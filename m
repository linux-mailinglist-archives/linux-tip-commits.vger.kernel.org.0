Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC453F8C12
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 18:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243074AbhHZQ0F (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 12:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243032AbhHZQ0F (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 12:26:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9529AC0613CF;
        Thu, 26 Aug 2021 09:25:17 -0700 (PDT)
Date:   Thu, 26 Aug 2021 16:25:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629995116;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WKwmqfxkGmBHV9m7Ovnorigf0kE/ltP+lC+IxUIwycs=;
        b=lI73Er5J7wzYf+z0ju5QkgLPoyk6r/gSycBHU4NHNJO+sE5QKb3YKnqpcBV5hUh7uDTqG3
        q/aeMK/KZfQIG9EPIgmPdq71H4GP/OspiaGtS1/q6b5tpsi5u6gxn5OcADB35pAa+RPV4H
        vx1/jsIX00aguNjuwKkMeJ7HDNaOPDvcyNQJFbaW9Y2TOvTS59/LUmxg27V6CMxkHyZdPL
        tWTfI3SjtnyigL+we05B1Rxph3bAMSXJBqPopsUnYd/Xt6ThQB89qBezQ8MA3OKfwFDpkm
        +9HP8euUvZ19onbhbk1k9CZuCeRSuZfXRr4em+jb/SJqKLIy1LAuDDPPJBHjKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629995116;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WKwmqfxkGmBHV9m7Ovnorigf0kE/ltP+lC+IxUIwycs=;
        b=aufmkwom8fSywppzV8kGLu96Gw/S6g8/UCNHHONRjEF29xMNcU485QzEE/JnchXUJjgEjU
        TIHYsydP39ZP8cAA==
From:   "tip-bot2 for Linus Walleij" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/fttmr010: Pass around less pointers
Cc:     clg@kaod.org, Joel Stanley <joel@jms.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210724224424.2085404-1-linus.walleij@linaro.org>
References: <20210724224424.2085404-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Message-ID: <162999511541.25758.7227260079640777012.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3a95de59730eb9ac8dd6a367018f5653a873ecaa
Gitweb:        https://git.kernel.org/tip/3a95de59730eb9ac8dd6a367018f5653a87=
3ecaa
Author:        Linus Walleij <linus.walleij@linaro.org>
AuthorDate:    Sun, 25 Jul 2021 00:44:23 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 14 Aug 2021 10:49:49 +02:00

clocksource/drivers/fttmr010: Pass around less pointers

Just pass bool flags from the different initcalls and use the
flags to set the right pointers. This results in less pointers
passed around in init.

Cc: C=C3=A9dric Le Goater <clg@kaod.org>
Cc: Joel Stanley <joel@jms.id.au>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210724224424.2085404-1-linus.walleij@linaro=
.org
---
 drivers/clocksource/timer-fttmr010.c | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer=
-fttmr010.c
index edb1d5f..126fb1f 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -271,9 +271,7 @@ static irqreturn_t ast2600_timer_interrupt(int irq, void =
*dev_id)
 }
=20
 static int __init fttmr010_common_init(struct device_node *np,
-		bool is_aspeed,
-		int (*timer_shutdown)(struct clock_event_device *),
-		irq_handler_t irq_handler)
+				       bool is_aspeed, bool is_ast2600)
 {
 	struct fttmr010 *fttmr010;
 	int irq;
@@ -374,8 +372,6 @@ static int __init fttmr010_common_init(struct device_node=
 *np,
 				     fttmr010->tick_rate);
 	}
=20
-	fttmr010->timer_shutdown =3D timer_shutdown;
-
 	/*
 	 * Setup clockevent timer (interrupt-driven) on timer 1.
 	 */
@@ -383,8 +379,18 @@ static int __init fttmr010_common_init(struct device_nod=
e *np,
 	writel(0, fttmr010->base + TIMER1_LOAD);
 	writel(0, fttmr010->base + TIMER1_MATCH1);
 	writel(0, fttmr010->base + TIMER1_MATCH2);
-	ret =3D request_irq(irq, irq_handler, IRQF_TIMER,
-			  "FTTMR010-TIMER1", &fttmr010->clkevt);
+
+	if (is_ast2600) {
+		fttmr010->timer_shutdown =3D ast2600_timer_shutdown;
+		ret =3D request_irq(irq, ast2600_timer_interrupt,
+				  IRQF_TIMER, "FTTMR010-TIMER1",
+				  &fttmr010->clkevt);
+	} else {
+		fttmr010->timer_shutdown =3D fttmr010_timer_shutdown;
+		ret =3D request_irq(irq, fttmr010_timer_interrupt,
+				  IRQF_TIMER, "FTTMR010-TIMER1",
+				  &fttmr010->clkevt);
+	}
 	if (ret) {
 		pr_err("FTTMR010-TIMER1 no IRQ\n");
 		goto out_unmap;
@@ -432,23 +438,17 @@ out_disable_clock:
=20
 static __init int ast2600_timer_init(struct device_node *np)
 {
-	return fttmr010_common_init(np, true,
-			ast2600_timer_shutdown,
-			ast2600_timer_interrupt);
+	return fttmr010_common_init(np, true, true);
 }
=20
 static __init int aspeed_timer_init(struct device_node *np)
 {
-	return fttmr010_common_init(np, true,
-			fttmr010_timer_shutdown,
-			fttmr010_timer_interrupt);
+	return fttmr010_common_init(np, true, false);
 }
=20
 static __init int fttmr010_timer_init(struct device_node *np)
 {
-	return fttmr010_common_init(np, false,
-			fttmr010_timer_shutdown,
-			fttmr010_timer_interrupt);
+	return fttmr010_common_init(np, false, false);
 }
=20
 TIMER_OF_DECLARE(fttmr010, "faraday,fttmr010", fttmr010_timer_init);
