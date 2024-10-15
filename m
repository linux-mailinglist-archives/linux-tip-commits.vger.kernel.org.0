Return-Path: <linux-tip-commits+bounces-2463-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD7D99FB91
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C81FB230EC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595771FDF9C;
	Tue, 15 Oct 2024 22:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e/YKKpi6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mR++QBFQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CF01F80A8;
	Tue, 15 Oct 2024 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032090; cv=none; b=mhiD0QlIh1xZIVzh0UygfsuEXFpVivbIi42ffysBXIh2fXdn1/nlKk2RgCZ4Va7gq1RxaAnQf6MkWKKKaLk222W6fwmTP9D4nSuUTAx3LR4Z3+1Dvnr14JeizYpEusssV76WTjQ9gp9LG8RKH2vogd6NNWubGn0xrz9zHqdyzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032090; c=relaxed/simple;
	bh=KfqTciSuNZFpdpJvBgTzht0tjJc8wUTwJk46Zela1iA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KQhL7qkttQe1Nd8fZ3ZW0WaFgkpz/Sy6vBO+V6NJvqoMGfUhPGuT2jj5DJcfxQ2zM1pwd9dkgqIAnqnh1OxHSvBiE/kQ1CYmnagyd9xgenBeFaDDIP7p06hCRpLoNroP+6G8zP3xw7JEJaOwnVA/OjCXSou7v2MiGpaPA/kInz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e/YKKpi6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mR++QBFQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:41:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729032085;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/4j39NF2zAupZrk2xyMClzsH733CIWJiDqLC29zw9A=;
	b=e/YKKpi67wjhb5BArv5qjsv6al8peZA49Cgz4gdFElSZjrhY5215kJ/2+aXoCo9GD7AVHi
	RHP24YErtZ6PXcuaMVeIWwK9KZuF5/kvnBzSl86BH6ynue/hO+VpYD8Uq3762WWtKNGItU
	APDUxO+rpubIK+SMzwPxjohsIaoEHZZdW+Xt+mIKGrkNp3pz7tckirMD0SPKhq3UDBh8QL
	FKE5DWCfsF7xZ2Cv+oLXThtO36lQB74G0kLwupJOcHenADtNWonhmQNS/NPIJ4Ma6CWEDB
	YQ8fQcnfeh4fMmkSWxvgJkN8SwcnnfbH45pHDiOETTIA1TfyFjEXinP9B8OXBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729032085;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/4j39NF2zAupZrk2xyMClzsH733CIWJiDqLC29zw9A=;
	b=mR++QBFQqK1tLWnyvMqoXl02tdrJmwmB9sYamUk7/X7tDwvq94mfBnynW/nGhtZdZOqwgg
	076LkARYrrl3Z9CA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Update function descriptions of
 sleep/delay related functions
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-5-dc8b907cb62f@linutronix.de>
References:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-5-dc8b907cb62f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903208484.1442.15909180065783184007.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f36eb171410839325fff9cd9b7b7400f7e606962
Gitweb:        https://git.kernel.org/tip/f36eb171410839325fff9cd9b7b7400f7e606962
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 14 Oct 2024 10:22:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 00:36:47 +02:00

timers: Update function descriptions of sleep/delay related functions

A lot of commonly used functions for inserting a sleep or delay lack a
proper function description. Add function descriptions to all of them to
have important information in a central place close to the code.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241014-devel-anna-maria-b4-timers-flseep-v3-5-dc8b907cb62f@linutronix.de

---
 include/asm-generic/delay.h | 41 +++++++++++++++++++++++++---
 include/linux/delay.h       | 48 ++++++++++++++++++++++++---------
 kernel/time/sleep_timeout.c | 53 +++++++++++++++++++++++++++++++-----
 3 files changed, 120 insertions(+), 22 deletions(-)

diff --git a/include/asm-generic/delay.h b/include/asm-generic/delay.h
index e448ac6..a8cee41 100644
--- a/include/asm-generic/delay.h
+++ b/include/asm-generic/delay.h
@@ -12,11 +12,39 @@ extern void __const_udelay(unsigned long xloops);
 extern void __delay(unsigned long loops);
 
 /*
- * The weird n/20000 thing suppresses a "comparison is always false due to
- * limited range of data type" warning with non-const 8-bit arguments.
+ * Implementation details:
+ *
+ * * The weird n/20000 thing suppresses a "comparison is always false due to
+ *   limited range of data type" warning with non-const 8-bit arguments.
+ * * 0x10c7 is 2**32 / 1000000 (rounded up) -> udelay
+ * * 0x5 is 2**32 / 1000000000 (rounded up) -> ndelay
  */
 
