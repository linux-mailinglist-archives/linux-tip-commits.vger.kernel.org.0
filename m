Return-Path: <linux-tip-commits+bounces-4688-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2147A7C2E9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B717189C7AA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6786C21D5BF;
	Fri,  4 Apr 2025 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GcPyipaY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QGbCQmgw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE99021C9E3;
	Fri,  4 Apr 2025 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743789279; cv=none; b=GrPynKYmXR6PtozZy3WveE7tnat8aiQfMFVsszIkjT5+3uM/LMfwTHrMyHn6GswtjKstuFOMRGieCJSV6NQSKj/8m2b5fQCbXisQHkUjlqBMhn2dCI2a6FBVsZszx+FwyICUMIGYIC+vmoNXPpzL0UqoE+gU3HXSm6ddPY2qngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743789279; c=relaxed/simple;
	bh=k76VRLC4oFC2wOaYnhoW8okozuGmTUk5XrH/3Z6STQo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sFWyXjvFIeIJYfHHJ/+G4ua4ETn2U8SCH1mZCL0E0D8wTEyC9KRkTcfVJ5QLbJcf7V4zQKhO0Ni0ifj9pRz6fgGAcoXmnjHLpyc/ojCkhPKWyh2oJrDRLJR+zwUrJVrpbhoa9hOywPUwiloYUBTMW2VOILWxT3liq5jJsut1MTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GcPyipaY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QGbCQmgw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:54:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743789276;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dn/bmcnUzInRG5lJWXuXDoxStCU6qWrrpVKVdUrkXEw=;
	b=GcPyipaY5SVqoGlmPOyZAS54BGW2Im0YRkkE9fTxDNp5PusOhyz3PVj+p/L8gKxK3na/GT
	OcigUiEEUybigZ7FWUzsUabzTi9WAbRvmwfxgoOeoz0OXDUTVGAtFBlCeGV520LRxR0WZY
	3Abf9BHOUTvWLnr1Ci+KMrjTQa1V7rFklS2ixJPqBG7dR9jTpsffAR+/Su735AEMT2cUVP
	atgAWxh4sll+YEj/bgotA8IQtO9n6Xxo4rnue3KupcRHorhXb5Fz1PRNGxPEt0k/8lF2KE
	m5cbi+D3F0JxrQ01IJqqieS5dG0mB9agmJ1FClKaqBmRweOTPzkMB4lxJELoBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743789276;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dn/bmcnUzInRG5lJWXuXDoxStCU6qWrrpVKVdUrkXEw=;
	b=QGbCQmgwm6YbwOcCL5QEzRAmtrBcNkpGGwAvR2z4typr8o1Y6G1hd+3Jgeu+GYWjxLXt89
	TreLM8S4ri6O16Dg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Merge __hrtimer_init() into
 __hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C8a0a847a35f711f66b2d05b57255aa44e7e61279=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C8a0a847a35f711f66b2d05b57255aa44e7e61279=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174378927585.31282.7640327274318309561.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     25e846814bbb905520a00e9e428c0247edea35c0
Gitweb:        https://git.kernel.org/tip/25e846814bbb905520a00e9e428c0247edea35c0
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:46:06 +02:00

hrtimers: Merge __hrtimer_init() into __hrtimer_setup()

__hrtimer_init() is only called by __hrtimer_setup(). Simplify by merging
__hrtimer_init() into __hrtimer_setup().

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/8a0a847a35f711f66b2d05b57255aa44e7e61279.1738746927.git.namcao@linutronix.de

---
 kernel/time/hrtimer.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 2d2835c..163cde3 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1592,8 +1592,9 @@ static inline int hrtimer_clockid_to_base(clockid_t clock_id)
 	}
 }
 
-static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
-			   enum hrtimer_mode mode)
+static void __hrtimer_setup(struct hrtimer *timer,
+			    enum hrtimer_restart (*function)(struct hrtimer *),
+			    clockid_t clock_id, enum hrtimer_mode mode)
 {
 	bool softtimer = !!(mode & HRTIMER_MODE_SOFT);
 	struct hrtimer_cpu_base *cpu_base;
@@ -1626,13 +1627,6 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 	timer->is_hard = !!(mode & HRTIMER_MODE_HARD);
 	timer->base = &cpu_base->clock_base[base];
 	timerqueue_init(&timer->node);
-}
-
-static void __hrtimer_setup(struct hrtimer *timer,
-			    enum hrtimer_restart (*function)(struct hrtimer *),
-			    clockid_t clock_id, enum hrtimer_mode mode)
-{
-	__hrtimer_init(timer, clock_id, mode);
 
 	if (WARN_ON_ONCE(!function))
 		timer->function = hrtimer_dummy_timeout;

