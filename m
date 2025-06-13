Return-Path: <linux-tip-commits+bounces-5809-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4455EAD8490
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FCE3B9C65
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727832ECE9E;
	Fri, 13 Jun 2025 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iIvUNSAL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2euirie0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACFE2EBDDE;
	Fri, 13 Jun 2025 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800255; cv=none; b=EbtQRZb7bMRSQeQtfy/X+m7vEYGqYcNjdikx++T+WPj/mEnUGrj+LufTqvgJZf+VQqmL67W8E+X7aeC9c4lYpvFqwzVwnY6EwhqTOerEUXZWma7vbkqXPmf9YZXAwTzpwq0nuVIvvnUCVf8FI9Av02pcJGuJuBe9IH5KtlQyKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800255; c=relaxed/simple;
	bh=HIJUnWkHFwQKfuiNLxPumwBH73fTtN1sG7qoscIoHdU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nDkIFGyvAIB54+x6oMXM4qsxVqDgg5o1UBKnha3hxMmJfzB5OB4Tox3QR8FLNPFM9a5ySnroUSbhXxKhEhcEUy1MTI5RM/Nt6vxmp2hdjF8a9BQYr5uDQ7dZ1zl1KrWRwmUo3ipuItQ+LUdHd00KbpcMEKnZ/ekI2NvkUEJgt5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iIvUNSAL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2euirie0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800251;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4z9wt04D5RVBAyDUcT6/lkCwZBXRczgnuzlf7/lU+s=;
	b=iIvUNSALsStCtpsbvEIGX9L524Uy+tYpWMqzcfSy0nvWE3nfaFlX9Od+BeQlJZ2cnnJ7dq
	4zgmOejB3zDA4Kf4eGdQlRjs00WJlQWVKaZmTiW8RYNvVq5h2qRhs/KoAD73h3ifpgKOfS
	2KyjK3M4mH4gt+Fsr1xe2g2w0fHkRHB8JtgKos4/7y2SmVCf3FlRj4a/d8vnmIlhNR1nWY
	NxGfHbe1t5drfO4b3mfarj8sFUJJo21jvzb5taAdOjJoWtcxEan7HrHLaCtlj3aV5JstiF
	5gX8J/GqXc/xN81vsU3Aoy9jyOmulSrc59C7Haj5Q23vxS+YM1ZZruzs5TuZLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800251;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4z9wt04D5RVBAyDUcT6/lkCwZBXRczgnuzlf7/lU+s=;
	b=2euirie0XI0BMIMIxn3giTv4JrZ4+ZNNngkValv2DryFS5MyUNQ9BZW2A1MvcLYDWDvvRm
	9AOSlXcnC4lcBNBg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/rt.c
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-15-mingo@kernel.org>
References: <20250528080924.2273858-15-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980025053.406.5771469149502206934.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3eca109a7885903f1bf07099ae89025069017cc0
Gitweb:        https://git.kernel.org/tip/3eca109a7885903f1bf07099ae89025069017cc0
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:17 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/rt.c

 - Use the standard #ifdef marker format for larger blocks,
   where appropriate:

        #if CONFIG_FOO
        ...
        #else /* !CONFIG_FOO: */
        ...
        #endif /* !CONFIG_FOO */

 - Fix whitespace noise and other inconsistencies.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250528080924.2273858-15-mingo@kernel.org
---
 kernel/sched/rt.c | 54 +++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 16008ac..7e8ed05 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -63,7 +63,7 @@ static int __init sched_rt_sysctl_init(void)
 	return 0;
 }
 late_initcall(sched_rt_sysctl_init);
-#endif
+#endif /* CONFIG_SYSCTL */
 
 void init_rt_rq(struct rt_rq *rt_rq)
 {
@@ -294,7 +294,7 @@ err:
 	return 0;
 }
 
-#else /* CONFIG_RT_GROUP_SCHED */
+#else /* !CONFIG_RT_GROUP_SCHED: */
 
 #define rt_entity_is_task(rt_se) (1)
 
@@ -330,7 +330,7 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 {
 	return 1;
 }
-#endif /* CONFIG_RT_GROUP_SCHED */
+#endif /* !CONFIG_RT_GROUP_SCHED */
 
 #ifdef CONFIG_SMP
 
@@ -433,7 +433,7 @@ static void dequeue_pushable_task(struct rq *rq, struct task_struct *p)
 	}
 }
 
-#else
+#else /* !CONFIG_SMP: */
 
 static inline void enqueue_pushable_task(struct rq *rq, struct task_struct *p)
 {
@@ -446,7 +446,7 @@ static inline void dequeue_pushable_task(struct rq *rq, struct task_struct *p)
 static inline void rt_queue_push_tasks(struct rq *rq)
 {
 }
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 
 static void enqueue_top_rt_rq(struct rt_rq *rt_rq);
 static void dequeue_top_rt_rq(struct rt_rq *rt_rq, unsigned int count);
@@ -488,12 +488,12 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
 
 	return cpu_cap >= min(min_cap, max_cap);
 }
-#else
+#else /* !CONFIG_UCLAMP_TASK: */
 static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
 {
 	return true;
 }
-#endif
+#endif /* !CONFIG_UCLAMP_TASK */
 
 #ifdef CONFIG_RT_GROUP_SCHED
 
@@ -801,9 +801,9 @@ static void balance_runtime(struct rt_rq *rt_rq)
 		raw_spin_lock(&rt_rq->rt_runtime_lock);
 	}
 }
