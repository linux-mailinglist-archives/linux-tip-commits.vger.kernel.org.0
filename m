Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92BE2AEB1E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgKKIYG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:24:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36254 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgKKIXY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:24 -0500
Date:   Wed, 11 Nov 2020 08:23:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605083003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FydEDKpgy2I/t4GenCWdAqiL7gDC5cgKxg/4lU+u/SE=;
        b=aCgBAN8kvedmst5MPBw1XeC8CMU22GUS2uvrSSfnX/kAvO/8mYGl+iqWNpZla/2vJGqvf7
        8wMmNI12v2uQqdP10EGnp1Bps87MtMe055/XTu1XXZn48N0KeUYlHZSl71VP1HQAs9LtpM
        cGrJ9RHgP/Q++2sHKE3p15B3cQJ4D7rODCZKCWntNVCR3iNjQlTTqO5x0vcM62VHPEAvCP
        2r76GBa78S/4ISR299TIOh/HNnVb/efs8EL3LAVh54m9dX77o33Bcr4HMXQiCIkqcE2c9Q
        7Arm4TlsdFLYruupFkNX2xJbTU8xbMYvFkroDNX229ShLhIjb09jumdtioWGUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605083003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FydEDKpgy2I/t4GenCWdAqiL7gDC5cgKxg/4lU+u/SE=;
        b=WpkzANmL2pUWhGg9YmZOXPsrf80oueOk5/tPEXCQnOLHnROwPu/5bKOafhC6vppoujw/vn
        NJPnq1wlePETCIBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Wait for tasks being pushed away on hotplug
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201023102346.377836842@infradead.org>
References: <20201023102346.377836842@infradead.org>
MIME-Version: 1.0
Message-ID: <160508300281.11244.3990530911271020022.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f2469a1fb43f85d243ce72638367fb6e15c33491
Gitweb:        https://git.kernel.org/tip/f2469a1fb43f85d243ce72638367fb6e15c33491
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Sep 2020 14:47:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:38:58 +01:00

sched/core: Wait for tasks being pushed away on hotplug

RT kernels need to ensure that all tasks which are not per CPU kthreads
have left the outgoing CPU to guarantee that no tasks are force migrated
within a migrate disabled section.

There is also some desire to (ab)use fine grained CPU hotplug control to
clear a CPU from active state to force migrate tasks which are not per CPU
kthreads away for power control purposes.

Add a mechanism which waits until all tasks which should leave the CPU
after the CPU active flag is cleared have moved to a different online CPU.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201023102346.377836842@infradead.org
---
 kernel/sched/core.c  | 40 +++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |  4 ++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1f8bfc9..e1093c4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6896,8 +6896,21 @@ static void balance_push(struct rq *rq)
 	 * Both the cpu-hotplug and stop task are in this case and are
 	 * required to complete the hotplug process.
 	 */
-	if (is_per_cpu_kthread(push_task))
+	if (is_per_cpu_kthread(push_task)) {
+		/*
+		 * If this is the idle task on the outgoing CPU try to wake
+		 * up the hotplug control thread which might wait for the
+		 * last task to vanish. The rcuwait_active() check is
+		 * accurate here because the waiter is pinned on this CPU
+		 * and can't obviously be running in parallel.
+		 */
+		if (!rq->nr_running && rcuwait_active(&rq->hotplug_wait)) {
+			raw_spin_unlock(&rq->lock);
+			rcuwait_wake_up(&rq->hotplug_wait);
+			raw_spin_lock(&rq->lock);
+		}
 		return;
+	}
 
 	get_task_struct(push_task);
 	/*
@@ -6928,6 +6941,20 @@ static void balance_push_set(int cpu, bool on)
 	rq_unlock_irqrestore(rq, &rf);
 }
 
+/*
+ * Invoked from a CPUs hotplug control thread after the CPU has been marked
+ * inactive. All tasks which are not per CPU kernel threads are either
+ * pushed off this CPU now via balance_push() or placed on a different CPU
+ * during wakeup. Wait until the CPU is quiescent.
+ */
+static void balance_hotplug_wait(void)
+{
+	struct rq *rq = this_rq();
+
+	rcuwait_wait_event(&rq->hotplug_wait, rq->nr_running == 1,
+			   TASK_UNINTERRUPTIBLE);
+}
+
 #else
 
 static inline void balance_push(struct rq *rq)
@@ -6938,6 +6965,10 @@ static inline void balance_push_set(int cpu, bool on)
 {
 }
 
+static inline void balance_hotplug_wait(void)
+{
+}
+
 #endif /* CONFIG_HOTPLUG_CPU */
 
 void set_rq_online(struct rq *rq)
@@ -7092,6 +7123,10 @@ int sched_cpu_deactivate(unsigned int cpu)
 		return ret;
 	}
 	sched_domains_numa_masks_clear(cpu);
+
+	/* Wait for all non per CPU kernel threads to vanish. */
+	balance_hotplug_wait();
+
 	return 0;
 }
 
@@ -7332,6 +7367,9 @@ void __init sched_init(void)
 
 		rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+		rcuwait_init(&rq->hotplug_wait);
+#endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a71ac84..c6f707a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1004,6 +1004,10 @@ struct rq {
 
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
+
+#ifdef CONFIG_HOTPLUG_CPU
+	struct rcuwait		hotplug_wait;
+#endif
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
