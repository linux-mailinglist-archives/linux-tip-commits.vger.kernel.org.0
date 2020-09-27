Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CAA27A035
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Sep 2020 11:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgI0J1t (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 27 Sep 2020 05:27:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38208 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgI0J12 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 27 Sep 2020 05:27:28 -0400
Date:   Sun, 27 Sep 2020 09:27:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601198846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NkUziR5CH7MbJe1aUJMRoZ1zyifVJRjEuzhdbnoYtUI=;
        b=O9g7bFjFSPr3OQMLMxvJb74hRoafn7ZWZa5ZaXCP/QlFLY3+1HH1N/yAyH3kW+KeW1+OLK
        0ulGsDwgaH5OQGIXcmG9nEokLT/lfOUihsoZOtEaLgnQGIfESHSZX4l38Eivg2wsON86mQ
        V/k5wJyp9iC9bHmL9FjJu0c+BV8HscdRmJWpXRDAnhQjXsSJuRbJDVeTo1sC4Af1JaXggz
        1eAn1TxzzBnfyaz9l1W31D6nERTTiL8eMXKRF/eGp4h1kQnXoeykRl6RKDEV7pG7khg0EV
        Hd+2Z2PFEdp8kbz8doergBTQZ0ltSELwKbYDMRYbgpj0P/R5ZTRUdr9kBdTxHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601198846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NkUziR5CH7MbJe1aUJMRoZ1zyifVJRjEuzhdbnoYtUI=;
        b=aVg0j5TkDiKt+LURY6VkuUlH2LkKyJB5t4BMrOeskaaNmNgnk520v3y4/X7mNIH89aaoOE
        vaOj/XW84IrwjFCA==
From:   "tip-bot2 for Tianjia Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource/drivers/h8300_timer8: Fix wrong
 return value in h8300_8timer_init()
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200802111541.5429-1-tianjia.zhang@linux.alibaba.com>
References: <20200802111541.5429-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <160119884544.7002.7992233387160286791.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     400d033f5a599120089b5f0c54d14d198499af5a
Gitweb:        https://git.kernel.org/tip/400d033f5a599120089b5f0c54d14d198499af5a
Author:        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
AuthorDate:    Sun, 02 Aug 2020 19:15:41 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 24 Aug 2020 13:01:38 +02:00

clocksource/drivers/h8300_timer8: Fix wrong return value in h8300_8timer_init()

In the init function, if the call to of_iomap() fails, the return
value is ENXIO instead of -ENXIO.

Change to the right negative errno.

Fixes: 691f8f878290f ("clocksource/drivers/h8300_timer8: Convert init function to return error")
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200802111541.5429-1-tianjia.zhang@linux.alibaba.com
---
 drivers/clocksource/h8300_timer8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
index 1d740a8..47114c2 100644
--- a/drivers/clocksource/h8300_timer8.c
+++ b/drivers/clocksource/h8300_timer8.c
@@ -169,7 +169,7 @@ static int __init h8300_8timer_init(struct device_node *node)
 		return PTR_ERR(clk);
 	}
 
-	ret = ENXIO;
+	ret = -ENXIO;
 	base = of_iomap(node, 0);
 	if (!base) {
 		pr_err("failed to map registers for clockevent\n");
