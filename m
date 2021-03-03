Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E7F32C78A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243190AbhCDAcO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842925AbhCCKWg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927FDC08EC44;
        Wed,  3 Mar 2021 01:49:40 -0800 (PST)
Date:   Wed, 03 Mar 2021 09:49:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614764979;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hTABHRhSxorg5dEuIvf42wRxUExBongMRqDYhCdL28U=;
        b=q9XMpYOMK0nyDwxbgnrRPA/IAEdbY6FoOWKBt6tfKbr67sMMnUYV0+Wo1jkVbd3NkcoaCb
        tpFGzYNHhhDiaPbcHsUd7VfsEBbEuTtVOLPhKwOx9Ab2jAgIHXsJFfBQmwgqcUm+9jQBzE
        KahRAVLZFW7obh0rkYklsZYJjtd/7PRGb5NBL+a7YY/VtTmjNkkV7zK5R+hr6nUO2TvIk3
        9s0lVyvViz60WHApQoJvpND1f6yoik/LB8yTXKCW6s0p9Ozx9ZhaDp56TO7Ds48C23RBVe
        j3vtfi3v2+4sv2xi9/sqr3I1vNHlEVZKd7ul/DqayGBHbPW14/aZ0jVaWH/UNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614764979;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hTABHRhSxorg5dEuIvf42wRxUExBongMRqDYhCdL28U=;
        b=lNTIDEKh0NbFjQ75V8kEfbCCGGl/f8stYkMTUitjWVipN5ZY7cjSCmE2tUrdSAOCqBsjIv
        uWJg/tXesYiLrODA==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove unused return of _nohz_idle_balance
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224133007.28644-3-vincent.guittot@linaro.org>
References: <20210224133007.28644-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <161476497862.20312.13726115341819502260.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f2c0af1dabdae4674fb7ddba0ac88ca78d0fe675
Gitweb:        https://git.kernel.org/tip/f2c0af1dabdae4674fb7ddba0ac88ca78d0fe675
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 24 Feb 2021 14:30:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 10:32:59 +01:00

sched/fair: Remove unused return of _nohz_idle_balance

The return of _nohz_idle_balance() is not used anymore so we can remove
it

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224133007.28644-3-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 806e16f..6a458e9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10354,10 +10354,8 @@ out:
  * Internal function that runs load balance for all idle cpus. The load balance
  * can be a simple update of blocked load or a complete load balance with
  * tasks movement depending of flags.
- * The function returns false if the loop has stopped before running
- * through all idle CPUs.
  */
-static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
+static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 			       enum cpu_idle_type idle)
 {
 	/* Earliest time when we have to do rebalance again */
@@ -10367,7 +10365,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	int update_next_balance = 0;
 	int this_cpu = this_rq->cpu;
 	int balance_cpu;
-	int ret = false;
 	struct rq *rq;
 
 	SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
@@ -10447,15 +10444,10 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	WRITE_ONCE(nohz.next_blocked,
 		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
 
-	/* The full idle balance loop has been done */
-	ret = true;
-
 abort:
 	/* There is still blocked load, enable periodic update */
 	if (has_blocked_load)
 		WRITE_ONCE(nohz.has_blocked, 1);
-
-	return ret;
 }
 
 /*
