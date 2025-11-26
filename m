Return-Path: <linux-tip-commits+bounces-7549-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C98C8A66A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 15:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFF404EC31A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17849303CA4;
	Wed, 26 Nov 2025 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MRX0VkXm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LG8qTpEf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C75305E3E;
	Wed, 26 Nov 2025 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168050; cv=none; b=WUbU6PGqwsxbWomt+aG1cqFwu7zbsfT0PwQcUNa4OjjHMkRm+zs7o0plXrQnDRMlX8zH62bD7oXemT6YgVecukSHu3lbQA0oZqh03D/4O8XZnZ8NDq/TWQbLj107OqBg0kORYoceaUspfVmZRYrVzUsJvXdZGzk+RdIYsubC9Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168050; c=relaxed/simple;
	bh=0BII9uQVKJVsqpPmF5IjPSiXTQEbncmz6PEqDQKVg6I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kaB3fFwizlJxY3fAdoK2G55sJeE/iy8k26cV+NujBPowBX3b84sUQVZMD5WDLPzS/6U0ssXq4UYQHHGz34DFkYAniKahhoMFvp/C1UMES1Zm657Ygu980JmK5ClgDWQjfAVG1FQ36B4YKobB5+KOgg9dwuawTLcfoUX+tosmsBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MRX0VkXm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LG8qTpEf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 14:40:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764168046;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQ+BmBmUfqq0t8XdE4Dd3XEMJ/cIQ7Va9efQxE+kAI8=;
	b=MRX0VkXmRF4fIRqgZuyk3shIOS1/j941Whm1u7MPiiu5Xkx5yRFBenwAOinGmY4FzUnYkZ
	tbNww3iK7KM3XPIXIrUTXly8PS7GwM7mpXt1u/0RjRgk4KHkpNeyy8i6PE0VLv77IWUKWU
	AdPc+vB3JEG77m1OpZdDxvW+MgQtK1qfZxH68vksKPM5gzgPZKIIi+44j+nG8fxaTgjLCs
	dNiX/fNZg00S7mw06aviAJILGv7PzjtoFDPIkphqlbWjITHuTTg5LQi7S00r1V2KXxfQk5
	sGmlBPcq2l2LC+JDczkQ1Q9HP7228HcX16xY8RgJ0ogJOlZ2l28HrvEGNKBFcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764168046;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQ+BmBmUfqq0t8XdE4Dd3XEMJ/cIQ7Va9efQxE+kAI8=;
	b=LG8qTpEfHE/LdElXVFnwbgTxmQIEyqtahYDUoEIgClOtT0snyJ2NcWdyGQY0gR2bNcwZs6
	qP/SK8+RAauoJmBg==
From: "tip-bot2 for Haotian Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/ralink: Fix resource
 leaks in init error path
Cc: Haotian Zhang <vulab@iscas.ac.cn>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251030090710.1603-1-vulab@iscas.ac.cn>
References: <20251030090710.1603-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176416804552.498.11893379377163894520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     2ba8e2aae1324704565a7d4d66f199d056c9e3c6
Gitweb:        https://git.kernel.org/tip/2ba8e2aae1324704565a7d4d66f199d056c=
9e3c6
Author:        Haotian Zhang <vulab@iscas.ac.cn>
AuthorDate:    Thu, 30 Oct 2025 17:07:10 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 26 Nov 2025 11:24:34 +01:00

clocksource/drivers/ralink: Fix resource leaks in init error path

The ralink_systick_init() function does not release all acquired resources
on its error paths. If irq_of_parse_and_map() or a subsequent call fails,
the previously created I/O memory mapping and IRQ mapping are leaked.

Add goto-based error handling labels to ensure that all allocated
resources are correctly freed.

Fixes: 1f2acc5a8a0a ("MIPS: ralink: Add support for systick timer found on ne=
wer ralink SoC")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/20251030090710.1603-1-vulab@iscas.ac.cn
---
 drivers/clocksource/timer-ralink.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ralink.c b/drivers/clocksource/timer-r=
alink.c
index 6ecdb42..68434d9 100644
--- a/drivers/clocksource/timer-ralink.c
+++ b/drivers/clocksource/timer-ralink.c
@@ -130,14 +130,15 @@ static int __init ralink_systick_init(struct device_nod=
e *np)
 	systick.dev.irq =3D irq_of_parse_and_map(np, 0);
 	if (!systick.dev.irq) {
 		pr_err("%pOFn: request_irq failed", np);
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto err_iounmap;
 	}
=20
 	ret =3D clocksource_mmio_init(systick.membase + SYSTICK_COUNT, np->name,
 				    SYSTICK_FREQ, 301, 16,
 				    clocksource_mmio_readl_up);
 	if (ret)
-		return ret;
+		goto err_free_irq;
=20
 	clockevents_register_device(&systick.dev);
=20
@@ -145,6 +146,12 @@ static int __init ralink_systick_init(struct device_node=
 *np)
 			np, systick.dev.mult, systick.dev.shift);
=20
 	return 0;
+
+err_free_irq:
+	irq_dispose_mapping(systick.dev.irq);
+err_iounmap:
+	iounmap(systick.membase);
+	return ret;
 }
=20
 TIMER_OF_DECLARE(systick, "ralink,cevt-systick", ralink_systick_init);

