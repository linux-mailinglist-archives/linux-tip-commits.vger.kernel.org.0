Return-Path: <linux-tip-commits+bounces-4180-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D072A5F263
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952B43BE2C2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657AB266B5F;
	Thu, 13 Mar 2025 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q2DCf2+O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FA4bF4Tz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C73266597;
	Thu, 13 Mar 2025 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865487; cv=none; b=GtHpIjbAL6zH4mVRpboPk8ev/oglrjG/N0KJ1WwDun2P2F/dKu7ouW8lzeOGl+TssOllX++SbQUZ1RI0iQfXWZuuyqVbGmpRWkzb/cxZDjl1pM9vqe+M+rq100ftvUAqiMxvHMKoZejZi2T6unvOxQQI+6hsvrkCmnqLOUD9Wkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865487; c=relaxed/simple;
	bh=/VBm87NzGhk097lLXf+aM0HX0eunkeDfZ2bSulrV/XU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LHZTO8TNRIPQ7b6xC3GUOBmMjS6G1gT2FckQ+Q9c3ispSJ9u7Vj6XYmFLngxDAeHN08A48dEYjeVCC9KyjEmrg6VS+YRMOvqkF3kNiD3/+vvRIFRSDl/H2QO/38ZCYQQTWmPg6ubUpSHTZrZH3EZ6vdqLMcsYzTImp/a5mtFIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q2DCf2+O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FA4bF4Tz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865483;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+IgVeIab4YrB1OEYkoOs+MCk38ppuMCclslGMphi3k=;
	b=Q2DCf2+OKYZQsG+TJMZBP+e/2fCwMUGFU5TbZU3mVm6jIs26AYzJc/t7UoR4nRAy8icWCy
	CoOS4jr+SUBYK8hIg9r/UTKJo430dcYmX2PQh419bZBfxBgcA51NJuWLC8hoUj4oO4OaxY
	iq68LPAVojenGzou/mWVQc6xfBv0zJuuz0UEszjckQM6VILlrhESHZdxJfkEBDPsnkLYNV
	oj5PYSj7s+/7qy0o5ARn/vezTKDufagVVDbGhFgwH+tnWnUap/Rk/3gvDxeyxsFWWdKiJS
	fPYb/SPS0VFeGGXO40Tlwz/BRau1Y+9ZIvM+Iex3f+wfwwwXPo+RbHyxsMQpmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865483;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+IgVeIab4YrB1OEYkoOs+MCk38ppuMCclslGMphi3k=;
	b=FA4bF4TzrJXXWA7g8k0/MQy+/XHwgop3Gvh4EjxAgcujzJi/4EZ/IjDnGL6Mc8lV0fM2mZ
	lvtcv6JJ9wNf65Cg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Dont iterate /proc/$PID/timers with
 sighand:: Siglock held
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250308155624.465175807@linutronix.de>
References: <20250308155624.465175807@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186548303.14745.6037005708872288111.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2dc4dbf89cf186639c25c1b04a07c11496f060ad
Gitweb:        https://git.kernel.org/tip/2dc4dbf89cf186639c25c1b04a07c11496f060ad
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 08 Mar 2025 17:48:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:18 +01:00

posix-timers: Dont iterate /proc/$PID/timers with sighand:: Siglock held

The readout of /proc/$PID/timers holds sighand::siglock with interrupts
disabled. That is required to protect against concurrent modifications of
the task::signal::posix_timers list because the list is not RCU safe.

With the conversion of the timer storage to a RCU protected hlist, this is
not longer required.

The only requirement is to protect the returned entry against a concurrent
free, which is trivial as the timers are RCU protected.

Removing the trylock of sighand::siglock is benign because the life time of
task_struct::signal is bound to the life time of the task_struct itself.

There are two scenarios where this matters:

  1) The process is life and not about to be checkpointed

  2) The process is stopped via ptrace for checkpointing

#1 is a racy snapshot of the armed timers and nothing can rely on it. It's
   not more than debug information and it has been that way before because
   sighand lock is dropped when the buffer is full and the restart of
   the iteration might find a completely different set of timers.

   The task and therefore task::signal cannot be freed as timers_start()
   acquired a reference count via get_pid_task().

