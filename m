Return-Path: <linux-tip-commits+bounces-2780-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 849439BFB79
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A841F22803
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A67D53F;
	Thu,  7 Nov 2024 01:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pXEb4PPS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3LvgRv79"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D385748F;
	Thu,  7 Nov 2024 01:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943094; cv=none; b=kZ5ieZFEMssxZU15lukIK6AEZIKJinrRGm8N8UEXoD8ChkXkS2fRGR4imKS4mf8+LhjmVDdTguTp0RGxrPxgEy6SQZzk4QipgqcPooy1P4DHjPXbREig/yZ+j1pfiXDgGaoTXxOpIKjnmu/Lyyb/eAxebKiz6poJyT6OVeE5MkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943094; c=relaxed/simple;
	bh=ApJbTd+4UsdGIyBRQimM2VcgZPY38VIJDgh4PMNy8JE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rFG6KYdERcPIBplS3zwCr36VMMTWWjl/nwlXzRFpSDJQVXjdxVmQxCNA63epfrBzizraEXMwIbaP21kXH+CYZt19aiC114To4pidewlHoEmylFgkpU3VzKtYbmgXt5oyLAglRCnodkwuYPhIdinN11P9Jsjs6IN2snkFIqu7WIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pXEb4PPS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3LvgRv79; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:31:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730943090;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7cpHMrh4Q1z50hfg043itEaVtM63uwOiFcvZIyvCNE=;
	b=pXEb4PPS/g5X6fMyl10uXCTwX7FZGWKwXTXZypIMPZWXvIcA9bawisaXIaQ/8WlHn78c5b
	p9VPmTFPIRZ4yriuuJpFj6GrRK3njjj86jY3SiHm7Fsh1k2RDWjyybAb2TBcsYdNAFfpyy
	2inZ9V147DSGyj97ZfGtQpu8u1sHfrNiNWGThgTfyb7kn/5ZdKohgsH+cmu//qKsQFOBXP
	9RSAR+ErTQ1wtVysW5Iiv34/D1xfIGiEWnoZmCnNyvZQ3OXxT1QIhmX9fRykBlgAGW9eIR
	YPhE1yAN8bszjY/Mtew108yrW1mWPIb67BsGooYJYinEGV0V9Q+sRr0kq9fU5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730943090;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7cpHMrh4Q1z50hfg043itEaVtM63uwOiFcvZIyvCNE=;
	b=3LvgRv79wOwgLjvKtadC+MIBKYsheumHDTb+087F4JoHZfETDk4/A3im/+Zk3GtKyFv6Ne
	V8Kvon2NGt0NnxAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] alarmtimers: Remove the throttle mechanism from
 alarm_forward_now()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105064214.252443020@linutronix.de>
References: <20241105064214.252443020@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094309012.32228.8445690067949850761.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6b0aa145786dab25c6b8e79ad70ac3382c381596
Gitweb:        https://git.kernel.org/tip/6b0aa145786dab25c6b8e79ad70ac3382c381596
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 05 Nov 2024 09:14:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:14:45 +01:00

alarmtimers: Remove the throttle mechanism from alarm_forward_now()

Now that ignored posix timer signals are requeued and the timers are
rearmed on signal delivery the workaround to keep such timers alive and
self rearm them is not longer required.

Remove the unused alarm timer parts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20241105064214.252443020@linutronix.de

---
 kernel/time/alarmtimer.c | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 8543d7f..593e7d5 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -467,35 +467,11 @@ u64 alarm_forward(struct alarm *alarm, ktime_t now, ktime_t interval)
 }
 EXPORT_SYMBOL_GPL(alarm_forward);
 
-static u64 __alarm_forward_now(struct alarm *alarm, ktime_t interval, bool throttle)
+u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
-	ktime_t now = base->get_ktime();
-
-	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && throttle) {
-		/*
-		 * Same issue as with posix_timer_fn(). Timers which are
-		 * periodic but the signal is ignored can starve the system
-		 * with a very small interval. The real fix which was
-		 * promised in the context of posix_timer_fn() never
-		 * materialized, but someone should really work on it.
-		 *
-		 * To prevent DOS fake @now to be 1 jiffy out which keeps
-		 * the overrun accounting correct but creates an
-		 * inconsistency vs. timer_gettime(2).
-		 */
-		ktime_t kj = NSEC_PER_SEC / HZ;
-
-		if (interval < kj)
-			now = ktime_add(now, kj);
-	}
-
-	return alarm_forward(alarm, now, interval);
-}
 
-u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
-{
-	return __alarm_forward_now(alarm, interval, false);
+	return alarm_forward(alarm, base->get_ktime(), interval);
 }
 EXPORT_SYMBOL_GPL(alarm_forward_now);
 

