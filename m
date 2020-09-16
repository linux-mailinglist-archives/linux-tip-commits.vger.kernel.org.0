Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A415926C418
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 17:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgIPPW4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 11:22:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49576 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgIPPUg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 11:20:36 -0400
Date:   Wed, 16 Sep 2020 15:12:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wT8D+EK9jfnomToaihRKqqn1DYbgpCrWJvXfwd/Mbz8=;
        b=y7RFj/HKkVhPYs50Q3whhcbtDi7LjLwGvj8AT8f1wJSbDTSawk5P91od6UfA8eIUBs7D4d
        naQu7pOvSjpCewoukOLKYoRWSRNfdlxypqft6Czbagy+tewH+5VPqqVuqvyA2cMf4Mt+wa
        VrapB9FCZgQtInxPcti9Hok0B2upkT/UnXiT814ANO/kEFcA3zfItjrJ770n0/hSZs9Csd
        tOX7NE7f7uQa6tXhaTIQwfWfZ+av6HAMfTQlt9+JfgKxo7hwoVBsvdfNX7d5dNjJ/srhOc
        XeyN7PamAn9C+2IiGH9JjhhZHeGqQUwnhj2AVr1Xic/P49StMp+GuDvMpq5Xnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wT8D+EK9jfnomToaihRKqqn1DYbgpCrWJvXfwd/Mbz8=;
        b=cKdXNhVeHcl/QtrRsVNrZhXXM6NnnkNFkrgyWQRASAVHmDiv1IBWfY+BtF74wYQV08efbv
        IgmP4LF3x+F5IPBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] genirq/chip: Use the first chip in irq_chip_compose_msi_msg()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160026914743.15536.17259361630851258245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     13b90cadfc294718dd5a89e1fcf103477b01eb50
Gitweb:        https://git.kernel.org/tip/13b90cadfc294718dd5a89e1fcf103477b01eb50
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:32 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:28 +02:00

genirq/chip: Use the first chip in irq_chip_compose_msi_msg()

The documentation of irq_chip_compose_msi_msg() claims that with
hierarchical irq domains the first chip in the hierarchy which has an
irq_compose_msi_msg() callback is chosen. But the code just keeps
iterating after it finds a chip with a compose callback.

The x86 HPET MSI implementation relies on that behaviour, but that does not
make it more correct.

The message should always be composed at the domain which manages the
underlying resource (e.g. APIC or remap table) because that domain knows
about the required layout of the message.

On X86 the following hierarchies exist:

1)   vector -------- PCI/MSI
2)   vector -- IR -- PCI/MSI

The vector domain has a different message format than the IR (remapping)
domain. So obviously the PCI/MSI domain can't compose the message without
having knowledge about the parent domain, which is exactly the opposite of
what hierarchical domains want to achieve.

X86 actually has two different PCI/MSI chips where #1 has a compose
callback and #2 does not. #2 delegates the composition to the remap domain
where it belongs, but #1 does it at the PCI/MSI level.

For the upcoming device MSI support it's necessary to change this and just
let the first domain which can compose the message take care of it. That
way the top level chip does not have to worry about it and the device MSI
code does not need special knowledge about topologies. It just sets the
compose callback to NULL and lets the hierarchy pick the first chip which
has one.

Due to that the attempt to move the compose callback from the direct
delivery PCI/MSI domain to the vector domain made the system fail to boot
with interrupt remapping enabled because in the remapping case
irq_chip_compose_msi_msg() keeps iterating and choses the compose callback
of the vector domain which obviously creates the wrong format for the remap
table.

Break out of the loop when the first irq chip with a compose callback is
found and fixup the HPET code temporarily. That workaround will be removed
once the direct delivery compose callback is moved to the place where it
belongs in the vector domain.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>                                                                                                                                                                                                                                     Link: https://lore.kernel.org/r/20200826112331.047917603@linutronix.de
 
---
 arch/x86/kernel/apic/msi.c |  7 +++++--
 kernel/irq/chip.c          |  9 ++++-----
 kernel/irq/internals.h     |  9 +++++++++
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index c2b2911..7f7bc6a 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -479,10 +479,13 @@ struct irq_domain *hpet_create_irq_domain(int hpet_id)
 	info.type = X86_IRQ_ALLOC_TYPE_HPET;
 	info.hpet_id = hpet_id;
 	parent = irq_remapping_get_ir_irq_domain(&info);
-	if (parent == NULL)
+	if (parent == NULL) {
 		parent = x86_vector_domain;
-	else
+	} else {
 		hpet_msi_controller.name = "IR-HPET-MSI";
+		/* Temporary fix: Will go away */
+		hpet_msi_controller.irq_compose_msi_msg = NULL;
+	}
 
 	fn = irq_domain_alloc_named_id_fwnode(hpet_msi_controller.name,
 					      hpet_id);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 857f5f4..0ae308e 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1541,18 +1541,17 @@ EXPORT_SYMBOL_GPL(irq_chip_release_resources_parent);
  */
 int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct irq_data *pos = NULL;
+	struct irq_data *pos;
 
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-	for (; data; data = data->parent_data)
-#endif
+	for (pos = NULL; !pos && data; data = irqd_get_parent_data(data)) {
 		if (data->chip && data->chip->irq_compose_msi_msg)
 			pos = data;
+	}
+
 	if (!pos)
 		return -ENOSYS;
 
 	pos->chip->irq_compose_msi_msg(pos, msg);
-
 	return 0;
 }
 
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 7db284b..5436352 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -473,6 +473,15 @@ static inline void irq_domain_deactivate_irq(struct irq_data *data)
 }
 #endif
 
+static inline struct irq_data *irqd_get_parent_data(struct irq_data *irqd)
+{
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	return irqd->parent_data;
+#else
+	return NULL;
+#endif
+}
+
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 #include <linux/debugfs.h>
 
