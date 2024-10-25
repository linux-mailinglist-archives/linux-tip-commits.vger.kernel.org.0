Return-Path: <linux-tip-commits+bounces-2593-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9EA9B0C89
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C143A284DE1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008E1217446;
	Fri, 25 Oct 2024 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ri8JGrMa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AeolYwc5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156E8216217;
	Fri, 25 Oct 2024 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879290; cv=none; b=EpOV3mGzT7O+pF6oKyqety5xOZUoHfn0X08eQqKMjQbYVCvRSX8Y2fKXdNif4C3WS/1AzYpJ77tyqAuckmz3lAO/lAk5KTRSCRaahoeTXTYbl3Sy+HI47URs1Zxq/BR701VaE3TcXdj+FiEWGbbQX81acAc1uDossqKomPSycms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879290; c=relaxed/simple;
	bh=MKRXDjpRcBX7T/3mEJDkWYa+IQtn8HbfiKl8JxSoQo0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XjRakuYAvMSLV5ZKPh6+TAYfTcgmeoC39uF5evxqtr/XFhydez0JQbp8xkr3y6w9oyqu0/j1KVVVs/4i2xmwMXRshHImhRvkTacq4LKDzATSDUsuY21EJJNhSJeUmK2Vn5xTPPWsZ4I3XS1QvcDfGPt15fmXT1MLA+NW6EGkHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ri8JGrMa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AeolYwc5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879285;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JB1nQ8eAL7AzOLwDVPkRyxkemlZN9sCTONsQx6q8eE=;
	b=ri8JGrMak0BFv+S4UYryIrkW8rB0qmFFDbeRvECT5E+0B71C9EcZX01esYZb+mwWHgVqdP
	5naJTgnzJBeBd3osdS8V4HxmB4Qgja/WH5SgTkgAjjipBbqfkZWPCKUUqadFppYduaZNDg
	/0wJjwuVe/g35GnEfi4158IH/3gKDzRuxTrsuaZehc9o0qPz43qJfjwkaw+jO/uexa3APm
	E2TytUMugYLNHJExqk2s9Vfj9W+tfQYGVta/9XY83mxEt9Z/2yYl94U5VJVg1l3OHAmA8N
	8B5no3CzOC3UW8IjMuXmjf1TSdXrCRApZ7DhAMcn//qemLa6Kjd047A6S9nWKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879285;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JB1nQ8eAL7AzOLwDVPkRyxkemlZN9sCTONsQx6q8eE=;
	b=AeolYwc5RN7+YsKrCS+Pmmnmo3JB4UQgCn1ksYy1UAG5wr/MEkJWtYsf6yi2uOQWq+8qKw
	nmfIHoeTG7HmPWDA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Move timekeeper_lock into tk_core
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-9-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-9-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987928458.1442.11352120161668762824.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8c4799b1845eabbdd820aa340f493ba8919af7a2
Gitweb:        https://git.kernel.org/tip/8c4799b1845eabbdd820aa340f493ba8919af7a2
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:14 +02:00

timekeeping: Move timekeeper_lock into tk_core

timekeeper_lock protects updates to struct tk_core but is not part of
struct tk_core. As long as there is only a single timekeeper, this is not a
problem. But when the timekeeper infrastructure will be reused for per ptp
clock timekeepers, timekeeper_lock needs to be part of tk_core.

Move the lock into tk_core, move initialisation of the lock and sequence
counter into timekeeping_init() and update all users of timekeeper_lock.

As this is touching all lock sites, convert them to use:

  guard(raw_spinlock_irqsave)(&tk_core.lock);

instead of lock/unlock functions whenever possible.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-9-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 72 +++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 43 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 77e0a0f..5392a66 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -41,8 +41,6 @@ enum timekeeping_adv_mode {
 	TK_ADV_FREQ
 };
 
-static DEFINE_RAW_SPINLOCK(timekeeper_lock);
-
 /*
  * The most important data for readout fits into a single 64 byte
  * cache line.
@@ -51,10 +49,8 @@ static struct {
 	seqcount_raw_spinlock_t	seq;
 	struct timekeeper	timekeeper;
 	struct timekeeper	shadow_timekeeper;
-} tk_core ____cacheline_aligned = {
-	.seq = SEQCNT_RAW_SPINLOCK_ZERO(tk_core.seq, &timekeeper_lock),
-};
-
+	raw_spinlock_t		lock;
+} tk_core ____cacheline_aligned;
 
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
@@ -118,13 +114,13 @@ unsigned long timekeeper_lock_irqsave(void)
 {
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
 	return flags;
 }
 
 void timekeeper_unlock_irqrestore(unsigned long flags)
 {
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 }
 
 /*
@@ -216,7 +212,7 @@ static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
  * the tkr's clocksource may change between the read reference, and the
  * clock reference passed to the read function.  This can cause crashes if
  * the wrong clocksource is passed to the wrong read function.
- * This isn't necessary to use when holding the timekeeper_lock or doing
+ * This isn't necessary to use when holding the tk_core.lock or doing
  * a read of the fast-timekeeper tkrs (which is protected by its own locking
  * and update logic).
  */
