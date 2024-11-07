Return-Path: <linux-tip-commits+bounces-2787-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1549A9BFB87
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45F328362E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1284F12C470;
	Thu,  7 Nov 2024 01:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kkylpegv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vQrawC3s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230112E3EB;
	Thu,  7 Nov 2024 01:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943099; cv=none; b=awcpBgwrUtLi3avSply5ggAi+ooOAcnnbEieK3O/IowVYCwhIFl6AyPSXK4oHmtha38Tb/DqF+1IFnm8DpBHd3X28cM1GNA9Oo0eUcvjpyx2wTHhEiEQQl2jK7c2ia/slZzpTm3yvBvsS/EoeGZ+ichyC/H+1S0LMUsI96hFUMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943099; c=relaxed/simple;
	bh=FmXMcfFTaaoynGahHZStfi5HHzeBMR4qSVgjAit0wv4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M0kpqOZl5+7Ut89NfgkgOuUGi4TRbvwf7ma3YzpERe0ubpKTbtSf0yHgMOJ5QwlVL5hQuPgc0rholFomWdy4mrnb1Cb1/GExWMFFA/0wmJym/RfE39N8ovcl+0kNTquGgUF3xtlPu+Ry9pFdRiPYcuZD1iqys8S5YSKh759xg5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kkylpegv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vQrawC3s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943095;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C8ILZ24GT2ZdoUyvmDMfpOXtJPLEqTg1di3yIrupOjU=;
	b=KkylpegvaSkjA7ObtsJzZDAVccXz99r964KR+N5wVgz/XzROx/WW5gxFDzn6EqrKp+zJhj
	1lOcjtMQCOVLQhufWVqZ+fir8sZ9cRsXqxjzEQX2lh+KBON8CAo6hEDjtOYcmPME3KC6Cq
	24OAvGLDfe6sMW+2vzaxOiHh0gXWbnYrLxPRrBeiZDUyJH0RPafQN9pFz/Z4gc22gxr4JQ
	fkeSJ/qpW2MCam1J3oBS9bV0UbHyWAp40UCgLzyRaC6U1LMA/pARaL9bzcTAy+jFcODQqK
	IfV0yl0nIU7RFc0p7KP6UCsGSlQ6be2KggGUOp/8BM25ByxjK1q4zK2udkZNig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943095;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C8ILZ24GT2ZdoUyvmDMfpOXtJPLEqTg1di3yIrupOjU=;
	b=vQrawC3s5VfJ1M4zHY3FJdesBK8GW+mgKRgJZdJZ99QdJ0TvQFP6Jb4POZWrFIJ3/MzOb+
	WH4AJ9qxJsYxo0BA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] signal: Cleanup unused posix-timer leftovers
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064213.786506636@linutronix.de>
References: <20241105064213.786506636@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094309498.32228.5755883017910521840.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c2a4796a154bb952be1106911841aab2c8c17c4d
Gitweb:        https://git.kernel.org/tip/c2a4796a154bb952be1106911841aab2c8c17c4d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:44 +01:00

signal: Cleanup unused posix-timer leftovers

Remove the leftovers of sigqueue preallocation as it's not longer used.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241105064213.786506636@linutronix.de

---
 include/linux/sched/signal.h |  2 +--
 kernel/signal.c              | 39 +++--------------------------------
 2 files changed, 4 insertions(+), 37 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 36283c1..02972fd 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -338,8 +338,6 @@ extern void force_fatal_sig(int);
 extern void force_exit_sig(int);
 extern int send_sig(int, struct task_struct *, int);
 extern int zap_other_threads(struct task_struct *p);
-extern struct sigqueue *sigqueue_alloc(void);
-extern void sigqueue_free(struct sigqueue *);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
 static inline void clear_notify_signal(void)
diff --git a/kernel/signal.c b/kernel/signal.c
index 2d74cd5..d267a2c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -439,8 +439,8 @@ static void __sigqueue_init(struct sigqueue *q, struct ucounts *ucounts,
  * - this may be called without locks if and only if t == current, otherwise an
  *   appropriate lock must be held to stop the target task from exiting
  */
-static struct sigqueue *__sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
-					 int override_rlimit, const unsigned int sigqueue_flags)
+static struct sigqueue *sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
+				       int override_rlimit)
 {
 	struct ucounts *ucounts = sig_get_ucounts(t, sig, override_rlimit);
 	struct sigqueue *q;
@@ -454,7 +454,7 @@ static struct sigqueue *__sigqueue_alloc(int sig, struct task_struct *t, gfp_t g
 		return NULL;
 	}
 
-	__sigqueue_init(q, ucounts, sigqueue_flags);
+	__sigqueue_init(q, ucounts, 0);
 	return q;
 }
 
@@ -1070,7 +1070,7 @@ static int __send_signal_locked(int sig, struct kernel_siginfo *info,
 	else
 		override_rlimit = 0;
 
-	q = __sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit, 0);
+	q = sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit);
 
 	if (q) {
 		list_add_tail(&q->list, &pending->list);
@@ -1926,37 +1926,6 @@ bool posixtimer_init_sigqueue(struct sigqueue *q)
 	return true;
 }
 
-struct sigqueue *sigqueue_alloc(void)
-{
-	return __sigqueue_alloc(-1, current, GFP_KERNEL, 0, SIGQUEUE_PREALLOC);
-}
-
-void sigqueue_free(struct sigqueue *q)
-{
-	spinlock_t *lock = &current->sighand->siglock;
-	unsigned long flags;
-
-	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
-		return;
-	/*
-	 * We must hold ->siglock while testing q->list
-	 * to serialize with collect_signal() or with
-	 * __exit_signal()->flush_sigqueue().
-	 */
-	spin_lock_irqsave(lock, flags);
-	q->flags &= ~SIGQUEUE_PREALLOC;
-	/*
-	 * If it is queued it will be freed when dequeued,
-	 * like the "regular" sigqueue.
-	 */
-	if (!list_empty(&q->list))
-		q = NULL;
-	spin_unlock_irqrestore(lock, flags);
-
-	if (q)
-		__sigqueue_free(q);
-}
-
 static void posixtimer_queue_sigqueue(struct sigqueue *q, struct task_struct *t, enum pid_type type)
 {
 	struct sigpending *pending;

