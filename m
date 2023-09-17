Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753347A3519
	for <lists+linux-tip-commits@lfdr.de>; Sun, 17 Sep 2023 12:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjIQKMo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 17 Sep 2023 06:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbjIQKMR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 17 Sep 2023 06:12:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA18194;
        Sun, 17 Sep 2023 03:12:09 -0700 (PDT)
Date:   Sun, 17 Sep 2023 10:12:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694945528;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xhrmml/XT//T5aROH913b4M+nVsI20VVCJhzlqLFV0Y=;
        b=kULh8OIlIr4wo5pfu1ejPwJacKEV6SCaZ6jXCyxxpPFdUbokyFYu6SO1wixo1DnbnbRu5X
        9GKF6uVndkUyFCnvqs7h9lxAYrfjTWv6W5flf4O3Z4R5yGDztPun5DTy4xGlizNvwoFkKM
        7HAPNr8Wm6WAzsIz47hlDBti7Cx0w9N5fdHq7f9QTFwKkUIukdFWhhTU8fRbvEHFJdNKjs
        AoDAGFO2KzhyeDxgKOLkt2MT6362jdI03voz9wTIG3DR7gPe4u9FgDNN2deoHSAwTiadvT
        WLxPzp5sJtH9SC1xIOtvFk3829bRE4gwIgD//yyQ7jR8QtjaWwP0wyBOJI+0lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694945528;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xhrmml/XT//T5aROH913b4M+nVsI20VVCJhzlqLFV0Y=;
        b=/FGpHm6tXKjLCrY6kiDXGXrh139kMmlA13jpXeqOft7Wq1b3o09RzSMC9tr/JpCdHOrdpf
        PM5DTDaIYMEmWsAA==
From:   "tip-bot2 for Elliot Berman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] freezer,sched: Use saved_state to reduce some
 spurious wakeups
Cc:     Prakash Viswalingam <quic_prakashv@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169494552740.27769.11220243181597792209.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e4d93065a5085dbb862aa4bd06fb3e51b02e8857
Gitweb:        https://git.kernel.org/tip/e4d93065a5085dbb862aa4bd06fb3e51b02e8857
Author:        Elliot Berman <quic_eberman@quicinc.com>
AuthorDate:    Fri, 08 Sep 2023 15:49:16 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 16 Sep 2023 11:16:02 +02:00

freezer,sched: Use saved_state to reduce some spurious wakeups

After commit f5d39b020809 ("freezer,sched: Rewrite core freezer logic"),
tasks that transition directly from TASK_FREEZABLE to TASK_FROZEN  are
always woken up on the thaw path. Prior to that commit, tasks could ask
freezer to consider them "frozen enough" via freezer_do_not_count(). The
commit replaced freezer_do_not_count() with a TASK_FREEZABLE state which
allows freezer to immediately mark the task as TASK_FROZEN without
waking up the task.  This is efficient for the suspend path, but on the
thaw path, the task is always woken up even if the task didn't need to
wake up and goes back to its TASK_(UN)INTERRUPTIBLE state. Although
these tasks are capable of handling of the wakeup, we can observe a
power/perf impact from the extra wakeup.

We observed on Android many tasks wait in the TASK_FREEZABLE state
(particularly due to many of them being binder clients). We observed
nearly 4x the number of tasks and a corresponding linear increase in
latency and power consumption when thawing the system. The latency
increased from ~15ms to ~50ms.

Avoid the spurious wakeups by saving the state of TASK_FREEZABLE tasks.
If the task was running before entering TASK_FROZEN state
(__refrigerator()) or if the task received a wake up for the saved
state, then the task is woken on thaw. saved_state from PREEMPT_RT locks
can be re-used because freezer would not stomp on the rtlock wait flow:
TASK_RTLOCK_WAIT isn't considered freezable.

Reported-by: Prakash Viswalingam <quic_prakashv@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 kernel/freezer.c    | 41 +++++++++++++++++++----------------------
 kernel/sched/core.c | 23 ++++++++++++++---------
 2 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index 4fad0e6..c450fa8 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -71,7 +71,11 @@ bool __refrigerator(bool check_kthr_stop)
 	for (;;) {
 		bool freeze;
 
+		raw_spin_lock_irq(&current->pi_lock);
 		set_current_state(TASK_FROZEN);
+		/* unstale saved_state so that __thaw_task() will wake us up */
+		current->saved_state = TASK_RUNNING;
+		raw_spin_unlock_irq(&current->pi_lock);
 
 		spin_lock_irq(&freezer_lock);
 		freeze = freezing(current) && !(check_kthr_stop && kthread_should_stop());
@@ -129,6 +133,7 @@ static int __set_task_frozen(struct task_struct *p, void *arg)
 		WARN_ON_ONCE(debug_locks && p->lockdep_depth);
 #endif
 
+	p->saved_state = p->__state;
 	WRITE_ONCE(p->__state, TASK_FROZEN);
 	return TASK_FROZEN;
 }
