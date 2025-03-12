Return-Path: <linux-tip-commits+bounces-4163-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DFFA5E2A2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89131168B76
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A749125FA0F;
	Wed, 12 Mar 2025 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tE2WpbJy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2YzXsqhd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B27A25EF99;
	Wed, 12 Mar 2025 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800042; cv=none; b=i8rovCcf+hGYhcY1plu0brTWrIc7DleUGyTSyjchvD0k28C4Ly4C7OsTG0IlHrmEpUS4YLYCzXY+bhkxpYwCERAyGP5grRYD2GC4lNYY7rFImX13/WIrwliIFvt1AVmFybXJrZ8RnGrU51dMU5g55/o6UpsK/15Yf6iE5vYoyXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800042; c=relaxed/simple;
	bh=HCuteGpVwtRGpFVvxXSsAFttRAX4AMU+RySE2pAtdxI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YdTMNNrVvYuBO+F5AXQ6xSfPpeZAtl0/2DtDS91XlWYKQ34scCHyA16Zv2GPO3uG0YBTG8DmZ5gj6znlynw2e1OCGPb0GG+n1zEjob7HniLcwrlCU5uV/ikUTYMwwIQVhBivqG4RRnPGtGoswIlo/FdM3RBojSYhuPFE2fJrqWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tE2WpbJy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2YzXsqhd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800038;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9ROMN+fkTfS8kY6BjK07lcb+b9RSmGF7Rcblgzcslk=;
	b=tE2WpbJyiVJhz4aq1W/gxrusMc+oUqZKqtW1knQLlnzRfxnx2mgVkrvnKmhjIUWMeTi0A2
	LxsOUmfhtaxw5U83QBMLsDdFNRqEx3vT+iATfYe8s3TXLT3Buhuu0/lc0AV4P5WLrrkunU
	8Z74k+iqBSwrYCCzK9wXCdyzGYnDlDzRLPIq8cm+gFwq0xEJW4zBW4SejbgVYn10Ip9fmJ
	U6xmMDWj8urNbvDBkvk1YkPf72eMrn+C9CDE/kwCr5QVp0a7fz2FGtypr8xcKbAX4vYb+6
	cZTkduwgGpfX/zDkUmM8pA2LlaTe5FJjG9qdP1vPscY0InOzfAC62WGOTLMS6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800038;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9ROMN+fkTfS8kY6BjK07lcb+b9RSmGF7Rcblgzcslk=;
	b=2YzXsqhddNw2thmfk8GxkUUx0+JhOdY4muWldELcEmtjcvn9NvzWciaOcTb9q8UTNiwfsa
	8L3x3fwxuBVYMRCw==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Use schema type to determine the schema
 format string
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>, Babu Moger <babu.moger@amd.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-6-james.morse@arm.com>
References: <20250311183715.16445-6-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180003769.14745.16406835804323793904.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     bb9343c8f2906ac7087a7f9560b37636c220551d
Gitweb:        https://git.kernel.org/tip/bb9343c8f2906ac7087a7f9560b37636c220551d
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:36:50 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:22:33 +01:00

x86/resctrl: Use schema type to determine the schema format string

Resctrl's architecture code gets to specify a format string that is
used when printing schema entries. This is expected to be one of two
values that the filesystem code supports.

Setting this format string allows the architecture code to change
the ABI resctrl presents to user-space.

Instead, use the schema format enum to choose which format string to
use.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20250311183715.16445-6-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c        |  4 ----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 14 ++++++++++++++
 include/linux/resctrl.h                   |  4 ++--
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index e9fe129..542503a 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -73,7 +73,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L3),
 			.mon_domains		= mon_domain_init(RDT_RESOURCE_L3),
 			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
-			.format_str		= "%d=%0*x",
 		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
@@ -86,7 +85,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.ctrl_scope		= RESCTRL_L2_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L2),
 			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
-			.format_str		= "%d=%0*x",
 		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
@@ -99,7 +97,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_MBA),
 			.schema_fmt		= RESCTRL_SCHEMA_RANGE,
-			.format_str		= "%d=%*u",
 		},
 	},
 	[RDT_RESOURCE_SMBA] =
@@ -110,7 +107,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_SMBA),
 			.schema_fmt		= RESCTRL_SCHEMA_RANGE,
-			.format_str		= "%d=%*u",
 		},
 	},
 };
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index f4334f4..c763cb4 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -487,7 +487,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 			ctrl_val = resctrl_arch_get_config(r, dom, closid,
 							   schema->conf_type);
 
-		seq_printf(s, r->format_str, dom->hdr.id, max_data_width,
+		seq_printf(s, schema->fmt_str, dom->hdr.id, max_data_width,
 			   ctrl_val);
 		sep = true;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3391ac8..e7862d0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2611,6 +2611,20 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
 	if (cl > max_name_width)
 		max_name_width = cl;
 
+	switch (r->schema_fmt) {
+	case RESCTRL_SCHEMA_BITMAP:
+		s->fmt_str = "%d=%0*x";
+		break;
+	case RESCTRL_SCHEMA_RANGE:
+		s->fmt_str = "%d=%0*u";
+		break;
+	}
+
+	if (WARN_ON_ONCE(!s->fmt_str)) {
+		kfree(s);
+		return -EINVAL;
+	}
+
 	INIT_LIST_HEAD(&s->list);
 	list_add(&s->list, &resctrl_schema_all);
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 3e1a413..736b9a9 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -216,7 +216,6 @@ enum resctrl_schema_fmt {
  * @name:		Name to use in "schemata" file.
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
- * @format_str:		Per resource format string to show domain value
  * @schema_fmt:		Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
  * @cdp_capable:	Is the CDP feature available on this resource
@@ -235,7 +234,6 @@ struct rdt_resource {
 	char			*name;
 	int			data_width;
 	u32			default_ctrl;
-	const char		*format_str;
 	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;
 	bool			cdp_capable;
@@ -253,6 +251,7 @@ struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l);
  *			   user-space
  * @list:	Member of resctrl_schema_all.
  * @name:	The name to use in the "schemata" file.
+ * @fmt_str:	Format string to show domain value.
  * @conf_type:	Whether this schema is specific to code/data.
  * @res:	The resource structure exported by the architecture to describe
  *		the hardware that is configured by this schema.
@@ -263,6 +262,7 @@ struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l);
 struct resctrl_schema {
 	struct list_head		list;
 	char				name[8];
+	const char			*fmt_str;
 	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
 	u32				num_closid;

