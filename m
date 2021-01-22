Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93699300A5A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Jan 2021 18:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbhAVRuE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Jan 2021 12:50:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55692 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbhAVRm1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Jan 2021 12:42:27 -0500
Date:   Fri, 22 Jan 2021 17:41:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611337294;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BPTueTNRul09a8MYVe1wx5xGuwjt8IYbYfuKNruUD78=;
        b=Zx93SxlJac2AZ95YtQTZrob0mHENJIwwqjDLMO8s9NKb0+eZpY88AYoZldUF0ac2Iw+EYh
        In/ILW4AKSjdZ2zyN/wvHkv8SLEZ6b+TM2uNl64Ldf4g8/sj/3+JPpv/R2ALUqfpbwZoHw
        nAwAFv0B8q4bR0f/jr+Ddr45e36mWJsA+Y9M3bfZwfb8akO2KJBnf5QkByzo4AoMv2mjFX
        1XIIwk+P9dk5It6DWyvM885eCROPvTW3NVHF+7G79PO0hsBIu0gh4MeKjQYc8Sh2jeHDKw
        6I/fDtndoVrwr3gzJhwb2qnVzvrYW04Yzxm8Vehs4ASjknjJcYpH93SXEaFwag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611337294;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BPTueTNRul09a8MYVe1wx5xGuwjt8IYbYfuKNruUD78=;
        b=V1DPrlgJfrs1tLS/vJ8IqYxTikxQnv8uk8vL2/S0WRQnmo9sI+g3LVKnXrv8E/XZcW70KM
        sdiEILC1WedhmbAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Relax the set_cpus_allowed_ptr() semantics
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Lai jiangshan <jiangshanlai@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210121103507.240724591@infradead.org>
References: <20210121103507.240724591@infradead.org>
MIME-Version: 1.0
Message-ID: <161133729382.414.17070860269435145336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     741ba80f6f9a4702089c122129f22df9774b3e64
Gitweb:        https://git.kernel.org/tip/741ba80f6f9a4702089c122129f22df9774b3e64
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 16 Jan 2021 11:56:37 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Jan 2021 15:09:44 +01:00

sched: Relax the set_cpus_allowed_ptr() semantics

Now that we have KTHREAD_IS_PER_CPU to denote the critical per-cpu
tasks to retain during CPU offline, we can relax the warning in
set_cpus_allowed_ptr(). Any spurious kthread that wants to get on at
the last minute will get pushed off before it can run.

While during CPU online there is no harm, and actual benefit, to
allowing kthreads back on early, it simplifies hotplug code and fixes
a number of outstanding races.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lai jiangshan <jiangshanlai@gmail.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210121103507.240724591@infradead.org
---
 kernel/sched/core.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 56b0962..ff74fca 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2342,7 +2342,9 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 
 	if (p->flags & PF_KTHREAD || is_migration_disabled(p)) {
 		/*
-		 * Kernel threads are allowed on online && !active CPUs.
+		 * Kernel threads are allowed on online && !active CPUs,
+		 * however, during cpu-hot-unplug, even these might get pushed
+		 * away if not KTHREAD_IS_PER_CPU.
 		 *
 		 * Specifically, migration_disabled() tasks must not fail the
 		 * cpumask_any_and_distribute() pick below, esp. so on
@@ -2386,16 +2388,6 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 
 	__do_set_cpus_allowed(p, new_mask, flags);
 
-	if (p->flags & PF_KTHREAD) {
-		/*
-		 * For kernel threads that do indeed end up on online &&
-		 * !active we want to ensure they are strict per-CPU threads.
-		 */
-		WARN_ON(cpumask_intersects(new_mask, cpu_online_mask) &&
-			!cpumask_intersects(new_mask, cpu_active_mask) &&
-			p->nr_cpus_allowed != 1);
-	}
-
 	return affine_move_task(rq, p, &rf, dest_cpu, flags);
 
 out:
@@ -7518,6 +7510,13 @@ int sched_cpu_deactivate(unsigned int cpu)
 	int ret;
 
 	set_cpu_active(cpu, false);
+
+	/*
+	 * From this point forward, this CPU will refuse to run any task that
+	 * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively
+	 * push those tasks away until this gets cleared, see
+	 * sched_cpu_dying().
+	 */
 	balance_push_set(cpu, true);
 
 	/*
