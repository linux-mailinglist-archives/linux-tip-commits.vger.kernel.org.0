Return-Path: <linux-tip-commits+bounces-4669-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636D4A7C259
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9265F3B1102
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417D1215075;
	Fri,  4 Apr 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a/QOmTTA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tt786yWI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A8F2147EF;
	Fri,  4 Apr 2025 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743787354; cv=none; b=gSgjuWKcYn5VRqccJnXY3S1fhwkiQkVE6H9VbynOOK8sNq4HQx3+xUdclm9DNQ5jH93+s3NFGBFXSLaAEWiCcGpnJl4fiN8cnNx4Hv3tGt4IqF7sI5EbO7buCZPdAHEUUs9oOvULk6O/cWk0gVoutOmYYJWOlGg20gHX5tO7WRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743787354; c=relaxed/simple;
	bh=acrvq7csjOcv/SlifOw2NxUWeB2+KQdjhzVOsZ9Ryqs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CIVipyBZwCCDCW4X6RZGHbrJ12HD+lwSEWqLYQSNETmtHDtkWichgfqiKOi3gtTXls3s84CUkx57rzYUUEwfC3JMjgmrF2J3hhndQv9DbFugBMgaRUDdUBa24rAgjjElLLITV1zwFk9R/0Q6xTWG0jgBH3cugSIvt0jjJbWnH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a/QOmTTA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tt786yWI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:22:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743787350;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RyxCxICuuHokyfU8AQ5uloO0o8334aXk+EI129fJyMY=;
	b=a/QOmTTAR20XjCKaEAUrY/e4c4jnagew5oGEdqinyViYRlA96mgPKUxH8DtuxKCrjNJqYH
	xcC8Ct0LvKoX5M7U1J8/wE3e+vCZBzpYzA4bkxQl35xsnP3OozCIsryULGM9+gCs4kFf+L
	jp06G5HzpKzUAAqsguU/b0IVuk3MrldJ1g049N74q6hfn84+QGhd1ngo34Iqa0MCSxgA8D
	WOyQsNqCwpnAznLkZrPXl3EuFiDNxRDe74NNSb+5ZewoIBbEVkd40NKsFCVa53744fKQum
	AuoIteE/B6g2GaGHQ1WIIF4hJQDMhL1/0MIQRQ7JCFdiQ4HNpLDkz3or4dzpQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743787350;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RyxCxICuuHokyfU8AQ5uloO0o8334aXk+EI129fJyMY=;
	b=Tt786yWIn31ATZcY+4RCT4LivtrxU3bPSddUIqytmGaD3DoC3JIJrA1w/7dU0N4uAzifh5
	FMVGxuwRs8s3HUCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] Revert "timekeeping: Fix possible
 inconsistencies in _COARSE clockids"
Cc: Miroslav Lichvar <mlichvar@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <Z-qsg6iDGlcIJulJ@localhost>
References: <Z-qsg6iDGlcIJulJ@localhost>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174378734570.31282.1517542045196187546.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     324a2219ba38b00ab0e53bd535782771ba9614b2
Gitweb:        https://git.kernel.org/tip/324a2219ba38b00ab0e53bd535782771ba9614b2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 04 Apr 2025 17:10:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:10:00 +02:00

Revert "timekeeping: Fix possible inconsistencies in _COARSE clockids"

This reverts commit 757b000f7b936edf79311ab0971fe465bbda75ea.

Miroslav reported that the changes for handling the inconsistencies in the
coarse time getters result in a regression on the adjtimex() side.

There are two issues:

  1) The forwarding of the base time moves the update out of the original
     period and establishes a new one.

  2) The clearing of the accumulated NTP error is changing the behaviour as
     well.

Userspace expects that multiplier/frequency updates are in effect, when the
syscall returns, so delaying the update to the next tick is not solving the
problem either.

Revert the change, so that the established expectations of user space
implementations (ntpd, chronyd) are restored. The re-introduced
inconsistency of the coarse time getters will be addressed in a subsequent
fix.

Fixes: 757b000f7b93 ("timekeeping: Fix possible inconsistencies in _COARSE clockids")
Reported-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/Z-qsg6iDGlcIJulJ@localhost
---
 kernel/time/timekeeping.c | 94 ++++++++++----------------------------
 1 file changed, 25 insertions(+), 69 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 929846b..1e67d07 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -682,19 +682,20 @@ static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int act
 }
 
 /**
- * timekeeping_forward - update clock to given cycle now value
+ * timekeeping_forward_now - update clock to the current time
  * @tk:		Pointer to the timekeeper to update
- * @cycle_now:  Current clocksource read value
  *
  * Forward the current clock to update its state since the last call to
  * update_wall_time(). This is useful before significant clock changes,
  * as it avoids having to deal with this time offset explicitly.
  */
