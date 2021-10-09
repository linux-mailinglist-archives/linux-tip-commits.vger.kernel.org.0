Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6B64278E7
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244985AbhJIKKy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:10:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49668 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244857AbhJIKKD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:10:03 -0400
Date:   Sat, 09 Oct 2021 10:07:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60/+SY8E0h2m9+++lh0PA/3g3TptwzZEqR6jwApUM3M=;
        b=nAtQ2DoW+6hhPSDkzurd1Sit4P/vrwZs6ywVsFNUzItO8JE/dXN/LUF5DSmp4ePCL98K2I
        pLREDUDHQvFYuq15wbKE5DqnBuLM25QR2QnS0JDEZ8KZHWC3HQyVyeNOoa3ewAVxrTqPU8
        crC0xGtkvLsI2Kx0pbEkMlIwj0R5uQrlLngWU5xUlvs0qyp5p3al2jIsPVApCG/3jy0pyx
        qX0IdB7+nkuhvSte0VkVBiPHLW5SVQuNT+t3NAn6Yt+H2JCZ/AJtshqtr3AGx7K2/E/owu
        XQK/iuN8WJEDjOxi1Pl49oFgAzvNSWhl60gqN3VdqX65Yi6Qb71F2LUYfE2k4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60/+SY8E0h2m9+++lh0PA/3g3TptwzZEqR6jwApUM3M=;
        b=gIVZYXNVhv2zpuD/Je1SRRB5O9Juc2Mjl+48oHHmU9GOj/AdeN9zjtvPU0k2jIjyAMYvct
        mShjiSghrvXYLuDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,rcu: Rework try_invoke_on_locked_down_task()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210929152428.649944917@infradead.org>
References: <20210929152428.649944917@infradead.org>
MIME-Version: 1.0
Message-ID: <163377406051.25758.17414280353986792435.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9b3c4ab3045e953670c7de9c1165fae5358a7237
Gitweb:        https://git.kernel.org/tip/9b3c4ab3045e953670c7de9c1165fae5358a7237
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Sep 2021 21:54:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:15 +02:00

sched,rcu: Rework try_invoke_on_locked_down_task()

Give try_invoke_on_locked_down_task() a saner name and have it return
an int so that the caller might distinguish between different reasons
of failure.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Tested-by: Vasily Gorbik <gor@linux.ibm.com> # on s390
Link: https://lkml.kernel.org/r/20210929152428.649944917@infradead.org
---
 include/linux/wait.h    |  3 ++-
 kernel/rcu/tasks.h      | 12 ++++++------
 kernel/rcu/tree_stall.h |  8 ++++----
 kernel/sched/core.c     |  6 +++---
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 93dab0e..2d0df57 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -1160,6 +1160,7 @@ int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, i
 		(wait)->flags = 0;						\
 	} while (0)
 
-bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg);
+typedef int (*task_call_f)(struct task_struct *p, void *arg);
+extern int task_call_func(struct task_struct *p, task_call_f func, void *arg);
 
 #endif /* _LINUX_WAIT_H */
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 806160c..171bc84 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -928,7 +928,7 @@ reset_ipi:
 }
 
 /* Callback function for scheduler to check locked-down task.  */
-static bool trc_inspect_reader(struct task_struct *t, void *arg)
+static int trc_inspect_reader(struct task_struct *t, void *arg)
 {
 	int cpu = task_cpu(t);
 	bool in_qs = false;
@@ -939,7 +939,7 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 
 		// If no chance of heavyweight readers, do it the hard way.
 		if (!ofl && !IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
-			return false;
+			return -EINVAL;
 
 		// If heavyweight readers are enabled on the remote task,
 		// we can inspect its state despite its currently running.
@@ -947,7 +947,7 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 		n_heavy_reader_attempts++;
 		if (!ofl && // Check for "running" idle tasks on offline CPUs.
 		    !rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
-			return false; // No quiescent state, do it the hard way.
+			return -EINVAL; // No quiescent state, do it the hard way.
 		n_heavy_reader_updates++;
 		if (ofl)
 			n_heavy_reader_ofl_updates++;
@@ -962,7 +962,7 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 	t->trc_reader_checked = true;
 
 	if (in_qs)
-		return true;  // Already in quiescent state, done!!!
+		return 0;  // Already in quiescent state, done!!!
 
 	// The task is in a read-side critical section, so set up its
 	// state so that it will awaken the grace-period kthread upon exit
@@ -970,7 +970,7 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 	atomic_inc(&trc_n_readers_need_end); // One more to wait on.
 	WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs));
 	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
-	return true;
+	return 0;
 }
 
 /* Attempt to extract the state for the specified task. */
@@ -992,7 +992,7 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 
 	// Attempt to nail down the task for inspection.
 	get_task_struct(t);
-	if (try_invoke_on_locked_down_task(t, trc_inspect_reader, NULL)) {
+	if (!task_call_func(t, trc_inspect_reader, NULL)) {
 		put_task_struct(t);
 		return;
 	}
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 677ee3d..5e2fa6f 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -240,16 +240,16 @@ struct rcu_stall_chk_rdr {
  * Report out the state of a not-running task that is stalling the
  * current RCU grace period.
  */
-static bool check_slow_task(struct task_struct *t, void *arg)
+static int check_slow_task(struct task_struct *t, void *arg)
 {
 	struct rcu_stall_chk_rdr *rscrp = arg;
 
 	if (task_curr(t))
-		return false; // It is running, so decline to inspect it.
+		return -EBUSY; // It is running, so decline to inspect it.
 	rscrp->nesting = t->rcu_read_lock_nesting;
 	rscrp->rs = t->rcu_read_unlock_special;
 	rscrp->on_blkd_list = !list_empty(&t->rcu_node_entry);
-	return true;
+	return 0;
 }
 
 /*
@@ -283,7 +283,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	while (i) {
 		t = ts[--i];
-		if (!try_invoke_on_locked_down_task(t, check_slow_task, &rscr))
+		if (task_call_func(t, check_slow_task, &rscr))
 			pr_cont(" P%d", t->pid);
 		else
 			pr_cont(" P%d/%d:%c%c%c%c",
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8a9aeac..74db3c3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4110,7 +4110,7 @@ out:
 }
 
 /**
- * try_invoke_on_locked_down_task - Invoke a function on task in fixed state
+ * task_call_func - Invoke a function on task in fixed state
  * @p: Process for which the function is to be invoked, can be @current.
  * @func: Function to invoke.
  * @arg: Argument to function.
@@ -4123,12 +4123,12 @@ out:
  * Returns:
  *   Whatever @func returns
  */
-bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg)
+int task_call_func(struct task_struct *p, task_call_f func, void *arg)
 {
 	struct rq *rq = NULL;
 	unsigned int state;
 	struct rq_flags rf;
-	bool ret = false;
+	int ret;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 
