Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DB326CDD8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 23:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgIPVF7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 17:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgIPQOy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614C4C02C288;
        Wed, 16 Sep 2020 08:17:18 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=olhTJRo/qKhs6GjAVlfsrOg/Dy9TXoczJplXDmHE2GM=;
        b=cM6kYE9aij7QBxsjnsyEbPzqqEdMTEZLzTfuCJ9W5gJpMhbvZ5xR6JPZ/ZGG8LuwA740qH
        4RkgYu+UFX8V2MGXTo6/0eSZGZ9rvedgxNrg8rHZYSDxiD5is86hv4X38/sJnvxoJ503WO
        doR9VDVSTMUhFEjbpBeUlrsBWmL8mShIkcrC7DpdzatLGRAPaWAvfk6Y13tq3jJ/fBdHCG
        r/OEgJUGJn84pfFUd7B5Dz6LFoRu4KW05Xkm0NHepIjOzJoN5WnSups4HPM6i5KJt756AN
        N/OKHFBcClmniuLD0ktJUXnOqiavjq4IrJ6FJgP/VqiIeukZzCEMqjCrzAtUfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=olhTJRo/qKhs6GjAVlfsrOg/Dy9TXoczJplXDmHE2GM=;
        b=6ywthyfc+BTHG8giTq3vmg5sI0WN/Y1gF3lArmTSIH0J9qYWbrzVBXAEqnPd6gAVw4JOh0
        0c33HurDF5RoR1Bg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] iommu/irq_remapping: Consolidate irq domain lookup
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <jroedel@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112331.741909337@linutronix.de>
References: <20200826112331.741909337@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026914244.15536.5890276968207275015.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     6b6256e616f7e10c4434cfcd32371fc33ca94e48
Gitweb:        https://git.kernel.org/tip/6b6256e616f7e10c4434cfcd32371fc33ca94e48
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:30 +02:00

iommu/irq_remapping: Consolidate irq domain lookup

Now that the iommu implementations handle the X86_*_GET_PARENT_DOMAIN
types, consolidate the two getter functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200826112331.741909337@linutronix.de
---
 arch/x86/include/asm/irq_remapping.h |  8 --------
 arch/x86/kernel/apic/io_apic.c       |  2 +-
 arch/x86/kernel/apic/msi.c           |  2 +-
 drivers/iommu/amd/iommu.c            |  1 -
 drivers/iommu/hyperv-iommu.c         |  4 ++--
 drivers/iommu/intel/irq_remapping.c  |  1 -
 drivers/iommu/irq_remapping.c        | 23 +----------------------
 drivers/iommu/irq_remapping.h        |  5 +----
 8 files changed, 6 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 4bc985f..af4a151 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -45,8 +45,6 @@ extern int irq_remap_enable_fault_handling(void);
 extern void panic_if_irq_remap(const char *msg);
 
 extern struct irq_domain *
-irq_remapping_get_ir_irq_domain(struct irq_alloc_info *info);
-extern struct irq_domain *
 irq_remapping_get_irq_domain(struct irq_alloc_info *info);
 
 /* Create PCI MSI/MSIx irqdomain, use @parent as the parent irqdomain. */
@@ -74,12 +72,6 @@ static inline void panic_if_irq_remap(const char *msg)
 }
 
 static inline struct irq_domain *
