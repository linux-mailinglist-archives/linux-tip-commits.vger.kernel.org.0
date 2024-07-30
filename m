Return-Path: <linux-tip-commits+bounces-1877-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8F0941C88
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938241F23EEC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5BE1A0733;
	Tue, 30 Jul 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dl0nwmlV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hkgK0ed2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7B518E03C;
	Tue, 30 Jul 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359196; cv=none; b=MLKhhvbwJDsmd3MxoO7QxZpXjOer5slO01ek9RCzsDtJ0ajwjwImUI/pViMhck94fcc2WY77eAZrOtOVlr3DNwJnsCtCfOlEtpPaToivmgec9GiIM9ea3df3Gn20nEMPOdB7YX1Qm6hZG286tvq1PjragPf4+oI7ERJSdlGYj3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359196; c=relaxed/simple;
	bh=2N5QIk9u5BCxLy6YLN5E+RJMVZVgOKrHjL4GWH703XI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Jaxx0phzu6CXny3EImzwbmImg6HIXv0vT8RiiMy0su5pS0Dw3DhXEAX1kaRNauXi7BxawcrhBb4DR+vodaN2lPmNmYzNhZA+c16iXqmEhZCZ5BuGwYet00roLwX2vtvsSD6bstVziSD+XVcoQX0iBHkTcYTCEGJJqVHJuwxm9ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dl0nwmlV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hkgK0ed2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359192;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=F244VwG0TWl1TF3TBCDFd5Js85A5tznaFCqCp51rvu8=;
	b=dl0nwmlVddsRcrgBOmfjDHVZJt8rE65j/3oJNMfeCmNjb4Ujcf52vxCpwpwmpEzGZnf6D0
	GMu5Ry6+lcrJS3rHIWzo9a2fg9fnYYsFwIZag76PNpY2DUxM+rUqifloBAShPpbwmvdxV8
	FLstyyZGhWB0xKHh9C5CKTuSL97Me4Per5msnu/blSPV4zpAEyeiLJexyf9iKmU0LvSmLO
	Hd434hyoQ4sADQbiKm4bobiSGGLQLWPOwpRAK3MPoMWqoupWhiAsmgjOrzsps94n64x8jS
	oakQWqbuZgclwvQDrJUXrmpK6mmxJeCQwEzzf2iRi9I7iil2OfayKzqnqk9uPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359192;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=F244VwG0TWl1TF3TBCDFd5Js85A5tznaFCqCp51rvu8=;
	b=hkgK0ed2u2vJOuTEsaqC9WVMHa+qMn5Prfyv+Dk1hqrXwJl13z/apX+94usJxWC8TWAsFr
	ejBYb5Q93Gw603Aw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Replace old expiry retrieval in
 posix_cpu_timer_set()
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
Message-ID: <172235919253.2215.5614152794990738705.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d471ff397c3571cfa648a20e7018aa04f8873cb3
Gitweb:        https://git.kernel.org/tip/d471ff397c3571cfa648a20e7018aa04f8873cb3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 13:17:08 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:34 +02:00

posix-cpu-timers: Replace old expiry retrieval in posix_cpu_timer_set()

Reuse the split out __posix_cpu_timer_get() function which does already the
right thing.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/posix-cpu-timers.c | 37 +++++----------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index cf89044..040d5c3 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -614,6 +614,8 @@ static void cpu_timer_fire(struct k_itimer *timer)
 	}
 }
 
+static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now);
+
 /*
  * Guts of sys_timer_settime for CPU timers.
  * This is called with the timer locked and interrupts disabled.
@@ -623,7 +625,6 @@ static void cpu_timer_fire(struct k_itimer *timer)
 static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 			       struct itimerspec64 *new, struct itimerspec64 *old)
 {
-	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	u64 old_expires, new_expires, old_incr, val;
 	struct cpu_timer *ctmr = &timer->it.cpu;
@@ -689,37 +690,11 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	else
 		val = cpu_clock_sample_group(clkid, p, true);
 
+	/* Retrieve the previous expiry value if requested. */
 	if (old) {
-		if (old_expires == 0) {
-			old->it_value.tv_sec = 0;
-			old->it_value.tv_nsec = 0;
-		} else {
-			/*
-			 * Update the timer in case it has overrun already.
-			 * If it has, we'll report it as having overrun and
-			 * with the next reloaded timer already ticking,
-			 * though we are swallowing that pending
-			 * notification here to install the new setting.
-			 */
-			u64 exp = bump_cpu_timer(timer, val);
-
-			if (val < exp) {
-				old_expires = exp - val;
-				old->it_value = ns_to_timespec64(old_expires);
-			} else {
-				/*
-				 * A single shot SIGEV_NONE timer must return 0, when it is
-				 * expired! Timers which have a real signal delivery mode
-				 * must return a remaining time greater than 0 because the
-				 * signal has not yet been delivered.
-				 */
-				if (sigev_none)
-					old->it_value.tv_nsec = 0;
-				else
-					old->it_value.tv_nsec = 1;
-				old->it_value.tv_sec = 0;
-			}
-		}
+		old->it_value = (struct timespec64){ };
+		if (old_expires)
+			__posix_cpu_timer_get(timer, old, val);
 	}
 
 	if (unlikely(ret)) {

