Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBC826C457
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 17:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgIPPhh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 11:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgIPPa3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 11:30:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DB5C02C297;
        Wed, 16 Sep 2020 08:20:16 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNQQ+weTsOhTxGscMKJcGAGkUigmfTPjARgrh4O+rpU=;
        b=LvkaKFDr4B6ai9WHuQ1MjtZqyPLS7xN7Zk16FKElbnho6B3DSe3UiewZz+F+Km0zIfiS8c
        r6BT32g990XEo25TNd+aMuM1d8nrc4MWRw+S6cLhTyo/Cc5LbclnOLmaprrujwhW/R8DvV
        305ZacQECa7G4MfS5v/DyCr0gZ+JroFXlierCf84nesomBA+jBHE5WmgGf79mYd9Lu0bmd
        AZLaIEUeH8HcMXDrUXiZDTxuYqwLLApn2q3hzWF3k4II6NcuwGSdXWRKbcR/FB2zKsuR56
        8SmBwkvwGG72aBLfVZ7PpHdkVRkKMTbIdj7vxqhcyHCr392XJFJLBtnVQVLQ7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNQQ+weTsOhTxGscMKJcGAGkUigmfTPjARgrh4O+rpU=;
        b=BNGJaG0lr6YK1URf4ekX8fHzFgdbjh1swfPngLRzUSnPpm3YU9EHBMTnG+9NSQKOBzG01o
        820XUsrhzgZdukCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/msi: Consolidate MSI allocation
Cc:     Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112332.466405395@linutronix.de>
References: <20200826112332.466405395@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026913739.15536.6275942744489847917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     3b9c1d377d67072d1d8a2373b4969103cca00dab
Gitweb:        https://git.kernel.org/tip/3b9c1d377d67072d1d8a2373b4969103cca00dab
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:35 +02:00

x86/msi: Consolidate MSI allocation

Convert the interrupt remap drivers to retrieve the pci device from the msi
descriptor and use info::hwirq.

This is the first step to prepare x86 for using the generic MSI domain ops.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Wei Liu <wei.liu@kernel.org>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200826112332.466405395@linutronix.de

---
 arch/x86/include/asm/hw_irq.h       | 8 --------
 arch/x86/kernel/apic/msi.c          | 7 +++----
 drivers/iommu/amd/iommu.c           | 5 +++--
 drivers/iommu/intel/irq_remapping.c | 4 ++--
 drivers/pci/controller/pci-hyperv.c | 2 +-
 5 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index dd0b479..a4aeeaa 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -86,14 +86,6 @@ struct irq_alloc_info {
 	union {
 		struct ioapic_alloc_info	ioapic;
 		struct uv_alloc_info		uv;
-
-		int		unused;
-#ifdef	CONFIG_PCI_MSI
-		struct {
-			struct pci_dev	*msi_dev;
-			irq_hw_number_t	msi_hwirq;
-		};
-#endif
 	};
 };
 
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 6d7655b..6b490d9 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -188,7 +188,6 @@ int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
-	info.msi_dev = dev;
 
 	domain = irq_remapping_get_irq_domain(&info);
 	if (domain == NULL)
@@ -207,7 +206,7 @@ void native_teardown_msi_irq(unsigned int irq)
 static irq_hw_number_t pci_msi_get_hwirq(struct msi_domain_info *info,
 					 msi_alloc_info_t *arg)
 {
-	return arg->msi_hwirq;
+	return arg->hwirq;
 }
 
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
@@ -217,7 +216,6 @@ int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 	struct msi_desc *desc = first_pci_msi_entry(pdev);
 
 	init_irq_alloc_info(arg, NULL);
-	arg->msi_dev = pdev;
 	if (desc->msi_attrib.is_msix) {
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
 	} else {
@@ -231,7 +229,8 @@ EXPORT_SYMBOL_GPL(pci_msi_prepare);
 
 void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
 {
-	arg->msi_hwirq = pci_msi_domain_calc_hwirq(desc);
+	arg->desc = desc;
+	arg->hwirq = pci_msi_domain_calc_hwirq(desc);
 }
 EXPORT_SYMBOL_GPL(pci_msi_set_desc);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8183a71..bc7bb4c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3528,7 +3528,7 @@ static int get_devid(struct irq_alloc_info *info)
 		return get_hpet_devid(info->devid);
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		return get_device_id(&info->msi_dev->dev);
+		return get_device_id(msi_desc_to_dev(info->desc));
 	default:
 		WARN_ON_ONCE(1);
 		return -1;
@@ -3702,7 +3702,8 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		   info->type == X86_IRQ_ALLOC_TYPE_PCI_MSIX) {
 		bool align = (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI);
 
-		index = alloc_irq_index(devid, nr_irqs, align, info->msi_dev);
+		index = alloc_irq_index(devid, nr_irqs, align,
+					msi_desc_to_pci_dev(info->desc));
 	} else {
 		index = alloc_irq_index(devid, nr_irqs, false, NULL);
 	}
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 90ba70d..d9db2f3 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1124,7 +1124,7 @@ static struct irq_domain *intel_get_irq_domain(struct irq_alloc_info *info)
 		return map_hpet_to_ir(info->devid);
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		return map_dev_to_ir(info->msi_dev);
+		return map_dev_to_ir(msi_desc_to_pci_dev(info->desc));
 	default:
 		WARN_ON_ONCE(1);
 		return NULL;
@@ -1293,7 +1293,7 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 		if (info->type == X86_IRQ_ALLOC_TYPE_HPET)
 			set_hpet_sid(irte, info->devid);
 		else
-			set_msi_sid(irte, info->msi_dev);
+			set_msi_sid(irte, msi_desc_to_pci_dev(info->desc));
 
 		msg->address_hi = MSI_ADDR_BASE_HI;
 		msg->data = sub_handle;
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index fc4c3a1..f6cc49b 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1534,7 +1534,7 @@ static struct irq_chip hv_msi_irq_chip = {
 static irq_hw_number_t hv_msi_domain_ops_get_hwirq(struct msi_domain_info *info,
 						   msi_alloc_info_t *arg)
 {
-	return arg->msi_hwirq;
+	return arg->hwirq;
 }
 
 static struct msi_domain_ops hv_msi_ops = {
