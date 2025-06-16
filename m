Return-Path: <linux-tip-commits+bounces-5854-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFC1ADBA54
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Jun 2025 21:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C2B3B491E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Jun 2025 19:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92A726C3B9;
	Mon, 16 Jun 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PX4HK4lz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bevBE0Pb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A1C2BF01B;
	Mon, 16 Jun 2025 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750103483; cv=none; b=fb+EKUmJMSdNPwNSSGUjxgBJ4uJ1H5aEpPDo+IhwA9+ItCqlbGYGcjDmhQGrTZZj9+pwpVJoIKLmDiBo7/L5O/yimdp7M5M6DcWiUxxPJRUJ2e4OXjbZAN5bfUKn/E1wF73j5OM9ubyFWYZhxDzWmFYmASwmk8gJm5lJhaWOahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750103483; c=relaxed/simple;
	bh=dJbubxaGX4fqW0iV25Klb4BaREKjDiiqjVfGhb9REK8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PKSuZ6f3DJd7/7v9W9ma4bRwZO7SuNc/9T1bta2qCD7HOST9ABsUBkdr1M3tEcJMHXiaUNthCHhcvk1+eYDRJu26R738Gleu076K9MHvxZl3Mbw7gQldWbgAzG1V3CUhBBCQTyiaDD7tFq+7UgsxyJhI7buzo3SykmEJ3mHu/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PX4HK4lz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bevBE0Pb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 16 Jun 2025 19:51:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750103479;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26aTIeMKxAJrmyasOnwaeAo0WGSlgN6dSV2cj8yxklg=;
	b=PX4HK4lzGTXr5SPv3JauOQWORzq6GV5QTpyn5N+Np2BibLCvQeqSme3Tul5aDFDCSMAqsd
	h1pXWx5/jykmXwSVvhXwzaFn+Z4FcEq7xCCOE14S1nd5aY72aK1TNkvDxziOU9YMtGDDFi
	TzzpNlITQgsMeE9YJvtK+y4fgfIVEfreX2K21hZpC1Agn3oBwcme+DxrEdagRFNahw9t7Z
	PG9cO1Ibz0XirnJEox3vcr5+nBq90qKQgHrJ6AsmZZNpBSI6lnspfD7C/fx2z9ncjB4uIQ
	g1J946BTi2ld4nnGAMH7EzIxhqr/nujLsuEjrJ/YUW1JBUWh+Wr5CT6JzCxkyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750103479;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26aTIeMKxAJrmyasOnwaeAo0WGSlgN6dSV2cj8yxklg=;
	b=bevBE0PbvHh74SU2k8Qu3DAUJssk2vAR6lJeypjpqRAI2RaOUeeZA/pVBFrVqpKNT1sRYA
	RAoVtXCToZkLHgAA==
From: "tip-bot2 for Qinyun Tan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86,fs/resctrl: Remove inappropriate references to
 cacheinfo in the resctrl subsystem
Cc: Qinyun Tan <qinyuntan@linux.alibaba.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250530182053.37502-2-qinyuntan@linux.alibaba.com>
References: <20250530182053.37502-2-qinyuntan@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175010347834.406.11124124238486500102.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     594902c986e269660302f09df9ec4bf1cf017b77
Gitweb:        https://git.kernel.org/tip/594902c986e269660302f09df9ec4bf1cf017b77
Author:        Qinyun Tan <qinyuntan@linux.alibaba.com>
AuthorDate:    Sat, 31 May 2025 02:20:53 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 16 Jun 2025 21:06:12 +02:00

x86,fs/resctrl: Remove inappropriate references to cacheinfo in the resctrl subsystem

In the resctrl subsystem's Sub-NUMA Cluster (SNC) mode, the rdt_mon_domain
structure representing a NUMA node relies on the cacheinfo interface
(rdt_mon_domain::ci) to store L3 cache information (e.g., shared_cpu_map)
for monitoring. The L3 cache information of a SNC NUMA node determines
which domains are summed for the "top level" L3-scoped events.

rdt_mon_domain::ci is initialized using the first online CPU of a NUMA
node. When this CPU goes offline, its shared_cpu_map is cleared to contain
only the offline CPU itself. Subsequently, attempting to read counters
via smp_call_on_cpu(offline_cpu) fails (and error ignored), returning
zero values for "top-level events" without any error indication.

Replace the cacheinfo references in struct rdt_mon_domain and struct
rmid_read with the cacheinfo ID (a unique identifier for the L3 cache).

rdt_domain_hdr::cpu_mask contains the online CPUs associated with that
domain. When reading "top-level events", select a CPU from
rdt_domain_hdr::cpu_mask and utilize its L3 shared_cpu_map to determine
valid CPUs for reading RMID counter via the MSR interface.

Considering all CPUs associated with the L3 cache improves the chances
of picking a housekeeping CPU on which the counter reading work can be
queued, avoiding an unnecessary IPI.

Fixes: 328ea68874642 ("x86/resctrl: Prepare for new Sub-NUMA Cluster (SNC) monitor files")
Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250530182053.37502-2-qinyuntan@linux.alibaba.com
---
 arch/x86/kernel/cpu/resctrl/core.c |  6 ++++--
 fs/resctrl/ctrlmondata.c           | 13 +++++++++----
 fs/resctrl/internal.h              |  4 ++--
 fs/resctrl/monitor.c               |  6 ++++--
 fs/resctrl/rdtgroup.c              |  6 +++---
 include/linux/resctrl.h            |  4 ++--
 6 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 7109cbf..187d527 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -498,6 +498,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	struct rdt_hw_mon_domain *hw_dom;
 	struct rdt_domain_hdr *hdr;
 	struct rdt_mon_domain *d;
