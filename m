Return-Path: <linux-tip-commits+bounces-2553-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4420C9B0659
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8F79B27313
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F45185B4C;
	Fri, 25 Oct 2024 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jG+wd4aA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o7UAzo8q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754B916D9C2;
	Fri, 25 Oct 2024 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868032; cv=none; b=G+Ypyj77N12AbyTB+KPmcg9mrPiUMaf8e1k+New8jjPH+X2hvjeRoNnpmJHO3+L1q0+oTmfwgKb0AssCbOxq83haZQaFCxZ0UhkLBNOcCu59URrIzGPRozwae5FVDYZvnB7mGTB3f5QDgMzERC415+e5YgJVlZ0SdamsU6SboKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868032; c=relaxed/simple;
	bh=R02Y2dvIsdOvY9hEGwLsRFzQNzWDdU2UxD51RlEjAJM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IXognLMyV7KeDzs1lNH+8VRMkwI+G8eL/sEZW98LI/ysyfOKTXKz3nPy9qgoHYYiqj7fqgIlspKIGWl5ddYPPPq87VhKnLKVmti+yOMydsnZ1msm3vtuO72C44o9rbo+QqhDqwVISrfj3SI5I2y9OtYOhxeatcAtzKSfKHDEDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jG+wd4aA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o7UAzo8q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:53:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868028;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsdBbJdWQudrz5WjSrEPn66pz8ojPyV2wOpQoiJZO6A=;
	b=jG+wd4aAFni0wg8++G/do6JLTu5d4eQUnSD7gMR5lVCWZVrr61dD+uw6QGUghMeJLjeeZe
	45HtwUIdkoQqieSSHaKqgnuc/NWu9eM06+7fuZvIA+Gi6qCjenjlL4wDussqgsgWo37fAb
	Z9w8j0X4d75Ibt919n3pWy//X/sTUlw37SrJRcES9A0jluWLxe4QMmU5O6NCAuzgC5M/B/
	16fyVxae8X7AmmOslsGoNDgIKO94Fcz4iiHaqWe/a7R0GNhex+tF6I/Ss+MsmIVYRSQ2Dz
	sOjG0svq+frK85GWq2d7qgk01+DyH+2x9RTxmnegEXm+zC/LOV9R6zqWEBkxtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868028;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsdBbJdWQudrz5WjSrEPn66pz8ojPyV2wOpQoiJZO6A=;
	b=o7UAzo8qJv+xWGwRsaYlw1yeBELAYCIJj59W081wVXQgQoViTg7jyk9QVSez6b5FHhUw18
	q4YL0Wb1/JN1FrAQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Rework
 timekeeping_inject_sleeptime64() to use shadow_timekeeper
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-20-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-20-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172986802802.1442.2194874781763485590.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2cc803915f351a845dc6c2e5e8ede1f09a2108d4
Gitweb:        https://git.kernel.org/tip/2cc803915f351a845dc6c2e5e8ede1f09a2108d4
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:41:13 +02:00

timekeeping: Rework timekeeping_inject_sleeptime64() to use shadow_timekeeper

Updates of the timekeeper can be done by operating on the shadow timekeeper
and afterwards copying the result into the real timekeeper. This has the
advantage, that the sequence count write protected region is kept as small
as possible.

Convert timekeeping_inject_sleeptime64() to use this scheme.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-20-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4e0037d..9552bc7 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1924,22 +1924,14 @@ bool timekeeping_rtc_skipsuspend(void)
  */
 void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
-	suspend_timing_needed = false;
-
-	timekeeping_forward_now(tk);
-
-	__timekeeping_inject_sleeptime(tk, delta);
-
-	timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
+	scoped_guard(raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tks = &tk_core.shadow_timekeeper;
 
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
+		suspend_timing_needed = false;
+		timekeeping_forward_now(tks);
+		__timekeeping_inject_sleeptime(tks, delta);
+		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+	}
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL | CLOCK_SET_BOOT);

