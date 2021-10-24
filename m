Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AAC438A0C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Oct 2021 17:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhJXPml (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Oct 2021 11:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbhJXPma (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Oct 2021 11:42:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9424DC061745;
        Sun, 24 Oct 2021 08:40:09 -0700 (PDT)
Date:   Sun, 24 Oct 2021 15:40:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635090008;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GcWU5tY5onugM4BFSU8TZW5aCZB4k1NwmlZk/lgLEC4=;
        b=Aof6jVMxcg1Wg0wKGjM97uktDavgunlHusRJAwi/0IWP0iJaTWcB9Mjh6B/3nmbNW8n+Iy
        siUSgaa8tRZssDoZMJ+WOl84pOjd694yZI736+XqxLz3tIwwD2S/+GthusEdNu3273Apku
        oZap1LEF6sni1ZVm7zao9J5EweiErGM0XWZblUY520EIkW0PMNGZcE9OjhimD/Yj7M2jGc
        MZoruiN+fBbV+l10AwwSKD4qlayVsn5NqyDQK4u2qUxE7JTLq1YkBcOeGgsDyhpK3eG1am
        Y4Zvun1Tv/92eN6FqmkusEVtxlhsBhTkKKfhcfEwQ6IV0dbmMACrHV0UqlXsig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635090008;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GcWU5tY5onugM4BFSU8TZW5aCZB4k1NwmlZk/lgLEC4=;
        b=FolArMSN4lXDZkuBeR6hY+NC/WnOy0Ydou7G/2gh1qGWWHDu1T/0CjVUYVJhPVTnpblq/9
        3R1tcoYI6xc6wRBw==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arc_timer: Eliminate redefined
 macro error
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210924020825.20317-1-rdunlap@infradead.org>
References: <20210924020825.20317-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <163509000739.626.4539906906227875754.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     58100c34f7827ddf64309c5a7c8c4e5bd6415b95
Gitweb:        https://git.kernel.org/tip/58100c34f7827ddf64309c5a7c8c4e5bd6415b95
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Thu, 23 Sep 2021 19:08:25 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 16 Oct 2021 22:15:01 +02:00

clocksource/drivers/arc_timer: Eliminate redefined macro error

In drivers/clocksource/, 3 drivers use "TIMER_CTRL_IE" with 3 different
values.  Two of them (mps2-timer.c and timer-sp804.c/timer-sp.h) are
localized and left unmodifed.

One of them uses a shared header file (<soc/arc/timers.h>), which is
what is causing the "redefined" warnings, so change the macro name in
that driver only. Also change the TIMER_CTRL_NH macro name.
Both macro names are prefixed with "ARC_" to reduce the likelihood
of future name collisions.

In file included from ../drivers/clocksource/timer-sp804.c:24:
../drivers/clocksource/timer-sp.h:25: error: "TIMER_CTRL_IE" redefined [-Werror]
   25 | #define TIMER_CTRL_IE           (1 << 5)        /*   VR */
../include/soc/arc/timers.h:20: note: this is the location of the previous definition
   20 | #define TIMER_CTRL_IE           (1 << 0) /* Interrupt when Count reaches limit */

Fixes: b26c2e3823ba ("ARC: breakout timer include code into separate header")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: linux-snps-arc@lists.infradead.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Shahab Vahedi <Shahab.Vahedi@synopsys.com>
Acked-by: Vineet Gupta <vgupta@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210924020825.20317-1-rdunlap@infradead.org
---
 drivers/clocksource/arc_timer.c | 6 +++---
 include/soc/arc/timers.h        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/arc_timer.c b/drivers/clocksource/arc_timer.c
index de93dd1..cb18524 100644
--- a/drivers/clocksource/arc_timer.c
+++ b/drivers/clocksource/arc_timer.c
@@ -225,7 +225,7 @@ static int __init arc_cs_setup_timer1(struct device_node *node)
 
 	write_aux_reg(ARC_REG_TIMER1_LIMIT, ARC_TIMERN_MAX);
 	write_aux_reg(ARC_REG_TIMER1_CNT, 0);
-	write_aux_reg(ARC_REG_TIMER1_CTRL, TIMER_CTRL_NH);
+	write_aux_reg(ARC_REG_TIMER1_CTRL, ARC_TIMER_CTRL_NH);
 
 	sched_clock_register(arc_timer1_clock_read, 32, arc_timer_freq);
 
@@ -245,7 +245,7 @@ static void arc_timer_event_setup(unsigned int cycles)
 	write_aux_reg(ARC_REG_TIMER0_LIMIT, cycles);
 	write_aux_reg(ARC_REG_TIMER0_CNT, 0);	/* start from 0 */
 
-	write_aux_reg(ARC_REG_TIMER0_CTRL, TIMER_CTRL_IE | TIMER_CTRL_NH);
+	write_aux_reg(ARC_REG_TIMER0_CTRL, ARC_TIMER_CTRL_IE | ARC_TIMER_CTRL_NH);
 }
 
 
@@ -294,7 +294,7 @@ static irqreturn_t timer_irq_handler(int irq, void *dev_id)
 	 *      explicitly clears IP bit
 	 * 2. Re-arm interrupt if periodic by writing to IE bit [0]
 	 */
-	write_aux_reg(ARC_REG_TIMER0_CTRL, irq_reenable | TIMER_CTRL_NH);
+	write_aux_reg(ARC_REG_TIMER0_CTRL, irq_reenable | ARC_TIMER_CTRL_NH);
 
 	evt->event_handler(evt);
 
diff --git a/include/soc/arc/timers.h b/include/soc/arc/timers.h
index 7ecde3b..ae99d3e 100644
--- a/include/soc/arc/timers.h
+++ b/include/soc/arc/timers.h
@@ -17,8 +17,8 @@
 #define ARC_REG_TIMER1_CNT	0x100	/* timer 1 count */
 
 /* CTRL reg bits */
-#define TIMER_CTRL_IE	        (1 << 0) /* Interrupt when Count reaches limit */
-#define TIMER_CTRL_NH	        (1 << 1) /* Count only when CPU NOT halted */
+#define ARC_TIMER_CTRL_IE	(1 << 0) /* Interrupt when Count reaches limit */
+#define ARC_TIMER_CTRL_NH	(1 << 1) /* Count only when CPU NOT halted */
 
 #define ARC_TIMERN_MAX		0xFFFFFFFF
 
