Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB653E98FC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhHKTly (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhHKTlw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D481AC061765;
        Wed, 11 Aug 2021 12:41:27 -0700 (PDT)
Date:   Wed, 11 Aug 2021 19:41:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GaecYIGSipOfP5AJk5OnRjpfubMAIa9tek47ihYOilg=;
        b=ERiSRzERvV5IAiVAWbQyG7j3LQGmvyKQUCGqd6MLFGcUjPkkXpIFcm2kdMtbdNFP8Ew+7I
        FkRZ93MY1sU3yYLhLRbKI8JloIjAaWuTscgyj2y/cEVQ+vKfIcjIPLWXvg1KXHSpeJLiFJ
        Nf6D3s3sMrMSEZha1g+sGTLPEVf07n2+VeUNn+jGyQa/C+ZXYHMCiclD+YsfqBgHbtqat6
        3RGGmbVXXJYw5JEYolSWd2+DAiXgz9VQQy37N/xlVwoH1ReUWjMN005CWy174qisfQaG0T
        llSAo50Ppu+oR3/TTwqDWFoUwv/hmOmCf+/64CnVn2I1gEWvRG6Ur/JS2dqZ+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GaecYIGSipOfP5AJk5OnRjpfubMAIa9tek47ihYOilg=;
        b=RJxl/RTqBvIkEwbszN1LtRYv4SgkcPk5vhDQPz/GpkcjS/g4uKesWR6R1YCtDCCJ48V5vw
        1cpOMqfK5Zy1y2Bw==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Pass configuration type to
 resctrl_arch_get_config()
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-18-james.morse@arm.com>
References: <20210728170637.25610-18-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871088570.395.1950599131350256301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     fa8f711d2f14381d1a47420b6da94b62e6484c56
Gitweb:        https://git.kernel.org/tip/fa8f711d2f14381d1a47420b6da94b62e6484c56
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:30 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 17:53:53 +02:00

x86/resctrl: Pass configuration type to resctrl_arch_get_config()

The ctrl_val[] array for a struct rdt_hw_resource only holds
configurations of one type. The type is implicit.

Once the CDP resources are merged, the ctrl_val[] array will hold all
the configurations for the hardware resource. When a particular type of
configuration is needed, it must be specified explicitly.

Pass the expected type from the schema into resctrl_arch_get_config().
Nothing uses this yet, but once a single ctrl_val[] array is used for
the three struct rdt_hw_resources that share hardware, the type will be
used to return the correct configuration value from the shared array.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-18-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  5 +--
 arch/x86/kernel/cpu/resctrl/monitor.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 35 ++++++++++++++--------
 include/linux/resctrl.h                   |  3 +-
 4 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 4da08ba..9ead0c0 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -402,7 +402,7 @@ out:
 }
 
 void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
-			     u32 closid, u32 *value)
+			     u32 closid, enum resctrl_conf_type type, u32 *value)
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 
@@ -424,7 +424,8 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 		if (sep)
 			seq_puts(s, ";");
 
-		resctrl_arch_get_config(r, dom, closid, &ctrl_val);
+		resctrl_arch_get_config(r, dom, closid, schema->conf_type,
+					&ctrl_val);
 		seq_printf(s, r->format_str, dom->id, max_data_width,
 			   ctrl_val);
 		sep = true;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index e45e715..eb22729 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -442,7 +442,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
 
 	cur_bw = pmbm_data->prev_bw;
-	resctrl_arch_get_config(r_mba, dom_mba, closid, &user_bw);
+	resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE, &user_bw);
 	delta_bw = pmbm_data->delta_bw;
 	/*
 	 * resctrl_arch_get_config() chooses the mbps/ctrl value to return
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6b2be56..61037b2 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -923,7 +923,8 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 		for (i = 0; i < closids_supported(); i++) {
 			if (!closid_allocated(i))
 				continue;
-			resctrl_arch_get_config(r, dom, i, &ctrl_val);
+			resctrl_arch_get_config(r, dom, i, s->conf_type,
+						&ctrl_val);
 			mode = rdtgroup_mode_by_closid(i);
 			switch (mode) {
 			case RDT_MODE_SHAREABLE:
@@ -1099,6 +1100,7 @@ static int rdtgroup_mode_show(struct kernfs_open_file *of,
  *         Used to return the result.
  * @d_cdp: RDT domain that shares hardware with @d (RDT domain peer)
  *         Used to return the result.
+ * @peer_type: The CDP configuration type of the peer resource.
  *
  * RDT resources are managed independently and by extension the RDT domains
  * (RDT resource instances) are managed independently also. The Code and
@@ -1116,7 +1118,8 @@ static int rdtgroup_mode_show(struct kernfs_open_file *of,
  */
 static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
 			    struct rdt_resource **r_cdp,
