Return-Path: <linux-tip-commits+bounces-3467-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740BEA398CF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D75B17568F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F2D23AE8B;
	Tue, 18 Feb 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UmOpW+Ji";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="11WHlStG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1F0238D43;
	Tue, 18 Feb 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874390; cv=none; b=HVigUB5mUeIICuQdA4MYp6RgWpp6rypSaKLxGIH37vIpv6hv5wuq6R0UprG/BDWato99YAq6kesm0eq+aPt6LXfiXfevjMTGo10rCxUD7h3N7WLXp83B3h+ROkQCKbVGPkq1kTrFR5QVNowoDBK3NbOQCuDgAtL6hiUj9ACnMuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874390; c=relaxed/simple;
	bh=calH7WEsiY//zHk3LYaDfCaM5fLPgqfXDeglEbKY5rE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gs2h2s4AjXsT34bMOQXeq45eBq2yK6ZX6XXszwpy1vwH9Bjt9H6K2PNsQdnvnQStMbpRJG5OI9UdigR0iNjF6vio141Iq04T4ZRsnaogw680rGbmzE7Nfi6cfF0uOMCtjeIv/R2pl6z7WJrh4VpA3Law0ron1S5ZAwcYpN+fPrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UmOpW+Ji; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=11WHlStG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874386;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DC4GQg2IvT7qZJc7JjpzIKArW8g6rwG4Jsn1VPJGMqM=;
	b=UmOpW+JiVWSAgnJflt9hEYclIti0ky+pKqgPAdlTo9KE3n4+gZs0KsaO+NHNJp/qaFqiBk
	NO0/D0iJ/CpusktuJL0//S6GMCqQO1lRtO5YVmELbDwET4fOriAS3sQIeq7uMpoAH6z61R
	QKv/CQ45wuU4+MsB7jZfjJjrz4spxVbGoQmw6wZIbXCGao24psAyrFfDgeOYkumOUOItG4
	WL+v/LcNhlNrV1BTSdh/tjwvYmE9CNZENSCYdVq3lzqydCWZeXphHxB1cmWQlTYp7GB2Ve
	AT+Y97N6KKTEIQSB1R8pW4ScjNThnWk6qxoIPo2WqwwI53TM15/puyd+j0Brjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874386;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DC4GQg2IvT7qZJc7JjpzIKArW8g6rwG4Jsn1VPJGMqM=;
	b=11WHlStGOO2MNZwnxFlzt0/n0HlGMsN6kPstfAbaAOkrf6c24anl6Kh5zbDKKlrVEI8OPp
	VWOnhheqOj1AeQCA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] drm/i915/request: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, Jani Nikula <jani.nikula@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4fe658e6d8483e44d4fff579bc426e627487f6ca=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C4fe658e6d8483e44d4fff579bc426e627487f6ca=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987438604.10177.16281628877035265681.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     1a2ff5c3058d3811b092736cbbd3ae09ea308dd2
Gitweb:        https://git.kernel.org/tip/1a2ff5c3058d3811b092736cbbd3ae09ea308dd2
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:06 +01:00

drm/i915/request: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Link: https://lore.kernel.org/all/4fe658e6d8483e44d4fff579bc426e627487f6ca.1738746904.git.namcao@linutronix.de

---
 drivers/gpu/drm/i915/i915_request.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 8f62cfa..ea0b8e7 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -293,8 +293,7 @@ static void __rq_init_watchdog(struct i915_request *rq)
 {
 	struct i915_request_watchdog *wdg = &rq->watchdog;
 
-	hrtimer_init(&wdg->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	wdg->timer.function = __rq_watchdog_expired;
+	hrtimer_setup(&wdg->timer, __rq_watchdog_expired, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 }
 
 static void __rq_arm_watchdog(struct i915_request *rq)

