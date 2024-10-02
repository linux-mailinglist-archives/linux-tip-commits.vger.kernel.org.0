Return-Path: <linux-tip-commits+bounces-2329-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8417C98DFCB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC0FB29AA4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F21E1D1516;
	Wed,  2 Oct 2024 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oy7mt0G3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="36kIw1aG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0241D0F69;
	Wed,  2 Oct 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883896; cv=none; b=lg4hMolRDmxYxKsGYOaanWQHKrzC3yF+mSchKmMr5vZ02E+fzLi/lM+Uzh2aA6VncIzeE3hlnUR6G26XZdbxUU5L7BCsALjCTWfW/JZ6Cad9dIjIqnnTi9NpUiaip5Ejta+0VfaVMBwkvG3QZFlPCsdFtJdcOJQw0eNsFMHZ+7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883896; c=relaxed/simple;
	bh=2T2zhcsr3HcIVy4114yAM6GQcK+KcG3YS4xse/xbjCc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MUfR6QseMUtyMljDUpou+Z0gky9FupD9879zJbDeCwtXOem0aapb89TaQ7fLqSKKp7ls+Fa8NjKmn/r3iOHCo/sMcNH6sVtlRsVx+nx/nb3Eo/UKzOsM3wsw+HwlyVkJNop/neMjw0gvpc3B8alFSpt8+cJmQwr978PKYiKu2qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oy7mt0G3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=36kIw1aG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:44:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=phZfWW+E1xTlfwpA8UUGwqY55xJjV9zidnHjMd7VCIs=;
	b=Oy7mt0G3u6EAS50GUUeOuISneTacngsjkjoBLJizFr3KFD2+BSHs0wfFBpYYcBXiqfHQlC
	VbcpoAscIO4rwudSlHJUI7HJPaIrVefNu1dQ3LvybAit7tUf3HfuN2Q9LYQY8jByvzECnW
	J9LoqnVQLAFTQ5xmXL/slw/uMSTexv6dpBf8w513Hg5S4eZI+l+HRWZNLxJpvvBY5uM2P1
	DJ6ecBne7fxSUFm7/EXvw8fK4xdms47cc59FJtOb59Pyi6bIVQT2rFs0ow1YTA2olzTNDH
	r1NZSgywPaZeRjq5v6s8A7PVRQdjjvZo3WyPyu24gppxekEFyjm2W9CGVeIA4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=phZfWW+E1xTlfwpA8UUGwqY55xJjV9zidnHjMd7VCIs=;
	b=36kIw1aGgj7DsIE35OUUwxh/NKqRFm2tUsHt4kGfOzoqnB4dxssJVs67ngNUK546Tqj/9a
	uVd+P+F9y67RSdCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Move time_freq/reftime into ntp_data
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-12-?=
 =?utf-8?q?2d52f4e13476=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-12-2?=
 =?utf-8?q?d52f4e13476=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788389145.1442.11872325695984054433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     161b8ec281c38d8747f0ae033126208698cad33f
Gitweb:        https://git.kernel.org/tip/161b8ec281c38d8747f0ae033126208698cad33f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:40 +02:00

ntp: Move time_freq/reftime into ntp_data

Continue the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-12-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 67c4117..5bce6a4 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -34,6 +34,8 @@
  * @time_maxerror:	Maximum error in microseconds holding the NTP sync distance
  *			(NTP dispersion + delay / 2)
  * @time_esterror:	Estimated error in microseconds holding NTP dispersion
+ * @time_freq:		Frequency offset scaled nsecs/secs
+ * @time_reftime:	Time at last adjustment in seconds
  *
  * Protected by the timekeeping locks.
  */
