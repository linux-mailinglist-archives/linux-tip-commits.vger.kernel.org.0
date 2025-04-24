Return-Path: <linux-tip-commits+bounces-5115-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C457DA9B344
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 18:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9492924352
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 16:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5FE27F73B;
	Thu, 24 Apr 2025 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AgcxEAuO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rq4kHA0Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDC73596A;
	Thu, 24 Apr 2025 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510546; cv=none; b=UuGAh2o3BbjSQPTTDYr7kAL9gH2rHB/cdm8NuRGdXmIfv8TMWZPN01/0NWGoGfYleLXVPWPB5Iav9xB7iLAN35d5R9NWVbqMJVoUZGjX40nU+ElJtQUU0T7IkzCVIkJUtF+r2YKgYMXBwTUu5tosxbuDfoPrBD+Jy8vJbESQ9yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510546; c=relaxed/simple;
	bh=T5LMZJXjhr3tRPeeRCkMAJ0+GhoAtZ4TWqdYkgxsaVk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iuj+dAIbQAKnQagFs6xocXs8LtvLMYBQ6btFVdmoPCr97kd3O4kEqrXPeHt+WZ4D2AE2At8S3UXaK6E6ZrTOA9XqBBc2E96uzM2k83KA21opErPunUAfGRS7gNS0+5kb6CaOb2nIRE3m08Kq1VK2WdD0QUlTgu3GyC1QzpRO0FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AgcxEAuO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rq4kHA0Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Apr 2025 16:02:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745510542;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P79Cs3WAD9cf4xNSiMqjg0SZzjdJqSOhpDOIowOEJNw=;
	b=AgcxEAuOjKokzIGZrdXip2hBmahKfG+BeRT6eVOEWZtJ1n3eMjHliXnsnNqlGIwWFezKnh
	b9eKTGuEh8bLpK1DF3HvCbsulTyR3oKb+JugkHvlJ9FbOMB6x2+P15CS7VmZ6df5cvif71
	3uhw1KysE7YYtcHkfU8mfiBSdu5Ih0HL9HIZkzDgcOvDI8mEScz1r6fCIrxHidiNJwk2Gs
	CsV3oQkP7n5KQXv1WgZ1yrBWGGwfQ1T2pABc+U7ZpSLBbIjLXsbMiPMFq7g799e2eA0twd
	+Veoo9Q/omL/IqBlaV9DIAtvFIvtm4k2ZhICocsTE4Nf8oVPvBgwnHkqjZbsPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745510542;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P79Cs3WAD9cf4xNSiMqjg0SZzjdJqSOhpDOIowOEJNw=;
	b=Rq4kHA0ZoKnornwK8yFaUI5aN7sF9kTAn/1RGK90J5DX+pT9WtZ0dCKXR50JA0Z1+C1994
	YxmFC9tLn3f0PGBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] timekeeping: Prevent coarse clocks going backwards
Cc: Lei Chen <lei.chen@smartx.com>, Thomas Gleixner <tglx@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250419054706.2319105-1-jstultz@google.com>
References: <20250419054706.2319105-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174551052233.31282.17192948467327807392.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     b2d289bc3730bde1eebb069b9392b678e9d6ef7c
Gitweb:        https://git.kernel.org/tip/b2d289bc3730bde1eebb069b9392b678e9d6ef7c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 18 Apr 2025 22:46:52 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Apr 2025 17:53:29 +02:00

timekeeping: Prevent coarse clocks going backwards

Lei Chen raised an issue with CLOCK_MONOTONIC_COARSE seeing time
inconsistencies. Lei tracked down that this was being caused by the
adjustment

    tk->tkr_mono.xtime_nsec -= offset;

which is made to compensate for the unaccumulated cycles in offset when the
multiplicator is adjusted forward, so that the non-_COARSE clockids don't
see inconsistencies.

However, the _COARSE clockid getter functions use the adjusted xtime_nsec
value directly and do not compensate the negative offset via the
clocksource delta multiplied with the new multiplicator. In that case the
caller can observe time going backwards in consecutive calls.

By design, this negative adjustment should be fine, because the logic run
from timekeeping_adjust() is done after it accumulated approximately

     multiplicator * interval_cycles

into xtime_nsec.  The accumulated value is always larger then the

     mult_adj * offset

value, which is subtracted from xtime_nsec. Both operations are done
together under the tk_core.lock, so the net change to xtime_nsec is always
always be positive.

However, do_adjtimex() calls into timekeeping_advance() as well, to
apply the NTP frequency adjustment immediately. In this case,
timekeeping_advance() does not return early when the offset is smaller
then interval_cycles. In that case there is no time accumulated into
xtime_nsec. But the subsequent call into timekeeping_adjust(), which
modifies the multiplicator, subtracts from xtime_nsec to correct for the
new multiplicator.

Here because there was no accumulation, xtime_nsec becomes smaller than
before, which opens a window up to the next accumulation, where the
_COARSE clockid getters, which don't compensate for the offset, can
observe the inconsistency.

