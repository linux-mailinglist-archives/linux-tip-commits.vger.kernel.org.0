Return-Path: <linux-tip-commits+bounces-2789-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 782559BFB8B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CA21F22870
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEF418CBE8;
	Thu,  7 Nov 2024 01:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qzxH7ZYI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="50B0+9tc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D135382877;
	Thu,  7 Nov 2024 01:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943100; cv=none; b=DIIYnso4txVDXQ7U2jTVHRSIwHOLR+eHV1PyG3g5lZQ+NKMpYcmK1wN6625wTTVPxkje2o7oPqWOG+wd3TJ3NaLOqeLzuwYwh8bLkKn9jNJjnWEB74kGDnMicHYb5mfoCYVsW+qcjZqUfaRGv5UdA6tfVKvrvfbj4MBiu34LDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943100; c=relaxed/simple;
	bh=shfCvBLzmlpLppOnbh5KgvIDen+9ttB0HSlXOmZ6coU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RBn3N+ZtRToDSqXkdalt4N8V4rzGxuM/QLh90m/PERPkjv7/R7g8cOYTNkQoZu8Rf29NN+BtGQMdfkraU0VWI334sTqdIuu4MJMbbSMNfhMgl+ZGkOAMlLu17S0C07wP9clQnrURRJaAEKlMEyz1SAmxIyU2vNhn8dD8pRKtrfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qzxH7ZYI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=50B0+9tc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943097;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJQIIXJJoK5jAGmX2XcdwMERRSWekPZKjoV6NAu97A0=;
	b=qzxH7ZYIR5SqYL+LZFWL9iTd6W4+9aLESsI8liHO/2MgkK5tht1CE9Kluegn5D1B4m5PJ0
	cGK7BONT6mGTQ2yupokQWgAt/fekzJSjYK1WKabD8HnbB5ppcFht8Ik/rMIxhAgjCOGh2p
	7vhbZdB7I8YUt9DHnrP9Ev1/hm4GEmz5HmkMjHJ0niZwzgQtwYo63MUI4H0AFaIN/q3Jc6
	wXi8H2pQeOkIDEJl0ZJYW6bP1PlWdLiLf//TlD+D5E1s6OcKfoDGvQTjvE9BOHIEpu3VdQ
	BBnPD8ij4CHpLdDJZSAOgoZ4CKvvQtZH7yOt/IUut69VFvX8FNkDmCtWoB4TWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943097;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJQIIXJJoK5jAGmX2XcdwMERRSWekPZKjoV6NAu97A0=;
	b=50B0+9tc6NpSvVC/zA/UHwxroX/Pbp3MVoTSyXbzDiA0nl0tY09UZiCNITMeXLPiiMZINk
	KITK2QeYZ9Qxq0Ag==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] signal: Replace resched_timer logic
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064213.652658158@linutronix.de>
References: <20241105064213.652658158@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094309639.32228.16013195780671060385.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     11629b9808e5900d675fd469d19932ea48060de3
Gitweb:        https://git.kernel.org/tip/11629b9808e5900d675fd469d19932ea48060de3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:44 +01:00

signal: Replace resched_timer logic

In preparation for handling ignored posix timer signals correctly and
embedding the sigqueue struct into struct k_itimer, hand down a pointer to
the sigqueue struct into posix_timer_deliver_signal() instead of just
having a boolean flag.

No functional change.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lore.kernel.org/all/20241105064213.652658158@linutronix.de

---
 include/linux/posix-timers.h |  5 +++--
 kernel/signal.c              | 32 ++++++++++++++++++++------------
 kernel/time/posix-timers.c   |  2 +-
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 52611ea..39f1db7 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -110,7 +110,7 @@ static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 void posixtimer_rearm_itimer(struct task_struct *p);
 bool posixtimer_init_sigqueue(struct sigqueue *q);
 int posixtimer_send_sigqueue(struct k_itimer *tmr);
