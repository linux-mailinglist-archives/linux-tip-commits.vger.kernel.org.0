Return-Path: <linux-tip-commits+bounces-4418-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFEEA6C27B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Mar 2025 19:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621C73B1C0A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Mar 2025 18:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1475F22FE1F;
	Fri, 21 Mar 2025 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZqN1OYzp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AfFiazIv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1553022F3B8;
	Fri, 21 Mar 2025 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742582113; cv=none; b=eKzEZANmd86pOswphtEEPECktL1Q4NcqNAiqecBMKxpOi8sTUKRgx3OiMyMHA9Hvl6iiHLIsKBmwkni0lEtr/qM426rbx5MYD1yjACiFpoCL5Y/AMwRfs/ETSIAQUmXCsbZMEFNsu+oiTu53EhUb1zZa6Z6kP4lg/XNtPCWy+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742582113; c=relaxed/simple;
	bh=HC0OumCZtiGfAulSJu25VhJt1z5d95KtsOn94dfPZzs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cnIkAyfjkWqWz8oFl0bgCdhuoqsr59j+Uk6VggNzNWBtkXkJygh8C89iuaQ39wCAyRV6nicWT7t8S/ORA+0LFfWmYKNtnoQv4Ul2FezswhF6vcvWgCa/XWwjrE23JhD6sVlPu8uSYyqiVbhe1wulP7q2D0VtK405vHPMzcWxPAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZqN1OYzp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AfFiazIv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Mar 2025 18:35:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742582107;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7ZGbMJi8bSnqJgnDDHOnL5kw3F6tgW4eUzHWdvLsz8=;
	b=ZqN1OYzpUgQVHSUqpCg+XSeDnk4oQG28tqIZnbrzjZJZwaqRqQ6EQZh+H+QYMNhHQBM2QM
	0cGsa0enbd8cAV/vSceCc/UI4NbEBnezWOgnUZSc9l/pU/oWgbiHCIkki0XSH/0sRHvxs9
	KpuGZxyhDOOgQdcR/mlre3zz8NfOV9hq+7yN01J5n0vvpGTlIwbAWBYpp7lLPajWs3nwBe
	+EtPmIg1vJ+Lax1vWhvI+t1kgOrCtJ4M2qguNKLC0+XruV/cbYh/Cm92gFdMQRrNZgzRUv
	QwVdgX9Ocx8Ro8ZkO9VUW4pwZVTyDF73KMAtfpCPMHJst6PTXeEM0Af4djVArQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742582107;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7ZGbMJi8bSnqJgnDDHOnL5kw3F6tgW4eUzHWdvLsz8=;
	b=AfFiazIvn9J+2X9QXujLMSNb7QmF8f27I5UgEY4Wyw8uZUnxz8FRp8FzBFGX9JEnUbDg2B
	CTKwP02Nc6UMD6CQ==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Fix possible inconsistencies in
 _COARSE clockids
Cc: Lei Chen <lei.chen@smartx.com>, John Stultz <jstultz@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250320200306.1712599-1-jstultz@google.com>
References: <20250320200306.1712599-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174258210717.14745.3564869302280255157.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     757b000f7b936edf79311ab0971fe465bbda75ea
Gitweb:        https://git.kernel.org/tip/757b000f7b936edf79311ab0971fe465bbda75ea
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Thu, 20 Mar 2025 13:03:00 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Mar 2025 19:16:18 +01:00

timekeeping: Fix possible inconsistencies in _COARSE clockids

Lei Chen raised an issue with CLOCK_MONOTONIC_COARSE seeing time
inconsistencies.

Lei tracked down that this was being caused by the adjustment

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

However, do_adjtimex() calls into timekeeping_advance() as well, to to
apply the NTP frequency adjustment immediately. In this case,
timekeeping_advance() does not return early when the offset is smaller then
interval_cycles. In that case there is no time accumulated into
xtime_nsec. But the subsequent call into timekeeping_adjust(), which
modifies the multiplicator, subtracts from xtime_nsec to correct
for the new multiplicator.

Here because there was no accumulation, xtime_nsec becomes smaller than
before, which opens a window up to the next accumulation, where the _COARSE
clockid getters, which don't compensate for the offset, can observe the
inconsistency.

To fix this, rework the timekeeping_advance() logic so that when invoked
from do_adjtimex(), the time is immediately forwarded to accumulate also
the sub-interval portion into xtime. That means the remaining offset
becomes zero and the subsequent multiplier adjustment therefore does not
modify xtime_nsec.

There is another related inconsistency. If xtime is forwarded due to the
instantaneous multiplier adjustment, the NTP error, which was accumulated
with the previous setting, becomes meaningless.

Therefore clear the NTP error as well, after forwarding the clock for the
instantaneous multiplier update.

