Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A1A27A027
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Sep 2020 11:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgI0J1Y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 27 Sep 2020 05:27:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38120 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgI0J1X (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 27 Sep 2020 05:27:23 -0400
Date:   Sun, 27 Sep 2020 09:27:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601198841;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4Gk3xX4XY8QOdOz8bsUPu2q5lUughdP4sF0z/xX3qU=;
        b=KVNWqptbYuPH7lH4zJzlJACKNvGjhHm6hj2un4lkjkMyTQCmBFb0Y8w5b+jBXvZxRC+cNT
        tvTpAKxvLdJwayo+GkH/nBPZEuoaXUUyW7d1awP/ohkT5pRvMH3qFcrSnsWjF8EKTvtKst
        MCY9qr9XNC21VmLvcrAwGaBYLjjU9QdMPydQEPRqnTOnA3frbAcRQYbo1QgztWDHPDbTaI
        p3ez3oKdHeHQCVCOifbAWx6bQKksAOALEvv+0iuANc4G0IYPifXG8qjsrdOe/dUFscT3dK
        IhRPfHYvCgBU2dEDS2uLWbQZ4ShIHXzJY1R9sUhytz0apyF5TMeBIw/e4vr6HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601198841;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4Gk3xX4XY8QOdOz8bsUPu2q5lUughdP4sF0z/xX3qU=;
        b=78thuUd8Ktfaa9UFhsZHsDOhCgNGgiy2EW9Ya+gE+4dFPt9/s3VDZKe0c3CBw8ww8n5cUf
        bWzFUcGEGntg6kAA==
From:   "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sp804: Prepare for support
 non-standard register offset
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200918132237.3552-6-thunder.leizhen@huawei.com>
References: <20200918132237.3552-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <160119884044.7002.1587977678970164737.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e69aae713bef63b357d4ff85bcb3f8f63dbf4ba3
Gitweb:        https://git.kernel.org/tip/e69aae713bef63b357d4ff85bcb3f8f63dbf4ba3
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Fri, 18 Sep 2020 21:22:33 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 24 Sep 2020 10:51:04 +02:00

clocksource/drivers/sp804: Prepare for support non-standard register offset

Add two local variables: timer1_base and timer2_base in sp804_of_init(),
to avoid repeatedly calculate the base address of timer2, and make it
easier to recognize timer1. Hope to make the next patch looks more clear.

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200918132237.3552-6-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp804.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index a443f39..471c5c6 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -188,6 +188,8 @@ static int __init sp804_of_init(struct device_node *np)
 {
 	static bool initialized = false;
 	void __iomem *base;
+	void __iomem *timer1_base;
+	void __iomem *timer2_base;
 	int irq, ret = -EINVAL;
 	u32 irq_num = 0;
 	struct clk *clk1, *clk2;
@@ -197,9 +199,12 @@ static int __init sp804_of_init(struct device_node *np)
 	if (!base)
 		return -ENXIO;
 
+	timer1_base = base;
+	timer2_base = base + TIMER_2_BASE;
+
 	/* Ensure timers are disabled */
-	writel(0, base + TIMER_CTRL);
-	writel(0, base + TIMER_2_BASE + TIMER_CTRL);
+	writel(0, timer1_base + TIMER_CTRL);
+	writel(0, timer2_base + TIMER_CTRL);
 
 	if (initialized || !of_device_is_available(np)) {
 		ret = -EINVAL;
@@ -228,21 +233,21 @@ static int __init sp804_of_init(struct device_node *np)
 	of_property_read_u32(np, "arm,sp804-has-irq", &irq_num);
 	if (irq_num == 2) {
 
-		ret = sp804_clockevents_init(base + TIMER_2_BASE, irq, clk2, name);
+		ret = sp804_clockevents_init(timer2_base, irq, clk2, name);
 		if (ret)
 			goto err;
 
-		ret = sp804_clocksource_and_sched_clock_init(base,
+		ret = sp804_clocksource_and_sched_clock_init(timer1_base,
 							     name, clk1, 1);
 		if (ret)
 			goto err;
 	} else {
 
-		ret = sp804_clockevents_init(base, irq, clk1, name);
+		ret = sp804_clockevents_init(timer1_base, irq, clk1, name);
 		if (ret)
 			goto err;
 
-		ret = sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE,
+		ret = sp804_clocksource_and_sched_clock_init(timer2_base,
 							     name, clk2, 1);
 		if (ret)
 			goto err;
