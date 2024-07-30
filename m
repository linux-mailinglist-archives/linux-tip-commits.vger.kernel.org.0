Return-Path: <linux-tip-commits+bounces-1872-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3D8941C75
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5F4282F16
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A35818E02B;
	Tue, 30 Jul 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gTkM6WH5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PKe30KCs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7123218C902;
	Tue, 30 Jul 2024 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359194; cv=none; b=pNWNXox4t7eiZF/7QYX45Ijakam5gay2k89feZOKRuco/fUf5H00CX01Y9F+g5mt5X51d83jcAnp4Fd3rL9KYMOml5Ji4HHpTMJTkTDsnidMtffj3iXezgoBUHWRON+eVjMvEAFDlmdSscJ3UOt5bEjWnPHjtoopKgoOJJbEvFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359194; c=relaxed/simple;
	bh=0wvArvbtmDcZgrOWXIWq4bLtzXffkU2h8BWLMAchJTA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=tOjoOMkPVR1+R/brJkTafLvd5i+kDDfIy8UFZx+BNbNEMo9J/Qlp3vJt91EvH7Q3zZh1geTWqu6LqAOFaM01eYaDgB9OsgU3jxreshuHH66XRgzyMi/pvrH5zFLAcGvR7PusTVQuO9wJLK1cgS/VdFi8BjCxWKnp8CsB0i0Ss8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gTkM6WH5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PKe30KCs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CRK8eI6uJD1N++bpaKwXRf3DW91bIs4V7MAPyhQZxac=;
	b=gTkM6WH5BagZJGYdneVACtWz/ieBUDSCw1dOa2LS2Olt+iW7X6ega+i9tDYmVhzlwz8scd
	T97KVHcOa+EgA2yJks1UipgiCJHrHz4giBJSxH3EitShc0sYGnLYKoPF2NqNY5qvGEp8Hh
	DARGFiiKxfTDQuxVCZzPwKdMRESPbojZXnZYFUUBWSpVRLXn16BU0m8SdiTdH1NlPcfB/2
	pv/i0MAuOJKxBpB9a7s7dCogumFw3Jgd8LVDjXl/nvLNX0WSppGuMmn9JpcLGAKWefdJ9s
	fpA/RUwcuiKHsQ3ZTHMAxNtoAcX23QClkgy++LONgCemfHDdJD5ITkzA7gyNEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CRK8eI6uJD1N++bpaKwXRf3DW91bIs4V7MAPyhQZxac=;
	b=PKe30KCsuTeAKdB2mk0rRQs1JEaq+nS8THJkjKoe3O3Wo/g/CytKZORSlaKm3kZJlfu1zp
	hwAaVIJJKvkp+NCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Retrieve interval in common
 timer_settime() code
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
Message-ID: <172235918977.2215.15763526336696027464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bfa408f03fc74bcfe8f275a434294bde06eabb00
Gitweb:        https://git.kernel.org/tip/bfa408f03fc74bcfe8f275a434294bde06eabb00
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:26 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:35 +02:00

posix-timers: Retrieve interval in common timer_settime() code

No point in doing this all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/posix-cpu-timers.c | 10 ++--------
 kernel/time/posix-timers.c     |  5 ++++-
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index c6fe017..4107977 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -622,8 +622,8 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 {
 	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
-	u64 old_expires, new_expires, old_incr, now;
 	struct cpu_timer *ctmr = &timer->it.cpu;
+	u64 old_expires, new_expires, now;
 	struct sighand_struct *sighand;
 	struct task_struct *p;
 	unsigned long flags;
@@ -660,10 +660,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 		return -ESRCH;
 	}
 
-	/*
-	 * Disarm any old timer after extracting its expiry time.
-	 */
-	old_incr = timer->it_interval;
+	/* Retrieve the current expiry time before disarming the timer */
 	old_expires = cpu_timer_getexpires(ctmr);
 
 	if (unlikely(timer->it.cpu.firing)) {
@@ -742,9 +739,6 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 		cpu_timer_fire(timer);
 out:
 	rcu_read_unlock();
-	if (old)
-		old->it_interval = ns_to_timespec64(old_incr);
-
 	return ret;
 }
 
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b924f0f..056966b 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -904,7 +904,7 @@ static int do_timer_settime(timer_t timer_id, int tmr_flags,
 	const struct k_clock *kc;
 	struct k_itimer *timr;
 	unsigned long flags;
-	int error = 0;
+	int error;
 
 	if (!timespec64_valid(&new_spec64->it_interval) ||
 	    !timespec64_valid(&new_spec64->it_value))
@@ -918,6 +918,9 @@ retry:
 	if (!timr)
 		return -EINVAL;
 
+	if (old_spec64)
+		old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
+
 	kc = timr->kclock;
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;

