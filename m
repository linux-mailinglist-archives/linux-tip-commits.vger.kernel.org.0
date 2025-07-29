Return-Path: <linux-tip-commits+bounces-6224-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF999B1512A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jul 2025 18:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B13172407
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jul 2025 16:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7131C4A13;
	Tue, 29 Jul 2025 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PAMTgC2W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u/VWoKRy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37A0223DEE;
	Tue, 29 Jul 2025 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805964; cv=none; b=TtoDfdHGmcJ6ov1azDEJxUfqP08du91ttbY1dfQhkSPaUalnsRSq5bjFC9UFlMUDefTd/26w8lbTu36yBdHdK8s5+8iFpR5TVBjj3sUw5xpT3P5EGaeGLgvsT9g/K6A3Jwn73k0DHTyx4BcO9HyqyYphz/e0lT/L57bUVeHS24A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805964; c=relaxed/simple;
	bh=7dqMTjKECF9AGEh1uRXv6NAwDBKIboIUlwO2cqVTw90=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=MUnEubUV8x0zcmX4QhXShROH1tDCkL3GBZnRi3Vco813OGtzUP+3N+fbNc3ZlEzNa7TQtrSjT3W7xAqtKYoRmcFrIdVirdxOJn8yVhIyFUiU4OWi8sx5yMCPYi+Gh0S+HHVKRX02A85W/6HD0G+J9T4BoGGqsGCpHUVZi78m1FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PAMTgC2W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u/VWoKRy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Jul 2025 16:19:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753805960;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=r66iPKUujXkYusCJvYotRDsZD+sc2Q9522797mKhioA=;
	b=PAMTgC2WQ4pRl9gWpU13X8uxYPwFVsGeVWVzJefvkwkC0q4cG1nZMlTwGOmqjvXE4+6Z6R
	n/jUGcsdRKW+HCEpcHKLm9zV2xajFtV52uPwSK2Rw1inA8sdCLi0B0rTZEAglRguPD7SK8
	vodYCtq+mvl7j4CFKSJj3gbeNPiZhICpH5YDEdU7pL8cHMNOf9p0SMz1YV4rGeIhCnpsnc
	QLrnmNH7rVFS/oyd2FRl8iooyDF+SPoPd3zxbEgXNalv5lHCRej+qR7nskbuofHY1Tg0Rd
	nTbTjqjdp6Y3uYiEj28IPFjpZvvGUpjQrZlmUGgn0kynD+3qmMrzlCLwi84GlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753805960;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=r66iPKUujXkYusCJvYotRDsZD+sc2Q9522797mKhioA=;
	b=u/VWoKRyALjVbNZ1XVRXtyU/ZLLBR45jE0DSWDgyDEQvu2XV+CnwY1Yd4BG7ML2xruwWRu
	y1N8kwuzwQ0uSsBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Revert
 module enablement
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175380595621.1420.11494352998189659112.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     7b098309ced7709c0a502b5eb9f54bd1f26fc6c6
Gitweb:        https://git.kernel.org/tip/7b098309ced7709c0a502b5eb9f54bd1f26=
fc6c6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Jul 2025 18:02:33 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 29 Jul 2025 18:06:07 +02:00

clocksource/drivers/exynos_mct: Revert module enablement

Revert "clocksource/drivers/exynos_mct: Add module support", "arm64:
exynos: Drop select CLKSRC_EXYNOS_MCT" and "clocksource/drivers/exynos_mct:
Fix section mismatch from the module conversion"

This reverts commits 338007c44c7f97a068c455fef5a49a49cc9389de,
2798e90b4e095940e3736312499a0fb562f3ee60 and
0b10fd66c4d749eba5dc1017911bd7f70bd29063.

The module enablement turned out to result in a series of
regressions. Revert it, so it can be revisited.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm64/Kconfig.platforms     |  1 +-
 drivers/clocksource/Kconfig      |  3 +--
 drivers/clocksource/exynos_mct.c | 51 +++++--------------------------
 3 files changed, 11 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 46825b0..a541bb0 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -109,6 +109,7 @@ config ARCH_BLAIZE
 config ARCH_EXYNOS
 	bool "Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
+	select CLKSRC_EXYNOS_MCT
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select EXYNOS_PMU
 	select PINCTRL
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index d657c8d..645f517 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -451,8 +451,7 @@ config ATMEL_TCB_CLKSRC
 	  Support for Timer Counter Blocks on Atmel SoCs.
=20
 config CLKSRC_EXYNOS_MCT
