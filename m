Return-Path: <linux-tip-commits+bounces-2333-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807DA98DF9C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C114282027
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7091D1E8A;
	Wed,  2 Oct 2024 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xTPU1hXP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tMEi9A1D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A271D0F48;
	Wed,  2 Oct 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883898; cv=none; b=ZIubAl46MRk5CH0QhXSw7f58l8+3uymdVULpZnNivkmORLLls5sZyfGpqVZwOTiiUgxmopqLvbIEwE+uoV2Y5NDlhAYBH46Dw2o8Kzk5JLmxQ44wi6FSIWBzr7tLGIdic6AdodZvFoNjXWvxANVVgcCfZH6jlRcfKrK1TJbtLl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883898; c=relaxed/simple;
	bh=ma5/QC9k83rQ1cvTV+hzk3ox0hz/HInJn8fqhJjyFjo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BDHWoLIQ5HN+XZtCjDS9KhChztsB08UH+fRkXSG4fAMJh0YxZF6FiJqCmfuQx6/kvHG4QoaqCABUIcrOPXcgK5DSDEuBGpbtZeCS17hop0TZEeP8c64WevEaHoiiJhhylCH1ugkb7li0PXcoCVtuwq7Spy6URCUrxW/mVnpYgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xTPU1hXP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tMEi9A1D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:44:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883893;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JHEWzNYdZjrMUGEErHz9B4qAQ/RHWr89KF/QbjJ3G8k=;
	b=xTPU1hXPl+F56Cw2jTAoVYcSMugi+oRmSQ01GqrqKbbmImXsukv1MO4qz42cMqIY4RlK9f
	peA2+J6cH8pP+9XIlRgNcQvJa8bOI7vzeC8tHA3GBL+MRWWlmtPEYwkIjoP+BQA+kesgbe
	Cv8w9mxP+D2Y5DJsc0pwyO4UxWpq2cpAfFDIytX3iQmCkhOsX36/wY1m2mTJrYRSjNN+l+
	R4G5S5YR8FcpAwfl6WwFtCCfn4jqlYV0NqAjqXdlhBXvsQHNZvBWkaEqdrm/isaBcyOxh5
	/FiewVv2q5Xeqf3uAMuEI7LpVh3tj0cnhM3FI+bQ8An/XEoYAusO6ovUoDtk/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883893;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JHEWzNYdZjrMUGEErHz9B4qAQ/RHWr89KF/QbjJ3G8k=;
	b=tMEi9A1DFmgRMoPSQhcRsmvGtenr63jYn9XK7AKE1YpvTpL4hKg9Y/2mBxeEENgbrVAHvb
	hpWz1/lGpIE7bSDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Move tick_stat* into ntp_data
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-9-2d52f4e13476@linutronix.de>
References:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-9-2d52f4e13476@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788389293.1442.15857338050147068514.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bee18a2301f97465a464176767f3a3a64f900d93
Gitweb:        https://git.kernel.org/tip/bee18a2301f97465a464176767f3a3a64f900d93
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:45 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:39 +02:00

ntp: Move tick_stat* into ntp_data

Continue the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-9-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 175 +++++++++++++++++++++------------------------
 1 file changed, 85 insertions(+), 90 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 2430e69..42c039a 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -27,6 +27,8 @@
  * @tick_usec:		USER_HZ period in microseconds
  * @tick_length:	Adjusted tick length
  * @tick_length_base:	Base value for @tick_length
+ * @time_state:		State of the clock synchronization
+ * @time_status:	Clock status bits
  *
  * Protected by the timekeeping locks.
  */
@@ -34,10 +36,14 @@ struct ntp_data {
 	unsigned long		tick_usec;
 	u64			tick_length;
 	u64			tick_length_base;
+	int			time_state;
+	int			time_status;
 };
 
 static struct ntp_data tk_ntp_data = {
 	.tick_usec		= USER_TICK_USEC,
+	.time_state		= TIME_OK,
+	.time_status		= STA_UNSYNC,
 };
 
 #define SECS_PER_DAY		86400
