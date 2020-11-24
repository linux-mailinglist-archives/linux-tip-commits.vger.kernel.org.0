Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0F42C22F2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Nov 2020 11:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgKXK3W (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Nov 2020 05:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgKXK3W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Nov 2020 05:29:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA758C0613D6;
        Tue, 24 Nov 2020 02:29:21 -0800 (PST)
Date:   Tue, 24 Nov 2020 10:29:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606213760;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q16tF5A58dRjbWRoQ9kfyN7hmvPic7M0FjJwQR03VhM=;
        b=JSX5w4+O5JcxKYY9tGo9iYYyMKjo1TPiT0Di0iQD6s45ioKuCJ8mLZUrXev8tPQlH3WP/B
        VegZum0xFPl3wWD9RKzMgYaAPMJ8YlotLt39P5okliIrN1qbv/JZpstsjjwiQwRbTRc3F1
        /yOWta+qLvmoxefhRRTJDXsYCfKMc0G68/U+p9i91TgDaC2vPDzkJ8EWXxHBGJXrSk7msU
        lL1W1r999hu7didu5wZw2PW8hWQKGBNS2ZbteAjl+UdipgB7+cc48TkIKmq9m4/XV8chzd
        /RkWrj2mKXy4uFzve21rj7vDYjB4sjreWw1pB41BC2xwp+KzP2MGaa7aPR2gWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606213760;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q16tF5A58dRjbWRoQ9kfyN7hmvPic7M0FjJwQR03VhM=;
        b=JyBjXLWbgaxzdNzj4UnCymKURrajcRKRJSXT4ZI4ZOoD/2CmmKGiuk5prmbex8a5GiPCm0
        UQ3LW6udPCKDXABw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make migrate_disable/enable() independent of RT
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201118204007.269943012@linutronix.de>
References: <20201118204007.269943012@linutronix.de>
MIME-Version: 1.0
Message-ID: <160621375892.11115.2640817604080789510.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     74d862b682f51e45d25b95b1ecf212428a4967b0
Gitweb:        https://git.kernel.org/tip/74d862b682f51e45d25b95b1ecf212428a4967b0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 18 Nov 2020 20:48:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 24 Nov 2020 11:25:44 +01:00

sched: Make migrate_disable/enable() independent of RT

Now that the scheduler can deal with migrate disable properly, there is no
real compelling reason to make it only available for RT.

There are quite some code pathes which needlessly disable preemption in
order to prevent migration and some constructs like kmap_atomic() enforce
it implicitly.

Making it available independent of RT allows to provide a preemptible
variant of kmap_atomic() and makes the code more consistent in general.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Grudgingly-Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20201118204007.269943012@linutronix.de

---
 include/linux/kernel.h  | 21 ++++++++++++-------
 include/linux/preempt.h | 38 ++--------------------------------
 include/linux/sched.h   |  2 +-
 kernel/sched/core.c     | 45 +++++++++++++++++++++++++++++++---------
 kernel/sched/sched.h    |  4 ++--
 lib/smp_processor_id.c  |  2 +-
 6 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2f05e91..665837f 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -204,6 +204,7 @@ extern int _cond_resched(void);
 extern void ___might_sleep(const char *file, int line, int preempt_offset);
 extern void __might_sleep(const char *file, int line, int preempt_offset);
 extern void __cant_sleep(const char *file, int line, int preempt_offset);
+extern void __cant_migrate(const char *file, int line);
 
 /**
  * might_sleep - annotation for functions that can sleep
@@ -227,6 +228,18 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
 # define cant_sleep() \
 	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
 # define sched_annotate_sleep()	(current->task_state_change = 0)
+
+/**
+ * cant_migrate - annotation for functions that cannot migrate
+ *
+ * Will print a stack trace if executed in code which is migratable
+ */
+# define cant_migrate()							\
+	do {								\
+		if (IS_ENABLED(CONFIG_SMP))				\
+			__cant_migrate(__FILE__, __LINE__);		\
+	} while (0)
+
 /**
  * non_block_start - annotate the start of section where sleeping is prohibited
  *
@@ -251,6 +264,7 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
 				   int preempt_offset) { }
 # define might_sleep() do { might_resched(); } while (0)
 # define cant_sleep() do { } while (0)
+# define cant_migrate()		do { } while (0)
 # define sched_annotate_sleep() do { } while (0)
 # define non_block_start() do { } while (0)
 # define non_block_end() do { } while (0)
@@ -258,13 +272,6 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
 
 #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
 
-#ifndef CONFIG_PREEMPT_RT
-# define cant_migrate()		cant_sleep()
-#else
-  /* Placeholder for now */
-# define cant_migrate()		do { } while (0)
-#endif
-
 /**
  * abs - return absolute value of an argument
  * @x: the value.  If it is unsigned type, it is converted to signed type first.
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 8b43922..6df63cb 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -322,7 +322,7 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 
 #endif
 
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+#ifdef CONFIG_SMP
 
 /*
  * Migrate-Disable and why it is undesired.
@@ -382,43 +382,11 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 extern void migrate_disable(void);
 extern void migrate_enable(void);
 
-#elif defined(CONFIG_PREEMPT_RT)
+#else
 
 static inline void migrate_disable(void) { }
 static inline void migrate_enable(void) { }
 
-#else /* !CONFIG_PREEMPT_RT */
-
-/**
- * migrate_disable - Prevent migration of the current task
- *
- * Maps to preempt_disable() which also disables preemption. Use
- * migrate_disable() to annotate that the intent is to prevent migration,
- * but not necessarily preemption.
- *
- * Can be invoked nested like preempt_disable() and needs the corresponding
- * number of migrate_enable() invocations.
- */
-static __always_inline void migrate_disable(void)
-{
-	preempt_disable();
-}
-
-/**
- * migrate_enable - Allow migration of the current task
- *
- * Counterpart to migrate_disable().
- *
- * As migrate_disable() can be invoked nested, only the outermost invocation
- * reenables migration.
- *
- * Currently mapped to preempt_enable().
- */
-static __always_inline void migrate_enable(void)
-{
-	preempt_enable();
-}
-
-#endif /* CONFIG_SMP && CONFIG_PREEMPT_RT */
+#endif /* CONFIG_SMP */
 
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3af9d52..a33f35f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -715,7 +715,7 @@ struct task_struct {
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			cpus_mask;
 	void				*migration_pending;
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+#ifdef CONFIG_SMP
 	unsigned short			migration_disabled;
 #endif
 	unsigned short			migration_flags;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e6473ec..c962922 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1728,8 +1728,6 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 
 #ifdef CONFIG_SMP
 
-#ifdef CONFIG_PREEMPT_RT
-
 static void
 __do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
 
@@ -1800,8 +1798,6 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 	return rq->nr_pinned;
 }
 
-#endif
-
 /*
  * Per-CPU kthreads are allowed to run on !active && online CPUs, see
  * __set_cpus_allowed_ptr() and select_fallback_rq().
@@ -2882,7 +2878,7 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
 	}
 }
 
-#else
+#else /* CONFIG_SMP */
 
 static inline int __set_cpus_allowed_ptr(struct task_struct *p,
 					 const struct cpumask *new_mask,
@@ -2891,10 +2887,6 @@ static inline int __set_cpus_allowed_ptr(struct task_struct *p,
 	return set_cpus_allowed_ptr(p, new_mask);
 }
 
-#endif /* CONFIG_SMP */
-
-#if !defined(CONFIG_SMP) || !defined(CONFIG_PREEMPT_RT)
-
 static inline void migrate_disable_switch(struct rq *rq, struct task_struct *p) { }
 
 static inline bool rq_has_pinned_tasks(struct rq *rq)
@@ -2902,7 +2894,7 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 	return false;
 }
 
-#endif
+#endif /* !CONFIG_SMP */
 
 static void
 ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
@@ -7924,6 +7916,39 @@ void __cant_sleep(const char *file, int line, int preempt_offset)
 	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 }
 EXPORT_SYMBOL_GPL(__cant_sleep);
