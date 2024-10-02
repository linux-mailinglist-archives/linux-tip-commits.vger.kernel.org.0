Return-Path: <linux-tip-commits+bounces-2334-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 590A598DF9F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15571F271E8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4E51D1F4A;
	Wed,  2 Oct 2024 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4lj5KIwu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eFG7of0J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A731D1517;
	Wed,  2 Oct 2024 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883898; cv=none; b=uM3TqpGPqrerubeytWzfVZstvJahx+G5WZvTnNJ1Cj9YQlZFLn3TyjyWpr3rIjCjNbwAI5lMFXbbNgkJAQ3XSk4rJrt0db4GV7nFTBNSUyvTuNWT3BrbmtaasFzMT9ptU6Fyfcag1iNrbzUxN3hdkTiQEorZmcJ4XWCyiHPu394=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883898; c=relaxed/simple;
	bh=ut/N+HQRdEb+VskrPpEE5zSmDpXCtEB+/zRcwngNaXU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M9qjcgsbSXq5SEi4OfSgEDZrCy1AhJSyaJYN6PQvSGlaYFTMMvi0fUrIEySXHV3llwhENBhvPDlnhNFtRDqAHd+6FeMYc+TQRnShEA7CPmGjReobiqUQX/4wYBRuVKG+C0KiFyGIdpwcgxtnefYzT9MT/JXgig2j2lXX5gNUnag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4lj5KIwu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eFG7of0J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:44:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883894;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOi8vpsK5bCIebMym2YIJFZ5FYfSbu8TZs0jqhARSTs=;
	b=4lj5KIwuAZc02QTNw4eRtYtdBklzaVItaPZeIEDxQRECeZgQz93KQj55UMqeGXCywPSZCv
	Yk2qWDB+CpCIYfs/ge267DGA5RSgAOq5wUZAlr78D9QziqJo7XWq8pAAO8tDQ54RYTa3Ob
	ARXYOksn8mumYEL9RwTcYDCcQ8eP/XIyoahhMAqHXlzcZeB/WJVIm8j+f39WOy7H2BQvTh
	KatHjrWCaZ9DmUDfHr60FVmZHdCuMWBEDHy+8NDh6wne240uRZ//cZwRwFGQImkIwlnE2Y
	z/1EvVMwYUqk2Fsf6XCtIUy3T6neP2smvEsX1nipUxZhXSApHWugJDD9hJmKSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883894;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOi8vpsK5bCIebMym2YIJFZ5FYfSbu8TZs0jqhARSTs=;
	b=eFG7of0JSNwHhBo04I3vihMQhe1oF54rZeYznVa5yCISpneu4TNuZpUXVCKoTTAeD9/J+/
	7Km9RmanzKnJUKCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Introduce struct ntp_data
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-7-2d52f4e13476@linutronix.de>
References:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-7-2d52f4e13476@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788389420.1442.14137586674389222703.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     68f66f97c5689825012877f58df65964056d4b5d
Gitweb:        https://git.kernel.org/tip/68f66f97c5689825012877f58df65964056d4b5d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:39 +02:00

ntp: Introduce struct ntp_data

All NTP data is held in static variables. That prevents the NTP code from
being reuasble for non-system time timekeepers, e.g. per PTP clock
timekeeping.

Introduce struct ntp_data and move tick_usec into it for a start.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-7-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 65 +++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 0bfd07d..f95f233 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -22,16 +22,19 @@
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
 
-
-/*
- * NTP timekeeping variables:
+/**
+ * struct ntp_data - Structure holding all NTP related state
+ * @tick_usec:		USER_HZ period in microseconds
  *
- * Note: All of the NTP state is protected by the timekeeping locks.
+ * Protected by the timekeeping locks.
  */
+struct ntp_data {
+	unsigned long		tick_usec;
+};
 
-
-/* USER_HZ period (usecs): */
-static unsigned long		tick_usec = USER_TICK_USEC;
+static struct ntp_data tk_ntp_data = {
+	.tick_usec		= USER_TICK_USEC,
+};
 
 static u64			tick_length;
 static u64			tick_length_base;
@@ -245,13 +248,11 @@ static inline void pps_fill_timex(struct __kernel_timex *txc)
  * Update tick_length and tick_length_base, based on tick_usec, ntp_tick_adj and
  * time_freq:
  */
-static void ntp_update_frequency(void)
+static void ntp_update_frequency(struct ntp_data *ntpdata)
 {
-	u64 second_length;
-	u64 new_base;
+	u64 second_length, new_base, tick_usec = (u64)ntpdata->tick_usec;
 
-	second_length		 = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ)
-						<< NTP_SCALE_SHIFT;
+	second_length		 = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ) << NTP_SCALE_SHIFT;
 
 	second_length		+= ntp_tick_adj;
 	second_length		+= time_freq;
@@ -330,10 +331,7 @@ static void ntp_update_offset(long offset)
 	time_offset = div_s64(offset64 << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
 }
 
