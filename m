Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3143728A8DD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgJKR7Z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388475AbgJKR5l (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A50DC0613DB;
        Sun, 11 Oct 2020 10:57:38 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eCX848/Ir1UXDCUe/vKPQEVhvUtnuhVBk5gChhfP6hY=;
        b=Ai4sctpOS/fa0ayFNx5acFQ66E6e8q3Y4DYsn8rglNc2Uj8grjZrK/3UWnyxNl93S2YSr5
        Q+6ZKDZS8CxbiGjMW87PgSPE3lySugzzciItuFmpMuhu2BpdWk97gw/7g+Zweet3JT6PAe
        SQZEJFXgnJOavpptxFUcG5BIyIpZH5u1Dv8x+Y86CZH+NU24ww3zLSVRJpVSGgvIW6PtDW
        0/WpcvlH6WgmHEOIH3Hlylv6L9xETx/orjDHSauUdSRWhvniMLvSUyFxo+JISy08kvJdJx
        5HNVU2d/xRERVk5gQ9UNIlLLE9l60c2cA1uYQ3cWFBi8ATa90EPZTcv1bSUThQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eCX848/Ir1UXDCUe/vKPQEVhvUtnuhVBk5gChhfP6hY=;
        b=E4KUmh4tiixCcXMBxftK0Tqtzvn3T0RZtlFHym6qtn5zYn/UzvPdn2nLXDzRWrLGXGEV9w
        axt8DZoAoVEHP+Ag==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3: Configure SGIs as standard interrupts
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243905600.7002.7081558778999291657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     64b499d8df40dadb1818ad9f74c4546951b37a8f
Gitweb:        https://git.kernel.org/tip/64b499d8df40dadb1818ad9f74c4546951b37a8f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sat, 25 Apr 2020 15:24:01 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Sep 2020 16:37:26 +01:00

irqchip/gic-v3: Configure SGIs as standard interrupts

Change the way we deal with GICv3 SGIs by turning them into proper
IRQs, and calling into the arch code to register the interrupt range
instead of a callback.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 94 ++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 43 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index f7c99a3..84ceb63 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -36,6 +36,8 @@
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
 
+#define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
+
 struct redist_region {
 	void __iomem		*redist_base;
 	phys_addr_t		phys_base;
@@ -383,7 +385,7 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
 {
 	u32 reg;
 
-	if (d->hwirq >= 8192) /* PPI/SPI only */
+	if (d->hwirq >= 8192) /* SGI/PPI/SPI only */
 		return -EINVAL;
 
 	switch (which) {
@@ -550,12 +552,12 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	u32 offset, index;
 	int ret;
 
-	/* Interrupt configuration for SGIs can't be changed */
-	if (irq < 16)
-		return -EINVAL;
-
 	range = get_intid_range(d);
 
+	/* Interrupt configuration for SGIs can't be changed */
+	if (range == SGI_RANGE)
+		return type != IRQ_TYPE_EDGE_RISING ? -EINVAL : 0;
+
 	/* SPIs have restrictions on the supported types */
 	if ((range == SPI_RANGE || range == ESPI_RANGE) &&
 	    type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
@@ -583,6 +585,9 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 
 static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
 {
+	if (get_intid_range(d) == SGI_RANGE)
+		return -EINVAL;
+
 	if (vcpu)
 		irqd_set_forwarded_to_vcpu(d);
 	else
@@ -657,38 +662,14 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 	if ((irqnr >= 1020 && irqnr <= 1023))
 		return;
 
-	/* Treat anything but SGIs in a uniform way */
-	if (likely(irqnr > 15)) {
-		int err;
-
-		if (static_branch_likely(&supports_deactivate_key))
-			gic_write_eoir(irqnr);
-		else
-			isb();
-
-		err = handle_domain_irq(gic_data.domain, irqnr, regs);
-		if (err) {
-			WARN_ONCE(true, "Unexpected interrupt received!\n");
-			gic_deactivate_unhandled(irqnr);
-		}
-		return;
-	}
-	if (irqnr < 16) {
+	if (static_branch_likely(&supports_deactivate_key))
 		gic_write_eoir(irqnr);
-		if (static_branch_likely(&supports_deactivate_key))
-			gic_write_dir(irqnr);
-#ifdef CONFIG_SMP
-		/*
-		 * Unlike GICv2, we don't need an smp_rmb() here.
-		 * The control dependency from gic_read_iar to
-		 * the ISB in gic_write_eoir is enough to ensure
-		 * that any shared data read by handle_IPI will
-		 * be read after the ACK.
-		 */
-		handle_IPI(irqnr, regs);
-#else
-		WARN_ONCE(true, "Unexpected SGI received!\n");
-#endif
+	else
+		isb();
+
+	if (handle_domain_irq(gic_data.domain, irqnr, regs)) {
+		WARN_ONCE(true, "Unexpected interrupt received!\n");
+		gic_deactivate_unhandled(irqnr);
 	}
 }
 
@@ -1136,11 +1117,11 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
 	gic_write_sgi1r(val);
 }
 
-static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
+static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 {
 	int cpu;
 
-	if (WARN_ON(irq >= 16))
+	if (WARN_ON(d->hwirq >= 16))
 		return;
 
 	/*
@@ -1154,7 +1135,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 		u16 tlist;
 
 		tlist = gic_compute_target_list(&cpu, mask, cluster_id);
-		gic_send_sgi(cluster_id, tlist, irq);
+		gic_send_sgi(cluster_id, tlist, d->hwirq);
 	}
 
 	/* Force the above writes to ICC_SGI1R_EL1 to be executed */
@@ -1163,10 +1144,24 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 
 static void __init gic_smp_init(void)
 {
-	set_smp_cross_call(gic_raise_softirq);
+	struct irq_fwspec sgi_fwspec = {
+		.fwnode		= gic_data.fwnode,
+		.param_count	= 1,
+	};
+	int base_sgi;
+
 	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
 				  "irqchip/arm/gicv3:starting",
 				  gic_starting_cpu, NULL);
+
+	/* Register all 8 non-secure SGIs */
+	base_sgi = __irq_domain_alloc_irqs(gic_data.domain, -1, 8,
+					   NUMA_NO_NODE, &sgi_fwspec,
+					   false, NULL);
+	if (WARN_ON(base_sgi <= 0))
+		return;
+
+	set_smp_ipi_range(base_sgi, 8);
 }
 
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
@@ -1215,6 +1210,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 }
 #else
 #define gic_set_affinity	NULL
+#define gic_ipi_send_mask	NULL
 #define gic_smp_init()		do { } while(0)
 #endif
 
@@ -1257,6 +1253,7 @@ static struct irq_chip gic_chip = {
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_nmi_setup		= gic_irq_nmi_setup,
 	.irq_nmi_teardown	= gic_irq_nmi_teardown,
+	.ipi_send_mask		= gic_ipi_send_mask,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_MASK_ON_SUSPEND,
@@ -1274,6 +1271,7 @@ static struct irq_chip gic_eoimode1_chip = {
 	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
 	.irq_nmi_setup		= gic_irq_nmi_setup,
 	.irq_nmi_teardown	= gic_irq_nmi_teardown,
+	.ipi_send_mask		= gic_ipi_send_mask,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_MASK_ON_SUSPEND,
@@ -1289,6 +1287,12 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 
 	switch (__get_intid_range(hw)) {
 	case SGI_RANGE:
+		irq_set_percpu_devid(irq);
+		irq_domain_set_info(d, irq, hw, chip, d->host_data,
+				    handle_percpu_devid_fasteoi_ipi,
+				    NULL, NULL);
+		break;
+
 	case PPI_RANGE:
 	case EPPI_RANGE:
 		irq_set_percpu_devid(irq);
@@ -1318,13 +1322,17 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
-#define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
-
 static int gic_irq_domain_translate(struct irq_domain *d,
 				    struct irq_fwspec *fwspec,
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
@@ -1656,9 +1664,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_update_rdist_properties();
 
-	gic_smp_init();
 	gic_dist_init();
 	gic_cpu_init();
+	gic_smp_init();
 	gic_cpu_pm_init();
 
 	if (gic_dist_supports_lpis()) {
