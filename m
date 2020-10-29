Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBBA29EB96
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgJ2MQq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:16:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33322 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgJ2MPr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:47 -0400
Date:   Thu, 29 Oct 2020 12:15:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bCq3OiF924pktchfCYypbdiZmyrMEVVH9yhcuHD2KPY=;
        b=lw4+G6+55U/6KgbQ++yPRJWGiOTbbltotkm/sjV4YDgfD01P3gbJHUMVx2ObBBNicmz5O6
        Y4P7Mp/lMtQsl0N203gaZusIKbcFVVPGphANlU7RgRUfEoF4paEZi2BIXGnkKfeO4aAOyt
        RN6Hgy/KOWR9L7nNoGYS+TeJMNM1stVXNulIs7MM3rTQ01kgcng5tgY67rdKvGHRlq3z6r
        twKtZII3lhYVDEzTGmFGJUyEOeqhSemjp/7+2P02GzN963HvxdouX/Bp3bi2PYsKoHfWeD
        pvyt6UIpjzS6m0QHEgk9sxSKazgNjgTPBcSuiLZ3o2mcm5uf5iUhqq+jF2Q9Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bCq3OiF924pktchfCYypbdiZmyrMEVVH9yhcuHD2KPY=;
        b=Ij5oRgN47CSAHTvRL4T6/fb3/b+GZgXjKVhZvCr5ybfoO27UU8dW4mdExhaB5S3Wraez0l
        CH807lCu1Xep/HAQ==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/hpet: Move MSI support into hpet.c
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-11-dwmw2@infradead.org>
References: <20201024213535.443185-11-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397374392.397.7775587789107375060.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     3d7295eb3003aea9f89de35304b3a88ae4d5036b
Gitweb:        https://git.kernel.org/tip/3d7295eb3003aea9f89de35304b3a88ae4d5036b
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Sat, 24 Oct 2020 22:35:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:25 +01:00

x86/hpet: Move MSI support into hpet.c

This isn't really dependent on PCI MSI; it's just generic MSI which is now
supported by the generic x86_vector_domain. Move the HPET MSI support back
into hpet.c with the rest of the HPET support.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-11-dwmw2@infradead.org

---
 arch/x86/include/asm/hpet.h |  11 +---
 arch/x86/kernel/apic/msi.c  | 111 +---------------------------------
 arch/x86/kernel/hpet.c      | 118 +++++++++++++++++++++++++++++++++--
 3 files changed, 112 insertions(+), 128 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 6352dee..ab9f3dd 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -74,17 +74,6 @@ extern void hpet_disable(void);
 extern unsigned int hpet_readl(unsigned int a);
 extern void force_hpet_resume(void);
 
-struct irq_data;
-struct hpet_channel;
-struct irq_domain;
-
-extern void hpet_msi_unmask(struct irq_data *data);
-extern void hpet_msi_mask(struct irq_data *data);
-extern void hpet_msi_write(struct hpet_channel *hc, struct msi_msg *msg);
-extern struct irq_domain *hpet_create_irq_domain(int hpet_id);
-extern int hpet_assign_irq(struct irq_domain *domain,
-			   struct hpet_channel *hc, int dev_num);
-
 #ifdef CONFIG_HPET_EMULATE_RTC
 
 #include <linux/interrupt.h>
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 4eda617..44ebe25 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -340,114 +340,3 @@ void dmar_free_hwirq(int irq)
 	irq_domain_free_irqs(irq, 1);
 }
 #endif
