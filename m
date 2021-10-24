Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FF2438A07
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Oct 2021 17:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhJXPme (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Oct 2021 11:42:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49318 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhJXPm1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Oct 2021 11:42:27 -0400
Date:   Sun, 24 Oct 2021 15:40:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635090006;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JbNbLpN9+9hbLKg+pJdybMyQ44tJ4s4IO2qisW99+Bc=;
        b=o+Ew2HyGXQpNH92yiIX3d2bNYawBrXazUkA/Q4lz0OVH2yeqqDzNxX1AoSp0/Plqu7f/46
        /phIru2pVFlEpWkWE9yH6TTxCoBJcaMQdtp8riOtZvaJKQw3Spqnsc1Lt04n6yoYs1wV2a
        lj0/IYDXTh4bN6g8IpUWgGSPBZzsWYm2BdggHFMFVZfcWJn4zmRTb4ujOMvA1KWxvwkYcj
        9A+l87pGWUXYYsgnwkZSsoPGhE1JyFA/MgHS9gLed8yJbqLlKUX+UNqZztwSTLR0a8Mbnp
        CvygvhtVEQfZWIP13rFO6HMVIrPHpY+wmjYQj2X8Oc5v9Wok98SUOX8JCX9AsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635090006;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JbNbLpN9+9hbLKg+pJdybMyQ44tJ4s4IO2qisW99+Bc=;
        b=tDN8SRlGnckoiNdEuu/T2XuNMOyks5gVzAZ3kPBt5MpIxM7X98tDVpcupVIkSP6AgUZn7W
        CYs8APOW9xd6gkCw==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Extend write
 side of timer register accessors to u64
Cc:     Oliver Upton <oupton@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211017124225.3018098-4-maz@kernel.org>
References: <20211017124225.3018098-4-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163509000526.626.2230118562135078800.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1e8d929231cf7b397101c5e6aaaa3d9bc9832f10
Gitweb:        https://git.kernel.org/tip/1e8d929231cf7b397101c5e6aaaa3d9bc9832f10
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 17 Oct 2021 13:42:11 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 17 Oct 2021 21:46:59 +02:00

clocksource/drivers/arm_arch_timer: Extend write side of timer register accessors to u64

The various accessors for the timer sysreg and MMIO registers are
currently hardwired to 32bit. However, we are about to introduce
the use of the CVAL registers, which require a 64bit access.

Upgrade the write side of the accessors to take a 64bit value
(the read side is left untouched as we don't plan to ever read
back any of these registers).

No functional change expected.

Reviewed-by: Oliver Upton <oupton@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211017124225.3018098-4-maz@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/include/asm/arch_timer.h    | 10 +++++-----
 arch/arm64/include/asm/arch_timer.h  |  2 +-
 drivers/clocksource/arm_arch_timer.c | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 7d75708..1482e70 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -24,15 +24,15 @@ int arch_timer_arch_init(void);
  * the code. At least it does so with a recent GCC (4.6.3).
  */
 static __always_inline
-void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
+void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 {
 	if (access == ARCH_TIMER_PHYS_ACCESS) {
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
-			asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" (val));
+			asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" ((u32)val));
 			break;
 		case ARCH_TIMER_REG_TVAL:
-			asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" (val));
+			asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" ((u32)val));
 			break;
 		default:
 			BUILD_BUG();
@@ -40,10 +40,10 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
 	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
-			asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" (val));
+			asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" ((u32)val));
 			break;
 		case ARCH_TIMER_REG_TVAL:
-			asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" (val));
+			asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" ((u32)val));
 			break;
 		default:
 			BUILD_BUG();
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 8332fcf..43f827b 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -89,7 +89,7 @@ static inline notrace u64 arch_timer_read_cntvct_el0(void)
  * the code.
  */
 static __always_inline
-void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
+void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 {
 	if (access == ARCH_TIMER_PHYS_ACCESS) {
 		switch (reg) {
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 67bdc72..a49bcef 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -100,17 +100,17 @@ early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
  */
 
 static __always_inline
-void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
+void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
 			  struct clock_event_device *clk)
 {
 	if (access == ARCH_TIMER_MEM_PHYS_ACCESS) {
 		struct arch_timer *timer = to_arch_timer(clk);
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
-			writel_relaxed(val, timer->base + CNTP_CTL);
+			writel_relaxed((u32)val, timer->base + CNTP_CTL);
 			break;
 		case ARCH_TIMER_REG_TVAL:
-			writel_relaxed(val, timer->base + CNTP_TVAL);
+			writel_relaxed((u32)val, timer->base + CNTP_TVAL);
 			break;
 		default:
 			BUILD_BUG();
@@ -119,10 +119,10 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
 		struct arch_timer *timer = to_arch_timer(clk);
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
-			writel_relaxed(val, timer->base + CNTV_CTL);
+			writel_relaxed((u32)val, timer->base + CNTV_CTL);
 			break;
 		case ARCH_TIMER_REG_TVAL:
-			writel_relaxed(val, timer->base + CNTV_TVAL);
+			writel_relaxed((u32)val, timer->base + CNTV_TVAL);
 			break;
 		default:
 			BUILD_BUG();
