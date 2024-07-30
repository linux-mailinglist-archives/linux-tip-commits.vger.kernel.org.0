Return-Path: <linux-tip-commits+bounces-1866-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1758941C64
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015D01C213CE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35536189901;
	Tue, 30 Jul 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1I8+Hz+5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aXxV+ger"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B93B1A6192;
	Tue, 30 Jul 2024 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359191; cv=none; b=ocaTi3yt8SXdGNXbjrdtw42GqJiQksO3yE5fX33W1Vr/8vTCQohIr7igOoDul25i5EQObmmaqzd2dJCEasSCVSMpGRF414kYzVPSGIsdRUzhKViXODj+FnqBdKquV4KpExv13KvYIPMI41SHEQjA0xA3s8Dy+StczYREba3JK74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359191; c=relaxed/simple;
	bh=4u/is5lMaagpf8vWdcIhvNg2FTNGLtDGP47dI45WOeI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=nCQYCuGRs38rQ+GC+X3KOtyMj5ssGT/A9/8cTBSI9To0bO97tslaJuxiwykjNpOTjB1YUc8cPbd3InKe71JRnTeHfCdj/v1KiOj1hzcOrVJoEEu/Zfs30aubP7icfBy2dUvDZYkzz4XvjPsqUe8R0O906q9/8QsTbyIyvi05ogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1I8+Hz+5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aXxV+ger; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=sxxMZsTJZBDZ+GHfoFguQ6oSpJdVOoNIcrjeWGC2S9U=;
	b=1I8+Hz+5VAXqQfnskSnOYMSd/LdMWL7oa1m6IwlDHf6FgZOT2KeEdk4u2wUvqBjEsxDLUD
	unluyPW4HUSp9QSVxNUzcPO9i6LZR+2Y/ThuXrSvNiXKaepH8FRhG9Wf7NgxfsPxvTFnsH
	xz8cz6egvdwwBxCHwWyLbsaKak6+NY2EqL93Bs5subf1l0kkLVXxIrXoBbjvzOzx7rvmQu
	EpcDs83mAhebsmUr5Ca2J3gwfQC4uD5yvhqg6nHhqMp4kt1JBOk4BAfploVXCce/yyMgZ8
	KXpxOBM7XitsIU7SoxR2Ecw2KmTqIAiT2bJp3NonrRxNYMCsLxWamuZiLqoIVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=sxxMZsTJZBDZ+GHfoFguQ6oSpJdVOoNIcrjeWGC2S9U=;
	b=aXxV+ger7Spc3uJI8MV53tHrpfXvt5PNjZRUo4NIwwxnMRst6bM+CkmJmJUpUH0Mmr+2Xk
	SkMtjZjimOtvLQBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] signal: Remove task argument from dequeue_signal()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172235918704.2215.7601997681338765406.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a2b80ce87a87fc18c594e74d13031d5e347b69cb
Gitweb:        https://git.kernel.org/tip/a2b80ce87a87fc18c594e74d13031d5e347b69cb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:33 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:35 +02:00

signal: Remove task argument from dequeue_signal()

The task pointer which is handed to dequeue_signal() is always current. The
argument along with the first comment about signalfd in that function is
confusing at best. Remove it and use current internally.

Update the stale comment for dequeue_signal() while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 fs/signalfd.c                |  4 ++--
 include/linux/sched/signal.h |  5 ++---
 kernel/signal.c              | 23 ++++++++++-------------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index ec7b2da..d0333bc 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -159,7 +159,7 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
 	DECLARE_WAITQUEUE(wait, current);
 
 	spin_lock_irq(&current->sighand->siglock);
-	ret = dequeue_signal(current, &ctx->sigmask, info, &type);
+	ret = dequeue_signal(&ctx->sigmask, info, &type);
 	switch (ret) {
 	case 0:
 		if (!nonblock)
@@ -174,7 +174,7 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
 	add_wait_queue(&current->sighand->signalfd_wqh, &wait);
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		ret = dequeue_signal(current, &ctx->sigmask, info, &type);
+		ret = dequeue_signal(&ctx->sigmask, info, &type);
 		if (ret != 0)
 			break;
 		if (signal_pending(current)) {
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 622fdef..c8ed09a 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -276,8 +276,7 @@ static inline void signal_set_stop_flags(struct signal_struct *sig,
 extern void flush_signals(struct task_struct *);
 extern void ignore_signals(struct task_struct *);
 extern void flush_signal_handlers(struct task_struct *, int force_default);
-extern int dequeue_signal(struct task_struct *task, sigset_t *mask,
-			  kernel_siginfo_t *info, enum pid_type *type);
+extern int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type);
 
 static inline int kernel_dequeue_signal(void)
 {
@@ -287,7 +286,7 @@ static inline int kernel_dequeue_signal(void)
 	int ret;
 
 	spin_lock_irq(&task->sighand->siglock);
-	ret = dequeue_signal(task, &task->blocked, &__info, &__type);
+	ret = dequeue_signal(&task->blocked, &__info, &__type);
 	spin_unlock_irq(&task->sighand->siglock);
 
 	return ret;
diff --git a/kernel/signal.c b/kernel/signal.c
index 60c737e..897765b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -618,20 +618,18 @@ static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
 }
 
 /*
- * Dequeue a signal and return the element to the caller, which is
- * expected to free it.
- *
- * All callers have to hold the siglock.
+ * Try to dequeue a signal. If a deliverable signal is found fill in the
+ * caller provided siginfo and return the signal number. Otherwise return
+ * 0.
  */
-int dequeue_signal(struct task_struct *tsk, sigset_t *mask,
-		   kernel_siginfo_t *info, enum pid_type *type)
+int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 {
+	struct task_struct *tsk = current;
 	bool resched_timer = false;
 	int signr;
 
-	/* We only dequeue private signals from ourselves, we don't let
-	 * signalfd steal them
-	 */
+	lockdep_assert_held(&tsk->sighand->siglock);
+
 	*type = PIDTYPE_PID;
 	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
 	if (!signr) {
@@ -2793,8 +2791,7 @@ relock:
 		type = PIDTYPE_PID;
 		signr = dequeue_synchronous_signal(&ksig->info);
 		if (!signr)
-			signr = dequeue_signal(current, &current->blocked,
-					       &ksig->info, &type);
+			signr = dequeue_signal(&current->blocked, &ksig->info, &type);
 
 		if (!signr)
 			break; /* will return 0 */
@@ -3648,7 +3645,7 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
 	signotset(&mask);
 
 	spin_lock_irq(&tsk->sighand->siglock);
-	sig = dequeue_signal(tsk, &mask, info, &type);
+	sig = dequeue_signal(&mask, info, &type);
 	if (!sig && timeout) {
 		/*
 		 * None ready, temporarily unblock those we're interested
@@ -3667,7 +3664,7 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
 		spin_lock_irq(&tsk->sighand->siglock);
 		__set_task_blocked(tsk, &tsk->real_blocked);
 		sigemptyset(&tsk->real_blocked);
-		sig = dequeue_signal(tsk, &mask, info, &type);
+		sig = dequeue_signal(&mask, info, &type);
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
 

