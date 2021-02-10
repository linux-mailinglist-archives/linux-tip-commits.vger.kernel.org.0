Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8586316344
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 11:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhBJKJa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 05:09:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhBJKHL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 05:07:11 -0500
Date:   Wed, 10 Feb 2021 10:06:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612951586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7TkFhQ5IYPk+6URTSfV+g3WPXoKsRpPTYUwIKL9Cc2I=;
        b=BSlNFF3bb1a68F1PUG04gjuc8DWJUCz5thSklKXVjj0kGMTxVi3RUBJjWZUx5A+3nRv6MO
        76KBIwlmp8bdBFN412JdOlDRys9yN/niLHM8ArL5wQpTt94fHWWo4G2ZR01ZYf4tUj0MD/
        zIubDKcnTiHr8aGLLyDMsXqWVX2INV6pALYzwK41vkXAwf5o27cz1S5uv+0a35VaIyMZM2
        WkbCeiHsxecn9R/KSKCTeyqdFORQ/KbbfYjmKz5x2hqLuqnO+KDm8FMyE38Gis3nVFUwum
        DRI0I9C/rB7aYQstDF6h9VO5A6pDGu6wdcR9NJ7GYkOgEtCDQXRnswZtGHJU1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612951586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7TkFhQ5IYPk+6URTSfV+g3WPXoKsRpPTYUwIKL9Cc2I=;
        b=lC0vvsJgtJ7MV85wFNKMUtqVM2Zsg8SkV6VsFxEhtYOjM9++R8pDH4OjPf2czUKqq/N5hX
        EN0dFHBi0G518DBg==
From:   "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-microchip-pit64b: Add
 clocksource suspend/resume
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1611061165-30180-1-git-send-email-claudiu.beznea@microchip.com>
References: <1611061165-30180-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Message-ID: <161295158385.23325.8599916370245957656.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e85c1d21b16b278f50d191155bc674633270e9c6
Gitweb:        https://git.kernel.org/tip/e85c1d21b16b278f50d191155bc674633270e9c6
Author:        Claudiu Beznea <claudiu.beznea@microchip.com>
AuthorDate:    Tue, 19 Jan 2021 14:59:25 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 03 Feb 2021 09:36:50 +01:00

clocksource/drivers/timer-microchip-pit64b: Add clocksource suspend/resume

Add suspend/resume support for clocksource timer.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1611061165-30180-1-git-send-email-claudiu.beznea@microchip.com
---
 drivers/clocksource/timer-microchip-pit64b.c | 86 +++++++++++++++----
 1 file changed, 71 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index 59e11ca..ab623b2 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -71,10 +71,24 @@ struct mchp_pit64b_clkevt {
 	struct clock_event_device	clkevt;
 };
 
-#define to_mchp_pit64b_timer(x) \
+#define clkevt_to_mchp_pit64b_timer(x) \
 	((struct mchp_pit64b_timer *)container_of(x,\
 		struct mchp_pit64b_clkevt, clkevt))
 
+/**
+ * mchp_pit64b_clksrc - PIT64B clocksource data structure
+ * @timer: PIT64B timer
+ * @clksrc: clocksource
+ */
+struct mchp_pit64b_clksrc {
+	struct mchp_pit64b_timer	timer;
+	struct clocksource		clksrc;
+};
+
+#define clksrc_to_mchp_pit64b_timer(x) \
+	((struct mchp_pit64b_timer *)container_of(x,\
+		struct mchp_pit64b_clksrc, clksrc))
+
 /* Base address for clocksource timer. */
 static void __iomem *mchp_pit64b_cs_base;
 /* Default cycles for clockevent timer. */
@@ -116,6 +130,36 @@ static inline void mchp_pit64b_reset(struct mchp_pit64b_timer *timer,
 	writel_relaxed(MCHP_PIT64B_CR_START, timer->base + MCHP_PIT64B_CR);
 }
 
