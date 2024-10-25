Return-Path: <linux-tip-commits+bounces-2597-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E609B0C90
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8146B25652
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BB2217640;
	Fri, 25 Oct 2024 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vy5duR0g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ma/562O8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D25216E05;
	Fri, 25 Oct 2024 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879292; cv=none; b=u4MRI+dwa5liWlW+hCs6S6O3n7cPZc1GLZ8K+MvvkN0GfRRf6AjiUdRtZjoFyA4Mf3S4gMbYJBuBLCsbmM82sB4iksiGjocoGmLnPNa6bbvfgdzNWXmRDM05NVM5gYICn9/L2xklbCzAdrSpoKvZbkY/vMKvAKbodrtTLRNer0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879292; c=relaxed/simple;
	bh=WEzp1fGWHvGzUjpV6BHhfvFmSptddODZVewsiILc4ZE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E2mxCNHDe4rJiBaSJ5VBuih1zSUehGrKjbDIaarrwigNeimyUdVPq6wUDzzW4a6hI58nIXMTeMSdmx4JRip3Giz3SDPR0CIOWWzOI7NI/sW6Lq8dfrY/0By3C2spizuAvzJ12k3boTSG1oujoucaF5CVAPNG8FCdtSNKWGaHRvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vy5duR0g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ma/562O8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879287;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLmXTbsR4RRlPZ63ujfRfO5j15Z6Dsjw+RLXPKG6fLk=;
	b=Vy5duR0gSYgZsBZtrrV9UyKpGcS9bJzOV1uYQayzg+wjNmIuZhcivdUzQxkEwhlsctueN8
	DrjVCxJC+3w+Dp2lwH3nDXdwwtaPFiFd0KQ1vC4mXc8ylTn909/mlxhpOS6Vw/cX3hDr4W
	LA1PiKKJFG+x7rZX6O1LDWVsyXRwEwnHDhXa4QaqTAybiy/Rq2JZiPV0+kjXBJcjwplPTM
	RoW8w6lII3vg8YcgeJmNy87AhEzFV3q3om6QF3MYCpI7SlbrvBBPCWXMfqbDlyYjudG0/m
	vme9zQ0caegMxxeNSxl5fPdsQA7LTUbxO06QgZaABcTWCBwc8CFWOzUAN5tS7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879287;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLmXTbsR4RRlPZ63ujfRfO5j15Z6Dsjw+RLXPKG6fLk=;
	b=Ma/562O8Wwo4jpex9rymrb2O+ioGsvm5oy0yxYcOxaCBQd2JVwyWdDC3YU0ktygpH4w1Qh
	r8R+3BVBkbEWxACQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Reorder struct timekeeper
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241015100839.12702-1-anna-maria@linutronix.de>
References: <20241015100839.12702-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987928707.1442.8730819910241400397.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6860d28ccb2390b4eeda32ab2ce7eb10f71921e1
Gitweb:        https://git.kernel.org/tip/6860d28ccb2390b4eeda32ab2ce7eb10f71921e1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Oct 2024 12:08:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:13 +02:00

timekeeping: Reorder struct timekeeper

struct timekeeper is ordered suboptimal vs. cachelines. The layout,
including the preceding seqcount (see struct tk_core in timekeeper.c) is:

 cacheline 0:   seqcount, tkr_mono
 cacheline 1:   tkr_raw, xtime_sec
 cacheline 2:   ktime_sec ... tai_offset, internal variables
 cacheline 3:	next_leap_ktime, raw_sec, internal variables
 cacheline 4:	internal variables

So any access to via ktime_get*() except for access to CLOCK_MONOTONIC_RAW
will use either cachelines 0 + 1 or cachelines 0 + 2. Access to
CLOCK_MONOTONIC_RAW uses cachelines 0 + 1 + 3.

Reorder the members so that the result is more efficient:

 cacheline 0:   seqcount, tkr_mono
 cacheline 1:   xtime_sec, ktime_sec ... tai_offset
 cacheline 2:	tkr_raw, raw_sec
 cacheline 3:	internal variables
 cacheline 4:	internal variables

That means ktime_get*() will access cacheline 0 + 1 and CLOCK_MONOTONIC_RAW
access will use cachelines 0 + 2.

