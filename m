Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410BF3E98FE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhHKTl4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:41:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53574 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhHKTlv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:51 -0400
Date:   Wed, 11 Aug 2021 19:41:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ffp5tsGVQTD4+VV+rrZ8c5Vs4zSn1hw9984lwozTmu4=;
        b=y+U+a0479MgrgRNZcIGzGTeOpYpkcYqZSG1gwQ3HfRt5Ly9BoRbuHh4cRYa/QtAPQWDQOP
        Y//NlTSfNH7CyhKQxRs1zhaXB5uEXu8beYXTcpiWJJ74cE9780lyV1UJbZ2gvsfimnBFUr
        2WHFNlqXNpPVqMAokxBGAzm31wxRcHc0nZAo8mjYzs3XYfcLEU71nxWgywODKhfbvbqpgS
        0C9WuHChdNVy8dZ2pw+l3VW4zK1lFxTQKYCza8U/fKVxe8yGlBVGQFpDJ3nfD2FbzNSKla
        DJGz5V4qcezVqZbvPjtMNoj7l8vFKiFqbL5FuDi2ZnTXrzIT1gpe4t9tVRmYrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ffp5tsGVQTD4+VV+rrZ8c5Vs4zSn1hw9984lwozTmu4=;
        b=lNYlOrog//88EJMVbnsvuTIOEAxrjZKdf1lHmD2RmyJdnGXLEgnylG6NaCIZRIQB/kYQIf
        OUtHEB3tVqym/ZDw==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add a helper to read a closid's configuration
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-17-james.morse@arm.com>
References: <20210728170637.25610-17-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871088628.395.10480115161828874443.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     f07e9d0250577a23eb06d4334798291616c01f2d
Gitweb:        https://git.kernel.org/tip/f07e9d0250577a23eb06d4334798291616c01f2d
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:29 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 17:46:34 +02:00

x86/resctrl: Add a helper to read a closid's configuration

Functions like show_doms() reach into the architecture's private
structure to retrieve the configuration from the struct rdt_hw_resource.

The hardware configuration may look completely different to the
values resctrl gets from user-space. The staged configuration and
resctrl_arch_update_domains() allow the architecture to convert or
translate these values.

Resctrl shouldn't read or write the ctrl_val[] values directly. Add
a helper to read the current configuration. This will allow another
architecture to scale the bitmaps if necessary, and possibly use
controls that don't take the user-space control format at all.

Of the remaining functions that access ctrl_val[] directly,
apply_config() is part of the architecture-specific code, and is
called via resctrl_arch_update_domains(). reset_all_ctrls() will be an
architecture specific helper.

update_mba_bw() manipulates both ctrl_val[], mbps_val[] and the
hardware. The mbps_val[] that matches the mba_sc state of the resource
is changed, but the other is left unchanged. Abstracting this is the
subject of later patches that affect set_mba_sc() too.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-17-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 16 ++++++--
 arch/x86/kernel/cpu/resctrl/monitor.c     |  6 ++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 43 +++++++++-------------
 include/linux/resctrl.h                   |  2 +-
 4 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 8cde76d..4da08ba 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -401,22 +401,30 @@ out:
 	return ret ?: nbytes;
 }
 
