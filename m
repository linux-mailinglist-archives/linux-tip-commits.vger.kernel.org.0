Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2364547F5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Nov 2021 15:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbhKQODo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Nov 2021 09:03:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60102 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238022AbhKQODA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Nov 2021 09:03:00 -0500
Date:   Wed, 17 Nov 2021 13:59:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637157600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f602pJmTRckwh397K621p4AuNe4roee7AbeUjZO9oRA=;
        b=nW6D1Wxk/R+gfk0DdnqcmR+WH5L933eNiRRtGtaGrS2xI/P8ii9/+OGNgTBgYAbKEnczEi
        OorhDz96vp3vk1Oi2uDU3bK+5ANul0qWq2qhmVKKGTwmmJb1yaVAc9/pkCJt0s5n+B9N04
        AWzPGwjCJbh3HHxa9BQeahfzvDeUPFbwxKlI+vYPt+CwE87iRPZ+LfkMddfOaWRC8C67eR
        nv3/QI/lU0jxpMTJlW7p/5l81hlIhBQqMnzNL07uFfhTQDGguM7w6/VCB0QSSkEYUh9kDa
        F6hH9TCbVSI+c4rzna7UK4TTQABSh8GlDjEZl8iWtd6p7N03Q55teP9rtrWGqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637157600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f602pJmTRckwh397K621p4AuNe4roee7AbeUjZO9oRA=;
        b=V+CeMifKgitKVzsGNqDtE/vhOtXOa8vprRsuv75hywWmZecN3Tx10baG833D1RjJNIN5XT
        2v5o+U95KNqjgeBQ==
From:   "tip-bot2 for Brian Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: Fix PSI_MEM_FULL state when tasks are in
 memstall and doing reclaim
Cc:     Brian Chen <brianchen118@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110213312.310243-1-brianchen118@gmail.com>
References: <20211110213312.310243-1-brianchen118@gmail.com>
MIME-Version: 1.0
Message-ID: <163715759965.11128.7039069818296933034.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     cb0e52b7748737b2cf6481fdd9b920ce7e1ebbdf
Gitweb:        https://git.kernel.org/tip/cb0e52b7748737b2cf6481fdd9b920ce7e1ebbdf
Author:        Brian Chen <brianchen118@gmail.com>
AuthorDate:    Wed, 10 Nov 2021 21:33:12 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Nov 2021 14:49:00 +01:00

psi: Fix PSI_MEM_FULL state when tasks are in memstall and doing reclaim

We've noticed cases where tasks in a cgroup are stalled on memory but
there is little memory FULL pressure since tasks stay on the runqueue
in reclaim.

A simple example involves a single threaded program that keeps leaking
and touching large amounts of memory. It runs in a cgroup with swap
enabled, memory.high set at 10M and cpu.max ratio set at 5%. Though
there is significant CPU pressure and memory SOME, there is barely any
memory FULL since the task enters reclaim and stays on the runqueue.
However, this memory-bound task is effectively stalled on memory and
we expect memory FULL to match memory SOME in this scenario.

The code is confused about memstall && running, thinking there is a
stalled task and a productive task when there's only one task: a
reclaimer that's counted as both. To fix this, we redefine the
condition for PSI_MEM_FULL to check that all running tasks are in an
active memstall instead of checking that there are no running tasks.

        case PSI_MEM_FULL:
-               return unlikely(tasks[NR_MEMSTALL] && !tasks[NR_RUNNING]);
+               return unlikely(tasks[NR_MEMSTALL] &&
+                       tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING]);

This will capture reclaimers. It will also capture tasks that called
psi_memstall_enter() and are about to sleep, but this should be
negligible noise.

Signed-off-by: Brian Chen <brianchen118@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lore.kernel.org/r/20211110213312.310243-1-brianchen118@gmail.com
---
 include/linux/psi_types.h | 13 ++++++++++-
 kernel/sched/psi.c        | 45 +++++++++++++++++++++++---------------
 kernel/sched/stats.h      |  5 +++-
 3 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index bf50068..516c0fe 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -22,7 +22,17 @@ enum psi_task_count {
 	 * don't have to special case any state tracking for it.
 	 */
 	NR_ONCPU,
-	NR_PSI_TASK_COUNTS = 4,
+	/*
+	 * For IO and CPU stalls the presence of running/oncpu tasks
+	 * in the domain means a partial rather than a full stall.
+	 * For memory it's not so simple because of page reclaimers:
+	 * they are running/oncpu while representing a stall. To tell
+	 * whether a domain has productivity left or not, we need to
+	 * distinguish between regular running (i.e. productive)
+	 * threads and memstall ones.
+	 */
+	NR_MEMSTALL_RUNNING,
+	NR_PSI_TASK_COUNTS = 5,
 };
 
 /* Task state bitmasks */
