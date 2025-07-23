Return-Path: <linux-tip-commits+bounces-6171-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE261B0EBAB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04121AA0D9C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DF2274B37;
	Wed, 23 Jul 2025 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bOuXIear";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+79AekKM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCFC2749CD;
	Wed, 23 Jul 2025 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255051; cv=none; b=D1o7dTWepW8tjYLxNcuE/cSta2SRnR3eKIBxpCU1tgujsJiKy8HzPOujrT5wPsHEhhaj2qoPrb1fEhix23AmwKdpFN+2LXGXVNFtr+c3pzil5+RuD5Tn4uKLii87Fx7pf2sFmlnBTeAaEPaOuU32+HqA5Idasicowbp7x8u0yPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255051; c=relaxed/simple;
	bh=4Yv1Xv9TU0B+dR6AHx+iOhNR4MzsJRzWx6K3MC1ZwcU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MuanQDJZ4HszDUkiZafOrtiJ+wCzaDhNncmuQtGb7W9Bhkp9VxznRJUhKpFbUeafPjFKzc6VKWo8axa6bgZ8+x+zQ8dbjAQgyCq7B3swvCq0YQq/qS4sdXBMqHEdHdydfN2bulJ6xxaJLplLaZcCehXPiEjP88BlGlwVxLgjfoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bOuXIear; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+79AekKM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYohQ+HQkBF26sKPVTOOZukderFU8Fz9OkYZWmP2KAs=;
	b=bOuXIearnXF1r9XxwM92v9ao9sVHnNcoaEuz4Cq0b566QjZmXHUgbBybYMnG9Ft3T9Jo62
	dsqrF3MZ9hEqDWFiy7Hwit+5g68N0Km9IYJzwWWLDhrmiVWqlfW6cn0RgJ/UkcY6AX+Fbx
	UyRXgImB6Y1ioua/ffeTMrSy3/1ZizPgtBDQdoF+zJCw5vuqPnlXrHU0+KQ2ssT05kghf9
	x8i2UZDuX7qQvuDWd6uRRmyBiDNjLgBfF3f8wYh50q0WgfI4ZT955H8scz8ZhPjNXDKpS6
	kmH39pXAqZJYaaM9oK7lswyMQ2OHLS0jHOTWCn9wlmXydU6R7wtLC3OgDrynoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYohQ+HQkBF26sKPVTOOZukderFU8Fz9OkYZWmP2KAs=;
	b=+79AekKMaY+wkKPm3gTUCid2YGWSk/AmGcuNb8HdQ4ADpCp6bETNB5SVoPSwgCVWD+Vn82
	uinTTt1CVCP1ByAQ==
From: "tip-bot2 for Donghoon Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/exynos_mct: Add module support
Cc: Donghoon Yu <hoony.yu@samsung.com>,
 Youngmin Nam <youngmin.nam@samsung.com>,
 Will McVicker <willmcvicker@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250620181719.1399856-6-willmcvicker@google.com>
References: <20250620181719.1399856-6-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325504604.1420.1427297053619047026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     5d86e479193babb6487c33bc01a464c54933eba6
Gitweb:        https://git.kernel.org/tip/5d86e479193babb6487c33bc01a464c5493=
3eba6
Author:        Donghoon Yu <hoony.yu@samsung.com>
AuthorDate:    Fri, 20 Jun 2025 11:17:08 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Jul 2025 13:00:51 +02:00

clocksource/drivers/exynos_mct: Add module support

On Arm64 platforms the Exynos MCT driver can be built as a module. On
boot (and even after boot) the arch_timer is used as the clocksource and
tick timer. Once the MCT driver is loaded, it can be used as the wakeup
source for the arch_timer.

Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
[original commit from https://android.googlesource.com/kernel/gs/+/8a52a8288e=
c7d88ff78f0b37480dbb0e9c65bbfd]
Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250620181719.1399856-6-willmcvicker@google.=
com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig      |  3 +-
 drivers/clocksource/exynos_mct.c | 51 +++++++++++++++++++++++++------
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 645f517..d657c8d 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -451,7 +451,8 @@ config ATMEL_TCB_CLKSRC
 	  Support for Timer Counter Blocks on Atmel SoCs.
=20
 config CLKSRC_EXYNOS_MCT
