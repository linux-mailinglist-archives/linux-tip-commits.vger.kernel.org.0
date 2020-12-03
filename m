Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E7A2CE2FF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Dec 2020 00:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbgLCXtN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 18:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgLCXtN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 18:49:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEE0C061A55;
        Thu,  3 Dec 2020 15:47:53 -0800 (PST)
Date:   Thu, 03 Dec 2020 23:47:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607039271;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J52ZGbGm3TOBF8q7c6bCGai971ChrkdxHwjXlwF1lDw=;
        b=ZuRk+8LO9j/2/0U+yvIQngfmHxALg6F4yHrNNkvwHcnOr4rzuGSiZ4/o2gn73KN4p2u4OE
        ljN7K9tzZmzqfs2KG6v6pI+7SA0qRDu7KUDbKJ5Plu5M+EaPzjK8PNXlfdDou5p+AUo/EK
        XgfxZIq/0FU3osxooNg6wnCGfb4uESnFXFs0kn52lg+Az8Vzx8m7Yk7RnjyhLEJZgxXoR9
        lv/Ij33ZmqWOlkCpHGpxem88ly8ULvXlADnFBigqbjh1BUeHHnQ/vOfHoryogcehPTDg6V
        24nh8UoKMJleWS61vYpD5ehUCEErcrZcHpYigKnVyGXpaPzi8LU+ulRR52YULw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607039271;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J52ZGbGm3TOBF8q7c6bCGai971ChrkdxHwjXlwF1lDw=;
        b=3+zhL8nptwod4EK+nR8lyJ/pcTHFg4frEiEu5AXEiCfGnmc6jMihbldGVCLooJEMNN5qJh
        hmz/ozY4btS3DqAg==
From:   "tip-bot2 for Vineet Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/nps: Remove EZChip NPS
 clocksource driver
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        x86@kernel.org
In-Reply-To: <20201105212210.1891598-2-vgupta@synopsys.com>
References: <20201105212210.1891598-2-vgupta@synopsys.com>
MIME-Version: 1.0
Message-ID: <160703927112.3364.16055880264291796769.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b6ea209ef124dad4045772a759e2aecd191534c0
Gitweb:        https://git.kernel.org/tip/b6ea209ef124dad4045772a759e2aecd191534c0
Author:        Vineet Gupta <Vineet.Gupta1@synopsys.com>
AuthorDate:    Thu, 05 Nov 2020 13:22:08 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 03 Dec 2020 19:16:18 +01:00

clocksource/drivers/nps: Remove EZChip NPS clocksource driver

NPS platform has been removed from ARC port and there are no in-tree
users of it now. So RIP !

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201105212210.1891598-2-vgupta@synopsys.com
---
 drivers/clocksource/Kconfig     |  10 +-
 drivers/clocksource/Makefile    |   1 +-
 drivers/clocksource/timer-nps.c | 284 +-------------------------------
 3 files changed, 295 deletions(-)
 delete mode 100644 drivers/clocksource/timer-nps.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 68b087b..390c27c 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -275,16 +275,6 @@ config CLKSRC_TI_32K
 	  This option enables support for Texas Instruments 32.768 Hz clocksource
 	  available on many OMAP-like platforms.
 
-config CLKSRC_NPS
-	bool "NPS400 clocksource driver" if COMPILE_TEST
-	depends on !PHYS_ADDR_T_64BIT
-	select CLKSRC_MMIO
-	select TIMER_OF if OF
-	help
-	  NPS400 clocksource support.
-	  It has a 64-bit counter with update rate up to 1000MHz.
-	  This counter is accessed via couple of 32-bit memory-mapped registers.
-
 config CLKSRC_STM32
 	bool "Clocksource for STM32 SoCs" if !ARCH_STM32
 	depends on OF && ARM && (ARCH_STM32 || COMPILE_TEST)
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 1c444cc..3c75cbb 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -56,7 +56,6 @@ obj-$(CONFIG_CLKSRC_QCOM)	+= timer-qcom.o
 obj-$(CONFIG_MTK_TIMER)		+= timer-mediatek.o
 obj-$(CONFIG_CLKSRC_PISTACHIO)	+= timer-pistachio.o
 obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
-obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
 obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
 obj-$(CONFIG_OWL_TIMER)		+= timer-owl.o
 obj-$(CONFIG_MILBEAUT_TIMER)	+= timer-milbeaut.o