-
-/*
- * MSI message composition
- */
-#ifdef CONFIG_HPET_TIMER
-static inline int hpet_dev_id(struct irq_domain *domain)
-{
-	struct msi_domain_info *info = msi_get_domain_info(domain);
-
-	return (int)(long)info->data;
-}
-
-static void hpet_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
-{
-	hpet_msi_write(irq_data_get_irq_handler_data(data), msg);
-}
-
-static struct irq_chip hpet_msi_controller __ro_after_init = {
-	.name = "HPET-MSI",
-	.irq_unmask = hpet_msi_unmask,
-	.irq_mask = hpet_msi_mask,
-	.irq_ack = irq_chip_ack_parent,
-	.irq_set_affinity = msi_domain_set_affinity,
-	.irq_retrigger = irq_chip_retrigger_hierarchy,
-	.irq_write_msi_msg = hpet_msi_write_msg,
-	.flags = IRQCHIP_SKIP_SET_WAKE,
-};
-
-static int hpet_msi_init(struct irq_domain *domain,
-			 struct msi_domain_info *info, unsigned int virq,
-			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
-{
-	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
-	irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
-			    handle_edge_irq, arg->data, "edge");
-
-	return 0;
-}
-
-static void hpet_msi_free(struct irq_domain *domain,
-			  struct msi_domain_info *info, unsigned int virq)
-{
-	irq_clear_status_flags(virq, IRQ_MOVE_PCNTXT);
-}
-
-static struct msi_domain_ops hpet_msi_domain_ops = {
-	.msi_init	= hpet_msi_init,
-	.msi_free	= hpet_msi_free,
-};
-
-static struct msi_domain_info hpet_msi_domain_info = {
-	.ops		= &hpet_msi_domain_ops,
-	.chip		= &hpet_msi_controller,
-	.flags		= MSI_FLAG_USE_DEF_DOM_OPS,
-};
-
-struct irq_domain *hpet_create_irq_domain(int hpet_id)
-{
-	struct msi_domain_info *domain_info;
-	struct irq_domain *parent, *d;
-	struct irq_alloc_info info;
-	struct fwnode_handle *fn;
-
-	if (x86_vector_domain == NULL)
-		return NULL;
-
-	domain_info = kzalloc(sizeof(*domain_info), GFP_KERNEL);
-	if (!domain_info)
-		return NULL;
-
-	*domain_info = hpet_msi_domain_info;
-	domain_info->data = (void *)(long)hpet_id;
-
-	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT;
-	info.devid = hpet_id;
-	parent = irq_remapping_get_irq_domain(&info);
-	if (parent == NULL)
-		parent = x86_vector_domain;
-	else
-		hpet_msi_controller.name = "IR-HPET-MSI";
-
-	fn = irq_domain_alloc_named_id_fwnode(hpet_msi_controller.name,
-					      hpet_id);
-	if (!fn) {
-		kfree(domain_info);
-		return NULL;
-	}
-
-	d = msi_create_irq_domain(fn, domain_info, parent);
-	if (!d) {
-		irq_domain_free_fwnode(fn);
-		kfree(domain_info);
-	}
-	return d;
-}
-
-int hpet_assign_irq(struct irq_domain *domain, struct hpet_channel *hc,
-		    int dev_num)
-{
-	struct irq_alloc_info info;
-
-	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_HPET;
-	info.data = hc;
-	info.devid = hpet_dev_id(domain);
-	info.hwirq = dev_num;
-
-	return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
-}
-#endif
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 7a50f0b..3b8b127 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -7,6 +7,7 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
 
+#include <asm/irq_remapping.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
 
@@ -50,7 +51,7 @@ unsigned long				hpet_address;
 u8					hpet_blockid; /* OS timer block num */
 bool					hpet_msi_disable;
 
-#ifdef CONFIG_PCI_MSI
+#ifdef CONFIG_GENERIC_MSI_IRQ
 static DEFINE_PER_CPU(struct hpet_channel *, cpu_hpet_channel);
 static struct irq_domain		*hpet_domain;
 #endif
@@ -467,9 +468,8 @@ static void __init hpet_legacy_clockevent_register(struct hpet_channel *hc)
 /*
  * HPET MSI Support
  */
-#ifdef CONFIG_PCI_MSI
-
-void hpet_msi_unmask(struct irq_data *data)
+#ifdef CONFIG_GENERIC_MSI_IRQ
+static void hpet_msi_unmask(struct irq_data *data)
 {
 	struct hpet_channel *hc = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
@@ -479,7 +479,7 @@ void hpet_msi_unmask(struct irq_data *data)
 	hpet_writel(cfg, HPET_Tn_CFG(hc->num));
 }
 
-void hpet_msi_mask(struct irq_data *data)
+static void hpet_msi_mask(struct irq_data *data)
 {
 	struct hpet_channel *hc = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
@@ -489,12 +489,118 @@ void hpet_msi_mask(struct irq_data *data)
 	hpet_writel(cfg, HPET_Tn_CFG(hc->num));
 }
 
