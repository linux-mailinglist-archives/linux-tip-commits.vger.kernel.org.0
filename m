Return-Path: <linux-tip-commits+bounces-3476-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BC2A398E0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB39188CD0C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436CB243371;
	Tue, 18 Feb 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sIDgX4xv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qAzfcWzj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070924113E;
	Tue, 18 Feb 2025 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874396; cv=none; b=DDUm+a/nYNhLNX8OUmR6MHVIVi0D5mbBybGBsjIUfY9X3ihfaz+eq5Q/G35JI35hSOqf24vqH5qgl+iLI3mWndcW49qaKa24dDbYJkOjqxNn/rDetJ3eP1snaxBB0RwF/Mc0BQWnbtGVNLSQV58Hg1QvBl0MM1s+2NfAfog2XKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874396; c=relaxed/simple;
	bh=pvlGj1I01zpsDEEic2q/2rLKNDUEAB1hsaB+mKL9/wU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GUpbz0nCzjfFQzPQptGaq2VR9uRxuFI3rXaTlxTay+NDHvmjnwBwyGVz4gEw9ei1y1TjhVTShekzUqf+xR7Z4CEpwQ6iUBBgWB1IXubT0V8Muz2/ivStbUTj1BNOzsQmG/VkzXf1xqGLZwF9kVduNMQslXensALU+i4v5cOHp1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sIDgX4xv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qAzfcWzj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdEho1+hvIl5F11CAuMWhA6zA4lur0XobHR4R5WsqJY=;
	b=sIDgX4xvV7NzU/Tk3YU2W+LZztzDmQEwYWXCxADxA+LXO4aFlUlC21QqahCqiuwpRSqP7/
	SGufHS7/+8lF8yGQOyKIIMjNIzehIJFcaRwR8nFaP8iG9FmX1suFPsJixEJGaPt6RDuBew
	Uy7ekPmK86KDHoDcWNQMn/Z3xjXQ7Ka18peAaguRoGqoPUI21lRsRvqlYTQvWHzU6pvtJU
	PFpNDAt/38FaK+ckuNBYa4k38NkD6iRkUkwKBKNBtJBgJ35WIcLw9vhAoz2TAL5tGch3bh
	9mdcKqJm1N6uWPIiW8mg2Eu6QeVL+WIa3KBCW3/eEiHCoHf823NedZ0C4vIS7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdEho1+hvIl5F11CAuMWhA6zA4lur0XobHR4R5WsqJY=;
	b=qAzfcWzjKdiK6OBmy4PBHyzzY4XRht7+hC+QczVTbj9lNCtj4BTSDImzNiSgzTQxIBXnne
	YcDpL4R2Pfx5+SDA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] iio: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C570792e31b28a94a511c19c6789f2171a6745685=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C570792e31b28a94a511c19c6789f2171a6745685=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987439197.10177.17785823876266132760.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     c69da1735f19d93c63fef5d38d9ff3b1c56587da
Gitweb:        https://git.kernel.org/tip/c69da1735f19d93c63fef5d38d9ff3b1c56587da
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:05 +01:00

iio: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/570792e31b28a94a511c19c6789f2171a6745685.1738746904.git.namcao@linutronix.de

---
 drivers/iio/adc/ti-tsc2046.c           | 4 +---
 drivers/iio/trigger/iio-trig-hrtimer.c | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 7dde571..4956005 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -812,9 +812,7 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 
 	spin_lock_init(&priv->state_lock);
 	priv->state = TSC2046_STATE_SHUTDOWN;
-	hrtimer_init(&priv->trig_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_SOFT);
-	priv->trig_timer.function = tsc2046_adc_timer;
+	hrtimer_setup(&priv->trig_timer, tsc2046_adc_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 
 	ret = devm_iio_trigger_register(dev, trig);
 	if (ret) {
diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index 716c795..82c72ba 100644
--- a/drivers/iio/trigger/iio-trig-hrtimer.c
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -145,8 +145,8 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char *name)
 	trig_info->swt.trigger->ops = &iio_hrtimer_trigger_ops;
 	trig_info->swt.trigger->dev.groups = iio_hrtimer_attr_groups;
 
-	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	trig_info->timer.function = iio_hrtimer_trig_handler;
+	hrtimer_setup(&trig_info->timer, iio_hrtimer_trig_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_HARD);
 
 	trig_info->sampling_frequency[0] = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
 	trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency[0];

