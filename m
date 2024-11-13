Return-Path: <linux-tip-commits+bounces-2852-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9089A9C7CCA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 21:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21020284176
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 20:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74206208230;
	Wed, 13 Nov 2024 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KRxqga/M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X0koWyE3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527C920651E;
	Wed, 13 Nov 2024 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529254; cv=none; b=HTAlneuViVzTubJaVb30gRExHokXfKmrpSVyoo1/q7O5Pe5nGx6up690ZFNdj2/iPSJwpMB4vYyujufe+88UAVZUHfkthV2upAFgV7BeXjJN0CIopBI2cIpVWFzvrgwDVErp39Zln+ALTVLSVWiUFj3yRIshY9N0lbDIy8Y/Q80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529254; c=relaxed/simple;
	bh=mz1hJfaB2UUwGHtq1m6rbsJHblYcumA44yIAJpb+yhk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J0xUs1JkAeVej/f+42c7BvbrGwUONUnV+cl3QEBboYHaQeHfoXkUw58Jf/cyBuQNVQ3ZkbGZ4PHumODLOV0je/KpHrXSLqzo15A5YE/b1lbdSIEKkpEH7e1tIenTxNXJksPNSBl/GtNjYBA80jztw5ambGD3bx6//4DQlES8ulI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KRxqga/M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X0koWyE3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 20:20:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731529250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIWBjehLe70QQiZ9tt5Yz9vIR5PCs1nas5wWdQK4FbA=;
	b=KRxqga/MSWvuQV/f1tSYqMe8zDgWaNoRzBPqbBgcn0zyeKv0+bdU05ZxP1DyuTvjIw6Oy3
	D0KR/txknV8eyu5gHQA64IwoErGIwV1ltgG47xu7qwankSCkKfONL2MOtvUqrZdkgsIeiH
	9X0LmrYOCqSsav17SqhQKcPq8QUN0t4mDDvdYSlR2ABNAQTo95L1ere135W/2xR2bF2sxP
	o1HF/bKxyl+P2PfU5tkbCBmYNkAt88vCekLykfuO9YZSvG9tEeYlxGb3pN/GBD632ZbLC8
	C7cmXFKXyuN+0S/Jwjhi0Opbb2KcLpLD5uACdXtyPmR3Fn97qnA2PiAuHR/jMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731529250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIWBjehLe70QQiZ9tt5Yz9vIR5PCs1nas5wWdQK4FbA=;
	b=X0koWyE3lJr4VTnV4oi5zaLvVwTlcNtluyREBrel+mKE7w6qNgBKW4rcgd9t8R8lpYRUxZ
	Tc6wTa5djfKMWeDA==
From: "tip-bot2 for Sergio Paracuellos" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/ralink: Add Ralink System Tick
 Counter driver
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241028203643.191268-2-sergio.paracuellos@gmail.com>
References: <20241028203643.191268-2-sergio.paracuellos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173152924977.32228.9160368237825863772.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     cd5375610baadd3a0842a9e83ca502684f938be8
Gitweb:        https://git.kernel.org/tip/cd5375610baadd3a0842a9e83ca502684f938be8
Author:        Sergio Paracuellos <sergio.paracuellos@gmail.com>
AuthorDate:    Mon, 28 Oct 2024 21:36:43 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 13 Nov 2024 13:49:33 +01:00

clocksource/drivers/ralink: Add Ralink System Tick Counter driver

System Tick Counter is present on Ralink SoCs RT3352 and MT7620. This
driver has been in 'arch/mips/ralink' directory since the beggining of
Ralink architecture support. However, it can be moved into a more proper
place in 'drivers/clocksource'. Hence add it here adding also support for
compile test targets and reducing LOC in architecture code folder.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Link: https://lore.kernel.org/r/20241028203643.191268-2-sergio.paracuellos@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/mips/ralink/Kconfig           |   7 +-
 arch/mips/ralink/Makefile          |   2 +-
 arch/mips/ralink/cevt-rt3352.c     | 153 +----------------------------
 drivers/clocksource/Kconfig        |   9 ++-
 drivers/clocksource/Makefile       |   1 +-
 drivers/clocksource/timer-ralink.c | 150 +++++++++++++++++++++++++++-
 6 files changed, 160 insertions(+), 162 deletions(-)
 delete mode 100644 arch/mips/ralink/cevt-rt3352.c
 create mode 100644 drivers/clocksource/timer-ralink.c

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 08c012a..910d059 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -1,13 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 if RALINK
 
