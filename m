Return-Path: <linux-tip-commits+bounces-2620-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6523D9B31A7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Oct 2024 14:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6A0BB21ED8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Oct 2024 13:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6DF1DB34E;
	Mon, 28 Oct 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CMkCiwoL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XQQXXReT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8038338396;
	Mon, 28 Oct 2024 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122118; cv=none; b=P9aiBDZVa6RWR5ZXnIL2KpjlShjC9CCRj85z/AGUY3yF4p/jnhPwdHk9p5vvGwUk9Iwk9Y7/is5O6n7WY7HThXVkTyO+aqRewrwIUV6lJGjl0o1kL1UMpvFFWdXI80jY/F1pIn9PzP1RmYUKURBlg5z2Gszf6xZQpYWDtZFpdWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122118; c=relaxed/simple;
	bh=J/gl99HWXzuSGpNCy7NnyOwOzr8RZTVAkWXPuxRaE28=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ED+hJLRpvKouVZbHMDUrpwH+3HkALHZIQ4LdUf/46kTUD1h1y3QLAii1mfdH8ZtFYxqRUeRCUMtT8/AWzoduqf98qNa7Fe2zPj0BtOQm76PPYAmdPgqmIdn5Z3S7LcTcPkLRtXmpGU65XIAJPeQTWGX65iJYY77kY/GiSV/NzsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CMkCiwoL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XQQXXReT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 28 Oct 2024 13:28:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730122113;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qKFz2n+nki82LW7I/fMzdeeOaX1ZuqP/LX7NJxmMCE=;
	b=CMkCiwoLlHaR5+MiKC6+r7K3SL0K0OfwrdCMpmx4RqXPuuFgrY0yccq8Epo2wqgArqlKFC
	hKnK33MzBkSpD1XG5vW/dbmSu7CNqBkzYDtI5kBpzLq8H6VhTu3WbxLaGLlg4Qqe0+lQ7E
	5XcCu8vlAgPBwfApqBGUhQmUiQewkD4Iu+J15pFG0KlziTFQ/Wx1aZ9FYcaHxHaTriU9aM
	KlynfjMmdzuKGWHok6KR4//GPGh+uTCBjBys0qykXhhWqj8BoQ58aj+qOL79zh4/41TQOg
	h5grfA+iuv/B8GVFrJI/VNxCyQyXLq2opVbXpxXH1zncIWOWKvyolUKF53SSrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730122113;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qKFz2n+nki82LW7I/fMzdeeOaX1ZuqP/LX7NJxmMCE=;
	b=XQQXXReTZy8rC4o3pz4PZ7pPEVTJVvFnYET5W3ugnBNJJT4vwTGZ2hrawaMlA/SmDtZ7Rb
	Gh2qZNhq+bGH3iAQ==
From: "tip-bot2 for Johannes Weiner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: psi: pass enqueue/dequeue flags to psi
 callbacks directly
Cc: Peter Zijlstra <peterz@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241014144358.GB1021@cmpxchg.org>
References: <20241014144358.GB1021@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173012211301.1442.2696306655704816115.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1a6151017ee5a30cb2d959f110ab18fc49646467
Gitweb:        https://git.kernel.org/tip/1a6151017ee5a30cb2d959f110ab18fc49646467
Author:        Johannes Weiner <hannes@cmpxchg.org>
AuthorDate:    Mon, 14 Oct 2024 10:43:58 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 26 Oct 2024 09:28:38 +02:00

sched: psi: pass enqueue/dequeue flags to psi callbacks directly

What psi needs to do on each enqueue and dequeue has gotten more
subtle, and the generic sched code trying to distill this into a bool
for the callbacks is awkward.

Pass the flags directly and let psi parse them. For that to work, the
#include "stats.h" (which has the psi callback implementations) needs
to be below the flag definitions in "sched.h". Move that section
further down, next to some of the other accounting stuff.

This also puts the ENQUEUE_SAVE/RESTORE branch behind the psi jump
label, slightly reducing overhead when PSI=y but runtime disabled.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241014144358.GB1021@cmpxchg.org
---
 kernel/sched/core.c  | 12 ++++-----
 kernel/sched/sched.h | 56 +++++++++++++++++++++----------------------
 kernel/sched/stats.h | 29 ++++++++++++++--------
 3 files changed, 53 insertions(+), 44 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9bad282..c57a79e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2024,10 +2024,10 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	uclamp_rq_inc(rq, p);
 
-	if (!(flags & ENQUEUE_RESTORE)) {
+	psi_enqueue(p, flags);
+
+	if (!(flags & ENQUEUE_RESTORE))
 		sched_info_enqueue(rq, p);
-		psi_enqueue(p, flags & ENQUEUE_MIGRATED);
-	}
 
 	if (sched_core_enabled(rq))
 		sched_core_enqueue(rq, p);
