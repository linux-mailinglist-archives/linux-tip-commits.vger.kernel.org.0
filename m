Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481EF26CDDA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 23:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgIPVGK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 17:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgIPQOy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B6FC02C289;
        Wed, 16 Sep 2020 08:17:18 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uLOb488cXYQLwnqIp0C8qijyqQA83ckJsa1xJCnQAd4=;
        b=Q55zcISUqgykd0j4Uuq7Tic4DvYC75T2Tey2FRsA957qxxnscS84eQgL0NeMZtZQamKTLq
        MNITPKL9uSz5ItDvSKVQuJQD3M8fBrtPuzFveSR2zY2XqXsuFGg0XOIyYHeThTFgAbgMat
        GNo7trp/3YuuMCdnHxCe4Kqb4quGYLDP2LjWRqp8Pol3hY3lH/24EFJIsdu+TsYrM65JJ8
        oBNZvqcY4vrn+FdSkhx/DbHO0MMu1Qsd98Athsanc23iWSAhf/5G5ObuVE+I2d8PWZPj9t
        adL0+TuUigUyFBYiWpRPuoGjV1QP6oTcvn33X+vd55DB9UPH5DMdw8vYoNIb+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uLOb488cXYQLwnqIp0C8qijyqQA83ckJsa1xJCnQAd4=;
        b=FEDN1dtp67ZflDM8QUfruvYaexAlwIIXr28oClQghPEq53QzF5kahW0AfcGarg7cL4jx0J
        JEGMBXTvEm6qxgAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] iommu/amd: Consolidate irq domain getter
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <jroedel@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112331.634777249@linutronix.de>
References: <20200826112331.634777249@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026914313.15536.11301018807345186226.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     192a99f4bd9d1d546ca276e058761a79af575744
Gitweb:        https://git.kernel.org/tip/192a99f4bd9d1d546ca276e058761a79af575744
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:38 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:29 +02:00

iommu/amd: Consolidate irq domain getter

The irq domain request mode is now indicated in irq_alloc_info::type.

Consolidate the two getter functions into one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200826112331.634777249@linutronix.de
---
 drivers/iommu/amd/iommu.c | 65 ++++++++++++--------------------------
 1 file changed, 21 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b98b0ab..4d4045a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3519,77 +3519,54 @@ static void irte_ga_clear_allocated(struct irq_remap_table *table, int index)
 
 static int get_devid(struct irq_alloc_info *info)
 {
-	int devid = -1;
-
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
-		devid     = get_ioapic_devid(info->ioapic_id);
-		break;
+	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
+		return get_ioapic_devid(info->ioapic_id);
 	case X86_IRQ_ALLOC_TYPE_HPET:
-		devid     = get_hpet_devid(info->hpet_id);
-		break;
+	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
+		return get_hpet_devid(info->hpet_id);
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		devid = get_device_id(&info->msi_dev->dev);
-		break;
+		return get_device_id(&info->msi_dev->dev);
 	default:
-		BUG_ON(1);
-		break;
+		WARN_ON_ONCE(1);
+		return -1;
 	}
-
-	return devid;
 }
 
-static struct irq_domain *get_ir_irq_domain(struct irq_alloc_info *info)
+static struct irq_domain *get_irq_domain_for_devid(struct irq_alloc_info *info,
+						   int devid)
 {
-	struct amd_iommu *iommu;
-	int devid;
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
 
-	if (!info)
+	if (!iommu)
 		return NULL;
 
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
 	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
-		break;
+		return iommu->ir_domain;
+	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
+		return iommu->msi_domain;
 	default:
+		WARN_ON_ONCE(1);
 		return NULL;
 	}
-
-	devid = get_devid(info);
-	if (devid >= 0) {
-		iommu = amd_iommu_rlookup_table[devid];
-		if (iommu)
-			return iommu->ir_domain;
-	}
-
-	return NULL;
 }
 
 static struct irq_domain *get_irq_domain(struct irq_alloc_info *info)
 {
-	struct amd_iommu *iommu;
 	int devid;
 
 	if (!info)
 		return NULL;
 
-	switch (info->type) {
-	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
-	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		devid = get_device_id(&info->msi_dev->dev);
-		if (devid < 0)
-			return NULL;
-
-		iommu = amd_iommu_rlookup_table[devid];
-		if (iommu)
-			return iommu->msi_domain;
-		break;
-	default:
-		break;
-	}
-
-	return NULL;
+	devid = get_devid(info);
+	if (devid < 0)
+		return NULL;
+	return get_irq_domain_for_devid(info, devid);
 }
 
 struct irq_remap_ops amd_iommu_irq_ops = {
@@ -3598,7 +3575,7 @@ struct irq_remap_ops amd_iommu_irq_ops = {
 	.disable		= amd_iommu_disable,
 	.reenable		= amd_iommu_reenable,
 	.enable_faulting	= amd_iommu_enable_faulting,
-	.get_ir_irq_domain	= get_ir_irq_domain,
+	.get_ir_irq_domain	= get_irq_domain,
 	.get_irq_domain		= get_irq_domain,
 };
 