@@ -30,6 +40,7 @@ enum psi_task_count {
 #define TSK_MEMSTALL	(1 << NR_MEMSTALL)
 #define TSK_RUNNING	(1 << NR_RUNNING)
 #define TSK_ONCPU	(1 << NR_ONCPU)
+#define TSK_MEMSTALL_RUNNING	(1 << NR_MEMSTALL_RUNNING)
 
 /* Resources that workloads could be stalled on */
 enum psi_res {
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 3397fa0..a679613 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -35,13 +35,19 @@
  * delayed on that resource such that nobody is advancing and the CPU
  * goes idle. This leaves both workload and CPU unproductive.
  *
- * Naturally, the FULL state doesn't exist for the CPU resource at the
- * system level, but exist at the cgroup level, means all non-idle tasks
- * in a cgroup are delayed on the CPU resource which used by others outside
- * of the cgroup or throttled by the cgroup cpu.max configuration.
- *
  *	SOME = nr_delayed_tasks != 0
- *	FULL = nr_delayed_tasks != 0 && nr_running_tasks == 0
+ *	FULL = nr_delayed_tasks != 0 && nr_productive_tasks == 0
+ *
+ * What it means for a task to be productive is defined differently
+ * for each resource. For IO, productive means a running task. For
+ * memory, productive means a running task that isn't a reclaimer. For
+ * CPU, productive means an oncpu task.
+ *
+ * Naturally, the FULL state doesn't exist for the CPU resource at the
+ * system level, but exist at the cgroup level. At the cgroup level,
+ * FULL means all non-idle tasks in the cgroup are delayed on the CPU
+ * resource which is being used by others outside of the cgroup or
+ * throttled by the cgroup cpu.max configuration.
  *
  * The percentage of wallclock time spent in those compound stall
  * states gives pressure numbers between 0 and 100 for each resource,
@@ -82,13 +88,13 @@
  *
  *	threads = min(nr_nonidle_tasks, nr_cpus)
  *	   SOME = min(nr_delayed_tasks / threads, 1)
- *	   FULL = (threads - min(nr_running_tasks, threads)) / threads
+ *	   FULL = (threads - min(nr_productive_tasks, threads)) / threads
  *
  * For the 257 number crunchers on 256 CPUs, this yields:
  *
  *	threads = min(257, 256)
  *	   SOME = min(1 / 256, 1)             = 0.4%
- *	   FULL = (256 - min(257, 256)) / 256 = 0%
+ *	   FULL = (256 - min(256, 256)) / 256 = 0%
  *
  * For the 1 out of 4 memory-delayed tasks, this yields:
  *
@@ -113,7 +119,7 @@
  * For each runqueue, we track:
  *
  *	   tSOME[cpu] = time(nr_delayed_tasks[cpu] != 0)
- *	   tFULL[cpu] = time(nr_delayed_tasks[cpu] && !nr_running_tasks[cpu])
+ *	   tFULL[cpu] = time(nr_delayed_tasks[cpu] && !nr_productive_tasks[cpu])
  *	tNONIDLE[cpu] = time(nr_nonidle_tasks[cpu] != 0)
  *
  * and then periodically aggregate:
@@ -234,7 +240,8 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 	case PSI_MEM_SOME:
 		return unlikely(tasks[NR_MEMSTALL]);
 	case PSI_MEM_FULL:
-		return unlikely(tasks[NR_MEMSTALL] && !tasks[NR_RUNNING]);
+		return unlikely(tasks[NR_MEMSTALL] &&
+			tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING]);
 	case PSI_CPU_SOME:
 		return unlikely(tasks[NR_RUNNING] > tasks[NR_ONCPU]);
 	case PSI_CPU_FULL:
@@ -711,10 +718,11 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		if (groupc->tasks[t]) {
 			groupc->tasks[t]--;
 		} else if (!psi_bug) {
-			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
+			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u %u] clear=%x set=%x\n",
 					cpu, t, groupc->tasks[0],
 					groupc->tasks[1], groupc->tasks[2],
-					groupc->tasks[3], clear, set);
+					groupc->tasks[3], groupc->tasks[4],
+					clear, set);
 			psi_bug = 1;
 		}
 	}
@@ -854,12 +862,15 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		int clear = TSK_ONCPU, set = 0;
 
 		/*
-		 * When we're going to sleep, psi_dequeue() lets us handle
-		 * TSK_RUNNING and TSK_IOWAIT here, where we can combine it
-		 * with TSK_ONCPU and save walking common ancestors twice.
+		 * When we're going to sleep, psi_dequeue() lets us
+		 * handle TSK_RUNNING, TSK_MEMSTALL_RUNNING and
+		 * TSK_IOWAIT here, where we can combine it with
+		 * TSK_ONCPU and save walking common ancestors twice.
 		 */
 		if (sleep) {
 			clear |= TSK_RUNNING;
+			if (prev->in_memstall)
+				clear |= TSK_MEMSTALL_RUNNING;
 			if (prev->in_iowait)
 				set |= TSK_IOWAIT;
 		}
@@ -908,7 +919,7 @@ void psi_memstall_enter(unsigned long *flags)
 	rq = this_rq_lock_irq(&rf);
 
 	current->in_memstall = 1;
-	psi_task_change(current, 0, TSK_MEMSTALL);
+	psi_task_change(current, 0, TSK_MEMSTALL | TSK_MEMSTALL_RUNNING);
 
 	rq_unlock_irq(rq, &rf);
 }
@@ -937,7 +948,7 @@ void psi_memstall_leave(unsigned long *flags)
 	rq = this_rq_lock_irq(&rf);
 
 	current->in_memstall = 0;
-	psi_task_change(current, TSK_MEMSTALL, 0);
+	psi_task_change(current, TSK_MEMSTALL | TSK_MEMSTALL_RUNNING, 0);
 
 	rq_unlock_irq(rq, &rf);
 }
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index cfb0893..3a3c826 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -118,6 +118,9 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 	if (static_branch_likely(&psi_disabled))
 		return;
 
+	if (p->in_memstall)
+		set |= TSK_MEMSTALL_RUNNING;
+
 	if (!wakeup || p->sched_psi_wake_requeue) {
 		if (p->in_memstall)
 			set |= TSK_MEMSTALL;
@@ -148,7 +151,7 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
 		return;
 
 	if (p->in_memstall)
-		clear |= TSK_MEMSTALL;
+		clear |= (TSK_MEMSTALL | TSK_MEMSTALL_RUNNING);
 
 	psi_task_change(p, clear, 0);
 }
