Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019CD32F9F4
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCFLmb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34268 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhCFLmW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:22 -0500
Date:   Sat, 06 Mar 2021 11:42:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030940;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TEGHZCNfMOmRTb0fhQ3fON6Fr5t1Etlx15m9W8M1I/U=;
        b=om4R5608TKgblJdAupfO/ia2aoX8PT/3WEEAhPM5DQuftaWvWeJ9562DPvmDmQ6klwIzo5
        GVGmQ4CdSGSmiFLsj4AVkcSDFNT8figJ4NG4okoF4QzaQCQyWY+7/dZkstBoLdA3YsbiGS
        HEho+pSk8R8N4R151t8pSSVlk7mlTsxwISDKA0MBbAZk/jMIk79dW7wBKEZ0pksQ0TewTO
        ZovEm3JnrwQLugG3vnJ0EsfXEKlp2ujKMhUadXOH9I0uBEqpXvBIWHWWQLehbB7ulo8vRS
        1n1jGk5NZBCR00NToAZ7hIXrFBfMq3pnGNEH/TUz0v1T7Lcs/BV2+GVMcc0tyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030940;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TEGHZCNfMOmRTb0fhQ3fON6Fr5t1Etlx15m9W8M1I/U=;
        b=3LrYlOnsVvnUFkl3JuDKGYxbhv+YPHXD50oXJ1unR5w0/JMnynmpijmF4knGkyn8Nvokju
        Wl3tZHkfv2VnECCA==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpu/hotplug: Add cpuhp_invoke_callback_range()
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210216103506.416286-4-vincent.donnefort@arm.com>
References: <20210216103506.416286-4-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <161503093994.398.3203177270870536065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     453e41085183980087f8a80dada523caf1131c3c
Gitweb:        https://git.kernel.org/tip/453e41085183980087f8a80dada523caf1131c3c
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Tue, 16 Feb 2021 10:35:06 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:22 +01:00

cpu/hotplug: Add cpuhp_invoke_callback_range()

Factorizing and unifying cpuhp callback range invocations, especially for
the hotunplug path, where two different ways of decrementing were used. The
first one, decrements before the callback is called:

 cpuhp_thread_fun()
     state = st->state;
     st->state--;
     cpuhp_invoke_callback(state);

The second one, after:

 take_down_cpu()|cpuhp_down_callbacks()
     cpuhp_invoke_callback(st->state);
     st->state--;

This is problematic for rolling back the steps in case of error, as
depending on the decrement, the rollback will start from N or N-1. It also
makes tracing inconsistent, between steps run in the cpuhp thread and
the others.

Additionally, avoid useless cpuhp_thread_fun() loops by skipping empty
steps.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20210216103506.416286-4-vincent.donnefort@arm.com
---
 kernel/cpu.c | 170 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 102 insertions(+), 68 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 680ed8f..23505d6 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -135,6 +135,11 @@ static struct cpuhp_step *cpuhp_get_step(enum cpuhp_state state)
 	return cpuhp_hp_states + state;
 }
 
+static bool cpuhp_step_empty(bool bringup, struct cpuhp_step *step)
+{
+	return bringup ? !step->startup.single : !step->teardown.single;
+}
+
 /**
  * cpuhp_invoke_callback _ Invoke the callbacks for a given state
  * @cpu:	The cpu for which the callback should be invoked
@@ -157,26 +162,24 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 
 	if (st->fail == state) {
 		st->fail = CPUHP_INVALID;
-
-		if (!(bringup ? step->startup.single : step->teardown.single))
-			return 0;
-
 		return -EAGAIN;
 	}
 
+	if (cpuhp_step_empty(bringup, step)) {
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
 	if (!step->multi_instance) {
 		WARN_ON_ONCE(lastp && *lastp);
 		cb = bringup ? step->startup.single : step->teardown.single;
-		if (!cb)
-			return 0;
+
 		trace_cpuhp_enter(cpu, st->target, state, cb);
 		ret = cb(cpu);
 		trace_cpuhp_exit(cpu, st->state, state, ret);
 		return ret;
 	}
 	cbm = bringup ? step->startup.multi : step->teardown.multi;
-	if (!cbm)
-		return 0;
 
 	/* Single invocation for instance add/remove */
 	if (node) {
@@ -475,6 +478,15 @@ cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
 static inline void
 cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
 {
+	st->target = prev_state;
+
+	/*
+	 * Already rolling back. No need invert the bringup value or to change
+	 * the current state.
+	 */
+	if (st->rollback)
+		return;
+
 	st->rollback = true;
 
 	/*
@@ -488,7 +500,6 @@ cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
 			st->state++;
 	}
 
-	st->target = prev_state;
 	st->bringup = !st->bringup;
 }
 
@@ -591,10 +602,53 @@ static int finish_cpu(unsigned int cpu)
  * Hotplug state machine related functions
  */
 
-static void undo_cpu_up(unsigned int cpu, struct cpuhp_cpu_state *st)
+/*
+ * Get the next state to run. Empty ones will be skipped. Returns true if a
+ * state must be run.
+ *
+ * st->state will be modified ahead of time, to match state_to_run, as if it
+ * has already ran.
+ */
+static bool cpuhp_next_state(bool bringup,
+			     enum cpuhp_state *state_to_run,
+			     struct cpuhp_cpu_state *st,
+			     enum cpuhp_state target)
 {
-	for (st->state--; st->state > st->target; st->state--)
-		cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
+	do {
+		if (bringup) {
+			if (st->state >= target)
+				return false;
+
+			*state_to_run = ++st->state;
+		} else {
+			if (st->state <= target)
+				return false;
+
+			*state_to_run = st->state--;
+		}
+
+		if (!cpuhp_step_empty(bringup, cpuhp_get_step(*state_to_run)))
+			break;
+	} while (true);
+
+	return true;
+}
+
+static int cpuhp_invoke_callback_range(bool bringup,
+				       unsigned int cpu,
+				       struct cpuhp_cpu_state *st,
+				       enum cpuhp_state target)
+{
+	enum cpuhp_state state;
+	int err = 0;
+
+	while (cpuhp_next_state(bringup, &state, st, target)) {
+		err = cpuhp_invoke_callback(cpu, state, bringup, NULL, NULL);
+		if (err)
+			break;
+	}
+
+	return err;
 }
 
 static inline bool can_rollback_cpu(struct cpuhp_cpu_state *st)
@@ -617,16 +671,12 @@ static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 	enum cpuhp_state prev_state = st->state;
 	int ret = 0;
 
-	while (st->state < target) {
-		st->state++;
-		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
-		if (ret) {
-			if (can_rollback_cpu(st)) {
-				st->target = prev_state;
-				undo_cpu_up(cpu, st);
-			}
-			break;
-		}
+	ret = cpuhp_invoke_callback_range(true, cpu, st, target);
+	if (ret) {
+		cpuhp_reset_state(st, prev_state);
+		if (can_rollback_cpu(st))
+			WARN_ON(cpuhp_invoke_callback_range(false, cpu, st,
+							    prev_state));
 	}
 	return ret;
 }
@@ -690,17 +740,9 @@ static void cpuhp_thread_fun(unsigned int cpu)
 		state = st->cb_state;
 		st->should_run = false;
 	} else {
-		if (bringup) {
-			st->state++;
-			state = st->state;
-			st->should_run = (st->state < st->target);
-			WARN_ON_ONCE(st->state > st->target);
-		} else {
-			state = st->state;
-			st->state--;
-			st->should_run = (st->state > st->target);
-			WARN_ON_ONCE(st->state < st->target);
-		}
+		st->should_run = cpuhp_next_state(bringup, &state, st, st->target);
+		if (!st->should_run)
+			goto end;
 	}
 
 	WARN_ON_ONCE(!cpuhp_is_ap_state(state));
@@ -728,6 +770,7 @@ static void cpuhp_thread_fun(unsigned int cpu)
 		st->should_run = false;
 	}
 
