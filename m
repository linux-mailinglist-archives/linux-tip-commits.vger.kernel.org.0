Return-Path: <linux-tip-commits+bounces-2282-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1780972BD1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 10:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DCE1F23AB6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 08:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02623195FCE;
	Tue, 10 Sep 2024 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gbE+oOWt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zohA1lSv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A57D193085;
	Tue, 10 Sep 2024 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955776; cv=none; b=JVSWX72q3z2LFyhfUsb0hzaXpOLoHJrZ/Mlu4+18VYcPgtXk3+gITYs8wKLeD2KFCfO/9QRvycqsz1yCy+N0u6LGgZYqnqMrI9dqJxDyFhE6936dras4IBV8FsPt1UmrnRfLrS7QKnHb9yx07fI1Oa8ag/1E46SVi4fRubIfkgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955776; c=relaxed/simple;
	bh=XNv4hzJqyiDnUDestUXSJvbu2pxXkBeimo/OqaSEGww=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gu9/A+fV3smk64T+7rqipM/32MQxQTJUSpnufq5eZgZYWzo8iyNwYeH5L6NKf/erikoYHeiQtK+2qgwlnlF4lZ9lnOVeE4JeDzbs/Tn2lCovh+jZE7yawvqu4EHou03FMw7fnDfHSpfntiNf3y5ctZ/DrEiW0SRCC9ywGRvm7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gbE+oOWt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zohA1lSv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 08:09:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725955765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93fjoai9BPs/0H+fmR/E5OGZlTIkiS+SCvr82z/xshQ=;
	b=gbE+oOWtKAisywuNi3a3UJOeR3/14It9nTRb8sivdbHQtkZE1qSatotIfj671jlvwyMSEm
	1B0RIBPEAaCH4xtY0E0h6uJrNm+aBQaebyMgvACvv679bvIVEaVLW/lUoLR2j9PetuN/eh
	Ot+5J90+dS6XYipW8XyN7N69cE4+p205I4SHCBJwmrtklVJEjG6+Cmpp6ABvHMZ9fzcFOV
	ZAu6oeMEYpmo11MwUburZ1uyyLGvzzm+dbZhQDfNa1LjungWeQGAx6XDnlWLPNlRfmbLaB
	IeBtGTQK8rAYXe4+k50v0uUH2CWUrXVvEN/C5tA/F7guClOGrMRsypijom1unQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725955765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93fjoai9BPs/0H+fmR/E5OGZlTIkiS+SCvr82z/xshQ=;
	b=zohA1lSvbZ5SDIU3DY2cSCdhmDq0pSUQlAynKfD/QsJCSXJdhEadmi2jIiy5OBIBRpqFk6
	l7+q95FqCkq9yJBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Introduce SM_IDLE and an idle re-entry
 fast-path in __schedule()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240809092240.6921-1-kprateek.nayak@amd.com>
References: <20240809092240.6921-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172595576493.2215.15007017667071346050.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3dcac251b066b60dba6d44c97d76faeb00bf19c5
Gitweb:        https://git.kernel.org/tip/3dcac251b066b60dba6d44c97d76faeb00bf19c5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 Aug 2024 09:22:40 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 09:51:14 +02:00

sched/core: Introduce SM_IDLE and an idle re-entry fast-path in __schedule()

