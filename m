Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D647B2CE304
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Dec 2020 00:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbgLCXtN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 18:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731166AbgLCXtN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 18:49:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C8BC08E85F;
        Thu,  3 Dec 2020 15:47:56 -0800 (PST)
Date:   Thu, 03 Dec 2020 23:47:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607039274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jme53xaOQdO72F1jhg2nmYVP7ANxVC7iMQE7U6lz2Eg=;
        b=UMdoPDmFLuHlsexK6T0p+pVv0QcoTZy/L5rTFsHk5PUMQ9+WFxkWjTLqFg76akp2Uv2g3Q
        I5v9EBFPXJ+X93RmBd+7kJrBo/8bSsnyXIdQjgxfZlofg89SC22i43BwwkXJmkQ994SfDo
        Nm6dYJYywuj5FJ+ncNOujDc+/yO+JAtQUv934NQ1AcooanwD4Gl97QZdg35/JL+IN7ip2U
        47EwCYs1mpZVWyl+vYWF8Q94PRoU1spYbZfioei4grro0jlcINC7fT6AUtxf8mxg0LXuLn
        jI+5W0PGwkl3MnKSfmGbMJQp3oLGVxw3FWK0XbDtYZ+5cgsFxImdo2z5OywJlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607039274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jme53xaOQdO72F1jhg2nmYVP7ANxVC7iMQE7U6lz2Eg=;
        b=EXPJ4akl6qIJsq/Cyu6pIRX2NcdCQqFSXW4G8jWVZQzyjxZNtb7dj84UXcN5rx0m+DT839
        xxb2C5OQkUFF8jCA==
From:   "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sp804: Add static for
 functions such as sp804_clockevents_init()
Cc:     kernel test robot <lkp@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201021012259.2067-2-thunder.leizhen@huawei.com>
References: <20201021012259.2067-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <160703927394.3364.13941572173860349558.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3c0a4b185f6c82c06025720b00a490c719a6f0ff
Gitweb:        https://git.kernel.org/tip/3c0a4b185f6c82c06025720b00a490c719a6f0ff
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Wed, 21 Oct 2020 09:22:59 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 03 Dec 2020 19:16:09 +01:00

clocksource/drivers/sp804: Add static for functions such as sp804_clockevents_init()

Add static for sp804_clocksource_and_sched_clock_init() and
sp804_clockevents_init(), they are only used in timer-sp804.c now.
Otherwise, the following warning will be reported:

drivers/clocksource/timer-sp804.c:68:12: warning: no previous prototype \
for 'sp804_clocksource_and_sched_clock_init' [-Wmissing-prototypes]
drivers/clocksource/timer-sp804.c:162:12: warning: no previous prototype \
for 'sp804_clockevents_init' [-Wmissing-prototypes]

Fixes: 975434f8b24a ("clocksource/drivers/sp804: Delete the leading "__" of some functions")
Fixes: 65f4d7ddc7b6 ("clocksource/drivers/sp804: Remove unused sp804_timer_disable() and timer-sp804.h")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201021012259.2067-2-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp804.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 6e8ad4a..db5330c 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -117,10 +117,10 @@ static u64 notrace sp804_read(void)
 	return ~readl_relaxed(sched_clkevt->value);
 }
 
-int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
-						  const char *name,
-						  struct clk *clk,
-						  int use_sched_clock)
+static int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
+							 const char *name,
+							 struct clk *clk,
+							 int use_sched_clock)
 {
 	long rate;
 	struct sp804_clkevt *clkevt;
@@ -216,8 +216,8 @@ static struct clock_event_device sp804_clockevent = {
 	.rating			= 300,
 };
 
-int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
-				  struct clk *clk, const char *name)
+static int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
+					 struct clk *clk, const char *name)
 {
 	struct clock_event_device *evt = &sp804_clockevent;
 	long rate;
