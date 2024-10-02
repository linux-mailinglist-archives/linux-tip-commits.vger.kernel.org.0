Return-Path: <linux-tip-commits+bounces-2336-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5917098DFA1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B267280F22
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0DB1D1F5E;
	Wed,  2 Oct 2024 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C8I0Jlq/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YKIHVxZw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512D61D151C;
	Wed,  2 Oct 2024 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883899; cv=none; b=tUGXHQF/glrFliWEQ0WE9l1XaWhBZzUOMemeBaAyEYX+BCOTw+IVtofK+dybjHZ4h7bbADBJgaOFDPFpyJbN3TYms7wWs7RHZzUxU6j+ebe+tv8pgK/Ksqdx0eRzXn/4xq91L787FlCaqJGDilpALw6W0eMiR/c+CeRptN+VAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883899; c=relaxed/simple;
	bh=GZh2OWYcinlazgRPE2vrw1/ke/+aj6vYCkwHvqjgcqo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UljjeJlXU9mCKpy6DakqA97s+2kPllClUrZrlwaLXQ+Qpzg7vnZrs5M0IxFBnsuLd4p0pjxx/2pDSrdaPS5PXhPL9sc5imqPOhycNOudkBdecAEN4o5JvGguAJH4c+04SyxjAZDZ8HQvvUQ2PJlGCIJnfbcaTeAafwYUAv+5KHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C8I0Jlq/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YKIHVxZw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:44:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883894;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GJufDNphTUba68R1yytroSINJJvN5j5D0mtG5HFbEYQ=;
	b=C8I0Jlq/CsWJD43M83eY0rfTxtlVKz7XIvAAr1OVBGL0nnrB3Z/9AXsNCocmG59jfuTQ2d
	2lsc5MRSYJjlMia/xL7cqSsdcCQpO9Q/nDBlem8+nrQjScZLvBdJ0S6dGLYnuJS8tv+OeE
	FV3iqe4OuSoDABXGi9D5/+Fm1vpigmu3XoBXOxS+76PCH1QACbf9gM2tYNA6WuhoPH+EzW
	mfr2dZQoFYw4nlTviuw53ekLXn9RpCpKiAQXy18EzWjUPNiju9Gom+YpFbtPEIZi1teK8q
	5Qst9NClwlxs7+r7Deq34l+ekNFBQiUz9vwmmM6EuSHJNUko0fqyOZNAoeirjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883894;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GJufDNphTUba68R1yytroSINJJvN5j5D0mtG5HFbEYQ=;
	b=YKIHVxZwzeJ/TjslDqQxYT+0eQe4x7z+epEHxRlt5F8xMeHXomNDfuqanD6JLYLLJiBLT3
	v2H83/gxq9xj2wDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Move tick_length* into ntp_data
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-8-2d52f4e13476@linutronix.de>
References:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-8-2d52f4e13476@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788389341.1442.10707408136353919336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ec93ec22aa10fb5311c0f068ee66c5b6d39788fe
Gitweb:        https://git.kernel.org/tip/ec93ec22aa10fb5311c0f068ee66c5b6d39788fe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:44 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:39 +02:00

ntp: Move tick_length* into ntp_data

Continue the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-8-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index f95f233..2430e69 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -25,20 +25,21 @@
 /**
  * struct ntp_data - Structure holding all NTP related state
  * @tick_usec:		USER_HZ period in microseconds
+ * @tick_length:	Adjusted tick length
+ * @tick_length_base:	Base value for @tick_length
  *
  * Protected by the timekeeping locks.
  */
 struct ntp_data {
 	unsigned long		tick_usec;
+	u64			tick_length;
+	u64			tick_length_base;
 };
 
 static struct ntp_data tk_ntp_data = {
 	.tick_usec		= USER_TICK_USEC,
 };
 
-static u64			tick_length;
-static u64			tick_length_base;
-
 #define SECS_PER_DAY		86400
 #define MAX_TICKADJ		500LL		/* usecs */
 #define MAX_TICKADJ_SCALED \
@@ -263,8 +264,8 @@ static void ntp_update_frequency(struct ntp_data *ntpdata)
 	 * Don't wait for the next second_overflow, apply the change to the
 	 * tick length immediately:
 	 */
-	tick_length		+= new_base - tick_length_base;
-	tick_length_base	 = new_base;
+	ntpdata->tick_length		+= new_base - ntpdata->tick_length_base;
+	ntpdata->tick_length_base	 = new_base;
 }
 
 static inline s64 ntp_update_offset_fll(s64 offset64, long secs)
@@ -341,8 +342,8 @@ static void __ntp_clear(struct ntp_data *ntpdata)
 
 	ntp_update_frequency(ntpdata);
 
-	tick_length	= tick_length_base;
-	time_offset	= 0;
+	ntpdata->tick_length	= ntpdata->tick_length_base;
+	time_offset		= 0;
 
 	ntp_next_leap_sec = TIME64_MAX;
 	/* Clear PPS state variables */
@@ -360,7 +361,7 @@ void ntp_clear(void)
 
 u64 ntp_tick_length(void)
 {
-	return tick_length;
+	return tk_ntp_data.tick_length;
 }
 
 /**
@@ -391,6 +392,7 @@ ktime_t ntp_get_next_leap(void)
  */
 int second_overflow(time64_t secs)
 {
+	struct ntp_data *ntpdata = &tk_ntp_data;
 	s64 delta;
 	int leap = 0;
 	s32 rem;
@@ -451,11 +453,11 @@ int second_overflow(time64_t secs)
 	}
 
 	/* Compute the phase adjustment for the next second */
-	tick_length	 = tick_length_base;
+	ntpdata->tick_length	 = ntpdata->tick_length_base;
 
-	delta		 = ntp_offset_chunk(time_offset);
-	time_offset	-= delta;
-	tick_length	+= delta;
+	delta			 = ntp_offset_chunk(time_offset);
+	time_offset		-= delta;
+	ntpdata->tick_length	+= delta;
 
 	/* Check PPS signal */
 	pps_dec_valid();
@@ -465,18 +467,18 @@ int second_overflow(time64_t secs)
 
 	if (time_adjust > MAX_TICKADJ) {
 		time_adjust -= MAX_TICKADJ;
-		tick_length += MAX_TICKADJ_SCALED;
+		ntpdata->tick_length += MAX_TICKADJ_SCALED;
 		goto out;
 	}
 
 	if (time_adjust < -MAX_TICKADJ) {
 		time_adjust += MAX_TICKADJ;
-		tick_length -= MAX_TICKADJ_SCALED;
+		ntpdata->tick_length -= MAX_TICKADJ_SCALED;
 		goto out;
 	}
 
-	tick_length += (s64)(time_adjust * NSEC_PER_USEC / NTP_INTERVAL_FREQ)
-							 << NTP_SCALE_SHIFT;
+	ntpdata->tick_length += (s64)(time_adjust * NSEC_PER_USEC / NTP_INTERVAL_FREQ)
+				<< NTP_SCALE_SHIFT;
 	time_adjust = 0;
 
 out:

