Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C294B2AEB1C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgKKIYH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgKKIXY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9F1C0617A7;
        Wed, 11 Nov 2020 00:23:23 -0800 (PST)
Date:   Wed, 11 Nov 2020 08:23:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605083002;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c7wTyN4gEbbk6YPp8gB0MSVnfHIB/3GfuLSKeaO/hwA=;
        b=dLybKHQW2uPa0TSsK9vGx4WnwX+Boe7m9a+QlMRZztfC5K3HmNKikc8gehvi5e5/PPTqgC
        pTJiShFJN01d3pDrS3f3HnckIiynNy+J8sFhsuqdqLM1NPv7Ox+u+rrFmSSR3tsDFEaHd7
        fRvtifr/Oc8g+8go5itMsVMJ4xGmlddnhFVJo2rsoq91EizY5+CfeUeSVdIi/43ywEUJEc
        Iy+aQBs27Z3id1pQtCJ4IiqScXR3wndHyuGeAv3X76OOsSDuPsmUlVEkzDPKBzJUfKKtF4
        T1boiZ6wwrQpbCF7bWT3TGOVfBoKjkqXUpzHoB0Fc6gMl8YYzGpb24/mEE0VAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605083002;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c7wTyN4gEbbk6YPp8gB0MSVnfHIB/3GfuLSKeaO/hwA=;
        b=IUMhZEelOx3Z89uXLGHIJw+/iLemHioojCS+x7G4tcjs6UJQ6mJ0bi6InRFNJBwhsd8CC5
        gy9aLEB12iafjTDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/hotplug: Consolidate task migration on CPU unplug
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201023102346.547163969@infradead.org>
References: <20201023102346.547163969@infradead.org>
MIME-Version: 1.0
Message-ID: <160508300169.11244.7154250838629196977.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1cf12e08bc4d50a76b80c42a3109c53d8794a0c9
Gitweb:        https://git.kernel.org/tip/1cf12e08bc4d50a76b80c42a3109c53d8794a0c9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 16 Sep 2020 09:27:18 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:38:58 +01:00

sched/hotplug: Consolidate task migration on CPU unplug

With the new mechanism which kicks tasks off the outgoing CPU at the end of
schedule() the situation on an outgoing CPU right before the stopper thread
brings it down completely is:

 - All user tasks and all unbound kernel threads have either been migrated
   away or are not running and the next wakeup will move them to a online CPU.

 - All per CPU kernel threads, except cpu hotplug thread and the stopper
   thread have either been unbound or parked by the responsible CPU hotplug
   callback.

That means that at the last step before the stopper thread is invoked the
cpu hotplug thread is the last legitimate running task on the outgoing
CPU.

Add a final wait step right before the stopper thread is kicked which
ensures that any still running tasks on the way to park or on the way to
kick themself of the CPU are either sleeping or gone.

This allows to remove the migrate_tasks() crutch in sched_cpu_dying(). If
sched_cpu_dying() detects that there is still another running task aside of
the stopper thread then it will explode with the appropriate fireworks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201023102346.547163969@infradead.org
---
 include/linux/cpuhotplug.h    |   1 +-
 include/linux/sched/hotplug.h |   2 +-
 kernel/cpu.c                  |   9 +-
 kernel/sched/core.c           | 154 +++++++--------------------------
 4 files changed, 46 insertions(+), 120 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index bc56287..0042ef3 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -152,6 +152,7 @@ enum cpuhp_state {
 	CPUHP_AP_ONLINE,
 	CPUHP_TEARDOWN_CPU,
 	CPUHP_AP_ONLINE_IDLE,
+	CPUHP_AP_SCHED_WAIT_EMPTY,
 	CPUHP_AP_SMPBOOT_THREADS,
 	CPUHP_AP_X86_VDSO_VMA_ONLINE,
 	CPUHP_AP_IRQ_AFFINITY_ONLINE,
diff --git a/include/linux/sched/hotplug.h b/include/linux/sched/hotplug.h
index 9a62ffd..412cdab 100644
--- a/include/linux/sched/hotplug.h
+++ b/include/linux/sched/hotplug.h
@@ -11,8 +11,10 @@ extern int sched_cpu_activate(unsigned int cpu);
 extern int sched_cpu_deactivate(unsigned int cpu);
 
 #ifdef CONFIG_HOTPLUG_CPU
+extern int sched_cpu_wait_empty(unsigned int cpu);
 extern int sched_cpu_dying(unsigned int cpu);
 #else
+# define sched_cpu_wait_empty	NULL
 # define sched_cpu_dying	NULL
 #endif
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ff2578..fa535ea 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1602,7 +1602,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.name			= "ap:online",
 	},
 	/*
-	 * Handled on controll processor until the plugged processor manages
+	 * Handled on control processor until the plugged processor manages
 	 * this itself.
 	 */
 	[CPUHP_TEARDOWN_CPU] = {
@@ -1611,6 +1611,13 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.teardown.single	= takedown_cpu,
 		.cant_stop		= true,
 	},
+
+	[CPUHP_AP_SCHED_WAIT_EMPTY] = {
+		.name			= "sched:waitempty",
+		.startup.single		= NULL,
+		.teardown.single	= sched_cpu_wait_empty,
+	},
+
 	/* Handle smpboot threads park/unpark */
 	[CPUHP_AP_SMPBOOT_THREADS] = {
 		.name			= "smpboot/threads:online",
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e1093c4..6c89806 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6741,120 +6741,6 @@ void idle_task_exit(void)
 	/* finish_cpu(), as ran on the BP, will clean up the active_mm state */
 }
 