Update kernel-doc and fix formatting issues while at it. Also fix a typo
in struct tk_read_base kernel-doc.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241015100839.12702-1-anna-maria@linutronix.de

---
 include/linux/timekeeper_internal.h | 106 ++++++++++++++++-----------
 1 file changed, 65 insertions(+), 41 deletions(-)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index 902c20e..a3b6380 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -26,7 +26,7 @@
  * occupies a single 64byte cache line.
  *
  * The struct is separate from struct timekeeper as it is also used
- * for a fast NMI safe accessors.
+ * for the fast NMI safe accessors.
  *
  * @base_real is for the fast NMI safe accessor to allow reading clock
  * realtime from any context.
@@ -44,33 +44,41 @@ struct tk_read_base {
 
 /**
  * struct timekeeper - Structure holding internal timekeeping values.
- * @tkr_mono:		The readout base structure for CLOCK_MONOTONIC
- * @tkr_raw:		The readout base structure for CLOCK_MONOTONIC_RAW
- * @xtime_sec:		Current CLOCK_REALTIME time in seconds
- * @ktime_sec:		Current CLOCK_MONOTONIC time in seconds
- * @wall_to_monotonic:	CLOCK_REALTIME to CLOCK_MONOTONIC offset
- * @offs_real:		Offset clock monotonic -> clock realtime
- * @offs_boot:		Offset clock monotonic -> clock boottime
- * @offs_tai:		Offset clock monotonic -> clock tai
- * @tai_offset:		The current UTC to TAI offset in seconds
- * @clock_was_set_seq:	The sequence number of clock was set events
- * @cs_was_changed_seq:	The sequence number of clocksource change events
- * @next_leap_ktime:	CLOCK_MONOTONIC time value of a pending leap-second
- * @raw_sec:		CLOCK_MONOTONIC_RAW  time in seconds
- * @monotonic_to_boot:	CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
- * @cycle_interval:	Number of clock cycles in one NTP interval
- * @xtime_interval:	Number of clock shifted nano seconds in one NTP
- *			interval.
- * @xtime_remainder:	Shifted nano seconds left over when rounding
- *			@cycle_interval
- * @raw_interval:	Shifted raw nano seconds accumulated per NTP interval.
- * @ntp_error:		Difference between accumulated time and NTP time in ntp
- *			shifted nano seconds.
- * @ntp_error_shift:	Shift conversion between clock shifted nano seconds and
- *			ntp shifted nano seconds.
- * @last_warning:	Warning ratelimiter (DEBUG_TIMEKEEPING)
- * @underflow_seen:	Underflow warning flag (DEBUG_TIMEKEEPING)
- * @overflow_seen:	Overflow warning flag (DEBUG_TIMEKEEPING)
+ * @tkr_mono:			The readout base structure for CLOCK_MONOTONIC
+ * @xtime_sec:			Current CLOCK_REALTIME time in seconds
+ * @ktime_sec:			Current CLOCK_MONOTONIC time in seconds
+ * @wall_to_monotonic:		CLOCK_REALTIME to CLOCK_MONOTONIC offset
+ * @offs_real:			Offset clock monotonic -> clock realtime
+ * @offs_boot:			Offset clock monotonic -> clock boottime
+ * @offs_tai:			Offset clock monotonic -> clock tai
+ * @tai_offset:			The current UTC to TAI offset in seconds
+ * @tkr_raw:			The readout base structure for CLOCK_MONOTONIC_RAW
+ * @raw_sec:			CLOCK_MONOTONIC_RAW  time in seconds
+ * @clock_was_set_seq:		The sequence number of clock was set events
+ * @cs_was_changed_seq:		The sequence number of clocksource change events
+ * @monotonic_to_boot:		CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
+ * @cycle_interval:		Number of clock cycles in one NTP interval
+ * @xtime_interval:		Number of clock shifted nano seconds in one NTP
+ *				interval.
+ * @xtime_remainder:		Shifted nano seconds left over when rounding
+ *				@cycle_interval
+ * @raw_interval:		Shifted raw nano seconds accumulated per NTP interval.
+ * @next_leap_ktime:		CLOCK_MONOTONIC time value of a pending leap-second
+ * @ntp_tick:			The ntp_tick_length() value currently being
+ *				used. This cached copy ensures we consistently
+ *				apply the tick length for an entire tick, as
+ *				ntp_tick_length may change mid-tick, and we don't
+ *				want to apply that new value to the tick in
+ *				progress.
+ * @ntp_error:			Difference between accumulated time and NTP time in ntp
+ *				shifted nano seconds.
+ * @ntp_error_shift:		Shift conversion between clock shifted nano seconds and
+ *				ntp shifted nano seconds.
+ * @ntp_err_mult:		Multiplication factor for scaled math conversion
+ * @skip_second_overflow:	Flag used to avoid updating NTP twice with same second
+ * @last_warning:		Warning ratelimiter (DEBUG_TIMEKEEPING)
+ * @underflow_seen:		Underflow warning flag (DEBUG_TIMEKEEPING)
+ * @overflow_seen:		Overflow warning flag (DEBUG_TIMEKEEPING)
  *
  * Note: For timespec(64) based interfaces wall_to_monotonic is what
  * we need to add to xtime (or xtime corrected for sub jiffy times)
@@ -88,10 +96,28 @@ struct tk_read_base {
  *
  * @monotonic_to_boottime is a timespec64 representation of @offs_boot to
  * accelerate the VDSO update for CLOCK_BOOTTIME.
+ *
+ * The cacheline ordering of the structure is optimized for in kernel usage of
+ * the ktime_get() and ktime_get_ts64() family of time accessors. Struct
+ * timekeeper is prepended in the core timekeeping code with a sequence count,
+ * which results in the following cacheline layout:
+ *
+ * 0:	seqcount, tkr_mono
+ * 1:	xtime_sec ... tai_offset
+ * 2:	tkr_raw, raw_sec
+ * 3,4: Internal variables
+ *
+ * Cacheline 0,1 contain the data which is used for accessing
+ * CLOCK_MONOTONIC/REALTIME/BOOTTIME/TAI, while cacheline 2 contains the
+ * data for accessing CLOCK_MONOTONIC_RAW.  Cacheline 3,4 are internal
+ * variables which are only accessed during timekeeper updates once per
+ * tick.
  */
 struct timekeeper {
+	/* Cacheline 0 (together with prepended seqcount of timekeeper core): */
 	struct tk_read_base	tkr_mono;
-	struct tk_read_base	tkr_raw;
+
+	/* Cacheline 1: */
 	u64			xtime_sec;
 	unsigned long		ktime_sec;
 	struct timespec64	wall_to_monotonic;
@@ -99,31 +125,29 @@ struct timekeeper {
 	ktime_t			offs_boot;
 	ktime_t			offs_tai;
 	s32			tai_offset;
+
+	/* Cacheline 2: */
+	struct tk_read_base	tkr_raw;
+	u64			raw_sec;
+
+	/* Cachline 3 and 4 (timekeeping internal variables): */
 	unsigned int		clock_was_set_seq;
 	u8			cs_was_changed_seq;
-	ktime_t			next_leap_ktime;
-	u64			raw_sec;
+
 	struct timespec64	monotonic_to_boot;
 
-	/* The following members are for timekeeping internal use */
 	u64			cycle_interval;
 	u64			xtime_interval;
 	s64			xtime_remainder;
 	u64			raw_interval;
-	/* The ntp_tick_length() value currently being used.
-	 * This cached copy ensures we consistently apply the tick
-	 * length for an entire tick, as ntp_tick_length may change
-	 * mid-tick, and we don't want to apply that new value to
-	 * the tick in progress.
-	 */
+
+	ktime_t			next_leap_ktime;
 	u64			ntp_tick;
-	/* Difference between accumulated time and NTP time in ntp
-	 * shifted nano seconds. */
 	s64			ntp_error;
 	u32			ntp_error_shift;
 	u32			ntp_err_mult;
-	/* Flag used to avoid updating NTP twice with same second */
 	u32			skip_second_overflow;
+
 #ifdef CONFIG_DEBUG_TIMEKEEPING
 	long			last_warning;
 	/*

