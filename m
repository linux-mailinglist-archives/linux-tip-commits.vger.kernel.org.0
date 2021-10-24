Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34D54389FB
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Oct 2021 17:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhJXPmX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Oct 2021 11:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhJXPmW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Oct 2021 11:42:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E84C061764;
        Sun, 24 Oct 2021 08:40:01 -0700 (PDT)
Date:   Sun, 24 Oct 2021 15:39:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635090000;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7szFJThxGwNXMsuYN2mc7IRV7ZJA9gCMMTMkB0rbC4s=;
        b=ePbDdtc0bxjYSU6CHruw9VsBh+7u2DAu/qCPhItaslnRD97dhyqATpzs+qHpSZOAc3wpUv
        E5kCWziHXWr6o5traaECkHDg8xTwAy8SXOajD+l3mspD5Mu2Rzi10prUVK5W58CTcyBYqr
        snXP1ogLvyAS/+vX2wLFaLqN3gI/uIF/nBlcO0naJSYarJXoyajnhxlEcCkZMleuoXeVAt
        R2TXkC1s84jWGB1apu7LapWEuXmQ+chEouoXBWEU7DXX18Equ6FEtmD96uW4p5teLYcVo4
        XxlLNQpkxH1LuEXVcKAqVSMQ0nu2qtOojr1GYdTlly8s2cfvStgqjBzVKy12pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635090000;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7szFJThxGwNXMsuYN2mc7IRV7ZJA9gCMMTMkB0rbC4s=;
        b=bMHKbKcTOMROiiJJ2bpXeBUfuT70gTEM3e79Nnt4q7YAiMue1UEP5bQcxcRBVyM4dRnvGl
        ddtyxgQ9eaX4cqAQ==
From:   "tip-bot2 for Oliver Upton" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Fix masking
 for high freq counters
Cc:     Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210807191428.3488948-1-oupton@google.com>
References: <20210807191428.3488948-1-oupton@google.com>
MIME-Version: 1.0
Message-ID: <163508999905.626.14613108278482809454.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c1153d52c4140424a5e31a5916fca3edd91fe13a
Gitweb:        https://git.kernel.org/tip/c1153d52c4140424a5e31a5916fca3edd91fe13a
Author:        Oliver Upton <oupton@google.com>
AuthorDate:    Sun, 17 Oct 2021 13:42:20 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 18 Oct 2021 09:20:02 +02:00

clocksource/drivers/arm_arch_timer: Fix masking for high freq counters

Unfortunately, the architecture provides no means to determine the bit
width of the system counter. However, we do know the following from the
specification:

 - the system counter is at least 56 bits wide
 - Roll-over time of not less than 40 years

To date, the arch timer driver has depended on the first property,
assuming any system counter to be 56 bits wide and masking off the rest.
However, combining a narrow clocksource mask with a high frequency
counter could result in prematurely wrapping the system counter by a
significant margin. For example, a 56 bit wide, 1GHz system counter
would wrap in a mere 2.28 years!

This is a problem for two reasons: v8.6+ implementations are required to
provide a 64 bit, 1GHz system counter. Furthermore, before v8.6,
implementers may select a counter frequency of their choosing.

Fix the issue by deriving a valid clock mask based on the second
property from above. Set the floor at 56 bits, since we know no system
counter is narrower than that.

[maz: fixed width computation not to lose the last bit, added
      max delta generation for the timer]

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Oliver Upton <oupton@google.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210807191428.3488948-1-oupton@google.com
Link: https://lore.kernel.org/r/20211017124225.3018098-13-maz@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 34 +++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 6e20bc1..9a04eac 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -52,6 +52,12 @@
 #define CNTV_CVAL_LO	0x30
 #define CNTV_CTL	0x3c
 
+/*
+ * The minimum amount of time a generic counter is guaranteed to not roll over
+ * (40 years)
+ */
+#define MIN_ROLLOVER_SECS	(40ULL * 365 * 24 * 3600)
+
 static unsigned arch_timers_present __initdata;
 
 struct arch_timer {
@@ -96,6 +102,22 @@ static int __init early_evtstrm_cfg(char *buf)
 early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
 
 /*
+ * Makes an educated guess at a valid counter width based on the Generic Timer
+ * specification. Of note:
+ *   1) the system counter is at least 56 bits wide
+ *   2) a roll-over time of not less than 40 years
+ *
+ * See 'ARM DDI 0487G.a D11.1.2 ("The system counter")' for more details.
+ */
+static int arch_counter_get_width(void)
+{
+	u64 min_cycles = MIN_ROLLOVER_SECS * arch_timer_rate;
+
+	/* guarantee the returned width is within the valid range */
+	return clamp_val(ilog2(min_cycles - 1) + 1, 56, 64);
+}
+
+/*
  * Architected system timer support.
  */
 
@@ -212,13 +234,11 @@ static struct clocksource clocksource_counter = {
 	.id	= CSID_ARM_ARCH_COUNTER,
 	.rating	= 400,
 	.read	= arch_counter_read,
-	.mask	= CLOCKSOURCE_MASK(56),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
 static struct cyclecounter cyclecounter __ro_after_init = {
 	.read	= arch_counter_read_cc,
-	.mask	= CLOCKSOURCE_MASK(56),
 };
 
 struct ate_acpi_oem_info {
@@ -790,7 +810,7 @@ static u64 __arch_timer_check_delta(void)
 		return CLOCKSOURCE_MASK(32);
 	}
 #endif
-	return CLOCKSOURCE_MASK(56);
+	return CLOCKSOURCE_MASK(arch_counter_get_width());
 }
 
 static void __arch_timer_setup(unsigned type,
@@ -1035,6 +1055,7 @@ struct arch_timer_kvm_info *arch_timer_get_kvm_info(void)
 static void __init arch_counter_register(unsigned type)
 {
 	u64 start_count;
+	int width;
 
 	/* Register the CP15 based counter if we have one */
 	if (type & ARCH_TIMER_TYPE_CP15) {
@@ -1059,6 +1080,10 @@ static void __init arch_counter_register(unsigned type)
 		arch_timer_read_counter = arch_counter_get_cntvct_mem;
 	}
 
+	width = arch_counter_get_width();
+	clocksource_counter.mask = CLOCKSOURCE_MASK(width);
+	cyclecounter.mask = CLOCKSOURCE_MASK(width);
+
 	if (!arch_counter_suspend_stop)
 		clocksource_counter.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
 	start_count = arch_timer_read_counter();
@@ -1068,8 +1093,7 @@ static void __init arch_counter_register(unsigned type)
 	timecounter_init(&arch_timer_kvm_info.timecounter,
 			 &cyclecounter, start_count);
 
-	/* 56 bits minimum, so we assume worst case rollover */
-	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
+	sched_clock_register(arch_timer_read_counter, width, arch_timer_rate);
 }
 
 static void arch_timer_stop(struct clock_event_device *clk)
