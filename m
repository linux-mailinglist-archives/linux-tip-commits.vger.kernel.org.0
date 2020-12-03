Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A392CE2EE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Dec 2020 00:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbgLCXsj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 18:48:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43514 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731279AbgLCXsf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 18:48:35 -0500
Date:   Thu, 03 Dec 2020 23:47:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607039272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFlwVZkPMKvN+SROeoLVZpAR+CyfutfRaDH4Ik0MEGQ=;
        b=DxxSelB1iOeLwuuY5mgacOFQedtMee+ap4yCzjdVUuQg30DQ692g7uuxKjeioOSGoJgcTK
        3wsJwvAl2HaCFHCAejwFXK2XPCazJVrnpzX2nzbGGVDBIrefycy2Y37T1mDG/hDRinqDhF
        FUCwGgRchAmGIVW84I8yUy80lx62E6PNYQyO2zSw8DdqVOxOFF2Oboq2yX1x/RF6UOaxxC
        FmahERm6DVbTqBF0Lfo+AZbag6UU6sv5HEe2EsyEHpACqz/OvQBXALUhCpTrZzm/O6TEwZ
        n1KZG2KAHw3+JvFSFL+PHZCIkIthq6qwxM7RSaC8CyZvaHyV9O71lUNV4+k5bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607039272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFlwVZkPMKvN+SROeoLVZpAR+CyfutfRaDH4Ik0MEGQ=;
        b=5q0t31Lp60GHak1w9QFTKsQA5vHNHP2HloQmc9QpcgYBX+a/dNPe/BXTFd22B2Tz/jXAF4
        pAkVPxB+9ITGhIDg==
From:   "tip-bot2 for Kefeng Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sp804: Use pr_fmt
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201029123317.90286-5-wangkefeng.wang@huawei.com>
References: <20201029123317.90286-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Message-ID: <160703927219.3364.11705684905823578800.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     19f7ce8e36c09f4a2491b065dabd9162018309b6
Gitweb:        https://git.kernel.org/tip/19f7ce8e36c09f4a2491b065dabd9162018309b6
Author:        Kefeng Wang <wangkefeng.wang@huawei.com>
AuthorDate:    Thu, 29 Oct 2020 20:33:17 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 03 Dec 2020 19:16:18 +01:00

clocksource/drivers/sp804: Use pr_fmt

Add pr_fmt to prefix pr_<level> output.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201029123317.90286-5-wangkefeng.wang@huawei.com
---
 drivers/clocksource/timer-sp804.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index fcce839..401d592 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -5,6 +5,9 @@
  *  Copyright (C) 1999 - 2003 ARM Limited
  *  Copyright (C) 2000 Deep Blue Solutions Ltd
  */
+
+#define pr_fmt(fmt)    KBUILD_MODNAME ": " fmt
+
 #include <linux/clk.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
@@ -63,13 +66,13 @@ static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 	if (!clk)
 		clk = clk_get_sys("sp804", name);
 	if (IS_ERR(clk)) {
-		pr_err("sp804: %s clock not found: %ld\n", name, PTR_ERR(clk));
+		pr_err("%s clock not found: %ld\n", name, PTR_ERR(clk));
 		return PTR_ERR(clk);
 	}
 
 	err = clk_prepare_enable(clk);
 	if (err) {
-		pr_err("sp804: clock failed to enable: %d\n", err);
+		pr_err("clock failed to enable: %d\n", err);
 		clk_put(clk);
 		return err;
 	}
@@ -218,7 +221,7 @@ static int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
 
 	if (request_irq(irq, sp804_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			"timer", &sp804_clockevent))
-		pr_err("%s: request_irq() failed\n", "timer");
+		pr_err("request_irq() failed\n");
 	clockevents_config_and_register(evt, rate, 0xf, 0xffffffff);
 
 	return 0;
@@ -280,7 +283,7 @@ static int __init sp804_of_init(struct device_node *np, struct sp804_timer *time
 	if (of_clk_get_parent_count(np) == 3) {
 		clk2 = of_clk_get(np, 1);
 		if (IS_ERR(clk2)) {
-			pr_err("sp804: %pOFn clock not found: %d\n", np,
+			pr_err("%pOFn clock not found: %d\n", np,
 				(int)PTR_ERR(clk2));
 			clk2 = NULL;
 		}
