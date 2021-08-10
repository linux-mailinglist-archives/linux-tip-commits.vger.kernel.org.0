Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B6F3E563A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 11:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbhHJJIE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 05:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238568AbhHJJID (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 05:08:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DA8C0613D3;
        Tue, 10 Aug 2021 02:07:41 -0700 (PDT)
Date:   Tue, 10 Aug 2021 09:07:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628586459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y7DhnaVpzSsT1jEXwDEfuJb1LM25ib/9ArHyci/UAZg=;
        b=FXsqYhktf/vvQzHG7IiktQic/BBFaDHiCFniaDRlTEy5+DJ57iS3ojClzO9OdDHWHP+670
        aB1U0W8tnWlqHriqmWricUjNLkDV78EvLHZGmLh1Ir6OR0n1D0D4WhmX4ZjGUvjTwXVmk4
        1IRpkB2rH5Qap+C5+X8k/r/kbdrkMSB1ISyBmVeKqIOBs5Qf02z2Fpj7w9Z7wPGod95SJj
        sq/wWk++CB68dke6FwU3sjx3is4XgLTYTeaWjunY6eyn+hHiFpO5PNfWqYuGPhv67Cun20
        G8gCRuu456opsHdVzmxJlQJOcrd/x2CYeSCvGeacj76ZB8YhAEFycV684rfN/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628586459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y7DhnaVpzSsT1jEXwDEfuJb1LM25ib/9ArHyci/UAZg=;
        b=jSOIbjO9gnMpzwJgc52yPPcRI7HXlgqo4U1wMWBelDIHMCTVvB0IRHETBjbkc834+YM0N1
        D0+rfJ+aleGzrnCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Provide a new set of mask and unmask functions
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <875ywetozb.ffs@tglx>
References: <875ywetozb.ffs@tglx>
MIME-Version: 1.0
Message-ID: <162858645831.395.5316214077115267914.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fcacdfbef5a1633211ebfac1b669a7739f5b553e
Gitweb:        https://git.kernel.org/tip/fcacdfbef5a1633211ebfac1b669a7739f5b553e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 09 Aug 2021 21:08:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 11:03:30 +02:00

PCI/MSI: Provide a new set of mask and unmask functions

The existing mask/unmask functions are convoluted and generate suboptimal
assembly code.

Provide a new set of functions which will be used in later patches to
replace the exisiting ones.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/875ywetozb.ffs@tglx
---
 drivers/pci/msi.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 2eab07b..26dd91f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -211,6 +211,78 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
 	return (1 << (1 << desc->msi_attrib.multi_cap)) - 1;
 }
 
+static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
+{
+	raw_spinlock_t *lock = &desc->dev->msi_lock;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(lock, flags);
+	desc->msi_mask &= ~clear;
+	desc->msi_mask |= set;
+	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->mask_pos,
+			       desc->msi_mask);
+	raw_spin_unlock_irqrestore(lock, flags);
+}
+
+static inline void pci_msi_mask(struct msi_desc *desc, u32 mask)
+{
+	pci_msi_update_mask(desc, 0, mask);
+}
+
+static inline void pci_msi_unmask(struct msi_desc *desc, u32 mask)
+{
+	pci_msi_update_mask(desc, mask, 0);
+}
+
+/*
+ * This internal function does not flush PCI writes to the device.  All
+ * users must ensure that they read from the device before either assuming
+ * that the device state is up to date, or returning out of this file.
+ * It does not affect the msi_desc::msix_ctrl cache either. Use with care!
+ */
+static void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
+{
+	void __iomem *desc_addr = pci_msix_desc_addr(desc);
+
+	writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+}
+
+static inline void pci_msix_mask(struct msi_desc *desc)
+{
+	desc->msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	pci_msix_write_vector_ctrl(desc, desc->msix_ctrl);
+	/* Flush write to device */
+	readl(desc->mask_base);
+}
+
+static inline void pci_msix_unmask(struct msi_desc *desc)
+{
+	desc->msix_ctrl &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	pci_msix_write_vector_ctrl(desc, desc->msix_ctrl);
+}
+
+static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
+{
+	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
+		return;
+
+	if (desc->msi_attrib.is_msix)
+		pci_msix_mask(desc);
+	else if (desc->msi_attrib.maskbit)
+		pci_msi_mask(desc, mask);
+}
+
+static void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
+{
+	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
+		return;
+
+	if (desc->msi_attrib.is_msix)
+		pci_msix_unmask(desc);
+	else if (desc->msi_attrib.maskbit)
+		pci_msi_unmask(desc, mask);
+}
+
 /**
  * pci_msi_mask_irq - Generic IRQ chip callback to mask PCI/MSI interrupts
  * @data:	pointer to irqdata associated to that interrupt
