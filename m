Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0059D9A2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2019 00:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfHZWxR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Aug 2019 18:53:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41473 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfHZWwY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Aug 2019 18:52:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2NqT-0006o0-Be; Tue, 27 Aug 2019 00:52:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D80BA1C0DDE;
        Tue, 27 Aug 2019 00:52:15 +0200 (CEST)
Date:   Mon, 26 Aug 2019 22:52:15 -0000
From:   tip-bot2 for Jon Hunter <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-of: Do not warn on
 deferred probe
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156685993577.1318.6823470223569390044.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     763719771e84b8c8c2f53af668cdc905faa608de
Gitweb:        https://git.kernel.org/tip/763719771e84b8c8c2f53af668cdc905faa608de
Author:        Jon Hunter <jonathanh@nvidia.com>
AuthorDate:    Wed, 21 Aug 2019 16:02:40 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 27 Aug 2019 00:31:39 +02:00

clocksource/drivers/timer-of: Do not warn on deferred probe

Deferred probe is an expected return value for clk_get() on many
platforms. The driver deals with it properly, so there's no need
to output a warning that may potentially confuse users.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-of.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index 8054228..d8c2bd4 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -113,8 +113,10 @@ static __init int timer_of_clk_init(struct device_node *np,
 	of_clk->clk = of_clk->name ? of_clk_get_by_name(np, of_clk->name) :
 		of_clk_get(np, of_clk->index);
 	if (IS_ERR(of_clk->clk)) {
-		pr_err("Failed to get clock for %pOF\n", np);
-		return PTR_ERR(of_clk->clk);
+		ret = PTR_ERR(of_clk->clk);
+		if (ret != -EPROBE_DEFER)
+			pr_err("Failed to get clock for %pOF\n", np);
+		goto out;
 	}
 
 	ret = clk_prepare_enable(of_clk->clk);
