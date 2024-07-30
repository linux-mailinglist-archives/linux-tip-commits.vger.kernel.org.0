Return-Path: <linux-tip-commits+bounces-1871-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90502941C73
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D1F1C23624
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A5D18C90D;
	Tue, 30 Jul 2024 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m33DF1dj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+xT9/OjQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF45218B470;
	Tue, 30 Jul 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359193; cv=none; b=EXoBhlCGvipiHGVAJJ/osRggHLx0J3fgXmPZr/mGaxr1LlDvqRw3u07vXtDlEyizc0bA4f87uo0Q3orxwZG5o/gpSI59jjjTOF8CmlJLQyAiCXoRwQW7CvOFhZn4633Tnhst9f3NrZVe/11R12TwMG16zmq2nuw6O7UxbaGLKps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359193; c=relaxed/simple;
	bh=35I2As70XamzdyvIRL2pQymlFR5JclmXBInx4Dlbfro=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=K8iMKFTyUz5jNvCsHO8rQMeS8yODxiU6N5X38cf565xvVJOT+rnKWpsIwJrE2Mi81whu02nn/aojhkmaYAoB98fU5G7ScQ9SAXTiLKHId+q82E9FBmhyzWqb2nRMyDcYHsW3wM2KNzIqd5KHX6kTOUUbFdJ8o1w18Ts2FOdoISo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m33DF1dj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+xT9/OjQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=X92X8QxQ3AchAKeJuHZElY+1QVRaqch4Nl7nNVPNCe0=;
	b=m33DF1djdf3hNr+1iJ84HrmR94EnpM8eaLKOc6XQJ7cPRmVQMRuAWG4rymGvYxLSK06pls
	ksuEAscj2uHHfHj5+ksiUijvpzfg21RWmzUgGSKJc7PWmTxu4jwpsveRVt58Dv7pP9aFM8
	472LkWYxl+aZRNZSv8w4idmgJeuO5DIgWHKKMmNEis4LSGtTKxiBl4NNGAfYhw4oDnmW7P
	FJ1iCqYy5pRKZO5yH080N68glU07oX9d8dRNz5oqXrH7zLHnjnJ3EGbBYl8NU35Rm/4bwx
	mHPXKObFaFM++gw6LcpVIytT0KsUVHyMoTZnLdXITruvfzblvWVzvGPtSpEc5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=X92X8QxQ3AchAKeJuHZElY+1QVRaqch4Nl7nNVPNCe0=;
	b=+xT9/OjQQhNBYjhpdJkyI3qCuZm1+NENKBHuHJ9CvX8KnE8J6cKKDrR+wrhEhrLlhvhGRg
	SGk/JRfsnjbNRmBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Convert timer list to hlist
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172235918887.2215.7982044996715533515.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     52dea0a15cc888e89f0144dca7b712fb56d12a28
Gitweb:        https://git.kernel.org/tip/52dea0a15cc888e89f0144dca7b712fb56d12a28
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:28 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:35 +02:00

posix-timers: Convert timer list to hlist

No requirement for a real list. Spare a few bytes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 fs/proc/base.c               |  6 +++---
 include/linux/posix-timers.h |  2 +-
 include/linux/sched/signal.h |  2 +-
 init/init_task.c             |  2 +-
 kernel/fork.c                |  2 +-
 kernel/time/posix-timers.c   | 19 ++++++++-----------
 6 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 72a1acd..dd57933 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2456,13 +2456,13 @@ static void *timers_start(struct seq_file *m, loff_t *pos)
 	if (!tp->sighand)
 		return ERR_PTR(-ESRCH);
 
-	return seq_list_start(&tp->task->signal->posix_timers, *pos);
+	return seq_hlist_start(&tp->task->signal->posix_timers, *pos);
 }
 
 static void *timers_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct timers_private *tp = m->private;
-	return seq_list_next(v, &tp->task->signal->posix_timers, pos);
+	return seq_hlist_next(v, &tp->task->signal->posix_timers, pos);
 }
 
 static void timers_stop(struct seq_file *m, void *v)
@@ -2491,7 +2491,7 @@ static int show_timer(struct seq_file *m, void *v)
 		[SIGEV_THREAD] = "thread",
 	};
 