@@ -53,16 +59,6 @@ static struct ntp_data tk_ntp_data = {
  * estimated error = NTP dispersion.
  */
 
-/*
- * clock synchronization status
- *
- * (TIME_ERROR prevents overwriting the CMOS clock)
- */
-static int			time_state = TIME_OK;
-
-/* clock status bits:							*/
-static int			time_status = STA_UNSYNC;
-
 /* time adjustment (nsecs):						*/
 static s64			time_offset;
 
@@ -127,9 +123,9 @@ static long pps_errcnt;		/* calibration errors */
  * PPS kernel consumer compensates the whole phase error immediately.
  * Otherwise, reduce the offset by a fixed factor times the time constant.
  */
-static inline s64 ntp_offset_chunk(s64 offset)
+static inline s64 ntp_offset_chunk(struct ntp_data *ntpdata, s64 offset)
 {
-	if (time_status & STA_PPSTIME && time_status & STA_PPSSIGNAL)
+	if (ntpdata->time_status & STA_PPSTIME && ntpdata->time_status & STA_PPSSIGNAL)
 		return offset;
 	else
 		return shift_right(offset, SHIFT_PLL + time_constant);
@@ -159,13 +155,13 @@ static inline void pps_clear(void)
  * Decrease pps_valid to indicate that another second has passed since the
  * last PPS signal. When it reaches 0, indicate that PPS signal is missing.
  */
-static inline void pps_dec_valid(void)
+static inline void pps_dec_valid(struct ntp_data *ntpdata)
 {
 	if (pps_valid > 0)
 		pps_valid--;
 	else {
-		time_status &= ~(STA_PPSSIGNAL | STA_PPSJITTER |
-				 STA_PPSWANDER | STA_PPSERROR);
+		ntpdata->time_status &= ~(STA_PPSSIGNAL | STA_PPSJITTER |
+					  STA_PPSWANDER | STA_PPSERROR);
 		pps_clear();
 	}
 }
@@ -198,12 +194,12 @@ static inline bool is_error_status(int status)
 			&& (status & (STA_PPSWANDER|STA_PPSERROR)));
 }
 
-static inline void pps_fill_timex(struct __kernel_timex *txc)
+static inline void pps_fill_timex(struct ntp_data *ntpdata, struct __kernel_timex *txc)
 {
 	txc->ppsfreq	   = shift_right((pps_freq >> PPM_SCALE_INV_SHIFT) *
 					 PPM_SCALE_INV, NTP_SCALE_SHIFT);
 	txc->jitter	   = pps_jitter;
-	if (!(time_status & STA_NANO))
+	if (!(ntpdata->time_status & STA_NANO))
 		txc->jitter = pps_jitter / NSEC_PER_USEC;
 	txc->shift	   = pps_shift;
 	txc->stabil	   = pps_stabil;
@@ -215,14 +211,14 @@ static inline void pps_fill_timex(struct __kernel_timex *txc)
 
 #else /* !CONFIG_NTP_PPS */
 
-static inline s64 ntp_offset_chunk(s64 offset)
+static inline s64 ntp_offset_chunk(struct ntp_data *ntp, s64 offset)
 {
 	return shift_right(offset, SHIFT_PLL + time_constant);
 }
 
 static inline void pps_reset_freq_interval(void) {}
 static inline void pps_clear(void) {}
-static inline void pps_dec_valid(void) {}
+static inline void pps_dec_valid(struct ntp_data *ntpdata) {}
 static inline void pps_set_freq(s64 freq) {}
 
 static inline bool is_error_status(int status)
@@ -230,7 +226,7 @@ static inline bool is_error_status(int status)
 	return status & (STA_UNSYNC|STA_CLOCKERR);
 }
 
-static inline void pps_fill_timex(struct __kernel_timex *txc)
+static inline void pps_fill_timex(struct ntp_data *ntpdata, struct __kernel_timex *txc)
 {
 	/* PPS is not implemented, so these are zero */
 	txc->ppsfreq	   = 0;
@@ -268,30 +264,30 @@ static void ntp_update_frequency(struct ntp_data *ntpdata)
 	ntpdata->tick_length_base	 = new_base;
 }
 
-static inline s64 ntp_update_offset_fll(s64 offset64, long secs)
+static inline s64 ntp_update_offset_fll(struct ntp_data *ntpdata, s64 offset64, long secs)
 {
-	time_status &= ~STA_MODE;
+	ntpdata->time_status &= ~STA_MODE;
 
 	if (secs < MINSEC)
 		return 0;
 
-	if (!(time_status & STA_FLL) && (secs <= MAXSEC))
+	if (!(ntpdata->time_status & STA_FLL) && (secs <= MAXSEC))
 		return 0;
 
-	time_status |= STA_MODE;
+	ntpdata->time_status |= STA_MODE;
 
 	return div64_long(offset64 << (NTP_SCALE_SHIFT - SHIFT_FLL), secs);
 }
 
