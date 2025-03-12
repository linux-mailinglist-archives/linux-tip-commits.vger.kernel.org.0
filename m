Return-Path: <linux-tip-commits+bounces-4164-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBFDA5E2A7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7253A50D3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370C425FA3D;
	Wed, 12 Mar 2025 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sS1+Np4B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TJOUxazg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E8425EFA5;
	Wed, 12 Mar 2025 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800043; cv=none; b=mz5FaQX5iG5Xy35PljwMl0FD5Ixd6R/hTECMdGwzS1pkjy+dl5FHAIoKirgwwp4KdqOCYRy2+WlDCP0RpNvmyrEaDAqj8ynvedwdC+UimkGdYvzF/DnlRQMxB/m7j1ufrziL6sUmk50mGTLGd2Pmy12l0jHPpG/krwk8yPKpf7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800043; c=relaxed/simple;
	bh=jqNvLzrARTpriUBS5IQRjaaiBZLia+NKlLSlfSr7hAg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mPkMD+SSJut/jgYb6GM1KWpNLlOIeon2S6uDy3hLVpeDUhA++CoMn10/0AND22xIBjgZoWjrIJVXBrOpD7d5Xs5WjFjrS2zQiNsT00nfthXlWsagRLMDA6/WudSEQOtAi9QbaBpU+2KE9YhuiIbwrhrTkxjNwNqb8tdjSZaLWhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sS1+Np4B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TJOUxazg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSWTxYQGxsSGPYBsZ28b8gepnAmHL/A/HEEfeQCsFwo=;
	b=sS1+Np4Bbp7qQrFQtmhVcZyoYxPoJqIqCMP1kkxRUOOU7Ro+/REmU770CB1S6ZB/L7Zymg
	LSXdci5iFXJ/AlYDx4KMJf9kSthy56zhLq0YkEETBTJuRqD6MfvqfKw5l2Xs9NP23ZvNPB
	WXBcgO8WnUBoy1lIdZrzbcSMCf3HPPx8rMUKrzVlYwBMeZCkhqwUNjfCaYBesIp0UraGpU
	mozJDTAA7iR15lDtTTZG7ILCfJVttZsiKiBuHHkQ3kI5z35+0y7sMsZLZRkgobpcKXuQ+8
	1FDoGjBYbUGJXqztfkAAuBt5dPEEYAGJTuH74nrtEikgot0VUxZdZwC5jP0gHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSWTxYQGxsSGPYBsZ28b8gepnAmHL/A/HEEfeQCsFwo=;
	b=TJOUxazgiixMba9sVoN49mSMwKDR0ra4hZm4jwagE58NAvi1Rwq1PWRCq9vh8uPDk5MYuR
	LTO9IB99Z6KCKgAA==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Use schema type to determine how to
 parse schema values
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-5-james.morse@arm.com>
References: <20250311183715.16445-5-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180003850.14745.11932668151026563601.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     c24f5eab6b2689fd4e97a2d2fe963864036653e6
Gitweb:        https://git.kernel.org/tip/c24f5eab6b2689fd4e97a2d2fe963864036653e6
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:36:49 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:22:30 +01:00

x86/resctrl: Use schema type to determine how to parse schema values

Resctrl's architecture code gets to specify a function pointer that is used
when parsing schema entries. This is expected to be one of two helpers from
the filesystem code.

Setting this function pointer allows the architecture code to change the ABI
resctrl presents to user-space, and forces resctrl to expose these helpers.

Instead, add a schema format enum to choose which schema parser to use. This
allows the helpers to be made static and the structs used for passing
arguments moved out of shared headers.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20250311183715.16445-5-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c        |  8 +++---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 32 ++++++++++++++++++----
 arch/x86/kernel/cpu/resctrl/internal.h    | 10 +-------
 include/linux/resctrl.h                   | 17 ++++++++----
 4 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 8ef2e44..e9fe129 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -72,7 +72,7 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.mon_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L3),
 			.mon_domains		= mon_domain_init(RDT_RESOURCE_L3),
-			.parse_ctrlval		= parse_cbm,
+			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
 			.format_str		= "%d=%0*x",
 		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
@@ -85,7 +85,7 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.name			= "L2",
 			.ctrl_scope		= RESCTRL_L2_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L2),
-			.parse_ctrlval		= parse_cbm,
+			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
 			.format_str		= "%d=%0*x",
 		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
@@ -98,7 +98,7 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.name			= "MB",
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_MBA),
-			.parse_ctrlval		= parse_bw,
+			.schema_fmt		= RESCTRL_SCHEMA_RANGE,
 			.format_str		= "%d=%*u",
 		},
 	},
