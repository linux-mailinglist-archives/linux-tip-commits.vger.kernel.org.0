Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDE328A8AD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388552AbgJKR5y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388455AbgJKR5f (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7B6C0613D6;
        Sun, 11 Oct 2020 10:57:35 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439054;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AsjVCLHdtxwIVZa1LBuPTCFI6Ckam80h0mH1br0fXS0=;
        b=Cj0mB2nHfrcFFzRSHnhED3TFTe65GxXkBGBKO5U9m/DOFAwBNaaxGjJ1BSlSiqn1Q7UtAi
        XAjWrFX0+nzRwSmULNEqBwOfkUqDSUK70FSRkaU3b3B0mVzsIZAtsgRgWzhO5e7H5+o+qQ
        x3eMNxaj/GTdgM7vAS1QCSSgN8HDIh4hWyQQny9cuuCsyInhI2nAT+Vo7wQ7Bk1aWVOD/F
        ytqYNkUAfC1SHcHfioFTw8PV8tPo3Aqr2RwHI40ZLbsT/zgFybCfMvW5HewTBOlbFOsxj8
        xxmxAvjUy7zH+qNogE3PmPW5mQr9/h+lCtBQ0lMJuJ67j5809n4tD6Fq0imXlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439054;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AsjVCLHdtxwIVZa1LBuPTCFI6Ckam80h0mH1br0fXS0=;
        b=QG8Q/4W4fr5IacgxqJPbQY+32fEuz6BT7YWin5nqPggSRTbvWdXcD0TfLXDrMG4VqEwitk
        kYs02U0EVyljTsCA==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/hip04: Configure IPIs as standard interrupts
Cc:     Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243905316.7002.16998093243980478956.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a2df12c5899e9bb181cb64385b04f2bc755780b6
Gitweb:        https://git.kernel.org/tip/a2df12c5899e9bb181cb64385b04f2bc755780b6
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sat, 20 Jun 2020 20:02:18 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Sep 2020 16:37:27 +01:00

irqchip/hip04: Configure IPIs as standard interrupts

In order to switch the hip04 driver to provide standard interrupts
for IPIs, rework the way interrupts are allocated, making sure
the irqdomain covers the SGIs as well as the rest of the interrupt
range.

The driver is otherwise so old-school that it creates all interrupts
upfront (duh!), so there is hardly anything else to change, apart
from communicating the IPIs to the arch code.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-hip04.c | 89 ++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 49 deletions(-)

diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 130caa1..9b73dcf 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -171,6 +171,29 @@ static int hip04_irq_set_affinity(struct irq_data *d,
 
 	return IRQ_SET_MASK_OK;
 }
+
+static void hip04_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
+{
+	int cpu;
+	unsigned long flags, map = 0;
+
+	raw_spin_lock_irqsave(&irq_controller_lock, flags);
+
+	/* Convert our logical CPU mask into a physical one. */
+	for_each_cpu(cpu, mask)
+		map |= hip04_cpu_map[cpu];
+
+	/*
+	 * Ensure that stores to Normal memory are visible to the
+	 * other CPUs before they observe us issuing the IPI.
+	 */
+	dmb(ishst);
+
+	/* this always happens on GIC0 */
+	writel_relaxed(map << 8 | d->hwirq, hip04_data.dist_base + GIC_DIST_SOFTINT);
+
+	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
+}
 #endif
 
 static void __exception_irq_entry hip04_handle_irq(struct pt_regs *regs)
@@ -182,19 +205,9 @@ static void __exception_irq_entry hip04_handle_irq(struct pt_regs *regs)
 		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
 		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
 
-		if (likely(irqnr > 15 && irqnr <= HIP04_MAX_IRQS)) {
+		if (irqnr <= HIP04_MAX_IRQS)
 			handle_domain_irq(hip04_data.domain, irqnr, regs);
-			continue;
-		}
-		if (irqnr < 16) {
-			writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
-#ifdef CONFIG_SMP
-			handle_IPI(irqnr, regs);
-#endif
-			continue;
-		}
-		break;
-	} while (1);
+	} while (irqnr > HIP04_MAX_IRQS);
 }
 
 static struct irq_chip hip04_irq_chip = {
@@ -205,6 +218,7 @@ static struct irq_chip hip04_irq_chip = {
 	.irq_set_type		= hip04_irq_set_type,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= hip04_irq_set_affinity,
+	.ipi_send_mask		= hip04_ipi_send_mask,
 #endif
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
@@ -279,39 +293,17 @@ static void hip04_irq_cpu_init(struct hip04_irq_data *intc)
 	writel_relaxed(1, base + GIC_CPU_CTRL);
 }
 
-#ifdef CONFIG_SMP
-static void hip04_raise_softirq(const struct cpumask *mask, unsigned int irq)
-{
-	int cpu;
-	unsigned long flags, map = 0;
-
-	raw_spin_lock_irqsave(&irq_controller_lock, flags);
-
-	/* Convert our logical CPU mask into a physical one. */
-	for_each_cpu(cpu, mask)
-		map |= hip04_cpu_map[cpu];
-
-	/*
-	 * Ensure that stores to Normal memory are visible to the
-	 * other CPUs before they observe us issuing the IPI.
-	 */
-	dmb(ishst);
-
-	/* this always happens on GIC0 */
-	writel_relaxed(map << 8 | irq, hip04_data.dist_base + GIC_DIST_SOFTINT);
-
-	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
-}
-#endif
-
 static int hip04_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hw)
 {
-	if (hw < 32) {
+	if (hw < 16) {
+		irq_set_percpu_devid(irq);
+		irq_set_chip_and_handler(irq, &hip04_irq_chip,
+					 handle_percpu_devid_fasteoi_ipi);
+	} else if (hw < 32) {
 		irq_set_percpu_devid(irq);
 		irq_set_chip_and_handler(irq, &hip04_irq_chip,
 					 handle_percpu_devid_irq);
-		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 	} else {
 		irq_set_chip_and_handler(irq, &hip04_irq_chip,
 					 handle_fasteoi_irq);
@@ -328,10 +320,13 @@ static int hip04_irq_domain_xlate(struct irq_domain *d,
 				  unsigned long *out_hwirq,
 				  unsigned int *out_type)
 {
-	unsigned long ret = 0;
-
 	if (irq_domain_get_of_node(d) != controller)
 		return -EINVAL;
+	if (intsize == 1 && intspec[0] < 16) {
+		*out_hwirq = intspec[0];
+		*out_type = IRQ_TYPE_EDGE_RISING;
+		return 0;
+	}
 	if (intsize < 3)
 		return -EINVAL;
 
@@ -344,7 +339,7 @@ static int hip04_irq_domain_xlate(struct irq_domain *d,
 
 	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
 
-	return ret;
+	return 0;
 }
 
 static int hip04_irq_starting_cpu(unsigned int cpu)
@@ -361,7 +356,6 @@ static const struct irq_domain_ops hip04_irq_domain_ops = {
 static int __init
 hip04_of_init(struct device_node *node, struct device_node *parent)
 {
-	irq_hw_number_t hwirq_base = 16;
 	int nr_irqs, irq_base, i;
 
 	if (WARN_ON(!node))
@@ -390,24 +384,21 @@ hip04_of_init(struct device_node *node, struct device_node *parent)
 		nr_irqs = HIP04_MAX_IRQS;
 	hip04_data.nr_irqs = nr_irqs;
 
-	nr_irqs -= hwirq_base; /* calculate # of irqs to allocate */
-
-	irq_base = irq_alloc_descs(-1, hwirq_base, nr_irqs, numa_node_id());
+	irq_base = irq_alloc_descs(-1, 0, nr_irqs, numa_node_id());
 	if (irq_base < 0) {
 		pr_err("failed to allocate IRQ numbers\n");
 		return -EINVAL;
 	}
 
 	hip04_data.domain = irq_domain_add_legacy(node, nr_irqs, irq_base,
-						  hwirq_base,
+						  0,
 						  &hip04_irq_domain_ops,
 						  &hip04_data);
-
 	if (WARN_ON(!hip04_data.domain))
 		return -EINVAL;
 
 #ifdef CONFIG_SMP
-	set_smp_cross_call(hip04_raise_softirq);
+	set_smp_ipi_range(irq_base, 16);
 #endif
 	set_handle_irq(hip04_handle_irq);
 