#2 the process is stopped for checkpointing so nothing can delete or create
   timers at this point. Neither can the process exit during the traversal.

   If CRIU fails to observe an exit in progress prior to the dissimination
   of the timers, then there are more severe problems to solve in the CRIU
   mechanics as they can't rely on posix timers being enabled in the first
   place.

Therefore replace the lock acquisition with rcu_read_lock() and switch the
timer storage traversal over to seq_hlist_*_rcu().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250308155624.465175807@linutronix.de


---
 fs/proc/base.c | 48 ++++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index cd89e95..5a1d682 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2497,11 +2497,9 @@ static const struct file_operations proc_map_files_operations = {
 
 #if defined(CONFIG_CHECKPOINT_RESTORE) && defined(CONFIG_POSIX_TIMERS)
 struct timers_private {
-	struct pid *pid;
-	struct task_struct *task;
-	struct sighand_struct *sighand;
-	struct pid_namespace *ns;
-	unsigned long flags;
+	struct pid		*pid;
+	struct task_struct	*task;
+	struct pid_namespace	*ns;
 };
 
 static void *timers_start(struct seq_file *m, loff_t *pos)
@@ -2512,54 +2510,48 @@ static void *timers_start(struct seq_file *m, loff_t *pos)
 	if (!tp->task)
 		return ERR_PTR(-ESRCH);
 
-	tp->sighand = lock_task_sighand(tp->task, &tp->flags);
-	if (!tp->sighand)
-		return ERR_PTR(-ESRCH);
-
-	return seq_hlist_start(&tp->task->signal->posix_timers, *pos);
+	rcu_read_lock();
+	return seq_hlist_start_rcu(&tp->task->signal->posix_timers, *pos);
 }
 
 static void *timers_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct timers_private *tp = m->private;
-	return seq_hlist_next(v, &tp->task->signal->posix_timers, pos);
+
+	return seq_hlist_next_rcu(v, &tp->task->signal->posix_timers, pos);
 }
 
 static void timers_stop(struct seq_file *m, void *v)
 {
 	struct timers_private *tp = m->private;
 
-	if (tp->sighand) {
-		unlock_task_sighand(tp->task, &tp->flags);
-		tp->sighand = NULL;
-	}
-
 	if (tp->task) {
 		put_task_struct(tp->task);
 		tp->task = NULL;
+		rcu_read_unlock();
 	}
 }
 
 static int show_timer(struct seq_file *m, void *v)
 {
-	struct k_itimer *timer;
-	struct timers_private *tp = m->private;
-	int notify;
 	static const char * const nstr[] = {
-		[SIGEV_SIGNAL] = "signal",
-		[SIGEV_NONE] = "none",
-		[SIGEV_THREAD] = "thread",
+		[SIGEV_SIGNAL]	= "signal",
+		[SIGEV_NONE]	= "none",
+		[SIGEV_THREAD]	= "thread",
 	};
 
-	timer = hlist_entry((struct hlist_node *)v, struct k_itimer, list);
-	notify = timer->it_sigev_notify;
+	struct k_itimer *timer = hlist_entry((struct hlist_node *)v, struct k_itimer, list);
+	struct timers_private *tp = m->private;
+	int notify = timer->it_sigev_notify;
+
+	guard(spinlock_irq)(&timer->it_lock);
+	if (!posixtimer_valid(timer))
+		return 0;
 
 	seq_printf(m, "ID: %d\n", timer->it_id);
-	seq_printf(m, "signal: %d/%px\n",
-		   timer->sigq.info.si_signo,
+	seq_printf(m, "signal: %d/%px\n", timer->sigq.info.si_signo,
 		   timer->sigq.info.si_value.sival_ptr);
-	seq_printf(m, "notify: %s/%s.%d\n",
-		   nstr[notify & ~SIGEV_THREAD_ID],
+	seq_printf(m, "notify: %s/%s.%d\n", nstr[notify & ~SIGEV_THREAD_ID],
 		   (notify & SIGEV_THREAD_ID) ? "tid" : "pid",
 		   pid_nr_ns(timer->it_pid, tp->ns));
 	seq_printf(m, "ClockID: %d\n", timer->it_clock);

