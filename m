Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2FA31BB87
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBOO4e (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhBOO4Z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533EDC06178A;
        Mon, 15 Feb 2021 06:55:45 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xCsE54zCsiLcN3JVfXEo7Zo0gLp/qCfSeayIPMGHaDk=;
        b=NQbsa/hTVQC47Xj7F4YOT9OyVXKTdvFVXIjHAkqSiUCrKltwCnAnEwViIrVDqxTvwQfno9
        sHNlGHg3gEiJ62AV5mS9LTWO5ab2+sXQ7cs6g7NNSgiC1k/AT4+4ARalRi8cIi6J+AHhLB
        C8JxauQJWvX+IQX0Vy/Yul0Zp9MY/qTsmgTndyCxikQGtW3+/5aDU8qRO97OhfuvSixaXp
        Nrjvup9gybQAkztzwJo1npfjL3zuwGCTPskr8jPVLS9wSuCteOYLIO1X5XaW8JJlEIneeg
        I8muhC1VUKo6tdiljh6Fy1ANWUcxatefY/gX+GHPytkyVUIpb0IEqWQzBUG9pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xCsE54zCsiLcN3JVfXEo7Zo0gLp/qCfSeayIPMGHaDk=;
        b=+4uVRdtbto1qrHaPl9L4ep4E0emLFZPd7DmUcQJ/WMIEQ6usAj9nPzm4NWR5OchvFLBeD/
        peoSJpECb0Y4ZFAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Add testing for RCU's global memory ordering
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094280.20312.6239095155352411820.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     00504537f44422a99d97f615f2b3ee17cfba194d
Gitweb:        https://git.kernel.org/tip/00504537f44422a99d97f615f2b3ee17cfba194d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 29 Oct 2020 15:08:57 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:53:41 -08:00

rcutorture: Add testing for RCU's global memory ordering

RCU guarantees that anything seen by a given reader will also be seen
after any grace period that must wait on that reader.  This is very likely
to hold based on inspection, but the advantage of having rcutorture do
the inspecting is that rcutorture doesn't mind inspecting frequently
and often.

This commit therefore adds code to test RCU's global memory ordering.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 98 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 96d55f0..338e118 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -143,11 +143,22 @@ static struct task_struct *read_exit_task;
 
 #define RCU_TORTURE_PIPE_LEN 10
 
+// Mailbox-like structure to check RCU global memory ordering.
+struct rcu_torture_reader_check {
+	unsigned long rtc_myloops;
+	int rtc_chkrdr;
+	unsigned long rtc_chkloops;
+	int rtc_ready;
+	struct rcu_torture_reader_check *rtc_assigner;
+} ____cacheline_internodealigned_in_smp;
+
+// Update-side data structure used to check RCU readers.
 struct rcu_torture {
 	struct rcu_head rtort_rcu;
 	int rtort_pipe_count;
 	struct list_head rtort_free;
 	int rtort_mbtest;
+	struct rcu_torture_reader_check *rtort_chkp;
 };
 
 static LIST_HEAD(rcu_torture_freelist);
@@ -158,10 +169,13 @@ static DEFINE_SPINLOCK(rcu_torture_lock);
 static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_count);
 static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_batch);
 static atomic_t rcu_torture_wcount[RCU_TORTURE_PIPE_LEN + 1];
+static struct rcu_torture_reader_check *rcu_torture_reader_mbchk;
 static atomic_t n_rcu_torture_alloc;
 static atomic_t n_rcu_torture_alloc_fail;
 static atomic_t n_rcu_torture_free;
 static atomic_t n_rcu_torture_mberror;
+static atomic_t n_rcu_torture_mbchk_fail;
+static atomic_t n_rcu_torture_mbchk_tries;
 static atomic_t n_rcu_torture_error;
 static long n_rcu_torture_barrier_error;
 static long n_rcu_torture_boost_ktrerror;
@@ -393,7 +407,12 @@ static bool
 rcu_torture_pipe_update_one(struct rcu_torture *rp)
 {
 	int i;
+	struct rcu_torture_reader_check *rtrcp = READ_ONCE(rp->rtort_chkp);
 
+	if (rtrcp) {
+		WRITE_ONCE(rp->rtort_chkp, NULL);
+		smp_store_release(&rtrcp->rtc_ready, 1); // Pair with smp_load_acquire().
+	}
 	i = READ_ONCE(rp->rtort_pipe_count);
 	if (i > RCU_TORTURE_PIPE_LEN)
 		i = RCU_TORTURE_PIPE_LEN;
@@ -1292,6 +1311,62 @@ static void rcu_torture_timer_cb(struct rcu_head *rhp)
 	kfree(rhp);
 }
 
