Return-Path: <linux-tip-commits+bounces-5733-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D02ABFA6A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 17:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8982173345
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A07B283134;
	Wed, 21 May 2025 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oJETzPIG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ff41GPgb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEBE27CCE1;
	Wed, 21 May 2025 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842590; cv=none; b=TjycNs3TjG5lJNvZF0N60rCMVO80WR2QIYJrTItrt1IyUQ3+xfVplIl6jVIxw6hVaCfK6G0PlPm89X6muzriC9Wl2m0aTKdZll4C0PA42Sj0wQXY8K5V5oEnylMNmvkWEWC2MLafBoKEpC3TRU9cfoKBtWZjpVZDZ9qraXo6xk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842590; c=relaxed/simple;
	bh=hMnwyRi17kgWMF0N2Av4mT1wpa7oKNDTQ/enB+i+ni0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cROXEF9ZbPOd+vYzeSri4saaB9k2lyMHu0i9s/OuohZaVpscY4P9w1uo99CjlIYduTcdTjBGR1Un9FY6DWxsK0mr7k3UJw+CN0qEySZeMkQOgWZC0Z5ImA9XhdDPLdQBiDJJjohQFXhGC81BVFJUQB66OuGYiOL1B7UpmEbYrMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oJETzPIG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ff41GPgb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1lJVkVnPhHsFkJ33DuylaMEFrpTLTwz93NUS/dO8y6E=;
	b=oJETzPIGEJjATZmPaLIQd0v1z/VdqQ9HcIpV0ux35UXG/axX+l+RESjIAzyCT4doVvmqea
	JmcZMc73eexxSvWZTyTqaF465qdRNlwewe+BwQ9hBHldsSKXlLil0dCvOI0gZw0ZYfZtKe
	K6oQjroVF5XGaR/AhsP5mB4XeFxT1rxQAi1jwISxLT9IjTXorDesFXAgPQ1tdBUvQBNA4F
	HOSr+tICW30/pnUsBj/a7xSV1fFWTcRxXzF+t2xLAq9+mTvs5XoP/wHnFMInesmK4Gk1Ul
	b7a53Gqd6eWBgxQ6MKw7Q4eTR62f+mwpSKUPnyrSw3C0q7aUr/psEDODkyvXKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1lJVkVnPhHsFkJ33DuylaMEFrpTLTwz93NUS/dO8y6E=;
	b=Ff41GPgbuzEOe1XY7XyUmowldDBV+tuuJU301iN0c+ze3BPdgSjoWfsDcF8M1Iw19OpsII
	KqPFTz9vAaN5jKAA==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/nxp-timer: Add the
 System Timer Module for the s32gx platforms
Cc: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Thomas Fossati <thomas.fossati@linaro.org>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250417151623.121109-3-daniel.lezcano@linaro.org>
References: <20250417151623.121109-3-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784258509.406.1898274600306804753.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     cec32ac7582712346edd474a01fb553f5bf0efb9
Gitweb:        https://git.kernel.org/tip/cec32ac7582712346edd474a01fb553f5bf=
0efb9
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Thu, 17 Apr 2025 17:16:19 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:32 +02:00

clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx plat=
forms

STM supports commonly required system and application software timing
functions. STM includes a 32-bit count-up timer and four 32-bit
compare channels with a separate interrupt source for each
channel. The timer is driven by the STM module clock divided by an
8-bit prescale value (1 to 256).

STM has the following features:
    =E2=80=A2 One 32-bit count-up timer with an 8-bit prescaler
    =E2=80=A2 Four 32-bit compare channels
    =E2=80=A2 An independent interrupt source for each channel
    =E2=80=A2 Ability to stop the timer in Debug mode

The s32g platform is declined into two versions, the s32g2 and the
s32g3. The former has a STM block with 8 timers and the latter has 12
timers.

The platform is designed to have one usable STM instance per core on
the system which is composed of 3 x Cortex-M3 + 4 Cortex-A53 for the
s32g2 and 3 x Cortex-M3 + 8 Cortex-A53 for the s32g3.

