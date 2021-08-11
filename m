Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C13F3E9904
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhHKTmB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:42:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53728 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhHKTl4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:56 -0400
Date:   Wed, 11 Aug 2021 19:41:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710891;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AK+HnJj5K+ksXnTP5/ZoWcXpndNlwL+MHGKq7P1YSLQ=;
        b=3Vl1YNFuFfpm8Qz+GrLsrLZnpl/Kaxo4kX3Qi1DoRKZFk2Gm5EeB8HjFARavU4LYajkoTO
        3pcV9x5FZVCvcHw1Z2h2HSS0Tnrhl0xs5qKv/13UJeES4Dl52gFOTYACTt93cF2tv7NOO8
        UzCdrcX8vaZJtQdamf4oJ07e4FOCBFnAOiFKb9BJ0Fyupu4rSLCf22bU4MdtT3zCenKbgx
        Hx0ILCohn9ZLvhW6mC5/eCa4y4AKoPdsy9N5Xxmaks5v9wRgeJdSqUFx+GbwKi0n74x8xg
        E90RjCRZ6pSLCPqLN2IFGBTiLFWQJuTEeyL8lRhbQBHa6TBiH+sJzuIIzhJk9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710891;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AK+HnJj5K+ksXnTP5/ZoWcXpndNlwL+MHGKq7P1YSLQ=;
        b=uy/UQ+2/tvC/QR06WCTuoFZSov3+sZ/kRwy1ykEU/Ws+k4u9osujSnySDJuLnEGlRV5rIl
        ZQQhBGNeMgD1baBg==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Pass the schema to resctrl filesystem functions
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-10-james.morse@arm.com>
References: <20210728170637.25610-10-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871089015.395.11457484234834997070.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     1c290682c0c9c47aa7594ffc83b9cedd20c1ec87
Gitweb:        https://git.kernel.org/tip/1c290682c0c9c47aa7594ffc83b9cedd20c1ec87
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:22 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 15:43:54 +02:00

x86/resctrl: Pass the schema to resctrl filesystem functions

Once the CDP resources are merged, there will be two struct
resctrl_schema for one struct rdt_resource. CDP becomes a type of
configuration that belongs to the schema.

Helpers like rdtgroup_cbm_overlaps() need access to the schema to query
the configuration (or configurations) based on schema properties.

Change these functions to take a struct schema instead of the struct
rdt_resource. All the modified functions are part of the filesystem code
that will move to /fs/resctrl once it is possible to support a second
architecture.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-10-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 23 ++++++++++++----------
 arch/x86/kernel/cpu/resctrl/internal.h    |  6 +++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 19 ++++++++++--------
 include/linux/resctrl.h                   |  3 ++-
 4 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index d10fdda..219b057 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -57,9 +57,10 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 	return true;
 }
 
-int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
+int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	     struct rdt_domain *d)
 {
+	struct rdt_resource *r = s->res;
 	unsigned long bw_val;
 
 	if (d->have_new_ctrl) {
@@ -125,10 +126,11 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
  */
-int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
+int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	      struct rdt_domain *d)
 {
 	struct rdtgroup *rdtgrp = data->rdtgrp;
+	struct rdt_resource *r = s->res;
 	u32 cbm_val;
 
 	if (d->have_new_ctrl) {
@@ -160,12 +162,12 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 	 * The CBM may not overlap with the CBM of another closid if
 	 * either is exclusive.
 	 */
-	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, true)) {
+	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, true)) {
 		rdt_last_cmd_puts("Overlaps with exclusive group\n");
 		return -EINVAL;
 	}
 
