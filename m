Return-Path: <linux-tip-commits+bounces-4150-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CABA5E288
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE90A17C0FD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6321F25CC93;
	Wed, 12 Mar 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HC91R7Zm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NhXJwPwR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832CE25A34D;
	Wed, 12 Mar 2025 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800032; cv=none; b=USVOvEfDdzKSOXr02VeQydSYK0UpFJmCW9vzzJcFwR9SQnED23RLmUX7nKG/p0w3+nTwd7ecDInTKfHe3p7CIGVo92C9xJ0ovFmKMqdxh0WVFMuQLofEhok76bnC8O1+PA/IrtjYKpLeAnM1mlZVIrxrTEqhWUpJPY8nPhj5RQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800032; c=relaxed/simple;
	bh=hWqjov6nrVhQbAd1iSWM8zdRD3j1rjsuPXPMSmhKwRM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ic5hlTDdWEd+ehX88spMzt0gxIsGQJLbrrrHk1c+9s4lBJj42v0e/+22pZKSAqjvUVcM9JKEs4e+lXVDxpsXjSIfyhjC4eZaxxZvzhKXTrj9icLZKzB3zMYwP/jD5GGrbaXdWCetvg1Gkj2ixRMqEm806aVOMpmBfWoeCoOssOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HC91R7Zm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NhXJwPwR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCPYnyk2s14jhZkC5U8dHgVmFzgWc9PXxW54PIRaHU0=;
	b=HC91R7Zmq1PcAWteVM17Vk7yTXZlfu9tVQgis/QBMA+VBGhOXvYRs1729iSDkuO2H2QcSP
	HbQoqduvzLGcdB4g+Y85jxOETpxRT8gIfoazS0SPeYAcqIN2E3Y3tmHpzLjj7Ih0uwn22u
	IZFTxyORmIU9jem8wTG2dmeznPm6FdUkxbQaGm3h1cCapsLUZpEfZBOltYQqPmPDiz13tp
	tr57d2npjtcyHuxgKKDRWQL2FR2tkuR90/Emmy4E4Leym3m7XIck1Rb83rur85n6pDiCeQ
	N7uvE9hfYtKty/iEFPyiWDta/thrdTtxB84eu7XYjB2b3k7qFe3xC3IZKU2m8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCPYnyk2s14jhZkC5U8dHgVmFzgWc9PXxW54PIRaHU0=;
	b=NhXJwPwR6yIlA1dngDQaSE6Tonvu5Xh9vAFxW6B0x6BLcrGMeciNTsXQZnqnzkznGARqyG
	R/8w7XAl7zDsmmCQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move the is_mbm_*_enabled() helpers to
 asm/resctrl.h
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-19-james.morse@arm.com>
References: <20250311183715.16445-19-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180002709.14745.2014515936219229070.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     d012b66a16618509242a51f5f6c9b19868ba5159
Gitweb:        https://git.kernel.org/tip/d012b66a16618509242a51f5f6c9b19868ba5159
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:37:03 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:23:33 +01:00

x86/resctrl: Move the is_mbm_*_enabled() helpers to asm/resctrl.h

The architecture specific parts of resctrl provide helpers like
is_mbm_total_enabled() and is_mbm_local_enabled() to hide accesses to the
rdt_mon_features bitmap.

Exposing a group of helpers between the architecture and filesystem code is
preferable to a single unsigned-long like rdt_mon_features. Helpers can be more
readable and have a well defined behaviour, while allowing architectures to hide
more complex behaviour.

Once the filesystem parts of resctrl are moved, these existing helpers can no
longer live in internal.h. Move them to include/linux/resctrl.h Once these are
exposed to the wider kernel, they should have a 'resctrl_arch_' prefix, to fit
the rest of the arch<->fs interface.

