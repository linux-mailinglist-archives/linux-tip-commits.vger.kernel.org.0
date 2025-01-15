Return-Path: <linux-tip-commits+bounces-3247-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D06D0A11ED5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 11:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6390188B1D3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD4822F82E;
	Wed, 15 Jan 2025 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TVont8Sw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YwmtiR1f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7BE1E7C22;
	Wed, 15 Jan 2025 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935457; cv=none; b=kRwE6jRgb7RKPQtD2I5bdsPCvl7IrLDTu5PAIg3pC3poi0Fw2J8zokAYflJmdg9pM/K3u2+bByLuc/87BxoiTjebsMWQBedBooh3prsmwBVQYmLebtWCBb3da7zheydM/Njz7cqUSqu4LaEDWrljGQl3WvJGwUVm0XeIG36wqtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935457; c=relaxed/simple;
	bh=XsoCRnIiQ1+T44zWKgIRolcZZT7mS2mD+WC9eXQbTaY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gC5PLeEnjPLrrfnmUlNnh+H1uRnE0bv5N7s/Viusqr/moy0OszYI2TmUddOuJtbeyUgQuAvzjBKncGhjWXyoI1nZ2gnV2ayl1mYcfrQid6uBi4xM8kqj/BByzlnsSVjufFx2Ndb9DuWklVlqQcdf13+PpSxf6rJnntArxpzawc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TVont8Sw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YwmtiR1f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 10:04:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736935453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGTj3AlQ9EtXYrEJWDn3ytyL9LPA90PqdnvIqy1UUvc=;
	b=TVont8SwXTq0Nid3j3DR/gWqFbE7mIxsgFywW05+2zHApL6G1pN6wCCMKBLbIO+ZumOEyS
	JBXTzPAlW6aA1PfV3c5CJskGOCHM/67ufERQq2g6A7Hgv8MjwCRGha/Vtx04dks1VYtT2z
	ojY2l+lNv9v3pHYKxv8640odcLbndCjgBJCtg/cxWWNMfhUKocLQWvqVkyp+Vdb//aumAr
	7zYOOMQhz9QgxkAEUjpS4zFWgobQxoEBcTlPwRgi2/rMZg/1SjUIrGDW1aZ1dnpqhVDPMC
	gfOP5H4i6TrD/m8wqiJzZel36/+DF5aKG/xZ1QANPQdxNY02lxZ8UBXZ3UwDhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736935453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGTj3AlQ9EtXYrEJWDn3ytyL9LPA90PqdnvIqy1UUvc=;
	b=YwmtiR1fKo2Kke8MV7l/aFBkiqZ5VbRUdxgqvMykijlizgTH+ne0OLVAxinfxD8CRZdr3T
	BcTpXTnRN9qhY3BA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] x86/apic: Convert to IRQCHIP_MOVE_DEFERRED
Cc: Thomas Gleixner <tglx@linutronix.de>, Steve Wahl <steve.wahl@hpe.com>,
 Wei Liu <wei.liu@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20241210103335.563277044@linutronix.de>
References: <20241210103335.563277044@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693545291.31546.9390502446176013904.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     12cbdcb9f05559ff72eb8a04df829852804c0276
Gitweb:        https://git.kernel.org/tip/12cbdcb9f05559ff72eb8a04df829852804c0276
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Dec 2024 11:34:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 10:56:22 +01:00

x86/apic: Convert to IRQCHIP_MOVE_DEFERRED

Instead of marking individual interrupts as safe to be migrated in
arbitrary contexts, mark the interrupt chips, which require the interrupt
to be moved in actual interrupt context, with the new IRQCHIP_MOVE_DEFERRED
flag. This makes more sense because this is a per interrupt chip property
and not restricted to individual interrupts.

That flips the logic from the historical opt-out to a opt-in model. This is
simpler to handle for other architectures, which default to unrestricted
affinity setting. It also allows to cleanup the redundant core logic
significantly.

All interrupt chips, which belong to a top-level domain sitting directly on
top of the x86 vector domain are marked accordingly, unless the related
setup code marks the interrupts with IRQ_MOVE_PCNTXT, i.e. XEN.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Link: https://lore.kernel.org/all/20241210103335.563277044@linutronix.de

---
 arch/x86/Kconfig                    | 1 +
 arch/x86/hyperv/irqdomain.c         | 2 +-
 arch/x86/kernel/apic/io_apic.c      | 2 +-
 arch/x86/kernel/apic/msi.c          | 3 ++-
 arch/x86/kernel/hpet.c              | 8 --------
 arch/x86/platform/uv/uv_irq.c       | 2 --
 drivers/iommu/amd/init.c            | 2 +-
 drivers/iommu/amd/iommu.c           | 1 -
 drivers/iommu/intel/irq_remapping.c | 1 -
 drivers/pci/controller/pci-hyperv.c | 1 +
 drivers/xen/events/events_base.c    | 6 ------
 11 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d7bd0a..df0fd72 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -173,6 +173,7 @@ config X86
 	select GENERIC_IRQ_RESERVATION_MODE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PENDING_IRQ		if SMP
