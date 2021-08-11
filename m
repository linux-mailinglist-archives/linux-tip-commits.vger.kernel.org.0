Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFE23E9910
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhHKTmG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:42:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53824 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhHKTmB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:42:01 -0400
Date:   Wed, 11 Aug 2021 19:41:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710895;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8LfeeFNVHK29iy3fHrkF6/zwgd5i9rxaNjnmm6PJaXc=;
        b=Sn/sDWxjGA9zjXNJpDLPxVr+r5RCjvKosZlIiijhKNfpKjDVYa1YOXvU5JpP2ZgTi/NAaT
        VhB9V2oaUYbE73OLFwBviUjMts2MicVDN6ma9Fc2+OFSDotgRbwBqFFLUXkn5qwKOXfthA
        eEoeuqNnm9azw4Ber8pi2oAKwpEiCXuR6nVsYjF+QtCz5lVJJcdMztP99eg2icAksrcyMg
        CCpEOOloxCctKHiW2EWSkGoqtDLF4L3cO+rnyaPDrpEMooMDdukiNAQ/a6HmyY+lPriG7d
        xoHuv7CVcAJYz7UQqVNpScY+cryYw7uFsUkNZJKkBLnttIWXtRSy0rJL5BLVhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710895;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8LfeeFNVHK29iy3fHrkF6/zwgd5i9rxaNjnmm6PJaXc=;
        b=nnjqDtIU5QJC9jF49rcDNMDcttN+rcTa8N3yQuSOPQfR2vHGR9uyHsDlrtuF0mmMyixOqM
        L+6Ja1623nRqylAQ==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Split struct rdt_resource
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-2-james.morse@arm.com>
References: <20210728170637.25610-2-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871089498.395.13979905339618458013.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     63c8b1231929b8aa80abc753c1c91b6b49e2c0b0
Gitweb:        https://git.kernel.org/tip/63c8b1231929b8aa80abc753c1c91b6b49e2c0b0
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:14 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 11:51:34 +02:00

x86/resctrl: Split struct rdt_resource

resctrl is the defacto Linux ABI for SoC resource partitioning features.

To support it on another architecture, it needs to be abstracted from
the features provided by Intel RDT and AMD PQoS, and moved to /fs/.
struct rdt_resource contains a mix of architecture private details
and properties of the filesystem interface user-space uses.

Start by splitting struct rdt_resource, into an architecture private
'hw' struct, which contains the common resctrl structure that would be
used by any architecture. The foreach helpers are most commonly used by
the filesystem code, and should return the common resctrl structure.
for_each_rdt_resource() is changed to walk the common structure in its
parent arch private structure.

Move as much of the structure as possible into the common structure
in the core code's header file. The x86 hardware accessors remain
part of the architecture private code, as do num_closid, mon_scale
and mbm_width.

mon_scale and mbm_width are used to detect overflow of the hardware
counters, and convert them from their native size to bytes. Any
cross-architecture abstraction should be in terms of bytes, making
these properties private.

The hardware's num_closid is kept in the private structure to force the
filesystem code to use a helper to access it. MPAM would return a single
value for the system, regardless of the resource. Using the helper
prevents this field from being confused with the version of num_closid
that is being exposed to user-space (added in a later patch).

After this split, filesystem code touching a 'hw' struct indicates
where an abstraction is needed.

Splitting this structure only moves types around, and should not lead
to any change in behaviour.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-2-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 257 ++++++++++++---------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  14 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 149 ++----------
 arch/x86/kernel/cpu/resctrl/monitor.c     |  32 +--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  68 +++---
 include/linux/resctrl.h                   | 110 +++++++++-
 7 files changed, 362 insertions(+), 272 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 23001ae..942d070 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -57,120 +57,134 @@ static void
 mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
 	      struct rdt_resource *r);
 
-#define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].domains)
+#define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.domains)
 
