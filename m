Return-Path: <linux-tip-commits+bounces-3406-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EADA3A3975F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D411892354
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D90022FF4F;
	Tue, 18 Feb 2025 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="suEsI96s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eBmxk7Oe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B1418E743;
	Tue, 18 Feb 2025 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871990; cv=none; b=Un+nTFRoPTuvGxrmTA9se8BX0e5E9IkhP6sk0rtCNfYC1W6n/uzzbzMEgvFOoX/HN/nszsT/id5XFdievbdhkqDEvGCB9x+AyQNyjDhhNOAyp1gBDYn1L9m4+SIYG2zIFf4kXGUyn7qrv8De682XJxDgCMxuabHcu2ivscwBkek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871990; c=relaxed/simple;
	bh=ZR25FqMY85SXGeNNrb6C20zFfWAQ+m9U58pE9hoiksw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AH3XGGn90vnus/ZlVqPVyf5DWKYtUHSYqS02g45uSy9u9QBzGsDnN7P+KtpYca89ZG83Of4SpTFnP49GQXIU0XWHPoWbSZNNRyBN2P2gStxXVFMqZxERad3y3E+15DTTFDvVPCRm7L1NcikOWSUSHUvQE0pzCeUgMu/Z9gJPi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=suEsI96s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eBmxk7Oe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871987;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lmkYftcRL8EGf58s9/7CI05dmodeWPyM+tQFhxcdLo=;
	b=suEsI96sQr5nXfbtZm6OhqkVRs0ul7ii3VOmt6ptL2di+aHGqnv0vLY0sFy0/OHHTfuGHn
	3496dW5tUHU+vcXJgnO55FmB4disOxM+gaOt6fjA5OljUzIDJC4ZxQZcZ49syjCWXJWWEh
	ZXA4Y97+kJiFyHb4SmDPHKubhq9Zg5eaHz5nWKgLq6m5pgTCFWiuVshrPanG/tOp0AczKn
	0A3/G7V7X7KkvTBI3ucYklwDQ1snNX49NgJWudgSHd2YjYxUJqMxVgDOZ9g+FBZWyNVwTQ
	m7j4lKtWKTdIaNU3ppvbxhxPNUgeS3iI95FkOhZGVmI6sJA1gopDjCgcDan/JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871987;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lmkYftcRL8EGf58s9/7CI05dmodeWPyM+tQFhxcdLo=;
	b=eBmxk7OeLmg3cQjybYv/F8Br07Vawm4l0wRoqW49oWcvTWGQb2AgPuon2MgrCKFL15428V
	seLEraSmVbXK9qDQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] null_blk: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C076cd30acb4b2d6b699f3c80463a8983530d4f06=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C076cd30acb4b2d6b699f3c80463a8983530d4f06=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987198650.10177.6744553006177110952.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     68d3de7fc49c326205811a23d0a146feed0d4fee
Gitweb:        https://git.kernel.org/tip/68d3de7fc49c326205811a23d0a146feed0d4fee
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:39:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:34 +01:00

null_blk: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/076cd30acb4b2d6b699f3c80463a8983530d4f06.1738746821.git.namcao@linutronix.de

---
 drivers/block/null_blk/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d94ef37..1645733 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1426,8 +1426,7 @@ static void nullb_setup_bwtimer(struct nullb *nullb)
 {
 	ktime_t timer_interval = ktime_set(0, TIMER_INTERVAL);
 
-	hrtimer_init(&nullb->bw_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	nullb->bw_timer.function = nullb_bwtimer_fn;
+	hrtimer_setup(&nullb->bw_timer, nullb_bwtimer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	atomic_long_set(&nullb->cur_bytes, mb_per_tick(nullb->dev->mbps));
 	hrtimer_start(&nullb->bw_timer, timer_interval, HRTIMER_MODE_REL);
 }
@@ -1604,8 +1603,8 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
 
 	if (!is_poll && nq->dev->irqmode == NULL_IRQ_TIMER) {
-		hrtimer_init(&cmd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		cmd->timer.function = null_cmd_timer_expired;
+		hrtimer_setup(&cmd->timer, null_cmd_timer_expired, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 	}
 	cmd->error = BLK_STS_OK;
 	cmd->nq = nq;

