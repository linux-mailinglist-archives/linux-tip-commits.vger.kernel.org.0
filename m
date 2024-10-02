Return-Path: <linux-tip-commits+bounces-2322-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B6798DF86
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FAC1C24F87
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324151D0E1C;
	Wed,  2 Oct 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RAE9F4KU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ah1bsM+m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0651D014D;
	Wed,  2 Oct 2024 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883892; cv=none; b=a8VhlM9nQjOGcnVgoH4gCVOXvYrxaU2aSt7/B/vBsZEoDI13emBPSvJQGvaylG+xoQ0oSraUfOuWKKhDm2epk4BxRh18Sl3LRbnmG9/qNM5GA0SMpSgl+lXBrx4/Yrh1c9/U5fUbYp5Fcq/q0utXX8f3G583uJT9+/kXk8U/nSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883892; c=relaxed/simple;
	bh=ECUnkzQaJs/AarKfjcjCTg5Mmk2gigZgWInQypTDDD0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sm2kYg7ZRd/6FLAH88faCGNbu2XoFNLNsSQmsQh2dLipGlCAWfa9Gzc+/x8yM8wJb4H3ZHCZgyovk7rLaTRudFCv/gBpK3Dru49OLON8PZetw5cQI6MPz8eoPcU6SLtpIuZbp63Ecs9Vj9jJIOe+t6GQz1W/a21GzKM50to3gs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RAE9F4KU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ah1bsM+m; arc=none smtp.client-ip=193.142.43.55
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
	bh=1xhqYxXX63tqZDxzoJGy5Ngxj4tTryM5LKccy9in7Pg=;
	b=RAE9F4KUa9IQsLJP743XaP9MYhRrRU1q4AoXzsmxA8HH4ga0p+uo6GLOzg/RAT6tWV3dP4
	EiQZGST1yLNqTsRz3XsRMzXsif5qlhsCc+1HA8+xliXgjKiTiizYrHTshb/v6ySoIx511+
	nP097+xq8nGQt1kKF750LDuUKcA2KORBW6gdyJg/kohFwTV8EmWMwgl4l1PUnjxgFpY8Nh
	t2SZPNuo05HXCdYGZrP7VHkV4v0XJRAVv8jRniIo0eZHvIwUx4Afa/GHGTipmukxCM3v/T
	kMxF7M/wzaKj9MAbKEmBJ2B1/Hssq06L1OaBLbYJ2YwdFd6Yb7c9bVXGbtouAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883888;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1xhqYxXX63tqZDxzoJGy5Ngxj4tTryM5LKccy9in7Pg=;
	b=ah1bsM+mgtCC1MWVEBEk8MI9SHgpNTEtKdr8AHl6dlveFvyigAMCste7P8u4OBvNr6wL8d
	BRHSW3qIzgbniXDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Move pps_freq/stabil into ntp_data
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-20-?=
 =?utf-8?q?2d52f4e13476=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-20-2?=
 =?utf-8?q?d52f4e13476=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788388745.1442.9605710777454835774.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     12850b46583440911a2789355d25d8eb9fe8157d
Gitweb:        https://git.kernel.org/tip/12850b46583440911a2789355d25d8eb9fe8157d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:41 +02:00

ntp: Move pps_freq/stabil into ntp_data

Continue the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-20-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index bebff6c..533367d 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -46,6 +46,8 @@
  * @pps_fbase:		PPS beginning of the last freq interval
  * @pps_shift:		PPS current interval duration in seconds (shift value)
  * @pps_intcnt:		PPS interval counter
+ * @pps_freq:		PPS frequency offset in scaled ns/s
+ * @pps_stabil:		PPS current stability in scaled ns/s
  *
  * Protected by the timekeeping locks.
  */
@@ -71,6 +73,8 @@ struct ntp_data {
 	struct timespec64	pps_fbase;
 	int			pps_shift;
 	int			pps_intcnt;
+	s64			pps_freq;
+	long			pps_stabil;
 #endif
 };
 