-/* 0x10c7 is 2**32 / 1000000 (rounded up) */
+/**
+ * udelay - Inserting a delay based on microseconds with busy waiting
+ * @usec:	requested delay in microseconds
+ *
+ * When delaying in an atomic context ndelay(), udelay() and mdelay() are the
+ * only valid variants of delaying/sleeping to go with.
+ *
+ * When inserting delays in non atomic context which are shorter than the time
+ * which is required to queue e.g. an hrtimer and to enter then the scheduler,
+ * it is also valuable to use udelay(). But it is not simple to specify a
+ * generic threshold for this which will fit for all systems. An approximation
+ * is a threshold for all delays up to 10 microseconds.
+ *
+ * When having a delay which is larger than the architecture specific
+ * %MAX_UDELAY_MS value, please make sure mdelay() is used. Otherwise a overflow
+ * risk is given.
+ *
+ * Please note that ndelay(), udelay() and mdelay() may return early for several
+ * reasons (https://lists.openwall.net/linux-kernel/2011/01/09/56):
+ *
+ * #. computed loops_per_jiffy too low (due to the time taken to execute the
+ *    timer interrupt.)
+ * #. cache behaviour affecting the time it takes to execute the loop function.
+ * #. CPU clock rate changes.
+ */
 #define udelay(n)							\
 	({								\
 		if (__builtin_constant_p(n)) {				\
@@ -29,7 +57,12 @@ extern void __delay(unsigned long loops);
 		}							\
 	})
 
