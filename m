Return-Path: <linux-tip-commits+bounces-2331-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2932998DF9A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1091C24F88
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B30E1D1E62;
	Wed,  2 Oct 2024 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tCnFv77N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HmD3MzdG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C51D12EF;
	Wed,  2 Oct 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883897; cv=none; b=os4v4tkw6xgvNg1CQKoPfNjbLC+WDVO5tpUCOBFClDE2psNkUs3LK3VgU4T8OZFF959jiefAdv2D/LYamL1GeoVfnNu8Rxf9xmC4wo6scuIhmleQmyEIc2QJm1obkBYgi17oqEj+h8bd3OxvqSx/iksffO/bk0OiFLzRQVWbxO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883897; c=relaxed/simple;
	bh=9Me2L78aWDCE2i5pNdn77OXKJ28c0sIyezCIjOmG/jI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PMO2eV28UnQPtiQPgPprjJtGLmSOWQdpJzhDBJhSCdLc2CgO4In1xO331Xd5TM8cEp+hTdSVQLL9Sqgk+tZft0h9QMkT4RcwXGElZsu97pFuB+3UMF0sOfgp+HsWVBNeeeQcdllqVmrROmylCHSQagqm8VP7nN+tdOgWIMjGOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tCnFv77N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HmD3MzdG; arc=none smtp.client-ip=193.142.43.55
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
	bh=cC7n8ZLDYt9hV4/ZduvqAO3cWvrGhgHDv9duB1MamlQ=;
	b=tCnFv77NkfsmJTq2cvmijpNU8Y4JbyYhIDpmjbjQF/Gzv21D3t9C43ZUgsmAuEMjEMEpbM
	uL0icLn7sfRIC/5ZBMUxydi730CkBkc9z8llk+8PyAutjm0eOiLbZTsvzS7SBN9cyawdSF
	MJJj8llybXYK10VWYp/QJHrHsUdrK1Au5Wg8ljX1HIHJ4iWSyAlZ9bRZEsSyABsMnC37EU
	ySS8+o6wga1X/e/31Ya4+PfCkSMQYVw45tzZl2RzIfMQhL63nRbJaXNyXIVgwPx3H/RlCP
	AXBI6S7oG5eV/PkFoYtWlRhWq///iPUiQmdsfW/ALz3COXc7C3IP/tdr+6Gm/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883893;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cC7n8ZLDYt9hV4/ZduvqAO3cWvrGhgHDv9duB1MamlQ=;
	b=HmD3MzdGxAQgNlkXlOhILT15IRVvms6k3QX6XDXxrwf1UCHA9H5Sc9tQlkzmGWkrrdK4M2
	3Sby76YeG/ifsmBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Move time_offset/constant into ntp_data
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-10-?=
 =?utf-8?q?2d52f4e13476=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-10-2?=
 =?utf-8?q?d52f4e13476=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788389239.1442.4098250649411609386.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d51435548e4c406395d7cc479820a0a962d65af6
Gitweb:        https://git.kernel.org/tip/d51435548e4c406395d7cc479820a0a962d65af6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:39 +02:00

ntp: Move time_offset/constant into ntp_data

Continue the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-10-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 49 ++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 42c039a..5a6c325 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -29,6 +29,8 @@
  * @tick_length_base:	Base value for @tick_length
  * @time_state:		State of the clock synchronization
  * @time_status:	Clock status bits
+ * @time_offset:	Time adjustment in nanoseconds
+ * @time_constant:	PLL time constant
  *
  * Protected by the timekeeping locks.
  */
@@ -38,12 +40,15 @@ struct ntp_data {
 	u64			tick_length_base;
 	int			time_state;
 	int			time_status;
+	s64			time_offset;
+	long			time_constant;
 };
 
 static struct ntp_data tk_ntp_data = {
 	.tick_usec		= USER_TICK_USEC,
 	.time_state		= TIME_OK,
 	.time_status		= STA_UNSYNC,
+	.time_constant		= 2,
 };
 
 #define SECS_PER_DAY		86400
@@ -59,12 +64,6 @@ static struct ntp_data tk_ntp_data = {
  * estimated error = NTP dispersion.
  */
 
-/* time adjustment (nsecs):						*/
-static s64			time_offset;
-
-/* pll time constant:							*/
-static long			time_constant = 2;
-
 /* maximum error (usecs):						*/
 static long			time_maxerror = NTP_PHASE_LIMIT;
 
@@ -128,7 +127,7 @@ static inline s64 ntp_offset_chunk(struct ntp_data *ntpdata, s64 offset)
 	if (ntpdata->time_status & STA_PPSTIME && ntpdata->time_status & STA_PPSSIGNAL)
 		return offset;
 	else
-		return shift_right(offset, SHIFT_PLL + time_constant);
+		return shift_right(offset, SHIFT_PLL + ntpdata->time_constant);
 }
 
 static inline void pps_reset_freq_interval(void)
