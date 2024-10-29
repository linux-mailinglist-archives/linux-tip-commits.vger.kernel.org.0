Return-Path: <linux-tip-commits+bounces-2639-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84D79B47F9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 12:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686E8283F0E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 11:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C0220604C;
	Tue, 29 Oct 2024 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bQz8f+Zn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ulhLGgwU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC8206047;
	Tue, 29 Oct 2024 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200161; cv=none; b=SNzyt/k+6vpOEla/yOR2mRdGkDQgDYOdAjSrsTowTAgSSWjq0BZ+nq9q86p7Ipv7NwSF+MPofbHPQuqN6ZO8MdY4RleKhlAMwlO1dgREB16qJnOC3XflTH1+uCubmNP0ucUckGpasZR1EJ2UHC+AookHMC9yYzg+wYGSnRnxx2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200161; c=relaxed/simple;
	bh=VDxsZs/e+YqUHgOci9Y0/gYFI1zLM/eo9xUePNY3azg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iNzswk5AkwHDlWWZ1YFx7bfeyC5nAe3/Z6Z8CPWr/pnGISvx2Z6B87oq/noMez9HmkWRiopQ7PValvM8sHYFa30RA3M2y9RXG81yzXEpUNRr/wQDszPcBnMeA2mjVS3hARbn69HIKK31pZBeHkLSW1waJ+9fl7JAoSQ0g8BeEkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bQz8f+Zn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ulhLGgwU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Oct 2024 11:09:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730200157;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQeckWuFmPuFt7no6peJiKkn2iyTBXNkt8ZUteX5cDc=;
	b=bQz8f+ZnIwVL4eSUF4k/nFd/dhnyTKxfbNfGWq87431PkQZ/ejTmDarrFcPbc+necdDdty
	yW9nYOi9WlzHtSmT9Uqq6dYjO2xeB19NQAa6thoVhJmMVUq2scSglHRYmR8DXNdzXEqSJr
	wJkNauuJcf/ZD/ydNOBja7ds7NoIYlvoWd0wQsQ7+MqJpY0jpyPd0w0UVGk4GTFho+kCE1
	FRBEs1iDIIC+dqS5rom5kwEJ5lB0HVOsoF1m8RTjn2rafxg2H2rXTY4JPsSDZYnQqH/zfo
	CF6QmwiwNqaOACzv12XJcqBLtwBm/qUNvc/A1070QnnOizt7jJtsjdo9UeaTSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730200157;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQeckWuFmPuFt7no6peJiKkn2iyTBXNkt8ZUteX5cDc=;
	b=ulhLGgwUrRrZqo40E1fW/GD5nVOHOuihdrw8t/XM+yD0BSaC9o2THTGkWV5bcwgSQtQisS
	ouAYl4dmYf9h1lBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] signal: Allow POSIX timer signals to be dropped
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241001083835.494416923@linutronix.de>
References: <20241001083835.494416923@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173020015664.1442.11418078313884486293.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c775ea28d4e23f5e58b6953645ef90c1b27a8e83
Gitweb:        https://git.kernel.org/tip/c775ea28d4e23f5e58b6953645ef90c1b27a8e83
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 01 Oct 2024 10:42:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 29 Oct 2024 11:43:19 +01:00

signal: Allow POSIX timer signals to be dropped

In case that a timer was reprogrammed or deleted an already pending signal
is obsolete. Right now such signals are kept around and eventually
delivered. While POSIX is blury about this:

 - "The effect of disarming or resetting a timer with pending expiration
    notifications is unspecified."

 - "The disposition of pending signals for the deleted timer is
    unspecified."

it is reasonable in both cases to expect that pending signals are discarded
as they have no meaning anymore.

Prepare the signal code to allow dropping posix timer signals.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241001083835.494416923@linutronix.de

---
 include/linux/posix-timers.h | 5 +++--
 kernel/signal.c              | 7 ++++---
 kernel/time/posix-timers.c   | 3 ++-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 670bf03..4ab49e5 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -100,8 +100,9 @@ static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 {
 	pct->bases[CPUCLOCK_SCHED].nextevt = runtime;
 }
+
 void posixtimer_rearm_itimer(struct task_struct *p);
-void posixtimer_rearm(struct kernel_siginfo *info);
+bool posixtimer_deliver_signal(struct kernel_siginfo *info);
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -125,7 +126,7 @@ static inline void posix_cputimers_init(struct posix_cputimers *pct) { }
 static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
 					      u64 cpu_limit) { }
 static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
-static inline void posixtimer_rearm(struct kernel_siginfo *info) { }
+static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info) { return false; }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
diff --git a/kernel/signal.c b/kernel/signal.c
index 1563c83..df34aa4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -594,6 +594,7 @@ int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 
 	lockdep_assert_held(&tsk->sighand->siglock);
 
+again:
 	*type = PIDTYPE_PID;
 	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
 	if (!signr) {
@@ -625,9 +626,9 @@ int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 		current->jobctl |= JOBCTL_STOP_DEQUEUED;
 	}
 
-	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
-		if (unlikely(resched_timer))
-			posixtimer_rearm(info);
+	if (IS_ENABLED(CONFIG_POSIX_TIMERS) && unlikely(resched_timer)) {
+		if (!posixtimer_deliver_signal(info))
+			goto again;
 	}
 
 	return signr;
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 05af074..dd0b1df 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -254,7 +254,7 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
  * info::si_sys_private is not zero, which indicates that the timer has to
  * be rearmed. Restart the timer and update info::si_overrun.
  */
-void posixtimer_rearm(struct kernel_siginfo *info)
+bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 {
 	struct k_itimer *timr;
 	unsigned long flags;
@@ -286,6 +286,7 @@ out:
 
 	/* Don't expose the si_sys_private value to userspace */
 	info->si_sys_private = 0;
+	return true;
 }
 
 int posix_timer_queue_signal(struct k_itimer *timr)