+// Set up and carry out testing of RCU's global memory ordering
+static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
+					struct torture_random_state *trsp)
+{
+	unsigned long loops;
+	int noc = num_online_cpus();
+	int rdrchked;
+	int rdrchker;
+	struct rcu_torture_reader_check *rtrcp; // Me.
+	struct rcu_torture_reader_check *rtrcp_assigner; // Assigned us to do checking.
+	struct rcu_torture_reader_check *rtrcp_chked; // Reader being checked.
+	struct rcu_torture_reader_check *rtrcp_chker; // Reader doing checking when not me.
+
+	if (myid < 0)
+		return; // Don't try this from timer handlers.
+
+	// Increment my counter.
+	rtrcp = &rcu_torture_reader_mbchk[myid];
+	WRITE_ONCE(rtrcp->rtc_myloops, rtrcp->rtc_myloops + 1);
+
+	// Attempt to assign someone else some checking work.
+	rdrchked = torture_random(trsp) % nrealreaders;
+	rtrcp_chked = &rcu_torture_reader_mbchk[rdrchked];
+	rdrchker = torture_random(trsp) % nrealreaders;
+	rtrcp_chker = &rcu_torture_reader_mbchk[rdrchker];
+	if (rdrchked != myid && rdrchked != rdrchker && noc >= rdrchked && noc >= rdrchker &&
+	    smp_load_acquire(&rtrcp->rtc_chkrdr) < 0 && // Pairs with smp_store_release below.
+	    !READ_ONCE(rtp->rtort_chkp) &&
+	    !smp_load_acquire(&rtrcp_chker->rtc_assigner)) { // Pairs with smp_store_release below.
+		rtrcp->rtc_chkloops = READ_ONCE(rtrcp_chked->rtc_myloops);
+		WARN_ON_ONCE(rtrcp->rtc_chkrdr >= 0);
+		rtrcp->rtc_chkrdr = rdrchked;
+		WARN_ON_ONCE(rtrcp->rtc_ready); // This gets set after the grace period ends.
+		if (cmpxchg_relaxed(&rtrcp_chker->rtc_assigner, NULL, rtrcp) ||
+		    cmpxchg_relaxed(&rtp->rtort_chkp, NULL, rtrcp))
+			(void)cmpxchg_relaxed(&rtrcp_chker->rtc_assigner, rtrcp, NULL); // Back out.
+	}
+
+	// If assigned some completed work, do it!
+	rtrcp_assigner = READ_ONCE(rtrcp->rtc_assigner);
+	if (!rtrcp_assigner || !smp_load_acquire(&rtrcp_assigner->rtc_ready))
+		return; // No work or work not yet ready.
+	rdrchked = rtrcp_assigner->rtc_chkrdr;
+	if (WARN_ON_ONCE(rdrchked < 0))
+		return;
+	rtrcp_chked = &rcu_torture_reader_mbchk[rdrchked];
+	loops = READ_ONCE(rtrcp_chked->rtc_myloops);
+	atomic_inc(&n_rcu_torture_mbchk_tries);
+	if (ULONG_CMP_LT(loops, rtrcp_assigner->rtc_chkloops))
+		atomic_inc(&n_rcu_torture_mbchk_fail);
+	rtrcp_assigner->rtc_chkloops = loops + ULONG_MAX / 2;
+	rtrcp_assigner->rtc_ready = 0;
+	smp_store_release(&rtrcp->rtc_assigner, NULL); // Someone else can assign us work.
+	smp_store_release(&rtrcp_assigner->rtc_chkrdr, -1); // Assigner can again assign.
+}
+
 /*
  * Do one extension of an RCU read-side critical section using the
  * current reader state in readstate (set to zero for initial entry
@@ -1427,7 +1502,7 @@ rcutorture_loop_extend(int *readstate, struct torture_random_state *trsp,
  * no data to read.  Can be invoked both from process context and
  * from a timer handler.
  */
-static bool rcu_torture_one_read(struct torture_random_state *trsp)
+static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 {
 	unsigned long cookie;
 	int i;
@@ -1462,6 +1537,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 	}
 	if (p->rtort_mbtest == 0)
 		atomic_inc(&n_rcu_torture_mberror);
+	rcu_torture_reader_do_mbchk(myid, p, trsp);
 	rtrsp = rcutorture_loop_extend(&readstate, trsp, rtrsp);
 	preempt_disable();
 	pipe_count = READ_ONCE(p->rtort_pipe_count);