@@ -47,6 +49,8 @@ struct ntp_data {
 	long			time_constant;
 	long			time_maxerror;
 	long			time_esterror;
+	s64			time_freq;
+	time64_t		time_reftime;
 };
 
 static struct ntp_data tk_ntp_data = {
@@ -64,12 +68,6 @@ static struct ntp_data tk_ntp_data = {
 	(((MAX_TICKADJ * NSEC_PER_USEC) << NTP_SCALE_SHIFT) / NTP_INTERVAL_FREQ)
 #define MAX_TAI_OFFSET		100000
 
-/* frequency offset (scaled nsecs/secs):				*/
-static s64			time_freq;
-
-/* time at last adjustment (secs):					*/
-static time64_t		time_reftime;
-
 static long			time_adjust;
 
 /* constant (boot-param configurable) NTP tick adjustment (upscaled)	*/
@@ -245,7 +243,7 @@ static void ntp_update_frequency(struct ntp_data *ntpdata)
 	second_length		 = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ) << NTP_SCALE_SHIFT;
 
 	second_length		+= ntp_tick_adj;
-	second_length		+= time_freq;
+	second_length		+= ntpdata->time_freq;
 
 	new_base		 = div_u64(second_length, NTP_INTERVAL_FREQ);
 
@@ -294,11 +292,11 @@ static void ntp_update_offset(struct ntp_data *ntpdata, long offset)
 	 * and in which mode (PLL or FLL).
 	 */
 	real_secs = __ktime_get_real_seconds();
-	secs = (long)(real_secs - time_reftime);
+	secs = (long)(real_secs - ntpdata->time_reftime);
 	if (unlikely(ntpdata->time_status & STA_FREQHOLD))
 		secs = 0;
 
-	time_reftime = real_secs;
+	ntpdata->time_reftime = real_secs;
 
 	offset64    = offset;
 	freq_adj    = ntp_update_offset_fll(ntpdata, offset64, secs);
@@ -314,9 +312,9 @@ static void ntp_update_offset(struct ntp_data *ntpdata, long offset)
 	freq_adj    += (offset64 * secs) <<
 			(NTP_SCALE_SHIFT - 2 * (SHIFT_PLL + 2 + ntpdata->time_constant));
 
-	freq_adj    = min(freq_adj + time_freq, MAXFREQ_SCALED);
+	freq_adj    = min(freq_adj + ntpdata->time_freq, MAXFREQ_SCALED);
 
-	time_freq   = max(freq_adj, -MAXFREQ_SCALED);
+	ntpdata->time_freq   = max(freq_adj, -MAXFREQ_SCALED);
 
 	ntpdata->time_offset = div_s64(offset64 << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
 }
@@ -696,7 +694,7 @@ static inline void process_adj_status(struct ntp_data *ntpdata, const struct __k
 	 * reference time to current time.
 	 */
 	if (!(ntpdata->time_status & STA_PLL) && (txc->status & STA_PLL))
-		time_reftime = __ktime_get_real_seconds();
+		ntpdata->time_reftime = __ktime_get_real_seconds();
 
 	/* only set allowed bits */
 	ntpdata->time_status &= STA_RONLY;
@@ -716,11 +714,11 @@ static inline void process_adjtimex_modes(struct ntp_data *ntpdata, const struct
 		ntpdata->time_status &= ~STA_NANO;
 
 	if (txc->modes & ADJ_FREQUENCY) {
-		time_freq = txc->freq * PPM_SCALE;
-		time_freq = min(time_freq, MAXFREQ_SCALED);
-		time_freq = max(time_freq, -MAXFREQ_SCALED);
+		ntpdata->time_freq = txc->freq * PPM_SCALE;
+		ntpdata->time_freq = min(ntpdata->time_freq, MAXFREQ_SCALED);
+		ntpdata->time_freq = max(ntpdata->time_freq, -MAXFREQ_SCALED);
 		/* Update pps_freq */
-		pps_set_freq(time_freq);
+		pps_set_freq(ntpdata->time_freq);
 	}
 
 	if (txc->modes & ADJ_MAXERROR)
@@ -775,7 +773,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 		/* If there are input parameters, then process them: */
 		if (txc->modes) {
 			audit_ntp_set_old(ad, AUDIT_NTP_OFFSET,	ntpdata->time_offset);
-			audit_ntp_set_old(ad, AUDIT_NTP_FREQ,	time_freq);
+			audit_ntp_set_old(ad, AUDIT_NTP_FREQ,	ntpdata->time_freq);
 			audit_ntp_set_old(ad, AUDIT_NTP_STATUS,	ntpdata->time_status);
 			audit_ntp_set_old(ad, AUDIT_NTP_TAI,	*time_tai);
 			audit_ntp_set_old(ad, AUDIT_NTP_TICK,	ntpdata->tick_usec);
@@ -783,7 +781,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 			process_adjtimex_modes(ntpdata, txc, time_tai);
 
 			audit_ntp_set_new(ad, AUDIT_NTP_OFFSET,	ntpdata->time_offset);
-			audit_ntp_set_new(ad, AUDIT_NTP_FREQ,	time_freq);
+			audit_ntp_set_new(ad, AUDIT_NTP_FREQ,	ntpdata->time_freq);
 			audit_ntp_set_new(ad, AUDIT_NTP_STATUS,	ntpdata->time_status);
 			audit_ntp_set_new(ad, AUDIT_NTP_TAI,	*time_tai);
 			audit_ntp_set_new(ad, AUDIT_NTP_TICK,	ntpdata->tick_usec);
@@ -798,7 +796,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 	if (is_error_status(ntpdata->time_status))
 		result = TIME_ERROR;
 
-	txc->freq	   = shift_right((time_freq >> PPM_SCALE_INV_SHIFT) *
+	txc->freq	   = shift_right((ntpdata->time_freq >> PPM_SCALE_INV_SHIFT) *
 					 PPM_SCALE_INV, NTP_SCALE_SHIFT);
 	txc->maxerror	   = ntpdata->time_maxerror;
 	txc->esterror	   = ntpdata->time_esterror;
@@ -973,7 +971,7 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 
 	/* If enabled, the system clock frequency is updated */
 	if ((ntpdata->time_status & STA_PPSFREQ) && !(ntpdata->time_status & STA_FREQHOLD)) {
-		time_freq = pps_freq;
+		ntpdata->time_freq = pps_freq;
 		ntp_update_frequency(ntpdata);
 	}
 

