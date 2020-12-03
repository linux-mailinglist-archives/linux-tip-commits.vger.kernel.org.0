Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6EF2CE2F7
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Dec 2020 00:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgLCXsr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 18:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731166AbgLCXsd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 18:48:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5292FC061A54;
        Thu,  3 Dec 2020 15:47:53 -0800 (PST)
Date:   Thu, 03 Dec 2020 23:47:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607039271;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jSMkjD9Qenurfgi00bT7IfsajSivmOgaJaBsexNMQgw=;
        b=bqhg7xKqDtKlXub1+B0Qu3f283uPaMf+eSfk42q8MLQaSggFeyTmYzEnYNc4b30jdWuLl9
        rLR+s6mameXA3c9qM2K9m72cdR0aNcuGaMcf9DKL/nUeKh6U1AcMNOpj6joNxmd269M8o5
        g6uAyNH+Lkj11VsaTzSs/+kIRiUe5wQ9Say5gAweGFud/p6VfTwagyS7ZfB8R5wRPCT+Y3
        ZsgwfydZkFXs7z75EIB0jFjyJunlrdMto4OTOPrQQ3ZVW+mmnODeI/1lmKs5b45Qcc/32e
        OKPznr/4ESi6gfvBsQ+tP/6J/qVZxgjsxdJ5Z+aJnuymU5E9E0gcYXcuz4rjlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607039271;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jSMkjD9Qenurfgi00bT7IfsajSivmOgaJaBsexNMQgw=;
        b=aCJ0Jv7x6QoH6nf73wUmwa0LZde34/d/NXmsUToGgX8hzge9zO6LDm9vXjmp1erlStPaMn
        86ENqovD5gfTkTBg==
From:   "tip-bot2 for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/orion: Add missing
 clk_disable_unprepare() on error path
Cc:     Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201111064706.3397156-1-yangyingliang@huawei.com>
References: <20201111064706.3397156-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Message-ID: <160703927077.3364.12918941878822334244.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c1e6cad00aa2f17845e7270e38ff3cc82c7b022a
Gitweb:        https://git.kernel.org/tip/c1e6cad00aa2f17845e7270e38ff3cc82c7b022a
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Wed, 11 Nov 2020 14:47:06 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 03 Dec 2020 19:16:26 +01:00

clocksource/drivers/orion: Add missing clk_disable_unprepare() on error path

After calling clk_prepare_enable(), clk_disable_unprepare() need
be called on error path.

Fixes: fbe4b3566ddc ("clocksource/drivers/orion: Convert init function...")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201111064706.3397156-1-yangyingliang@huawei.com
---
 drivers/clocksource/timer-orion.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-orion.c b/drivers/clocksource/timer-orion.c
index d01ff41..5101e83 100644
--- a/drivers/clocksource/timer-orion.c
+++ b/drivers/clocksource/timer-orion.c
@@ -143,7 +143,8 @@ static int __init orion_timer_init(struct device_node *np)
 	irq = irq_of_parse_and_map(np, 1);
 	if (irq <= 0) {
 		pr_err("%pOFn: unable to parse timer1 irq\n", np);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unprep_clk;
 	}
 
 	rate = clk_get_rate(clk);
@@ -160,7 +161,7 @@ static int __init orion_timer_init(struct device_node *np)
 				    clocksource_mmio_readl_down);
 	if (ret) {
 		pr_err("Failed to initialize mmio timer\n");
-		return ret;
+		goto out_unprep_clk;
 	}
 
 	sched_clock_register(orion_read_sched_clock, 32, rate);
@@ -170,7 +171,7 @@ static int __init orion_timer_init(struct device_node *np)
 			  "orion_event", NULL);
 	if (ret) {
 		pr_err("%pOFn: unable to setup irq\n", np);
-		return ret;
+		goto out_unprep_clk;
 	}
 
 	ticks_per_jiffy = (clk_get_rate(clk) + HZ/2) / HZ;
@@ -183,5 +184,9 @@ static int __init orion_timer_init(struct device_node *np)
 	orion_delay_timer_init(rate);
 
 	return 0;
+
+out_unprep_clk:
+	clk_disable_unprepare(clk);
+	return ret;
 }
 TIMER_OF_DECLARE(orion_timer, "marvell,orion-timer", orion_timer_init);
