Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D023438A04
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Oct 2021 17:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhJXPma (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Oct 2021 11:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhJXPm0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Oct 2021 11:42:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EFBC061745;
        Sun, 24 Oct 2021 08:40:05 -0700 (PDT)
Date:   Sun, 24 Oct 2021 15:40:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635090004;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S8SIjBl/WTOaM3v5g80WQS2LGQBJMDkxgDFS1PA5Xc0=;
        b=qVAmh4UbZidgBN6CAIJ74XZ10SnWEA/IeDJobALA7pr7y4MCcpFlUNAtw/RKyEsp1nFNRu
        xFVxdyteOk3Q6Wj3lg20VkFDGkP/eQ/zRznpREPaP7JhNsjxFgHndQ4uaHmhi9AaZ75B29
        0GLBOGCf/KtCDIfcQBRrc3boDkg+xyDnkAWrTt0UMQBGf69TcRL4XkLxRXV5CYwa7X2PiG
        4PPiQh+8TfRz8X9mL/UKIjzKCKEcodJywoNQ447I8ihi34Oc1WOzWlTRseKcBbXpgm8iH5
        lEa2BaYjZp6psq7/ipYJ6+mumpLL/zYnjZpNQv5ZokbYKMP1NyyhgP57ShEajQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635090004;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S8SIjBl/WTOaM3v5g80WQS2LGQBJMDkxgDFS1PA5Xc0=;
        b=qn8RVH4jmufTFIt+rerdfLL4posEc1w3D2FK3PkODn8haWcmAVSAqugN8HnINoKEyRSLcW
        2rZBmz3MTt3ta0BA==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Fix MMIO base
 address vs callback ordering issue
Cc:     Oliver Upton <oupton@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211017124225.3018098-7-maz@kernel.org>
References: <20211017124225.3018098-7-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163509000318.626.4703226817140830741.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     72f47a3f0ea4cda4ca5d90c0d6043f697b9b0647
Gitweb:        https://git.kernel.org/tip/72f47a3f0ea4cda4ca5d90c0d6043f697b9b0647
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 17 Oct 2021 13:42:14 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 17 Oct 2021 21:47:15 +02:00

clocksource/drivers/arm_arch_timer: Fix MMIO base address vs callback ordering issue

The MMIO timer base address gets published after we have registered
the callbacks and the interrupt handler, which is... a bit dangerous.

Fix this by moving the base address publication to the point where
we register the timer, and expose a pointer to the timer structure
itself rather than a naked value.

Reviewed-by: Oliver Upton <oupton@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211017124225.3018098-7-maz@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 8afe8c8..bede10f 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -54,13 +54,13 @@
 
 static unsigned arch_timers_present __initdata;
 
-static void __iomem *arch_counter_base __ro_after_init;
-
 struct arch_timer {
 	void __iomem *base;
 	struct clock_event_device evt;
 };
 
+static struct arch_timer *arch_timer_mem __ro_after_init;
+
 #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
 
 static u32 arch_timer_rate __ro_after_init;
@@ -973,9 +973,9 @@ static u64 arch_counter_get_cntvct_mem(void)
 	u32 vct_lo, vct_hi, tmp_hi;
 
 	do {
-		vct_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
-		vct_lo = readl_relaxed(arch_counter_base + CNTVCT_LO);
-		tmp_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
+		vct_hi = readl_relaxed(arch_timer_mem->base + CNTVCT_HI);
+		vct_lo = readl_relaxed(arch_timer_mem->base + CNTVCT_LO);
+		tmp_hi = readl_relaxed(arch_timer_mem->base + CNTVCT_HI);
 	} while (vct_hi != tmp_hi);
 
 	return ((u64) vct_hi << 32) | vct_lo;
@@ -1166,25 +1166,25 @@ static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
 {
 	int ret;
 	irq_handler_t func;
-	struct arch_timer *t;
 
-	t = kzalloc(sizeof(*t), GFP_KERNEL);
-	if (!t)
+	arch_timer_mem = kzalloc(sizeof(*arch_timer_mem), GFP_KERNEL);
+	if (!arch_timer_mem)
 		return -ENOMEM;
 
-	t->base = base;
-	t->evt.irq = irq;
-	__arch_timer_setup(ARCH_TIMER_TYPE_MEM, &t->evt);
+	arch_timer_mem->base = base;
+	arch_timer_mem->evt.irq = irq;
+	__arch_timer_setup(ARCH_TIMER_TYPE_MEM, &arch_timer_mem->evt);
 
 	if (arch_timer_mem_use_virtual)
 		func = arch_timer_handler_virt_mem;
 	else
 		func = arch_timer_handler_phys_mem;
 
-	ret = request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &t->evt);
+	ret = request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &arch_timer_mem->evt);
 	if (ret) {
 		pr_err("Failed to request mem timer irq\n");
-		kfree(t);
+		kfree(arch_timer_mem);
+		arch_timer_mem = NULL;
 	}
 
 	return ret;
@@ -1442,7 +1442,6 @@ arch_timer_mem_frame_register(struct arch_timer_mem_frame *frame)
 		return ret;
 	}
 
-	arch_counter_base = base;
 	arch_timers_present |= ARCH_TIMER_TYPE_MEM;
 
 	return 0;
