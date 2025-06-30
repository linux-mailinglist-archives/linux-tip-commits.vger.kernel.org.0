Return-Path: <linux-tip-commits+bounces-5948-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E50AEE1DE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 17:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A1397A9FBF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C998228E581;
	Mon, 30 Jun 2025 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tqryisp6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lo8Ci7Uz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80C328DB5D;
	Mon, 30 Jun 2025 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295924; cv=none; b=Stikz0b+IDt/iE1uCb3zutuhnzwSslIPhE0t6D8S37cqz6dmM15ikdqazrxlumTdwe+TjsRyoUBbXlp3+TpmpR9pdn2tjmVEUEzeMISozxVLJRPSvWLPtZtK3HCKv563mlJpWq4JA3qvvddIgEM8eLArb3RSN11JFuPVi0lKSC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295924; c=relaxed/simple;
	bh=MdYANBvQabD/15frOT2sESuzzdW18URNcnNIyD+XLLo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pXInmhteHZnNsDh1PBWRxT95sLGsm2B/V8xGVDTQ63e6g3Cqk66bRsyplUTGabvYf6XcoM3ptsj8ZvmQwZTMYaDaKMinlBp9o6mV3eivIlTujV0Np8V/TdxERVjDF1xerDEIe3dCmXY452X+NJ+WCXoPUr3X3m2V+J2RIGXNq1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tqryisp6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lo8Ci7Uz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Jun 2025 15:05:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751295920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofH4bWEaSHKjOz+m2pTkM37HryCE3gP4LRS8S7Z5ssQ=;
	b=tqryisp6mD8HiAaGDdDrwC4cDyL/6sa8e1s7kPZwjNJYtq6jNT2/HrE9KOKfjw7xIiAM28
	bb/Ydm/8eAKWIkrFL8ULK0OAsR5g7NzvroamRjPrAT7Ggec7DUmGbvv8gDLP2AZJk5yP7g
	vJkkutZHo35L8bfbDFnaQrwpm8Sw2ULnK5X2/9e3NRSxVzaR9VJfjbdXJ5v0+S1+b4eZow
	s6KPbKydDGK4yQZ8XE+6ikGA//nV5QOTUnF44M4NPqo6MJme0xNDHa3lcGofPR/3DXvLf2
	hFFRua21AWBx2ZnByOH6HrfMpFcTn7nIvNFWNNrhIYEOgN9JdrokTB83N+AS+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751295920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofH4bWEaSHKjOz+m2pTkM37HryCE3gP4LRS8S7Z5ssQ=;
	b=lo8Ci7UzV+o/W+Q+dr3pL/KxGDPyvvYCi+H0C/ebjBiIyhi/TbutTDKIEeBXVlHrSpRk5q
	CyLtWzv2HrNvxpAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/ptp] timekeeping: Prepare do_adtimex() for auxiliary clocks
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250625183758.253203783@linutronix.de>
References: <20250625183758.253203783@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175129591982.406.5375790825027841172.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     4eca49d0b621b314ac7c80f363932ec6f6c8abc8
Gitweb:        https://git.kernel.org/tip/4eca49d0b621b314ac7c80f363932ec6f6c8abc8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Jun 2025 20:38:45 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 Jun 2025 20:13:13 +02:00

timekeeping: Prepare do_adtimex() for auxiliary clocks

Exclude ADJ_TAI, leap seconds and PPS functionality as they make no sense
in the context of auxiliary clocks and provide a time stamp based on the
actual clock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250625183758.253203783@linutronix.de

---
 kernel/time/timekeeping.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 0de6131..6770544 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -58,6 +58,17 @@ static struct tk_data timekeeper_data[TIMEKEEPERS_MAX];
 /* The core timekeeper */
 #define tk_core		(timekeeper_data[TIMEKEEPER_CORE])
 
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+static inline bool tk_get_aux_ts64(unsigned int tkid, struct timespec64 *ts)
+{
+	return ktime_get_aux_ts64(CLOCK_AUX + tkid - TIMEKEEPER_AUX_FIRST, ts);
+}
+#else
+static inline bool tk_get_aux_ts64(unsigned int tkid, struct timespec64 *ts)
+{
+	return false;
+}
+#endif
 
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
@@ -2508,7 +2519,7 @@ ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq, ktime_t *offs_real,
 /*
  * timekeeping_validate_timex - Ensures the timex is ok for use in do_adjtimex
  */
-static int timekeeping_validate_timex(const struct __kernel_timex *txc)
+static int timekeeping_validate_timex(const struct __kernel_timex *txc, bool aux_clock)
 {
 	if (txc->modes & ADJ_ADJTIME) {
 		/* singleshot must not be used with any other mode bits */
@@ -2567,6 +2578,20 @@ static int timekeeping_validate_timex(const struct __kernel_timex *txc)
 			return -EINVAL;
 	}
 
+	if (aux_clock) {
+		/* Auxiliary clocks are similar to TAI and do not have leap seconds */
+		if (txc->status & (STA_INS | STA_DEL))
+			return -EINVAL;
+
+		/* No TAI offset setting */
+		if (txc->modes & ADJ_TAI)
+			return -EINVAL;
+
+		/* No PPS support either */
+		if (txc->status & (STA_PPSFREQ | STA_PPSTIME))
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -2595,17 +2620,22 @@ static int __do_adjtimex(struct tk_data *tkd, struct __kernel_timex *txc,
 			 struct adjtimex_result *result)
 {
 	struct timekeeper *tks = &tkd->shadow_timekeeper;
+	bool aux_clock = !timekeeper_is_core_tk(tks);
 	struct timespec64 ts;
 	s32 orig_tai, tai;
 	int ret;
 
 	/* Validate the data before disabling interrupts */
-	ret = timekeeping_validate_timex(txc);
+	ret = timekeeping_validate_timex(txc, aux_clock);
 	if (ret)
 		return ret;
 	add_device_randomness(txc, sizeof(*txc));
 
-	ktime_get_real_ts64(&ts);
+	if (!aux_clock)
+		ktime_get_real_ts64(&ts);
+	else
+		tk_get_aux_ts64(tkd->timekeeper.id, &ts);
+
 	add_device_randomness(&ts, sizeof(ts));
 
 	guard(raw_spinlock_irqsave)(&tkd->lock);

