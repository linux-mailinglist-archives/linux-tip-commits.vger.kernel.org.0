Return-Path: <linux-tip-commits+bounces-5905-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6CCAE8977
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 18:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5943A162BCC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 16:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81A81F0994;
	Wed, 25 Jun 2025 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="viOUbC6l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/YWR6i2m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418BD2D5C8B;
	Wed, 25 Jun 2025 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868165; cv=none; b=r8/XGnvHYP69hYtRPzlCZLnLSCGqpXb+24g0VIPOGna0+wq+0cdGVsk1oNujhOO5NOvbRO8yC9TsbZdyNlX3S9Gt0PX2ImMh3+3BM4+rdVk4imH6Yh3gcQVEwWpxy0etk39NHS7sN64CU2gnXGhYV4DsAG9XlKptDCtwc+srNXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868165; c=relaxed/simple;
	bh=ASgXXv6E2j8Qut48mm7mr6UVwY+iEmxD7SU6jp0RgHU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XfLANon6QmENp5/06uIkmgyFOvWqPbI2I5bCw1Y+pZFSjTYjW9IUhsJ2SaZ+9HabgX2FmDXsFJ6RiJguKRY+aYFAWwSw62KaLvcFqIkW2/1ZFH4JIOxaQlKKa8dnn9V+4c/tIEp6/2G/J5mgXevDNnHpce1rgdKsRi6Esgcr5h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=viOUbC6l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/YWR6i2m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 16:16:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750868162;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcNq8hTjr8LV0vhUOn7QfmBXfxzj5f2y6b3TkUUg8a0=;
	b=viOUbC6lIfr99WDudK9njIoPxG8WFDkQOr3QMuPANwf/THWDmMhejyrY/ZA79PHojBy5zU
	pMK61LB20BQcELcnv3I1FxwyyZh+5mxwGtB0/+l+qBJUSYh2LWDr6SUtuP1mKVCLTkXuS9
	o66ZplwZy0dhtrrWEYxjwrgXnXVRUzab80Ta1q7mn7sb8brItwQVMvh/KsWzmS4cdESLVA
	ginEV8wayphhtiM80oSZa34Z9Aq4ReVz6soCg4OCo7PaMd1GeLspzpN8fs4jWtPPRpZxs/
	3KtkOCCk5VHT2P/T1HtdZy3uoOqzHJU8QfXAOkXEStT2ZVmQ9I7zmLE5FDtxcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750868162;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcNq8hTjr8LV0vhUOn7QfmBXfxzj5f2y6b3TkUUg8a0=;
	b=/YWR6i2mBuU2CMWRfOmQrocjsdS+h1koBrHVTY+pClkmJCEHL8rR/LqR2FXAbtZclmSDjt
	V+qNElybX9ls3vCQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] timekeeping: Make __timekeeping_advance() reusable
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250519083026.160967312@linutronix.de>
References: <20250519083026.160967312@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175086816139.406.6428584731965488102.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     926ad475169f5b24868438e4bff61ec6a73efd19
Gitweb:        https://git.kernel.org/tip/926ad475169f5b24868438e4bff61ec6a73efd19
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 19 May 2025 10:33:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Jun 2025 14:28:23 +02:00

timekeeping: Make __timekeeping_advance() reusable

In __timekeeping_advance() the pointer to struct tk_data is hardcoded by the
use of &tk_core. As long as there is only a single timekeeper (tk_core),
this is not a problem. But when __timekeeping_advance() will be reused for
per auxiliary timekeepers, __timekeeping_advance() needs to be generalized.

Add a pointer to struct tk_data as function argument of
__timekeeping_advance() and adapt all call sites.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250519083026.160967312@linutronix.de


---
 kernel/time/timekeeping.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 99b4749..153f760 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2196,10 +2196,10 @@ static u64 logarithmic_accumulation(struct timekeeper *tk, u64 offset,
  * timekeeping_advance - Updates the timekeeper to the current time and
  * current NTP tick length
  */
-static bool __timekeeping_advance(enum timekeeping_adv_mode mode)
+static bool __timekeeping_advance(struct tk_data *tkd, enum timekeeping_adv_mode mode)
 {
-	struct timekeeper *tk = &tk_core.shadow_timekeeper;
-	struct timekeeper *real_tk = &tk_core.timekeeper;
+	struct timekeeper *tk = &tkd->shadow_timekeeper;
+	struct timekeeper *real_tk = &tkd->timekeeper;
 	unsigned int clock_set = 0;
 	int shift = 0, maxshift;
 	u64 offset, orig_offset;
@@ -2252,7 +2252,7 @@ static bool __timekeeping_advance(enum timekeeping_adv_mode mode)
 	if (orig_offset != offset)
 		tk_update_coarse_nsecs(tk);
 
-	timekeeping_update_from_shadow(&tk_core, clock_set);
+	timekeeping_update_from_shadow(tkd, clock_set);
 
 	return !!clock_set;
 }
@@ -2260,7 +2260,7 @@ static bool __timekeeping_advance(enum timekeeping_adv_mode mode)
 static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 {
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
-	return __timekeeping_advance(mode);
+	return __timekeeping_advance(&tk_core, mode);
 }
 
 /**
@@ -2598,7 +2598,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 
 		/* Update the multiplier immediately if frequency was set directly */
 		if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
-			clock_set |= __timekeeping_advance(TK_ADV_FREQ);
+			clock_set |= __timekeeping_advance(&tk_core, TK_ADV_FREQ);
 	}
 
 	if (txc->modes & ADJ_SETOFFSET)