-struct rdt_resource rdt_resources_all[] = {
+struct rdt_hw_resource rdt_resources_all[] = {
 	[RDT_RESOURCE_L3] =
 	{
-		.rid			= RDT_RESOURCE_L3,
-		.name			= "L3",
-		.domains		= domain_init(RDT_RESOURCE_L3),
+		.r_resctrl = {
+			.rid			= RDT_RESOURCE_L3,
+			.name			= "L3",
+			.cache_level		= 3,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 1,
+				.cbm_idx_offset	= 0,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L3),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 3,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 1,
-			.cbm_idx_offset	= 0,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
 	},
 	[RDT_RESOURCE_L3DATA] =
 	{
-		.rid			= RDT_RESOURCE_L3DATA,
-		.name			= "L3DATA",
-		.domains		= domain_init(RDT_RESOURCE_L3DATA),
+		.r_resctrl = {
+			.rid			= RDT_RESOURCE_L3DATA,
+			.name			= "L3DATA",
+			.cache_level		= 3,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 2,
+				.cbm_idx_offset	= 0,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L3DATA),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 3,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 2,
-			.cbm_idx_offset	= 0,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
 	},
 	[RDT_RESOURCE_L3CODE] =
 	{
-		.rid			= RDT_RESOURCE_L3CODE,
-		.name			= "L3CODE",
-		.domains		= domain_init(RDT_RESOURCE_L3CODE),
+		.r_resctrl = {
+			.rid			= RDT_RESOURCE_L3CODE,
+			.name			= "L3CODE",
+			.cache_level		= 3,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 2,
+				.cbm_idx_offset	= 1,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L3CODE),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 3,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 2,
-			.cbm_idx_offset	= 1,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
 	},
 	[RDT_RESOURCE_L2] =
 	{
-		.rid			= RDT_RESOURCE_L2,
-		.name			= "L2",
-		.domains		= domain_init(RDT_RESOURCE_L2),
+		.r_resctrl = {
+			.rid			= RDT_RESOURCE_L2,
+			.name			= "L2",
+			.cache_level		= 2,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 1,
+				.cbm_idx_offset	= 0,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L2),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 2,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 1,
-			.cbm_idx_offset	= 0,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
 	},
 	[RDT_RESOURCE_L2DATA] =
 	{
-		.rid			= RDT_RESOURCE_L2DATA,
-		.name			= "L2DATA",
-		.domains		= domain_init(RDT_RESOURCE_L2DATA),
+		.r_resctrl = {
+			.rid			= RDT_RESOURCE_L2DATA,
+			.name			= "L2DATA",
+			.cache_level		= 2,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 2,
+				.cbm_idx_offset	= 0,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L2DATA),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 2,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 2,
-			.cbm_idx_offset	= 0,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
 	},
 	[RDT_RESOURCE_L2CODE] =
 	{
-		.rid			= RDT_RESOURCE_L2CODE,
-		.name			= "L2CODE",
-		.domains		= domain_init(RDT_RESOURCE_L2CODE),
+		.r_resctrl = {
+			.rid			= RDT_RESOURCE_L2CODE,
+			.name			= "L2CODE",
+			.cache_level		= 2,
+			.cache = {
+				.min_cbm_bits	= 1,
+				.cbm_idx_mult	= 2,
+				.cbm_idx_offset	= 1,
+			},
+			.domains		= domain_init(RDT_RESOURCE_L2CODE),
+			.parse_ctrlval		= parse_cbm,
+			.format_str		= "%d=%0*x",
+			.fflags			= RFTYPE_RES_CACHE,
+		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
-		.cache_level		= 2,
-		.cache = {
-			.min_cbm_bits	= 1,
-			.cbm_idx_mult	= 2,
-			.cbm_idx_offset	= 1,
-		},
-		.parse_ctrlval		= parse_cbm,
-		.format_str		= "%d=%0*x",
-		.fflags			= RFTYPE_RES_CACHE,
 	},
 	[RDT_RESOURCE_MBA] =
 	{
-		.rid			= RDT_RESOURCE_MBA,
-		.name			= "MB",
-		.domains		= domain_init(RDT_RESOURCE_MBA),
-		.cache_level		= 3,
-		.parse_ctrlval		= parse_bw,
-		.format_str		= "%d=%*u",
-		.fflags			= RFTYPE_RES_MB,
+		.r_resctrl = {
+			.rid			= RDT_RESOURCE_MBA,
+			.name			= "MB",
+			.cache_level		= 3,
+			.domains		= domain_init(RDT_RESOURCE_MBA),
+			.parse_ctrlval		= parse_bw,
+			.format_str		= "%d=%*u",
+			.fflags			= RFTYPE_RES_MB,
+		},
 	},
 };
 
@@ -199,7 +213,8 @@ static unsigned int cbm_idx(struct rdt_resource *r, unsigned int closid)
  */
 static inline void cache_alloc_hsw_probe(void)
 {
-	struct rdt_resource *r  = &rdt_resources_all[RDT_RESOURCE_L3];
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
+	struct rdt_resource *r  = &hw_res->r_resctrl;
 	u32 l, h, max_cbm = BIT_MASK(20) - 1;
 
 	if (wrmsr_safe(MSR_IA32_L3_CBM_BASE, max_cbm, 0))
@@ -211,7 +226,7 @@ static inline void cache_alloc_hsw_probe(void)
 	if (l != max_cbm)
 		return;
 
-	r->num_closid = 4;
+	hw_res->num_closid = 4;
 	r->default_ctrl = max_cbm;
 	r->cache.cbm_len = 20;
 	r->cache.shareable_bits = 0xc0000;
@@ -225,7 +240,7 @@ static inline void cache_alloc_hsw_probe(void)
 bool is_mba_sc(struct rdt_resource *r)
 {
 	if (!r)
-		return rdt_resources_all[RDT_RESOURCE_MBA].membw.mba_sc;
+		return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.mba_sc;
 
 	return r->membw.mba_sc;
 }
@@ -253,12 +268,13 @@ static inline bool rdt_get_mb_table(struct rdt_resource *r)
 
 static bool __get_mem_config_intel(struct rdt_resource *r)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	union cpuid_0x10_3_eax eax;
 	union cpuid_0x10_x_edx edx;
 	u32 ebx, ecx, max_delay;
 
 	cpuid_count(0x00000010, 3, &eax.full, &ebx, &ecx, &edx.full);
-	r->num_closid = edx.split.cos_max + 1;
+	hw_res->num_closid = edx.split.cos_max + 1;
 	max_delay = eax.split.max_delay + 1;
 	r->default_ctrl = MAX_MBA_BW;
 	r->membw.arch_needs_linear = true;
@@ -287,12 +303,13 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 
 static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	union cpuid_0x10_3_eax eax;
 	union cpuid_0x10_x_edx edx;
 	u32 ebx, ecx;
 
 	cpuid_count(0x80000020, 1, &eax.full, &ebx, &ecx, &edx.full);
-	r->num_closid = edx.split.cos_max + 1;
+	hw_res->num_closid = edx.split.cos_max + 1;
 	r->default_ctrl = MAX_MBA_BW_AMD;
 
 	/* AMD does not use delay */
@@ -317,12 +334,13 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 
 static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	union cpuid_0x10_1_eax eax;
 	union cpuid_0x10_x_edx edx;
 	u32 ebx, ecx;
 
 	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx, &edx.full);
-	r->num_closid = edx.split.cos_max + 1;
+	hw_res->num_closid = edx.split.cos_max + 1;
 	r->cache.cbm_len = eax.split.cbm_len + 1;
 	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
 	r->cache.shareable_bits = ebx & r->default_ctrl;
@@ -333,10 +351,12 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 
 static void rdt_get_cdp_config(int level, int type)
 {
-	struct rdt_resource *r_l = &rdt_resources_all[level];
-	struct rdt_resource *r = &rdt_resources_all[type];
+	struct rdt_resource *r_l = &rdt_resources_all[level].r_resctrl;
+	struct rdt_hw_resource *hw_res_l = resctrl_to_arch_res(r_l);
+	struct rdt_resource *r = &rdt_resources_all[type].r_resctrl;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
-	r->num_closid = r_l->num_closid / 2;
+	hw_res->num_closid = hw_res_l->num_closid / 2;
 	r->cache.cbm_len = r_l->cache.cbm_len;
 	r->default_ctrl = r_l->default_ctrl;
 	r->cache.shareable_bits = r_l->cache.shareable_bits;
@@ -365,9 +385,10 @@ static void
 mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
 	unsigned int i;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(r->msr_base + i, d->ctrl_val[i]);
+		wrmsrl(hw_res->msr_base + i, d->ctrl_val[i]);
 }
 
 /*
@@ -389,19 +410,21 @@ mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
 		struct rdt_resource *r)
 {
 	unsigned int i;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
 	/*  Write the delay values for mba. */
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(r->msr_base + i, delay_bw_map(d->ctrl_val[i], r));
+		wrmsrl(hw_res->msr_base + i, delay_bw_map(d->ctrl_val[i], r));
 }
 
 static void
 cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
 	unsigned int i;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(r->msr_base + cbm_idx(r, i), d->ctrl_val[i]);
+		wrmsrl(hw_res->msr_base + cbm_idx(r, i), d->ctrl_val[i]);
 }
 
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
@@ -420,13 +443,14 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
 void rdt_ctrl_update(void *arg)
 {
 	struct msr_param *m = arg;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(m->res);
 	struct rdt_resource *r = m->res;
 	int cpu = smp_processor_id();
 	struct rdt_domain *d;
 
 	d = get_domain_from_cpu(cpu, r);
 	if (d) {
-		r->msr_update(d, m, r);
+		hw_res->msr_update(d, m, r);
 		return;
 	}
 	pr_warn_once("cpu %d not found in any domain for resource %s\n",
@@ -468,6 +492,7 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 
 void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	int i;
 
 	/*
@@ -476,7 +501,7 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 	 * For Memory Allocation: Set b/w requested to 100%
 	 * and the bandwidth in MBps to U32_MAX
 	 */
-	for (i = 0; i < r->num_closid; i++, dc++, dm++) {
+	for (i = 0; i < hw_res->num_closid; i++, dc++, dm++) {
 		*dc = r->default_ctrl;
 		*dm = MBA_MAX_MBPS;
 	}
@@ -484,14 +509,15 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 
 static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct msr_param m;
 	u32 *dc, *dm;
 
-	dc = kmalloc_array(r->num_closid, sizeof(*d->ctrl_val), GFP_KERNEL);
+	dc = kmalloc_array(hw_res->num_closid, sizeof(*d->ctrl_val), GFP_KERNEL);
 	if (!dc)
 		return -ENOMEM;
 
-	dm = kmalloc_array(r->num_closid, sizeof(*d->mbps_val), GFP_KERNEL);
+	dm = kmalloc_array(hw_res->num_closid, sizeof(*d->mbps_val), GFP_KERNEL);
 	if (!dm) {
 		kfree(dc);
 		return -ENOMEM;
@@ -502,8 +528,8 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	setup_default_ctrlval(r, dc, dm);
 
 	m.low = 0;
-	m.high = r->num_closid;
-	r->msr_update(d, &m, r);
+	m.high = hw_res->num_closid;
+	hw_res->msr_update(d, &m, r);
 	return 0;
 }
 
@@ -655,7 +681,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	if (r == &rdt_resources_all[RDT_RESOURCE_L3]) {
+	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
 		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
 			cancel_delayed_work(&d->mbm_over);
 			mbm_setup_overflow_handler(d, 0);
@@ -827,19 +853,22 @@ static bool __init rdt_cpu_has(int flag)
 
 static __init bool get_mem_config(void)
 {
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_MBA];
+
 	if (!rdt_cpu_has(X86_FEATURE_MBA))
 		return false;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
-		return __get_mem_config_intel(&rdt_resources_all[RDT_RESOURCE_MBA]);
+		return __get_mem_config_intel(&hw_res->r_resctrl);
 	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
-		return __rdt_get_mem_config_amd(&rdt_resources_all[RDT_RESOURCE_MBA]);
+		return __rdt_get_mem_config_amd(&hw_res->r_resctrl);
 
 	return false;
 }
 
 static __init bool get_rdt_alloc_resources(void)
 {
+	struct rdt_resource *r;
 	bool ret = false;
 
 	if (rdt_alloc_capable)
@@ -849,14 +878,16 @@ static __init bool get_rdt_alloc_resources(void)
 		return false;
 
 	if (rdt_cpu_has(X86_FEATURE_CAT_L3)) {
-		rdt_get_cache_alloc_cfg(1, &rdt_resources_all[RDT_RESOURCE_L3]);
+		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+		rdt_get_cache_alloc_cfg(1, r);
 		if (rdt_cpu_has(X86_FEATURE_CDP_L3))
 			rdt_get_cdp_l3_config();
 		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CAT_L2)) {
 		/* CPUID 0x10.2 fields are same format at 0x10.1 */
-		rdt_get_cache_alloc_cfg(2, &rdt_resources_all[RDT_RESOURCE_L2]);
+		r = &rdt_resources_all[RDT_RESOURCE_L2].r_resctrl;
+		rdt_get_cache_alloc_cfg(2, r);
 		if (rdt_cpu_has(X86_FEATURE_CDP_L2))
 			rdt_get_cdp_l2_config();
 		ret = true;
@@ -870,6 +901,8 @@ static __init bool get_rdt_alloc_resources(void)
 
 static __init bool get_rdt_mon_resources(void)
 {
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
 	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC))
 		rdt_mon_features |= (1 << QOS_L3_OCCUP_EVENT_ID);
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL))
@@ -880,7 +913,7 @@ static __init bool get_rdt_mon_resources(void)
 	if (!rdt_mon_features)
 		return false;
 
-	return !rdt_get_mon_l3_config(&rdt_resources_all[RDT_RESOURCE_L3]);
+	return !rdt_get_mon_l3_config(r);
 }
 
 static __init void __check_quirks_intel(void)
