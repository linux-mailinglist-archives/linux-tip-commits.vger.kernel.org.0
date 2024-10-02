Return-Path: <linux-tip-commits+bounces-2323-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEBC98DF88
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3DE1C24F8E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B239E1D0E36;
	Wed,  2 Oct 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nqzmvU97";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UV5nNCap"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ADE1D0DCE;
	Wed,  2 Oct 2024 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883892; cv=none; b=DBUzMPX5DkqVlqwO/xZhAFOoD9HJqNv/xSBjHhf2MzaJ+g1LWN/Z/N9rIw/A0PkKedwLMpr3FuHaQXBjMD86noMYrPkxo7Z5oHKXnX3TrY+Uzd/4zh5/+b6hHZLtdcP7gsJuhOUTp+pYXg4PCcYX4Iv2NR6jc+82/AuxuGkxt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883892; c=relaxed/simple;
	bh=sV/lyAxneYB0oHye5amJfKSUaKSFfYD3MzGgevEMT3g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V/pItP9TXxN9zJn1Iu3FvlI0Hc/kcoQ35qqUgxcxy1SZvbmJ7STav1fmz9JZiQ0UkIkuYgWuWwEY3VavUN/vKa2LGiB9z06LfwCTROOKd2mLTA85n7V1EDVi3Dv1a5EwHY+F8xLaTMBQJKFtBsKnUaAuPGySk83/wwVHRpqF8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nqzmvU97; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UV5nNCap; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:44:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883888;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulwvHlWefmqmvuCdsOoASRx4/PpABpCadUXiZdmLrVA=;
	b=nqzmvU976h/dP6tSQ5ge2mBuTv4A+3uo9yjhlxmZFiwhAILSjIlbpJm84CqHPhqqnhpXHZ
	DyOJ+lNVMFdPJvC6ZDSOBscainzhMGVfU+saWIszWEbC7uIybIA6kJlpazQBVC9mpabuRi
	JV4BRbBRsgKGPDDQiike1t9M5odWALwHQhgzywDjmpcSWh6ZVYeV14mMcX30HWowIwNfpo
	GqhsJgNgkOqXxLCfH++I07zfgrPTBloaup63dXMN2ud0AJdyKw4WjBdozIi1r7LjCvVt5Q
	Wb/kvitqmi1XHWRhqLEcRU+MFGubDLyzZzqsyWMGdkhNC+gqmjC733r0z+4zmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883888;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulwvHlWefmqmvuCdsOoASRx4/PpABpCadUXiZdmLrVA=;
	b=UV5nNCapoEoLD4mpuFu4a/pkqYGlHODRikEHjrOrgjTwnV2IKsOZA72WWDqINsNeyvZHu4
	7HVzypmzlKDf3OCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Move pps_shift/intcnt into ntp_data
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-19-?=
 =?utf-8?q?2d52f4e13476=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-19-2?=
 =?utf-8?q?d52f4e13476=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788388800.1442.13355632237011992806.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b1c89a762f753bedd5a62be4a5a586281be6f3c3
Gitweb:        https://git.kernel.org/tip/b1c89a762f753bedd5a62be4a5a586281be6f3c3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:40 +02:00

ntp: Move pps_shift/intcnt into ntp_data

Continue the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-19-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 54 +++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 4bde69c..bebff6c 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -44,6 +44,8 @@
  * @pps_tf:		PPS phase median filter
  * @pps_jitter:		PPS current jitter in nanoseconds
  * @pps_fbase:		PPS beginning of the last freq interval
+ * @pps_shift:		PPS current interval duration in seconds (shift value)
+ * @pps_intcnt:		PPS interval counter
  *
  * Protected by the timekeeping locks.
  */
@@ -67,6 +69,8 @@ struct ntp_data {
 	long			pps_tf[3];
 	long			pps_jitter;
 	struct timespec64	pps_fbase;
+	int			pps_shift;
+	int			pps_intcnt;
 #endif
 };
 
@@ -102,8 +106,6 @@ static struct ntp_data tk_ntp_data = {
 				   intervals to decrease it */
 #define PPS_MAXWANDER	100000	/* max PPS freq wander (ns/s) */
 
-static int pps_shift;		/* current interval duration (s) (shift) */
-static int pps_intcnt;		/* interval counter */
 static s64 pps_freq;		/* frequency offset (scaled ns/s) */
 static long pps_stabil;		/* current stability (scaled ns/s) */
 
@@ -128,11 +130,11 @@ static inline s64 ntp_offset_chunk(struct ntp_data *ntpdata, s64 offset)
 		return shift_right(offset, SHIFT_PLL + ntpdata->time_constant);
 }
 
