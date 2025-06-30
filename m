Return-Path: <linux-tip-commits+bounces-5952-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92751AEE1EB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 17:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3BAD16E686
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 15:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FC3290BD3;
	Mon, 30 Jun 2025 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YjHv9Eoz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eHySzb3G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB4928FAA8;
	Mon, 30 Jun 2025 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295928; cv=none; b=X54buzMTQcosaUhaDIO0A4U+WdMzJYrTaAtgjFK6lI4I69o5s36wWd3iZh+853rkcp7rnW3KxBDTGZx+17c+8Ji6UK17ncg1jsQcxAH21UimHkQpMou+TD4FvSnr50ubCRSan5UftYCyHbUVfzrQqoJlD/6gM5pgpbUpq1IM0CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295928; c=relaxed/simple;
	bh=JYAWjmzPDPYmiqAp2LLo74clcZ+Wf/uPcsIXfY1zWvw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WPKFVkSAo5hb/eg3GMBKij4GIG38ciUb5ap90RYaH9i5mfpe7JDRGxIO5nZVVxITD1JJYThIqmC9mP1GBRZrwSG27sDCQzSCh6wZjWKC9EMhhxq6AENzECYq3rwb4MKBYTBR6iwkzT9Wq7uTpJS4zBkvmNrguwjlWMgn5Mx0asI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YjHv9Eoz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eHySzb3G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Jun 2025 15:05:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751295925;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnU1K6TFVe83lP8xxS0Qz1CkcAW9rj9BryL6Lalg3xs=;
	b=YjHv9EozdkAFIR3W83//smk/rv/fbODl4jIDiEXKVYKDWGguBSmAXed65fcIDr/VEJfKbV
	ngSZ1Ohkce3Qram/ITcQaGY4PkP0V5QfwBNLH65u2p86popxBnhlnjojNgtPhoxCbKRygH
	fhLzgCxuzQsx1Y5afbRN0PUgAOF74sbza0+ERbaWxynpNmykI1d5RDpu1H6iQtYFK+PicK
	4QiWywcwPfFFlZQin/zMCZdv2g4LkDi4SbM0dtJ0eWIGQl7g1QessFUgRviUdICgn0YGo7
	qqEMf1DLKCs7upO52bqLH0DpYP6mOYj7/Zu8yddBLCIHR5+mwnZq4j5ntsc18g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751295925;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnU1K6TFVe83lP8xxS0Qz1CkcAW9rj9BryL6Lalg3xs=;
	b=eHySzb3G+vwGzwE6TeG/6IgEgXN6pTofOdvWuwxKLAe+r1rLRoUna0vhnBbuN+v+TQ9CSu
	Kq8z7PVTbBF+EhCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] timekeeping: Add minimal posix-timers support for
 auxiliary clocks
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250625183757.932220594@linutronix.de>
References: <20250625183757.932220594@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175129592450.406.15022854094962477894.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     606424bf4ffd9d27865c45b5707c1edac6b187ed
Gitweb:        https://git.kernel.org/tip/606424bf4ffd9d27865c45b5707c1edac6b187ed
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Jun 2025 20:38:32 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 Jun 2025 20:13:12 +02:00

timekeeping: Add minimal posix-timers support for auxiliary clocks

Provide clock_getres(2) and clock_gettime(2) for auxiliary clocks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250625183757.932220594@linutronix.de

---
 kernel/time/posix-timers.c |  3 +++
 kernel/time/posix-timers.h |  1 +
 kernel/time/timekeeping.c  | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 2053b1a..8b58217 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1526,6 +1526,9 @@ static const struct k_clock * const posix_clocks[] = {
 	[CLOCK_REALTIME_ALARM]		= &alarm_clock,
 	[CLOCK_BOOTTIME_ALARM]		= &alarm_clock,
 	[CLOCK_TAI]			= &clock_tai,
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+	[CLOCK_AUX ... CLOCK_AUX_LAST]	= &clock_aux,
+#endif
 };
 
 static const struct k_clock *clockid_to_kclock(const clockid_t id)
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index 61906f0..7f259e8 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -41,6 +41,7 @@ extern const struct k_clock clock_posix_dynamic;
 extern const struct k_clock clock_process;
 extern const struct k_clock clock_thread;
 extern const struct k_clock alarm_clock;
+extern const struct k_clock clock_aux;
 
 void posix_timer_queue_signal(struct k_itimer *timr);
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c7d2913..10c6e37 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2655,6 +2655,7 @@ EXPORT_SYMBOL(hardpps);
 #endif /* CONFIG_NTP_PPS */
 
 #ifdef CONFIG_POSIX_AUX_CLOCKS
+#include "posix-timers.h"
 
 /*
  * Bitmap for the activated auxiliary timekeepers to allow lockless quick
@@ -2749,6 +2750,26 @@ bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *ts)
 }
 EXPORT_SYMBOL_GPL(ktime_get_aux_ts64);
 
+static int aux_get_res(clockid_t id, struct timespec64 *tp)
+{
+	if (!clockid_aux_valid(id))
+		return -ENODEV;
+
+	tp->tv_sec = 0;
+	tp->tv_nsec = 1;
+	return 0;
+}
+
+static int aux_get_timespec(clockid_t id, struct timespec64 *tp)
+{
+	return ktime_get_aux_ts64(id, tp) ? 0 : -ENODEV;
+}
+
+const struct k_clock clock_aux = {
+	.clock_getres		= aux_get_res,
+	.clock_get_timespec	= aux_get_timespec,
+};
+
 static __init void tk_aux_setup(void)
 {
 	for (int i = TIMEKEEPER_AUX_FIRST; i <= TIMEKEEPER_AUX_LAST; i++)

