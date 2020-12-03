Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A5F2CE308
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Dec 2020 00:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbgLCXtO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 18:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbgLCXtN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 18:49:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FEDC08C5F2;
        Thu,  3 Dec 2020 15:47:55 -0800 (PST)
Date:   Thu, 03 Dec 2020 23:47:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607039273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GUW4s6AU1fmorc7mAxrO5GBYxOUjlxaeAPnq/HEuD58=;
        b=4grlbUVUHtDYUZMeChaR1clT1KM32pLvZN8lJBHaLsASmdJKoKOehAeGxQyU1ZndR+rs+0
        AkWiDRiKDfL0o3F7rKi2N62+B83YOIF339ErhSHC9uJRq62eYZXPO5ZFZ58KQ2i5qEebIZ
        WzS7gIM/MD5r4v1AYM+/26x/CL/U+XovG+3Ol0JKJP9HIUho6zvHdUcm/kl4rJhrYwWZg9
        cpVzleYCJSJEuxWMwG5L1XYmbkH0lks+X+9sT5hWAMmopvFPA0gIHrqWqRbHGZSUJmvRss
        ZiHJrlol8RlPqVYTnmxkYyhVAeSQzELFHQJ6okNz9Oqr/rdisyT9xt5PSEHPQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607039273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GUW4s6AU1fmorc7mAxrO5GBYxOUjlxaeAPnq/HEuD58=;
        b=Fx7gGUy24xsNd8fx1u8tBs76CUTi3S+2TY3Rp7kaF4lq5rSX3/KPIs42WWZ5HUQfD2WZ+C
        uGW+l6FciRTY/zCQ==
From:   "tip-bot2 for Kefeng Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sp804: Use clk_prepare_enable
 and clk_disable_unprepare
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201029123317.90286-3-wangkefeng.wang@huawei.com>
References: <20201029123317.90286-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Message-ID: <160703927312.3364.14275095458127731757.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9d4965eb438f0c9f93e91ce6bfec72bbb8def988
Gitweb:        https://git.kernel.org/tip/9d4965eb438f0c9f93e91ce6bfec72bbb8def988
Author:        Kefeng Wang <wangkefeng.wang@huawei.com>
AuthorDate:    Thu, 29 Oct 2020 20:33:15 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 03 Dec 2020 19:16:17 +01:00

clocksource/drivers/sp804: Use clk_prepare_enable and clk_disable_unprepare

Directly use clk_prepare_enable and clk_disable_unprepare.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201029123317.90286-3-wangkefeng.wang@huawei.com
---
 drivers/clocksource/timer-sp804.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 22a68cb..d74788b 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -68,17 +68,9 @@ static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 		return PTR_ERR(clk);
 	}
 
-	err = clk_prepare(clk);
-	if (err) {
-		pr_err("sp804: clock failed to prepare: %d\n", err);
-		clk_put(clk);
-		return err;
-	}
-
-	err = clk_enable(clk);
+	err = clk_prepare_enable(clk);
 	if (err) {
 		pr_err("sp804: clock failed to enable: %d\n", err);
-		clk_unprepare(clk);
 		clk_put(clk);
 		return err;
 	}
@@ -86,8 +78,7 @@ static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 	rate = clk_get_rate(clk);
 	if (rate < 0) {
 		pr_err("sp804: clock failed to get rate: %ld\n", rate);
-		clk_disable(clk);
-		clk_unprepare(clk);
+		clk_disable_unprepare(clk);
 		clk_put(clk);
 	}
 
