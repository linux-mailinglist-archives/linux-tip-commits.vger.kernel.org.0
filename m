Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390A227A02E
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Sep 2020 11:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgI0J1h (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 27 Sep 2020 05:27:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38152 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgI0J1Z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 27 Sep 2020 05:27:25 -0400
Date:   Sun, 27 Sep 2020 09:27:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601198843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wKR+mytJ+59GArKWsdLJziybCOsL4PfBl+o+11Jqdco=;
        b=HEZwHeJQid8klg9UHlyaK3Gh1tZRTeZRLdC3b+WqCh3sC3XFg4qVdsq4nyEYOMso8VzRq4
        J4DbSnO6OR8ZCU3nKP5oSElVvjsF4cznuHo2gXbWqRlTOrrckt0jAhaToerQGxAVIyl/UN
        pEGU1RM2yZ+2NZj9QEo0KeO39sU6rKxpy+JwK1JAxYip5PL+eU+hDt374gTWTDxR0Rjz98
        MnCAK6DHNT0xX7JjE1dEvLybbHIW9HHAaVo4wXuxe3cAgyvJp0cyCgpHZ9SzkuG5jz9Rxg
        vjACG8Kgt7cTG5rGH3cVqFsyoTqd1HchJcLUyT/70BR2XF1HY7JA8Fitxdw86g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601198843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wKR+mytJ+59GArKWsdLJziybCOsL4PfBl+o+11Jqdco=;
        b=PUOAdPzH7iCZxBj6SZTKJZ7ko0HITTB6QJUcd7FoXw2BE4EBbeQCbpPFmn9Tq5jAJqrOn6
        o8nqM698r5edoHBA==
From:   "tip-bot2 for Kefeng Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sp804: Cleanup clk_get_sys()
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200918132237.3552-2-thunder.leizhen@huawei.com>
References: <20200918132237.3552-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <160119884246.7002.9537010852462748057.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7d19d521a034a8c58586814e0320463d1299a3a9
Gitweb:        https://git.kernel.org/tip/7d19d521a034a8c58586814e0320463d1299a3a9
Author:        Kefeng Wang <wangkefeng.wang@huawei.com>
AuthorDate:    Fri, 18 Sep 2020 21:22:29 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 24 Sep 2020 10:51:04 +02:00

clocksource/drivers/sp804: Cleanup clk_get_sys()

Move the clk_get_sys() part into sp804_get_clock_rate(), cleanup the same
code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200918132237.3552-2-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp804.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 5cd0abf..bec2d37 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -22,11 +22,18 @@
 
 #include "timer-sp.h"
 
-static long __init sp804_get_clock_rate(struct clk *clk)
+static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 {
 	long rate;
 	int err;
 
+	if (!clk)
+		clk = clk_get_sys("sp804", name);
+	if (IS_ERR(clk)) {
+		pr_err("sp804: %s clock not found: %ld\n", name, PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
 	err = clk_prepare(clk);
 	if (err) {
 		pr_err("sp804: clock failed to prepare: %d\n", err);
@@ -72,16 +79,7 @@ int  __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
 {
 	long rate;
 
-	if (!clk) {
-		clk = clk_get_sys("sp804", name);
-		if (IS_ERR(clk)) {
-			pr_err("sp804: clock not found: %d\n",
-			       (int)PTR_ERR(clk));
-			return PTR_ERR(clk);
-		}
-	}
-
-	rate = sp804_get_clock_rate(clk);
+	rate = sp804_get_clock_rate(clk, name);
 	if (rate < 0)
 		return -EINVAL;
 
@@ -173,15 +171,7 @@ int __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struct
 	struct clock_event_device *evt = &sp804_clockevent;
 	long rate;
 
-	if (!clk)
-		clk = clk_get_sys("sp804", name);
-	if (IS_ERR(clk)) {
-		pr_err("sp804: %s clock not found: %d\n", name,
-			(int)PTR_ERR(clk));
-		return PTR_ERR(clk);
-	}
-
-	rate = sp804_get_clock_rate(clk);
+	rate = sp804_get_clock_rate(clk, name);
 	if (rate < 0)
 		return -EINVAL;
 
