Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA173ACFAA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhFRQFu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 12:05:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57364 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhFRQFt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 12:05:49 -0400
Date:   Fri, 18 Jun 2021 16:03:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624032218;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zx6fC5m/1KenoPpaubnraLUKe5jyt3bCNVqLv/9YqOE=;
        b=WOUe0tCTx2V+POPDXIKS0SGosqHGfbYVNC3CXdam5jIqavjA+L5hp/SpeKmCrwaWcD4Zbz
        KxMKVrfnpK65ffMU5QcAPsq3eD01DivhNAKf8SM2SM21pRc1tHGdCp2O0NLooKjng2+J7L
        USV+j+8/hhQMMEnXDyyWJ1TmVp1ElNeby68NI8vBQ/z3gl4UH/rV1VYXtaRuzbxGReRvOq
        Xg5kCQLbyv00MEp0ptE9vnH/20YijqYtujnjNDXR2LDanQQjZIxRK5PppBh1mMUV70TAS+
        6hy+eTgUAOKD8UNLyvMMF/CmnlI+p+3t7V9Lk+sgr5KhDf5peJYSLfWTnP9J0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624032218;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zx6fC5m/1KenoPpaubnraLUKe5jyt3bCNVqLv/9YqOE=;
        b=sXbWPQtk9ZCkKs05/jjtwUHIIr75PS3VE0dUiD97HFvMSpi+of4b41XadwIELP9BlW+hnj
        bcyNqnJ0X2eYprCA==
From:   "tip-bot2 for Zou Wei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_global_timer: Make symbol
 'gt_clk_rate_change_nb' static
Cc:     Hulk Robot <hulkci@huawei.com>, Zou Wei <zou_wei@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1623490046-37972-1-git-send-email-zou_wei@huawei.com>
References: <1623490046-37972-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Message-ID: <162403221797.19906.14772536901646306415.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     be534f8ee137b95046d7c53c8200ffdcf05781a7
Gitweb:        https://git.kernel.org/tip/be534f8ee137b95046d7c53c8200ffdcf05781a7
Author:        Zou Wei <zou_wei@huawei.com>
AuthorDate:    Sat, 12 Jun 2021 17:27:26 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 16 Jun 2021 17:33:04 +02:00

clocksource/drivers/arm_global_timer: Make symbol 'gt_clk_rate_change_nb' static

The sparse tool complains as follows:

drivers/clocksource/arm_global_timer.c:54:23: warning:
 symbol 'gt_clk_rate_change_nb' was not declared. Should it be static?

This symbol is not used outside of arm_global_timer.c, so mark it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1623490046-37972-1-git-send-email-zou_wei@huawei.com
---
 drivers/clocksource/arm_global_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 60a8047..68b1d14 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -51,7 +51,7 @@
  * the units for all operations.
  */
 static void __iomem *gt_base;
-struct notifier_block gt_clk_rate_change_nb;
+static struct notifier_block gt_clk_rate_change_nb;
 static u32 gt_psv_new, gt_psv_bck, gt_target_rate;
 static int gt_ppi;
 static struct clock_event_device __percpu *gt_evt;
