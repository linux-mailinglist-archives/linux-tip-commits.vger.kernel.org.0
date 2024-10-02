Return-Path: <linux-tip-commits+bounces-2321-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 408D098DF83
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8AD51F223B1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FD81D0DDE;
	Wed,  2 Oct 2024 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AIXETVJM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="crthIP0i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B12D23CE;
	Wed,  2 Oct 2024 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883890; cv=none; b=gmSk8Q/ESkYpGylBh8V17NHr8AeTCuES/TsmwcGA6F00yRYiCIjg5JYN55LtbwsR08NWJb0CS+9nDWMPLApwqHg8KUkcFEyMSabWPXTct/2ZMR5cyE5ldLuN08+RTiymESXyR0sawkyhBPC46DPbWJ5TCgzmrNElEMs/6hv70C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883890; c=relaxed/simple;
	bh=0aZRx91l+QUQkrK34eQKynZZCeiLz8BUmUYbz2eSSbQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C85r/D19DcVzuYTFhzDMk8TYd9CLmv+ZBzV0kHL2aOWPe3FlM6AYfl3L/Xr5x2dE//d5H2eeBdjpPdGSWFr7lB6COQv9wspLfQViW/H5HF0MnAZt/sA7/dEYBVeDVXNZRq3kPe566YB+YSzTBCI8DjGAZWCeeRZMWGRN6dagdX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AIXETVJM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=crthIP0i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:44:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883887;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WsYCZE2uZ9ivWYpQl7cMhwMB9avGOBeZ30rJ/6/bEU=;
	b=AIXETVJMR2SMjzIq+ASEYpbsyXtlGoEjujljXx1OeRqcLlA/v9ZG9wPirVOuHHdBgyUPCv
	pH5H2R+nLFD7ePCVAR9avl7yxtM3TKW34NopRuaNCLZT3c5JJ05AvTuX+Y8+8qqriuMpJN
	WMhh3YkRik96s1FOAf/fmQxN8DM8yM87U4w55NdOr+XCN7oTgc6rjG5F6qvJrWXscIXDkF
	Sp1GNErdqWFd+//CTRsZD17IZGZ7KUyqvJBJkVSKKKoEKFKCriaO+19MGV0EGFWHyK/t7F
	oQ5V81ojIjHU+634b2d+0FdGDjkzSsPpdmS2QzwJ/aaQQV4JJtd2LuVbv/tsbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883887;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WsYCZE2uZ9ivWYpQl7cMhwMB9avGOBeZ30rJ/6/bEU=;
	b=crthIP0iuGLK81kWYoHtTu2+SSvdBAR/G3roKY+9/9LFqrjtgPSmcCNOgAY2rTCfYMDFh+
	s8KrToVeBFEyMCCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Move pps monitors into ntp_data
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-21-?=
 =?utf-8?q?2d52f4e13476=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-21-2?=
 =?utf-8?q?d52f4e13476=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788388695.1442.11681828017326759997.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6fadb4a61d3fd4cdc6ede38a911b4abbfb43eed4
Gitweb:        https://git.kernel.org/tip/6fadb4a61d3fd4cdc6ede38a911b4abbfb43eed4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:41 +02:00

ntp: Move pps monitors into ntp_data

Finalize the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-21-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 533367d..b550ebe 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -48,6 +48,10 @@
  * @pps_intcnt:		PPS interval counter
  * @pps_freq:		PPS frequency offset in scaled ns/s
  * @pps_stabil:		PPS current stability in scaled ns/s
+ * @pps_calcnt:		PPS monitor: calibration intervals
+ * @pps_jitcnt:		PPS monitor: jitter limit exceeded
+ * @pps_stbcnt:		PPS monitor: stability limit exceeded
+ * @pps_errcnt:		PPS monitor: calibration errors
  *
  * Protected by the timekeeping locks.
  */
