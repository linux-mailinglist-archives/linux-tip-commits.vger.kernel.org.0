Return-Path: <linux-tip-commits+bounces-2641-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C609B47FE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 12:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3300B28249E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 11:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602892064E2;
	Tue, 29 Oct 2024 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n0gM2gv5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bq4c5cSk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF758205E34;
	Tue, 29 Oct 2024 11:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200162; cv=none; b=Orl2za8evKYbQefXXcwMgTaa4fr/JGoP9jQoZF9qer5Wddhp2Buo26nD2GQ6UV+aLEYcB0LZVGjHT5psDXtftq6Eak93Taygp06EhKpq2QQiXVNUDw8wrVU/iaQs/+LHHx/RgGAP4LPpHwMY4hbvrlStn83HJkUwV3HWwT5xwY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200162; c=relaxed/simple;
	bh=WGW+Df0kj/eYVaKYyjQLuQ3oKTasYvRLAi1Z0nQ4uS8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sYGlg1AEwPvtYjUMmLmA94LE7Inb6Java/2ft0orc/3LHz3EZSb2HAnLfkfuEUdQmOqHyj+5N2oO1iVQ45bPtZlr1GNfz4rvXg/9uO2DF/RdpJDr7bUy2/SJViYmQDEqUrV4XDRYfq93N08CVs6YXMXfLeej8vk57WfwviqcOcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n0gM2gv5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bq4c5cSk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Oct 2024 11:09:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730200158;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y14UjisJE0erXY3imcuh2mxkHhKEDZ6lNzp7L0GYnkU=;
	b=n0gM2gv5XytStfRhvmEYOJr6RT7PKRZx4wbRjWZorDA0dokEZhI1p7EllPLGP6/MJcNqIW
	fe/mCVua31rkV1On6Wx7IEIt4CxkdB1oMFj57NCNkzSiWoelNyAxvEqEaZ8iqySN+JQOXW
	KJDyYTGluJOM1RZLmqaDWlUVprLLKAxoeDSWxMQ1TFz9lP+zbYSvJUiUQMYfsq3qO7kynv
	yIFLZVqknd2PeH7ROVNpS0aCyhyPqN9K47mFOlfDtLDkPj4krvTKepEu+OYlMpCpvsdm/G
	yTiJ5kJ8CQogIKnfgElFijKh7u8ZH17xCEZLfXIjWRYRYWhwtmH2XVwPwOVUvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730200158;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y14UjisJE0erXY3imcuh2mxkHhKEDZ6lNzp7L0GYnkU=;
	b=bq4c5cSkAn1L/niC34/wM5hKhMtYgfMz+tf+iqQ1zjRGG2KP7IOTHxEjwNOEp2iuAtdYh0
	QeJY5aqcHcB8VLBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Cure si_sys_private race
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241001083835.434338954@linutronix.de>
References: <20241001083835.434338954@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173020015741.1442.18106109997769773880.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4febce44cfebcb490b196d5d10ae9f403ca4c956
Gitweb:        https://git.kernel.org/tip/4febce44cfebcb490b196d5d10ae9f403ca4c956
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 01 Oct 2024 10:42:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 29 Oct 2024 11:43:18 +01:00

posix-timers: Cure si_sys_private race

The si_sys_private member of the siginfo which is embedded in the
preallocated sigqueue is used by the posix timer code to decide whether a
timer must be reprogrammed on signal delivery.

The handling of this is racy as a long standing comment in that code
documents. It is modified with the timer lock held, but without sighand
lock being held. The actual signal delivery code checks for it under
sighand lock without holding the timer lock.

Hand the new value to send_sigqueue() as argument and store it with sighand
lock held. This is an intermediate change to address this issue.

The arguments to this function will be cleanup in subsequent changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241001083835.434338954@linutronix.de

---
 include/linux/sched/signal.h |  2 +-
 kernel/signal.c              | 10 +++++++++-
 kernel/time/posix-timers.c   | 15 +--------------
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index c8ed09a..bd9f569 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -340,7 +340,7 @@ extern int send_sig(int, struct task_struct *, int);
 extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
-extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type);
+extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type, int si_private);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
 static inline void clear_notify_signal(void)
diff --git a/kernel/signal.c b/kernel/signal.c
index f420c43..1563c83 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1919,7 +1919,7 @@ void sigqueue_free(struct sigqueue *q)
 		__sigqueue_free(q);
 }
 
-int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
+int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type, int si_private)
 {
 	int sig = q->info.si_signo;
 	struct sigpending *pending;
@@ -1954,6 +1954,14 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	if (!likely(lock_task_sighand(t, &flags)))
 		goto ret;
 
+	/*
+	 * Update @q::info::si_sys_private for posix timer signals with
+	 * sighand locked to prevent a race against dequeue_signal() which
+	 * decides based on si_sys_private whether to invoke
+	 * posixtimer_rearm() or not.
+	 */
+	q->info.si_sys_private = si_private;
+
 	ret = 1; /* the signal is ignored */
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t, false))
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index d461a32..05af074 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -299,21 +299,8 @@ int posix_timer_queue_signal(struct k_itimer *timr)
 	if (timr->it_interval)
 		si_private = ++timr->it_requeue_pending;
 
-	/*
-	 * FIXME: if ->sigq is queued we can race with
-	 * dequeue_signal()->posixtimer_rearm().
-	 *
-	 * If dequeue_signal() sees the "right" value of
-	 * si_sys_private it calls posixtimer_rearm().
-	 * We re-queue ->sigq and drop ->it_lock().
-	 * posixtimer_rearm() locks the timer
-	 * and re-schedules it while ->sigq is pending.
-	 * Not really bad, but not that we want.
-	 */
-	timr->sigq->info.si_sys_private = si_private;
-
 	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
-	ret = send_sigqueue(timr->sigq, timr->it_pid, type);
+	ret = send_sigqueue(timr->sigq, timr->it_pid, type, si_private);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }

