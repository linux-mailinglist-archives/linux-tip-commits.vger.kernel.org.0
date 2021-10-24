Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449EB438A06
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Oct 2021 17:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhJXPmc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Oct 2021 11:42:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49310 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhJXPm1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Oct 2021 11:42:27 -0400
Date:   Sun, 24 Oct 2021 15:40:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635090005;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aiqg8bunttRuBlM52xX/mBM6Kuoy+B1PzJt+jiQfbk0=;
        b=sdhiXS88HAAeJ94Y69+o8kGD4YZnstFNosqSa5MocozWFMrNis83vEadvjf/ckYwtipy+o
        kJvDdvRjuBCkk//KxClr6ppvZc+qPW2zrNyi1w7DFQv57lvRY5m77y0MmrS9T589Vsq+Y4
        RLWAutQg5s/W+f4gZ3Ub1gk5+wu9lSxRM1FRwYs7KASSq9T5W+kW7MfuMyBf/hzKuFUQht
        o5FLruhCH7kMgLY997aqEFSxE/Fj8dIVQHvH8UpEKE5tbZ5SV+Y9VqYF8GbOMTW1d6tu9X
        sjDxdvoEDMq1ZmOoSZgDuAYnJJo6s/0ywRUm95zaaw4ej2fslPCiVNI96D0Syg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635090005;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aiqg8bunttRuBlM52xX/mBM6Kuoy+B1PzJt+jiQfbk0=;
        b=8+nThB7TRv+sZczxxCI4rLs7R2ti33tURyTuW9Tv7J3MxkK20SG4h7XFBBV00Sl++9lIRJ
        rhFXnQubvIFyPeAg==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Move system
 register timer programming over to CVAL
Cc:     Oliver Upton <oupton@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211017124225.3018098-5-maz@kernel.org>
References: <20211017124225.3018098-5-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163509000458.626.1487368951316888954.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a38b71b0833eb2fabd2b1fa37d665c0a88b8b7e4
Gitweb:        https://git.kernel.org/tip/a38b71b0833eb2fabd2b1fa37d665c0a88b8b7e4
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 17 Oct 2021 13:42:12 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 17 Oct 2021 21:47:05 +02:00

clocksource/drivers/arm_arch_timer: Move system register timer programming over to CVAL

In order to cope better with high frequency counters, move the
programming of the timers from the countdown timer (TVAL) over
to the comparator (CVAL).

The programming model is slightly different, as we now need to
read the current counter value to have an absolute deadline
instead of a relative one.

There is a small overhead to this change, which we will address
in the following patches.

Reviewed-by: Oliver Upton <oupton@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211017124225.3018098-5-maz@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/include/asm/arch_timer.h    |  8 ++++----
 arch/arm64/include/asm/arch_timer.h  | 10 +++++-----
 drivers/clocksource/arm_arch_timer.c | 26 +++++++++++++++++++++++---
 include/clocksource/arm_arch_timer.h |  1 +
 4 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 1482e70..a9b2b72 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -31,8 +31,8 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		case ARCH_TIMER_REG_CTRL:
 			asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" ((u32)val));
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" ((u32)val));
+		case ARCH_TIMER_REG_CVAL:
+			asm volatile("mcrr p15, 2, %Q0, %R0, c14" : : "r" (val));
 			break;
 		default:
 			BUILD_BUG();
@@ -42,8 +42,8 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		case ARCH_TIMER_REG_CTRL:
 			asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" ((u32)val));
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" ((u32)val));
+		case ARCH_TIMER_REG_CVAL:
+			asm volatile("mcrr p15, 3, %Q0, %R0, c14" : : "r" (val));
 			break;
 		default:
 			BUILD_BUG();
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 43f827b..4f4aa13 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -96,8 +96,8 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		case ARCH_TIMER_REG_CTRL:
 			write_sysreg(val, cntp_ctl_el0);
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			write_sysreg(val, cntp_tval_el0);
+		case ARCH_TIMER_REG_CVAL:
+			write_sysreg(val, cntp_cval_el0);
 			break;
 		default:
 			BUILD_BUG();
@@ -107,8 +107,8 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		case ARCH_TIMER_REG_CTRL:
 			write_sysreg(val, cntv_ctl_el0);
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			write_sysreg(val, cntv_tval_el0);
+		case ARCH_TIMER_REG_CVAL:
+			write_sysreg(val, cntv_cval_el0);
 			break;
 		default:
 			BUILD_BUG();
@@ -121,7 +121,7 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 }
 
 static __always_inline
-u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
+u64 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 {
 	if (access == ARCH_TIMER_PHYS_ACCESS) {
 		switch (reg) {
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index a49bcef..3221654 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -691,10 +691,18 @@ static __always_inline void set_next_event(const int access, unsigned long evt,
 					   struct clock_event_device *clk)
 {
 	unsigned long ctrl;
+	u64 cnt;
+
 	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
 	ctrl |= ARCH_TIMER_CTRL_ENABLE;
 	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
-	arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL, evt, clk);
+
+	if (access == ARCH_TIMER_PHYS_ACCESS)
+		cnt = __arch_counter_get_cntpct();
+	else
+		cnt = __arch_counter_get_cntvct();
+
+	arch_timer_reg_write(access, ARCH_TIMER_REG_CVAL, evt + cnt, clk);
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }
 
@@ -712,17 +720,29 @@ static int arch_timer_set_next_event_phys(unsigned long evt,
 	return 0;
 }
 
+static __always_inline void set_next_event_mem(const int access, unsigned long evt,
+					   struct clock_event_device *clk)
+{
+	unsigned long ctrl;
+	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
+	ctrl |= ARCH_TIMER_CTRL_ENABLE;
+	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
+
+	arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL, evt, clk);
+	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
+}
+
 static int arch_timer_set_next_event_virt_mem(unsigned long evt,
 					      struct clock_event_device *clk)
 {
-	set_next_event(ARCH_TIMER_MEM_VIRT_ACCESS, evt, clk);
+	set_next_event_mem(ARCH_TIMER_MEM_VIRT_ACCESS, evt, clk);
 	return 0;
 }
 
 static int arch_timer_set_next_event_phys_mem(unsigned long evt,
 					      struct clock_event_device *clk)
 {
-	set_next_event(ARCH_TIMER_MEM_PHYS_ACCESS, evt, clk);
+	set_next_event_mem(ARCH_TIMER_MEM_PHYS_ACCESS, evt, clk);
 	return 0;
 }
 
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 73c7139..d59537a 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -25,6 +25,7 @@
 enum arch_timer_reg {
 	ARCH_TIMER_REG_CTRL,
 	ARCH_TIMER_REG_TVAL,
+	ARCH_TIMER_REG_CVAL,
 };
 
 enum arch_timer_ppi_nr {