+	select GENERIC_PENDING_IRQ_CHIPFLAGS	if SMP
 	select GENERIC_PTDUMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 3215a4a..64b9213 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -304,7 +304,7 @@ static struct irq_chip hv_pci_msi_controller = {
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_compose_msi_msg	= hv_irq_compose_msi_msg,
 	.irq_set_affinity	= msi_domain_set_affinity,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED,
 };
 
 static struct msi_domain_ops pci_msi_domain_ops = {
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 1029ea4..5d033d9 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1861,7 +1861,7 @@ static struct irq_chip ioapic_chip __read_mostly = {
 	.irq_set_affinity	= ioapic_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
-	.flags			= IRQCHIP_SKIP_SET_WAKE |
+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED |
 				  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 3407692..66bc5d3 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -214,6 +214,7 @@ static bool x86_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		if (WARN_ON_ONCE(domain != real_parent))
 			return false;
 		info->chip->irq_set_affinity = msi_set_affinity;
+		info->chip->flags |= IRQCHIP_MOVE_DEFERRED;
 		break;
 	case DOMAIN_BUS_DMAR:
 	case DOMAIN_BUS_AMDVI:
@@ -315,7 +316,7 @@ static struct irq_chip dmar_msi_controller = {
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_compose_msi_msg	= dmar_msi_compose_msg,
 	.irq_write_msi_msg	= dmar_msi_write_msg,
-	.flags			= IRQCHIP_SKIP_SET_WAKE |
+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED |
 				  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index c96ae8f..87b5a50 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -516,22 +516,14 @@ static int hpet_msi_init(struct irq_domain *domain,
 			 struct msi_domain_info *info, unsigned int virq,
 			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
 {
-	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
 	irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
 			    handle_edge_irq, arg->data, "edge");
 
 	return 0;
 }
 
-static void hpet_msi_free(struct irq_domain *domain,
-			  struct msi_domain_info *info, unsigned int virq)
-{
-	irq_clear_status_flags(virq, IRQ_MOVE_PCNTXT);
-}
-
 static struct msi_domain_ops hpet_msi_domain_ops = {
 	.msi_init	= hpet_msi_init,
-	.msi_free	= hpet_msi_free,
 };
 
 static struct msi_domain_info hpet_msi_domain_info = {
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index a379501..f971ef2 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -92,8 +92,6 @@ static int uv_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	if (ret >= 0) {
 		if (info->uv.limit == UV_AFFINITY_CPU)
 			irq_set_status_flags(virq, IRQ_NO_BALANCING);
-		else
-			irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
 
 		chip_data->pnode = uv_blade_to_pnode(info->uv.blade);
 		chip_data->offset = info->uv.offset;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0e0a531..614f216 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2332,7 +2332,7 @@ static struct irq_chip intcapxt_controller = {
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_affinity       = intcapxt_set_affinity,
 	.irq_set_wake		= intcapxt_set_wake,
-	.flags			= IRQCHIP_MASK_ON_SUSPEND,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_MOVE_DEFERRED,
 };
 
 static const struct irq_domain_ops intcapxt_domain_ops = {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3f691e1..b02e631 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3532,7 +3532,6 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		irq_data->chip_data = data;
 		irq_data->chip = &amd_ir_chip;
 		irq_remapping_prepare_irte(data, cfg, info, devid, index, i);
-		irq_set_status_flags(virq + i, IRQ_MOVE_PCNTXT);
 	}
 
 	return 0;
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 466c141..f5402df 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1463,7 +1463,6 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
 		else
 			irq_data->chip = &intel_ir_chip;
 		intel_irq_remapping_prepare_irte(ird, irq_cfg, info, index, i);
-		irq_set_status_flags(virq + i, IRQ_MOVE_PCNTXT);
 	}
 	return 0;
 
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cdd5be1..6084b38 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2053,6 +2053,7 @@ static struct irq_chip hv_msi_irq_chip = {
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 #ifdef CONFIG_X86
 	.irq_ack		= irq_chip_ack_parent,
+	.flags			= IRQCHIP_MOVE_DEFERRED,
 #elif defined(CONFIG_ARM64)
 	.irq_eoi		= irq_chip_eoi_parent,
 #endif
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 985e155..41309d3 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -722,12 +722,6 @@ static struct irq_info *xen_irq_init(unsigned int irq)
 		INIT_RCU_WORK(&info->rwork, delayed_free_irq);
 
 		set_info_for_irq(irq, info);
-		/*
-		 * Interrupt affinity setting can be immediate. No point
-		 * in delaying it until an interrupt is handled.
-		 */
-		irq_set_status_flags(irq, IRQ_MOVE_PCNTXT);
-
 		INIT_LIST_HEAD(&info->eoi_list);
 		list_add_tail(&info->list, &xen_irq_list_head);
 	}

