Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD5832B051
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhCCDhO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:37:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35704 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378835AbhCBJD0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 04:03:26 -0500
Date:   Tue, 02 Mar 2021 09:01:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614675716;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/sybR9nsvB35T/F1HG+zdLQgZ1CBfNipke2xlswkYJ4=;
        b=EFWEaVzEnqyB2T1c1EWOIuc46u1uqlZab9ucEB2vRFR2FFBYVBl9pksOXr1BOraL57rfmk
        Zq5y+k2yLvy3HSl50Iwzjw9Yqn8bHEWI2jysRReHnHl0iqUUxPMkiUBpToZWVuW3ePXP4g
        EmidqvYFnPNSOmZgoOBUhaR+h+HooEmc5jAhffzKPUYJPs3XwIDtw7DjKs5PZiDmermUv7
        t5seYRRXRe4D/REw/SQJO5Bov9g1dVQviF4ECjDm4GciYornYKFY7rN0/ar+L95iRNlNg8
        wFRHHdyakMSgf0gZADARzSOfp3b767uhT1YhxyIMvUQV20MZE/deFXoXPuvPNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614675716;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/sybR9nsvB35T/F1HG+zdLQgZ1CBfNipke2xlswkYJ4=;
        b=SKXvlH+5NbTMyjH/ZvUsMiGpsTEQz39mCeNxV6JG9r0dceTfVDm8wH4yaK+rc8/Oabp7Vu
        bSpmssy3WsN7ffBQ==
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
Message-ID: <161467571544.20312.5783812537772586397.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8af3f0fbfbaa3b78bb1fc577ee42c3228f3cc822
Gitweb:        https://git.kernel.org/tip/8af3f0fbfbaa3b78bb1fc577ee42c3228f3cc822
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 24 Feb 2021 14:30:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 18:17:23 +01:00

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
