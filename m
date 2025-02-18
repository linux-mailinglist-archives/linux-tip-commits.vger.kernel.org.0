Return-Path: <linux-tip-commits+bounces-3479-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4087A3991B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B293A3457
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72989243979;
	Tue, 18 Feb 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="18eNIi7y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FPVeQYnm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282D24336B;
	Tue, 18 Feb 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874398; cv=none; b=XpnF+HoxBAT8j8WbI2qZyN6ForRfqZ2hCFJxIhip3HWCoBUjocrukMDBxMQTq86JZ2HAoDeoCH58KSDhQbyNSu6MHDpO0mkwyWhAJBVaBFiCzeN1yJFuXyHmYQMKMBaZkL9Uln07dSITJ4PB7MnQJZWWnIBouY9wPt+SETkHsCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874398; c=relaxed/simple;
	bh=k64F/Ac7FSLD3Kg442R3EotduNy5+e2epMczWoKqo54=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=acxCqVA0Wvtx3N6hMbEToZCUztLMQ5guIpd51Lb2q9ZkoWKUKreOBdcKY/GlsKv4bmRlSDZiKZpHySgAqrk8jExBQDSmzYww2WDPY7VZmr7FiS8COaF2019mZgbenTfp5GGXNVeES8ww9a+FDZXKRkZQr9P7TJCMqiqGiXu90Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=18eNIi7y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FPVeQYnm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3v3vaHO/hT1UdE2BlCdVCN90X8lNBF7Sc4JCYmjHDtQ=;
	b=18eNIi7yzcMsChjzdJBK4EReWRBCTTkXUZzp8DbduQd6iTPLpbuQDBIGAaORxyaxOE811T
	eaKf2uxzSQj3GDwYCiwPkt4yme61hal1NEjGpxUAvDLA12r31JpdysxHbl1fOKR/jQHFCh
	9rbww8ROs0yDSugr2nPD3ip3v7YNIqFuuWDowKJpO9kIYmERJnS9ks+QhhwuALF56daNho
	XfN08r4q2HTOqczYJsOXAEPHsyctWVo+A1nFCYBIgL2nEZEbiM3LpbRyGlxSQ2yzHUbLcE
	Nfw8bNlQJlTfFb1ub8jXdFUwCjuyoFi7T8UhMdtpb0CfRLBugH2nLxn8Tho7Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3v3vaHO/hT1UdE2BlCdVCN90X8lNBF7Sc4JCYmjHDtQ=;
	b=FPVeQYnmu1DADJfclqGCQYOum7XfWB3O8mv1Firyl3wDpMt6XOamq6K9T9Jkl+Z1JsTVKl
	48i5/YXv8b9ECUBQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] media: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Zack Rusin <zack.rusin@broadcom.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cc725ad8d0ecac3cf6bbc532af567e56d47a6b75c=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cc725ad8d0ecac3cf6bbc532af567e56d47a6b75c=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987439385.10177.18246795562273186744.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     0ebb5e74db095156c392e96479846b4b46df7829
Gitweb:        https://git.kernel.org/tip/0ebb5e74db095156c392e96479846b4b46df7829
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:04 +01:00

media: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/c725ad8d0ecac3cf6bbc532af567e56d47a6b75c.1738746904.git.namcao@linutronix.de

---
 drivers/media/cec/core/cec-pin.c                     | 3 +--
 drivers/media/pci/cx88/cx88-input.c                  | 3 +--
 drivers/media/platform/chips-media/wave5/wave5-vpu.c | 4 ++--
 drivers/media/rc/pwm-ir-tx.c                         | 3 +--
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/media/cec/core/cec-pin.c b/drivers/media/cec/core/cec-pin.c
index a70451d..bebaa40 100644
--- a/drivers/media/cec/core/cec-pin.c
+++ b/drivers/media/cec/core/cec-pin.c
@@ -1346,9 +1346,8 @@ struct cec_adapter *cec_pin_allocate_adapter(const struct cec_pin_ops *pin_ops,
 	if (pin == NULL)
 		return ERR_PTR(-ENOMEM);
 	pin->ops = pin_ops;
-	hrtimer_init(&pin->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	atomic_set(&pin->work_pin_num_events, 0);
-	pin->timer.function = cec_pin_timer;
+	hrtimer_setup(&pin->timer, cec_pin_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	init_waitqueue_head(&pin->kthread_waitq);
 	pin->tx_custom_low_usecs = CEC_TIM_CUSTOM_DEFAULT;
 	pin->tx_custom_high_usecs = CEC_TIM_CUSTOM_DEFAULT;
diff --git a/drivers/media/pci/cx88/cx88-input.c b/drivers/media/pci/cx88/cx88-input.c
index a04a1d3..b9f2c14 100644
--- a/drivers/media/pci/cx88/cx88-input.c
+++ b/drivers/media/pci/cx88/cx88-input.c
@@ -190,8 +190,7 @@ static int __cx88_ir_start(void *priv)
 	ir = core->ir;
 
 	if (ir->polling) {
-		hrtimer_init(&ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		ir->timer.function = cx88_ir_work;
+		hrtimer_setup(&ir->timer, cx88_ir_work, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 		hrtimer_start(&ir->timer,
 			      ktime_set(0, ir->polling * 1000000),
 			      HRTIMER_MODE_REL);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index d132029..8479dc9 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -269,8 +269,8 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 	dev->irq = platform_get_irq(pdev, 0);
 	if (dev->irq < 0) {
 		dev_err(&pdev->dev, "failed to get irq resource, falling back to polling\n");
-		hrtimer_init(&dev->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
-		dev->hrtimer.function = &wave5_vpu_timer_callback;
+		hrtimer_setup(&dev->hrtimer, &wave5_vpu_timer_callback, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_PINNED);
 		dev->worker = kthread_run_worker(0, "vpu_irq_thread");
 		if (IS_ERR(dev->worker)) {
 			dev_err(&pdev->dev, "failed to create vpu irq worker\n");
diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index fe368ae..84533fd 100644
--- a/drivers/media/rc/pwm-ir-tx.c
+++ b/drivers/media/rc/pwm-ir-tx.c
@@ -172,8 +172,7 @@ static int pwm_ir_probe(struct platform_device *pdev)
 		rcdev->tx_ir = pwm_ir_tx_sleep;
 	} else {
 		init_completion(&pwm_ir->tx_done);
-		hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		pwm_ir->timer.function = pwm_ir_timer;
+		hrtimer_setup(&pwm_ir->timer, pwm_ir_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 		rcdev->tx_ir = pwm_ir_tx_atomic;
 	}
 