diff --git a/drivers/clocksource/timer-nps.c b/drivers/clocksource/timer-nps.c
deleted file mode 100644
index 7b6bb0d..0000000
--- a/drivers/clocksource/timer-nps.c
+++ /dev/null
@@ -1,284 +0,0 @@
-/*
- * Copyright (c) 2016, Mellanox Technologies. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- */
-
-#include <linux/interrupt.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-#include <linux/clk.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/cpu.h>
-#include <soc/nps/common.h>
-
-#define NPS_MSU_TICK_LOW	0xC8
-#define NPS_CLUSTER_OFFSET	8
-#define NPS_CLUSTER_NUM		16
-
-/* This array is per cluster of CPUs (Each NPS400 cluster got 256 CPUs) */
-static void *nps_msu_reg_low_addr[NPS_CLUSTER_NUM] __read_mostly;
-
-static int __init nps_get_timer_clk(struct device_node *node,
-			     unsigned long *timer_freq,
-			     struct clk **clk)
-{
-	int ret;
-
-	*clk = of_clk_get(node, 0);
-	ret = PTR_ERR_OR_ZERO(*clk);
-	if (ret) {
-		pr_err("timer missing clk\n");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(*clk);
-	if (ret) {
-		pr_err("Couldn't enable parent clk\n");
-		clk_put(*clk);
-		return ret;
-	}
-
-	*timer_freq = clk_get_rate(*clk);
-	if (!(*timer_freq)) {
-		pr_err("Couldn't get clk rate\n");
-		clk_disable_unprepare(*clk);
-		clk_put(*clk);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static u64 nps_clksrc_read(struct clocksource *clksrc)
-{
-	int cluster = raw_smp_processor_id() >> NPS_CLUSTER_OFFSET;
-
-	return (u64)ioread32be(nps_msu_reg_low_addr[cluster]);
-}
-
-static int __init nps_setup_clocksource(struct device_node *node)
-{
-	int ret, cluster;
-	struct clk *clk;
-	unsigned long nps_timer1_freq;
-
-
-	for (cluster = 0; cluster < NPS_CLUSTER_NUM; cluster++)
-		nps_msu_reg_low_addr[cluster] =
-			nps_host_reg((cluster << NPS_CLUSTER_OFFSET),
-				     NPS_MSU_BLKID, NPS_MSU_TICK_LOW);
-
-	ret = nps_get_timer_clk(node, &nps_timer1_freq, &clk);
-	if (ret)
-		return ret;
-
-	ret = clocksource_mmio_init(nps_msu_reg_low_addr, "nps-tick",
-				    nps_timer1_freq, 300, 32, nps_clksrc_read);
-	if (ret) {
-		pr_err("Couldn't register clock source.\n");
-		clk_disable_unprepare(clk);
-	}
-
-	return ret;
-}
-
-TIMER_OF_DECLARE(ezchip_nps400_clksrc, "ezchip,nps400-timer",
-		       nps_setup_clocksource);
-TIMER_OF_DECLARE(ezchip_nps400_clk_src, "ezchip,nps400-timer1",
-		       nps_setup_clocksource);
-
-#ifdef CONFIG_EZNPS_MTM_EXT
-#include <soc/nps/mtm.h>
-
-/* Timer related Aux registers */
-#define NPS_REG_TIMER0_TSI	0xFFFFF850
-#define NPS_REG_TIMER0_LIMIT	0x23
-#define NPS_REG_TIMER0_CTRL	0x22
-#define NPS_REG_TIMER0_CNT	0x21
-
-/*
- * Interrupt Enabled (IE) - re-arm the timer
- * Not Halted (NH) - is cleared when working with JTAG (for debug)
- */
-#define TIMER0_CTRL_IE		BIT(0)
-#define TIMER0_CTRL_NH		BIT(1)
-
-static unsigned long nps_timer0_freq;
-static unsigned long nps_timer0_irq;
-
-static void nps_clkevent_rm_thread(void)
-{
-	int thread;
-	unsigned int cflags, enabled_threads;
-
-	hw_schd_save(&cflags);
-
-	enabled_threads = read_aux_reg(NPS_REG_TIMER0_TSI);
-
-	/* remove thread from TSI1 */
-	thread = read_aux_reg(CTOP_AUX_THREAD_ID);
-	enabled_threads &= ~(1 << thread);
-	write_aux_reg(NPS_REG_TIMER0_TSI, enabled_threads);
-
-	/* Acknowledge and if needed re-arm the timer */
-	if (!enabled_threads)
-		write_aux_reg(NPS_REG_TIMER0_CTRL, TIMER0_CTRL_NH);
-	else
-		write_aux_reg(NPS_REG_TIMER0_CTRL,
-			      TIMER0_CTRL_IE | TIMER0_CTRL_NH);
-
-	hw_schd_restore(cflags);
-}
-
-static void nps_clkevent_add_thread(unsigned long delta)
-{
-	int thread;
-	unsigned int cflags, enabled_threads;
-
-	hw_schd_save(&cflags);
-
-	/* add thread to TSI1 */
-	thread = read_aux_reg(CTOP_AUX_THREAD_ID);
-	enabled_threads = read_aux_reg(NPS_REG_TIMER0_TSI);
-	enabled_threads |= (1 << thread);
-	write_aux_reg(NPS_REG_TIMER0_TSI, enabled_threads);
-
-	/* set next timer event */
-	write_aux_reg(NPS_REG_TIMER0_LIMIT, delta);
-	write_aux_reg(NPS_REG_TIMER0_CNT, 0);
-	write_aux_reg(NPS_REG_TIMER0_CTRL,
-		      TIMER0_CTRL_IE | TIMER0_CTRL_NH);
-
-	hw_schd_restore(cflags);
-}
-
-/*
- * Whenever anyone tries to change modes, we just mask interrupts
- * and wait for the next event to get set.
- */
-static int nps_clkevent_set_state(struct clock_event_device *dev)
-{
-	nps_clkevent_rm_thread();
-	disable_percpu_irq(nps_timer0_irq);
-
-	return 0;
-}
-
-static int nps_clkevent_set_next_event(unsigned long delta,
-				       struct clock_event_device *dev)
-{
-	nps_clkevent_add_thread(delta);
-	enable_percpu_irq(nps_timer0_irq, IRQ_TYPE_NONE);
-
-	return 0;
-}
-
-static DEFINE_PER_CPU(struct clock_event_device, nps_clockevent_device) = {
-	.name				=	"NPS Timer0",
-	.features			=	CLOCK_EVT_FEAT_ONESHOT,
-	.rating				=	300,
-	.set_next_event			=	nps_clkevent_set_next_event,
-	.set_state_oneshot		=	nps_clkevent_set_state,
-	.set_state_oneshot_stopped	=	nps_clkevent_set_state,
-	.set_state_shutdown		=	nps_clkevent_set_state,
-	.tick_resume			=	nps_clkevent_set_state,
-};
-
-static irqreturn_t timer_irq_handler(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-
-	nps_clkevent_rm_thread();
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static int nps_timer_starting_cpu(unsigned int cpu)
-{
-	struct clock_event_device *evt = this_cpu_ptr(&nps_clockevent_device);
-
-	evt->cpumask = cpumask_of(smp_processor_id());
-
-	clockevents_config_and_register(evt, nps_timer0_freq, 0, ULONG_MAX);
-	enable_percpu_irq(nps_timer0_irq, IRQ_TYPE_NONE);
-
-	return 0;
-}
-
-static int nps_timer_dying_cpu(unsigned int cpu)
-{
-	disable_percpu_irq(nps_timer0_irq);
-	return 0;
-}
-
-static int __init nps_setup_clockevent(struct device_node *node)
-{
-	struct clk *clk;
-	int ret;
-
-	nps_timer0_irq = irq_of_parse_and_map(node, 0);
-	if (nps_timer0_irq <= 0) {
-		pr_err("clockevent: missing irq\n");
-		return -EINVAL;
-	}
-
-	ret = nps_get_timer_clk(node, &nps_timer0_freq, &clk);
-	if (ret)
-		return ret;
-
-	/* Needs apriori irq_set_percpu_devid() done in intc map function */
-	ret = request_percpu_irq(nps_timer0_irq, timer_irq_handler,
-				 "Timer0 (per-cpu-tick)",
-				 &nps_clockevent_device);
-	if (ret) {
-		pr_err("Couldn't request irq\n");
-		clk_disable_unprepare(clk);
-		return ret;
-	}
-
-	ret = cpuhp_setup_state(CPUHP_AP_ARC_TIMER_STARTING,
-				"clockevents/nps:starting",
-				nps_timer_starting_cpu,
-				nps_timer_dying_cpu);
-	if (ret) {
-		pr_err("Failed to setup hotplug state\n");
-		clk_disable_unprepare(clk);
-		free_percpu_irq(nps_timer0_irq, &nps_clockevent_device);
-		return ret;
-	}
-
-	return 0;
-}
-
-TIMER_OF_DECLARE(ezchip_nps400_clk_evt, "ezchip,nps400-timer0",
-		       nps_setup_clockevent);
-#endif /* CONFIG_EZNPS_MTM_EXT */
