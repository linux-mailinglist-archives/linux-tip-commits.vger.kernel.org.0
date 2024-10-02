Return-Path: <linux-tip-commits+bounces-2341-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3D198DFB1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEB56B2ACC9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9B61D2711;
	Wed,  2 Oct 2024 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="teGxVFtA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iLWK9RRE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D31D1E98;
	Wed,  2 Oct 2024 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883901; cv=none; b=Q8hUUrksE7rTBcvcxA5CbnwU9FfTVPGNJfBmG7DbU/SGmgXdwPN4xAWuVOndO1racPhLtgyf2JShW+bFJqNJ2xurmpjn2ch573z6Uzqabpq5nUAJd4IxM07qBYdTcfAe+l56MJZtihl1QG0fWWRO2q4U+GMYzy+0DHRdhwNr5zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883901; c=relaxed/simple;
	bh=HPUwfzIi81z1o+Mt2KeYXhqZBlbX2OzYfIOaooqZL48=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SvzAq4qylh1A2GYQcIbhyZW2N4UmXENj6vliw2GirKBhtw05Qw4IgIjbsbiDuUUIK0FMkM2p9o7j4NzAME3vSCK8C/kll7BJNDl9AC3UD6AnK4A1hy7M0k3fhf3LkvJP1TcNsBKZmvp+e5wo4/maudHQBpjFjR/BXerzTqKuNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=teGxVFtA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iLWK9RRE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:44:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883896;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTI4pYA22rYyggsmTud0eC5VT6nQWkq1ZesDDgWsu7I=;
	b=teGxVFtAbRcgZKaFzXcF2uaH9JosAZUGXX8wRLUGI/GHiRGdW7zlSzU+hY+VVoP2fM7SYy
	J56hK4DHc6VEduGqiULjMQKanFntSj8LQjEY5UJhWIYm5XUU+dlhzHp9ShHFQFwMy55EhO
	ZpR0AFbV1f7/oI3VrRGzpI8zJQx0Juc7/LoSvHqWtMWjljILN7USCdqYH9IU2JVezpm1/3
	ez3a25bqZLEKw98G1BmDeXnrjo0YnUKYLV0QaqeDEIg6Q62CsTFQbQXBij7Q3KlhCXeLai
	PKGT5grLAK1SYUvNT19sqnqmYxeuHTCW8z/uUo8e4l8VtipuVNEkM+pGnOUBEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883896;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTI4pYA22rYyggsmTud0eC5VT6nQWkq1ZesDDgWsu7I=;
	b=iLWK9RRE1BCb0Y21JyxuxVu7x00sxmKEL1an56y1d7xZQROqzl7CzIr072knsK3KcMvUqp
	pJ8YqMQGPTNYKtAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Clean up comments
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-3-2d52f4e13476@linutronix.de>
References:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-3-2d52f4e13476@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788389616.1442.2949348497247504879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a0581cdb2e5d3ad633e51a945b6f0527ce70b68a
Gitweb:        https://git.kernel.org/tip/a0581cdb2e5d3ad633e51a945b6f0527ce70b68a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:38 +02:00

ntp: Clean up comments

Usage of different comment formatting makes fast reading and parsing the
code harder. There are several multi-line comments which do not follow the
coding style by starting with a line only containing '/*'. There are also
comments which do not start with capitals.

Clean up all those comments to be consistent and remove comments which
document the obvious.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-3-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 144 ++++++++++++++++++++++++---------------------
 1 file changed, 78 insertions(+), 66 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index ed15ec9..e78d3cd 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -119,7 +119,8 @@ static long pps_stbcnt;		/* stability limit exceeded */
 static long pps_errcnt;		/* calibration errors */
 
 
-/* PPS kernel consumer compensates the whole phase error immediately.
+/*
+ * PPS kernel consumer compensates the whole phase error immediately.
  * Otherwise, reduce the offset by a fixed factor times the time constant.
  */
 static inline s64 ntp_offset_chunk(s64 offset)
@@ -132,8 +133,7 @@ static inline s64 ntp_offset_chunk(s64 offset)
 
 static inline void pps_reset_freq_interval(void)
 {
-	/* the PPS calibration interval may end
-	   surprisingly early */
+	/* The PPS calibration interval may end surprisingly early */
 	pps_shift = PPS_INTMIN;
 	pps_intcnt = 0;
 }
@@ -151,9 +151,9 @@ static inline void pps_clear(void)
 	pps_freq = 0;
 }
 
