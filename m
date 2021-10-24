Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2E1438A09
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Oct 2021 17:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhJXPmg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Oct 2021 11:42:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49298 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhJXPm2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Oct 2021 11:42:28 -0400
Date:   Sun, 24 Oct 2021 15:40:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635090006;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFkjUuOkf8MjwddyPJH+aUG10+A4HCYS2HXgxJm+16o=;
        b=Wk+/+erV8CRRInoorksww6cqnOU0DugAUfmxb2BCBXvcyPnCcAxjGAkix2OPfDFeKyEBHu
        HAEAu5QYaHgFpLA2yM2wZiUC+vqDC1qQ/DS25Xym+x5NUjtb0Li1om6EOZxJJjlgI2CT5B
        NQLTrGDZPV+r/NrTTD5b4uLesrPGbweKNZhLb2nx2yQBF5R3+cKC8cpVHXIl2ZyDYBbHqY
        Hr059hKg+nIlKTs6NJQADdtWAv+h/c8cI5vWGB3blDh0QsIB4VwtmPHV9h3Y9IhArP756m
        ZRT6evAjqkOt05IMnxNop7aeu0kTzCPa2td67sLWu4FH0Yhcb5w7HgN/KWFuKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635090006;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFkjUuOkf8MjwddyPJH+aUG10+A4HCYS2HXgxJm+16o=;
        b=WuuhTByTT1yep54+ELqkW0ViqVU7EHAF87NYWnioXi1WjfeX85qFCSlmm8vx7vlMRKsKAp
        qsOa457bma5CJ9BQ==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Drop CNT*_TVAL
 read accessors
Cc:     Oliver Upton <oupton@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211017124225.3018098-3-maz@kernel.org>
References: <20211017124225.3018098-3-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163509000598.626.1591023522536792971.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d72689988d67d56aebf7afb7f609373ea6b548db
Gitweb:        https://git.kernel.org/tip/d72689988d67d56aebf7afb7f609373ea6b548db
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 17 Oct 2021 13:42:10 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 17 Oct 2021 21:46:50 +02:00

clocksource/drivers/arm_arch_timer: Drop CNT*_TVAL read accessors

The arch timer driver never reads the various TVAL registers, only
writes to them. It is thus pointless to provide accessors
for them and to implement errata workarounds.

Drop these read-side accessors, and add a couple of BUG() statements
for the time being. These statements will be removed further down
the line.

Reviewed-by: Oliver Upton <oupton@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211017124225.3018098-3-maz@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/include/asm/arch_timer.h    |  6 +----
 arch/arm64/include/asm/arch_timer.h  | 17 +----------
 drivers/clocksource/arm_arch_timer.c | 44 +---------------------------
 3 files changed, 67 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index a5d27cf..7d75708 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -65,9 +65,6 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 		case ARCH_TIMER_REG_CTRL:
 			asm volatile("mrc p15, 0, %0, c14, c2, 1" : "=r" (val));
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			asm volatile("mrc p15, 0, %0, c14, c2, 0" : "=r" (val));
-			break;
 		default:
 			BUILD_BUG();
 		}
@@ -76,9 +73,6 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 		case ARCH_TIMER_REG_CTRL:
 			asm volatile("mrc p15, 0, %0, c14, c3, 1" : "=r" (val));
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			asm volatile("mrc p15, 0, %0, c14, c3, 0" : "=r" (val));
-			break;
 		default:
 			BUILD_BUG();
 		}
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index fa12ea4..8332fcf 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -52,8 +52,6 @@ struct arch_timer_erratum_workaround {
 	enum arch_timer_erratum_match_type match_type;
 	const void *id;
 	const char *desc;
-	u32 (*read_cntp_tval_el0)(void);
-	u32 (*read_cntv_tval_el0)(void);
 	u64 (*read_cntpct_el0)(void);
 	u64 (*read_cntvct_el0)(void);
 	int (*set_next_event_phys)(unsigned long, struct clock_event_device *);
@@ -64,17 +62,6 @@ struct arch_timer_erratum_workaround {
 DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
 		timer_unstable_counter_workaround);
 
-/* inline sysreg accessors that make erratum_handler() work */
-static inline notrace u32 arch_timer_read_cntp_tval_el0(void)
-{
-	return read_sysreg(cntp_tval_el0);
-}
-
-static inline notrace u32 arch_timer_read_cntv_tval_el0(void)
-{
-	return read_sysreg(cntv_tval_el0);
-}
-
 static inline notrace u64 arch_timer_read_cntpct_el0(void)
 {
 	return read_sysreg(cntpct_el0);
@@ -140,8 +127,6 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			return read_sysreg(cntp_ctl_el0);
-		case ARCH_TIMER_REG_TVAL:
-			return arch_timer_reg_read_stable(cntp_tval_el0);
 		default:
 			BUILD_BUG();
 		}
@@ -149,8 +134,6 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			return read_sysreg(cntv_ctl_el0);
-		case ARCH_TIMER_REG_TVAL:
-			return arch_timer_reg_read_stable(cntv_tval_el0);
 		default:
 			BUILD_BUG();
 		}
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 3b7d46d..67bdc72 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -144,9 +144,6 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
 		case ARCH_TIMER_REG_CTRL:
 			val = readl_relaxed(timer->base + CNTP_CTL);
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			val = readl_relaxed(timer->base + CNTP_TVAL);
-			break;
 		default:
 			BUILD_BUG();
 		}
