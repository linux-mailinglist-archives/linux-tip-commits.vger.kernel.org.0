Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCC2359C03
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 12:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhDIK1w (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 06:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbhDIK1o (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 06:27:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E17FC061764;
        Fri,  9 Apr 2021 03:27:31 -0700 (PDT)
Date:   Fri, 09 Apr 2021 10:27:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617964048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZrzyngjpZItAgmE1XRwY7Rfm6k70fu/lM9YEiyvbyE=;
        b=vVJ0UyAlxpjfPO+HNh19HTBbbZQVYg6CSfl4klOhwS3vBVO3lX1j7a+D5VlJd1Ardx0gtf
        /lrCeEG7mAwywZeDZndPIStfeWfwJogJtRGtuIMemPJbwjD2Wz+c0cupkn5MpwucNKidso
        I8UjGt92Io0O4O5kSHZSYoCTFZUM5sOqjbk9dMaqve0UwF0g8m6jlKwy+FVRGHwdkYgwws
        t7BxM/1X/X4uwrknC3jrhCovByVcvwekFyrR5QiXqXufNrS4bZiEeZvuzg5eQUpcc9oqLZ
        BBvriWZ7PaHYU6/qLL8lUSJHMr3nmQs2j66BeJCTuO3H93ky2AOWmkNSYtI7NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617964048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZrzyngjpZItAgmE1XRwY7Rfm6k70fu/lM9YEiyvbyE=;
        b=Rhyf6wklV+GvwwUJJNRpCDZjwIL3VZtea2AZ9n+yBal7A7OgFj3NjAr00nc19jpdCXrRe+
        iCQgBvduW/Y7ouAA==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Fix posted mode
 status check order
Cc:     Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304072135.52712-2-tony@atomide.com>
References: <20210304072135.52712-2-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <161796404824.29796.16232327566063779144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     212709926c5493a566ca4086ad4f4b0d4e66b553
Gitweb:        https://git.kernel.org/tip/212709926c5493a566ca4086ad4f4b0d4e66b553
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Thu, 04 Mar 2021 09:21:33 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 08 Apr 2021 13:23:41 +02:00

clocksource/drivers/timer-ti-dm: Fix posted mode status check order

When the timer is configured in posted mode, we need to check the write-
posted status register (TWPS) before writing to the register.

We now check TWPS after the write starting with commit 52762fbd1c47
("clocksource/drivers/timer-ti-dm: Add clockevent and clocksource
support").

For example, in the TRM for am571x the following is documented in chapter
"22.2.4.13.1.1 Write Posting Synchronization Mode":

"For each register, a status bit is provided in the timer write-posted
 status (TWPS) register. In this mode, it is mandatory that software check
 this status bit before any write access. If a write is attempted to a
 register with a previous access pending, the previous access is discarded
 without notice."

The regression happened when I updated the code to use standard read/write
accessors for the driver instead of using __omap_dm_timer_load_start().
We have__omap_dm_timer_load_start() check the TWPS status correctly using
__omap_dm_timer_write().

Fixes: 52762fbd1c47 ("clocksource/drivers/timer-ti-dm: Add clockevent and clocksource support")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210304072135.52712-2-tony@atomide.com
---
 drivers/clocksource/timer-ti-dm-systimer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index 614c838..3a65434 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -449,13 +449,13 @@ static int dmtimer_set_next_event(unsigned long cycles,
 	struct dmtimer_systimer *t = &clkevt->t;
 	void __iomem *pend = t->base + t->pend;
 
-	writel_relaxed(0xffffffff - cycles, t->base + t->counter);
 	while (readl_relaxed(pend) & WP_TCRR)
 		cpu_relax();
+	writel_relaxed(0xffffffff - cycles, t->base + t->counter);
 
-	writel_relaxed(OMAP_TIMER_CTRL_ST, t->base + t->ctrl);
 	while (readl_relaxed(pend) & WP_TCLR)
 		cpu_relax();
+	writel_relaxed(OMAP_TIMER_CTRL_ST, t->base + t->ctrl);
 
 	return 0;
 }
@@ -490,18 +490,18 @@ static int dmtimer_set_periodic(struct clock_event_device *evt)
 	dmtimer_clockevent_shutdown(evt);
 
 	/* Looks like we need to first set the load value separately */
-	writel_relaxed(clkevt->period, t->base + t->load);
 	while (readl_relaxed(pend) & WP_TLDR)
 		cpu_relax();
+	writel_relaxed(clkevt->period, t->base + t->load);
 
-	writel_relaxed(clkevt->period, t->base + t->counter);
 	while (readl_relaxed(pend) & WP_TCRR)
 		cpu_relax();
+	writel_relaxed(clkevt->period, t->base + t->counter);
 
-	writel_relaxed(OMAP_TIMER_CTRL_AR | OMAP_TIMER_CTRL_ST,
-		       t->base + t->ctrl);
 	while (readl_relaxed(pend) & WP_TCLR)
 		cpu_relax();
+	writel_relaxed(OMAP_TIMER_CTRL_AR | OMAP_TIMER_CTRL_ST,
+		       t->base + t->ctrl);
 
 	return 0;
 }
