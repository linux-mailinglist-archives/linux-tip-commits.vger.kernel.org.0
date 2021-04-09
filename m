Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A56359C01
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 12:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhDIK1u (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 06:27:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49654 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhDIK1n (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 06:27:43 -0400
Date:   Fri, 09 Apr 2021 10:27:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617964048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DxYiiPzBlmDXJKr6niOfykMji13w89Am+JbYSxwhg/k=;
        b=O8YG0tgWMiTq68bNe52y1/q/LCLHzidJqZsAA5CMU9tsD9bT95tx2mxO4oelzonJJrI0fV
        GMdmpTBxU4hArh+FZlGjz2ASMJjhuY++eacY5GBhpJ2BDB1JmwlJCQRaLmIDRR13GDnq+V
        hh6QGjaD+efFkQecN5Njm4I0ehhjgdA6zkgkhFuzTETKDM9CmuuPrDUJqTb5frY7JR4SeK
        X+z5IfUCxEMzmMNoucygbgiovsIX3n304is7hx1mi9Qzhuetgq12c1+R/3ZflBfUoZ/ZSd
        4fLiDSvdtJlImJ67zGXPBxt4VhZU21dcxaeCPZ1IVImjz0J8RBn33lLMVCJdIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617964048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DxYiiPzBlmDXJKr6niOfykMji13w89Am+JbYSxwhg/k=;
        b=TQIFtyZ8CGoIFlfi3dWMYPssFOXooIvlxUmOsWiTq5C0kPRNRPCUTv+0VJ3wT0UrI8o2tz
        cYx/hrwvnbvp+0Dw==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Add missing
 set_state_oneshot_stopped
Cc:     Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304072135.52712-4-tony@atomide.com>
References: <20210304072135.52712-4-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <161796404779.29796.13930394883340080121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ac4daf737674b4d29e19b7c300caff3bcf7160d8
Gitweb:        https://git.kernel.org/tip/ac4daf737674b4d29e19b7c300caff3bcf7160d8
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Thu, 04 Mar 2021 09:21:35 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 08 Apr 2021 13:23:47 +02:00

clocksource/drivers/timer-ti-dm: Add missing set_state_oneshot_stopped

To avoid spurious timer interrupts when KTIME_MAX is used, we need to
configure set_state_oneshot_stopped(). Although implementing this is
optional, it still affects things like power management for the extra
timer interrupt.

For more information, please see commit 8fff52fd5093 ("clockevents:
Introduce CLOCK_EVT_STATE_ONESHOT_STOPPED state") and commit cf8c5009ee37
("clockevents/drivers/arm_arch_timer: Implement
->set_state_oneshot_stopped()").

Fixes: 52762fbd1c47 ("clocksource/drivers/timer-ti-dm: Add clockevent and clocksource support")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210304072135.52712-4-tony@atomide.com
---
 drivers/clocksource/timer-ti-dm-systimer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index 3a65434..186a599 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -554,6 +554,7 @@ static int __init dmtimer_clockevent_init(struct device_node *np)
 	dev->set_state_shutdown = dmtimer_clockevent_shutdown;
 	dev->set_state_periodic = dmtimer_set_periodic;
 	dev->set_state_oneshot = dmtimer_clockevent_shutdown;
+	dev->set_state_oneshot_stopped = dmtimer_clockevent_shutdown;
 	dev->tick_resume = dmtimer_clockevent_shutdown;
 	dev->cpumask = cpu_possible_mask;
 
