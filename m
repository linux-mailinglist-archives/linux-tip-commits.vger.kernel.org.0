Return-Path: <linux-tip-commits+bounces-7539-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A403FC8A614
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 15:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490203A874C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 14:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094C32FDC43;
	Wed, 26 Nov 2025 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3M+V6/od";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3YndJvxD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3762730276D;
	Wed, 26 Nov 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168018; cv=none; b=O4Od2UFyqXWyWPMfgr/nTWJX734WhW3V6EjgbHB36Q3vbJ8K0Krms996ZZ5JbPW5orx99W5ZIZmZi/WUMC4+yEJjITIWEnnaGXIiurnbAYNlLtJu/2Q9/f0H05M8MR5QlhpfG6aHq2Hq1Ss1TYpAWBxRelfzuVopNMDgj6sNy8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168018; c=relaxed/simple;
	bh=iJqE3DDjcZyp9kmV3sm0xZygPYBJKYUcpXHPo/jEe/c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jzKIcqkMM4j6imjgJGXNHXnLcmxHFOdOyhtbFwTTEEKgDYVJXvmkHJ8DEf29FG0OV/oHQj3GGaNuT3F0AGZgkLIIKHG2vpgyLlRLCIsNmTXBWUVLlx79BybrsQiUzDWO4E6oaM2rrpqoNp4zqDujLkzpEQc1ArIl6AtC5X+XSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3M+V6/od; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3YndJvxD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 14:40:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764168013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxMplbH6ASuOysNl+YjozSqSOtBkL8VltPVtXLLt4OI=;
	b=3M+V6/odUFjkzjKrWnDAh1ZKP7/ynz+iofNK7ioDEN5VX/LYM1Pc0A0oNPFIZjb0P3HIX/
	o4y2ZkythRaxlbvbI6laQIIBT634KJhG9x2b1S6XU0xmAFM2a3OmmcJnguH5e2djsvDYH6
	b3PnaxtBEDAsYf664i07f1rx/QSI5Pb/nht1QeKLHQc2MMKEjiwVYJ0XwtesVuDBfUNDCT
	Z+jGHHg/7o8uhOBMhwRq6TEnRuIemwe7qd0fJCBbE55vqLJTQuDqOnhQLkDdlqK/pbIo9C
	3KVroufTjc6lqBc7flw412smIVmtKpvgLQVijdi7BaxGp22e3Tv+u1jRWOl0GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764168013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxMplbH6ASuOysNl+YjozSqSOtBkL8VltPVtXLLt4OI=;
	b=3YndJvxDo4d5TJROarJq+93XrKwCsiQTWcCuCRuDGe6SKmQCsHK7fjXaq4ySzYYPJ9uPHM
	WSYX4Sv7C7riXrBw==
From: "tip-bot2 for Hao-Wen Ting" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers: Add Realtek system
 timer driver
Cc: "Hao-Wen Ting" <haowen.ting@realtek.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251126060110.198330-3-haowen.ting@realtek.com>
References: <20251126060110.198330-3-haowen.ting@realtek.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176416801190.498.17026062158783999046.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     d1780dce9575072303b9c574614b72b5c8c5c44c
Gitweb:        https://git.kernel.org/tip/d1780dce9575072303b9c574614b72b5c8c=
5c44c
Author:        Hao-Wen Ting <haowen.ting@realtek.com>
AuthorDate:    Wed, 26 Nov 2025 14:01:10 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 26 Nov 2025 11:25:15 +01:00

clocksource/drivers: Add Realtek system timer driver

Add a system timer driver for Realtek SoCs.

This driver registers the 1 MHz global hardware counter on Realtek
platforms as a clock event device. Since this hardware counter starts
counting automatically after SoC power-on, no clock initialization is
required. Because the counter does not stop or get affected by CPU power
down, and it supports oneshot mode, it is typically used as a tick
broadcast timer.