@@ -170,42 +175,34 @@ bool freeze_task(struct task_struct *p)
 }
 
 /*
- * The special task states (TASK_STOPPED, TASK_TRACED) keep their canonical
- * state in p->jobctl. If either of them got a wakeup that was missed because
- * TASK_FROZEN, then their canonical state reflects that and the below will
- * refuse to restore the special state and instead issue the wakeup.
+ * Restore the saved_state before the task entered freezer. For typical task
+ * in the __refrigerator(), saved_state == TASK_RUNNING so nothing happens
+ * here. For tasks which were TASK_NORMAL | TASK_FREEZABLE, their initial state
+ * is restored unless they got an expected wakeup (see ttwu_state_match()).
+ * Returns 1 if the task state was restored.
  */
-static int __set_task_special(struct task_struct *p, void *arg)
+static int __restore_freezer_state(struct task_struct *p, void *arg)
 {
-	unsigned int state = 0;
+	unsigned int state = p->saved_state;
 
-	if (p->jobctl & JOBCTL_TRACED)
-		state = TASK_TRACED;
-
-	else if (p->jobctl & JOBCTL_STOPPED)
-		state = TASK_STOPPED;
-
-	if (state)
+	if (state != TASK_RUNNING) {
 		WRITE_ONCE(p->__state, state);
+		return 1;
+	}
 
-	return state;
+	return 0;
 }
 
 void __thaw_task(struct task_struct *p)
 {
-	unsigned long flags, flags2;
+	unsigned long flags;
 
 	spin_lock_irqsave(&freezer_lock, flags);
 	if (WARN_ON_ONCE(freezing(p)))
 		goto unlock;
 
-	if (lock_task_sighand(p, &flags2)) {
-		/* TASK_FROZEN -> TASK_{STOPPED,TRACED} */
-		bool ret = task_call_func(p, __set_task_special, NULL);
-		unlock_task_sighand(p, &flags2);
-		if (ret)
-			goto unlock;
-	}
+	if (task_call_func(p, __restore_freezer_state, NULL))
+		goto unlock;
 
 	wake_up_state(p, TASK_FROZEN);
 unlock:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 49541e3..5a50c4e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2242,8 +2242,8 @@ static __always_inline
 int task_state_match(struct task_struct *p, unsigned int state)
 {
 	/*
-	 * Serialize against current_save_and_set_rtlock_wait_state() and
-	 * current_restore_rtlock_saved_state().
+	 * Serialize against current_save_and_set_rtlock_wait_state(),
+	 * current_restore_rtlock_saved_state(), and __refrigerator().
 	 */
 	guard(raw_spinlock_irq)(&p->pi_lock);
 	return __task_state_match(p, state);
@@ -4015,13 +4015,17 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
  * The caller holds p::pi_lock if p != current or has preemption
  * disabled when p == current.
  *
- * The rules of PREEMPT_RT saved_state:
+ * The rules of saved_state:
  *
  *   The related locking code always holds p::pi_lock when updating
  *   p::saved_state, which means the code is fully serialized in both cases.
  *
- *   The lock wait and lock wakeups happen via TASK_RTLOCK_WAIT. No other
- *   bits set. This allows to distinguish all wakeup scenarios.
+ *   For PREEMPT_RT, the lock wait and lock wakeups happen via TASK_RTLOCK_WAIT.
+ *   No other bits set. This allows to distinguish all wakeup scenarios.
+ *
+ *   For FREEZER, the wakeup happens via TASK_FROZEN. No other bits set. This
+ *   allows us to prevent early wakeup of tasks before they can be run on
+ *   asymmetric ISA architectures (eg ARMv9).
  */
 static __always_inline
 bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
@@ -4037,10 +4041,11 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 
 	/*
 	 * Saved state preserves the task state across blocking on
-	 * an RT lock.  If the state matches, set p::saved_state to
-	 * TASK_RUNNING, but do not wake the task because it waits
-	 * for a lock wakeup. Also indicate success because from
-	 * the regular waker's point of view this has succeeded.
+	 * an RT lock or TASK_FREEZABLE tasks.  If the state matches,
+	 * set p::saved_state to TASK_RUNNING, but do not wake the task
+	 * because it waits for a lock wakeup or __thaw_task(). Also
+	 * indicate success because from the regular waker's point of
+	 * view this has succeeded.
 	 *
 	 * After acquiring the lock the task will restore p::__state
 	 * from p::saved_state which ensures that the regular
