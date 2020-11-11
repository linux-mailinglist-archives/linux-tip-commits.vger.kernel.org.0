Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0249F2AEB30
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgKKIYo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgKKIXV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35430C0613D1;
        Wed, 11 Nov 2020 00:23:21 -0800 (PST)
Date:   Wed, 11 Nov 2020 08:23:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605082999;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WxmguMigCVYdvg/XX4NfDLNdO82BjrGincvzoSF6y1s=;
        b=4QmQoj5gY2Ps1BWCGFkVH0NLRJ5TDGvKjFXz+9A1X1iT2t76QIkEuqDuyepTetYRqHluJI
        5N6PrO18l0JT+HAIQOF/Uc7geYKpEk4il1JRSI4OJVbwEJ1cVO0/xORJLpZrU3fbeGaKe5
        g1GKmcrHnIfo/bDq9cwkGenvfD3llVAKqNMhZMRVprQ7QyILZLS8l1H7FKCoc+j7hwS3Xa
        4AJ+uHF1FZbBhRyeKo2rSMFloCnL+NW5oTlA0BDqJFxDUV1HFbhFTh3q4olDpIC0VGHnXv
        xycE2DSyCEO4AVLCaLiKUtH9EtQlrPV/bISIkvhLXSY16/zU64SHGnOpvWXGfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605082999;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WxmguMigCVYdvg/XX4NfDLNdO82BjrGincvzoSF6y1s=;
        b=RLaBsVgmkefSJENQmBhjnEqKQS0MTHGCfGbHFVikzGwHPnMyJbydFjBHtpBN28NWCOqDVP
        Eyv2cpo7USJri8Dg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Make migrate disable and CPU hotplug
 cooperative
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201023102347.067278757@infradead.org>
References: <20201023102347.067278757@infradead.org>
MIME-Version: 1.0
Message-ID: <160508299865.11244.8558054743131362689.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3015ef4b98f53fe7eba4f5f82f562c0e074d213c
Gitweb:        https://git.kernel.org/tip/3015ef4b98f53fe7eba4f5f82f562c0e074d213c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 14:08:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:39:00 +01:00

sched/core: Make migrate disable and CPU hotplug cooperative

On CPU unplug tasks which are in a migrate disabled region cannot be pushed
to a different CPU until they returned to migrateable state.

Account the number of tasks on a runqueue which are in a migrate disabled
section and make the hotplug wait mechanism respect that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201023102347.067278757@infradead.org
---
 kernel/sched/core.c  | 36 ++++++++++++++++++++++++++++++------
 kernel/sched/sched.h |  4 ++++
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0efc1e4..6ea593c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1721,10 +1721,17 @@ static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
 
 void migrate_disable(void)
 {
-	if (current->migration_disabled++)
+	struct task_struct *p = current;
+
+	if (p->migration_disabled) {
+		p->migration_disabled++;
 		return;
+	}
 
-	barrier();
+	preempt_disable();
+	this_rq()->nr_pinned++;
+	p->migration_disabled = 1;
+	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_disable);
 
@@ -1751,6 +1758,7 @@ void migrate_enable(void)
 	 */
 	barrier();
 	p->migration_disabled = 0;
+	this_rq()->nr_pinned--;
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_enable);
@@ -1760,6 +1768,11 @@ static inline bool is_migration_disabled(struct task_struct *p)
 	return p->migration_disabled;
 }
 
+static inline bool rq_has_pinned_tasks(struct rq *rq)
+{
+	return rq->nr_pinned;
+}
+
 #endif
 
 /*
@@ -2693,6 +2706,11 @@ static inline bool is_migration_disabled(struct task_struct *p)
 	return false;
 }
 
+static inline bool rq_has_pinned_tasks(struct rq *rq)
+{
+	return false;
+}
+
 #endif
 
 static void
@@ -7066,15 +7084,20 @@ static void balance_push(struct rq *rq)
 	 * Both the cpu-hotplug and stop task are in this case and are
 	 * required to complete the hotplug process.
 	 */
-	if (is_per_cpu_kthread(push_task)) {
+	if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
 		/*
 		 * If this is the idle task on the outgoing CPU try to wake
 		 * up the hotplug control thread which might wait for the
 		 * last task to vanish. The rcuwait_active() check is
 		 * accurate here because the waiter is pinned on this CPU
 		 * and can't obviously be running in parallel.
+		 *
+		 * On RT kernels this also has to check whether there are
+		 * pinned and scheduled out tasks on the runqueue. They
+		 * need to leave the migrate disabled section first.
 		 */
-		if (!rq->nr_running && rcuwait_active(&rq->hotplug_wait)) {
+		if (!rq->nr_running && !rq_has_pinned_tasks(rq) &&
+		    rcuwait_active(&rq->hotplug_wait)) {
 			raw_spin_unlock(&rq->lock);
 			rcuwait_wake_up(&rq->hotplug_wait);
 			raw_spin_lock(&rq->lock);
@@ -7121,7 +7144,8 @@ static void balance_hotplug_wait(void)
 {
 	struct rq *rq = this_rq();
 
-	rcuwait_wait_event(&rq->hotplug_wait, rq->nr_running == 1,
+	rcuwait_wait_event(&rq->hotplug_wait,
+			   rq->nr_running == 1 && !rq_has_pinned_tasks(rq),
 			   TASK_UNINTERRUPTIBLE);
 }
 
@@ -7366,7 +7390,7 @@ int sched_cpu_dying(unsigned int cpu)
 	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
-	BUG_ON(rq->nr_running != 1);
+	BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq));
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 72d8e47..42de140 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1053,6 +1053,10 @@ struct rq {
 	/* Must be inspected within a rcu lock section */
 	struct cpuidle_state	*idle_state;
 #endif
+
+#if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
+	unsigned int		nr_pinned;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
