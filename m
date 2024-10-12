Return-Path: <linux-tip-commits+bounces-2401-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 577B099B568
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Oct 2024 16:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAFA0B22439
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Oct 2024 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120C01946C4;
	Sat, 12 Oct 2024 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oNS3S2ng";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RXrqT5IO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE371474D9;
	Sat, 12 Oct 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742570; cv=none; b=DhJqDuZcZO3xUPs9aZSbK7tgfosB8bHH3BcRJzO9Ci6kXLJ9B/wwQvHhYQdIF+0R547VIQDMM5NqWdCeD0gn3pf1qI9J2yPYSKt3LiR0rVdieSSFD8otAwnlzJym5RlWv+IiYYloVLB7vJdxQo1BpyV0MDuKHmuQXyhtU6WUfGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742570; c=relaxed/simple;
	bh=N1qI1F7vE3r72MHL1rh6NIgv3xfuzn5nHGvZ45uQDAg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eJ2FTyh4T73E+dCWBENeAj1w+qMM4q8lq8xgkq/QeFqgD6Gxn2AOxnvHExRwOTVOTOOwNxH/L9vTt+jAvZ+Sgy/XXq0urc0bkA435vIMjp5X6m+Xsffutwr3u0NJwWP5gLMrtXe4jLjZhi8zSz3B3BOAQkEsBmzFRJSe4bl9iFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oNS3S2ng; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RXrqT5IO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Oct 2024 14:15:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728742559;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Edq6xgbCyNcZWuBXliqH7XwpUJ6JsIScgzJ2xC9/vwA=;
	b=oNS3S2ngGHvamOEEeDQS5wQ8B4U5/CtFXtUKWvDGTS14s1PsZq+A121muY8xzxlUk+t1cs
	uo24QcoG1rbKKpfX8VqWDEYmUfPtH7iKTstaO4BttOpOtcMf/Ilh6d6O2UFQ387/jKHDpO
	e+XdA+4tJgsOdEsTyrQLM3hzzHcSGxDIKVTdpEV0yygrxG0OHTpjGlMpHhtxbUD4FG1eRZ
	RQ/UawWh70Uda2zHc6SpGBo/P3mYc0VR2Od80BSiO6qZbEFv4cOAAGUrCLANVYCtKBFUzO
	9EmMI0INJ2s3X9sUAB4fKiFuF7f28JqbbphgSRqvFdAGG+lGJmjx5ctYSjFHPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728742559;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Edq6xgbCyNcZWuBXliqH7XwpUJ6JsIScgzJ2xC9/vwA=;
	b=RXrqT5IOnSQkfiDNscl2R52gLc1ge9zfO2/t7pQyW6yoRW5Y3flfnzppUd+Kl4iF01aWCA
	+gsIXPVHjg8m6wAg==
From: "tip-bot2 for Johannes Weiner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] Since sched_delayed tasks remain queued even
 after blocking, the load
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241010193712.GC181795@cmpxchg.org>
References: <20241010193712.GC181795@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172874255900.1442.15057813607707554977.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     f2c9767170bead8d0ceb9c01d074c6916350310d
Gitweb:        https://git.kernel.org/tip/f2c9767170bead8d0ceb9c01d074c6916350310d
Author:        Johannes Weiner <hannes@cmpxchg.org>
AuthorDate:    Fri, 11 Oct 2024 10:49:33 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Oct 2024 10:49:33 +02:00

Since sched_delayed tasks remain queued even after blocking, the load
balancer can migrate them between runqueues while PSI considers them
to be asleep. As a result, it misreads the migration requeue followed
by a wakeup as a double queue:

  psi: inconsistent task state! task=... cpu=... psi_flags=4 clear=. set=4

First, call psi_enqueue() after p->sched_class->enqueue_task(). A
wakeup will clear p->se.sched_delayed while a migration will not, so
psi can use that flag to tell them apart.

Then teach psi to migrate any "sleep" state when delayed-dequeue tasks
are being migrated.

Delayed-dequeue tasks can be revived by ttwu_runnable(), which will
call down with a new ENQUEUE_DELAYED. Instead of further complicating
the wakeup conditional in enqueue_task(), identify migration contexts
instead and default to wakeup handling for all other cases.

Debugged-by-and-original-fix-by: K Prateek Nayak <kprateek.nayak@amd.com>
Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Closes: https://lore.kernel.org/lkml/20240830123458.3557-1-spasswolf@web.de/
Closes: https://lore.kernel.org/all/cd67fbcd-d659-4822-bb90-7e8fbb40a856@molgen.mpg.de/
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lkml.kernel.org/r/20241010193712.GC181795@cmpxchg.org
---
 kernel/sched/core.c  | 12 +++++------
 kernel/sched/stats.h | 48 +++++++++++++++++++++++++++++--------------
 2 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9e09140..71232f8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2012,11 +2012,6 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
