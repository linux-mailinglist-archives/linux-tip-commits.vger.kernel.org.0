Return-Path: <linux-tip-commits+bounces-2581-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171B49B0C71
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C01B23ECE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0CE20EA25;
	Fri, 25 Oct 2024 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y4lmS67x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KHKaB8iT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DC020BB5B;
	Fri, 25 Oct 2024 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879280; cv=none; b=qC3a5kR4B88zSIScr0xTu4mm6YI5iS6qMDGOCu2/xQNThtRCp9m+LmT8s2UVQZXrGZQTwO4xXul3JBBsXSYKSG+4kC4qqEZ0+iP21GIGqoQup3HGd0Yo5zgfmxse/Knoy9Y0KC3SIPEVSaxfrvoaAqV/ZM+/gC7pC1maI9gFRQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879280; c=relaxed/simple;
	bh=C2DvclD02YbyNWVKIaPx1NhHlV1yzQ4KM46lhkg75EM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=D+3QLBOXXfxmN7fQNzhJikSyKPD8FCQWUxQzuKXVn12IVhjCO4EgKH4HSwSPo/ejuAwNmmF1/lRYxlIc3aNQadsab4GkKIamDdhpwqaqC8rzqZ8HbD57d9zgNeuxlKgzwLIXedtenUDlA/8A+sy9Ve5O7H16ju4xjkJpJKj3c0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y4lmS67x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KHKaB8iT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879277;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4MaRrgQSry/8T/wd5vE2To0AFEtg0Fd3E7skUB7KCg4=;
	b=y4lmS67xEySu9RkLNq+RoGfX8lbvHktQaQk3AAps5VfxJQ4acqVHMRKAFuKFzEI2+mqHEu
	LQMIcwCK1AEymz3nuWaO8LmOznM1N33khvklm5DcC7mLf1jMejdVpcQ03BTZkepW+zkrbR
	oqedVpdh22w6Q/5qpJxssLihfDsxuMJ8n+oO5BVKdipK2ElDulUVqwEl15veiT57NJEe06
	doUMrOAP8s5h/LMn7GSsggPWAnHjCRGURi8BuX40uWBVFlMpsJVj5iIHWOcKzsiDgKGFrQ
	IGzhH4D+lvTYiNgGk5jMnhXFpUWGKqVXR/ZBj4qtSSxrgn4/RXwcFtUSApE8hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879277;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4MaRrgQSry/8T/wd5vE2To0AFEtg0Fd3E7skUB7KCg4=;
	b=KHKaB8iTvUSkt26EZ6P5zyUMddJb4jM6SFX+F7V1WkGhbzFeHIYLny7qYa5z7guovfAcoT
	ZGhN/156m89d90AA==
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
Message-ID: <172987927681.1442.7398743165778403580.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2b473e65dea6be1a60d357f0afe46ecb6bf91501
Gitweb:        https://git.kernel.org/tip/2b473e65dea6be1a60d357f0afe46ecb6bf91501
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:15 +02:00

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

