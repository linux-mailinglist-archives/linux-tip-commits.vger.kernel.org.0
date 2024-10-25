Return-Path: <linux-tip-commits+bounces-2573-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC479B0689
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B66C2840AF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176D520C8CD;
	Fri, 25 Oct 2024 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zhwG76cX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tatip2qw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183E20C628;
	Fri, 25 Oct 2024 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868046; cv=none; b=qK94QEjTzgURVJoRVzccKurDumb71BobewxMr3pGbZBcF2GkdSnKJWQtXuJCTAIrhCK3wPrwnXBHCZi3e5HM/bLHkmPIhZS9B/RgzomBNlKd9omveNtU8f7mmyibrdLwJgi26nwh4mRCI0tvnE9K62CLkGHx7tMjjPf7TwlFQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868046; c=relaxed/simple;
	bh=3PtoDnWK07d4+PkkuosGXCpC6H8bZkeUK8Zxs6JwNGk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r71m+qEBJ0NQE8AmgSG/JEKw0fTs5jjGBueA329kxbXq0RWP5s9/1TKVrNZGoD0uxUEJUqkMMu5jOXr01ebE/jga3f0oqKnfMkPAMn90kz3cv40UfOHFpEVoc6yLP5soxDHN9V/BcNEhgHhFU1HUT00nCcMW13zpxhcDFdIfEc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zhwG76cX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tatip2qw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:54:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4slJnB3OnLyjzfMnPuOOULjjv+sNTOIWPZ6TmnMwG/4=;
	b=zhwG76cXQB4AVfQusWv4xjZCNM05EqgN2iLuCoZfJQa7qNY2HWAqFAij5PATn1PMYEMkr4
	1Zzt2YGdykyG/WZGJHaZtMeayaFf69J2jcAxhgOGTDMuyCuJa30VIMcZvcyFYRV8UTHhg4
	QEi+Qp4vJX0WAZguWFG3C6r6FDBc9XtUuqoPCPj+pFfE5rsg328vvVx+ywVIgV2GkXWknk
	lXQ3B4eWuefX3b06fSTBCMVGlVdHIEP8NmjuhC+Qtvkv4TpLNNK1bvoZTkpwb2bsG2F97v
	dBz5fT1/ptYKfjakfbVlQxWUOMdBYviZWjriQl+OKYt29Fawa14a1FXMKAGb1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4slJnB3OnLyjzfMnPuOOULjjv+sNTOIWPZ6TmnMwG/4=;
	b=Tatip2qwGHqg0bndJG3DnetOff0+ikL3bw0GK5+YAf6bFBhxh66ixUyPRrckm+/s9QWt5Q
	oPtES27PmAX0lLDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Read NTP tick length only once
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-1-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-1-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172986804071.1442.8301856001102299062.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9b25bf86006c32865bd810b9ab915528fdabf1f7
Gitweb:        https://git.kernel.org/tip/9b25bf86006c32865bd810b9ab915528fdabf1f7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:28:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:41:11 +02:00

timekeeping: Read NTP tick length only once

From: Thomas Gleixner <tglx@linutronix.de>

No point in reading it a second time when the comparison fails.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-1-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 1427c58..2bc3542 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2161,16 +2161,17 @@ static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
  */
 static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
 {
+	u64 ntp_tl = ntp_tick_length();
 	u32 mult;
 
 	/*
 	 * Determine the multiplier from the current NTP tick length.
 	 * Avoid expensive division when the tick length doesn't change.
 	 */
-	if (likely(tk->ntp_tick == ntp_tick_length())) {
+	if (likely(tk->ntp_tick == ntp_tl)) {
 		mult = tk->tkr_mono.mult - tk->ntp_err_mult;
 	} else {
-		tk->ntp_tick = ntp_tick_length();
+		tk->ntp_tick = ntp_tl;
 		mult = div64_u64((tk->ntp_tick >> tk->ntp_error_shift) -
 				 tk->xtime_remainder, tk->cycle_interval);
 	}

