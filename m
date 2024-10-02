Return-Path: <linux-tip-commits+bounces-2328-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE64098DF91
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079201C24F6D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D87F1D1304;
	Wed,  2 Oct 2024 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2RZwWgRb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VIXvHjih"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9361D0E24;
	Wed,  2 Oct 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883895; cv=none; b=aiC9zzwmN4DW9QZuJxUIYS/d4dr2FMjzMqzO9J2zvGIpt89AS6EieT9Zlm7iHkbH+jFf/9iMqMsPkaWjfWlWENgPZgulHbjlwwFfCDaqeMErFXT7E3r7BNKyBdrmJTrofDmkG/iEwa7ioyXVBQ1WAiYUydKucrVGk62zm1uV7dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883895; c=relaxed/simple;
	bh=sgcZ8RZl+LUsuheTHX1rivBBaFL+qW25CMiESfqEJCk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cAaXj/IDdHqbHDgWd0+YfH5sdPB0rMLE4tYGsFu+Ly70+S3Vz8aG5WDbzJxkV8zhqOxWEXHlCIlDp8IOct/bVlJ/xAmCI3vfyLjF8ODyGggO0xMP7hI/GlEQ48uu+DBwjzoYks93aGy0ujEExWYGSPCFKaTW8S2zuA3XjuGy7mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2RZwWgRb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VIXvHjih; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:44:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883889;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CrrrhXj4g7eYpOKU3sM62AcI57vpPoMDM1raZ8hG1Wc=;
	b=2RZwWgRbLiQbh44J159kyvrEJ6xWjewjwC7oa4LhIpgZVsib96Ez/D7EUwagcSXdFtOAu5
	vOhlfI8oVDQht3ahhLjn24eSQKPeuqby5wAJBNNTcFz5dpal68W9b5PqUajVP1SGWShRHE
	CY1hNGBPJKHiHpz99R9eXPuIdAN8gV9bIz+rKlu22de+ohsii6471qUQV9Ot5N6H5BKv/c
	qHOhYhtCA6JLS/G/6loSnA47tAWTmxYkK+F3XoNGWK0/ayJ0CcdHPpNGEz+srqjgDIDl1E
	8u0gET7w2SVt+UEK6X6iaHDL0eARuj4ad/rdC3cAjBkPKZofB1ZUWzLaRztXcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883889;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CrrrhXj4g7eYpOKU3sM62AcI57vpPoMDM1raZ8hG1Wc=;
	b=VIXvHjihm3geceGV6ZLfQ8pMOs71XpB1qZUebD1MVb2AWs7CWFKcCGyRZiU2Q/QMo3qmB+
	Ioh3aWGIkBNJbzCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Move pps_jitter into ntp_data
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-17-?=
 =?utf-8?q?2d52f4e13476=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-17-2?=
 =?utf-8?q?d52f4e13476=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788388903.1442.16589361643620029584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9d7130dfc0e1c53112fcbed4b9f566d0f6fbc949
Gitweb:        https://git.kernel.org/tip/9d7130dfc0e1c53112fcbed4b9f566d0f6fbc949
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:40 +02:00

ntp: Move pps_jitter into ntp_data

Continue the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-17-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 6a1ba27..576f86a 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -42,6 +42,7 @@
  *
  * @pps_valid:		PPS signal watchdog counter
  * @pps_tf:		PPS phase median filter
+ * @pps_jitter:		PPS current jitter in nanoseconds
  *
  * Protected by the timekeeping locks.
  */
@@ -63,6 +64,7 @@ struct ntp_data {
 #ifdef CONFIG_NTP_PPS
 	int			pps_valid;
 	long			pps_tf[3];
+	long			pps_jitter;
 #endif
 };
 
@@ -98,7 +100,6 @@ static struct ntp_data tk_ntp_data = {
 				   intervals to decrease it */
 #define PPS_MAXWANDER	100000	/* max PPS freq wander (ns/s) */
 
-static long pps_jitter;		/* current jitter (ns) */
 static struct timespec64 pps_fbase; /* beginning of the last freq interval */
 static int pps_shift;		/* current interval duration (s) (shift) */
 static int pps_intcnt;		/* interval counter */
@@ -194,9 +195,9 @@ static inline void pps_fill_timex(struct ntp_data *ntpdata, struct __kernel_time
 {
 	txc->ppsfreq	   = shift_right((pps_freq >> PPM_SCALE_INV_SHIFT) *
 					 PPM_SCALE_INV, NTP_SCALE_SHIFT);
-	txc->jitter	   = pps_jitter;
+	txc->jitter	   = ntpdata->pps_jitter;
 	if (!(ntpdata->time_status & STA_NANO))
-		txc->jitter = pps_jitter / NSEC_PER_USEC;
+		txc->jitter = ntpdata->pps_jitter / NSEC_PER_USEC;
 	txc->shift	   = pps_shift;
 	txc->stabil	   = pps_stabil;
 	txc->jitcnt	   = pps_jitcnt;
@@ -998,9 +999,9 @@ static void hardpps_update_phase(struct ntp_data *ntpdata, long error)
 	 * threshold, the sample is discarded; otherwise, if so enabled,
 	 * the time offset is updated.
 	 */
-	if (jitter > (pps_jitter << PPS_POPCORN)) {
+	if (jitter > (ntpdata->pps_jitter << PPS_POPCORN)) {
 		printk_deferred(KERN_WARNING "hardpps: PPSJITTER: jitter=%ld, limit=%ld\n",
-				jitter, (pps_jitter << PPS_POPCORN));
+				jitter, (ntpdata->pps_jitter << PPS_POPCORN));
 		ntpdata->time_status |= STA_PPSJITTER;
 		pps_jitcnt++;
 	} else if (ntpdata->time_status & STA_PPSTIME) {
@@ -1011,7 +1012,7 @@ static void hardpps_update_phase(struct ntp_data *ntpdata, long error)
 		ntpdata->time_adjust = 0;
 	}
 	/* Update jitter */
-	pps_jitter += (jitter - pps_jitter) >> PPS_INTMIN;
+	ntpdata->pps_jitter += (jitter - ntpdata->pps_jitter) >> PPS_INTMIN;
 }
 
 /*