-	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, false)) {
+	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, false)) {
 		if (rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
 		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 			rdt_last_cmd_puts("Overlaps with other group\n");
@@ -185,9 +187,10 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
  * separated by ";". The "id" is in decimal, and must match one of
  * the "id"s for this resource.
  */
-static int parse_line(char *line, struct rdt_resource *r,
+static int parse_line(char *line, struct resctrl_schema *s,
 		      struct rdtgroup *rdtgrp)
 {
+	struct rdt_resource *r = s->res;
 	struct rdt_parse_data data;
 	char *dom = NULL, *id;
 	struct rdt_domain *d;
@@ -213,7 +216,7 @@ next:
 		if (d->id == dom_id) {
 			data.buf = dom;
 			data.rdtgrp = rdtgrp;
-			if (r->parse_ctrlval(&data, r, d))
+			if (r->parse_ctrlval(&data, s, d))
 				return -EINVAL;
 			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
 				/*
@@ -292,7 +295,7 @@ static int rdtgroup_parse_resource(char *resname, char *tok,
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
 		if (!strcmp(resname, r->name) && rdtgrp->closid < s->num_closid)
-			return parse_line(tok, r, rdtgrp);
+			return parse_line(tok, s, rdtgrp);
 	}
 	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
 	return -EINVAL;
@@ -377,8 +380,9 @@ out:
 	return ret ?: nbytes;
 }
 
-static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
+static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
 {
+	struct rdt_resource *r = schema->res;
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *dom;
 	bool sep = false;
@@ -429,9 +433,8 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 		} else {
 			closid = rdtgrp->closid;
 			list_for_each_entry(schema, &resctrl_schema_all, list) {
-				r = schema->res;
 				if (closid < schema->num_closid)
-					show_doms(s, r, closid);
+					show_doms(s, schema, closid);
 			}
 		}
 	} else {
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c4bc5fa..5d5debe 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -401,9 +401,9 @@ static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r
 	return container_of(r, struct rdt_hw_resource, r_resctrl);
 }
 
-int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
+int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	      struct rdt_domain *d);
-int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
+int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	     struct rdt_domain *d);
 
 extern struct mutex rdtgroup_mutex;
@@ -505,7 +505,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
-bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
 			   unsigned long cbm, int closid, bool exclusive);
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_domain *d,
 				  unsigned long cbm);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 09ffe9a..53d281a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1221,7 +1221,7 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 
 /**
  * rdtgroup_cbm_overlaps - Does CBM overlap with other use of hardware
- * @r: Resource to which domain instance @d belongs.
+ * @s: Schema for the resource to which domain instance @d belongs.
  * @d: The domain instance for which @closid is being tested.
  * @cbm: Capacity bitmask being tested.
  * @closid: Intended closid for @cbm.
@@ -1239,9 +1239,10 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
  *
  * Return: true if CBM overlap detected, false if there is no overlap
  */
-bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
 			   unsigned long cbm, int closid, bool exclusive)
 {
+	struct rdt_resource *r = s->res;
 	struct rdt_resource *r_cdp;
 	struct rdt_domain *d_cdp;
 
@@ -1282,7 +1283,8 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
 			hw_dom = resctrl_to_arch_dom(d);
-			if (rdtgroup_cbm_overlaps(r, d, hw_dom->ctrl_val[closid],
+			if (rdtgroup_cbm_overlaps(s, d,
+						  hw_dom->ctrl_val[closid],
 						  rdtgrp->closid, false)) {
 				rdt_last_cmd_puts("Schemata overlaps\n");
 				return false;
@@ -2712,11 +2714,12 @@ static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
  * Set the RDT domain up to start off with all usable allocations. That is,
  * all shareable and unused bits. All-zero CBM is invalid.
  */
-static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
+static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 				 u32 closid)
 {
 	struct rdt_resource *r_cdp = NULL;
 	struct rdt_domain *d_cdp = NULL;
+	struct rdt_resource *r = s->res;
 	u32 used_b = 0, unused_b = 0;
 	unsigned long tmp_cbm;
 	enum rdtgrp_mode mode;
@@ -2786,13 +2789,13 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
  * If there are no more shareable bits available on any domain then
  * the entire allocation will fail.
  */
-static int rdtgroup_init_cat(struct rdt_resource *r, u32 closid)
+static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 {
 	struct rdt_domain *d;
 	int ret;
 
-	list_for_each_entry(d, &r->domains, list) {
-		ret = __init_one_rdt_domain(d, r, closid);
+	list_for_each_entry(d, &s->res->domains, list) {
+		ret = __init_one_rdt_domain(d, s, closid);
 		if (ret < 0)
 			return ret;
 	}
@@ -2823,7 +2826,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 		if (r->rid == RDT_RESOURCE_MBA) {
 			rdtgroup_init_mba(r);
 		} else {
-			ret = rdtgroup_init_cat(r, rdtgrp->closid);
+			ret = rdtgroup_init_cat(s, rdtgrp->closid);
 			if (ret < 0)
 				return ret;
 		}
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index b9d2005..979592c 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -121,6 +121,7 @@ struct resctrl_membw {
 };
 
 struct rdt_parse_data;
+struct resctrl_schema;
 
 /**
  * struct rdt_resource - attributes of a resctrl resource
@@ -158,7 +159,7 @@ struct rdt_resource {
 	u32			default_ctrl;
 	const char		*format_str;
 	int			(*parse_ctrlval)(struct rdt_parse_data *data,
-						 struct rdt_resource *r,
+						 struct resctrl_schema *s,
 						 struct rdt_domain *d);
 	struct list_head	evt_list;
 	unsigned long		fflags;
