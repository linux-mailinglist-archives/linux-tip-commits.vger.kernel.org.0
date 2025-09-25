Return-Path: <linux-tip-commits+bounces-6751-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5C5BA1966
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25BF1C81DED
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BB332BF2E;
	Thu, 25 Sep 2025 21:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WkLvDKD/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EfXiaE1R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA92332BBEE;
	Thu, 25 Sep 2025 21:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836016; cv=none; b=I22Vbj1tWByx2scIGb//OB7B6bInpfjOmXBwLWwUpkhSxtPSs8P3cBcoAVL9b1SKYyB448P1NIP5m/XI9chv0pm+EkK3uiEfBz4X6yHbOnNnV0qdZq7nATPRGKT802aZML9Daopi4gWHhrMUOjXs2O+m0tztXqujva8Iop2IB9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836016; c=relaxed/simple;
	bh=Aw68vyzJ3/D86z2EM0BICYhevrof8xhy9Bj9dtZmbP8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=RmteTwk/G48eeLC28egIBOS2NICn8uvTJ+zYMi46O+7E2qGhT55c0TeXgQUMaZan3W+5n7LI73D/ib+5DSr8rSR5GNq8UUBkjz6DGw43Jly3+43D+HaE90dLts5P1HhvEgnOlggejuXfaRhbYC86/t7PIqBsF6XFvSVMDswYO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WkLvDKD/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EfXiaE1R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=WOmKZLSpnFmlHE6fQv4hM/8QNhC8/A4nn3XoHv+DFWM=;
	b=WkLvDKD/B9FvHU6W1GuRXliiNqczzPua3NWLCGj8ePsRgWVIIqKwuRzBaelnSFjMw0ESgJ
	lqCmJAsD079yCElko3J1S6qGr0gRMATLh59Y0edWndyZrDjqllZ22T3nAjxjrU5X8qYpCm
	fqpVQaGVLRgwE5b+0wN24kfDzwW8mXqCvZ+qBCnuyw7TOtLb2ndnj0i4jycwNR4RdN+xhs
	kHsupC+F2FJtGMbWSirb12SlOUtkG8lq6qwWjcV7MUxLowbOmZoHGSzmX9gkItSHSDbUnr
	2nyGW8KcctBKGYYBTfeO44z9HUugXLlRBCPdWT81s4ujHAey98vdGHvURdMDHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=WOmKZLSpnFmlHE6fQv4hM/8QNhC8/A4nn3XoHv+DFWM=;
	b=EfXiaE1RfOPYuO/Z0O/mxxCJP/GlpbdjIYwTbSBdyvzhIWwb147WkvwZzr/1xGrGhj+ieL
	eC+inCkZ+GqG8SCQ==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/vf-pit: Allocate the
 struct timer at init time
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883601185.709179.4057737731058240934.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     375fbfc66ca23873c3d9b1c5f6739bf0e2875a57
Gitweb:        https://git.kernel.org/tip/375fbfc66ca23873c3d9b1c5f6739bf0e28=
75a57
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:25 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:29:02 +02:00

clocksource/drivers/vf-pit: Allocate the struct timer at init time

Instead of having a static global structure for a timer, let's
allocate it dynamically so we can create multiple instances in the
future to support multiple timers. At the same time, add the
rollbacking code in case of error.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-8-daniel.lezcano@linar=
o.org
---
 drivers/clocksource/timer-vf-pit.c | 48 ++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
index a11e6a6..d408dcd 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -37,8 +37,6 @@ struct pit_timer {
 	struct clocksource cs;
 };
=20
-static struct pit_timer pit_timer;
-
 static void __iomem *clksrc_base;
=20
 static inline struct pit_timer *ced_to_pit(struct clock_event_device *ced)
@@ -189,38 +187,66 @@ static int __init pit_clockevent_init(struct pit_timer =
*pit, void __iomem *base,
=20
 static int __init pit_timer_init(struct device_node *np)
 {
+	struct pit_timer *pit;
 	struct clk *pit_clk;
 	void __iomem *timer_base;
 	unsigned long clk_rate;
 	int irq, ret;
=20
+	pit =3D kzalloc(sizeof(*pit), GFP_KERNEL);
+	if (!pit)
+		return -ENOMEM;
+
+	ret =3D -ENXIO;
 	timer_base =3D of_iomap(np, 0);
 	if (!timer_base) {
 		pr_err("Failed to iomap\n");
-		return -ENXIO;
+		goto out_kfree;
 	}
=20
+	ret =3D -EINVAL;
 	irq =3D irq_of_parse_and_map(np, 0);
-	if (irq <=3D 0)
-		return -EINVAL;
+	if (irq <=3D 0) {
+		pr_err("Failed to irq_of_parse_and_map\n");
+		goto out_iounmap;
+	}
=20
 	pit_clk =3D of_clk_get(np, 0);
-	if (IS_ERR(pit_clk))
-		return PTR_ERR(pit_clk);
+	if (IS_ERR(pit_clk)) {
+		ret =3D PTR_ERR(pit_clk);
+		goto out_iounmap;
+	}
=20
 	ret =3D clk_prepare_enable(pit_clk);
 	if (ret)
-		return ret;
+		goto out_clk_put;
=20
 	clk_rate =3D clk_get_rate(pit_clk);
=20
 	/* enable the pit module */
 	writel(~PITMCR_MDIS, timer_base + PITMCR);
=20
-	ret =3D pit_clocksource_init(&pit_timer, timer_base, clk_rate);
+	ret =3D pit_clocksource_init(pit, timer_base, clk_rate);
 	if (ret)
-		return ret;
+		goto out_disable_unprepare;
+
+	ret =3D pit_clockevent_init(pit, timer_base, clk_rate, irq, 0);
+	if (ret)
+		goto out_pit_clocksource_unregister;
+
+	return 0;
=20
-	return pit_clockevent_init(&pit_timer, timer_base, clk_rate, irq, 0);
+out_pit_clocksource_unregister:
+	clocksource_unregister(&pit->cs);
+out_disable_unprepare:
+	clk_disable_unprepare(pit_clk);
+out_clk_put:
+	clk_put(pit_clk);
+out_iounmap:
+	iounmap(timer_base);
+out_kfree:
+	kfree(pit);
+
+	return ret;
 }
 TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);