@@ -109,7 +109,7 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.name			= "SMBA",
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_SMBA),
-			.parse_ctrlval		= parse_bw,
+			.schema_fmt		= RESCTRL_SCHEMA_RANGE,
 			.format_str		= "%d=%*u",
 		},
 	},
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 4af27ef..f4334f4 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -23,6 +23,15 @@
 
 #include "internal.h"
 
+struct rdt_parse_data {
+	struct rdtgroup		*rdtgrp;
+	char			*buf;
+};
+
+typedef int (ctrlval_parser_t)(struct rdt_parse_data *data,
+			       struct resctrl_schema *s,
+			       struct rdt_ctrl_domain *d);
+
 /*
  * Check whether MBA bandwidth percentage value is correct. The value is
  * checked against the minimum and max bandwidth values specified by the
@@ -64,8 +73,8 @@ static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
 	return true;
 }
 
-int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
-	     struct rdt_ctrl_domain *d)
+static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
+		    struct rdt_ctrl_domain *d)
 {
 	struct resctrl_staged_config *cfg;
 	u32 closid = data->rdtgrp->closid;
@@ -143,8 +152,8 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
  */
-int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
-	      struct rdt_ctrl_domain *d)
+static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
+		     struct rdt_ctrl_domain *d)
 {
 	struct rdtgroup *rdtgrp = data->rdtgrp;
 	struct resctrl_staged_config *cfg;
@@ -210,6 +219,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
 		      struct rdtgroup *rdtgrp)
 {
 	enum resctrl_conf_type t = s->conf_type;
+	ctrlval_parser_t *parse_ctrlval = NULL;
 	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
 	struct rdt_parse_data data;
@@ -220,6 +230,18 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
 
+	switch (r->schema_fmt) {
+	case RESCTRL_SCHEMA_BITMAP:
+		parse_ctrlval = &parse_cbm;
+		break;
+	case RESCTRL_SCHEMA_RANGE:
+		parse_ctrlval = &parse_bw;
+		break;
+	}
+
+	if (WARN_ON_ONCE(!parse_ctrlval))
+		return -EINVAL;
+
 	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
 	    (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)) {
 		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
@@ -240,7 +262,7 @@ next:
 		if (d->hdr.id == dom_id) {
 			data.buf = dom;
 			data.rdtgrp = rdtgrp;
-			if (r->parse_ctrlval(&data, s, d))
+			if (parse_ctrlval(&data, s, d))
 				return -EINVAL;
 			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
 				cfg = &d->staged_config[t];
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 75252a7..b5543bd 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -459,11 +459,6 @@ static inline bool is_mbm_event(int e)
 		e <= QOS_L3_MBM_LOCAL_EVENT_ID);
 }
 
-struct rdt_parse_data {
-	struct rdtgroup		*rdtgrp;
-	char			*buf;
-};
-
 /**
  * struct rdt_hw_resource - arch private attributes of a resctrl resource
  * @r_resctrl:		Attributes of the resource used directly by resctrl.
@@ -500,11 +495,6 @@ static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r
 	return container_of(r, struct rdt_hw_resource, r_resctrl);
 }
 
-int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
-	      struct rdt_ctrl_domain *d);
-int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
-	     struct rdt_ctrl_domain *d);
-
 extern struct mutex rdtgroup_mutex;
 
 extern struct rdt_hw_resource rdt_resources_all[];
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 496ddca..3e1a413 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -183,7 +183,6 @@ struct resctrl_membw {
 	u32				*mb_map;
 };
 
-struct rdt_parse_data;
 struct resctrl_schema;
 
 enum resctrl_scope {
@@ -193,6 +192,16 @@ enum resctrl_scope {
 };
 
 /**
+ * enum resctrl_schema_fmt - The format user-space provides for a schema.
+ * @RESCTRL_SCHEMA_BITMAP:	The schema is a bitmap in hex.
+ * @RESCTRL_SCHEMA_RANGE:	The schema is a decimal number.
+ */
+enum resctrl_schema_fmt {
+	RESCTRL_SCHEMA_BITMAP,
+	RESCTRL_SCHEMA_RANGE,
+};
+
+/**
  * struct rdt_resource - attributes of a resctrl resource
  * @rid:		The index of the resource
  * @alloc_capable:	Is allocation available on this machine
@@ -208,7 +217,7 @@ enum resctrl_scope {
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @format_str:		Per resource format string to show domain value
- * @parse_ctrlval:	Per resource function pointer to parse control values
+ * @schema_fmt:		Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
  * @cdp_capable:	Is the CDP feature available on this resource
  */
@@ -227,9 +236,7 @@ struct rdt_resource {
 	int			data_width;
 	u32			default_ctrl;
 	const char		*format_str;
-	int			(*parse_ctrlval)(struct rdt_parse_data *data,
-						 struct resctrl_schema *s,
-						 struct rdt_ctrl_domain *d);
+	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;
 	bool			cdp_capable;
 };

