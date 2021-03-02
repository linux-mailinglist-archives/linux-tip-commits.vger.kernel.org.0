Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5600D32B04C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350746AbhCCDgZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:36:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35706 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378836AbhCBJD0 (ORCPT
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
        bh=P7gaYykhRHnsJhH5SPiJe0AUCkbEO0XbXOQe32bnpYk=;
        b=AhtNWDi35ZD6gGTf29zdB7b4mNFcLu8jhscNJiQQPl4BsYTg+DQCCDzdds8HuaZOsXT6ZK
        gJLu4/eISJgmVseT+4+wxeXCNi7ZlGl2dx0ujDfetCeGoIf+iYkB5Xe2B+MkZ5R+ezWewT
        mVhu20zsa8FHYldRwas8jMNyVDINOUK4jr5IPkLQgYdxftHanAnAEKtzvZ6T2yuNw5cVD/
        ovu5WatsY+yqaVC00uwBol7Sl00T1PcC5POb3id0xRC48vBs2y28BYM5DoL1V8HQjEJNoa
        oXEA4e+SALjlepycTUUGfCSKtWoO7rOV9flKvGWtGI7u8Vjw/GviMhG3OQNH+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614675716;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P7gaYykhRHnsJhH5SPiJe0AUCkbEO0XbXOQe32bnpYk=;
        b=0u34UPBLc0cWvrzWlDzkaPTwuSAeMNkUXH+gUBDD0m23cdJUproLKvnmaDpdoKEbQyL5AA
        gYaS6pIBbT5NmlBw==
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
Message-ID: <161467571573.20312.16499976125264525563.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     81df323258719a0194fadbf4aa93e213a552e460
Gitweb:        https://git.kernel.org/tip/81df323258719a0194fadbf4aa93e213a552e460
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 24 Feb 2021 14:30:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 18:17:23 +01:00

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
