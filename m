Return-Path: <linux-tip-commits+bounces-2330-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7725D98DF97
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2132D28056D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD4C1D172D;
	Wed,  2 Oct 2024 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e1DSPeE5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lscqaGY+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F851D0F74;
	Wed,  2 Oct 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883896; cv=none; b=LAD1hLeeSOYZWhO/4q5oRLSt0hWIs/y1iTCliUUIBHVGGuQjTkPpJ30tRWOaBuUScbar5Q/VPekoYP6pERBJjWNUvoPKhROHRKRWD9olLcJLTcISEIwfC3vO+Uyg8o9FNiHhYEeDiWV3mU5+oK65oFLJSRIBvCfTSZpEgksoAjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883896; c=relaxed/simple;
	bh=ZwU1+WZ4rBxbr0wEzpqBUQ9k/BXOv9IqywC5siOX2Z4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VerZ3wYguXeyTelmxCCxyF+adx20kXYlnHobJL63vpT7qFBHn8CIcwonb992fbL8zYdyIWhsDTnmwFKteMdErzVQ1ObehamYNCqA/qLq5DAQ7GKd1vPvBEC3rkNALyI9Hu/i96j7Mi6zVBhjp6OXrrcvXeanX8iCZWy5dU4eAk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e1DSPeE5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lscqaGY+; arc=none smtp.client-ip=193.142.43.55
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
	bh=VuCmjICvHvIovldzENZRG0eFmLQ7R81cXqIHk5WPltU=;
	b=e1DSPeE5gB1H15pYaSfCM4kNyPjvwTY9ct6YWbj1ZvNTwlJiEJPeRjuXE9n1HWd6Oe/b4v
	TtKkjz1qw5lLaZL4HOMMoNePYIlStJnQ1sF0EoC69bY2a7n6J+a3+/eRHb2VLabI8oKRun
	fh6zAHfWddDlXf6CVBLXwGpmZ3nGk/v8KU69Bj/Ycj63aQqWfs7w7n+/ROdPel8ROsliRi
	VU/Gu1cDfZw496sw2m6CRVLplQrvEMN+FL9ieu/ndRCyUSGo+Kcy/mLN1LS3PeDvna3Z3v
	BfLApZGUdkyvpwaph1fCEL8pOYBtAh0Gqhfg8hnAMrxYQPHUYxwRVQjOZMXGkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VuCmjICvHvIovldzENZRG0eFmLQ7R81cXqIHk5WPltU=;
	b=lscqaGY+GCJyMlmRLFMKv9dWh1DRrhT+oR1ek2AVRxYqyMWFtk88E1+3Q5LJ2osSdRFVjM
	A1jT1C8q/TUMvrCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Move time_adj/ntp_tick_adj into ntp_data
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-13-?=
 =?utf-8?q?2d52f4e13476=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-13-2?=
 =?utf-8?q?d52f4e13476=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788389095.1442.9355659598673486962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bb6400a298d8bab8074a9e78ae778ce7b238493d
Gitweb:        https://git.kernel.org/tip/bb6400a298d8bab8074a9e78ae778ce7b238493d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:40 +02:00

ntp: Move time_adj/ntp_tick_adj into ntp_data

Continue the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-13-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 5bce6a4..f9c2f26 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -36,6 +36,8 @@
  * @time_esterror:	Estimated error in microseconds holding NTP dispersion
  * @time_freq:		Frequency offset scaled nsecs/secs
  * @time_reftime:	Time at last adjustment in seconds
+ * @time_adjust:	Adjustment value
+ * @ntp_tick_adj:	Constant boot-param configurable NTP tick adjustment (upscaled)
  *
  * Protected by the timekeeping locks.
  */