@@ -918,9 +951,12 @@ static __init bool get_rdt_resources(void)
 
 static __init void rdt_init_res_defs_intel(void)
 {
+	struct rdt_hw_resource *hw_res;
 	struct rdt_resource *r;
 
 	for_each_rdt_resource(r) {
+		hw_res = resctrl_to_arch_res(r);
+
 		if (r->rid == RDT_RESOURCE_L3 ||
 		    r->rid == RDT_RESOURCE_L3DATA ||
 		    r->rid == RDT_RESOURCE_L3CODE ||
@@ -931,17 +967,20 @@ static __init void rdt_init_res_defs_intel(void)
 			r->cache.arch_has_empty_bitmaps = false;
 			r->cache.arch_has_per_cpu_cfg = false;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
-			r->msr_base = MSR_IA32_MBA_THRTL_BASE;
-			r->msr_update = mba_wrmsr_intel;
+			hw_res->msr_base = MSR_IA32_MBA_THRTL_BASE;
+			hw_res->msr_update = mba_wrmsr_intel;
 		}
 	}
 }
 
 static __init void rdt_init_res_defs_amd(void)
 {
+	struct rdt_hw_resource *hw_res;
 	struct rdt_resource *r;
 
 	for_each_rdt_resource(r) {
+		hw_res = resctrl_to_arch_res(r);
+
 		if (r->rid == RDT_RESOURCE_L3 ||
 		    r->rid == RDT_RESOURCE_L3DATA ||
 		    r->rid == RDT_RESOURCE_L3CODE ||
@@ -952,8 +991,8 @@ static __init void rdt_init_res_defs_amd(void)
 			r->cache.arch_has_empty_bitmaps = true;
 			r->cache.arch_has_per_cpu_cfg = true;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
-			r->msr_base = MSR_IA32_MBA_BW_BASE;
-			r->msr_update = mba_wrmsr_amd;
+			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
+			hw_res->msr_update = mba_wrmsr_amd;
 		}
 	}
 }
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index c877642..3f0c33d 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -284,10 +284,12 @@ done:
 static int rdtgroup_parse_resource(char *resname, char *tok,
 				   struct rdtgroup *rdtgrp)
 {
+	struct rdt_hw_resource *hw_res;
 	struct rdt_resource *r;
 
 	for_each_alloc_enabled_rdt_resource(r) {
-		if (!strcmp(resname, r->name) && rdtgrp->closid < r->num_closid)
+		hw_res = resctrl_to_arch_res(r);
+		if (!strcmp(resname, r->name) && rdtgrp->closid < hw_res->num_closid)
 			return parse_line(tok, r, rdtgrp);
 	}
 	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
@@ -394,6 +396,7 @@ static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v)
 {
+	struct rdt_hw_resource *hw_res;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	int ret = 0;
@@ -418,7 +421,8 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 		} else {
 			closid = rdtgrp->closid;
 			for_each_alloc_enabled_rdt_resource(r) {
-				if (closid < r->num_closid)
+				hw_res = resctrl_to_arch_res(r);
+				if (closid < hw_res->num_closid)
 					show_doms(s, r, closid);
 			}
 		}
