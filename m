Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6072F27A038
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Sep 2020 11:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgI0J1u (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 27 Sep 2020 05:27:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38194 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgI0J11 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 27 Sep 2020 05:27:27 -0400
Date:   Sun, 27 Sep 2020 09:27:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601198845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pTKWU/7l4o+IgAzjM3xg89gJGgMIIMbQ0bnBcVw6FWc=;
        b=WikYgK7o5ghv2LN5R2Dl9ExQvpoDbcH6P5omYCS4ncfCPOsDqpDlw8xfQH8PM16gxSKJao
        e7Q6zmmBKgXcHlKLPlz69pt+QxaCd+X/sCQi4mi9gmHMTygtBMLJN5Gk+rX6CSmwpf5d11
        DrrZGcxjgFw2VONzzG6X4ryTlFquZu2jcqlwUO16WnjxmKfAbMu4bZEXGOCVPqB9D3cPOO
        v0ZXsM2n1qI6qu46+BYDu+X2eu8x8qvSSr8gXectUyPqoyXb12/UsWsA0SsvYuol3eA9NA
        +LnF9vwh9W5iALbxrdIIkjrncSA1yKtIx5HYgkIwgWQAnUeTxaT7watfxjlZaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601198845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pTKWU/7l4o+IgAzjM3xg89gJGgMIIMbQ0bnBcVw6FWc=;
        b=NboKaqCSp44gXo85GyuIXqRlNQsO3km/lXA2TYYZqbZczRX1SayFgP4sV2oVZtxgZnkoPN
        +HoWBFGGKeT1tYAg==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource/drivers/timer-ti-dm: Do reset before enable
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817092428.6176-1-tony@atomide.com>
References: <20200817092428.6176-1-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <160119884498.7002.2614579485726728914.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     164805157f3c6834670afbaff563353c773131f1
Gitweb:        https://git.kernel.org/tip/164805157f3c6834670afbaff563353c773131f1
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Mon, 17 Aug 2020 12:24:28 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 24 Aug 2020 13:01:39 +02:00

clocksource/drivers/timer-ti-dm: Do reset before enable

Commit 6cfcd5563b4f ("clocksource/drivers/timer-ti-dm: Fix suspend and
resume for am3 and am4") exposed a new issue for type2 dual mode timers
on at least omap5 where the clockevent will stop when the SoC starts
entering idle states during the boot.

Turns out we are wrongly first enabling the system timer and then
resetting it, while we must also re-enable it after reset. The current
sequence leaves the timer module in a partially initialized state. This
issue went unnoticed earlier with ti-sysc driver reconfiguring the timer
module until we fixed the issue of ti-sysc reconfiguring system timers.

Let's fix the issue by calling dmtimer_systimer_enable() from reset for
both type1 and type2 timers, and switch the order of reset and enable in
dmtimer_systimer_setup(). Let's also move dmtimer_systimer_enable() and
dmtimer_systimer_disable() to do this without adding forward declarations.

Fixes: 6cfcd5563b4f ("clocksource/drivers/timer-ti-dm: Fix suspend and resume for am3 and am4")
Reported-by: H. Nikolaus Schaller" <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200817092428.6176-1-tony@atomide.com
---
 drivers/clocksource/timer-ti-dm-systimer.c | 44 ++++++++++-----------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index f6fd1c1..33b3e8a 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -69,12 +69,33 @@ static bool dmtimer_systimer_revision1(struct dmtimer_systimer *t)
 	return !(tidr >> 16);
 }
 
+static void dmtimer_systimer_enable(struct dmtimer_systimer *t)
+{
+	u32 val;
+
+	if (dmtimer_systimer_revision1(t))
+		val = DMTIMER_TYPE1_ENABLE;
+	else
+		val = DMTIMER_TYPE2_ENABLE;
+
+	writel_relaxed(val, t->base + t->sysc);
+}
+
+static void dmtimer_systimer_disable(struct dmtimer_systimer *t)
+{
+	if (!dmtimer_systimer_revision1(t))
+		return;
+
+	writel_relaxed(DMTIMER_TYPE1_DISABLE, t->base + t->sysc);
+}
+
 static int __init dmtimer_systimer_type1_reset(struct dmtimer_systimer *t)
 {
 	void __iomem *syss = t->base + OMAP_TIMER_V1_SYS_STAT_OFFSET;
 	int ret;
 	u32 l;
 
+	dmtimer_systimer_enable(t);
 	writel_relaxed(BIT(1) | BIT(2), t->base + t->ifctrl);
 	ret = readl_poll_timeout_atomic(syss, l, l & BIT(0), 100,
 					DMTIMER_RESET_WAIT);
@@ -88,6 +109,7 @@ static int __init dmtimer_systimer_type2_reset(struct dmtimer_systimer *t)
 	void __iomem *sysc = t->base + t->sysc;
 	u32 l;
 
+	dmtimer_systimer_enable(t);
 	l = readl_relaxed(sysc);
 	l |= BIT(0);
 	writel_relaxed(l, sysc);
@@ -336,26 +358,6 @@ static int __init dmtimer_systimer_init_clock(struct dmtimer_systimer *t,
 	return 0;
 }
 
-static void dmtimer_systimer_enable(struct dmtimer_systimer *t)
-{
-	u32 val;
-
-	if (dmtimer_systimer_revision1(t))
-		val = DMTIMER_TYPE1_ENABLE;
-	else
-		val = DMTIMER_TYPE2_ENABLE;
-
-	writel_relaxed(val, t->base + t->sysc);
-}
-
-static void dmtimer_systimer_disable(struct dmtimer_systimer *t)
-{
-	if (!dmtimer_systimer_revision1(t))
-		return;
-
-	writel_relaxed(DMTIMER_TYPE1_DISABLE, t->base + t->sysc);
-}
-
 static int __init dmtimer_systimer_setup(struct device_node *np,
 					 struct dmtimer_systimer *t)
 {
@@ -409,8 +411,8 @@ static int __init dmtimer_systimer_setup(struct device_node *np,
 	t->wakeup = regbase + _OMAP_TIMER_WAKEUP_EN_OFFSET;
 	t->ifctrl = regbase + _OMAP_TIMER_IF_CTRL_OFFSET;
 
-	dmtimer_systimer_enable(t);
 	dmtimer_systimer_reset(t);
+	dmtimer_systimer_enable(t);
 	pr_debug("dmtimer rev %08x sysc %08x\n", readl_relaxed(t->base),
 		 readl_relaxed(t->base + t->sysc));
 
