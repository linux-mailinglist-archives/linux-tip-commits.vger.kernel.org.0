Return-Path: <linux-tip-commits+bounces-2405-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE56499C141
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Oct 2024 09:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BF91F238BF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Oct 2024 07:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C8B147C9B;
	Mon, 14 Oct 2024 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fxor0nIa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bRVYJ6G+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A2E1482E9;
	Mon, 14 Oct 2024 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890928; cv=none; b=FV45O8ceFonBJsR2eDuQVfc7Yqcf7/R+VAd/afzJ4Kl/PCct2fxgNJqFvjTYmqMRufMXCMs37lhKtglnDPJNmPT7jkFMmreQztn0D3ZQKIzLNdHCtv38FpCZv5yoNEmEU3voWn5ciFtwIyXS08x7bE8xNNIdrSvRPsonVmBZkG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890928; c=relaxed/simple;
	bh=rdWpZ4poBoiNXQwfHj0uhNaG570pcSmLR5KAcW+JAk4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jLNBc5DTtm5td8XGgVSsWaZRlyrzWxYMkQ9uFJYSS5BNgg/m+nsydGLqL6TCmmgutD6T6C7esNHr/d2LB6X/FfJcCArTTueWoJZRE+g6Nj/Xm/5Sl5mF0fQ57Di4vsiEYGYpK0g2he8rwMMcSA/X9cCnHu3KUMYGm8YVCK8UQVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fxor0nIa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bRVYJ6G+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Oct 2024 07:28:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728890925;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oo+8SAORv6osZ/3BcFWFI6k3e8aajXQJPvY8ZoubVOk=;
	b=fxor0nIa0gJFQHOMoecLOr2EwvjMpE9j66gAJL97wbmLADSinat5h68WispYrcteSf9kUI
	EcZAY+BoxLzOwvrCA+wOCrPyKwZnxMEPhsPS9GgsxZd9p5C+ol/AnZbk5/X6PArTjyMIEb
	EFgfA22G9t+lEtVl7togUiKOpX0Nx67kfqc9Nd5S+UljqGRRlYI6cCfuvnHxt4x1KL5rJB
	AqcwgSx1QgGU/atRIPJ6iDdBTydJrjnf/GNg1/REcHuF2o4XZ5aMFi9VZgwDZrYrloB6Uh
	YN+q+Igv9RXrIGUpqpTIVR6R8tQCXnzwQshk3y6rrFhvvqJp7hqbrY+CkdaAZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728890925;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oo+8SAORv6osZ/3BcFWFI6k3e8aajXQJPvY8ZoubVOk=;
	b=bRVYJ6G+ckXKh2hWB0az50/OI7UzGdq180m4Y9ItkWMjHjUNwLgq9Tfx6Q0X+EkigntsHR
	4/aHmko4mHiTU6DA==
From: "tip-bot2 for Johannes Weiner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/psi: Fix mistaken CPU pressure indication
 after corrupted task state bug
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010193712.GC181795@cmpxchg.org>
References: <20241010193712.GC181795@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172889092458.1442.11890344300997783512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     c6508124193d42bbc3224571eb75bfa4c1821fbb
Gitweb:        https://git.kernel.org/tip/c6508124193d42bbc3224571eb75bfa4c1821fbb
Author:        Johannes Weiner <hannes@cmpxchg.org>
AuthorDate:    Fri, 11 Oct 2024 10:49:33 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Oct 2024 09:11:42 +02:00

sched/psi: Fix mistaken CPU pressure indication after corrupted task state bug

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

It's not just the warning in dmesg, the task state corruption causes a
permanent CPU pressure indication, which messes with workload/machine
health monitoring.

Debugged-by-and-original-fix-by: K Prateek Nayak <kprateek.nayak@amd.com>
Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Closes: https://lore.kernel.org/lkml/20240830123458.3557-1-spasswolf@web.de/
Closes: https://lore.kernel.org/all/cd67fbcd-d659-4822-bb90-7e8fbb40a856@molgen.mpg.de/
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

