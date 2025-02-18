Return-Path: <linux-tip-commits+bounces-3405-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F916A3975E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986771892229
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0157F22CBD0;
	Tue, 18 Feb 2025 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DQpWgOp8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PnVYHiA3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAF5653;
	Tue, 18 Feb 2025 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871989; cv=none; b=OZjyqDgV8Btob0/ur1nl5gQMMSpKH0scHvV1QEWq/lwnchlMWLQOtMmFGMx43iOpyrpmohZo7O6W+27OM9uQwsB6QtgGr1DzqcIvfqSuXw2jf3hOwMTzk1cp1OKMMq7yoY+NS0u4jUrLz+PwkgxvGjJdI338hUmz/t1CKPPk4+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871989; c=relaxed/simple;
	bh=A8+a9ymOl3LKrHAIC32mnM8MKQsmdtypiNjkP2g1glw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FULE1aWwp82cCyZiJbzLjllibvy6dl+ZxOKvmUko/vrKVk608G0EsL1fF4Y1L9R90NrvwFUkzj1by33GUwAdSyYCN3OSfwvt/+ivxLqV8+yfg1/JFSBfLqgLzv56Z9ouNZFLzXmgngHpU8Bd6vJQWjjpI0OOAndI8OgLMpI0ggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DQpWgOp8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PnVYHiA3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871986;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOM0xv7DCdQvc71Mrn/g4+s717Actq9qsGD0/sJLqzw=;
	b=DQpWgOp86rZ/QUCzBveU/jwk4n7jyYEt9KSHGMCkxedLuerJOc2bWb5TXIaKCGr9Mwyjqd
	5M08rTnhG2KTfb2nt4efrDqzECBO7bBhob4x1uhook85otKI7tVSBJsH70/GDQvYDTulhd
	XHma0Hoi19h0gXKZwkvbWddmBh66eYILdro9VPbj/h6DvCk9a7Nhc+shkcR4KMdk5vKCDB
	1dRxe/oCeNmo1ffTJq7TSwUK6uYdBACSk9/1QXWn6HClOZwkEE2mTtbumqVFSWCWQRuFmf
	rN5Dyp3NluJbGZr0RL9lsoYAIX2b7ksdDeet0mcgkwFY1cgcwcgoilDwbuy43w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871986;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOM0xv7DCdQvc71Mrn/g4+s717Actq9qsGD0/sJLqzw=;
	b=PnVYHiA3tSN8ZcYbjObpYOI09Cry9NUqjFYh15z6JHhhGpz8KSGkvFkRz9CSw25ZS0Dov+
	0D5IDw/5zFCpTJAw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] hwrng: timeriomem: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C010640f1668d40894a1721037c56f7a684dbcc5f=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C010640f1668d40894a1721037c56f7a684dbcc5f=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987198293.10177.15839286335954474666.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     8030d4673e9957df30a8a0fa4228917b954f71c0
Gitweb:        https://git.kernel.org/tip/8030d4673e9957df30a8a0fa4228917b954f71c0
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:39:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:34 +01:00

hwrng: timeriomem: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/010640f1668d40894a1721037c56f7a684dbcc5f.1738746821.git.namcao@linutronix.de

---
 drivers/char/hw_random/timeriomem-rng.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/timeriomem-rng.c b/drivers/char/hw_random/timeriomem-rng.c
index 7174bfc..b95f6d0 100644
--- a/drivers/char/hw_random/timeriomem-rng.c
+++ b/drivers/char/hw_random/timeriomem-rng.c
@@ -152,8 +152,7 @@ static int timeriomem_rng_probe(struct platform_device *pdev)
 
 	priv->period = ns_to_ktime(period * NSEC_PER_USEC);
 	init_completion(&priv->completion);
-	hrtimer_init(&priv->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	priv->timer.function = timeriomem_rng_trigger;
+	hrtimer_setup(&priv->timer, timeriomem_rng_trigger, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 
 	priv->rng_ops.name = dev_name(&pdev->dev);
 	priv->rng_ops.read = timeriomem_rng_read;

