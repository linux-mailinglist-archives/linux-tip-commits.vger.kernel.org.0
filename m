Return-Path: <linux-tip-commits+bounces-3489-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5971A398E9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770D37A2879
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4630A2594BE;
	Tue, 18 Feb 2025 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="raRJIa4F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xm3Wbkmi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64485248186;
	Tue, 18 Feb 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874404; cv=none; b=l2LGLOrn7nDudHz6FTD21e9zkqrIo4kBD/1N1xxn4WVU9gG30EVU7H8WrjgOy+xwSVErZ5jE4Zprk1DDOEwIN/RjBW6glsUltCFDXk4yWlz0mPMV1NizVnqZ3ZrZRA37JTW+wjvM730vqLc+3KBbXu1aomZZ1wNFZoVGfRd0mbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874404; c=relaxed/simple;
	bh=4eCnF4ivg6hnSLtoh3YCTo9692z7i3by6ncD77sU5Mk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oyR7Yk9ZWjv1KniwoQn1z0CO0HlX4IiYVnmOWE70TjUH9P/S7m3zWQVpMZ9VJwVo49mgPuek5Yh1qOjw33LCH1TuyBr4CSsdKWJveoE988KMC+t9ej1KNUMpRDboeYuI26FoYbD/s+ilnn7d6lhkkyvX5veBMLLor7DZxuc1MBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=raRJIa4F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xm3Wbkmi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gLbuiUWcwWd4bXH96NX0RI8w3txovjnRTN2U79ST0h4=;
	b=raRJIa4FfTpoCPtZrr+F1dfGYHqk7cvo4IL/XBq33xM7BMNs2e0wMoC6ZuDkZ6iIhAFhIV
	SrC+dsVsawstDr7Hiin/2G3meZhjsOQwaE2xsX6gRBXptIgkBwY52U39hCmtBrj7dWnWJH
	1VxF8tG4r+G7YWtNqCK76TGq24+50DScaOFSh58bNkRv0abvvP1ZsCYj6rl3lGEjjECINw
	vHbhpyzxIK1HWMKf9UL7SKNZo8OW2iuUBL5IuzRiPZezFf5mZvC/80JWvmsbt7NAY3d87Z
	zW/RrCYQoeaQLHdABobLtLW7WMy387VnWr8WhMNHQSLvfQHQqsHs9FKGr8Z0sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gLbuiUWcwWd4bXH96NX0RI8w3txovjnRTN2U79ST0h4=;
	b=xm3Wbkmie3HzUNZvuw3Tb287IJkR6D5FeBpwwK79Yw7XDFgRLuw6cDnTxgj9Q7LbsZ86Wg
	fSrKoPWbar5+OSCQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] rtc: class: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C22f3f087ddbab1708583033c07c3b7fb17810110=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C22f3f087ddbab1708583033c07c3b7fb17810110=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987439956.10177.8584812026566714351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     c92697913fdc5fe0e16ec8e9cfa29c4300069918
Gitweb:        https://git.kernel.org/tip/c92697913fdc5fe0e16ec8e9cfa29c4300069918
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:02 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:03 +01:00

rtc: class: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/all/22f3f087ddbab1708583033c07c3b7fb17810110.1738746904.git.namcao@linutronix.de

---
 drivers/rtc/class.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index e31fa0a..b88cd4f 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -240,8 +240,7 @@ static struct rtc_device *rtc_allocate_device(void)
 	/* Init uie timer */
 	rtc_timer_init(&rtc->uie_rtctimer, rtc_uie_update_irq, rtc);
 	/* Init pie timer */
-	hrtimer_init(&rtc->pie_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	rtc->pie_timer.function = rtc_pie_update_irq;
+	hrtimer_setup(&rtc->pie_timer, rtc_pie_update_irq, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	rtc->pie_enabled = 0;
 
 	set_bit(RTC_FEATURE_ALARM, rtc->features);

