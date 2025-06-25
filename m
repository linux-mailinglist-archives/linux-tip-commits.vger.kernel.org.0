Return-Path: <linux-tip-commits+bounces-5911-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B503DAE897E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 18:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F36D7B38E0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD5A2DAFC5;
	Wed, 25 Jun 2025 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a276tNPs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J+0Z0z0h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332442DA75D;
	Wed, 25 Jun 2025 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868172; cv=none; b=Sfmz3jzdmN4d/dYnpQeVvWsq4VOVkBAhzF45Q3XOTXgzvOpGRcs79d6rlLsHuFpL8TaLph3/zxAIk2uS7cwCd2gqHOWIQm45ohzIO024+Oh9RiPXUWF7TIWbRQB9HRu5V2ClKfCWXcmHAxdibJeY8nkQCY2qI8oKofJ+4nwmGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868172; c=relaxed/simple;
	bh=lMs3O1pbbjTVtqBf8omuaCHyA7BNoqj87c4/2DFsjLw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KEfipmpliW7+7Fas3kFYr7OjqeNfeNRsyHuErSAIfQl7OPm8W7MAHV43E2FpZafhi8GfcI0gG3o4qLa1x5tfFkOdwhmCDy2Ir//yiQpPY7Pci4rGywVyo0v1H2LTyWxqkOdGOEavCVYrugG/UtosuvCn7H1azzgU3wKbAi89QlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a276tNPs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J+0Z0z0h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 16:16:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750868168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/NJzRhX1Q5dDQ4R7j/2zw4ltGe0vJsVfzDyOrMNa4E=;
	b=a276tNPsT3fWCSc+1DJpfgiMyk58KxtLh8i2yqr8wl1qXotsMEoo8VaRONVaxvLx89lc9e
	xKkpqbgWKgVuCykIMf62oLmUAhe23QDgfQjHHCu3uoiL4eTnMPSCqI+Vt2O4yM8cmLeHTv
	Xi4s0zTUK/LXs97qjZOPuESdWjD1rue06AT20KA8nRtoBBzLkNwQG7wyFzXjFDS7ffQnZa
	5e09gI/qfKmmjQzgctd8AEwne7HQOjfebYyoYTNnT/OTzUkvk5L45uZc8QKG9rZR3how4E
	7755i8O9dJ7udslAp1sKXcr3sU2+hSWxL5eY3omTpx/arfoKIActe+2+HLHPjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750868168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/NJzRhX1Q5dDQ4R7j/2zw4ltGe0vJsVfzDyOrMNa4E=;
	b=J+0Z0z0h9FDKn+LidpUSg4oTLMUlOYVP6t4cWODB4PhkV+Jbsjfl3M3EkVaCbsIfb8YGEi
	7E3ajj7jvRbAj3DA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/ptp] timekeeping: Avoid double notification in do_adjtimex()
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250519083025.779267274@linutronix.de>
References: <20250519083025.779267274@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175086816754.406.13446562901316096725.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     7e55b6ba1fe6987638160e5f8216288f38043759
Gitweb:        https://git.kernel.org/tip/7e55b6ba1fe6987638160e5f8216288f38043759
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 19 May 2025 10:33:17 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Jun 2025 14:28:22 +02:00

timekeeping: Avoid double notification in do_adjtimex()

Consolidate do_adjtimex() so that it does not notify about clock changes
twice.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250519083025.779267274@linutronix.de


---
 kernel/time/timekeeping.c | 98 +++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 42 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d88d19f..fb1da87 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1418,40 +1418,49 @@ int do_settimeofday64(const struct timespec64 *ts)
 EXPORT_SYMBOL(do_settimeofday64);
 
 /**
- * timekeeping_inject_offset - Adds or subtracts from the current time.
+ * __timekeeping_inject_offset - Adds or subtracts from the current time.
  * @ts:		Pointer to the timespec variable containing the offset
  *
  * Adds or subtracts an offset value from the current time.
  */
-static int timekeeping_inject_offset(const struct timespec64 *ts)
+static int __timekeeping_inject_offset(const struct timespec64 *ts)
 {
+	struct timekeeper *tks = &tk_core.shadow_timekeeper;
+	struct timespec64 tmp;
+
 	if (ts->tv_nsec < 0 || ts->tv_nsec >= NSEC_PER_SEC)
 		return -EINVAL;
 
-	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
-		struct timekeeper *tks = &tk_core.shadow_timekeeper;
-		struct timespec64 tmp;
 
-		timekeeping_forward_now(tks);
-
-		/* Make sure the proposed value is valid */
-		tmp = timespec64_add(tk_xtime(tks), *ts);
-		if (timespec64_compare(&tks->wall_to_monotonic, ts) > 0 ||
-		    !timespec64_valid_settod(&tmp)) {
-			timekeeping_restore_shadow(&tk_core);
-			return -EINVAL;
-		}
+	timekeeping_forward_now(tks);
 
-		tk_xtime_add(tks, ts);
-		tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
-		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+	/* Make sure the proposed value is valid */
+	tmp = timespec64_add(tk_xtime(tks), *ts);
+	if (timespec64_compare(&tks->wall_to_monotonic, ts) > 0 ||
+	    !timespec64_valid_settod(&tmp)) {
+		timekeeping_restore_shadow(&tk_core);
+		return -EINVAL;
 	}
 
-	/* Signal hrtimers about time change */
-	clock_was_set(CLOCK_SET_WALL);
+	tk_xtime_add(tks, ts);
+	tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
+	timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
 	return 0;
 }
 