Fixes: da15cfdae033 ("time: Introduce CLOCK_REALTIME_COARSE")
Reported-by: Lei Chen <lei.chen@smartx.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250320200306.1712599-1-jstultz@google.com
Closes: https://lore.kernel.org/lkml/20250310030004.3705801-1-lei.chen@smartx.com/
---
 kernel/time/timekeeping.c | 94 +++++++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 25 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 1e67d07..929846b 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -682,20 +682,19 @@ static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int act
 }
 
 /**
- * timekeeping_forward_now - update clock to the current time
+ * timekeeping_forward - update clock to given cycle now value
  * @tk:		Pointer to the timekeeper to update
+ * @cycle_now:  Current clocksource read value
  *
  * Forward the current clock to update its state since the last call to
  * update_wall_time(). This is useful before significant clock changes,
  * as it avoids having to deal with this time offset explicitly.
  */
-static void timekeeping_forward_now(struct timekeeper *tk)
+static void timekeeping_forward(struct timekeeper *tk, u64 cycle_now)
 {
-	u64 cycle_now, delta;
+	u64 delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
+				      tk->tkr_mono.clock->max_raw_delta);
 
-	cycle_now = tk_clock_read(&tk->tkr_mono);
-	delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
-				  tk->tkr_mono.clock->max_raw_delta);
 	tk->tkr_mono.cycle_last = cycle_now;
 	tk->tkr_raw.cycle_last  = cycle_now;
 
@@ -711,6 +710,21 @@ static void timekeeping_forward_now(struct timekeeper *tk)
 }
 
 /**
+ * timekeeping_forward_now - update clock to the current time
+ * @tk:		Pointer to the timekeeper to update
+ *
+ * Forward the current clock to update its state since the last call to
+ * update_wall_time(). This is useful before significant clock changes,
+ * as it avoids having to deal with this time offset explicitly.
+ */
+static void timekeeping_forward_now(struct timekeeper *tk)
+{
+	u64 cycle_now = tk_clock_read(&tk->tkr_mono);
+
+	timekeeping_forward(tk, cycle_now);
+}
+
+/**
  * ktime_get_real_ts64 - Returns the time of day in a timespec64.
  * @ts:		pointer to the timespec to be set
  *
@@ -2151,6 +2165,54 @@ static u64 logarithmic_accumulation(struct timekeeper *tk, u64 offset,
 	return offset;
 }
 
+static u64 timekeeping_accumulate(struct timekeeper *tk, u64 offset,
+				  enum timekeeping_adv_mode mode,
+				  unsigned int *clock_set)
+{
+	int shift = 0, maxshift;
+
+	/*
+	 * TK_ADV_FREQ indicates that adjtimex(2) directly set the
+	 * frequency or the tick length.
+	 *
+	 * Accumulate the offset, so that the new multiplier starts from
+	 * now. This is required as otherwise for offsets, which are
+	 * smaller than tk::cycle_interval, timekeeping_adjust() could set
+	 * xtime_nsec backwards, which subsequently causes time going
+	 * backwards in the coarse time getters. But even for the case
+	 * where offset is greater than tk::cycle_interval the periodic
+	 * accumulation does not have much value.
+	 *
+	 * Also reset tk::ntp_error as it does not make sense to keep the
+	 * old accumulated error around in this case.
+	 */
+	if (mode == TK_ADV_FREQ) {
+		timekeeping_forward(tk, tk->tkr_mono.cycle_last + offset);
+		tk->ntp_error = 0;
+		return 0;
+	}
+
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
+	maxshift = (64 - (ilog2(ntp_tick_length()) + 1)) - 1;
+	shift = min(shift, maxshift);
+	while (offset >= tk->cycle_interval) {
+		offset = logarithmic_accumulation(tk, offset, shift, clock_set);
+		if (offset < tk->cycle_interval << shift)
+			shift--;
+	}
+	return offset;
+}
+
 /*
  * timekeeping_advance - Updates the timekeeper to the current time and
  * current NTP tick length
@@ -2160,7 +2222,6 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 	struct timekeeper *real_tk = &tk_core.timekeeper;
 	unsigned int clock_set = 0;
-	int shift = 0, maxshift;
 	u64 offset;
 
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
@@ -2177,24 +2238,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)
 		return false;
 
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
-	maxshift = (64 - (ilog2(ntp_tick_length())+1)) - 1;
-	shift = min(shift, maxshift);
-	while (offset >= tk->cycle_interval) {
-		offset = logarithmic_accumulation(tk, offset, shift, &clock_set);
-		if (offset < tk->cycle_interval<<shift)
-			shift--;
-	}
+	offset = timekeeping_accumulate(tk, offset, mode, &clock_set);
 
 	/* Adjust the multiplier to correct NTP error */
 	timekeeping_adjust(tk, offset);