+	struct cacheinfo *ci;
 	int err;
 
 	lockdep_assert_held(&domain_list_lock);
@@ -525,12 +526,13 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	d = &hw_dom->d_resctrl;
 	d->hdr.id = id;
 	d->hdr.type = RESCTRL_MON_DOMAIN;
-	d->ci = get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
-	if (!d->ci) {
+	ci = get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
+	if (!ci) {
 		pr_warn_once("Can't find L3 cache for CPU:%d resource %s\n", cpu, r->name);
 		mon_domain_free(hw_dom);
 		return;
 	}
+	d->ci_id = ci->id;
 	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
 
 	arch_mon_domain_online(r, d);
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 6ed2dfd..d98e0d2 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -594,9 +594,10 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	struct rmid_read rr = {0};
 	struct rdt_mon_domain *d;
 	struct rdtgroup *rdtgrp;
+	int domid, cpu, ret = 0;
 	struct rdt_resource *r;
+	struct cacheinfo *ci;
 	struct mon_data *md;
-	int domid, ret = 0;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (!rdtgrp) {
@@ -623,10 +624,14 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		 * one that matches this cache id.
 		 */
 		list_for_each_entry(d, &r->mon_domains, hdr.list) {
-			if (d->ci->id == domid) {
-				rr.ci = d->ci;
+			if (d->ci_id == domid) {
+				rr.ci_id = d->ci_id;
+				cpu = cpumask_any(&d->hdr.cpu_mask);
+				ci = get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
+				if (!ci)
+					continue;
 				mon_event_read(&rr, r, NULL, rdtgrp,
-					       &d->ci->shared_cpu_map, evtid, false);
+					       &ci->shared_cpu_map, evtid, false);
 				goto checkresult;
 			}
 		}
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 9a8cf6f..0a1eedb 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -98,7 +98,7 @@ struct mon_data {
  *	   domains in @r sharing L3 @ci.id
  * @evtid: Which monitor event to read.
  * @first: Initialize MBM counter when true.
- * @ci:    Cacheinfo for L3. Only set when @d is NULL. Used when summing domains.
+ * @ci_id: Cacheinfo id for L3. Only set when @d is NULL. Used when summing domains.
  * @err:   Error encountered when reading counter.
  * @val:   Returned value of event counter. If @rgrp is a parent resource group,
  *	   @val includes the sum of event counts from its child resource groups.
@@ -112,7 +112,7 @@ struct rmid_read {
 	struct rdt_mon_domain	*d;
 	enum resctrl_event_id	evtid;
 	bool			first;
-	struct cacheinfo	*ci;
+	unsigned int		ci_id;
 	int			err;
 	u64			val;
 	void			*arch_mon_ctx;
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index bde2801..f563785 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -361,6 +361,7 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 {
 	int cpu = smp_processor_id();
 	struct rdt_mon_domain *d;
+	struct cacheinfo *ci;
 	struct mbm_state *m;
 	int err, ret;
 	u64 tval = 0;
@@ -388,7 +389,8 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 	}
 
 	/* Summing domains that share a cache, must be on a CPU for that cache. */
-	if (!cpumask_test_cpu(cpu, &rr->ci->shared_cpu_map))
+	ci = get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
+	if (!ci || ci->id != rr->ci_id)
 		return -EINVAL;
 
 	/*
@@ -400,7 +402,7 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 	 */
 	ret = -EINVAL;
 	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
-		if (d->ci->id != rr->ci->id)
+		if (d->ci_id != rr->ci_id)
 			continue;
 		err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
 					     rr->evtid, &tval, rr->arch_mon_ctx);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 1beb124..77d0822 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3036,7 +3036,7 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 	char name[32];
 
 	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
-	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);
+	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci_id : d->hdr.id);
 	if (snc_mode)
 		sprintf(subname, "mon_sub_%s_%02d", r->name, d->hdr.id);
 
@@ -3061,7 +3061,7 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
 		return -EPERM;
 
 	list_for_each_entry(mevt, &r->evt_list, list) {
-		domid = do_sum ? d->ci->id : d->hdr.id;
+		domid = do_sum ? d->ci_id : d->hdr.id;
 		priv = mon_get_kn_priv(r->rid, domid, mevt, do_sum);
 		if (WARN_ON_ONCE(!priv))
 			return -EINVAL;
@@ -3089,7 +3089,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
-	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);
+	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci_id : d->hdr.id);
 	kn = kernfs_find_and_get(parent_kn, name);
 	if (kn) {
 		/*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 9ba771f..6fb4894 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -159,7 +159,7 @@ struct rdt_ctrl_domain {
 /**
  * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor resource
  * @hdr:		common header for different domain types
- * @ci:			cache info for this domain
+ * @ci_id:		cache info id for this domain
  * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
  * @mbm_total:		saved state for MBM total bandwidth
  * @mbm_local:		saved state for MBM local bandwidth
@@ -170,7 +170,7 @@ struct rdt_ctrl_domain {
  */
 struct rdt_mon_domain {
 	struct rdt_domain_hdr		hdr;
-	struct cacheinfo		*ci;
+	unsigned int			ci_id;
 	unsigned long			*rmid_busy_llc;
 	struct mbm_state		*mbm_total;
 	struct mbm_state		*mbm_local;