@@ -449,6 +453,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of = m->private;
+	struct rdt_hw_resource *hw_res;
 	u32 resid, evtid, domid;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -468,7 +473,8 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	domid = md.u.domid;
 	evtid = md.u.evtid;
 
-	r = &rdt_resources_all[resid];
+	hw_res = &rdt_resources_all[resid];
+	r = &hw_res->r_resctrl;
 	d = rdt_find_domain(r, domid, NULL);
 	if (IS_ERR_OR_NULL(d)) {
 		ret = -ENOENT;
@@ -482,7 +488,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	else if (rr.val & RMID_VAL_UNAVAIL)
 		seq_puts(m, "Unavailable\n");
 	else
-		seq_printf(m, "%llu\n", rr.val * r->mon_scale);
+		seq_printf(m, "%llu\n", rr.val * hw_res->mon_scale);
 
 out:
 	rdtgroup_kn_unlock(of->kn);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 6a5f60a..caf9248 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_RESCTRL_INTERNAL_H
 #define _ASM_X86_RESCTRL_INTERNAL_H
 
+#include <linux/resctrl.h>
 #include <linux/sched.h>
 #include <linux/kernfs.h>
 #include <linux/fs_context.h>
@@ -353,67 +354,6 @@ struct msr_param {
 	int			high;
 };
 
-/**
- * struct rdt_cache - Cache allocation related data
- * @cbm_len:		Length of the cache bit mask
- * @min_cbm_bits:	Minimum number of consecutive bits to be set
- * @cbm_idx_mult:	Multiplier of CBM index
- * @cbm_idx_offset:	Offset of CBM index. CBM index is computed by:
- *			closid * cbm_idx_multi + cbm_idx_offset
- *			in a cache bit mask
- * @shareable_bits:	Bitmask of shareable resource with other
- *			executing entities
- * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
- * @arch_has_empty_bitmaps:	True if the '0' bitmap is valid.
- * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
- *				level has CPU scope.
- */
-struct rdt_cache {
-	unsigned int	cbm_len;
-	unsigned int	min_cbm_bits;
-	unsigned int	cbm_idx_mult;
-	unsigned int	cbm_idx_offset;
-	unsigned int	shareable_bits;
-	bool		arch_has_sparse_bitmaps;
-	bool		arch_has_empty_bitmaps;
-	bool		arch_has_per_cpu_cfg;
-};
-
-/**
- * enum membw_throttle_mode - System's memory bandwidth throttling mode
- * @THREAD_THROTTLE_UNDEFINED:	Not relevant to the system
- * @THREAD_THROTTLE_MAX:	Memory bandwidth is throttled at the core
- *				always using smallest bandwidth percentage
- *				assigned to threads, aka "max throttling"
- * @THREAD_THROTTLE_PER_THREAD:	Memory bandwidth is throttled at the thread
- */
-enum membw_throttle_mode {
-	THREAD_THROTTLE_UNDEFINED = 0,
-	THREAD_THROTTLE_MAX,
-	THREAD_THROTTLE_PER_THREAD,
-};
-
-/**
- * struct rdt_membw - Memory bandwidth allocation related data
- * @min_bw:		Minimum memory bandwidth percentage user can request
- * @bw_gran:		Granularity at which the memory bandwidth is allocated
- * @delay_linear:	True if memory B/W delay is in linear scale
- * @arch_needs_linear:	True if we can't configure non-linear resources
- * @throttle_mode:	Bandwidth throttling mode when threads request
- *			different memory bandwidths
- * @mba_sc:		True if MBA software controller(mba_sc) is enabled
- * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
- */
-struct rdt_membw {
-	u32				min_bw;
-	u32				bw_gran;
-	u32				delay_linear;
-	bool				arch_needs_linear;
-	enum membw_throttle_mode	throttle_mode;
-	bool				mba_sc;
-	u32				*mb_map;
-};
-
 static inline bool is_llc_occupancy_enabled(void)
 {
 	return (rdt_mon_features & (1 << QOS_L3_OCCUP_EVENT_ID));
@@ -446,58 +386,33 @@ struct rdt_parse_data {
 };
 
 /**
- * struct rdt_resource - attributes of an RDT resource
- * @rid:		The index of the resource
- * @alloc_enabled:	Is allocation enabled on this machine
- * @mon_enabled:	Is monitoring enabled for this feature
- * @alloc_capable:	Is allocation available on this machine
- * @mon_capable:	Is monitor feature available on this machine
- * @name:		Name to use in "schemata" file
- * @num_closid:		Number of CLOSIDs available
- * @cache_level:	Which cache level defines scope of this resource
- * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
+ * struct rdt_hw_resource - arch private attributes of a resctrl resource
+ * @r_resctrl:		Attributes of the resource used directly by resctrl.
+ * @num_closid:		Maximum number of closid this hardware can support.
  * @msr_base:		Base MSR address for CBMs
  * @msr_update:		Function pointer to update QOS MSRs
- * @data_width:		Character width of data when displaying
- * @domains:		All domains for this resource
- * @cache:		Cache allocation related data
- * @membw:		If the component has bandwidth controls, their properties.
- * @format_str:		Per resource format string to show domain value
- * @parse_ctrlval:	Per resource function pointer to parse control values
- * @evt_list:		List of monitoring events
- * @num_rmid:		Number of RMIDs available
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
  * @mbm_width:		Monitor width, to detect and correct for overflow.
- * @fflags:		flags to choose base and info files
+ *
+ * Members of this structure are either private to the architecture
+ * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
+ * msr_update and msr_base.
  */
-struct rdt_resource {
-	int			rid;
-	bool			alloc_enabled;
-	bool			mon_enabled;
-	bool			alloc_capable;
-	bool			mon_capable;
-	char			*name;
+struct rdt_hw_resource {
+	struct rdt_resource	r_resctrl;
 	int			num_closid;
-	int			cache_level;
-	u32			default_ctrl;
 	unsigned int		msr_base;
 	void (*msr_update)	(struct rdt_domain *d, struct msr_param *m,
 				 struct rdt_resource *r);
-	int			data_width;
-	struct list_head	domains;
-	struct rdt_cache	cache;
-	struct rdt_membw	membw;
-	const char		*format_str;
-	int (*parse_ctrlval)(struct rdt_parse_data *data,
-			     struct rdt_resource *r,
-			     struct rdt_domain *d);
-	struct list_head	evt_list;
-	int			num_rmid;
 	unsigned int		mon_scale;
 	unsigned int		mbm_width;
-	unsigned long		fflags;
 };
 
+static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
+{
+	return container_of(r, struct rdt_hw_resource, r_resctrl);
+}
+
 int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 	      struct rdt_domain *d);
 int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
@@ -505,7 +420,7 @@ int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
 
 extern struct mutex rdtgroup_mutex;
 
-extern struct rdt_resource rdt_resources_all[];
+extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 
@@ -524,33 +439,41 @@ enum {
 	RDT_NUM_RESOURCES,
 };
 
+static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
+{
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(res);
+
+	hw_res++;
+	return &hw_res->r_resctrl;
+}
+
+/*
+ * To return the common struct rdt_resource, which is contained in struct
+ * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
+ */
 #define for_each_rdt_resource(r)					      \
-	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
-	     r++)
+	for (r = &rdt_resources_all[0].r_resctrl;			      \
+	     r <= &rdt_resources_all[RDT_NUM_RESOURCES - 1].r_resctrl;	      \
+	     r = resctrl_inc(r))
 
 #define for_each_capable_rdt_resource(r)				      \
-	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
-	     r++)							      \
+	for_each_rdt_resource(r)					      \
 		if (r->alloc_capable || r->mon_capable)
 
 #define for_each_alloc_capable_rdt_resource(r)				      \