This has been tried to be fixed by forwarding the timekeeper in the case
that adjtimex() adjusts the multiplier, which resets the offset to zero:

  757b000f7b93 ("timekeeping: Fix possible inconsistencies in _COARSE clockids")

That works correctly, but unfortunately causes a regression on the
adjtimex() side. There are two issues:

   1) The forwarding of the base time moves the update out of the original
      period and establishes a new one.

   2) The clearing of the accumulated NTP error is changing the behaviour as
      well.

Userspace expects that multiplier/frequency updates are in effect, when the
syscall returns, so delaying the update to the next tick is not solving the
problem either.

Commit 757b000f7b93 was reverted so that the established expectations of
user space implementations (ntpd, chronyd) are restored, but that obviously
brought the inconsistencies back.

One of the initial approaches to fix this was to establish a separate
storage for the coarse time getter nanoseconds part by calculating it from
the offset. That was dropped on the floor because not having yet another
state to maintain was simpler. But given the result of the above exercise,
this solution turns out to be the right one. Bring it back in a slightly
modified form.

Thus introduce timekeeper::coarse_nsec and store that nanoseconds part in
it, switch the time getter functions and the VDSO update to use that value.
coarse_nsec is set on operations which forward or initialize the timekeeper
and after time was accumulated during a tick. If there is no accumulation
the timestamp is unchanged.

This leaves the adjtimex() behaviour unmodified and prevents coarse time
from going backwards.

[ jstultz: Simplified the coarse_nsec calculation and kept behavior so
  	   coarse clockids aren't adjusted on each inter-tick adjtimex
  	   call, slightly reworked the comments and commit message ]

Fixes: da15cfdae033 ("time: Introduce CLOCK_REALTIME_COARSE")
Reported-by: Lei Chen <lei.chen@smartx.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250419054706.2319105-1-jstultz@google.com
Closes: https://lore.kernel.org/lkml/20250310030004.3705801-1-lei.chen@smartx.com/
---
 include/linux/timekeeper_internal.h |  8 ++--
 kernel/time/timekeeping.c           | 50 +++++++++++++++++++++++-----
 kernel/time/vsyscall.c              |  4 +-
 3 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index e39d4d5..785048a 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -51,7 +51,7 @@ struct tk_read_base {
  * @offs_real:			Offset clock monotonic -> clock realtime
  * @offs_boot:			Offset clock monotonic -> clock boottime
  * @offs_tai:			Offset clock monotonic -> clock tai
- * @tai_offset:			The current UTC to TAI offset in seconds
+ * @coarse_nsec:		The nanoseconds part for coarse time getters
  * @tkr_raw:			The readout base structure for CLOCK_MONOTONIC_RAW
  * @raw_sec:			CLOCK_MONOTONIC_RAW  time in seconds
  * @clock_was_set_seq:		The sequence number of clock was set events
@@ -76,6 +76,7 @@ struct tk_read_base {
  *				ntp shifted nano seconds.
  * @ntp_err_mult:		Multiplication factor for scaled math conversion
  * @skip_second_overflow:	Flag used to avoid updating NTP twice with same second
+ * @tai_offset:			The current UTC to TAI offset in seconds
  *
  * Note: For timespec(64) based interfaces wall_to_monotonic is what
  * we need to add to xtime (or xtime corrected for sub jiffy times)
@@ -100,7 +101,7 @@ struct tk_read_base {
  * which results in the following cacheline layout:
  *
  * 0:	seqcount, tkr_mono
- * 1:	xtime_sec ... tai_offset
+ * 1:	xtime_sec ... coarse_nsec
  * 2:	tkr_raw, raw_sec
  * 3,4: Internal variables
  *
@@ -121,7 +122,7 @@ struct timekeeper {
 	ktime_t			offs_real;
 	ktime_t			offs_boot;
 	ktime_t			offs_tai;
-	s32			tai_offset;
+	u32			coarse_nsec;
 
 	/* Cacheline 2: */
 	struct tk_read_base	tkr_raw;
@@ -144,6 +145,7 @@ struct timekeeper {
 	u32			ntp_error_shift;
 	u32			ntp_err_mult;
 	u32			skip_second_overflow;
+	s32			tai_offset;
 };
 
 #ifdef CONFIG_GENERIC_TIME_VSYSCALL
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 1e67d07..a009c91 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -164,10 +164,34 @@ static inline struct timespec64 tk_xtime(const struct timekeeper *tk)
 	return ts;
 }
 
+static inline struct timespec64 tk_xtime_coarse(const struct timekeeper *tk)
+{
+	struct timespec64 ts;
+
+	ts.tv_sec = tk->xtime_sec;
+	ts.tv_nsec = tk->coarse_nsec;
+	return ts;
+}
+
+/*
+ * Update the nanoseconds part for the coarse time keepers. They can't rely
+ * on xtime_nsec because xtime_nsec could be adjusted by a small negative
+ * amount when the multiplication factor of the clock is adjusted, which
+ * could cause the coarse clocks to go slightly backwards. See
+ * timekeeping_apply_adjustment(). Thus we keep a separate copy for the coarse
+ * clockids which only is updated when the clock has been set or  we have
+ * accumulated time.
+ */
+static inline void tk_update_coarse_nsecs(struct timekeeper *tk)
+{
+	tk->coarse_nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+}
+
 static void tk_set_xtime(struct timekeeper *tk, const struct timespec64 *ts)
 {
 	tk->xtime_sec = ts->tv_sec;
 	tk->tkr_mono.xtime_nsec = (u64)ts->tv_nsec << tk->tkr_mono.shift;
+	tk_update_coarse_nsecs(tk);
 }
 
 static void tk_xtime_add(struct timekeeper *tk, const struct timespec64 *ts)
@@ -175,6 +199,7 @@ static void tk_xtime_add(struct timekeeper *tk, const struct timespec64 *ts)
 	tk->xtime_sec += ts->tv_sec;
 	tk->tkr_mono.xtime_nsec += (u64)ts->tv_nsec << tk->tkr_mono.shift;
 	tk_normalize_xtime(tk);
+	tk_update_coarse_nsecs(tk);
 }
 
 static void tk_set_wall_to_mono(struct timekeeper *tk, struct timespec64 wtm)
@@ -708,6 +733,7 @@ static void timekeeping_forward_now(struct timekeeper *tk)
 		tk_normalize_xtime(tk);
 		delta -= incr;
 	}
+	tk_update_coarse_nsecs(tk);
 }
 
 /**
@@ -804,8 +830,8 @@ EXPORT_SYMBOL_GPL(ktime_get_with_offset);
 ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned int seq;
 	ktime_t base, *offset = offsets[offs];
+	unsigned int seq;
 	u64 nsecs;
 
 	WARN_ON(timekeeping_suspended);
@@ -813,7 +839,7 @@ ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 		base = ktime_add(tk->tkr_mono.base, *offset);
-		nsecs = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+		nsecs = tk->coarse_nsec;
 
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
@@ -2161,7 +2187,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	struct timekeeper *real_tk = &tk_core.timekeeper;
 	unsigned int clock_set = 0;
 	int shift = 0, maxshift;
-	u64 offset;
+	u64 offset, orig_offset;
 
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
 
@@ -2172,7 +2198,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	offset = clocksource_delta(tk_clock_read(&tk->tkr_mono),
 				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
 				   tk->tkr_mono.clock->max_raw_delta);
-
+	orig_offset = offset;
 	/* Check if there's really nothing to do */
 	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)
 		return false;
