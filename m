Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB73337F883
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 15:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbhEMNT2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 13 May 2021 09:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbhEMNSp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 13 May 2021 09:18:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F08BC06174A;
        Thu, 13 May 2021 06:17:29 -0700 (PDT)
Date:   Thu, 13 May 2021 13:17:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620911848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMc8ViLxcJqGDbfDniJ05oRZr8C01Yj2YoQakOu6Beo=;
        b=pQETw5bDcFuPc2lP9GSHikcqpZ61dFzZ8x1Gkhlbl0vSpEySzJxA/dDpe4TBA8mkpa3vag
        sg0szwagTaqbFFIF59Z4nnQ5kkSoZdnqn5JLH5tvFVhJBlS84vGZ33FOCpP3LBzoGo134j
        jtXJo1mF1wkJAhp598+iUPVRlC++NI7knsLw1QShTVa3dArSVxi8RvOkW48dfHPL70teBH
        lF0Ug0RGBarxkPKAuJAJCH3cRWD+Ss+tVvVqoXbZIwavpOJQOUucxsufUGM+Rj3gjxXovf
        ElSaGZ8IZAGsSUeV5HEuRVEsalnfAeOaXnMDe6ix3Q2RB7MgtrBTZ53H94WX7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620911848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMc8ViLxcJqGDbfDniJ05oRZr8C01Yj2YoQakOu6Beo=;
        b=nK8HRs63w49DtWjX+5zFK6JEL6nXklqHmkZqzK/b7N+qSyW2E/3/QFzpKuk0kjhaeS4AH7
        ke7WuP3vy6SUJlDA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/nohz] tick/nohz: Only wake up a single target cpu when
 kicking a task
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210512232924.150322-7-frederic@kernel.org>
References: <20210512232924.150322-7-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162091184780.29796.751845297099091276.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/nohz branch of tip:

Commit-ID:     29721b859217b946bfc001c1644745ed4d7c26cb
Gitweb:        https://git.kernel.org/tip/29721b859217b946bfc001c1644745ed4d7c26cb
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 13 May 2021 01:29:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 May 2021 14:21:22 +02:00

tick/nohz: Only wake up a single target cpu when kicking a task

When adding a tick dependency to a task, its necessary to
wake up the CPU where the task resides to reevaluate tick
dependencies on that CPU.

However the current code wakes up all nohz_full CPUs, which
is unnecessary.

Switch to waking up a single CPU, by using ordering of writes
to task->cpu and task->tick_dep_mask.

[ mingo: Minor readability edit. ]

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210512232924.150322-7-frederic@kernel.org
---
 kernel/time/tick-sched.c | 40 ++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 89ec0ab..b90ca66 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -322,6 +322,31 @@ void tick_nohz_full_kick_cpu(int cpu)
 	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
 }
 
+static void tick_nohz_kick_task(struct task_struct *tsk)
+{
+	int cpu = task_cpu(tsk);
+
+	/*
+	 * If the task concurrently migrates to another CPU,
+	 * we guarantee it sees the new tick dependency upon
+	 * schedule.
+	 *
+	 *
+	 * set_task_cpu(p, cpu);
+	 *   STORE p->cpu = @cpu
+	 * __schedule() (switch to task 'p')
+	 *   LOCK rq->lock
+	 *   smp_mb__after_spin_lock()          STORE p->tick_dep_mask
+	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
+	 *      LOAD p->tick_dep_mask           LOAD p->cpu
+	 */
+
+	preempt_disable();
+	if (cpu_online(cpu))
+		tick_nohz_full_kick_cpu(cpu);
+	preempt_enable();
+}
+
 /*
  * Kick all full dynticks CPUs in order to force these to re-evaluate
  * their dependency on the tick and restart it if necessary.
@@ -404,19 +429,8 @@ EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cpu);
  */
 void tick_nohz_dep_set_task(struct task_struct *tsk, enum tick_dep_bits bit)
 {
-	if (!atomic_fetch_or(BIT(bit), &tsk->tick_dep_mask)) {
-		if (tsk == current) {
-			preempt_disable();
-			tick_nohz_full_kick();
-			preempt_enable();
-		} else {
-			/*
-			 * Some future tick_nohz_full_kick_task()
-			 * should optimize this.
-			 */
-			tick_nohz_full_kick_all();
-		}
-	}
+	if (!atomic_fetch_or(BIT(bit), &tsk->tick_dep_mask))
+		tick_nohz_kick_task(tsk);
 }
 EXPORT_SYMBOL_GPL(tick_nohz_dep_set_task);
 
