Return-Path: <linux-tip-commits+bounces-4778-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC003A821D0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 12:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522A53BE648
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 10:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF6B25D52E;
	Wed,  9 Apr 2025 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O3X5d0SI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fmzh+oet"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C7325D210;
	Wed,  9 Apr 2025 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193486; cv=none; b=MeAYwSxusO70EalrM9LKe9WZIGHo7xfee7PGrH1YX+cItDFZ7drHhCPG2gl7NWUdOIavNbh83ktmuQYqkTFM9oF5zAXPsO55k5v9h2bKeJXhAE5lgtEI5eIoc92mEj9Ae0Cm8ZF6WzUMz6SR9Jf12eatrGsEXILCpJcB6g1B75s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193486; c=relaxed/simple;
	bh=HycmIH8ELSyYNHTekUH6sixLxrKN1sNEq+/zcLa9awA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eurcGBkWFF9uKFtebTbW0SBAMAj+gyVIGMWPasNhPz4wSIVZRXmnx3D+0YSX70zWBr1Aljmn3YM18NkXZ6Obzltg16ARLWeiDn8aHRsMR4Eh565Y3vu5s0kPhYWT6VV2FLt2z6xvL/9UGRAqthH3dBBkAXU55iwW0cEV1oO3T8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O3X5d0SI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fmzh+oet; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 10:11:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744193482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILqKcrGsm0LWQWFN/ADMSJ/XmwDnPGIgtuo3oUEpjHs=;
	b=O3X5d0SIefwoU12y5bD24kPqQ7tWeS+mupTBAGZmz+NkJiIBLpU7YQMcqlluHexAVoOgbo
	wZLm5CmaQ4yoiM4Xus4F2gQSfgVMtqTnIUdh2GH/4lEdDIW1X2zszvlx4sAh1CAPY2wOqI
	CJ8Hy29QeBWrbMNHpQCLG6HdjL/aKR5Te5hF7t0lLh7d5XdlFu7eH/Wu92GhKqjGpPKj8G
	DWvl3cW2kngSFJ+pQ6HC/N5/xlpQtWn2blIaggq4DyanRWJ3SLsBAa4eGwJ2D15spqWV/Z
	HvG7OY30+oEtqF5ZN492UIacWRt8vbzOymJHx6JOcnk0nr7JSn8HqsW1RLWJZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744193482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILqKcrGsm0LWQWFN/ADMSJ/XmwDnPGIgtuo3oUEpjHs=;
	b=fmzh+oett2MHKS+e62v4Dag2aeuokeGFprAGxeatoRm2iU/yjSWbNKbWQbQGztL57SXPMv
	32xOPfiR2mdVQmCA==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Fix rdtgroup_mkdir()'s unlocked use of
 kernfs_node::name
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250407124637.2433230-1-james.morse@arm.com>
References: <20250407124637.2433230-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174419347599.31282.1068342026111511089.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     45c2e30bbd64d75559b99f3a5c455129a7a34b06
Gitweb:        https://git.kernel.org/tip/45c2e30bbd64d75559b99f3a5c455129a7a34b06
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Mon, 07 Apr 2025 13:46:37 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 09 Apr 2025 11:35:08 +02:00

x86/resctrl: Fix rdtgroup_mkdir()'s unlocked use of kernfs_node::name

Since

  741c10b096bc ("kernfs: Use RCU to access kernfs_node::name.")

a helper rdt_kn_name() that checks that rdtgroup_mutex is held has been used
for all accesses to the kernfs node name.

