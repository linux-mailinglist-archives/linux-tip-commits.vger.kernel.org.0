Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A388F3ACFAF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 18:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbhFRQFy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 12:05:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57418 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhFRQFv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 12:05:51 -0400
Date:   Fri, 18 Jun 2021 16:03:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624032221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9NOyDN1Emmtcu9gsSsGTxEq1iVk0D7i6S4fpHLEpys=;
        b=B6BYkRWZTADpLI500g2/qeElwG3Et+nMivxvRI8zn49j4w9iJCNF2+iiE8/El65lhSbhpv
        Jzn3LR1/214gLpUdkIgIaAGAIHF4dNFcYzO+7RF6VywmKLGftaWRtjaqsNpE95hARvTRgZ
        wLBWm2CjZwM+Sw9P9KeWS1Q36tmgDevpVemAVwsBn64ZxSL7cNn81i5s3jwhpnqlaprk2J
        kbAfI910kdWgPUwrelM0LKKWUbMipIc6HqtKv4gX6xZ9LqzuGuvBRz+0D3eJntMwaq6+dQ
        JTfBluit37Taj4bswKZzj+bgplLeTbIMpB8ak/yRTSEbFOUwSp8ixztvQ+FguA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624032221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9NOyDN1Emmtcu9gsSsGTxEq1iVk0D7i6S4fpHLEpys=;
        b=FYzyokFUcUG2FeYJrNnu0H52rTmxqWTyM316WgQRmqT7a4nOPPqsrqN2oZ9oF5TkjZyFpB
        ouydwUpYKJllP3AQ==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Save and restore
 timer TIOCP_CFG
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Adam Ford <aford173@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210415085506.56828-1-tony@atomide.com>
References: <20210415085506.56828-1-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <162403222040.19906.12782574837725084275.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9517c577f9f722270584cfb1a7b4e1354e408658
Gitweb:        https://git.kernel.org/tip/9517c577f9f722270584cfb1a7b4e1354e408658
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Thu, 15 Apr 2021 11:55:06 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Jun 2021 14:14:14 +02:00

clocksource/drivers/timer-ti-dm: Save and restore timer TIOCP_CFG

As we are using cpu_pm to save and restore context, we must also save and
restore the timer sysconfig register TIOCP_CFG. This is needed because
we are not calling PM runtime functions at all with cpu_pm.

Fixes: b34677b0999a ("clocksource/drivers/timer-ti-dm: Implement cpu_pm notifier for context save and restore")
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Adam Ford <aford173@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>
Cc: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210415085506.56828-1-tony@atomide.com
---
 drivers/clocksource/timer-ti-dm.c | 6 ++++++
 include/clocksource/timer-ti-dm.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 33eeabf..e5c631f 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -78,6 +78,9 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 
 static void omap_timer_restore_context(struct omap_dm_timer *timer)
 {
+	__omap_dm_timer_write(timer, OMAP_TIMER_OCP_CFG_OFFSET,
+			      timer->context.ocp_cfg, 0);
+
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG,
 				timer->context.twer);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG,
@@ -95,6 +98,9 @@ static void omap_timer_restore_context(struct omap_dm_timer *timer)
 
 static void omap_timer_save_context(struct omap_dm_timer *timer)
 {
+	timer->context.ocp_cfg =
+		__omap_dm_timer_read(timer, OMAP_TIMER_OCP_CFG_OFFSET, 0);
+
 	timer->context.tclr =
 			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	timer->context.twer =
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
index 4c61dad..f6da8a1 100644
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -74,6 +74,7 @@
 #define OMAP_TIMER_ERRATA_I103_I767			0x80000000
 
 struct timer_regs {
+	u32 ocp_cfg;
 	u32 tidr;
 	u32 tier;
 	u32 twer;
