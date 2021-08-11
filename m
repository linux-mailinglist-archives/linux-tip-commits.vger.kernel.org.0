Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443273E9909
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhHKTmD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbhHKTly (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16505C061765;
        Wed, 11 Aug 2021 12:41:30 -0700 (PDT)
Date:   Wed, 11 Aug 2021 19:41:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ymxFcESUTWNPQOxj7ubhGb5LNgs3R7ZAUOpndBW5JJs=;
        b=dtTvOYtS7/TrjJl/Zki3lNsbF718a2EXC//nF5G4gzrlJMrO9M2lMktvB8E9yWD1SRQYCJ
        r1NPw/5XmpW5F71AWnEzp+OPFjOV5Tnrrw+c7GZulBnyAXx7NrS2hWWRXSFnigT8jhwGqg
        xbb2mCWsZY1KEY5BL/uCIPBxP9O9Ktk2vbrEFpX3LhLhMF95UhfL+woVC6vKll0NDo4wcj
        G5DKrIUIVIpNk44WYWIH9BN02P7yptvyCqz0qNX7nnGp9oK+sIhUU8ioi41027MNgrimcd
        SAN0E9Fx5KH3wbb0JrR2SDXqkCsv6BykJh70kJ2X3X8v5SV89ANOwcF0emZtyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ymxFcESUTWNPQOxj7ubhGb5LNgs3R7ZAUOpndBW5JJs=;
        b=bDiRsuel1L9gXGGsPYRa1DVDHE3atiHGyY6z2aAaQGBx/WxK9ZGn9MmfRJH8uPxXiBszue
        GOfO8Lp1yYjzZXCg==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Group staged configuration into a
 separate struct
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-14-james.morse@arm.com>
References: <20210728170637.25610-14-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871088792.395.3906931149771648595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     e8f7282552b902af3bd1f07a87d657b7f5f12ab8
Gitweb:        https://git.kernel.org/tip/e8f7282552b902af3bd1f07a87d657b7f5f12ab8
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:26 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 16:32:32 +02:00

x86/resctrl: Group staged configuration into a separate struct

When configuration changes are made, the new value is written to struct
rdt_domain's new_ctrl field and the have_new_ctrl flag is set. Later
new_ctrl is copied to hardware by a call to update_domains().

Once the CDP resources are merged, there will be one new_ctrl field in
use by two struct resctrl_schema requiring a per-schema IPI to copy the
value to hardware.

Move new_ctrl and have_new_ctrl into a new struct resctrl_staged_config.
Before the CDP resources can be merged, struct rdt_domain will need an
array of these, one per type of configuration. Using the type as an
index to the array will ensure that a schema configuration string can't
specify the same domain twice.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-14-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 43 ++++++++++++++--------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 22 ++++++-----
 include/linux/resctrl.h                   | 16 ++++++--
 3 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 104b285..9ddfa76 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -62,16 +62,17 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 {
 	struct rdt_resource *r = s->res;
 	unsigned long bw_val;
+	struct resctrl_staged_config *cfg = &d->staged_config;
 
-	if (d->have_new_ctrl) {
+	if (cfg->have_new_ctrl) {
 		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
 		return -EINVAL;
 	}
 
 	if (!bw_validate(data->buf, &bw_val, r))
 		return -EINVAL;
-	d->new_ctrl = bw_val;
-	d->have_new_ctrl = true;
+	cfg->new_ctrl = bw_val;
+	cfg->have_new_ctrl = true;
 
 	return 0;
 }
@@ -129,11 +130,12 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	      struct rdt_domain *d)
 {
+	struct resctrl_staged_config *cfg = &d->staged_config;
 	struct rdtgroup *rdtgrp = data->rdtgrp;
 	struct rdt_resource *r = s->res;
 	u32 cbm_val;
 
-	if (d->have_new_ctrl) {
+	if (cfg->have_new_ctrl) {
 		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
 		return -EINVAL;
 	}
@@ -175,8 +177,8 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 		}
 	}
 
-	d->new_ctrl = cbm_val;
-	d->have_new_ctrl = true;
+	cfg->new_ctrl = cbm_val;
+	cfg->have_new_ctrl = true;
 
 	return 0;
 }
@@ -190,6 +192,7 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 static int parse_line(char *line, struct resctrl_schema *s,
 		      struct rdtgroup *rdtgrp)
 {
+	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
 	struct rdt_parse_data data;
 	char *dom = NULL, *id;
@@ -219,6 +222,7 @@ next:
 			if (r->parse_ctrlval(&data, s, d))
 				return -EINVAL;
 			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
+				cfg = &d->staged_config;
 				/*
 				 * In pseudo-locking setup mode and just
 				 * parsed a valid CBM that should be
@@ -229,7 +233,7 @@ next:
 				 */
 				rdtgrp->plr->s = s;
 				rdtgrp->plr->d = d;
-				rdtgrp->plr->cbm = d->new_ctrl;
+				rdtgrp->plr->cbm = cfg->new_ctrl;
 				d->plr = rdtgrp->plr;
 				return 0;
 			}
@@ -239,14 +243,27 @@ next:
 	return -EINVAL;
 }
 
