Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078603ACFB8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 18:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhFRQF7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 12:05:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57468 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhFRQFz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 12:05:55 -0400
Date:   Fri, 18 Jun 2021 16:03:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624032224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ttwZxfUcJD6yei7VscGx2Gwm5W/BlM6CdYXcjt4qMY4=;
        b=YSbvaHKfwq0Vy6LPhHIFHJouTBsn7IqFZz6XwBb8Oxh7MbX3DCQIkoWfTdowTmygtotmGG
        7dsZXB0WbIqpU/vld3/ULS8CYTPqK6899drY/TkYG20lpYDQ/tq2FnFt7H6l0Qrai7GWyB
        TzbIo9ZI+EIZj+fKMQB0PRRDaDbJWoopcKY9VY6JFpPxpK6KHHHdF6MwSoSjhBm6kawY5y
        ol7mPvlO95CpSUa4BK+0TV9KhjPR8FAOLVYsXdfqJeHhnydV79BrU9y20AnEYKnYqlQT//
        speXKACBRAKR7tHM5Tri11R60MB5ainoLNe4o6M6cvOjm+fsLmtHvFVBZDghAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624032224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ttwZxfUcJD6yei7VscGx2Gwm5W/BlM6CdYXcjt4qMY4=;
        b=cK5GjXK6ahrdOBcIqsBSRSjlPhOiaQBc0dqOiRtjsuFddiCES+KdaN8zseZrwblFr37P55
        up7uNKiSrF2BxmDw==
From:   "tip-bot2 for Jisheng Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Remove
 arch_timer_rate1
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Hulk Robot <hulkci@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210511154856.6afbcb65@xhacker.debian>
References: <20210511154856.6afbcb65@xhacker.debian>
MIME-Version: 1.0
Message-ID: <162403222393.19906.7229170586395782407.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4f9f4f0f6261e4b162dfcaf91e08824a7c93da07
Gitweb:        https://git.kernel.org/tip/4f9f4f0f6261e4b162dfcaf91e08824a7c93da07
Author:        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
AuthorDate:    Tue, 11 May 2021 15:48:56 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 03 Jun 2021 22:15:12 +02:00

clocksource/drivers/arm_arch_timer: Remove arch_timer_rate1

This variable is added by my mistake, it's not used at all.

Fixes: e2bf384d4329 ("clocksource/drivers/arm_arch_timer: Add __ro_after_init and __init")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210511154856.6afbcb65@xhacker.debian
---
 drivers/clocksource/arm_arch_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index fe1a826..89a9e05 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -64,7 +64,6 @@ struct arch_timer {
 #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
 
 static u32 arch_timer_rate __ro_after_init;
-u32 arch_timer_rate1 __ro_after_init;
 static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI] __ro_after_init;
 
 static const char *arch_timer_ppi_names[ARCH_TIMER_MAX_TIMER_PPI] = {
