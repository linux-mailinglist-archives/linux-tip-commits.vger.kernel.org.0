Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9292CE2F4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Dec 2020 00:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbgLCXsd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 18:48:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43440 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbgLCXsc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 18:48:32 -0500
Date:   Thu, 03 Dec 2020 23:47:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607039269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aj+bwNzxfz+m6pVUkdDu4SIQ51pSi5YKNJTCHY1zGxQ=;
        b=rQgpuXRjSZTpYCitZ1G8+koaLGraJgL3GsrYtD+F9XL8DX0UIF9vwKfA8gAtkw0B91Qr1A
        6lqRL8ML/NVQ35SJ6p5sQ5n9KnmX1C3dV4GG8rXCA3wkLTCnd6y5Y3cnC1FW/ICtM07tMy
        o5TZniSPViNDyPENwdNdPrWi8Xjc0oAowAMw/NOVzK7x28WiY3B7E7qHcipXQfmOmu4k2f
        lB26ZrOdMsQL9oHBQb7/L0wSXpEgawLxknhUrR+Z+prqi/Dhe+NkBF1D85j0iyOYjZflPn
        Oxmni+hUgJa3PQl/6op6VKsMROsH/DnsO7pD8n3v4/KXzQcouSgfMJGy82Plzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607039269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aj+bwNzxfz+m6pVUkdDu4SIQ51pSi5YKNJTCHY1zGxQ=;
        b=PmVQV9bDKclxDB/85ENgctXPedmwiZZM3EUuMlmaXaQYEkZbgk6Ijt9jImmsN2EMzW+CXB
        9YNzXJFtJPA2LzCw==
From:   "tip-bot2 for Yu Kuai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/cadence_ttc: Fix memory leak
 in ttc_setup_clockevent()
Cc:     Hulk Robot <hulkci@huawei.com>, Yu Kuai <yukuai3@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201116135123.2164033-1-yukuai3@huawei.com>
References: <20201116135123.2164033-1-yukuai3@huawei.com>
MIME-Version: 1.0
Message-ID: <160703926935.3364.302668536378787132.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     eee422c46e6840a81c9db18a497b74387a557b29
Gitweb:        https://git.kernel.org/tip/eee422c46e6840a81c9db18a497b74387a557b29
Author:        Yu Kuai <yukuai3@huawei.com>
AuthorDate:    Mon, 16 Nov 2020 21:51:23 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 03 Dec 2020 19:16:26 +01:00

clocksource/drivers/cadence_ttc: Fix memory leak in ttc_setup_clockevent()

If clk_notifier_register() failed, ttc_setup_clockevent() will return
without freeing 'ttcce', which will leak memory.

Fixes: 70504f311d4b ("clocksource/drivers/cadence_ttc: Convert init function to return error")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201116135123.2164033-1-yukuai3@huawei.com
---
 drivers/clocksource/timer-cadence-ttc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 80e9606..4efd0cf 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -413,10 +413,8 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 	ttcce->ttc.clk = clk;
 
 	err = clk_prepare_enable(ttcce->ttc.clk);
-	if (err) {
-		kfree(ttcce);
-		return err;
-	}
+	if (err)
+		goto out_kfree;
 
 	ttcce->ttc.clk_rate_change_nb.notifier_call =
 		ttc_rate_change_clockevent_cb;
@@ -426,7 +424,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 				    &ttcce->ttc.clk_rate_change_nb);
 	if (err) {
 		pr_warn("Unable to register clock notifier.\n");
-		return err;
+		goto out_kfree;
 	}
 
 	ttcce->ttc.freq = clk_get_rate(ttcce->ttc.clk);
@@ -455,15 +453,17 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 
 	err = request_irq(irq, ttc_clock_event_interrupt,
 			  IRQF_TIMER, ttcce->ce.name, ttcce);
-	if (err) {
-		kfree(ttcce);
-		return err;
-	}
+	if (err)
+		goto out_kfree;
 
 	clockevents_config_and_register(&ttcce->ce,
 			ttcce->ttc.freq / PRESCALE, 1, 0xfffe);
 
 	return 0;
+
+out_kfree:
+	kfree(ttcce);
+	return err;
 }
 
 static int __init ttc_timer_probe(struct platform_device *pdev)
