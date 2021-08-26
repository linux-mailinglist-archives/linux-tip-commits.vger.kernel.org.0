Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446663F8C1A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 18:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbhHZQ0R (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 12:26:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33184 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243104AbhHZQ0I (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 12:26:08 -0400
Date:   Thu, 26 Aug 2021 16:25:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629995120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/z4eEHA/BvTTf9lcIYQIgsjWlsescoJO2hukCV5cUHE=;
        b=jZAdaB6KqtCGc5L9fF78GLHO3gKCyC69tQ/ShxyAaw8DtiCavCSphLaDw+RbmQpo4QUC7d
        mnx0Xuj6hht+s79ENc1QQOwualcUoWrgoFV4rkRTO3Z5DHAQ60f+osAqncAjjcstrLIW8/
        nX1rO0XDUIl7z0b3YTfz7FS1y1BC6DM/UzLXEvElXPi+hsS6SBWBODgU0izNCdA+0gzwON
        eoU2txguHHlj5f1qFr74m9rx44nHmYjKPolC1mdYLsQh93OWk/SgUzf5hLVBQbDVZ0Mkcx
        LQK3OFSw3M91hFwQUBzJNRosetbblufnOkOT1ykNL1GVr9uNs0BA5zaD7jld7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629995120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/z4eEHA/BvTTf9lcIYQIgsjWlsescoJO2hukCV5cUHE=;
        b=FUlo3D9n0Soqkd49vxSFv80nIm6sWXibUk3iEtonan81mBpYP/gUoARv7uxkwwWMcP9EQa
        c1tB8vY1keZxnXBw==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/exynos_mct: Mark MCT device as
 CLOCK_EVT_FEAT_PERCPU
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Will Deacon <will@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210608154341.10794-3-will@kernel.org>
References: <20210608154341.10794-3-will@kernel.org>
MIME-Version: 1.0
Message-ID: <162999511928.25758.13349701269137366922.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     88183788eacb782eb6e1295f1934fb9531b503d6
Gitweb:        https://git.kernel.org/tip/88183788eacb782eb6e1295f1934fb9531b503d6
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Tue, 08 Jun 2021 16:43:41 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 13 Aug 2021 09:24:22 +02:00

clocksource/drivers/exynos_mct: Mark MCT device as CLOCK_EVT_FEAT_PERCPU

The "mct_tick" is a per-cpu clockevents device. Set the
CLOCK_EVT_FEAT_PERCPU feature to prevent e.g. mct_tick0 being unsafely
designated as the global broadcast timer and instead treat the device as
a per-cpu wakeup timer.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Will Deacon <will@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210608154341.10794-3-will@kernel.org
---
 drivers/clocksource/exynos_mct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 804d3e0..5e3e96d 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -465,7 +465,8 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 	evt->set_state_oneshot = set_state_shutdown;
 	evt->set_state_oneshot_stopped = set_state_shutdown;
 	evt->tick_resume = set_state_shutdown;
-	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
+			CLOCK_EVT_FEAT_PERCPU;
 	evt->rating = MCT_CLKEVENTS_RATING,
 
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