@@ -2044,10 +2044,10 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & DEQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
-	if (!(flags & DEQUEUE_SAVE)) {
+	if (!(flags & DEQUEUE_SAVE))
 		sched_info_dequeue(rq, p);
-		psi_dequeue(p, !(flags & DEQUEUE_SLEEP));
-	}
+
+	psi_dequeue(p, flags);
 
 	/*
 	 * Must be before ->dequeue_task() because ->dequeue_task() can 'fail'
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7b13901..e51bf5a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2093,34 +2093,6 @@ static inline const struct cpumask *task_user_cpus(struct task_struct *p)
 
 #endif /* CONFIG_SMP */
 
-#include "stats.h"
-
-#if defined(CONFIG_SCHED_CORE) && defined(CONFIG_SCHEDSTATS)
-
-extern void __sched_core_account_forceidle(struct rq *rq);
-
-static inline void sched_core_account_forceidle(struct rq *rq)
-{
-	if (schedstat_enabled())
-		__sched_core_account_forceidle(rq);
-}
-
-extern void __sched_core_tick(struct rq *rq);
-
-static inline void sched_core_tick(struct rq *rq)
-{
-	if (sched_core_enabled(rq) && schedstat_enabled())
-		__sched_core_tick(rq);
-}
-
-#else /* !(CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS): */
-
-static inline void sched_core_account_forceidle(struct rq *rq) { }
-
-static inline void sched_core_tick(struct rq *rq) { }
-
-#endif /* !(CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS) */
-
 #ifdef CONFIG_CGROUP_SCHED
 
 /*
@@ -3191,6 +3163,34 @@ extern void nohz_run_idle_balance(int cpu);
 static inline void nohz_run_idle_balance(int cpu) { }
 #endif
 
+#include "stats.h"
+
+#if defined(CONFIG_SCHED_CORE) && defined(CONFIG_SCHEDSTATS)
+
+extern void __sched_core_account_forceidle(struct rq *rq);
+
+static inline void sched_core_account_forceidle(struct rq *rq)
+{
+	if (schedstat_enabled())
+		__sched_core_account_forceidle(rq);
+}
+
+extern void __sched_core_tick(struct rq *rq);
+
+static inline void sched_core_tick(struct rq *rq)
+{
+	if (sched_core_enabled(rq) && schedstat_enabled())
+		__sched_core_tick(rq);
+}
+
+#else /* !(CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS): */
+
+static inline void sched_core_account_forceidle(struct rq *rq) { }
+
+static inline void sched_core_tick(struct rq *rq) { }
+
+#endif /* !(CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS) */
+
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 
 struct irqtime {
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 767e098..8ee0add 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -127,21 +127,25 @@ static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
  * go through migration requeues. In this case, *sleeping* states need
  * to be transferred.
  */
-static inline void psi_enqueue(struct task_struct *p, bool migrate)
+static inline void psi_enqueue(struct task_struct *p, int flags)
 {
 	int clear = 0, set = 0;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
 
+	/* Same runqueue, nothing changed for psi */
+	if (flags & ENQUEUE_RESTORE)
+		return;
+
 	if (p->se.sched_delayed) {
 		/* CPU migration of "sleeping" task */
-		SCHED_WARN_ON(!migrate);
+		SCHED_WARN_ON(!(flags & ENQUEUE_MIGRATED));
 		if (p->in_memstall)
 			set |= TSK_MEMSTALL;
 		if (p->in_iowait)
 			set |= TSK_IOWAIT;
-	} else if (migrate) {
+	} else if (flags & ENQUEUE_MIGRATED) {
 		/* CPU migration of runnable task */
 		set = TSK_RUNNING;
 		if (p->in_memstall)
@@ -158,17 +162,14 @@ static inline void psi_enqueue(struct task_struct *p, bool migrate)
 	psi_task_change(p, clear, set);
 }
 
-static inline void psi_dequeue(struct task_struct *p, bool migrate)
+static inline void psi_dequeue(struct task_struct *p, int flags)
 {
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	/*
-	 * When migrating a task to another CPU, clear all psi
-	 * state. The enqueue callback above will work it out.
-	 */
-	if (migrate)
-		psi_task_change(p, p->psi_flags, 0);
+	/* Same runqueue, nothing changed for psi */
+	if (flags & DEQUEUE_SAVE)
+		return;
 
 	/*
 	 * A voluntary sleep is a dequeue followed by a task switch. To
@@ -176,6 +177,14 @@ static inline void psi_dequeue(struct task_struct *p, bool migrate)
 	 * TSK_RUNNING and TSK_IOWAIT for us when it moves TSK_ONCPU.
 	 * Do nothing here.
 	 */
+	if (flags & DEQUEUE_SLEEP)
+		return;
+
+	/*
+	 * When migrating a task to another CPU, clear all psi
+	 * state. The enqueue callback above will work it out.
+	 */
+	psi_task_change(p, p->psi_flags, 0);
 }
 
 static inline void psi_ttwu_dequeue(struct task_struct *p)

