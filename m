Return-Path: <linux-tip-commits+bounces-4696-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF61A7C84E
	for <lists+linux-tip-commits@lfdr.de>; Sat,  5 Apr 2025 10:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE487177F22
	for <lists+linux-tip-commits@lfdr.de>; Sat,  5 Apr 2025 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780D91DE2CB;
	Sat,  5 Apr 2025 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HmgOBD92";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gJT6fTgg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C681D89FA;
	Sat,  5 Apr 2025 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743842805; cv=none; b=oSa362VUNcru4/5yAIuX42YuctMdO8tB46eHMtrE4db+EzBScpDTltkKyUV2ibaMeJ/OBR/Rc4cghtzy2R7KZXzee3s11yqJ3f3YAtjRncz//ZcRC+9tC6pqItUjiPAUbKrO6sFQ97i7cyTTDFOd+KfAGdG5o3vY1ga3WEXK7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743842805; c=relaxed/simple;
	bh=XBZ/LImc/tx60+rNPFz8Mypw2cGw/3ZlpSyaQYEikG0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VXdsqym+F4in1TTLcFZiA4ah51BgqUZdMjCO64NPA87d1Mi2XfQ9HVt0KJnb4egJqmRSa54571dItmb7wv5Vc/9H6gx7FddedN/mT6CuzM8FEF8q+3AoUXJak1q5QSfWP/rA1f/09sia4Zrxk5yJMSMGFYAYtoDmO8BlhCFsOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HmgOBD92; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gJT6fTgg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 05 Apr 2025 08:46:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743842795;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCOVR5OATdJwGl4Ddf+Lauj94m7tLOYwfKx0Bj8CTRI=;
	b=HmgOBD92VcMHsR21tqOtrUeHvrNCZoeP8e4Ryv9MRFjl38GlzBimJf4HOb3wpaN3l6VAXs
	5OG4pUf1j4kD5yBbmCh3Y3cy8smRsp8F7XMhcBcppZyshUKTa6FZ32wNJrVsMC4B6fd94G
	tMznzsnTaDLd9nm8RyQS61hw7Dl2FopAHI5Vq/NjHWsilYPmoJCl3/9M6hKJwHsh6J476w
	nwhSILYaa+sOSYqhvoM1/eto14zWkdWgARGvOi46fYxsfr6A+Fyi2Z63Yh+4rz5CWn4191
	UJ2psKOX1jpKrzb5LGIQmSIYQhFQ7UVF4x+Nk36Ldot+m9D1bDFmwnnbz36KsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743842795;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCOVR5OATdJwGl4Ddf+Lauj94m7tLOYwfKx0Bj8CTRI=;
	b=gJT6fTgglQEFtbvhcnvAq8yCfp0E5CtdUiLEREwOeQJv3ijI52/TwdZtj3rUhUkCFxzI5p
	ofOdJIcHKDvsxbAg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Rename __hrtimer_init_sleeper() to
 __hrtimer_setup_sleeper()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C807694aedad9353421c4a7347629a30c5c31026f=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C807694aedad9353421c4a7347629a30c5c31026f=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174384279511.31282.16424788609335284727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     fcea1ccf2476ca793b0ca3f80ca23f5a28cbb0b3
Gitweb:        https://git.kernel.org/tip/fcea1ccf2476ca793b0ca3f80ca23f5a28cbb0b3
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:18 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 05 Apr 2025 10:30:17 +02:00

hrtimers: Rename __hrtimer_init_sleeper() to __hrtimer_setup_sleeper()

All the hrtimer_init*() functions have been renamed to hrtimer_setup*().
Rename __hrtimer_init_sleeper() to __hrtimer_setup_sleeper() as well, to
keep the names consistent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/all/807694aedad9353421c4a7347629a30c5c31026f.1738746927.git.namcao@linutronix.de
---
 kernel/time/hrtimer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e883f65..8cb2c85 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2016,7 +2016,7 @@ void hrtimer_sleeper_start_expires(struct hrtimer_sleeper *sl,
 	 * Make the enqueue delivery mode check work on RT. If the sleeper
 	 * was initialized for hard interrupt delivery, force the mode bit.
 	 * This is a special case for hrtimer_sleepers because
-	 * __hrtimer_init_sleeper() determines the delivery mode on RT so the
+	 * __hrtimer_setup_sleeper() determines the delivery mode on RT so the
 	 * fiddling with this decision is avoided at the call sites.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && sl->timer.is_hard)
@@ -2026,8 +2026,8 @@ void hrtimer_sleeper_start_expires(struct hrtimer_sleeper *sl,
 }
 EXPORT_SYMBOL_GPL(hrtimer_sleeper_start_expires);
 
-static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
-				   clockid_t clock_id, enum hrtimer_mode mode)
+static void __hrtimer_setup_sleeper(struct hrtimer_sleeper *sl,
+				    clockid_t clock_id, enum hrtimer_mode mode)
 {
 	/*
 	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitly
@@ -2067,7 +2067,7 @@ void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl,
 				    clockid_t clock_id, enum hrtimer_mode mode)
 {
 	debug_init_on_stack(&sl->timer, clock_id, mode);
-	__hrtimer_init_sleeper(sl, clock_id, mode);
+	__hrtimer_setup_sleeper(sl, clock_id, mode);
 }
 EXPORT_SYMBOL_GPL(hrtimer_setup_sleeper_on_stack);
 