Since commit b2a02fc43a1f ("smp: Optimize
send_call_function_single_ipi()") an idle CPU in TIF_POLLING_NRFLAG mode
can be pulled out of idle by setting TIF_NEED_RESCHED flag to service an
IPI without actually sending an interrupt. Even in cases where the IPI
handler does not queue a task on the idle CPU, do_idle() will call
__schedule() since need_resched() returns true in these cases.

Introduce and use SM_IDLE to identify call to __schedule() from
schedule_idle() and shorten the idle re-entry time by skipping
pick_next_task() when nr_running is 0 and the previous task is the idle
task.

With the SM_IDLE fast-path, the time taken to complete a fixed set of
IPIs using ipistorm improves noticeably. Following are the numbers
from a dual socket Intel Ice Lake Xeon server (2 x 32C/64T) and
3rd Generation AMD EPYC system (2 x 64C/128T) (boost on, C2 disabled)
running ipistorm between CPU8 and CPU16:

cmdline: insmod ipistorm.ko numipi=100000 single=1 offset=8 cpulist=8 wait=1

   ==================================================================
   Test          : ipistorm (modified)
   Units         : Normalized runtime
   Interpretation: Lower is better
   Statistic     : AMean
   ======================= Intel Ice Lake Xeon ======================
   kernel:				time [pct imp]
   tip:sched/core			1.00 [baseline]
   tip:sched/core + SM_IDLE		0.80 [20.51%]
   ==================== 3rd Generation AMD EPYC =====================
   kernel:				time [pct imp]
   tip:sched/core			1.00 [baseline]
   tip:sched/core + SM_IDLE		0.90 [10.17%]
   ==================================================================

[ kprateek: Commit message, SM_RTLOCK_WAIT fix ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240809092240.6921-1-kprateek.nayak@amd.com
---
 kernel/sched/core.c | 45 +++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ffcd637..2922fac 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6410,19 +6410,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  * Constants for the sched_mode argument of __schedule().
  *
  * The mode argument allows RT enabled kernels to differentiate a
- * preemption from blocking on an 'sleeping' spin/rwlock. Note that
- * SM_MASK_PREEMPT for !RT has all bits set, which allows the compiler to
- * optimize the AND operation out and just check for zero.
+ * preemption from blocking on an 'sleeping' spin/rwlock.
  */
-#define SM_NONE			0x0
-#define SM_PREEMPT		0x1
-#define SM_RTLOCK_WAIT		0x2
-
-#ifndef CONFIG_PREEMPT_RT
-# define SM_MASK_PREEMPT	(~0U)
-#else
-# define SM_MASK_PREEMPT	SM_PREEMPT
-#endif
+#define SM_IDLE			(-1)
+#define SM_NONE			0
+#define SM_PREEMPT		1
+#define SM_RTLOCK_WAIT		2
 
 /*
  * __schedule() is the main scheduler function.
@@ -6463,9 +6456,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  *
  * WARNING: must be called with preemption disabled!
  */
-static void __sched notrace __schedule(unsigned int sched_mode)
+static void __sched notrace __schedule(int sched_mode)
 {
 	struct task_struct *prev, *next;
+	/*
+	 * On PREEMPT_RT kernel, SM_RTLOCK_WAIT is noted
+	 * as a preemption by schedule_debug() and RCU.
+	 */
+	bool preempt = sched_mode > SM_NONE;
 	unsigned long *switch_count;
 	unsigned long prev_state;
 	struct rq_flags rf;
@@ -6476,13 +6474,13 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	rq = cpu_rq(cpu);
 	prev = rq->curr;
 
-	schedule_debug(prev, !!sched_mode);
+	schedule_debug(prev, preempt);
 
 	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
 		hrtick_clear(rq);
 
 	local_irq_disable();
-	rcu_note_context_switch(!!sched_mode);
+	rcu_note_context_switch(preempt);
 
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
@@ -6511,12 +6509,20 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 
 	switch_count = &prev->nivcsw;
 
+	/* Task state changes only considers SM_PREEMPT as preemption */
+	preempt = sched_mode == SM_PREEMPT;
+
 	/*
 	 * We must load prev->state once (task_struct::state is volatile), such
 	 * that we form a control dependency vs deactivate_task() below.
 	 */
 	prev_state = READ_ONCE(prev->__state);
-	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
+	if (sched_mode == SM_IDLE) {
+		if (!rq->nr_running) {
+			next = prev;
+			goto picked;
+		}
+	} else if (!preempt && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
 			WRITE_ONCE(prev->__state, TASK_RUNNING);
 		} else {
@@ -6547,6 +6553,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	}
 
 	next = pick_next_task(rq, prev, &rf);
+picked:
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
@@ -6588,7 +6595,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		psi_account_irqtime(rq, prev, next);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
-		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
+		trace_sched_switch(preempt, prev, next, prev_state);
 
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
@@ -6664,7 +6671,7 @@ static void sched_update_worker(struct task_struct *tsk)
 	}
 }
 
-static __always_inline void __schedule_loop(unsigned int sched_mode)
+static __always_inline void __schedule_loop(int sched_mode)
 {
 	do {
 		preempt_disable();
@@ -6709,7 +6716,7 @@ void __sched schedule_idle(void)
 	 */
 	WARN_ON_ONCE(current->__state);
 	do {
-		__schedule(SM_NONE);
+		__schedule(SM_IDLE);
 	} while (need_resched());
 }
 

