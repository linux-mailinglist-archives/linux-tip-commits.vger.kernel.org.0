Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8A932C7BD
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355680AbhCDAcm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843041AbhCCKYt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:24:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAEEC08EC63;
        Wed,  3 Mar 2021 01:49:41 -0800 (PST)
Date:   Wed, 03 Mar 2021 09:49:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614764978;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spJYzG0V8FSe/RlhfwMuPJRjOyZ9c5I0F92XeiinPzo=;
        b=faXby6FoN6qzl8t+/wGc5FMwyoRiVJYKYGJwK4KC+9duU3zvgI9VaS6C2Ng/BXZgMxVvgT
        OlKnSfl1Csm72FW9klpdDeX8Btb06gY/kfDxE1qOfk9fd8t73L88nUhzi7pzEGUWAIFyZM
        YF7Fxs+QY/xbkaezfdypGaDQ06TE53YvIvrlwwMLlF6d30nh5B2QvFcZ7kloUApptqEKs1
        2V16I74gvj5isk/PFSYPC4R59YCPlY01hEdeTvi0gFdy5JDuB52F0bVTCeeHJnVsPp38qX
        GQmrp9EiV6gjNyi4y0UkZjLVdjfK6a9qoAdjT2ifLt6gKydiY0eaJdTOu2jYbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614764978;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spJYzG0V8FSe/RlhfwMuPJRjOyZ9c5I0F92XeiinPzo=;
        b=dQqIng2ZvpR/JWWXlzJI+i+7ZS1Zg4EN22lcoxqGbKpSHvgRsRK6coiCi7ieBAw6IeTIHa
        wnCYi0Yz19b4utCw==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove unused parameter of update_nohz_stats
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224133007.28644-4-vincent.guittot@linaro.org>
References: <20210224133007.28644-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <161476497823.20312.8194834492699718515.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     21c5d27a4c5d9fddb2c35ccdd5cddc11b75f753d
Gitweb:        https://git.kernel.org/tip/21c5d27a4c5d9fddb2c35ccdd5cddc11b75f753d
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 24 Feb 2021 14:30:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 10:32:59 +01:00

sched/fair: Remove unused parameter of update_nohz_stats

idle load balance is the only user of update_nohz_stats and doesn't use
force parameter. Remove it

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224133007.28644-4-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6a458e9..1b91030 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8352,7 +8352,7 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
 
-static bool update_nohz_stats(struct rq *rq, bool force)
+static bool update_nohz_stats(struct rq *rq)
 {
 #ifdef CONFIG_NO_HZ_COMMON
 	unsigned int cpu = rq->cpu;
@@ -8363,7 +8363,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
 	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
 		return false;
 
-	if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick))
+	if (!time_after(jiffies, rq->last_blocked_load_update_tick))
 		return true;
 
 	update_blocked_averages(cpu);
@@ -10401,7 +10401,7 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 
 		rq = cpu_rq(balance_cpu);
 
-		has_blocked_load |= update_nohz_stats(rq, true);
+		has_blocked_load |= update_nohz_stats(rq);
 
 		/*
 		 * If time for next balance is due,