-/* Decrease pps_valid to indicate that another second has passed since
- * the last PPS signal. When it reaches 0, indicate that PPS signal is
- * missing.
+/*
+ * Decrease pps_valid to indicate that another second has passed since the
+ * last PPS signal. When it reaches 0, indicate that PPS signal is missing.
  */
 static inline void pps_dec_valid(void)
 {
@@ -174,17 +174,21 @@ static inline void pps_set_freq(s64 freq)
 static inline int is_error_status(int status)
 {
 	return (status & (STA_UNSYNC|STA_CLOCKERR))
-		/* PPS signal lost when either PPS time or
-		 * PPS frequency synchronization requested
+		/*
+		 * PPS signal lost when either PPS time or PPS frequency
+		 * synchronization requested
 		 */
 		|| ((status & (STA_PPSFREQ|STA_PPSTIME))
 			&& !(status & STA_PPSSIGNAL))
-		/* PPS jitter exceeded when
-		 * PPS time synchronization requested */
+		/*
+		 * PPS jitter exceeded when PPS time synchronization
+		 * requested
+		 */
 		|| ((status & (STA_PPSTIME|STA_PPSJITTER))
 			== (STA_PPSTIME|STA_PPSJITTER))
-		/* PPS wander exceeded or calibration error when
-		 * PPS frequency synchronization requested
+		/*
+		 * PPS wander exceeded or calibration error when PPS
+		 * frequency synchronization requested
 		 */
 		|| ((status & STA_PPSFREQ)
 			&& (status & (STA_PPSWANDER|STA_PPSERROR)));
@@ -270,8 +274,8 @@ static void ntp_update_frequency(void)
 	new_base		 = div_u64(second_length, NTP_INTERVAL_FREQ);
 
 	/*
-	 * Don't wait for the next second_overflow, apply
-	 * the change to the tick length immediately:
+	 * Don't wait for the next second_overflow, apply the change to the
+	 * tick length immediately:
 	 */
 	tick_length		+= new_base - tick_length_base;
 	tick_length_base	 = new_base;
@@ -307,10 +311,7 @@ static void ntp_update_offset(long offset)
 		offset *= NSEC_PER_USEC;
 	}
 
-	/*
-	 * Scale the phase adjustment and
-	 * clamp to the operating range.
-	 */
+	/* Scale the phase adjustment and clamp to the operating range. */
 	offset = clamp(offset, -MAXPHASE, MAXPHASE);
 
 	/*
@@ -349,7 +350,8 @@ static void ntp_update_offset(long offset)
  */
 void ntp_clear(void)
 {
-	time_adjust	= 0;		/* stop active adjtime() */
+	/* Stop active adjtime() */
+	time_adjust	= 0;
 	time_status	|= STA_UNSYNC;
 	time_maxerror	= NTP_PHASE_LIMIT;
 	time_esterror	= NTP_PHASE_LIMIT;
@@ -387,7 +389,7 @@ ktime_t ntp_get_next_leap(void)
 }
 
 /*
- * this routine handles the overflow of the microsecond field
+ * This routine handles the overflow of the microsecond field
  *
  * The tricky bits of code to handle the accurate clock support
  * were provided by Dave Mills (Mills@UDEL.EDU) of NTP fame.
@@ -452,7 +454,6 @@ int second_overflow(time64_t secs)
 		break;
 	}
 
-
 	/* Bump the maxerror field */
 	time_maxerror += MAXFREQ / NSEC_PER_USEC;
 	if (time_maxerror > NTP_PHASE_LIMIT) {
@@ -696,7 +697,7 @@ static inline void process_adj_status(const struct __kernel_timex *txc)
 		time_state = TIME_OK;
 		time_status = STA_UNSYNC;
 		ntp_next_leap_sec = TIME64_MAX;
-		/* restart PPS frequency calibration */
+		/* Restart PPS frequency calibration */
 		pps_reset_freq_interval();
 	}
 
@@ -707,7 +708,7 @@ static inline void process_adj_status(const struct __kernel_timex *txc)
 	if (!(time_status & STA_PLL) && (txc->status & STA_PLL))
 		time_reftime = __ktime_get_real_seconds();
 
-	/* only set allowed bits */
+	/* Only set allowed bits */
 	time_status &= STA_RONLY;
 	time_status |= txc->status & ~STA_RONLY;
 }
@@ -729,7 +730,7 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 		time_freq = txc->freq * PPM_SCALE;
 		time_freq = min(time_freq, MAXFREQ_SCALED);
 		time_freq = max(time_freq, -MAXFREQ_SCALED);
-		/* update pps_freq */
+		/* Update pps_freq */
 		pps_set_freq(time_freq);
 	}
 
@@ -762,7 +763,7 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 
 
 /*
- * adjtimex mainly allows reading (and writing, if superuser) of
+ * adjtimex() mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
  */
 int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