@@ -2205,6 +2231,14 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	 */
 	clock_set |= accumulate_nsecs_to_secs(tk);
 
+	/*
+	 * To avoid inconsistencies caused adjtimex TK_ADV_FREQ calls
+	 * making small negative adjustments to the base xtime_nsec
+	 * value, only update the coarse clocks if we accumulated time
+	 */
+	if (orig_offset != offset)
+		tk_update_coarse_nsecs(tk);
+
 	timekeeping_update_from_shadow(&tk_core, clock_set);
 
 	return !!clock_set;
@@ -2248,7 +2282,7 @@ void ktime_get_coarse_real_ts64(struct timespec64 *ts)
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 
-		*ts = tk_xtime(tk);
+		*ts = tk_xtime_coarse(tk);
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 }
 EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
@@ -2271,7 +2305,7 @@ void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts)
 
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
-		*ts = tk_xtime(tk);
+		*ts = tk_xtime_coarse(tk);
 		offset = tk_core.timekeeper.offs_real;
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
@@ -2350,12 +2384,12 @@ void ktime_get_coarse_ts64(struct timespec64 *ts)
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 
-		now = tk_xtime(tk);
+		now = tk_xtime_coarse(tk);
 		mono = tk->wall_to_monotonic;
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
 	set_normalized_timespec64(ts, now.tv_sec + mono.tv_sec,
-				now.tv_nsec + mono.tv_nsec);
+				  now.tv_nsec + mono.tv_nsec);
 }
 EXPORT_SYMBOL(ktime_get_coarse_ts64);
 
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 01c2ab1..32ef27c 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -98,12 +98,12 @@ void update_vsyscall(struct timekeeper *tk)
 	/* CLOCK_REALTIME_COARSE */
 	vdso_ts		= &vc[CS_HRES_COARSE].basetime[CLOCK_REALTIME_COARSE];
 	vdso_ts->sec	= tk->xtime_sec;
-	vdso_ts->nsec	= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+	vdso_ts->nsec	= tk->coarse_nsec;
 
 	/* CLOCK_MONOTONIC_COARSE */
 	vdso_ts		= &vc[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC_COARSE];
 	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
-	nsec		= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+	nsec		= tk->coarse_nsec;
 	nsec		= nsec + tk->wall_to_monotonic.tv_nsec;
 	vdso_ts->sec	+= __iter_div_u64_rem(nsec, NSEC_PER_SEC, &vdso_ts->nsec);
 

