Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EE1359BFC
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 12:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhDIK1q (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 06:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhDIK1m (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 06:27:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77015C061760;
        Fri,  9 Apr 2021 03:27:27 -0700 (PDT)
Date:   Fri, 09 Apr 2021 10:27:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617964045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w3h4796W3yIFiflCD3pZLynXoO89kp0CscKIN45ibB0=;
        b=ix/Y+qT0BuPlzZSWgSQrMpLEmX1uWfc7UE321lNaCZ9LEB18+QbQKh/MyMkxgxriKCIa/5
        zdlmpy0zIyzuZkuYvaSdv/Ty6J6ENOvcwTvJyZH+HnnqLW49l3oGFY78LBg9x6cl1Xn8E2
        ff/Fx1AFGi7Uue7WcDbfm/CTnzrkK8iTAcepi77hPCQp2a8QH8AT8HHK9scowo0+cOB/rN
        5vrIfF+VpG4BLYJt1K/zJyVZ737HLUUhhvwUJV5IjRvRsErqLACWwc+kDLfIZV3ARfls8h
        Pow5arMzfOqKBtSTzrUcCeMCPeSyqk2lcAJMsyivRXpULV7EQu6blm/jbjpU2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617964045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w3h4796W3yIFiflCD3pZLynXoO89kp0CscKIN45ibB0=;
        b=GmUFP8iA+07pIy6n4lYHB3G7tMu4GWO2pD+JiOfuIOTWWcawlZ/obeAr7ujsgT2CJVRqOO
        hPtzLOSBV8ClkOCg==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Handle dra7 timer
 wrap errata i940
Cc:     Keerthy <j-keerthy@ti.com>, Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210323074326.28302-3-tony@atomide.com>
References: <20210323074326.28302-3-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <161796404495.29796.7785407556294992309.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     25de4ce5ed02994aea8bc111d133308f6fd62566
Gitweb:        https://git.kernel.org/tip/25de4ce5ed02994aea8bc111d133308f6fd62566
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Tue, 23 Mar 2021 09:43:26 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 08 Apr 2021 16:41:18 +02:00

clocksource/drivers/timer-ti-dm: Handle dra7 timer wrap errata i940

There is a timer wrap issue on dra7 for the ARM architected timer.
In a typical clock configuration the timer fails to wrap after 388 days.

To work around the issue, we need to use timer-ti-dm percpu timers instead.

Let's configure dmtimer3 and 4 as percpu timers by default, and warn about
the issue if the dtb is not configured properly.

Let's do this as a single patch so it can be backported to v5.8 and later
kernels easily. Note that this patch depends on earlier timer-ti-dm
systimer posted mode fixes, and a preparatory clockevent patch
"clocksource/drivers/timer-ti-dm: Prepare to handle dra7 timer wrap issue".

For more information, please see the errata for "AM572x Sitara Processors
Silicon Revisions 1.1, 2.0":

https://www.ti.com/lit/er/sprz429m/sprz429m.pdf

The concept is based on earlier reference patches done by Tero Kristo and
Keerthy.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Tero Kristo <kristo@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210323074326.28302-3-tony@atomide.com
---
 arch/arm/boot/dts/dra7-l4.dtsi             |  4 +-
 arch/arm/boot/dts/dra7.dtsi                | 20 ++++++-
 drivers/clocksource/timer-ti-dm-systimer.c | 76 +++++++++++++++++++++-
 include/linux/cpuhotplug.h                 |  1 +-
 4 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 3bf90d9..a294a02 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -1168,7 +1168,7 @@
 			};
 		};
 
-		target-module@34000 {			/* 0x48034000, ap 7 46.0 */
+		timer3_target: target-module@34000 {	/* 0x48034000, ap 7 46.0 */
 			compatible = "ti,sysc-omap4-timer", "ti,sysc";
 			reg = <0x34000 0x4>,
 			      <0x34010 0x4>;
@@ -1195,7 +1195,7 @@
 			};
 		};
 
-		target-module@36000 {			/* 0x48036000, ap 9 4e.0 */
+		timer4_target: target-module@36000 {	/* 0x48036000, ap 9 4e.0 */
 			compatible = "ti,sysc-omap4-timer", "ti,sysc";
 			reg = <0x36000 0x4>,
 			      <0x36010 0x4>;
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index ce11947..53d6878 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -46,6 +46,7 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
+		status = "disabled";	/* See ARM architected timer wrap erratum i940 */
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
@@ -1241,3 +1242,22 @@
 		assigned-clock-parents = <&sys_32k_ck>;
 	};
 };
