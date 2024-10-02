Return-Path: <linux-tip-commits+bounces-2338-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A59B398DFC0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0824B28C6C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E270B1D223C;
	Wed,  2 Oct 2024 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nkrB5hDT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mPuobBor"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156D11D1E7C;
	Wed,  2 Oct 2024 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883900; cv=none; b=dcQXlzBkHlVH4EnucWDrzFLgKLyT4JSRcljQ0tEgKU+v4iXcrcB1I2ELBwaEG6wcoc7KERvFGmzQfSBEvYBvCQWblvrRbWLdHbZ7A73jTC8j9w6fqJe9ddOwvPLyiahQWLm54daPmnZFjwiMQdTCAelHBn3MYS7JQuXPLuGhK0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883900; c=relaxed/simple;
	bh=KiZo8KbRz3QiPY5Yj3E8hpnL3psprFInU6EH8F3jwww=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oKs068ntyu/lIO2/is9Lw18B+I10PcbAiF1azgswFo7GuTAGucwZ7Fth+iovDIfHl1AvCTGogql8QG+qvBuXGA9W1zewBk+gaSIVj3Ia5cI7PxCORoXN96PccW9utdGC7TcKweAmDeXM3VP7rbqxpzi7abgzf6baIC+aPvwo93w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nkrB5hDT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mPuobBor; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:44:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883896;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+umG2l0Hxx6MmaqCxiifxkQEsLJhgpmymJYN3AfyjU=;
	b=nkrB5hDTUOMynvTZaglnqcR3aW9tqzt4q7DJokkZPWTABeTbYO9to55OligeVhoozMn8ny
	yOhSseN2RqPDY288sJs/hpTF4I5T36QoEVkpZ0ODHo7H0gWy8Z+BnJEosHMQ3PT+jwz2H0
	gSgpaShiOSmD+tUcia6rqsoP5FngaS0xEQnoHgcObSOk5PzVVd75PRWzW/aaTxF7+Q4bWV
	60UaksaHC6NyTVJ1Ibz+ZJdzDMj1w4/mFSg1SRb4/PV1oyqxHkKnXmR1orMbUXU1TuNNfc
	OlXBG21wLKieGnieHVgIOrDhc0YQBBGc8fefCvEoTR/0rXUUFZpcfFZZTeXhPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883896;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+umG2l0Hxx6MmaqCxiifxkQEsLJhgpmymJYN3AfyjU=;
	b=mPuobBorYAMkcTZgKe+uq8PyIBRYfp5b0NCbZIMDvn+FGKrl0eCxdZ8qDHn92YhrJozDH9
	lg3LzDZl+4hwdJCQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Cleanup formatting of code
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-4-2d52f4e13476@linutronix.de>
References:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-4-2d52f4e13476@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788389566.1442.4969034114724683279.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     38007dc032bd90920463c5d2e6a27d89f7617d6d
Gitweb:        https://git.kernel.org/tip/38007dc032bd90920463c5d2e6a27d89f7617d6d
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:40 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:38 +02:00

ntp: Cleanup formatting of code

Code is partially formatted in a creative way which makes reading
harder. Examples are function calls over several lines where the
indentation does not start at the same height then the open bracket after
the function name.

Improve formatting but do not make a functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-4-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index e78d3cd..bf2f6ee 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -428,8 +428,7 @@ int second_overflow(time64_t secs)
 		} else if (secs == ntp_next_leap_sec) {
 			leap = -1;
 			time_state = TIME_OOP;
-			printk(KERN_NOTICE
-				"Clock: inserting leap second 23:59:60 UTC\n");
+			pr_notice("Clock: inserting leap second 23:59:60 UTC\n");
 		}
 		break;
 	case TIME_DEL:
@@ -440,8 +439,7 @@ int second_overflow(time64_t secs)
 			leap = 1;
 			ntp_next_leap_sec = TIME64_MAX;
 			time_state = TIME_WAIT;
-			printk(KERN_NOTICE
-				"Clock: deleting leap second 23:59:59 UTC\n");
+			pr_notice("Clock: deleting leap second 23:59:59 UTC\n");
 		}
 		break;
 	case TIME_OOP:
