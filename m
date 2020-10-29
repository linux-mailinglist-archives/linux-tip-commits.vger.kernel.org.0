Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616C029EB88
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgJ2MQd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:16:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33306 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgJ2MPt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:49 -0400
Date:   Thu, 29 Oct 2020 12:15:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hk2iKAQtv20Dt1kLFxuYM1vt59/+P0eP5cIGvekraFQ=;
        b=Q+dVZ/yrRqViemo3BmO107kGInn6CfeLzfryfyIvZAXUjrm9FlfZTbtPp2offmg1YBKl94
        DTTuIebTzy2SdDq6tQq/jaeDLjgbvK+sYT4odAM4vYTbCzYeTrPbhSg3M+XKkAxj6ujXk/
        AgBbCRtzVvHmQFJJd+K03YTwlfknfiYrs9m3/C735kWMduH4GyBIkl7heggLlkr+4fSDMV
        2AkIYxWnsTK/5Cd54UxkRjDfSXZhCTxaDNVPK3MEtyLmeRlj3EWQpDIAIGugCDQdAPtf8z
        X2/cDEnbaXdDKBbc2AbV+CEcYS5VMSs/X4ZP6Z6pOkLoEc/YR1fvlGlRtuJKuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hk2iKAQtv20Dt1kLFxuYM1vt59/+P0eP5cIGvekraFQ=;
        b=albAqCLFVlsX/T3P+KgTvGbMPaPTMI3hHVLgh/LJyZjdd+uZJrmW4MYDRr1FGFiQIYYJrT
        d6ltbilyP5/teFAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Cleanup destination mode
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-9-dwmw2@infradead.org>
References: <20201024213535.443185-9-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397374521.397.410261489835128681.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     8c44963b603db76e3e5f57d90d027657ba43c1fe
Gitweb:        https://git.kernel.org/tip/8c44963b603db76e3e5f57d90d027657ba43c1fe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 24 Oct 2020 22:35:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:25 +01:00

x86/apic: Cleanup destination mode

apic::irq_dest_mode is actually a boolean, but defined as u32 and named in
a way which does not explain what it means.

Make it a boolean and rename it to 'dest_mode_logical'

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-9-dwmw2@infradead.org

