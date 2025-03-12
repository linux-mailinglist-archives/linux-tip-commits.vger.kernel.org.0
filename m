Return-Path: <linux-tip-commits+bounces-4165-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDA9A5E2A4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17401189821B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED359260A20;
	Wed, 12 Mar 2025 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sjkP3bv4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gjwro72O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F59256C9B;
	Wed, 12 Mar 2025 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800043; cv=none; b=aCNoEbfPt1tCW8YXYVMdlpAdaZJFC/+XHEDwMKc9pykMnoX3cUh4PSggmWiDTPNuCYT3Cp0CTWW49ZsVUWsOEyvJmqT6Yhgkuy2Vfsgarh3YqE3u5t9h9xRWFRU+cZPPRUvVDa0y+KDwoWaEqN9Nsv9301bfX3IzCs42zvAHZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800043; c=relaxed/simple;
	bh=xWyvRkWEeBRnxoE7vvGN0mIqkoVgHd2rpPst0CnjKT4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Kp5FMjQKutTEF8K1ikL76S53m+Nxhj9et6Oe1hfyLTuvW69kV8IpMnaWbjJYG6j1KH0DfA6LJXc3whYH5VXYWbSAOqT97tbPgv+QTsSLkNMafJVg8U9dbyptUyhK2n3VTax4UK0Ump1+unHaHnz452LG6vZ/48BpmLHAK6WPm8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sjkP3bv4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gjwro72O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68XL2X4OiTEZjd0cTuan9H7k1pZXEMl9vvbHSuJLsbs=;
	b=sjkP3bv4EqdAT7PgzBOxlRauVHT9oPF4/CA1cTfIpT/UIbQo/1RCsCQdbP3vIMERg7gHr0
	42NEVtB+pgfcuShU63jAa3+pLVBzBKSKmtSuyYC+ltDNbi7teGAJdIAApZvrvyHsiX253w
	K+5E5ZvQsjCT1ZncVNEc2cuA3V8UzMlv3/fqkv5w1GRJpI8etqv6s+EVBur7L//5lF43Tv
	1gQ5KeNZ9e0cgevAuUpdri5K7DpNvV5wtpuZ/JNGy3WoYwLvwBETYKuLnsq+k7YHlTTGHn
	tm3YlKXAMr4ZchvMQnp1K2PbzZ045NxRw0gKwq2TscYko16EVYVBqkYeD5z3dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68XL2X4OiTEZjd0cTuan9H7k1pZXEMl9vvbHSuJLsbs=;
	b=gjwro72Omk4iI4Pytc/Y4f+glKKdQgkkKMu4sVxG6BsnlKHhuhnvAxcQNUa39M7MjkrNia
	yrwk7DupMD5MXbAQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Remove fflags from struct rdt_resource
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-4-james.morse@arm.com>
References: <20250311183715.16445-4-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180003930.14745.12527506976084153097.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     131dab13a82d9edd97dd96d98d2919f56f339331
Gitweb:        https://git.kernel.org/tip/131dab13a82d9edd97dd96d98d2919f56f339331
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:36:48 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:22:26 +01:00

x86/resctrl: Remove fflags from struct rdt_resource

The resctrl arch code specifies whether a resource controls a cache or memory
using the fflags field. This field is then used by resctrl to determine which
files should be exposed in the filesystem.

Allowing the architecture to pick this value means the RFTYPE_ flags have to
be in a shared header, and allows an architecture to create a combination that
resctrl does not support.

Remove the fflags field, and pick the value based on the resource id.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20250311183715.16445-4-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c     |  4 ----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++--
 include/linux/resctrl.h                |  2 --
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 12b4131..8ef2e44 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -74,7 +74,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.mon_domains		= mon_domain_init(RDT_RESOURCE_L3),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
 		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
@@ -88,7 +87,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L2),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
 		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
@@ -102,7 +100,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_MBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
-			.fflags			= RFTYPE_RES_MB,
 		},
 	},
 	[RDT_RESOURCE_SMBA] =
@@ -114,7 +111,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_SMBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
-			.fflags			= RFTYPE_RES_MB,
 		},
 	},
 };
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 45093b9..3391ac8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2165,6 +2165,20 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
 	return ret;
 }
 
+static unsigned long fflags_from_resource(struct rdt_resource *r)
+{
+	switch (r->rid) {
+	case RDT_RESOURCE_L3:
+	case RDT_RESOURCE_L2:
+		return RFTYPE_RES_CACHE;
+	case RDT_RESOURCE_MBA:
+	case RDT_RESOURCE_SMBA:
+		return RFTYPE_RES_MB;
+	}
+
+	return WARN_ON_ONCE(1);
+}
+
 static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 {
 	struct resctrl_schema *s;
@@ -2185,14 +2199,14 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	/* loop over enabled controls, these are all alloc_capable */
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
-		fflags = r->fflags | RFTYPE_CTRL_INFO;
+		fflags = fflags_from_resource(r) | RFTYPE_CTRL_INFO;
 		ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
 		if (ret)
 			goto out_destroy;
 	}
 
 	for_each_mon_capable_rdt_resource(r) {
-		fflags = r->fflags | RFTYPE_MON_INFO;
+		fflags = fflags_from_resource(r) | RFTYPE_MON_INFO;
 		sprintf(name, "%s_MON", r->name);
 		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
 		if (ret)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 37279e2..496ddca 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -210,7 +210,6 @@ enum resctrl_scope {
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
  * @evt_list:		List of monitoring events
- * @fflags:		flags to choose base and info files
  * @cdp_capable:	Is the CDP feature available on this resource
  */
 struct rdt_resource {
@@ -232,7 +231,6 @@ struct rdt_resource {
 						 struct resctrl_schema *s,
 						 struct rdt_ctrl_domain *d);
 	struct list_head	evt_list;
-	unsigned long		fflags;
 	bool			cdp_capable;
 };
 

