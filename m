Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFC7319EB5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhBLMkT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45332 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhBLMiw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:52 -0500
Date:   Fri, 12 Feb 2021 12:37:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133435;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SMYH1ti0VT22jHjvfoO8HBQPyu7kjLBeQfRFWoLG9WA=;
        b=yepK/gF3A6WBi7XhHhzB027EtLfEqENMqHE+4mKgF+1meT/tXOkeX5nwxUpRZ/4zhA4a2z
        AAalkWUA35kmka1/UoxUKb3ojt4TX6JqWEyO2mezjxR0PIgpPPvAgREKyfVvGDn9kgJF/U
        BDWVveSIhKXXkUR5fhPtU5JxkMM0CTfe4HluNp5jtn5B/esUlhU+iomW2wzJBhTKu7jfGM
        zEUruv+OS6FKyipyTtKm1C0qKFlI+brfhjlY9FFTi5LVM34H1gYfrRvXuiYO6j1nnn7Xs2
        YbC6iYx5PNRqSEcLJsQsLZvmdGYOB4cnPBeYPojD4I/GrVRhEqMBA3UDOIs1Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SMYH1ti0VT22jHjvfoO8HBQPyu7kjLBeQfRFWoLG9WA=;
        b=/6f8zhztztmQCTDBc2rVAPpQBcpYMD2GOVib8SkQIDhjNBdZdsTES2DiNYSmnlWFJv9dNr
        /5lR3/FW+wQtanAA==
From:   "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Check and report missed fqs timer wakeup on RCU stall
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343534.23325.16700918004955304852.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     683954e55c981467bfd4688417e914bafc40959f
Gitweb:        https://git.kernel.org/tip/683954e55c981467bfd4688417e914bafc40959f
Author:        Neeraj Upadhyay <neeraju@codeaurora.org>
AuthorDate:    Mon, 16 Nov 2020 21:36:00 +05:30
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:54:11 -08:00

rcu: Check and report missed fqs timer wakeup on RCU stall

For a new grace period request, the RCU GP kthread transitions through
following states:

a. [RCU_GP_WAIT_GPS] -> [RCU_GP_DONE_GPS]

The RCU_GP_WAIT_GPS state is where the GP kthread waits for a request
for a new GP.  Once it receives a request (for example, when a new RCU
callback is queued), the GP kthread transitions to RCU_GP_DONE_GPS.

b. [RCU_GP_DONE_GPS] -> [RCU_GP_ONOFF]

Grace period initialization starts in rcu_gp_init(), which records the
start of new GP in rcu_state.gp_seq and transitions to RCU_GP_ONOFF.

c. [RCU_GP_ONOFF] -> [RCU_GP_INIT]

The purpose of the RCU_GP_ONOFF state is to apply the online/offline
information that was buffered for any CPUs that recently came online or
went offline.  This state is maintained in per-leaf rcu_node bitmasks,
with the buffered state in ->qsmaskinitnext and the state for the upcoming
GP in ->qsmaskinit.  At the end of this RCU_GP_ONOFF state, each bit in
->qsmaskinit will correspond to a CPU that must pass through a quiescent
state before the upcoming grace period is allowed to complete.

However, a leaf rcu_node structure with an all-zeroes ->qsmaskinit
cannot necessarily be ignored.  In preemptible RCU, there might well be
tasks still in RCU read-side critical sections that were first preempted
while running on one of the CPUs managed by this structure.  Such tasks
will be queued on this structure's ->blkd_tasks list.  Only after this
list fully drains can this leaf rcu_node structure be ignored, and even
then only if none of its CPUs have come back online in the meantime.
Once that happens, the ->qsmaskinit masks further up the tree will be
updated to exclude this leaf rcu_node structure.

Once the ->qsmaskinitnext and ->qsmaskinit fields have been updated
as needed, the GP kthread transitions to RCU_GP_INIT.

d. [RCU_GP_INIT] -> [RCU_GP_WAIT_FQS]

