Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177009D99E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2019 00:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfHZWwX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Aug 2019 18:52:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41455 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfHZWwW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Aug 2019 18:52:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2NqQ-0006mh-5l; Tue, 27 Aug 2019 00:52:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5B87C1C0DE0;
        Tue, 27 Aug 2019 00:52:13 +0200 (CEST)
Date:   Mon, 26 Aug 2019 22:52:13 -0000
From:   tip-bot2 for Anson Huang <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/imx-sysctr: Add internal clock
 divider handle
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156685993313.1300.5077580516378764921.tip-bot2@tip-bot2>
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

Commit-ID:     4419e19d8117dda6bccfbc62090e766f469ff20a
Gitweb:        https://git.kernel.org/tip/4419e19d8117dda6bccfbc62090e766f469ff20a
Author:        Anson Huang <Anson.Huang@nxp.com>
AuthorDate:    Thu, 15 Aug 2019 20:38:42 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 27 Aug 2019 00:31:39 +02:00

clocksource/drivers/imx-sysctr: Add internal clock divider handle

The system counter block guide states that the base clock is
internally divided by 3 before use, that means the clock input of
system counter defined in DT should be base clock which is normally
from OSC, and then internally divided by 3 before use.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-sysctr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index fd7d680..b7c80a3 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -20,6 +20,8 @@
 #define SYS_CTR_EN		0x1
 #define SYS_CTR_IRQ_MASK	0x2
 
+#define SYS_CTR_CLK_DIV		0x3
+
 static void __iomem *sys_ctr_base;
 static u32 cmpcr;
 
@@ -134,6 +136,9 @@ static int __init sysctr_timer_init(struct device_node *np)
 	if (ret)
 		return ret;
 
+	/* system counter clock is divided by 3 internally */
+	to_sysctr.of_clk.rate /= SYS_CTR_CLK_DIV;
+
 	sys_ctr_base = timer_of_base(&to_sysctr);
 	cmpcr = readl(sys_ctr_base + CMPCR);
 	cmpcr &= ~SYS_CTR_EN;
