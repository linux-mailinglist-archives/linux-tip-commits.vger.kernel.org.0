Return-Path: <linux-tip-commits+bounces-6744-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014C0BA1954
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5431E3B9E8B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3715329F3D;
	Thu, 25 Sep 2025 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IvCWxsVx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="om3W1OPp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091A2329519;
	Thu, 25 Sep 2025 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836007; cv=none; b=Ss/xBjDBKph8PlQGUbRay7M9k9DKkBQfBKt6NLf3yaDTAlRWdDwLfWUT9rasECovhrEtVOtJ5VkFovWbt+YgnbhazgCwd34/QH2mEsw93cTvBTsOlmfSPOkyi4pfNB66sxq7FaxWwdfzQfT4Zkgb8q+dh6SOgJHaUua4IEUV4sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836007; c=relaxed/simple;
	bh=1PT342UwfDv9xTAA8jsCdrYg0CvK23qXHXTElIiPbIs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=k0ApBCgJNzriTh4qQPm+fmqDPNQ7BpOphIrbeBKangEQ2lkKjTL7TVq7QQZcVVPIjoU2TvDjFZB7exwDyBwgEhzNjAuF1wHStyehPO79Yi0WpF6jdd7GgF44+pW21sn3iLmTd1Urs5EPdJ/v+oKl6Bn5z1nqaOilQaOdyLno7Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IvCWxsVx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=om3W1OPp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836004;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=I5rJzwmBKzNJBcx3Lv+OVulO2WEye8JF93tjGNzS8no=;
	b=IvCWxsVxxrc6w7YvuRvBdRa+4oX1rDkRX3FOovXbMAQFZ3RYFZSrFEt9VKapdWyb0wiSiB
	zlu+ZoEJAkgM8w2/HJyzqmxPLXC08ecof8JPziKcYR/pgLq7AfiNwlroQPE3O3zjsqUzYP
	3/ss+RYi49p7liRZXlYadkyf/NxvMtfBfT0otMXQEJ31bwwhL/yhfw84KC3wPEdlMBjBNT
	9vkDrnVbprhs8euvnx7FFe1VWtv9q2uWQcwF2RgK0/MyeaYLkF4Tu+CtANYcIvsO0S2Xbi
	aMHmBtop7HocCFtswi+snQw/MjNb+12Rjdy3/HB/wr9veCI2ZuF5+YyW+hpFrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836004;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=I5rJzwmBKzNJBcx3Lv+OVulO2WEye8JF93tjGNzS8no=;
	b=om3W1OPpOaO9lDEH9S3EdnE21ieE/fsSRGi90cDya7hmhrvuor8h+fX3R+8EFzqULYNkZ5
	sIMiDsbBQtkisnDQ==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/vf-pit: Enable and
 disable module on error
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883600335.709179.11338075527850140329.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     13cea8527c95e1359191347abe5d94cccc47a311
Gitweb:        https://git.kernel.org/tip/13cea8527c95e1359191347abe5d94cccc4=
7a311
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:32 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:29:45 +02:00

clocksource/drivers/vf-pit: Enable and disable module on error

Encapsulate the calls to writel to enable and disable the PIT module
and make use of them. Add the missing module disablement in case of
error.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-15-daniel.lezcano@lina=
ro.org
---
 drivers/clocksource/timer-vf-pit.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
index 9637708..609a4d9 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -13,10 +13,12 @@
 /*
  * Each pit takes 0x10 Bytes register space
  */
-#define PITMCR		0x00
 #define PIT0_OFFSET	0x100
 #define PIT_CH(n)       (PIT0_OFFSET + 0x10 * (n))
=20
+#define PITMCR(__base)	(__base)
+
+#define PITMCR_FRZ	BIT(0)
 #define PITMCR_MDIS	BIT(1)
=20
 #define PITLDVAL(__base)	(__base)
@@ -52,6 +54,16 @@ static inline struct pit_timer *cs_to_pit(struct clocksour=
ce *cs)
 	return container_of(cs, struct pit_timer, cs);
 }
=20
+static inline void pit_module_enable(void __iomem *base)
+{
+	writel(0, PITMCR(base));
+}
+
+static inline void pit_module_disable(void __iomem *base)
+{
+	writel(PITMCR_MDIS, PITMCR(base));
+}
+
 static inline void pit_timer_enable(struct pit_timer *pit)
 {
 	writel(PITTCTRL_TEN | PITTCTRL_TIE, PITTCTRL(pit->clkevt_base));
@@ -254,11 +266,11 @@ static int __init pit_timer_init(struct device_node *np)
 	clk_rate =3D clk_get_rate(pit_clk);
=20
 	/* enable the pit module */
-	writel(~PITMCR_MDIS, timer_base + PITMCR);
+	pit_module_enable(timer_base);
=20
 	ret =3D pit_clocksource_init(pit, name, timer_base, clk_rate);
 	if (ret)
-		goto out_disable_unprepare;
+		goto out_pit_module_disable;
=20
 	ret =3D pit_clockevent_init(pit, name, timer_base, clk_rate, irq, 0);
 	if (ret)
@@ -268,7 +280,8 @@ static int __init pit_timer_init(struct device_node *np)
=20
 out_pit_clocksource_unregister:
 	clocksource_unregister(&pit->cs);
-out_disable_unprepare:
+out_pit_module_disable:
+	pit_module_disable(timer_base);
 	clk_disable_unprepare(pit_clk);
 out_clk_put:
 	clk_put(pit_clk);

