Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FDE362498
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbhDPPyU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbhDPPyL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:54:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A65C06175F;
        Fri, 16 Apr 2021 08:53:46 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:53:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618588425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZoebXQ8Mgg7UhRKnMD9HerFEyIYyqA2Y9vKuqLHlFs=;
        b=gr+b+mL3XpYUzz30PBSYJ6Cu4lhr/U8MqgMhDKKWvn/qB2nmkJsDpDqP8NW8cZ2hLd3QjL
        OnC8VcJ/xBTREFdZRz27aiNw/Ri14SjAi18xu7zsClP5ln9Bmjkb7cjbu8wN37hzLpNOMc
        LsR4ZCL65GHBFHHzbve3jqgxBxr5bwGav7yEIVvAxVXX7TmXpRcgmla6WnTW8qy+LV0Kmp
        w2ciA/pk4/lF+PJzJwmmjgsX4Ssa3tGgrRKNIv1eMxog8f3KVeHmW0wEg/1O4HG4ANh5HO
        65eC4UUt8dCEL/jfVdgUTBr3kdlagQFO59ugtFw/Amz5GozS4atOcgI0GRvG8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618588425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZoebXQ8Mgg7UhRKnMD9HerFEyIYyqA2Y9vKuqLHlFs=;
        b=BEfeo6XWA5U8cKGUo8h7zKOEXw0YfZKHwEznPc1VALTYSSQiC4SeA5P2liTj12IGQRHJuO
        EdN2qy5N+YNG6YDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Use cpu_dying() to fix balance_push vs
 hotplug-rollback
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <YHgAYef83VQhKdC2@hirez.programming.kicks-ass.net>
References: <YHgAYef83VQhKdC2@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161858842443.29796.7574048202320693227.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b5c4477366fb5e6a2f0f38742c33acd666c07698
Gitweb:        https://git.kernel.org/tip/b5c4477366fb5e6a2f0f38742c33acd666c07698
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 21 Jan 2021 16:09:32 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 17:06:32 +02:00

sched: Use cpu_dying() to fix balance_push vs hotplug-rollback

Use the new cpu_dying() state to simplify and fix the balance_push()
vs CPU hotplug rollback state.

Specifically, we currently rely on notifiers sched_cpu_dying() /
sched_cpu_activate() to terminate balance_push, however if the
cpu_down() fails when we're past sched_cpu_deactivate(), it should
terminate balance_push at that point and not wait until we hit
sched_cpu_activate().

Similarly, when cpu_up() fails and we're going back down, balance_push
should be active, where it currently is not.

So instead, make sure balance_push is enabled below SCHED_AP_ACTIVE
(when !cpu_active()), and gate it's utility with cpu_dying().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/YHgAYef83VQhKdC2@hirez.programming.kicks-ass.net
---
 kernel/sched/core.c  | 26 +++++++++++++++-----------
 kernel/sched/sched.h |  1 -
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95bd6ab..7d031da 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1811,7 +1811,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 		return cpu_online(cpu);
 
 	/* Regular kernel threads don't get to stay during offline. */
-	if (cpu_rq(cpu)->balance_push)
+	if (cpu_dying(cpu))
 		return false;
 
 	/* But are allowed during online. */
@@ -7638,6 +7638,9 @@ static DEFINE_PER_CPU(struct cpu_stop_work, push_work);
 
 /*
  * Ensure we only run per-cpu kthreads once the CPU goes !active.
+ *
+ * This is enabled below SCHED_AP_ACTIVE; when !cpu_active(), but only
+ * effective when the hotplug motion is down.
  */
 static void balance_push(struct rq *rq)
 {
@@ -7645,12 +7648,19 @@ static void balance_push(struct rq *rq)
 
 	lockdep_assert_held(&rq->lock);
 	SCHED_WARN_ON(rq->cpu != smp_processor_id());
+
 	/*
 	 * Ensure the thing is persistent until balance_push_set(.on = false);
 	 */
 	rq->balance_callback = &balance_push_callback;
 
 	/*
+	 * Only active while going offline.
+	 */
+	if (!cpu_dying(rq->cpu))
+		return;
+
+	/*
 	 * Both the cpu-hotplug and stop task are in this case and are
 	 * required to complete the hotplug process.
 	 *
@@ -7703,7 +7713,6 @@ static void balance_push_set(int cpu, bool on)
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
-	rq->balance_push = on;
 	if (on) {
 		WARN_ON_ONCE(rq->balance_callback);
 		rq->balance_callback = &balance_push_callback;
@@ -7828,8 +7837,8 @@ int sched_cpu_activate(unsigned int cpu)
 	struct rq_flags rf;
 
 	/*
-	 * Make sure that when the hotplug state machine does a roll-back
-	 * we clear balance_push. Ideally that would happen earlier...
+	 * Clear the balance_push callback and prepare to schedule
+	 * regular tasks.
 	 */
 	balance_push_set(cpu, false);
 
@@ -8014,12 +8023,6 @@ int sched_cpu_dying(unsigned int cpu)
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
-	/*
-	 * Now that the CPU is offline, make sure we're welcome
-	 * to new tasks once we come back up.
-	 */
-	balance_push_set(cpu, false);
-
 	calc_load_migrate(rq);
 	update_max_interval();
 	hrtick_clear(rq);
@@ -8204,7 +8207,7 @@ void __init sched_init(void)
 		rq->sd = NULL;
 		rq->rd = NULL;
 		rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
-		rq->balance_callback = NULL;
+		rq->balance_callback = &balance_push_callback;
 		rq->active_balance = 0;
 		rq->next_balance = jiffies;
 		rq->push_cpu = 0;
@@ -8251,6 +8254,7 @@ void __init sched_init(void)
 
 #ifdef CONFIG_SMP
 	idle_thread_set_boot_cpu();
+	balance_push_set(smp_processor_id(), false);
 #endif
 	init_sched_fair_class();
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cbb0b01..7e7e936 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -983,7 +983,6 @@ struct rq {
 	unsigned long		cpu_capacity_orig;
 
 	struct callback_head	*balance_callback;
-	unsigned char		balance_push;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
