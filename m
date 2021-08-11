Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B48E3E990F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhHKTmF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:42:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhHKTmA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:42:00 -0400
Date:   Wed, 11 Aug 2021 19:41:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710895;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WEiMe6o+R82N+dlJ5ta2bwk5UguqD0dM1Levn2kp6wg=;
        b=raZQD49Y959WTpUTaU3Orhuvw6G1BFMCZXLFaYcCDFE7/VVdXuXOFpy6yD7OhyCXnmOkZY
        UdXHK2IVmnVsBuXmXIrdDhe3x6gg3ictA+fZjg/rSpS5huXEfZEHMIjIMkUCAxLwrobAZX
        ASpUaMbyBa6Dipirlw23nSaUEMEogJFoe8T5xPyewB1wPvxsoF5DMOkMhWE4LfD0g/mho5
        Y7FdWvIj5wwFkoZuyKMlD2wOAPE2aU+xu/QKPYZ7d1cLRhDj2/gHTpafsKhbKgQWQrFmcf
        180JGsBoxpsoELRJshTawCZhx28kpTfhI7Ts7RbINyFlPdFmYlGaUJYP/1P3UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710895;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WEiMe6o+R82N+dlJ5ta2bwk5UguqD0dM1Levn2kp6wg=;
        b=/eETx8L2jLHuEKtR7RX/F++ZehOmzjImw0TLaRkq0pmmBMHpM3vGw6L8hrEEjV1ONajyFp
        iLJl+dC7Id8wRuDw==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Split struct rdt_domain
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-3-james.morse@arm.com>
References: <20210728170637.25610-3-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871089440.395.305966895513436885.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     792e0f6f789bda5e31b1dbcfcc84068da36a79b1
Gitweb:        https://git.kernel.org/tip/792e0f6f789bda5e31b1dbcfcc84068da36a79b1
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:15 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 12:00:43 +02:00

x86/resctrl: Split struct rdt_domain

resctrl is the defacto Linux ABI for SoC resource partitioning features.

To support it on another architecture, it needs to be abstracted from
the features provided by Intel RDT and AMD PQoS, and moved to /fs/.
struct rdt_domain contains a mix of architecture private details and
properties of the filesystem interface user-space uses.

Continue by splitting struct rdt_domain, into an architecture private
'hw' struct, which contains the common resctrl structure that would be
used by any architecture. The hardware values in ctrl_val and mbps_val
need to be accessed via helpers to allow another architecture to convert
these into a different format if necessary. After this split, filesystem
code paths touching a 'hw' struct indicates where an abstraction is
needed.

Splitting this structure only moves types around, and should not lead
to any change in behaviour.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-3-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 32 ++++++++++------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 +++--
 arch/x86/kernel/cpu/resctrl/internal.h    | 43 ++++++----------------
 arch/x86/kernel/cpu/resctrl/monitor.c     |  8 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 29 +++++++++------
 include/linux/resctrl.h                   | 32 +++++++++++++++-
 6 files changed, 94 insertions(+), 60 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 942d070..10fbbc3 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -385,10 +385,11 @@ static void
 mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
 	unsigned int i;
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(hw_res->msr_base + i, d->ctrl_val[i]);
+		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
 }
 
 /*
@@ -410,21 +411,23 @@ mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
 		struct rdt_resource *r)
 {
 	unsigned int i;
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
 	/*  Write the delay values for mba. */
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(hw_res->msr_base + i, delay_bw_map(d->ctrl_val[i], r));
+		wrmsrl(hw_res->msr_base + i, delay_bw_map(hw_dom->ctrl_val[i], r));
 }
 
 static void
 cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
 	unsigned int i;
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(hw_res->msr_base + cbm_idx(r, i), d->ctrl_val[i]);
+		wrmsrl(hw_res->msr_base + cbm_idx(r, i), hw_dom->ctrl_val[i]);
 }
 
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
@@ -510,21 +513,22 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct msr_param m;
 	u32 *dc, *dm;
 
-	dc = kmalloc_array(hw_res->num_closid, sizeof(*d->ctrl_val), GFP_KERNEL);
+	dc = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->ctrl_val), GFP_KERNEL);
 	if (!dc)
 		return -ENOMEM;
 
-	dm = kmalloc_array(hw_res->num_closid, sizeof(*d->mbps_val), GFP_KERNEL);
+	dm = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->mbps_val), GFP_KERNEL);
 	if (!dm) {
 		kfree(dc);
 		return -ENOMEM;
 	}
 
