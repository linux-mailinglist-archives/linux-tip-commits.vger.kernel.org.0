Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD703E9901
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhHKTl6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:41:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53750 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhHKTl5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:57 -0400
Date:   Wed, 11 Aug 2021 19:41:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710892;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ABX9K8Wm/yPMilwMOifQkl9fXVXu5fF7RE179Lq4QX8=;
        b=Cp1EL63GMRdo4GV+RhYS3hDFw0tYIJROb3R6vJ9cwc0iASCWnQe+bsZgS6cLkupTEA2bH2
        vAFeEgCISgN7VA9JGvr4Cr9Pzp1XoxunaXuarnIVaxQvwue7vLGlSSVuksmK2MokEJLZdb
        //bt6kUgu3FqhXRND9P7sioDGGfS+wiA3wj7oyDNnDEV1oQuQoSdEPitfXj3Ugm6o0DQHm
        VV0656tLxNd9+X0vtQ6keERu9PnBofMIbOi9kmz7dVqCsspIVd8SRch2p0ulE9iFd7ATvH
        BW/I/1np496yroe0LGYMGAjdIS4MPiJvqafl3dMggPPrK+vFs9I5KJBe4FqHJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710892;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ABX9K8Wm/yPMilwMOifQkl9fXVXu5fF7RE179Lq4QX8=;
        b=NcuXgnRa8+HJYAATh4pS/Lty2r7tkfqAWcNqj00udpsKDgaO2kX08CCMrXkSDxkMjyd6ze
        0RQ15Gu2XQty5ICQ==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Store the effective num_closid in the schema
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-8-james.morse@arm.com>
References: <20210728170637.25610-8-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871089148.395.12025293492025159378.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     3183e87c1b797caaeb208b01c99bea8140273a16
Gitweb:        https://git.kernel.org/tip/3183e87c1b797caaeb208b01c99bea8140273a16
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:20 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 15:24:27 +02:00

x86/resctrl: Store the effective num_closid in the schema

Struct resctrl_schema holds properties that vary with the style of
configuration that resctrl applies to a resource. There are already
two values for the hardware's num_closid, depending on whether the
architecture presents the L3 or L3CODE/L3DATA resources.

As the way CDP changes the number of control groups that resctrl can
create is part of the user-space interface, it should be managed by the
filesystem parts of resctrl. This allows the architecture code to only
describe the value the hardware supports.

Add num_closid to resctrl_schema. This is the value seen by the
filesystem, which may be different to the maximum value described by the
arch code when CDP is enabled.

These functions operate on the num_closid value that is exposed to
user-space:

  * rdtgroup_parse_resource()
  * rdtgroup_schemata_show()
  * rdt_num_closids_show()
  * closid_init()

Change them to use the schema value instead. schemata_list_create() sets
this value, and reaches into the architecture-specific structure to get
the value. This will eventually be replaced with a helper.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-8-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  9 +++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 13 ++++---------
 include/linux/resctrl.h                   |  4 ++++
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 405b99d..d10fdda 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -286,14 +286,12 @@ done:
 static int rdtgroup_parse_resource(char *resname, char *tok,
 				   struct rdtgroup *rdtgrp)
 {
-	struct rdt_hw_resource *hw_res;
 	struct resctrl_schema *s;
 	struct rdt_resource *r;
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
-		hw_res = resctrl_to_arch_res(s->res);
-		if (!strcmp(resname, r->name) && rdtgrp->closid < hw_res->num_closid)
+		if (!strcmp(resname, r->name) && rdtgrp->closid < s->num_closid)
 			return parse_line(tok, r, rdtgrp);
 	}
 	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
@@ -404,7 +402,6 @@ static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v)
 {
-	struct rdt_hw_resource *hw_res;
 	struct resctrl_schema *schema;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -432,8 +429,8 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 		} else {
 			closid = rdtgrp->closid;
 			list_for_each_entry(schema, &resctrl_schema_all, list) {
-				hw_res = resctrl_to_arch_res(schema->res);
-				if (closid < hw_res->num_closid)
+				r = schema->res;
+				if (closid < schema->num_closid)
 					show_doms(s, r, closid);
 			}
 		}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7502b7d..2f29b7d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -103,15 +103,12 @@ int closids_supported(void)
 
 static void closid_init(void)
 {
-	struct rdt_hw_resource *hw_res;
 	struct resctrl_schema *s;
 	int rdt_min_closid = 32;
 
 	/* Compute rdt_min_closid across all resources */
-	list_for_each_entry(s, &resctrl_schema_all, list) {
-		hw_res = resctrl_to_arch_res(s->res);
-		rdt_min_closid = min(rdt_min_closid, hw_res->num_closid);
-	}
+	list_for_each_entry(s, &resctrl_schema_all, list)
+		rdt_min_closid = min(rdt_min_closid, s->num_closid);
 
 	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
 
@@ -849,11 +846,8 @@ static int rdt_num_closids_show(struct kernfs_open_file *of,
 				struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = of->kn->parent->priv;
-	struct rdt_resource *r = s->res;
-	struct rdt_hw_resource *hw_res;
 
-	hw_res = resctrl_to_arch_res(r);
-	seq_printf(seq, "%d\n", hw_res->num_closid);
+	seq_printf(seq, "%u\n", s->num_closid);
 	return 0;
 }
 
@@ -2140,6 +2134,7 @@ static int schemata_list_create(void)
 
 		s->res = r;
 		s->conf_type = resctrl_to_arch_res(r)->conf_type;
+		s->num_closid = resctrl_to_arch_res(r)->num_closid;
 
 		INIT_LIST_HEAD(&s->list);
 		list_add(&s->list, &resctrl_schema_all);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 095ed48..59d0fa7 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -172,10 +172,14 @@ struct rdt_resource {
  * @conf_type:	Whether this schema is specific to code/data.
  * @res:	The resource structure exported by the architecture to describe
  *		the hardware that is configured by this schema.
+ * @num_closid:	The number of closid that can be used with this schema. When
+ *		features like CDP are enabled, this will be lower than the
+ *		hardware supports for the resource.
  */
 struct resctrl_schema {
 	struct list_head		list;
 	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
+	int				num_closid;
 };
 #endif /* _RESCTRL_H */
