Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0E926CDE2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 23:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgIPVF7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 17:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgIPQOy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665A6C02C28B;
        Wed, 16 Sep 2020 08:17:18 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269147;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=488N6wQurTksVQAM7a3w0y6UbpMCq6Fzuf5z+HrfVxM=;
        b=zw74+7HPMJtSeuhreC33CFjpJv7ZB1H++6oIJAsjGEOPDVU69O3LYLPdB77D8KInu7ASJj
        ivYTqmVkSzsu4V+Yk4tDiJ19L5D1ISVAuX74Hgps5i3R3pU87LxN9H/mBD91raXZQCMCyE
        VtreJeKB7Eb5G3eoOMIaJgcU2uP7/XvEVYrl9iVTmLpNdpit/8aq8Tl9VYY94mbefv6XPG
        0Le4B3xDregQPEGAgXxJU+sSIQObwGuJm9sDOwGgR72oXXRg0m87K7Q0QuoYjY7+CQqrdF
        /OJ/cdVSxRdM7kQEhxoHEWFkllw3UkYkRnnd/UrzyNOwbabON++ppwSW//Z4nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269147;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=488N6wQurTksVQAM7a3w0y6UbpMCq6Fzuf5z+HrfVxM=;
        b=H70x687Yjzwfe47fzEpnjLjMhYoNWHHjBNaMXOHSJMnpXCX3+VRK5K9AYUk1jmuddbnSzs
        aTGArOaO9B0HskBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/msi: Move compose message callback where it belongs
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112331.157603198@linutronix.de>
References: <20200826112331.157603198@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026914673.15536.10904150133157409823.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     b0a19555efd098183db0ee3ad52a3cd3bfbd1ba2
Gitweb:        https://git.kernel.org/tip/b0a19555efd098183db0ee3ad52a3cd3bfbd1ba2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:33 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:28 +02:00

x86/msi: Move compose message callback where it belongs

Composing the MSI message at the MSI chip level is wrong because the
underlying parent domain is the one which knows how the message should be
composed for the direct vector delivery or the interrupt remapping table
entry.

The interrupt remapping aware PCI/MSI chip does that already. Make the
direct delivery chip do the same and move the composition of the direct
delivery MSI message to the vector domain irq chip.

This prepares for the upcoming device MSI support to avoid having
architecture specific knowledge in the device MSI domain irq chips.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200826112331.157603198@linutronix.de

---
 arch/x86/include/asm/apic.h   |  8 ++++++++
 arch/x86/kernel/apic/msi.c    | 12 +++---------
 arch/x86/kernel/apic/vector.c |  1 +
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 2cc44e9..1c129ab 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -519,6 +519,14 @@ static inline bool apic_id_is_primary_thread(unsigned int id) { return false; }
 static inline void apic_smt_update(void) { }
 #endif
 
+struct msi_msg;
+
+#ifdef CONFIG_PCI_MSI
+void x86_vector_msi_compose_msg(struct irq_data *data, struct msi_msg *msg);
+#else
+# define x86_vector_msi_compose_msg NULL
+#endif
+
 extern void ioapic_zap_locks(void);
 
 #endif /* _ASM_X86_APIC_H */
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 7f7bc6a..5e8465e 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -45,7 +45,7 @@ static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
 		MSI_DATA_VECTOR(cfg->vector);
 }
 
-static void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
+void x86_vector_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	__irq_msi_compose_msg(irqd_cfg(data), msg);
 }
@@ -177,7 +177,6 @@ static struct irq_chip pci_msi_controller = {
 	.irq_mask		= pci_msi_mask_irq,
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_compose_msi_msg	= irq_msi_compose_msg,
 	.irq_set_affinity	= msi_set_affinity,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
@@ -321,7 +320,6 @@ static struct irq_chip dmar_msi_controller = {
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_set_affinity	= msi_domain_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_compose_msi_msg	= irq_msi_compose_msg,
 	.irq_write_msi_msg	= dmar_msi_write_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
@@ -419,7 +417,6 @@ static struct irq_chip hpet_msi_controller __ro_after_init = {
 	.irq_ack = irq_chip_ack_parent,
 	.irq_set_affinity = msi_domain_set_affinity,
 	.irq_retrigger = irq_chip_retrigger_hierarchy,
-	.irq_compose_msi_msg = irq_msi_compose_msg,
 	.irq_write_msi_msg = hpet_msi_write_msg,
 	.flags = IRQCHIP_SKIP_SET_WAKE,
 };
@@ -479,13 +476,10 @@ struct irq_domain *hpet_create_irq_domain(int hpet_id)
 	info.type = X86_IRQ_ALLOC_TYPE_HPET;
 	info.hpet_id = hpet_id;
 	parent = irq_remapping_get_ir_irq_domain(&info);
-	if (parent == NULL) {
+	if (parent == NULL)
 		parent = x86_vector_domain;
-	} else {
+	else
 		hpet_msi_controller.name = "IR-HPET-MSI";
-		/* Temporary fix: Will go away */
-		hpet_msi_controller.irq_compose_msi_msg = NULL;
-	}
 
 	fn = irq_domain_alloc_named_id_fwnode(hpet_msi_controller.name,
 					      hpet_id);
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index f8a56b5..66516d8 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -824,6 +824,7 @@ static struct irq_chip lapic_controller = {
 	.name			= "APIC",
 	.irq_ack		= apic_ack_edge,
 	.irq_set_affinity	= apic_set_affinity,
+	.irq_compose_msi_msg	= x86_vector_msi_compose_msg,
 	.irq_retrigger		= apic_retrigger_irq,
 };
 