-	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
-	     r++)							      \
+	for_each_rdt_resource(r)					      \
 		if (r->alloc_capable)
 
 #define for_each_mon_capable_rdt_resource(r)				      \
-	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
-	     r++)							      \
+	for_each_rdt_resource(r)					      \
 		if (r->mon_capable)
 
 #define for_each_alloc_enabled_rdt_resource(r)				      \
-	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
-	     r++)							      \
+	for_each_rdt_resource(r)					      \
 		if (r->alloc_enabled)
 
 #define for_each_mon_enabled_rdt_resource(r)				      \
-	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
-	     r++)							      \
+	for_each_rdt_resource(r)					      \
 		if (r->mon_enabled)
 
 /* CPUID.(EAX=10H, ECX=ResID=1).EAX */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f07c10b..5daf584 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -174,7 +174,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 	struct rdt_resource *r;
 	u32 crmid = 1, nrmid;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3];
+	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
 	/*
 	 * Skip RMID 0 and start from RMID 1 and check all the RMIDs that
@@ -232,7 +232,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	int cpu;
 	u64 val;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3];
+	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
 	entry->busy = 0;
 	cpu = get_cpu();
@@ -287,6 +287,7 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 
 static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
 	struct mbm_state *m;
 	u64 chunks, tval;
 
@@ -319,7 +320,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 		return 0;
 	}
 
-	chunks = mbm_overflow_count(m->prev_msr, tval, rr->r->mbm_width);
+	chunks = mbm_overflow_count(m->prev_msr, tval, hw_res->mbm_width);
 	m->chunks += chunks;
 	m->prev_msr = tval;
 
@@ -334,7 +335,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
  */
 static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3];
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
 	struct mbm_state *m = &rr->d->mbm_local[rmid];
 	u64 tval, cur_bw, chunks;
 
