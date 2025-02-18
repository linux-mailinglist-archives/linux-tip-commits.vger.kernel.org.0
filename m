Return-Path: <linux-tip-commits+bounces-3413-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9171AA39769
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7DBD7A2D10
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2CF238D28;
	Tue, 18 Feb 2025 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lE660Pcy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+bgD1BM2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC80235346;
	Tue, 18 Feb 2025 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871995; cv=none; b=fYID7uXEaTfwNc6LGH5LABGXAEXwc4QN7LbMz4qso19Ky3PJgP6veA4WPOIMTNAV88zr0T5WccasE7GDvTfhP3uTlxMuA5qHY0o5XXxannKx8OEA9W1vCZ5qfmGufbiR+tbGXch5ssiifhRuVli5EiQtoK7eIWXGphsX7FeRlzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871995; c=relaxed/simple;
	bh=2bCc+cH7wOC9uTV6zX7HR4np7BoHs5BqStjsejPxc2c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jhL0cnpKX1/URqDSQlaiVm0DQLLqYwIyHjh7bBR9EZlOTolup3xK8MBUQpVX1tRDF/r3/8R49CjQLehxbcTFR1xbwBXk/U0gkVsIllw0qRFAtA0ULuIkzkYSxZuRrT/rtFzkYUGGqKAkCb6IDhMwRiH9NmpCdz3DRsoh5D+7IEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lE660Pcy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+bgD1BM2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871992;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANhGy+mmlg2hY3YOOmdIhly8pP5zr6hRfEUG5nIfXXw=;
	b=lE660Pcyo07nQrKFlGO84qd7va4VOVWkI6xqg1abe/Uk5logyDUDRqZ5uFJmVAvHi5oofQ
	21h8z5A1DtZoEzVaqxdEEAZ+LWwmmPbc/HUGIkr2u1bD1PhtxHI0Z3thLIcMhaleKyDCIp
	8SnyEPUOb5e+7qwbz9imjcZ0s/YXCTiu6uFTB6LM1WhcBQS0zly3sfav0a6AtzhnPk9by5
	vU0aUUALRsOjCv7QxPRDiLWhjZFgZ7X1ym4x7JtWHYWcB0LhZ/Njg8/psk7b6OJVq7nA8t
	6EPZ48robbF+u56Vb6Cjkhl33R7jNnrwOEAJz/Y+HlkzEtL2pRt5JUF9VyGIdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871992;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANhGy+mmlg2hY3YOOmdIhly8pP5zr6hRfEUG5nIfXXw=;
	b=+bgD1BM2yIPDueII5rxpdm5VCnIl2HCIyhfPDt855F2d9rt6xahkWoRhkBpAyytSdVgZFr
	FDkmn9CrNunOTmCg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] watchdog: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca5c62f2b5e1ea1cf4d32f37bc2d21a8eeab2f875=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Ca5c62f2b5e1ea1cf4d32f37bc2d21a8eeab2f875=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987199145.10177.8808739283421726234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     d2254b0643222ffa7e4e7ac0ae8aa0e4cbf6d09a
Gitweb:        https://git.kernel.org/tip/d2254b0643222ffa7e4e7ac0ae8aa0e4cbf6d09a
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:39:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:33 +01:00

watchdog: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/a5c62f2b5e1ea1cf4d32f37bc2d21a8eeab2f875.1738746821.git.namcao@linutronix.de

---
 drivers/watchdog/softdog.c                     | 8 +++-----
 drivers/watchdog/watchdog_dev.c                | 4 ++--
 drivers/watchdog/watchdog_hrtimer_pretimeout.c | 4 ++--
 kernel/watchdog.c                              | 3 +--
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index 7a10962..0820e35 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -187,14 +187,12 @@ static int __init softdog_init(void)
 	watchdog_set_nowayout(&softdog_dev, nowayout);
 	watchdog_stop_on_reboot(&softdog_dev);
 
-	hrtimer_init(&softdog_ticktock, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	softdog_ticktock.function = softdog_fire;
+	hrtimer_setup(&softdog_ticktock, softdog_fire, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 
 	if (IS_ENABLED(CONFIG_SOFT_WATCHDOG_PRETIMEOUT)) {
 		softdog_info.options |= WDIOF_PRETIMEOUT;
-		hrtimer_init(&softdog_preticktock, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL);
-		softdog_preticktock.function = softdog_pretimeout;
+		hrtimer_setup(&softdog_preticktock, softdog_pretimeout, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 	}
 
 	if (soft_active_on_boot)
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 19698d8..8369fd9 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1051,8 +1051,8 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 	}
 
 	kthread_init_work(&wd_data->work, watchdog_ping_work);
-	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	wd_data->timer.function = watchdog_timer_expired;
+	hrtimer_setup(&wd_data->timer, watchdog_timer_expired, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_HARD);
 	watchdog_hrtimer_pretimeout_init(wdd);
 
 	if (wdd->id == 0) {
diff --git a/drivers/watchdog/watchdog_hrtimer_pretimeout.c b/drivers/watchdog/watchdog_hrtimer_pretimeout.c
index 940b537..fbc7eec 100644
--- a/drivers/watchdog/watchdog_hrtimer_pretimeout.c
+++ b/drivers/watchdog/watchdog_hrtimer_pretimeout.c
@@ -23,8 +23,8 @@ void watchdog_hrtimer_pretimeout_init(struct watchdog_device *wdd)
 {
 	struct watchdog_core_data *wd_data = wdd->wd_data;
 
-	hrtimer_init(&wd_data->pretimeout_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	wd_data->pretimeout_timer.function = watchdog_hrtimer_pretimeout;
+	hrtimer_setup(&wd_data->pretimeout_timer, watchdog_hrtimer_pretimeout, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 }
 
 void watchdog_hrtimer_pretimeout_start(struct watchdog_device *wdd)
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index b2da7de..6a98dbc 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -797,8 +797,7 @@ static void watchdog_enable(unsigned int cpu)
 	 * Start the timer first to prevent the hardlockup watchdog triggering
 	 * before the timer has a chance to fire.
 	 */
-	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	hrtimer->function = watchdog_timer_fn;
+	hrtimer_setup(hrtimer, watchdog_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	hrtimer_start(hrtimer, ns_to_ktime(sample_period),
 		      HRTIMER_MODE_REL_PINNED_HARD);
 