rdtgroup_mkdir() uses the name to determine if a valid monitor group is being
created by checking the parent name is "mon_groups". This is done without
holding rdtgroup_mutex, and now triggers the following warning:

  | WARNING: suspicious RCU usage
  | 6.15.0-rc1 #4465 Tainted: G            E
  | -----------------------------
  | arch/x86/kernel/cpu/resctrl/internal.h:408 suspicious rcu_dereference_check() usage!
  [...]
  | Call Trace:
  |  <TASK>
  |  dump_stack_lvl
  |  lockdep_rcu_suspicious.cold
  |  is_mon_groups
  |  rdtgroup_mkdir
  |  kernfs_iop_mkdir
  |  vfs_mkdir
  |  do_mkdirat
  |  __x64_sys_mkdir
  |  do_syscall_64
  |  entry_SYSCALL_64_after_hwframe

Creating a control or monitor group calls mkdir_rdt_prepare(), which uses
rdtgroup_kn_lock_live() to take the rdtgroup_mutex.

To avoid taking and dropping the lock, move the check for the monitor group
name and position into mkdir_rdt_prepare() so that it occurs under
rdtgroup_mutex. Hoist is_mon_groups() earlier in the file.

  [ bp: Massage. ]

Fixes: 741c10b096bc ("kernfs: Use RCU to access kernfs_node::name.")
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250407124637.2433230-1-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 48 ++++++++++++++-----------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 93ec829..cc4a541 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3553,6 +3553,22 @@ static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
 		free_rmid(rgrp->closid, rgrp->mon.rmid);
 }
 
+/*
+ * We allow creating mon groups only with in a directory called "mon_groups"
+ * which is present in every ctrl_mon group. Check if this is a valid
+ * "mon_groups" directory.
+ *
+ * 1. The directory should be named "mon_groups".
+ * 2. The mon group itself should "not" be named "mon_groups".
+ *   This makes sure "mon_groups" directory always has a ctrl_mon group
+ *   as parent.
+ */
+static bool is_mon_groups(struct kernfs_node *kn, const char *name)
+{
+	return (!strcmp(rdt_kn_name(kn), "mon_groups") &&
+		strcmp(name, "mon_groups"));
+}
+
 static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 			     const char *name, umode_t mode,
 			     enum rdt_group_type rtype, struct rdtgroup **r)
@@ -3568,6 +3584,15 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 		goto out_unlock;
 	}
 
+	/*
+	 * Check that the parent directory for a monitor group is a "mon_groups"
+	 * directory.
+	 */
+	if (rtype == RDTMON_GROUP && !is_mon_groups(parent_kn, name)) {
+		ret = -EPERM;
+		goto out_unlock;
+	}
+
 	if (rtype == RDTMON_GROUP &&
 	    (prdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
 	     prdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)) {
@@ -3751,22 +3776,6 @@ out_unlock:
 	return ret;
 }
 
-/*
- * We allow creating mon groups only with in a directory called "mon_groups"
- * which is present in every ctrl_mon group. Check if this is a valid
- * "mon_groups" directory.
- *
- * 1. The directory should be named "mon_groups".
- * 2. The mon group itself should "not" be named "mon_groups".
- *   This makes sure "mon_groups" directory always has a ctrl_mon group
- *   as parent.
- */
-static bool is_mon_groups(struct kernfs_node *kn, const char *name)
-{
-	return (!strcmp(rdt_kn_name(kn), "mon_groups") &&
-		strcmp(name, "mon_groups"));
-}
-
 static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
 			  umode_t mode)
 {
@@ -3782,11 +3791,8 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
 	if (resctrl_arch_alloc_capable() && parent_kn == rdtgroup_default.kn)
 		return rdtgroup_mkdir_ctrl_mon(parent_kn, name, mode);
 
-	/*
-	 * If RDT monitoring is supported and the parent directory is a valid
-	 * "mon_groups" directory, add a monitoring subdirectory.
-	 */
-	if (resctrl_arch_mon_capable() && is_mon_groups(parent_kn, name))
+	/* Else, attempt to add a monitoring subdirectory. */
+	if (resctrl_arch_mon_capable())
 		return rdtgroup_mkdir_mon(parent_kn, name, mode);
 
 	return -EPERM;

