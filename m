Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC7F3EF372
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhHQUPi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34996 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbhHQUPM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:12 -0400
Date:   Tue, 17 Aug 2021 20:14:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231277;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/UUXL3ZbvEGTzEyGMRyI4OWP11PNQKuJE5fPnk+4GU=;
        b=NAbmw8eWRy2mDwcRAfn5N6d65+gmy6oxWY86LcWIZgdUvOceL+DqfYoNJs5fU9UMppOmFG
        vpV0LLHeWOoyAGaTpYN2J9mE5XsY/AzkIGze+qLeHNynmclCpbShbv4BUbtcQZqWw9+ZMM
        vuafd+8BeMhVBxblWq0mhoOTnTcB/R27dK+ZltVrtodI0bhFSgZWn0xZA9jOSUNv9hcOpa
        Rq/bQtolJ6FR1o38kNh2s3tUhLuYVeKlevmqgSkEq8sPxdc28jmTDg4Si9AjI0hepqd9aF
        ucv99/zkIB0O+6STzkFTuy3CkwVaRpxfl9IO02bwB7Cg1qlZlS+39ACZ30I1aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231277;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/UUXL3ZbvEGTzEyGMRyI4OWP11PNQKuJE5fPnk+4GU=;
        b=StTaqJtPmKRMeym7HVhlOVM2L0y7HDtNqq8tEBHrYDrOPgmu9ZbKfRbjjAbXqZ7lRaRQb7
        Y4HLVWqNiLJq9LCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched/wakeup: Split out the wakeup ->__state check
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211302.088945085@linutronix.de>
References: <20210815211302.088945085@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923127706.25758.7582470982975216736.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     43295d73adc8d3780e9f34206663e336678aaff8
Gitweb:        https://git.kernel.org/tip/43295d73adc8d3780e9f34206663e336678aaff8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:27:40 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 16:40:54 +02:00

sched/wakeup: Split out the wakeup ->__state check

RT kernels have a slightly more complicated handling of wakeups due to
'sleeping' spin/rwlocks. If a task is blocked on such a lock then the
original state of the task is preserved over the blocking period, and
any regular (non lock related) wakeup has to be targeted at the
saved state to ensure that these wakeups are not lost.

Once the task acquires the lock it restores the task state from the saved state.

To avoid cluttering try_to_wake_up() with that logic, split the wakeup
state check out into an inline helper and use it at both places where
task::__state is checked against the state argument of try_to_wake_up().

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211302.088945085@linutronix.de
---
 kernel/sched/core.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 20ffcc0..961991e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3562,6 +3562,22 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
 }
 
 /*
+ * Invoked from try_to_wake_up() to check whether the task can be woken up.
+ *
+ * The caller holds p::pi_lock if p != current or has preemption
+ * disabled when p == current.
+ */
+static __always_inline
+bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
+{
+	if (READ_ONCE(p->__state) & state) {
+		*success = 1;
+		return true;
+	}
+	return false;
+}
+
+/*
  * Notes on Program-Order guarantees on SMP systems.
  *
  *  MIGRATION
@@ -3700,10 +3716,9 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		 *  - we're serialized against set_special_state() by virtue of
 		 *    it disabling IRQs (this allows not taking ->pi_lock).
 		 */
-		if (!(READ_ONCE(p->__state) & state))
+		if (!ttwu_state_match(p, state, &success))
 			goto out;
 
-		success = 1;
 		trace_sched_waking(p);
 		WRITE_ONCE(p->__state, TASK_RUNNING);
 		trace_sched_wakeup(p);
@@ -3718,14 +3733,11 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 */
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 	smp_mb__after_spinlock();
-	if (!(READ_ONCE(p->__state) & state))
+	if (!ttwu_state_match(p, state, &success))
 		goto unlock;
 
 	trace_sched_waking(p);
 
-	/* We're going to change ->state: */
-	success = 1;
-
 	/*
 	 * Ensure we load p->on_rq _after_ p->state, otherwise it would
 	 * be possible to, falsely, observe p->on_rq == 0 and get stuck