-	if (!(flags & ENQUEUE_RESTORE)) {
-		sched_info_enqueue(rq, p);
-		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
-	}
-
 	p->sched_class->enqueue_task(rq, p, flags);
 	/*
 	 * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
@@ -2024,6 +2019,11 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	uclamp_rq_inc(rq, p);
 
+	if (!(flags & ENQUEUE_RESTORE)) {
+		sched_info_enqueue(rq, p);
+		psi_enqueue(p, flags & ENQUEUE_MIGRATED);
+	}
+
 	if (sched_core_enabled(rq))
 		sched_core_enqueue(rq, p);
 }
@@ -2041,7 +2041,7 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 
 	if (!(flags & DEQUEUE_SAVE)) {
 		sched_info_dequeue(rq, p);
-		psi_dequeue(p, flags & DEQUEUE_SLEEP);
+		psi_dequeue(p, !(flags & DEQUEUE_SLEEP));
 	}
 
 	/*
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 237780a..767e098 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -119,45 +119,63 @@ static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
  * memory stalls. As a result, it has to distinguish between sleeps,
- * where a task's runnable state changes, and requeues, where a task
- * and its state are being moved between CPUs and runqueues.
+ * where a task's runnable state changes, and migrations, where a task
+ * and its runnable state are being moved between CPUs and runqueues.
+ *
+ * A notable case is a task whose dequeue is delayed. PSI considers
+ * those sleeping, but because they are still on the runqueue they can
+ * go through migration requeues. In this case, *sleeping* states need
+ * to be transferred.
  */
-static inline void psi_enqueue(struct task_struct *p, bool wakeup)
+static inline void psi_enqueue(struct task_struct *p, bool migrate)
 {
-	int clear = 0, set = TSK_RUNNING;
+	int clear = 0, set = 0;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	if (p->in_memstall)
-		set |= TSK_MEMSTALL_RUNNING;
-
-	if (!wakeup) {
+	if (p->se.sched_delayed) {
+		/* CPU migration of "sleeping" task */
+		SCHED_WARN_ON(!migrate);
 		if (p->in_memstall)
 			set |= TSK_MEMSTALL;
+		if (p->in_iowait)
+			set |= TSK_IOWAIT;
+	} else if (migrate) {
+		/* CPU migration of runnable task */
+		set = TSK_RUNNING;
+		if (p->in_memstall)
+			set |= TSK_MEMSTALL | TSK_MEMSTALL_RUNNING;
 	} else {
+		/* Wakeup of new or sleeping task */
 		if (p->in_iowait)
 			clear |= TSK_IOWAIT;
+		set = TSK_RUNNING;
+		if (p->in_memstall)
+			set |= TSK_MEMSTALL_RUNNING;
 	}
 
 	psi_task_change(p, clear, set);
 }
 
-static inline void psi_dequeue(struct task_struct *p, bool sleep)
+static inline void psi_dequeue(struct task_struct *p, bool migrate)
 {
 	if (static_branch_likely(&psi_disabled))
 		return;
 
 	/*
+	 * When migrating a task to another CPU, clear all psi
+	 * state. The enqueue callback above will work it out.
+	 */
+	if (migrate)
+		psi_task_change(p, p->psi_flags, 0);
+
+	/*
 	 * A voluntary sleep is a dequeue followed by a task switch. To
 	 * avoid walking all ancestors twice, psi_task_switch() handles
 	 * TSK_RUNNING and TSK_IOWAIT for us when it moves TSK_ONCPU.
 	 * Do nothing here.
 	 */
-	if (sleep)
-		return;
-
-	psi_task_change(p, p->psi_flags, 0);
 }
 
 static inline void psi_ttwu_dequeue(struct task_struct *p)
@@ -190,8 +208,8 @@ static inline void psi_sched_switch(struct task_struct *prev,
 }
 
 #else /* CONFIG_PSI */
-static inline void psi_enqueue(struct task_struct *p, bool wakeup) {}
-static inline void psi_dequeue(struct task_struct *p, bool sleep) {}
+static inline void psi_enqueue(struct task_struct *p, bool migrate) {}
+static inline void psi_dequeue(struct task_struct *p, bool migrate) {}
 static inline void psi_ttwu_dequeue(struct task_struct *p) {}
 static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,

