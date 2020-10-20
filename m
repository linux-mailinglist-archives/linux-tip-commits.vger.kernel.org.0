Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED25928A8B1
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388544AbgJKR5x (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:57:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40092 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388448AbgJKR5h (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:37 -0400
Date:   Sun, 11 Oct 2020 17:57:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439053;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=h2xP7qBHvyyXxN51lN4YRxNA/TXs0TWrQl4oGaSfUQQ=;
        b=d00g40+Foui7dGWRD1rUtio8SMtY2QUy2q/9rucEm0umdSVmDvrZkHko/Yq5hkVyiS9Fdl
        FtJLi49Q2kupmNO81FLbnCe8dq4Hl82AFlnyW/mRT6Bvkzb2scWwChDxXRxy1mjVVO6hN4
        1lNzDjqrkO0uoWULc4T5ctVktO0CgXKAaZ/1qTkzk/clK3PtRVO1HJ7dxlHHRS0nbQiZqY
        9+qP1wn0uydgnc30FOK1xf2/8MEqLSYCIf8EI3fFz+7U0s6J5Jl+fP0rPS8p1wNrQr3bc6
        y20uB9jLHvjIeQxsyKhrcUFdiaMF2FhZrB0FhP369PHCY6oM8cHonjge+68UQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439053;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=h2xP7qBHvyyXxN51lN4YRxNA/TXs0TWrQl4oGaSfUQQ=;
        b=7FF9q3/FbUHxEORwK/sV5yg2C3PnxJOxtOMHPBUoOC5TbM2QvaIxutVA/W/7fMvZqLED1R
        ZB7ML4eZuwzComAw==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Configure IPIs as standard interrupts
Cc:     Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243905263.7002.18289520301587809617.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f02147dd02eb5fab31b55b73e7524f94b5f20324
Gitweb:        https://git.kernel.org/tip/f02147dd02eb5fab31b55b73e7524f94b5f20324
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 22 Jun 2020 21:23:36 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Sep 2020 16:37:27 +01:00

irqchip/armada-370-xp: Configure IPIs as standard interrupts

To introduce IPIs as standard interrupts to the Armada 370-XP
driver, let's allocate a completely separate irqdomain and
irqchip combo that lives parallel to the "standard" one.

This effectively should be modelled as a chained interrupt
controller, but the code is in such a state that it is
pretty hard to shoehorn, as it would require the rewrite
of the MSI layer as well.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-armada-370-xp.c | 262 ++++++++++++++++++---------
 1 file changed, 178 insertions(+), 84 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index c9bdc52..d7eb2e9 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -310,7 +310,134 @@ static inline int armada_370_xp_msi_init(struct device_node *node,
 }
 #endif
 
+static void armada_xp_mpic_perf_init(void)
+{
+	unsigned long cpuid = cpu_logical_map(smp_processor_id());
+
+	/* Enable Performance Counter Overflow interrupts */
+	writel(ARMADA_370_XP_INT_CAUSE_PERF(cpuid),
+	       per_cpu_int_base + ARMADA_370_XP_INT_FABRIC_MASK_OFFS);
+}
+
 #ifdef CONFIG_SMP
+static struct irq_domain *ipi_domain;
+
+static void armada_370_xp_ipi_mask(struct irq_data *d)
+{
+	u32 reg;
+	reg = readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	reg &= ~BIT(d->hwirq);
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+}
+
+static void armada_370_xp_ipi_unmask(struct irq_data *d)
+{
+	u32 reg;
+	reg = readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	reg |= BIT(d->hwirq);
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+}
+
+static void armada_370_xp_ipi_send_mask(struct irq_data *d,
+					const struct cpumask *mask)
+{
+	unsigned long map = 0;
+	int cpu;
+
+	/* Convert our logical CPU mask into a physical one. */
+	for_each_cpu(cpu, mask)
+		map |= 1 << cpu_logical_map(cpu);
+
+	/*
+	 * Ensure that stores to Normal memory are visible to the
+	 * other CPUs before issuing the IPI.
+	 */
+	dsb();
+
+	/* submit softirq */
+	writel((map << 8) | d->hwirq, main_int_base +
+		ARMADA_370_XP_SW_TRIG_INT_OFFS);
+}
+
+static void armada_370_xp_ipi_eoi(struct irq_data *d)
+{
+	writel(~BIT(d->hwirq), per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
+}
+
+static struct irq_chip ipi_irqchip = {
+	.name		= "IPI",
+	.irq_mask	= armada_370_xp_ipi_mask,
+	.irq_unmask	= armada_370_xp_ipi_unmask,
+	.irq_eoi	= armada_370_xp_ipi_eoi,
+	.ipi_send_mask	= armada_370_xp_ipi_send_mask,
+};
+
+static int armada_370_xp_ipi_alloc(struct irq_domain *d,
+					 unsigned int virq,
+					 unsigned int nr_irqs, void *args)
+{
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_set_percpu_devid(virq + i);
+		irq_domain_set_info(d, virq + i, i, &ipi_irqchip,
+				    d->host_data,
+				    handle_percpu_devid_fasteoi_ipi,
+				    NULL, NULL);
+	}
+
+	return 0;
+}
+
+static void armada_370_xp_ipi_free(struct irq_domain *d,
+					 unsigned int virq,
+					 unsigned int nr_irqs)
+{
+	/* Not freeing IPIs */
+}
+
+static const struct irq_domain_ops ipi_domain_ops = {
+	.alloc	= armada_370_xp_ipi_alloc,
+	.free	= armada_370_xp_ipi_free,
+};
+
+static void ipi_resume(void)
+{
+	int i;
+
+	for (i = 0; i < IPI_DOORBELL_END; i++) {
+		int irq;
+
+		irq = irq_find_mapping(ipi_domain, i);
+		if (irq <= 0)
+			continue;
+		if (irq_percpu_is_enabled(irq)) {
+			struct irq_data *d;
+			d = irq_domain_get_irq_data(ipi_domain, irq);
+			armada_370_xp_ipi_unmask(d);
+		}
+	}
+}
+
+static __init void armada_xp_ipi_init(struct device_node *node)
+{
+	int base_ipi;
+
+	ipi_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+					      IPI_DOORBELL_END,
+					      &ipi_domain_ops, NULL);
+	if (WARN_ON(!ipi_domain))
+		return;
+
+	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
+	base_ipi = __irq_domain_alloc_irqs(ipi_domain, -1, IPI_DOORBELL_END,
+					   NUMA_NO_NODE, NULL, false, NULL);
+	if (WARN_ON(!base_ipi))
+		return;
+
+	set_smp_ipi_range(base_ipi, IPI_DOORBELL_END);
+}
+
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
 
 static int armada_xp_set_affinity(struct irq_data *d,
@@ -334,43 +461,6 @@ static int armada_xp_set_affinity(struct irq_data *d,
 
 	return IRQ_SET_MASK_OK;
 }
-#endif
-
-static struct irq_chip armada_370_xp_irq_chip = {
-	.name		= "MPIC",
-	.irq_mask       = armada_370_xp_irq_mask,
-	.irq_mask_ack   = armada_370_xp_irq_mask,
-	.irq_unmask     = armada_370_xp_irq_unmask,
-#ifdef CONFIG_SMP
-	.irq_set_affinity = armada_xp_set_affinity,
-#endif
-	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
-};
-
-static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
-				      unsigned int virq, irq_hw_number_t hw)
-{
-	armada_370_xp_irq_mask(irq_get_irq_data(virq));
-	if (!is_percpu_irq(hw))
-		writel(hw, per_cpu_int_base +
-			ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
-	else
-		writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
-	irq_set_status_flags(virq, IRQ_LEVEL);
-
-	if (is_percpu_irq(hw)) {
-		irq_set_percpu_devid(virq);
-		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
-					handle_percpu_devid_irq);
-	} else {
-		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
-					handle_level_irq);
-		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq)));
-	}
-	irq_set_probe(virq);
-
-	return 0;
-}
 
 static void armada_xp_mpic_smp_cpu_init(void)
 {
@@ -383,48 +473,16 @@ static void armada_xp_mpic_smp_cpu_init(void)
 	for (i = 0; i < nr_irqs; i++)
 		writel(i, per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK_OFFS);
 
+	/* Disable all IPIs */
+	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+
 	/* Clear pending IPIs */
 	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
 
-	/* Enable first 8 IPIs */
-	writel(IPI_DOORBELL_MASK, per_cpu_int_base +
-		ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
-
 	/* Unmask IPI interrupt */
 	writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 }
 
-static void armada_xp_mpic_perf_init(void)
-{
-	unsigned long cpuid = cpu_logical_map(smp_processor_id());
-
-	/* Enable Performance Counter Overflow interrupts */
-	writel(ARMADA_370_XP_INT_CAUSE_PERF(cpuid),
-	       per_cpu_int_base + ARMADA_370_XP_INT_FABRIC_MASK_OFFS);
-}
-
-#ifdef CONFIG_SMP
-static void armada_mpic_send_doorbell(const struct cpumask *mask,
-				      unsigned int irq)
-{
-	int cpu;
-	unsigned long map = 0;
-
-	/* Convert our logical CPU mask into a physical one. */
-	for_each_cpu(cpu, mask)
-		map |= 1 << cpu_logical_map(cpu);
-
-	/*
-	 * Ensure that stores to Normal memory are visible to the
-	 * other CPUs before issuing the IPI.
-	 */
-	dsb();
-
-	/* submit softirq */
-	writel((map << 8) | irq, main_int_base +
-		ARMADA_370_XP_SW_TRIG_INT_OFFS);
-}
-
 static void armada_xp_mpic_reenable_percpu(void)
 {
 	unsigned int irq;
@@ -445,6 +503,8 @@ static void armada_xp_mpic_reenable_percpu(void)
 
 		armada_370_xp_irq_unmask(data);
 	}
+
+	ipi_resume();
 }
 
 static int armada_xp_mpic_starting_cpu(unsigned int cpu)
