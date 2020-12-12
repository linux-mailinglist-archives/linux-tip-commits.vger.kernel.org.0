Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303322D86B4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438912AbgLLM7v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 07:59:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41384 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438904AbgLLM7d (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 07:59:33 -0500
Date:   Sat, 12 Dec 2020 12:58:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777931;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VHEudTIhg2Gl2G+V/aCUtCdtej8ZwE/NwZECskx3Pxk=;
        b=NVJWYpRMeCn2Svt9VFJZG/vk1I0Q9N7YDDbRmyhflKhuNtIH+DCEnrrbLya1F5DbFwo60D
        hhqnvLp2O17yGWZT6cQg9Ix1ufJORfvD3/GShRTavaJVdlMc0CIsYUs6AaSpvRIcE2hu5L
        7FFU18xtydPVUL4ZQUTNm09dOvM7xM1vzZD32qooq0jcUY4jBrbDb3QsobdtBUEEjavwbP
        hQTIhuoimPURGWM3X9aMzmR2AGqm+FSczD/7WwjOXbMmnyKkgfaAe72GdSWcYMaXhPHbeP
        LVWoV9j8rWYwTbOUjhO5SciNJik6sT6wF7/k8WU4LS9ifbDoDd0+j9g6tok6Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777931;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VHEudTIhg2Gl2G+V/aCUtCdtej8ZwE/NwZECskx3Pxk=;
        b=oVctea8vHfS/wvGgk/47DWJkaZ+Furm4SLC3WLkIFw39UAX5IdtNj8E305ZSqaa093hCRu
        Cke7eeDsAF51b/DA==
From:   "tip-bot2 for Dinh Nguyen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/dw_apb_timer_of: Add error
 handling if no clock available
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201205105223.208604-1-dinguyen@kernel.org>
References: <20201205105223.208604-1-dinguyen@kernel.org>
MIME-Version: 1.0
Message-ID: <160777793079.3364.16456115998718335775.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5d9814df0aec56a638bbf20795abb4cfaf3cd331
Gitweb:        https://git.kernel.org/tip/5d9814df0aec56a638bbf20795abb4cfaf3cd331
Author:        Dinh Nguyen <dinguyen@kernel.org>
AuthorDate:    Sat, 05 Dec 2020 04:52:23 -06:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 05 Dec 2020 19:33:55 +01:00

clocksource/drivers/dw_apb_timer_of: Add error handling if no clock available

commit ("b0fc70ce1f02 arm64: berlin: Select DW_APB_TIMER_OF") added the
support for the dw_apb_timer into the arm64 defconfig. However, for some
platforms like the Intel Stratix10 and Agilex, the clock manager doesn't
get loaded until after the timer driver get loaded. Thus, the driver hits
the panic "No clock nor clock-frequency property for" because it cannot
properly get the clock.

This patch adds the error handling needed for the timer driver so that
the kernel can continue booting instead of just hitting the panic.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201205105223.208604-1-dinguyen@kernel.org
---
 drivers/clocksource/dw_apb_timer_of.c | 57 +++++++++++++++++---------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index ab3ddeb..42e7e43 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -14,12 +14,13 @@
 #include <linux/reset.h>
 #include <linux/sched_clock.h>
 
-static void __init timer_get_base_and_rate(struct device_node *np,
+static int __init timer_get_base_and_rate(struct device_node *np,
 				    void __iomem **base, u32 *rate)
 {
 	struct clk *timer_clk;
 	struct clk *pclk;
 	struct reset_control *rstc;
+	int ret;
 
 	*base = of_iomap(np, 0);
 
@@ -46,55 +47,67 @@ static void __init timer_get_base_and_rate(struct device_node *np,
 			pr_warn("pclk for %pOFn is present, but could not be activated\n",
 				np);
 
+	if (!of_property_read_u32(np, "clock-freq", rate) &&
+	    !of_property_read_u32(np, "clock-frequency", rate))
+		return 0;
+
 	timer_clk = of_clk_get_by_name(np, "timer");
 	if (IS_ERR(timer_clk))
-		goto try_clock_freq;
+		return PTR_ERR(timer_clk);
 
-	if (!clk_prepare_enable(timer_clk)) {
-		*rate = clk_get_rate(timer_clk);
-		return;
-	}
+	ret = clk_prepare_enable(timer_clk);
+	if (ret)
+		return ret;
+
+	*rate = clk_get_rate(timer_clk);
+	if (!(*rate))
+		return -EINVAL;
 
-try_clock_freq:
-	if (of_property_read_u32(np, "clock-freq", rate) &&
-	    of_property_read_u32(np, "clock-frequency", rate))
-		panic("No clock nor clock-frequency property for %pOFn", np);
+	return 0;
 }
 
-static void __init add_clockevent(struct device_node *event_timer)
+static int __init add_clockevent(struct device_node *event_timer)
 {
 	void __iomem *iobase;
 	struct dw_apb_clock_event_device *ced;
 	u32 irq, rate;
+	int ret = 0;
 
 	irq = irq_of_parse_and_map(event_timer, 0);
 	if (irq == 0)
 		panic("No IRQ for clock event timer");
 
-	timer_get_base_and_rate(event_timer, &iobase, &rate);
+	ret = timer_get_base_and_rate(event_timer, &iobase, &rate);
+	if (ret)
+		return ret;
 
 	ced = dw_apb_clockevent_init(-1, event_timer->name, 300, iobase, irq,
 				     rate);
 	if (!ced)
-		panic("Unable to initialise clockevent device");
+		return -EINVAL;
 
 	dw_apb_clockevent_register(ced);
+
+	return 0;
 }
 
 static void __iomem *sched_io_base;
 static u32 sched_rate;
 
-static void __init add_clocksource(struct device_node *source_timer)
+static int __init add_clocksource(struct device_node *source_timer)
 {
 	void __iomem *iobase;
 	struct dw_apb_clocksource *cs;
 	u32 rate;
+	int ret;
 
-	timer_get_base_and_rate(source_timer, &iobase, &rate);
+	ret = timer_get_base_and_rate(source_timer, &iobase, &rate);
+	if (ret)
+		return ret;
 
 	cs = dw_apb_clocksource_init(300, source_timer->name, iobase, rate);
 	if (!cs)
-		panic("Unable to initialise clocksource device");
+		return -EINVAL;
 
 	dw_apb_clocksource_start(cs);
 	dw_apb_clocksource_register(cs);
@@ -106,6 +119,8 @@ static void __init add_clocksource(struct device_node *source_timer)
 	 */
 	sched_io_base = iobase + 0x04;
 	sched_rate = rate;
+
+	return 0;
 }
 
 static u64 notrace read_sched_clock(void)
@@ -146,10 +161,14 @@ static struct delay_timer dw_apb_delay_timer = {
 static int num_called;
 static int __init dw_apb_timer_init(struct device_node *timer)
 {
+	int ret = 0;
+
 	switch (num_called) {
 	case 1:
 		pr_debug("%s: found clocksource timer\n", __func__);
-		add_clocksource(timer);
+		ret = add_clocksource(timer);
+		if (ret)
+			return ret;
 		init_sched_clock();
 #ifdef CONFIG_ARM
 		dw_apb_delay_timer.freq = sched_rate;
@@ -158,7 +177,9 @@ static int __init dw_apb_timer_init(struct device_node *timer)
 		break;
 	default:
 		pr_debug("%s: found clockevent timer\n", __func__);
-		add_clockevent(timer);
+		ret = add_clockevent(timer);
+		if (ret)
+			return ret;
 		break;
 	}
 
