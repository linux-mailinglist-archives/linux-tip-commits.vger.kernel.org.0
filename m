Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B7027A029
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Sep 2020 11:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgI0J12 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 27 Sep 2020 05:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgI0J1Y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 27 Sep 2020 05:27:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF29C0613CE;
        Sun, 27 Sep 2020 02:27:24 -0700 (PDT)
Date:   Sun, 27 Sep 2020 09:27:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601198842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G48oWQo3iYokRZVjZalYpAiocL2lZUIoAcqLXi8KKBI=;
        b=k3a2c/mkYgOKU69ZMaHiy5nFTW1fhlYR9VUSNgSizf88Bk5FHpbMR0vHUE2jxpbWRq4Eb4
        /hIDtH3L3JmBhLfl90vXtOyiTSy3qYcZdAkIhN4uX3gh2S3e1Krx2t+FNei5uxqTMShod0
        LPy6yNqjqT+i7jUq7eXJMXiJj8XX51yP0wscZZoE4Z6eKXTglBju8qK3GFMINctdUejV0G
        Ktb6dNfSCxkAS05X59/iJQpz54nsqwFKlj51P0U4Zbh2z07Kb4utRU4hZdpQGmurdHyXgU
        rCFInv4Pb0zlg80wLf04m9lwbK09dwKYkLB4bKWXkN4Q5GTj6zbzWByE4lM90A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601198842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G48oWQo3iYokRZVjZalYpAiocL2lZUIoAcqLXi8KKBI=;
        b=RKe3LMKrm0JH+Y9sR2zOlkzLzztyCmA9pz4L0iIw2fb5sTGoxwkL4mrqZKMSOIA02PGxlX
        JLdJHSmt9DH5e1AA==
From:   "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sp804: Remove unused
 sp804_timer_disable() and timer-sp804.h
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200918132237.3552-3-thunder.leizhen@huawei.com>
References: <20200918132237.3552-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <160119884197.7002.6152487091186524941.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     65f4d7ddc7b681001246f60c22a3cf650864da35
Gitweb:        https://git.kernel.org/tip/65f4d7ddc7b681001246f60c22a3cf650864da35
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Fri, 18 Sep 2020 21:22:30 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 24 Sep 2020 10:51:04 +02:00

clocksource/drivers/sp804: Remove unused sp804_timer_disable() and timer-sp804.h

Since commit 7484c727b636 ("ARM: realview: delete the RealView board
files") and commit 16956fed35fe ("ARM: versatile: switch to DT only
booting and remove legacy code"), there's no one to use the functions
defined or declared in include/clocksource/timer-sp804.h. Delete it.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200918132237.3552-3-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp804.c |  7 -------
 include/clocksource/timer-sp804.h | 29 -----------------------------
 2 files changed, 36 deletions(-)
 delete mode 100644 include/clocksource/timer-sp804.h

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index bec2d37..97b41a4 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -18,8 +18,6 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 
-#include <clocksource/timer-sp804.h>
-
 #include "timer-sp.h"
 
 static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
@@ -67,11 +65,6 @@ static u64 notrace sp804_read(void)
 	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
 }
 
-void __init sp804_timer_disable(void __iomem *base)
-{
-	writel(0, base + TIMER_CTRL);
-}
-
 int  __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
 						     const char *name,
 						     struct clk *clk,
diff --git a/include/clocksource/timer-sp804.h b/include/clocksource/timer-sp804.h
deleted file mode 100644
index a5b41f3..0000000
--- a/include/clocksource/timer-sp804.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __CLKSOURCE_TIMER_SP804_H
-#define __CLKSOURCE_TIMER_SP804_H
-
-struct clk;
-
-int __sp804_clocksource_and_sched_clock_init(void __iomem *,
-					     const char *, struct clk *, int);
-int __sp804_clockevents_init(void __iomem *, unsigned int,
-			     struct clk *, const char *);
-void sp804_timer_disable(void __iomem *);
-
-static inline void sp804_clocksource_init(void __iomem *base, const char *name)
-{
-	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 0);
-}
-
-static inline void sp804_clocksource_and_sched_clock_init(void __iomem *base,
-							  const char *name)
-{
-	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 1);
-}
-
-static inline void sp804_clockevents_init(void __iomem *base, unsigned int irq, const char *name)
-{
-	__sp804_clockevents_init(base, irq, NULL, name);
-
-}
-#endif
