Return-Path: <linux-tip-commits+bounces-4166-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B600A5E2A9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE7316AB6F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E86261571;
	Wed, 12 Mar 2025 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eaV8U+QJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jq0tIl0F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A71260371;
	Wed, 12 Mar 2025 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800045; cv=none; b=kAZK2LoqF3yHq60Vo78he/NNnrnhy5vMDAuo0s4mlJelQoHYDULIugvIfT+rXbsjdsankwuGknudYBs8Zr9k5y4G7VKVzjQMfv+S0UKhGKqLR3m6l2xFwZpQAFCncWR5betPEpQcFLdvWyNfFmjQxky1GKzap3qwVUmL6ArM8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800045; c=relaxed/simple;
	bh=tZNJCogvijc0A7GrqJnOpRhvRaQ4znXdMIVzDHGCV+8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PzMnssUYAUXJGmRuV8avol0y9OWH1ipD1bOHI9x5VXXzeHW97leUZOe2MH57Yeki9DDmC8Ozxf7pDW1XFAbjITHQ3ipAqVJLF9I3YzSa7Fvu3szpKTsI4E/VMyKv7uqzcf5jctOkH3FyVAdogUvt5JeYVIwIa/mHXJBftFuprX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eaV8U+QJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jq0tIl0F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWNsyAJ5QpgLRwMZ1v5JH29l5RgOTzo4F+DnZOKhjZY=;
	b=eaV8U+QJACymyWajHvJhKP86XgGW3m0g5kie8Ivn7whKY7zWaPjUhst+hGJkRFLt3WSw3f
	lt3CrIfRDEd1zrlgWE/GK8z1xQUf6a8saAajiTxEnBpNjqnTPoxQjfhAdZwtvy3GHdda86
	4l3E3cHp1H7I2JActXbF6pxU2GuTVGdSmx4N0lrfUwAfXe2VPPDlkRgEJ4g80x9BIS3Zy5
	hWamAfA9Oiz/w8aRnZwx3IXQUPlSSAuxgTbdC7TJPGud4MNbeD025JGZCydTXxLt0Ayoqc
	vKv8xeFg6FBI98/wcXDioKhhPs/S4ffufHhs70zLc3TPNNLC6tWDAjUamd9B0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWNsyAJ5QpgLRwMZ1v5JH29l5RgOTzo4F+DnZOKhjZY=;
	b=jq0tIl0Fp+vc+y1qLoFvqRb4HtbCBKJyrHLfEfmdW93EgldoPgKwpAvbuqkoJquN4cf8jy
	ok2ZovQohrx/vuDw==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add a helper to avoid reaching into the
 arch code resource list
Cc: Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>, Babu Moger <babu.moger@amd.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-3-james.morse@arm.com>
References: <20250311183715.16445-3-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180004055.14745.5374468530139576657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     3c021531131c9ee5df5da739819a515326ee9570
Gitweb:        https://git.kernel.org/tip/3c021531131c9ee5df5da739819a515326ee9570
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:36:47 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:22:22 +01:00

x86/resctrl: Add a helper to avoid reaching into the arch code resource list

Resctrl occasionally wants to know something about a specific resource, in
these cases it reaches into the arch code's rdt_resources_all[] array.

Once the filesystem parts of resctrl are moved to /fs/, this means it will
need visibility of the architecture specific struct rdt_hw_resource
definition, and the array of all resources.  All architectures would also need
a r_resctrl member in this struct.

Instead, abstract this via a helper to allow architectures to do different
things here. Move the level enum to the resctrl header and add a helper to
retrieve the struct rdt_resource by 'rid'.

resctrl_arch_get_resource() should not return NULL for any value in the enum,
it may instead return a dummy resource that is !alloc_enabled && !mon_enabled.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20250311183715.16445-3-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 12 ++++++++++--
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 10 ----------
 arch/x86/kernel/cpu/resctrl/monitor.c     |  8 ++++----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 14 +++++++-------
 include/linux/resctrl.h                   | 17 +++++++++++++++++
 6 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 3d1735e..12b4131 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -62,7 +62,7 @@ static void mba_wrmsr_amd(struct msr_param *m);
 #define ctrl_domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.ctrl_domains)
 #define mon_domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.mon_domains)
 
