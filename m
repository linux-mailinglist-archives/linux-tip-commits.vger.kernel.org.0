Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9793D26C581
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 19:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgIPRBT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 13:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgIPRAl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 13:00:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D225DC02C292;
        Wed, 16 Sep 2020 08:20:16 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269141;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTg/YWez9IXSn7cG6G80O6ITDooXZtsmUwYKaTqYOlo=;
        b=uWdiXSmgKPVOhnp6b85VV4ICn1tI6VLASRRNNVqCH/yKoWblU0lYPJD/YjCcjGGI45RY15
        Lh6TmSOFVRzv4odNWH9J5s2WHO8sPG/DrjE6/veJipKJi36qNr3MaM2DLNhd+JywHQse1x
        BcpZxV3pax2r0dvVofSe7zvXL9XQ3FHL7CmujALZnBPRY9pxHzV8NlpsRe99LVcm4PT1xE
        m2WfBz2q+yo/fjTbIVt5VQH0smkuPuMGz5/DvFoSsmUjAIXJr9yq5QlgrW/DAGoMzCSYQY
        3DdTTZqIcpD/4FJy2wx/xfHfuu6vn64+RDnhGqSQURlxyqRMcr7JOsMQW6JklQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269141;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTg/YWez9IXSn7cG6G80O6ITDooXZtsmUwYKaTqYOlo=;
        b=lxYIYcquLqUKjdaPfph26ntuO974ze23MBvagbgh2izXNKvdtijaWolBMrCZQLFux3exiu
        S9WvzzzBZG8IN9Cw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/msi: Consolidate HPET allocation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <jroedel@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112331.943993771@linutronix.de>
References: <20200826112331.943993771@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026914100.15536.14781063006916517529.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     2bf1e7bcedb8802cb4fc65757b229edfe112a4bb
Gitweb:        https://git.kernel.org/tip/2bf1e7bcedb8802cb4fc65757b229edfe112a4bb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:31 +02:00

x86/msi: Consolidate HPET allocation

None of the magic HPET fields are required in any way.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200826112331.943993771@linutronix.de
---
 arch/x86/include/asm/hw_irq.h       |  7 -------
 arch/x86/kernel/apic/msi.c          | 14 +++++++-------
 drivers/iommu/amd/iommu.c           |  2 +-
 drivers/iommu/intel/irq_remapping.c |  4 ++--
 4 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index b0e15f6..2d39e61 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -65,13 +65,6 @@ struct irq_alloc_info {
 
 	union {
 		int		unused;
-#ifdef	CONFIG_HPET_TIMER
-		struct {
-			int		hpet_id;
-			int		hpet_index;
-			void		*hpet_data;
-		};
-#endif
 #ifdef	CONFIG_PCI_MSI
 		struct {
 			struct pci_dev	*msi_dev;
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 9edb1bb..da68d08 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -423,7 +423,7 @@ static struct irq_chip hpet_msi_controller __ro_after_init = {
 static irq_hw_number_t hpet_msi_get_hwirq(struct msi_domain_info *info,
 					  msi_alloc_info_t *arg)
 {
-	return arg->hpet_index;
+	return arg->hwirq;
 }
 
 static int hpet_msi_init(struct irq_domain *domain,
@@ -431,8 +431,8 @@ static int hpet_msi_init(struct irq_domain *domain,
 			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
 {
 	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
-	irq_domain_set_info(domain, virq, arg->hpet_index, info->chip, NULL,
-			    handle_edge_irq, arg->hpet_data, "edge");
+	irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
+			    handle_edge_irq, arg->data, "edge");
 
 	return 0;
 }
@@ -473,7 +473,7 @@ struct irq_domain *hpet_create_irq_domain(int hpet_id)
 
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT;
-	info.hpet_id = hpet_id;
+	info.devid = hpet_id;
 	parent = irq_remapping_get_irq_domain(&info);
 	if (parent == NULL)
 		parent = x86_vector_domain;
@@ -502,9 +502,9 @@ int hpet_assign_irq(struct irq_domain *domain, struct hpet_channel *hc,
 
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_HPET;
-	info.hpet_data = hc;
-	info.hpet_id = hpet_dev_id(domain);
-	info.hpet_index = dev_num;
+	info.data = hc;
+	info.devid = hpet_dev_id(domain);
+	info.hwirq = dev_num;
 
 	return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 18b4dfb..a308472 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3525,7 +3525,7 @@ static int get_devid(struct irq_alloc_info *info)
 		return get_ioapic_devid(info->ioapic_id);
 	case X86_IRQ_ALLOC_TYPE_HPET:
 	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
-		return get_hpet_devid(info->hpet_id);
+		return get_hpet_devid(info->devid);
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
 		return get_device_id(&info->msi_dev->dev);
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 0289a78..58c2d7a 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1121,7 +1121,7 @@ static struct irq_domain *intel_get_irq_domain(struct irq_alloc_info *info)
 	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
 		return map_ioapic_to_ir(info->ioapic_id);
 	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
-		return map_hpet_to_ir(info->hpet_id);
+		return map_hpet_to_ir(info->devid);
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
 		return map_dev_to_ir(info->msi_dev);
@@ -1291,7 +1291,7 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
 		if (info->type == X86_IRQ_ALLOC_TYPE_HPET)
-			set_hpet_sid(irte, info->hpet_id);
+			set_hpet_sid(irte, info->devid);
 		else
 			set_msi_sid(irte, info->msi_dev);
 
