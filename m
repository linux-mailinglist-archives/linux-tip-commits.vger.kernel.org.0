Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1D4359BFE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 12:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhDIK1r (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 06:27:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49638 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbhDIK1n (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 06:27:43 -0400
Date:   Fri, 09 Apr 2021 10:27:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617964047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RpXUcJFVAbPv/enfIYWxGxieQKnrqvTMi8i/syVswnM=;
        b=e2KcTvPbHvuw1znuKvbC/CktR2yLO/ubmyBVlNZtVOps8hAcOeSg3pACIUXC1/8bwdrGvm
        XFMgadclIFk7mIFSD0u4qGFQzCcT/oL5fJ0NCSmq1G8WEw+6nTdRmMn7o4cNyaQDIynLkq
        WLCBrqb1J5iWHf45AwhfZUHqGs/PVugTDc63XllnaK322vL26+gJ8DRUBiDZ0cw6fNuZCf
        Lc6nnbRXTQ0KW8RhINxzyR0NXZ7IH4d5IolJG7YeeYgBoGqK1bUczFjlJYGuJq8K7cflpW
        FNM7hXw0DYwarhUSOBq5pWG6QYiovISEQWqQe4+Ekf32OfEc01GMs6oRLzoouA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617964047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RpXUcJFVAbPv/enfIYWxGxieQKnrqvTMi8i/syVswnM=;
        b=Db2l2ov2zCMOWjI26oB8mhjPvXo6LypLodWBR38EwJB/5mLYCm7752yND5b/sSsuOIZItT
        GRu0FnlFZnF54TBg==
From:   "tip-bot2 for Wei Yongjun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/ingenic_ost: Fix return value
 check in ingenic_ost_probe()
Cc:     Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210308123031.2285083-1-weiyongjun1@huawei.com>
References: <20210308123031.2285083-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Message-ID: <161796404735.29796.5865943539504104634.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2a65f7e2772613debd03fa2492e76a635aa04545
Gitweb:        https://git.kernel.org/tip/2a65f7e2772613debd03fa2492e76a635aa04545
Author:        Wei Yongjun <weiyongjun1@huawei.com>
AuthorDate:    Mon, 08 Mar 2021 12:30:31 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 08 Apr 2021 13:24:15 +02:00

clocksource/drivers/ingenic_ost: Fix return value check in ingenic_ost_probe()

In case of error, the function device_node_to_regmap() returns
ERR_PTR() and never returns NULL. The NULL test in the return
value check should be replaced with IS_ERR().

Fixes: ca7b72b5a5f2 ("clocksource: Add driver for the Ingenic JZ47xx OST")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210308123031.2285083-1-weiyongjun1@huawei.com
---
 drivers/clocksource/ingenic-ost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/ingenic-ost.c b/drivers/clocksource/ingenic-ost.c
index d2d6646..06d2575 100644
--- a/drivers/clocksource/ingenic-ost.c
+++ b/drivers/clocksource/ingenic-ost.c
@@ -88,9 +88,9 @@ static int __init ingenic_ost_probe(struct platform_device *pdev)
 		return PTR_ERR(ost->regs);
 
 	map = device_node_to_regmap(dev->parent->of_node);
-	if (!map) {
+	if (IS_ERR(map)) {
 		dev_err(dev, "regmap not found");
-		return -EINVAL;
+		return PTR_ERR(map);
 	}
 
 	ost->clk = devm_clk_get(dev, "ost");
