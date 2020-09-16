Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C574026CC58
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 22:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgIPUm5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 16:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgIPREy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 13:04:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD95EC02C290;
        Wed, 16 Sep 2020 08:20:16 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wSsZXmKv4DJ586+JYta5mfBw9RA/hpHKHNH982hvl6M=;
        b=vKduTr/VcyIAHeqbgaNm0bZrhwY53gy2HyMChlx27qN8U+IxzWkXYbyM397j+97V2E+Mq0
        83yLRKV8UU/+Qy22jyLyqEaeyDzYuEG3tAAN9sn38D5EOqI+Lcd2MUPyqaH5Utok3ZZgrZ
        YQdeO/uX521oiJL0BHTwasRbSQJbTfowH3DPLps0NYydcirUrvHcIbFz3YyzX9ZL9+xdR4
        iz/4DMTuJNcAj14vrRwzwSPG/DjVVkq8xJxxJZGx67noi0t1jaY+J4BzB1WM49/IBej4Vb
        T3/J3wOvPPo/OZ4SVC68DKb2/165UIV651/63YCz63OSVol3Z0wwWfUvwQn6HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wSsZXmKv4DJ586+JYta5mfBw9RA/hpHKHNH982hvl6M=;
        b=Z7UIEcEJdZlAA7WFpDD5EwvKm6lNznJmCOWk0f1FWMX4B+FcjeqhFGgg6fdDryg8HNUX46
        lqlNXIPoJE7VIvBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] PCI/MSI: Rework pci_msi_domain_calc_hwirq()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112332.352583299@linutronix.de>
References: <20200826112332.352583299@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026913811.15536.12878064625759253751.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     dfb9eb7cf6cd0c0b0f2a1111fcc47b0a297b097d
Gitweb:        https://git.kernel.org/tip/dfb9eb7cf6cd0c0b0f2a1111fcc47b0a297b097d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:45 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:34 +02:00

PCI/MSI: Rework pci_msi_domain_calc_hwirq()

Retrieve the PCI device from the msi descriptor instead of doing so at the
call sites.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200826112332.352583299@linutronix.de

---
 arch/x86/kernel/apic/msi.c |  2 +-
 drivers/pci/msi.c          |  9 ++++-----
 include/linux/msi.h        |  3 +--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index ebf57db..6d7655b 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -231,7 +231,7 @@ EXPORT_SYMBOL_GPL(pci_msi_prepare);
 
 void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
 {
-	arg->msi_hwirq = pci_msi_domain_calc_hwirq(arg->msi_dev, desc);
+	arg->msi_hwirq = pci_msi_domain_calc_hwirq(desc);
 }
 EXPORT_SYMBOL_GPL(pci_msi_set_desc);
 
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 30ae4ff..9af58a2 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1346,14 +1346,14 @@ void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
 
 /**
  * pci_msi_domain_calc_hwirq - Generate a unique ID for an MSI source
- * @dev:	Pointer to the PCI device
  * @desc:	Pointer to the MSI descriptor
  *
  * The ID number is only used within the irqdomain.
  */
-irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
-					  struct msi_desc *desc)
+irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
 {
+	struct pci_dev *dev = msi_desc_to_pci_dev(desc);
+
 	return (irq_hw_number_t)desc->msi_attrib.entry_nr |
 		pci_dev_id(dev) << 11 |
 		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
@@ -1406,8 +1406,7 @@ static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
 				    struct msi_desc *desc)
 {
 	arg->desc = desc;
-	arg->hwirq = pci_msi_domain_calc_hwirq(msi_desc_to_pci_dev(desc),
-					       desc);
+	arg->hwirq = pci_msi_domain_calc_hwirq(desc);
 }
 #else
 #define pci_msi_domain_set_desc		NULL
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8ad679e..d360cc7 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -369,8 +369,7 @@ void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg);
 struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);
-irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
-					  struct msi_desc *desc);
+irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc);
 int pci_msi_domain_check_cap(struct irq_domain *domain,
 			     struct msi_domain_info *info, struct device *dev);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
