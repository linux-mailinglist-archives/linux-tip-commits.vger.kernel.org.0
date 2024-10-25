Return-Path: <linux-tip-commits+bounces-2590-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA33B9B0C83
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08ABE28386B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D152161FA;
	Fri, 25 Oct 2024 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H+bC4wMT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eYuxSwi3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF39214422;
	Fri, 25 Oct 2024 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879287; cv=none; b=iIj2ZW7ygATudFJO2Zn+HoIDUaRTB/b/4YKkhbnEtYHSK6TjKN3hbWp9aJ/Y50jM8TtcJa2cC1L/UyW9ShIyb2d8uY5HdmZHqVg3dmhpJRrIJmaOdpc2AzuwkQL4dNA05Mdzrc8Wks9yuf1S13XV+rem+VuY96PEN2aMeByNzh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879287; c=relaxed/simple;
	bh=B6aUwKlORBldAJWSLf8rX/+mB0XoNJ8cq4A2JyyjRpI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PKYgwBFP+y0Yv5MFh0acOHfI46N4oUgSfCT6/+7qZycsdKHLd2jdO7zRR0pu56RQObY4BFD+RiaUUaeNDQKTykNu2jTNTMiRUf5rSKX/YTzHgjNsphwGEy58dnt9Yq68yz3V6pcN5lNaDik8GJdhsGNzaD4l0wvWudKKA1qmTo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H+bC4wMT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eYuxSwi3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879283;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytn7kYpOkSMnfXCsIFoBC2SHCutkJ2xQ1e9aWKHxSTg=;
	b=H+bC4wMTB3YganezjAU0qwIqtDCmT+Fxig7EyZwZMDwF6ATrhY4JKLEc8BCNZ4QmBdUSDn
	szYq8Ay3hqJ1sZJM25H3+I9wRM42jvAv58L60IU8G12RiuSHvgR4XrjIW6W++Td4TOGbHS
	HmIFHr3uTLtYjs3T95Hz7RuSwsD9m9hYAvi40ZBhZlqPIPRQ1euDMEVAbiSQ4TKEXH5+Ss
	lnFo8tl5xBKq7VcUba56rcwmA/yMoFIL0rsRl9JuMWhx7Calon4glRkgfUdtpzWK/fjQ0L
	5Iv2uiFnV2/eY0jKDBoqrPWomGa7np3nuTpZ/w644/xk+htW+vlM1NPquoRfCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879283;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytn7kYpOkSMnfXCsIFoBC2SHCutkJ2xQ1e9aWKHxSTg=;
	b=eYuxSwi346GxcZmTITY7CaN+jw9SxpmYKXxcnUlTkRqVX5NnSiUn09kXpIy4kVXa0+GFjI
	TTwglV/lt5pt2PBw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Add struct tk_data as argument to
 timekeeping_update()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-12-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-12-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987928252.1442.14465186170246162619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1d72d7b5fd53592342db9c9d7d0fde14a883c2c4
Gitweb:        https://git.kernel.org/tip/1d72d7b5fd53592342db9c9d7d0fde14a883c2c4
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:14 +02:00

timekeeping: Add struct tk_data as argument to timekeeping_update()

Updates of the timekeeper are done in two ways:

 1. Updating timekeeper and afterwards memcpy()'ing the result into
    shadow_timekeeper using timekeeping_update(). Used everywhere for
    updates except in timekeeping_advance(); the sequence counter protected
    region starts before the first change to the timekeeper is done.

 2. Updating shadow_timekeeper and then memcpy()'ing the result into
    timekeeper.  Used only by in timekeeping_advance(); The seqence counter
    protected region is only around timekeeping_update() and the memcpy for
    copy from shadow to timekeeper.

The second option is fast path optimized. The sequence counter protected
region is as short as possible.

As this behaviour is mainly documented by commit messages, but not in code,
it makes the not easy timekeeping code more complicated to read.