The purpose of the RCU_GP_INIT state is to copy each ->qsmaskinit to
the ->qsmask field within each rcu_node structure.  This copying is done
breadth-first from the root to the leaves.  Why not just copy directly
from ->qsmaskinitnext to ->qsmask?  Because the ->qsmaskinitnext masks
can change in the meantime as additional CPUs come online or go offline.
Such changes would result in inconsistencies in the ->qsmask fields up and
down the tree, which could in turn result in too-short grace periods or
grace-period hangs.  These issues are avoided by snapshotting the leaf
rcu_node structures' ->qsmaskinitnext fields into their ->qsmaskinit
counterparts, generating a consistent set of ->qsmaskinit fields
throughout the tree, and only then copying these consistent ->qsmaskinit
fields to their ->qsmask counterparts.

Once this initialization step is complete, the GP kthread transitions
to RCU_GP_WAIT_FQS, where it waits to do a force-quiescent-state scan
on the one hand or for the end of the grace period on the other.

e. [RCU_GP_WAIT_FQS] -> [RCU_GP_DOING_FQS]

The RCU_GP_WAIT_FQS state waits for one of three things:  (1) An
explicit request to do a force-quiescent-state scan, (2) The end of
the grace period, or (3) A short interval of time, after which it
will do a force-quiescent-state (FQS) scan.  The explicit request can
come from rcutorture or from any CPU that has too many RCU callbacks
queued (see the qhimark kernel parameter and the RCU_GP_FLAG_OVLD
flag).  The aforementioned "short period of time" is specified by the
jiffies_till_first_fqs boot parameter for a given grace period's first
FQS scan and by the jiffies_till_next_fqs for later FQS scans.

Either way, once the wait is over, the GP kthread transitions to
RCU_GP_DOING_FQS.

f. [RCU_GP_DOING_FQS] -> [RCU_GP_CLEANUP]

The RCU_GP_DOING_FQS state performs an FQS scan.  Each such scan carries
out two functions for any CPU whose bit is still set in its leaf rcu_node
structure's ->qsmask field, that is, for any CPU that has not yet reported
a quiescent state for the current grace period:

  i.  Report quiescent states on behalf of CPUs that have been observed
      to be idle (from an RCU perspective) since the beginning of the
      grace period.

  ii. If the current grace period is too old, take various actions to
      encourage holdout CPUs to pass through quiescent states, including
      enlisting the aid of any calls to cond_resched() and might_sleep(),
      and even including IPIing the holdout CPUs.

These checks are skipped for any leaf rcu_node structure with a all-zero
->qsmask field, however such structures are subject to RCU priority
boosting if there are tasks on a given structure blocking the current
grace period.  The end of the grace period is detected when the root
rcu_node structure's ->qsmask is zero and when there are no longer any
preempted tasks blocking the current grace period.  (No, this last check
is not redundant.  To see this, consider an rcu_node tree having exactly
one structure that serves as both root and leaf.)

Once the end of the grace period is detected, the GP kthread transitions
to RCU_GP_CLEANUP.

g. [RCU_GP_CLEANUP] -> [RCU_GP_CLEANED]

The RCU_GP_CLEANUP state marks the end of grace period by updating the
rcu_state structure's ->gp_seq field and also all rcu_node structures'
->gp_seq field.  As before, the rcu_node tree is traversed in breadth
first order.  Once this update is complete, the GP kthread transitions
to the RCU_GP_CLEANED state.

i. [RCU_GP_CLEANED] -> [RCU_GP_INIT]

Once in the RCU_GP_CLEANED state, the GP kthread immediately transitions
into the RCU_GP_INIT state.

j. The role of timers.

If there is at least one idle CPU, and if timers are not firing, the
transition from RCU_GP_DOING_FQS to RCU_GP_CLEANUP will never happen.
Timers can fail to fire for a number of reasons, including issues in
timer configuration, issues in the timer framework, and failure to handle
softirqs (for example, when there is a storm of interrupts).  Whatever the
reason, if the timers fail to fire, the GP kthread will never be awakened,
resulting in RCU CPU stall warnings and eventually in OOM.

