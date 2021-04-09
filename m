Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DEF359C07
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 12:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhDIK1z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 06:27:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49670 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhDIK1o (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 06:27:44 -0400
Date:   Fri, 09 Apr 2021 10:27:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617964050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nat72EUkBzLgHcZa5I/gmE14ktQ18zfB4aaUgUA0cEQ=;
        b=ytuerbOfBAV7YOG9WuOQ1MEOEPJZBhTs7RDVM8fLUkM6xvg/f96A8Fc87DFhC7oDdsQF8T
        dLgq/nxYty+qQfzxvXXF2Qj/W54iBnR/1wwLlBJ5noqPGZtmaJ+CFQznKaVL+2osky3Q1p
        /UBwpCb5alvnNA3u8bXx+esYGmWYW99O+tpHxHQxfNF4tw7MgW6hAt61591OLOw4cH33hO
        VygaNOV+Ov48vVJ9Cq7ahqiTKr0+HOmgk9AvU9vl9v6DxFSHdRjacfhPNbM+T6Bcpu81a6
        ffVihYkFb7eMhVGxwVu1U9M1h7N/Thlvt0XPiFmyJxLMPUWuSDqxnKiHjQ53wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617964050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nat72EUkBzLgHcZa5I/gmE14ktQ18zfB4aaUgUA0cEQ=;
        b=QmMRJGSuUvFLOV5tI3lDRNNGoJfar/alT5aXESxI+6cQvETLigUq1FHcNL/5QMpMhBil6s
        zoRTjqnOhj/CftCg==
From:   "tip-bot2 for Paul Cercueil" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/ingenic: Add support for the JZ4760
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210308212302.10288-2-paul@crapouillou.net>
References: <20210308212302.10288-2-paul@crapouillou.net>
MIME-Version: 1.0
Message-ID: <161796404977.29796.7936206069021613068.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8a3f717f35a3e9a28a935f8e4459c72ba00e90ca
Gitweb:        https://git.kernel.org/tip/8a3f717f35a3e9a28a935f8e4459c72ba00e90ca
Author:        Paul Cercueil <paul@crapouillou.net>
AuthorDate:    Mon, 08 Mar 2021 21:23:01 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 08 Apr 2021 13:23:22 +02:00

clocksource/drivers/ingenic: Add support for the JZ4760

Add support for the TCU (Timer/Counter Unit) of the JZ4760 and JZ4760B
SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210308212302.10288-2-paul@crapouillou.net
---
 drivers/clocksource/ingenic-timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/ingenic-timer.c b/drivers/clocksource/ingenic-timer.c
index 905fd6b..24ed0f1 100644
--- a/drivers/clocksource/ingenic-timer.c
+++ b/drivers/clocksource/ingenic-timer.c
@@ -264,6 +264,7 @@ static const struct ingenic_soc_info jz4725b_soc_info = {
 static const struct of_device_id ingenic_tcu_of_match[] = {
 	{ .compatible = "ingenic,jz4740-tcu", .data = &jz4740_soc_info, },
 	{ .compatible = "ingenic,jz4725b-tcu", .data = &jz4725b_soc_info, },
+	{ .compatible = "ingenic,jz4760-tcu", .data = &jz4740_soc_info, },
 	{ .compatible = "ingenic,jz4770-tcu", .data = &jz4740_soc_info, },
 	{ .compatible = "ingenic,x1000-tcu", .data = &jz4740_soc_info, },
 	{ /* sentinel */ }
@@ -358,6 +359,7 @@ err_free_ingenic_tcu:
 
 TIMER_OF_DECLARE(jz4740_tcu_intc,  "ingenic,jz4740-tcu",  ingenic_tcu_init);
 TIMER_OF_DECLARE(jz4725b_tcu_intc, "ingenic,jz4725b-tcu", ingenic_tcu_init);
+TIMER_OF_DECLARE(jz4760_tcu_intc,  "ingenic,jz4760-tcu",  ingenic_tcu_init);
 TIMER_OF_DECLARE(jz4770_tcu_intc,  "ingenic,jz4770-tcu",  ingenic_tcu_init);
 TIMER_OF_DECLARE(x1000_tcu_intc,  "ingenic,x1000-tcu",  ingenic_tcu_init);
 
