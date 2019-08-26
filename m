Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90ED19D99F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2019 00:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfHZWwZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Aug 2019 18:52:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41481 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfHZWwY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Aug 2019 18:52:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2NqU-0006oM-QH; Tue, 27 Aug 2019 00:52:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7C1711C0DDF;
        Tue, 27 Aug 2019 00:52:16 +0200 (CEST)
Date:   Mon, 26 Aug 2019 22:52:16 -0000
From:   tip-bot2 for Jon Hunter <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers: Do not warn on probe defer
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156685993641.1321.15726266917512010090.tip-bot2@tip-bot2>
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

Commit-ID:     14e019df1e64c8b19ce8e0b3da25b6f40c8716be
Gitweb:        https://git.kernel.org/tip/14e019df1e64c8b19ce8e0b3da25b6f40c8716be
Author:        Jon Hunter <jonathanh@nvidia.com>
AuthorDate:    Wed, 21 Aug 2019 16:02:41 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 27 Aug 2019 00:31:39 +02:00

clocksource/drivers: Do not warn on probe defer

Deferred probe is an expected return value on many platforms and so
there's no need to output a warning that may potentially confuse users.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-probe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
index dda1946..ee9574d 100644
--- a/drivers/clocksource/timer-probe.c
+++ b/drivers/clocksource/timer-probe.c
@@ -29,7 +29,9 @@ void __init timer_probe(void)
 
 		ret = init_func_ret(np);
 		if (ret) {
-			pr_err("Failed to initialize '%pOF': %d\n", np, ret);
+			if (ret != -EPROBE_DEFER)
+				pr_err("Failed to initialize '%pOF': %d\n", np,
+				       ret);
 			continue;
 		}
 
