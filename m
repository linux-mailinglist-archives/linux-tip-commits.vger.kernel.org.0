Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E7127A037
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Sep 2020 11:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgI0J1X (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 27 Sep 2020 05:27:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38100 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI0J1X (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 27 Sep 2020 05:27:23 -0400
Date:   Sun, 27 Sep 2020 09:27:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601198840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VHpxqLpHfRdnTf2yLc6PD3ZbrpNdW3AUuwgLP7OYf3E=;
        b=sCjYijXksxYit2gocLpK4NHsIUltQU1eyxtjPp25DakcajhoEMzikTzxmr3iKwo43ln4RQ
        BhNgerJA6cJzgNe4hfXYnJZYyYpiAfLCVniGOQyIjnZ7hBxLvf+ogBva12A4M4J+GJ3RXj
        hKkjnKIySrCkM9i/RTO2454o4Wkimj9r1EscftLXEXTi5ZBmzdetC9Egk3i61QsIAXv7we
        SB9YrKvomsVOfUzHQA5f1rBqGrCoJL8etqpPmwRPfL5qyrTTc6Fx8tOI1k1FGcM/Uc6HAJ
        sJLqHA3dCNX6+BfDlEheNE+2VmSn65flCT3GDdRUMKTmkOWlZfQmCz6mCBXE4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601198840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VHpxqLpHfRdnTf2yLc6PD3ZbrpNdW3AUuwgLP7OYf3E=;
        b=X4+vKiAgDzX1LNxn7LlRley4fquiur4r/jM3AeTiOnKPREa9gZcg0M8Izi0eT4SaxR99rL
        hwOhf/2vh2jlSTCA==
From:   "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sp804: Add support for
 Hisilicon sp804 timer
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200918132237.3552-8-thunder.leizhen@huawei.com>
References: <20200918132237.3552-8-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <160119883960.7002.9470721026208404830.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bd5a1936ffa2b69032815775fa54fc1c422d49d5
Gitweb:        https://git.kernel.org/tip/bd5a1936ffa2b69032815775fa54fc1c422d49d5
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Fri, 18 Sep 2020 21:22:35 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 24 Sep 2020 10:51:04 +02:00

clocksource/drivers/sp804: Add support for Hisilicon sp804 timer

The ARM SP804 supports a maximum of 32-bit counter, but Hisilicon extends
it to 64-bit. That means, the registers: TimerXload, TimerXValue and
TimerXBGLoad are 64bits, all other registers are the same as those in the
SP804. The driver code can be completely reused except that the register
offset is different.

Use compatible = "hisilicon,sp804" mark as Hisilicon sp804 timer.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200918132237.3552-8-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp804.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 5f4f979..f0783d1 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -20,6 +20,18 @@
 
 #include "timer-sp.h"
 
+/* Hisilicon 64-bit timer(a variant of ARM SP804) */
+#define HISI_TIMER_1_BASE	0x00
+#define HISI_TIMER_2_BASE	0x40
+#define HISI_TIMER_LOAD		0x00
+#define HISI_TIMER_VALUE	0x08
+#define HISI_TIMER_CTRL		0x10
+#define HISI_TIMER_INTCLR	0x14
+#define HISI_TIMER_RIS		0x18
+#define HISI_TIMER_MIS		0x1c
+#define HISI_TIMER_BGLOAD	0x20
+
+
 struct sp804_timer __initdata arm_sp804_timer = {
 	.load		= TIMER_LOAD,
 	.value		= TIMER_VALUE,
@@ -29,6 +41,15 @@ struct sp804_timer __initdata arm_sp804_timer = {
 	.width		= 32,
 };
 
+struct sp804_timer __initdata hisi_sp804_timer = {
+	.load		= HISI_TIMER_LOAD,
+	.value		= HISI_TIMER_VALUE,
+	.ctrl		= HISI_TIMER_CTRL,
+	.intclr		= HISI_TIMER_INTCLR,
+	.timer_base	= {HISI_TIMER_1_BASE, HISI_TIMER_2_BASE},
+	.width		= 64,
+};
+
 static struct sp804_clkevt sp804_clkevt[NR_TIMERS];
 
 static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
@@ -315,6 +336,12 @@ static int __init arm_sp804_of_init(struct device_node *np)
 }
 TIMER_OF_DECLARE(sp804, "arm,sp804", arm_sp804_of_init);
 
+static int __init hisi_sp804_of_init(struct device_node *np)
+{
+	return sp804_of_init(np, &hisi_sp804_timer);
+}
+TIMER_OF_DECLARE(hisi_sp804, "hisilicon,sp804", hisi_sp804_of_init);
+
 static int __init integrator_cp_of_init(struct device_node *np)
 {
 	static int init_count = 0;