@@ -806,8 +807,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 			txc->offset = (u32)txc->offset / NSEC_PER_USEC;
 	}
 
-	result = time_state;	/* mostly `TIME_OK' */
-	/* check for errors */
+	result = time_state;
 	if (is_error_status(time_status))
 		result = TIME_ERROR;
 
@@ -822,7 +822,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 	txc->tick	   = tick_usec;
 	txc->tai	   = *time_tai;
 
-	/* fill PPS status fields */
+	/* Fill PPS status fields */
 	pps_fill_timex(txc);
 
 	txc->time.tv_sec = ts->tv_sec;
@@ -853,17 +853,21 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 
 #ifdef	CONFIG_NTP_PPS
 
-/* actually struct pps_normtime is good old struct timespec, but it is
+/*
+ * struct pps_normtime is basically a struct timespec, but it is
  * semantically different (and it is the reason why it was invented):
  * pps_normtime.nsec has a range of ( -NSEC_PER_SEC / 2, NSEC_PER_SEC / 2 ]
- * while timespec.tv_nsec has a range of [0, NSEC_PER_SEC) */
+ * while timespec.tv_nsec has a range of [0, NSEC_PER_SEC)
+ */
 struct pps_normtime {
 	s64		sec;	/* seconds */
 	long		nsec;	/* nanoseconds */
 };
 
-/* normalize the timestamp so that nsec is in the
-   ( -NSEC_PER_SEC / 2, NSEC_PER_SEC / 2 ] interval */
+/*
+ * Normalize the timestamp so that nsec is in the
+ * [ -NSEC_PER_SEC / 2, NSEC_PER_SEC / 2 ] interval
+ */
 static inline struct pps_normtime pps_normalize_ts(struct timespec64 ts)
 {
 	struct pps_normtime norm = {
@@ -879,7 +883,7 @@ static inline struct pps_normtime pps_normalize_ts(struct timespec64 ts)
 	return norm;
 }
 
-/* get current phase correction and jitter */
+/* Get current phase correction and jitter */
 static inline long pps_phase_filter_get(long *jitter)
 {
 	*jitter = pps_tf[0] - pps_tf[1];
@@ -890,7 +894,7 @@ static inline long pps_phase_filter_get(long *jitter)
 	return pps_tf[0];
 }
 
-/* add the sample to the phase filter */
+/* Add the sample to the phase filter */
 static inline void pps_phase_filter_add(long err)
 {
 	pps_tf[2] = pps_tf[1];
@@ -898,8 +902,9 @@ static inline void pps_phase_filter_add(long err)
 	pps_tf[0] = err;
 }
 
-/* decrease frequency calibration interval length.
- * It is halved after four consecutive unstable intervals.
+/*
+ * Decrease frequency calibration interval length. It is halved after four
+ * consecutive unstable intervals.
  */
 static inline void pps_dec_freq_interval(void)
 {
@@ -912,8 +917,9 @@ static inline void pps_dec_freq_interval(void)
 	}
 }
 
-/* increase frequency calibration interval length.
- * It is doubled after four consecutive stable intervals.
+/*
+ * Increase frequency calibration interval length. It is doubled after
+ * four consecutive stable intervals.
  */
 static inline void pps_inc_freq_interval(void)
 {
@@ -926,7 +932,8 @@ static inline void pps_inc_freq_interval(void)
 	}
 }
 
-/* update clock frequency based on MONOTONIC_RAW clock PPS signal
+/*
+ * Update clock frequency based on MONOTONIC_RAW clock PPS signal
  * timestamps
  *
  * At the end of the calibration interval the difference between the
@@ -940,7 +947,7 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 	long delta, delta_mod;
 	s64 ftemp;
 
-	/* check if the frequency interval was too long */
+	/* Check if the frequency interval was too long */
 	if (freq_norm.sec > (2 << pps_shift)) {
 		time_status |= STA_PPSERROR;
 		pps_errcnt++;
@@ -951,9 +958,10 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 		return 0;
 	}
 
-	/* here the raw frequency offset and wander (stability) is
-	 * calculated. If the wander is less than the wander threshold
-	 * the interval is increased; otherwise it is decreased.
+	/*
+	 * Here the raw frequency offset and wander (stability) is
+	 * calculated. If the wander is less than the wander threshold the
+	 * interval is increased; otherwise it is decreased.
 	 */
 	ftemp = div_s64(((s64)(-freq_norm.nsec)) << NTP_SCALE_SHIFT,
 			freq_norm.sec);
@@ -965,13 +973,14 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 		time_status |= STA_PPSWANDER;
 		pps_stbcnt++;
 		pps_dec_freq_interval();
