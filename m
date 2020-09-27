Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5A827A02A
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Sep 2020 11:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgI0J13 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 27 Sep 2020 05:27:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38132 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgI0J1X (ORCPT
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
        bh=MavYTX+JSgOLnrqC+IUCqIFdaZNDRBELuEFkvvCkhkM=;
        b=QLaRQJELUdJkB9fLX4RbBeCOGhqYUgBqOmLyc7HNqM86PRcFleNgWePYh5UHwxT/qreTcT
        Gg/gNYPq4ddNCotM2c7LXcYvaKRXE3IkQW6YsrslA94awFBVlNEfm1CgFlN+3UCL7nND0n
        H004Txm9N8o2rITGApW/2qqTBX7Yy3aYwO13dYEu2MSWzWKg/YN868XsnrmFplTt+SJx7Z
        oHmO/HMErcDw0Yjr/K29RVc6c7xNw4w27ZbhKZbp3laiWYnPbvEOJnWl7zaVAhFPjSj466
        I45elWo7dbL7q41GxYfsnhuny2O2XdEsOHRPg81td+h0YCh9t0CJefbljsezqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601198841;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MavYTX+JSgOLnrqC+IUCqIFdaZNDRBELuEFkvvCkhkM=;
        b=BOWaUWGFUwzqrIVC1Sq5SBP78Z7f3lgRi78Q+W09fIww07rVjrQa45z7/NcWClpixgXuUc
        Xn6F0piToWbP6WDA==
From:   "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sp804: Remove a mismatched comment
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200918132237.3552-5-thunder.leizhen@huawei.com>
References: <20200918132237.3552-5-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <160119884087.7002.15407009426816787123.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2f71078e7753b2fbba62999aa46c2fad16df9d98
Gitweb:        https://git.kernel.org/tip/2f71078e7753b2fbba62999aa46c2fad16df9d98
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Fri, 18 Sep 2020 21:22:32 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 24 Sep 2020 10:51:04 +02:00

clocksource/drivers/sp804: Remove a mismatched comment

writel(0, base + TIMER_CTRL);
... ...
writel(xxx | TIMER_CTRL_PERIODIC, base + TIMER_CTRL);

The timer is just temporarily disabled, and it will be set to periodic
mode later.

The description of the field TimerMode of the register TimerXControl
as shown below:
0 = Timer module is in free-running mode (default)
1 = Timer module is in periodic mode.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200918132237.3552-5-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp804.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 097f5a8..a443f39 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -76,7 +76,6 @@ int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
 	if (rate < 0)
 		return -EINVAL;
 
-	/* setup timer 0 as free-running clocksource */
 	writel(0, base + TIMER_CTRL);
 	writel(0xffffffff, base + TIMER_LOAD);
 	writel(0xffffffff, base + TIMER_VALUE);