-#else /* !CONFIG_SMP */
+#else /* !CONFIG_SMP: */
 static inline void balance_runtime(struct rt_rq *rt_rq) {}
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 
 static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 {
@@ -933,7 +933,7 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 	return 0;
 }
 
-#else /* !CONFIG_RT_GROUP_SCHED */
+#else /* !CONFIG_RT_GROUP_SCHED: */
 
 typedef struct rt_rq *rt_rq_iter_t;
 
@@ -985,7 +985,7 @@ static void __enable_runtime(struct rq *rq) { }
 static void __disable_runtime(struct rq *rq) { }
 #endif
 
-#endif /* CONFIG_RT_GROUP_SCHED */
+#endif /* !CONFIG_RT_GROUP_SCHED */
 
 static inline int rt_se_prio(struct sched_rt_entity *rt_se)
 {
@@ -1036,7 +1036,7 @@ static void update_curr_rt(struct rq *rq)
 				do_start_rt_bandwidth(sched_rt_bandwidth(rt_rq));
 		}
 	}
-#endif
+#endif /* CONFIG_RT_GROUP_SCHED */
 }
 
 static void
@@ -1110,14 +1110,14 @@ dec_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio)
 		cpupri_set(&rq->rd->cpupri, rq->cpu, rt_rq->highest_prio.curr);
 }
 
-#else /* CONFIG_SMP */
+#else /* !CONFIG_SMP: */
 
 static inline
 void inc_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio) {}
 static inline
 void dec_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio) {}
 
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 
 #if defined CONFIG_SMP || defined CONFIG_RT_GROUP_SCHED
 static void
@@ -1158,12 +1158,12 @@ dec_rt_prio(struct rt_rq *rt_rq, int prio)
 	dec_rt_prio_smp(rt_rq, prio, prev_prio);
 }
 
-#else
+#else /* !(CONFIG_SMP || CONFIG_RT_GROUP_SCHED): */
 
 static inline void inc_rt_prio(struct rt_rq *rt_rq, int prio) {}
 static inline void dec_rt_prio(struct rt_rq *rt_rq, int prio) {}
 
-#endif /* CONFIG_SMP || CONFIG_RT_GROUP_SCHED */
+#endif /* !(CONFIG_SMP || CONFIG_RT_GROUP_SCHED) */
 
 #ifdef CONFIG_RT_GROUP_SCHED
 
@@ -1185,7 +1185,7 @@ dec_rt_group(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 	WARN_ON(!rt_rq->rt_nr_running && rt_rq->rt_nr_boosted);
 }
 
-#else /* CONFIG_RT_GROUP_SCHED */
+#else /* !CONFIG_RT_GROUP_SCHED: */
 
 static void
 inc_rt_group(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
@@ -1195,7 +1195,7 @@ inc_rt_group(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 static inline
 void dec_rt_group(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq) {}
 
-#endif /* CONFIG_RT_GROUP_SCHED */
+#endif /* !CONFIG_RT_GROUP_SCHED */
 
 static inline
 unsigned int rt_se_nr_running(struct sched_rt_entity *rt_se)
@@ -1685,7 +1685,7 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	if (p->prio == donor->prio && !test_tsk_need_resched(rq->curr))
 		check_preempt_equal_prio(rq, p);
-#endif
+#endif /* CONFIG_SMP */
 }
 
 static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
@@ -2512,11 +2512,11 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 */
 		if (p->prio > rq->rt.highest_prio.curr)
 			resched_curr(rq);
-#else
+#else /* !CONFIG_SMP: */
 		/* For UP simply resched on drop of prio */
 		if (oldprio < p->prio)
 			resched_curr(rq);
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 	} else {
 		/*
 		 * This task is not running, but if it is
@@ -2552,9 +2552,9 @@ static void watchdog(struct rq *rq, struct task_struct *p)
 		}
 	}
 }
-#else
+#else /* !CONFIG_POSIX_TIMERS: */
 static inline void watchdog(struct rq *rq, struct task_struct *p) { }
-#endif
+#endif /* !CONFIG_POSIX_TIMERS */
 
 /*
  * scheduler tick hitting a task of our scheduling class.
@@ -2623,7 +2623,7 @@ static int task_is_throttled_rt(struct task_struct *p, int cpu)
 
 	return rt_rq_throttled(rt_rq);
 }
-#endif
+#endif /* CONFIG_SCHED_CORE */
 
 DEFINE_SCHED_CLASS(rt) = {
 
@@ -2646,7 +2646,7 @@ DEFINE_SCHED_CLASS(rt) = {
 	.task_woken		= task_woken_rt,
 	.switched_from		= switched_from_rt,
 	.find_lock_rq		= find_lock_lowest_rq,
-#endif
+#endif /* !CONFIG_SMP */
 
 	.task_tick		= task_tick_rt,
 
@@ -2890,7 +2890,7 @@ int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)
 	return 1;
 }
 
-#else /* !CONFIG_RT_GROUP_SCHED */
+#else /* !CONFIG_RT_GROUP_SCHED: */
 
 #ifdef CONFIG_SYSCTL
 static int sched_rt_global_constraints(void)
@@ -2898,7 +2898,7 @@ static int sched_rt_global_constraints(void)
 	return 0;
 }
 #endif /* CONFIG_SYSCTL */
-#endif /* CONFIG_RT_GROUP_SCHED */
+#endif /* !CONFIG_RT_GROUP_SCHED */
 
 #ifdef CONFIG_SYSCTL
 static int sched_rt_global_validate(void)