-irq_remapping_get_ir_irq_domain(struct irq_alloc_info *info)
-{
-	return NULL;
-}
-
-static inline struct irq_domain *
 irq_remapping_get_irq_domain(struct irq_alloc_info *info)
 {
 	return NULL;
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index be01bb6..20ba0b7 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2298,7 +2298,7 @@ static int mp_irqdomain_create(int ioapic)
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT;
 	info.ioapic_id = mpc_ioapic_id(ioapic);
-	parent = irq_remapping_get_ir_irq_domain(&info);
+	parent = irq_remapping_get_irq_domain(&info);
 	if (!parent)
 		parent = x86_vector_domain;
 	else
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 421c016..9edb1bb 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -474,7 +474,7 @@ struct irq_domain *hpet_create_irq_domain(int hpet_id)
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT;
 	info.hpet_id = hpet_id;
-	parent = irq_remapping_get_ir_irq_domain(&info);
+	parent = irq_remapping_get_irq_domain(&info);
 	if (parent == NULL)
 		parent = x86_vector_domain;
 	else
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4d4045a..18b4dfb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3575,7 +3575,6 @@ struct irq_remap_ops amd_iommu_irq_ops = {
 	.disable		= amd_iommu_disable,
 	.reenable		= amd_iommu_reenable,
 	.enable_faulting	= amd_iommu_enable_faulting,
-	.get_ir_irq_domain	= get_irq_domain,
 	.get_irq_domain		= get_irq_domain,
 };
 
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index e7bee11..dc82a1d 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -182,7 +182,7 @@ static int __init hyperv_enable_irq_remapping(void)
 	return IRQ_REMAP_X2APIC_MODE;
 }
 
-static struct irq_domain *hyperv_get_ir_irq_domain(struct irq_alloc_info *info)
+static struct irq_domain *hyperv_get_irq_domain(struct irq_alloc_info *info)
 {
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT)
 		return ioapic_ir_domain;
@@ -193,7 +193,7 @@ static struct irq_domain *hyperv_get_ir_irq_domain(struct irq_alloc_info *info)
 struct irq_remap_ops hyperv_irq_remap_ops = {
 	.prepare		= hyperv_prepare_irq_remapping,
 	.enable			= hyperv_enable_irq_remapping,
-	.get_ir_irq_domain	= hyperv_get_ir_irq_domain,
+	.get_irq_domain		= hyperv_get_irq_domain,
 };
 
 #endif
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index d85656e..0289a78 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1137,7 +1137,6 @@ struct irq_remap_ops intel_irq_remap_ops = {
 	.disable		= disable_irq_remapping,
 	.reenable		= reenable_irq_remapping,
 	.enable_faulting	= enable_drhd_fault_handling,
-	.get_ir_irq_domain	= intel_get_irq_domain,
 	.get_irq_domain		= intel_get_irq_domain,
 };
 
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 83f36f6..2d84b1e 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -160,33 +160,12 @@ void panic_if_irq_remap(const char *msg)
 }
 
 /**
- * irq_remapping_get_ir_irq_domain - Get the irqdomain associated with the IOMMU
- *				     device serving request @info
- * @info: interrupt allocation information, used to identify the IOMMU device
- *
- * It's used to get parent irqdomain for HPET and IOAPIC irqdomains.
- * Returns pointer to IRQ domain, or NULL on failure.
- */
-struct irq_domain *
-irq_remapping_get_ir_irq_domain(struct irq_alloc_info *info)
-{
-	if (!remap_ops || !remap_ops->get_ir_irq_domain)
-		return NULL;
-
-	return remap_ops->get_ir_irq_domain(info);
-}
-
-/**
  * irq_remapping_get_irq_domain - Get the irqdomain serving the request @info
  * @info: interrupt allocation information, used to identify the IOMMU device
  *
- * There will be one PCI MSI/MSIX irqdomain associated with each interrupt
- * remapping device, so this interface is used to retrieve the PCI MSI/MSIX
- * irqdomain serving request @info.
  * Returns pointer to IRQ domain, or NULL on failure.
  */
-struct irq_domain *
-irq_remapping_get_irq_domain(struct irq_alloc_info *info)
+struct irq_domain *irq_remapping_get_irq_domain(struct irq_alloc_info *info)
 {
 	if (!remap_ops || !remap_ops->get_irq_domain)
 		return NULL;
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 6a190d5..1661b3d 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -43,10 +43,7 @@ struct irq_remap_ops {
 	/* Enable fault handling */
 	int  (*enable_faulting)(void);
 
-	/* Get the irqdomain associated the IOMMU device */
-	struct irq_domain *(*get_ir_irq_domain)(struct irq_alloc_info *);
-
-	/* Get the MSI irqdomain associated with the IOMMU device */
+	/* Get the irqdomain associated to IOMMU device */
 	struct irq_domain *(*get_irq_domain)(struct irq_alloc_info *);
 };
 
