Return-Path: <linux-tip-commits+bounces-2332-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FF298DF9B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C011280E8D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA95B1D1E69;
	Wed,  2 Oct 2024 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eLzClR+3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SFW1xwTN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468301D0F7C;
	Wed,  2 Oct 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883897; cv=none; b=kLxY7BNvw2r++TZQg14z8TxwstTym4Fg0NF+H/E6V6Ib/miJJf24qg5SInxH1TmBqxxD6kxz9rI6mnYgyRr70BN6Eu3DK66M8RIEyK/GTurqjyPXftKGz+CMSmjzSUIb3A+n4QAhhI+cDoghxZ69nbiyBsyU7Bhnuisbfas3R4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883897; c=relaxed/simple;
	bh=teOg+gc/M8PQ9cZoSO8k0LH7VkIkKWS/WVsjLc9MU30=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RqOnKBDMjpy0k+1FvHecNB7Nu0J1T0WbxB7m8aGbWAGf9pmS6qAlc3tvQDmtD2GzK6AGMDfgWFPtV9H22dJNZOk6RutuusVGapaQJ8aRoAj15sRTJU80ms9ZljebsTM3MdpFIMmFcnyfpOfgbS5s/FuRnyl+CtQZoXzHK3SqDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eLzClR+3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SFW1xwTN; arc=none smtp.client-ip=193.142.43.55
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
	bh=ycbKfRvYM6rHQcKARlQ2J19/u+JpHS8yfBgGi5Y5/N0=;
	b=eLzClR+3S2kYfD1S8RuiHkm5Qsj2/w3j/IwMvzaEOR5JHFZcUCGVz31kQAC3oCWWgto+sD
	8tqjGhWGZmktqoJdHyGFNgZDL0Yh2PBZ/GI6mAnzOkgS5S540QGVcesyU9C1qp0+WkTOVW
	nigVXs9XfLzFZbrigRU+DJJk8WIj/f5qzpBVGRyQt9RbmF/u3Yil5qjAWDoBichZK9x+EC
	PjnfLP+aIrFR6zmlYxFd4h+ssbNQ/OPXDBSbfrDCW8+A8wx76qGgW1GInHwA3qIQRgzhPI
	4HVX1O4MvcAzAKiSqfBNjX7xmFMTuovmCEoUTvorXz0l/EjUGce6IW4KFY3s2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ycbKfRvYM6rHQcKARlQ2J19/u+JpHS8yfBgGi5Y5/N0=;
	b=SFW1xwTNfXGnYG77UoogcLhbEVq0YGA0ReDGc/Yb1aOcXX3loN1lMCN8pArUcls2bCWRdt
	Tux6SnQadeuPRoDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Move time_max/esterror into ntp_data
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-11-?=
 =?utf-8?q?2d52f4e13476=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-11-2?=
 =?utf-8?q?d52f4e13476=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788389193.1442.2004408061941208132.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7891cf2961c0e99e026d911cbf1ec4aeb938750d
Gitweb:        https://git.kernel.org/tip/7891cf2961c0e99e026d911cbf1ec4aeb938750d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:39 +02:00

ntp: Move time_max/esterror into ntp_data

Continue the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-11-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 5a6c325..67c4117 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -31,6 +31,9 @@
  * @time_status:	Clock status bits
  * @time_offset:	Time adjustment in nanoseconds
  * @time_constant:	PLL time constant
+ * @time_maxerror:	Maximum error in microseconds holding the NTP sync distance
+ *			(NTP dispersion + delay / 2)
+ * @time_esterror:	Estimated error in microseconds holding NTP dispersion
  *
  * Protected by the timekeeping locks.
  */
