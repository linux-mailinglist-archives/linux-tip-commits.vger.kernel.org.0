Return-Path: <linux-tip-commits+bounces-2797-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7829BFB9C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26224B22214
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C7119580F;
	Thu,  7 Nov 2024 01:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gCIKb+FV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SePHXzR4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A719342B;
	Thu,  7 Nov 2024 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943106; cv=none; b=t+F8kXN6r+54KBfu9h4ar7AF7MVrQo+KEbRGImYBsKW4qRRAFyJRChsRsiaNhcu1O+LudtkA1vUXFnNCAT4bnrBJwyZo9EAkhsnh3V4Eph6lAyewiObUl6uMTeWZUFQXGAMlz4tzPOAor1d2SYXuNWWwvQz30Ym/JbYqo77XA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943106; c=relaxed/simple;
	bh=7Up0vWmqbQHqPdyN6gxAEjMERzglp4DhI3RrWp9WUSs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YE2jBCZ8/UguJcgGyZGPj+QvfRg375cLdJ8CF+Y9e1Lmm3MecNPRAB6mm5r61+m2TEzgL9Xe8yTPX9DIpdpeFXys/cVc4B00awedsyPhQ7DeeZijArC3uFJG/ZoWVzViwFHt8bT7Pd6WblBbRDIRJ7qBRT7xQHAj42M6f3EHPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gCIKb+FV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SePHXzR4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943103;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x399kV5boEDJEwb3wmxD7ytLScLkIxXgDyuGRKNkDjY=;
	b=gCIKb+FVhExjFWvrWvpPHsA+XbgnR9nNp2fJzJHFggLQM4E7Ph0KMA2hunob1HujmETvhh
	d3byO+Kk6sa/3UruzVSiBQbzR7Asgp1Rm8tNo3DBUPa91EVW2hqQw9Hes2Soi/wBeMmKVf
	ZajfTvvvx9siUHbvJ1bjRpcmMR4NUKP7pb93Xl6zKt2Lqpi1RETOQorz3BlkCzkoYmnTr+
	jmmpAEIGakhCThp2pqnsNbjl9D8XG8ZV8kOKQzFhj0hDt0e32MyZaHPpbgr20HboCMD9BR
	jXK9e1RWXF3OYGBlxzI24EPza+wNuZAW6A6f0PFRXktzxORIqSFrPFPWojcDRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943103;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x399kV5boEDJEwb3wmxD7ytLScLkIxXgDyuGRKNkDjY=;
	b=SePHXzR48T8a4YYbakeq1AOEQZlfRkqUsbVBdVJQvIxDJHmmG3io5jAjHHc4aWPq48jpbU
	3ftLrjYHREQk/aBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] posix-timers: Make signal overrun accounting sensible
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064213.106738193@linutronix.de>
References: <20241105064213.106738193@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094310240.32228.8339353456155004952.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b06b0345fff3678517acd0f1837d52477ba30944
Gitweb:        https://git.kernel.org/tip/b06b0345fff3678517acd0f1837d52477ba30944
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:43 +01:00

posix-timers: Make signal overrun accounting sensible

The handling of the timer overrun in the signal code is inconsistent as it
takes previous overruns into account. This is just wrong as after the
reprogramming of a timer the overrun count starts over from a clean state,
i.e. 0.

Don't touch info::si_overrun in send_sigqueue() and only store the overrun
value at signal delivery time, which is computed from the timer itself
relative to the expiry time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241105064213.106738193@linutronix.de

---
 kernel/signal.c            |  6 ------
 kernel/time/posix-timers.c | 11 ++++++-----
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 68e6bc7..ba7159b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1968,15 +1968,9 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type, int s
 
 	ret = 0;
 	if (unlikely(!list_empty(&q->list))) {
-		/*
-		 * If an SI_TIMER entry is already queue just increment
-		 * the overrun count.
-		 */
-		q->info.si_overrun++;
 		result = TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;
 	}
-	q->info.si_overrun = 0;
 
 	signalfd_notify(t, sig);
 	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b380e25..66ed49e 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -233,11 +233,12 @@ __initcall(init_posix_timers);
  * The siginfo si_overrun field and the return value of timer_getoverrun(2)
  * are of type int. Clamp the overrun value to INT_MAX
  */
-static inline int timer_overrun_to_int(struct k_itimer *timr, int baseval)
+static inline int timer_overrun_to_int(struct k_itimer *timr)
 {
-	s64 sum = timr->it_overrun_last + (s64)baseval;
+	if (timr->it_overrun_last > (s64)INT_MAX)
+		return INT_MAX;
 
-	return sum > (s64)INT_MAX ? INT_MAX : (int)sum;
+	return (int)timr->it_overrun_last;
 }
 
 static void common_hrtimer_rearm(struct k_itimer *timr)
@@ -280,7 +281,7 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 		timr->it_overrun = -1LL;
 		++timr->it_signal_seq;
 
-		info->si_overrun = timer_overrun_to_int(timr, info->si_overrun);
+		info->si_overrun = timer_overrun_to_int(timr);
 	}
 	ret = true;
 
@@ -774,7 +775,7 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 	if (!timr)
 		return -EINVAL;
 
-	overrun = timer_overrun_to_int(timr, 0);
+	overrun = timer_overrun_to_int(timr);
 	unlock_timer(timr, flags);
 
 	return overrun;

