Return-Path: <linux-tip-commits+bounces-5947-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 622BFAEE1DF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 17:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14DD77A5EAE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 15:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6310728DEE2;
	Mon, 30 Jun 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FIvX2hon";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8PAgYe9s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0628D8C1;
	Mon, 30 Jun 2025 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295923; cv=none; b=EirBBG1RdsK+HYbYBVsaOGxez+P3Sn1/migYn047j4Af3v82O9/Jaz09vsj2kIlIe4igk+EvePQ9NF4EZqtqmEi2oT8T+eVSS8fi3kZ0JwReqbjh4SslaV3PkdhqVJnFMzmMfBmYhLKmumq+Qw9pEUuioUKxsOoCbD926fQi4XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295923; c=relaxed/simple;
	bh=2vchCUumQFUvcSbel9TIy/7GlflPtNq1I3wqjswZDko=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LlUmTpZzI4x57WfDqThGJLlYJ6ux1FNkTDNzbLhFaUkE1Ix2ycfvWdNaYjMSR1JOyO/9rSJiyCNRV9/QCkn3M3tdl7CU8VbKfH7CuP1GC9fwMyrNm20UYTftZs9bqLjBDXHR6wZ7wpolzXZNtx+Ua622MzrCOJRPyEHJ8+DOGv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FIvX2hon; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8PAgYe9s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Jun 2025 15:05:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751295920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1iG03Ay6Bg3cXBpBAi8/2iSGVGPWDPE3IwAKVyJsk1A=;
	b=FIvX2honcNNQwuyUDvgnWCU3Axk9KyVuVjPbegSXMxcH4Fl8AE6TCePdj5ysUw0y/p5gSs
	7xPeOEAFhX53ugz8qM+UmKVOQfv5MUC/dCQocIBGXV4303rL9lc9GEsG9VRXRpmZB4gf9U
	yObZCBR6/1YrnX+B4rXkoktALQen2Sm9TduZrc+VoaWPQ4REjCyyHWAPXz72qOSEcFwOqj
	7+CsRtjwmOctK4Sx1E8hiqK7u1eS9tGR7t/kAegSQoFmWA7ngCk+6LLe8XDPJklzvmmJ20
	BN4Sf1jFRImDygMRyxKmf8EVLnkuEplNyI8HHZkptsR7HkLCGsLPyWnksoTdRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751295920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1iG03Ay6Bg3cXBpBAi8/2iSGVGPWDPE3IwAKVyJsk1A=;
	b=8PAgYe9sv/7zia+fZ89GKOBRr+87l2ARFhX5wRNFNL5PXpd3krEcfN6o9FdMUHvarh1y1W
	mbnmroJTlQO9LmDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/ptp] timekeeping: Provide adjtimex() for auxiliary clocks
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250625183758.317946543@linutronix.de>
References: <20250625183758.317946543@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175129591888.406.15810387280877920988.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     ecf3e70304911be1c14cd21baa0bc611a53ec50b
Gitweb:        https://git.kernel.org/tip/ecf3e70304911be1c14cd21baa0bc611a53ec50b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Jun 2025 20:38:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 Jun 2025 20:13:13 +02:00

timekeeping: Provide adjtimex() for auxiliary clocks

The behaviour is close to clock_adtime(CLOCK_REALTIME) with the
following differences:

  1) ADJ_SETOFFSET adjusts the auxiliary clock offset
  
  2) ADJ_TAI is not supported

  3) Leap seconds are not supported

  4) PPS is not supported

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250625183758.317946543@linutronix.de

---
 kernel/time/timekeeping.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 6770544..523670e 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2875,10 +2875,26 @@ static int aux_clock_set(const clockid_t id, const struct timespec64 *tnew)
 	return 0;
 }
 
+static int aux_clock_adj(const clockid_t id, struct __kernel_timex *txc)
+{
+	struct tk_data *aux_tkd = aux_get_tk_data(id);
+	struct adjtimex_result result = { };
+
+	if (!aux_tkd)
+		return -ENODEV;
+
+	/*
+	 * @result is ignored for now as there are neither hrtimers nor a
+	 * RTC related to auxiliary clocks for now.
+	 */
+	return __do_adjtimex(aux_tkd, txc, &result);
+}
+
 const struct k_clock clock_aux = {
 	.clock_getres		= aux_get_res,
 	.clock_get_timespec	= aux_get_timespec,
 	.clock_set		= aux_clock_set,
+	.clock_adj		= aux_clock_adj,
 };
 
 static __init void tk_aux_setup(void)