-static void timekeeping_forward(struct timekeeper *tk, u64 cycle_now)
+static void timekeeping_forward_now(struct timekeeper *tk)
 {
-	u64 delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
-				      tk->tkr_mono.clock->max_raw_delta);
+	u64 cycle_now, delta;
 
+	cycle_now = tk_clock_read(&tk->tkr_mono);
+	delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
+				  tk->tkr_mono.clock->max_raw_delta);
 	tk->tkr_mono.cycle_last = cycle_now;
 	tk->tkr_raw.cycle_last  = cycle_now;
 
@@ -710,21 +711,6 @@ static void timekeeping_forward(struct timekeeper *tk, u64 cycle_now)
 }
 
 /**
- * timekeeping_forward_now - update clock to the current time
- * @tk:		Pointer to the timekeeper to update
- *
- * Forward the current clock to update its state since the last call to
- * update_wall_time(). This is useful before significant clock changes,
- * as it avoids having to deal with this time offset explicitly.
- */
-static void timekeeping_forward_now(struct timekeeper *tk)
-{
-	u64 cycle_now = tk_clock_read(&tk->tkr_mono);
-
-	timekeeping_forward(tk, cycle_now);
-}
-
-/**
  * ktime_get_real_ts64 - Returns the time of day in a timespec64.
  * @ts:		pointer to the timespec to be set
  *
@@ -2165,54 +2151,6 @@ static u64 logarithmic_accumulation(struct timekeeper *tk, u64 offset,
 	return offset;
 }
 
-static u64 timekeeping_accumulate(struct timekeeper *tk, u64 offset,
-				  enum timekeeping_adv_mode mode,
-				  unsigned int *clock_set)
-{
-	int shift = 0, maxshift;
-
-	/*
-	 * TK_ADV_FREQ indicates that adjtimex(2) directly set the
-	 * frequency or the tick length.
-	 *
-	 * Accumulate the offset, so that the new multiplier starts from
-	 * now. This is required as otherwise for offsets, which are
-	 * smaller than tk::cycle_interval, timekeeping_adjust() could set
-	 * xtime_nsec backwards, which subsequently causes time going
-	 * backwards in the coarse time getters. But even for the case
-	 * where offset is greater than tk::cycle_interval the periodic
-	 * accumulation does not have much value.
-	 *
-	 * Also reset tk::ntp_error as it does not make sense to keep the
-	 * old accumulated error around in this case.
-	 */
-	if (mode == TK_ADV_FREQ) {
-		timekeeping_forward(tk, tk->tkr_mono.cycle_last + offset);
-		tk->ntp_error = 0;
-		return 0;
-	}
-
-	/*
-	 * With NO_HZ we may have to accumulate many cycle_intervals
-	 * (think "ticks") worth of time at once. To do this efficiently,
-	 * we calculate the largest doubling multiple of cycle_intervals
-	 * that is smaller than the offset.  We then accumulate that
-	 * chunk in one go, and then try to consume the next smaller
-	 * doubled multiple.
-	 */
-	shift = ilog2(offset) - ilog2(tk->cycle_interval);
-	shift = max(0, shift);
-	/* Bound shift to one less than what overflows tick_length */
-	maxshift = (64 - (ilog2(ntp_tick_length()) + 1)) - 1;
-	shift = min(shift, maxshift);
-	while (offset >= tk->cycle_interval) {
-		offset = logarithmic_accumulation(tk, offset, shift, clock_set);
-		if (offset < tk->cycle_interval << shift)
-			shift--;
-	}
-	return offset;
-}
-
 /*
  * timekeeping_advance - Updates the timekeeper to the current time and
  * current NTP tick length
@@ -2222,6 +2160,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 	struct timekeeper *real_tk = &tk_core.timekeeper;
 	unsigned int clock_set = 0;
+	int shift = 0, maxshift;
 	u64 offset;
 
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
@@ -2238,7 +2177,24 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)
 		return false;
 
-	offset = timekeeping_accumulate(tk, offset, mode, &clock_set);
+	/*
+	 * With NO_HZ we may have to accumulate many cycle_intervals
+	 * (think "ticks") worth of time at once. To do this efficiently,
+	 * we calculate the largest doubling multiple of cycle_intervals
+	 * that is smaller than the offset.  We then accumulate that
+	 * chunk in one go, and then try to consume the next smaller
+	 * doubled multiple.
+	 */
+	shift = ilog2(offset) - ilog2(tk->cycle_interval);
+	shift = max(0, shift);
+	/* Bound shift to one less than what overflows tick_length */
+	maxshift = (64 - (ilog2(ntp_tick_length())+1)) - 1;
+	shift = min(shift, maxshift);
+	while (offset >= tk->cycle_interval) {
+		offset = logarithmic_accumulation(tk, offset, shift, &clock_set);
+		if (offset < tk->cycle_interval<<shift)
+			shift--;
+	}
 
 	/* Adjust the multiplier to correct NTP error */
 	timekeeping_adjust(tk, offset);

