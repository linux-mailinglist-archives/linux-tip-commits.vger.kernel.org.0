Return-Path: <linux-tip-commits+bounces-5951-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEDCAEE1E5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 17:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D551716CDC5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 15:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A7528F94E;
	Mon, 30 Jun 2025 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fOFhH6aw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xWpiVIul"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A87128EA4B;
	Mon, 30 Jun 2025 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295926; cv=none; b=EGMNr5ueyFEAZOzbY37gJTWxywSrmTNUD6lVLDsDNG1DbnrTbRG8JpIA52ne3wb9KCFXgoRiMNpnZ+e2roUkPNtV36LBjeDoz8VzUZkcXcP3xV4hRUUFf+jIEEyZ3mJjghMlmnFe+Og9PVC3GFS+hLemYtb19uIdMaaLhmHGiDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295926; c=relaxed/simple;
	bh=7GF6YotyzjFywwiOL+VXOJIg7a67zUK6U4SxykIOjm8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o3T/P4ksmNuTHs6z5AT7bEheBbpgPca1VxoObrRtNZmk+iYw7/gAwbTHfC8T47SphuaBzru5AiE5M+JZXHnb62W1drjDPtX+v0uD3aj7S38K7smNMmq00fBFuJTTR33u0jBMuFbkE+5t4q2k98OwIpRb+kQ2pBVpJftJSzwG5Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fOFhH6aw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xWpiVIul; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Jun 2025 15:05:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751295923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivOpvqudDIXNMuCcX6+5GMYajXeQgmR4yXTSFzoOouI=;
	b=fOFhH6awlkdLtH20H7N0Jj6ieGhkdMOeZySNCifHbPzhQUd6dguMYxyzHoz8KNCq+AQMd3
	cV2B2aftw2RSNQDzGMdOQV0X2EbMLPzgh9drmSAOx9BlIusskt2N7OigvdR2N+XY40J4Y2
	c5z8HygJSiMus8uZ0V7pswqxkIzRcTd/7LG2J6hgBAyalHn1o0N0nY/4wxdQY7wGgTmA01
	sEbpkX//rMoNwSCgW6rBUHG9t6ndCEQ0DNQo2VsJkcavcvfJhYkWYj+fuhGBurGdPvqiR5
	kYMFHA2ca27VgRrNhaQOkIaxJdHstCWrMypc6z+ddbjkhDbC27z7C1QZfNfhfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751295923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivOpvqudDIXNMuCcX6+5GMYajXeQgmR4yXTSFzoOouI=;
	b=xWpiVIulSQCtVjTb7BAksBWR4S53hv+dBDeDI94Wy1nmWQj42mMvdKFMXblwl6ciADncpJ
	6vY+NLUMsgYjQCCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/ptp] timekeeping: Make timekeeping_inject_offset() reusable
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250625183758.059934561@linutronix.de>
References: <20250625183758.059934561@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175129592261.406.13807265836498784856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     e8db3a55798d70f2c222c6103990776fca6a6ebc
Gitweb:        https://git.kernel.org/tip/e8db3a55798d70f2c222c6103990776fca6a6ebc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Jun 2025 20:38:40 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 Jun 2025 20:13:13 +02:00

timekeeping: Make timekeeping_inject_offset() reusable

Split out the inner workings for auxiliary clock support and feed the core time
keeper into it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250625183758.059934561@linutronix.de

---
 kernel/time/timekeeping.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b6ac784..2d294cf 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1433,32 +1433,32 @@ EXPORT_SYMBOL(do_settimeofday64);
 
 /**
  * __timekeeping_inject_offset - Adds or subtracts from the current time.
+ * @tkd:	Pointer to the timekeeper to modify
  * @ts:		Pointer to the timespec variable containing the offset
  *
  * Adds or subtracts an offset value from the current time.
  */
-static int __timekeeping_inject_offset(const struct timespec64 *ts)
+static int __timekeeping_inject_offset(struct tk_data *tkd, const struct timespec64 *ts)
 {
-	struct timekeeper *tks = &tk_core.shadow_timekeeper;
+	struct timekeeper *tks = &tkd->shadow_timekeeper;
 	struct timespec64 tmp;
 
 	if (ts->tv_nsec < 0 || ts->tv_nsec >= NSEC_PER_SEC)
 		return -EINVAL;
 
-
 	timekeeping_forward_now(tks);
 
 	/* Make sure the proposed value is valid */
 	tmp = timespec64_add(tk_xtime(tks), *ts);
 	if (timespec64_compare(&tks->wall_to_monotonic, ts) > 0 ||
 	    !timespec64_valid_settod(&tmp)) {
-		timekeeping_restore_shadow(&tk_core);
+		timekeeping_restore_shadow(tkd);
 		return -EINVAL;
 	}
 
 	tk_xtime_add(tks, ts);
 	tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
-	timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
 	return 0;
 }
 
@@ -1467,7 +1467,7 @@ static int timekeeping_inject_offset(const struct timespec64 *ts)
 	int ret;
 
 	scoped_guard (raw_spinlock_irqsave, &tk_core.lock)
-		ret = __timekeeping_inject_offset(ts);
+		ret = __timekeeping_inject_offset(&tk_core, ts);
 
 	/* Signal hrtimers about time change */
 	if (!ret)
@@ -2568,6 +2568,7 @@ EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
  */
 int do_adjtimex(struct __kernel_timex *txc)
 {
+	struct tk_data *tkd = &tk_core;
 	struct timespec64 delta, ts;
 	struct audit_ntp_data ad;
 	bool offset_set = false;
@@ -2585,16 +2586,19 @@ int do_adjtimex(struct __kernel_timex *txc)
 	ktime_get_real_ts64(&ts);
 	add_device_randomness(&ts, sizeof(ts));
 
-	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
-		struct timekeeper *tks = &tk_core.shadow_timekeeper;
+	scoped_guard (raw_spinlock_irqsave, &tkd->lock) {
+		struct timekeeper *tks = &tkd->shadow_timekeeper;
 		s32 orig_tai, tai;
 
+		if (!tks->clock_valid)
+			return -ENODEV;
+
 		if (txc->modes & ADJ_SETOFFSET) {
 			delta.tv_sec  = txc->time.tv_sec;
 			delta.tv_nsec = txc->time.tv_usec;
 			if (!(txc->modes & ADJ_NANO))
 				delta.tv_nsec *= 1000;
-			ret = __timekeeping_inject_offset(&delta);
+			ret = __timekeeping_inject_offset(tkd, &delta);
 			if (ret)
 				return ret;
 
@@ -2607,7 +2611,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 
 		if (tai != orig_tai) {
 			__timekeeping_set_tai_offset(tks, tai);
-			timekeeping_update_from_shadow(&tk_core, TK_CLOCK_WAS_SET);
+			timekeeping_update_from_shadow(tkd, TK_CLOCK_WAS_SET);
 			clock_set = true;
 		} else {
 			tk_update_leap_state_all(&tk_core);
@@ -2615,7 +2619,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 
 		/* Update the multiplier immediately if frequency was set directly */
 		if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
-			clock_set |= __timekeeping_advance(&tk_core, TK_ADV_FREQ);
+			clock_set |= __timekeeping_advance(tkd, TK_ADV_FREQ);
 	}
 
 	if (txc->modes & ADJ_SETOFFSET)

