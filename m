Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A0D359BFF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 12:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhDIK1r (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 06:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbhDIK1m (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 06:27:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A47C061762;
        Fri,  9 Apr 2021 03:27:27 -0700 (PDT)
Date:   Fri, 09 Apr 2021 10:27:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617964046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0fZC1yS04ZZUMJP0u1DS95boL5zIHDDetlF7JUEXzA=;
        b=ZnZK2Ggo/3ImnyWSWt0Va9LPyhmrkAacO7qexduLfb84BDGAXASJSCxucUv9leDEfgR2LU
        iWd7acSAF+0WDxJaQulOaSMTnIyaCD7yje4m+H7LiKPaw3UhzFtXefX7Pt9cWbWbsoulzD
        lKMw+Oa60O9LQy6TlPGzfggoibX/mmxzlIc6I/0YOvmXaxcyAnkiTqLS7ClQCckLKrKyn2
        2wImWaFpzqwaygo1AsaHVdeGQvjMg/6PviTJtpy+wAUDzcYenpcqFQhvwYlCK1/6MaUzyh
        JMOMrOAhDS6MS6xq3zVHXYFjF0Xttvec4uxcyXi8i/Yay0+ba7FsB5/DB36H+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617964046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0fZC1yS04ZZUMJP0u1DS95boL5zIHDDetlF7JUEXzA=;
        b=hau0AxuPEMwNdPn/ejq2CQt5c2p389R9Eh3OeFmPKQYdBAWK75EFQuSP5YRQGesQtrHPJ7
        2GcMwFwW4/XZdsBg==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Prepare to handle
 dra7 timer wrap issue
Cc:     Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210323074326.28302-2-tony@atomide.com>
References: <20210323074326.28302-2-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <161796404538.29796.4926091444188954187.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3efe7a878a11c13b5297057bfc1e5639ce1241ce
Gitweb:        https://git.kernel.org/tip/3efe7a878a11c13b5297057bfc1e5639ce1241ce
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Tue, 23 Mar 2021 09:43:25 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 08 Apr 2021 16:15:54 +02:00

clocksource/drivers/timer-ti-dm: Prepare to handle dra7 timer wrap issue

There is a timer wrap issue on dra7 for the ARM architected timer.
In a typical clock configuration the timer fails to wrap after 388 days.

To work around the issue, we need to use timer-ti-dm timers instead.

Let's prepare for adding support for percpu timers by adding a common
dmtimer_clkevt_init_common() and call it from dmtimer_clockevent_init().
This patch makes no intentional functional changes.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210323074326.28302-2-tony@atomide.com
---
 drivers/clocksource/timer-ti-dm-systimer.c | 66 +++++++++++++--------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index 186a599..3308031 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -530,17 +530,17 @@ static void omap_clockevent_unidle(struct clock_event_device *evt)
 	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, t->base + t->wakeup);
 }
 
-static int __init dmtimer_clockevent_init(struct device_node *np)
+static int __init dmtimer_clkevt_init_common(struct dmtimer_clockevent *clkevt,
+					     struct device_node *np,
+					     unsigned int features,
+					     const struct cpumask *cpumask,
+					     const char *name,
+					     int rating)
 {
-	struct dmtimer_clockevent *clkevt;
 	struct clock_event_device *dev;
 	struct dmtimer_systimer *t;
 	int error;
 
-	clkevt = kzalloc(sizeof(*clkevt), GFP_KERNEL);
-	if (!clkevt)
-		return -ENOMEM;
-
 	t = &clkevt->t;
 	dev = &clkevt->dev;
 
@@ -548,25 +548,23 @@ static int __init dmtimer_clockevent_init(struct device_node *np)
 	 * We mostly use cpuidle_coupled with ARM local timers for runtime,
 	 * so there's probably no use for CLOCK_EVT_FEAT_DYNIRQ here.
 	 */
-	dev->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	dev->rating = 300;
+	dev->features = features;
+	dev->rating = rating;
 	dev->set_next_event = dmtimer_set_next_event;
 	dev->set_state_shutdown = dmtimer_clockevent_shutdown;
 	dev->set_state_periodic = dmtimer_set_periodic;
 	dev->set_state_oneshot = dmtimer_clockevent_shutdown;
 	dev->set_state_oneshot_stopped = dmtimer_clockevent_shutdown;
 	dev->tick_resume = dmtimer_clockevent_shutdown;
-	dev->cpumask = cpu_possible_mask;
+	dev->cpumask = cpumask;
 
 	dev->irq = irq_of_parse_and_map(np, 0);
-	if (!dev->irq) {
-		error = -ENXIO;
-		goto err_out_free;
-	}
+	if (!dev->irq)
+		return -ENXIO;
 
 	error = dmtimer_systimer_setup(np, &clkevt->t);
 	if (error)
-		goto err_out_free;
+		return error;
 
 	clkevt->period = 0xffffffff - DIV_ROUND_CLOSEST(t->rate, HZ);
 
@@ -578,32 +576,54 @@ static int __init dmtimer_clockevent_init(struct device_node *np)
 	writel_relaxed(OMAP_TIMER_CTRL_POSTED, t->base + t->ifctrl);
 
 	error = request_irq(dev->irq, dmtimer_clockevent_interrupt,
-			    IRQF_TIMER, "clockevent", clkevt);
+			    IRQF_TIMER, name, clkevt);
 	if (error)
 		goto err_out_unmap;
 
 	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, t->base + t->irq_ena);
 	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, t->base + t->wakeup);
 
-	pr_info("TI gptimer clockevent: %s%lu Hz at %pOF\n",
-		of_find_property(np, "ti,timer-alwon", NULL) ?
+	pr_info("TI gptimer %s: %s%lu Hz at %pOF\n",
+		name, of_find_property(np, "ti,timer-alwon", NULL) ?
 		"always-on " : "", t->rate, np->parent);
 
-	clockevents_config_and_register(dev, t->rate,
+	return 0;
+
+err_out_unmap:
+	iounmap(t->base);
+
+	return error;
+}
+
+static int __init dmtimer_clockevent_init(struct device_node *np)
+{
+	struct dmtimer_clockevent *clkevt;
+	int error;
+
+	clkevt = kzalloc(sizeof(*clkevt), GFP_KERNEL);
+	if (!clkevt)
+		return -ENOMEM;
+
+	error = dmtimer_clkevt_init_common(clkevt, np,
+					   CLOCK_EVT_FEAT_PERIODIC |
+					   CLOCK_EVT_FEAT_ONESHOT,
+					   cpu_possible_mask, "clockevent",
+					   300);
+	if (error)
+		goto err_out_free;
+
+	clockevents_config_and_register(&clkevt->dev, clkevt->t.rate,
 					3, /* Timer internal resync latency */
 					0xffffffff);
 
 	if (of_machine_is_compatible("ti,am33xx") ||
 	    of_machine_is_compatible("ti,am43")) {
-		dev->suspend = omap_clockevent_idle;
-		dev->resume = omap_clockevent_unidle;
+		clkevt->dev.suspend = omap_clockevent_idle;
+		clkevt->dev.resume = omap_clockevent_unidle;
 	}
 
 	return 0;
 
-err_out_unmap:
-	iounmap(t->base);
-
 err_out_free:
 	kfree(clkevt);
 
