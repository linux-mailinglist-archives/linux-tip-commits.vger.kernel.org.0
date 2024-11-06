Return-Path: <linux-tip-commits+bounces-2770-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7DB9BE4C6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE55285FB5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F43B1E009F;
	Wed,  6 Nov 2024 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aLzRbVPV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4rKQHIqU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A521DEFE0;
	Wed,  6 Nov 2024 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890132; cv=none; b=IAFC0htHNEDorz4gixmSDWYrD1I91iwVYrenQ29SOfcc1MuEVSS546dVs5GIFUZeUoIEb52eoF+yZYXStN73ed9lLWuA0UqGFvIwPcTTi4p0igvSvOuvBktZLqbFlTnhv3v5nVbD7SBtQQ0m55BSuHCmtZTzEo4ZSNZedBy18bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890132; c=relaxed/simple;
	bh=2rzKUIevnZ/xKNxWryK+VOqqFemXcNuRExAMaKoG+rs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iJNOWs2Tz3kGKgF5LfB9CFCG0l2p/JTicTORmcmR7ApGBZEqiQJkvOAeJebwSqprpwyWpbonSr6wd4IBdnOslhuEdRBTeQp65zUt58U6Jp1lcjglP9gsl3BD1z8SU2Z2UaXVtGDAQxMjfpx2h9Khrm4lNvIE9KOwCMjK7eCvp8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aLzRbVPV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4rKQHIqU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:48:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrfhrbMl7vKD74OVMhpO5HTFUFpHsB/Unhe0giyRPrE=;
	b=aLzRbVPVCpyMv59nap+H18XEyLTiYka+GR70CoTb4zCfN2ntsPAqI7vwXm+IrjpHD3UUUq
	cbvP1mERsvL8o4U2A5U/EcUxNgncSpNI7FF8/Axe6qpUnwA1MZ4ouq6jYt1lZtAkEOf6BE
	QMW+KvBKEaIS/JLTlgg58oZuiqhn99q+ml3YMEgkNiq2UAeowlf3p5ubhtQeRqImvC6+x/
	KVNx5sBWhLTUQLTPa0D4wrt1vlR2q1vjZh0T4OaeYXYn2Fn88XRTPhVPBZUAJzSBwAxBPV
	1DlWkO22KXMuNQDKs8z9kmiMlX3THeB4R6o2qVgcfTJmthGu09gQ6kyjc4RxLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrfhrbMl7vKD74OVMhpO5HTFUFpHsB/Unhe0giyRPrE=;
	b=4rKQHIqUNaGnyCqbZrOvwBAKy9ZhFCeNWVre9E9Hpo6YmY0P+iu4B9J7wGeUhwljFMy1/u
	oTHKXi6ZrMgXF3DA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add Lazy preemption model
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007075055.331243614@infradead.org>
References: <20241007075055.331243614@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089012712.32228.11696401567312549799.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7c70cb94d29cd325fabe4a818c18613e3b9919a1
Gitweb:        https://git.kernel.org/tip/7c70cb94d29cd325fabe4a818c18613e3b9919a1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 04 Oct 2024 14:46:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:38 +01:00

sched: Add Lazy preemption model

Change fair to use resched_curr_lazy(), which, when the lazy
preemption model is selected, will set TIF_NEED_RESCHED_LAZY.

This LAZY bit will be promoted to the full NEED_RESCHED bit on tick.
As such, the average delay between setting LAZY and actually
rescheduling will be TICK_NSEC/2.

In short, Lazy preemption will delay preemption for fair class but
will function as Full preemption for all the other classes, most
notably the realtime (RR/FIFO/DEADLINE) classes.

The goal is to bridge the performance gap with Voluntary, such that we
might eventually remove that option entirely.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lkml.kernel.org/r/20241007075055.331243614@infradead.org
---
 include/linux/preempt.h |  8 +++-
 kernel/Kconfig.preempt  | 15 ++++++++-
 kernel/sched/core.c     | 80 +++++++++++++++++++++++++++++++++++++++-
 kernel/sched/debug.c    |  5 +--
 kernel/sched/fair.c     |  6 +--
 kernel/sched/sched.h    |  1 +-
 6 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index ce76f1a..ca86235 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -486,6 +486,7 @@ DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
 extern bool preempt_model_none(void);
 extern bool preempt_model_voluntary(void);
 extern bool preempt_model_full(void);
+extern bool preempt_model_lazy(void);
 
 #else
 
@@ -502,6 +503,11 @@ static inline bool preempt_model_full(void)
 	return IS_ENABLED(CONFIG_PREEMPT);
 }
 
+static inline bool preempt_model_lazy(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_LAZY);
+}
+
 #endif
 
 static inline bool preempt_model_rt(void)
