Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B123EF373
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbhHQUPj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34954 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbhHQUPJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:09 -0400
Date:   Tue, 17 Aug 2021 20:14:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231275;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HRrjx/pjxJ3o1b5kaZWrME7gwwp1QWS20ueBJ8FJVrE=;
        b=s54SItZ2BUI5MZchQPywTQ9moc15v0UBxTVCknQZdTto92hEbCEFu+jO8IgYq3yiecYjOL
        zGMybHVuYyM3CbwBudYAfzOvVgS/cPqjfpaUiiA7yEGEa7kkNu5o5p2KagEPu27qfMVfi+
        yZbrAI99XWD7eEWiWE5xSAbOWhEsblbVKbpVnBEwz6hieRWVaMbtiRlkMmsKJKDTvPyKVi
        bupgTxssQjObmM1tMEXUlShLVmLDKt97KQi7qgcq4R9PbBHhCmUmYfeeqc9eHHg31xavB9
        Co0sX1m0NQS2dfYM1aJdXcwoU5i9pH+VB9maJwvNujnllkTbzngU81NAiQY+Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231275;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HRrjx/pjxJ3o1b5kaZWrME7gwwp1QWS20ueBJ8FJVrE=;
        b=r+/OIdGyvTesuAcTCkSMFSTDy/3Q96JITT6g8SzWwn5V96+BkrX/1pPe2ILL6dY1tENNEn
        nSOR/nRxj5FKt3AA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched/core: Rework the __schedule() preempt argument
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211302.315473019@linutronix.de>
References: <20210815211302.315473019@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923127466.25758.3236926605858960727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b4bfa3fcfe3b827ddb8b16edd45896caac5a1194
Gitweb:        https://git.kernel.org/tip/b4bfa3fcfe3b827ddb8b16edd45896caac5a1194
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:27:46 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 16:53:43 +02:00

sched/core: Rework the __schedule() preempt argument

PREEMPT_RT needs to hand a special state into __schedule() when a task
blocks on a 'sleeping' spin/rwlock. This is required to handle
rcu_note_context_switch() correctly without having special casing in the
RCU code. From an RCU point of view the blocking on the sleeping spinlock
is equivalent to preemption, because the task might be in a read side
critical section.

schedule_debug() also has a check which would trigger with the !preempt
case, but that could be handled differently.

To avoid adding another argument and extra checks which cannot be optimized
out by the compiler, the following solution has been chosen:

 - Replace the boolean 'preempt' argument with an unsigned integer
   'sched_mode' argument and define constants to hand in:
   (0 == no preemption, 1 = preemption).

 - Add two masks to apply on that mode: one for the debug/rcu invocations,
   and one for the actual scheduling decision.

   For a non RT kernel these masks are UINT_MAX, i.e. all bits are set,
   which allows the compiler to optimize the AND operation out, because it is
   not masking out anything. IOW, it's not different from the boolean.

   RT enabled kernels will define these masks separately.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211302.315473019@linutronix.de
---
 kernel/sched/core.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e407c6a..ebc24e1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5820,6 +5820,18 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 #endif /* CONFIG_SCHED_CORE */
 
 /*
+ * Constants for the sched_mode argument of __schedule().
+ *
+ * The mode argument allows RT enabled kernels to differentiate a
+ * preemption from blocking on an 'sleeping' spin/rwlock. Note that
+ * SM_MASK_PREEMPT for !RT has all bits set, which allows the compiler to
+ * optimize the AND operation out and just check for zero.
+ */
+#define SM_NONE			0x0
+#define SM_PREEMPT		0x1
+#define SM_MASK_PREEMPT		(~0U)
+
+/*
  * __schedule() is the main scheduler function.
  *
  * The main means of driving the scheduler and thus entering this function are:
@@ -5858,7 +5870,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  *
  * WARNING: must be called with preemption disabled!
  */
-static void __sched notrace __schedule(bool preempt)
+static void __sched notrace __schedule(unsigned int sched_mode)
 {
 	struct task_struct *prev, *next;
 	unsigned long *switch_count;
@@ -5871,13 +5883,13 @@ static void __sched notrace __schedule(bool preempt)
 	rq = cpu_rq(cpu);
 	prev = rq->curr;
 
-	schedule_debug(prev, preempt);
+	schedule_debug(prev, !!sched_mode);
 
 	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
 		hrtick_clear(rq);
 
 	local_irq_disable();
-	rcu_note_context_switch(preempt);
+	rcu_note_context_switch(!!sched_mode);
 
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
@@ -5911,7 +5923,7 @@ static void __sched notrace __schedule(bool preempt)
 	 *  - ptrace_{,un}freeze_traced() can change ->state underneath us.
 	 */
 	prev_state = READ_ONCE(prev->__state);
-	if (!preempt && prev_state) {
+	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
 			WRITE_ONCE(prev->__state, TASK_RUNNING);
 		} else {
@@ -5977,7 +5989,7 @@ static void __sched notrace __schedule(bool preempt)
 		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
-		trace_sched_switch(preempt, prev, next);
+		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next);
 
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
@@ -5998,7 +6010,7 @@ void __noreturn do_task_dead(void)
 	/* Tell freezer to ignore us: */
 	current->flags |= PF_NOFREEZE;
 
-	__schedule(false);
+	__schedule(SM_NONE);
 	BUG();
 
 	/* Avoid "noreturn function does return" - but don't continue if BUG() is a NOP: */
@@ -6059,7 +6071,7 @@ asmlinkage __visible void __sched schedule(void)
 	sched_submit_work(tsk);
 	do {
 		preempt_disable();
-		__schedule(false);
+		__schedule(SM_NONE);
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
 	sched_update_worker(tsk);
@@ -6087,7 +6099,7 @@ void __sched schedule_idle(void)
 	 */
 	WARN_ON_ONCE(current->__state);
 	do {
-		__schedule(false);
+		__schedule(SM_NONE);
 	} while (need_resched());
 }
 
@@ -6140,7 +6152,7 @@ static void __sched notrace preempt_schedule_common(void)
 		 */
 		preempt_disable_notrace();
 		preempt_latency_start(1);
-		__schedule(true);
+		__schedule(SM_PREEMPT);
 		preempt_latency_stop(1);
 		preempt_enable_no_resched_notrace();
 
@@ -6219,7 +6231,7 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 		 * an infinite recursion.
 		 */
 		prev_ctx = exception_enter();
-		__schedule(true);
+		__schedule(SM_PREEMPT);
 		exception_exit(prev_ctx);
 
 		preempt_latency_stop(1);
@@ -6368,7 +6380,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 	do {
 		preempt_disable();
 		local_irq_enable();
-		__schedule(true);
+		__schedule(SM_PREEMPT);
 		local_irq_disable();
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