There is a special STM instance called STM_TS which is dedicated to
the timestamp. The 7th STM instance STM_07 is directly tied to the
STM_TS which means it is not usable as a clockevent.

The driver instantiate each STM described in the device tree as a
clocksource and a clockevent conforming to the reference manual even
if the Linux system does not use all of the clocksource. Each
clockevent will have a cpumask set for a specific CPU.

Given the counter is shared between the clocksource and the
clockevent, the STM module can not be disabled by one or another so
the refcounting mechanism is used to stop the counter when it reaches
zero and to start it when it is one. The suspend and resume relies on
the refcount to stop the module.

As the device tree will have multiple STM entries, the driver can be
probed in parallel with the async option but it is not enabled
yet. However, the driver code takes care of preventing a race by
putting a lock to protect the number of STM instances global variable
which means it is ready to support the option when enough testing will
be done with the underlying time framework.

Cc: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Thomas Fossati <thomas.fossati@linaro.org>
Suggested-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Link: https://lore.kernel.org/r/20250417151623.121109-3-daniel.lezcano@linaro=
.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig         |   8 +-
 drivers/clocksource/Makefile        |   1 +-
 drivers/clocksource/timer-nxp-stm.c | 495 +++++++++++++++++++++++++++-
 3 files changed, 504 insertions(+)
 create mode 100644 drivers/clocksource/timer-nxp-stm.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 487c852..2861b2c 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -763,4 +763,12 @@ config RALINK_TIMER
 	  Enables support for system tick counter present on
 	  Ralink SoCs RT3352 and MT7620.
=20
+config NXP_STM_TIMER
+	bool "NXP System Timer Module driver"
+	depends on ARCH_S32 || COMPILE_TEST
+	select CLKSRC_MMIO
+	help
+          Enables the support for NXP System Timer Module found in the
+          s32g NXP platform series.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 43ef16a..0abc5ca 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -92,3 +92,4 @@ obj-$(CONFIG_GXP_TIMER)			+=3D timer-gxp.o
 obj-$(CONFIG_CLKSRC_LOONGSON1_PWM)	+=3D timer-loongson1-pwm.o
 obj-$(CONFIG_EP93XX_TIMER)		+=3D timer-ep93xx.o
 obj-$(CONFIG_RALINK_TIMER)		+=3D timer-ralink.o
