Return-Path: <linux-tip-commits+bounces-4660-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E08FAA7BFA5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 16:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34483BBF7B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 14:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFA81F582A;
	Fri,  4 Apr 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B65T0Pbs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zwNSuBBq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2701F540C;
	Fri,  4 Apr 2025 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777383; cv=none; b=nBLNfZQ/IaxG5SWy/aKKsa9mgbffNAbTEtRTzCT+tlu5l2t0xIpDO34rTmZO9GoG0uiUu1gWQpRGXr0WCDzJTzKPTjxQIgMa/Qf7EgPD/fbyX1eSERWx+TbYdgZ/qICq4bJnzif6DVkPX54y78cWxslrjkVlWvJLuqyXTPg4Sh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777383; c=relaxed/simple;
	bh=3GR+5zqzUaiZaL10fhL4l50tG1KP2KWpEDBL9p/4qjg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=D3+n3B95N2eAA5TRHEALQdB/CnZUato8RNwoT4vtZ3JEMm67TvmWMCP67nt+38hfyu5Nl92BszLeeG8TsOjBS5LhLoTjICX4oZwJptHHVhKc2Fp3GwtgoSBjNDLKTtA8Yiq4A1laY6U/ltTmnY5w17N1MWuyHLkcP9RY51neNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B65T0Pbs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zwNSuBBq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 14:36:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743777380;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIYrmUd5RKpQFflfxB3lp8KzRYD2z0TUldh977BLUS0=;
	b=B65T0PbsoOAY4M1pmRWV6rL3TkkKNiaZxM/FlwBBX1NYQ1mO/Ylol3C87vWL7BGLfMVI8G
	Lumof6fYzPEKs4y6qAJqtJHTlhP6p9AQ2lmLfyAJY92nmAo7wN9R5l3bqQQE0C4+gwWM44
	o6VGJlNzB4d8kvNL9CS82GP1KkJ9tw7RLsRaU2OASdbA5rQ7y9gWhGyAMeRhbhrXRfFmbG
	7yNW2m9eIHz2FfCaIbZBmf/tEMei/PtDFJ6yFSqgzAgCuM6HTjH1cPrkQdYu5LV6KVOIwu
	jIWuoBdd6ytXAZSnIPNUcq7y9H4lhM2kh6P7GunQOF+hPieRgMf/CrZPgHBpHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743777380;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIYrmUd5RKpQFflfxB3lp8KzRYD2z0TUldh977BLUS0=;
	b=zwNSuBBqudQXfv0fFFictSsICdqnE7hdQb9ZSCu/kkGHHUQzXpab8wUlvjP0uUt5VwrNNE
	+66FlOdtu87oiVAQ==
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
Message-ID: <174377737931.31282.16685195575482632099.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     63c35edadf1d30e9aeeace9f12a80ead96daa4f2
Gitweb:        https://git.kernel.org/tip/63c35edadf1d30e9aeeace9f12a80ead96daa4f2
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 16:26:09 +02:00

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

