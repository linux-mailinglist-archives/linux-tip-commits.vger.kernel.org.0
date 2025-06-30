Return-Path: <linux-tip-commits+bounces-5946-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 491F9AEE1DC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 17:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A4B169A63
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5638128DB71;
	Mon, 30 Jun 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L6ZLk26j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+iMt83+H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AA028D843;
	Mon, 30 Jun 2025 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295923; cv=none; b=UnxZNVokpnI8A9pqa+6ZLsOiLdHkxx+QzGZNL4GnrTcX8oK6yjXEQ+V61uKFcB+Bi75UmlUsIOCgUqsR8zLX2B0iO2Ny6qDHXyFH6ar7BnnIWbLZuoKbcW0ipdr+J7dYuZd1aRNQ4LHsCHWeMn+N4QPyGiA8CzA8vynb7pSIzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295923; c=relaxed/simple;
	bh=JDVTldISF9Vk0tK74iI1KcFbukHfqn3UYGN9NE8tIbo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PoVMvKCcEnIj1jdbFAz9n89sYN27HoDixLvN+wS1QckGYZbPSLyqGAL92stP0GqAWX1RXpYd73vzJV80DrAmsptFNI6lCPmZN0djgE2y8bKdAmsZ6Xfe8Uvcsnc3pGiB0D8DaFX1FhijQSqeJS0xc0HgSIuSkrqjZxxnny36HFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L6ZLk26j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+iMt83+H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Jun 2025 15:05:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751295919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrVZ+GWuyPsSeFLk373pG7jw5KmeMdr/7xDyvHdlsJM=;
	b=L6ZLk26j/5gOlUSR3CO35NXkaKevTXBw4n8iDSzl1sFPIjOYSeKBqgAym0SwcUE4QiIV8A
	S21LHnDgEARowgNRNXx0S3yQUQSulvpA6eCkP8D4oiCimN3Sk5mcRiOLhD5SDgv/Zw0zEF
	KVidCvzizugfKVdM9KVWZgoisUPnDa2XsylCEY+FfwmUiIjO9sOQYNksy9ky0ekiC8ImxX
	Dfre7qgpeUdXnKaW+zSSkruBawFGURWgwIk3IgCNC5KmV3X4WCHYg5L/8+bYb8yaLf1oez
	aN91LB8OzIobH1QiUqv5GMaQuUPhWJgv5d40vngnIR33Gl1njvr5vgwtJQwR1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751295919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrVZ+GWuyPsSeFLk373pG7jw5KmeMdr/7xDyvHdlsJM=;
	b=+iMt83+HBhd/VIg8RU4Lo6QyPGs6dN9ZDpL9cKH9AqTXXKIs4vUBOvzORcOwqtcA7NXSam
	a6bjGJ9HtS6CwHAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/ptp] timekeeping: Provide update for auxiliary timekeepers
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250625183758.382451331@linutronix.de>
References: <20250625183758.382451331@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175129591780.406.8933561327569298178.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     e6d4c00719a6b1dda3fb358b4c973595f9dfd455
Gitweb:        https://git.kernel.org/tip/e6d4c00719a6b1dda3fb358b4c973595f9dfd455
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Jun 2025 20:38:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 Jun 2025 20:13:13 +02:00

timekeeping: Provide update for auxiliary timekeepers

Update the auxiliary timekeepers periodically. For now this is tied to the system
timekeeper update from the tick. This might be revisited and moved out of the tick.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250625183758.382451331@linutronix.de

---
 kernel/time/timekeeping.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 523670e..568ba1f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -131,9 +131,11 @@ static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
 #ifdef CONFIG_POSIX_AUX_CLOCKS
 static __init void tk_aux_setup(void);
 static void tk_aux_update_clocksource(void);
+static void tk_aux_advance(void);
 #else
 static inline void tk_aux_setup(void) { }
 static inline void tk_aux_update_clocksource(void) { }
+static inline void tk_aux_advance(void) { }
 #endif
 
 unsigned long timekeeper_lock_irqsave(void)
@@ -2317,11 +2319,13 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 /**
  * update_wall_time - Uses the current clocksource to increment the wall time
  *
+ * It also updates the enabled auxiliary clock timekeepers
  */
 void update_wall_time(void)
 {
 	if (timekeeping_advance(TK_ADV_TICK))
 		clock_was_set_delayed();
+	tk_aux_advance();
 }
 
 /**
@@ -2764,6 +2768,21 @@ static void tk_aux_update_clocksource(void)
 	}
 }
 
+static void tk_aux_advance(void)
+{
+	unsigned long active = READ_ONCE(aux_timekeepers);
+	unsigned int id;
+
+	/* Lockless quick check to avoid extra cache lines */
+	for_each_set_bit(id, &active, BITS_PER_LONG) {
+		struct tk_data *aux_tkd = &timekeeper_data[id + TIMEKEEPER_AUX_FIRST];
+
+		guard(raw_spinlock)(&aux_tkd->lock);
+		if (aux_tkd->shadow_timekeeper.clock_valid)
+			__timekeeping_advance(aux_tkd, TK_ADV_TICK);
+	}
+}
+
 /**
  * ktime_get_aux - Get time for a AUX clock
  * @id:	ID of the clock to read (CLOCK_AUX...)

