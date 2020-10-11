Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB57A28A8F8
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgJKSAG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388432AbgJKR5c (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD1EC0613D0;
        Sun, 11 Oct 2020 10:57:31 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lt9hbjdmHPfPZbQljoPRJY2wZCbN+IyAnoiP7ndOiR8=;
        b=P9WpJYjl1yIB9jWIljwFy66aDdIpxKRFWsOP4sxW71XsNXxqXXi80aX3YEt2VAgJaekgVg
        peucUv7asZ75oJ5x/pGAmYbxEuFWgWyUPpMWzFDEFu8tZZTact1ubw4eZdmvjPkJJhAyA2
        P8/mpnR6tiSwJkJhSxskKUPa38eM399fi2nxWkQRyMK9Q0qwwV6Rv0CPa4ldCENk3c7gBA
        BYyNhd/uEiyABL1yVgKdbelghnnILyNaImQfk2TfGKAKmb6Ju8dEZs0aaXvko6favCvFCA
        1bDUF1UcvKZHxIfdp8RWEzOuMCjO3o04gr6TUAKW3HEkC+Ub2wgw+VUlybVdyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lt9hbjdmHPfPZbQljoPRJY2wZCbN+IyAnoiP7ndOiR8=;
        b=gKy7ZZfBAO+PIlYA1rPqHbWb0oYFhKp+9JkptzfyiMZiojq24T1x4Y8MYvsxCSMupOl/nx
        lIRvoTm2sfMUPMBg==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic: Cleanup Franken-GIC handling
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243904951.7002.4149665170568132503.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8594c3b85171b6f68e34e07b533ec2f1bf7fb065
Gitweb:        https://git.kernel.org/tip/8594c3b85171b6f68e34e07b533ec2f1bf7fb065
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 15 Sep 2020 14:03:51 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Sep 2020 16:37:29 +01:00

irqchip/gic: Cleanup Franken-GIC handling

Introduce a static key identifying Samsung's unique creation, allowing
to replace the indirect call to compute the base addresses with
a simple test on the static key.

Faster, cheaper, negative diffstat.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic.c | 41 +++++++++++---------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 66671e1..30edcca 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -83,9 +83,6 @@ struct gic_chip_data {
 #endif
 	struct irq_domain *domain;
 	unsigned int gic_irqs;
-#ifdef CONFIG_GIC_NON_BANKED
-	void __iomem *(*get_base)(union gic_base *);
-#endif
 };
 
 #ifdef CONFIG_BL_SWITCHER
@@ -127,35 +124,27 @@ static struct gic_kvm_info gic_v2_kvm_info;
 static DEFINE_PER_CPU(u32, sgi_intid);
 
 #ifdef CONFIG_GIC_NON_BANKED
-static void __iomem *gic_get_percpu_base(union gic_base *base)
-{
-	return raw_cpu_read(*base->percpu_base);
-}
+static DEFINE_STATIC_KEY_FALSE(frankengic_key);
 
-static void __iomem *gic_get_common_base(union gic_base *base)
+static void enable_frankengic(void)
 {
-	return base->common_base;
+	static_branch_enable(&frankengic_key);
 }
 
-static inline void __iomem *gic_data_dist_base(struct gic_chip_data *data)
+static inline void __iomem *__get_base(union gic_base *base)
 {
-	return data->get_base(&data->dist_base);
-}
+	if (static_branch_unlikely(&frankengic_key))
+		return raw_cpu_read(*base->percpu_base);
 
-static inline void __iomem *gic_data_cpu_base(struct gic_chip_data *data)
-{
-	return data->get_base(&data->cpu_base);
+	return base->common_base;
 }
 
-static inline void gic_set_base_accessor(struct gic_chip_data *data,
-					 void __iomem *(*f)(union gic_base *))
-{
-	data->get_base = f;
-}
+#define gic_data_dist_base(d)	__get_base(&(d)->dist_base)
+#define gic_data_cpu_base(d)	__get_base(&(d)->cpu_base)
 #else
 #define gic_data_dist_base(d)	((d)->dist_base.common_base)
 #define gic_data_cpu_base(d)	((d)->cpu_base.common_base)
-#define gic_set_base_accessor(d, f)
+#define enable_frankengic()	do { } while(0)
 #endif
 
 static inline void __iomem *gic_dist_base(struct irq_data *d)
@@ -307,7 +296,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 
 	/* Interrupt configuration for SGIs can't be changed */
 	if (gicirq < 16)
-		return type == IRQ_TYPE_EDGE_RISING ? 0 : -EINVAL;
+		return type != IRQ_TYPE_EDGE_RISING ? -EINVAL : 0;
 
 	/* SPIs have restrictions on the supported types */
 	if (gicirq >= 32 && type != IRQ_TYPE_LEVEL_HIGH &&
@@ -720,11 +709,6 @@ static int gic_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
 	int i;
 
 	for (i = 0; i < CONFIG_ARM_GIC_MAX_NR; i++) {
-#ifdef CONFIG_GIC_NON_BANKED
-		/* Skip over unused GICs */
-		if (!gic_data[i].get_base)
-			continue;
-#endif
 		switch (cmd) {
 		case CPU_PM_ENTER:
 			gic_cpu_save(&gic_data[i]);
@@ -1165,7 +1149,7 @@ static int gic_init_bases(struct gic_chip_data *gic,
 				gic->raw_cpu_base + offset;
 		}
 
-		gic_set_base_accessor(gic, gic_get_percpu_base);
+		enable_frankengic();
 	} else {
 		/* Normal, sane GIC... */
 		WARN(gic->percpu_offset,
@@ -1173,7 +1157,6 @@ static int gic_init_bases(struct gic_chip_data *gic,
 		     gic->percpu_offset);
 		gic->dist_base.common_base = gic->raw_dist_base;
 		gic->cpu_base.common_base = gic->raw_cpu_base;
-		gic_set_base_accessor(gic, gic_get_common_base);
 	}
 
 	/*