-void hpet_msi_write(struct hpet_channel *hc, struct msi_msg *msg)
+static void hpet_msi_write(struct hpet_channel *hc, struct msi_msg *msg)
 {
 	hpet_writel(msg->data, HPET_Tn_ROUTE(hc->num));
 	hpet_writel(msg->address_lo, HPET_Tn_ROUTE(hc->num) + 4);
 }
 
+static void hpet_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	hpet_msi_write(irq_data_get_irq_handler_data(data), msg);
+}
+
+static struct irq_chip hpet_msi_controller __ro_after_init = {
+	.name = "HPET-MSI",
+	.irq_unmask = hpet_msi_unmask,
+	.irq_mask = hpet_msi_mask,
+	.irq_ack = irq_chip_ack_parent,
+	.irq_set_affinity = msi_domain_set_affinity,
+	.irq_retrigger = irq_chip_retrigger_hierarchy,
+	.irq_write_msi_msg = hpet_msi_write_msg,
+	.flags = IRQCHIP_SKIP_SET_WAKE,
+};
+
+static int hpet_msi_init(struct irq_domain *domain,
+			 struct msi_domain_info *info, unsigned int virq,
+			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
+{
+	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
+	irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
+			    handle_edge_irq, arg->data, "edge");
+
+	return 0;
+}
+
+static void hpet_msi_free(struct irq_domain *domain,
+			  struct msi_domain_info *info, unsigned int virq)
+{
+	irq_clear_status_flags(virq, IRQ_MOVE_PCNTXT);
+}
+
+static struct msi_domain_ops hpet_msi_domain_ops = {
+	.msi_init	= hpet_msi_init,
+	.msi_free	= hpet_msi_free,
+};
+
+static struct msi_domain_info hpet_msi_domain_info = {
+	.ops		= &hpet_msi_domain_ops,
+	.chip		= &hpet_msi_controller,
+	.flags		= MSI_FLAG_USE_DEF_DOM_OPS,
+};
+
+static struct irq_domain *hpet_create_irq_domain(int hpet_id)
+{
+	struct msi_domain_info *domain_info;
+	struct irq_domain *parent, *d;
+	struct irq_alloc_info info;
+	struct fwnode_handle *fn;
+
+	if (x86_vector_domain == NULL)
+		return NULL;
+
+	domain_info = kzalloc(sizeof(*domain_info), GFP_KERNEL);
+	if (!domain_info)
+		return NULL;
+
+	*domain_info = hpet_msi_domain_info;
+	domain_info->data = (void *)(long)hpet_id;
+
+	init_irq_alloc_info(&info, NULL);
+	info.type = X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT;
+	info.devid = hpet_id;
+	parent = irq_remapping_get_irq_domain(&info);
+	if (parent == NULL)
+		parent = x86_vector_domain;
+	else
+		hpet_msi_controller.name = "IR-HPET-MSI";
+
+	fn = irq_domain_alloc_named_id_fwnode(hpet_msi_controller.name,
+					      hpet_id);
+	if (!fn) {
+		kfree(domain_info);
+		return NULL;
+	}
+
+	d = msi_create_irq_domain(fn, domain_info, parent);
+	if (!d) {
+		irq_domain_free_fwnode(fn);
+		kfree(domain_info);
+	}
+	return d;
+}
+
+static inline int hpet_dev_id(struct irq_domain *domain)
+{
+	struct msi_domain_info *info = msi_get_domain_info(domain);
+
+	return (int)(long)info->data;
+}
+
+static int hpet_assign_irq(struct irq_domain *domain, struct hpet_channel *hc,
+			   int dev_num)
+{
+	struct irq_alloc_info info;
+
+	init_irq_alloc_info(&info, NULL);
+	info.type = X86_IRQ_ALLOC_TYPE_HPET;
+	info.data = hc;
+	info.devid = hpet_dev_id(domain);
+	info.hwirq = dev_num;
+
+	return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
+}
+
 static int hpet_clkevt_msi_resume(struct clock_event_device *evt)
 {
 	struct hpet_channel *hc = clockevent_to_channel(evt);