-/**
- * ntp_clear - Clears the NTP state variables
- */
-void ntp_clear(void)
+static void __ntp_clear(struct ntp_data *ntpdata)
 {
 	/* Stop active adjtime() */
 	time_adjust	= 0;
@@ -341,7 +339,7 @@ void ntp_clear(void)
 	time_maxerror	= NTP_PHASE_LIMIT;
 	time_esterror	= NTP_PHASE_LIMIT;
 
-	ntp_update_frequency();
+	ntp_update_frequency(ntpdata);
 
 	tick_length	= tick_length_base;
 	time_offset	= 0;
@@ -351,6 +349,14 @@ void ntp_clear(void)
 	pps_clear();
 }
 
+/**
+ * ntp_clear - Clears the NTP state variables
+ */
+void ntp_clear(void)
+{
+	__ntp_clear(&tk_ntp_data);
+}
+
 
 u64 ntp_tick_length(void)
 {
@@ -706,7 +712,7 @@ static inline void process_adj_status(const struct __kernel_timex *txc)
 }
 
 
-static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
+static inline void process_adjtimex_modes(struct ntp_data *ntpdata, const struct __kernel_timex *txc,
 					  s32 *time_tai)
 {
 	if (txc->modes & ADJ_STATUS)
@@ -747,13 +753,12 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 		ntp_update_offset(txc->offset);
 
 	if (txc->modes & ADJ_TICK)
-		tick_usec = txc->tick;
+		ntpdata->tick_usec = txc->tick;
 
 	if (txc->modes & (ADJ_TICK|ADJ_FREQUENCY|ADJ_OFFSET))
-		ntp_update_frequency();
+		ntp_update_frequency(ntpdata);
 }
 
-
 /*
  * adjtimex() mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
@@ -761,6 +766,7 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 		  s32 *time_tai, struct audit_ntp_data *ad)
 {
+	struct ntp_data *ntpdata = &tk_ntp_data;
 	int result;
 
 	if (txc->modes & ADJ_ADJTIME) {
@@ -769,7 +775,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 		if (!(txc->modes & ADJ_OFFSET_READONLY)) {
 			/* adjtime() is independent from ntp_adjtime() */
 			time_adjust = txc->offset;
-			ntp_update_frequency();
+			ntp_update_frequency(ntpdata);
 
 			audit_ntp_set_old(ad, AUDIT_NTP_ADJUST,	save_adjust);
 			audit_ntp_set_new(ad, AUDIT_NTP_ADJUST,	time_adjust);
@@ -782,15 +788,15 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 			audit_ntp_set_old(ad, AUDIT_NTP_FREQ,	time_freq);
 			audit_ntp_set_old(ad, AUDIT_NTP_STATUS,	time_status);
 			audit_ntp_set_old(ad, AUDIT_NTP_TAI,	*time_tai);
-			audit_ntp_set_old(ad, AUDIT_NTP_TICK,	tick_usec);
+			audit_ntp_set_old(ad, AUDIT_NTP_TICK,	ntpdata->tick_usec);
 
-			process_adjtimex_modes(txc, time_tai);
+			process_adjtimex_modes(ntpdata, txc, time_tai);
 
 			audit_ntp_set_new(ad, AUDIT_NTP_OFFSET,	time_offset);
 			audit_ntp_set_new(ad, AUDIT_NTP_FREQ,	time_freq);
 			audit_ntp_set_new(ad, AUDIT_NTP_STATUS,	time_status);
 			audit_ntp_set_new(ad, AUDIT_NTP_TAI,	*time_tai);
-			audit_ntp_set_new(ad, AUDIT_NTP_TICK,	tick_usec);
+			audit_ntp_set_new(ad, AUDIT_NTP_TICK,	ntpdata->tick_usec);
 		}
 
 		txc->offset = shift_right(time_offset * NTP_INTERVAL_FREQ,
@@ -811,7 +817,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 	txc->constant	   = time_constant;
 	txc->precision	   = 1;
 	txc->tolerance	   = MAXFREQ_SCALED / PPM_SCALE;
-	txc->tick	   = tick_usec;
+	txc->tick	   = ntpdata->tick_usec;
 	txc->tai	   = *time_tai;
 
 	/* Fill PPS status fields */
@@ -932,7 +938,7 @@ static inline void pps_inc_freq_interval(void)
  * too long, the data are discarded.
  * Returns the difference between old and new frequency values.
  */
-static long hardpps_update_freq(struct pps_normtime freq_norm)
+static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime freq_norm)
 {
 	long delta, delta_mod;
 	s64 ftemp;
@@ -979,7 +985,7 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 	/* If enabled, the system clock frequency is updated */
 	if ((time_status & STA_PPSFREQ) && !(time_status & STA_FREQHOLD)) {
 		time_freq = pps_freq;
-		ntp_update_frequency();
+		ntp_update_frequency(ntpdata);
 	}
 
 	return delta;
@@ -1030,6 +1036,7 @@ static void hardpps_update_phase(long error)
 void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts)
 {
 	struct pps_normtime pts_norm, freq_norm;
+	struct ntp_data *ntpdata = &tk_ntp_data;
 
 	pts_norm = pps_normalize_ts(*phase_ts);
 
@@ -1070,7 +1077,7 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 		pps_calcnt++;
 		/* Restart the frequency calibration interval */
 		pps_fbase = *raw_ts;
-		hardpps_update_freq(freq_norm);
+		hardpps_update_freq(ntpdata, freq_norm);
 	}
 
 	hardpps_update_phase(pts_norm.nsec);

