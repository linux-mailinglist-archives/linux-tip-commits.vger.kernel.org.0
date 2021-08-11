Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C831E3E990D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhHKTmF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:42:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53712 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbhHKTl7 (ORCPT
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
        bh=Lx+5m1E8Xhbok/umNRkdZwY0a9r9XVZQHpSdTnxlkzQ=;
        b=l8uS99XnUmQdfih5iwfjUIEnhvqSZ6/sZS4c3YE07tQSHPAbSJA0nFerAqq1dwyg6Hya5h
        Lfcrg2fFuFCHax4s0izvUK98Nfids9w/hK+6EM+ALiusFWBdK1vjGUgXtyQ0yW/iuM1CZI
        j5GDhVVfWjjPv/uNvnxGj7jSXVV+KqZEUpVF/P2IgEhTZdhR6nD0fn5c/pCZAEc78sM+Cv
        hLNae0CiAyusZjcviM+U4oL1hSKJn80c8wugLZzQthj9PKtLbQr9e0VWwSCt7za2vKrhF4
        CHkt09PseDUbZe4KdXDMoTDTF1n+1VC7m+wnbuERBQd8uvy8NRXSDVbaMdkGfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710894;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lx+5m1E8Xhbok/umNRkdZwY0a9r9XVZQHpSdTnxlkzQ=;
        b=LyAP7FGHe2zrXfvLESUFnrf5VnSBITn/wMYbGO9fr7uX1XGZTTeBu8R46pnpEjRQ4Umnxb
        iTEDZMAg1iBV8pBQ==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add a separate schema list for resctrl
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-4-james.morse@arm.com>
References: <20210728170637.25610-4-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871089383.395.8381186160684756810.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     cdb9ebc9178461c27d618bb1238e851da17271de
Gitweb:        https://git.kernel.org/tip/cdb9ebc9178461c27d618bb1238e851da17271de
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:16 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 12:28:01 +02:00

x86/resctrl: Add a separate schema list for resctrl

Resctrl exposes schemata to user-space, which allow the control values
to be specified for a group of tasks.

User-visible properties of the interface, (such as the schemata names
and how the values are parsed) are rooted in a struct provided by the
architecture code. (struct rdt_hw_resource). Once a second architecture
uses resctrl, this would allow user-visible properties to diverge
between architectures.

These properties should come from the resctrl code that will be common
to all architectures. Resctrl has no per-schema structure, only struct
rdt_{hw_,}resource. Create a struct resctrl_schema to hold the
rdt_resource. Before a second architecture can be supported, this
structure will also need to hold the schema name visible to user-space
and the type of configuration values for resctrl.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-4-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 43 ++++++++++++++++++++++++-
 include/linux/resctrl.h                | 11 ++++++-
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 02c85c7..2cc4b37 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -110,6 +110,7 @@ extern unsigned int resctrl_cqm_threshold;
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
 extern unsigned int rdt_mon_features;
+extern struct list_head resctrl_schema_all;
 
 enum rdt_group_type {
 	RDTCTRL_GROUP = 0,
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d190a21..3e0b6aa 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -39,6 +39,9 @@ static struct kernfs_root *rdt_root;
 struct rdtgroup rdtgroup_default;
 LIST_HEAD(rdt_all_groups);
 
+/* list of entries for the schemata file */
+LIST_HEAD(resctrl_schema_all);
+
 /* Kernel fs node for "info" directory under root */
 static struct kernfs_node *kn_info;
 
@@ -2109,6 +2112,35 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 	return ret;
 }
 
+static int schemata_list_create(void)
+{
+	struct resctrl_schema *s;
+	struct rdt_resource *r;
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		s = kzalloc(sizeof(*s), GFP_KERNEL);
+		if (!s)
+			return -ENOMEM;
+
+		s->res = r;
+
+		INIT_LIST_HEAD(&s->list);
+		list_add(&s->list, &resctrl_schema_all);
+	}
+
+	return 0;
+}
+
+static void schemata_list_destroy(void)
+{
+	struct resctrl_schema *s, *tmp;
+
+	list_for_each_entry_safe(s, tmp, &resctrl_schema_all, list) {
+		list_del(&s->list);
+		kfree(s);
+	}
+}
+
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
@@ -2130,11 +2162,17 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (ret < 0)
 		goto out_cdp;
 
+	ret = schemata_list_create();
+	if (ret) {
+		schemata_list_destroy();
+		goto out_mba;
+	}
+
 	closid_init();
 
 	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
 	if (ret < 0)
-		goto out_mba;
+		goto out_schemata_free;
 
 	if (rdt_mon_capable) {
 		ret = mongroup_create_dir(rdtgroup_default.kn,
@@ -2184,6 +2222,8 @@ out_mongrp:
 		kernfs_remove(kn_mongrp);
 out_info:
 	kernfs_remove(kn_info);
+out_schemata_free:
+	schemata_list_destroy();
 out_mba:
 	if (ctx->enable_mba_mbps)
 		set_mba_sc(false);
@@ -2425,6 +2465,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	rmdir_all_sub();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
+	schemata_list_destroy();
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
 	static_branch_disable_cpuslocked(&rdt_enable_key);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index a4c89da..5a21d48 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -153,4 +153,15 @@ struct rdt_resource {
 
 };
 
+/**
+ * struct resctrl_schema - configuration abilities of a resource presented to
+ *			   user-space
+ * @list:	Member of resctrl_schema_all.
+ * @res:	The resource structure exported by the architecture to describe
+ *		the hardware that is configured by this schema.
+ */
+struct resctrl_schema {
+	struct list_head		list;
+	struct rdt_resource		*res;
+};
 #endif /* _RESCTRL_H */