@@ -106,9 +110,6 @@ static struct ntp_data tk_ntp_data = {
 				   intervals to decrease it */
 #define PPS_MAXWANDER	100000	/* max PPS freq wander (ns/s) */
 
-static s64 pps_freq;		/* frequency offset (scaled ns/s) */
-static long pps_stabil;		/* current stability (scaled ns/s) */
-
 /*
  * PPS signal quality monitors
  */
@@ -148,7 +149,7 @@ static inline void pps_clear(struct ntp_data *ntpdata)
 	ntpdata->pps_tf[1] = 0;
 	ntpdata->pps_tf[2] = 0;
 	ntpdata->pps_fbase.tv_sec = ntpdata->pps_fbase.tv_nsec = 0;
-	pps_freq = 0;
+	ntpdata->pps_freq = 0;
 }
 
 /*
@@ -166,9 +167,9 @@ static inline void pps_dec_valid(struct ntp_data *ntpdata)
 	}
 }
 
-static inline void pps_set_freq(s64 freq)
+static inline void pps_set_freq(struct ntp_data *ntpdata)
 {
-	pps_freq = freq;
+	ntpdata->pps_freq = ntpdata->time_freq;
 }
 
 static inline bool is_error_status(int status)
@@ -196,13 +197,13 @@ static inline bool is_error_status(int status)
 
 static inline void pps_fill_timex(struct ntp_data *ntpdata, struct __kernel_timex *txc)
 {
-	txc->ppsfreq	   = shift_right((pps_freq >> PPM_SCALE_INV_SHIFT) *
+	txc->ppsfreq	   = shift_right((ntpdata->pps_freq >> PPM_SCALE_INV_SHIFT) *
 					 PPM_SCALE_INV, NTP_SCALE_SHIFT);
 	txc->jitter	   = ntpdata->pps_jitter;
 	if (!(ntpdata->time_status & STA_NANO))
 		txc->jitter = ntpdata->pps_jitter / NSEC_PER_USEC;
 	txc->shift	   = ntpdata->pps_shift;
-	txc->stabil	   = pps_stabil;
+	txc->stabil	   = ntpdata->pps_stabil;
 	txc->jitcnt	   = pps_jitcnt;
 	txc->calcnt	   = pps_calcnt;
 	txc->errcnt	   = pps_errcnt;
@@ -219,7 +220,7 @@ static inline s64 ntp_offset_chunk(struct ntp_data *ntpdata, s64 offset)
 static inline void pps_reset_freq_interval(struct ntp_data *ntpdata) {}
 static inline void pps_clear(struct ntp_data *ntpdata) {}
 static inline void pps_dec_valid(struct ntp_data *ntpdata) {}
-static inline void pps_set_freq(s64 freq) {}
+static inline void pps_set_freq(struct ntp_data *ntpdata) {}
 
 static inline bool is_error_status(int status)
 {
@@ -727,7 +728,7 @@ static inline void process_adjtimex_modes(struct ntp_data *ntpdata, const struct
 		ntpdata->time_freq = min(ntpdata->time_freq, MAXFREQ_SCALED);
 		ntpdata->time_freq = max(ntpdata->time_freq, -MAXFREQ_SCALED);
 		/* Update pps_freq */
-		pps_set_freq(ntpdata->time_freq);
+		pps_set_freq(ntpdata);
 	}
 
 	if (txc->modes & ADJ_MAXERROR)
@@ -956,8 +957,8 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 	 */
 	ftemp = div_s64(((s64)(-freq_norm.nsec)) << NTP_SCALE_SHIFT,
 			freq_norm.sec);
-	delta = shift_right(ftemp - pps_freq, NTP_SCALE_SHIFT);
-	pps_freq = ftemp;
+	delta = shift_right(ftemp - ntpdata->pps_freq, NTP_SCALE_SHIFT);
+	ntpdata->pps_freq = ftemp;
 	if (delta > PPS_MAXWANDER || delta < -PPS_MAXWANDER) {
 		printk_deferred(KERN_WARNING "hardpps: PPSWANDER: change=%ld\n", delta);
 		ntpdata->time_status |= STA_PPSWANDER;
@@ -975,12 +976,12 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 	delta_mod = delta;
 	if (delta_mod < 0)
 		delta_mod = -delta_mod;
-	pps_stabil += (div_s64(((s64)delta_mod) << (NTP_SCALE_SHIFT - SHIFT_USEC),
-			       NSEC_PER_USEC) - pps_stabil) >> PPS_INTMIN;
+	ntpdata->pps_stabil += (div_s64(((s64)delta_mod) << (NTP_SCALE_SHIFT - SHIFT_USEC),
+				     NSEC_PER_USEC) - ntpdata->pps_stabil) >> PPS_INTMIN;
 
 	/* If enabled, the system clock frequency is updated */
 	if ((ntpdata->time_status & STA_PPSFREQ) && !(ntpdata->time_status & STA_FREQHOLD)) {
-		ntpdata->time_freq = pps_freq;
+		ntpdata->time_freq = ntpdata->pps_freq;
 		ntp_update_frequency(ntpdata);
 	}
 

