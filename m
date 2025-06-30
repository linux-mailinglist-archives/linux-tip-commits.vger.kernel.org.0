Return-Path: <linux-tip-commits+bounces-5955-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB62AEE1F0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 17:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC6616F49C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 15:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB625292912;
	Mon, 30 Jun 2025 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BomG0/3k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ImIVMABR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9611291157;
	Mon, 30 Jun 2025 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295930; cv=none; b=J+vVnLHRFnBQPDVDm+SrAgvfo2hp14qQmZCYquw1n/25IDPX0fw9Ay4ymE7Xh98HjHLnBj17SdUreYJdH8syrq0SkGySivNpQ/rdXJKNJBNidrnTkP3NMjhyeTLRxOfRvMFbAX8QDN338HJF8j8dnIG8Z46OBA/jWm5E5aQdEVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295930; c=relaxed/simple;
	bh=0W6s5/jGseNLnE+1C6AdCnmGnOEgBuCw0cCa2YUqkvQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Kc+hxWrkv+Kl0f407e6ct2KRrX+fNB82Nj1GECDcLvWxf5Yf71qQPuZKbILznj0PpESS9z7bBQ2MIehN6fdFoZ+5sqGQ81wYpGTkGzoCm4B9qZERMPUj+D2Sv9nnDpKmz0p8t/VyZqlqSYH7IzxzVfUrjLoTRVXANt4t+WpWIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BomG0/3k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ImIVMABR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Jun 2025 15:05:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751295927;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBEeNYSpdTJRssb5x7xx14QXGiKv8YywtcQFFpfHdY4=;
	b=BomG0/3kIiR2hJknGdVvI5e6BokGOZCglMsprKfRWzn6DObkgrCEqdw7kSO8uO4KL54+Je
	gr1kCbpeH5UnvRrZiRzUZtRkJjrGpn6bvjHULpM8yUp3vocZfbIJjyIljvegtQw1N3c9AU
	bGp22LJzW/Dyj8807B2NiZsMUIB5tvKYc0kWXBAyF0b5feyDEb9cp+UTHAsj/xrZTq+xaX
	SBKszPwAI14jWYILSqNQNF7hyzue2q1KWZQnwOEVyicYImz7eUbKj4qytcdTDNLDg1a5CM
	7Po7/gmYVcDej5lGv6xFCfrIVHWwHfAzYHf1ckOESOS+Oqzf61Alu9uF3JepRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751295927;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBEeNYSpdTJRssb5x7xx14QXGiKv8YywtcQFFpfHdY4=;
	b=ImIVMABRfD5w6XUvFXqcRTiDILJkBVrkRq3dbyR8lE+Vh+7Rojx7dUH+4PngMMzZJIgYGy
	Vg6Nl6JF3BB6JNAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] timekeeping: Update auxiliary timekeepers on
 clocksource change
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250625183757.803890875@linutronix.de>
References: <20250625183757.803890875@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175129592646.406.9501444922223792636.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     9f7729480a2c771bbe49b7eab034a8eaa5e27bfb
Gitweb:        https://git.kernel.org/tip/9f7729480a2c771bbe49b7eab034a8eaa5e27bfb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Jun 2025 20:38:29 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 Jun 2025 20:13:12 +02:00

timekeeping: Update auxiliary timekeepers on clocksource change

Propagate a system clocksource change to the auxiliary timekeepers so that
they can pick up the new clocksource.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250625183757.803890875@linutronix.de

---
 kernel/time/timekeeping.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 7d3693a..ee97570 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -119,8 +119,10 @@ static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
 
 #ifdef CONFIG_POSIX_AUX_CLOCKS
 static __init void tk_aux_setup(void);
+static void tk_aux_update_clocksource(void);
 #else
 static inline void tk_aux_setup(void) { }
+static inline void tk_aux_update_clocksource(void) { }
 #endif
 
 unsigned long timekeeper_lock_irqsave(void)
@@ -1548,6 +1550,8 @@ static int change_clocksource(void *data)
 		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
 	}
 
+	tk_aux_update_clocksource();
+
 	if (old) {
 		if (old->disable)
 			old->disable(old);
@@ -2651,6 +2655,35 @@ EXPORT_SYMBOL(hardpps);
 #endif /* CONFIG_NTP_PPS */
 
 #ifdef CONFIG_POSIX_AUX_CLOCKS
+
+/*
+ * Bitmap for the activated auxiliary timekeepers to allow lockless quick
+ * checks in the hot paths without touching extra cache lines. If set, then
+ * the state of the corresponding timekeeper has to be re-checked under
+ * timekeeper::lock.
+ */
+static unsigned long aux_timekeepers;
+
+/* Invoked from timekeeping after a clocksource change */
+static void tk_aux_update_clocksource(void)
+{
+	unsigned long active = READ_ONCE(aux_timekeepers);
+	unsigned int id;
+
+	for_each_set_bit(id, &active, BITS_PER_LONG) {
+		struct tk_data *tkd = &timekeeper_data[id + TIMEKEEPER_AUX_FIRST];
+		struct timekeeper *tks = &tkd->shadow_timekeeper;
+
+		guard(raw_spinlock_irqsave)(&tkd->lock);
+		if (!tks->clock_valid)
+			continue;
+
+		timekeeping_forward_now(tks);
+		tk_setup_internals(tks, tk_core.timekeeper.tkr_mono.clock);
+		timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
+	}
+}
+
 static __init void tk_aux_setup(void)
 {
 	for (int i = TIMEKEEPER_AUX_FIRST; i <= TIMEKEEPER_AUX_LAST; i++)

