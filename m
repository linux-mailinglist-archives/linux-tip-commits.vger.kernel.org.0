Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F472CE2F1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Dec 2020 00:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbgLCXsl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 18:48:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43520 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgLCXsf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 18:48:35 -0500
Date:   Thu, 03 Dec 2020 23:47:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607039273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YmFEEQLf2WAelPhwSt16tWh7diwmoPHgojtUGRcjrcI=;
        b=BQHDJG3VAKI+uTNp9KAbUGNubNMIddoNJO7wP9DYG/UrvQpoTKKIPgaqZj1DdDtWbhaORf
        BT+RTMEp9ZDlql65xGi92UT3b8P6WW0aXypr9gh43O00BUBxfdPviE0Et+hUc1wx6opCDe
        6fVRd00paDrp+aFKj5RSjNiwZXeBhPHct9qFwUx6DI+zBXggl9GSX0jydZcxZULv5kXAmk
        CLqZ2aT8Kj8/9om++uMNqhaxSkYNXa68+bKXs4qJWnScE3IFElOuy8WdvcUSR+ansg5dgA
        jt7LEkrYIUD4p14Lwfosyd8p909z7ntnohbY85xitEqOImd31/WWLDJYhyxlOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607039273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YmFEEQLf2WAelPhwSt16tWh7diwmoPHgojtUGRcjrcI=;
        b=ltpFPgkIlzYHeZxupMjbbtmwPy8/iOYi1RJSp378m1t+GpUuTSnPDrDhqDggA1adB2hsNZ
        9n5epPFk123pThAQ==
From:   "tip-bot2 for Kefeng Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sp804: Correct clk_get_rate handle
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201029123317.90286-4-wangkefeng.wang@huawei.com>
References: <20201029123317.90286-4-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Message-ID: <160703927269.3364.7420018736671696138.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     dca54f8ce1c3c979caf06cfdcdf8eab05a00f5ff
Gitweb:        https://git.kernel.org/tip/dca54f8ce1c3c979caf06cfdcdf8eab05a00f5ff
Author:        Kefeng Wang <wangkefeng.wang@huawei.com>
AuthorDate:    Thu, 29 Oct 2020 20:33:16 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 03 Dec 2020 19:16:17 +01:00

clocksource/drivers/sp804: Correct clk_get_rate handle

clk_get_rate won't return negative value, correct clk_get_rate handle.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201029123317.90286-4-wangkefeng.wang@huawei.com
---
 drivers/clocksource/timer-sp804.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index d74788b..fcce839 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -58,7 +58,6 @@ static struct sp804_clkevt sp804_clkevt[NR_TIMERS];
 
 static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 {
-	long rate;
 	int err;
 
 	if (!clk)
@@ -75,14 +74,7 @@ static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 		return err;
 	}
 
-	rate = clk_get_rate(clk);
-	if (rate < 0) {
-		pr_err("sp804: clock failed to get rate: %ld\n", rate);
-		clk_disable_unprepare(clk);
-		clk_put(clk);
-	}
-
-	return rate;
+	return clk_get_rate(clk);
 }
 
 static struct sp804_clkevt * __init sp804_clkevt_get(void __iomem *base)
