Return-Path: <linux-tip-commits+bounces-4675-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 334C6A7C278
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0941B60ACE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3916A21D3F4;
	Fri,  4 Apr 2025 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qDwCTewa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8iTh2wi6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E5E21D3D0;
	Fri,  4 Apr 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788053; cv=none; b=PvQ8+fkvZsbK6MP25YCYWLzeafWzzb2WuLnPtlzfAhPYxDHx540LOVEVD/DVK698C767rg93F/f5p9+OulnMymzd0ZiqPtlcdQy/drqporcunFFQ2o1RIqGdJOHRs4i5eIydjL2/sPu3/bLqh8kvDVJka8Hx9aamJx2AKxl0QWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788053; c=relaxed/simple;
	bh=SA7ZpsqpFB1M/8Qe2G73ueKE2L+aj70QQ/ZrdJXgGc4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ON/laL6/0N60BTx6BOmkEQBw9iG0LAWjEtGou5hCctmu2ZzqYDUYR7U44gOTUf/5TETtPQyMS8YTXTwzXFx94WZhfTt4PlGNf2C514wfgKy3CJ1/PD9U8nh6vlQeYP7/7JUXXh284hdAgi+dOUDt5nWlQ8xgTuWUewVjK9udKIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qDwCTewa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8iTh2wi6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:34:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743788050;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hU9ErGd7k1ZR0WnI0v49ytv0j1jqBU7QSssbTwy3xg=;
	b=qDwCTewalLaCz3H1XOhuOkcqTiFgF5oGB6mcAYLYyRZD/FO3xJWwLg/lx9euEkc7rlNMAk
	E7xzT0sa0t3qtwtc+xNOLLdc959RoOSQ+dOi0ldLfiOvBbJc/nekWXS4F1SnKUSKaouGlj
	Tu4egFIMXuDYz7b82NpqvChDcgSvlVZBJXHvBi82QnwVUES6jARKnjMnXR6V4fhS7/Njvn
	3Remgz/l4E2NuR4eOCNnw8Ajx9WJOT7KHb04PmffenHHjx/3wUdl74SBFvIVGpkAPUwGtT
	cB4VJdN6oj6dEIT5REBX0uYocTEa/JIaJC4UEYwMJiui76qtvn9OTEwvMEaP9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743788050;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hU9ErGd7k1ZR0WnI0v49ytv0j1jqBU7QSssbTwy3xg=;
	b=8iTh2wi6rl9q/Ht7siaBykyVQ62LC4afW7XChIfgcGv2ZxLKuUyu9aPCjhIu99K688M0fm
	J4UReDbxgS4dDcDA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Rename __hrtimer_init_sleeper() to
 __hrtimer_setup_sleeper()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
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
Message-ID: <174378804949.31282.2835684316926029885.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     69d621b6302208d96885e13e8187e7e16418b947
Gitweb:        https://git.kernel.org/tip/69d621b6302208d96885e13e8187e7e16418b947
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:26:44 +02:00

hrtimers: Rename __hrtimer_init_sleeper() to __hrtimer_setup_sleeper()

All the hrtimer_init*() functions have been renamed to hrtimer_setup*().
Rename __hrtimer_init_sleeper() to __hrtimer_setup_sleeper() as well, to
keep the names consistent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
 