Signed-off-by: Hao-Wen Ting <haowen.ting@realtek.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251126060110.198330-3-haowen.ting@realtek.com
---
 MAINTAINERS                         |   5 +-
 drivers/clocksource/Kconfig         |  11 ++-
 drivers/clocksource/Makefile        |   1 +-
 drivers/clocksource/timer-realtek.c | 150 +++++++++++++++++++++++++++-
 4 files changed, 167 insertions(+)
 create mode 100644 drivers/clocksource/timer-realtek.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3da2c26..b72b987 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21669,6 +21669,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/spi/realtek,rtl9301-snand.yaml
 F:	drivers/spi/spi-realtek-rtl-snand.c
=20
+REALTEK SYSTIMER DRIVER
+M:	Hao-Wen Ting <haowen.ting@realtek.com>
+S:	Maintained
+F:	drivers/clocksource/timer-realtek.c
+
 REALTEK WIRELESS DRIVER (rtlwifi family)
 M:	Ping-Ke Shih <pkshih@realtek.com>
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index ffcd236..aa59e5b 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -782,4 +782,15 @@ config NXP_STM_TIMER
           Enables the support for NXP System Timer Module found in the
           s32g NXP platform series.
=20
+config RTK_SYSTIMER
+	bool "Realtek SYSTIMER support"
+	depends on ARM || ARM64
+	depends on ARCH_REALTEK || COMPILE_TEST
+	select TIMER_OF
+	help
+	  This option enables the driver that registers the global 1 MHz hardware
+	  counter as a clock event device on Realtek SoCs. Make sure to enable
+	  this option only when building for a Realtek platform or for compilation
+	  testing.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index ec4452e..b46376a 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -95,3 +95,4 @@ obj-$(CONFIG_CLKSRC_LOONGSON1_PWM)	+=3D timer-loongson1-pwm=
.o
 obj-$(CONFIG_EP93XX_TIMER)		+=3D timer-ep93xx.o
 obj-$(CONFIG_RALINK_TIMER)		+=3D timer-ralink.o
 obj-$(CONFIG_NXP_STM_TIMER)		+=3D timer-nxp-stm.o
