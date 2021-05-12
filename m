Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A01437BA78
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhELK3y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhELK3o (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E3BC06138A;
        Wed, 12 May 2021 03:28:34 -0700 (PDT)
Date:   Wed, 12 May 2021 10:28:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815313;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QUbtj+67oIgzC72oHOblgVSsmsRE/xeTfB45TSqaACI=;
        b=hAA4gBM2vxevPUcUhXgCQqybzZVe7gG6bK+JA6c+Fs3XKUmrvEEjPW7qR9SxPteB4rZ3fe
        XB2vO4W9mBjFU8E+vtyUzecYcR+mIyMxIBbTg3FpvzO96zgfpdCzCPOjTmJV1ptbXVutBw
        eeLsKuCuzFvxTqZc2A8sBAjssild+RkLNVJRvnVVefI+PP2pj2aFjZ01K5fOKWDivt52oR
        Dj73MCwTLC06uIBNUtpYNZSodkdnA4cv14bc4/UYjJdB4HxFIWDFPuZZFI45HTnWxO/qdB
        F7Rw4s5v+8iFTaGgPy8/pfIqefMtFLcrFFd+nnKeH3l7sl0XCvseQymym8XmDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815313;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QUbtj+67oIgzC72oHOblgVSsmsRE/xeTfB45TSqaACI=;
        b=VZ+y2uX6FXOy5Rf+Oz9FaBpzZxfnqezY7427ygcqd/MegSxuNDHBEviZznkydLmZFqQg0Y
        BA/L/YCdsHMUGeAQ==
From:   "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,fair: Skip newidle_balance if a wakeup is pending
Cc:     Rik van Riel <riel@surriel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422130236.0bb353df@imladris.surriel.com>
References: <20210422130236.0bb353df@imladris.surriel.com>
MIME-Version: 1.0
Message-ID: <162081531253.29796.98482466243425223.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e5e678e4fea26d73444f4427cbbaeab4fa79ecee
Gitweb:        https://git.kernel.org/tip/e5e678e4fea26d73444f4427cbbaeab4fa79ecee
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Thu, 22 Apr 2021 13:02:36 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:23 +02:00

sched,fair: Skip newidle_balance if a wakeup is pending

The try_to_wake_up function has an optimization where it can queue
a task for wakeup on its previous CPU, if the task is still in the
middle of going to sleep inside schedule().

Once schedule() re-enables IRQs, the task will be woken up with an
IPI, and placed back on the runqueue.

If we have such a wakeup pending, there is no need to search other
CPUs for runnable tasks. Just skip (or bail out early from) newidle
balancing, and run the just woken up task.

For a memcache like workload test, this reduces total CPU use by
about 2%, proportionally split between user and system time,
and p99 and p95 application response time by 10% on average.
The schedstats run_delay number shows a similar improvement.

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/20210422130236.0bb353df@imladris.surriel.com
---
 kernel/sched/fair.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3248e24..d10c6cc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10592,6 +10592,14 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	u64 curr_cost = 0;
 
 	update_misfit_status(NULL, this_rq);
+
+	/*
+	 * There is a task waiting to run. No need to search for one.
+	 * Return 0; the task will be enqueued when switching to idle.
+	 */
+	if (this_rq->ttwu_pending)
+		return 0;
+
 	/*
 	 * We must set idle_stamp _before_ calling idle_balance(), such that we
 	 * measure the duration of idle_balance() as idle time.
@@ -10657,7 +10665,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		 * Stop searching for tasks to pull if there are
 		 * now runnable tasks on this rq.
 		 */
-		if (pulled_task || this_rq->nr_running > 0)
+		if (pulled_task || this_rq->nr_running > 0 ||
+		    this_rq->ttwu_pending)
 			break;
 	}
 	rcu_read_unlock();
