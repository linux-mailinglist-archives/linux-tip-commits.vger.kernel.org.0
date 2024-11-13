Return-Path: <linux-tip-commits+bounces-2850-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F9E9C7CC6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 21:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B006282F26
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 20:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96472206965;
	Wed, 13 Nov 2024 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hd6hrRAN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F6Eb1cte"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4D18A6C5;
	Wed, 13 Nov 2024 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529252; cv=none; b=ksGRfFUVGSuLXDuZDmxkpR9GX1DxuNCQa6DDLw8h5BjVXoYfNRmj/LoTPWH6AzAJaezmCeI2KR7eYPL5HU9gZqyBi7SyGOXq8KAOUZtSZif9crsj8g9LNwwDOYIMVGrZRrUYBS4VSIF9T2JRHceHRZS9O5PZrpaYghN0r+XWVLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529252; c=relaxed/simple;
	bh=moicPVVtPC380KCnKM31FmSrYRtGfWGPg5cJY/BLWMA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qI9boGCLs7ZtihOTzHyQag2/lSAmW/c8bmC2nyF6VMRTbRtLLrR407E/Jir7lHj1Np5rtgphscAuqpzU0HITRwuSfn1rNYi1qEH6XG9fyE5G6qQZG/j4WpFZqyyREEseyPmvf899b82B6Z5J8ZbRE42CS6Yhpx4DNYdkMmcT9H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hd6hrRAN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F6Eb1cte; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 20:20:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731529249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezHU6cqj71BkVIJ48DzGAqNoUSDFdwpY1pm6ysPGIRo=;
	b=Hd6hrRANrD3L0DImBohpApXE1MCS0aaJ7fDH08aQ9HMmuJmDVUKipQDMBOPk72a1eVuuac
	Kwyy/oKbyH7pFHJGWb2S8M0vMH/VmeiIO/kvX9OkEyLf0Yc0vhUKAWfU1itv1H1ZwIu7ZW
	4GVgSex2EanxB04FukdVx9IOzyr/6KRj/9uoEn9V3HFWsT+lcAg91YrAyXo1WvJcsLm6VA
	AbYpmK1iH3CoaEPGwJ23VKLuAU5zXubb267mAQMW+4BgN6B5UH+cZjJFjLXC2BLbhJsJnW
	K/001g0cZr8EQevs+/pHv5Gv8QjUJbw+CW2fxYrZlQA3JEzkHdA3SQFgIDcYQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731529249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezHU6cqj71BkVIJ48DzGAqNoUSDFdwpY1pm6ysPGIRo=;
	b=F6Eb1cteMnIgxvmRM1rirWurs1ZWEIh3Z8qPY4/6TVFb6A8bHZilGfGiLQhxiGtdihXST5
	AcPlzBo2Jow1M9Bg==
From: "tip-bot2 for Javier Carrasco" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Fix child node
 refcount handling
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20241031-timer-ti-dm-systimer-of_node_put-v3-1-063ee822b73a@gmail.com>
References:
 <20241031-timer-ti-dm-systimer-of_node_put-v3-1-063ee822b73a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173152924816.32228.1809322097420256013.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e5cfc0989d9a2849c51c720a16b90b2c061a1aeb
Gitweb:        https://git.kernel.org/tip/e5cfc0989d9a2849c51c720a16b90b2c061a1aeb
Author:        Javier Carrasco <javier.carrasco.cruz@gmail.com>
AuthorDate:    Thu, 31 Oct 2024 13:54:23 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 13 Nov 2024 13:49:33 +01:00

clocksource/drivers/timer-ti-dm: Fix child node refcount handling

of_find_compatible_node() increments the node's refcount, and it must be
decremented again with a call to of_node_put() when the pointer is no
longer required to avoid leaking the resource.

Instead of adding the missing calls to of_node_put() in all execution
paths, use the cleanup attribute for 'arm_timer' by means of the
__free() macro, which automatically calls of_node_put() when the
variable goes out of scope.

Fixes: 25de4ce5ed02 ("clocksource/drivers/timer-ti-dm: Handle dra7 timer wrap errata i940")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://lore.kernel.org/r/20241031-timer-ti-dm-systimer-of_node_put-v3-1-063ee822b73a@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-ti-dm-systimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index c2dcd8d..d1c144d 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -686,9 +686,9 @@ subsys_initcall(dmtimer_percpu_timer_startup);
 
 static int __init dmtimer_percpu_quirk_init(struct device_node *np, u32 pa)
 {
-	struct device_node *arm_timer;
+	struct device_node *arm_timer __free(device_node) =
+		of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
 
-	arm_timer = of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
 	if (of_device_is_available(arm_timer)) {
 		pr_warn_once("ARM architected timer wrap issue i940 detected\n");
 		return 0;