@@ -51,6 +53,8 @@ struct ntp_data {
 	long			time_esterror;
 	s64			time_freq;
 	time64_t		time_reftime;
+	long			time_adjust;
+	s64			ntp_tick_adj;
 };
 
 static struct ntp_data tk_ntp_data = {
@@ -68,11 +72,6 @@ static struct ntp_data tk_ntp_data = {
 	(((MAX_TICKADJ * NSEC_PER_USEC) << NTP_SCALE_SHIFT) / NTP_INTERVAL_FREQ)
 #define MAX_TAI_OFFSET		100000
 
-static long			time_adjust;
-
-/* constant (boot-param configurable) NTP tick adjustment (upscaled)	*/
-static s64			ntp_tick_adj;
-
 /* second value of the next pending leapsecond, or TIME64_MAX if no leap */
 static time64_t			ntp_next_leap_sec = TIME64_MAX;
 
@@ -242,7 +241,7 @@ static void ntp_update_frequency(struct ntp_data *ntpdata)
 
 	second_length		 = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ) << NTP_SCALE_SHIFT;
 
-	second_length		+= ntp_tick_adj;
+	second_length		+= ntpdata->ntp_tick_adj;
 	second_length		+= ntpdata->time_freq;
 
 	new_base		 = div_u64(second_length, NTP_INTERVAL_FREQ);
@@ -322,7 +321,7 @@ static void ntp_update_offset(struct ntp_data *ntpdata, long offset)
 static void __ntp_clear(struct ntp_data *ntpdata)
 {
 	/* Stop active adjtime() */
-	time_adjust		= 0;
+	ntpdata->time_adjust	= 0;
 	ntpdata->time_status	|= STA_UNSYNC;
 	ntpdata->time_maxerror	= NTP_PHASE_LIMIT;
 	ntpdata->time_esterror	= NTP_PHASE_LIMIT;
@@ -450,24 +449,24 @@ int second_overflow(time64_t secs)
 	/* Check PPS signal */
 	pps_dec_valid(ntpdata);
 
-	if (!time_adjust)
+	if (!ntpdata->time_adjust)
 		goto out;
 
-	if (time_adjust > MAX_TICKADJ) {
-		time_adjust -= MAX_TICKADJ;
+	if (ntpdata->time_adjust > MAX_TICKADJ) {
+		ntpdata->time_adjust -= MAX_TICKADJ;
 		ntpdata->tick_length += MAX_TICKADJ_SCALED;
 		goto out;
 	}
 
-	if (time_adjust < -MAX_TICKADJ) {
-		time_adjust += MAX_TICKADJ;
+	if (ntpdata->time_adjust < -MAX_TICKADJ) {
+		ntpdata->time_adjust += MAX_TICKADJ;
 		ntpdata->tick_length -= MAX_TICKADJ_SCALED;
 		goto out;
 	}
 
-	ntpdata->tick_length += (s64)(time_adjust * NSEC_PER_USEC / NTP_INTERVAL_FREQ)
+	ntpdata->tick_length += (s64)(ntpdata->time_adjust * NSEC_PER_USEC / NTP_INTERVAL_FREQ)
 				<< NTP_SCALE_SHIFT;
-	time_adjust = 0;
+	ntpdata->time_adjust = 0;
 
 out:
 	return leap;
@@ -758,15 +757,15 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 	int result;
 
 	if (txc->modes & ADJ_ADJTIME) {
-		long save_adjust = time_adjust;
+		long save_adjust = ntpdata->time_adjust;
 
 		if (!(txc->modes & ADJ_OFFSET_READONLY)) {
 			/* adjtime() is independent from ntp_adjtime() */
-			time_adjust = txc->offset;
+			ntpdata->time_adjust = txc->offset;
 			ntp_update_frequency(ntpdata);
 
 			audit_ntp_set_old(ad, AUDIT_NTP_ADJUST,	save_adjust);
-			audit_ntp_set_new(ad, AUDIT_NTP_ADJUST,	time_adjust);
+			audit_ntp_set_new(ad, AUDIT_NTP_ADJUST,	ntpdata->time_adjust);
 		}
 		txc->offset = save_adjust;
 	} else {
@@ -1003,7 +1002,7 @@ static void hardpps_update_phase(struct ntp_data *ntpdata, long error)
 		ntpdata->time_offset = div_s64(((s64)correction) << NTP_SCALE_SHIFT,
 					       NTP_INTERVAL_FREQ);
 		/* Cancel running adjtime() */
-		time_adjust = 0;
+		ntpdata->time_adjust = 0;
 	}
 	/* Update jitter */
 	pps_jitter += (jitter - pps_jitter) >> PPS_INTMIN;
@@ -1075,11 +1074,11 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 
 static int __init ntp_tick_adj_setup(char *str)
 {
-	int rc = kstrtos64(str, 0, &ntp_tick_adj);
+	int rc = kstrtos64(str, 0, &tk_ntp_data.ntp_tick_adj);
 	if (rc)
 		return rc;
 
-	ntp_tick_adj <<= NTP_SCALE_SHIFT;
+	tk_ntp_data.ntp_tick_adj <<= NTP_SCALE_SHIFT;
 	return 1;
 }
 

