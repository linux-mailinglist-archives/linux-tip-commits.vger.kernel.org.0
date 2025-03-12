Return-Path: <linux-tip-commits+bounces-4159-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF0BA5E299
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F024A7ADB08
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D72E25E451;
	Wed, 12 Mar 2025 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b2X6aC+e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5DHAA+bJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D774525DAF0;
	Wed, 12 Mar 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800038; cv=none; b=uXJN0u+/YoQm4S9DCmDXye1MWcCoRdCLiWYs3XssQMT/BQWicna0XCoNA8eDIfkFrLC38GbLtf3HzJge+fFdCSJF4a85Q85c+Am1FkFljm4nTUPbzt30bsl/kBilk4+LBmXZeGxabi87a42JKKfGDw4lcFMZUG1a9R8tc7sBm4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800038; c=relaxed/simple;
	bh=GNovYvux3Ykr/fI4WNe/5hqzpwmfj7RligaV3hG6bfM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PG758rloED4Idk0HhLCl5J++eIotoM1xRVvActPvIOS6Gjpub840T0fWWM6DvLovwh5pECnecQ9CR5/dgGv7TCqDtppoqQPwsVDyM5/orWfrePAuJ/dxG2gqbStTLyxrc1aIlM2lFQn33X1LPjnUMLigvQKnkZ2WX+8ZYQJ8fgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b2X6aC+e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5DHAA+bJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZNQjUr/jeuGG3AOqwngm6ukBco9muJyG3Ks8mQACWw=;
	b=b2X6aC+eUbHNuPr0nB2vvPzEXIPfZdRq4j67VfQrBA393A4JTT3h+r0X/wU6d34da34L9U
	TeGSVys4EQn2m4O1Kvv8XKviZ/pHBKZyYMysHq1BnTFS5vRpr3XuHgC/WuMpIBrfJnMITV
	CarVryVahNFrMPhS7XpoBlDsEyPD5NdVrwKMiOvqMxvxr+kZO0IEEZb8fPoAPGhkk9Ezwn
	JFjxorlwUICvHMBCYz7+yqsIhWUsYO+7KEQVuGgHBubRsuOZCv5SlPD/PAJ2WvzjNCDRZR
	SC8hSN47rqYUqbuIV5QBPqHFKdE9PtbrjHvtyUBNtD66X4KlP50SDB5Gj3Ce5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZNQjUr/jeuGG3AOqwngm6ukBco9muJyG3Ks8mQACWw=;
	b=5DHAA+bJILK1ZCrduCctXq6fxofdjRHdEv5zgubnRpP8XCnB5VKNV72ki5tsT0fnfEoMVt
	Uk4lUhjg6WXNtUCQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Add helper for setting CPU default properties
Cc: Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-10-james.morse@arm.com>
References: <20250311183715.16445-10-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180003390.14745.12232071953909183872.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     aebd5354dd191860033f8599048d3d3998482ee7
Gitweb:        https://git.kernel.org/tip/aebd5354dd191860033f8599048d3d3998482ee7
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:36:54 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:22:48 +01:00

x86/resctrl: Add helper for setting CPU default properties

rdtgroup_rmdir_ctrl() and rdtgroup_rmdir_mon() set the per-CPU pqr_state for
CPUs that were part of the rmdir()'d group.

Another architecture might not have a 'pqr_state', its hardware may need the
values in a different format. MPAM's equivalent of RMID values are not unique,
and always need the CLOSID to be provided too.

There is only one caller that modifies a single value, (rdtgroup_rmdir_mon()).
MPAM always needs both CLOSID and RMID for the hardware value as these are
written to the same system register.

As rdtgroup_rmdir_mon() has the CLOSID on hand, only provide a helper to set
both values. These values are read by __resctrl_sched_in(), but may be written
by a different CPU without any locking, add READ/WRTE_ONCE() to avoid torn
values.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
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
Link: https://lore.kernel.org/r/20250311183715.16445-10-james.morse@arm.com
---
 arch/x86/include/asm/resctrl.h         | 14 +++++++++++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 20 ++++++++++++++------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 8b1b6ce..6908cd0 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -4,8 +4,9 @@
 
 #ifdef CONFIG_X86_CPU_RESCTRL
 
-#include <linux/sched.h>
 #include <linux/jump_label.h>
+#include <linux/percpu.h>
+#include <linux/sched.h>
 
 /*
  * This value can never be a valid CLOSID, and is used when mapping a
@@ -96,8 +97,8 @@ static inline void resctrl_arch_disable_mon(void)
 static inline void __resctrl_sched_in(struct task_struct *tsk)
 {
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
-	u32 closid = state->default_closid;
-	u32 rmid = state->default_rmid;
+	u32 closid = READ_ONCE(state->default_closid);
+	u32 rmid = READ_ONCE(state->default_rmid);
 	u32 tmp;
 
 	/*
@@ -132,6 +133,13 @@ static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
 	return val * scale;
 }
 
+static inline void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid,
+							    u32 rmid)
+{
+	WRITE_ONCE(per_cpu(pqr_state.default_closid, cpu), closid);
+	WRITE_ONCE(per_cpu(pqr_state.default_rmid, cpu), rmid);
+}
+
 static inline void resctrl_arch_set_closid_rmid(struct task_struct *tsk,
 						u32 closid, u32 rmid)
 {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cd8f65c..f706e5a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3731,14 +3731,21 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
 static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 {
 	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
+	u32 closid, rmid;
 	int cpu;
 
 	/* Give any tasks back to the parent group */
 	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
 
-	/* Update per cpu rmid of the moved CPUs first */
+	/*
+	 * Update per cpu closid/rmid of the moved CPUs first.
+	 * Note: the closid will not change, but the arch code still needs it.
+	 */
+	closid = prdtgrp->closid;
+	rmid = prdtgrp->mon.rmid;
 	for_each_cpu(cpu, &rdtgrp->cpu_mask)
-		per_cpu(pqr_state.default_rmid, cpu) = prdtgrp->mon.rmid;
+		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
+
 	/*
 	 * Update the MSR on moved CPUs and CPUs which have moved
 	 * task running on them.
@@ -3771,6 +3778,7 @@ static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
 
 static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 {
+	u32 closid, rmid;
 	int cpu;
 
 	/* Give any tasks back to the default group */
@@ -3781,10 +3789,10 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 		   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
 	/* Update per cpu closid and rmid of the moved CPUs first */
-	for_each_cpu(cpu, &rdtgrp->cpu_mask) {
-		per_cpu(pqr_state.default_closid, cpu) = rdtgroup_default.closid;
-		per_cpu(pqr_state.default_rmid, cpu) = rdtgroup_default.mon.rmid;
-	}
+	closid = rdtgroup_default.closid;
+	rmid = rdtgroup_default.mon.rmid;
+	for_each_cpu(cpu, &rdtgrp->cpu_mask)
+		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
 
 	/*
 	 * Update the MSR on moved CPUs and CPUs which have moved

