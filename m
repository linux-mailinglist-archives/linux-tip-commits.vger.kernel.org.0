Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD3E32C7A0
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359611AbhCDAcX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842993AbhCCKX3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB1EC08EBAC;
        Wed,  3 Mar 2021 01:49:37 -0800 (PST)
Date:   Wed, 03 Mar 2021 09:49:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614764975;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MOTr5sCmcXgtMdq/Wpv1w5JtftZQLlg60TsCtDQxW30=;
        b=cVcqMXc8w5tk6YcDtz9lI+3z6MF0/wTo0eN86H+oELnIHfOPiDxyd9rcykTMt3QAeqEgDv
        qZHFabl4hnN2gR8WdcUBJROAMW/hGkvXtBvetBhfdcH5wvkRQJirsLwvCUwLiAtDOGcrdt
        5N368MgRfC6Hx9iz/qDYN1vMSoCHuTn8jCRZPAf8Q4Mn3XgBsxoYQtAOLv4yT97E47tZUm
        tLryHl8auVRmHJLvr8h+ip0+rilapy2uYNEYVGc3tapOX/jWmhjYk8g0yLjQ2yR4KSVnF8
        1yO8V9dPekhGoN3XUM7Lp0S6AFSBoYqKmF1u62uXHeJN3P1cApkBuH+xcMqCtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614764975;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MOTr5sCmcXgtMdq/Wpv1w5JtftZQLlg60TsCtDQxW30=;
        b=36Z3nC5yuDuJoUV8iRJyIWWMKSV078gP8SPiXAFmzI0+T+3q2O0hPBLq9m4T7hmIvtKjeg
        BV9FCFfk2+hgeiDw==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpu/hotplug: Add cpuhp_invoke_callback_range()
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210216103506.416286-4-vincent.donnefort@arm.com>
References: <20210216103506.416286-4-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <161476497438.20312.6267336240400916329.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8b89220650146d59e9a8af2e5f12fc582539609e
Gitweb:        https://git.kernel.org/tip/8b89220650146d59e9a8af2e5f12fc582539609e
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Tue, 16 Feb 2021 10:35:06 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 10:33:00 +01:00

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
