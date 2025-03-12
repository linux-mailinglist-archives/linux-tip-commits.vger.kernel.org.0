Return-Path: <linux-tip-commits+bounces-4158-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 425F9A5E298
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304BE1695F6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE3225DD10;
	Wed, 12 Mar 2025 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u3g4PFXU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kzHA24vS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E68825D91B;
	Wed, 12 Mar 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800037; cv=none; b=Jna604B+yiQrMz+epnZt14F4DQMjLBV0bLkOZpkvPn6pzEYFFdjQrOxI9ihszkCxHnSqH8EptQWbYfafvB92Rw+Qli5yjBh7EDGTVTijP8J6A3zeqI1b9/fEYAW/ytq3Rhbiro600qOgWSff1p0Ls7blQLOyB4LCCZayhTTT5Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800037; c=relaxed/simple;
	bh=h22brxz5NgesQNx5JgLAOWf7oCATxhEL3+zp5kBi5y4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gobk+NHu8vrJrpoeMZ/EP/SdwpUqP7PQ6fRoBk+u8jv0RwfZDR8xXVoOVDBmPRuHs8yt8x5ayy9vF+7+D1x9XUMB4KQJFUVYG81nw50INJ3Y4deA4Qbaqc9yjaGJyRrr2Tr9hc3WkTN2kiaoAnVJ4skIl0jSneFAceCqEhK7ss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u3g4PFXU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kzHA24vS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKTJMVP4wUDBym4pXffZn75uCv1F5ylNGI2sJUoqVfI=;
	b=u3g4PFXUtq8RuunM/LvGvbhVHRhCkbGpyxm0JbtqCyit5t9VC4sAGz9Aso5N4Gu1rPCNPV
	fcn53wdHSTpqSm9rEC5733ooFiULS4H9OaPeGQQp85hcbSwcGkyhUkRVTd2/0uu8Oz+SYS
	t2zZcRtqyNCTAGaw2bwMayLSu+vzaaSgZwPTzGMYgC1c7nuEgWRPRSdbsHE8uoSlryxylW
	1cJFe2CkoldaiPLUXLxyBnSrk3EY1gCQwzoD04ZdIn3xS5FVii389o2VS+KkL2J/50uhGf
	jFO8DrpyHuO2/Hhh5bZRvMBbwA6G1MYnITRE3tRJDPWxDIsbj/KhT1IwLIpfhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKTJMVP4wUDBym4pXffZn75uCv1F5ylNGI2sJUoqVfI=;
	b=kzHA24vSG4AicolSsWRwh9eJJ9ejXyUUB68SKA3N4XZu/OUrFD5yMTuW5XsqDaafKGZaYk
	tLLV7baYrG/hlICQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
Cc: Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-11-james.morse@arm.com>
References: <20250311183715.16445-11-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180003323.14745.11010166299767294808.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     6f06aee356bfd0c817cbe83debedd240fbed0719
Gitweb:        https://git.kernel.org/tip/6f06aee356bfd0c817cbe83debedd240fbed0719
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:36:55 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:22:51 +01:00

x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()

update_cpu_closid_rmid() takes a struct rdtgroup as an argument, which it uses
to update the local CPUs default pqr values. This is a problem once the
resctrl parts move out to /fs/, as the arch code cannot poke around inside
struct rdtgroup.

Rename update_cpu_closid_rmid() as resctrl_arch_sync_cpus_defaults() to be
used as the target of an IPI, and pass the effective CLOSID and RMID in a new
struct.

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
Link: https://lore.kernel.org/r/20250311183715.16445-11-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++++----
 include/linux/resctrl.h                | 22 ++++++++++++++++++++++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f706e5a..62d9a50 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -355,13 +355,13 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
  * from update_closid_rmid() is protected against __switch_to() because
  * preemption is disabled.
  */
-static void update_cpu_closid_rmid(void *info)
+void resctrl_arch_sync_cpu_closid_rmid(void *info)
 {
-	struct rdtgroup *r = info;
+	struct resctrl_cpu_defaults *r = info;
 
 	if (r) {
 		this_cpu_write(pqr_state.default_closid, r->closid);
-		this_cpu_write(pqr_state.default_rmid, r->mon.rmid);
+		this_cpu_write(pqr_state.default_rmid, r->rmid);
 	}
 
 	/*
@@ -376,11 +376,20 @@ static void update_cpu_closid_rmid(void *info)
  * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
  *
  * Per task closids/rmids must have been set up before calling this function.
+ * @r may be NULL.
  */
 static void
 update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
 {
-	on_each_cpu_mask(cpu_mask, update_cpu_closid_rmid, r, 1);
+	struct resctrl_cpu_defaults defaults, *p = NULL;
+
+	if (r) {
+		defaults.closid = r->closid;
+		defaults.rmid = r->mon.rmid;
+		p = &defaults;
+	}
+
+	on_each_cpu_mask(cpu_mask, resctrl_arch_sync_cpu_closid_rmid, p, 1);
 }
 
 static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index d16dc96..31808b3 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -266,6 +266,28 @@ struct resctrl_schema {
 	u32				num_closid;
 };
 
+struct resctrl_cpu_defaults {
+	u32 closid;
+	u32 rmid;
+};
+
+/**
+ * resctrl_arch_sync_cpu_closid_rmid() - Refresh this CPU's CLOSID and RMID.
+ *					 Call via IPI.
+ * @info:	If non-NULL, a pointer to a struct resctrl_cpu_defaults
+ *		specifying the new CLOSID and RMID for tasks in the default
+ *		resctrl ctrl and mon group when running on this CPU.  If NULL,
+ *		this CPU is not re-assigned to a different default group.
+ *
+ * Propagates reassignment of CPUs and/or tasks to different resctrl groups
+ * when requested by the resctrl core code.
+ *
+ * This function records the per-cpu defaults specified by @info (if any),
+ * and then reconfigures the CPU's hardware CLOSID and RMID for subsequent
+ * execution based on @current, in the same way as during a task switch.
+ */
+void resctrl_arch_sync_cpu_closid_rmid(void *info);
+
 /**
  * resctrl_get_default_ctrl() - Return the default control value for this
  *                              resource.

