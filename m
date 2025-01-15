Return-Path: <linux-tip-commits+bounces-3209-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD42FA11D1A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A6E188BAEE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2A31EEA25;
	Wed, 15 Jan 2025 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AGx5E1Gb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wm+qhrIk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D46C1DB144;
	Wed, 15 Jan 2025 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932584; cv=none; b=S4XQNTOpsqOnCe5ZCUX2hSxQXkl0LUPtDZ3+B2L0S09uZGbtEB6ZFsRNy3BMIuB9AbJ/f1KZaHaVivm/0wPs/0v0P9d5qo6AI5/gylpvfJx+owdNUYfVK9Eeb6yTG3ZSIYxgYEbB1hPpPBmHnxChfPagnvcOirFTtSpA4DV5VJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932584; c=relaxed/simple;
	bh=jcMRvTfYm51yY3q9BwmQHVcJ+ANhQ+BxzGpxlg9mLac=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZwKStDGlUUY3p3vJFEv4WQq1my2P/3ruNSqZTiOaO6fH7Wvx/4ApOy0gOqyXSG0wfqfbaKi4ayYL0LXQaMt/T4GfhXOM11MQ8bNbX3OtqHDLs143y9i9+bGxLrrQrDLfY0Qxm1X/fot0Q/e5QVmfggt1iITSIvKEIOwo3yd3ek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AGx5E1Gb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wm+qhrIk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:16:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932574;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DuGCoUFbLnyVZoafzOy8cUQRnlZJc2Bl77DJrSpEgL8=;
	b=AGx5E1GbZqvMG6l39XmY6Psxsnu82HJQ3NMgAMQ+rdYu8JVf2FtQZvRDIh8GjRHdSxxWDj
	mJwseSpYFVopm5H0DsGnaEGdR/9MG1JYhuQ4sZhqKd4qBU2p6rtLVUJnFM5KA95ZVadMnm
	Vke4Sn4yLHVWjZIZm/kDapiw8tOlWhID4VpgYmueHDioImiX5QKGwyhuoVAyqV2Xlithdt
	Hp6OJzhOOTaBxHLl1+scSsOc5WwenqFEjAI9yDnuVTxXXXtc/zmfXYnHJU6tisBAvpTMzy
	8SZpWaaPOpM0a6rUMh5Ho7w7nsY1N+7V4tEWr+8yqfSBPzIXjw9/jhhTA5dSBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932574;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DuGCoUFbLnyVZoafzOy8cUQRnlZJc2Bl77DJrSpEgL8=;
	b=wm+qhrIkppnrEn8d4LN5fVSyAqbQCb6Vxv+jagKhAp1z+pL+bGrJS5kPkHqQdORFWoJssI
	i2CXf4o6HF7gzJBQ==
From: "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/ts4800: Replace seq_printf() by seq_puts()
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C1ba5692126804f9e1ff062ac24939b24030b4f72=2E17334?=
 =?utf-8?q?03985=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C1ba5692126804f9e1ff062ac24939b24030b4f72=2E173340?=
 =?utf-8?q?3985=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693257191.31546.17424558594145453307.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e3ab1fc9354fabd65ea10ce6ca4153ef07128ad0
Gitweb:        https://git.kernel.org/tip/e3ab1fc9354fabd65ea10ce6ca4153ef07128ad0
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Thu, 05 Dec 2024 14:12:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 09:59:42 +01:00

irqchip/ts4800: Replace seq_printf() by seq_puts()

Simplify "seq_printf(p, "%s", ...)" to "seq_puts(p, ...)".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/1ba5692126804f9e1ff062ac24939b24030b4f72.1733403985.git.geert+renesas@glider.be
---
 drivers/irqchip/irq-ts4800.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index cc219f2..960c343 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -52,7 +52,7 @@ static void ts4800_irq_print_chip(struct irq_data *d, struct seq_file *p)
 {
 	struct ts4800_irq_data *data = irq_data_get_irq_chip_data(d);
 
-	seq_printf(p, "%s", dev_name(&data->pdev->dev));
+	seq_puts(p, dev_name(&data->pdev->dev));
 }
 
 static const struct irq_chip ts4800_chip = {

