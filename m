Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA1C3E9900
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhHKTl6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:41:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53574 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhHKTly (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:54 -0400
Date:   Wed, 11 Aug 2021 19:41:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95dNBib4fyPUKjRV7pAhRoKBhE12OLadNvnBrCvpu0E=;
        b=RyiZnu1SfpKvCY4V+z/+TL8CTyyeIM81M/0eh9AiRViuTCNFq5DcE51ob2g8hlIYTOwpJ0
        EAUPwXw8lE2qo3x/69y2pob1VH1m8YdlfkWx5+6ENDts4zRKVrXhLHXDIr/eUu5E/JNrOq
        /I+W3nOfK3JpRjJZNhOMh6fsofWcx0BvExwKPg9hw5yvOfyvb1zWL6wrigpb59NZyhSWJ7
        9ZwIdDjubKj0ZlfbncO1u64WrrmdyKwczZo/+MSyh8pGpzBwP24g/EQ2KWIQsuIJkNrdzg
        KP+OiJarMtjAIbL+VK6hyMdnVHaVPvsQgpEpBuudvEOXW9I9+LWDTtG6F769Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95dNBib4fyPUKjRV7pAhRoKBhE12OLadNvnBrCvpu0E=;
        b=apwdsXy/vbGTcehrZQFyoOMEAyk28mp9MSdta7cJJm7vRRiGIAFoO6oizSHIigtTyNWZdR
        jIs2xy4Hg2NZ/gBQ==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move the schemata names into struct
 resctrl_schema
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-13-james.morse@arm.com>
References: <20210728170637.25610-13-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871088843.395.15678854173683918468.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     e198fde3fe0892a5d1e28c0e29f1eebfb6f8c1cd
Gitweb:        https://git.kernel.org/tip/e198fde3fe0892a5d1e28c0e29f1eebfb6f8c1cd
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:25 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 16:21:35 +02:00

x86/resctrl: Move the schemata names into struct resctrl_schema

resctrl 'info' directories and schema parsing use the schema name.
This lives in the struct rdt_resource, and is specified by the
architecture code.

Once the CDP resources are merged, there will only be one resource (and
one name) in use by two schemata. To allow the CDP CODE/DATA property to
be the type of configuration the schema uses, the name should also be
per-schema.

Add a name field to struct resctrl_schema, and use this wherever
the schema name is exposed (or read from) user-space. Calculating
max_name_width for padding the schemata file also moves as this is
visible to user-space. As the names in struct rdt_resource already
include the CDP information, schemata_list_create() copies them.

schemata_list_create() includes the length of the CDP suffix when
calculating max_name_width in preparation for CDP resources being
merged.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-13-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c        |  5 +----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 ++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 29 ++++++++++++++++++----
 include/linux/resctrl.h                   |  2 ++-
 4 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 87b5aa7..755118a 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -782,13 +782,8 @@ static int resctrl_offline_cpu(unsigned int cpu)
 static __init void rdt_init_padding(void)
 {
 	struct rdt_resource *r;
-	int cl;
 
 	for_each_alloc_capable_rdt_resource(r) {
-		cl = strlen(r->name);
-		if (cl > max_name_width)
-			max_name_width = cl;
-
 		if (r->data_width > max_data_width)
 			max_data_width = r->data_width;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 0ee1ded..104b285 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -290,11 +290,9 @@ static int rdtgroup_parse_resource(char *resname, char *tok,
 				   struct rdtgroup *rdtgrp)
 {
 	struct resctrl_schema *s;
-	struct rdt_resource *r;
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
-		r = s->res;
-		if (!strcmp(resname, r->name) && rdtgrp->closid < s->num_closid)
+		if (!strcmp(resname, s->name) && rdtgrp->closid < s->num_closid)
 			return parse_line(tok, s, rdtgrp);
 	}
 	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
@@ -388,7 +386,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 	bool sep = false;
 	u32 ctrl_val;
 
-	seq_printf(s, "%*s:", max_name_width, r->name);
+	seq_printf(s, "%*s:", max_name_width, schema->name);
 	list_for_each_entry(dom, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(dom);
 		if (sep)
@@ -408,7 +406,6 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 {
 	struct resctrl_schema *schema;
 	struct rdtgroup *rdtgrp;
-	struct rdt_resource *r;
 	int ret = 0;
 	u32 closid;
 
@@ -416,8 +413,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 	if (rdtgrp) {
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 			list_for_each_entry(schema, &resctrl_schema_all, list) {
-				r = schema->res;
-				seq_printf(s, "%s:uninitialized\n", r->name);
+				seq_printf(s, "%s:uninitialized\n", schema->name);
 			}
 		} else if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
 			if (!rdtgrp->plr->d) {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cc9dacd..1f8c8d7 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1439,7 +1439,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			ret = -ENODEV;
 		} else {
 			seq_printf(s, "%*s:", max_name_width,
-				   rdtgrp->plr->s->res->name);
+				   rdtgrp->plr->s->name);
 			size = rdtgroup_cbm_to_size(rdtgrp->plr->s->res,
 						    rdtgrp->plr->d,
 						    rdtgrp->plr->cbm);
@@ -1451,7 +1451,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 	list_for_each_entry(schema, &resctrl_schema_all, list) {
 		r = schema->res;
 		sep = false;
-		seq_printf(s, "%*s:", max_name_width, r->name);
+		seq_printf(s, "%*s:", max_name_width, schema->name);
 		list_for_each_entry(d, &r->domains, list) {
 			hw_dom = resctrl_to_arch_dom(d);
 			if (sep)
@@ -1823,7 +1823,7 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
 		fflags =  r->fflags | RF_CTRL_INFO;
-		ret = rdtgroup_mkdir_info_resdir(s, r->name, fflags);
+		ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
 		if (ret)
 			goto out_destroy;
 	}
@@ -2141,6 +2141,7 @@ static int schemata_list_create(void)
 {
 	struct resctrl_schema *s;
 	struct rdt_resource *r;
+	int ret, cl;
 
 	for_each_alloc_enabled_rdt_resource(r) {
 		s = kzalloc(sizeof(*s), GFP_KERNEL);
@@ -2151,6 +2152,26 @@ static int schemata_list_create(void)
 		s->conf_type = resctrl_to_arch_res(r)->conf_type;
 		s->num_closid = resctrl_arch_get_num_closid(r);
 
+		ret = snprintf(s->name, sizeof(s->name), r->name);
+		if (ret >= sizeof(s->name)) {
+			kfree(s);
+			return -EINVAL;
+		}
+
+		cl = strlen(s->name);
+
+		/*
+		 * If CDP is supported by this resource, but not enabled,
+		 * include the suffix. This ensures the tabular format of the
+		 * schemata file does not change between mounts of the
+		 * filesystem.
+		 */
+		if (r->cdp_capable && !resctrl_arch_get_cdp_enabled(r->rid))
+			cl += 4;
+
+		if (cl > max_name_width)
+			max_name_width = cl;
+
 		INIT_LIST_HEAD(&s->list);
 		list_add(&s->list, &resctrl_schema_all);
 	}
@@ -2784,7 +2805,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	 */
 	tmp_cbm = d->new_ctrl;
 	if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
-		rdt_last_cmd_printf("No space on %s:%d\n", r->name, d->id);
+		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->id);
 		return -ENOSPC;
 	}
 	d->have_new_ctrl = true;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 4b30571..e482ce7 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -171,6 +171,7 @@ struct rdt_resource {
  * struct resctrl_schema - configuration abilities of a resource presented to
  *			   user-space
  * @list:	Member of resctrl_schema_all.
+ * @name:	The name to use in the "schemata" file.
  * @conf_type:	Whether this schema is specific to code/data.
  * @res:	The resource structure exported by the architecture to describe
  *		the hardware that is configured by this schema.
@@ -180,6 +181,7 @@ struct rdt_resource {
  */
 struct resctrl_schema {
 	struct list_head		list;
+	char				name[8];
 	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
 	u32				num_closid;
