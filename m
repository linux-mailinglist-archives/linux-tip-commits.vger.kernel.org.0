Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7911F3E990C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhHKTmE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:42:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53574 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhHKTl7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:59 -0400
Date:   Wed, 11 Aug 2021 19:41:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710894;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wozxhdDvpJ6H6Nr9quWjLn2ZtP7OBSakf/V+UmxAYdE=;
        b=CY7WGX8F+SNRNKt+tR1j9cggv/dxHzoi0PsjoDaUYuK7eVpgQBbMPCjbuQeBZiKB9iwvsf
        VCKjRw0ZE60h7UmaZOrlpuAMITNMx1wovzzVVz0s6jK1oN03z+1DePcIAnA+0o3tl9TBuT
        lNRoEnX+Vb1trW/8x9MXcRM/zqGmPOfp9+A6KBZseLGy/TRMPfzL/nKlEIP5VYFylzSTI1
        0T0bWthMFdCebMEIGeYN8PhdqtVw8lBS7WCx9uS6GlCkbTKex/UPwGoXzWOgzT8cGqsWaD
        Hy+vKRBvXMKlPxvGD/MJy+1yO2LC5K4gOq45VbxUKdcnPNXBhpnSVpW856PeDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710894;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wozxhdDvpJ6H6Nr9quWjLn2ZtP7OBSakf/V+UmxAYdE=;
        b=fQ/2TU0W6zj+nCKmEia74pTwwlMakXRg3X1lZKlZWd1K2VUt3F1VZR2QuYqTkOC7MHujKk
        zx7cPbDX0M3+qvAA==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Pass the schema in info dir's private pointer
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-5-james.morse@arm.com>
References: <20210728170637.25610-5-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871089320.395.17946912039444953915.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     f2594492308d2a950c9f765eb719480f3b881f0a
Gitweb:        https://git.kernel.org/tip/f2594492308d2a950c9f765eb719480f3b881f0a
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:17 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 12:41:19 +02:00

x86/resctrl: Pass the schema in info dir's private pointer

Many of resctrl's per-schema files return a value from struct
rdt_resource, which they take as their 'priv' pointer.

Moving properties that resctrl exposes to user-space into the core 'fs'
code, (e.g. the name of the schema), means some of the functions that
back the filesystem need the schema struct (to where the properties are
moved), but currently take struct rdt_resource. For example, once the
CDP resources are merged, struct rdt_resource no longer reflects all the
properties of the schema.

For the info dirs that represent a control, the information needed
will be accessed via struct resctrl_schema, as this is how the resource
is being used. For the monitors, its still struct rdt_resource as the
monitors aren't described as schema.

This difference means the type of the private pointers varies between
control and monitor info dirs.

Change the 'priv' pointer to point to struct resctrl_schema for
the per-schema files that represent a control. The type can be
determined from the fflags field. If the flags are RF_MON_INFO, its
a struct rdt_resource. If the flags are RF_CTRL_INFO, its a struct
resctrl_schema. No entry in res_common_files[] has both flags.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-5-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 38 ++++++++++++++++---------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3e0b6aa..1fc40db 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -848,7 +848,8 @@ static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
 static int rdt_num_closids_show(struct kernfs_open_file *of,
 				struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 	struct rdt_hw_resource *hw_res;
 
 	hw_res = resctrl_to_arch_res(r);
@@ -859,7 +860,8 @@ static int rdt_num_closids_show(struct kernfs_open_file *of,
 static int rdt_default_ctrl_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%x\n", r->default_ctrl);
 	return 0;
@@ -868,7 +870,8 @@ static int rdt_default_ctrl_show(struct kernfs_open_file *of,
 static int rdt_min_cbm_bits_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%u\n", r->cache.min_cbm_bits);
 	return 0;
@@ -877,7 +880,8 @@ static int rdt_min_cbm_bits_show(struct kernfs_open_file *of,
 static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 				   struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%x\n", r->cache.shareable_bits);
 	return 0;
@@ -900,13 +904,14 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			      struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
 	/*
 	 * Use unsigned long even though only 32 bits are used to ensure
 	 * test_bit() is used safely.
 	 */
 	unsigned long sw_shareable = 0, hw_shareable = 0;
 	unsigned long exclusive = 0, pseudo_locked = 0;
+	struct rdt_resource *r = s->res;
 	struct rdt_domain *dom;
 	int i, hwb, swb, excl, psl;
 	enum rdtgrp_mode mode;
@@ -978,7 +983,8 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 static int rdt_min_bw_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%u\n", r->membw.min_bw);
 	return 0;
@@ -1009,7 +1015,8 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 static int rdt_bw_gran_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%u\n", r->membw.bw_gran);
 	return 0;
@@ -1018,7 +1025,8 @@ static int rdt_bw_gran_show(struct kernfs_open_file *of,
 static int rdt_delay_linear_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	seq_printf(seq, "%u\n", r->membw.delay_linear);
 	return 0;
@@ -1038,7 +1046,8 @@ static int max_threshold_occ_show(struct kernfs_open_file *of,
 static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
 					 struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
+	struct resctrl_schema *s = of->kn->parent->priv;
+	struct rdt_resource *r = s->res;
 
 	if (r->membw.throttle_mode == THREAD_THROTTLE_PER_THREAD)
 		seq_puts(seq, "per-thread\n");
@@ -1771,14 +1780,14 @@ int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
 	return ret;
 }
 
-static int rdtgroup_mkdir_info_resdir(struct rdt_resource *r, char *name,
+static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
 				      unsigned long fflags)
 {
 	struct kernfs_node *kn_subdir;
 	int ret;
 
 	kn_subdir = kernfs_create_dir(kn_info, name,
-				      kn_info->mode, r);
+				      kn_info->mode, priv);
 	if (IS_ERR(kn_subdir))
 		return PTR_ERR(kn_subdir);
 
@@ -1795,6 +1804,7 @@ static int rdtgroup_mkdir_info_resdir(struct rdt_resource *r, char *name,
 
 static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 {
+	struct resctrl_schema *s;
 	struct rdt_resource *r;
 	unsigned long fflags;
 	char name[32];
@@ -1809,9 +1819,11 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	if (ret)
 		goto out_destroy;
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	/* loop over enabled controls, these are all alloc_enabled */
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		r = s->res;
 		fflags =  r->fflags | RF_CTRL_INFO;
-		ret = rdtgroup_mkdir_info_resdir(r, r->name, fflags);
+		ret = rdtgroup_mkdir_info_resdir(s, r->name, fflags);
 		if (ret)
 			goto out_destroy;
 	}
