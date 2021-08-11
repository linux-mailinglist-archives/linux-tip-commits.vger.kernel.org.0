Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2163E9907
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhHKTmB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:42:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhHKTl5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:57 -0400
Date:   Wed, 11 Aug 2021 19:41:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710892;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7x0FmXQmj/5Yft3tNNg6PcnEIQL9YW982NXID7J+yrM=;
        b=nGlPhBjurzCgFp+3xqQ/h0cgV6f91DaHfN+OzzeWEjSce36P2nMGBb0HOb92JXITAUlVy8
        Ei9Qe4RpQX03mlyLvxHidKhNq7mr0r8VQT44t9ctvGCZlIa8xJ2d5zg+uFR7ukODYO7Oai
        Dpw3wzccPCdmmovvbv+hDxAc+2fdEVnE2KHJJaVeD+pFeCOIzKggLlJ7bBL9WZOGu8tnb2
        pMHcNtBjcfTDPpBd+5hFR5FVGyDvG6x6kDthm1+5cSQEvWwkZoTze0YmgMicNMI1HmaDPt
        ccnZM+dikB97X0jBynnYcqZDirwtHAAmuptZUCdoS1SJ+zhMZKhHwRhUMtNxOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710892;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7x0FmXQmj/5Yft3tNNg6PcnEIQL9YW982NXID7J+yrM=;
        b=vIpZKsnuNGgse1dY5OPd/L2CEeovbzVvcqy+qWjCcxc3dpXfSG8+0dJ4lHMYy2qCXAIajz
        OGDVtY4b9zJFiyAw==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Walk the resctrl schema list instead of
 an arch list
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-7-james.morse@arm.com>
References: <20210728170637.25610-7-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871089210.395.13588797537065926685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     331ebe4c43496cdc7f8d9a32d4ef59300b748435
Gitweb:        https://git.kernel.org/tip/331ebe4c43496cdc7f8d9a32d4ef59300b748435
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:19 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 13:20:43 +02:00

x86/resctrl: Walk the resctrl schema list instead of an arch list

When parsing a schema configuration value from user-space, resctrl walks
the architectures rdt_resources_all[] array to find a matching struct
rdt_resource.

Once the CDP resources are merged there will be one resource in use
by two schemata. Anything walking rdt_resources_all[] on behalf of a
user-space request should walk the list of struct resctrl_schema
instead.

Change the users of for_each_alloc_enabled_rdt_resource() to walk the
schema instead. Schemata were only created for alloc_enabled resources
so these two lists are currently equivalent.

schemata_list_create() and rdt_kill_sb() are ignored. The first
creates the schema list, and will eventually loop over the resource
indexes using an arch helper to retrieve the resource. rdt_kill_sb()
will eventually make use of an arch 'reset everything' helper.

After the filesystem code is moved, rdtgroup_pseudo_locked_in_hierarchy()
remains part of the x86 specific hooks to support pseudo lock. This
code walks each domain, and still does this after the separate resources
are merged.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-7-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 23 ++++++++++++++--------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 18 +++++++++++------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 08eef53..405b99d 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -287,10 +287,12 @@ static int rdtgroup_parse_resource(char *resname, char *tok,
 				   struct rdtgroup *rdtgrp)
 {
 	struct rdt_hw_resource *hw_res;
+	struct resctrl_schema *s;
 	struct rdt_resource *r;
 
-	for_each_alloc_enabled_rdt_resource(r) {
-		hw_res = resctrl_to_arch_res(r);
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		r = s->res;
+		hw_res = resctrl_to_arch_res(s->res);
 		if (!strcmp(resname, r->name) && rdtgrp->closid < hw_res->num_closid)
 			return parse_line(tok, r, rdtgrp);
 	}
@@ -301,6 +303,7 @@ static int rdtgroup_parse_resource(char *resname, char *tok,
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
 {
+	struct resctrl_schema *s;
 	struct rdtgroup *rdtgrp;
 	struct rdt_domain *dom;
 	struct rdt_resource *r;
@@ -331,8 +334,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 		goto out;
 	}
 
-	for_each_alloc_enabled_rdt_resource(r) {
-		list_for_each_entry(dom, &r->domains, list)
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		list_for_each_entry(dom, &s->res->domains, list)
 			dom->have_new_ctrl = false;
 	}
 
@@ -353,7 +356,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 			goto out;
 	}
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		r = s->res;
 		ret = update_domains(r, rdtgrp->closid);
 		if (ret)
 			goto out;
@@ -401,6 +405,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v)
 {
 	struct rdt_hw_resource *hw_res;
+	struct resctrl_schema *schema;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	int ret = 0;
@@ -409,8 +414,10 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (rdtgrp) {
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
-			for_each_alloc_enabled_rdt_resource(r)
+			list_for_each_entry(schema, &resctrl_schema_all, list) {
+				r = schema->res;
 				seq_printf(s, "%s:uninitialized\n", r->name);
+			}
 		} else if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
 			if (!rdtgrp->plr->d) {
 				rdt_last_cmd_clear();
@@ -424,8 +431,8 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			}
 		} else {
 			closid = rdtgrp->closid;
-			for_each_alloc_enabled_rdt_resource(r) {
-				hw_res = resctrl_to_arch_res(r);
+			list_for_each_entry(schema, &resctrl_schema_all, list) {
+				hw_res = resctrl_to_arch_res(schema->res);
 				if (closid < hw_res->num_closid)
 					show_doms(s, r, closid);
 			}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d7fd071..7502b7d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -104,12 +104,12 @@ int closids_supported(void)
 static void closid_init(void)
 {
 	struct rdt_hw_resource *hw_res;
-	struct rdt_resource *r;
+	struct resctrl_schema *s;
 	int rdt_min_closid = 32;
 
 	/* Compute rdt_min_closid across all resources */
-	for_each_alloc_enabled_rdt_resource(r) {
-		hw_res = resctrl_to_arch_res(r);
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		hw_res = resctrl_to_arch_res(s->res);
 		rdt_min_closid = min(rdt_min_closid, hw_res->num_closid);
 	}
 
@@ -1276,11 +1276,13 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 {
 	struct rdt_hw_domain *hw_dom;
 	int closid = rdtgrp->closid;
+	struct resctrl_schema *s;
 	struct rdt_resource *r;
 	bool has_cache = false;
 	struct rdt_domain *d;
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		r = s->res;
 		if (r->rid == RDT_RESOURCE_MBA)
 			continue;
 		has_cache = true;
@@ -1418,6 +1420,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 static int rdtgroup_size_show(struct kernfs_open_file *of,
 			      struct seq_file *s, void *v)
 {
+	struct resctrl_schema *schema;
 	struct rdt_hw_domain *hw_dom;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -1449,7 +1452,8 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		goto out;
 	}
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	list_for_each_entry(schema, &resctrl_schema_all, list) {
+		r = schema->res;
 		sep = false;
 		seq_printf(s, "%*s:", max_name_width, r->name);
 		list_for_each_entry(d, &r->domains, list) {
@@ -2815,10 +2819,12 @@ static void rdtgroup_init_mba(struct rdt_resource *r)
 /* Initialize the RDT group's allocations. */
 static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 {
+	struct resctrl_schema *s;
 	struct rdt_resource *r;
 	int ret;
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		r = s->res;
 		if (r->rid == RDT_RESOURCE_MBA) {
 			rdtgroup_init_mba(r);
 		} else {