-/*
- * Since this CPU is going 'away' for a while, fold any nr_active delta
- * we might have. Assumes we're called after migrate_tasks() so that the
- * nr_active count is stable. We need to take the teardown thread which
- * is calling this into account, so we hand in adjust = 1 to the load
- * calculation.
- *
- * Also see the comment "Global load-average calculations".
- */
-static void calc_load_migrate(struct rq *rq)
-{
-	long delta = calc_load_fold_active(rq, 1);
-	if (delta)
-		atomic_long_add(delta, &calc_load_tasks);
-}
-
-static struct task_struct *__pick_migrate_task(struct rq *rq)
-{
-	const struct sched_class *class;
-	struct task_struct *next;
-
-	for_each_class(class) {
-		next = class->pick_next_task(rq);
-		if (next) {
-			next->sched_class->put_prev_task(rq, next);
-			return next;
-		}
-	}
-
-	/* The idle class should always have a runnable task */
-	BUG();
-}
-
-/*
- * Migrate all tasks from the rq, sleeping tasks will be migrated by
- * try_to_wake_up()->select_task_rq().
- *
- * Called with rq->lock held even though we'er in stop_machine() and
- * there's no concurrency possible, we hold the required locks anyway
- * because of lock validation efforts.
- */
-static void migrate_tasks(struct rq *dead_rq, struct rq_flags *rf)
-{
-	struct rq *rq = dead_rq;
-	struct task_struct *next, *stop = rq->stop;
-	struct rq_flags orf = *rf;
-	int dest_cpu;
-
-	/*
-	 * Fudge the rq selection such that the below task selection loop
-	 * doesn't get stuck on the currently eligible stop task.
-	 *
-	 * We're currently inside stop_machine() and the rq is either stuck
-	 * in the stop_machine_cpu_stop() loop, or we're executing this code,
-	 * either way we should never end up calling schedule() until we're
-	 * done here.
-	 */
-	rq->stop = NULL;
-
-	/*
-	 * put_prev_task() and pick_next_task() sched
-	 * class method both need to have an up-to-date
-	 * value of rq->clock[_task]
-	 */
-	update_rq_clock(rq);
-
-	for (;;) {
-		/*
-		 * There's this thread running, bail when that's the only
-		 * remaining thread:
-		 */
-		if (rq->nr_running == 1)
-			break;
-
-		next = __pick_migrate_task(rq);
-
-		/*
-		 * Rules for changing task_struct::cpus_mask are holding
-		 * both pi_lock and rq->lock, such that holding either
-		 * stabilizes the mask.
-		 *
-		 * Drop rq->lock is not quite as disastrous as it usually is
-		 * because !cpu_active at this point, which means load-balance
-		 * will not interfere. Also, stop-machine.
-		 */
-		rq_unlock(rq, rf);
-		raw_spin_lock(&next->pi_lock);
-		rq_relock(rq, rf);
-
-		/*
-		 * Since we're inside stop-machine, _nothing_ should have
-		 * changed the task, WARN if weird stuff happened, because in
-		 * that case the above rq->lock drop is a fail too.
-		 */
-		if (WARN_ON(task_rq(next) != rq || !task_on_rq_queued(next))) {
-			raw_spin_unlock(&next->pi_lock);
-			continue;
-		}
-
-		/* Find suitable destination for @next, with force if needed. */
-		dest_cpu = select_fallback_rq(dead_rq->cpu, next);
-		rq = __migrate_task(rq, rf, next, dest_cpu);
-		if (rq != dead_rq) {
-			rq_unlock(rq, rf);
-			rq = dead_rq;
-			*rf = orf;
-			rq_relock(rq, rf);
-		}
-		raw_spin_unlock(&next->pi_lock);
-	}
-
-	rq->stop = stop;
-}
-
 static int __balance_push_cpu_stop(void *arg)
 {
 	struct task_struct *p = arg;
@@ -7123,10 +7009,6 @@ int sched_cpu_deactivate(unsigned int cpu)
 		return ret;
 	}
 	sched_domains_numa_masks_clear(cpu);
-
-	/* Wait for all non per CPU kernel threads to vanish. */
-	balance_hotplug_wait();
-
 	return 0;
 }
 
@@ -7146,6 +7028,41 @@ int sched_cpu_starting(unsigned int cpu)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+
+/*
+ * Invoked immediately before the stopper thread is invoked to bring the
+ * CPU down completely. At this point all per CPU kthreads except the
+ * hotplug thread (current) and the stopper thread (inactive) have been
+ * either parked or have been unbound from the outgoing CPU. Ensure that
+ * any of those which might be on the way out are gone.
+ *
+ * If after this point a bound task is being woken on this CPU then the
+ * responsible hotplug callback has failed to do it's job.
+ * sched_cpu_dying() will catch it with the appropriate fireworks.
+ */
+int sched_cpu_wait_empty(unsigned int cpu)
+{
+	balance_hotplug_wait();
+	return 0;
+}
+
+/*
+ * Since this CPU is going 'away' for a while, fold any nr_active delta we
+ * might have. Called from the CPU stopper task after ensuring that the
+ * stopper is the last running task on the CPU, so nr_active count is
+ * stable. We need to take the teardown thread which is calling this into
+ * account, so we hand in adjust = 1 to the load calculation.
+ *
+ * Also see the comment "Global load-average calculations".
+ */
+static void calc_load_migrate(struct rq *rq)
+{
+	long delta = calc_load_fold_active(rq, 1);
+
+	if (delta)
+		atomic_long_add(delta, &calc_load_tasks);
+}
+
 int sched_cpu_dying(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -7159,7 +7076,6 @@ int sched_cpu_dying(unsigned int cpu)
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
 		set_rq_offline(rq);
 	}
-	migrate_tasks(rq, &rf);
 	BUG_ON(rq->nr_running != 1);
 	rq_unlock_irqrestore(rq, &rf);
 
