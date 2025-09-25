Return-Path: <linux-tip-commits+bounces-6726-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC3FBA18C0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431FE2A5E44
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BE3322767;
	Thu, 25 Sep 2025 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JEbbmrQk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XGIXW8Pl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E465321458;
	Thu, 25 Sep 2025 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835975; cv=none; b=B3CXIIwygQBTAZj627TSAbXqqaX2H/WGnn4Jj4t29pA7TPfdtIr3QFwftBqOTmiw34nXRnWLvMjfxtsNgeNRE0yXp03xmIt+JSuhBe76gumkvYa/N93qb2x8ZTMdGOiVDkrAgxm3wxutqwJfspEcBps8NZjOAFYZd0zSR8bk5Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835975; c=relaxed/simple;
	bh=BXQYrQxXNdKQZeytmWFZvTgFXpKOtKX6VeNOTgre7Hw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=epC7Xm4FaXzxfiU+wyrXiOZESWJQ3rjViomhPCvwBfJSK4hwARxiHha/hpxqUXHqBexKIGjPNqHGOkG02/KKn439KvAb1QDrLzYKu0GuokYjTYndT85J6QJOeYPVKNM4QBuXRwlA4gl4zA+2zuHocbThMnQFaIOg1+I1slfAKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JEbbmrQk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XGIXW8Pl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:32:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835971;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=12SU5SzflFgkR9wPWadvfTTuTwwtww0a1Ga16pF2HV4=;
	b=JEbbmrQkxNW63UizknaV/SuftqlctxRh/xKKHKRIvWzFMo9RH8TQa39EjHcQ2RTjquUmAi
	iemDb213A/XTIRFdSSvkvQb5An7VNsRKcS72xQBsqZqF4cWpjULMJLYDyv9NexswryUgBU
	3bacbpvccCCY6xskO5+ymrijU74SWnZMgA6azSNGJZHST5hQCQr7Rp5JWGOmedjmfeag7x
	sVFUQeRZdFr0fBZkHdeV995xH4jifrmLYEeP+ewyDiJcAxiuxBB6yp+BAeRYoeX5TEJcuS
	OqVzGM7QoqkpOAqCNK2SOHslaa4Su/SAzmHd2m7jdoZ3KtUYk3413mOkbhbFPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835971;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=12SU5SzflFgkR9wPWadvfTTuTwwtww0a1Ga16pF2HV4=;
	b=XGIXW8Pl8jAj5sUHp4TNdxaCNsi9NPg/SG9C6rnbNGOvJiWeMbLDV6X6i/CvmXR/0EOYav
	eHnuEtnRMkSoJ0Aw==
From: "tip-bot2 for Markus Schneider-Pargmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/arm_global_timer: Add
 auto-detection for initial prescaler values
Cc: "Markus Schneider-Pargmann" <msp@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Judith Mendez <jm@ti.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883597030.709179.15238499822670222328.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     1c4b87c921fb158d853adcb8fd48c2dc07fc6f91
Gitweb:        https://git.kernel.org/tip/1c4b87c921fb158d853adcb8fd48c2dc07f=
c6f91
Author:        Markus Schneider-Pargmann <msp@baylibre.com>
AuthorDate:    Tue, 19 Aug 2025 09:52:41 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:41:58 +02:00

clocksource/drivers/arm_global_timer: Add auto-detection for initial prescale=
r values

am43xx has a clock tree where the global timer clock is an indirect child
of the CPU clock used for frequency scaling:

  dpll_mpu_ck -- CPU/cpufreq
        |
        v
  dpll_mpu_m2_ck -- divider
        |
        v
  mpu_periphclk -- fixed divider by 2 used for global timer

When CPU frequency changes, the global timer's clock notifier rejects
the change because the hardcoded prescaler (1 or 2) cannot accommodate
the frequency range across all CPU OPPs (300, 600, 720, 800, 1000 MHz).

Add platform-specific prescaler auto-detection to solve this issue:

- am43xx: prescaler =3D 50 (calculated as initial_freq/GCD of all OPP
  freqs) This allows the timer to work across all CPU frequencies after
  the fixed divider by 2. Tested on am4372-idk-evm.

- zynq-7000: prescaler =3D 2 (preserves previous Kconfig default)

- Other platforms: prescaler =3D 1 (previous default)

The Kconfig option now defaults to 0 (auto-detection) but can still
override the auto-detected value when set to a non-zero value,
preserving existing customization workflows.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
Tested-by: Judith Mendez <jm@ti.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Link: https://lore.kernel.org/r/20250819-topic-am43-arm-global-timer-v6-16-v2=
-1-6d082e2a5161@baylibre.com
---
 drivers/clocksource/Kconfig            |  4 +-
 drivers/clocksource/arm_global_timer.c | 44 ++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 0fd662f..ffcd236 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -395,8 +395,7 @@ config ARM_GLOBAL_TIMER