-bool posixtimer_deliver_signal(struct kernel_siginfo *info);
+bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue *timer_sigq);
 void posixtimer_free_timer(struct k_itimer *timer);
 
 /* Init task static initializer */
@@ -135,7 +135,8 @@ static inline void posix_cputimers_init(struct posix_cputimers *pct) { }
 static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
 					      u64 cpu_limit) { }
 static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
-static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info) { return false; }
+static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info,
+					     struct sigqueue *timer_sigq) { return false; }
 static inline void posixtimer_free_timer(struct k_itimer *timer) { }
 #endif
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 5b71e26..0ddb5dd 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -545,7 +545,7 @@ bool unhandled_signal(struct task_struct *tsk, int sig)
 }
 
 static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *info,
-			   bool *resched_timer)
+			   struct sigqueue **timer_sigq)
 {
 	struct sigqueue *q, *first = NULL;
 
@@ -568,10 +568,17 @@ still_pending:
 		list_del_init(&first->list);
 		copy_siginfo(info, &first->info);
 
-		*resched_timer = (first->flags & SIGQUEUE_PREALLOC) &&
-				 (info->si_code == SI_TIMER);
-
-		__sigqueue_free(first);
+		/*
+		 * posix-timer signals are preallocated and freed when the
+		 * timer goes away. Either directly or by clearing
+		 * SIGQUEUE_PREALLOC so that the next delivery will free
+		 * them. Spare the extra round through __sigqueue_free()
+		 * which is ignoring preallocated signals.
+		 */
+		if (unlikely((first->flags & SIGQUEUE_PREALLOC) && (info->si_code == SI_TIMER)))
+			*timer_sigq = first;
+		else
+			__sigqueue_free(first);
 	} else {
 		/*
 		 * Ok, it wasn't in the queue.  This must be
@@ -588,12 +595,12 @@ still_pending:
 }
 
 static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
-			kernel_siginfo_t *info, bool *resched_timer)
+			    kernel_siginfo_t *info, struct sigqueue **timer_sigq)
 {
 	int sig = next_signal(pending, mask);
 
 	if (sig)
-		collect_signal(sig, pending, info, resched_timer);
+		collect_signal(sig, pending, info, timer_sigq);
 	return sig;
 }
 
@@ -605,18 +612,19 @@ static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
 int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 {
 	struct task_struct *tsk = current;
-	bool resched_timer = false;
+	struct sigqueue *timer_sigq;
 	int signr;
 
 	lockdep_assert_held(&tsk->sighand->siglock);
 
 again:
 	*type = PIDTYPE_PID;
-	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
+	timer_sigq = NULL;
+	signr = __dequeue_signal(&tsk->pending, mask, info, &timer_sigq);
 	if (!signr) {
 		*type = PIDTYPE_TGID;
 		signr = __dequeue_signal(&tsk->signal->shared_pending,
-					 mask, info, &resched_timer);
+					 mask, info, &timer_sigq);
 
 		if (unlikely(signr == SIGALRM))
 			posixtimer_rearm_itimer(tsk);
@@ -642,8 +650,8 @@ again:
 		current->jobctl |= JOBCTL_STOP_DEQUEUED;
 	}
 
-	if (IS_ENABLED(CONFIG_POSIX_TIMERS) && unlikely(resched_timer)) {
-		if (!posixtimer_deliver_signal(info))
+	if (IS_ENABLED(CONFIG_POSIX_TIMERS) && unlikely(timer_sigq)) {
+		if (!posixtimer_deliver_signal(info, timer_sigq))
 			goto again;
 	}
 
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 0901ed9..d6fef06 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -254,7 +254,7 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
  * This function is called from the signal delivery code. It decides
  * whether the signal should be dropped and rearms interval timers.
  */
-bool posixtimer_deliver_signal(struct kernel_siginfo *info)
+bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue *timer_sigq)
 {
 	struct k_itimer *timr;
 	unsigned long flags;