@@ -156,9 +153,6 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
 		case ARCH_TIMER_REG_CTRL:
 			val = readl_relaxed(timer->base + CNTV_CTL);
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			val = readl_relaxed(timer->base + CNTV_TVAL);
-			break;
 		default:
 			BUILD_BUG();
 		}
@@ -247,16 +241,6 @@ struct ate_acpi_oem_info {
 	_new;						\
 })
 
-static u32 notrace fsl_a008585_read_cntp_tval_el0(void)
-{
-	return __fsl_a008585_read_reg(cntp_tval_el0);
-}
-
-static u32 notrace fsl_a008585_read_cntv_tval_el0(void)
-{
-	return __fsl_a008585_read_reg(cntv_tval_el0);
-}
-
 static u64 notrace fsl_a008585_read_cntpct_el0(void)
 {
 	return __fsl_a008585_read_reg(cntpct_el0);
@@ -293,16 +277,6 @@ static u64 notrace fsl_a008585_read_cntvct_el0(void)
 	_new;							\
 })
 
-static u32 notrace hisi_161010101_read_cntp_tval_el0(void)
-{
-	return __hisi_161010101_read_reg(cntp_tval_el0);
-}
-
-static u32 notrace hisi_161010101_read_cntv_tval_el0(void)
-{
-	return __hisi_161010101_read_reg(cntv_tval_el0);
-}
-
 static u64 notrace hisi_161010101_read_cntpct_el0(void)
 {
 	return __hisi_161010101_read_reg(cntpct_el0);
@@ -387,16 +361,6 @@ static u64 notrace sun50i_a64_read_cntvct_el0(void)
 {
 	return __sun50i_a64_read_reg(cntvct_el0);
 }
-
-static u32 notrace sun50i_a64_read_cntp_tval_el0(void)
-{
-	return read_sysreg(cntp_cval_el0) - sun50i_a64_read_cntpct_el0();
-}
-
-static u32 notrace sun50i_a64_read_cntv_tval_el0(void)
-{
-	return read_sysreg(cntv_cval_el0) - sun50i_a64_read_cntvct_el0();
-}
 #endif
 
 #ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
@@ -446,8 +410,6 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.match_type = ate_match_dt,
 		.id = "fsl,erratum-a008585",
 		.desc = "Freescale erratum a005858",
-		.read_cntp_tval_el0 = fsl_a008585_read_cntp_tval_el0,
-		.read_cntv_tval_el0 = fsl_a008585_read_cntv_tval_el0,
 		.read_cntpct_el0 = fsl_a008585_read_cntpct_el0,
 		.read_cntvct_el0 = fsl_a008585_read_cntvct_el0,
 		.set_next_event_phys = erratum_set_next_event_tval_phys,
@@ -459,8 +421,6 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.match_type = ate_match_dt,
 		.id = "hisilicon,erratum-161010101",
 		.desc = "HiSilicon erratum 161010101",
-		.read_cntp_tval_el0 = hisi_161010101_read_cntp_tval_el0,
-		.read_cntv_tval_el0 = hisi_161010101_read_cntv_tval_el0,
 		.read_cntpct_el0 = hisi_161010101_read_cntpct_el0,
 		.read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
 		.set_next_event_phys = erratum_set_next_event_tval_phys,
@@ -470,8 +430,6 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.match_type = ate_match_acpi_oem_info,
 		.id = hisi_161010101_oem_info,
 		.desc = "HiSilicon erratum 161010101",
-		.read_cntp_tval_el0 = hisi_161010101_read_cntp_tval_el0,
-		.read_cntv_tval_el0 = hisi_161010101_read_cntv_tval_el0,
 		.read_cntpct_el0 = hisi_161010101_read_cntpct_el0,
 		.read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
 		.set_next_event_phys = erratum_set_next_event_tval_phys,
@@ -492,8 +450,6 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.match_type = ate_match_dt,
 		.id = "allwinner,erratum-unknown1",
 		.desc = "Allwinner erratum UNKNOWN1",
-		.read_cntp_tval_el0 = sun50i_a64_read_cntp_tval_el0,
-		.read_cntv_tval_el0 = sun50i_a64_read_cntv_tval_el0,
 		.read_cntpct_el0 = sun50i_a64_read_cntpct_el0,
 		.read_cntvct_el0 = sun50i_a64_read_cntvct_el0,
 		.set_next_event_phys = erratum_set_next_event_tval_phys,