+
+#ifdef CONFIG_SMP
+void __cant_migrate(const char *file, int line)
+{
+	static unsigned long prev_jiffy;
+
+	if (irqs_disabled())
+		return;
+
+	if (is_migration_disabled(current))
+		return;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
+		return;
+
+	if (preempt_count() > 0)
+		return;
+
+	if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
+		return;
+	prev_jiffy = jiffies;
+
+	pr_err("BUG: assuming non migratable context at %s:%d\n", file, line);
+	pr_err("in_atomic(): %d, irqs_disabled(): %d, migration_disabled() %u pid: %d, name: %s\n",
+	       in_atomic(), irqs_disabled(), is_migration_disabled(current),
+	       current->pid, current->comm);
+
+	debug_show_held_locks(current);
+	dump_stack();
+	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
+}
+EXPORT_SYMBOL_GPL(__cant_migrate);
+#endif
 #endif
 
 #ifdef CONFIG_MAGIC_SYSRQ
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 590e6f2..f5acb6c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1056,7 +1056,7 @@ struct rq {
 	struct cpuidle_state	*idle_state;
 #endif
 
-#if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
+#ifdef CONFIG_SMP
 	unsigned int		nr_pinned;
 #endif
 	unsigned int		push_busy;
@@ -1092,7 +1092,7 @@ static inline int cpu_of(struct rq *rq)
 
 static inline bool is_migration_disabled(struct task_struct *p)
 {
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+#ifdef CONFIG_SMP
 	return p->migration_disabled;
 #else
 	return false;
diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index faaa927..1c1dbd3 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -26,7 +26,7 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	if (current->nr_cpus_allowed == 1)
 		goto out;
 
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+#ifdef CONFIG_SMP
 	if (current->migration_disabled)
 		goto out;
 #endif
