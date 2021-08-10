Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2FB3E5636
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 11:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbhHJJID (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 05:08:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41858 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhHJJID (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 05:08:03 -0400
Date:   Tue, 10 Aug 2021 09:07:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628586459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gS/nYgS3bsaEMEVPCUduZ3SuL+pMxWzU/1Q03h6t2ag=;
        b=WLuwO47GMr8J+iT8nytpL9IoNMtDDlCLGFLjRkHY5cZIte7ZlKB0LuTswDkYkpNpiQc6x+
        1Wj4E1xlzki2K4E7gTkEB59TwLAzIZDz0PJjOBA8gExcyj8xr/tS2JO2PHRA487rM2EgG9
        I24uPyLhZn5Sg8+6P5qOctSlcgjMMvKQbggglK/61X9ySIV/EpCEQYUnejAwI7VTLM/9Zi
        AqjvJpvBWRLiqTo+D1eoM0Rd1ldJC1GpdKeZCvPZTtl4pApSy/yy/DXNtrx4FOaqDjAJVw
        TU7JrobMtRZEGanp0kEUode16vZyrXlEiVZV2yr6gnvxwwFRmaQQfRhWXW0jTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628586459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gS/nYgS3bsaEMEVPCUduZ3SuL+pMxWzU/1Q03h6t2ag=;
        b=Hf6w6XYvC3WzCFf5DUFiUp25gHQljnW6mJbwrk80QNPHpeKoV1P8/vruMnrZesP9DSSkBw
        bVNgaVUzu4DkPOBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Cleanup msi_mask()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210729222543.203905260@linutronix.de>
References: <20210729222543.203905260@linutronix.de>
MIME-Version: 1.0
Message-ID: <162858645885.395.1880441423425826045.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7327cefebb85d440fa6a589fdf53979d55b29a5a
Gitweb:        https://git.kernel.org/tip/7327cefebb85d440fa6a589fdf53979d55b29a5a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 29 Jul 2021 23:51:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 11:03:30 +02:00

PCI/MSI: Cleanup msi_mask()

msi_mask() is calculating the possible mask bits for MSI per vector
masking.

Rename it to msi_multi_mask() and hand the MSI descriptor pointer into it
to simplify the call sites.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210729222543.203905260@linutronix.de

---
 drivers/pci/msi.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 1bde9ec..2eab07b 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -129,14 +129,6 @@ void __weak arch_restore_msi_irqs(struct pci_dev *dev)
 	return default_restore_msi_irqs(dev);
 }
 
-static inline __attribute_const__ u32 msi_mask(unsigned x)
-{
-	/* Don't shift by >= width of type */
-	if (x >= 5)
-		return 0xffffffff;
-	return (1 << (1 << x)) - 1;
-}
-
 /*
  * PCI 2.3 does not specify mask bits for each MSI interrupt.  Attempting to
  * mask all MSI interrupts by clearing the MSI enable bit does not work
@@ -211,6 +203,14 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
 	}
 }
 
+static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
+{
+	/* Don't shift by >= width of type */
+	if (desc->msi_attrib.multi_cap >= 5)
+		return 0xffffffff;
+	return (1 << (1 << desc->msi_attrib.multi_cap)) - 1;
+}
+
 /**
  * pci_msi_mask_irq - Generic IRQ chip callback to mask PCI/MSI interrupts
  * @data:	pointer to irqdata associated to that interrupt
@@ -419,8 +419,7 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 	arch_restore_msi_irqs(dev);
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
-	msi_mask_irq(entry, msi_mask(entry->msi_attrib.multi_cap),
-		     entry->msi_mask);
+	msi_mask_irq(entry, msi_multi_mask(entry), entry->msi_mask);
 	control &= ~PCI_MSI_FLAGS_QSIZE;
 	control |= (entry->msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
@@ -642,7 +641,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 		return -ENOMEM;
 
 	/* All MSIs are unmasked by default; mask them all */
-	mask = msi_mask(entry->msi_attrib.multi_cap);
+	mask = msi_multi_mask(entry);
 	msi_mask_irq(entry, mask, mask);
 
 	list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
@@ -938,7 +937,6 @@ EXPORT_SYMBOL(pci_msi_vec_count);
 static void pci_msi_shutdown(struct pci_dev *dev)
 {
 	struct msi_desc *desc;
-	u32 mask;
 
 	if (!pci_msi_enable || !dev || !dev->msi_enabled)
 		return;
@@ -951,8 +949,7 @@ static void pci_msi_shutdown(struct pci_dev *dev)
 	dev->msi_enabled = 0;
 
 	/* Return the device with MSI unmasked as initial states */
-	mask = msi_mask(desc->msi_attrib.multi_cap);
-	msi_mask_irq(desc, mask, 0);
+	msi_mask_irq(desc, msi_multi_mask(desc), 0);
 
 	/* Restore dev->irq to its default pin-assertion IRQ */
 	dev->irq = desc->msi_attrib.default_irq;