+static int timekeeping_inject_offset(const struct timespec64 *ts)
+{
+	int ret;
+
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock)
+		ret = __timekeeping_inject_offset(ts);
+
+	/* Signal hrtimers about time change */
+	if (!ret)
+		clock_was_set(CLOCK_SET_WALL);
+	return ret;
+}
+
 /*
  * Indicates if there is an offset between the system clock and the hardware
  * clock/persistent clock/rtc.
@@ -2186,7 +2195,7 @@ static u64 logarithmic_accumulation(struct timekeeper *tk, u64 offset,
  * timekeeping_advance - Updates the timekeeper to the current time and
  * current NTP tick length
  */
-static bool timekeeping_advance(enum timekeeping_adv_mode mode)
+static bool __timekeeping_advance(enum timekeeping_adv_mode mode)
 {
 	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 	struct timekeeper *real_tk = &tk_core.timekeeper;
@@ -2194,8 +2203,6 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	int shift = 0, maxshift;
 	u64 offset, orig_offset;
 
-	guard(raw_spinlock_irqsave)(&tk_core.lock);
-
 	/* Make sure we're fully resumed: */
 	if (unlikely(timekeeping_suspended))
 		return false;
@@ -2249,6 +2256,12 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	return !!clock_set;
 }
 
+static bool timekeeping_advance(enum timekeeping_adv_mode mode)
+{
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
+	return __timekeeping_advance(mode);
+}
+
 /**
  * update_wall_time - Uses the current clocksource to increment the wall time
  *
@@ -2537,10 +2550,10 @@ EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
  */
 int do_adjtimex(struct __kernel_timex *txc)
 {
+	struct timespec64 delta, ts;
 	struct audit_ntp_data ad;
 	bool offset_set = false;
 	bool clock_set = false;
-	struct timespec64 ts;
 	int ret;
 
 	/* Validate the data before disabling interrupts */
@@ -2549,21 +2562,6 @@ int do_adjtimex(struct __kernel_timex *txc)
 		return ret;
 	add_device_randomness(txc, sizeof(*txc));
 
-	if (txc->modes & ADJ_SETOFFSET) {
-		struct timespec64 delta;
-
-		delta.tv_sec  = txc->time.tv_sec;
-		delta.tv_nsec = txc->time.tv_usec;
-		if (!(txc->modes & ADJ_NANO))
-			delta.tv_nsec *= 1000;
-		ret = timekeeping_inject_offset(&delta);
-		if (ret)
-			return ret;
-
-		offset_set = delta.tv_sec != 0;
-		audit_tk_injoffset(delta);
-	}
-
 	audit_ntp_init(&ad);
 
 	ktime_get_real_ts64(&ts);
@@ -2573,6 +2571,19 @@ int do_adjtimex(struct __kernel_timex *txc)
 		struct timekeeper *tks = &tk_core.shadow_timekeeper;
 		s32 orig_tai, tai;
 
+		if (txc->modes & ADJ_SETOFFSET) {
+			delta.tv_sec  = txc->time.tv_sec;
+			delta.tv_nsec = txc->time.tv_usec;
+			if (!(txc->modes & ADJ_NANO))
+				delta.tv_nsec *= 1000;
+			ret = __timekeeping_inject_offset(&delta);
+			if (ret)
+				return ret;
+
+			offset_set = delta.tv_sec != 0;
+			clock_set = true;
+		}
+
 		orig_tai = tai = tks->tai_offset;
 		ret = __do_adjtimex(txc, &ts, &tai, &ad);
 
@@ -2583,13 +2594,16 @@ int do_adjtimex(struct __kernel_timex *txc)
 		} else {
 			tk_update_leap_state_all(&tk_core);
 		}
+
+		/* Update the multiplier immediately if frequency was set directly */
+		if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
+			clock_set |= __timekeeping_advance(TK_ADV_FREQ);
 	}
 
-	audit_ntp_log(&ad);
+	if (txc->modes & ADJ_SETOFFSET)
+		audit_tk_injoffset(delta);
 
-	/* Update the multiplier immediately if frequency was set directly */
-	if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
-		clock_set |= timekeeping_advance(TK_ADV_FREQ);
+	audit_ntp_log(&ad);
 
 	if (clock_set)
 		clock_was_set(CLOCK_SET_WALL);