-	bool "Exynos multi core timer driver" if COMPILE_TEST
+	tristate "Exynos multi core timer driver" if ARM64
+	default y if ARCH_EXYNOS || COMPILE_TEST
 	depends on ARM || ARM64
 	depends on ARCH_ARTPEC || ARCH_EXYNOS || COMPILE_TEST
 	help
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mc=
t.c
index 62febeb..5075ebe 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -15,9 +15,11 @@
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/percpu.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
 #include <linux/clocksource.h>
 #include <linux/sched_clock.h>
=20
@@ -217,6 +219,7 @@ static struct clocksource mct_frc =3D {
 	.mask		=3D CLOCKSOURCE_MASK(32),
 	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
 	.resume		=3D exynos4_frc_resume,
+	.owner		=3D THIS_MODULE,
 };
=20
 /*
@@ -241,7 +244,7 @@ static cycles_t exynos4_read_current_timer(void)
 }
 #endif
=20
-static int __init exynos4_clocksource_init(bool frc_shared)
+static int exynos4_clocksource_init(bool frc_shared)
 {
 	/*
 	 * When the frc is shared, the main processor should have already
@@ -336,6 +339,7 @@ static struct clock_event_device mct_comp_device =3D {
 	.set_state_oneshot	=3D mct_set_state_shutdown,
 	.set_state_oneshot_stopped =3D mct_set_state_shutdown,
 	.tick_resume		=3D mct_set_state_shutdown,
+	.owner			=3D THIS_MODULE,
 };
=20
 static irqreturn_t exynos4_mct_comp_isr(int irq, void *dev_id)
@@ -476,6 +480,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 	evt->features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
 			CLOCK_EVT_FEAT_PERCPU;
 	evt->rating =3D MCT_CLKEVENTS_RATING;
+	evt->owner =3D THIS_MODULE;
=20
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
=20
@@ -511,7 +516,7 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
 	return 0;
 }
=20
-static int __init exynos4_timer_resources(struct device_node *np)
+static int exynos4_timer_resources(struct device_node *np)
 {
 	struct clk *mct_clk, *tick_clk;
=20
@@ -539,7 +544,7 @@ static int __init exynos4_timer_resources(struct device_n=
ode *np)
  * @local_idx: array mapping CPU numbers to local timer indices
  * @nr_local: size of @local_idx array
  */
-static int __init exynos4_timer_interrupts(struct device_node *np,
+static int exynos4_timer_interrupts(struct device_node *np,
 					   unsigned int int_type,
 					   const u32 *local_idx,
 					   size_t nr_local)
@@ -652,7 +657,7 @@ out_irq:
 	return err;
 }
=20
-static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
+static int mct_init_dt(struct device_node *np, unsigned int int_type)
 {
 	bool frc_shared =3D of_property_read_bool(np, "samsung,frc-shared");
 	u32 local_idx[MCT_NR_LOCAL] =3D {0};
@@ -700,15 +705,43 @@ static int __init mct_init_dt(struct device_node *np, u=
nsigned int int_type)
 	return exynos4_clockevent_init();
 }
=20
-
-static int __init mct_init_spi(struct device_node *np)
+static int mct_init_spi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_SPI);
 }
=20
-static int __init mct_init_ppi(struct device_node *np)
+static int mct_init_ppi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_PPI);
 }
-TIMER_OF_DECLARE(exynos4210, "samsung,exynos4210-mct", mct_init_spi);
-TIMER_OF_DECLARE(exynos4412, "samsung,exynos4412-mct", mct_init_ppi);
+
+static int exynos4_mct_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	int (*mct_init)(struct device_node *np);
+
+	mct_init =3D of_device_get_match_data(dev);
+	if (!mct_init)
+		return -EINVAL;
+
+	return mct_init(dev->of_node);
+}
+
+static const struct of_device_id exynos4_mct_match_table[] =3D {
+	{ .compatible =3D "samsung,exynos4210-mct", .data =3D &mct_init_spi, },
+	{ .compatible =3D "samsung,exynos4412-mct", .data =3D &mct_init_ppi, },
+	{}
+};
+MODULE_DEVICE_TABLE(of, exynos4_mct_match_table);
+
+static struct platform_driver exynos4_mct_driver =3D {
+	.probe		=3D exynos4_mct_probe,
+	.driver		=3D {
+		.name	=3D "exynos-mct",
+		.of_match_table =3D exynos4_mct_match_table,
+	},
+};
+module_platform_driver(exynos4_mct_driver);
+
+MODULE_DESCRIPTION("Exynos Multi Core Timer Driver");
+MODULE_LICENSE("GPL");

