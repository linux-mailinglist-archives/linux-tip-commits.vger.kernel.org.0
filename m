Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DF829EB78
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgJ2MPw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:15:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33230 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgJ2MPv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:51 -0400
Date:   Thu, 29 Oct 2020 12:15:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tBoaR8dOHAaHgA43wLXPNld+uNIoIhuMG1zpf/oJ/Uc=;
        b=o3F83qlPR0d/BqZsAKdronkP5827UXjE0ZijvraNnA16KE2rSt1+xiB/S9lrQ7Dg/YEZ6s
        xHEAzJug9LcqUjT2VxR03UQoBrl++7b3aBIVMUHbrI9+XgYbHH5QWzo1rObz4Xhi9z1wvm
        wW0m1KSzJqyUO/aEQqGZfm/HWojOWUrUPV3kvBqiy9lBJTg2/bC2LFyqTcLe1VcR47JFZA
        WqT5gNew29iAR6uGubJAQe1H/FUapKFy0+MHfcz3t1+4lKojNJrWMuekd8qw/guvj+uG+4
        o5GFE79+abptiP6PegZPAM/WB9vwdF++zrChRwz1pmmQak99Md3UmxY+qlykBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tBoaR8dOHAaHgA43wLXPNld+uNIoIhuMG1zpf/oJ/Uc=;
        b=0legjyPFJf4fJk77GyJs6F9JhbK1kEMUC73K3HUq1XWgdthyLSIgc5HxAJGwhhlefy1cCC
        4u51IVc/cFICgZAA==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/msi: Only use high bits of MSI address for DMAR unit
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-3-dwmw2@infradead.org>
References: <20201024213535.443185-3-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397374883.397.12235159676662296048.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     47bea873cf809f490cfac0c4e88533fd7fed6064
Gitweb:        https://git.kernel.org/tip/47bea873cf809f490cfac0c4e88533fd7fed6064
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Sat, 24 Oct 2020 22:35:02 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:24 +01:00

x86/msi: Only use high bits of MSI address for DMAR unit

The Intel IOMMU has an MSI-like configuration for its interrupt, but it
isn't really MSI. So it gets to abuse the high 32 bits of the address, and
puts the high 24 bits of the extended APIC ID there.

This isn't something that can be used in the general case for real MSIs,
since external devices using the high bits of the address would be
performing writes to actual memory space above 4GiB, not targeted at the
APIC.

Factor the hack out and allow it only to be used when appropriate, adding a
WARN_ON_ONCE() if other MSIs are targeted at an unreachable APIC ID. That
should never happen since the compatibility MSI messages are not used when
Interrupt Remapping is enabled.

The x2apic_enabled() check isn't needed because Linux won't bring up CPUs
with higher APIC IDs unless IR and x2apic are enabled anyway.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-3-dwmw2@infradead.org

---
 arch/x86/kernel/apic/msi.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 6313f0a..516df47 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -23,13 +23,11 @@
 
 struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
 
-static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
+static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
+				  bool dmar)
 {
 	msg->address_hi = MSI_ADDR_BASE_HI;
 
-	if (x2apic_enabled())
-		msg->address_hi |= MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid);
-
 	msg->address_lo =
 		MSI_ADDR_BASE_LO |
 		((apic->irq_dest_mode == 0) ?
@@ -43,18 +41,29 @@ static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
 		MSI_DATA_LEVEL_ASSERT |
 		MSI_DATA_DELIVERY_FIXED |
 		MSI_DATA_VECTOR(cfg->vector);
+
+	/*
+	 * Only the IOMMU itself can use the trick of putting destination
+	 * APIC ID into the high bits of the address. Anything else would
+	 * just be writing to memory if it tried that, and needs IR to
+	 * address higher APIC IDs.
+	 */
+	if (dmar)
+		msg->address_hi |= MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid);
+	else
+		WARN_ON_ONCE(MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid));
 }
 
 void x86_vector_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	__irq_msi_compose_msg(irqd_cfg(data), msg);
+	__irq_msi_compose_msg(irqd_cfg(data), msg, false);
 }
 
 static void irq_msi_update_msg(struct irq_data *irqd, struct irq_cfg *cfg)
 {
 	struct msi_msg msg[2] = { [1] = { }, };
 
-	__irq_msi_compose_msg(cfg, msg);
+	__irq_msi_compose_msg(cfg, msg, false);
 	irq_data_get_irq_chip(irqd)->irq_write_msi_msg(irqd, msg);
 }
 
@@ -276,6 +285,17 @@ struct irq_domain *arch_create_remap_msi_irq_domain(struct irq_domain *parent,
 #endif
 
 #ifdef CONFIG_DMAR_TABLE
+/*
+ * The Intel IOMMU (ab)uses the high bits of the MSI address to contain the
+ * high bits of the destination APIC ID. This can't be done in the general
+ * case for MSIs as it would be targeting real memory above 4GiB not the
+ * APIC.
+ */
+static void dmar_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	__irq_msi_compose_msg(irqd_cfg(data), msg, true);
+}
+
 static void dmar_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	dmar_msi_write(data->irq, msg);
@@ -288,6 +308,7 @@ static struct irq_chip dmar_msi_controller = {
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_set_affinity	= msi_domain_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_compose_msi_msg	= dmar_msi_compose_msg,
 	.irq_write_msi_msg	= dmar_msi_write_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