=20
 config ARM_GT_INITIAL_PRESCALER_VAL
 	int "ARM global timer initial prescaler value"
-	default 2 if ARCH_ZYNQ
-	default 1
+	default 0
 	depends on ARM_GLOBAL_TIMER
 	help
 	  When the ARM global timer initializes, its current rate is declared
@@ -406,6 +405,7 @@ config ARM_GT_INITIAL_PRESCALER_VAL
 	  bounds about how much the parent clock is allowed to decrease or
 	  increase wrt the initial clock value.
 	  This affects CPU_FREQ max delta from the initial frequency.
+	  Use 0 to use auto-detection in the driver.
=20
 config ARM_TIMER_SP804
 	bool "Support for Dual Timer SP804 module"
diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm=
_global_timer.c
index 2d86bbc..5e3d6bb 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -263,14 +263,13 @@ static void __init gt_delay_timer_init(void)
 	register_current_timer_delay(&gt_delay_timer);
 }
=20
-static int __init gt_clocksource_init(void)
+static int __init gt_clocksource_init(unsigned int psv)
 {
 	writel(0, gt_base + GT_CONTROL);
 	writel(0, gt_base + GT_COUNTER0);
 	writel(0, gt_base + GT_COUNTER1);
 	/* set prescaler and enable timer on all the cores */
-	writel(FIELD_PREP(GT_CONTROL_PRESCALER_MASK,
-			  CONFIG_ARM_GT_INITIAL_PRESCALER_VAL - 1) |
+	writel(FIELD_PREP(GT_CONTROL_PRESCALER_MASK, psv - 1) |
 	       GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
=20
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
@@ -338,11 +337,45 @@ static int gt_clk_rate_change_cb(struct notifier_block =
*nb,
 	return NOTIFY_DONE;
 }
=20
+struct gt_prescaler_config {
+	const char *compatible;
+	unsigned long prescaler;
+};
+
+static const struct gt_prescaler_config gt_prescaler_configs[] =3D {
+	/*
+	 * On am43 the global timer clock is a child of the clock used for CPU
+	 * OPPs, so the initial prescaler has to be compatible with all OPPs
+	 * which are 300, 600, 720, 800 and 1000 with a fixed divider of 2, this
+	 * gives us a GCD of 10. Initial frequency is 1000, so the prescaler is
+	 * 50.
+	 */
+	{ .compatible =3D "ti,am43", .prescaler =3D 50 },
+	{ .compatible =3D "xlnx,zynq-7000", .prescaler =3D 2 },
+	{ .compatible =3D NULL }
+};
+
+static unsigned long gt_get_initial_prescaler_value(struct device_node *np)
+{
+	const struct gt_prescaler_config *config;
+
+	if (CONFIG_ARM_GT_INITIAL_PRESCALER_VAL !=3D 0)
+		return CONFIG_ARM_GT_INITIAL_PRESCALER_VAL;
+
+	for (config =3D gt_prescaler_configs; config->compatible; config++) {
+		if (of_machine_is_compatible(config->compatible))
+			return config->prescaler;
+	}
+
+	return 1;
+}
+
 static int __init global_timer_of_register(struct device_node *np)
 {
 	struct clk *gt_clk;
 	static unsigned long gt_clk_rate;
 	int err;
+	unsigned long psv;
=20
 	/*
 	 * In A9 r2p0 the comparators for each processor with the global timer
@@ -378,8 +411,9 @@ static int __init global_timer_of_register(struct device_=
node *np)
 		goto out_unmap;
 	}
=20
+	psv =3D gt_get_initial_prescaler_value(np);
 	gt_clk_rate =3D clk_get_rate(gt_clk);
-	gt_target_rate =3D gt_clk_rate / CONFIG_ARM_GT_INITIAL_PRESCALER_VAL;
+	gt_target_rate =3D gt_clk_rate / psv;
 	gt_clk_rate_change_nb.notifier_call =3D
 		gt_clk_rate_change_cb;
 	err =3D clk_notifier_register(gt_clk, &gt_clk_rate_change_nb);
@@ -404,7 +438,7 @@ static int __init global_timer_of_register(struct device_=
node *np)
 	}
=20
 	/* Register and immediately configure the timer on the boot CPU */
-	err =3D gt_clocksource_init();
+	err =3D gt_clocksource_init(psv);
 	if (err)
 		goto out_irq;
=20

