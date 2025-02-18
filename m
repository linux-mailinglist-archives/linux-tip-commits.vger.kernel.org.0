Return-Path: <linux-tip-commits+bounces-3470-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5295A398D2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B6F188EB27
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393CA23FC43;
	Tue, 18 Feb 2025 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rE9m709y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rUSLS+tR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620BD234972;
	Tue, 18 Feb 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874392; cv=none; b=ACv88RuSkt4EWHITWkDKNrwc5U7C2JHypZdNlsIyyc6CDZn+oaKEIPLfhHH4PLu8GZz0oejkE8oBvyek7JWJCd+sUAZglYfwNTI8mbtJ5pJOQ1xPrTuYNPDXdABrwBJCRkygY4y0Hpp5WXgpaNd37ghPGMoqeso05IyEidOksMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874392; c=relaxed/simple;
	bh=JG7ihXwlGWuxqJbuzEmz5VxaATV7mmL0UAlyijXO5G8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dOj98JujIfYv6LFvInwpb5KSX8gFs4/b7Ps3eUIdCMpCJ8paMCKkMuEB4eqaad8xPEHX/UG5nMmaym90lxtLdbVIjJPzAWwkijrQNNyykdeGYDTzXXrGbwbCVCtE+AYHjazExAhr1QcRawoPQeHyTC+LybqHNz4sbjcjwLpmNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rE9m709y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rUSLS+tR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmaRp1+yBAM5/s1uEVvq4gDTOHieeMjjRb1+kwrtUZc=;
	b=rE9m709y4o6QFoqdaM1UjADRBPpAJpPrPo3nRG8HNfDYv+4k/DFD0uEMB66gjEqhCdS0ij
	IkC/gXh6ALOeDO0i747X3JbwNOdUAzGx+2eZvdquvjrQcioX39LLmPBZr2j2g0zg3v638r
	DeQqvfQjmzfjiBUbFzVmkcYZ6r7b0H0DDAvyw1ZiKCACRV6whJpThe3nTHgblbg8pXQuGg
	nvOpNRyeAIJnuLYSjoLnVKasx+a26QTcF1taey5e7erpElqzfTIgH3XgQMcb0Mw6vc7x3v
	jfCHLxzaE9fJSNtQQUyJ6wI4pGxv/g48rawIlp4UT04tTRMX7Fjik0790F++6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmaRp1+yBAM5/s1uEVvq4gDTOHieeMjjRb1+kwrtUZc=;
	b=rUSLS+tRCZwBrGmDC49xoEvwfNsSf4nOHx2c8VDX1hj9w9rtu2+gSq1bbx5aB4lhzSk5Em
	dRoyjH8WmgifK5Cg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] drm/i915/perf: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, Jani Nikula <jani.nikula@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb712673a02c7132ea85eff57b0e7e59f6d5d0da0=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cb712673a02c7132ea85eff57b0e7e59f6d5d0da0=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987438814.10177.4516683381564352346.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     7358f053c4d6ef2692e4860b6d46b8f33c9aa1d3
Gitweb:        https://git.kernel.org/tip/7358f053c4d6ef2692e4860b6d46b8f33c9aa1d3
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:06 +01:00

drm/i915/perf: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Link: https://lore.kernel.org/all/b712673a02c7132ea85eff57b0e7e59f6d5d0da0.1738746904.git.namcao@linutronix.de

---
 drivers/gpu/drm/i915/i915_perf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 5384d1b..279e266 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -3359,9 +3359,8 @@ static int i915_oa_stream_init(struct i915_perf_stream *stream,
 		"opening stream oa config uuid=%s\n",
 		  stream->oa_config->uuid);
 
-	hrtimer_init(&stream->poll_check_timer,
-		     CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	stream->poll_check_timer.function = oa_poll_check_timer_cb;
+	hrtimer_setup(&stream->poll_check_timer, oa_poll_check_timer_cb, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	init_waitqueue_head(&stream->poll_wq);
 	spin_lock_init(&stream->oa_buffer.ptr_lock);
 	mutex_init(&stream->lock);