@@ -842,10 +840,8 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 			txc->tai--;
 			txc->time.tv_sec++;
 		}
-		if ((time_state == TIME_OOP) &&
-					(ts->tv_sec == ntp_next_leap_sec)) {
+		if ((time_state == TIME_OOP) &&	(ts->tv_sec == ntp_next_leap_sec))
 			result = TIME_WAIT;
-		}
 	}
 
 	return result;
@@ -952,9 +948,8 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 		time_status |= STA_PPSERROR;
 		pps_errcnt++;
 		pps_dec_freq_interval();
-		printk_deferred(KERN_ERR
-			"hardpps: PPSERROR: interval too long - %lld s\n",
-			freq_norm.sec);
+		printk_deferred(KERN_ERR "hardpps: PPSERROR: interval too long - %lld s\n",
+				freq_norm.sec);
 		return 0;
 	}
 
@@ -968,8 +963,7 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 	delta = shift_right(ftemp - pps_freq, NTP_SCALE_SHIFT);
 	pps_freq = ftemp;
 	if (delta > PPS_MAXWANDER || delta < -PPS_MAXWANDER) {
-		printk_deferred(KERN_WARNING
-				"hardpps: PPSWANDER: change=%ld\n", delta);
+		printk_deferred(KERN_WARNING "hardpps: PPSWANDER: change=%ld\n", delta);
 		time_status |= STA_PPSWANDER;
 		pps_stbcnt++;
 		pps_dec_freq_interval();
@@ -985,13 +979,11 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 	delta_mod = delta;
 	if (delta_mod < 0)
 		delta_mod = -delta_mod;
-	pps_stabil += (div_s64(((s64)delta_mod) <<
-				(NTP_SCALE_SHIFT - SHIFT_USEC),
-				NSEC_PER_USEC) - pps_stabil) >> PPS_INTMIN;
+	pps_stabil += (div_s64(((s64)delta_mod) << (NTP_SCALE_SHIFT - SHIFT_USEC),
+			       NSEC_PER_USEC) - pps_stabil) >> PPS_INTMIN;
 
 	/* If enabled, the system clock frequency is updated */
-	if ((time_status & STA_PPSFREQ) != 0 &&
-	    (time_status & STA_FREQHOLD) == 0) {
+	if ((time_status & STA_PPSFREQ) && !(time_status & STA_FREQHOLD)) {
 		time_freq = pps_freq;
 		ntp_update_frequency();
 	}
@@ -1015,15 +1007,13 @@ static void hardpps_update_phase(long error)
 	 * the time offset is updated.
 	 */
 	if (jitter > (pps_jitter << PPS_POPCORN)) {
-		printk_deferred(KERN_WARNING
-				"hardpps: PPSJITTER: jitter=%ld, limit=%ld\n",
+		printk_deferred(KERN_WARNING "hardpps: PPSJITTER: jitter=%ld, limit=%ld\n",
 				jitter, (pps_jitter << PPS_POPCORN));
 		time_status |= STA_PPSJITTER;
 		pps_jitcnt++;
 	} else if (time_status & STA_PPSTIME) {
 		/* Correct the time using the phase offset */
-		time_offset = div_s64(((s64)correction) << NTP_SCALE_SHIFT,
-				NTP_INTERVAL_FREQ);
+		time_offset = div_s64(((s64)correction) << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
 		/* Cancel running adjtime() */
 		time_adjust = 0;
 	}
@@ -1072,9 +1062,8 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 	 * Check that the signal is in the range
 	 * [1s - MAXFREQ us, 1s + MAXFREQ us], otherwise reject it
 	 */
-	if ((freq_norm.sec == 0) ||
-			(freq_norm.nsec > MAXFREQ * freq_norm.sec) ||
-			(freq_norm.nsec < -MAXFREQ * freq_norm.sec)) {
+	if ((freq_norm.sec == 0) || (freq_norm.nsec > MAXFREQ * freq_norm.sec) ||
+	    (freq_norm.nsec < -MAXFREQ * freq_norm.sec)) {
 		time_status |= STA_PPSJITTER;
 		/* Restart the frequency calibration interval */
 		pps_fbase = *raw_ts;

