Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DEE438A0B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Oct 2021 17:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhJXPmk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Oct 2021 11:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbhJXPm3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Oct 2021 11:42:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0889C061348;
        Sun, 24 Oct 2021 08:40:08 -0700 (PDT)
Date:   Sun, 24 Oct 2021 15:40:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635090007;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BV7vZJ5RAy20+J6HxbOnMnqQ+ewopAswGbOJ+9G2qFo=;
        b=dIvhVurt1UBW+0kYWQzbZs6cmoWdyDz1iDMz/RGdODZJYoeXFbfyEkhF+NshKKwIkWy48M
        Klr7ZMuhYaaKWfWKu+aOy/nm0kQqnRCQL+hFo7rznebkzyuMuOCNH4HLH2wZwBeoc15ElG
        owviWnJn5cva/k+gOQk6EfwnOTeyy4fy8zC1hJyeN4nqGIH2tanZNukQASclO6wxNOwFvm
        u+ZSJ8Sag3+6ZYPgk0kI84+vGyh9t5yo0/WVvtqizvnnO7y2fBHXtf9PcmvY1hbQDxpoVn
        bHLtvPvN9wCRgqOSTV0DCfEmmYJ4rsbHSVC5fJKItch4GW66UAJvH76o8zGTvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635090007;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BV7vZJ5RAy20+J6HxbOnMnqQ+ewopAswGbOJ+9G2qFo=;
        b=e2qw4szCAkgw3TunW57/rfc1YV+lc8/gDBp0sccituhFLFkyLi7HM+YgM3Tfm9n7xVpCin
        e8Nl+rsIdRqyBiAw==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/arm_arch_timer: Add build-time guards
 for unhandled register accesses
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211017124225.3018098-2-maz@kernel.org>
References: <20211017124225.3018098-2-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163509000666.626.6472069643484764782.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4775bc63f880001ee4fbd6456b12ab04674149e3
Gitweb:        https://git.kernel.org/tip/4775bc63f880001ee4fbd6456b12ab04674149e3
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 17 Oct 2021 13:42:09 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 17 Oct 2021 21:45:48 +02:00

clocksource/arm_arch_timer: Add build-time guards for unhandled register accesses

As we are about to change the registers that are used by the driver,
start by adding build-time checks to ensure that we always handle
all registers and access modes.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211017124225.3018098-2-maz@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/include/asm/arch_timer.h    | 12 ++++++++++++
 arch/arm64/include/asm/arch_timer.h  | 13 ++++++++++++-
 drivers/clocksource/arm_arch_timer.c |  8 ++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 9917581..a5d27cf 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -34,6 +34,8 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
 		case ARCH_TIMER_REG_TVAL:
 			asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" (val));
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
 		switch (reg) {
@@ -43,7 +45,11 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
 		case ARCH_TIMER_REG_TVAL:
 			asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" (val));
 			break;
+		default:
+			BUILD_BUG();
 		}
+	} else {
+		BUILD_BUG();
 	}
 
 	isb();
@@ -62,6 +68,8 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 		case ARCH_TIMER_REG_TVAL:
 			asm volatile("mrc p15, 0, %0, c14, c2, 0" : "=r" (val));
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
 		switch (reg) {
@@ -71,7 +79,11 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 		case ARCH_TIMER_REG_TVAL:
 			asm volatile("mrc p15, 0, %0, c14, c3, 0" : "=r" (val));
 			break;
+		default:
+			BUILD_BUG();
 		}
+	} else {
+		BUILD_BUG();
 	}
 
 	return val;
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 88d20f0..fa12ea4 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -112,6 +112,8 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
 		case ARCH_TIMER_REG_TVAL:
 			write_sysreg(val, cntp_tval_el0);
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
 		switch (reg) {
@@ -121,7 +123,11 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
 		case ARCH_TIMER_REG_TVAL:
 			write_sysreg(val, cntv_tval_el0);
 			break;
+		default:
+			BUILD_BUG();
 		}
+	} else {
+		BUILD_BUG();
 	}
 
 	isb();
@@ -136,6 +142,8 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 			return read_sysreg(cntp_ctl_el0);
 		case ARCH_TIMER_REG_TVAL:
 			return arch_timer_reg_read_stable(cntp_tval_el0);
+		default:
+			BUILD_BUG();
 		}
 	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
 		switch (reg) {
@@ -143,10 +151,13 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 			return read_sysreg(cntv_ctl_el0);
 		case ARCH_TIMER_REG_TVAL:
 			return arch_timer_reg_read_stable(cntv_tval_el0);
+		default:
+			BUILD_BUG();
 		}
 	}
 
-	BUG();
+	BUILD_BUG();
+	unreachable();
 }
 
 static inline u32 arch_timer_get_cntfrq(void)
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index be6d741..3b7d46d 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -112,6 +112,8 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
 		case ARCH_TIMER_REG_TVAL:
 			writel_relaxed(val, timer->base + CNTP_TVAL);
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
 		struct arch_timer *timer = to_arch_timer(clk);
@@ -122,6 +124,8 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
 		case ARCH_TIMER_REG_TVAL:
 			writel_relaxed(val, timer->base + CNTV_TVAL);
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else {
 		arch_timer_reg_write_cp15(access, reg, val);
@@ -143,6 +147,8 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
 		case ARCH_TIMER_REG_TVAL:
 			val = readl_relaxed(timer->base + CNTP_TVAL);
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
 		struct arch_timer *timer = to_arch_timer(clk);
@@ -153,6 +159,8 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
 		case ARCH_TIMER_REG_TVAL:
 			val = readl_relaxed(timer->base + CNTV_TVAL);
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else {
 		val = arch_timer_reg_read_cp15(access, reg);