---
 arch/x86/include/asm/apic.h           | 2 +-
 arch/x86/kernel/apic/apic.c           | 2 +-
 arch/x86/kernel/apic/apic_flat_64.c   | 4 ++--
 arch/x86/kernel/apic/apic_noop.c      | 4 +---
 arch/x86/kernel/apic/apic_numachip.c  | 4 ++--
 arch/x86/kernel/apic/bigsmp_32.c      | 3 +--
 arch/x86/kernel/apic/io_apic.c        | 2 +-
 arch/x86/kernel/apic/msi.c            | 6 +++---
 arch/x86/kernel/apic/probe_32.c       | 3 +--
 arch/x86/kernel/apic/x2apic_cluster.c | 2 +-
 arch/x86/kernel/apic/x2apic_phys.c    | 2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c    | 2 +-
 arch/x86/kernel/smpboot.c             | 7 ++-----
 arch/x86/platform/uv/uv_irq.c         | 2 +-
 arch/x86/xen/apic.c                   | 3 +--
 drivers/iommu/amd/amd_iommu_types.h   | 2 +-
 drivers/iommu/amd/iommu.c             | 8 ++++----
 drivers/iommu/intel/irq_remapping.c   | 2 +-
 18 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index e230ed2..c1f64c6 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -309,7 +309,7 @@ struct apic {
 	u32	disable_esr;
 
 	enum apic_delivery_modes delivery_mode;
-	u32	irq_dest_mode;
+	bool	dest_mode_logical;
 
 	u32	(*calc_dest_apicid)(unsigned int cpu);
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 29d28b3..54f0435 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1591,7 +1591,7 @@ static void setup_local_APIC(void)
 	apic->init_apic_ldr();
 
 #ifdef CONFIG_X86_32
-	if (apic->irq_dest_mode == 1) {
+	if (apic->dest_mode_logical) {
 		int logical_apicid, ldr_apicid;
 
 		/*
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index bbb1b89..8f72b43 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -114,7 +114,7 @@ static struct apic apic_flat __ro_after_init = {
 	.apic_id_registered		= flat_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
-	.irq_dest_mode			= 1, /* logical */
+	.dest_mode_logical		= true,
 
 	.disable_esr			= 0,
 
@@ -205,7 +205,7 @@ static struct apic apic_physflat __ro_after_init = {
 	.apic_id_registered		= flat_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
-	.irq_dest_mode			= 0, /* physical */
+	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
 
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 38f167c..fe78319 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -96,8 +96,7 @@ struct apic apic_noop __ro_after_init = {
 	.apic_id_registered		= noop_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
-	/* logical delivery broadcast to all CPUs: */
-	.irq_dest_mode			= 1,
+	.dest_mode_logical		= true,
 
 	.disable_esr			= 0,
 
@@ -105,7 +104,6 @@ struct apic apic_noop __ro_after_init = {
 	.init_apic_ldr			= noop_init_apic_ldr,
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.setup_apic_routing		= NULL,
-
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= physid_set_mask_of_physid,
 
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 4ebf9fe..a54d817 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -247,7 +247,7 @@ static const struct apic apic_numachip1 __refconst = {
 	.apic_id_registered		= numachip_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
-	.irq_dest_mode			= 0, /* physical */
+	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
 
@@ -294,7 +294,7 @@ static const struct apic apic_numachip2 __refconst = {
 	.apic_id_registered		= numachip_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
-	.irq_dest_mode			= 0, /* physical */
+	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
 
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 64c375b..77555f6 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -128,8 +128,7 @@ static struct apic apic_bigsmp __ro_after_init = {
 	.apic_id_registered		= bigsmp_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
-	/* phys delivery to target CPU: */
-	.irq_dest_mode			= 0,
+	.dest_mode_logical		= false,
 
 	.disable_esr			= 1,
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index cff6cbc..c6d92d2 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2950,7 +2950,7 @@ static void mp_setup_entry(struct irq_cfg *cfg, struct mp_chip_data *data,
 {
 	memset(entry, 0, sizeof(*entry));
 	entry->delivery_mode = apic->delivery_mode;
-	entry->dest_mode     = apic->irq_dest_mode;
+	entry->dest_mode     = apic->dest_mode_logical;
 	entry->dest	     = cfg->dest_apicid;
 	entry->vector	     = cfg->vector;
 	entry->trigger	     = data->trigger;
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 516df47..46ffd41 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -30,9 +30,9 @@ static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
 
 	msg->address_lo =
 		MSI_ADDR_BASE_LO |
-		((apic->irq_dest_mode == 0) ?
-			MSI_ADDR_DEST_MODE_PHYSICAL :
-			MSI_ADDR_DEST_MODE_LOGICAL) |
+		(apic->dest_mode_logical ?
+			MSI_ADDR_DEST_MODE_LOGICAL :
+			MSI_ADDR_DEST_MODE_PHYSICAL) |
 		MSI_ADDR_REDIRECTION_CPU |
 		MSI_ADDR_DEST_ID(cfg->dest_apicid);
 
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 97652aa..a61f642 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -70,8 +70,7 @@ static struct apic apic_default __ro_after_init = {
 	.apic_id_registered		= default_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
-	/* logical delivery broadcast to all CPUs: */
-	.irq_dest_mode			= 1,
+	.dest_mode_logical		= true,
 
 	.disable_esr			= 0,
 
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 53390fc..df6adc5 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -185,7 +185,7 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.apic_id_registered		= x2apic_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
-	.irq_dest_mode			= 1, /* logical */
+	.dest_mode_logical		= true,
 
 	.disable_esr			= 0,
 
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index ee0c4d0..0e4e819 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -158,7 +158,7 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.apic_id_registered		= x2apic_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
-	.irq_dest_mode			= 0, /* physical */
+	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
 
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d21a685..de94181 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -808,7 +808,7 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.apic_id_registered		= uv_apic_id_registered,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
-	.irq_dest_mode			= 0, /* Physical */
+	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 6c14f10..d133d65 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -747,7 +747,7 @@ static void __init smp_quirk_init_udelay(void)
 int
 wakeup_secondary_cpu_via_nmi(int apicid, unsigned long start_eip)
 {
-	u32 dm = apic->irq_dest_mode ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
+	u32 dm = apic->dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
 	unsigned long send_status, accept_status = 0;
 	int maxlvt;
 
@@ -981,10 +981,7 @@ wakeup_cpu_via_init_nmi(int cpu, unsigned long start_ip, int apicid,
 	if (!boot_error) {
 		enable_start_cpu0 = 1;
 		*cpu0_nmi_registered = 1;
-		if (apic->irq_dest_mode)
-			id = cpu0_logical_apicid;
-		else
-			id = apicid;
+		id = apic->dest_mode_logical ? cpu0_logical_apicid : apicid;
 		boot_error = wakeup_secondary_cpu_via_nmi(id, start_ip);
 	}
 
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index e7020d1..1a536a1 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -36,7 +36,7 @@ static void uv_program_mmr(struct irq_cfg *cfg, struct uv_irq_2_mmr_pnode *info)
 	entry = (struct uv_IO_APIC_route_entry *)&mmr_value;
 	entry->vector		= cfg->vector;
 	entry->delivery_mode	= apic->delivery_mode;
-	entry->dest_mode	= apic->irq_dest_mode;
+	entry->dest_mode	= apic->dest_mode_logical;
 	entry->polarity		= 0;
 	entry->trigger		= 0;
 	entry->mask		= 0;
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index c35c24b..0d46cc2 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -148,8 +148,7 @@ static struct apic xen_pv_apic = {
 	.apic_id_valid 			= xen_id_always_valid,
 	.apic_id_registered 		= xen_id_always_registered,
 
-	/* .irq_delivery_mode - used in native_compose_msi_msg only */
-	/* .irq_dest_mode     - used in native_compose_msi_msg only */
+	/* .delivery_mode and .dest_mode_logical not used by XENPV */
 
 	.disable_esr			= 0,
 
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f696ac7..ba74a72 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -893,7 +893,7 @@ struct amd_ir_data {
 };
 
 struct amd_irte_ops {
-	void (*prepare)(void *, u32, u32, u8, u32, int);
+	void (*prepare)(void *, u32, bool, u8, u32, int);
 	void (*activate)(void *, u16, u16);
 	void (*deactivate)(void *, u16, u16);
 	void (*set_affinity)(void *, u16, u16, u8, u32);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index bc81b91..d7f0c89 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3466,7 +3466,7 @@ static void free_irte(u16 devid, int index)
 }
 
 static void irte_prepare(void *entry,
-			 u32 delivery_mode, u32 dest_mode,
+			 u32 delivery_mode, bool dest_mode,
 			 u8 vector, u32 dest_apicid, int devid)
 {
 	union irte *irte = (union irte *) entry;
@@ -3480,7 +3480,7 @@ static void irte_prepare(void *entry,
 }
 
 static void irte_ga_prepare(void *entry,
-			    u32 delivery_mode, u32 dest_mode,
+			    u32 delivery_mode, bool dest_mode,
 			    u8 vector, u32 dest_apicid, int devid)
 {
 	struct irte_ga *irte = (struct irte_ga *) entry;
@@ -3672,7 +3672,7 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 	data->irq_2_irte.devid = devid;
 	data->irq_2_irte.index = index + sub_handle;
 	iommu->irte_ops->prepare(data->entry, apic->delivery_mode,
-				 apic->irq_dest_mode, irq_cfg->vector,
+				 apic->dest_mode_logical, irq_cfg->vector,
 				 irq_cfg->dest_apicid, devid);
 
 	switch (info->type) {
@@ -3943,7 +3943,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 	entry->hi.val = 0;
 
 	entry->lo.fields_remap.valid       = valid;
-	entry->lo.fields_remap.dm          = apic->irq_dest_mode;
+	entry->lo.fields_remap.dm          = apic->dest_mode_logical;
 	entry->lo.fields_remap.int_type    = apic->delivery_mode;
 	entry->hi.fields.vector            = cfg->vector;
 	entry->lo.fields_remap.destination =
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index d44e719..5628d43 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1113,7 +1113,7 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	memset(irte, 0, sizeof(*irte));
 
 	irte->present = 1;
-	irte->dst_mode = apic->irq_dest_mode;
+	irte->dst_mode = apic->dest_mode_logical;
 	/*
 	 * Trigger mode in the IRTE will always be edge, and for IO-APIC, the
 	 * actual level or edge trigger will be setup in the IO-APIC
