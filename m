Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176143F8C17
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243134AbhHZQ0N (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 12:26:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33198 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243109AbhHZQ0J (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 12:26:09 -0400
Date:   Thu, 26 Aug 2021 16:25:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629995120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VAdo3aAIEd8rdIkb8bPvTnhqCoD4Ebes64JZqj1AMpo=;
        b=l8oD2Oh2Ml1N3N5Rx4yuMDEiKFz8skrSbISaWwYOqJmSH8kTjKhBUeT/vv6DbPsN+VOhFX
        4dj3QC33Jtg1LFjS6oV9rceRTcebnvaLsBqPiBlqewJRshHCyQ7gGVFsQsj/pLBQsB+z3E
        UqFyZ0mehemQ9hefhI4Yv4iTSPwxFHSD0zqIlPvGLPJIra07SvnqlSua6aZbU5+oOODRbK
        t6Ylx7c9H/vpHA2Lay5AtSPtAXtmRSQHiFJLGYUw9qiansQGrlOvNxrfDqJaSl2itUPH53
        LkLusp2ViP53K+c3RuUE/LHaTYUMB4HcTY26jV1DkN9K84Mmy+5ZYOPZBH8PXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629995120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VAdo3aAIEd8rdIkb8bPvTnhqCoD4Ebes64JZqj1AMpo=;
        b=WydwjeOLOnTkuPWmj8kAkcxaj/WLeqrVCjF5bz0DZB0NtDYsNyrNuHZ80Rsfx1yYXM7YPN
        WD8A03RcP2KIKHDw==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/exynos_mct: Prioritise Arm
 arch timer on arm64
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210608154341.10794-2-will@kernel.org>
References: <20210608154341.10794-2-will@kernel.org>
MIME-Version: 1.0
Message-ID: <162999512006.25758.16639424534256456858.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ae460fd9164b16654d8ec06cbc280b832f840eac
Gitweb:        https://git.kernel.org/tip/ae460fd9164b16654d8ec06cbc280b832f840eac
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Tue, 08 Jun 2021 16:43:40 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 13 Aug 2021 09:24:22 +02:00

clocksource/drivers/exynos_mct: Prioritise Arm arch timer on arm64

All arm64 CPUs feature an architected timer, which offers a relatively
low-latency interface to a per-cpu clocksource and timer. For the most
part, using this interface is a no-brainer, with the exception of SoCs
where it cannot be used to wake up from deep idle state (i.e.
CLOCK_EVT_FEAT_C3STOP is set).

On the contrary, the Exynos MCT is extremely slow to access yet can be
used as a wakeup source. In preparation for using the Exynos MCT as a
potential wakeup timer for the Arm architected timer, reduce its ratings
so that the architected timer is preferred.

This effectively reverts the decision made in 6282edb72bed
("clocksource/drivers/exynos_mct: Increase priority over ARM arch timer")
for arm64, as the reasoning for the original change was to work around
a 32-bit SoC design.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Will Deacon <will@kernel.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> # exynos-5422
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210608154341.10794-2-will@kernel.org
---
 drivers/clocksource/exynos_mct.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index fabad79..804d3e0 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -51,6 +51,15 @@
 
 #define TICK_BASE_CNT	1
 
+#ifdef CONFIG_ARM
+/* Use values higher than ARM arch timer. See 6282edb72bed. */
+#define MCT_CLKSOURCE_RATING		450
+#define MCT_CLKEVENTS_RATING		500
+#else
+#define MCT_CLKSOURCE_RATING		350
+#define MCT_CLKEVENTS_RATING		350
+#endif
+
 enum {
 	MCT_INT_SPI,
 	MCT_INT_PPI
@@ -206,7 +215,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
 
 static struct clocksource mct_frc = {
 	.name		= "mct-frc",
-	.rating		= 450,	/* use value higher than ARM arch timer */
+	.rating		= MCT_CLKSOURCE_RATING,
 	.read		= exynos4_frc_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
@@ -457,7 +466,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 	evt->set_state_oneshot_stopped = set_state_shutdown;
 	evt->tick_resume = set_state_shutdown;
 	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	evt->rating = 500;	/* use value higher than ARM arch timer */
+	evt->rating = MCT_CLKEVENTS_RATING,
 
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
 
