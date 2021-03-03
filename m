Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C37532C78E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355645AbhCDAcQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842933AbhCCKWk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2885AC08EC2A;
        Wed,  3 Mar 2021 01:49:38 -0800 (PST)
Date:   Wed, 03 Mar 2021 09:49:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614764976;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LYiRjyn+EbB1p5fCEsKZIwXGP+E1mHDDnqUGCE76f10=;
        b=oDpyKWJsjx0alu5NKQU9eo6A2mJ5fV+mRHU424GShL1HkSzdCoz0uakRQlZpDqyuiqD9nw
        qGv3Uv04oNs8NKpuzTrFoISGjiClQb/ozTGlej3iA9dSBcQR6PO8PnCuQv/u5pAcspsI27
        bLm8qAmE1TUYtgmoBkRXG/6eBgFflsqr49uBUmn0BuEMU5pGV1JG8ppyIfrA1dv39w4FE7
        YGYUqX3fUFHaXQ/+N0NmuQ6gMVfxhURQhg7ZbeP3qpFJ1ES3t4sK+47nmCDdr+rnJRulqI
        VN+1UPYONFDI7DTFsOH83J1jp17wuzbj4hN+ppjp0drMW08v0sc8YCJxIhtSqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614764976;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LYiRjyn+EbB1p5fCEsKZIwXGP+E1mHDDnqUGCE76f10=;
        b=A2j8NepkA4rHdpao5GDsytOzuOZMSexCxL+wxlnr+gWLYgkaSmYjrCT4/MKN9XF7PAyZvK
        zgM02td0wgUdAsAg==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/pelt: Fix task util_est update filtering
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210225165820.1377125-1-vincent.donnefort@arm.com>
References: <20210225165820.1377125-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <161476497543.20312.983998070673547869.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9357e217ba642b39ce89f9cd5b5f3e5a21712283
Gitweb:        https://git.kernel.org/tip/9357e217ba642b39ce89f9cd5b5f3e5a21712283
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Thu, 25 Feb 2021 16:58:20 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 10:33:00 +01:00

sched/pelt: Fix task util_est update filtering

Being called for each dequeue, util_est reduces the number of its updates
by filtering out when the EWMA signal is different from the task util_avg
by less than 1%. It is a problem for a sudden util_avg ramp-up. Due to the
decay from a previous high util_avg, EWMA might now be close enough to
the new util_avg. No update would then happen while it would leave
ue.enqueued with an out-of-date value.

Taking into consideration the two util_est members, EWMA and enqueued for
the filtering, ensures, for both, an up-to-date value.

This is for now an issue only for the trace probe that might return the
stale value. Functional-wise, it isn't a problem, as the value is always
accessed through max(enqueued, ewma).

This problem has been observed using LISA's UtilConvergence:test_means on
the sd845c board.

No regression observed with Hackbench on sd845c and Perf-bench sched pipe
on hikey/hikey960.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210225165820.1377125-1-vincent.donnefort@arm.com
---
 kernel/sched/fair.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1af51a6..f5d6541 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3941,6 +3941,8 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
 	trace_sched_util_est_cfs_tp(cfs_rq);
 }
 
+#define UTIL_EST_MARGIN (SCHED_CAPACITY_SCALE / 100)
+
 /*
  * Check if a (signed) value is within a specified (unsigned) margin,
  * based on the observation that:
@@ -3958,7 +3960,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 				   struct task_struct *p,
 				   bool task_sleep)
 {
-	long last_ewma_diff;
+	long last_ewma_diff, last_enqueued_diff;
 	struct util_est ue;
 
 	if (!sched_feat(UTIL_EST))
@@ -3979,6 +3981,8 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	if (ue.enqueued & UTIL_AVG_UNCHANGED)
 		return;
 
+	last_enqueued_diff = ue.enqueued;
+
 	/*
 	 * Reset EWMA on utilization increases, the moving average is used only
 	 * to smooth utilization decreases.
@@ -3992,12 +3996,17 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	}
 
 	/*
-	 * Skip update of task's estimated utilization when its EWMA is
+	 * Skip update of task's estimated utilization when its members are
 	 * already ~1% close to its last activation value.
 	 */
 	last_ewma_diff = ue.enqueued - ue.ewma;
-	if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
+	last_enqueued_diff -= ue.enqueued;
+	if (within_margin(last_ewma_diff, UTIL_EST_MARGIN)) {
+		if (!within_margin(last_enqueued_diff, UTIL_EST_MARGIN))
+			goto done;
+
 		return;
+	}
 
 	/*
 	 * To avoid overestimation of actual task utilization, skip updates if