@@ -342,8 +343,8 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL))
 		return;
 
-	chunks = mbm_overflow_count(m->prev_bw_msr, tval, rr->r->mbm_width);
-	cur_bw = (get_corrected_mbm_count(rmid, chunks) * r->mon_scale) >> 20;
+	chunks = mbm_overflow_count(m->prev_bw_msr, tval, hw_res->mbm_width);
+	cur_bw = (get_corrected_mbm_count(rmid, chunks) * hw_res->mon_scale) >> 20;
 
 	if (m->delta_comp)
 		m->delta_bw = abs(cur_bw - m->prev_bw);
@@ -416,6 +417,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 {
 	u32 closid, rmid, cur_msr, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
+	struct rdt_hw_resource *hw_r_mba;
 	u32 cur_bw, delta_bw, user_bw;
 	struct rdt_resource *r_mba;
 	struct rdt_domain *dom_mba;
@@ -425,7 +427,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	if (!is_mbm_local_enabled())
 		return;
 
-	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA];
+	hw_r_mba = &rdt_resources_all[RDT_RESOURCE_MBA];
+	r_mba = &hw_r_mba->r_resctrl;
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
 	pmbm_data = &dom_mbm->mbm_local[rmid];
@@ -474,7 +477,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 		return;
 	}
 
-	cur_msr = r_mba->msr_base + closid;
+	cur_msr = hw_r_mba->msr_base + closid;
 	wrmsrl(cur_msr, delay_bw_map(new_msr_val, r_mba));
 	dom_mba->ctrl_val[closid] = new_msr_val;
 
@@ -538,7 +541,7 @@ void cqm_handle_limbo(struct work_struct *work)
 
 	mutex_lock(&rdtgroup_mutex);
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3];
+	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	d = container_of(work, struct rdt_domain, cqm_limbo.work);
 
 	__check_limbo(d, false);
@@ -574,7 +577,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	if (!static_branch_likely(&rdt_mon_enable_key))
 		goto out_unlock;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3];
+	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	d = container_of(work, struct rdt_domain, mbm_over.work);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
@@ -671,15 +674,16 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 int rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	unsigned int cl_size = boot_cpu_data.x86_cache_size;
 	int ret;
 
-	r->mon_scale = boot_cpu_data.x86_cache_occ_scale;
+	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
 	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
-	r->mbm_width = MBM_CNTR_WIDTH_BASE;
+	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
 
 	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
-		r->mbm_width += mbm_offset;
+		hw_res->mbm_width += mbm_offset;
 	else if (mbm_offset > MBM_CNTR_WIDTH_OFFSET_MAX)
 		pr_warn("Ignoring impossible MBM counter offset\n");
 
@@ -693,7 +697,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 	resctrl_cqm_threshold = cl_size * 1024 / r->num_rmid;
 
 	/* h/w works in units of "boot_cpu_data.x86_cache_occ_scale" */
-	resctrl_cqm_threshold /= r->mon_scale;
+	resctrl_cqm_threshold /= hw_res->mon_scale;
 
 	ret = dom_data_init(r);
 	if (ret)
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 2207916..17868ac 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -688,8 +688,8 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
 	 *   resource, the portion of cache used by it should be made
 	 *   unavailable to all future allocations from both resources.
 	 */
-	if (rdt_resources_all[RDT_RESOURCE_L3DATA].alloc_enabled ||
-	    rdt_resources_all[RDT_RESOURCE_L2DATA].alloc_enabled) {
+	if (rdt_resources_all[RDT_RESOURCE_L3DATA].r_resctrl.alloc_enabled ||
+	    rdt_resources_all[RDT_RESOURCE_L2DATA].r_resctrl.alloc_enabled) {
 		rdt_last_cmd_puts("CDP enabled\n");
 		return -EINVAL;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 01fd30e..d49a007 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -100,12 +100,15 @@ int closids_supported(void)
 
 static void closid_init(void)
 {
+	struct rdt_hw_resource *hw_res;
 	struct rdt_resource *r;
 	int rdt_min_closid = 32;
 
 	/* Compute rdt_min_closid across all resources */
-	for_each_alloc_enabled_rdt_resource(r)
-		rdt_min_closid = min(rdt_min_closid, r->num_closid);
+	for_each_alloc_enabled_rdt_resource(r) {
+		hw_res = resctrl_to_arch_res(r);
+		rdt_min_closid = min(rdt_min_closid, hw_res->num_closid);
+	}
 
 	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
 
@@ -843,8 +846,10 @@ static int rdt_num_closids_show(struct kernfs_open_file *of,
 				struct seq_file *seq, void *v)
 {
 	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_hw_resource *hw_res;
 
-	seq_printf(seq, "%d\n", r->num_closid);
+	hw_res = resctrl_to_arch_res(r);
+	seq_printf(seq, "%d\n", hw_res->num_closid);
 	return 0;
 }
 
@@ -1020,8 +1025,9 @@ static int max_threshold_occ_show(struct kernfs_open_file *of,
 				  struct seq_file *seq, void *v)
 {
 	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
-	seq_printf(seq, "%u\n", resctrl_cqm_threshold * r->mon_scale);
+	seq_printf(seq, "%u\n", resctrl_cqm_threshold * hw_res->mon_scale);
 
 	return 0;
 }
@@ -1042,7 +1048,7 @@ static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
 static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 				       char *buf, size_t nbytes, loff_t off)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_hw_resource *hw_res;
 	unsigned int bytes;
 	int ret;
 
@@ -1053,7 +1059,8 @@ static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 	if (bytes > (boot_cpu_data.x86_cache_size * 1024))
 		return -EINVAL;
 
-	resctrl_cqm_threshold = bytes / r->mon_scale;
+	hw_res = resctrl_to_arch_res(of->kn->parent->priv);
+	resctrl_cqm_threshold = bytes / hw_res->mon_scale;
 
 	return nbytes;
 }
@@ -1111,16 +1118,16 @@ static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
 
 	switch (r->rid) {
 	case RDT_RESOURCE_L3DATA:
-		_r_cdp = &rdt_resources_all[RDT_RESOURCE_L3CODE];
+		_r_cdp = &rdt_resources_all[RDT_RESOURCE_L3CODE].r_resctrl;
 		break;
 	case RDT_RESOURCE_L3CODE:
-		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L3DATA];
+		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L3DATA].r_resctrl;
 		break;
 	case RDT_RESOURCE_L2DATA:
