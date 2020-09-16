Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B2326C497
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 17:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgIPPuZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 11:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgIPP2v (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 11:28:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BFDC02C28A;
        Wed, 16 Sep 2020 08:17:18 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269145;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rW0q3pgqcygaiLdb2Ww7tZ+fu+C22PaxPKJYrTUxjMY=;
        b=oYe3sZQzaTisEYRig7tXDXMy6j+u8WcDRCGDmuQXgpVkxzRjL54Ir3il86MaE2LhQYoHrq
        wht2/q5nj4joNEbUsl8DvcH4Pqcd2t+MK4jvLS/XRjbAwsp6+Bg/+Gp+3Nb+kSoHikjUHb
        uU902hDt7LoEZxPIxC+Nw0BpEfKHM/T6ikGXbS/VdOcY92Q6VZEqWrY/RlzQS6ck0/IzHL
        O5Ox6JMEMSwaET+Wd4D6nd7pykPzh9If4/gvEA3U9t8qR/HcIqDOZgxT30Jfqxfm8F44tz
        iO2SQBz0iCQBMk6VaRlPIp/tJ/gcjQ46XR3SsT+nqDhdI3is8HhTJiWxCndS5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269145;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rW0q3pgqcygaiLdb2Ww7tZ+fu+C22PaxPKJYrTUxjMY=;
        b=vYft43ApnAmi3sP8i4n1pa0T/MN+OOkZIFvF3p1GMF+olT3Jw2YthtXJLNyyrDa0GQjjCK
        6kvZG6xOGp6Or9AA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Add allocation type for parent domain retrieval
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <jroedel@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112331.436350257@linutronix.de>
References: <20200826112331.436350257@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026914454.15536.10889063727643231215.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     b4c364da32cf3b85297648ff5563de2c47d9e32f
Gitweb:        https://git.kernel.org/tip/b4c364da32cf3b85297648ff5563de2c47d9e32f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:29 +02:00

x86/irq: Add allocation type for parent domain retrieval

irq_remapping_ir_irq_domain() is used to retrieve the remapping parent
domain for an allocation type. irq_remapping_irq_domain() is for retrieving
the actual device domain for allocating interrupts for a device.

The two functions are similar and can be unified by using explicit modes
for parent irq domain retrieval.

Add X86_IRQ_ALLOC_TYPE_IOAPIC/HPET_GET_PARENT and use it in the iommu
implementations. Drop the parent domain retrieval for PCI_MSI/X as that is
unused.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200826112331.436350257@linutronix.de

---
 arch/x86/include/asm/hw_irq.h       | 2 ++
 arch/x86/kernel/apic/io_apic.c      | 2 +-
 arch/x86/kernel/apic/msi.c          | 2 +-
 drivers/iommu/amd/iommu.c           | 8 ++++++++
 drivers/iommu/hyperv-iommu.c        | 2 +-
 drivers/iommu/intel/irq_remapping.c | 8 ++------
 6 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 3982a1e..91b064d 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -40,6 +40,8 @@ enum irq_alloc_type {
 	X86_IRQ_ALLOC_TYPE_PCI_MSIX,
 	X86_IRQ_ALLOC_TYPE_DMAR,
 	X86_IRQ_ALLOC_TYPE_UV,
+	X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT,
+	X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT,
 };
 
 struct irq_alloc_info {
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 779a89e..be01bb6 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2296,7 +2296,7 @@ static int mp_irqdomain_create(int ioapic)
 		return 0;
 
 	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_IOAPIC;
+	info.type = X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT;
 	info.ioapic_id = mpc_ioapic_id(ioapic);
 	parent = irq_remapping_get_ir_irq_domain(&info);
 	if (!parent)
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 7410d34..421c016 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -472,7 +472,7 @@ struct irq_domain *hpet_create_irq_domain(int hpet_id)
 	domain_info->data = (void *)(long)hpet_id;
 
 	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_HPET;
+	info.type = X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT;
 	info.hpet_id = hpet_id;
 	parent = irq_remapping_get_ir_irq_domain(&info);
 	if (parent == NULL)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cf26b73..b98b0ab 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3548,6 +3548,14 @@ static struct irq_domain *get_ir_irq_domain(struct irq_alloc_info *info)
 	if (!info)
 		return NULL;
 
+	switch (info->type) {
+	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
+	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
+		break;
+	default:
+		return NULL;
+	}
+
 	devid = get_devid(info);
 	if (devid >= 0) {
 		iommu = amd_iommu_rlookup_table[devid];
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 8919c1c..e7bee11 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -184,7 +184,7 @@ static int __init hyperv_enable_irq_remapping(void)
 
 static struct irq_domain *hyperv_get_ir_irq_domain(struct irq_alloc_info *info)
 {
-	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC)
+	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT)
 		return ioapic_ir_domain;
 	else
 		return NULL;
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 33c4389..9b15cd0 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1115,16 +1115,12 @@ static struct irq_domain *intel_get_ir_irq_domain(struct irq_alloc_info *info)
 		return NULL;
 
 	switch (info->type) {
-	case X86_IRQ_ALLOC_TYPE_IOAPIC:
+	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
 		iommu = map_ioapic_to_ir(info->ioapic_id);
 		break;
-	case X86_IRQ_ALLOC_TYPE_HPET:
+	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
 		iommu = map_hpet_to_ir(info->hpet_id);
 		break;
-	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
-	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		iommu = map_dev_to_ir(info->msi_dev);
-		break;
 	default:
 		BUG_ON(1);
 		break;
