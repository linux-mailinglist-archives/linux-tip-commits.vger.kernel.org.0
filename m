Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE473E5637
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 11:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbhHJJIE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 05:08:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41862 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbhHJJIE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 05:08:04 -0400
Date:   Tue, 10 Aug 2021 09:07:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628586460;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8yTxOiFA9GbF97x7uuvq74y8EFVr0Ci19U/U/4WDl/o=;
        b=D/o/DMBuQK4c0hD54W8OUFGl2gs9yXiuixc+nrzTHuYnKmemv9ThoMMuhu3sVOPwWgncCa
        LUrYdDfjVckzMNlIGDD5HEqfwCFsdjkPL2EUy2kiobd03GoFb3KxS3//vQRylO03shcVrs
        EzVt8xdyHlJoEg6ijJEkqtK2tmUf0eN9jOhYUHFQyQ2t9tIQklabKn8IGNeBBcy+rJe1E3
        whGso1Xv295+Br6wqfoyIHorFImZ4lsswwUPn3ckk+eXgBRrl+0ROH1BoMt6osrieiWCHK
        P+hgLMh1jShgQADbIwt8/j4w+QQgevq0ZuggLt5w+K3uuRBkveLMMVl0o634WQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628586460;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8yTxOiFA9GbF97x7uuvq74y8EFVr0Ci19U/U/4WDl/o=;
        b=xnLC1NBcFwcUdVSuN1z9UgBxBzlDyCGwl5X7lB5qEn6laLm60xZa4f7tYYHN32S2k/0PRw
        B/mI5db5RFN3/3Bg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Deobfuscate virtual MSI-X
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210729222543.151522318@linutronix.de>
References: <20210729222543.151522318@linutronix.de>
MIME-Version: 1.0
Message-ID: <162858645939.395.3014962225125734205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b296ababcc4bbf8efbb603d3aec6024a78662c1b
Gitweb:        https://git.kernel.org/tip/b296ababcc4bbf8efbb603d3aec6024a78662c1b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 29 Jul 2021 23:51:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 11:03:30 +02:00

PCI/MSI: Deobfuscate virtual MSI-X

Handling of virtual MSI-X is obfuscated by letting pci_msix_desc_addr()
return NULL and checking the pointer.

Just use msi_desc::msi_attrib.is_virtual at the call sites and get rid of
that pointer check.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210729222543.151522318@linutronix.de

---
 drivers/pci/msi.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d2821bb..1bde9ec 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -166,11 +166,7 @@ static void msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 
 static void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
 {
-	if (desc->msi_attrib.is_virtual)
-		return NULL;
-
-	return desc->mask_base +
-		desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
+	return desc->mask_base + desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
 }
 
 /*
@@ -182,14 +178,10 @@ static void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
  */
 static u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
 {
+	void __iomem *desc_addr = pci_msix_desc_addr(desc);
 	u32 ctrl = desc->msix_ctrl;
-	void __iomem *desc_addr;
-
-	if (pci_msi_ignore_mask)
-		return 0;
 
-	desc_addr = pci_msix_desc_addr(desc);
-	if (!desc_addr)
+	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
 		return 0;
 
 	ctrl &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
@@ -256,10 +248,8 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 	if (entry->msi_attrib.is_msix) {
 		void __iomem *base = pci_msix_desc_addr(entry);
 
-		if (!base) {
-			WARN_ON(1);
+		if (WARN_ON_ONCE(entry->msi_attrib.is_virtual))
 			return;
-		}
 
 		msg->address_lo = readl(base + PCI_MSIX_ENTRY_LOWER_ADDR);
 		msg->address_hi = readl(base + PCI_MSIX_ENTRY_UPPER_ADDR);
@@ -292,7 +282,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 		void __iomem *base = pci_msix_desc_addr(entry);
 		bool unmasked = !(entry->msix_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
 
-		if (!base)
+		if (entry->msi_attrib.is_virtual)
 			goto skip;
 
 		/*
@@ -744,9 +734,10 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 		entry->msi_attrib.default_irq	= dev->irq;
 		entry->mask_base		= base;
 
-		addr = pci_msix_desc_addr(entry);
-		if (addr)
+		if (!entry->msi_attrib.is_virtual) {
+			addr = pci_msix_desc_addr(entry);
 			entry->msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+		}
 
 		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
 		if (masks)