+obj-$(CONFIG_NXP_STM_TIMER)		+=3D timer-nxp-stm.o
diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-=
nxp-stm.c
new file mode 100644
index 0000000..d7ccf90
--- /dev/null
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -0,0 +1,495 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ * Copyright 2018,2021-2025 NXP
+ *
+ * NXP System Timer Module:
+ *
+ *  STM supports commonly required system and application software
+ *  timing functions. STM includes a 32-bit count-up timer and four
+ *  32-bit compare channels with a separate interrupt source for each
+ *  channel. The timer is driven by the STM module clock divided by an
+ *  8-bit prescale value (1 to 256). It has ability to stop the timer
+ *  in Debug mode
+ */
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/cpuhotplug.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/sched_clock.h>
+#include <linux/units.h>
+
+#define STM_CR(__base)		(__base)
+
+#define STM_CR_TEN		BIT(0)
+#define STM_CR_FRZ		BIT(1)
+#define STM_CR_CPS_OFFSET	8u
+#define STM_CR_CPS_MASK		GENMASK(15, STM_CR_CPS_OFFSET)
+
+#define STM_CNT(__base)		((__base) + 0x04)
+
+#define STM_CCR0(__base)	((__base) + 0x10)
+#define STM_CCR1(__base)	((__base) + 0x20)
+#define STM_CCR2(__base)	((__base) + 0x30)
+#define STM_CCR3(__base)	((__base) + 0x40)
+
+#define STM_CCR_CEN		BIT(0)
+
+#define STM_CIR0(__base)	((__base) + 0x14)
+#define STM_CIR1(__base)	((__base) + 0x24)
+#define STM_CIR2(__base)	((__base) + 0x34)
+#define STM_CIR3(__base)	((__base) + 0x44)
+
+#define STM_CIR_CIF		BIT(0)
+
+#define STM_CMP0(__base)	((__base) + 0x18)
+#define STM_CMP1(__base)	((__base) + 0x28)
+#define STM_CMP2(__base)	((__base) + 0x38)
+#define STM_CMP3(__base)	((__base) + 0x48)
+
+#define STM_ENABLE_MASK	(STM_CR_FRZ | STM_CR_TEN)
+
+struct stm_timer {
+	void __iomem *base;
+	unsigned long rate;
+	unsigned long delta;
+	unsigned long counter;
+	struct clock_event_device ced;
+	struct clocksource cs;
+	atomic_t refcnt;
+};
+
+static DEFINE_PER_CPU(struct stm_timer *, stm_timers);
+
+static struct stm_timer *stm_sched_clock;
+
+/*
+ * Global structure for multiple STMs initialization
+ */
+static int stm_instances;
+
+/*
+ * This global lock is used to prevent race conditions with the
+ * stm_instances in case the driver is using the ASYNC option
+ */
+static DEFINE_MUTEX(stm_instances_lock);
+
+DEFINE_GUARD(stm_instances, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
+
+static struct stm_timer *cs_to_stm(struct clocksource *cs)
+{
+	return container_of(cs, struct stm_timer, cs);
+}
+
+static struct stm_timer *ced_to_stm(struct clock_event_device *ced)
+{
+	return container_of(ced, struct stm_timer, ced);
+}
+
+static u64 notrace nxp_stm_read_sched_clock(void)
+{
+	return readl(STM_CNT(stm_sched_clock->base));
+}
+
+static u32 nxp_stm_clocksource_getcnt(struct stm_timer *stm_timer)
+{
+	return readl(STM_CNT(stm_timer->base));
+}
+
+static void nxp_stm_clocksource_setcnt(struct stm_timer *stm_timer, u32 cnt)
+{
+	writel(cnt, STM_CNT(stm_timer->base));
+}
+
+static u64 nxp_stm_clocksource_read(struct clocksource *cs)
+{
+	struct stm_timer *stm_timer =3D cs_to_stm(cs);
+
+	return (u64)nxp_stm_clocksource_getcnt(stm_timer);
+}
+
+static void nxp_stm_module_enable(struct stm_timer *stm_timer)
+{
+	u32 reg;
+
+	reg =3D readl(STM_CR(stm_timer->base));
+
+	reg |=3D STM_ENABLE_MASK;
+
+	writel(reg, STM_CR(stm_timer->base));
+}
+
+static void nxp_stm_module_disable(struct stm_timer *stm_timer)
+{
+	u32 reg;
+
+	reg =3D readl(STM_CR(stm_timer->base));
+
+	reg &=3D ~STM_ENABLE_MASK;
+
+	writel(reg, STM_CR(stm_timer->base));
+}
+
+static void nxp_stm_module_put(struct stm_timer *stm_timer)
+{
+	if (atomic_dec_and_test(&stm_timer->refcnt))
+		nxp_stm_module_disable(stm_timer);
+}
+
+static void nxp_stm_module_get(struct stm_timer *stm_timer)
+{
+	if (atomic_inc_return(&stm_timer->refcnt) =3D=3D 1)
+		nxp_stm_module_enable(stm_timer);
+}
+
+static int nxp_stm_clocksource_enable(struct clocksource *cs)
+{
+	struct stm_timer *stm_timer =3D cs_to_stm(cs);
+
+	nxp_stm_module_get(stm_timer);
+
+	return 0;
+}
+
+static void nxp_stm_clocksource_disable(struct clocksource *cs)
+{
+	struct stm_timer *stm_timer =3D cs_to_stm(cs);
+
+	nxp_stm_module_put(stm_timer);
+}
+
+static void nxp_stm_clocksource_suspend(struct clocksource *cs)
+{
+	struct stm_timer *stm_timer =3D cs_to_stm(cs);
+
+	nxp_stm_clocksource_disable(cs);
+	stm_timer->counter =3D nxp_stm_clocksource_getcnt(stm_timer);
+}
+
+static void nxp_stm_clocksource_resume(struct clocksource *cs)
+{
+	struct stm_timer *stm_timer =3D cs_to_stm(cs);
+
+	nxp_stm_clocksource_setcnt(stm_timer, stm_timer->counter);
+	nxp_stm_clocksource_enable(cs);
+}
+
+static void __init devm_clocksource_unregister(void *data)
+{
+	struct stm_timer *stm_timer =3D data;
+
+	clocksource_unregister(&stm_timer->cs);
+}
+
+static int __init nxp_stm_clocksource_init(struct device *dev, struct stm_ti=
mer *stm_timer,
+					   const char *name, void __iomem *base, struct clk *clk)
+{
+	int ret;
+
+	stm_timer->base =3D base;
+	stm_timer->rate =3D clk_get_rate(clk);
+
+	stm_timer->cs.name =3D name;
+	stm_timer->cs.rating =3D 460;
+	stm_timer->cs.read =3D nxp_stm_clocksource_read;
+	stm_timer->cs.enable =3D nxp_stm_clocksource_enable;
+	stm_timer->cs.disable =3D nxp_stm_clocksource_disable;
+	stm_timer->cs.suspend =3D nxp_stm_clocksource_suspend;
+	stm_timer->cs.resume =3D nxp_stm_clocksource_resume;
+	stm_timer->cs.mask =3D CLOCKSOURCE_MASK(32);
+	stm_timer->cs.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+
+	ret =3D clocksource_register_hz(&stm_timer->cs, stm_timer->rate);
+	if (ret)
+		return ret;
+
+	ret =3D devm_add_action_or_reset(dev, devm_clocksource_unregister, stm_time=
r);
+	if (ret) {
+		clocksource_unregister(&stm_timer->cs);
+		return ret;
+	}
+
+	stm_sched_clock =3D stm_timer;
+
+	sched_clock_register(nxp_stm_read_sched_clock, 32, stm_timer->rate);
+
+	dev_dbg(dev, "Registered clocksource %s\n", name);
+
+	return 0;
+}
+
+static int nxp_stm_clockevent_read_counter(struct stm_timer *stm_timer)
+{
+	return readl(STM_CNT(stm_timer->base));
+}
+
+static void nxp_stm_clockevent_disable(struct stm_timer *stm_timer)
+{
+	writel(0, STM_CCR0(stm_timer->base));
+}
+
+static void nxp_stm_clockevent_enable(struct stm_timer *stm_timer)
+{
+	writel(STM_CCR_CEN, STM_CCR0(stm_timer->base));
+}
+
+static int nxp_stm_clockevent_shutdown(struct clock_event_device *ced)
+{
+	struct stm_timer *stm_timer =3D ced_to_stm(ced);
+
+	nxp_stm_clockevent_disable(stm_timer);
+
+	return 0;
+}
+
+static int nxp_stm_clockevent_set_next_event(unsigned long delta, struct clo=
ck_event_device *ced)
+{
+	struct stm_timer *stm_timer =3D ced_to_stm(ced);
+	u32 val;
+
+	nxp_stm_clockevent_disable(stm_timer);
+
+	stm_timer->delta =3D delta;
+
+	val =3D nxp_stm_clockevent_read_counter(stm_timer) + delta;
+
+	writel(val, STM_CMP0(stm_timer->base));
+
+	/*
+	 * The counter is shared across the channels and can not be
+	 * stopped while we are setting the next event. If the delta
+	 * is very small it is possible the counter increases above
+	 * the computed 'val'. The min_delta value specified when
+	 * registering the clockevent will prevent that. The second
+	 * case is if the counter wraps while we compute the 'val' and
+	 * before writing the comparator register. We read the counter,
+	 * check if we are back in time and abort the timer with -ETIME.
+	 */
+	if (val > nxp_stm_clockevent_read_counter(stm_timer) + delta)
+		return -ETIME;
+
+	nxp_stm_clockevent_enable(stm_timer);
+
+	return 0;
+}
+
+static int nxp_stm_clockevent_set_periodic(struct clock_event_device *ced)
+{
+	struct stm_timer *stm_timer =3D ced_to_stm(ced);
+
+	return nxp_stm_clockevent_set_next_event(stm_timer->rate, ced);
+}
+
+static void nxp_stm_clockevent_suspend(struct clock_event_device *ced)
+{
+	struct stm_timer *stm_timer =3D ced_to_stm(ced);
+
+	nxp_stm_module_put(stm_timer);
+}
+
+static void nxp_stm_clockevent_resume(struct clock_event_device *ced)
+{
+	struct stm_timer *stm_timer =3D ced_to_stm(ced);
+
+	nxp_stm_module_get(stm_timer);
+}
+
+static int __init nxp_stm_clockevent_per_cpu_init(struct device *dev, struct=
 stm_timer *stm_timer,
+						  const char *name, void __iomem *base, int irq,
+						  struct clk *clk, int cpu)
+{
+	stm_timer->base =3D base;
+	stm_timer->rate =3D clk_get_rate(clk);
+
+	stm_timer->ced.name =3D name;
+	stm_timer->ced.features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHO=
T;
+	stm_timer->ced.set_state_shutdown =3D nxp_stm_clockevent_shutdown;
+	stm_timer->ced.set_state_periodic =3D nxp_stm_clockevent_set_periodic;
+	stm_timer->ced.set_next_event =3D nxp_stm_clockevent_set_next_event;
+	stm_timer->ced.suspend =3D nxp_stm_clockevent_suspend;
+	stm_timer->ced.resume =3D nxp_stm_clockevent_resume;
+	stm_timer->ced.cpumask =3D cpumask_of(cpu);
+	stm_timer->ced.rating =3D 460;
+	stm_timer->ced.irq =3D irq;
+
+	per_cpu(stm_timers, cpu) =3D stm_timer;
+
+	nxp_stm_module_get(stm_timer);
+
+	dev_dbg(dev, "Initialized per cpu clockevent name=3D%s, irq=3D%d, cpu=3D%d\=
n", name, irq, cpu);
+
+	return 0;
+}
+
+static int nxp_stm_clockevent_starting_cpu(unsigned int cpu)
+{
+	struct stm_timer *stm_timer =3D per_cpu(stm_timers, cpu);
+	int ret;
+
+	if (WARN_ON(!stm_timer))
+		return -EFAULT;
+
+	ret =3D irq_force_affinity(stm_timer->ced.irq, cpumask_of(cpu));
+	if (ret)
+		return ret;
+
+	/*
+	 * The timings measurement show reading the counter register
+	 * and writing to the comparator register takes as a maximum
+	 * value 1100 ns at 133MHz rate frequency. The timer must be
+	 * set above this value and to be secure we set the minimum
+	 * value equal to 2000ns, so 2us.
+	 *
+	 * minimum ticks =3D (rate / MICRO) * 2
+	 */
+	clockevents_config_and_register(&stm_timer->ced, stm_timer->rate,
+					(stm_timer->rate / MICRO) * 2, ULONG_MAX);
+
+	return 0;
+}
+
+static irqreturn_t nxp_stm_module_interrupt(int irq, void *dev_id)
+{
+	struct stm_timer *stm_timer =3D dev_id;
+	struct clock_event_device *ced =3D &stm_timer->ced;
+	u32 val;
+
+	/*
+	 * The interrupt is shared across the channels in the
+	 * module. But this one is configured to run only one channel,
+	 * consequently it is pointless to test the interrupt flags
+	 * before and we can directly reset the channel 0 irq flag
+	 * register.
+	 */
+	writel(STM_CIR_CIF, STM_CIR0(stm_timer->base));
+
+	/*
+	 * Update STM_CMP value using the counter value
+	 */
+	val =3D nxp_stm_clockevent_read_counter(stm_timer) + stm_timer->delta;
+
+	writel(val, STM_CMP0(stm_timer->base));
+
+	/*
+	 * stm hardware doesn't support oneshot, it will generate an
+	 * interrupt and start the counter again so software needs to
+	 * disable the timer to stop the counter loop in ONESHOT mode.
+	 */
+	if (likely(clockevent_state_oneshot(ced)))
+		nxp_stm_clockevent_disable(stm_timer);
+
+	ced->event_handler(ced);
+
+	return IRQ_HANDLED;
+}
+
+static int __init nxp_stm_timer_probe(struct platform_device *pdev)
+{
+	struct stm_timer *stm_timer;
+	struct device *dev =3D &pdev->dev;
+	struct device_node *np =3D dev->of_node;
+	const char *name =3D of_node_full_name(np);
+	struct clk *clk;
+	void __iomem *base;
+	int irq, ret;
+
+	/*
+	 * The device tree can have multiple STM nodes described, so
+	 * it makes this driver a good candidate for the async probe.
+	 * It is still unclear if the time framework correctly handles
+	 * parallel loading of the timers but at least this driver is
+	 * ready to support the option.
+	 */
+	guard(stm_instances)(&stm_instances_lock);
+
+	/*
+	 * The S32Gx are SoCs featuring a diverse set of cores. Linux
+	 * is expected to run on Cortex-A53 cores, while other
+	 * software stacks will operate on Cortex-M cores. The number
+	 * of STM instances has been sized to include at most one
+	 * instance per core.
+	 *
+	 * As we need a clocksource and a clockevent per cpu, we
+	 * simply initialize a clocksource per cpu along with the
+	 * clockevent which makes the resulting code simpler.
+	 *
+	 * However if the device tree is describing more STM instances
+	 * than the number of cores, then we ignore them.
+	 */
+	if (stm_instances >=3D num_possible_cpus())
+		return 0;
+
+	base =3D devm_of_iomap(dev, np, 0, NULL);
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base), "Failed to iomap %pOFn\n", np);
+
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get IRQ\n");
+
+	clk =3D devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Clock not found\n");
+
+	stm_timer =3D devm_kzalloc(dev, sizeof(*stm_timer), GFP_KERNEL);
+	if (!stm_timer)
+		return -ENOMEM;
+
+	ret =3D devm_request_irq(dev, irq, nxp_stm_module_interrupt,
+			       IRQF_TIMER | IRQF_NOBALANCING, name, stm_timer);
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to allocate interrupt line\n");
+
+	ret =3D nxp_stm_clocksource_init(dev, stm_timer, name, base, clk);
+	if (ret)
+		return ret;
+
+	/*
+	 * Next probed STM will be a per CPU clockevent, until we
+	 * probe as many as we have CPUs available on the system, we
+	 * do a partial initialization
+	 */
+	ret =3D nxp_stm_clockevent_per_cpu_init(dev, stm_timer, name,
+					      base, irq, clk,
+					      stm_instances);
+	if (ret)
+		return ret;
+
+	stm_instances++;
+
+	/*
+	 * The number of probed STMs for per CPU clockevent is
+	 * equal to the number of available CPUs on the
+	 * system. We install the cpu hotplug to finish the
+	 * initialization by registering the clockevents
+	 */
+	if (stm_instances =3D=3D num_possible_cpus()) {
+		ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "STM timer:starting",
+					nxp_stm_clockevent_starting_cpu, NULL);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id nxp_stm_of_match[] =3D {
+	{ .compatible =3D "nxp,s32g2-stm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nxp_stm_of_match);
+
+static struct platform_driver nxp_stm_probe =3D {
+	.probe	=3D nxp_stm_timer_probe,
+	.driver	=3D {
+		.name		=3D "nxp-stm",
+		.of_match_table	=3D nxp_stm_of_match,
+	},
+};
+module_platform_driver(nxp_stm_probe);
+
+MODULE_DESCRIPTION("NXP System Timer Module driver");
+MODULE_LICENSE("GPL");

