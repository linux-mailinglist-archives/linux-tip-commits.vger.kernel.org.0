Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1054A359BFB
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 12:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhDIK1p (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 06:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbhDIK1m (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 06:27:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6A3C061761;
        Fri,  9 Apr 2021 03:27:27 -0700 (PDT)
Date:   Fri, 09 Apr 2021 10:27:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617964046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oACO1p4wnALRcEm4RuIScduf6az7/Ti+ol5X3nMwTe8=;
        b=4Rg8RV1P3b1x0h/GvtOUf0L/xjphX3jve35bTBFpP4qoDPIvmnFTEfOBtmhjp06IZc4+I6
        W+80+CjPpEb3SH++2rEhS1H2YRZfsMzYna9P1MtDPWijJCghXkBk5IuYkZAsp5YVmHknVD
        w002JQ+wm2B1/ZaQMHpcoVQB0C00bff+hrVR0nLqeWBRVZ5tDQ1vneUvhidCzcOxlYad9t
        mxvDeZRuNK1Pp5KvVaVVCaTR0A2cA8OVG8UyiXJo8Croc4+E/Wt9Li1UbBDY9cc0fJyGAg
        XxfyB4SXH4vo8oISh1If1OzIDuN9mAoLyvZr2y9pHYJiufvboQgUtn8WKn7+pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617964046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oACO1p4wnALRcEm4RuIScduf6az7/Ti+ol5X3nMwTe8=;
        b=qi5CktMBHPNnmkJ4nXodHgfcj/u3RI4WUB4qRlW+Oy8Jj4+64Al9KbIb/52CDfvnothMFW
        n9QLsOZ/BmmOmgCg==
From:   "tip-bot2 for Dinh Nguyen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/dw_apb_timer_of: Add handling
 for potential memory leak
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210322121844.2271041-1-dinguyen@kernel.org>
References: <20210322121844.2271041-1-dinguyen@kernel.org>
MIME-Version: 1.0
Message-ID: <161796404579.29796.7906578993576300222.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     397dc6f7ca3c858dc95800f299357311ccf679e6
Gitweb:        https://git.kernel.org/tip/397dc6f7ca3c858dc95800f299357311ccf679e6
Author:        Dinh Nguyen <dinguyen@kernel.org>
AuthorDate:    Mon, 22 Mar 2021 07:18:44 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 08 Apr 2021 13:24:53 +02:00

clocksource/drivers/dw_apb_timer_of: Add handling for potential memory leak

Add calls to disable the clock and unmap the timer base address in case
of any failures.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210322121844.2271041-1-dinguyen@kernel.org
---
 drivers/clocksource/dw_apb_timer_of.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index 2b2c3b5..3819ef5 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -52,18 +52,34 @@ static int __init timer_get_base_and_rate(struct device_node *np,
 		return 0;
 
 	timer_clk = of_clk_get_by_name(np, "timer");
-	if (IS_ERR(timer_clk))
-		return PTR_ERR(timer_clk);
+	if (IS_ERR(timer_clk)) {
+		ret = PTR_ERR(timer_clk);
+		goto out_pclk_disable;
+	}
 
 	ret = clk_prepare_enable(timer_clk);
 	if (ret)
-		return ret;
+		goto out_timer_clk_put;
 
 	*rate = clk_get_rate(timer_clk);
-	if (!(*rate))
-		return -EINVAL;
+	if (!(*rate)) {
+		ret = -EINVAL;
+		goto out_timer_clk_disable;
+	}
 
 	return 0;
+
+out_timer_clk_disable:
+	clk_disable_unprepare(timer_clk);
+out_timer_clk_put:
+	clk_put(timer_clk);
+out_pclk_disable:
+	if (!IS_ERR(pclk)) {
+		clk_disable_unprepare(pclk);
+		clk_put(pclk);
+	}
+	iounmap(*base);
+	return ret;
 }
 
 static int __init add_clockevent(struct device_node *event_timer)