Move and rename the helpers that touch rdt_mon_features directly. is_mbm_event()
and is_mbm_enabled() are only called from rdtgroup.c, so can be moved into that
file.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20250311183715.16445-19-james.morse@arm.com
---
 arch/x86/include/asm/resctrl.h            | 16 +++++++++-
 arch/x86/kernel/cpu/resctrl/core.c        |  8 ++--
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 27 +---------------
 arch/x86/kernel/cpu/resctrl/monitor.c     | 16 ++++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 40 ++++++++++++++--------
 6 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 52f2326..6d4c7ea 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -42,6 +42,7 @@ DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
 
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
+extern unsigned int rdt_mon_features;
 
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
@@ -81,6 +82,21 @@ static inline void resctrl_arch_disable_mon(void)
 	static_branch_dec_cpuslocked(&rdt_enable_key);
 }
 
+static inline bool resctrl_arch_is_llc_occupancy_enabled(void)
+{
+	return (rdt_mon_features & (1 << QOS_L3_OCCUP_EVENT_ID));
+}
+
+static inline bool resctrl_arch_is_mbm_total_enabled(void)
+{
+	return (rdt_mon_features & (1 << QOS_L3_MBM_TOTAL_EVENT_ID));
+}
+
+static inline bool resctrl_arch_is_mbm_local_enabled(void)
+{
+	return (rdt_mon_features & (1 << QOS_L3_MBM_LOCAL_EVENT_ID));
+}
+
 /*
  * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
  *
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index a1577bd..eba210d 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -453,13 +453,13 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_mon_domain *hw_dom)
 {
 	size_t tsize;
 
-	if (is_mbm_total_enabled()) {
+	if (resctrl_arch_is_mbm_total_enabled()) {
 		tsize = sizeof(*hw_dom->arch_mbm_total);
 		hw_dom->arch_mbm_total = kcalloc(num_rmid, tsize, GFP_KERNEL);
 		if (!hw_dom->arch_mbm_total)
 			return -ENOMEM;
 	}
-	if (is_mbm_local_enabled()) {
+	if (resctrl_arch_is_mbm_local_enabled()) {
 		tsize = sizeof(*hw_dom->arch_mbm_local);
 		hw_dom->arch_mbm_local = kcalloc(num_rmid, tsize, GFP_KERNEL);
 		if (!hw_dom->arch_mbm_local) {
@@ -908,9 +908,9 @@ static __init bool get_rdt_mon_resources(void)
 	if (!rdt_mon_features)
 		return false;
 
-	if (is_mbm_local_enabled())
+	if (resctrl_arch_is_mbm_local_enabled())
 		mba_mbps_default_event = QOS_L3_MBM_LOCAL_EVENT_ID;
-	else if (is_mbm_total_enabled())
+	else if (resctrl_arch_is_mbm_total_enabled())
 		mba_mbps_default_event = QOS_L3_MBM_TOTAL_EVENT_ID;
 
 	return !rdt_get_mon_l3_config(r);
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 763317e..1ecc932 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -559,12 +559,12 @@ ssize_t rdtgroup_mba_mbps_event_write(struct kernfs_open_file *of,
 	rdt_last_cmd_clear();
 
 	if (!strcmp(buf, "mbm_local_bytes")) {
-		if (is_mbm_local_enabled())
+		if (resctrl_arch_is_mbm_local_enabled())
 			rdtgrp->mba_mbps_event = QOS_L3_MBM_LOCAL_EVENT_ID;
 		else
 			ret = -EINVAL;
 	} else if (!strcmp(buf, "mbm_total_bytes")) {
-		if (is_mbm_total_enabled())
+		if (resctrl_arch_is_mbm_total_enabled())
 			rdtgrp->mba_mbps_event = QOS_L3_MBM_TOTAL_EVENT_ID;
 		else
 			ret = -EINVAL;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 82dbc16..4a5996d 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -156,7 +156,6 @@ struct rmid_read {
 	void			*arch_mon_ctx;
 };
 
-extern unsigned int rdt_mon_features;
 extern struct list_head resctrl_schema_all;
 extern bool resctrl_mounted;
 
@@ -406,32 +405,6 @@ struct msr_param {
 	u32			high;
 };
 
-static inline bool is_llc_occupancy_enabled(void)
-{
-	return (rdt_mon_features & (1 << QOS_L3_OCCUP_EVENT_ID));
-}
-
-static inline bool is_mbm_total_enabled(void)
-{
-	return (rdt_mon_features & (1 << QOS_L3_MBM_TOTAL_EVENT_ID));
-}
-
-static inline bool is_mbm_local_enabled(void)
-{
-	return (rdt_mon_features & (1 << QOS_L3_MBM_LOCAL_EVENT_ID));
-}
-
-static inline bool is_mbm_enabled(void)
-{
-	return (is_mbm_total_enabled() || is_mbm_local_enabled());
-}
-
-static inline bool is_mbm_event(int e)
-{
-	return (e >= QOS_L3_MBM_TOTAL_EVENT_ID &&
-		e <= QOS_L3_MBM_LOCAL_EVENT_ID);
-}
-
 /**
  * struct rdt_hw_resource - arch private attributes of a resctrl resource
  * @r_resctrl:		Attributes of the resource used directly by resctrl.
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 1730ba8..d883ed5 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -295,11 +295,11 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *
 {
 	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
 
-	if (is_mbm_total_enabled())
+	if (resctrl_arch_is_mbm_total_enabled())
 		memset(hw_dom->arch_mbm_total, 0,
 		       sizeof(*hw_dom->arch_mbm_total) * r->num_rmid);
 
-	if (is_mbm_local_enabled())
+	if (resctrl_arch_is_mbm_local_enabled())
 		memset(hw_dom->arch_mbm_local, 0,
 		       sizeof(*hw_dom->arch_mbm_local) * r->num_rmid);
 }
@@ -569,7 +569,7 @@ void free_rmid(u32 closid, u32 rmid)
 
 	entry = __rmid_entry(idx);
 
-	if (is_llc_occupancy_enabled())
+	if (resctrl_arch_is_llc_occupancy_enabled())
 		add_rmid_to_limbo(entry);
 	else
 		list_add_tail(&entry->list, &rmid_free_lru);
@@ -852,10 +852,10 @@ static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
 	 * This is protected from concurrent reads from user as both
 	 * the user and overflow handler hold the global mutex.
 	 */