@@ -211,9 +210,9 @@ static inline void pps_fill_timex(struct ntp_data *ntpdata, struct __kernel_time
 
 #else /* !CONFIG_NTP_PPS */
 
-static inline s64 ntp_offset_chunk(struct ntp_data *ntp, s64 offset)
+static inline s64 ntp_offset_chunk(struct ntp_data *ntpdata, s64 offset)
 {
-	return shift_right(offset, SHIFT_PLL + time_constant);
+	return shift_right(offset, SHIFT_PLL + ntpdata->time_constant);
 }
 
 static inline void pps_reset_freq_interval(void) {}
@@ -315,17 +314,17 @@ static void ntp_update_offset(struct ntp_data *ntpdata, long offset)
 	 * sampling rate (e.g. intermittent network connection)
 	 * to avoid instability.
 	 */
-	if (unlikely(secs > 1 << (SHIFT_PLL + 1 + time_constant)))
-		secs = 1 << (SHIFT_PLL + 1 + time_constant);
+	if (unlikely(secs > 1 << (SHIFT_PLL + 1 + ntpdata->time_constant)))
+		secs = 1 << (SHIFT_PLL + 1 + ntpdata->time_constant);
 
 	freq_adj    += (offset64 * secs) <<
-			(NTP_SCALE_SHIFT - 2 * (SHIFT_PLL + 2 + time_constant));
+			(NTP_SCALE_SHIFT - 2 * (SHIFT_PLL + 2 + ntpdata->time_constant));
 
 	freq_adj    = min(freq_adj + time_freq, MAXFREQ_SCALED);
 
 	time_freq   = max(freq_adj, -MAXFREQ_SCALED);
 
-	time_offset = div_s64(offset64 << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
+	ntpdata->time_offset = div_s64(offset64 << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
 }
 
 static void __ntp_clear(struct ntp_data *ntpdata)
@@ -339,7 +338,7 @@ static void __ntp_clear(struct ntp_data *ntpdata)
 	ntp_update_frequency(ntpdata);
 
 	ntpdata->tick_length	= ntpdata->tick_length_base;
-	time_offset		= 0;
+	ntpdata->time_offset	= 0;
 
 	ntp_next_leap_sec = TIME64_MAX;
 	/* Clear PPS state variables */
@@ -452,8 +451,8 @@ int second_overflow(time64_t secs)
 	/* Compute the phase adjustment for the next second */
 	ntpdata->tick_length	 = ntpdata->tick_length_base;
 
-	delta			 = ntp_offset_chunk(ntpdata, time_offset);
-	time_offset		-= delta;
+	delta			 = ntp_offset_chunk(ntpdata, ntpdata->time_offset);
+	ntpdata->time_offset	-= delta;
 	ntpdata->tick_length	+= delta;
 
 	/* Check PPS signal */
@@ -737,10 +736,10 @@ static inline void process_adjtimex_modes(struct ntp_data *ntpdata, const struct
 		time_esterror = clamp(txc->esterror, 0, NTP_PHASE_LIMIT);
 
 	if (txc->modes & ADJ_TIMECONST) {
-		time_constant = clamp(txc->constant, 0, MAXTC);
+		ntpdata->time_constant = clamp(txc->constant, 0, MAXTC);
 		if (!(ntpdata->time_status & STA_NANO))
-			time_constant += 4;
-		time_constant = clamp(time_constant, 0, MAXTC);
+			ntpdata->time_constant += 4;
+		ntpdata->time_constant = clamp(ntpdata->time_constant, 0, MAXTC);
 	}
 
 	if (txc->modes & ADJ_TAI && txc->constant >= 0 && txc->constant <= MAX_TAI_OFFSET)
@@ -781,7 +780,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 	} else {
 		/* If there are input parameters, then process them: */
 		if (txc->modes) {
-			audit_ntp_set_old(ad, AUDIT_NTP_OFFSET,	time_offset);
+			audit_ntp_set_old(ad, AUDIT_NTP_OFFSET,	ntpdata->time_offset);
 			audit_ntp_set_old(ad, AUDIT_NTP_FREQ,	time_freq);
 			audit_ntp_set_old(ad, AUDIT_NTP_STATUS,	ntpdata->time_status);
 			audit_ntp_set_old(ad, AUDIT_NTP_TAI,	*time_tai);
@@ -789,15 +788,14 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 
 			process_adjtimex_modes(ntpdata, txc, time_tai);
 
-			audit_ntp_set_new(ad, AUDIT_NTP_OFFSET,	time_offset);
+			audit_ntp_set_new(ad, AUDIT_NTP_OFFSET,	ntpdata->time_offset);
 			audit_ntp_set_new(ad, AUDIT_NTP_FREQ,	time_freq);
 			audit_ntp_set_new(ad, AUDIT_NTP_STATUS,	ntpdata->time_status);
 			audit_ntp_set_new(ad, AUDIT_NTP_TAI,	*time_tai);
 			audit_ntp_set_new(ad, AUDIT_NTP_TICK,	ntpdata->tick_usec);
 		}
 
-		txc->offset = shift_right(time_offset * NTP_INTERVAL_FREQ,
-				  NTP_SCALE_SHIFT);
+		txc->offset = shift_right(ntpdata->time_offset * NTP_INTERVAL_FREQ, NTP_SCALE_SHIFT);
 		if (!(ntpdata->time_status & STA_NANO))
 			txc->offset = (u32)txc->offset / NSEC_PER_USEC;
 	}
@@ -811,7 +809,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 	txc->maxerror	   = time_maxerror;
 	txc->esterror	   = time_esterror;
 	txc->status	   = ntpdata->time_status;
-	txc->constant	   = time_constant;
+	txc->constant	   = ntpdata->time_constant;
 	txc->precision	   = 1;
 	txc->tolerance	   = MAXFREQ_SCALED / PPM_SCALE;
 	txc->tick	   = ntpdata->tick_usec;
@@ -1010,7 +1008,8 @@ static void hardpps_update_phase(struct ntp_data *ntpdata, long error)
 		pps_jitcnt++;
 	} else if (ntpdata->time_status & STA_PPSTIME) {
 		/* Correct the time using the phase offset */
-		time_offset = div_s64(((s64)correction) << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
+		ntpdata->time_offset = div_s64(((s64)correction) << NTP_SCALE_SHIFT,
+					       NTP_INTERVAL_FREQ);
 		/* Cancel running adjtime() */
 		time_adjust = 0;
 	}