@@ -75,6 +79,10 @@ struct ntp_data {
 	int			pps_intcnt;
 	s64			pps_freq;
 	long			pps_stabil;
+	long			pps_calcnt;
+	long			pps_jitcnt;
+	long			pps_stbcnt;
+	long			pps_errcnt;
 #endif
 };
 
@@ -111,15 +119,6 @@ static struct ntp_data tk_ntp_data = {
 #define PPS_MAXWANDER	100000	/* max PPS freq wander (ns/s) */
 
 /*
- * PPS signal quality monitors
- */
-static long pps_calcnt;		/* calibration intervals */
-static long pps_jitcnt;		/* jitter limit exceeded */
-static long pps_stbcnt;		/* stability limit exceeded */
-static long pps_errcnt;		/* calibration errors */
-
-
-/*
  * PPS kernel consumer compensates the whole phase error immediately.
  * Otherwise, reduce the offset by a fixed factor times the time constant.
  */
@@ -204,10 +203,10 @@ static inline void pps_fill_timex(struct ntp_data *ntpdata, struct __kernel_time
 		txc->jitter = ntpdata->pps_jitter / NSEC_PER_USEC;
 	txc->shift	   = ntpdata->pps_shift;
 	txc->stabil	   = ntpdata->pps_stabil;
-	txc->jitcnt	   = pps_jitcnt;
-	txc->calcnt	   = pps_calcnt;
-	txc->errcnt	   = pps_errcnt;
-	txc->stbcnt	   = pps_stbcnt;
+	txc->jitcnt	   = ntpdata->pps_jitcnt;
+	txc->calcnt	   = ntpdata->pps_calcnt;
+	txc->errcnt	   = ntpdata->pps_errcnt;
+	txc->stbcnt	   = ntpdata->pps_stbcnt;
 }
 
 #else /* !CONFIG_NTP_PPS */
@@ -943,7 +942,7 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 	/* Check if the frequency interval was too long */
 	if (freq_norm.sec > (2 << ntpdata->pps_shift)) {
 		ntpdata->time_status |= STA_PPSERROR;
-		pps_errcnt++;
+		ntpdata->pps_errcnt++;
 		pps_dec_freq_interval(ntpdata);
 		printk_deferred(KERN_ERR "hardpps: PPSERROR: interval too long - %lld s\n",
 				freq_norm.sec);
@@ -962,7 +961,7 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 	if (delta > PPS_MAXWANDER || delta < -PPS_MAXWANDER) {
 		printk_deferred(KERN_WARNING "hardpps: PPSWANDER: change=%ld\n", delta);
 		ntpdata->time_status |= STA_PPSWANDER;
-		pps_stbcnt++;
+		ntpdata->pps_stbcnt++;
 		pps_dec_freq_interval(ntpdata);
 	} else {
 		/* Good sample */
@@ -1007,7 +1006,7 @@ static void hardpps_update_phase(struct ntp_data *ntpdata, long error)
 		printk_deferred(KERN_WARNING "hardpps: PPSJITTER: jitter=%ld, limit=%ld\n",
 				jitter, (ntpdata->pps_jitter << PPS_POPCORN));
 		ntpdata->time_status |= STA_PPSJITTER;
-		pps_jitcnt++;
+		ntpdata->pps_jitcnt++;
 	} else if (ntpdata->time_status & STA_PPSTIME) {
 		/* Correct the time using the phase offset */
 		ntpdata->time_offset = div_s64(((s64)correction) << NTP_SCALE_SHIFT,
@@ -1072,7 +1071,7 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 
 	/* Signal is ok. Check if the current frequency interval is finished */
 	if (freq_norm.sec >= (1 << ntpdata->pps_shift)) {
-		pps_calcnt++;
+		ntpdata->pps_calcnt++;
 		/* Restart the frequency calibration interval */
 		ntpdata->pps_fbase = *raw_ts;
 		hardpps_update_freq(ntpdata, freq_norm);

