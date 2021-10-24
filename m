Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0E1438A01
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Oct 2021 17:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhJXPm1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Oct 2021 11:42:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49318 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhJXPmZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Oct 2021 11:42:25 -0400
Date:   Sun, 24 Oct 2021 15:40:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635090003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9eJO3SkzJoXedi7ZJIj/Q9MrwXOxsQSvUdXtfubanlI=;
        b=rHHjdpxO9J7S0U3NYqZiTOjKfYT5xZZObmLmWYwWSx1F1HnRb9l/fOthJYklMbBgLkxIvn
        5ZD3abFCU1mA5nqzk6WMM65l8HTJjwGXvaVJsqKZAOIMv3DjWegx/81yFYp9Jr/GEQFJ2e
        ruhFyjOk9rp+jVYSFwvvIeAy+g+AxWO+QisWvcNHh1O6MCNz4c5t7EG6CBmZgw/qNch+l/
        Pu86WINR7cUcrp3ahXDisgQjzU0O8Raaf+dDxBAzycfLqDVnzA/Wo28jDr1YQqI4i9C08U
        LvntyeSuxUPhe1Wbd0JzI2wNl9j9RnWBgnE4nexj4Q6BCMTHBFqef6QtKYF59Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635090003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9eJO3SkzJoXedi7ZJIj/Q9MrwXOxsQSvUdXtfubanlI=;
        b=FKZ0wxsrfcFEPOi9QnlvJ5TATvh6MpHPaqCDdf1gbfd5/eyTxu5a0M5Ek+rcQvEpFr7eJE
        gY1r1rUmosAQDoBA==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Move MMIO
 timer programming over to CVAL
Cc:     Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211017124225.3018098-8-maz@kernel.org>
References: <20211017124225.3018098-8-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163509000248.626.5257507099113316820.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8b82c4f883a7b22660464c0232fbdb7a6deb3061
Gitweb:        https://git.kernel.org/tip/8b82c4f883a7b22660464c0232fbdb7a6deb3061
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 17 Oct 2021 13:42:15 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 17 Oct 2021 21:47:21 +02:00

clocksource/drivers/arm_arch_timer: Move MMIO timer programming over to CVAL

Similarily to the sysreg-based timer, move the MMIO over to using
the CVAL registers instead of TVAL. Note that there is no warranty
that the 64bit MMIO access will be atomic, but the timer is always
disabled at the point where we program CVAL.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211017124225.3018098-8-maz@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/include/asm/arch_timer.h    |  1 +-
 drivers/clocksource/arm_arch_timer.c | 50 ++++++++++++++++++++-------
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index a9b2b72..9f4b895 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -7,6 +7,7 @@
 #include <asm/hwcap.h>
 #include <linux/clocksource.h>
 #include <linux/init.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/types.h>
 
 #include <clocksource/arm_arch_timer.h>
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index bede10f..f4db3a6 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -44,11 +44,13 @@
 #define CNTACR_RWVT	BIT(4)
 #define CNTACR_RWPT	BIT(5)
 
-#define CNTVCT_LO	0x08
-#define CNTVCT_HI	0x0c
+#define CNTVCT_LO	0x00
+#define CNTPCT_LO	0x08
 #define CNTFRQ		0x10
+#define CNTP_CVAL_LO	0x20
 #define CNTP_TVAL	0x28
 #define CNTP_CTL	0x2c
+#define CNTV_CVAL_LO	0x30
 #define CNTV_TVAL	0x38
 #define CNTV_CTL	0x3c
 
@@ -112,6 +114,13 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
 		case ARCH_TIMER_REG_TVAL:
 			writel_relaxed((u32)val, timer->base + CNTP_TVAL);
 			break;
+		case ARCH_TIMER_REG_CVAL:
+			/*
+			 * Not guaranteed to be atomic, so the timer
+			 * must be disabled at this point.
+			 */
+			writeq_relaxed(val, timer->base + CNTP_CVAL_LO);
+			break;
 		default:
 			BUILD_BUG();
 		}
@@ -124,6 +133,10 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
 		case ARCH_TIMER_REG_TVAL:
 			writel_relaxed((u32)val, timer->base + CNTV_TVAL);
 			break;
+		case ARCH_TIMER_REG_CVAL:
+			/* Same restriction as above */
+			writeq_relaxed(val, timer->base + CNTV_CVAL_LO);
+			break;
 		default:
 			BUILD_BUG();
 		}
@@ -720,15 +733,36 @@ static int arch_timer_set_next_event_phys(unsigned long evt,
 	return 0;
 }
 
+static u64 arch_counter_get_cnt_mem(struct arch_timer *t, int offset_lo)
+{
+	u32 cnt_lo, cnt_hi, tmp_hi;
+
+	do {
+		cnt_hi = readl_relaxed(t->base + offset_lo + 4);
+		cnt_lo = readl_relaxed(t->base + offset_lo);
+		tmp_hi = readl_relaxed(t->base + offset_lo + 4);
+	} while (cnt_hi != tmp_hi);
+
+	return ((u64) cnt_hi << 32) | cnt_lo;
+}
+
 static __always_inline void set_next_event_mem(const int access, unsigned long evt,
 					   struct clock_event_device *clk)
 {
+	struct arch_timer *timer = to_arch_timer(clk);
 	unsigned long ctrl;
+	u64 cnt;
+
 	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
 	ctrl |= ARCH_TIMER_CTRL_ENABLE;
 	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
 
-	arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL, evt, clk);
+	if (access ==  ARCH_TIMER_MEM_VIRT_ACCESS)
+		cnt = arch_counter_get_cnt_mem(timer, CNTVCT_LO);
+	else
+		cnt = arch_counter_get_cnt_mem(timer, CNTPCT_LO);
+
+	arch_timer_reg_write(access, ARCH_TIMER_REG_CVAL, evt + cnt, clk);
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }
 
@@ -970,15 +1004,7 @@ bool arch_timer_evtstrm_available(void)
 
 static u64 arch_counter_get_cntvct_mem(void)
 {
-	u32 vct_lo, vct_hi, tmp_hi;
-
-	do {
-		vct_hi = readl_relaxed(arch_timer_mem->base + CNTVCT_HI);
-		vct_lo = readl_relaxed(arch_timer_mem->base + CNTVCT_LO);
-		tmp_hi = readl_relaxed(arch_timer_mem->base + CNTVCT_HI);
-	} while (vct_hi != tmp_hi);
-
-	return ((u64) vct_hi << 32) | vct_lo;
+	return arch_counter_get_cnt_mem(arch_timer_mem, CNTVCT_LO);
 }
 
 static struct arch_timer_kvm_info arch_timer_kvm_info;
