Return-Path: <linux-tip-commits+bounces-2327-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7122C98DF8F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8A12829CB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11921D12E0;
	Wed,  2 Oct 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QcRnnJQt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S5nsMlvW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C80C1D0E22;
	Wed,  2 Oct 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883894; cv=none; b=LPYE4vndX7CSLT2F+k6kYRDwvs5GZ/sB+q89Cb3iKNYpJCOFLlfOwG18+tc3ZpBrvgS8rI7cbqGpJOoVAvR2AMF5h4vQx+Flj9T9ZIiZ2eizHSCCzAN645gKVTfnYwiRmiyB0ls9yGZbzVkUlczSiq2BCc8t4dyGZFna8dkESGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883894; c=relaxed/simple;
	bh=lUa8DeIar+hKgJpu9ii9fQsWEZ5dWcwblxkQ08dlj3E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qb70hj7/4aMnZDfM8Qvb8oGz6tTOem1PS/EApVqBMjTKSa2bu7tB/riA3DDCrth3gbjbd7tOozK4SVSu55itjSPQ/MEFAvd29/dECrNTqZ2eVnlvdaJY3kcWNHIyb+AlQOVOI43CnG6uS2JmZEzXApdwY9Dj+xqjWatng4vO6c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QcRnnJQt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S5nsMlvW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:44:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJ3uQGs2YGwsBl9AlnLhrt+/vOdKPzIa+xEqN64v1YM=;
	b=QcRnnJQtaR/OGlMgiGQEORv2eFGPBkNCo+YRSDp+0C6A+AMt5kLdazmBlLeab/W4GSiuZh
	R0rowaYchVpxcLqveSTZ7iVzFMODlCr9fVsUgLwykZG2pQIjNi2vMwGJxUjz6eCCyLBlf/
	TDbjFRQPiOj+VI2Mb4YIDFERhPMBhI93PTYR4BGM7BkkFmBTQuo5nKbZhTZDifIbr6eaIX
	c/xJVbeIpWuAaoGo9NCH52thC9TRGWj/Q7c5P3uxtFbo+iQv4yboJ+jM+6ktaZZM1/Ko7B
	b2Smw+L3OOcJol+PhCP+Uq1TuUEfhlt0b9C6akqq/k0YnScUlKwkHYa9+rV5lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJ3uQGs2YGwsBl9AlnLhrt+/vOdKPzIa+xEqN64v1YM=;
	b=S5nsMlvWkeSm108F0sujmjO/z5z/5vVpDHjs81KLiBRfhguAYQedXeTQvEuGjP9SrMUnlE
	cCBvyOW9lkz6O6CA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Move ntp_next_leap_sec into ntp_data
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-14-?=
 =?utf-8?q?2d52f4e13476=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-14-2?=
 =?utf-8?q?d52f4e13476=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788389046.1442.10725706193332289513.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     75d956b947b7fc99df80a0db6677cdc30e70f75b
Gitweb:        https://git.kernel.org/tip/75d956b947b7fc99df80a0db6677cdc30e70f75b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:40 +02:00

ntp: Move ntp_next_leap_sec into ntp_data

Continue the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-14-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index f9c2f26..f156114 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -38,6 +38,7 @@
  * @time_reftime:	Time at last adjustment in seconds
  * @time_adjust:	Adjustment value
  * @ntp_tick_adj:	Constant boot-param configurable NTP tick adjustment (upscaled)
+ * @ntp_next_leap_sec:	Second value of the next pending leapsecond, or TIME64_MAX if no leap
  *
  * Protected by the timekeeping locks.
  */
@@ -55,6 +56,7 @@ struct ntp_data {
 	time64_t		time_reftime;
 	long			time_adjust;
 	s64			ntp_tick_adj;
+	time64_t		ntp_next_leap_sec;
 };
 
 static struct ntp_data tk_ntp_data = {
@@ -64,6 +66,7 @@ static struct ntp_data tk_ntp_data = {
 	.time_constant		= 2,
 	.time_maxerror		= NTP_PHASE_LIMIT,
 	.time_esterror		= NTP_PHASE_LIMIT,
+	.ntp_next_leap_sec	= TIME64_MAX,
 };
 
 #define SECS_PER_DAY		86400
@@ -72,9 +75,6 @@ static struct ntp_data tk_ntp_data = {
 	(((MAX_TICKADJ * NSEC_PER_USEC) << NTP_SCALE_SHIFT) / NTP_INTERVAL_FREQ)
 #define MAX_TAI_OFFSET		100000
 
-/* second value of the next pending leapsecond, or TIME64_MAX if no leap */
-static time64_t			ntp_next_leap_sec = TIME64_MAX;
-
 #ifdef CONFIG_NTP_PPS
 
 /*
@@ -331,7 +331,7 @@ static void __ntp_clear(struct ntp_data *ntpdata)
 	ntpdata->tick_length	= ntpdata->tick_length_base;
 	ntpdata->time_offset	= 0;
 
-	ntp_next_leap_sec = TIME64_MAX;
+	ntpdata->ntp_next_leap_sec = TIME64_MAX;
 	/* Clear PPS state variables */
 	pps_clear();
 }
@@ -362,7 +362,7 @@ ktime_t ntp_get_next_leap(void)
 	ktime_t ret;
 
 	if ((ntpdata->time_state == TIME_INS) && (ntpdata->time_status & STA_INS))
-		return ktime_set(ntp_next_leap_sec, 0);
+		return ktime_set(ntpdata->ntp_next_leap_sec, 0);
 	ret = KTIME_MAX;
 	return ret;
 }