However, an RCU CPU stall warning has a large number of potential causes,
as documented in Documentation/RCU/stallwarn.rst.  This commit therefore
adds analysis to the RCU CPU stall-warning code to emit an additional
message if the cause of the stall is likely to be timer failure.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/stallwarn.rst | 23 ++++++++++++++++++++++-
 kernel/rcu/tree.c               | 25 +++++++++++++++----------
 kernel/rcu/tree_stall.h         | 32 ++++++++++++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 11 deletions(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index c9ab6af..d53856c 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -92,7 +92,9 @@ warnings:
 	buggy timer hardware through bugs in the interrupt or exception
 	path (whether hardware, firmware, or software) through bugs
 	in Linux's timer subsystem through bugs in the scheduler, and,
-	yes, even including bugs in RCU itself.
+	yes, even including bugs in RCU itself.  It can also result in
+	the ``rcu_.*timer wakeup didn't happen for`` console-log message,
+	which will include additional debugging information.
 
 -	A bug in the RCU implementation.
 
@@ -292,6 +294,25 @@ kthread is waiting for a short timeout, the "state" precedes value of the
 task_struct ->state field, and the "cpu" indicates that the grace-period
 kthread last ran on CPU 5.
 
+If the relevant grace-period kthread does not wake from FQS wait in a
+reasonable time, then the following additional line is printed::
+
+	kthread timer wakeup didn't happen for 23804 jiffies! g7076 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
+
+The "23804" indicates that kthread's timer expired more than 23 thousand
+jiffies ago.  The rest of the line has meaning similar to the kthread
+starvation case.
+
+Additionally, the following line is printed::
+
+	Possible timer handling issue on cpu=4 timer-softirq=11142
+
+Here "cpu" indicates that the grace-period kthread last ran on CPU 4,
+where it queued the fqs timer.  The number following the "timer-softirq"
+is the current ``TIMER_SOFTIRQ`` count on cpu 4.  If this value does not
+change on successive RCU CPU stall warnings, there is further reason to
+suspect a timer problem.
+
 
 Multiple Warnings From One Stall
 ================================
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 40e5e3d..e918f10 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1765,7 +1765,7 @@ static bool rcu_gp_init(void)
 	 * go offline later.  Please also refer to "Hotplug CPU" section
 	 * of RCU's Requirements documentation.
 	 */
-	rcu_state.gp_state = RCU_GP_ONOFF;
+	WRITE_ONCE(rcu_state.gp_state, RCU_GP_ONOFF);
 	rcu_for_each_leaf_node(rnp) {
 		smp_mb(); // Pair with barriers used when updating ->ofl_seq to odd values.
 		firstseq = READ_ONCE(rnp->ofl_seq);
@@ -1831,7 +1831,7 @@ static bool rcu_gp_init(void)
 	 * The grace period cannot complete until the initialization
 	 * process finishes, because this kthread handles both.
 	 */
-	rcu_state.gp_state = RCU_GP_INIT;
+	WRITE_ONCE(rcu_state.gp_state, RCU_GP_INIT);
 	rcu_for_each_node_breadth_first(rnp) {
 		rcu_gp_slow(gp_init_delay);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -1930,17 +1930,22 @@ static void rcu_gp_fqs_loop(void)
 	ret = 0;
 	for (;;) {
 		if (!ret) {
-			rcu_state.jiffies_force_qs = jiffies + j;
+			WRITE_ONCE(rcu_state.jiffies_force_qs, jiffies + j);
+			/*
+			 * jiffies_force_qs before RCU_GP_WAIT_FQS state
+			 * update; required for stall checks.
+			 */
+			smp_wmb();
 			WRITE_ONCE(rcu_state.jiffies_kick_kthreads,
 				   jiffies + (j ? 3 * j : 2));
 		}
 		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 				       TPS("fqswait"));
-		rcu_state.gp_state = RCU_GP_WAIT_FQS;
+		WRITE_ONCE(rcu_state.gp_state, RCU_GP_WAIT_FQS);
 		ret = swait_event_idle_timeout_exclusive(
 				rcu_state.gp_wq, rcu_gp_fqs_check_wake(&gf), j);
 		rcu_gp_torture_wait();
-		rcu_state.gp_state = RCU_GP_DOING_FQS;
+		WRITE_ONCE(rcu_state.gp_state, RCU_GP_DOING_FQS);
 		/* Locking provides needed memory barriers. */
 		/* If grace period done, leave loop. */
 		if (!READ_ONCE(rnp->qsmask) &&
@@ -2054,7 +2059,7 @@ static void rcu_gp_cleanup(void)
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("end"));
 	rcu_seq_end(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
-	rcu_state.gp_state = RCU_GP_IDLE;
+	WRITE_ONCE(rcu_state.gp_state, RCU_GP_IDLE);
 	/* Check for GP requests since above loop. */
 	rdp = this_cpu_ptr(&rcu_data);
 	if (!needgp && ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed)) {
@@ -2093,12 +2098,12 @@ static int __noreturn rcu_gp_kthread(void *unused)
 		for (;;) {
 			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("reqwait"));
-			rcu_state.gp_state = RCU_GP_WAIT_GPS;
+			WRITE_ONCE(rcu_state.gp_state, RCU_GP_WAIT_GPS);
 			swait_event_idle_exclusive(rcu_state.gp_wq,
 					 READ_ONCE(rcu_state.gp_flags) &
 					 RCU_GP_FLAG_INIT);
 			rcu_gp_torture_wait();
-			rcu_state.gp_state = RCU_GP_DONE_GPS;
+			WRITE_ONCE(rcu_state.gp_state, RCU_GP_DONE_GPS);
 			/* Locking provides needed memory barrier. */
 			if (rcu_gp_init())
 				break;
@@ -2113,9 +2118,9 @@ static int __noreturn rcu_gp_kthread(void *unused)
 		rcu_gp_fqs_loop();
 
 		/* Handle grace-period end. */
-		rcu_state.gp_state = RCU_GP_CLEANUP;
+		WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANUP);
 		rcu_gp_cleanup();
-		rcu_state.gp_state = RCU_GP_CLEANED;
+		WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANED);
 	}
 }
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 29cf096..353da30 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -482,6 +482,36 @@ static void rcu_check_gp_kthread_starvation(void)
 	}
 }
 
