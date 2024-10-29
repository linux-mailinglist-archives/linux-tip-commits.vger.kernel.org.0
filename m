Return-Path: <linux-tip-commits+bounces-2630-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6BC9B44A0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 09:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570981F250AE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55667204093;
	Tue, 29 Oct 2024 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2gizr7nQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G/M0jb/I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB442022EB;
	Tue, 29 Oct 2024 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191527; cv=none; b=TsL67VGQBEchYC2U61EpE8v14EpqQpZs6pRYPjK/Jesf9fz486xVrK3lJB61L3bMSfOcEdoedqF8XmeMRG4ZMqtQ2JQThAfpp8ZmDlQmJpYXvaFnatSOGcBAVxLOsPjaCCxERS27NDmI+tmDRcSiMPO2NJNmH967ofp68jloZhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191527; c=relaxed/simple;
	bh=+Erxtc7WtOU8yP1VGy7klTJLaur8UEwNgVXVWdNoKCE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=WWKMrLQJoksKJ1816GyS/Sl/N5afGPZSq9MCkjpZv+1JU4M5v2iw1smTR3QODIvXmhkfHfp4QxE436RjyReUjA8Yr/BE2i8JOTrjkf0O/dpOAmbkf1Qze6uPKV6lFz1wvq946YX8zKIGtSL14T7yMaDRaikVh8IOyna21ViTqD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2gizr7nQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G/M0jb/I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Oct 2024 08:45:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730191523;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mfY6Kj0okUtncUtOxPLheuNdLVvW+po3IeanSIIzFCE=;
	b=2gizr7nQJ21jDswx3j5fYxdQIsDa70ob2spmWybHWV2Pz0uSEEZTJNY+4UGZWHNxKk0Qel
	TJKbcaomMzZpo6Ds7ytwmMYyRrCt6U1jVIlKhQwTK/RH3Aabh7N+9tPaMRqBfbrVkRI65e
	pKXxblYdoMbxzwMXX8KhhMo88UlkW/p3Cfgfbv2pbwIzkiPplKkobQcZQH7fuFwRo6Ju12
	YACT1t/xkIG+CmaIiHs2juFwOmxf4AssQ+rw00sxR86vJsCH29mqpVzKkPLguuwqdd+HMR
	hYl+JDrR6nbFy7RApZKshQ1+4f/UFrxtREIkU4hnrHrLydy4nfDiZjEt/tRkyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730191523;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mfY6Kj0okUtncUtOxPLheuNdLVvW+po3IeanSIIzFCE=;
	b=G/M0jb/IfTG8TzCjKYfit7UsJe44JwAagD4vt4ggJhVANKcH8doNK8aZrP7Z/dbwDYivOI
	j5IdjqYVaeY26jCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] signal: Allow POSIX timer signals to be dropped
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
Message-ID: <173019152223.1442.4793642768436234035.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c22f9833a366f12ffe5a9889192b211f96a4610e
Gitweb:        https://git.kernel.org/tip/c22f9833a366f12ffe5a9889192b211f96a4610e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 01 Oct 2024 10:42:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 29 Oct 2024 09:39:06 +01:00

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

