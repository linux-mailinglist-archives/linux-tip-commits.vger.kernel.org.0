Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6B83E5644
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 11:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbhHJJIL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 05:08:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41880 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbhHJJII (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 05:08:08 -0400
Date:   Tue, 10 Aug 2021 09:07:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628586462;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cTbMwutGVeokiwZy/kjRxaINYULtcx7erFFUBGKwecg=;
        b=VaZNe6MpeKPBwcQd5Zn1qpNW2VETf4aEfp6aRSY+NRG7uCOJPBEDnl/afY95j8yfdRu1Z2
        D+DLaMGXXADn81hQ0CN5qsdVfNS3WRdX7O+DIuE9Ku948cRgugpR9MY7w4+nBj5qjyP9IF
        UpxVcLRJTiJhluPmr4Rt5sxKmer33HJE2EnR4gCQhx1AKxx3JedGJ9rsDiBMReBSudd6WT
        JKh5D0G2nSFO/TuwAl9CjWmI3Bv0r+pRUBeanX5LFWJ1ANHqITTQn90YVbuBWDQpAgK8yx
        Xht0/43mhM8U1Pukv5NJGpX63xGhuuPKjOOfskeqkGfdkOvpUCzzuk8t6NV2Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628586462;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cTbMwutGVeokiwZy/kjRxaINYULtcx7erFFUBGKwecg=;
        b=sd6uPoNWRInjlTy2qzF8KNPTCCWGfKVpvaJo3EKuQrUYC9hdbdOzhVAupXr1htqavRR9ny
        OWdSHQoklLNDZ8Dw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] s390/pci: Do not mask MSI[-X] entries on teardown
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210729222542.939798136@linutronix.de>
References: <20210729222542.939798136@linutronix.de>
MIME-Version: 1.0
Message-ID: <162858646159.395.3903591994413187859.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3998527d2e3ee2bfdf710a45b7b90968ff87babc
Gitweb:        https://git.kernel.org/tip/3998527d2e3ee2bfdf710a45b7b90968ff87babc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 29 Jul 2021 23:51:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 11:03:29 +02:00

s390/pci: Do not mask MSI[-X] entries on teardown

The PCI core already ensures that the MSI[-X] state is correct when MSI[-X]
is disabled. For MSI the reset state is all entries unmasked and for MSI-X
all vectors are masked.

S390 masks all MSI entries and masks the already masked MSI-X entries
again. Remove it and let the device in the correct state.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Tested-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
Link: https://lore.kernel.org/r/20210729222542.939798136@linutronix.de

---
 arch/s390/pci/pci_irq.c | 4 ----
 drivers/pci/msi.c       | 4 ++--
 include/linux/msi.h     | 2 --
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 9c7de90..3823e15 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -365,10 +365,6 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 	for_each_pci_msi_entry(msi, pdev) {
 		if (!msi->irq)
 			continue;
-		if (msi->msi_attrib.is_msix)
-			__pci_msix_desc_mask_irq(msi, 1);
-		else
-			__pci_msi_desc_mask_irq(msi, 1, 1);
 		irq_set_msi_desc(msi->irq, NULL);
 		irq_free_desc(msi->irq);
 		msi->msg.address_lo = 0;
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index e5e7533..95e6ce4 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -143,7 +143,7 @@ static inline __attribute_const__ u32 msi_mask(unsigned x)
  * reliably as devices without an INTx disable bit will then generate a
  * level IRQ which will never be cleared.
  */
-void __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
+static void __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 {
 	raw_spinlock_t *lock = &desc->dev->msi_lock;
 	unsigned long flags;
@@ -180,7 +180,7 @@ static void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
  * file.  This saves a few milliseconds when initialising devices with lots
  * of MSI-X interrupts.
  */
-u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
+static u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
 {
 	u32 mask_bits = desc->masked;
 	void __iomem *desc_addr;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index e8bdcb8..3d0e747 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -232,8 +232,6 @@ void free_msi_entry(struct msi_desc *entry);
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 
-u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag);
-void __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
 
