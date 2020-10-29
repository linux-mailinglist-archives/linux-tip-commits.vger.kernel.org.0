Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0456329EB90
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgJ2MPh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgJ2MPg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161EBC0613CF;
        Thu, 29 Oct 2020 05:15:36 -0700 (PDT)
Date:   Thu, 29 Oct 2020 12:15:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973732;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8uPFWxHNjEK2wJS21o4sdpLeopS+H2cJsWFHrBT+tw=;
        b=PXdWkojdXCYrNer0r8GhNCsqriK3UP88lkr08FjYFBdpIDrV+KYYEZ/9URzGfEug5L1adf
        gKIYprsBG5B6oRh33xZPnJqCW2JUmlP8ebGy5mP2/BC9c7KDSozWjujVESYec4RTgUZwj6
        a7jeBcJm4LKl9rl2isL8xVBzzOPPNrUsHdq5pPQn9KvrxqEoe9cpfM0MTSGxZCNLFWkJ8f
        fFwa5HdOPqzlhpGOW4w+ZI/U0guqluh4eZf84Z4EYhoOyo432VD5j7LnRT7grSFNALUEWT
        4TN/DGRaCjEnsORrvi/eDYFilezeuynaaWRM/GuSJaCm7Ib9qlKORaIvZy9YWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973732;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8uPFWxHNjEK2wJS21o4sdpLeopS+H2cJsWFHrBT+tw=;
        b=rFVXDqRc3h8er1npMTyFR36rWDzt3PoIO8Fn8FNJWZYgjnW0jhxNL6WHgoEhqDl33lWrne
        AM5ockzyUxnqewDg==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86: Kill all traces of irq_remapping_get_irq_domain()
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-30-dwmw2@infradead.org>
References: <20201024213535.443185-30-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397373190.397.17223418403390684015.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     ed381fca47122f0787ee53b97e5f9d562eec7237
Gitweb:        https://git.kernel.org/tip/ed381fca47122f0787ee53b97e5f9d562eec7237
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Sat, 24 Oct 2020 22:35:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:28 +01:00

x86: Kill all traces of irq_remapping_get_irq_domain()

All users are converted to use the fwspec based parent domain lookup.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-30-dwmw2@infradead.org

---
 arch/x86/include/asm/hw_irq.h        |  2 +--
 arch/x86/include/asm/irq_remapping.h |  9 +-------
 drivers/iommu/amd/iommu.c            | 34 +---------------------------
 drivers/iommu/hyperv-iommu.c         |  9 +-------
 drivers/iommu/intel/irq_remapping.c  | 17 +--------------
 drivers/iommu/irq_remapping.c        | 14 +-----------
 drivers/iommu/irq_remapping.h        |  3 +--
 7 files changed, 88 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 83a69f6..458f5a6 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -40,8 +40,6 @@ enum irq_alloc_type {
 	X86_IRQ_ALLOC_TYPE_PCI_MSIX,
 	X86_IRQ_ALLOC_TYPE_DMAR,
 	X86_IRQ_ALLOC_TYPE_UV,
-	X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT,
-	X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT,
 };
 
 struct ioapic_alloc_info {
diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index af4a151..7cc4943 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -44,9 +44,6 @@ extern int irq_remapping_reenable(int);
 extern int irq_remap_enable_fault_handling(void);
 extern void panic_if_irq_remap(const char *msg);
 
-extern struct irq_domain *
-irq_remapping_get_irq_domain(struct irq_alloc_info *info);
-
 /* Create PCI MSI/MSIx irqdomain, use @parent as the parent irqdomain. */
 extern struct irq_domain *
 arch_create_remap_msi_irq_domain(struct irq_domain *par, const char *n, int id);
@@ -71,11 +68,5 @@ static inline void panic_if_irq_remap(const char *msg)
 {
 }
 
-static inline struct irq_domain *
-irq_remapping_get_irq_domain(struct irq_alloc_info *info)
-{
-	return NULL;
-}
-
 #endif /* CONFIG_IRQ_REMAP */
 #endif /* __X86_IRQ_REMAPPING_H */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 31b2224..463d322 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3601,10 +3601,8 @@ static int get_devid(struct irq_alloc_info *info)
 {
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
-	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
 		return get_ioapic_devid(info->devid);
 	case X86_IRQ_ALLOC_TYPE_HPET:
-	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
 		return get_hpet_devid(info->devid);
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
@@ -3615,44 +3613,12 @@ static int get_devid(struct irq_alloc_info *info)
 	}
 }
 
