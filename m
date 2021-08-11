Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1F83E98F1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhHKTls (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhHKTls (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED59CC0613D3;
        Wed, 11 Aug 2021 12:41:23 -0700 (PDT)
Date:   Wed, 11 Aug 2021 19:41:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7muyi+TzPeF74HWt2zkk4Y/YvExSwvt1B1pymrOfuIE=;
        b=mhI0qxGeFV9Km7sRVKQr7CKHeYSBj7bn8Mi8x8qAdYmOk54t6xIwYZ+iE38KcgLy1QcsZl
        9VGOQHmxXXFzULtlkHl1DMhpYvXNqkrRRuk2ySts3a9hkEdu8Hkoeo4GHWhNovAEaFuC9j
        CK4MR+Zkg+Mo9Gro2Q/TK7hnpx+W3qqoGIZiqKY2R2Sp2C769h6Kcd9C9AtKKGPEGqG5fQ
        3FxcMczV8ix6yDHgsswyMNI9sAqHAmrSl1DA6+/fDNkwabjKCJX+ldMkMHLG4xP8ekuC2H
        zgBk1Bamoj3mnmxsT9oovWwIorcYfr2ZukTqWopZ8URMJF6hcMWNnpVgGcZmHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7muyi+TzPeF74HWt2zkk4Y/YvExSwvt1B1pymrOfuIE=;
        b=E9VN6hdHDbJYLtOH9yxRdF+a+WMgYHtSlUiE5A4Bl4NrBXbgm+qtE5CWzoKus14OfYHP//
        EC+Snkpr2GqmAqAg==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Make resctrl_arch_get_config() return its value
Cc:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210811163831.14917-1-james.morse@arm.com>
References: <20210811163831.14917-1-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871088028.395.4858783989401486742.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     111136e69c9df50c3ca7d4e3977344b8a2d0d947
Gitweb:        https://git.kernel.org/tip/111136e69c9df50c3ca7d4e3977344b8a2d0d947
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 11 Aug 2021 16:38:31 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 18:42:53 +02:00

x86/resctrl: Make resctrl_arch_get_config() return its value

resctrl_arch_get_config() has no return, but does pass a single value
back via one of its arguments.

Return the value instead.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210811163831.14917-1-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 13 ++++++-------
 arch/x86/kernel/cpu/resctrl/monitor.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 20 ++++++++++++--------
 include/linux/resctrl.h                   |  5 ++---
 4 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index a487cf7..8766627 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -427,16 +427,15 @@ out:
 	return ret ?: nbytes;
 }
 
-void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
-			     u32 closid, enum resctrl_conf_type type, u32 *value)
+u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
+			    u32 closid, enum resctrl_conf_type type)
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	u32 idx = get_config_index(closid, type);
 
 	if (!is_mba_sc(r))
-		*value = hw_dom->ctrl_val[idx];
-	else
-		*value = hw_dom->mbps_val[idx];
+		return hw_dom->ctrl_val[idx];
+	return hw_dom->mbps_val[idx];
 }
 
 static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
@@ -451,8 +450,8 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 		if (sep)
 			seq_puts(s, ";");
 
-		resctrl_arch_get_config(r, dom, closid, schema->conf_type,
-					&ctrl_val);
+		ctrl_val = resctrl_arch_get_config(r, dom, closid,
+						   schema->conf_type);
 		seq_printf(s, r->format_str, dom->id, max_data_width,
 			   ctrl_val);
 		sep = true;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index eb22729..b0741be 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -442,7 +442,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
 
 	cur_bw = pmbm_data->prev_bw;
-	resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE, &user_bw);
+	user_bw = resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE);
 	delta_bw = pmbm_data->delta_bw;
 	/*
 	 * resctrl_arch_get_config() chooses the mbps/ctrl value to return
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 89123a4..b57b3db 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -923,8 +923,8 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 		for (i = 0; i < closids_supported(); i++) {
 			if (!closid_allocated(i))
 				continue;
-			resctrl_arch_get_config(r, dom, i, s->conf_type,
-						&ctrl_val);
+			ctrl_val = resctrl_arch_get_config(r, dom, i,
+							   s->conf_type);
 			mode = rdtgroup_mode_by_closid(i);
 			switch (mode) {
 			case RDT_MODE_SHAREABLE:
@@ -1142,7 +1142,7 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 
 	/* Check for overlap with other resource groups */
 	for (i = 0; i < closids_supported(); i++) {
-		resctrl_arch_get_config(r, d, i, type, (u32 *)&ctrl_b);
+		ctrl_b = resctrl_arch_get_config(r, d, i, type);
 		mode = rdtgroup_mode_by_closid(i);
 		if (closid_allocated(i) && i != closid &&
 		    mode != RDT_MODE_PSEUDO_LOCKSETUP) {
@@ -1222,7 +1222,8 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 			continue;
 		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
-			resctrl_arch_get_config(r, d, closid, s->conf_type, &ctrl);
+			ctrl = resctrl_arch_get_config(r, d, closid,
+						       s->conf_type);
 			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
 				rdt_last_cmd_puts("Schemata overlaps\n");
 				return false;
@@ -1395,8 +1396,9 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 				size = 0;
 			} else {
-				resctrl_arch_get_config(r, d, rdtgrp->closid,
-							schema->conf_type, &ctrl);
+				ctrl = resctrl_arch_get_config(r, d,
+							       rdtgrp->closid,
+							       schema->conf_type);
 				if (r->rid == RDT_RESOURCE_MBA)
 					size = ctrl;
 				else
@@ -2724,10 +2726,12 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 			 * with an exclusive group.
 			 */
 			if (resctrl_arch_get_cdp_enabled(r->rid))
-				resctrl_arch_get_config(r, d, i, peer_type, &peer_ctl);
+				peer_ctl = resctrl_arch_get_config(r, d, i,
+								   peer_type);
 			else
 				peer_ctl = 0;
-			resctrl_arch_get_config(r, d, i, s->conf_type, &ctrl_val);
+			ctrl_val = resctrl_arch_get_config(r, d, i,
+							   s->conf_type);
 			used_b |= ctrl_val | peer_ctl;
 			if (mode == RDT_MODE_SHAREABLE)
 				cfg->new_ctrl |= ctrl_val | peer_ctl;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 18dd764..21deb52 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -194,8 +194,7 @@ struct resctrl_schema {
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
-void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
-			     u32 closid, enum resctrl_conf_type type,
-			     u32 *value);
+u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
+			    u32 closid, enum resctrl_conf_type type);
 
 #endif /* _RESCTRL_H */