-config CLKEVT_RT3352
-	bool
-	depends on SOC_RT305X || SOC_MT7620
-	default y
-	select TIMER_OF
-	select CLKSRC_MMIO
-
 config RALINK_ILL_ACC
 	bool
 	depends on SOC_RT305X
diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index 26fabbd..0c109ea 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -10,8 +10,6 @@ ifndef CONFIG_MIPS_GIC
 	obj-y += clk.o timer.o
 endif
 
-obj-$(CONFIG_CLKEVT_RT3352) += cevt-rt3352.o
-
 obj-$(CONFIG_RALINK_ILL_ACC) += ill_acc.o
 
 obj-$(CONFIG_IRQ_INTC) += irq.o
diff --git a/arch/mips/ralink/cevt-rt3352.c b/arch/mips/ralink/cevt-rt3352.c
deleted file mode 100644
index 269d487..0000000
--- a/arch/mips/ralink/cevt-rt3352.c
+++ /dev/null
@@ -1,153 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2013 by John Crispin <john@phrozen.org>
- */
-
-#include <linux/clockchips.h>
-#include <linux/clocksource.h>
-#include <linux/interrupt.h>
-#include <linux/reset.h>
-#include <linux/init.h>
-#include <linux/time.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-
-#include <asm/mach-ralink/ralink_regs.h>
-
-#define SYSTICK_FREQ		(50 * 1000)
-
-#define SYSTICK_CONFIG		0x00
-#define SYSTICK_COMPARE		0x04
-#define SYSTICK_COUNT		0x08
-
-/* route systick irq to mips irq 7 instead of the r4k-timer */
-#define CFG_EXT_STK_EN		0x2
-/* enable the counter */
-#define CFG_CNT_EN		0x1
-
-struct systick_device {
-	void __iomem *membase;
-	struct clock_event_device dev;
-	int irq_requested;
-	int freq_scale;
-};
-
-static int systick_set_oneshot(struct clock_event_device *evt);
-static int systick_shutdown(struct clock_event_device *evt);
-
-static int systick_next_event(unsigned long delta,
-				struct clock_event_device *evt)
-{
-	struct systick_device *sdev;
-	u32 count;
-
-	sdev = container_of(evt, struct systick_device, dev);
-	count = ioread32(sdev->membase + SYSTICK_COUNT);
-	count = (count + delta) % SYSTICK_FREQ;
-	iowrite32(count, sdev->membase + SYSTICK_COMPARE);
-
-	return 0;
-}
-
-static void systick_event_handler(struct clock_event_device *dev)
-{
-	/* noting to do here */
-}
-
-static irqreturn_t systick_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *dev = (struct clock_event_device *) dev_id;
-
-	dev->event_handler(dev);
-
-	return IRQ_HANDLED;
-}
-
-static struct systick_device systick = {
-	.dev = {
-		/*
-		 * cevt-r4k uses 300, make sure systick
-		 * gets used if available
-		 */
-		.rating			= 310,
-		.features		= CLOCK_EVT_FEAT_ONESHOT,
-		.set_next_event		= systick_next_event,
-		.set_state_shutdown	= systick_shutdown,
-		.set_state_oneshot	= systick_set_oneshot,
-		.event_handler		= systick_event_handler,
-	},
-};
-
-static int systick_shutdown(struct clock_event_device *evt)
-{
-	struct systick_device *sdev;
-
-	sdev = container_of(evt, struct systick_device, dev);
-
-	if (sdev->irq_requested)
-		free_irq(systick.dev.irq, &systick.dev);
-	sdev->irq_requested = 0;
-	iowrite32(0, systick.membase + SYSTICK_CONFIG);
-
-	return 0;
-}
-
-static int systick_set_oneshot(struct clock_event_device *evt)
-{
-	const char *name = systick.dev.name;
-	struct systick_device *sdev;
-	int irq = systick.dev.irq;
-
-	sdev = container_of(evt, struct systick_device, dev);
-
-	if (!sdev->irq_requested) {
-		if (request_irq(irq, systick_interrupt,
-				IRQF_PERCPU | IRQF_TIMER, name, &systick.dev))
-			pr_err("Failed to request irq %d (%s)\n", irq, name);
-	}
-	sdev->irq_requested = 1;
-	iowrite32(CFG_EXT_STK_EN | CFG_CNT_EN,
-		  systick.membase + SYSTICK_CONFIG);
-
-	return 0;
-}
-
-static int __init ralink_systick_init(struct device_node *np)
-{
-	int ret;
-
-	systick.membase = of_iomap(np, 0);
-	if (!systick.membase)
-		return -ENXIO;
-
-	systick.dev.name = np->name;
-	clockevents_calc_mult_shift(&systick.dev, SYSTICK_FREQ, 60);
-	systick.dev.max_delta_ns = clockevent_delta2ns(0x7fff, &systick.dev);
-	systick.dev.max_delta_ticks = 0x7fff;
-	systick.dev.min_delta_ns = clockevent_delta2ns(0x3, &systick.dev);
-	systick.dev.min_delta_ticks = 0x3;
-	systick.dev.irq = irq_of_parse_and_map(np, 0);
-	if (!systick.dev.irq) {
-		pr_err("%pOFn: request_irq failed", np);
-		return -EINVAL;
-	}
-
-	ret = clocksource_mmio_init(systick.membase + SYSTICK_COUNT, np->name,
-				    SYSTICK_FREQ, 301, 16,
-				    clocksource_mmio_readl_up);
-	if (ret)
-		return ret;
-
-	clockevents_register_device(&systick.dev);
-
-	pr_info("%pOFn: running - mult: %d, shift: %d\n",
-			np, systick.dev.mult, systick.dev.shift);
-
-	return 0;
-}
-
-TIMER_OF_DECLARE(systick, "ralink,cevt-systick", ralink_systick_init);
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index d546903..487c852 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -754,4 +754,13 @@ config EP93XX_TIMER
 	  Enables support for the Cirrus Logic timer block
 	  EP93XX.
 