+end:
 	cpuhp_lock_release(bringup);
 	lockdep_release_cpus_lock();
 
@@ -881,19 +924,18 @@ static int take_cpu_down(void *_param)
 		return err;
 
 	/*
-	 * We get here while we are in CPUHP_TEARDOWN_CPU state and we must not
-	 * do this step again.
+	 * Must be called from CPUHP_TEARDOWN_CPU, which means, as we are going
+	 * down, that the current state is CPUHP_TEARDOWN_CPU - 1.
 	 */
-	WARN_ON(st->state != CPUHP_TEARDOWN_CPU);
-	st->state--;
+	WARN_ON(st->state != (CPUHP_TEARDOWN_CPU - 1));
+
 	/* Invoke the former CPU_DYING callbacks */
-	for (; st->state > target; st->state--) {
-		ret = cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
-		/*
-		 * DYING must not fail!
-		 */
-		WARN_ON_ONCE(ret);
-	}
+	ret = cpuhp_invoke_callback_range(false, cpu, st, target);
+
+	/*
+	 * DYING must not fail!
+	 */
+	WARN_ON_ONCE(ret);
 
 	/* Give up timekeeping duties */
 	tick_handover_do_timer();
@@ -975,27 +1017,22 @@ void cpuhp_report_idle_dead(void)
 				 cpuhp_complete_idle_dead, st, 0);
 }
 
-static void undo_cpu_down(unsigned int cpu, struct cpuhp_cpu_state *st)
-{
-	for (st->state++; st->state < st->target; st->state++)
-		cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
-}
-
 static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 				enum cpuhp_state target)
 {
 	enum cpuhp_state prev_state = st->state;
 	int ret = 0;
 
-	for (; st->state > target; st->state--) {
-		ret = cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
-		if (ret) {
-			st->target = prev_state;
-			if (st->state < prev_state)
-				undo_cpu_down(cpu, st);
-			break;
-		}
+	ret = cpuhp_invoke_callback_range(false, cpu, st, target);
+	if (ret) {
+
+		cpuhp_reset_state(st, prev_state);
+
+		if (st->state < prev_state)
+			WARN_ON(cpuhp_invoke_callback_range(true, cpu, st,
+							    prev_state));
 	}
+
 	return ret;
 }
 
@@ -1168,14 +1205,12 @@ void notify_cpu_starting(unsigned int cpu)
 
 	rcu_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
 	cpumask_set_cpu(cpu, &cpus_booted_once_mask);
-	while (st->state < target) {
-		st->state++;
-		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
-		/*
-		 * STARTING must not fail!
-		 */
-		WARN_ON_ONCE(ret);
-	}
+	ret = cpuhp_invoke_callback_range(true, cpu, st, target);
+
+	/*
+	 * STARTING must not fail!
+	 */
+	WARN_ON_ONCE(ret);
 }
 
 /*
@@ -1781,8 +1816,7 @@ static int cpuhp_issue_call(int cpu, enum cpuhp_state state, bool bringup,
 	 * If there's nothing to do, we done.
 	 * Relies on the union for multi_instance.
 	 */
-	if ((bringup && !sp->startup.single) ||
-	    (!bringup && !sp->teardown.single))
+	if (cpuhp_step_empty(bringup, sp))
 		return 0;
 	/*
 	 * The non AP bound callbacks can fail on bringup. On teardown
