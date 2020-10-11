Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C5228A8A9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388523AbgJKR5s (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388469AbgJKR5k (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC20C0613DA;
        Sun, 11 Oct 2020 10:57:37 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+OfYFZ30/Bhh320VllxL/nQwxccB4cYCI77NAMkEY24=;
        b=FeYDzTqNN0OgFKj25BDxtGKf62uQHDwie98zWgquulsxcLwfNupHrhykM3OCqK+ugwZQWJ
        oOvBgFzIah9BK6R2sHuOoy8TDTEiSs7QWMPqjboDkPlb9FBsp35+Rqw6AN/GE9jzodUjU1
        CkUOCtrdRuCfyi6umjmks1ypkHHwdTj5k2HyYNgnbvKay5AE0Ya3ZYycB+7l6DszkmEiW3
        HAngKpCCFiv+/41LV+7TbnTwgebO5RbgdypK9Y2E97LsAFcgIRStSwUvAnYW9UYIyprVZX
        xeod8oeMUiAqgYMFSsuUzzNPDUhE0WrLUd2+0ASFy/hI+iTsDjXfW7+kEpYl9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+OfYFZ30/Bhh320VllxL/nQwxccB4cYCI77NAMkEY24=;
        b=qOmRXcfhndgGadZ/H06/nr2sDRcvv8UTvmUVMVJ1KSFUTbQtDoOZU4itHB8WmA4k9YmbH+
        C4H2Rluoh6tqa7Dw==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic: Refactor SMP configuration
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243905543.7002.4041160664706483630.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7ec46b519467852fc8eb83b6214ad568f8007846
Gitweb:        https://git.kernel.org/tip/7ec46b519467852fc8eb83b6214ad568f8007846
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sat, 25 Apr 2020 15:24:01 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Sep 2020 16:37:26 +01:00

irqchip/gic: Refactor SMP configuration

As we are about to change quite a lot of the SMP support code,
let's start by moving it around so that it minimizes the amount
of #ifdefery.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic.c | 76 ++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 36 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index a27ba2c..4ffd62a 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -325,28 +325,6 @@ static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
 	return 0;
 }
 
-#ifdef CONFIG_SMP
-static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
-			    bool force)
-{
-	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + gic_irq(d);
-	unsigned int cpu;
-
-	if (!force)
-		cpu = cpumask_any_and(mask_val, cpu_online_mask);
-	else
-		cpu = cpumask_first(mask_val);
-
-	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
-		return -EINVAL;
-
-	writeb_relaxed(gic_cpu_map[cpu], reg);
-	irq_data_update_effective_affinity(d, cpumask_of(cpu));
-
-	return IRQ_SET_MASK_OK_DONE;
-}
-#endif
-
 static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqstat, irqnr;
@@ -795,6 +773,26 @@ static int gic_pm_init(struct gic_chip_data *gic)
 #endif
 
 #ifdef CONFIG_SMP
+static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
+			    bool force)
+{
+	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + gic_irq(d);
+	unsigned int cpu;
+
+	if (!force)
+		cpu = cpumask_any_and(mask_val, cpu_online_mask);
+	else
+		cpu = cpumask_first(mask_val);
+
+	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	writeb_relaxed(gic_cpu_map[cpu], reg);
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+
 static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 {
 	int cpu;
@@ -824,6 +822,23 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 
 	gic_unlock_irqrestore(flags);
 }
+
+static int gic_starting_cpu(unsigned int cpu)
+{
+	gic_cpu_init(&gic_data[0]);
+	return 0;
+}
+
+static __init void gic_smp_init(void)
+{
+	set_smp_cross_call(gic_raise_softirq);
+	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
+				  "irqchip/arm/gic:starting",
+				  gic_starting_cpu, NULL);
+}
+#else
+#define gic_smp_init()		do { } while(0)
+#define gic_set_affinity	NULL
 #endif
 
 #ifdef CONFIG_BL_SWITCHER
@@ -1027,12 +1042,6 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 	return -EINVAL;
 }
 
-static int gic_starting_cpu(unsigned int cpu)
-{
-	gic_cpu_init(&gic_data[0]);
-	return 0;
-}
-
 static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				unsigned int nr_irqs, void *arg)
 {
@@ -1079,10 +1088,8 @@ static void gic_init_chip(struct gic_chip_data *gic, struct device *dev,
 		gic->chip.irq_set_vcpu_affinity = gic_irq_set_vcpu_affinity;
 	}
 
-#ifdef CONFIG_SMP
 	if (gic == &gic_data[0])
 		gic->chip.irq_set_affinity = gic_set_affinity;
-#endif
 }
 
 static int gic_init_bases(struct gic_chip_data *gic,
@@ -1199,12 +1206,7 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
 		 */
 		for (i = 0; i < NR_GIC_CPU_IF; i++)
 			gic_cpu_map[i] = 0xff;
-#ifdef CONFIG_SMP
-		set_smp_cross_call(gic_raise_softirq);
-#endif
-		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
-					  "irqchip/arm/gic:starting",
-					  gic_starting_cpu, NULL);
+
 		set_handle_irq(gic_handle_irq);
 		if (static_branch_likely(&supports_deactivate_key))
 			pr_info("GIC: Using split EOI/Deactivate mode\n");
@@ -1221,6 +1223,8 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
 	ret = gic_init_bases(gic, handle);
 	if (ret)
 		kfree(name);
+	else if (gic == &gic_data[0])
+		gic_smp_init();
 
 	return ret;
 }