+void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
+			     u32 closid, u32 *value)
+{
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+
+	if (!is_mba_sc(r))
+		*value = hw_dom->ctrl_val[closid];
+	else
+		*value = hw_dom->mbps_val[closid];
+}
+
 static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
 {
 	struct rdt_resource *r = schema->res;
-	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *dom;
 	bool sep = false;
 	u32 ctrl_val;
 
 	seq_printf(s, "%*s:", max_name_width, schema->name);
 	list_for_each_entry(dom, &r->domains, list) {
-		hw_dom = resctrl_to_arch_dom(dom);
 		if (sep)
 			seq_puts(s, ";");
 
-		ctrl_val = (!is_mba_sc(r) ? hw_dom->ctrl_val[closid] :
-			    hw_dom->mbps_val[closid]);
+		resctrl_arch_get_config(r, dom, closid, &ctrl_val);
 		seq_printf(s, r->format_str, dom->id, max_data_width,
 			   ctrl_val);
 		sep = true;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 26a0948..e45e715 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -442,8 +442,12 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
 
 	cur_bw = pmbm_data->prev_bw;
-	user_bw = hw_dom_mba->mbps_val[closid];
+	resctrl_arch_get_config(r_mba, dom_mba, closid, &user_bw);
 	delta_bw = pmbm_data->delta_bw;
+	/*
+	 * resctrl_arch_get_config() chooses the mbps/ctrl value to return
+	 * based on is_mba_sc(). For now, reach into the hw_dom.
+	 */
 	cur_msr_val = hw_dom_mba->ctrl_val[closid];
 
 	/*
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 4b6de76..6b2be56 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -910,27 +910,27 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 	int i, hwb, swb, excl, psl;
 	enum rdtgrp_mode mode;
 	bool sep = false;
-	u32 *ctrl;
+	u32 ctrl_val;
 
 	mutex_lock(&rdtgroup_mutex);
 	hw_shareable = r->cache.shareable_bits;
 	list_for_each_entry(dom, &r->domains, list) {
 		if (sep)
 			seq_putc(seq, ';');
-		ctrl = resctrl_to_arch_dom(dom)->ctrl_val;
 		sw_shareable = 0;
 		exclusive = 0;
 		seq_printf(seq, "%d=", dom->id);
-		for (i = 0; i < closids_supported(); i++, ctrl++) {
+		for (i = 0; i < closids_supported(); i++) {
 			if (!closid_allocated(i))
 				continue;
+			resctrl_arch_get_config(r, dom, i, &ctrl_val);
 			mode = rdtgroup_mode_by_closid(i);
 			switch (mode) {
 			case RDT_MODE_SHAREABLE:
-				sw_shareable |= *ctrl;
+				sw_shareable |= ctrl_val;
 				break;
 			case RDT_MODE_EXCLUSIVE:
-				exclusive |= *ctrl;
+				exclusive |= ctrl_val;
 				break;
 			case RDT_MODE_PSEUDO_LOCKSETUP:
 			/*
@@ -1188,7 +1188,6 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 {
 	enum rdtgrp_mode mode;
 	unsigned long ctrl_b;
-	u32 *ctrl;
 	int i;
 
 	/* Check for any overlap with regions used by hardware directly */
@@ -1199,9 +1198,8 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 	}
 
 	/* Check for overlap with other resource groups */
-	ctrl = resctrl_to_arch_dom(d)->ctrl_val;
-	for (i = 0; i < closids_supported(); i++, ctrl++) {
-		ctrl_b = *ctrl;
+	for (i = 0; i < closids_supported(); i++) {
+		resctrl_arch_get_config(r, d, i, (u32 *)&ctrl_b);
 		mode = rdtgroup_mode_by_closid(i);
 		if (closid_allocated(i) && i != closid &&
 		    mode != RDT_MODE_PSEUDO_LOCKSETUP) {
@@ -1269,12 +1267,12 @@ bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
  */
 static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 {
-	struct rdt_hw_domain *hw_dom;
 	int closid = rdtgrp->closid;
 	struct resctrl_schema *s;
 	struct rdt_resource *r;
 	bool has_cache = false;
 	struct rdt_domain *d;
+	u32 ctrl;
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
@@ -1282,10 +1280,8 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 			continue;
 		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
-			hw_dom = resctrl_to_arch_dom(d);
-			if (rdtgroup_cbm_overlaps(s, d,
-						  hw_dom->ctrl_val[closid],
-						  rdtgrp->closid, false)) {
+			resctrl_arch_get_config(r, d, closid, &ctrl);
+			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
 				rdt_last_cmd_puts("Schemata overlaps\n");
 				return false;
 			}
@@ -1417,7 +1413,6 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			      struct seq_file *s, void *v)
 {
 	struct resctrl_schema *schema;
-	struct rdt_hw_domain *hw_dom;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	struct rdt_domain *d;
@@ -1453,15 +1448,13 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		sep = false;
 		seq_printf(s, "%*s:", max_name_width, schema->name);
 		list_for_each_entry(d, &r->domains, list) {
-			hw_dom = resctrl_to_arch_dom(d);
 			if (sep)
 				seq_putc(s, ';');
 			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 				size = 0;
 			} else {
-				ctrl = (!is_mba_sc(r) ?
-						hw_dom->ctrl_val[rdtgrp->closid] :
-						hw_dom->mbps_val[rdtgrp->closid]);
+				resctrl_arch_get_config(r, d, rdtgrp->closid,
+							&ctrl);
 				if (r->rid == RDT_RESOURCE_MBA)
 					size = ctrl;
 				else
@@ -2759,7 +2752,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	u32 used_b = 0, unused_b = 0;
 	unsigned long tmp_cbm;
 	enum rdtgrp_mode mode;
-	u32 peer_ctl, *ctrl;
+	u32 peer_ctl, ctrl_val;
 	int i;
 
 	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
@@ -2767,8 +2760,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	cfg->have_new_ctrl = false;
 	cfg->new_ctrl = r->cache.shareable_bits;
 	used_b = r->cache.shareable_bits;
-	ctrl = resctrl_to_arch_dom(d)->ctrl_val;
-	for (i = 0; i < closids_supported(); i++, ctrl++) {
+	for (i = 0; i < closids_supported(); i++) {
 		if (closid_allocated(i) && i != closid) {
 			mode = rdtgroup_mode_by_closid(i);
 			if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
@@ -2784,12 +2776,13 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 			 * with an exclusive group.
 			 */
 			if (d_cdp)
-				peer_ctl = resctrl_to_arch_dom(d_cdp)->ctrl_val[i];
+				resctrl_arch_get_config(r_cdp, d_cdp, i, &peer_ctl);
 			else
 				peer_ctl = 0;
-			used_b |= *ctrl | peer_ctl;
+			resctrl_arch_get_config(r, d, i, &ctrl_val);
+			used_b |= ctrl_val | peer_ctl;
 			if (mode == RDT_MODE_SHAREABLE)
-				cfg->new_ctrl |= *ctrl | peer_ctl;
+				cfg->new_ctrl |= ctrl_val | peer_ctl;
 		}
 	}
 	if (d->plr && d->plr->cbm > 0)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index be58811..3a23094 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -200,5 +200,7 @@ struct resctrl_schema {
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
+void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
+			     u32 closid, u32 *value);
 
 #endif /* _RESCTRL_H */