@@ -42,6 +45,8 @@ struct ntp_data {
 	int			time_status;
 	s64			time_offset;
 	long			time_constant;
+	long			time_maxerror;
+	long			time_esterror;
 };
 
 static struct ntp_data tk_ntp_data = {
@@ -49,6 +54,8 @@ static struct ntp_data tk_ntp_data = {
 	.time_state		= TIME_OK,
 	.time_status		= STA_UNSYNC,
 	.time_constant		= 2,
+	.time_maxerror		= NTP_PHASE_LIMIT,
+	.time_esterror		= NTP_PHASE_LIMIT,
 };
 
 #define SECS_PER_DAY		86400
@@ -57,19 +64,6 @@ static struct ntp_data tk_ntp_data = {
 	(((MAX_TICKADJ * NSEC_PER_USEC) << NTP_SCALE_SHIFT) / NTP_INTERVAL_FREQ)
 #define MAX_TAI_OFFSET		100000
 
-/*
- * phase-lock loop variables
- *
- * Note: maximum error = NTP sync distance = dispersion + delay / 2;
- * estimated error = NTP dispersion.
- */
-
-/* maximum error (usecs):						*/
-static long			time_maxerror = NTP_PHASE_LIMIT;
-
-/* estimated error (usecs):						*/
-static long			time_esterror = NTP_PHASE_LIMIT;
-
 /* frequency offset (scaled nsecs/secs):				*/
 static s64			time_freq;
 
@@ -332,8 +326,8 @@ static void __ntp_clear(struct ntp_data *ntpdata)
 	/* Stop active adjtime() */
 	time_adjust		= 0;
 	ntpdata->time_status	|= STA_UNSYNC;
-	time_maxerror		= NTP_PHASE_LIMIT;
-	time_esterror		= NTP_PHASE_LIMIT;
+	ntpdata->time_maxerror	= NTP_PHASE_LIMIT;
+	ntpdata->time_esterror	= NTP_PHASE_LIMIT;
 
 	ntp_update_frequency(ntpdata);
 
@@ -442,9 +436,9 @@ int second_overflow(time64_t secs)
 	}
 
 	/* Bump the maxerror field */
-	time_maxerror += MAXFREQ / NSEC_PER_USEC;
-	if (time_maxerror > NTP_PHASE_LIMIT) {
-		time_maxerror = NTP_PHASE_LIMIT;
+	ntpdata->time_maxerror += MAXFREQ / NSEC_PER_USEC;
+	if (ntpdata->time_maxerror > NTP_PHASE_LIMIT) {
+		ntpdata->time_maxerror = NTP_PHASE_LIMIT;
 		ntpdata->time_status |= STA_UNSYNC;
 	}
 
@@ -730,10 +724,10 @@ static inline void process_adjtimex_modes(struct ntp_data *ntpdata, const struct
 	}
 
 	if (txc->modes & ADJ_MAXERROR)
-		time_maxerror = clamp(txc->maxerror, 0, NTP_PHASE_LIMIT);
+		ntpdata->time_maxerror = clamp(txc->maxerror, 0, NTP_PHASE_LIMIT);
 
 	if (txc->modes & ADJ_ESTERROR)
-		time_esterror = clamp(txc->esterror, 0, NTP_PHASE_LIMIT);
+		ntpdata->time_esterror = clamp(txc->esterror, 0, NTP_PHASE_LIMIT);
 
 	if (txc->modes & ADJ_TIMECONST) {
 		ntpdata->time_constant = clamp(txc->constant, 0, MAXTC);
@@ -806,8 +800,8 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 
 	txc->freq	   = shift_right((time_freq >> PPM_SCALE_INV_SHIFT) *
 					 PPM_SCALE_INV, NTP_SCALE_SHIFT);
-	txc->maxerror	   = time_maxerror;
-	txc->esterror	   = time_esterror;
+	txc->maxerror	   = ntpdata->time_maxerror;
+	txc->esterror	   = ntpdata->time_esterror;
 	txc->status	   = ntpdata->time_status;
 	txc->constant	   = ntpdata->time_constant;
 	txc->precision	   = 1;

