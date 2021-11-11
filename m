Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C85744D398
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Nov 2021 09:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhKKJAj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Nov 2021 04:00:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48242 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhKKJAj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Nov 2021 04:00:39 -0500
Date:   Thu, 11 Nov 2021 08:57:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636621069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpX/3iqutdNuUNqUMiECHDN//GDq1RD6twpCEPyzJp8=;
        b=x6H3MkhkooIzwwxy82RZ8ilAqUGbjDjelHi1C8u55gLrzoxR006t9jLnrDMrmZzZQfcwyJ
        7GUx1hIoZVTIdp4CEVV51w5K3ZBgigVU+VaXwVC3exLH50kY6tYTqv2K9I0zQulN1M3emI
        TKnA4XOxPshsSpK0fRragVMmOHEPKhlTipajoiaWfAF0NBmtQyRM/4YBDC1G9KA4eX9HDr
        YfIzhJmuJyqkWJG77dpPLVCUVipcQ6cxFwoy48OuQCPrTKnAIGVgboCM6rspjv7khvhqVN
        PQ1auRujvcRcYMVYnE72/MTsi2x6VGwoXlvDbt3kjYtODCFzYu2WabWWDK+GRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636621069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpX/3iqutdNuUNqUMiECHDN//GDq1RD6twpCEPyzJp8=;
        b=d8qauZklk61n6DfUauYs0hiGPfcE5bqJT6FxRDioNukdcQvKWZUBk4HMzQPFP7RFGdA65u
        3TzPMoiudcLgpSCQ==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] PCI/MSI: Deal with devices lying about their MSI
 mask capability
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211104180130.3825416-2-maz@kernel.org>
References: <20211104180130.3825416-2-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163662106820.414.5840196207952256721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     2226667a145db2e1f314d7f57fd644fe69863ab9
Gitweb:        https://git.kernel.org/tip/2226667a145db2e1f314d7f57fd644fe69863ab9
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 04 Nov 2021 18:01:29 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 11 Nov 2021 09:50:30 +01:00

PCI/MSI: Deal with devices lying about their MSI mask capability

It appears that some devices are lying about their mask capability,
pretending that they don't have it, while they actually do.
The net result is that now that we don't enable MSIs on such
endpoint.

Add a new per-device flag to deal with this. Further patches will
make use of it, sadly.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20211104180130.3825416-2-maz@kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>
---
 drivers/pci/msi.c   | 3 +++
 include/linux/pci.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 6da7910..7043301 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -477,6 +477,9 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 		goto out;
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
+	/* Lies, damned lies, and MSIs */
+	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
+		control |= PCI_MSI_FLAGS_MASKBIT;
 
 	entry->msi_attrib.is_msix	= 0;
 	entry->msi_attrib.is_64		= !!(control & PCI_MSI_FLAGS_64BIT);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c8afbee..d0dba7f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -233,6 +233,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
 	/* Don't use Relaxed Ordering for TLPs directed at this device */
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
+	/* Device does honor MSI masking despite saying otherwise */
+	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
 };
 
 enum pci_irq_reroute_variant {