-static inline void pps_reset_freq_interval(void)
+static inline void pps_reset_freq_interval(struct ntp_data *ntpdata)
 {
 	/* The PPS calibration interval may end surprisingly early */
-	pps_shift = PPS_INTMIN;
-	pps_intcnt = 0;
+	ntpdata->pps_shift = PPS_INTMIN;
+	ntpdata->pps_intcnt = 0;
 }
 
 /**
@@ -141,7 +143,7 @@ static inline void pps_reset_freq_interval(void)
  */
 static inline void pps_clear(struct ntp_data *ntpdata)
 {
-	pps_reset_freq_interval();
+	pps_reset_freq_interval(ntpdata);
 	ntpdata->pps_tf[0] = 0;
 	ntpdata->pps_tf[1] = 0;
 	ntpdata->pps_tf[2] = 0;
@@ -199,7 +201,7 @@ static inline void pps_fill_timex(struct ntp_data *ntpdata, struct __kernel_time
 	txc->jitter	   = ntpdata->pps_jitter;
 	if (!(ntpdata->time_status & STA_NANO))
 		txc->jitter = ntpdata->pps_jitter / NSEC_PER_USEC;
-	txc->shift	   = pps_shift;
+	txc->shift	   = ntpdata->pps_shift;
 	txc->stabil	   = pps_stabil;
 	txc->jitcnt	   = pps_jitcnt;
 	txc->calcnt	   = pps_calcnt;
@@ -214,7 +216,7 @@ static inline s64 ntp_offset_chunk(struct ntp_data *ntpdata, s64 offset)
 	return shift_right(offset, SHIFT_PLL + ntpdata->time_constant);
 }
 
-static inline void pps_reset_freq_interval(void) {}
+static inline void pps_reset_freq_interval(struct ntp_data *ntpdata) {}
 static inline void pps_clear(struct ntp_data *ntpdata) {}
 static inline void pps_dec_valid(struct ntp_data *ntpdata) {}
 static inline void pps_set_freq(s64 freq) {}
@@ -693,7 +695,7 @@ static inline void process_adj_status(struct ntp_data *ntpdata, const struct __k
 		ntpdata->time_status = STA_UNSYNC;
 		ntpdata->ntp_next_leap_sec = TIME64_MAX;
 		/* Restart PPS frequency calibration */
-		pps_reset_freq_interval();
+		pps_reset_freq_interval(ntpdata);
 	}
 
 	/*
@@ -896,13 +898,13 @@ static inline void pps_phase_filter_add(struct ntp_data *ntpdata, long err)
  * Decrease frequency calibration interval length. It is halved after four
  * consecutive unstable intervals.
  */
-static inline void pps_dec_freq_interval(void)
+static inline void pps_dec_freq_interval(struct ntp_data *ntpdata)
 {
-	if (--pps_intcnt <= -PPS_INTCOUNT) {
-		pps_intcnt = -PPS_INTCOUNT;
-		if (pps_shift > PPS_INTMIN) {
-			pps_shift--;
-			pps_intcnt = 0;
+	if (--ntpdata->pps_intcnt <= -PPS_INTCOUNT) {
+		ntpdata->pps_intcnt = -PPS_INTCOUNT;
+		if (ntpdata->pps_shift > PPS_INTMIN) {
+			ntpdata->pps_shift--;
+			ntpdata->pps_intcnt = 0;
 		}
 	}
 }
@@ -911,13 +913,13 @@ static inline void pps_dec_freq_interval(void)
  * Increase frequency calibration interval length. It is doubled after
  * four consecutive stable intervals.
  */
-static inline void pps_inc_freq_interval(void)
+static inline void pps_inc_freq_interval(struct ntp_data *ntpdata)
 {
-	if (++pps_intcnt >= PPS_INTCOUNT) {
-		pps_intcnt = PPS_INTCOUNT;
-		if (pps_shift < PPS_INTMAX) {
-			pps_shift++;
-			pps_intcnt = 0;
+	if (++ntpdata->pps_intcnt >= PPS_INTCOUNT) {
+		ntpdata->pps_intcnt = PPS_INTCOUNT;
+		if (ntpdata->pps_shift < PPS_INTMAX) {
+			ntpdata->pps_shift++;
+			ntpdata->pps_intcnt = 0;
 		}
 	}
 }
@@ -938,10 +940,10 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 	s64 ftemp;
 
 	/* Check if the frequency interval was too long */
-	if (freq_norm.sec > (2 << pps_shift)) {
+	if (freq_norm.sec > (2 << ntpdata->pps_shift)) {
 		ntpdata->time_status |= STA_PPSERROR;
 		pps_errcnt++;
-		pps_dec_freq_interval();
+		pps_dec_freq_interval(ntpdata);
 		printk_deferred(KERN_ERR "hardpps: PPSERROR: interval too long - %lld s\n",
 				freq_norm.sec);
 		return 0;
@@ -960,10 +962,10 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 		printk_deferred(KERN_WARNING "hardpps: PPSWANDER: change=%ld\n", delta);
 		ntpdata->time_status |= STA_PPSWANDER;
 		pps_stbcnt++;
-		pps_dec_freq_interval();
+		pps_dec_freq_interval(ntpdata);
 	} else {
 		/* Good sample */
-		pps_inc_freq_interval();
+		pps_inc_freq_interval(ntpdata);
 	}
 
 	/*
@@ -1068,7 +1070,7 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 	}
 
 	/* Signal is ok. Check if the current frequency interval is finished */
-	if (freq_norm.sec >= (1 << pps_shift)) {
+	if (freq_norm.sec >= (1 << ntpdata->pps_shift)) {
 		pps_calcnt++;
 		/* Restart the frequency calibration interval */
 		ntpdata->pps_fbase = *raw_ts;

