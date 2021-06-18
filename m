Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284013ACFB5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 18:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhFRQF5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 12:05:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57418 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbhFRQFy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 12:05:54 -0400
Date:   Fri, 18 Jun 2021 16:03:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624032224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csYDDTxqqcFbug0K46MJZVaaoNyFdNrrAOf+S7nZVN4=;
        b=dFK31Rv3LLWkRYRnmt73bfSiMba2D4mRUK+wrvYdpiF9qFQwQ1B1AQmqbgpMXZNoTLJ0Zf
        uePkfl3d+/PEw3qhr2g+++oeBtQVKA1tlKmHIUp8if71v5bpuaNcjhk8kPpY3VXkaDhtow
        GlBIZ3fv02bNLDlPNBh0CZ6RgMPiCKcmrVZ8Lf/QaibNYvr3qjyR4qJ8aJy2cRWZOpD4HJ
        ri9vO+tpDHetwPJWK/S1DcMMXIODyDjfSftwjNU8wOs7R5jFWg3rQ3haH6SaRu/2CvVESb
        NEGXJ+W9atWdtsDTiabFLyD1unVt2UgbsrUr9Baff0aF/ta0QNoLF9lBMrt6ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624032224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csYDDTxqqcFbug0K46MJZVaaoNyFdNrrAOf+S7nZVN4=;
        b=ALhGl0OZXz01aMo73HhbL3t6BUZ0liUauoasYS+bhBbdfn6qqE0xTXbVWvwZg9ieXZq4b9
        AlnnAl5ULzEEweCg==
From:   "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/samsung_pwm: Minor whitespace cleanup
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506202729.157260-1-krzysztof.kozlowski@canonical.com>
References: <20210506202729.157260-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Message-ID: <162403222337.19906.3721651976027741839.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a0143f5ac0594d73ef91c2336d8172217ff9cd72
Gitweb:        https://git.kernel.org/tip/a0143f5ac0594d73ef91c2336d8172217ff9cd72
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
AuthorDate:    Thu, 06 May 2021 16:27:25 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 04 Jun 2021 10:12:10 +02:00

clocksource/drivers/samsung_pwm: Minor whitespace cleanup

Cleanup the code to be slightly more readable and follow coding
convention - only whitespace.  This fixes checkpatch warnings:

  WARNING: Block comments should align the * on each line
  WARNING: please, no space before tabs
  WARNING: Missing a blank line after declarations
  CHECK: Alignment should match open parenthesis

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210506202729.157260-1-krzysztof.kozlowski@canonical.com
---
 drivers/clocksource/samsung_pwm_timer.c | 19 +++++++++++--------
 include/clocksource/samsung_pwm.h       |  3 ++-
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index f760229..69bf79c 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -4,7 +4,7 @@
  *		http://www.samsung.com/
  *
  * samsung - Common hr-timer support (s3c and s5p)
-*/
+ */
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -22,7 +22,6 @@
 
 #include <clocksource/samsung_pwm.h>
 
-
 /*
  * Clocksource driver
  */
@@ -38,8 +37,8 @@
 #define TCFG0_PRESCALER_MASK		0xff
 #define TCFG0_PRESCALER1_SHIFT		8
 
-#define TCFG1_SHIFT(x)	  		((x) * 4)
-#define TCFG1_MUX_MASK	  		0xf
+#define TCFG1_SHIFT(x)			((x) * 4)
+#define TCFG1_MUX_MASK			0xf
 
 /*
  * Each channel occupies 4 bits in TCON register, but there is a gap of 4
@@ -183,7 +182,7 @@ static void samsung_time_start(unsigned int channel, bool periodic)
 }
 
 static int samsung_set_next_event(unsigned long cycles,
-				struct clock_event_device *evt)
+				  struct clock_event_device *evt)
 {
 	/*
 	 * This check is needed to account for internal rounding
@@ -225,6 +224,7 @@ static void samsung_clockevent_resume(struct clock_event_device *cev)
 
 	if (pwm.variant.has_tint_cstat) {
 		u32 mask = (1 << pwm.event_id);
+
 		writel(mask | (mask << 5), pwm.base + REG_TINT_CSTAT);
 	}
 }
@@ -248,6 +248,7 @@ static irqreturn_t samsung_clock_event_isr(int irq, void *dev_id)
 
 	if (pwm.variant.has_tint_cstat) {
 		u32 mask = (1 << pwm.event_id);
+
 		writel(mask | (mask << 5), pwm.base + REG_TINT_CSTAT);
 	}
 
@@ -272,7 +273,7 @@ static void __init samsung_clockevent_init(void)
 
 	time_event_device.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&time_event_device,
-						clock_rate, 1, pwm.tcnt_max);
+					clock_rate, 1, pwm.tcnt_max);
 
 	irq_number = pwm.irq[pwm.event_id];
 	if (request_irq(irq_number, samsung_clock_event_isr,
@@ -282,6 +283,7 @@ static void __init samsung_clockevent_init(void)
 
 	if (pwm.variant.has_tint_cstat) {
 		u32 mask = (1 << pwm.event_id);
+
 		writel(mask | (mask << 5), pwm.base + REG_TINT_CSTAT);
 	}
 }
@@ -347,7 +349,7 @@ static int __init samsung_clocksource_init(void)
 		pwm.source_reg = pwm.base + pwm.source_id * 0x0c + 0x14;
 
 	sched_clock_register(samsung_read_sched_clock,
-						pwm.variant.bits, clock_rate);
+			     pwm.variant.bits, clock_rate);
 
 	samsung_clocksource.mask = CLOCKSOURCE_MASK(pwm.variant.bits);
 	return clocksource_register_hz(&samsung_clocksource, clock_rate);
@@ -398,7 +400,8 @@ static int __init _samsung_pwm_clocksource_init(void)
 }
 
 void __init samsung_pwm_clocksource_init(void __iomem *base,
-			unsigned int *irqs, struct samsung_pwm_variant *variant)
+					 unsigned int *irqs,
+					 struct samsung_pwm_variant *variant)
 {
 	pwm.base = base;
 	memcpy(&pwm.variant, variant, sizeof(pwm.variant));
diff --git a/include/clocksource/samsung_pwm.h b/include/clocksource/samsung_pwm.h
index c395238..7634198 100644
--- a/include/clocksource/samsung_pwm.h
+++ b/include/clocksource/samsung_pwm.h
@@ -27,6 +27,7 @@ struct samsung_pwm_variant {
 };
 
 void samsung_pwm_clocksource_init(void __iomem *base,
-		unsigned int *irqs, struct samsung_pwm_variant *variant);
+				  unsigned int *irqs,
+				  struct samsung_pwm_variant *variant);
 
 #endif /* __CLOCKSOURCE_SAMSUNG_PWM_H */
