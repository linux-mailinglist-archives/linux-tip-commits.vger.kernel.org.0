Return-Path: <linux-tip-commits+bounces-2566-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6059B0677
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6AA1F23FC9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC903DAC0E;
	Fri, 25 Oct 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mgHfOwdU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bFQKHmFP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1387520F3E7;
	Fri, 25 Oct 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868041; cv=none; b=mYie+df1bGov6BfJIuDVhfzHz81btmd10OmkO/fAf5aXGuJwXVyJnvP6LCh5/X2nhFhdc9abGwt9T6DRfUvGrE97mMRjwM6aWYONm72B/o962OzfkzKPjsSvP2RCFF4YfYPDAthmbxqlMDwVV8yr/yFgDzUjUGZEmJjaikncEwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868041; c=relaxed/simple;
	bh=hKgou++AhNwQzw1hBqRKY/z8CEO04uLKxigGuRtV8hI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PnEP0e2pvXICL7f2DgopQGinY/Dka3HC1CNYxxbXWlBHi8g6HbouDjxaKtUxIJ0+kqPGUF6vQwDobMJWemLORcJjrndGg63fO/01YGYC1UOh4KWqjlkLTVyFNZxi3bLgAOxByKy2TJysQkhPEcuBfiJMKDJk48CZOfg1AEEnvaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mgHfOwdU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bFQKHmFP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:53:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=og/tNlRS7bYpGBovZ+Dx6s2liF7UHKz3OESYVR+6hpo=;
	b=mgHfOwdUZiI6amTcmUNvC+UNsUPih5QwP0lok6e++OHg9/VQ/cC10m1n4MFIwrfaUJA2yT
	T9aNWZq13y/W+/IrYZ4AU8B3zpRInFrGKwy5CimCzpQGcFUqsw+Gnftrdq9lBlzB19PIVR
	3juPA8zQHs0iCVaLemLW+R9EDDeLMRyTTE50MzhtBF/Q2y33k4Q2onYEXVeYgteAdcz3gW
	qO/F0YY/rVKEDIiW2KNiysPqr3dBY98J3cLhdwwY4uHdHyFeLk0bJFfsYB6cd4qIXD8+7s
	UoGI4eqUX8d9aa0lUM3V1UkKJfTVjZ7zzILWIvNidl4ljDvim09uFIdoBZIYmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=og/tNlRS7bYpGBovZ+Dx6s2liF7UHKz3OESYVR+6hpo=;
	b=bFQKHmFPEcAU3gWKe3aLlWVxpPvodcAo9FmJIU6UY44N4AbS6FMSGdWWQfFZbhpFTaMXyX
	y3KqX9Sz8o9g/bBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Move shadow_timekeeper into tk_core
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-7-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-7-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172986803684.1442.5968133345148771294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d517700c6fef3fab9c5d36c8065dcc385b70ce7c
Gitweb:        https://git.kernel.org/tip/d517700c6fef3fab9c5d36c8065dcc385b70ce7c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:41:11 +02:00

timekeeping: Move shadow_timekeeper into tk_core

From: Thomas Gleixner <tglx@linutronix.de>

tk_core requires shadow_timekeeper to allow timekeeping_advance() updating
without holding the timekeeper sequence count write locked. This allows the
readers to make progress up to the actual update where the shadow
timekeeper is copied over to the real timekeeper.

As long as there is only a single timekeeper, having them separate is
fine. But when the timekeeper infrastructure will be reused for per ptp
clock timekeepers, shadow_timekeeper needs to be part of tk_core.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-7-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index cfb718d..848d2b1 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -50,11 +50,11 @@ DEFINE_RAW_SPINLOCK(timekeeper_lock);
 static struct {
 	seqcount_raw_spinlock_t	seq;
 	struct timekeeper	timekeeper;
+	struct timekeeper	shadow_timekeeper;
 } tk_core ____cacheline_aligned = {
 	.seq = SEQCNT_RAW_SPINLOCK_ZERO(tk_core.seq, &timekeeper_lock),
 };
 
-static struct timekeeper shadow_timekeeper;
 
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
@@ -795,8 +795,7 @@ static void timekeeping_update(struct timekeeper *tk, unsigned int action)
 	 * timekeeper structure on the next update with stale data
 	 */
 	if (action & TK_MIRROR)
-		memcpy(&shadow_timekeeper, &tk_core.timekeeper,
-		       sizeof(tk_core.timekeeper));
+		memcpy(&tk_core.shadow_timekeeper, &tk_core.timekeeper, sizeof(tk_core.timekeeper));
 }
 
 /**
@@ -2305,8 +2304,8 @@ static u64 logarithmic_accumulation(struct timekeeper *tk, u64 offset,
  */
 static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 {
+	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 	struct timekeeper *real_tk = &tk_core.timekeeper;
-	struct timekeeper *tk = &shadow_timekeeper;
 	unsigned int clock_set = 0;
 	int shift = 0, maxshift;
 	u64 offset;