@@ -519,7 +525,7 @@ static inline bool preempt_model_rt(void)
  */
 static inline bool preempt_model_preemptible(void)
 {
-	return preempt_model_full() || preempt_model_rt();
+	return preempt_model_full() || preempt_model_lazy() || preempt_model_rt();
 }
 
 #endif /* __LINUX_PREEMPT_H */
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index fe782cd..09f06d8 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -11,6 +11,9 @@ config PREEMPT_BUILD
 	select PREEMPTION
 	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
 
+config ARCH_HAS_PREEMPT_LAZY
+	bool
+
 choice
 	prompt "Preemption Model"
 	default PREEMPT_NONE
@@ -67,6 +70,18 @@ config PREEMPT
 	  embedded system with latency requirements in the milliseconds
 	  range.
 
+config PREEMPT_LAZY
+	bool "Scheduler controlled preemption model"
+	depends on !ARCH_NO_PREEMPT
+	depends on ARCH_HAS_PREEMPT_LAZY
+	select PREEMPT_BUILD
+	help
+	  This option provides a scheduler driven preemption model that
+	  is fundamentally similar to full preemption, but is less
+	  eager to preempt SCHED_NORMAL tasks in an attempt to
+	  reduce lock holder preemption and recover some of the performance
+	  gains seen from using Voluntary preemption.
+
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
 	depends on EXPERT && ARCH_SUPPORTS_RT
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0cd05e3..df6a34d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1083,6 +1083,13 @@ static void __resched_curr(struct rq *rq, int tif)
 
 	lockdep_assert_rq_held(rq);
 
+	/*
+	 * Always immediately preempt the idle task; no point in delaying doing
+	 * actual work.
+	 */
+	if (is_idle_task(curr) && tif == TIF_NEED_RESCHED_LAZY)
+		tif = TIF_NEED_RESCHED;
+
 	if (cti->flags & ((1 << tif) | _TIF_NEED_RESCHED))
 		return;
 