-	tristate "Exynos multi core timer driver" if ARM64
-	default y if ARCH_EXYNOS || COMPILE_TEST
+	bool "Exynos multi core timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
 	depends on ARCH_ARTPEC || ARCH_EXYNOS || COMPILE_TEST
 	help
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mc=
t.c
index 80d263e..62febeb 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -15,11 +15,9 @@
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/percpu.h>
-#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
-#include <linux/platform_device.h>
 #include <linux/clocksource.h>
 #include <linux/sched_clock.h>
=20
@@ -219,7 +217,6 @@ static struct clocksource mct_frc =3D {
 	.mask		=3D CLOCKSOURCE_MASK(32),
 	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
 	.resume		=3D exynos4_frc_resume,
-	.owner		=3D THIS_MODULE,
 };
=20
 /*
@@ -244,7 +241,7 @@ static cycles_t exynos4_read_current_timer(void)
 }
 #endif
=20
-static int exynos4_clocksource_init(bool frc_shared)
+static int __init exynos4_clocksource_init(bool frc_shared)
 {
 	/*
 	 * When the frc is shared, the main processor should have already
@@ -339,7 +336,6 @@ static struct clock_event_device mct_comp_device =3D {
 	.set_state_oneshot	=3D mct_set_state_shutdown,
 	.set_state_oneshot_stopped =3D mct_set_state_shutdown,
 	.tick_resume		=3D mct_set_state_shutdown,
-	.owner			=3D THIS_MODULE,
 };
=20
 static irqreturn_t exynos4_mct_comp_isr(int irq, void *dev_id)
@@ -480,7 +476,6 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 	evt->features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
 			CLOCK_EVT_FEAT_PERCPU;
 	evt->rating =3D MCT_CLKEVENTS_RATING;
-	evt->owner =3D THIS_MODULE;
=20
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
=20
@@ -516,7 +511,7 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
 	return 0;
 }
=20
-static int exynos4_timer_resources(struct device_node *np)
+static int __init exynos4_timer_resources(struct device_node *np)
 {
 	struct clk *mct_clk, *tick_clk;
=20
@@ -544,7 +539,7 @@ static int exynos4_timer_resources(struct device_node *np)
  * @local_idx: array mapping CPU numbers to local timer indices
  * @nr_local: size of @local_idx array
  */
-static int exynos4_timer_interrupts(struct device_node *np,
+static int __init exynos4_timer_interrupts(struct device_node *np,
 					   unsigned int int_type,
 					   const u32 *local_idx,
 					   size_t nr_local)
@@ -657,7 +652,7 @@ out_irq:
 	return err;
 }
=20
-static __init_or_module int mct_init_dt(struct device_node *np, unsigned int=
 int_type)
+static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 {
 	bool frc_shared =3D of_property_read_bool(np, "samsung,frc-shared");
 	u32 local_idx[MCT_NR_LOCAL] =3D {0};
@@ -705,43 +700,15 @@ static __init_or_module int mct_init_dt(struct device_n=
ode *np, unsigned int int
 	return exynos4_clockevent_init();
 }
=20
-static __init_or_module int mct_init_spi(struct device_node *np)
+
+static int __init mct_init_spi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_SPI);
 }
=20
-static __init_or_module int mct_init_ppi(struct device_node *np)
+static int __init mct_init_ppi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_PPI);
 }
-
-static int exynos4_mct_probe(struct platform_device *pdev)
-{
-	struct device *dev =3D &pdev->dev;
-	int (*mct_init)(struct device_node *np);
-
-	mct_init =3D of_device_get_match_data(dev);
-	if (!mct_init)
-		return -EINVAL;
-
-	return mct_init(dev->of_node);
-}
-
-static const struct of_device_id exynos4_mct_match_table[] =3D {
-	{ .compatible =3D "samsung,exynos4210-mct", .data =3D &mct_init_spi, },
-	{ .compatible =3D "samsung,exynos4412-mct", .data =3D &mct_init_ppi, },
-	{}
-};
-MODULE_DEVICE_TABLE(of, exynos4_mct_match_table);
-
-static struct platform_driver exynos4_mct_driver =3D {
-	.probe		=3D exynos4_mct_probe,
-	.driver		=3D {
-		.name	=3D "exynos-mct",
-		.of_match_table =3D exynos4_mct_match_table,
-	},
-};
-module_platform_driver(exynos4_mct_driver);
-
-MODULE_DESCRIPTION("Exynos Multi Core Timer Driver");
-MODULE_LICENSE("GPL");
+TIMER_OF_DECLARE(exynos4210, "samsung,exynos4210-mct", mct_init_spi);
+TIMER_OF_DECLARE(exynos4412, "samsung,exynos4412-mct", mct_init_ppi);

