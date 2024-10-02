Return-Path: <linux-tip-commits+bounces-2324-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CE698DF8A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D531F23D61
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC861D0E3F;
	Wed,  2 Oct 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ICVlBqum";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VcFK6uHK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E636D1D0DE9;
	Wed,  2 Oct 2024 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883892; cv=none; b=aOxzvdPJTwRrSKSxFYaQWRBTKSYVnnyvvv5DUDXQZ7OTsJMnqgsxEA6t2j5JCsSi3vdALNFK0q2CbiM94shr21AYg+ig0IntLsh8+XCBo4AUM7K9bK7DnR3wDYmSujjZNl326G5hTfMvig5OXua6rmEeqxsXaaSk15F0xyT76Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883892; c=relaxed/simple;
	bh=OMjxCYuARm/i1ZfiErF5M4NjP9kYNzGwnW7VcrqUKLo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ag4OlYyruiYrSw7gdNIrfjcjoLXJOjDg7+2otrBqCfdh5VHqlEO3Z56hFlURTPmIw6L829Tvk81cLRI2ZV34+5ZjNnV0uRLZgNn7Obttj6yUQoksk+nksf4kh6iVMejwKLU0taRiPt1Th8ZT+RX9ARlChShrWjkMQ0ZEUqVLGlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ICVlBqum; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VcFK6uHK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:44:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883889;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E92cHh0Dnae9gnONMkiD7E3xkBfmoe8wKyOLRg/X7A0=;
	b=ICVlBqum5kce58acZzTcwleXDKvcHIheHEztU613gicCgPKQQcxB/KHmKcqZ3HiEh80LNM
	dy9WOpr2qjrwer6Je12K08HXw5pLUQ4wkxALGTGsMp/A+ojbEOOc6nWBy5o+BgXw38gxm9
	tYJrlgsiTG5lxoLlHL8IwnybA4za68Lwp4Q6uEKw46kBo9I8wmPE59IKKPnKMpGClBfHo7
	8fUcq8xDBliOcMOA5p/auP7+BnZrmaeGkphqEBoJErukLqYLTsEf8Gf0UGYE2BIkR/3WQC
	8aRSTtDOr5Tisw9T6OLtL7GoquCKO39S7tApg+gCfrhE0I8o7pbWebQWth1jXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883889;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E92cHh0Dnae9gnONMkiD7E3xkBfmoe8wKyOLRg/X7A0=;
	b=VcFK6uHKa7m+U56YWbHN0bemnoOrgofEmATSEGssvPayC6T5ph2S2ng+23uvCSYMz89LJO
	vReE6DZ4LNWBwTCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Move pps_fbase into ntp_data
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-18-?=
 =?utf-8?q?2d52f4e13476=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-18-2?=
 =?utf-8?q?d52f4e13476=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788388850.1442.15597261960243803321.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     db45e9bce8df2396740c0c03906ad6ed63948a8b
Gitweb:        https://git.kernel.org/tip/db45e9bce8df2396740c0c03906ad6ed63948a8b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:40 +02:00

ntp: Move pps_fbase into ntp_data

Continue the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-18-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 576f86a..4bde69c 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -43,6 +43,7 @@
  * @pps_valid:		PPS signal watchdog counter
  * @pps_tf:		PPS phase median filter
  * @pps_jitter:		PPS current jitter in nanoseconds
+ * @pps_fbase:		PPS beginning of the last freq interval
  *
  * Protected by the timekeeping locks.
  */
@@ -65,6 +66,7 @@ struct ntp_data {
 	int			pps_valid;
 	long			pps_tf[3];
 	long			pps_jitter;
+	struct timespec64	pps_fbase;
 #endif
 };
 
@@ -100,7 +102,6 @@ static struct ntp_data tk_ntp_data = {
 				   intervals to decrease it */
 #define PPS_MAXWANDER	100000	/* max PPS freq wander (ns/s) */
 
-static struct timespec64 pps_fbase; /* beginning of the last freq interval */
 static int pps_shift;		/* current interval duration (s) (shift) */
 static int pps_intcnt;		/* interval counter */
 static s64 pps_freq;		/* frequency offset (scaled ns/s) */
@@ -144,7 +145,7 @@ static inline void pps_clear(struct ntp_data *ntpdata)
 	ntpdata->pps_tf[0] = 0;
 	ntpdata->pps_tf[1] = 0;
 	ntpdata->pps_tf[2] = 0;
-	pps_fbase.tv_sec = pps_fbase.tv_nsec = 0;
+	ntpdata->pps_fbase.tv_sec = ntpdata->pps_fbase.tv_nsec = 0;
 	pps_freq = 0;
 }
 
@@ -1045,13 +1046,13 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 	 * When called for the first time, just start the frequency
 	 * interval
 	 */
-	if (unlikely(pps_fbase.tv_sec == 0)) {
-		pps_fbase = *raw_ts;
+	if (unlikely(ntpdata->pps_fbase.tv_sec == 0)) {
+		ntpdata->pps_fbase = *raw_ts;
 		return;
 	}
 
 	/* Ok, now we have a base for frequency calculation */
-	freq_norm = pps_normalize_ts(timespec64_sub(*raw_ts, pps_fbase));
+	freq_norm = pps_normalize_ts(timespec64_sub(*raw_ts, ntpdata->pps_fbase));
 
 	/*
 	 * Check that the signal is in the range
@@ -1061,7 +1062,7 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 	    (freq_norm.nsec < -MAXFREQ * freq_norm.sec)) {
 		ntpdata->time_status |= STA_PPSJITTER;
 		/* Restart the frequency calibration interval */
-		pps_fbase = *raw_ts;
+		ntpdata->pps_fbase = *raw_ts;
 		printk_deferred(KERN_ERR "hardpps: PPSJITTER: bad pulse\n");
 		return;
 	}
@@ -1070,7 +1071,7 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 	if (freq_norm.sec >= (1 << pps_shift)) {
 		pps_calcnt++;
 		/* Restart the frequency calibration interval */
-		pps_fbase = *raw_ts;
+		ntpdata->pps_fbase = *raw_ts;
 		hardpps_update_freq(ntpdata, freq_norm);
 	}
 

