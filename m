Return-Path: <linux-tip-commits+bounces-5902-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB76AE8979
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 18:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A5A18920F7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E1F2D4B49;
	Wed, 25 Jun 2025 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DPcOHUCA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nCpJSV6s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076BF2C375A;
	Wed, 25 Jun 2025 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868162; cv=none; b=YlkE1fe/vIHzJgNIykrNXgBetzgc1wuGGU5nVHpgagqUAhe7Cg6Y5iBCqDKpM3U8/dv9oP2MQbjq2ZSQ+z1nTJeO7DzSPcyJCybGjKb9lD0cLtmZyN7bEnVKOCQW3fE+tlwtSDbwmwfc8AS2D4qUUZRYkDZyrDOZD9qXmpc55Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868162; c=relaxed/simple;
	bh=4zBQUvQNHCGrjl5nn790FRjdO5M7qj5PBiw1l/uk4JU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IGFAZ5EMxRHrr7DbsQpgeaFMy2cYP1bbDD+Dq8EGRVuUEAd6l4W08v0q9KWglxJaRnVkY9cxYgXHDGylbQqp7VISr8d4/BdamDjCvN6BArIRA2OMGT7TljMDqsYxjkT/qSD3nZCMBv9qoGzagq2G0zCI+EI/Uai/l+od1oLYbR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DPcOHUCA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nCpJSV6s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 16:15:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750868159;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfSIxnm2KBe6nkyjs2edHQpatarBmYq4T2pwftj3yxc=;
	b=DPcOHUCAemXMQFvXYUXPYQkTnfAMNEO2wBX2wxPJBGAtjMe08nmaYt0RN45fesKZ4LHweq
	iUkk1XA48DOUpM20keT7elKkHwAFwd4bCCKRi0udN2mNY60O01PR/yLGHrt6Kpb84HeDQJ
	gQr73fC8sMKK2zSJST0s6HynwS5gBnU9a+HM6Q4lxJX9ePAyIpac7+KAKFQgqB942G426Z
	19dEacAWirP7n1Hs6GZFL4u6U3eUasyZgX0sZ22ry392k+w9eqe4Kcj1R9J85EnQNjfOM5
	JQz38MrmQ5EdrcwScdafDoYnQdl0R/elV2vjm2gEaQNbn3E+1TKe47gIFIsDhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750868159;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfSIxnm2KBe6nkyjs2edHQpatarBmYq4T2pwftj3yxc=;
	b=nCpJSV6stdSwKqY1YIQTvnZSjoRnWn/nwoS0z0u11vXvnWSb/DI9WuVgN3Qm1S8vdiqRwb
	zvkCc08shQOcgLCQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] timekeeping: Introduce auxiliary timekeepers
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250519083026.350061049@linutronix.de>
References: <20250519083026.350061049@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175086815823.406.4007639365671610452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     22c62b9a84b8f16ca0277e133a0cd62a259fee7c
Gitweb:        https://git.kernel.org/tip/22c62b9a84b8f16ca0277e133a0cd62a259fee7c
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 19 May 2025 10:33:28 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Jun 2025 14:28:23 +02:00

timekeeping: Introduce auxiliary timekeepers

Provide timekeepers for auxiliary clocks and initialize them during
boot.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250519083026.350061049@linutronix.de


---
 kernel/time/timekeeping.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index bf59bac..19f4af1 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -53,7 +53,11 @@ struct tk_data {
 	raw_spinlock_t		lock;
 } ____cacheline_aligned;
 
-static struct tk_data tk_core;
+static struct tk_data timekeeper_data[TIMEKEEPERS_MAX];
+
+/* The core timekeeper */
+#define tk_core		(timekeeper_data[TIMEKEEPER_CORE])
+
 
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
@@ -113,6 +117,12 @@ static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
 	.base[1] = FAST_TK_INIT,
 };
 
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+static __init void tk_aux_setup(void);
+#else
+static inline void tk_aux_setup(void) { }
+#endif
+
 unsigned long timekeeper_lock_irqsave(void)
 {
 	unsigned long flags;
@@ -1589,7 +1599,6 @@ void ktime_get_raw_ts64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL(ktime_get_raw_ts64);
 
-
 /**
  * timekeeping_valid_for_hres - Check if timekeeping is suitable for hres
  */
@@ -1701,6 +1710,7 @@ void __init timekeeping_init(void)
 	struct clocksource *clock;
 
 	tkd_basic_setup(&tk_core, TIMEKEEPER_CORE, true);
+	tk_aux_setup();
 
 	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
 	if (timespec64_valid_settod(&wall_time) &&
@@ -2630,3 +2640,11 @@ void hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts)
 }
 EXPORT_SYMBOL(hardpps);
 #endif /* CONFIG_NTP_PPS */
+
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+static __init void tk_aux_setup(void)
+{
+	for (int i = TIMEKEEPER_AUX_FIRST; i <= TIMEKEEPER_AUX_LAST; i++)
+		tkd_basic_setup(&timekeeper_data[i], i, false);
+}
+#endif /* CONFIG_POSIX_AUX_CLOCKS */

