Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE9B32F9F5
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhCFLma (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34280 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhCFLmW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:22 -0500
Date:   Sat, 06 Mar 2021 11:42:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030941;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=trxFQB8QUuSivL5J71BUEOmqr0J1API3E+ON47ryfb0=;
        b=lc4UXGNSLJdsx+qvpqA2vpiZXV+z+FEwYkShsWNnzQUYoU4smZNr3fmNxgJXt7b2LFhqnj
        A586dCtahoUa8Sjvf9q4Ao0urBynZGEunpkYHVkVPyLvw6VqSTT5bC/1S8wMeWdN5Rd3nb
        gbVzQ70KM6XlXTj0RpfmOdMtJ0qxuaRspux8MzOInQFAZoChuK+YFpJ2fc8+AqGZtr0WEs
        Rgbr8owTIh8APfv+uXZREKnoWVl2Xn3BSCrikSPsu0hYwg6tavnfBf0bEYysqaKFtRxqmg
        tdvRCITBO65EiENYHM2gXfFaQoIJeZ0cH86Vw17hd+U7iJwZjWsbCdV09/SMYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030941;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=trxFQB8QUuSivL5J71BUEOmqr0J1API3E+ON47ryfb0=;
        b=P4on0JT7wZASFA97cRB18/clQk2Mx1JMVGDV5KyBSpWEdytPwhKZSQfVo7OHSoRv1lyERd
        0tracpfQCc1JMdDw==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/pelt: Fix task util_est update filtering
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210225165820.1377125-1-vincent.donnefort@arm.com>
References: <20210225165820.1377125-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <161503094077.398.18057493289217956874.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b89997aa88f0b07d8a6414c908af75062103b8c9
Gitweb:        https://git.kernel.org/tip/b89997aa88f0b07d8a6414c908af75062103b8c9
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Thu, 25 Feb 2021 16:58:20 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:22 +01:00

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