+
+/* Local timers, see ARM architected timer wrap erratum i940 */
+&timer3_target {
+	ti,no-reset-on-init;
+	ti,no-idle;
+	timer@0 {
+		assigned-clocks = <&l4per_clkctrl DRA7_L4PER_TIMER3_CLKCTRL 24>;
+		assigned-clock-parents = <&timer_sys_clk_div>;
+	};
+};
+
+&timer4_target {
+	ti,no-reset-on-init;
+	ti,no-idle;
+	timer@0 {
+		assigned-clocks = <&l4per_clkctrl DRA7_L4PER_TIMER4_CLKCTRL 24>;
+		assigned-clock-parents = <&timer_sys_clk_div>;
+	};
+};
diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index 3308031..b6f9796 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -2,6 +2,7 @@
 #include <linux/clk.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
+#include <linux/cpuhotplug.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -630,6 +631,78 @@ err_out_free:
 	return error;
 }
 
+/* Dmtimer as percpu timer. See dra7 ARM architected timer wrap erratum i940 */
+static DEFINE_PER_CPU(struct dmtimer_clockevent, dmtimer_percpu_timer);
+
+static int __init dmtimer_percpu_timer_init(struct device_node *np, int cpu)
+{
+	struct dmtimer_clockevent *clkevt;
+	int error;
+
+	if (!cpu_possible(cpu))
+		return -EINVAL;
+
+	if (!of_property_read_bool(np->parent, "ti,no-reset-on-init") ||
+	    !of_property_read_bool(np->parent, "ti,no-idle"))
+		pr_warn("Incomplete dtb for percpu dmtimer %pOF\n", np->parent);
+
+	clkevt = per_cpu_ptr(&dmtimer_percpu_timer, cpu);
+
+	error = dmtimer_clkevt_init_common(clkevt, np, CLOCK_EVT_FEAT_ONESHOT,
+					   cpumask_of(cpu), "percpu-dmtimer",
+					   500);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+/* See TRM for timer internal resynch latency */
+static int omap_dmtimer_starting_cpu(unsigned int cpu)
+{
+	struct dmtimer_clockevent *clkevt = per_cpu_ptr(&dmtimer_percpu_timer, cpu);
+	struct clock_event_device *dev = &clkevt->dev;
+	struct dmtimer_systimer *t = &clkevt->t;
+
+	clockevents_config_and_register(dev, t->rate, 3, ULONG_MAX);
+	irq_force_affinity(dev->irq, cpumask_of(cpu));
+
+	return 0;
+}
+
+static int __init dmtimer_percpu_timer_startup(void)
+{
+	struct dmtimer_clockevent *clkevt = per_cpu_ptr(&dmtimer_percpu_timer, 0);
+	struct dmtimer_systimer *t = &clkevt->t;
+
+	if (t->sysc) {
+		cpuhp_setup_state(CPUHP_AP_TI_GP_TIMER_STARTING,
+				  "clockevents/omap/gptimer:starting",
+				  omap_dmtimer_starting_cpu, NULL);
+	}
+
+	return 0;
+}
+subsys_initcall(dmtimer_percpu_timer_startup);
+
+static int __init dmtimer_percpu_quirk_init(struct device_node *np, u32 pa)
+{
+	struct device_node *arm_timer;
+
+	arm_timer = of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
+	if (of_device_is_available(arm_timer)) {
+		pr_warn_once("ARM architected timer wrap issue i940 detected\n");
+		return 0;
+	}
+
+	if (pa == 0x48034000)		/* dra7 dmtimer3 */
+		return dmtimer_percpu_timer_init(np, 0);
+	else if (pa == 0x48036000)	/* dra7 dmtimer4 */
+		return dmtimer_percpu_timer_init(np, 1);
+
+	return 0;
+}
+
 /* Clocksource */
 static struct dmtimer_clocksource *
 to_dmtimer_clocksource(struct clocksource *cs)
@@ -763,6 +836,9 @@ static int __init dmtimer_systimer_init(struct device_node *np)
 	if (clockevent == pa)
 		return dmtimer_clockevent_init(np);
 
+	if (of_machine_is_compatible("ti,dra7"))
+		return dmtimer_percpu_quirk_init(np, pa);
+
 	return 0;
 }
 
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f14adb8..cc7c3fd 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -135,6 +135,7 @@ enum cpuhp_state {
 	CPUHP_AP_RISCV_TIMER_STARTING,
 	CPUHP_AP_CLINT_TIMER_STARTING,
 	CPUHP_AP_CSKY_TIMER_STARTING,
+	CPUHP_AP_TI_GP_TIMER_STARTING,
 	CPUHP_AP_HYPERV_TIMER_STARTING,
 	CPUHP_AP_KVM_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING,
