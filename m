Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B393F8C14
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 18:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242493AbhHZQ0G (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 12:26:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33144 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhHZQ0F (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 12:26:05 -0400
Date:   Thu, 26 Aug 2021 16:25:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629995117;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQJwXpy38+p8jG5t3zdAlFyhKkTeEHih9M2fULaGVBg=;
        b=aiAxBxCI/Pl2JjbbzlT7sSD2rDxDukWXWXi9ED2mrlGvp7YAF+oJ1LByB9wTy2RoFUOpD1
        9yCSdA9xx19gFxF9jFzNL0Paln0f0sRXsqw7X4fmN7Gd7f/DYx4QwDZQ5khQqoCfC06cKT
        iQZUNyuIGGwYZbrEXhXiNzQC/vinotsYtNJ59+rDPcN1yIp7yZj49Xu+LSRrvbUzeGGJ0S
        rqVPVpifsHIVHfWScxcYTOPoLT39IBi+W5LzWA1uuf7NIV3YNh4wW49he1LmImsmdz+9iS
        da89r8BFGqBCXS2Mn0wmy+YQT8oxkwGnLia3Jn3EJv4p4XaXNS5279dDpSN+Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629995117;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQJwXpy38+p8jG5t3zdAlFyhKkTeEHih9M2fULaGVBg=;
        b=Lp0r/vCe+c50omLHpwQrzfTW+Y4kBXow+bGHf8FrJ8JfDexAzWs3HfdusqJt75oY9ttO3U
        3ulum0B/4zzBbVCA==
From:   "tip-bot2 for Fengquan Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/mediatek: Optimize systimer
 irq clear flow on shutdown
Cc:     Fengquan Chen <fengquan.chen@mediatek.com>,
        "Hsin-Yi Wang" <hsinyi@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1617960162-1988-2-git-send-email-Fengquan.Chen@mediatek.com>
References: <1617960162-1988-2-git-send-email-Fengquan.Chen@mediatek.com>
MIME-Version: 1.0
Message-ID: <162999511619.25758.16241295232360944154.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ce9570657d45d6387a68d7f419fe70d085200a2f
Gitweb:        https://git.kernel.org/tip/ce9570657d45d6387a68d7f419fe70d085200a2f
Author:        Fengquan Chen <Fengquan.Chen@mediatek.com>
AuthorDate:    Fri, 09 Apr 2021 17:22:42 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 14 Aug 2021 02:44:35 +02:00

clocksource/drivers/mediatek: Optimize systimer irq clear flow on shutdown

mtk_syst_clkevt_shutdown is called after irq disabled in suspend flow,
clear any pending systimer irq when shutdown to avoid suspend aborted
due to timer irq pending

Also as for systimer in mediatek socs, there must be firstly enable
timer before clear systimer irq

Fixes: e3af677607d9("clocksource/drivers/timer-mediatek: Add support for system timer")
Signed-off-by: Fengquan Chen <fengquan.chen@mediatek.com>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1617960162-1988-2-git-send-email-Fengquan.Chen@mediatek.com
---
 drivers/clocksource/timer-mediatek.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index ab63b95..7bcb4a3 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -60,9 +60,9 @@
  * SYST_CON_EN: Clock enable. Shall be set to
  *   - Start timer countdown.
  *   - Allow timeout ticks being updated.
- *   - Allow changing interrupt functions.
+ *   - Allow changing interrupt status,like clear irq pending.
  *
- * SYST_CON_IRQ_EN: Set to allow interrupt.
+ * SYST_CON_IRQ_EN: Set to enable interrupt.
  *
  * SYST_CON_IRQ_CLR: Set to clear interrupt.
  */
@@ -75,6 +75,7 @@ static void __iomem *gpt_sched_reg __read_mostly;
 static void mtk_syst_ack_irq(struct timer_of *to)
 {
 	/* Clear and disable interrupt */
+	writel(SYST_CON_EN, SYST_CON_REG(to));
 	writel(SYST_CON_IRQ_CLR | SYST_CON_EN, SYST_CON_REG(to));
 }
 
@@ -111,6 +112,9 @@ static int mtk_syst_clkevt_next_event(unsigned long ticks,
 
 static int mtk_syst_clkevt_shutdown(struct clock_event_device *clkevt)
 {
+	/* Clear any irq */
+	mtk_syst_ack_irq(to_timer_of(clkevt));
+
 	/* Disable timer */
 	writel(0, SYST_CON_REG(to_timer_of(clkevt)));
 