-static void ntp_update_offset(long offset)
+static void ntp_update_offset(struct ntp_data *ntpdata, long offset)
 {
 	s64 freq_adj, offset64;
 	long secs, real_secs;
 
-	if (!(time_status & STA_PLL))
+	if (!(ntpdata->time_status & STA_PLL))
 		return;
 
-	if (!(time_status & STA_NANO)) {
+	if (!(ntpdata->time_status & STA_NANO)) {
 		/* Make sure the multiplication below won't overflow */
 		offset = clamp(offset, -USEC_PER_SEC, USEC_PER_SEC);
 		offset *= NSEC_PER_USEC;
@@ -306,13 +302,13 @@ static void ntp_update_offset(long offset)
 	 */
 	real_secs = __ktime_get_real_seconds();
 	secs = (long)(real_secs - time_reftime);
-	if (unlikely(time_status & STA_FREQHOLD))
+	if (unlikely(ntpdata->time_status & STA_FREQHOLD))
 		secs = 0;
 
 	time_reftime = real_secs;
 
 	offset64    = offset;
-	freq_adj    = ntp_update_offset_fll(offset64, secs);
+	freq_adj    = ntp_update_offset_fll(ntpdata, offset64, secs);
 
 	/*
 	 * Clamp update interval to reduce PLL gain with low
@@ -335,10 +331,10 @@ static void ntp_update_offset(long offset)
 static void __ntp_clear(struct ntp_data *ntpdata)
 {
 	/* Stop active adjtime() */
-	time_adjust	= 0;
-	time_status	|= STA_UNSYNC;
-	time_maxerror	= NTP_PHASE_LIMIT;
-	time_esterror	= NTP_PHASE_LIMIT;
+	time_adjust		= 0;
+	ntpdata->time_status	|= STA_UNSYNC;
+	time_maxerror		= NTP_PHASE_LIMIT;
+	time_esterror		= NTP_PHASE_LIMIT;
 
 	ntp_update_frequency(ntpdata);
 
@@ -372,9 +368,10 @@ u64 ntp_tick_length(void)
  */
 ktime_t ntp_get_next_leap(void)
 {
+	struct ntp_data *ntpdata = &tk_ntp_data;
 	ktime_t ret;
 
-	if ((time_state == TIME_INS) && (time_status & STA_INS))
+	if ((ntpdata->time_state == TIME_INS) && (ntpdata->time_status & STA_INS))
 		return ktime_set(ntp_next_leap_sec, 0);
 	ret = KTIME_MAX;
 	return ret;
@@ -402,46 +399,46 @@ int second_overflow(time64_t secs)
 	 * day, the system clock is set back one second; if in leap-delete
 	 * state, the system clock is set ahead one second.
 	 */
-	switch (time_state) {
+	switch (ntpdata->time_state) {
 	case TIME_OK:
-		if (time_status & STA_INS) {
-			time_state = TIME_INS;
+		if (ntpdata->time_status & STA_INS) {
+			ntpdata->time_state = TIME_INS;
 			div_s64_rem(secs, SECS_PER_DAY, &rem);
 			ntp_next_leap_sec = secs + SECS_PER_DAY - rem;
-		} else if (time_status & STA_DEL) {
-			time_state = TIME_DEL;
+		} else if (ntpdata->time_status & STA_DEL) {
+			ntpdata->time_state = TIME_DEL;
 			div_s64_rem(secs + 1, SECS_PER_DAY, &rem);
 			ntp_next_leap_sec = secs + SECS_PER_DAY - rem;
 		}
 		break;
 	case TIME_INS:
-		if (!(time_status & STA_INS)) {
+		if (!(ntpdata->time_status & STA_INS)) {
 			ntp_next_leap_sec = TIME64_MAX;
-			time_state = TIME_OK;
+			ntpdata->time_state = TIME_OK;
 		} else if (secs == ntp_next_leap_sec) {
 			leap = -1;
-			time_state = TIME_OOP;
+			ntpdata->time_state = TIME_OOP;
 			pr_notice("Clock: inserting leap second 23:59:60 UTC\n");
 		}
 		break;
 	case TIME_DEL:
-		if (!(time_status & STA_DEL)) {
+		if (!(ntpdata->time_status & STA_DEL)) {
 			ntp_next_leap_sec = TIME64_MAX;
-			time_state = TIME_OK;
+			ntpdata->time_state = TIME_OK;
 		} else if (secs == ntp_next_leap_sec) {
 			leap = 1;
 			ntp_next_leap_sec = TIME64_MAX;
-			time_state = TIME_WAIT;
+			ntpdata->time_state = TIME_WAIT;
 			pr_notice("Clock: deleting leap second 23:59:59 UTC\n");
 		}
 		break;
 	case TIME_OOP:
 		ntp_next_leap_sec = TIME64_MAX;
-		time_state = TIME_WAIT;
+		ntpdata->time_state = TIME_WAIT;
 		break;
 	case TIME_WAIT:
-		if (!(time_status & (STA_INS | STA_DEL)))
-			time_state = TIME_OK;
+		if (!(ntpdata->time_status & (STA_INS | STA_DEL)))
+			ntpdata->time_state = TIME_OK;
 		break;
 	}
 
@@ -449,18 +446,18 @@ int second_overflow(time64_t secs)
 	time_maxerror += MAXFREQ / NSEC_PER_USEC;
 	if (time_maxerror > NTP_PHASE_LIMIT) {
 		time_maxerror = NTP_PHASE_LIMIT;
-		time_status |= STA_UNSYNC;
+		ntpdata->time_status |= STA_UNSYNC;
 	}
 
 	/* Compute the phase adjustment for the next second */
 	ntpdata->tick_length	 = ntpdata->tick_length_base;
 
-	delta			 = ntp_offset_chunk(time_offset);
+	delta			 = ntp_offset_chunk(ntpdata, time_offset);
 	time_offset		-= delta;
 	ntpdata->tick_length	+= delta;
 
 	/* Check PPS signal */
-	pps_dec_valid();
+	pps_dec_valid(ntpdata);
 
 	if (!time_adjust)
 		goto out;
@@ -608,7 +605,7 @@ static inline int update_rtc(struct timespec64 *to_set, unsigned long *offset_ns
  */
 static inline bool ntp_synced(void)
 {
-	return !(time_status & STA_UNSYNC);
+	return !(tk_ntp_data.time_status & STA_UNSYNC);
 }
 
 /*
@@ -691,11 +688,11 @@ static inline void __init ntp_init_cmos_sync(void) { }
 /*
  * Propagate a new txc->status value into the NTP state:
  */
-static inline void process_adj_status(const struct __kernel_timex *txc)
+static inline void process_adj_status(struct ntp_data *ntpdata, const struct __kernel_timex *txc)
 {
-	if ((time_status & STA_PLL) && !(txc->status & STA_PLL)) {
-		time_state = TIME_OK;
-		time_status = STA_UNSYNC;
+	if ((ntpdata->time_status & STA_PLL) && !(txc->status & STA_PLL)) {
+		ntpdata->time_state = TIME_OK;
+		ntpdata->time_status = STA_UNSYNC;
 		ntp_next_leap_sec = TIME64_MAX;
 		/* Restart PPS frequency calibration */
 		pps_reset_freq_interval();
@@ -705,26 +702,25 @@ static inline void process_adj_status(const struct __kernel_timex *txc)
 	 * If we turn on PLL adjustments then reset the
 	 * reference time to current time.
 	 */
-	if (!(time_status & STA_PLL) && (txc->status & STA_PLL))
+	if (!(ntpdata->time_status & STA_PLL) && (txc->status & STA_PLL))
 		time_reftime = __ktime_get_real_seconds();
 
-	/* Only set allowed bits */
-	time_status &= STA_RONLY;
-	time_status |= txc->status & ~STA_RONLY;
+	/* only set allowed bits */
+	ntpdata->time_status &= STA_RONLY;
+	ntpdata->time_status |= txc->status & ~STA_RONLY;
 }
 
-
 static inline void process_adjtimex_modes(struct ntp_data *ntpdata, const struct __kernel_timex *txc,
 					  s32 *time_tai)
 {
 	if (txc->modes & ADJ_STATUS)
-		process_adj_status(txc);
+		process_adj_status(ntpdata, txc);
 
 	if (txc->modes & ADJ_NANO)
-		time_status |= STA_NANO;
+		ntpdata->time_status |= STA_NANO;
 
 	if (txc->modes & ADJ_MICRO)
-		time_status &= ~STA_NANO;
+		ntpdata->time_status &= ~STA_NANO;
 
 	if (txc->modes & ADJ_FREQUENCY) {
 		time_freq = txc->freq * PPM_SCALE;
@@ -742,17 +738,16 @@ static inline void process_adjtimex_modes(struct ntp_data *ntpdata, const struct
 
 	if (txc->modes & ADJ_TIMECONST) {
 		time_constant = clamp(txc->constant, 0, MAXTC);
-		if (!(time_status & STA_NANO))
+		if (!(ntpdata->time_status & STA_NANO))
 			time_constant += 4;
 		time_constant = clamp(time_constant, 0, MAXTC);
 	}
 
-	if (txc->modes & ADJ_TAI &&
-			txc->constant >= 0 && txc->constant <= MAX_TAI_OFFSET)
+	if (txc->modes & ADJ_TAI && txc->constant >= 0 && txc->constant <= MAX_TAI_OFFSET)
 		*time_tai = txc->constant;
 
 	if (txc->modes & ADJ_OFFSET)
-		ntp_update_offset(txc->offset);
+		ntp_update_offset(ntpdata, txc->offset);
 
 	if (txc->modes & ADJ_TICK)
 		ntpdata->tick_usec = txc->tick;
@@ -788,7 +783,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 		if (txc->modes) {
 			audit_ntp_set_old(ad, AUDIT_NTP_OFFSET,	time_offset);
 			audit_ntp_set_old(ad, AUDIT_NTP_FREQ,	time_freq);
-			audit_ntp_set_old(ad, AUDIT_NTP_STATUS,	time_status);
+			audit_ntp_set_old(ad, AUDIT_NTP_STATUS,	ntpdata->time_status);
 			audit_ntp_set_old(ad, AUDIT_NTP_TAI,	*time_tai);
 			audit_ntp_set_old(ad, AUDIT_NTP_TICK,	ntpdata->tick_usec);
 
@@ -796,26 +791,26 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 
 			audit_ntp_set_new(ad, AUDIT_NTP_OFFSET,	time_offset);
 			audit_ntp_set_new(ad, AUDIT_NTP_FREQ,	time_freq);
-			audit_ntp_set_new(ad, AUDIT_NTP_STATUS,	time_status);
+			audit_ntp_set_new(ad, AUDIT_NTP_STATUS,	ntpdata->time_status);
 			audit_ntp_set_new(ad, AUDIT_NTP_TAI,	*time_tai);
 			audit_ntp_set_new(ad, AUDIT_NTP_TICK,	ntpdata->tick_usec);
 		}
 
 		txc->offset = shift_right(time_offset * NTP_INTERVAL_FREQ,
 				  NTP_SCALE_SHIFT);
-		if (!(time_status & STA_NANO))
+		if (!(ntpdata->time_status & STA_NANO))
 			txc->offset = (u32)txc->offset / NSEC_PER_USEC;
 	}
 
-	result = time_state;
-	if (is_error_status(time_status))
+	result = ntpdata->time_state;
+	if (is_error_status(ntpdata->time_status))
 		result = TIME_ERROR;
 
 	txc->freq	   = shift_right((time_freq >> PPM_SCALE_INV_SHIFT) *
 					 PPM_SCALE_INV, NTP_SCALE_SHIFT);
 	txc->maxerror	   = time_maxerror;
 	txc->esterror	   = time_esterror;
-	txc->status	   = time_status;
+	txc->status	   = ntpdata->time_status;
 	txc->constant	   = time_constant;
 	txc->precision	   = 1;
 	txc->tolerance	   = MAXFREQ_SCALED / PPM_SCALE;
@@ -823,26 +818,26 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 	txc->tai	   = *time_tai;
 
 	/* Fill PPS status fields */
-	pps_fill_timex(txc);
+	pps_fill_timex(ntpdata, txc);
 
 	txc->time.tv_sec = ts->tv_sec;
 	txc->time.tv_usec = ts->tv_nsec;
-	if (!(time_status & STA_NANO))
+	if (!(ntpdata->time_status & STA_NANO))
 		txc->time.tv_usec = ts->tv_nsec / NSEC_PER_USEC;
 
 	/* Handle leapsec adjustments */
 	if (unlikely(ts->tv_sec >= ntp_next_leap_sec)) {
-		if ((time_state == TIME_INS) && (time_status & STA_INS)) {
+		if ((ntpdata->time_state == TIME_INS) && (ntpdata->time_status & STA_INS)) {
 			result = TIME_OOP;
 			txc->tai++;
 			txc->time.tv_sec--;
 		}
-		if ((time_state == TIME_DEL) && (time_status & STA_DEL)) {
+		if ((ntpdata->time_state == TIME_DEL) && (ntpdata->time_status & STA_DEL)) {
 			result = TIME_WAIT;
 			txc->tai--;
 			txc->time.tv_sec++;
 		}
-		if ((time_state == TIME_OOP) &&	(ts->tv_sec == ntp_next_leap_sec))
+		if ((ntpdata->time_state == TIME_OOP) && (ts->tv_sec == ntp_next_leap_sec))
 			result = TIME_WAIT;
 	}
 
@@ -947,7 +942,7 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 
 	/* Check if the frequency interval was too long */
 	if (freq_norm.sec > (2 << pps_shift)) {
-		time_status |= STA_PPSERROR;
+		ntpdata->time_status |= STA_PPSERROR;
 		pps_errcnt++;
 		pps_dec_freq_interval();
 		printk_deferred(KERN_ERR "hardpps: PPSERROR: interval too long - %lld s\n",
@@ -966,7 +961,7 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 	pps_freq = ftemp;
 	if (delta > PPS_MAXWANDER || delta < -PPS_MAXWANDER) {
 		printk_deferred(KERN_WARNING "hardpps: PPSWANDER: change=%ld\n", delta);
-		time_status |= STA_PPSWANDER;
+		ntpdata->time_status |= STA_PPSWANDER;
 		pps_stbcnt++;
 		pps_dec_freq_interval();
 	} else {
@@ -985,7 +980,7 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 			       NSEC_PER_USEC) - pps_stabil) >> PPS_INTMIN;
 
 	/* If enabled, the system clock frequency is updated */
-	if ((time_status & STA_PPSFREQ) && !(time_status & STA_FREQHOLD)) {
+	if ((ntpdata->time_status & STA_PPSFREQ) && !(ntpdata->time_status & STA_FREQHOLD)) {
 		time_freq = pps_freq;
 		ntp_update_frequency(ntpdata);
 	}
@@ -994,7 +989,7 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 }
 
 /* Correct REALTIME clock phase error against PPS signal */
-static void hardpps_update_phase(long error)
+static void hardpps_update_phase(struct ntp_data *ntpdata, long error)
 {
 	long correction = -error;
 	long jitter;
@@ -1011,9 +1006,9 @@ static void hardpps_update_phase(long error)
 	if (jitter > (pps_jitter << PPS_POPCORN)) {
 		printk_deferred(KERN_WARNING "hardpps: PPSJITTER: jitter=%ld, limit=%ld\n",
 				jitter, (pps_jitter << PPS_POPCORN));
-		time_status |= STA_PPSJITTER;
+		ntpdata->time_status |= STA_PPSJITTER;
 		pps_jitcnt++;
-	} else if (time_status & STA_PPSTIME) {
+	} else if (ntpdata->time_status & STA_PPSTIME) {
 		/* Correct the time using the phase offset */
 		time_offset = div_s64(((s64)correction) << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
 		/* Cancel running adjtime() */
@@ -1043,10 +1038,10 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 	pts_norm = pps_normalize_ts(*phase_ts);
 
 	/* Clear the error bits, they will be set again if needed */
-	time_status &= ~(STA_PPSJITTER | STA_PPSWANDER | STA_PPSERROR);
+	ntpdata->time_status &= ~(STA_PPSJITTER | STA_PPSWANDER | STA_PPSERROR);
 
-	/* Indicate signal presence */
-	time_status |= STA_PPSSIGNAL;
+	/* indicate signal presence */
+	ntpdata->time_status |= STA_PPSSIGNAL;
 	pps_valid = PPS_VALID;
 
 	/*
@@ -1067,7 +1062,7 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 	 */
 	if ((freq_norm.sec == 0) || (freq_norm.nsec > MAXFREQ * freq_norm.sec) ||
 	    (freq_norm.nsec < -MAXFREQ * freq_norm.sec)) {
-		time_status |= STA_PPSJITTER;
+		ntpdata->time_status |= STA_PPSJITTER;
 		/* Restart the frequency calibration interval */
 		pps_fbase = *raw_ts;
 		printk_deferred(KERN_ERR "hardpps: PPSJITTER: bad pulse\n");
@@ -1082,7 +1077,7 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 		hardpps_update_freq(ntpdata, freq_norm);
 	}
 
-	hardpps_update_phase(pts_norm.nsec);
+	hardpps_update_phase(ntpdata, pts_norm.nsec);
 
 }
 #endif	/* CONFIG_NTP_PPS */

