Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33F729EB76
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgJ2MPv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:15:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33322 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgJ2MPv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:51 -0400
Date:   Thu, 29 Oct 2020 12:15:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIQ7YIFJ37tyIN64IrIhaOrfMuZ7j1rWYi6LvcRqWY8=;
        b=nvD8CyPgoh1EX4AsurLgxRGO1Nflsv/XWXTkoI+joRmPfzsghMaF1fYI41QOy8092q1dRq
        FFPOUvLB5TVrhg/7zh2iaHBoz3yqfeeQ6rUunbDdOBJ4OnwUEu27I1KDkX919hPT0SWZ1w
        xv2UvP41ufFs/POKw5l1emkURLq90G5INPfxsrKBcs+b23qDB3lRAoxt6i72303BGwNg0j
        gIkqtpHUHTZ7bUL/EuQthF35j1xYqLn78tplDjgZOuFA+cUUzON2/GncynNVRdRdS2zxUA
        j0QSpdAA0531Gt1VDdpQFXmwEcZelKTsR4i25RXwr/F5M31vcIAyUlW7lVGatA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIQ7YIFJ37tyIN64IrIhaOrfMuZ7j1rWYi6LvcRqWY8=;
        b=+kT6YZurGhtKkE4QJRzQwL2G/EutWwloiSjykd9QPfTcwn1my+39WwLC4Xkt7KvFshhFq9
        2HG5Nlz5n4cCVyBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Cleanup delivery mode defines
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-6-dwmw2@infradead.org>
References: <20201024213535.443185-6-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397374697.397.2430389140744938107.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     721612994f53ed600b39a80d912b10f51960e2e3
Gitweb:        https://git.kernel.org/tip/721612994f53ed600b39a80d912b10f51960e2e3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 24 Oct 2020 22:35:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:24 +01:00

x86/apic: Cleanup delivery mode defines

The enum ioapic_irq_destination_types and the enumerated constants starting
with 'dest_' are gross misnomers because they describe the delivery mode.

Rename then enum and the constants so they actually make sense.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-6-dwmw2@infradead.org