-static struct irq_domain *get_irq_domain_for_devid(struct irq_alloc_info *info,
-						   int devid)
-{
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
-
-	if (!iommu)
-		return NULL;
-
-	switch (info->type) {
-	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
-	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
-		return iommu->ir_domain;
-	default:
-		WARN_ON_ONCE(1);
-		return NULL;
-	}
-}
-
-static struct irq_domain *get_irq_domain(struct irq_alloc_info *info)
-{
-	int devid;
-
-	if (!info)
-		return NULL;
-
-	devid = get_devid(info);
-	if (devid < 0)
-		return NULL;
-	return get_irq_domain_for_devid(info, devid);
-}
-
 struct irq_remap_ops amd_iommu_irq_ops = {
 	.prepare		= amd_iommu_prepare,
 	.enable			= amd_iommu_enable,
 	.disable		= amd_iommu_disable,
 	.reenable		= amd_iommu_reenable,
 	.enable_faulting	= amd_iommu_enable_faulting,
-	.get_irq_domain		= get_irq_domain,
 };
 
 static void fill_msi_msg(struct msi_msg *msg, u32 index)
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 78a264a..a629a6b 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -160,18 +160,9 @@ static int __init hyperv_enable_irq_remapping(void)
 	return IRQ_REMAP_X2APIC_MODE;
 }
 
-static struct irq_domain *hyperv_get_irq_domain(struct irq_alloc_info *info)
-{
-	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT)
-		return ioapic_ir_domain;
-	else
-		return NULL;
-}
-
 struct irq_remap_ops hyperv_irq_remap_ops = {
 	.prepare		= hyperv_prepare_irq_remapping,
 	.enable			= hyperv_enable_irq_remapping,
-	.get_irq_domain		= hyperv_get_irq_domain,
 };
 
 #endif
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index b3b079c..bca4401 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1127,29 +1127,12 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	irte->redir_hint = 1;
 }
 
-static struct irq_domain *intel_get_irq_domain(struct irq_alloc_info *info)
-{
-	if (!info)
-		return NULL;
-
-	switch (info->type) {
-	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
-		return map_ioapic_to_ir(info->devid);
-	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
-		return map_hpet_to_ir(info->devid);
-	default:
-		WARN_ON_ONCE(1);
-		return NULL;
-	}
-}
-
 struct irq_remap_ops intel_irq_remap_ops = {
 	.prepare		= intel_prepare_irq_remapping,
 	.enable			= intel_enable_irq_remapping,
 	.disable		= disable_irq_remapping,
 	.reenable		= reenable_irq_remapping,
 	.enable_faulting	= enable_drhd_fault_handling,
-	.get_irq_domain		= intel_get_irq_domain,
 };
 
 static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 2d84b1e..83314b9 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -158,17 +158,3 @@ void panic_if_irq_remap(const char *msg)
 	if (irq_remapping_enabled)
 		panic(msg);
 }
-
-/**
- * irq_remapping_get_irq_domain - Get the irqdomain serving the request @info
- * @info: interrupt allocation information, used to identify the IOMMU device
- *
- * Returns pointer to IRQ domain, or NULL on failure.
- */
-struct irq_domain *irq_remapping_get_irq_domain(struct irq_alloc_info *info)
-{
-	if (!remap_ops || !remap_ops->get_irq_domain)
-		return NULL;
-
-	return remap_ops->get_irq_domain(info);
-}
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 1661b3d..8c89cb9 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -42,9 +42,6 @@ struct irq_remap_ops {
 
 	/* Enable fault handling */
 	int  (*enable_faulting)(void);
-
-	/* Get the irqdomain associated to IOMMU device */
-	struct irq_domain *(*get_irq_domain)(struct irq_alloc_info *);
 };
 
 extern struct irq_remap_ops intel_irq_remap_ops;
