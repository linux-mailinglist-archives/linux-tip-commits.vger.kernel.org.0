Return-Path: <linux-tip-commits+bounces-5815-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE62AD8499
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F41316FBD9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0C12F363B;
	Fri, 13 Jun 2025 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YqDvT9Nm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HTDbstNW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29902ED878;
	Fri, 13 Jun 2025 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800261; cv=none; b=ALGjBIZr3N/JJvz3DTu2XK3iOb2oSdZpDFw1K8atAmzjUP2RZp8QUxB0GwbXuwAc0ULZ+j3wyK5/UZVu4OUN1/fncrVaR+UfGeg9OMLOjLI0Ugb0HMwjCRv9FCZd9nPH/ix9ta53vZC2OgDLx0yB4JTosbFPl6fM4Ih2Iw8MlPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800261; c=relaxed/simple;
	bh=PSxIWv0LHa7/3hvJsJDaa/NPJS6C5r7oz615g4F1wn8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NMAHnXxnijSFYkRu46aLO+8u53FVK7SPe093ekndyRK2Nt7TJ4hb5Cr8YTsqqnQwKaMN5jCNFmF8O5sRaA5VSCvgm915IZpdQ+KEOmGbjkpApgztsJZDTiAfdouaJ/clisyoUErS2TriyeKzWzIvTYcUJVMu4FUOoc7ktZiLekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YqDvT9Nm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HTDbstNW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800257;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZ58HqD6nFcmI7LKIhCbH2sdzRCQIPbKxn/i8LaQ6nc=;
	b=YqDvT9NmGr+E17C6pej9qgi8x4TlmJzgC5kcc4gDM9GL1ty1cQ+XOOy23x0sxdRIX4fm37
	+iMv8LqoSkJGF48auS6LWhO276M8x7LhTgXt+S9Jfa90puJaGD56xWvpllD1UNXuri5wz/
	avqIuwMPmr49qv81L4ZGbxteMU7KS3NMPjfG3ddYv8X3YQnsESpuK2xEWfoWo0OQjReNuR
	GXhPoWJg+REGciXHY4WRGp+y+a+cuQ4n10ZpbTOcD9oFJcczma3rIGlXVLw9dgCAi2agWJ
	/GtkbHczKsP+j22Qg+S3fN47waH7JhlhJUmtfjzUo3wm7Q/roUU1lsHlIBKBEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800257;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZ58HqD6nFcmI7LKIhCbH2sdzRCQIPbKxn/i8LaQ6nc=;
	b=HTDbstNWM5NLov4fZzGYPq6aFtBnMoiQ4gc4dt+UZIplgDVSaewFtAgE+cbFR3rhaI/YNF
	4+n305AuzWHq0yBA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/deadline.c
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-8-mingo@kernel.org>
References: <20250528080924.2273858-8-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980025635.406.17057485786628792654.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c503c3dc2d49dbca2cec531ca8f1b8e9143c5087
Gitweb:        https://git.kernel.org/tip/c503c3dc2d49dbca2cec531ca8f1b8e9143c5087
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:16 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/deadline.c

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
Link: https://lore.kernel.org/r/20250528080924.2273858-8-mingo@kernel.org
---
 kernel/sched/deadline.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ff5be80..a2cea68 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -55,7 +55,7 @@ static int __init sched_dl_sysctl_init(void)
 	return 0;
 }
 late_initcall(sched_dl_sysctl_init);
-#endif
+#endif /* CONFIG_SYSCTL */
 
 static bool dl_server(struct sched_dl_entity *dl_se)
 {
@@ -103,7 +103,7 @@ static inline bool is_dl_boosted(struct sched_dl_entity *dl_se)
 {
 	return pi_of(dl_se) != dl_se;
 }
-#else
+#else /* !CONFIG_RT_MUTEXES: */
 static inline struct sched_dl_entity *pi_of(struct sched_dl_entity *dl_se)
 {
 	return dl_se;
@@ -113,7 +113,7 @@ static inline bool is_dl_boosted(struct sched_dl_entity *dl_se)
 {
 	return false;
 }
-#endif
+#endif /* !CONFIG_RT_MUTEXES */
 
 #ifdef CONFIG_SMP
 static inline struct dl_bw *dl_bw_of(int i)
@@ -195,7 +195,7 @@ void __dl_update(struct dl_bw *dl_b, s64 bw)
 		rq->dl.extra_bw += bw;
 	}
 }
