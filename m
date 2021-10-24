Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265604389FF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Oct 2021 17:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhJXPm0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Oct 2021 11:42:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49298 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhJXPmX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Oct 2021 11:42:23 -0400
Date:   Sun, 24 Oct 2021 15:40:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635090001;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VV4V0F8DisqtQgDr237bHejQaOsqv9OyOL55me3JHL0=;
        b=md0163NqemSnLKsouyCsP1KqlhbICscya6kJw6j63HEVhBN8rupAdk2bSspqrVL+47hikc
        wnUx6bexuVLDy1Z4efNBtR42+JhherUhn2sqPk/xfMpTLlkLH4C2conECW61kekgFfWgON
        OUhfjV0JvwsGH5wcx9P1rCboNZnRg+tFl0v8r00egqqqN8axTj5SRtTcORYJycB0aN6/nb
        eah3WmPNDgTIRnlpbgKY9zE4UevGdY2tfLKAv19QlhpS03XG1YLKswnfI8kHfWh8Q53zwO
        71nCHCNWkJwC84cb1RuZu4Hak8AAslLp8hMtHbtMCvGlXx2BeaIPMwhEBacxJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635090001;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VV4V0F8DisqtQgDr237bHejQaOsqv9OyOL55me3JHL0=;
        b=Bkng0/5qovn+6d/+5IvZnPK+Ma2AZQx/lp+YjYQ8SltMAuw6IfTcQKCT93grZXTqiDwUOo
        3mfitGnTSxSSseDg==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Remove any
 trace of the TVAL programming interface
Cc:     Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211017124225.3018098-11-maz@kernel.org>
References: <20211017124225.3018098-11-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163509000040.626.11026337634937329265.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     41f8d02a6a558f80775bf61fe6312a14eeabbca0
Gitweb:        https://git.kernel.org/tip/41f8d02a6a558f80775bf61fe6312a14eeabbca0
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 17 Oct 2021 13:42:18 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 17 Oct 2021 21:47:39 +02:00

clocksource/drivers/arm_arch_timer: Remove any trace of the TVAL programming interface

TVAL usage is now long gone, get rid of the leftovers.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211017124225.3018098-11-maz@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 8 --------
 include/clocksource/arm_arch_timer.h | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index ef3f838..6e20bc1 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -48,10 +48,8 @@
 #define CNTPCT_LO	0x08
 #define CNTFRQ		0x10
 #define CNTP_CVAL_LO	0x20
-#define CNTP_TVAL	0x28
 #define CNTP_CTL	0x2c
 #define CNTV_CVAL_LO	0x30
-#define CNTV_TVAL	0x38
 #define CNTV_CTL	0x3c
 
 static unsigned arch_timers_present __initdata;
@@ -111,9 +109,6 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
 		case ARCH_TIMER_REG_CTRL:
 			writel_relaxed((u32)val, timer->base + CNTP_CTL);
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			writel_relaxed((u32)val, timer->base + CNTP_TVAL);
-			break;
 		case ARCH_TIMER_REG_CVAL:
 			/*
 			 * Not guaranteed to be atomic, so the timer
@@ -130,9 +125,6 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
 		case ARCH_TIMER_REG_CTRL:
 			writel_relaxed((u32)val, timer->base + CNTV_CTL);
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			writel_relaxed((u32)val, timer->base + CNTV_TVAL);
-			break;
 		case ARCH_TIMER_REG_CVAL:
 			/* Same restriction as above */
 			writeq_relaxed(val, timer->base + CNTV_CVAL_LO);
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index d59537a..e715bdb 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -24,7 +24,6 @@
 
 enum arch_timer_reg {
 	ARCH_TIMER_REG_CTRL,
-	ARCH_TIMER_REG_TVAL,
 	ARCH_TIMER_REG_CVAL,
 };
 
