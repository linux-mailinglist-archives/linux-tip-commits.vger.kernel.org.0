Return-Path: <linux-tip-commits+bounces-1875-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B985C941C87
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB99B27486
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3362E1917C9;
	Tue, 30 Jul 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xGssrAQ0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QB2atbsZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F81718454A;
	Tue, 30 Jul 2024 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359195; cv=none; b=JU3msFxt3247neneOhecp+wV9Oy9lMgBjx2ei6QUwMbPKA15QIVkMaALMKLZ3xTknGniKrBgbxWvhCaINEV8HeDjsHNvk5Xj2xLHyZ2x651dW4IrGZFJH+xXza4wtjbsHFPxYk+zJx88s5o6iJusTzrycoDyjysiwexC/CVaIzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359195; c=relaxed/simple;
	bh=jxToxjCuVs+0qtKJN4ze4Lbz1owJ7V4gdXl4SPVP7FI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=TdEWgMr+EshF0mwXIOLSOfCF0HFDNYBEFM8do6LfGBkQKyDphxfptFeN7ZUaR3nM4sPwQccNQTJjWORSpRsiEsh+lAXTEQQgI9I6sZ1/iELaFfjzNz12CsJyskY1TRZDfj+LEGwYUE1UQIuoayASSlPpJEkiCqk7fIKuyRB+PzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xGssrAQ0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QB2atbsZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359192;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=L+nPZ/4wF9yKIWL6G1F3KWbWnD6wX9oeuEYSmw/K2Wc=;
	b=xGssrAQ0e5BZURMqg09Jt0ZcIE2BNkXR2ing4IG4tfaWlIo6uHP5HtaGBMbaoxdGlTBRBh
	F/Ic6obbEHrhuwnivgpG/b7mjO5PEyQ4kXuWXOLpBhxlcum8KtahpL1Qo5UmHBdPs60K8y
	DFAyAWjmKp0q4KyRVZygx/b/u70GEcaPNbNCK4Uh7rbD60g+kfu4FGxcrPPRm8Rm3xfYD2
	1nzndTl6xxhYQ59rtI0nc+dEyWF/Yzj3L6yDSAouihkIP3nA7sKw2FkGKnJTj3H0oifPlH
	erLJK5MUNuu4jIeSKFStF0ZcQ7QIQSJzfEePdZw+Mh/6fc0l50N1MLoqUuHfKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359192;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=L+nPZ/4wF9yKIWL6G1F3KWbWnD6wX9oeuEYSmw/K2Wc=;
	b=QB2atbsZ9IA5825NxzMuIx6FxQo3MyoWe2tzyzFFEeZwXqTK+wKBbbndUdG+94GoBkOgGf
	Bj0R+zZX+CqYBDCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] posix-cpu-timers: Use @now instead of @val for clarity
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
Message-ID: <172235919163.2215.10963718986549637780.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c44462661e4c5967c5df451393af727d1886c8ea
Gitweb:        https://git.kernel.org/tip/c44462661e4c5967c5df451393af727d1886c8ea
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:22 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:34 +02:00

posix-cpu-timers: Use @now instead of @val for clarity

posix_cpu_timer_set() uses @val as variable for the current time. That's
confusing at best.

Use @now as anywhere else and rewrite the confusing comment about clock
sampling.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/posix-cpu-timers.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 62e6b90..b1a9a2f 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -622,7 +622,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 {
 	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
-	u64 old_expires, new_expires, old_incr, val;
+	u64 old_expires, new_expires, old_incr, now;
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	struct sighand_struct *sighand;
 	struct task_struct *p;
@@ -674,23 +674,19 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	}
 
 	/*
-	 * We need to sample the current value to convert the new
-	 * value from to relative and absolute, and to convert the
-	 * old value from absolute to relative.  To set a process
-	 * timer, we need a sample to balance the thread expiry
-	 * times (in arm_timer).  With an absolute time, we must
-	 * check if it's already passed.  In short, we need a sample.
+	 * Sample the current clock for saving the previous setting
+	 * and for rearming the timer.
 	 */
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
-		val = cpu_clock_sample(clkid, p);
+		now = cpu_clock_sample(clkid, p);
 	else
-		val = cpu_clock_sample_group(clkid, p, !sigev_none);
+		now = cpu_clock_sample_group(clkid, p, !sigev_none);
 
 	/* Retrieve the previous expiry value if requested. */
 	if (old) {
 		old->it_value = (struct timespec64){ };
 		if (old_expires)
-			__posix_cpu_timer_get(timer, old, val);
+			__posix_cpu_timer_get(timer, old, now);
 	}
 
 	if (unlikely(ret)) {
@@ -706,7 +702,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 
 	/* Convert relative expiry time to absolute */
 	if (new_expires && !(timer_flags & TIMER_ABSTIME))
-		new_expires += val;
+		new_expires += now;
 
 	/* Set the new expiry time (might be 0) */
 	cpu_timer_setexpires(ctmr, new_expires);
@@ -716,7 +712,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 * not yet expired and the timer requires signal delivery.
 	 * SIGEV_NONE timers are never armed.
 	 */
-	if (!sigev_none && new_expires && val < new_expires)
+	if (!sigev_none && new_expires && now < new_expires)
 		arm_timer(timer, p);
 
 	unlock_task_sighand(p, &flags);
@@ -736,7 +732,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1;
 
-	if (!sigev_none && val >= new_expires) {
+	if (!sigev_none && now >= new_expires) {
 		if (new_expires != 0) {
 			/*
 			 * The designated time already passed, so we notify

