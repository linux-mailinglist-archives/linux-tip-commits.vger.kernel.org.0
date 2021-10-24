Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81DC4389F7
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Oct 2021 17:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhJXPmV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Oct 2021 11:42:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49280 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhJXPmU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Oct 2021 11:42:20 -0400
Date:   Sun, 24 Oct 2021 15:39:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635089999;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lI0+pYO+2wpUprd/7Q04qf9pA/n+JUwomMW7QIeyL1A=;
        b=Z68wGDyuajtJqNYVEzEWOoLxqGN8k0tes3+WjpZVLw/mko1oTcd2nsQ6OOpJ6+hXWGPnew
        8zcuwONWqHP7EkMvziLHwIFAqJ0NM9NSGzGLgF1oFqp30Y33eBn9Az3VFPhz2oB8QiW8eg
        8QrmFiNOvePvVPvz0uFggQbOySTzp6h4bCcP+9zG/qEcVQwetWP4ewgxQgSN1yFH19rEKY
        2oST+jFDqKmi/OnxVvJ6WDT3K4bzSGWYjzLOHmK6Qj/IZmKBhG2weDLSwn9gHnBeP7sX5h
        n1gicsvihozR3jpXKIcsdtlbeFpucnrl3vatWam5NHFvWCvsLbcYDoxFsRzsQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635089999;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lI0+pYO+2wpUprd/7Q04qf9pA/n+JUwomMW7QIeyL1A=;
        b=Dh/Q0UllEbfYA8crUjw4DLBvUrxVpOJLcOiyeVrRJImCQ4mwAtTK2rmqNVk/P1VuAQqlHA
        ab1sQWw/d4hrPuBw==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arch_arm_timer: Move
 workaround synchronisation around
Cc:     Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211017124225.3018098-14-maz@kernel.org>
References: <20211017124225.3018098-14-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163508999837.626.7470689598244228406.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     db26f8f2da92471e9f7f71ec78d6fa455cd9c821
Gitweb:        https://git.kernel.org/tip/db26f8f2da92471e9f7f71ec78d6fa455cd9c821
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 17 Oct 2021 13:42:21 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 18 Oct 2021 09:20:57 +02:00

clocksource/drivers/arch_arm_timer: Move workaround synchronisation around

We currently handle synchronisation when workarounds are enabled
by having an ISB in the __arch_counter_get_cnt?ct_stable() helpers.

While this works, this prevents us from relaxing this synchronisation.

Instead, move it closer to the point where the synchronisation is
actually needed. Further patches will subsequently relax this.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211017124225.3018098-14-maz@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/include/asm/arch_timer.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index b8000ef..519ac1f 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -32,7 +32,7 @@
 	({								\
 		const struct arch_timer_erratum_workaround *__wa;	\
 		__wa = __this_cpu_read(timer_unstable_counter_workaround); \
-		(__wa && __wa->h) ? __wa->h : arch_timer_##h;		\
+		(__wa && __wa->h) ? ({ isb(); __wa->h;}) : arch_timer_##h; \
 	})
 
 #else
@@ -64,11 +64,13 @@ DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
 
 static inline notrace u64 arch_timer_read_cntpct_el0(void)
 {
+	isb();
 	return read_sysreg(cntpct_el0);
 }
 
 static inline notrace u64 arch_timer_read_cntvct_el0(void)
 {
+	isb();
 	return read_sysreg(cntvct_el0);
 }
 
@@ -163,7 +165,6 @@ static __always_inline u64 __arch_counter_get_cntpct_stable(void)
 {
 	u64 cnt;
 
-	isb();
 	cnt = arch_timer_reg_read_stable(cntpct_el0);
 	arch_counter_enforce_ordering(cnt);
 	return cnt;
@@ -183,7 +184,6 @@ static __always_inline u64 __arch_counter_get_cntvct_stable(void)
 {
 	u64 cnt;
 
-	isb();
 	cnt = arch_timer_reg_read_stable(cntvct_el0);
 	arch_counter_enforce_ordering(cnt);
 	return cnt;