-/* 0x5 is 2**32 / 1000000000 (rounded up) */
+/**
+ * ndelay - Inserting a delay based on nanoseconds with busy waiting
+ * @nsec:	requested delay in nanoseconds
+ *
+ * See udelay() for basic information about ndelay() and it's variants.
+ */
 #define ndelay(n)							\
 	({								\
 		if (__builtin_constant_p(n)) {				\
diff --git a/include/linux/delay.h b/include/linux/delay.h
index 2bc586a..2de509e 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -6,17 +6,7 @@
  * Copyright (C) 1993 Linus Torvalds
  *
  * Delay routines, using a pre-computed "loops_per_jiffy" value.
- *
- * Please note that ndelay(), udelay() and mdelay() may return early for
- * several reasons:
- *  1. computed loops_per_jiffy too low (due to the time taken to
- *     execute the timer interrupt.)
- *  2. cache behaviour affecting the time it takes to execute the
- *     loop function.
- *  3. CPU clock rate changes.
- *
- * Please see this thread:
- *   https://lists.openwall.net/linux-kernel/2011/01/09/56
+ * Sleep routines using timer list timers or hrtimers.
  */
 
 #include <linux/math.h>
@@ -35,12 +25,21 @@ extern unsigned long loops_per_jiffy;
  * The 2nd mdelay() definition ensures GCC will optimize away the 
  * while loop for the common cases where n <= MAX_UDELAY_MS  --  Paul G.
  */
-
 #ifndef MAX_UDELAY_MS
 #define MAX_UDELAY_MS	5
 #endif
 
 #ifndef mdelay
+/**
+ * mdelay - Inserting a delay based on milliseconds with busy waiting
+ * @n:	requested delay in milliseconds
+ *
+ * See udelay() for basic information about mdelay() and it's variants.
+ *
+ * Please double check, whether mdelay() is the right way to go or whether a
+ * refactoring of the code is the better variant to be able to use msleep()
+ * instead.
+ */
 #define mdelay(n) (\
 	(__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
 	({unsigned long __ms=(n); while (__ms--) udelay(1000);}))
@@ -63,16 +62,41 @@ unsigned long msleep_interruptible(unsigned int msecs);
 void usleep_range_state(unsigned long min, unsigned long max,
 			unsigned int state);
 
+/**
+ * usleep_range - Sleep for an approximate time
+ * @min:	Minimum time in microseconds to sleep
+ * @max:	Maximum time in microseconds to sleep
+ *
+ * For basic information please refere to usleep_range_state().
+ *
+ * The task will be in the state TASK_UNINTERRUPTIBLE during the sleep.
+ */
 static inline void usleep_range(unsigned long min, unsigned long max)
 {
 	usleep_range_state(min, max, TASK_UNINTERRUPTIBLE);
 }
 
+/**
+ * usleep_range_idle - Sleep for an approximate time with idle time accounting
+ * @min:	Minimum time in microseconds to sleep
+ * @max:	Maximum time in microseconds to sleep
+ *
+ * For basic information please refere to usleep_range_state().
+ *
+ * The sleeping task has the state TASK_IDLE during the sleep to prevent
+ * contribution to the load avarage.
+ */
 static inline void usleep_range_idle(unsigned long min, unsigned long max)
 {
 	usleep_range_state(min, max, TASK_IDLE);
 }
 
+/**
+ * ssleep - wrapper for seconds around msleep
+ * @seconds:	Requested sleep duration in seconds
+ *
+ * Please refere to msleep() for detailed information.
+ */
 static inline void ssleep(unsigned int seconds)
 {
 	msleep(seconds * 1000);
diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
index 560d17c..f3f246e 100644
--- a/kernel/time/sleep_timeout.c
+++ b/kernel/time/sleep_timeout.c
@@ -281,7 +281,34 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout);
 
 /**
  * msleep - sleep safely even with waitqueue interruptions
- * @msecs: Time in milliseconds to sleep for
+ * @msecs:	Requested sleep duration in milliseconds
+ *
+ * msleep() uses jiffy based timeouts for the sleep duration. Because of the
+ * design of the timer wheel, the maximum additional percentage delay (slack) is
+ * 12.5%. This is only valid for timers which will end up in level 1 or a higher
+ * level of the timer wheel. For explanation of those 12.5% please check the
+ * detailed description about the basics of the timer wheel.
+ *
+ * The slack of timers which will end up in level 0 depends on sleep duration
+ * (msecs) and HZ configuration and can be calculated in the following way (with
+ * the timer wheel design restriction that the slack is not less than 12.5%):
+ *
+ *   ``slack = MSECS_PER_TICK / msecs``
+ *
+ * When the allowed slack of the callsite is known, the calculation could be
+ * turned around to find the minimal allowed sleep duration to meet the
+ * constraints. For example:
+ *
+ * * ``HZ=1000`` with ``slack=25%``: ``MSECS_PER_TICK / slack = 1 / (1/4) = 4``:
+ *   all sleep durations greater or equal 4ms will meet the constraints.
+ * * ``HZ=1000`` with ``slack=12.5%``: ``MSECS_PER_TICK / slack = 1 / (1/8) = 8``:
+ *   all sleep durations greater or equal 8ms will meet the constraints.
+ * * ``HZ=250`` with ``slack=25%``: ``MSECS_PER_TICK / slack = 4 / (1/4) = 16``:
+ *   all sleep durations greater or equal 16ms will meet the constraints.
+ * * ``HZ=250`` with ``slack=12.5%``: ``MSECS_PER_TICK / slack = 4 / (1/8) = 32``:
+ *   all sleep durations greater or equal 32ms will meet the constraints.
+ *
+ * See also the signal aware variant msleep_interruptible().
  */
 void msleep(unsigned int msecs)
 {
@@ -294,7 +321,15 @@ EXPORT_SYMBOL(msleep);
 
 /**
  * msleep_interruptible - sleep waiting for signals
- * @msecs: Time in milliseconds to sleep for
+ * @msecs:	Requested sleep duration in milliseconds
+ *
+ * See msleep() for some basic information.
+ *
+ * The difference between msleep() and msleep_interruptible() is that the sleep
+ * could be interrupted by a signal delivery and then returns early.
+ *
+ * Returns: The remaining time of the sleep duration transformed to msecs (see
+ * schedule_timeout() for details).
  */
 unsigned long msleep_interruptible(unsigned int msecs)
 {
@@ -312,11 +347,17 @@ EXPORT_SYMBOL(msleep_interruptible);
  * @max:	Maximum time in usecs to sleep
  * @state:	State of the current task that will be while sleeping
  *
+ * usleep_range_state() sleeps at least for the minimum specified time but not
+ * longer than the maximum specified amount of time. The range might reduce
+ * power usage by allowing hrtimers to coalesce an already scheduled interrupt
+ * with this hrtimer. In the worst case, an interrupt is scheduled for the upper
+ * bound.
+ *
+ * The sleeping task is set to the specified state before starting the sleep.
+ *
  * In non-atomic context where the exact wakeup time is flexible, use
- * usleep_range_state() instead of udelay().  The sleep improves responsiveness
- * by avoiding the CPU-hogging busy-wait of udelay(), and the range reduces
- * power usage by allowing hrtimers to take advantage of an already-
- * scheduled interrupt instead of scheduling a new one just for this sleep.
+ * usleep_range() or its variants instead of udelay(). The sleep improves
+ * responsiveness by avoiding the CPU-hogging busy-wait of udelay().
  */
 void __sched usleep_range_state(unsigned long min, unsigned long max, unsigned int state)
 {

