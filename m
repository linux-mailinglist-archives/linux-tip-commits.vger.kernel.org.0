Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A204389FD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Oct 2021 17:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhJXPmY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Oct 2021 11:42:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49296 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhJXPmW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Oct 2021 11:42:22 -0400
Date:   Sun, 24 Oct 2021 15:39:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635090000;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTr1gD/kA+g3tFNw7w7e2cHygMPHH7OvR9pLYFS853s=;
        b=NkV42+VbqboTlxRPrCfTUl81w/2yOJ8Arqc0K1zBZnowln/k5X6nzsSfVku4YjRMnOiC0Q
        DcCBXKECLZeutIZSnPlPFfzeI58SYsczAf+uI21i2LuCcUXxlltsgKtFdOo1f8G7BZJD8+
        PwQ6xDZrTX62lNsQMho/kIFud4MK0Cnp/KpbmT/LgguARQ34JyvHnUdYY1YDDsTQdVV++M
        VroSvGMtkgnxTa5745QzK5GQnv0Plgq4225x6pqE18e2yxGjcLIO1y6eRzo45HDUD9R4PB
        FexG+UXWj4cAw5ToYQUGKu4lNVM6lbDhh4mpqmN8sUdf5FrW4iCwbASxjUEoUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635090000;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTr1gD/kA+g3tFNw7w7e2cHygMPHH7OvR9pLYFS853s=;
        b=n0KlgvHJKRMBDxreCd5s1cKRAgBLqfg1Z9mjcEMxjdp2CR6Jtx3nMED75FxZt6Neh4hta6
        77rgf2Ic6AJq3rAw==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Drop
 unnecessary ISB on CVAL programming
Cc:     Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211017124225.3018098-12-maz@kernel.org>
References: <20211017124225.3018098-12-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163508999973.626.6510756085416837493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ec8f7f3342c88780d682cc2464daf0fe43259c4f
Gitweb:        https://git.kernel.org/tip/ec8f7f3342c88780d682cc2464daf0fe43259c4f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 17 Oct 2021 13:42:19 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 17 Oct 2021 21:47:44 +02:00

clocksource/drivers/arm_arch_timer: Drop unnecessary ISB on CVAL programming

Switching from TVAL to CVAL has a small drawback: we need an ISB
before reading the counter. We cannot get rid of it, but we can
instead remove the one that comes just after writing to CVAL.

This reduces the number of ISBs from 3 to 2 when programming
the timer.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211017124225.3018098-12-maz@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/include/asm/arch_timer.h   | 4 ++--
 arch/arm64/include/asm/arch_timer.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 9f4b895..bb129b6 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -31,6 +31,7 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" ((u32)val));
+			isb();
 			break;
 		case ARCH_TIMER_REG_CVAL:
 			asm volatile("mcrr p15, 2, %Q0, %R0, c14" : : "r" (val));
@@ -42,6 +43,7 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" ((u32)val));
+			isb();
 			break;
 		case ARCH_TIMER_REG_CVAL:
 			asm volatile("mcrr p15, 3, %Q0, %R0, c14" : : "r" (val));
@@ -52,8 +54,6 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 	} else {
 		BUILD_BUG();
 	}
-
-	isb();
 }
 
 static __always_inline
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 4f4aa13..b8000ef 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -95,6 +95,7 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			write_sysreg(val, cntp_ctl_el0);
+			isb();
 			break;
 		case ARCH_TIMER_REG_CVAL:
 			write_sysreg(val, cntp_cval_el0);
@@ -106,6 +107,7 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			write_sysreg(val, cntv_ctl_el0);
+			isb();
 			break;
 		case ARCH_TIMER_REG_CVAL:
 			write_sysreg(val, cntv_cval_el0);
@@ -116,8 +118,6 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 	} else {
 		BUILD_BUG();
 	}
-
-	isb();
 }
 
 static __always_inline