-	d->ctrl_val = dc;
-	d->mbps_val = dm;
+	hw_dom->ctrl_val = dc;
+	hw_dom->mbps_val = dm;
 	setup_default_ctrlval(r, dc, dm);
 
 	m.low = 0;
@@ -586,6 +590,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 {
 	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
 	struct list_head *add_pos = NULL;
+	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 
 	d = rdt_find_domain(r, id, &add_pos);
@@ -601,10 +606,11 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	d = kzalloc_node(sizeof(*d), GFP_KERNEL, cpu_to_node(cpu));
-	if (!d)
+	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
+	if (!hw_dom)
 		return;
 
+	d = &hw_dom->d_resctrl;
 	d->id = id;
 	cpumask_set_cpu(cpu, &d->cpu_mask);
 
@@ -633,6 +639,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 {
 	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
+	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 
 	d = rdt_find_domain(r, id, NULL);
@@ -640,6 +647,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
 		return;
 	}
+	hw_dom = resctrl_to_arch_dom(d);
 
 	cpumask_clear_cpu(cpu, &d->cpu_mask);
 	if (cpumask_empty(&d->cpu_mask)) {
@@ -672,12 +680,12 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		if (d->plr)
 			d->plr->d = NULL;
 
-		kfree(d->ctrl_val);
-		kfree(d->mbps_val);
+		kfree(hw_dom->ctrl_val);
+		kfree(hw_dom->mbps_val);
 		bitmap_free(d->rmid_busy_llc);
 		kfree(d->mbm_total);
 		kfree(d->mbm_local);
-		kfree(d);
+		kfree(hw_dom);
 		return;
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 3f0c33d..08eef53 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -238,6 +238,7 @@ next:
 
 int update_domains(struct rdt_resource *r, int closid)
 {
+	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
@@ -254,7 +255,8 @@ int update_domains(struct rdt_resource *r, int closid)
 
 	mba_sc = is_mba_sc(r);
 	list_for_each_entry(d, &r->domains, list) {
-		dc = !mba_sc ? d->ctrl_val : d->mbps_val;
+		hw_dom = resctrl_to_arch_dom(d);
+		dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
 		if (d->have_new_ctrl && d->new_ctrl != dc[closid]) {
 			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 			dc[closid] = d->new_ctrl;
@@ -375,17 +377,19 @@ out:
 
 static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
 {
+	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *dom;
 	bool sep = false;
 	u32 ctrl_val;
 
 	seq_printf(s, "%*s:", max_name_width, r->name);
 	list_for_each_entry(dom, &r->domains, list) {
+		hw_dom = resctrl_to_arch_dom(dom);
 		if (sep)
 			seq_puts(s, ";");
 
-		ctrl_val = (!is_mba_sc(r) ? dom->ctrl_val[closid] :
-			    dom->mbps_val[closid]);
+		ctrl_val = (!is_mba_sc(r) ? hw_dom->ctrl_val[closid] :
+			    hw_dom->mbps_val[closid]);
 		seq_printf(s, r->format_str, dom->id, max_data_width,
 			   ctrl_val);
 		sep = true;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index caf9248..02c85c7 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -304,44 +304,25 @@ struct mbm_state {
 };
 
 /**
- * struct rdt_domain - group of cpus sharing an RDT resource
- * @list:	all instances of this resource
- * @id:		unique id for this instance
- * @cpu_mask:	which cpus share this resource
- * @rmid_busy_llc:
- *		bitmap of which limbo RMIDs are above threshold
- * @mbm_total:	saved state for MBM total bandwidth
- * @mbm_local:	saved state for MBM local bandwidth
- * @mbm_over:	worker to periodically read MBM h/w counters
- * @cqm_limbo:	worker to periodically read CQM h/w counters
- * @mbm_work_cpu:
- *		worker cpu for MBM h/w counters
- * @cqm_work_cpu:
- *		worker cpu for CQM h/w counters
+ * struct rdt_hw_domain - Arch private attributes of a set of CPUs that share
+ *			  a resource
+ * @d_resctrl:	Properties exposed to the resctrl file system
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
  * @mbps_val:	When mba_sc is enabled, this holds the bandwidth in MBps
- * @new_ctrl:	new ctrl value to be loaded
- * @have_new_ctrl: did user provide new_ctrl for this domain
- * @plr:	pseudo-locked region (if any) associated with domain
+ *
+ * Members of this structure are accessed via helpers that provide abstraction.
  */
-struct rdt_domain {
-	struct list_head		list;
-	int				id;
-	struct cpumask			cpu_mask;
-	unsigned long			*rmid_busy_llc;
-	struct mbm_state		*mbm_total;
-	struct mbm_state		*mbm_local;
-	struct delayed_work		mbm_over;
-	struct delayed_work		cqm_limbo;
-	int				mbm_work_cpu;
-	int				cqm_work_cpu;
+struct rdt_hw_domain {
+	struct rdt_domain		d_resctrl;
 	u32				*ctrl_val;
 	u32				*mbps_val;
-	u32				new_ctrl;
-	bool				have_new_ctrl;
-	struct pseudo_lock_region	*plr;
 };
 
+static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
+{
+	return container_of(r, struct rdt_hw_domain, d_resctrl);
+}
+
 /**
  * struct msr_param - set a range of MSRs from a domain
  * @res:       The resource to use
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 5daf584..26a0948 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -418,6 +418,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	u32 closid, rmid, cur_msr, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
 	struct rdt_hw_resource *hw_r_mba;
+	struct rdt_hw_domain *hw_dom_mba;
 	u32 cur_bw, delta_bw, user_bw;
 	struct rdt_resource *r_mba;
 	struct rdt_domain *dom_mba;
@@ -438,11 +439,12 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 		pr_warn_once("Failure to get domain for MBA update\n");
 		return;
 	}
+	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
 
 	cur_bw = pmbm_data->prev_bw;
-	user_bw = dom_mba->mbps_val[closid];
+	user_bw = hw_dom_mba->mbps_val[closid];
 	delta_bw = pmbm_data->delta_bw;
-	cur_msr_val = dom_mba->ctrl_val[closid];
+	cur_msr_val = hw_dom_mba->ctrl_val[closid];
 
 	/*
 	 * For Ctrl groups read data from child monitor groups.
@@ -479,7 +481,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 
 	cur_msr = hw_r_mba->msr_base + closid;
 	wrmsrl(cur_msr, delay_bw_map(new_msr_val, r_mba));
-	dom_mba->ctrl_val[closid] = new_msr_val;
+	hw_dom_mba->ctrl_val[closid] = new_msr_val;
 
 	/*
 	 * Delta values are updated dynamically package wise for each
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d49a007..d190a21 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -915,7 +915,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 	list_for_each_entry(dom, &r->domains, list) {
 		if (sep)
 			seq_putc(seq, ';');
-		ctrl = dom->ctrl_val;
+		ctrl = resctrl_to_arch_dom(dom)->ctrl_val;
 		sw_shareable = 0;
 		exclusive = 0;
 		seq_printf(seq, "%d=", dom->id);
@@ -1193,7 +1193,7 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 	}
 
 	/* Check for overlap with other resource groups */
-	ctrl = d->ctrl_val;
+	ctrl = resctrl_to_arch_dom(d)->ctrl_val;
 	for (i = 0; i < closids_supported(); i++, ctrl++) {
 		ctrl_b = *ctrl;
 		mode = rdtgroup_mode_by_closid(i);
@@ -1262,6 +1262,7 @@ bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
  */
 static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 {
+	struct rdt_hw_domain *hw_dom;
 	int closid = rdtgrp->closid;
 	struct rdt_resource *r;
 	bool has_cache = false;
@@ -1272,7 +1273,8 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 			continue;
 		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
-			if (rdtgroup_cbm_overlaps(r, d, d->ctrl_val[closid],
+			hw_dom = resctrl_to_arch_dom(d);
+			if (rdtgroup_cbm_overlaps(r, d, hw_dom->ctrl_val[closid],
 						  rdtgrp->closid, false)) {
 				rdt_last_cmd_puts("Schemata overlaps\n");
 				return false;
@@ -1404,6 +1406,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 static int rdtgroup_size_show(struct kernfs_open_file *of,
 			      struct seq_file *s, void *v)
 {
+	struct rdt_hw_domain *hw_dom;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	struct rdt_domain *d;
@@ -1438,14 +1441,15 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		sep = false;
 		seq_printf(s, "%*s:", max_name_width, r->name);
 		list_for_each_entry(d, &r->domains, list) {
+			hw_dom = resctrl_to_arch_dom(d);
 			if (sep)
 				seq_putc(s, ';');
 			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 				size = 0;
 			} else {
 				ctrl = (!is_mba_sc(r) ?
-						d->ctrl_val[rdtgrp->closid] :
-						d->mbps_val[rdtgrp->closid]);
+						hw_dom->ctrl_val[rdtgrp->closid] :
+						hw_dom->mbps_val[rdtgrp->closid]);
 				if (r->rid == RDT_RESOURCE_MBA)
 					size = ctrl;
 				else
@@ -1940,6 +1944,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 static int set_mba_sc(bool mba_sc)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 
 	if (!is_mbm_enabled() || !is_mba_linear() ||
@@ -1947,8 +1952,10 @@ static int set_mba_sc(bool mba_sc)
 		return -EINVAL;
 
 	r->membw.mba_sc = mba_sc;
-	list_for_each_entry(d, &r->domains, list)
-		setup_default_ctrlval(r, d->ctrl_val, d->mbps_val);
+	list_for_each_entry(d, &r->domains, list) {
+		hw_dom = resctrl_to_arch_dom(d);
+		setup_default_ctrlval(r, hw_dom->ctrl_val, hw_dom->mbps_val);
+	}
 
 	return 0;
 }
@@ -2265,6 +2272,7 @@ static int rdt_init_fs_context(struct fs_context *fc)
 static int reset_all_ctrls(struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
@@ -2283,10 +2291,11 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	 * from each domain to update the MSRs below.
 	 */
 	list_for_each_entry(d, &r->domains, list) {
+		hw_dom = resctrl_to_arch_dom(d);
 		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 
 		for (i = 0; i < hw_res->num_closid; i++)
-			d->ctrl_val[i] = r->default_ctrl;
+			hw_dom->ctrl_val[i] = r->default_ctrl;
 	}
 	cpu = get_cpu();
 	/* Update CBM on this cpu if it's in cpu_mask. */
@@ -2665,7 +2674,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
 	d->have_new_ctrl = false;
 	d->new_ctrl = r->cache.shareable_bits;
 	used_b = r->cache.shareable_bits;
-	ctrl = d->ctrl_val;
+	ctrl = resctrl_to_arch_dom(d)->ctrl_val;
 	for (i = 0; i < closids_supported(); i++, ctrl++) {
 		if (closid_allocated(i) && i != closid) {
 			mode = rdtgroup_mode_by_closid(i);
@@ -2682,7 +2691,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
 			 * with an exclusive group.
 			 */
 			if (d_cdp)
-				peer_ctl = d_cdp->ctrl_val[i];
+				peer_ctl = resctrl_to_arch_dom(d_cdp)->ctrl_val[i];
 			else
 				peer_ctl = 0;
 			used_b |= *ctrl | peer_ctl;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5ccf36b..a4c89da 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -15,7 +15,37 @@ int proc_resctrl_show(struct seq_file *m,
 
 #endif
 
-struct rdt_domain;
+/**
+ * struct rdt_domain - group of CPUs sharing a resctrl resource
+ * @list:		all instances of this resource
+ * @id:			unique id for this instance
+ * @cpu_mask:		which CPUs share this resource
+ * @new_ctrl:		new ctrl value to be loaded
+ * @have_new_ctrl:	did user provide new_ctrl for this domain
+ * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
+ * @mbm_total:		saved state for MBM total bandwidth
+ * @mbm_local:		saved state for MBM local bandwidth
+ * @mbm_over:		worker to periodically read MBM h/w counters
+ * @cqm_limbo:		worker to periodically read CQM h/w counters
+ * @mbm_work_cpu:	worker CPU for MBM h/w counters
+ * @cqm_work_cpu:	worker CPU for CQM h/w counters
+ * @plr:		pseudo-locked region (if any) associated with domain
+ */
+struct rdt_domain {
+	struct list_head		list;
+	int				id;
+	struct cpumask			cpu_mask;
+	u32				new_ctrl;
+	bool				have_new_ctrl;
+	unsigned long			*rmid_busy_llc;
+	struct mbm_state		*mbm_total;
+	struct mbm_state		*mbm_local;
+	struct delayed_work		mbm_over;
+	struct delayed_work		cqm_limbo;
+	int				mbm_work_cpu;
+	int				cqm_work_cpu;
+	struct pseudo_lock_region	*plr;
+};
 
 /**
  * struct resctrl_cache - Cache allocation related data