+/* Complain about missing wakeups from expired fqs wait timer */
+static void rcu_check_gp_kthread_expired_fqs_timer(void)
+{
+	struct task_struct *gpk = rcu_state.gp_kthread;
+	short gp_state;
+	unsigned long jiffies_fqs;
+	int cpu;
+
+	/*
+	 * Order reads of .gp_state and .jiffies_force_qs.
+	 * Matching smp_wmb() is present in rcu_gp_fqs_loop().
+	 */
+	gp_state = smp_load_acquire(&rcu_state.gp_state);
+	jiffies_fqs = READ_ONCE(rcu_state.jiffies_force_qs);
+
+	if (gp_state == RCU_GP_WAIT_FQS &&
+	    time_after(jiffies, jiffies_fqs + RCU_STALL_MIGHT_MIN) &&
+	    gpk && !READ_ONCE(gpk->on_rq)) {
+		cpu = task_cpu(gpk);
+		pr_err("%s kthread timer wakeup didn't happen for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx\n",
+		       rcu_state.name, (jiffies - jiffies_fqs),
+		       (long)rcu_seq_current(&rcu_state.gp_seq),
+		       data_race(rcu_state.gp_flags),
+		       gp_state_getname(RCU_GP_WAIT_FQS), RCU_GP_WAIT_FQS,
+		       gpk->state);
+		pr_err("\tPossible timer handling issue on cpu=%d timer-softirq=%u\n",
+		       cpu, kstat_softirqs_cpu(TIMER_SOFTIRQ, cpu));
+	}
+}
+
 static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 {
 	int cpu;
@@ -543,6 +573,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 		WRITE_ONCE(rcu_state.jiffies_stall,
 			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
 
+	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
 	panic_on_rcu_stall();
@@ -578,6 +609,7 @@ static void print_cpu_stall(unsigned long gps)
 		jiffies - gps,
 		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
 
+	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
 	rcu_dump_cpu_stacks();