-struct rdt_hw_resource rdt_resources_all[] = {
+struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 	[RDT_RESOURCE_L3] =
 	{
 		.r_resctrl = {
@@ -127,6 +127,14 @@ u32 resctrl_arch_system_num_rmid_idx(void)
 	return r->num_rmid;
 }
 
+struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
+{
+	if (l >= RDT_NUM_RESOURCES)
+		return NULL;
+
+	return &rdt_resources_all[l].r_resctrl;
+}
+
 /*
  * cache_alloc_hsw_probe() - Have to probe for Intel haswell server CPUs
  * as they do not have CPUID enumeration support for Cache allocation.
@@ -174,7 +182,7 @@ static inline void cache_alloc_hsw_probe(void)
 bool is_mba_sc(struct rdt_resource *r)
 {
 	if (!r)
-		return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.mba_sc;
+		r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 
 	/*
 	 * The software controller support is only applicable to MBA resource.
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 5363511..4af27ef 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -649,7 +649,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	resid = md.u.rid;
 	domid = md.u.domid;
 	evtid = md.u.evtid;
-	r = &rdt_resources_all[resid].r_resctrl;
+	r = resctrl_arch_get_resource(resid);
 
 	if (md.u.sum) {
 		/*
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 20c898f..75252a7 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -512,16 +512,6 @@ extern struct rdtgroup rdtgroup_default;
 extern struct dentry *debugfs_resctrl;
 extern enum resctrl_event_id mba_mbps_default_event;
 
-enum resctrl_res_level {
-	RDT_RESOURCE_L3,
-	RDT_RESOURCE_L2,
-	RDT_RESOURCE_MBA,
-	RDT_RESOURCE_SMBA,
-
-	/* Must be the last */
-	RDT_NUM_RESOURCES,
-};
-
 static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(res);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 94a1d97..58b5b21 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -365,7 +365,7 @@ static void limbo_release_entry(struct rmid_entry *entry)
  */
 void __check_limbo(struct rdt_mon_domain *d, bool force_free)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry;
 	u32 idx, cur_idx = 1;
@@ -521,7 +521,7 @@ int alloc_rmid(u32 closid)
 
 static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	struct rdt_mon_domain *d;
 	u32 idx;
 
@@ -761,7 +761,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
 	struct rdtgroup *entry;
 	u32 cur_bw, user_bw;
 
-	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+	r_mba = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 	evt_id = rgrp->mba_mbps_event;
 
 	closid = rgrp->closid;
@@ -925,7 +925,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	if (!resctrl_mounted || !resctrl_arch_mon_capable())
 		goto out_unlock;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	d = container_of(work, struct rdt_mon_domain, mbm_over.work);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 04b653d..45093b9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2256,7 +2256,7 @@ static void l2_qos_cfg_update(void *arg)
 
 static inline bool is_mba_linear(void)
 {
-	return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.delay_linear;
+	return resctrl_arch_get_resource(RDT_RESOURCE_MBA)->membw.delay_linear;
 }
 
 static int set_cache_qos_cfg(int level, bool enable)
@@ -2346,8 +2346,8 @@ static void mba_sc_domain_destroy(struct rdt_resource *r,
  */
 static bool supports_mba_mbps(void)
 {
-	struct rdt_resource *rmbm = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+	struct rdt_resource *rmbm = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 
 	return (is_mbm_enabled() &&
 		r->alloc_capable && is_mba_linear() &&
@@ -2360,7 +2360,7 @@ static bool supports_mba_mbps(void)
  */
 static int set_mba_sc(bool mba_sc)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 	u32 num_closid = resctrl_arch_get_num_closid(r);
 	struct rdt_ctrl_domain *d;
 	unsigned long fflags;
@@ -2714,7 +2714,7 @@ static int rdt_get_tree(struct fs_context *fc)
 		resctrl_mounted = true;
 
 	if (is_mbm_enabled()) {
-		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+		r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 		list_for_each_entry(dom, &r->mon_domains, hdr.list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
 						   RESCTRL_PICK_ANY_CPU);
@@ -3951,7 +3951,7 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
 		seq_puts(seq, ",cdpl2");
 
-	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
+	if (is_mba_sc(resctrl_arch_get_resource(RDT_RESOURCE_MBA)))
 		seq_puts(seq, ",mba_MBps");
 
 	if (resctrl_debug)
@@ -4151,7 +4151,7 @@ static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
 
 void resctrl_offline_cpu(unsigned int cpu)
 {
-	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_resource *l3 = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	struct rdt_mon_domain *d;
 	struct rdtgroup *rdtgrp;
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index d94abba..37279e2 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -37,6 +37,16 @@ enum resctrl_conf_type {
 	CDP_DATA,
 };
 
+enum resctrl_res_level {
+	RDT_RESOURCE_L3,
+	RDT_RESOURCE_L2,
+	RDT_RESOURCE_MBA,
+	RDT_RESOURCE_SMBA,
+
+	/* Must be the last */
+	RDT_NUM_RESOURCES,
+};
+
 #define CDP_NUM_TYPES	(CDP_DATA + 1)
 
 /*
@@ -226,6 +236,13 @@ struct rdt_resource {
 	bool			cdp_capable;
 };
 
+/*
+ * Get the resource that exists at this level. If the level is not supported
+ * a dummy/not-capable resource can be returned. Levels >= RDT_NUM_RESOURCES
+ * will return NULL.
+ */
+struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l);
+
 /**
  * struct resctrl_schema - configuration abilities of a resource presented to
  *			   user-space

