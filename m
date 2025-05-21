Return-Path: <linux-tip-commits+bounces-5719-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EA2ABFA7B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 18:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 496857AC829
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD9B22A1FA;
	Wed, 21 May 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fIqabevJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eOOSP6HS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C02A227E94;
	Wed, 21 May 2025 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842579; cv=none; b=QO1He85yUroI7ph3i7TW9AG0nfJqKPW6gC+1EoafHwr7kLtPIjGiB9iXR/KFlpD1XROA84cH4oIo7DX0Sh8IceOhK7arXrODLmti76eRiooDlK/Li5LB+bqI+kMdhf/XQFue0tJk5A6yrAX688dujE35kVaIew86t2W2Bc0s7+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842579; c=relaxed/simple;
	bh=bqzWSzVtVtcFhTKNGFkLk2myG/E5+grJNJCMiUSXXzQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V87hk7+w+4AG3x6y1hBDBWUAoOdw6vQSn2ckvldZkuieBzEOSXrMYjDi1jpzoSmkO8BuAqWufhzBepAMrErnVpe3vLaHdkgWJxj0bUwkvzFH5MxJnV+kp+p9X41FLx9wVmt7ziz9zMjbHvLNc6kNRwAu4dLNHZqiBThyTFNpfAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fIqabevJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eOOSP6HS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2CafC7m9pSVQSlGo/SQgFCF5iol4m51cNfYKFeUB+U=;
	b=fIqabevJJ7a333JOreBF6EGGZopsUn7WOZO6Q85KX9z1qeklOr4fPm/1yF1GD5e3kQbgxc
	vkfnpTyKLB9mAk82lt4glGV2ZfEf9ZtFL9wlg+HeikqvZS3ne0xGm9Py2DKZp47k4SLv12
	y1A56webJdYgVrFD5p6yiieDxXPZKFu2A8wXqF2x7RgQT8uJAAVonvu0ZNEIIA625xKkfZ
	eJnXuvCl8I7NSmGTkRrFt/dXW3mALwmyyozuJ583K3x36fNbnNNZfiZ+fk6HEj8sa3P0FK
	uF9g+LQov1o3q4FtiSeej/5I0qC5XEILIeDaHbg8Ze3K1g8dl64MuC94rsD8og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2CafC7m9pSVQSlGo/SQgFCF5iol4m51cNfYKFeUB+U=;
	b=eOOSP6HSzUlIjUYCFu37oZZaeozUhHj+8ovl6H/pJtHWudDn6EE9DDVTnJgaZnregOGmD0
	9R4wo1X/LCqngoCg==
From: "tip-bot2 for Caleb James DeLisle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers: Add EcoNet Timer HPT driver
Cc: Caleb James DeLisle <cjd@cjdns.fr>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250507134500.390547-3-cjd@cjdns.fr>
References: <20250507134500.390547-3-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784257481.406.6659367253542693656.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     3b4c33ac87d0d11308f4445ecec2a124e2e77724
Gitweb:        https://git.kernel.org/tip/3b4c33ac87d0d11308f4445ecec2a124e2e77724
Author:        Caleb James DeLisle <cjd@cjdns.fr>
AuthorDate:    Wed, 07 May 2025 13:44:55 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:33 +02:00

clocksource/drivers: Add EcoNet Timer HPT driver

Introduce a clocksource driver for the so-called high-precision timer (HPT)
in the EcoNet EN751221 and EN751627 MIPS SoCs.

It's a 32 bit upward-counting one-shot timer which relies on the crystal so it
is unaffected by CPU power mode. On MIPS 34K devices (single core) there is
one timer, and on 1004K devices (dual core) there are two.

Each timer has two sets of count/compare registers so that there is one for
each of the VPEs on the core. Because each core has 2 VPEs, register selection
takes the CPU number / 2 for the timer corrisponding to the core, then CPU
number % 2 for the register corrisponding to the VPE.

These timers use a percpu-devid IRQ to route interrupts to the VPE which set
the event.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
Link: https://lore.kernel.org/r/20250507134500.390547-3-cjd@cjdns.fr
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig                 |   8 +-
 drivers/clocksource/Makefile                |   1 +-
 drivers/clocksource/timer-econet-en751221.c | 216 +++++++++++++++++++-
 3 files changed, 225 insertions(+)
 create mode 100644 drivers/clocksource/timer-econet-en751221.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 3b63a28..645f517 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -73,6 +73,14 @@ config DW_APB_TIMER_OF
 	select DW_APB_TIMER
 	select TIMER_OF
 
