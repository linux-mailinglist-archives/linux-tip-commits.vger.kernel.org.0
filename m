Return-Path: <linux-tip-commits+bounces-2983-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9099E5965
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 16:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1F616256C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF4E1B0F22;
	Thu,  5 Dec 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hwvBTlXa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PehXsZlA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112EE433D8;
	Thu,  5 Dec 2024 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411483; cv=none; b=l4Q580Dc4d9yRbsIDA+IxqYBAR9RvyXaKc/JdMCzgeRiySVkW0cRAqI36Af2Czsy2aknoyLZRfqPiRlOMSL2fFbyhBVcjc21FT52Q8k2WAlkPoErz1rtDM5mzbsKozHDH6XHDyn9W15ETwxjJ4xc2M+fa7fS9c3xdw1TFEupIcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411483; c=relaxed/simple;
	bh=QDBZmVIt+9VHIk2mElyvp3jXNo/pvpUj7/v6nn7mroE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NgnLJnd2PsgGXRu2Zhkf5iCTGpImLZ9HzKunTyWV6v0+GjktEfmNJeLRWJRDfYF3VjA9vSz33qcrdNlCTyOEUcX/OMfToSkG0lsoTPE7Pgnk8phJFbnBendrVpsaHV6bdBDihhSfjD3Vw0AVoNO2PJTwfMb+MAGeSifIUeGi4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hwvBTlXa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PehXsZlA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Dec 2024 15:11:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733411480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zz4zriZLB5fV9X5mXpQVspZ2dLAgnDHqaEW8qSqoDr8=;
	b=hwvBTlXa+4zhoxrfqiyMUS+KGzhnxjy+9tPlfPASyR3bCGNPCjSb9Sl0KYEC7MX5C3AwuO
	CNegzQpsAC0VOmfD1xfihq71hbSmCnkoIHdkyYAkc8GzyAdOyqk5LXiY4sGuXvrnHOpzM9
	y8PwTNVnbC3p5Ohvpmxl2BTVNMIymr6cYFWqqCNBc4sKlSa7ERMFyqdYcZpKyIfWyCp3+P
	IQBjz8GBmqjmMa6ih7OfzICEO3DMgwdxbZSktUcwIFUAm18mgGfq6AGtMFtOuGb0tSR5JK
	qNiSG9S7mMj9p2ePwmHPhcwqN/ynjqdyeiaAOBo5ouLx7/AOx0Mv5Vxe59z3FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733411480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zz4zriZLB5fV9X5mXpQVspZ2dLAgnDHqaEW8qSqoDr8=;
	b=PehXsZlAL1+w/QfkxPJBbXC++U6HhCNqpnrCUTwAN9UyCQ0yYMGg3KI/qkd7MNFgDqiDdH
	zpUeWZLOH1oAfJDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] clocksource: Make negative motion detection more robust
Cc: Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <8734j5ul4x.ffs@tglx>
References: <8734j5ul4x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173341147905.412.14955963756930219376.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     76031d9536a076bf023bedbdb1b4317fc801dd67
Gitweb:        https://git.kernel.org/tip/76031d9536a076bf023bedbdb1b4317fc801dd67
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Dec 2024 11:16:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 05 Dec 2024 16:03:24 +01:00

clocksource: Make negative motion detection more robust

Guenter reported boot stalls on a emulated ARM 32-bit platform, which has a
24-bit wide clocksource.

It turns out that the calculated maximal idle time, which limits idle
sleeps to prevent clocksource wrap arounds, is close to the point where the
negative motion detection triggers.

  max_idle_ns:                    597268854 ns
  negative motion tripping point: 671088640 ns

If the idle wakeup is delayed beyond that point, the clocksource
advances far enough to trigger the negative motion detection. This
prevents the clock to advance and in the worst case the system stalls
completely if the consecutive sleeps based on the stale clock are
delayed as well.

Cure this by calculating a more robust cut-off value for negative motion,
which covers 87.5% of the actual clocksource counter width. Compare the
delta against this value to catch negative motion. This is specifically for
clock sources with a small counter width as their wrap around time is close
to the half counter width. For clock sources with wide counters this is not
a problem because the maximum idle time is far from the half counter width
due to the math overflow protection constraints.

For the case at hand this results in a tripping point of 1174405120ns.

