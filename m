Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02CA3ACFB2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 18:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbhFRQF4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 12:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbhFRQFw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 12:05:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3323C061574;
        Fri, 18 Jun 2021 09:03:42 -0700 (PDT)
Date:   Fri, 18 Jun 2021 16:03:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624032221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s7e7IJaPXHeivxB/n1wou8c3uOjA/B4McYCVyvVbbvo=;
        b=03RL5nsraAVwcxldr6YhXLOPz/Yc6XSOIbjf9m5SjglvdjiUxm/7nZdh7kP23uVojio0d8
        oa1l9Ld9FTi6N9d+g+g6Vwg4aqYKYjArOtPSTzqDo0zeCe6ojFCH+ib+jc2kbGPjUaNVX2
        G25SyKqMwFBbQN/WqhmoD4/3ldYklm/FjEiXN28JwpJbg0XaSxwxVgDqS6/isdRBaVdS+p
        kgJCpcaxb9ogUr84xrjAQkXgCzSSgZJO+ODliDIv5IqvJcmq/1nYTb4AKRalGHdvY641dK
        lODkPRJXIK7PV/lSmkhymLlf206SzekOdC2jSU0hm29nPYQPxLIGFSWRXadtMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624032221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s7e7IJaPXHeivxB/n1wou8c3uOjA/B4McYCVyvVbbvo=;
        b=FjGCKEK+pdkPzfLjZGniUkIRSus7P+0Vnpi6SeGNK574YwSERKXfTie2RGBfP6hAxtwC/G
        USEPj2Ks0WiNhrCg==
From:   "tip-bot2 for Evan Benn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/mediatek: Ack and disable
 interrupts on suspend
Cc:     Evan Benn <evanbenn@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210512122528.v4.1.I1d9917047de06715da16e1620759f703fcfdcbcb@changeid>
References: <20210512122528.v4.1.I1d9917047de06715da16e1620759f703fcfdcbcb@changeid>
MIME-Version: 1.0
Message-ID: <162403222096.19906.10495814045933833626.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     75ac5cc2ee6b499bc0225ad67302271772929f19
Gitweb:        https://git.kernel.org/tip/75ac5cc2ee6b499bc0225ad67302271772929f19
Author:        Evan Benn <evanbenn@chromium.org>
AuthorDate:    Wed, 12 May 2021 12:25:44 +10:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Jun 2021 14:14:03 +02:00

clocksource/drivers/mediatek: Ack and disable interrupts on suspend

Interrupts are disabled during suspend before this driver disables its
timers. ARM trusted firmware will abort suspend if the timer irq is
pending, so ack and disable the timer interrupt during suspend.

Signed-off-by: Evan Benn <evanbenn@chromium.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210512122528.v4.1.I1d9917047de06715da16e1620759f703fcfdcbcb@changeid
---
 drivers/clocksource/timer-mediatek.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index 9318edc..ab63b95 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -241,6 +241,28 @@ static void mtk_gpt_enable_irq(struct timer_of *to, u8 timer)
 	       timer_of_base(to) + GPT_IRQ_EN_REG);
 }
 
+static void mtk_gpt_resume(struct clock_event_device *clk)
+{
+	struct timer_of *to = to_timer_of(clk);
+
+	mtk_gpt_enable_irq(to, TIMER_CLK_EVT);
+}
+
+static void mtk_gpt_suspend(struct clock_event_device *clk)
+{
+	struct timer_of *to = to_timer_of(clk);
+
+	/* Disable all interrupts */
+	writel(0x0, timer_of_base(to) + GPT_IRQ_EN_REG);
+
+	/*
+	 * This is called with interrupts disabled,
+	 * so we need to ack any interrupt that is pending
+	 * or for example ATF will prevent a suspend from completing.
+	 */
+	writel(0x3f, timer_of_base(to) + GPT_IRQ_ACK_REG);
+}
+
 static struct timer_of to = {
 	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
 
@@ -286,6 +308,8 @@ static int __init mtk_gpt_init(struct device_node *node)
 	to.clkevt.set_state_oneshot = mtk_gpt_clkevt_shutdown;
 	to.clkevt.tick_resume = mtk_gpt_clkevt_shutdown;
 	to.clkevt.set_next_event = mtk_gpt_clkevt_next_event;
+	to.clkevt.suspend = mtk_gpt_suspend;
+	to.clkevt.resume = mtk_gpt_resume;
 	to.of_irq.handler = mtk_gpt_interrupt;
 
 	ret = timer_of_init(node, &to);
