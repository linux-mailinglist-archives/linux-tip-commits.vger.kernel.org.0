Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8213ACFB6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 18:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbhFRQF5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 12:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbhFRQFy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 12:05:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC95C06175F;
        Fri, 18 Jun 2021 09:03:44 -0700 (PDT)
Date:   Fri, 18 Jun 2021 16:03:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624032223;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EfYeF/xyclN0tRTpgr8ii4BQq54TSBAJ6z5k795hebM=;
        b=XcHvwdy6y1sAwD1zn4y5xuoQA8k0oTzuGNmzwYVyLmpWi8kntrqZ+ESsvy9M9lNILlHkuT
        7ALGYW4xNdtVY4bpcySFVmHHofve2lOoGjYI3oOvR+5S84gbldJHXfUZFaXi7fVW1xkPAB
        V0SUWUzmAa8+vQtCR9+b5U6oMt7sZdx2Wq3g+w4XUi59nppgE0Vz280UgEKOZJ7yYUIld7
        4MBKfN2g8PomnEjkAq3jBGqMM5Dd8Iu4SkCjgA16/mc/nKQDUHjPNQdGVppnTlONcNsS56
        QLonJ0FHaScne0vyd8RI/uzK5B77KYllGxNkuUC+3SoFYpMzdBTefOM7vetylw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624032223;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EfYeF/xyclN0tRTpgr8ii4BQq54TSBAJ6z5k795hebM=;
        b=p9tglkZTlbfZCFs2y1g/i6ZO+x9wsZWC2PP6PY1Lb+5tJwEyOHWw2dZMj6RGGoBA0OIeeg
        40NrJcBXFkHHy1AA==
From:   "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/samsung_pwm: Constify passed structure
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506202729.157260-2-krzysztof.kozlowski@canonical.com>
References: <20210506202729.157260-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Message-ID: <162403222274.19906.17126151088160892046.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bb08e96575dbbd49acb49999dd0d7ffedb5c1608
Gitweb:        https://git.kernel.org/tip/bb08e96575dbbd49acb49999dd0d7ffedb5c1608
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
AuthorDate:    Thu, 06 May 2021 16:27:26 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 04 Jun 2021 10:12:11 +02:00

clocksource/drivers/samsung_pwm: Constify passed structure

The 'struct samsung_pwm_variant' argument passed to initialization
functions is not modified, so it can be made const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210506202729.157260-2-krzysztof.kozlowski@canonical.com
---
 drivers/clocksource/samsung_pwm_timer.c | 2 +-
 include/clocksource/samsung_pwm.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 69bf79c..bfad61b 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -401,7 +401,7 @@ static int __init _samsung_pwm_clocksource_init(void)
 
 void __init samsung_pwm_clocksource_init(void __iomem *base,
 					 unsigned int *irqs,
-					 struct samsung_pwm_variant *variant)
+					 const struct samsung_pwm_variant *variant)
 {
 	pwm.base = base;
 	memcpy(&pwm.variant, variant, sizeof(pwm.variant));
diff --git a/include/clocksource/samsung_pwm.h b/include/clocksource/samsung_pwm.h
index 7634198..9b435ca 100644
--- a/include/clocksource/samsung_pwm.h
+++ b/include/clocksource/samsung_pwm.h
@@ -28,6 +28,6 @@ struct samsung_pwm_variant {
 
 void samsung_pwm_clocksource_init(void __iomem *base,
 				  unsigned int *irqs,
-				  struct samsung_pwm_variant *variant);
+				  const struct samsung_pwm_variant *variant);
 
 #endif /* __CLOCKSOURCE_SAMSUNG_PWM_H */