@@ -394,18 +394,18 @@ int second_overflow(time64_t secs)
 		if (ntpdata->time_status & STA_INS) {
 			ntpdata->time_state = TIME_INS;
 			div_s64_rem(secs, SECS_PER_DAY, &rem);
-			ntp_next_leap_sec = secs + SECS_PER_DAY - rem;
+			ntpdata->ntp_next_leap_sec = secs + SECS_PER_DAY - rem;
 		} else if (ntpdata->time_status & STA_DEL) {
 			ntpdata->time_state = TIME_DEL;
 			div_s64_rem(secs + 1, SECS_PER_DAY, &rem);
-			ntp_next_leap_sec = secs + SECS_PER_DAY - rem;
+			ntpdata->ntp_next_leap_sec = secs + SECS_PER_DAY - rem;
 		}
 		break;
 	case TIME_INS:
 		if (!(ntpdata->time_status & STA_INS)) {
-			ntp_next_leap_sec = TIME64_MAX;
+			ntpdata->ntp_next_leap_sec = TIME64_MAX;
 			ntpdata->time_state = TIME_OK;
-		} else if (secs == ntp_next_leap_sec) {
+		} else if (secs == ntpdata->ntp_next_leap_sec) {
 			leap = -1;
 			ntpdata->time_state = TIME_OOP;
 			pr_notice("Clock: inserting leap second 23:59:60 UTC\n");
@@ -413,17 +413,17 @@ int second_overflow(time64_t secs)
 		break;
 	case TIME_DEL:
 		if (!(ntpdata->time_status & STA_DEL)) {
-			ntp_next_leap_sec = TIME64_MAX;
+			ntpdata->ntp_next_leap_sec = TIME64_MAX;
 			ntpdata->time_state = TIME_OK;
-		} else if (secs == ntp_next_leap_sec) {
+		} else if (secs == ntpdata->ntp_next_leap_sec) {
 			leap = 1;
-			ntp_next_leap_sec = TIME64_MAX;
+			ntpdata->ntp_next_leap_sec = TIME64_MAX;
 			ntpdata->time_state = TIME_WAIT;
 			pr_notice("Clock: deleting leap second 23:59:59 UTC\n");
 		}
 		break;
 	case TIME_OOP:
-		ntp_next_leap_sec = TIME64_MAX;
+		ntpdata->ntp_next_leap_sec = TIME64_MAX;
 		ntpdata->time_state = TIME_WAIT;
 		break;
 	case TIME_WAIT:
@@ -683,7 +683,7 @@ static inline void process_adj_status(struct ntp_data *ntpdata, const struct __k
 	if ((ntpdata->time_status & STA_PLL) && !(txc->status & STA_PLL)) {
 		ntpdata->time_state = TIME_OK;
 		ntpdata->time_status = STA_UNSYNC;
-		ntp_next_leap_sec = TIME64_MAX;
+		ntpdata->ntp_next_leap_sec = TIME64_MAX;
 		/* Restart PPS frequency calibration */
 		pps_reset_freq_interval();
 	}
@@ -815,7 +815,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 		txc->time.tv_usec = ts->tv_nsec / NSEC_PER_USEC;
 
 	/* Handle leapsec adjustments */
-	if (unlikely(ts->tv_sec >= ntp_next_leap_sec)) {
+	if (unlikely(ts->tv_sec >= ntpdata->ntp_next_leap_sec)) {
 		if ((ntpdata->time_state == TIME_INS) && (ntpdata->time_status & STA_INS)) {
 			result = TIME_OOP;
 			txc->tai++;
@@ -826,7 +826,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 			txc->tai--;
 			txc->time.tv_sec++;
 		}
-		if ((ntpdata->time_state == TIME_OOP) && (ts->tv_sec == ntp_next_leap_sec))
+		if ((ntpdata->time_state == TIME_OOP) && (ts->tv_sec == ntpdata->ntp_next_leap_sec))
 			result = TIME_WAIT;
 	}
 

