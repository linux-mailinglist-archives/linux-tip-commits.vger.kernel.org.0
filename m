Return-Path: <linux-tip-commits+bounces-1876-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 484F5941C82
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C651F24B11
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BD419FA9D;
	Tue, 30 Jul 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="agoFoOCj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2AESMsKw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26A918E021;
	Tue, 30 Jul 2024 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359195; cv=none; b=qL2GGwQpbVg3zQ+SsanI1p7yHLs/hiIvXzmI8wW9xzNMBycPHFphVJ3adcCAtGNhn+DQENwdXFz/Sdvw9QtFN7G5LNmFWUl/yp0waIvU1NoedBwco4O00AN74KMMFTdXev3Fub6E60zM6r8Js1dsV4ygEMHUJZY8Czq2qolnEfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359195; c=relaxed/simple;
	bh=4NjqzuMnozM5yksODMPGoL9FmyF7Dd24+F/+JYRpxbo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=hLSzgiexPy82B4FvHpb9eDu7KbA736MWod8K9enXQlMJNrxeuF2vB5wU2/IL1Kzp8c69VcQvndNexaEFAIweRGKB9kIQPg4FZ6BfV9DxrSyAZgA8AlueAF15Nd/HYAy8Lm2H8uMnFohSedpY6q4D5YtK2pW/B8m2YrvmTZsVbxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=agoFoOCj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2AESMsKw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359192;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=WGBE+teuW+jCoO09T0oofmyAd91E2f4TrWQAngEtvKQ=;
	b=agoFoOCjo/0k2NN1cyvIrbOLHNXl34sAP8Zy1LihFnmXNI3lNiHM+y+eDvj2RFPteq4672
	6Tzx0K8qN7RU5wSpNSWZSHhsZiJD25IwsQJn6gN5wHE2J78VsEJpn2AbV8KVW1SlnpfFZf
	/G5c0l858GFvFYKLU+1sJQe6OMY0Ak6xc9HHLuizjzOl/2mlh8lir7jLfmnQ9m05VgPwMB
	bZq0XYB13FsbPRfc55sXaNRMmYR1PrM1krr7Efm2WdNBdBHfP+SPxVofmWBRSBvyODPkz7
	0Y7Jg2tAMBYM5KzS6ja1cv1PKzFDgetD2f4p/3JtfKcPoBkkAk9opp8bhP+8Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359192;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=WGBE+teuW+jCoO09T0oofmyAd91E2f4TrWQAngEtvKQ=;
	b=2AESMsKw3AL45nLFU0Vtb1n4T6aI69OtGViEhvhWJ+StyFqI8NfRyX0ygbqQnRws30EXqj
	sGo1EUV2v1mMjiAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Do not arm SIGEV_NONE timers
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172235919206.2215.8148552980366858825.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bd29d773ea8d2c7fc36dc3f70d4c9d1cf404aa4b
Gitweb:        https://git.kernel.org/tip/bd29d773ea8d2c7fc36dc3f70d4c9d1cf404aa4b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:21 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:34 +02:00

posix-cpu-timers: Do not arm SIGEV_NONE timers

There is no point in arming SIGEV_NONE timers as they never deliver a
signal. timer_gettime() is handling the expiry time correctly and that's
all SIGEV_NONE timers care about.

Prevent arming them and remove the expiry handler code which just disarms
them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/posix-cpu-timers.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 040d5c3..62e6b90 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -584,12 +584,7 @@ static void cpu_timer_fire(struct k_itimer *timer)
 {
 	struct cpu_timer *ctmr = &timer->it.cpu;
 
-	if ((timer->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
-		/*
-		 * User don't want any signal.
-		 */
-		cpu_timer_setexpires(ctmr, 0);
-	} else if (unlikely(timer->sigq == NULL)) {
+	if (unlikely(timer->sigq == NULL)) {
 		/*
 		 * This a special case for clock_nanosleep,
 		 * not a normal timer from sys_timer_create.
@@ -625,6 +620,7 @@ static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *i
 static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 			       struct itimerspec64 *new, struct itimerspec64 *old)
 {
+	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	u64 old_expires, new_expires, old_incr, val;
 	struct cpu_timer *ctmr = &timer->it.cpu;
@@ -688,7 +684,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
 		val = cpu_clock_sample(clkid, p);
 	else
-		val = cpu_clock_sample_group(clkid, p, true);
+		val = cpu_clock_sample_group(clkid, p, !sigev_none);
 
 	/* Retrieve the previous expiry value if requested. */
 	if (old) {
@@ -708,19 +704,20 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 		goto out;
 	}
 
-	if (new_expires != 0 && !(timer_flags & TIMER_ABSTIME)) {
+	/* Convert relative expiry time to absolute */
+	if (new_expires && !(timer_flags & TIMER_ABSTIME))
 		new_expires += val;
-	}
+
+	/* Set the new expiry time (might be 0) */
+	cpu_timer_setexpires(ctmr, new_expires);
 
 	/*
-	 * Install the new expiry time (or zero).
-	 * For a timer with no notification action, we don't actually
-	 * arm the timer (we'll just fake it for timer_gettime).
+	 * Arm the timer if it is not disabled, the new expiry value has
+	 * not yet expired and the timer requires signal delivery.
+	 * SIGEV_NONE timers are never armed.
 	 */
-	cpu_timer_setexpires(ctmr, new_expires);
-	if (new_expires != 0 && val < new_expires) {
+	if (!sigev_none && new_expires && val < new_expires)
 		arm_timer(timer, p);
-	}
 
 	unlock_task_sighand(p, &flags);
 	/*
@@ -739,7 +736,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1;
 
-	if (val >= new_expires) {
+	if (!sigev_none && val >= new_expires) {
 		if (new_expires != 0) {
 			/*
 			 * The designated time already passed, so we notify

