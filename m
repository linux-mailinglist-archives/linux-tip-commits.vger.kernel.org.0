Return-Path: <linux-tip-commits+bounces-3484-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3CAA39923
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE573A73C4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F882475C0;
	Tue, 18 Feb 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1+YkI9d8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5uASk5My"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1B2451C5;
	Tue, 18 Feb 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874401; cv=none; b=GObJ3P77VRWnh6eQ9E2GEioQsg878tvm2oh7mY8jN9D/5sNfQ4+pYrgroL7q8wwryyPaDZsXjujYv6BRluuoc7NWTtu9pstVFkd/IKifGaD62kxlDTupUZxY5Fc2Lq3xdpRJSgRtfvFq40t9l+m/BWskYEHmoucXnF72+gf0NZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874401; c=relaxed/simple;
	bh=7MXF16EqikDKSThwjGsK43P7IQ6OYTrtmyiL8T8AhFY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TEd6bSojR2Hoq0XzipjJMnU6LCAsOjHrEw1I0GBG7Es8YxlFEfSisnQo0UeOLr8T5APgOtiT3Csrt0v5Ij2b9lbUwvtYw4JjD3ezDG26WFpPi4evRbXe9+ghBTb1b+jmqaQdQtUPlVqDRXiQsVUi6hrpxc5+8j+ETferFQjgdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1+YkI9d8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5uASk5My; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYPmd6Y+MpaKmH3zZTkvCETFWzup4EeKDvq5chJypjk=;
	b=1+YkI9d8yckkhfnqxaeb4DF7U47M5QJOuxeyU6sSl2yO6vQFo6rD3EekkaBMw24sE8UNPK
	rB4BPkMP7iWsa5Lzhp0mmu0t2fmD5HfGIA6rC8hCAZUZeexexyhWvLWa0s8meGjlFhb0U9
	rrywJikNiXONrZCWfxSaaSmTkSFMRFUIZSxKMYPgWE8bxSyPL5JPpmGX/EO0z75hpiGvct
	I96bry+++CjHTD6M5rpH8zZIo612P4vwpk45nKGygFp0MKHEe3Hx8HbSjL0+1TXkoBID56
	/sBPQecr9EWsLQJR/k51eSu5LLKRSwtkoLSRo+SpihMcNGFuRc/0R0RzE0siCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYPmd6Y+MpaKmH3zZTkvCETFWzup4EeKDvq5chJypjk=;
	b=5uASk5MybCSXNIvCNp3Tyq/Jz7sOlNtPEMYUwHYSmwpxbQXDEcsUVEgsOb4U95VA1O5ijE
	2ZLag0gq1Cd6r9Bg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] power: reset: ltc2952-poweroff: Switch to use
 hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C75ef5206f52f194b9c51653628cd2d0b083a482f=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C75ef5206f52f194b9c51653628cd2d0b083a482f=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987439695.10177.16411219137394575352.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     563608c20403ebee8a5d4d4bda7c0ba75485acba
Gitweb:        https://git.kernel.org/tip/563608c20403ebee8a5d4d4bda7c0ba75485acba
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:06 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:04 +01:00

power: reset: ltc2952-poweroff: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/all/75ef5206f52f194b9c51653628cd2d0b083a482f.1738746904.git.namcao@linutronix.de

---
 drivers/power/reset/ltc2952-poweroff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index 1a6fc8d..90c664d 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -162,11 +162,11 @@ static void ltc2952_poweroff_default(struct ltc2952_poweroff *data)
 	data->wde_interval = 300L * NSEC_PER_MSEC;
 	data->trigger_delay = ktime_set(2, 500L * NSEC_PER_MSEC);
 
-	hrtimer_init(&data->timer_trigger, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	data->timer_trigger.function = ltc2952_poweroff_timer_trigger;
+	hrtimer_setup(&data->timer_trigger, ltc2952_poweroff_timer_trigger, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
-	hrtimer_init(&data->timer_wde, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	data->timer_wde.function = ltc2952_poweroff_timer_wde;
+	hrtimer_setup(&data->timer_wde, ltc2952_poweroff_timer_wde, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 }
 
 static int ltc2952_poweroff_init(struct platform_device *pdev)