There is no reason why updates to the timekeeper can't use the optimized
version everywhere. With this, the code will be cleaner, as code is reused
instead of duplicated.

To be able to access tk_data which contains all required information, add a
pointer to tk_data as an argument to timekeeping_update(). With that
convert the comment about holding the lock into a lockdep assert.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-12-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index cd83dea..979687a 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -547,7 +547,7 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
  *    timekeeping_inject_sleeptime64()
  *    __timekeeping_inject_sleeptime(tk, delta);
  *                                                 timestamp();
- *    timekeeping_update(tk, TK_CLEAR_NTP...);
+ *    timekeeping_update(tkd, tk, TK_CLEAR_NTP...);
  *
  * (2) On 32-bit systems, the 64-bit boot offset (tk->offs_boot) may be
  * partially updated.  Since the tk->offs_boot update is a rare event, this
@@ -772,9 +772,10 @@ static inline void tk_update_ktime_data(struct timekeeper *tk)
 	tk->tkr_raw.base = ns_to_ktime(tk->raw_sec * NSEC_PER_SEC);
 }
 
-/* must hold tk_core.lock */
-static void timekeeping_update(struct timekeeper *tk, unsigned int action)
+static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsigned int action)
 {
+	lockdep_assert_held(&tkd->lock);
+
 	if (action & TK_CLEAR_NTP) {
 		tk->ntp_error = 0;
 		ntp_clear();
@@ -1498,7 +1499,7 @@ int do_settimeofday64(const struct timespec64 *ts)
 
 	tk_set_xtime(tk, ts);
 out:
-	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
+	timekeeping_update(&tk_core, tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
@@ -1548,7 +1549,7 @@ static int timekeeping_inject_offset(const struct timespec64 *ts)
 	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *ts));
 
 error: /* even if we error out, we forwarded the time, so call update */
-	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
+	timekeeping_update(&tk_core, tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
@@ -1633,7 +1634,7 @@ static int change_clocksource(void *data)
 	timekeeping_forward_now(tk);
 	old = tk->tkr_mono.clock;
 	tk_setup_internals(tk, new);
-	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
+	timekeeping_update(&tk_core, tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
@@ -1832,7 +1833,7 @@ void __init timekeeping_init(void)
 
 	tk_set_wall_to_mono(tk, wall_to_mono);
 
-	timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
+	timekeeping_update(&tk_core, tk, TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
 }
@@ -1924,7 +1925,7 @@ void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 
 	__timekeeping_inject_sleeptime(tk, delta);
 
-	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
+	timekeeping_update(&tk_core, tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
@@ -1987,7 +1988,7 @@ void timekeeping_resume(void)
 
 	tk->ntp_error = 0;
 	timekeeping_suspended = 0;
-	timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
+	timekeeping_update(&tk_core, tk, TK_MIRROR | TK_CLOCK_WAS_SET);
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
@@ -2056,7 +2057,7 @@ int timekeeping_suspend(void)
 		}
 	}
 
-	timekeeping_update(tk, TK_MIRROR);
+	timekeeping_update(&tk_core, tk, TK_MIRROR);
 	halt_fast_timekeeper(tk);
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
@@ -2374,7 +2375,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	 * memcpy under the tk_core.seq against one before we start
 	 * updating.
 	 */
-	timekeeping_update(tk, clock_set);
+	timekeeping_update(&tk_core, tk, clock_set);
 	memcpy(real_tk, tk, sizeof(*tk));
 	/* The memcpy must come last. Do not put anything here! */
 	write_seqcount_end(&tk_core.seq);
@@ -2712,7 +2713,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 
 	if (tai != orig_tai) {
 		__timekeeping_set_tai_offset(tk, tai);
-		timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
+		timekeeping_update(&tk_core, tk, TK_MIRROR | TK_CLOCK_WAS_SET);
 		clock_set = true;
 	} else {
 		tk_update_leap_state(tk);