-	if (is_mbm_total_enabled())
+	if (resctrl_arch_is_mbm_total_enabled())
 		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_TOTAL_EVENT_ID);
 
-	if (is_mbm_local_enabled())
+	if (resctrl_arch_is_mbm_local_enabled())
 		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_LOCAL_EVENT_ID);
 }
 
@@ -1085,11 +1085,11 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 {
 	INIT_LIST_HEAD(&r->evt_list);
 
-	if (is_llc_occupancy_enabled())
+	if (resctrl_arch_is_llc_occupancy_enabled())
 		list_add_tail(&llc_occupancy_event.list, &r->evt_list);
-	if (is_mbm_total_enabled())
+	if (resctrl_arch_is_mbm_total_enabled())
 		list_add_tail(&mbm_total_event.list, &r->evt_list);
-	if (is_mbm_local_enabled())
+	if (resctrl_arch_is_mbm_local_enabled())
 		list_add_tail(&mbm_local_event.list, &r->evt_list);
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index badac3f..eb32fbc 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -117,6 +117,18 @@ void rdt_staged_configs_clear(void)
 	}
 }
 
+static bool resctrl_is_mbm_enabled(void)
+{
+	return (resctrl_arch_is_mbm_total_enabled() ||
+		resctrl_arch_is_mbm_local_enabled());
+}
+
+static bool resctrl_is_mbm_event(int e)
+{
+	return (e >= QOS_L3_MBM_TOTAL_EVENT_ID &&
+		e <= QOS_L3_MBM_LOCAL_EVENT_ID);
+}
+
 /*
  * Trivial allocator for CLOSIDs. Since h/w only supports a small number,
  * we can keep a bitmap of free CLOSIDs in a single integer.
@@ -164,7 +176,7 @@ static int closid_alloc(void)
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
-	    is_llc_occupancy_enabled()) {
+	    resctrl_arch_is_llc_occupancy_enabled()) {
 		cleanest_closid = resctrl_find_cleanest_closid();
 		if (cleanest_closid < 0)
 			return cleanest_closid;
@@ -2378,7 +2390,7 @@ static bool supports_mba_mbps(void)
 	struct rdt_resource *rmbm = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 
-	return (is_mbm_enabled() &&
+	return (resctrl_is_mbm_enabled() &&
 		r->alloc_capable && is_mba_linear() &&
 		r->ctrl_scope == rmbm->mon_scope);
 }
@@ -2756,7 +2768,7 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (resctrl_arch_alloc_capable() || resctrl_arch_mon_capable())
 		resctrl_mounted = true;
 
-	if (is_mbm_enabled()) {
+	if (resctrl_is_mbm_enabled()) {
 		r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 		list_for_each_entry(dom, &r->mon_domains, hdr.list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
@@ -3125,7 +3137,7 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
 		if (ret)
 			return ret;
 
-		if (!do_sum && is_mbm_event(mevt->evtid))
+		if (!do_sum && resctrl_is_mbm_event(mevt->evtid))
 			mon_event_read(&rr, r, d, prgrp, &d->hdr.cpu_mask, mevt->evtid, true);
 	}
 
@@ -4082,9 +4094,9 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d
 	if (resctrl_mounted && resctrl_arch_mon_capable())
 		rmdir_mondata_subdir_allrdtgrp(r, d);
 
-	if (is_mbm_enabled())
+	if (resctrl_is_mbm_enabled())
 		cancel_delayed_work(&d->mbm_over);
-	if (is_llc_occupancy_enabled() && has_busy_rmid(d)) {
+	if (resctrl_arch_is_llc_occupancy_enabled() && has_busy_rmid(d)) {
 		/*
 		 * When a package is going down, forcefully
 		 * decrement rmid->ebusy. There is no way to know
@@ -4120,12 +4132,12 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain 
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	size_t tsize;
 
-	if (is_llc_occupancy_enabled()) {
+	if (resctrl_arch_is_llc_occupancy_enabled()) {
 		d->rmid_busy_llc = bitmap_zalloc(idx_limit, GFP_KERNEL);
 		if (!d->rmid_busy_llc)
 			return -ENOMEM;
 	}
-	if (is_mbm_total_enabled()) {
+	if (resctrl_arch_is_mbm_total_enabled()) {
 		tsize = sizeof(*d->mbm_total);
 		d->mbm_total = kcalloc(idx_limit, tsize, GFP_KERNEL);
 		if (!d->mbm_total) {
@@ -4133,7 +4145,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain 
 			return -ENOMEM;
 		}
 	}
-	if (is_mbm_local_enabled()) {
+	if (resctrl_arch_is_mbm_local_enabled()) {
 		tsize = sizeof(*d->mbm_local);
 		d->mbm_local = kcalloc(idx_limit, tsize, GFP_KERNEL);
 		if (!d->mbm_local) {
@@ -4172,13 +4184,13 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
 	if (err)
 		goto out_unlock;
 
-	if (is_mbm_enabled()) {
+	if (resctrl_is_mbm_enabled()) {
 		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
 		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL,
 					   RESCTRL_PICK_ANY_CPU);
 	}
 
-	if (is_llc_occupancy_enabled())
+	if (resctrl_arch_is_llc_occupancy_enabled())
 		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
 
 	/*
@@ -4233,12 +4245,12 @@ void resctrl_offline_cpu(unsigned int cpu)
 
 	d = get_mon_domain_from_cpu(cpu, l3);
 	if (d) {
-		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
+		if (resctrl_is_mbm_enabled() && cpu == d->mbm_work_cpu) {
 			cancel_delayed_work(&d->mbm_over);
 			mbm_setup_overflow_handler(d, 0, cpu);
 		}
-		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
-		    has_busy_rmid(d)) {
+		if (resctrl_arch_is_llc_occupancy_enabled() &&
+		    cpu == d->cqm_work_cpu && has_busy_rmid(d)) {
 			cancel_delayed_work(&d->cqm_limbo);
 			cqm_setup_limbo_handler(d, 0, cpu);
 		}