+config ECONET_EN751221_TIMER
+	bool "EcoNet EN751221 High Precision Timer" if COMPILE_TEST
+	depends on HAS_IOMEM
+	select CLKSRC_MMIO
+	select TIMER_OF
+	help
+	  Support for CPU timer found on EcoNet MIPS based SoCs.
+
 config FTTMR010_TIMER
 	bool "Faraday Technology timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 0abc5ca..205bf3b 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
 obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
 obj-$(CONFIG_DAVINCI_TIMER)	+= timer-davinci.o
 obj-$(CONFIG_DIGICOLOR_TIMER)	+= timer-digicolor.o
+obj-$(CONFIG_ECONET_EN751221_TIMER)	+= timer-econet-en751221.o
 obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm.o
 obj-$(CONFIG_OMAP_DM_SYSTIMER)	+= timer-ti-dm-systimer.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
diff --git a/drivers/clocksource/timer-econet-en751221.c b/drivers/clocksource/timer-econet-en751221.c
new file mode 100644
index 0000000..3b449fd
--- /dev/null
+++ b/drivers/clocksource/timer-econet-en751221.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Timer present on EcoNet EN75xx MIPS based SoCs.
+ *
+ * Copyright (C) 2025 by Caleb James DeLisle <cjd@cjdns.fr>
+ */
+
+#include <linux/io.h>
+#include <linux/cpumask.h>
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/sched_clock.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/cpuhotplug.h>
+#include <linux/clk.h>
+
+#define ECONET_BITS			32
+#define ECONET_MIN_DELTA		0x00001000
+#define ECONET_MAX_DELTA		GENMASK(ECONET_BITS - 2, 0)
+/* 34Kc hardware has 1 block and 1004Kc has 2. */
+#define ECONET_NUM_BLOCKS		DIV_ROUND_UP(NR_CPUS, 2)
+
+static struct {
+	void __iomem	*membase[ECONET_NUM_BLOCKS];
+	u32		freq_hz;
+} econet_timer __ro_after_init;
+
+static DEFINE_PER_CPU(struct clock_event_device, econet_timer_pcpu);
+
+/* Each memory block has 2 timers, the order of registers is:
+ * CTL, CMR0, CNT0, CMR1, CNT1
+ */
+static inline void __iomem *reg_ctl(u32 timer_n)
+{
+	return econet_timer.membase[timer_n >> 1];
+}
+
+static inline void __iomem *reg_compare(u32 timer_n)
+{
+	return econet_timer.membase[timer_n >> 1] + (timer_n & 1) * 0x08 + 0x04;
+}
+
+static inline void __iomem *reg_count(u32 timer_n)
+{
+	return econet_timer.membase[timer_n >> 1] + (timer_n & 1) * 0x08 + 0x08;
+}
+
+static inline u32 ctl_bit_enabled(u32 timer_n)
+{
+	return 1U << (timer_n & 1);
+}
+
+static inline u32 ctl_bit_pending(u32 timer_n)
+{
+	return 1U << ((timer_n & 1) + 16);
+}
+
+static bool cevt_is_pending(int cpu_id)
+{
+	return ioread32(reg_ctl(cpu_id)) & ctl_bit_pending(cpu_id);
+}
+
+static irqreturn_t cevt_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *dev = this_cpu_ptr(&econet_timer_pcpu);
+	int cpu = cpumask_first(dev->cpumask);
+
+	/* Each VPE has its own events,
+	 * so this will only happen on spurious interrupt.
+	 */
+	if (!cevt_is_pending(cpu))
+		return IRQ_NONE;
+
+	iowrite32(ioread32(reg_count(cpu)), reg_compare(cpu));
+	dev->event_handler(dev);
+	return IRQ_HANDLED;
+}
+
+static int cevt_set_next_event(ulong delta, struct clock_event_device *dev)
+{
+	u32 next;
+	int cpu;
+
+	cpu = cpumask_first(dev->cpumask);
+	next = ioread32(reg_count(cpu)) + delta;
+	iowrite32(next, reg_compare(cpu));
+
+	if ((s32)(next - ioread32(reg_count(cpu))) < ECONET_MIN_DELTA / 2)
+		return -ETIME;
+
+	return 0;
+}
+
+static int cevt_init_cpu(uint cpu)
+{
+	struct clock_event_device *cd = &per_cpu(econet_timer_pcpu, cpu);
+	u32 reg;
+
+	pr_debug("%s: Setting up clockevent for CPU %d\n", cd->name, cpu);
+
+	reg = ioread32(reg_ctl(cpu)) | ctl_bit_enabled(cpu);
+	iowrite32(reg, reg_ctl(cpu));
+
+	enable_percpu_irq(cd->irq, IRQ_TYPE_NONE);
+
+	/* Do this last because it synchronously configures the timer */
+	clockevents_config_and_register(cd, econet_timer.freq_hz,
+					ECONET_MIN_DELTA, ECONET_MAX_DELTA);
+
+	return 0;
+}
+
+static u64 notrace sched_clock_read(void)
+{
+	/* Always read from clock zero no matter the CPU */
+	return (u64)ioread32(reg_count(0));
+}
+
+/* Init */
+
+static void __init cevt_dev_init(uint cpu)
+{
+	iowrite32(0, reg_count(cpu));
+	iowrite32(U32_MAX, reg_compare(cpu));
+}
+
+static int __init cevt_init(struct device_node *np)
+{
+	int i, irq, ret;
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq <= 0) {
+		pr_err("%pOFn: irq_of_parse_and_map failed", np);
+		return -EINVAL;
+	}
+
+	ret = request_percpu_irq(irq, cevt_interrupt, np->name, &econet_timer_pcpu);
+
+	if (ret < 0) {
+		pr_err("%pOFn: IRQ %d setup failed (%d)\n", np, irq, ret);
+		goto err_unmap_irq;
+	}
+
+	for_each_possible_cpu(i) {
+		struct clock_event_device *cd = &per_cpu(econet_timer_pcpu, i);
+
+		cd->rating		= 310,
+		cd->features		= CLOCK_EVT_FEAT_ONESHOT |
+					  CLOCK_EVT_FEAT_C3STOP |
+					  CLOCK_EVT_FEAT_PERCPU;
+		cd->set_next_event	= cevt_set_next_event;
+		cd->irq			= irq;
+		cd->cpumask		= cpumask_of(i);
+		cd->name		= np->name;
+
+		cevt_dev_init(i);
+	}
+
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+			  "clockevents/econet/timer:starting",
+			  cevt_init_cpu, NULL);
+	return 0;
+
+err_unmap_irq:
+	irq_dispose_mapping(irq);
+	return ret;
+}
+
+static int __init timer_init(struct device_node *np)
+{
+	int num_blocks = DIV_ROUND_UP(num_possible_cpus(), 2);
+	struct clk *clk;
+	int ret;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("%pOFn: Failed to get CPU clock from DT %ld\n", np, PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
+	econet_timer.freq_hz = clk_get_rate(clk);
+
+	for (int i = 0; i < num_blocks; i++) {
+		econet_timer.membase[i] = of_iomap(np, i);
+		if (!econet_timer.membase[i]) {
+			pr_err("%pOFn: failed to map register [%d]\n", np, i);
+			return -ENXIO;
+		}
+	}
+
+	/* For clocksource purposes always read clock zero, whatever the CPU */
+	ret = clocksource_mmio_init(reg_count(0), np->name,
+				    econet_timer.freq_hz, 301, ECONET_BITS,
+				    clocksource_mmio_readl_up);
+	if (ret) {
+		pr_err("%pOFn: clocksource_mmio_init failed: %d", np, ret);
+		return ret;
+	}
+
+	ret = cevt_init(np);
+	if (ret < 0)
+		return ret;
+
+	sched_clock_register(sched_clock_read, ECONET_BITS,
+			     econet_timer.freq_hz);
+
+	pr_info("%pOFn: using %u.%03u MHz high precision timer\n", np,
+		econet_timer.freq_hz / 1000000,
+		(econet_timer.freq_hz / 1000) % 1000);
+
+	return 0;
+}
+
+TIMER_OF_DECLARE(econet_timer_hpt, "econet,en751221-timer", timer_init);