@@ -462,7 +522,46 @@ static int mpic_cascaded_starting_cpu(unsigned int cpu)
 	enable_percpu_irq(parent_irq, IRQ_TYPE_NONE);
 	return 0;
 }
+#else
+static void armada_xp_mpic_smp_cpu_init(void) {}
+static void ipi_resume(void) {}
+#endif
+
+static struct irq_chip armada_370_xp_irq_chip = {
+	.name		= "MPIC",
+	.irq_mask       = armada_370_xp_irq_mask,
+	.irq_mask_ack   = armada_370_xp_irq_mask,
+	.irq_unmask     = armada_370_xp_irq_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = armada_xp_set_affinity,
 #endif
+	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
+				      unsigned int virq, irq_hw_number_t hw)
+{
+	armada_370_xp_irq_mask(irq_get_irq_data(virq));
+	if (!is_percpu_irq(hw))
+		writel(hw, per_cpu_int_base +
+			ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+	else
+		writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
+	irq_set_status_flags(virq, IRQ_LEVEL);
+
+	if (is_percpu_irq(hw)) {
+		irq_set_percpu_devid(virq);
+		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
+					handle_percpu_devid_irq);
+	} else {
+		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
+					handle_level_irq);
+		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq)));
+	}
+	irq_set_probe(virq);
+
+	return 0;
+}
 
 static const struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
 	.map = armada_370_xp_mpic_irq_map,