+static void apply_config(struct rdt_hw_domain *hw_dom,
+			 struct resctrl_staged_config *cfg, int closid,
+			 cpumask_var_t cpu_mask, bool mba_sc)
+{
+	struct rdt_domain *dom = &hw_dom->d_resctrl;
+	u32 *dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
+
+	if (cfg->new_ctrl != dc[closid]) {
+		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
+		dc[closid] = cfg->new_ctrl;
+	}
+}
+
 int update_domains(struct rdt_resource *r, int closid)
 {
+	struct resctrl_staged_config *cfg;
 	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
 	bool mba_sc;
-	u32 *dc;
 	int cpu;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
@@ -259,11 +276,9 @@ int update_domains(struct rdt_resource *r, int closid)
 	mba_sc = is_mba_sc(r);
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
-		dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
-		if (d->have_new_ctrl && d->new_ctrl != dc[closid]) {
-			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
-			dc[closid] = d->new_ctrl;
-		}
+		cfg = &hw_dom->d_resctrl.staged_config;
+		if (cfg->have_new_ctrl)
+			apply_config(hw_dom, cfg, closid, cpu_mask, mba_sc);
 	}
 
 	/*
@@ -335,7 +350,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		list_for_each_entry(dom, &s->res->domains, list)
-			dom->have_new_ctrl = false;
+			memset(&dom->staged_config, 0, sizeof(dom->staged_config));
 	}
 
 	while ((tok = strsep(&buf, "\n")) != NULL) {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1f8c8d7..62cc82d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2752,6 +2752,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 				 u32 closid)
 {
 	struct rdt_resource *r_cdp = NULL;
+	struct resctrl_staged_config *cfg;
 	struct rdt_domain *d_cdp = NULL;
 	struct rdt_resource *r = s->res;
 	u32 used_b = 0, unused_b = 0;
@@ -2761,8 +2762,9 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	int i;
 
 	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
-	d->have_new_ctrl = false;
-	d->new_ctrl = r->cache.shareable_bits;
+	cfg = &d->staged_config;
+	cfg->have_new_ctrl = false;
+	cfg->new_ctrl = r->cache.shareable_bits;
 	used_b = r->cache.shareable_bits;
 	ctrl = resctrl_to_arch_dom(d)->ctrl_val;
 	for (i = 0; i < closids_supported(); i++, ctrl++) {
@@ -2786,29 +2788,29 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 				peer_ctl = 0;
 			used_b |= *ctrl | peer_ctl;
 			if (mode == RDT_MODE_SHAREABLE)
-				d->new_ctrl |= *ctrl | peer_ctl;
+				cfg->new_ctrl |= *ctrl | peer_ctl;
 		}
 	}
 	if (d->plr && d->plr->cbm > 0)
 		used_b |= d->plr->cbm;
 	unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
 	unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
-	d->new_ctrl |= unused_b;
+	cfg->new_ctrl |= unused_b;
 	/*
 	 * Force the initial CBM to be valid, user can
 	 * modify the CBM based on system availability.
 	 */
-	d->new_ctrl = cbm_ensure_valid(d->new_ctrl, r);
+	cfg->new_ctrl = cbm_ensure_valid(cfg->new_ctrl, r);
 	/*
 	 * Assign the u32 CBM to an unsigned long to ensure that
 	 * bitmap_weight() does not access out-of-bound memory.
 	 */
-	tmp_cbm = d->new_ctrl;
+	tmp_cbm = cfg->new_ctrl;
 	if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
 		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->id);
 		return -ENOSPC;
 	}
-	d->have_new_ctrl = true;
+	cfg->have_new_ctrl = true;
 
 	return 0;
 }
@@ -2840,11 +2842,13 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 /* Initialize MBA resource with default values. */
 static void rdtgroup_init_mba(struct rdt_resource *r)
 {
+	struct resctrl_staged_config *cfg;
 	struct rdt_domain *d;
 
 	list_for_each_entry(d, &r->domains, list) {
-		d->new_ctrl = is_mba_sc(r) ? MBA_MAX_MBPS : r->default_ctrl;
-		d->have_new_ctrl = true;
+		cfg = &d->staged_config;
+		cfg->new_ctrl = is_mba_sc(r) ? MBA_MAX_MBPS : r->default_ctrl;
+		cfg->have_new_ctrl = true;
 	}
 }
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index e482ce7..ff7f7d7 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -28,12 +28,20 @@ enum resctrl_conf_type {
 };
 
 /**
+ * struct resctrl_staged_config - parsed configuration to be applied
+ * @new_ctrl:		new ctrl value to be loaded
+ * @have_new_ctrl:	whether the user provided new_ctrl is valid
+ */
+struct resctrl_staged_config {
+	u32			new_ctrl;
+	bool			have_new_ctrl;
+};
+
+/**
  * struct rdt_domain - group of CPUs sharing a resctrl resource
  * @list:		all instances of this resource
  * @id:			unique id for this instance
  * @cpu_mask:		which CPUs share this resource
- * @new_ctrl:		new ctrl value to be loaded
- * @have_new_ctrl:	did user provide new_ctrl for this domain
  * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
  * @mbm_total:		saved state for MBM total bandwidth
  * @mbm_local:		saved state for MBM local bandwidth
@@ -42,13 +50,12 @@ enum resctrl_conf_type {
  * @mbm_work_cpu:	worker CPU for MBM h/w counters
  * @cqm_work_cpu:	worker CPU for CQM h/w counters
  * @plr:		pseudo-locked region (if any) associated with domain
+ * @staged_config:	parsed configuration to be applied
  */
 struct rdt_domain {
 	struct list_head		list;
 	int				id;
 	struct cpumask			cpu_mask;
-	u32				new_ctrl;
-	bool				have_new_ctrl;
 	unsigned long			*rmid_busy_llc;
 	struct mbm_state		*mbm_total;
 	struct mbm_state		*mbm_local;
@@ -57,6 +64,7 @@ struct rdt_domain {
 	int				mbm_work_cpu;
 	int				cqm_work_cpu;
 	struct pseudo_lock_region	*plr;
+	struct resctrl_staged_config	staged_config;
 };
 
 /**
