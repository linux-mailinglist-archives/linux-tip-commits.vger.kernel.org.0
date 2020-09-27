Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEEF27A023
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Sep 2020 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgI0J1W (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 27 Sep 2020 05:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgI0J1W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 27 Sep 2020 05:27:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00878C0613CE;
        Sun, 27 Sep 2020 02:27:21 -0700 (PDT)
Date:   Sun, 27 Sep 2020 09:27:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601198840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NoREJBYtTaK5urcLHtLaaMlVb1ZBxZeQJ8zng4TTpoQ=;
        b=l3yCRfN3atBquAQLqec6MbzsaKzr5huhcFsSPkHepDWhL7BJqag2lIALMsD3p9+u8LqXxR
        cIl+P6bLd5ayirzU+UXeODIBI4lTs+PGXW87fjyQdOcLdSLHNCgqf5713I6a+5pFJf9uLG
        89AddX8xSOMOSq7bQJs25fnfCC4URdc0GRAgaONjcw8GoF0cde67BfNjYPCAUR+6VXj2A+
        gXvpH0NxfMoAEUO/mWTVVMPhhWtCy5LnLlZecH5HvGwuaGXhJOvnfqUUIUtFo1QT4wAzmR
        0TrMX/672kym5YCJ2tHwu0xDU6O9ERQmYyICkUEklLllv090TxIJTKd80IkFQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601198840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NoREJBYtTaK5urcLHtLaaMlVb1ZBxZeQJ8zng4TTpoQ=;
        b=Y+jQAMt6chifq8Vk06sVYmXFe10YlekxxT000lKjAYJUnqtwsRwLhsufPXoluByO4aEVao
        yZi5nY/Bdtnjk8Aw==
From:   "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sp804: Enable Hisilicon sp804
 timer 64bit mode
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200918132237.3552-9-thunder.leizhen@huawei.com>
References: <20200918132237.3552-9-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <160119883909.7002.9109042796819288420.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     549437a43f45ce70cf5012317633c635c43ba4f4
Gitweb:        https://git.kernel.org/tip/549437a43f45ce70cf5012317633c635c43ba4f4
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Fri, 18 Sep 2020 21:22:36 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 24 Sep 2020 10:51:04 +02:00

clocksource/drivers/sp804: Enable Hisilicon sp804 timer 64bit mode

A 100MHZ 32-bit timer will be wrapped up less than 43s. Although the
kernel maintains a software high 32-bit count in the tick IRQ. But it's
not applicable to the user mode APPs.

Note: The kernel still uses the lower 32 bits of the timer.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200918132237.3552-9-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp.h    |  6 ++++++
 drivers/clocksource/timer-sp804.c | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/clocksource/timer-sp.h b/drivers/clocksource/timer-sp.h
index 1ab75cb..811f840 100644
--- a/drivers/clocksource/timer-sp.h
+++ b/drivers/clocksource/timer-sp.h
@@ -33,12 +33,15 @@
 
 struct sp804_timer {
 	int load;
+	int load_h;
 	int value;
+	int value_h;
 	int ctrl;
 	int intclr;
 	int ris;
 	int mis;
 	int bgload;
+	int bgload_h;
 	int timer_base[NR_TIMERS];
 	int width;
 };
@@ -46,12 +49,15 @@ struct sp804_timer {
 struct sp804_clkevt {
 	void __iomem *base;
 	void __iomem *load;
+	void __iomem *load_h;
 	void __iomem *value;
+	void __iomem *value_h;
 	void __iomem *ctrl;
 	void __iomem *intclr;
 	void __iomem *ris;
 	void __iomem *mis;
 	void __iomem *bgload;
+	void __iomem *bgload_h;
 	unsigned long reload;
 	int width;
 };
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index f0783d1..6e8ad4a 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -24,12 +24,15 @@
 #define HISI_TIMER_1_BASE	0x00
 #define HISI_TIMER_2_BASE	0x40
 #define HISI_TIMER_LOAD		0x00
+#define HISI_TIMER_LOAD_H	0x04
 #define HISI_TIMER_VALUE	0x08
+#define HISI_TIMER_VALUE_H	0x0c
 #define HISI_TIMER_CTRL		0x10
 #define HISI_TIMER_INTCLR	0x14
 #define HISI_TIMER_RIS		0x18
 #define HISI_TIMER_MIS		0x1c
 #define HISI_TIMER_BGLOAD	0x20
+#define HISI_TIMER_BGLOAD_H	0x24
 
 
 struct sp804_timer __initdata arm_sp804_timer = {
@@ -43,7 +46,9 @@ struct sp804_timer __initdata arm_sp804_timer = {
 
 struct sp804_timer __initdata hisi_sp804_timer = {
 	.load		= HISI_TIMER_LOAD,
+	.load_h		= HISI_TIMER_LOAD_H,
 	.value		= HISI_TIMER_VALUE,
+	.value_h	= HISI_TIMER_VALUE_H,
 	.ctrl		= HISI_TIMER_CTRL,
 	.intclr		= HISI_TIMER_INTCLR,
 	.timer_base	= {HISI_TIMER_1_BASE, HISI_TIMER_2_BASE},
@@ -129,6 +134,10 @@ int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
 	writel(0, clkevt->ctrl);
 	writel(0xffffffff, clkevt->load);
 	writel(0xffffffff, clkevt->value);
+	if (clkevt->width == 64) {
+		writel(0xffffffff, clkevt->load_h);
+		writel(0xffffffff, clkevt->value_h);
+	}
 	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
 		clkevt->ctrl);
 
@@ -245,7 +254,9 @@ static void __init sp804_clkevt_init(struct sp804_timer *timer, void __iomem *ba
 		clkevt = &sp804_clkevt[i];
 		clkevt->base	= timer_base;
 		clkevt->load	= timer_base + timer->load;
+		clkevt->load_h	= timer_base + timer->load_h;
 		clkevt->value	= timer_base + timer->value;
+		clkevt->value_h	= timer_base + timer->value_h;
 		clkevt->ctrl	= timer_base + timer->ctrl;
 		clkevt->intclr	= timer_base + timer->intclr;
 		clkevt->width	= timer->width;