@@ -1108,6 +1115,32 @@ void resched_curr(struct rq *rq)
 	__resched_curr(rq, TIF_NEED_RESCHED);
 }
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+static DEFINE_STATIC_KEY_FALSE(sk_dynamic_preempt_lazy);
+static __always_inline bool dynamic_preempt_lazy(void)
+{
+	return static_branch_unlikely(&sk_dynamic_preempt_lazy);
+}
+#else
+static __always_inline bool dynamic_preempt_lazy(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_LAZY);
+}
+#endif
+
+static __always_inline int get_lazy_tif_bit(void)
+{
+	if (dynamic_preempt_lazy())
+		return TIF_NEED_RESCHED_LAZY;
+
+	return TIF_NEED_RESCHED;
+}
+
+void resched_curr_lazy(struct rq *rq)
+{
+	__resched_curr(rq, get_lazy_tif_bit());
+}
+
 void resched_cpu(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -5612,6 +5645,10 @@ void sched_tick(void)
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
+
+	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
+		resched_curr(rq);
+
 	donor->sched_class->task_tick(rq, donor, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
@@ -7374,6 +7411,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
  *   preempt_schedule           <- NOP
  *   preempt_schedule_notrace   <- NOP
  *   irqentry_exit_cond_resched <- NOP
+ *   dynamic_preempt_lazy       <- false
  *
  * VOLUNTARY:
  *   cond_resched               <- __cond_resched
@@ -7381,6 +7419,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
  *   preempt_schedule           <- NOP
  *   preempt_schedule_notrace   <- NOP
  *   irqentry_exit_cond_resched <- NOP
+ *   dynamic_preempt_lazy       <- false
  *
  * FULL:
  *   cond_resched               <- RET0
@@ -7388,6 +7427,15 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
  *   preempt_schedule           <- preempt_schedule
  *   preempt_schedule_notrace   <- preempt_schedule_notrace
  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ *   dynamic_preempt_lazy       <- false
+ *
+ * LAZY:
+ *   cond_resched               <- RET0
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- preempt_schedule
+ *   preempt_schedule_notrace   <- preempt_schedule_notrace
+ *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ *   dynamic_preempt_lazy       <- true
  */
 
 enum {
@@ -7395,6 +7443,7 @@ enum {
 	preempt_dynamic_none,
 	preempt_dynamic_voluntary,
 	preempt_dynamic_full,
+	preempt_dynamic_lazy,
 };
 
 int preempt_dynamic_mode = preempt_dynamic_undefined;
@@ -7410,15 +7459,23 @@ int sched_dynamic_mode(const char *str)
 	if (!strcmp(str, "full"))
 		return preempt_dynamic_full;
 
+#ifdef CONFIG_ARCH_HAS_PREEMPT_LAZY
+	if (!strcmp(str, "lazy"))
+		return preempt_dynamic_lazy;
+#endif
+
 	return -EINVAL;
 }
 
+#define preempt_dynamic_key_enable(f)	static_key_enable(&sk_dynamic_##f.key)
+#define preempt_dynamic_key_disable(f)	static_key_disable(&sk_dynamic_##f.key)
+
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
 #define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-#define preempt_dynamic_enable(f)	static_key_enable(&sk_dynamic_##f.key)
-#define preempt_dynamic_disable(f)	static_key_disable(&sk_dynamic_##f.key)
+#define preempt_dynamic_enable(f)	preempt_dynamic_key_enable(f)
+#define preempt_dynamic_disable(f)	preempt_dynamic_key_disable(f)
 #else
 #error "Unsupported PREEMPT_DYNAMIC mechanism"
 #endif
@@ -7438,6 +7495,7 @@ static void __sched_dynamic_update(int mode)
 	preempt_dynamic_enable(preempt_schedule);
 	preempt_dynamic_enable(preempt_schedule_notrace);
 	preempt_dynamic_enable(irqentry_exit_cond_resched);
+	preempt_dynamic_key_disable(preempt_lazy);
 
 	switch (mode) {
 	case preempt_dynamic_none:
@@ -7447,6 +7505,7 @@ static void __sched_dynamic_update(int mode)
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
+		preempt_dynamic_key_disable(preempt_lazy);
 		if (mode != preempt_dynamic_mode)
 			pr_info("Dynamic Preempt: none\n");
 		break;
@@ -7458,6 +7517,7 @@ static void __sched_dynamic_update(int mode)
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
+		preempt_dynamic_key_disable(preempt_lazy);
 		if (mode != preempt_dynamic_mode)
 			pr_info("Dynamic Preempt: voluntary\n");
 		break;
@@ -7469,9 +7529,22 @@ static void __sched_dynamic_update(int mode)
 		preempt_dynamic_enable(preempt_schedule);
 		preempt_dynamic_enable(preempt_schedule_notrace);
 		preempt_dynamic_enable(irqentry_exit_cond_resched);
+		preempt_dynamic_key_disable(preempt_lazy);
 		if (mode != preempt_dynamic_mode)
 			pr_info("Dynamic Preempt: full\n");
 		break;
+
+	case preempt_dynamic_lazy:
+		if (!klp_override)
+			preempt_dynamic_disable(cond_resched);
+		preempt_dynamic_disable(might_resched);
+		preempt_dynamic_enable(preempt_schedule);
+		preempt_dynamic_enable(preempt_schedule_notrace);
+		preempt_dynamic_enable(irqentry_exit_cond_resched);
+		preempt_dynamic_key_enable(preempt_lazy);
+		if (mode != preempt_dynamic_mode)
+			pr_info("Dynamic Preempt: lazy\n");
+		break;
 	}
 
 	preempt_dynamic_mode = mode;
@@ -7534,6 +7607,8 @@ static void __init preempt_dynamic_init(void)
 			sched_dynamic_update(preempt_dynamic_none);
 		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
 			sched_dynamic_update(preempt_dynamic_voluntary);
+		} else if (IS_ENABLED(CONFIG_PREEMPT_LAZY)) {
+			sched_dynamic_update(preempt_dynamic_lazy);
 		} else {
 			/* Default static call setting, nothing to do */
 			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
@@ -7554,6 +7629,7 @@ static void __init preempt_dynamic_init(void)
 PREEMPT_MODEL_ACCESSOR(none);
 PREEMPT_MODEL_ACCESSOR(voluntary);
 PREEMPT_MODEL_ACCESSOR(full);
+PREEMPT_MODEL_ACCESSOR(lazy);
 
 #else /* !CONFIG_PREEMPT_DYNAMIC: */
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f4035c7..44a49f9 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -245,11 +245,12 @@ static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
 static int sched_dynamic_show(struct seq_file *m, void *v)
 {
 	static const char * preempt_modes[] = {
-		"none", "voluntary", "full"
+		"none", "voluntary", "full", "lazy",
 	};
+	int j = ARRAY_SIZE(preempt_modes) - !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(preempt_modes); i++) {
+	for (i = 0; i < j; i++) {
 		if (preempt_dynamic_mode == i)
 			seq_puts(m, "(");
 		seq_puts(m, preempt_modes[i]);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6512258..3356315 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1251,7 +1251,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 		return;
 
 	if (resched || did_preempt_short(cfs_rq, curr)) {
-		resched_curr(rq);
+		resched_curr_lazy(rq);
 		clear_buddies(cfs_rq, curr);
 	}
 }
@@ -5677,7 +5677,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	 * validating it and just reschedule.
 	 */
 	if (queued) {
-		resched_curr(rq_of(cfs_rq));
+		resched_curr_lazy(rq_of(cfs_rq));
 		return;
 	}
 #endif
@@ -8829,7 +8829,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int 
 	return;
 
 preempt:
-	resched_curr(rq);
+	resched_curr_lazy(rq);
 }
 
 static struct task_struct *pick_task_fair(struct rq *rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e51bf5a..090dd4b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2689,6 +2689,7 @@ extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
 extern void resched_curr(struct rq *rq);
+extern void resched_curr_lazy(struct rq *rq);
 extern void resched_cpu(int cpu);
 
 extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);

