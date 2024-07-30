Return-Path: <linux-tip-commits+bounces-1867-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9C9941C65
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFA61C23282
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E3B189B89;
	Tue, 30 Jul 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e2Zbwtf9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uQyNAbHr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E61A18801A;
	Tue, 30 Jul 2024 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359191; cv=none; b=tNXRn+1Sf4O2ci52jARrrWlVYhrXJjG1GQc904HNyb4Ca5BMhFLQS8H2LxA25yUIvDqe6lQ+yRYajlitt6uE9MsfdYqgqjoH4FG2WmjhuP53f5x02xWFXKeUXiWIJFHRNYq3zTLV27Dz1Rv+YOfqcwEqr0bQ1UdLgTfPwNsIWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359191; c=relaxed/simple;
	bh=Zw0RQPQLQsVT1aIe63RK17NVZxKGYEJAinHULSMNLz4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=BP4394ydCvo0yS25xzVtrgudgcmVldqdtKY14281xpOkAcsC+4RkGJ1LyusunD8QcwdXcdY+ZNHrkm4gl8t9Q8iDLMfqpZUpXwjNabfYKjh8RkUcusP68CGqvF3G8pBOnXi6W8kp4SJvqLOLRg8xyHTY5JgyPdrSHSxxvScbFO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e2Zbwtf9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uQyNAbHr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fY1ZyGNrG8zLS41NJpTOs6O9ku3B+xYnnV8APeZBECA=;
	b=e2Zbwtf9GxJYM4sfNojPK4rEJuGFU34YA0TVfe51AGcY/m2MxNY+UmXbgMbjCd5HEZjk5Z
	oV2Xvq8il+t16DKDLYfWxmMItL5snJK1AVTKReYOxP/F9Bf9AdsenL4HW8+MWAGA5NLQdC
	+j9APD5kse9ztXa5kw54gl+3Cf95/h0ezrU8nXarOTNByPl6GmsZ36aJ379wgReZ2wM3/k
	hoXDydLi1leOY9FRZGeJBD2kLhkSyX7wZBzbME85Slgk2RKGbznS4UTxI5NGjcvJf6Z0Ff
	ITSJXLXXgoV2gx4n3DmHpSFNbxKv+YiHaUREYA0FP+IbYgmu1aArg2HmtKtLXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fY1ZyGNrG8zLS41NJpTOs6O9ku3B+xYnnV8APeZBECA=;
	b=uQyNAbHrdRDvP1ToQSyocIvkV3eREWGKh5JebxJbSTOzkudDd0oXeYWQhcPfljYL1RtpD0
	yUJDXwtE+3k9+DBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Consolidate signal queueing
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
Message-ID: <172235918751.2215.1609600520367579217.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     566e2d82536cf77b5ed7c03f887e7c36bf86feaa
Gitweb:        https://git.kernel.org/tip/566e2d82536cf77b5ed7c03f887e7c36bf86feaa
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:32 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:35 +02:00

posix-timers: Consolidate signal queueing

Rename posix_timer_event() to posix_timer_queue_signal() as this is what
the function is about.

Consolidate the requeue pending and deactivation updates into that function
as there is no point in doing this in all incarnations of posix timers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/alarmtimer.c       |  7 +------
 kernel/time/posix-cpu-timers.c |  4 ++--
 kernel/time/posix-timers.c     | 21 +++++++++++----------
 kernel/time/posix-timers.h     |  2 +-
 4 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 5abfa43..76bd4fd 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -574,15 +574,10 @@ static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm,
 					    it.alarm.alarmtimer);
 	enum alarmtimer_restart result = ALARMTIMER_NORESTART;
 	unsigned long flags;
-	int si_private = 0;
 
 	spin_lock_irqsave(&ptr->it_lock, flags);
 
-	ptr->it_active = 0;
-	if (ptr->it_interval)
-		si_private = ++ptr->it_requeue_pending;
-
-	if (posix_timer_event(ptr, si_private) && ptr->it_interval) {
+	if (posix_timer_queue_signal(ptr) && ptr->it_interval) {
 		/*
 		 * Handle ignored signals and rearm the timer. This will go
 		 * away once we handle ignored signals proper. Ensure that
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index bcc2b83..6bcee47 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -598,9 +598,9 @@ static void cpu_timer_fire(struct k_itimer *timer)
 		/*
 		 * One-shot timer.  Clear it as soon as it's fired.
 		 */
-		posix_timer_event(timer, 0);
+		posix_timer_queue_signal(timer);
 		cpu_timer_setexpires(ctmr, 0);
-	} else if (posix_timer_event(timer, ++timer->it_requeue_pending)) {
+	} else if (posix_timer_queue_signal(timer)) {
 		/*
 		 * The signal did not get queued because the signal
 		 * was ignored, so we won't get any callback to
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 679be90..1cc830e 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -277,10 +277,17 @@ void posixtimer_rearm(struct kernel_siginfo *info)
 	unlock_timer(timr, flags);
 }
 
-int posix_timer_event(struct k_itimer *timr, int si_private)
+int posix_timer_queue_signal(struct k_itimer *timr)
 {
+	int ret, si_private = 0;
 	enum pid_type type;
-	int ret;
+
+	lockdep_assert_held(&timr->it_lock);
+
+	timr->it_active = 0;
+	if (timr->it_interval)
+		si_private = ++timr->it_requeue_pending;
+
 	/*
 	 * FIXME: if ->sigq is queued we can race with
 	 * dequeue_signal()->posixtimer_rearm().
@@ -309,19 +316,13 @@ int posix_timer_event(struct k_itimer *timr, int si_private)
  */
 static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 {
+	struct k_itimer *timr = container_of(timer, struct k_itimer, it.real.timer);
 	enum hrtimer_restart ret = HRTIMER_NORESTART;
-	struct k_itimer *timr;
 	unsigned long flags;
-	int si_private = 0;
 
-	timr = container_of(timer, struct k_itimer, it.real.timer);
 	spin_lock_irqsave(&timr->it_lock, flags);
 
-	timr->it_active = 0;
-	if (timr->it_interval != 0)
-		si_private = ++timr->it_requeue_pending;
-
-	if (posix_timer_event(timr, si_private)) {
+	if (posix_timer_queue_signal(timr)) {
 		/*
 		 * The signal was not queued due to SIG_IGN. As a
 		 * consequence the timer is not going to be rearmed from
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index 630a77b..4784ea6 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -36,7 +36,7 @@ extern const struct k_clock clock_process;
 extern const struct k_clock clock_thread;
 extern const struct k_clock alarm_clock;
 
-int posix_timer_event(struct k_itimer *timr, int si_private);
+int posix_timer_queue_signal(struct k_itimer *timr);
 
 void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting);
 int common_timer_set(struct k_itimer *timr, int flags,

