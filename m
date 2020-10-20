Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5AD28A8AC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbgJKR5y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388465AbgJKR5k (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADDDC0613D9;
        Sun, 11 Oct 2020 10:57:37 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=h22pgM4rcx1oan3seG1t53T1AsUpvYcaJ2HLl+HZ6f0=;
        b=kV/N2kZHzK9Qd0O4H7NvytkCQI2kz3Cc4D/ZgPUWlJhD1thL7/tZcC8vwp2iBDp5j/0hJ/
        m036WqsfGd4NHHS/K3rBhO4TERbIkk9tIskXDz32CAXM+qBI0mg2t7bbIHalQE61uytvqT
        89nw20jAL1+ieHNKuFcJatQNd9KoInZ8S0TbpXkVP1Kc4sp5qoKbWkGZMtcWIp5s23CoXC
        VyntAJEVK8O5ecA5Y6a+SwdqXjP9Q7nJrAAbXZlRvYD+EdQWeflO2HnVGL4znD5fn7P1Rp
        0NuOeTPe+ILgjlPqL1qV6BGf+sQru9bPY9RAGinbUeQah7xS7ms1KKfK28AufA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=h22pgM4rcx1oan3seG1t53T1AsUpvYcaJ2HLl+HZ6f0=;
        b=vDOJTcqatA9ntxIa6ZT/wVgw27bG/lrEL3lZeD6706odxAZH7RinaM9aYBS2TGwI1xFd0U
        8DG6yLBjyVbDZADA==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic: Configure SGIs as standard interrupts
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243905491.7002.10257688961532458875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     64a267e9a41c5a91efdfa5bf55bd2509cb4f7170
Gitweb:        https://git.kernel.org/tip/64a267e9a41c5a91efdfa5bf55bd2509cb4f7170
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sat, 25 Apr 2020 15:24:01 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Sep 2020 16:37:27 +01:00

irqchip/gic: Configure SGIs as standard interrupts

Change the way we deal with GIC SGIs by turning them into proper
IRQs, and calling into the arch code to register the interrupt range
instead of a callback.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic.c | 128 +++++++++++++++++++++++++------------
 1 file changed, 87 insertions(+), 41 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4ffd62a..66671e1 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -124,6 +124,8 @@ static struct gic_chip_data gic_data[CONFIG_ARM_GIC_MAX_NR] __read_mostly;
 
 static struct gic_kvm_info gic_v2_kvm_info;
 
+static DEFINE_PER_CPU(u32, sgi_intid);
+
 #ifdef CONFIG_GIC_NON_BANKED
 static void __iomem *gic_get_percpu_base(union gic_base *base)
 {
@@ -226,16 +228,26 @@ static void gic_unmask_irq(struct irq_data *d)
 
 static void gic_eoi_irq(struct irq_data *d)
 {
-	writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
+	u32 hwirq = gic_irq(d);
+
+	if (hwirq < 16)
+		hwirq = this_cpu_read(sgi_intid);
+
+	writel_relaxed(hwirq, gic_cpu_base(d) + GIC_CPU_EOI);
 }
 
 static void gic_eoimode1_eoi_irq(struct irq_data *d)
 {
+	u32 hwirq = gic_irq(d);
+
 	/* Do not deactivate an IRQ forwarded to a vcpu. */
 	if (irqd_is_forwarded_to_vcpu(d))
 		return;
 
-	writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_DEACTIVATE);
+	if (hwirq < 16)
+		hwirq = this_cpu_read(sgi_intid);
+
+	writel_relaxed(hwirq, gic_cpu_base(d) + GIC_CPU_DEACTIVATE);
 }
 
 static int gic_irq_set_irqchip_state(struct irq_data *d,
@@ -295,7 +307,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 
 	/* Interrupt configuration for SGIs can't be changed */
 	if (gicirq < 16)
-		return -EINVAL;
+		return type == IRQ_TYPE_EDGE_RISING ? 0 : -EINVAL;
 
 	/* SPIs have restrictions on the supported types */
 	if (gicirq >= 32 && type != IRQ_TYPE_LEVEL_HIGH &&
@@ -315,7 +327,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
 {
 	/* Only interrupts on the primary GIC can be forwarded to a vcpu. */
-	if (cascading_gic_irq(d))
+	if (cascading_gic_irq(d) || gic_irq(d) < 16)
 		return -EINVAL;
 
 	if (vcpu)
@@ -335,31 +347,33 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
 		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
 
-		if (likely(irqnr > 15 && irqnr < 1020)) {
-			if (static_branch_likely(&supports_deactivate_key))
-				writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
-			isb();
-			handle_domain_irq(gic->domain, irqnr, regs);
-			continue;
-		}
-		if (irqnr < 16) {
+		if (unlikely(irqnr >= 1020))
+			break;
+
+		if (static_branch_likely(&supports_deactivate_key))
 			writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
-			if (static_branch_likely(&supports_deactivate_key))
-				writel_relaxed(irqstat, cpu_base + GIC_CPU_DEACTIVATE);
-#ifdef CONFIG_SMP
+		isb();
+
+		/*
+		 * Ensure any shared data written by the CPU sending the IPI
+		 * is read after we've read the ACK register on the GIC.
+		 *
+		 * Pairs with the write barrier in gic_ipi_send_mask
+		 */
+		if (irqnr <= 15) {
+			smp_rmb();
+
 			/*
-			 * Ensure any shared data written by the CPU sending
-			 * the IPI is read after we've read the ACK register
-			 * on the GIC.
-			 *
-			 * Pairs with the write barrier in gic_raise_softirq
+			 * The GIC encodes the source CPU in GICC_IAR,
+			 * leading to the deactivation to fail if not
+			 * written back as is to GICC_EOI.  Stash the INTID
+			 * away for gic_eoi_irq() to write back.  This only
+			 * works because we don't nest SGIs...
 			 */
-			smp_rmb();
-			handle_IPI(irqnr, regs);
-#endif
-			continue;
+			this_cpu_write(sgi_intid, irqstat);
 		}
-		break;
+
+		handle_domain_irq(gic->domain, irqnr, regs);
 	} while (1);
 }
 
@@ -793,14 +807,14 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	return IRQ_SET_MASK_OK_DONE;
 }
 
-static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
+static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 {
 	int cpu;
 	unsigned long flags, map = 0;
 
 	if (unlikely(nr_cpu_ids == 1)) {
 		/* Only one CPU? let's do a self-IPI... */
-		writel_relaxed(2 << 24 | irq,
+		writel_relaxed(2 << 24 | d->hwirq,
 			       gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
 		return;
 	}
@@ -818,7 +832,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	dmb(ishst);
 
 	/* this always happens on GIC0 */
-	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
+	writel_relaxed(map << 16 | d->hwirq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
 
 	gic_unlock_irqrestore(flags);
 }
@@ -831,14 +845,28 @@ static int gic_starting_cpu(unsigned int cpu)
 
 static __init void gic_smp_init(void)
 {
-	set_smp_cross_call(gic_raise_softirq);
+	struct irq_fwspec sgi_fwspec = {
+		.fwnode		= gic_data[0].domain->fwnode,
+		.param_count	= 1,
+	};
+	int base_sgi;
+
 	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
 				  "irqchip/arm/gic:starting",
 				  gic_starting_cpu, NULL);
+
+	base_sgi = __irq_domain_alloc_irqs(gic_data[0].domain, -1, 8,
+					   NUMA_NO_NODE, &sgi_fwspec,
+					   false, NULL);
+	if (WARN_ON(base_sgi <= 0))
+		return;
+
+	set_smp_ipi_range(base_sgi, 8);
 }
 #else
 #define gic_smp_init()		do { } while(0)
 #define gic_set_affinity	NULL
+#define gic_ipi_send_mask	NULL
 #endif
 
 #ifdef CONFIG_BL_SWITCHER
@@ -985,15 +1013,24 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 {
 	struct gic_chip_data *gic = d->host_data;
 
-	if (hw < 32) {
+	switch (hw) {
+	case 0 ... 15:
+		irq_set_percpu_devid(irq);
+		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
+				    handle_percpu_devid_fasteoi_ipi,
+				    NULL, NULL);
+		break;
+	case 16 ... 31:
 		irq_set_percpu_devid(irq);
 		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
-	} else {
+		break;
+	default:
 		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irq_set_probe(irq);
 		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
+		break;
 	}
 	return 0;
 }
@@ -1007,19 +1044,26 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 				    unsigned long *hwirq,
 				    unsigned int *type)
 {
+	if (fwspec->param_count == 1 && fwspec->param[0] < 16) {
+		*hwirq = fwspec->param[0];
+		*type = IRQ_TYPE_EDGE_RISING;
+		return 0;
+	}
+
 	if (is_of_node(fwspec->fwnode)) {
 		if (fwspec->param_count < 3)
 			return -EINVAL;
 
-		/* Get the interrupt number and add 16 to skip over SGIs */
-		*hwirq = fwspec->param[1] + 16;
-
-		/*
-		 * For SPIs, we need to add 16 more to get the GIC irq
-		 * ID number
-		 */
-		if (!fwspec->param[0])
-			*hwirq += 16;
+		switch (fwspec->param[0]) {
+		case 0:			/* SPI */
+			*hwirq = fwspec->param[1] + 32;
+			break;
+		case 1:			/* PPI */
+			*hwirq = fwspec->param[1] + 16;
+			break;
+		default:
+			return -EINVAL;
+		}
 
 		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
 
@@ -1088,8 +1132,10 @@ static void gic_init_chip(struct gic_chip_data *gic, struct device *dev,
 		gic->chip.irq_set_vcpu_affinity = gic_irq_set_vcpu_affinity;
 	}
 
-	if (gic == &gic_data[0])
+	if (gic == &gic_data[0]) {
 		gic->chip.irq_set_affinity = gic_set_affinity;
+		gic->chip.ipi_send_mask = gic_ipi_send_mask;
+	}
 }
 
 static int gic_init_bases(struct gic_chip_data *gic,