-			    struct rdt_domain **d_cdp)
+			    struct rdt_domain **d_cdp,
+			    enum resctrl_conf_type *peer_type)
 {
 	struct rdt_resource *_r_cdp = NULL;
 	struct rdt_domain *_d_cdp = NULL;
@@ -1125,15 +1128,19 @@ static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
 	switch (r->rid) {
 	case RDT_RESOURCE_L3DATA:
 		_r_cdp = &rdt_resources_all[RDT_RESOURCE_L3CODE].r_resctrl;
+		*peer_type = CDP_CODE;
 		break;
 	case RDT_RESOURCE_L3CODE:
 		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L3DATA].r_resctrl;
+		*peer_type = CDP_DATA;
 		break;
 	case RDT_RESOURCE_L2DATA:
 		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2CODE].r_resctrl;
+		*peer_type = CDP_CODE;
 		break;
 	case RDT_RESOURCE_L2CODE:
 		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2DATA].r_resctrl;
+		*peer_type = CDP_DATA;
 		break;
 	default:
 		ret = -ENOENT;
@@ -1184,7 +1191,8 @@ out:
  * Return: false if CBM does not overlap, true if it does.
  */
 static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
-				    unsigned long cbm, int closid, bool exclusive)
+				    unsigned long cbm, int closid,
+				    enum resctrl_conf_type type, bool exclusive)
 {
 	enum rdtgrp_mode mode;
 	unsigned long ctrl_b;
@@ -1199,7 +1207,7 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 
 	/* Check for overlap with other resource groups */
 	for (i = 0; i < closids_supported(); i++) {
-		resctrl_arch_get_config(r, d, i, (u32 *)&ctrl_b);
+		resctrl_arch_get_config(r, d, i, type, (u32 *)&ctrl_b);
 		mode = rdtgroup_mode_by_closid(i);
 		if (closid_allocated(i) && i != closid &&
 		    mode != RDT_MODE_PSEUDO_LOCKSETUP) {
@@ -1240,17 +1248,19 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
 			   unsigned long cbm, int closid, bool exclusive)
 {
+	enum resctrl_conf_type peer_type;
 	struct rdt_resource *r = s->res;
 	struct rdt_resource *r_cdp;
 	struct rdt_domain *d_cdp;
 
-	if (__rdtgroup_cbm_overlaps(r, d, cbm, closid, exclusive))
+	if (__rdtgroup_cbm_overlaps(r, d, cbm, closid, s->conf_type,
+				    exclusive))
 		return true;
 
-	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp) < 0)
+	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp, &peer_type) < 0)
 		return false;
 
-	return  __rdtgroup_cbm_overlaps(r_cdp, d_cdp, cbm, closid, exclusive);
+	return  __rdtgroup_cbm_overlaps(r_cdp, d_cdp, cbm, closid, peer_type, exclusive);
 }
 
 /**
@@ -1280,7 +1290,7 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 			continue;
 		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
-			resctrl_arch_get_config(r, d, closid, &ctrl);
+			resctrl_arch_get_config(r, d, closid, s->conf_type, &ctrl);
 			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
 				rdt_last_cmd_puts("Schemata overlaps\n");
 				return false;
@@ -1454,7 +1464,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 				size = 0;
 			} else {
 				resctrl_arch_get_config(r, d, rdtgrp->closid,
-							&ctrl);
+							schema->conf_type, &ctrl);
 				if (r->rid == RDT_RESOURCE_MBA)
 					size = ctrl;
 				else
@@ -2747,6 +2757,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	enum resctrl_conf_type t = s->conf_type;
 	struct rdt_resource *r_cdp = NULL;
 	struct resctrl_staged_config *cfg;
+	enum resctrl_conf_type peer_type;
 	struct rdt_domain *d_cdp = NULL;
 	struct rdt_resource *r = s->res;
 	u32 used_b = 0, unused_b = 0;
@@ -2755,7 +2766,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	u32 peer_ctl, ctrl_val;
 	int i;
 
-	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
+	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp, &peer_type);
 	cfg = &d->staged_config[t];
 	cfg->have_new_ctrl = false;
 	cfg->new_ctrl = r->cache.shareable_bits;
@@ -2776,10 +2787,10 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 			 * with an exclusive group.
 			 */
 			if (d_cdp)
-				resctrl_arch_get_config(r_cdp, d_cdp, i, &peer_ctl);
+				resctrl_arch_get_config(r_cdp, d_cdp, i, peer_type, &peer_ctl);
 			else
 				peer_ctl = 0;
-			resctrl_arch_get_config(r, d, i, &ctrl_val);
+			resctrl_arch_get_config(r, d, i, s->conf_type, &ctrl_val);
 			used_b |= ctrl_val | peer_ctl;
 			if (mode == RDT_MODE_SHAREABLE)
 				cfg->new_ctrl |= ctrl_val | peer_ctl;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 3a23094..69d7387 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -201,6 +201,7 @@ struct resctrl_schema {
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
-			     u32 closid, u32 *value);
+			     u32 closid, enum resctrl_conf_type type,
+			     u32 *value);
 
 #endif /* _RESCTRL_H */