@@ -708,13 +704,11 @@ static void update_pvclock_gtod(struct timekeeper *tk, bool was_set)
 int pvclock_gtod_register_notifier(struct notifier_block *nb)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned long flags;
 	int ret;
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
 	ret = raw_notifier_chain_register(&pvclock_gtod_chain, nb);
 	update_pvclock_gtod(tk, true);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
 	return ret;
 }
@@ -727,14 +721,8 @@ EXPORT_SYMBOL_GPL(pvclock_gtod_register_notifier);
  */
 int pvclock_gtod_unregister_notifier(struct notifier_block *nb)
 {
-	unsigned long flags;
-	int ret;
-
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
-	ret = raw_notifier_chain_unregister(&pvclock_gtod_chain, nb);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
-
-	return ret;
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
+	return raw_notifier_chain_unregister(&pvclock_gtod_chain, nb);
 }
 EXPORT_SYMBOL_GPL(pvclock_gtod_unregister_notifier);
 
@@ -782,7 +770,7 @@ static inline void tk_update_ktime_data(struct timekeeper *tk)
 	tk->tkr_raw.base = ns_to_ktime(tk->raw_sec * NSEC_PER_SEC);
 }
 
-/* must hold timekeeper_lock */
+/* must hold tk_core.lock */
 static void timekeeping_update(struct timekeeper *tk, unsigned int action)
 {
 	if (action & TK_CLEAR_NTP) {
@@ -1491,7 +1479,7 @@ int do_settimeofday64(const struct timespec64 *ts)
 	if (!timespec64_valid_settod(ts))
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
 	timekeeping_forward_now(tk);
@@ -1511,7 +1499,7 @@ out:
 	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL);
@@ -1541,7 +1529,7 @@ static int timekeeping_inject_offset(const struct timespec64 *ts)
 	if (ts->tv_nsec < 0 || ts->tv_nsec >= NSEC_PER_SEC)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
 	timekeeping_forward_now(tk);
@@ -1561,7 +1549,7 @@ error: /* even if we error out, we forwarded the time, so call update */
 	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL);
@@ -1637,7 +1625,7 @@ static int change_clocksource(void *data)
 		return 0;
 	}
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
 	timekeeping_forward_now(tk);
@@ -1646,7 +1634,7 @@ static int change_clocksource(void *data)
 	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	if (old) {
 		if (old->disable)
@@ -1801,7 +1789,9 @@ void __init timekeeping_init(void)
 	struct timespec64 wall_time, boot_offset, wall_to_mono;
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct clocksource *clock;
-	unsigned long flags;
+
+	raw_spin_lock_init(&tk_core.lock);
+	seqcount_raw_spinlock_init(&tk_core.seq, &tkd->lock);
 
 	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
 	if (timespec64_valid_settod(&wall_time) &&
@@ -1821,7 +1811,7 @@ void __init timekeeping_init(void)
 	 */
 	wall_to_mono = timespec64_sub(boot_offset, wall_time);
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
 	write_seqcount_begin(&tk_core.seq);
 	ntp_init();
 
@@ -1838,7 +1828,6 @@ void __init timekeeping_init(void)
 	timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 }
 
 /* time in seconds when suspend began for persistent clock */
@@ -1919,7 +1908,7 @@ void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
 	suspend_timing_needed = false;
@@ -1931,7 +1920,7 @@ void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL | CLOCK_SET_BOOT);
@@ -1955,7 +1944,7 @@ void timekeeping_resume(void)
 	clockevents_resume();
 	clocksource_resume();
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
 	/*
@@ -1993,7 +1982,7 @@ void timekeeping_resume(void)
 	timekeeping_suspended = 0;
 	timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
 	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	touch_softlockup_watchdog();
 
@@ -2024,7 +2013,7 @@ int timekeeping_suspend(void)
 
 	suspend_timing_needed = true;
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 	timekeeping_forward_now(tk);
 	timekeeping_suspended = 1;
@@ -2063,7 +2052,7 @@ int timekeeping_suspend(void)
 	timekeeping_update(tk, TK_MIRROR);
 	halt_fast_timekeeper(tk);
 	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	tick_suspend();
 	clocksource_suspend();
@@ -2323,7 +2312,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	int shift = 0, maxshift;
 	u64 offset;
 
-	guard(raw_spinlock_irqsave)(&timekeeper_lock);
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
 
 	/* Make sure we're fully resumed: */
 	if (unlikely(timekeeping_suspended))
@@ -2708,7 +2697,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 	ktime_get_real_ts64(&ts);
 	add_device_randomness(&ts, sizeof(ts));
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
 	orig_tai = tai = tk->tai_offset;
@@ -2723,7 +2712,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 	}
 
 	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	audit_ntp_log(&ad);
 
@@ -2747,11 +2736,8 @@ int do_adjtimex(struct __kernel_timex *txc)
  */
 void hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
 	__hardpps(phase_ts, raw_ts);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 }
 EXPORT_SYMBOL(hardpps);
 #endif /* CONFIG_NTP_PPS */