+static void mchp_pit64b_suspend(struct mchp_pit64b_timer *timer)
+{
+	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
+	if (timer->mode & MCHP_PIT64B_MR_SGCLK)
+		clk_disable_unprepare(timer->gclk);
+	clk_disable_unprepare(timer->pclk);
+}
+
+static void mchp_pit64b_resume(struct mchp_pit64b_timer *timer)
+{
+	clk_prepare_enable(timer->pclk);
+	if (timer->mode & MCHP_PIT64B_MR_SGCLK)
+		clk_prepare_enable(timer->gclk);
+}
+
+static void mchp_pit64b_clksrc_suspend(struct clocksource *cs)
+{
+	struct mchp_pit64b_timer *timer = clksrc_to_mchp_pit64b_timer(cs);
+
+	mchp_pit64b_suspend(timer);
+}
+
+static void mchp_pit64b_clksrc_resume(struct clocksource *cs)
+{
+	struct mchp_pit64b_timer *timer = clksrc_to_mchp_pit64b_timer(cs);
+
+	mchp_pit64b_resume(timer);
+	mchp_pit64b_reset(timer, ULLONG_MAX, MCHP_PIT64B_MR_CONT, 0);
+}
+
 static u64 mchp_pit64b_clksrc_read(struct clocksource *cs)
 {
 	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
@@ -128,7 +172,7 @@ static u64 mchp_pit64b_sched_read_clk(void)
 
 static int mchp_pit64b_clkevt_shutdown(struct clock_event_device *cedev)
 {
-	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
 	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
 
@@ -137,7 +181,7 @@ static int mchp_pit64b_clkevt_shutdown(struct clock_event_device *cedev)
 
 static int mchp_pit64b_clkevt_set_periodic(struct clock_event_device *cedev)
 {
-	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
 	mchp_pit64b_reset(timer, mchp_pit64b_ce_cycles, MCHP_PIT64B_MR_CONT,
 			  MCHP_PIT64B_IER_PERIOD);
@@ -148,7 +192,7 @@ static int mchp_pit64b_clkevt_set_periodic(struct clock_event_device *cedev)
 static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
 					     struct clock_event_device *cedev)
 {
-	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
 	mchp_pit64b_reset(timer, evt, MCHP_PIT64B_MR_ONE_SHOT,
 			  MCHP_PIT64B_IER_PERIOD);
@@ -158,21 +202,16 @@ static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
 
 static void mchp_pit64b_clkevt_suspend(struct clock_event_device *cedev)
 {
-	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
-	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
-	if (timer->mode & MCHP_PIT64B_MR_SGCLK)
-		clk_disable_unprepare(timer->gclk);
-	clk_disable_unprepare(timer->pclk);
+	mchp_pit64b_suspend(timer);
 }
 
 static void mchp_pit64b_clkevt_resume(struct clock_event_device *cedev)
 {
-	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
-	clk_prepare_enable(timer->pclk);
-	if (timer->mode & MCHP_PIT64B_MR_SGCLK)
-		clk_prepare_enable(timer->gclk);
+	mchp_pit64b_resume(timer);
 }
 
 static irqreturn_t mchp_pit64b_interrupt(int irq, void *dev_id)
@@ -296,20 +335,37 @@ done:
 static int __init mchp_pit64b_init_clksrc(struct mchp_pit64b_timer *timer,
 					  u32 clk_rate)
 {
+	struct mchp_pit64b_clksrc *cs;
 	int ret;
 
+	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
+	if (!cs)
+		return -ENOMEM;
+
 	mchp_pit64b_reset(timer, ULLONG_MAX, MCHP_PIT64B_MR_CONT, 0);
 
 	mchp_pit64b_cs_base = timer->base;
 
-	ret = clocksource_mmio_init(timer->base, MCHP_PIT64B_NAME, clk_rate,
-				    210, 64, mchp_pit64b_clksrc_read);
+	cs->timer.base = timer->base;
+	cs->timer.pclk = timer->pclk;
+	cs->timer.gclk = timer->gclk;
+	cs->timer.mode = timer->mode;
+	cs->clksrc.name = MCHP_PIT64B_NAME;
+	cs->clksrc.mask = CLOCKSOURCE_MASK(64);
+	cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+	cs->clksrc.rating = 210;
+	cs->clksrc.read = mchp_pit64b_clksrc_read;
+	cs->clksrc.suspend = mchp_pit64b_clksrc_suspend;
+	cs->clksrc.resume = mchp_pit64b_clksrc_resume;
+
+	ret = clocksource_register_hz(&cs->clksrc, clk_rate);
 	if (ret) {
 		pr_debug("clksrc: Failed to register PIT64B clocksource!\n");
 
 		/* Stop timer. */
 		writel_relaxed(MCHP_PIT64B_CR_SWRST,
 			       timer->base + MCHP_PIT64B_CR);
+		kfree(cs);
 
 		return ret;
 	}