+config RALINK_TIMER
+	bool "Ralink System Tick Counter"
+	depends on SOC_RT305X || SOC_MT7620 || COMPILE_TEST
+	select CLKSRC_MMIO
+	select TIMER_OF
+	help
+	  Enables support for system tick counter present on
+	  Ralink SoCs RT3352 and MT7620.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 2274378..43ef16a 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -91,3 +91,4 @@ obj-$(CONFIG_GOLDFISH_TIMER)		+= timer-goldfish.o
 obj-$(CONFIG_GXP_TIMER)			+= timer-gxp.o
 obj-$(CONFIG_CLKSRC_LOONGSON1_PWM)	+= timer-loongson1-pwm.o
 obj-$(CONFIG_EP93XX_TIMER)		+= timer-ep93xx.o
+obj-$(CONFIG_RALINK_TIMER)		+= timer-ralink.o
diff --git a/drivers/clocksource/timer-ralink.c b/drivers/clocksource/timer-ralink.c
new file mode 100644
index 0000000..6ecdb42
--- /dev/null
+++ b/drivers/clocksource/timer-ralink.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ralink System Tick Counter driver present on RT3352 and MT7620 SoCs.
+ *
+ * Copyright (C) 2013 by John Crispin <john@phrozen.org>
+ */
+
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
+#include <linux/reset.h>
+#include <linux/init.h>
+#include <linux/time.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+
+#define SYSTICK_FREQ		(50 * 1000)
+
+#define SYSTICK_CONFIG		0x00
+#define SYSTICK_COMPARE		0x04
+#define SYSTICK_COUNT		0x08
+
+/* route systick irq to mips irq 7 instead of the r4k-timer */
+#define CFG_EXT_STK_EN		0x2
+/* enable the counter */
+#define CFG_CNT_EN		0x1
+
+struct systick_device {
+	void __iomem *membase;
+	struct clock_event_device dev;
+	int irq_requested;
+	int freq_scale;
+};
+
+static int systick_set_oneshot(struct clock_event_device *evt);
+static int systick_shutdown(struct clock_event_device *evt);
+
+static int systick_next_event(unsigned long delta,
+			      struct clock_event_device *evt)
+{
+	struct systick_device *sdev;
+	u32 count;
+
+	sdev = container_of(evt, struct systick_device, dev);
+	count = ioread32(sdev->membase + SYSTICK_COUNT);
+	count = (count + delta) % SYSTICK_FREQ;
+	iowrite32(count, sdev->membase + SYSTICK_COMPARE);
+
+	return 0;
+}
+
+static void systick_event_handler(struct clock_event_device *dev)
+{
+	/* noting to do here */
+}
+
+static irqreturn_t systick_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *dev = (struct clock_event_device *)dev_id;
+
+	dev->event_handler(dev);
+
+	return IRQ_HANDLED;
+}
+
+static struct systick_device systick = {
+	.dev = {
+		/*
+		 * cevt-r4k uses 300, make sure systick
+		 * gets used if available
+		 */
+		.rating			= 310,
+		.features		= CLOCK_EVT_FEAT_ONESHOT,
+		.set_next_event		= systick_next_event,
+		.set_state_shutdown	= systick_shutdown,
+		.set_state_oneshot	= systick_set_oneshot,
+		.event_handler		= systick_event_handler,
+	},
+};
+
+static int systick_shutdown(struct clock_event_device *evt)
+{
+	struct systick_device *sdev;
+
+	sdev = container_of(evt, struct systick_device, dev);
+
+	if (sdev->irq_requested)
+		free_irq(systick.dev.irq, &systick.dev);
+	sdev->irq_requested = 0;
+	iowrite32(0, systick.membase + SYSTICK_CONFIG);
+
+	return 0;
+}
+
+static int systick_set_oneshot(struct clock_event_device *evt)
+{
+	const char *name = systick.dev.name;
+	struct systick_device *sdev;
+	int irq = systick.dev.irq;
+
+	sdev = container_of(evt, struct systick_device, dev);
+
+	if (!sdev->irq_requested) {
+		if (request_irq(irq, systick_interrupt,
+				IRQF_PERCPU | IRQF_TIMER, name, &systick.dev))
+			pr_err("Failed to request irq %d (%s)\n", irq, name);
+	}
+	sdev->irq_requested = 1;
+	iowrite32(CFG_EXT_STK_EN | CFG_CNT_EN,
+		  systick.membase + SYSTICK_CONFIG);
+
+	return 0;
+}
+
+static int __init ralink_systick_init(struct device_node *np)
+{
+	int ret;
+
+	systick.membase = of_iomap(np, 0);
+	if (!systick.membase)
+		return -ENXIO;
+
+	systick.dev.name = np->name;
+	clockevents_calc_mult_shift(&systick.dev, SYSTICK_FREQ, 60);
+	systick.dev.max_delta_ns = clockevent_delta2ns(0x7fff, &systick.dev);
+	systick.dev.max_delta_ticks = 0x7fff;
+	systick.dev.min_delta_ns = clockevent_delta2ns(0x3, &systick.dev);
+	systick.dev.min_delta_ticks = 0x3;
+	systick.dev.irq = irq_of_parse_and_map(np, 0);
+	if (!systick.dev.irq) {
+		pr_err("%pOFn: request_irq failed", np);
+		return -EINVAL;
+	}
+
+	ret = clocksource_mmio_init(systick.membase + SYSTICK_COUNT, np->name,
+				    SYSTICK_FREQ, 301, 16,
+				    clocksource_mmio_readl_up);
+	if (ret)
+		return ret;
+
+	clockevents_register_device(&systick.dev);
+
+	pr_info("%pOFn: running - mult: %d, shift: %d\n",
+			np, systick.dev.mult, systick.dev.shift);
+
+	return 0;
+}
+
+TIMER_OF_DECLARE(systick, "ralink,cevt-systick", ralink_systick_init);