@@ -562,22 +661,15 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 #ifdef CONFIG_SMP
 		/* IPI Handling */
 		if (irqnr == 0) {
-			u32 ipimask, ipinr;
+			unsigned long ipimask;
+			int ipi;
 
 			ipimask = readl_relaxed(per_cpu_int_base +
 						ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
 				& IPI_DOORBELL_MASK;
 
-			writel(~ipimask, per_cpu_int_base +
-				ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
-
-			/* Handle all pending doorbells */
-			for (ipinr = IPI_DOORBELL_START;
-			     ipinr < IPI_DOORBELL_END; ipinr++) {
-				if (ipimask & (0x1 << ipinr))
-					handle_IPI(ipinr, regs);
-			}
-			continue;
+			for_each_set_bit(ipi, &ipimask, IPI_DOORBELL_END)
+				handle_domain_irq(ipi_domain, ipi, regs);
 		}
 #endif
 
@@ -636,6 +728,8 @@ static void armada_370_xp_mpic_resume(void)
 		writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 	if (doorbell_mask_reg & PCI_MSI_DOORBELL_MASK)
 		writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+
+	ipi_resume();
 }
 
 static struct syscore_ops armada_370_xp_mpic_syscore_ops = {
@@ -691,7 +785,7 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 		irq_set_default_host(armada_370_xp_mpic_domain);
 		set_handle_irq(armada_370_xp_handle_irq);
 #ifdef CONFIG_SMP
-		set_smp_cross_call(armada_mpic_send_doorbell);
+		armada_xp_ipi_init(node);
 		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 					  "irqchip/armada/ipi:starting",
 					  armada_xp_mpic_starting_cpu, NULL);