+obj-$(CONFIG_RTK_SYSTIMER)		+=3D timer-realtek.o
diff --git a/drivers/clocksource/timer-realtek.c b/drivers/clocksource/timer-=
realtek.c
new file mode 100644
index 0000000..4f0439d
--- /dev/null
+++ b/drivers/clocksource/timer-realtek.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Realtek Semiconductor Corp.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/irqflags.h>
+#include <linux/interrupt.h>
+#include "timer-of.h"
+
+#define ENBL 1
+#define DSBL 0
+
+#define SYSTIMER_RATE 1000000
+#define SYSTIMER_MIN_DELTA 0x64
+#define SYSTIMER_MAX_DELTA ULONG_MAX
+
+/* SYSTIMER Register Offset (RTK Internal Use) */
+#define TS_LW_OFST 0x0
+#define TS_HW_OFST 0x4
+#define TS_CMP_VAL_LW_OFST 0x8
+#define TS_CMP_VAL_HW_OFST 0xC
+#define TS_CMP_CTRL_OFST 0x10
+#define TS_CMP_STAT_OFST 0x14
+
+/* SYSTIMER CMP CTRL REG Mask */
+#define TS_CMP_EN_MASK 0x1
+#define TS_WR_EN0_MASK 0x2
+
+static void __iomem *systimer_base;
+
+static u64 rtk_ts64_read(void)
+{
+	u32 low, high;
+	u64 ts;
+
+	/* Caution: Read LSB word (TS_LW_OFST) first then MSB (TS_HW_OFST) */
+	low =3D readl(systimer_base + TS_LW_OFST);
+	high =3D readl(systimer_base + TS_HW_OFST);
+	ts =3D ((u64)high << 32) | low;
+
+	return ts;
+}
+
+static void rtk_cmp_value_write(u64 value)
+{
+	u32 high, low;
+
+	low =3D value & 0xFFFFFFFF;
+	high =3D value >> 32;
+
+	writel(high, systimer_base + TS_CMP_VAL_HW_OFST);
+	writel(low, systimer_base + TS_CMP_VAL_LW_OFST);
+}
+
+static inline void rtk_cmp_en_write(bool cmp_en)
+{
+	u32 val;
+
+	val =3D TS_WR_EN0_MASK;
+	if (cmp_en =3D=3D ENBL)
+		val |=3D TS_CMP_EN_MASK;
+
+	writel(val, systimer_base + TS_CMP_CTRL_OFST);
+}
+
+static int rtk_syst_clkevt_next_event(unsigned long cycles, struct clock_eve=
nt_device *clkevt)
+{
+	u64 cmp_val;
+
+	rtk_cmp_en_write(DSBL);
+	cmp_val =3D rtk_ts64_read();
+
+	/* Set CMP value to current timestamp plus delta_us */
+	rtk_cmp_value_write(cmp_val + cycles);
+	rtk_cmp_en_write(ENBL);
+	return 0;
+}
+
+static irqreturn_t rtk_ts_match_intr_handler(int irq, void *dev_id)
+{
+	struct clock_event_device *clkevt =3D dev_id;
+	void __iomem *reg_base;
+	u32 val;
+
+	/* Disable TS CMP Match */
+	rtk_cmp_en_write(DSBL);
+
+	/* Clear TS CMP INTR */
+	reg_base =3D systimer_base + TS_CMP_STAT_OFST;
+	val =3D readl(reg_base) & TS_CMP_EN_MASK;
+	writel(val | TS_CMP_EN_MASK, reg_base);
+	clkevt->event_handler(clkevt);
+
+	return IRQ_HANDLED;
+}
+
+static int rtk_syst_shutdown(struct clock_event_device *clkevt)
+{
+	void __iomem *reg_base;
+	u64 cmp_val =3D 0;
+
+	/* Disable TS CMP Match */
+	rtk_cmp_en_write(DSBL);
+	/* Set compare value to 0 */
+	rtk_cmp_value_write(cmp_val);
+
+	/* Clear TS CMP INTR */
+	reg_base =3D systimer_base + TS_CMP_STAT_OFST;
+	writel(TS_CMP_EN_MASK, reg_base);
+	return 0;
+}
+
+static struct timer_of rtk_timer_to =3D {
+	.flags =3D TIMER_OF_IRQ | TIMER_OF_BASE,
+
+	.clkevt =3D {
+		.name			=3D "rtk-clkevt",
+		.rating			=3D 300,
+		.cpumask		=3D cpu_possible_mask,
+		.features		=3D CLOCK_EVT_FEAT_DYNIRQ |
+					  CLOCK_EVT_FEAT_ONESHOT,
+		.set_next_event		=3D rtk_syst_clkevt_next_event,
+		.set_state_oneshot	=3D rtk_syst_shutdown,
+		.set_state_shutdown	=3D rtk_syst_shutdown,
+	},
+
+	.of_irq =3D {
+		.flags			=3D IRQF_TIMER | IRQF_IRQPOLL,
+		.handler		=3D rtk_ts_match_intr_handler,
+	},
+};
+
+static int __init rtk_systimer_init(struct device_node *node)
+{
+	int ret;
+
+	ret =3D timer_of_init(node, &rtk_timer_to);
+	if (ret)
+		return ret;
+
+	systimer_base =3D timer_of_base(&rtk_timer_to);
+	clockevents_config_and_register(&rtk_timer_to.clkevt, SYSTIMER_RATE,
+					SYSTIMER_MIN_DELTA, SYSTIMER_MAX_DELTA);
+
+	return 0;
+}
+
+TIMER_OF_DECLARE(rtk_systimer, "realtek,rtd1625-systimer", rtk_systimer_init=
);

