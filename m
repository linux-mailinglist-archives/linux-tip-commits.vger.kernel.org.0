Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C85359C00
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 12:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhDIK1t (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 06:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbhDIK1n (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 06:27:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F374AC061763;
        Fri,  9 Apr 2021 03:27:30 -0700 (PDT)
Date:   Fri, 09 Apr 2021 10:27:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617964047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eOpjc/5oLseTKTdow5GlBUGuJdmu0mipYLa59vxGndk=;
        b=NuHjq8adSrImFjqVh1LrvBrNHVxQ8xBkzGkCy/SR8il5kcG1OctfGInG7M7/UEUYn3YuFN
        vsqkF3bQ7LNVgnS4au/8XEWGHDUd5gTyhcSlqeYwtFVI1Rcspmt1d5HxsbCJnZiwyG1Ewo
        QzPI0/mjPPIG89XvVtAJvVJlBhBNtxJ+uHONi9Dvy2pctggcTc0b75UobcBHRZ9SFO3T7t
        nPcBe2erlWrI79tmCv+zxgnw/4FM3yqdL1vtaev9MZkMELXEMV4C1qapQ0wfT3XmF2Oer7
        cJMCjy7ruRxviTbAMU7zA7/0ygfLe/mGC4z8McLj+Grc/ZStnLUOGkNl/qB27w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617964047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eOpjc/5oLseTKTdow5GlBUGuJdmu0mipYLa59vxGndk=;
        b=jQm1FmUhtRzUuNC2h7XZq1N0M7iqRxC0vYTveTD+qZkwLRMI+WbcFZZrjWZRCTC9yjF5F7
        aWDY036+cjvmzMAw==
From:   "tip-bot2 for Drew Fustini" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/pistachio: Fix trivial typo
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Drew Fustini <drew@beagleboard.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210305090315.384547-1-drew@beagleboard.org>
References: <20210305090315.384547-1-drew@beagleboard.org>
MIME-Version: 1.0
Message-ID: <161796404695.29796.11103155064345782166.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a47d7ef4550d08fb428ea4c3f1a9c71674212208
Gitweb:        https://git.kernel.org/tip/a47d7ef4550d08fb428ea4c3f1a9c71674212208
Author:        Drew Fustini <drew@beagleboard.org>
AuthorDate:    Fri, 05 Mar 2021 01:03:17 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 08 Apr 2021 13:24:15 +02:00

clocksource/drivers/pistachio: Fix trivial typo

Fix trivial typo, rename local variable from 'overflw' to 'overflow' in
pistachio_clocksource_read_cycles().

Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Drew Fustini <drew@beagleboard.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210305090315.384547-1-drew@beagleboard.org
---
 drivers/clocksource/timer-pistachio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-pistachio.c b/drivers/clocksource/timer-pistachio.c
index a2dd85d..6f37181 100644
--- a/drivers/clocksource/timer-pistachio.c
+++ b/drivers/clocksource/timer-pistachio.c
@@ -71,7 +71,7 @@ static u64 notrace
 pistachio_clocksource_read_cycles(struct clocksource *cs)
 {
 	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
-	u32 counter, overflw;
+	u32 counter, overflow;
 	unsigned long flags;
 
 	/*
@@ -80,7 +80,7 @@ pistachio_clocksource_read_cycles(struct clocksource *cs)
 	 */
 
 	raw_spin_lock_irqsave(&pcs->lock, flags);
-	overflw = gpt_readl(pcs->base, TIMER_CURRENT_OVERFLOW_VALUE, 0);
+	overflow = gpt_readl(pcs->base, TIMER_CURRENT_OVERFLOW_VALUE, 0);
 	counter = gpt_readl(pcs->base, TIMER_CURRENT_VALUE, 0);
 	raw_spin_unlock_irqrestore(&pcs->lock, flags);
 