Note, that this cannot prevent issues when the delay exceeds the 87.5%
margin, but that's not different from the previous unchecked version which
allowed arbitrary time jumps.

Systems with small counter width are prone to invalid results, but this
problem is unlikely to be seen on real hardware. If such a system
completely stalls for more than half a second, then there are other more
urgent problems than the counter wrapping around.

Fixes: c163e40af9b2 ("timekeeping: Always check for negative motion")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/all/8734j5ul4x.ffs@tglx
Closes: https://lore.kernel.org/all/387b120b-d68a-45e8-b6ab-768cd95d11c2@roeck-us.net
---
 include/linux/clocksource.h        |  2 ++
 kernel/time/clocksource.c          | 11 ++++++++++-
 kernel/time/timekeeping.c          |  6 ++++--
 kernel/time/timekeeping_internal.h |  8 ++++----
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index ef1b16d..65b7c41 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -49,6 +49,7 @@ struct module;
  * @archdata:		Optional arch-specific data
  * @max_cycles:		Maximum safe cycle value which won't overflow on
  *			multiplication
+ * @max_raw_delta:	Maximum safe delta value for negative motion detection
  * @name:		Pointer to clocksource name
  * @list:		List head for registration (internal)
  * @freq_khz:		Clocksource frequency in khz.
@@ -109,6 +110,7 @@ struct clocksource {
 	struct arch_clocksource_data archdata;
 #endif
 	u64			max_cycles;
+	u64			max_raw_delta;
 	const char		*name;
 	struct list_head	list;
 	u32			freq_khz;
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index aab6472..7304d7c 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -24,7 +24,7 @@ static void clocksource_enqueue(struct clocksource *cs);
 
 static noinline u64 cycles_to_nsec_safe(struct clocksource *cs, u64 start, u64 end)
 {
-	u64 delta = clocksource_delta(end, start, cs->mask);
+	u64 delta = clocksource_delta(end, start, cs->mask, cs->max_raw_delta);
 
 	if (likely(delta < cs->max_cycles))
 		return clocksource_cyc2ns(delta, cs->mult, cs->shift);
@@ -993,6 +993,15 @@ static inline void clocksource_update_max_deferment(struct clocksource *cs)
 	cs->max_idle_ns = clocks_calc_max_nsecs(cs->mult, cs->shift,
 						cs->maxadj, cs->mask,
 						&cs->max_cycles);
+
+	/*
+	 * Threshold for detecting negative motion in clocksource_delta().
+	 *
+	 * Allow for 0.875 of the counter width so that overly long idle
+	 * sleeps, which go slightly over mask/2, do not trigger the
+	 * negative motion detection.
+	 */
+	cs->max_raw_delta = (cs->mask >> 1) + (cs->mask >> 2) + (cs->mask >> 3);
 }
 
 static struct clocksource *clocksource_find_best(bool oneshot, bool skipcur)
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 0ca85ff..3d12882 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -755,7 +755,8 @@ static void timekeeping_forward_now(struct timekeeper *tk)
 	u64 cycle_now, delta;
 
 	cycle_now = tk_clock_read(&tk->tkr_mono);
-	delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr_mono.mask);
+	delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
+				  tk->tkr_mono.clock->max_raw_delta);
 	tk->tkr_mono.cycle_last = cycle_now;
 	tk->tkr_raw.cycle_last  = cycle_now;
 
@@ -2230,7 +2231,8 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 		return false;
 
 	offset = clocksource_delta(tk_clock_read(&tk->tkr_mono),
-				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask);
+				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
+				   tk->tkr_mono.clock->max_raw_delta);
 
 	/* Check if there's really nothing to do */
 	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)
diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
index 63e600e..8c90791 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -30,15 +30,15 @@ static inline void timekeeping_inc_mg_floor_swaps(void)
 
 #endif
 
-static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
+static inline u64 clocksource_delta(u64 now, u64 last, u64 mask, u64 max_delta)
 {
 	u64 ret = (now - last) & mask;
 
 	/*
-	 * Prevent time going backwards by checking the MSB of mask in
-	 * the result. If set, return 0.
+	 * Prevent time going backwards by checking the result against
+	 * @max_delta. If greater, return 0.
 	 */
-	return ret & ~(mask >> 1) ? 0 : ret;
+	return ret > max_delta ? 0 : ret;
 }
 
 /* Semi public for serialization of non timekeeper VDSO updates. */

