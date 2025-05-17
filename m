Return-Path: <linux-tip-commits+bounces-5654-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E50ABA967
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A36A03B35
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3959720D4F0;
	Sat, 17 May 2025 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="axJl48nG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Qw7Qm2Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075ED209F43;
	Sat, 17 May 2025 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476188; cv=none; b=e07+Pg/CS5MC42jwOxqRMnPi2I/VSLqo0BUcGU8VFpmH+xUV8sn+HPXvgLDPX2v/dknHyW59ju2YLsvahO0a/W3is1bycB3VDOLG5VyjrVwBkn4gDB6Nfk+zGWeiB1iYWqYAsNAMZxtGeYHu6aCTbgR4OKU7mmsyEig0ZGdJ1gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476188; c=relaxed/simple;
	bh=sBAnObnVeOTzZTeNFrnMvR5T5UMFdc7THxM7Wi2ZbuI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qkh615OrVEF9zsON5Jq242Axwr22V7hlQnXSlgiTPAuqhqBra5MvJmd9odbN8/tHlPk7G8jytCUHfprxERVQ8x8hTcWWPnK3SpztNGagvsnG3V1M13SDhREKx88ybLaudtjsGBc/t9lvCJBeeFPsGAwAdlv0cE7yYgN8qINdpD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=axJl48nG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Qw7Qm2Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:03:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/ewV0hr/Fcko//Q6R1uPgZZMx5cHC+dY+tPAzXSXRc=;
	b=axJl48nG3uciIZlpFpqX4b+iOdDVJj+EM6oT4lsdktTG7V8ZAEer+eZG/eVFYLrM/L9/u+
	jixJZ7PA67luf+kjVgLZDhHCVBF2+R4L4wsbzM01eINbKPOMU+WDwUUHfNmKCx5itO24B0
	mtDTDl6yKwkKY+PGpCpN6MOg1P/oVycqH7yqb535IbcUjWwZq+UC+mb73HXzsWXqyohw3k
	/rjsc6wULTmHjovmiLtIrV4emV3Wqw1QuXcF8pAzA1I3nq57OJibPO54wFkmOzAKOqS/R2
	BpHTchwdp3rtzKhFPgqYO/XVhdRa1jRz3HDVIFjwsNplQEYAaUivemOxSRCK5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/ewV0hr/Fcko//Q6R1uPgZZMx5cHC+dY+tPAzXSXRc=;
	b=2Qw7Qm2Q1cRbO6PqUCK4OHAqy72wwkXkOmJJheb7gS1PG7NpUcsX/zFx00i6mpwvoJR+qs
	QNItyYuD5LOM2ICA==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Rename resctrl_sched_in() to begin with
 "resctrl_arch_"
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-7-james.morse@arm.com>
References: <20250515165855.31452-7-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747618337.406.7348845016914993919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     7704fb81bc87254e8772f387b62153b135bb1932
Gitweb:        https://git.kernel.org/tip/7704fb81bc87254e8772f387b62153b135bb1932
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:36 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 15 May 2025 21:01:00 +02:00

x86/resctrl: Rename resctrl_sched_in() to begin with "resctrl_arch_"

resctrl_sched_in() loads the architecture specific CPU MSRs with the
CLOSID and RMID values. This function was named before resctrl was
split to have architecture specific code, and generic filesystem code.

This function is obviously architecture specific, but does not begin
with 'resctrl_arch_', making it the odd one out in the functions an
architecture needs to support to enable resctrl.

Rename it for consistency. This is purely cosmetic.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-7-james.morse@arm.com
---
 arch/x86/include/asm/resctrl.h         |  4 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 12 ++++++------
 arch/x86/kernel/process_32.c           |  2 +-
 arch/x86/kernel/process_64.c           |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 011bf67..7a39728 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -175,7 +175,7 @@ static inline bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 ignored,
 	return READ_ONCE(tsk->rmid) == rmid;
 }
 
-static inline void resctrl_sched_in(struct task_struct *tsk)
+static inline void resctrl_arch_sched_in(struct task_struct *tsk)
 {
 	if (static_branch_likely(&rdt_enable_key))
 		__resctrl_sched_in(tsk);
@@ -212,7 +212,7 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
 #else
 
-static inline void resctrl_sched_in(struct task_struct *tsk) {}
+static inline void resctrl_arch_sched_in(struct task_struct *tsk) {}
 static inline void resctrl_cpu_detect(struct cpuinfo_x86 *c) {}
 
 #endif /* CONFIG_X86_CPU_RESCTRL */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 53213ca..88197af 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -376,7 +376,7 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
 }
 
 /*
- * This is safe against resctrl_sched_in() called from __switch_to()
+ * This is safe against resctrl_arch_sched_in() called from __switch_to()
  * because __switch_to() is executed with interrupts disabled. A local call
  * from update_closid_rmid() is protected against __switch_to() because
  * preemption is disabled.
@@ -395,7 +395,7 @@ void resctrl_arch_sync_cpu_closid_rmid(void *info)
 	 * executing task might have its own closid selected. Just reuse
 	 * the context switch code.
 	 */
-	resctrl_sched_in(current);
+	resctrl_arch_sched_in(current);
 }
 
 /*
@@ -620,7 +620,7 @@ static void _update_task_closid_rmid(void *task)
 	 * Otherwise, the MSR is updated when the task is scheduled in.
 	 */
 	if (task == current)
-		resctrl_sched_in(task);
+		resctrl_arch_sched_in(task);
 }
 
 static void update_task_closid_rmid(struct task_struct *t)
@@ -678,7 +678,7 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	 * Ensure the task's closid and rmid are written before determining if
 	 * the task is current that will decide if it will be interrupted.
 	 * This pairs with the full barrier between the rq->curr update and
-	 * resctrl_sched_in() during context switch.
+	 * resctrl_arch_sched_in() during context switch.
 	 */
 	smp_mb();
 
@@ -2994,8 +2994,8 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 			/*
 			 * Order the closid/rmid stores above before the loads
 			 * in task_curr(). This pairs with the full barrier
-			 * between the rq->curr update and resctrl_sched_in()
-			 * during context switch.
+			 * between the rq->curr update and
+			 * resctrl_arch_sched_in() during context switch.
 			 */
 			smp_mb();
 
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 4636ef3..f1429fd 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -211,7 +211,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	switch_fpu_finish(next_p);
 
 	/* Load the Intel cache allocation PQR MSR. */
-	resctrl_sched_in(next_p);
+	resctrl_arch_sched_in(next_p);
 
 	return prev_p;
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 7196ca7..642fc32 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -707,7 +707,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	}
 
 	/* Load the Intel cache allocation PQR MSR. */
-	resctrl_sched_in(next_p);
+	resctrl_arch_sched_in(next_p);
 
 	return prev_p;
 }