-		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2CODE];
+		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2CODE].r_resctrl;
 		break;
 	case RDT_RESOURCE_L2CODE:
-		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2DATA];
+		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2DATA].r_resctrl;
 		break;
 	default:
 		ret = -ENOENT;
@@ -1867,7 +1874,7 @@ static void l2_qos_cfg_update(void *arg)
 
 static inline bool is_mba_linear(void)
 {
-	return rdt_resources_all[RDT_RESOURCE_MBA].membw.delay_linear;
+	return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.delay_linear;
 }
 
 static int set_cache_qos_cfg(int level, bool enable)
@@ -1888,7 +1895,7 @@ static int set_cache_qos_cfg(int level, bool enable)
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
-	r_l = &rdt_resources_all[level];
+	r_l = &rdt_resources_all[level].r_resctrl;
 	list_for_each_entry(d, &r_l->domains, list) {
 		if (r_l->cache.arch_has_per_cpu_cfg)
 			/* Pick all the CPUs in the domain instance */
@@ -1917,10 +1924,10 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 	if (!r->alloc_capable)
 		return;
 
-	if (r == &rdt_resources_all[RDT_RESOURCE_L2DATA])
+	if (r == &rdt_resources_all[RDT_RESOURCE_L2DATA].r_resctrl)
 		l2_qos_cfg_update(&r->alloc_enabled);
 
-	if (r == &rdt_resources_all[RDT_RESOURCE_L3DATA])
+	if (r == &rdt_resources_all[RDT_RESOURCE_L3DATA].r_resctrl)
 		l3_qos_cfg_update(&r->alloc_enabled);
 }
 