-	} else {	/* good sample */
+	} else {
+		/* Good sample */
 		pps_inc_freq_interval();
 	}
 
-	/* the stability metric is calculated as the average of recent
-	 * frequency changes, but is used only for performance
-	 * monitoring
+	/*
+	 * The stability metric is calculated as the average of recent
+	 * frequency changes, but is used only for performance monitoring
 	 */
 	delta_mod = delta;
 	if (delta_mod < 0)
@@ -980,7 +989,7 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 				(NTP_SCALE_SHIFT - SHIFT_USEC),
 				NSEC_PER_USEC) - pps_stabil) >> PPS_INTMIN;
 
-	/* if enabled, the system clock frequency is updated */
+	/* If enabled, the system clock frequency is updated */
 	if ((time_status & STA_PPSFREQ) != 0 &&
 	    (time_status & STA_FREQHOLD) == 0) {
 		time_freq = pps_freq;
@@ -990,17 +999,18 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 	return delta;
 }
 
-/* correct REALTIME clock phase error against PPS signal */
+/* Correct REALTIME clock phase error against PPS signal */
 static void hardpps_update_phase(long error)
 {
 	long correction = -error;
 	long jitter;
 
-	/* add the sample to the median filter */
+	/* Add the sample to the median filter */
 	pps_phase_filter_add(correction);
 	correction = pps_phase_filter_get(&jitter);
 
-	/* Nominal jitter is due to PPS signal noise. If it exceeds the
+	/*
+	 * Nominal jitter is due to PPS signal noise. If it exceeds the
 	 * threshold, the sample is discarded; otherwise, if so enabled,
 	 * the time offset is updated.
 	 */
@@ -1011,13 +1021,13 @@ static void hardpps_update_phase(long error)
 		time_status |= STA_PPSJITTER;
 		pps_jitcnt++;
 	} else if (time_status & STA_PPSTIME) {
-		/* correct the time using the phase offset */
+		/* Correct the time using the phase offset */
 		time_offset = div_s64(((s64)correction) << NTP_SCALE_SHIFT,
 				NTP_INTERVAL_FREQ);
-		/* cancel running adjtime() */
+		/* Cancel running adjtime() */
 		time_adjust = 0;
 	}
-	/* update jitter */
+	/* Update jitter */
 	pps_jitter += (jitter - pps_jitter) >> PPS_INTMIN;
 }
 
@@ -1039,41 +1049,43 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 
 	pts_norm = pps_normalize_ts(*phase_ts);
 
-	/* clear the error bits, they will be set again if needed */
+	/* Clear the error bits, they will be set again if needed */
 	time_status &= ~(STA_PPSJITTER | STA_PPSWANDER | STA_PPSERROR);
 
-	/* indicate signal presence */
+	/* Indicate signal presence */
 	time_status |= STA_PPSSIGNAL;
 	pps_valid = PPS_VALID;
 
-	/* when called for the first time,
-	 * just start the frequency interval */
+	/*
+	 * When called for the first time, just start the frequency
+	 * interval
+	 */
 	if (unlikely(pps_fbase.tv_sec == 0)) {
 		pps_fbase = *raw_ts;
 		return;
 	}
 
-	/* ok, now we have a base for frequency calculation */
+	/* Ok, now we have a base for frequency calculation */
 	freq_norm = pps_normalize_ts(timespec64_sub(*raw_ts, pps_fbase));
 
-	/* check that the signal is in the range
-	 * [1s - MAXFREQ us, 1s + MAXFREQ us], otherwise reject it */
+	/*
+	 * Check that the signal is in the range
+	 * [1s - MAXFREQ us, 1s + MAXFREQ us], otherwise reject it
+	 */
 	if ((freq_norm.sec == 0) ||
 			(freq_norm.nsec > MAXFREQ * freq_norm.sec) ||
 			(freq_norm.nsec < -MAXFREQ * freq_norm.sec)) {
 		time_status |= STA_PPSJITTER;
-		/* restart the frequency calibration interval */
+		/* Restart the frequency calibration interval */
 		pps_fbase = *raw_ts;
 		printk_deferred(KERN_ERR "hardpps: PPSJITTER: bad pulse\n");
 		return;
 	}
 
-	/* signal is ok */
-
-	/* check if the current frequency interval is finished */
+	/* Signal is ok. Check if the current frequency interval is finished */
 	if (freq_norm.sec >= (1 << pps_shift)) {
 		pps_calcnt++;
-		/* restart the frequency calibration interval */
+		/* Restart the frequency calibration interval */
 		pps_fbase = *raw_ts;
 		hardpps_update_freq(freq_norm);
 	}

