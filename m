Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D057F2AEB24
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgKKIYg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgKKIXX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1558C0613D6;
        Wed, 11 Nov 2020 00:23:22 -0800 (PST)
Date:   Wed, 11 Nov 2020 08:23:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605083000;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQcJZ/RcDudXCK0MOpoalu4Vmjep2fgTflumDXYtMCA=;
        b=NyS2teeeZxtH0asdbkXbtwwm6rH+Up31Khe8H3vnq91umXn8dBcA572/YMvpfBEpsxQFRY
        5oy+IUzEIL48tLQrU+NCtd2cxe186EcpxDFFUzOiVGpd06lNNs2St49qHlH9EaIScw6qvG
        PKTIYIJc/mt521mxmh0o+fCXQTCQ5ceYUfhZ5UYi078OaQ9LjQhTSnsuEvSIEE+x3vrtir
        MqBQj+ztLbkP58ufl4kYONmFfsFKi5pRF8COGZv9/LpvcmmSKlCORCKJd3dQ37nftFdOBg
        LlGVwOSs9RPehXCWuHRhfWK6onrSsxky3ZFDjE9qdLgCFYgYndrjG7pmrFHCWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605083000;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQcJZ/RcDudXCK0MOpoalu4Vmjep2fgTflumDXYtMCA=;
        b=yqkv0j/1R3WmMlFjkuy0wohTZK1ZB7SxvxX4nSeiSZh/r9VvnWTtBzpHTRYUijL1ezSpj5
        8ES3jq37/qxNYxBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add migrate_disable()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201023102346.818170844@infradead.org>
References: <20201023102346.818170844@infradead.org>
MIME-Version: 1.0
Message-ID: <160508299986.11244.14812545447589936667.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     af449901b84c98cbd84a0113223ba3bcfcb12a26
Gitweb:        https://git.kernel.org/tip/af449901b84c98cbd84a0113223ba3bcfcb12a26
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 17 Sep 2020 10:38:30 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:38:59 +01:00

sched: Add migrate_disable()

Add the base migrate_disable() support (under protest).

While migrate_disable() is (currently) required for PREEMPT_RT, it is
also one of the biggest flaws in the system.

