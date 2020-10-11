Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF76428A8F0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgJKR7z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388464AbgJKR5k (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C03C0613D7;
        Sun, 11 Oct 2020 10:57:36 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439054;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8hKkMswhB6M0Zl+kmKpICEwqloCRl3FpP+kQYtNnMFs=;
        b=Aml6hOAG0HohBor11mVvLfMUO0hbJZeFeI4RnGtmWwEwF4OpnfzlZ14OxGGUfJEJzFl26u
        V7/zgKx6Cpk74e4JGLWRTJyaSZIT3mMATpxhIUzNvT+Sdo6fC1WA3ItcIm9GR+NZnqBGDJ
        dOupeJCA/GX4FMdU+lbTH/52NEoueu2VBDaF0I1e43I7MyyhX2k9EEqkfxJJ69FoZIjHNx
        yXrGLkmO7nKVvHfKDkr3dvC9ODf3fGzDM1HgkAR5ooFaqkbsZoWbSfe7i2iGrEtpeBtO90
        hFUjf+73fPYogAB1BKcsUmqWEoRmcvi5HsHtLY41Xd3ZftEUgcbM03qlThuwDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439054;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8hKkMswhB6M0Zl+kmKpICEwqloCRl3FpP+kQYtNnMFs=;
        b=RKxg3A13mPwUbgttZAL2Z3/mXkx5GYSaplKFcfpzjYUaH5U0oZIwGiTi53KauMc8WPLW6P
        KS0QFiUv4NjIksCQ==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/bcm2836: Configure mailbox interrupts as
 standard interrupts
Cc:     Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243905366.7002.1553031713520044449.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0809ae724904c3c5dbdddf4169d48aac9c6fcdc8
Gitweb:        https://git.kernel.org/tip/0809ae724904c3c5dbdddf4169d48aac9c6fcdc8
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 05 May 2020 12:59:04 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Sep 2020 16:37:27 +01:00

irqchip/bcm2836: Configure mailbox interrupts as standard interrupts

In order to switch the bcm2836 driver to privide standard interrupts
for IPIs, it first needs to stop lying about the way things work.

The mailbox interrupt is actually a multiplexer, with enough
bits to store 32 pending interrupts per CPU. So let's turn it
into a chained irqchip.

Once this is done, we can instanciate the corresponding IPIs,
and pass them to the architecture code.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-bcm2836.c | 151 +++++++++++++++++++++++++++------
 1 file changed, 125 insertions(+), 26 deletions(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 2038693..85df6dd 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -10,6 +10,7 @@
 #include <linux/of_irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/irq-bcm2836.h>
 
 #include <asm/exception.h>
@@ -89,12 +90,24 @@ static struct irq_chip bcm2836_arm_irqchip_gpu = {
 	.irq_unmask	= bcm2836_arm_irqchip_unmask_gpu_irq,
 };
 
+static void bcm2836_arm_irqchip_dummy_op(struct irq_data *d)
+{
+}
+
+static struct irq_chip bcm2836_arm_irqchip_dummy = {
+	.name		= "bcm2836-dummy",
+	.irq_eoi	= bcm2836_arm_irqchip_dummy_op,
+};
+
 static int bcm2836_map(struct irq_domain *d, unsigned int irq,
 		       irq_hw_number_t hw)
 {
 	struct irq_chip *chip;
 
 	switch (hw) {
+	case LOCAL_IRQ_MAILBOX0:
+		chip = &bcm2836_arm_irqchip_dummy;
+		break;
 	case LOCAL_IRQ_CNTPSIRQ:
 	case LOCAL_IRQ_CNTPNSIRQ:
 	case LOCAL_IRQ_CNTHPIRQ:
@@ -127,17 +140,7 @@ __exception_irq_entry bcm2836_arm_irqchip_handle_irq(struct pt_regs *regs)
 	u32 stat;
 
 	stat = readl_relaxed(intc.base + LOCAL_IRQ_PENDING0 + 4 * cpu);
-	if (stat & BIT(LOCAL_IRQ_MAILBOX0)) {
-#ifdef CONFIG_SMP
-		void __iomem *mailbox0 = (intc.base +
-					  LOCAL_MAILBOX0_CLR0 + 16 * cpu);
-		u32 mbox_val = readl(mailbox0);
-		u32 ipi = ffs(mbox_val) - 1;
-
-		writel(1 << ipi, mailbox0);
-		handle_IPI(ipi, regs);
-#endif
-	} else if (stat) {
+	if (stat) {
 		u32 hwirq = ffs(stat) - 1;
 
 		handle_domain_irq(intc.domain, hwirq, regs);
@@ -145,8 +148,35 @@ __exception_irq_entry bcm2836_arm_irqchip_handle_irq(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_SMP
-static void bcm2836_arm_irqchip_send_ipi(const struct cpumask *mask,
-					 unsigned int ipi)
+static struct irq_domain *ipi_domain;
+
+static void bcm2836_arm_irqchip_handle_ipi(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int cpu = smp_processor_id();
+	u32 mbox_val;
+
+	chained_irq_enter(chip, desc);
+
+	mbox_val = readl_relaxed(intc.base + LOCAL_MAILBOX0_CLR0 + 16 * cpu);
+	if (mbox_val) {
+		int hwirq = ffs(mbox_val) - 1;
+		generic_handle_irq(irq_find_mapping(ipi_domain, hwirq));
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void bcm2836_arm_irqchip_ipi_eoi(struct irq_data *d)
+{
+	int cpu = smp_processor_id();
+
+	writel_relaxed(BIT(d->hwirq),
+		       intc.base + LOCAL_MAILBOX0_CLR0 + 16 * cpu);
+}
+
+static void bcm2836_arm_irqchip_ipi_send_mask(struct irq_data *d,
+					      const struct cpumask *mask)
 {
 	int cpu;
 	void __iomem *mailbox0_base = intc.base + LOCAL_MAILBOX0_SET0;
@@ -157,11 +187,45 @@ static void bcm2836_arm_irqchip_send_ipi(const struct cpumask *mask,
 	 */
 	smp_wmb();
 
-	for_each_cpu(cpu, mask)	{
-		writel(1 << ipi, mailbox0_base + 16 * cpu);
+	for_each_cpu(cpu, mask)
+		writel_relaxed(BIT(d->hwirq), mailbox0_base + 16 * cpu);
+}
+
+static struct irq_chip bcm2836_arm_irqchip_ipi = {
+	.name		= "IPI",
+	.irq_eoi	= bcm2836_arm_irqchip_ipi_eoi,
+	.ipi_send_mask	= bcm2836_arm_irqchip_ipi_send_mask,
+};
+
+static int bcm2836_arm_irqchip_ipi_alloc(struct irq_domain *d,
+					 unsigned int virq,
+					 unsigned int nr_irqs, void *args)
+{
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_set_percpu_devid(virq + i);
+		irq_domain_set_info(d, virq + i, i, &bcm2836_arm_irqchip_ipi,
+				    d->host_data,
+				    handle_percpu_devid_fasteoi_ipi,
+				    NULL, NULL);
 	}
+
+	return 0;
 }
 
+static void bcm2836_arm_irqchip_ipi_free(struct irq_domain *d,
+					 unsigned int virq,
+					 unsigned int nr_irqs)
+{
+	/* Not freeing IPIs */
+}
+
+static const struct irq_domain_ops ipi_domain_ops = {
+	.alloc	= bcm2836_arm_irqchip_ipi_alloc,
+	.free	= bcm2836_arm_irqchip_ipi_free,
+};
+
 static int bcm2836_cpu_starting(unsigned int cpu)
 {
 	bcm2836_arm_irqchip_unmask_per_cpu_irq(LOCAL_MAILBOX_INT_CONTROL0, 0,
@@ -175,25 +239,58 @@ static int bcm2836_cpu_dying(unsigned int cpu)
 					     cpu);
 	return 0;
 }
-#endif
 
-static const struct irq_domain_ops bcm2836_arm_irqchip_intc_ops = {
-	.xlate = irq_domain_xlate_onetwocell,
-	.map = bcm2836_map,
-};
+#define BITS_PER_MBOX	32
 
-static void
-bcm2836_arm_irqchip_smp_init(void)
+static void bcm2836_arm_irqchip_smp_init(void)
 {
-#ifdef CONFIG_SMP
+	struct irq_fwspec ipi_fwspec = {
+		.fwnode		= intc.domain->fwnode,
+		.param_count	= 1,
+		.param		= {
+			[0]	= LOCAL_IRQ_MAILBOX0,
+		},
+	};
+	int base_ipi, mux_irq;
+
+	mux_irq = irq_create_fwspec_mapping(&ipi_fwspec);
+	if (WARN_ON(mux_irq <= 0))
+		return;
+
+	ipi_domain = irq_domain_create_linear(intc.domain->fwnode,
+					      BITS_PER_MBOX, &ipi_domain_ops,
+					      NULL);
+	if (WARN_ON(!ipi_domain))
+		return;
+
+	ipi_domain->flags |= IRQ_DOMAIN_FLAG_IPI_SINGLE;
+	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
+
+	base_ipi = __irq_domain_alloc_irqs(ipi_domain, -1, BITS_PER_MBOX,
+					   NUMA_NO_NODE, NULL,
+					   false, NULL);
+
+	if (WARN_ON(!base_ipi))
+		return;
+
+	set_smp_ipi_range(base_ipi, BITS_PER_MBOX);
+
+	irq_set_chained_handler_and_data(mux_irq,
+					 bcm2836_arm_irqchip_handle_ipi, NULL);
+
 	/* Unmask IPIs to the boot CPU. */
 	cpuhp_setup_state(CPUHP_AP_IRQ_BCM2836_STARTING,
 			  "irqchip/bcm2836:starting", bcm2836_cpu_starting,
 			  bcm2836_cpu_dying);
-
-	set_smp_cross_call(bcm2836_arm_irqchip_send_ipi);
-#endif
 }
+#else
+#define bcm2836_arm_irqchip_smp_init()	do { } while(0)
+#endif
+
+static const struct irq_domain_ops bcm2836_arm_irqchip_intc_ops = {
+	.xlate = irq_domain_xlate_onetwocell,
+	.map = bcm2836_map,
+};
 
 /*
  * The LOCAL_IRQ_CNT* timer firings are based off of the external
@@ -232,6 +329,8 @@ static int __init bcm2836_arm_irqchip_l1_intc_of_init(struct device_node *node,
 	if (!intc.domain)
 		panic("%pOF: unable to create IRQ domain\n", node);
 
+	irq_domain_update_bus_token(intc.domain, DOMAIN_BUS_WIRED);
+
 	bcm2836_arm_irqchip_smp_init();
 
 	set_handle_irq(bcm2836_arm_irqchip_handle_irq);
