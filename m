Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56B23E5639
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 11:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbhHJJIG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 05:08:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41874 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbhHJJIF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 05:08:05 -0400
Date:   Tue, 10 Aug 2021 09:07:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628586461;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/OGv2fXwEoDW6ys3FbnQN0NNzxFGIbwzT8Z35jIu8yI=;
        b=wxnHjfVdEHtYzP0mnIp6hzuClMnV4iFfCQM1WpAhgOE/dG1Vd7I4TECjU58hCswAMM2y0L
        fWQkHX2DJgg8psoW0uvd9BxGHI6+Y+qycTjR1Z51LTixVEddTbgQhmuglFOZLp2Qbp1wVf
        BL1hCGCROvHb12IpkedMsAKzOMYD7joCAjDQAwcilRhpR8NRUPK/N0wFT0maALKp1bnnyU
        guhxiINzg+mMBtxjkoXyBBILa/nrvM0WFQVOE05W3PqXXJhLHwTQN3Wf/48YRzPkYzVl4q
        lOjD9bf1s22wMRdBaRXT90lAR32pcRInvNYFvBd/UkVCIBur7ik/Bfi8PSBBSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628586461;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/OGv2fXwEoDW6ys3FbnQN0NNzxFGIbwzT8Z35jIu8yI=;
        b=TuqeF4HNkHMXvtLWcT843HUkfy+9q3YstieAd/oNSTS0tRL/yABWoaoO6C8CxkSPBJSTPp
        KmtSJp6lRVcaBQCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Rename msi_desc::masked
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210729222543.045993608@linutronix.de>
References: <20210729222543.045993608@linutronix.de>
MIME-Version: 1.0
Message-ID: <162858646048.395.1675569114537900488.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     67961e77a39b8e975dd1906179b9224f29150357
Gitweb:        https://git.kernel.org/tip/67961e77a39b8e975dd1906179b9224f29150357
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 29 Jul 2021 23:51:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 11:03:29 +02:00

PCI/MSI: Rename msi_desc::masked

msi_desc::masked is a misnomer. For MSI it's used to cache the MSI mask
bits when the device supports per vector masking. For MSI-X it's used to
cache the content of the vector control word which contains the mask bit
for the vector.

Replace it with a union of msi_mask and msix_ctrl to make the purpose clear
and fix up the usage sites.

No functional change

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210729222543.045993608@linutronix.de

---
 drivers/pci/msi.c   | 30 +++++++++++++++---------------
 include/linux/msi.h |  8 ++++++--
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index b59957c..175f4d6 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -152,10 +152,10 @@ static void __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 		return;
 
 	raw_spin_lock_irqsave(lock, flags);
-	desc->masked &= ~mask;
-	desc->masked |= flag;
+	desc->msi_mask &= ~mask;
+	desc->msi_mask |= flag;
 	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->mask_pos,
-			       desc->masked);
+			       desc->msi_mask);
 	raw_spin_unlock_irqrestore(lock, flags);
 }
 
@@ -182,7 +182,7 @@ static void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
  */
 static u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
 {
-	u32 mask_bits = desc->masked;
+	u32 ctrl = desc->msix_ctrl;
 	void __iomem *desc_addr;
 
 	if (pci_msi_ignore_mask)
@@ -192,18 +192,18 @@ static u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
 	if (!desc_addr)
 		return 0;
 
-	mask_bits &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
-	if (flag & PCI_MSIX_ENTRY_CTRL_MASKBIT)
-		mask_bits |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	ctrl &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	if (ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT)
+		ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
 
-	writel(mask_bits, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+	writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 
-	return mask_bits;
+	return ctrl;
 }
 
 static void msix_mask_irq(struct msi_desc *desc, u32 flag)
 {
-	desc->masked = __pci_msix_desc_mask_irq(desc, flag);
+	desc->msix_ctrl = __pci_msix_desc_mask_irq(desc, flag);
 }
 
 static void msi_set_mask_bit(struct irq_data *data, u32 flag)
@@ -290,7 +290,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 		/* Don't touch the hardware now */
 	} else if (entry->msi_attrib.is_msix) {
 		void __iomem *base = pci_msix_desc_addr(entry);
-		bool unmasked = !(entry->masked & PCI_MSIX_ENTRY_CTRL_MASKBIT);
+		bool unmasked = !(entry->msix_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
 
 		if (!base)
 			goto skip;
@@ -430,7 +430,7 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
 	msi_mask_irq(entry, msi_mask(entry->msi_attrib.multi_cap),
-		     entry->masked);
+		     entry->msi_mask);
 	control &= ~PCI_MSI_FLAGS_QSIZE;
 	control |= (entry->msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
@@ -461,7 +461,7 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 
 	arch_restore_msi_irqs(dev);
 	for_each_pci_msi_entry(entry, dev)
-		msix_mask_irq(entry, entry->masked);
+		msix_mask_irq(entry, entry->msix_ctrl);
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
@@ -602,7 +602,7 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 
 	/* Save the initial mask status */
 	if (entry->msi_attrib.maskbit)
-		pci_read_config_dword(dev, entry->mask_pos, &entry->masked);
+		pci_read_config_dword(dev, entry->mask_pos, &entry->msi_mask);
 
 out:
 	kfree(masks);
@@ -750,7 +750,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 
 		addr = pci_msix_desc_addr(entry);
 		if (addr)
-			entry->masked = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+			entry->msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 
 		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
 		if (masks)
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 3d0e747..a20dc66 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -107,7 +107,8 @@ struct ti_sci_inta_msi_desc {
  *			address or data changes
  * @write_msi_msg_data:	Data parameter for the callback.
  *
- * @masked:	[PCI MSI/X] Mask bits
+ * @msi_mask:	[PCI MSI]   MSI cached mask bits
+ * @msix_ctrl:	[PCI MSI-X] MSI-X cached per vector control bits
  * @is_msix:	[PCI MSI/X] True if MSI-X
  * @multiple:	[PCI MSI/X] log2 num of messages allocated
  * @multi_cap:	[PCI MSI/X] log2 num of messages supported
@@ -139,7 +140,10 @@ struct msi_desc {
 	union {
 		/* PCI MSI/X specific data */
 		struct {
-			u32 masked;
+			union {
+				u32 msi_mask;
+				u32 msix_ctrl;
+			};
 			struct {
 				u8	is_msix		: 1;
 				u8	multiple	: 3;
