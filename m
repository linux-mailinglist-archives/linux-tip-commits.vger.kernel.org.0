Return-Path: <linux-tip-commits+bounces-2794-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3769BFB97
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2911F22AD3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E64194089;
	Thu,  7 Nov 2024 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZDhoY2LS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EG89AaGF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F04191F7C;
	Thu,  7 Nov 2024 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943104; cv=none; b=JKJCPbhzlzlyPf1HtMlfuJ7wYbP6B6OHFKyfmwtq/FBr3uMryYfhgujac/+esGikjSsL9H73YQDlxws0kHk1jqTpfZMvx+gQR6bKI0HNpJcKDcVsSeM+RULj7rAXOQfXSOpw4MFC+Sfmb5z7Sjwaq4qP0QCK7loCiEY8EsNcRxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943104; c=relaxed/simple;
	bh=pChswCX4maHg2jB8tW/ZIrYiFCflM7hvnhEB991bzaU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qiHLtabUAcIkZjyEx9cSdlvuYi77szHJqrVA6/btSfKm/ZRFyLHjLqt3CLhcoiCg9bT3WzDaTR3Opl5xqFRcFOscQsczlKKrnb2BisMpz9X4SG9VlNIKsRmX+bP3YROZBCsGjofZoQ5t6HnpuoDQMmXLxYsrCXEuai9VmiujhTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZDhoY2LS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EG89AaGF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943101;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOAYd+Gqh5Uvq9juzWItnKVsTFkOlvPIm/ljmAcAbxw=;
	b=ZDhoY2LSPRx4damfwgh158ZaBEKTs2wToeSmMpi80B4uAs9K3dXs2zq2cLycZV+OkxWWCF
	FiHuQbJJI3CQLaUEgbyXPux5HKBmnb52O55UVZOLJe2ExoC1bhTQ2+sCvfZjgNjMmoQMn4
	W7nyXQQ03ujqZUBxHbNL7UOcoCPNXQZ4ZDQSH34dWCkkNqUbPzD2wAGKOO8K0vXYtfgNPy
	zlEEfHhYPVOoj1pOQi1U8jNQZrrk7PiCZkp6L6WCALS9w1+X2JpLjPvqs0Xy7NckvAHixG
	cC4Q5fxItTAtxoM/sJKK6sz4i75XRvKSAYqFQSWzTgWaUs11qN/azr4i6Qk3cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943101;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOAYd+Gqh5Uvq9juzWItnKVsTFkOlvPIm/ljmAcAbxw=;
	b=EG89AaGFHSxa5JDm1aJWP/pFUdaQA9NDIG8yEIW0jatEFttQbQw+rVbRvizsblvg2p3MfS
	XedmMzbWp9ZPZkDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Add a refcount to struct k_itimer
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064213.304756440@linutronix.de>
References: <20241105064213.304756440@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094310022.32228.3905635373285392825.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5d916a0988eed5217c103932ff4887c9ae83c89c
Gitweb:        https://git.kernel.org/tip/5d916a0988eed5217c103932ff4887c9ae83c89c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:43 +01:00

posix-timers: Add a refcount to struct k_itimer

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

To make that work correctly it needs reference counting so that timer
deletion does not free the timer prematuraly when there is a signal queued
or delivered concurrently.

Add a rcuref to the posix timer part.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241105064213.304756440@linutronix.de


---
 include/linux/posix-timers.h | 14 ++++++++++++++
 kernel/time/posix-timers.c   |  7 ++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index bcd0120..9740fd0 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -6,11 +6,13 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/posix-timers_types.h>
+#include <linux/rcuref.h>
 #include <linux/spinlock.h>
 #include <linux/timerqueue.h>
 
 struct kernel_siginfo;
 struct task_struct;
+struct k_itimer;
 
 static inline clockid_t make_process_cpuclock(const unsigned int pid,
 		const clockid_t clock)
@@ -105,6 +107,7 @@ static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 
 void posixtimer_rearm_itimer(struct task_struct *p);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info);
+void posixtimer_free_timer(struct k_itimer *timer);
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -129,6 +132,7 @@ static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
 					      u64 cpu_limit) { }
 static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
 static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info) { return false; }
+static inline void posixtimer_free_timer(struct k_itimer *timer) { }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
@@ -156,6 +160,7 @@ static inline void posix_cputimers_init_work(void) { }
  * @it_signal:		Pointer to the creators signal struct
  * @it_pid:		The pid of the process/task targeted by the signal
  * @it_process:		The task to wakeup on clock_nanosleep (CPU timers)
+ * @rcuref:		Reference count for life time management
  * @sigq:		Pointer to preallocated sigqueue
  * @it:			Union representing the various posix timer type
  *			internals.
@@ -180,6 +185,7 @@ struct k_itimer {
 		struct task_struct	*it_process;
 	};
 	struct sigqueue		*sigq;
+	rcuref_t		rcuref;
 	union {
 		struct {
 			struct hrtimer	timer;
@@ -200,4 +206,12 @@ void set_process_cpu_timer(struct task_struct *task, unsigned int clock_idx,
 
 int update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new);
 
+#ifdef CONFIG_POSIX_TIMERS
+static inline void posixtimer_putref(struct k_itimer *tmr)
+{
+	if (rcuref_put(&tmr->rcuref))
+		posixtimer_free_timer(tmr);
+}
+#endif /* !CONFIG_POSIX_TIMERS */
+
 #endif
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 66ed49e..53bd3c4 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -417,10 +417,11 @@ static struct k_itimer * alloc_posix_timer(void)
 		return NULL;
 	}
 	clear_siginfo(&tmr->sigq->info);
+	rcuref_init(&tmr->rcuref, 1);
 	return tmr;
 }
 
-static void posix_timer_free(struct k_itimer *tmr)
+void posixtimer_free_timer(struct k_itimer *tmr)
 {
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
@@ -432,7 +433,7 @@ static void posix_timer_unhash_and_free(struct k_itimer *tmr)
 	spin_lock(&hash_lock);
 	hlist_del_rcu(&tmr->t_hash);
 	spin_unlock(&hash_lock);
-	posix_timer_free(tmr);
+	posixtimer_putref(tmr);
 }
 
 static int common_timer_create(struct k_itimer *new_timer)
@@ -467,7 +468,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	 */
 	new_timer_id = posix_timer_add(new_timer);
 	if (new_timer_id < 0) {
-		posix_timer_free(new_timer);
+		posixtimer_free_timer(new_timer);
 		return new_timer_id;
 	}
 