@@ -1932,7 +1939,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
  */
 static int set_mba_sc(bool mba_sc)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA];
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 	struct rdt_domain *d;
 
 	if (!is_mbm_enabled() || !is_mba_linear() ||
@@ -1948,9 +1955,9 @@ static int set_mba_sc(bool mba_sc)
 
 static int cdp_enable(int level, int data_type, int code_type)
 {
-	struct rdt_resource *r_ldata = &rdt_resources_all[data_type];
-	struct rdt_resource *r_lcode = &rdt_resources_all[code_type];
-	struct rdt_resource *r_l = &rdt_resources_all[level];
+	struct rdt_resource *r_ldata = &rdt_resources_all[data_type].r_resctrl;
+	struct rdt_resource *r_lcode = &rdt_resources_all[code_type].r_resctrl;
+	struct rdt_resource *r_l = &rdt_resources_all[level].r_resctrl;
 	int ret;
 
 	if (!r_l->alloc_capable || !r_ldata->alloc_capable ||
@@ -1980,13 +1987,13 @@ static int cdpl2_enable(void)
 
 static void cdp_disable(int level, int data_type, int code_type)
 {
-	struct rdt_resource *r = &rdt_resources_all[level];
+	struct rdt_resource *r = &rdt_resources_all[level].r_resctrl;
 
 	r->alloc_enabled = r->alloc_capable;
 
-	if (rdt_resources_all[data_type].alloc_enabled) {
-		rdt_resources_all[data_type].alloc_enabled = false;
-		rdt_resources_all[code_type].alloc_enabled = false;
+	if (rdt_resources_all[data_type].r_resctrl.alloc_enabled) {
+		rdt_resources_all[data_type].r_resctrl.alloc_enabled = false;
+		rdt_resources_all[code_type].r_resctrl.alloc_enabled = false;
 		set_cache_qos_cfg(level, false);
 	}
 }
@@ -2003,9 +2010,9 @@ static void cdpl2_disable(void)
 
 static void cdp_disable_all(void)
 {
-	if (rdt_resources_all[RDT_RESOURCE_L3DATA].alloc_enabled)
+	if (rdt_resources_all[RDT_RESOURCE_L3DATA].r_resctrl.alloc_enabled)
 		cdpl3_disable();
-	if (rdt_resources_all[RDT_RESOURCE_L2DATA].alloc_enabled)
+	if (rdt_resources_all[RDT_RESOURCE_L2DATA].r_resctrl.alloc_enabled)
 		cdpl2_disable();
 }
 
@@ -2153,7 +2160,7 @@ static int rdt_get_tree(struct fs_context *fc)
 		static_branch_enable_cpuslocked(&rdt_enable_key);
 
 	if (is_mbm_enabled()) {
-		r = &rdt_resources_all[RDT_RESOURCE_L3];
+		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 		list_for_each_entry(dom, &r->domains, list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
 	}
@@ -2257,6 +2264,7 @@ static int rdt_init_fs_context(struct fs_context *fc)
 
 static int reset_all_ctrls(struct rdt_resource *r)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
@@ -2267,7 +2275,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
 
 	msr_param.res = r;
 	msr_param.low = 0;
-	msr_param.high = r->num_closid;
+	msr_param.high = hw_res->num_closid;
 
 	/*
 	 * Disable resource control for this resource by setting all
@@ -2277,7 +2285,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	list_for_each_entry(d, &r->domains, list) {
 		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 
-		for (i = 0; i < r->num_closid; i++)
+		for (i = 0; i < hw_res->num_closid; i++)
 			d->ctrl_val[i] = r->default_ctrl;
 	}
 	cpu = get_cpu();
@@ -3124,13 +3132,13 @@ out:
 
 static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 {
-	if (rdt_resources_all[RDT_RESOURCE_L3DATA].alloc_enabled)
+	if (rdt_resources_all[RDT_RESOURCE_L3DATA].r_resctrl.alloc_enabled)
 		seq_puts(seq, ",cdp");
 
-	if (rdt_resources_all[RDT_RESOURCE_L2DATA].alloc_enabled)
+	if (rdt_resources_all[RDT_RESOURCE_L2DATA].r_resctrl.alloc_enabled)
 		seq_puts(seq, ",cdpl2");
 
-	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA]))
+	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
 		seq_puts(seq, ",mba_MBps");
 
 	return 0;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 9b05af9..5ccf36b 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -2,6 +2,8 @@
 #ifndef _RESCTRL_H
 #define _RESCTRL_H
 
+#include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/pid.h>
 
 #ifdef CONFIG_PROC_CPU_RESCTRL
@@ -13,4 +15,112 @@ int proc_resctrl_show(struct seq_file *m,
 
 #endif
 
+struct rdt_domain;
+
+/**
+ * struct resctrl_cache - Cache allocation related data
+ * @cbm_len:		Length of the cache bit mask
+ * @min_cbm_bits:	Minimum number of consecutive bits to be set
+ * @cbm_idx_mult:	Multiplier of CBM index
+ * @cbm_idx_offset:	Offset of CBM index. CBM index is computed by:
+ *			closid * cbm_idx_multi + cbm_idx_offset
+ *			in a cache bit mask
+ * @shareable_bits:	Bitmask of shareable resource with other
+ *			executing entities
+ * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
+ * @arch_has_empty_bitmaps:	True if the '0' bitmap is valid.
+ * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
+ *				level has CPU scope.
+ */
+struct resctrl_cache {
+	unsigned int	cbm_len;
+	unsigned int	min_cbm_bits;
+	unsigned int	cbm_idx_mult;	// TODO remove this
+	unsigned int	cbm_idx_offset; // TODO remove this
+	unsigned int	shareable_bits;
+	bool		arch_has_sparse_bitmaps;
+	bool		arch_has_empty_bitmaps;
+	bool		arch_has_per_cpu_cfg;
+};
+
+/**
+ * enum membw_throttle_mode - System's memory bandwidth throttling mode
+ * @THREAD_THROTTLE_UNDEFINED:	Not relevant to the system
+ * @THREAD_THROTTLE_MAX:	Memory bandwidth is throttled at the core
+ *				always using smallest bandwidth percentage
+ *				assigned to threads, aka "max throttling"
+ * @THREAD_THROTTLE_PER_THREAD:	Memory bandwidth is throttled at the thread
+ */
+enum membw_throttle_mode {
+	THREAD_THROTTLE_UNDEFINED = 0,
+	THREAD_THROTTLE_MAX,
+	THREAD_THROTTLE_PER_THREAD,
+};
+
+/**
+ * struct resctrl_membw - Memory bandwidth allocation related data
+ * @min_bw:		Minimum memory bandwidth percentage user can request
+ * @bw_gran:		Granularity at which the memory bandwidth is allocated
+ * @delay_linear:	True if memory B/W delay is in linear scale
+ * @arch_needs_linear:	True if we can't configure non-linear resources
+ * @throttle_mode:	Bandwidth throttling mode when threads request
+ *			different memory bandwidths
+ * @mba_sc:		True if MBA software controller(mba_sc) is enabled
+ * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
+ */
+struct resctrl_membw {
+	u32				min_bw;
+	u32				bw_gran;
+	u32				delay_linear;
+	bool				arch_needs_linear;
+	enum membw_throttle_mode	throttle_mode;
+	bool				mba_sc;
+	u32				*mb_map;
+};
+
+struct rdt_parse_data;
+
+/**
+ * struct rdt_resource - attributes of a resctrl resource
+ * @rid:		The index of the resource
+ * @alloc_enabled:	Is allocation enabled on this machine
+ * @mon_enabled:	Is monitoring enabled for this feature
+ * @alloc_capable:	Is allocation available on this machine
+ * @mon_capable:	Is monitor feature available on this machine
+ * @num_rmid:		Number of RMIDs available
+ * @cache_level:	Which cache level defines scope of this resource
+ * @cache:		Cache allocation related data
+ * @membw:		If the component has bandwidth controls, their properties.
+ * @domains:		All domains for this resource
+ * @name:		Name to use in "schemata" file.
+ * @data_width:		Character width of data when displaying
+ * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
+ * @format_str:		Per resource format string to show domain value
+ * @parse_ctrlval:	Per resource function pointer to parse control values
+ * @evt_list:		List of monitoring events
+ * @fflags:		flags to choose base and info files
+ */
+struct rdt_resource {
+	int			rid;
+	bool			alloc_enabled;
+	bool			mon_enabled;
+	bool			alloc_capable;
+	bool			mon_capable;
+	int			num_rmid;
+	int			cache_level;
+	struct resctrl_cache	cache;
+	struct resctrl_membw	membw;
+	struct list_head	domains;
+	char			*name;
+	int			data_width;
+	u32			default_ctrl;
+	const char		*format_str;
+	int			(*parse_ctrlval)(struct rdt_parse_data *data,
+						 struct rdt_resource *r,
+						 struct rdt_domain *d);
+	struct list_head	evt_list;
+	unsigned long		fflags;
+
+};
+
 #endif /* _RESCTRL_H */
