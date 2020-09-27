Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821B527A033
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Sep 2020 11:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgI0J1h (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 27 Sep 2020 05:27:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38138 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgI0J1Y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 27 Sep 2020 05:27:24 -0400
Date:   Sun, 27 Sep 2020 09:27:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601198842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OnM6aQVyNa3xu3woV9/e5trpDDTB0Z3LkEVHsUiNfZQ=;
        b=JCuk/T1WXiIrjycTW6nPHwpUpd9v/TchDLhn31uARi1NqVXaJi2D7nQ6KEy18NKxW9SyfO
        C3s4PN4J3tngVj1ErslCkq0J8H0cHwuMnUjfbj+4xL4V2W7iKtTTiTKlUB0YouAMrV7Hey
        gWwhurazM9h3i5sulXmzva9gfZNYt9ugPYHFPoR+Y15FfrjK00jAKqMsyQnSwObjZgKwgz
        Kg6a+i3u1Fbq96PzI4LE5c8NWJuXoaj4tCKVVUl5UjR75M7NlzOw45v7ni/5Ixk7BoG7uY
        rDbGAbKLaMhtIubbUniVQ+37q8iRzOgCt4IWhZS3m+DYoFij9/coOPi7e9hEWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601198842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OnM6aQVyNa3xu3woV9/e5trpDDTB0Z3LkEVHsUiNfZQ=;
        b=tzE5PgrUEUoGFINkBj9jCYNlDwd2k031PR7WgE7QnAkIhxbX9JNRWuovkcrjwa6j7gAV5e
        hHRYSonLYTkr2CBw==
From:   "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sp804: Delete the leading "__"
 of some functions
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200918132237.3552-4-thunder.leizhen@huawei.com>
References: <20200918132237.3552-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <160119884140.7002.1633179964213830099.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     975434f8b24a55af31daa4634972890c061a0a0c
Gitweb:        https://git.kernel.org/tip/975434f8b24a55af31daa4634972890c061a0a0c
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Fri, 18 Sep 2020 21:22:31 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 24 Sep 2020 10:51:04 +02:00

clocksource/drivers/sp804: Delete the leading "__" of some functions

Delete the leading "__" of __sp804_clocksource_and_sched_clock_init() and
__sp804_clockevents_init(), make it looks a little more comfortable.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200918132237.3552-4-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp804.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 97b41a4..097f5a8 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -65,10 +65,10 @@ static u64 notrace sp804_read(void)
 	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
 }
 
-int  __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
-						     const char *name,
-						     struct clk *clk,
-						     int use_sched_clock)
+int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
+						  const char *name,
+						  struct clk *clk,
+						  int use_sched_clock)
 {
 	long rate;
 
@@ -159,7 +159,8 @@ static struct clock_event_device sp804_clockevent = {
 	.rating			= 300,
 };
 
-int __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struct clk *clk, const char *name)
+int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
+				  struct clk *clk, const char *name)
 {
 	struct clock_event_device *evt = &sp804_clockevent;
 	long rate;
@@ -228,21 +229,22 @@ static int __init sp804_of_init(struct device_node *np)
 	of_property_read_u32(np, "arm,sp804-has-irq", &irq_num);
 	if (irq_num == 2) {
 
-		ret = __sp804_clockevents_init(base + TIMER_2_BASE, irq, clk2, name);
+		ret = sp804_clockevents_init(base + TIMER_2_BASE, irq, clk2, name);
 		if (ret)
 			goto err;
 
-		ret = __sp804_clocksource_and_sched_clock_init(base, name, clk1, 1);
+		ret = sp804_clocksource_and_sched_clock_init(base,
+							     name, clk1, 1);
 		if (ret)
 			goto err;
 	} else {
 
-		ret = __sp804_clockevents_init(base, irq, clk1 , name);
+		ret = sp804_clockevents_init(base, irq, clk1, name);
 		if (ret)
 			goto err;
 
-		ret =__sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE,
-							      name, clk2, 1);
+		ret = sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE,
+							     name, clk2, 1);
 		if (ret)
 			goto err;
 	}
@@ -282,7 +284,8 @@ static int __init integrator_cp_of_init(struct device_node *np)
 		goto err;
 
 	if (!init_count) {
-		ret = __sp804_clocksource_and_sched_clock_init(base, name, clk, 0);
+		ret = sp804_clocksource_and_sched_clock_init(base,
+							     name, clk, 0);
 		if (ret)
 			goto err;
 	} else {
@@ -290,7 +293,7 @@ static int __init integrator_cp_of_init(struct device_node *np)
 		if (irq <= 0)
 			goto err;
 
-		ret = __sp804_clockevents_init(base, irq, clk, name);
+		ret = sp804_clockevents_init(base, irq, clk, name);
 		if (ret)
 			goto err;
 	}
