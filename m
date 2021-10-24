Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70584438A00
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Oct 2021 17:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhJXPm0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Oct 2021 11:42:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49296 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhJXPmY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Oct 2021 11:42:24 -0400
Date:   Sun, 24 Oct 2021 15:40:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635090002;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gpCMkJDiDM8UcyG2fROMLkbrcYEHdPtIFhSb73sr0Mc=;
        b=wJsEqIFYEFMjCDxKiP3sKFPpPNK6XYgGZN82//oBy0N6T93md8rwuoC/yBoDa53qx+ye9B
        NmOVYNzOE8kAkAsRONi1K98ORUudh1KsrCF+u5GkPUD00vtY1/4L9R2xBxvcxXFyf92hB6
        hV/FppwWcenwaSQ6os5T+WiTeXnRUl8YoepYTWMh+aRyHwmyfiStInxq2LhOSNf44Yuy8S
        DdjX7E0JVihnUjnG26V796ZlvSHomepXgZ7mbDoi90b1nDdpIa5LCJqQ/V0O0b/VK2QjyF
        qjrw7LU4Rm+IS6sKt0GvKHUJKqIiCJ86d4BELvOrMMo/6RNpACEuXan6vFSZiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635090002;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gpCMkJDiDM8UcyG2fROMLkbrcYEHdPtIFhSb73sr0Mc=;
        b=D4wZ6xS6GdXoIvjqom1+ttOIrF73q+ddnHODyodikQ0Nh14hs+R5LcQcOEUv9r5DH/AF06
        MpK2bVx0F81hhYCw==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Advertise
 56bit timer to the core code
Cc:     Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211017124225.3018098-9-maz@kernel.org>
References: <20211017124225.3018098-9-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163509000178.626.8608412263303583759.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     30aa08da35e07a51a81d489517a3f6fb5164b09c
Gitweb:        https://git.kernel.org/tip/30aa08da35e07a51a81d489517a3f6fb5164b09c
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 17 Oct 2021 13:42:16 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 17 Oct 2021 21:47:27 +02:00

clocksource/drivers/arm_arch_timer: Advertise 56bit timer to the core code

Proudly tell the code code that we have a timer able to handle
56 bits deltas.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211017124225.3018098-9-maz@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index f4db3a6..36e0914 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -834,7 +834,7 @@ static void __arch_timer_setup(unsigned type,
 
 	clk->set_state_shutdown(clk);
 
-	clockevents_config_and_register(clk, arch_timer_rate, 0xf, 0x7fffffff);
+	clockevents_config_and_register(clk, arch_timer_rate, 0xf, CLOCKSOURCE_MASK(56));
 }
 
 static void arch_timer_evtstrm_enable(int divider)