---
 arch/x86/include/asm/apic.h           |  3 ++-
 arch/x86/include/asm/apicdef.h        | 16 +++++++---------
 arch/x86/kernel/apic/apic_flat_64.c   |  4 ++--
 arch/x86/kernel/apic/apic_noop.c      |  2 +-
 arch/x86/kernel/apic/apic_numachip.c  |  4 ++--
 arch/x86/kernel/apic/bigsmp_32.c      |  2 +-
 arch/x86/kernel/apic/io_apic.c        | 11 ++++++-----
 arch/x86/kernel/apic/probe_32.c       |  2 +-
 arch/x86/kernel/apic/x2apic_cluster.c |  2 +-
 arch/x86/kernel/apic/x2apic_phys.c    |  2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c    |  6 +++---
 arch/x86/platform/uv/uv_irq.c         |  2 +-
 drivers/iommu/amd/iommu.c             |  4 ++--
 drivers/iommu/intel/irq_remapping.c   |  2 +-
 drivers/pci/controller/pci-hyperv.c   |  6 +++---
 15 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 57af25c..37a08f3 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -309,7 +309,8 @@ struct apic {
 	/* dest_logical is used by the IPI functions */
 	u32	dest_logical;
 	u32	disable_esr;
-	u32	irq_delivery_mode;
+
+	enum apic_delivery_modes delivery_mode;
 	u32	irq_dest_mode;
 
 	u32	(*calc_dest_apicid)(unsigned int cpu);
diff --git a/arch/x86/include/asm/apicdef.h b/arch/x86/include/asm/apicdef.h
index 05e694e..5716f22 100644
--- a/arch/x86/include/asm/apicdef.h
+++ b/arch/x86/include/asm/apicdef.h
@@ -432,15 +432,13 @@ struct local_apic {
  #define BAD_APICID 0xFFFFu
 #endif
 
-enum ioapic_irq_destination_types {
-	dest_Fixed		= 0,
-	dest_LowestPrio		= 1,
-	dest_SMI		= 2,
-	dest__reserved_1	= 3,
-	dest_NMI		= 4,
-	dest_INIT		= 5,
-	dest__reserved_2	= 6,
-	dest_ExtINT		= 7
+enum apic_delivery_modes {
+	APIC_DELIVERY_MODE_FIXED	= 0,
+	APIC_DELIVERY_MODE_LOWESTPRIO   = 1,
+	APIC_DELIVERY_MODE_SMI		= 2,
+	APIC_DELIVERY_MODE_NMI		= 4,
+	APIC_DELIVERY_MODE_INIT		= 5,
+	APIC_DELIVERY_MODE_EXTINT	= 7,
 };
 
 #endif /* _ASM_X86_APICDEF_H */
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 7862b15..fdd38a1 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -113,7 +113,7 @@ static struct apic apic_flat __ro_after_init = {
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= flat_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.irq_dest_mode			= 1, /* logical */
 
 	.disable_esr			= 0,
@@ -206,7 +206,7 @@ static struct apic apic_physflat __ro_after_init = {
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= flat_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.irq_dest_mode			= 0, /* physical */
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 780c702..4fc934b 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -95,7 +95,7 @@ struct apic apic_noop __ro_after_init = {
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= noop_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	/* logical delivery broadcast to all CPUs: */
 	.irq_dest_mode			= 1,
 
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 35edd57..db715d0 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -246,7 +246,7 @@ static const struct apic apic_numachip1 __refconst = {
 	.apic_id_valid			= numachip_apic_id_valid,
 	.apic_id_registered		= numachip_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.irq_dest_mode			= 0, /* physical */
 
 	.disable_esr			= 0,
@@ -295,7 +295,7 @@ static const struct apic apic_numachip2 __refconst = {
 	.apic_id_valid			= numachip_apic_id_valid,
 	.apic_id_registered		= numachip_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.irq_dest_mode			= 0, /* physical */
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 98d015a..7f6461f 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -127,7 +127,7 @@ static struct apic apic_bigsmp __ro_after_init = {
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= bigsmp_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	/* phys delivery to target CPU: */
 	.irq_dest_mode			= 0,
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 7b3c7e0..cff6cbc 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -535,7 +535,7 @@ static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 
 	/* Check delivery_mode to be sure we're not clearing an SMI pin */
 	entry = ioapic_read_entry(apic, pin);
-	if (entry.delivery_mode == dest_SMI)
+	if (entry.delivery_mode == APIC_DELIVERY_MODE_SMI)
 		return;
 
 	/*
@@ -1368,7 +1368,8 @@ void __init enable_IO_APIC(void)
 		/* If the interrupt line is enabled and in ExtInt mode
 		 * I have found the pin where the i8259 is connected.
 		 */
-		if ((entry.mask == 0) && (entry.delivery_mode == dest_ExtINT)) {
+		if ((entry.mask == 0) &&
+		    (entry.delivery_mode == APIC_DELIVERY_MODE_EXTINT)) {
 			ioapic_i8259.apic = apic;
 			ioapic_i8259.pin  = pin;
 			goto found_i8259;
@@ -1416,7 +1417,7 @@ void native_restore_boot_irq_mode(void)
 		entry.trigger		= IOAPIC_EDGE;
 		entry.polarity		= IOAPIC_POL_HIGH;
 		entry.dest_mode		= IOAPIC_DEST_MODE_PHYSICAL;
-		entry.delivery_mode	= dest_ExtINT;
+		entry.delivery_mode	= APIC_DELIVERY_MODE_EXTINT;
 		entry.dest		= read_apic_id();
 
 		/*
@@ -2047,7 +2048,7 @@ static inline void __init unlock_ExtINT_logic(void)
 	entry1.dest_mode = IOAPIC_DEST_MODE_PHYSICAL;
 	entry1.mask = IOAPIC_UNMASKED;
 	entry1.dest = hard_smp_processor_id();
-	entry1.delivery_mode = dest_ExtINT;
+	entry1.delivery_mode = APIC_DELIVERY_MODE_EXTINT;
 	entry1.polarity = entry0.polarity;
 	entry1.trigger = IOAPIC_EDGE;
 	entry1.vector = 0;
@@ -2948,7 +2949,7 @@ static void mp_setup_entry(struct irq_cfg *cfg, struct mp_chip_data *data,
 			   struct IO_APIC_route_entry *entry)
 {
 	memset(entry, 0, sizeof(*entry));
-	entry->delivery_mode = apic->irq_delivery_mode;
+	entry->delivery_mode = apic->delivery_mode;
 	entry->dest_mode     = apic->irq_dest_mode;
 	entry->dest	     = cfg->dest_apicid;
 	entry->vector	     = cfg->vector;
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 67b6f7c..77c6e2e 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -69,7 +69,7 @@ static struct apic apic_default __ro_after_init = {
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= default_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	/* logical delivery broadcast to all CPUs: */
 	.irq_dest_mode			= 1,
 
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index b0889c4..82fb43d 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -184,7 +184,7 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.apic_id_valid			= x2apic_apic_id_valid,
 	.apic_id_registered		= x2apic_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.irq_dest_mode			= 1, /* logical */
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index e14eae6..437e843 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -157,7 +157,7 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.apic_id_valid			= x2apic_apic_id_valid,
 	.apic_id_registered		= x2apic_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.irq_dest_mode			= 0, /* physical */
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 9ade9e6..49deefd 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -703,9 +703,9 @@ static void uv_send_IPI_one(int cpu, int vector)
 	unsigned long dmode, val;
 
 	if (vector == NMI_VECTOR)
-		dmode = dest_NMI;
+		dmode = APIC_DELIVERY_MODE_NMI;
 	else
-		dmode = dest_Fixed;
+		dmode = APIC_DELIVERY_MODE_FIXED;
 
 	val = (1UL << UVH_IPI_INT_SEND_SHFT) |
 		(apicid << UVH_IPI_INT_APIC_ID_SHFT) |
@@ -807,7 +807,7 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.apic_id_valid			= uv_apic_id_valid,
 	.apic_id_registered		= uv_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.irq_dest_mode			= 0, /* Physical */
 
 	.disable_esr			= 0,
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index 18ca226..e7020d1 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -35,7 +35,7 @@ static void uv_program_mmr(struct irq_cfg *cfg, struct uv_irq_2_mmr_pnode *info)
 	mmr_value = 0;
 	entry = (struct uv_IO_APIC_route_entry *)&mmr_value;
 	entry->vector		= cfg->vector;
-	entry->delivery_mode	= apic->irq_delivery_mode;
+	entry->delivery_mode	= apic->delivery_mode;
 	entry->dest_mode	= apic->irq_dest_mode;
 	entry->polarity		= 0;
 	entry->trigger		= 0;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b9cf594..bc81b91 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3671,7 +3671,7 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 
 	data->irq_2_irte.devid = devid;
 	data->irq_2_irte.index = index + sub_handle;
-	iommu->irte_ops->prepare(data->entry, apic->irq_delivery_mode,
+	iommu->irte_ops->prepare(data->entry, apic->delivery_mode,
 				 apic->irq_dest_mode, irq_cfg->vector,
 				 irq_cfg->dest_apicid, devid);
 
@@ -3944,7 +3944,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 
 	entry->lo.fields_remap.valid       = valid;
 	entry->lo.fields_remap.dm          = apic->irq_dest_mode;
-	entry->lo.fields_remap.int_type    = apic->irq_delivery_mode;
+	entry->lo.fields_remap.int_type    = apic->delivery_mode;
 	entry->hi.fields.vector            = cfg->vector;
 	entry->lo.fields_remap.destination =
 				APICID_TO_IRTE_DEST_LO(cfg->dest_apicid);
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 0cfce1d..d44e719 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1122,7 +1122,7 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	 * irq migration in the presence of interrupt-remapping.
 	*/
 	irte->trigger_mode = 0;
-	irte->dlvry_mode = apic->irq_delivery_mode;
+	irte->dlvry_mode = apic->delivery_mode;
 	irte->vector = vector;
 	irte->dest_id = IRTE_DEST(dest);
 	irte->redir_hint = 1;
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 03ed5cb..6db8d96 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1226,7 +1226,7 @@ static void hv_irq_unmask(struct irq_data *data)
 	params->int_target.vector = cfg->vector;
 
 	/*
-	 * Honoring apic->irq_delivery_mode set to dest_Fixed by
+	 * Honoring apic->delivery_mode set to APIC_DELIVERY_MODE_FIXED by
 	 * setting the HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results in a
 	 * spurious interrupt storm. Not doing so does not seem to have a
 	 * negative effect (yet?).
@@ -1324,7 +1324,7 @@ static u32 hv_compose_msi_req_v1(
 	int_pkt->wslot.slot = slot;
 	int_pkt->int_desc.vector = vector;
 	int_pkt->int_desc.vector_count = 1;
-	int_pkt->int_desc.delivery_mode = dest_Fixed;
+	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
 
 	/*
 	 * Create MSI w/ dummy vCPU set, overwritten by subsequent retarget in
@@ -1345,7 +1345,7 @@ static u32 hv_compose_msi_req_v2(
 	int_pkt->wslot.slot = slot;
 	int_pkt->int_desc.vector = vector;
 	int_pkt->int_desc.vector_count = 1;
-	int_pkt->int_desc.delivery_mode = dest_Fixed;
+	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
 
 	/*
 	 * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