@@ -1518,7 +1594,7 @@ static DEFINE_TORTURE_RANDOM_PERCPU(rcu_torture_timer_rand);
 static void rcu_torture_timer(struct timer_list *unused)
 {
 	atomic_long_inc(&n_rcu_torture_timers);
-	(void)rcu_torture_one_read(this_cpu_ptr(&rcu_torture_timer_rand));
+	(void)rcu_torture_one_read(this_cpu_ptr(&rcu_torture_timer_rand), -1);
 
 	/* Test call_rcu() invocation from interrupt handler. */
 	if (cur_ops->call) {
@@ -1554,7 +1630,7 @@ rcu_torture_reader(void *arg)
 			if (!timer_pending(&t))
 				mod_timer(&t, jiffies + 1);
 		}
-		if (!rcu_torture_one_read(&rand) && !torture_must_stop())
+		if (!rcu_torture_one_read(&rand, myid) && !torture_must_stop())
 			schedule_timeout_interruptible(HZ);
 		if (time_after(jiffies, lastsleep) && !torture_must_stop()) {
 			schedule_timeout_interruptible(1);
@@ -1614,8 +1690,9 @@ rcu_torture_stats_print(void)
 		atomic_read(&n_rcu_torture_alloc),
 		atomic_read(&n_rcu_torture_alloc_fail),
 		atomic_read(&n_rcu_torture_free));
-	pr_cont("rtmbe: %d rtbe: %ld rtbke: %ld rtbre: %ld ",
+	pr_cont("rtmbe: %d rtmbkf: %d/%d rtbe: %ld rtbke: %ld rtbre: %ld ",
 		atomic_read(&n_rcu_torture_mberror),
+		atomic_read(&n_rcu_torture_mbchk_fail), atomic_read(&n_rcu_torture_mbchk_tries),
 		n_rcu_torture_barrier_error,
 		n_rcu_torture_boost_ktrerror,
 		n_rcu_torture_boost_rterror);
@@ -1632,12 +1709,14 @@ rcu_torture_stats_print(void)
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) ||
+	    atomic_read(&n_rcu_torture_mbchk_fail) ||
 	    n_rcu_torture_barrier_error || n_rcu_torture_boost_ktrerror ||
 	    n_rcu_torture_boost_rterror || n_rcu_torture_boost_failure ||
 	    i > 1) {
 		pr_cont("%s", "!!! ");
 		atomic_inc(&n_rcu_torture_error);
 		WARN_ON_ONCE(atomic_read(&n_rcu_torture_mberror));
+		WARN_ON_ONCE(atomic_read(&n_rcu_torture_mbchk_fail));
 		WARN_ON_ONCE(n_rcu_torture_barrier_error);  // rcu_barrier()
 		WARN_ON_ONCE(n_rcu_torture_boost_ktrerror); // no boost kthread
 		WARN_ON_ONCE(n_rcu_torture_boost_rterror); // can't set RT prio
@@ -2467,7 +2546,7 @@ static int rcu_torture_read_exit_child(void *trsp_in)
 	// Minimize time between reading and exiting.
 	while (!kthread_should_stop())
 		schedule_timeout_uninterruptible(1);
-	(void)rcu_torture_one_read(trsp);
+	(void)rcu_torture_one_read(trsp, -1);
 	return 0;
 }
 
@@ -2582,6 +2661,8 @@ rcu_torture_cleanup(void)
 		kfree(reader_tasks);
 		reader_tasks = NULL;
 	}
+	kfree(rcu_torture_reader_mbchk);
+	rcu_torture_reader_mbchk = NULL;
 
 	if (fakewriter_tasks) {
 		for (i = 0; i < nfakewriters; i++)
@@ -2785,6 +2866,8 @@ rcu_torture_init(void)
 	atomic_set(&n_rcu_torture_alloc_fail, 0);
 	atomic_set(&n_rcu_torture_free, 0);
 	atomic_set(&n_rcu_torture_mberror, 0);
+	atomic_set(&n_rcu_torture_mbchk_fail, 0);
+	atomic_set(&n_rcu_torture_mbchk_tries, 0);
 	atomic_set(&n_rcu_torture_error, 0);
 	n_rcu_torture_barrier_error = 0;
 	n_rcu_torture_boost_ktrerror = 0;
@@ -2826,12 +2909,15 @@ rcu_torture_init(void)
 	}
 	reader_tasks = kcalloc(nrealreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
-	if (reader_tasks == NULL) {
+	rcu_torture_reader_mbchk = kcalloc(nrealreaders, sizeof(*rcu_torture_reader_mbchk),
+					   GFP_KERNEL);
+	if (!reader_tasks || !rcu_torture_reader_mbchk) {
 		VERBOSE_TOROUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
 	for (i = 0; i < nrealreaders; i++) {
+		rcu_torture_reader_mbchk[i].rtc_chkrdr = -1;
 		firsterr = torture_create_kthread(rcu_torture_reader, (void *)i,
 						  reader_tasks[i]);
 		if (firsterr)