-	timer = list_entry((struct list_head *)v, struct k_itimer, list);
+	timer = hlist_entry((struct hlist_node *)v, struct k_itimer, list);
 	notify = timer->it_sigev_notify;
 
 	seq_printf(m, "ID: %d\n", timer->it_id);
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index dc7b738..4536917 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -158,7 +158,7 @@ static inline void posix_cputimers_init_work(void) { }
  * @rcu:		RCU head for freeing the timer.
  */
 struct k_itimer {
-	struct list_head	list;
+	struct hlist_node	list;
 	struct hlist_node	t_hash;
 	spinlock_t		it_lock;
 	const struct k_clock	*kclock;
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0a0e23c..622fdef 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -137,7 +137,7 @@ struct signal_struct {
 
 	/* POSIX.1b Interval Timers */
 	unsigned int		next_posix_timer_id;
-	struct list_head	posix_timers;
+	struct hlist_head	posix_timers;
 
 	/* ITIMER_REAL timer for the process */
 	struct hrtimer real_timer;
diff --git a/init/init_task.c b/init/init_task.c
index eeb110c..5d0399b 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -29,7 +29,7 @@ static struct signal_struct init_signals = {
 	.cred_guard_mutex = __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
 	.exec_update_lock = __RWSEM_INITIALIZER(init_signals.exec_update_lock),
 #ifdef CONFIG_POSIX_TIMERS
-	.posix_timers = LIST_HEAD_INIT(init_signals.posix_timers),
+	.posix_timers	= HLIST_HEAD_INIT,
 	.cputimer	= {
 		.cputime_atomic	= INIT_CPUTIME_ATOMIC,
 	},
diff --git a/kernel/fork.c b/kernel/fork.c
index cc76049..c1b343c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1861,7 +1861,7 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 	prev_cputime_init(&sig->prev_cputime);
 
 #ifdef CONFIG_POSIX_TIMERS
-	INIT_LIST_HEAD(&sig->posix_timers);
+	INIT_HLIST_HEAD(&sig->posix_timers);
 	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	sig->real_timer.function = it_real_fn;
 #endif
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 53a993e..fa75e94 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -515,7 +515,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	spin_lock_irq(&current->sighand->siglock);
 	/* This makes the timer valid in the hash table */
 	WRITE_ONCE(new_timer->it_signal, current->signal);
-	list_add(&new_timer->list, &current->signal->posix_timers);
+	hlist_add_head(&new_timer->list, &current->signal->posix_timers);
 	spin_unlock_irq(&current->sighand->siglock);
 	/*
 	 * After unlocking sighand::siglock @new_timer is subject to
@@ -1025,7 +1025,7 @@ retry_delete:
 	}
 
 	spin_lock(&current->sighand->siglock);
-	list_del(&timer->list);
+	hlist_del(&timer->list);
 	spin_unlock(&current->sighand->siglock);
 	/*
 	 * A concurrent lookup could check timer::it_signal lockless. It
@@ -1075,7 +1075,7 @@ retry_delete:
 
 		goto retry_delete;
 	}
-	list_del(&timer->list);
+	hlist_del(&timer->list);
 
 	/*
 	 * Setting timer::it_signal to NULL is technically not required
@@ -1096,22 +1096,19 @@ retry_delete:
  */
 void exit_itimers(struct task_struct *tsk)
 {
-	struct list_head timers;
-	struct k_itimer *tmr;
+	struct hlist_head timers;
 
-	if (list_empty(&tsk->signal->posix_timers))
+	if (hlist_empty(&tsk->signal->posix_timers))
 		return;
 
 	/* Protect against concurrent read via /proc/$PID/timers */
 	spin_lock_irq(&tsk->sighand->siglock);
-	list_replace_init(&tsk->signal->posix_timers, &timers);
+	hlist_move_list(&tsk->signal->posix_timers, &timers);
 	spin_unlock_irq(&tsk->sighand->siglock);
 
 	/* The timers are not longer accessible via tsk::signal */
-	while (!list_empty(&timers)) {
-		tmr = list_first_entry(&timers, struct k_itimer, list);
-		itimer_delete(tmr);
-	}
+	while (!hlist_empty(&timers))
+		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
 }
 
 SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,

