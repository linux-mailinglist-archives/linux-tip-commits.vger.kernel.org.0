Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43B737F882
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 15:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhEMNT0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 13 May 2021 09:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbhEMNSp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 13 May 2021 09:18:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2695C061574;
        Thu, 13 May 2021 06:17:28 -0700 (PDT)
Date:   Thu, 13 May 2021 13:17:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620911847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UVV3zneIEDe+eolIm/nNGFGvELudnycxsQZGLPyf+dY=;
        b=T+r+/lczcEURLhXoG1G9VRZcIHNMzCO8L4XQgkwh6RZSpqfA/BSKlesstA33s5Ojg3JTeE
        3sncRYu5q0oggNuJ4UYnjP83GA735aUDRi5WS6F5YT+a4o8sddWaznvsKwTDUz5i4OTszU
        1mDmecTpWNUMOoswlL+nqvHKPBVeDD46cKwJg9ROVbnre1bvAlohlBGO7wlUddaBNEHlLe
        niba/pJkvP/lLmyN+KZhvvmtMX6HmlUPiYHThds4JWXSc09hONooYXX+fs3JV3AL2Q/qQY
        xJ/J0FWSL0cb807bb8sl8BZ4SRAMTmtg9DNk62u7tG/1cxdJTPKYeQMgPJbOng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620911847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UVV3zneIEDe+eolIm/nNGFGvELudnycxsQZGLPyf+dY=;
        b=qY+PhrJcoIME5H7jD1UJJMa2cxa0JEVYuZ5TvdTd1coVLRPU/r9R7DlQtf4BKDq6eyiOvc
        21BTCLtXB6BggcCw==
From:   "tip-bot2 for Marcelo Tosatti" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/nohz] tick/nohz: Kick only _queued_ task whose tick
 dependency is updated
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210512232924.150322-9-frederic@kernel.org>
References: <20210512232924.150322-9-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162091184694.29796.18356854745705114664.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/nohz branch of tip:

Commit-ID:     a1dfb6311c7739e21e160bc4c5575a1b21b48c87
Gitweb:        https://git.kernel.org/tip/a1dfb6311c7739e21e160bc4c5575a1b21b48c87
Author:        Marcelo Tosatti <mtosatti@redhat.com>
AuthorDate:    Thu, 13 May 2021 01:29:22 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 May 2021 14:21:22 +02:00

tick/nohz: Kick only _queued_ task whose tick dependency is updated

When the tick dependency of a task is updated, we want it to aknowledge
the new state and restart the tick if needed. If the task is not
running, we don't need to kick it because it will observe the new
dependency upon scheduling in. But if the task is running, we may need
to send an IPI to it so that it gets notified.

Unfortunately we don't have the means to check if a task is running
in a race free way. Checking p->on_cpu in a synchronized way against
p->tick_dep_mask would imply adding a full barrier between
prepare_task_switch() and tick_nohz_task_switch(), which we want to
avoid in this fast-path.

Therefore we blindly fire an IPI to the task's CPU.

Meanwhile we can check if the task is queued on the CPU rq because
p->on_rq is always set to TASK_ON_RQ_QUEUED _before_ schedule() and its
full barrier that precedes tick_nohz_task_switch(). And if the task is
queued on a nohz_full CPU, it also has fair chances to be running as the
isolation constraints prescribe running single tasks on full dynticks
CPUs.

So use this as a trick to check if we can spare an IPI toward a
non-running task.

NOTE: For the ordering to be correct, it is assumed that we never
deactivate a task while it is running, the only exception being the task
deactivating itself while scheduling out.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210512232924.150322-9-frederic@kernel.org
---
 include/linux/sched.h    |  2 ++
 kernel/sched/core.c      |  5 +++++
 kernel/time/tick-sched.c | 19 +++++++++++++++++--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2c8813..3341ae2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2011,6 +2011,8 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
 
 #endif /* CONFIG_SMP */
 
+extern bool sched_task_on_rq(struct task_struct *p);
+
 /*
  * In order to reduce various lock holder preemption latencies provide an
  * interface to see if a vCPU is currently running or not.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5226cc2..78e480f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1590,6 +1590,11 @@ static inline void uclamp_post_fork(struct task_struct *p) { }
 static inline void init_uclamp(void) { }
 #endif /* CONFIG_UCLAMP_TASK */
 
+bool sched_task_on_rq(struct task_struct *p)
+{
+	return task_on_rq_queued(p);
+}
+
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (!(flags & ENQUEUE_NOCLOCK))
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index acbe672..197a3bd 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -324,14 +324,28 @@ void tick_nohz_full_kick_cpu(int cpu)
 
 static void tick_nohz_kick_task(struct task_struct *tsk)
 {
-	int cpu = task_cpu(tsk);
+	int cpu;
+
+	/*
+	 * If the task is not running, run_posix_cpu_timers()
+	 * has nothing to elapse, IPI can then be spared.
+	 *
+	 * activate_task()                      STORE p->tick_dep_mask
+	 *   STORE p->on_rq
+	 * __schedule() (switch to task 'p')    smp_mb() (atomic_fetch_or())
+	 *   LOCK rq->lock                      LOAD p->on_rq
+	 *   smp_mb__after_spin_lock()
+	 *   tick_nohz_task_switch()
+	 *     LOAD p->tick_dep_mask
+	 */
+	if (!sched_task_on_rq(tsk))
+		return;
 
 	/*
 	 * If the task concurrently migrates to another CPU,
 	 * we guarantee it sees the new tick dependency upon
 	 * schedule.
 	 *
-	 *
 	 * set_task_cpu(p, cpu);
 	 *   STORE p->cpu = @cpu
 	 * __schedule() (switch to task 'p')
@@ -340,6 +354,7 @@ static void tick_nohz_kick_task(struct task_struct *tsk)
 	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
 	 *      LOAD p->tick_dep_mask           LOAD p->cpu
 	 */
+	cpu = task_cpu(tsk);
 
 	preempt_disable();
 	if (cpu_online(cpu))