-#else
+#else /* !CONFIG_SMP: */
 static inline struct dl_bw *dl_bw_of(int i)
 {
 	return &cpu_rq(i)->dl.dl_bw;
@@ -223,7 +223,7 @@ void __dl_update(struct dl_bw *dl_b, s64 bw)
 
 	dl->extra_bw += bw;
 }
-#endif
+#endif /* !CONFIG_SMP */
 
 static inline
 void __dl_sub(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
@@ -757,7 +757,7 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 	return later_rq;
 }
 
-#else
+#else /* !CONFIG_SMP: */
 
 static inline
 void enqueue_pushable_dl_task(struct rq *rq, struct task_struct *p)
@@ -786,7 +786,7 @@ static inline void deadline_queue_push_tasks(struct rq *rq)
 static inline void deadline_queue_pull_task(struct rq *rq)
 {
 }
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 
 static void
 enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags);
@@ -1213,7 +1213,7 @@ static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
 		push_dl_task(rq);
 		rq_repin_lock(rq, rf);
 	}
-#endif
+#endif /* CONFIG_SMP */
 }
 
 /* a defer timer will not be reset if the runtime consumed was < dl_server_min_res */
@@ -1360,7 +1360,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 		 * there.
 		 */
 	}
-#endif
+#endif /* CONFIG_SMP */
 
 	enqueue_task_dl(rq, p, ENQUEUE_REPLENISH);
 	if (dl_task(rq->donor))
@@ -1602,7 +1602,7 @@ throttle:
 			rt_rq->rt_time += delta_exec;
 		raw_spin_unlock(&rt_rq->rt_runtime_lock);
 	}
-#endif
+#endif /* CONFIG_RT_GROUP_SCHED */
 }
 
 /*
@@ -1885,12 +1885,12 @@ static void dec_dl_deadline(struct dl_rq *dl_rq, u64 deadline)
 	}
 }
 
-#else
+#else /* !CONFIG_SMP: */
 
 static inline void inc_dl_deadline(struct dl_rq *dl_rq, u64 deadline) {}
 static inline void dec_dl_deadline(struct dl_rq *dl_rq, u64 deadline) {}
 
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 
 static inline
 void inc_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
@@ -2379,11 +2379,11 @@ static void start_hrtick_dl(struct rq *rq, struct sched_dl_entity *dl_se)
 {
 	hrtick_start(rq, dl_se->runtime);
 }
-#else /* !CONFIG_SCHED_HRTICK */
+#else /* !CONFIG_SCHED_HRTICK: */
 static void start_hrtick_dl(struct rq *rq, struct sched_dl_entity *dl_se)
 {
 }
-#endif
+#endif /* !CONFIG_SCHED_HRTICK */
 
 static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 {
@@ -3125,13 +3125,13 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 		    dl_time_before(p->dl.deadline, rq->curr->dl.deadline))
 			resched_curr(rq);
 	}
-#else
+#else /* !CONFIG_SMP: */
 	/*
 	 * We don't know if p has a earlier or later deadline, so let's blindly
 	 * set a (maybe not needed) rescheduling point.
 	 */
 	resched_curr(rq);
-#endif
+#endif /* !CONFIG_SMP */
 }
 
 #ifdef CONFIG_SCHED_CORE
@@ -3162,7 +3162,7 @@ DEFINE_SCHED_CLASS(dl) = {
 	.rq_offline             = rq_offline_dl,
 	.task_woken		= task_woken_dl,
 	.find_lock_rq		= find_lock_later_rq,
-#endif
+#endif /* CONFIG_SMP */
 
 	.task_tick		= task_tick_dl,
 	.task_fork              = task_fork_dl,
@@ -3574,7 +3574,7 @@ void dl_bw_free(int cpu, u64 dl_bw)
 {
 	dl_bw_manage(dl_bw_req_free, cpu, dl_bw);
 }
-#endif
+#endif /* CONFIG_SMP */
 
 void print_dl_stats(struct seq_file *m, int cpu)
 {