Notably this is just the base implementation, it is broken vs
sched_setaffinity() and hotplug, both solved in additional patches for
ease of review.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201023102346.818170844@infradead.org
---
 include/linux/preempt.h |  65 +++++++++++++++++++++++-
 include/linux/sched.h   |   3 +-
 kernel/sched/core.c     | 112 ++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h    |   6 +-
 lib/smp_processor_id.c  |   5 ++-
 5 files changed, 183 insertions(+), 8 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 7d9c1c0..97ba7c9 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -322,6 +322,69 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 
 #endif
 
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+
+/*
+ * Migrate-Disable and why it is (strongly) undesired.
+ *
+ * The premise of the Real-Time schedulers we have on Linux
+ * (SCHED_FIFO/SCHED_DEADLINE) is that M CPUs can/will run M tasks
+ * concurrently, provided there are sufficient runnable tasks, also known as
+ * work-conserving. For instance SCHED_DEADLINE tries to schedule the M
+ * earliest deadline threads, and SCHED_FIFO the M highest priority threads.
+ *
+ * The correctness of various scheduling models depends on this, but is it
+ * broken by migrate_disable() that doesn't imply preempt_disable(). Where
+ * preempt_disable() implies an immediate priority ceiling, preemptible
+ * migrate_disable() allows nesting.
+ *
+ * The worst case is that all tasks preempt one another in a migrate_disable()
+ * region and stack on a single CPU. This then reduces the available bandwidth
+ * to a single CPU. And since Real-Time schedulability theory considers the
+ * Worst-Case only, all Real-Time analysis shall revert to single-CPU
+ * (instantly solving the SMP analysis problem).
+ *
+ *
+ * The reason we have it anyway.
+ *
+ * PREEMPT_RT breaks a number of assumptions traditionally held. By forcing a
+ * number of primitives into becoming preemptible, they would also allow
+ * migration. This turns out to break a bunch of per-cpu usage. To this end,
+ * all these primitives employ migirate_disable() to restore this implicit
+ * assumption.
+ *
+ * This is a 'temporary' work-around at best. The correct solution is getting
+ * rid of the above assumptions and reworking the code to employ explicit
+ * per-cpu locking or short preempt-disable regions.
+ *
+ * The end goal must be to get rid of migrate_disable(), alternatively we need
+ * a schedulability theory that does not depend on abritrary migration.
+ *
+ *
+ * Notes on the implementation.
+ *
+ * The implementation is particularly tricky since existing code patterns
+ * dictate neither migrate_disable() nor migrate_enable() is allowed to block.
+ * This means that it cannot use cpus_read_lock() to serialize against hotplug,
+ * nor can it easily migrate itself into a pending affinity mask change on
+ * migrate_enable().
+ *
+ *
+ * Note: even non-work-conserving schedulers like semi-partitioned depends on
+ *       migration, so migrate_disable() is not only a problem for
+ *       work-conserving schedulers.
+ *
+ */
+extern void migrate_disable(void);
+extern void migrate_enable(void);
+
+#elif defined(CONFIG_PREEMPT_RT)
+
+static inline void migrate_disable(void) { }
+static inline void migrate_enable(void) { }
+
+#else /* !CONFIG_PREEMPT_RT */
+
 /**
  * migrate_disable - Prevent migration of the current task
  *
@@ -352,4 +415,6 @@ static __always_inline void migrate_enable(void)
 	preempt_enable();
 }
 
+#endif /* CONFIG_SMP && CONFIG_PREEMPT_RT */
+
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 063cd12..0732356 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -714,6 +714,9 @@ struct task_struct {
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			cpus_mask;
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+	int				migration_disabled;
+#endif
 
 #ifdef CONFIG_PREEMPT_RCU
 	int				rcu_read_lock_nesting;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 396accb..6a3f1c2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1696,6 +1696,61 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 
 #ifdef CONFIG_SMP
 
+#ifdef CONFIG_PREEMPT_RT
+
+static void
+__do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
+
+static int __set_cpus_allowed_ptr(struct task_struct *p,
+				  const struct cpumask *new_mask,
+				  u32 flags);
+
+static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
+{
+	if (likely(!p->migration_disabled))
+		return;
+
+	if (p->cpus_ptr != &p->cpus_mask)
+		return;
+
+	/*
+	 * Violates locking rules! see comment in __do_set_cpus_allowed().
+	 */
+	__do_set_cpus_allowed(p, cpumask_of(rq->cpu), SCA_MIGRATE_DISABLE);
+}
+
+void migrate_disable(void)
+{
+	if (current->migration_disabled++)
+		return;
+
+	barrier();
+}
+EXPORT_SYMBOL_GPL(migrate_disable);
+
+void migrate_enable(void)
+{
+	struct task_struct *p = current;
+
+	if (--p->migration_disabled)
+		return;
+
+	barrier();
+
+	if (p->cpus_ptr == &p->cpus_mask)
+		return;
+
+	__set_cpus_allowed_ptr(p, &p->cpus_mask, SCA_MIGRATE_ENABLE);
+}
+EXPORT_SYMBOL_GPL(migrate_enable);
+
+static inline bool is_migration_disabled(struct task_struct *p)
+{
+	return p->migration_disabled;
+}
+
+#endif
+
 /*
  * Per-CPU kthreads are allowed to run on !active && online CPUs, see
  * __set_cpus_allowed_ptr() and select_fallback_rq().
@@ -1705,7 +1760,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 		return false;
 
-	if (is_per_cpu_kthread(p))
+	if (is_per_cpu_kthread(p) || is_migration_disabled(p))
 		return cpu_online(cpu);
 
 	return cpu_active(cpu);
@@ -1826,6 +1881,11 @@ static int migration_cpu_stop(void *data)
  */
 void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
 {
+	if (flags & (SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) {
+		p->cpus_ptr = new_mask;
+		return;
+	}
+
 	cpumask_copy(&p->cpus_mask, new_mask);
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
@@ -1836,7 +1896,22 @@ __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32
 	struct rq *rq = task_rq(p);
 	bool queued, running;
 
-	lockdep_assert_held(&p->pi_lock);
+	/*
+	 * This here violates the locking rules for affinity, since we're only
+	 * supposed to change these variables while holding both rq->lock and
+	 * p->pi_lock.
+	 *
+	 * HOWEVER, it magically works, because ttwu() is the only code that
+	 * accesses these variables under p->pi_lock and only does so after
+	 * smp_cond_load_acquire(&p->on_cpu, !VAL), and we're in __schedule()
+	 * before finish_task().
+	 *
+	 * XXX do further audits, this smells like something putrid.
+	 */
+	if (flags & SCA_MIGRATE_DISABLE)
+		SCHED_WARN_ON(!p->on_cpu);
+	else
+		lockdep_assert_held(&p->pi_lock);
 
 	queued = task_on_rq_queued(p);
 	running = task_current(rq, p);
@@ -1887,9 +1962,14 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	rq = task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 
-	if (p->flags & PF_KTHREAD) {
+	if (p->flags & PF_KTHREAD || is_migration_disabled(p)) {
 		/*
-		 * Kernel threads are allowed on online && !active CPUs
+		 * Kernel threads are allowed on online && !active CPUs.
+		 *
+		 * Specifically, migration_disabled() tasks must not fail the
+		 * cpumask_any_and_distribute() pick below, esp. so on
+		 * SCA_MIGRATE_ENABLE, otherwise we'll not call
+		 * set_cpus_allowed_common() and actually reset p->cpus_ptr.
 		 */
 		cpu_valid_mask = cpu_online_mask;
 	}
@@ -1903,7 +1983,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		goto out;
 	}
 
-	if (cpumask_equal(&p->cpus_mask, new_mask))
+	if (!(flags & SCA_MIGRATE_ENABLE) && cpumask_equal(&p->cpus_mask, new_mask))
 		goto out;
 
 	/*
@@ -1995,6 +2075,8 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	 * Clearly, migrating tasks to offline CPUs is a fairly daft thing.
 	 */
 	WARN_ON_ONCE(!cpu_online(new_cpu));
+
+	WARN_ON_ONCE(is_migration_disabled(p));
 #endif
 
 	trace_sched_migrate_task(p, new_cpu);
@@ -2325,6 +2407,12 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 			}
 			fallthrough;
 		case possible:
+			/*
+			 * XXX When called from select_task_rq() we only
+			 * hold p->pi_lock and again violate locking order.
+			 *
+			 * More yuck to audit.
+			 */
 			do_set_cpus_allowed(p, cpu_possible_mask);
 			state = fail;
 			break;
@@ -2359,7 +2447,7 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
 {
 	lockdep_assert_held(&p->pi_lock);
 
-	if (p->nr_cpus_allowed > 1)
+	if (p->nr_cpus_allowed > 1 && !is_migration_disabled(p))
 		cpu = p->sched_class->select_task_rq(p, cpu, sd_flags, wake_flags);
 	else
 		cpu = cpumask_any(p->cpus_ptr);
@@ -2421,6 +2509,17 @@ static inline int __set_cpus_allowed_ptr(struct task_struct *p,
 
 #endif /* CONFIG_SMP */
 
+#if !defined(CONFIG_SMP) || !defined(CONFIG_PREEMPT_RT)
+
+static inline void migrate_disable_switch(struct rq *rq, struct task_struct *p) { }
+
+static inline bool is_migration_disabled(struct task_struct *p)
+{
+	return false;
+}
+
+#endif
+
 static void
 ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 {
@@ -4570,6 +4669,7 @@ static void __sched notrace __schedule(bool preempt)
 		 */
 		++*switch_count;
 
+		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
 		trace_sched_switch(preempt, prev, next);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0420d80..72d8e47 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1902,14 +1902,16 @@ static inline bool sched_fair_runnable(struct rq *rq)
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 extern struct task_struct *pick_next_task_idle(struct rq *rq);
 
+#define SCA_CHECK		0x01
+#define SCA_MIGRATE_DISABLE	0x02
+#define SCA_MIGRATE_ENABLE	0x04
+
 #ifdef CONFIG_SMP
 
 extern void update_group_capacity(struct sched_domain *sd, int cpu);
 
 extern void trigger_load_balance(struct rq *rq);
 
-#define SCA_CHECK		0x01
-
 extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
 
 #endif
diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 525222e..faaa927 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -26,6 +26,11 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	if (current->nr_cpus_allowed == 1)
 		goto out;
 
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+	if (current->migration_disabled)
+		goto out;
+#endif
+
 	/*
 	 * It is valid to assume CPU-locality during early bootup:
 	 */
