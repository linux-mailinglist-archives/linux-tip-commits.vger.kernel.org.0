Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015CD3ACFA9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhFRQFt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 12:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhFRQFs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 12:05:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7D0C061574;
        Fri, 18 Jun 2021 09:03:39 -0700 (PDT)
Date:   Fri, 18 Jun 2021 16:03:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624032218;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqyE3BtOKENtxAO9mzegNHwVPtpSpatO6DJrfAeObo0=;
        b=r1/nRo8FpmWeklBC0oo2PzSGBeB8P4MVVdOKFwnGEKFgxVzhlsyGKYXYPxP68BWanmtpfS
        ogy+ZqFHzqcB54AlAq38pONUYkF/aImKm9XYW9hCdhTWKiV8vREzaTST8Af/4Q5aUPZNoq
        J21KkMC36AYOLwOH4aPHIzEVIZoTbacBlKFGVWSyrxc54w93L0jAydtasCPX4bJfON2XcT
        h/pdi+Z4TdA7evhSY6M7UG0jk9TztH3oF2+926Ub8+rPlG8hBV8Wwdiaw7f48AKSSTTqvB
        00Ir007DP22BGiVjxdyjswWFMiHLzWtrz6TQ4vI0gOuAmU3RQoJayyTsj7LI+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624032218;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqyE3BtOKENtxAO9mzegNHwVPtpSpatO6DJrfAeObo0=;
        b=ffqTYIOSuPa/OYB7jL53OiwnR7Ezu2VfSghj8vLbRWF/f1XY0ZHDbPmAL/TCCwjv19Swt2
        Igupy2npWULIhjAA==
From:   "tip-bot2 for Wan Jiabing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_global_timer: Remove
 duplicated argument in arm_global_timer
Cc:     Wan Jiabing <wanjiabing@vivo.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210615115440.8881-1-wanjiabing@vivo.com>
References: <20210615115440.8881-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Message-ID: <162403221739.19906.6087766341626697388.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f94bc2667fb204d7c131ac39d9ea342bd16116dc
Gitweb:        https://git.kernel.org/tip/f94bc2667fb204d7c131ac39d9ea342bd16116dc
Author:        Wan Jiabing <wanjiabing@vivo.com>
AuthorDate:    Tue, 15 Jun 2021 19:54:40 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 16 Jun 2021 17:33:04 +02:00

clocksource/drivers/arm_global_timer: Remove duplicated argument in arm_global_timer

Fix the following coccicheck warning:

    drivers/clocksource/arm_global_timer.c:107:4-23:
    duplicated argument to & or |

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210615115440.8881-1-wanjiabing@vivo.com
---
 drivers/clocksource/arm_global_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 68b1d14..44a61dc 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -104,7 +104,7 @@ static void gt_compare_set(unsigned long delta, int periodic)
 	counter += delta;
 	ctrl = readl(gt_base + GT_CONTROL);
 	ctrl &= ~(GT_CONTROL_COMP_ENABLE | GT_CONTROL_IRQ_ENABLE |
-		  GT_CONTROL_AUTO_INC | GT_CONTROL_AUTO_INC);
+		  GT_CONTROL_AUTO_INC);
 	ctrl |= GT_CONTROL_TIMER_ENABLE;
 	writel_relaxed(ctrl, gt_base + GT_CONTROL);
 	writel_relaxed(lower_32_bits(counter), gt_base + GT_COMP0);
