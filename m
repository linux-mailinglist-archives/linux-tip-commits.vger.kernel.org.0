Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA7D367B29
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Apr 2021 09:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhDVHgh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Apr 2021 03:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhDVHgh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Apr 2021 03:36:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F0BC06174A;
        Thu, 22 Apr 2021 00:36:02 -0700 (PDT)
Date:   Thu, 22 Apr 2021 07:36:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619076961;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ygaHawp8T/kH373vVmhcmax1kMu0V4pX0+2ZN2xTwBM=;
        b=0QoGKYrpZGYtQRY/8RfcgQu65VvETTXQcHaAmWzLNXMsDDz1mnTYEha7P6JHur9C781uTI
        AWKREpCOtgozpw/SROB2NG0oOrvKtSSzwdv8GIYk+Vizf2uOnYwQbas96OCyD6HMoliGPV
        xzQvDuUTTH1z3nTNES3lqzxceXq3cpW63Fyrmgzm8lLfNEdXKKwlSjZvXCwMxjKGUlbRrL
        cyZdu3RyVxmzJbpJCjU9Q6Uv2Rds2q2k7D2LQc5lPzSwwCQjJTyMAzW/ume+Pm7FMyP09f
        MeThcewXpRaCxqi9Fr/ZDP1Q1C7F5DV1WcKFrVyogio5XfTztWxs/uDPk805cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619076961;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ygaHawp8T/kH373vVmhcmax1kMu0V4pX0+2ZN2xTwBM=;
        b=1a84TXPcwE0uJqUvxk35nVxxx2zZ3najR9b0DQzM3uBlfZsbQT+IHpG2/IV7MrWUq0yHuz
        2bRaZMUEImawcOAA==
From:   "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,fair: skip newidle_balance if a wakeup is pending
Cc:     Rik van Riel <riel@surriel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210420120705.5c705d4b@imladris.surriel.com>
References: <20210420120705.5c705d4b@imladris.surriel.com>
MIME-Version: 1.0
Message-ID: <161907696062.29796.108437696048031441.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9c9f520a14670ad59da2f700660f7601ec9e0b07
Gitweb:        https://git.kernel.org/tip/9c9f520a14670ad59da2f700660f7601ec9e0b07
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Tue, 20 Apr 2021 12:07:05 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 Apr 2021 13:55:43 +02:00

sched,fair: skip newidle_balance if a wakeup is pending

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
Link: https://lkml.kernel.org/r/20210420120705.5c705d4b@imladris.surriel.com
---
 kernel/sched/fair.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d75af1..83cd2bd 100644
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
@@ -10684,7 +10693,12 @@ out:
 	if (time_after(this_rq->next_balance, next_balance))
 		this_rq->next_balance = next_balance;
 
-	if (pulled_task)
+	/*
+	 * If we are no longer idle, do not let the time spent here pull
+	 * down this_rq->avg_idle. That could lead to newidle_balance not
+	 * doing enough work, and the CPU actually going idle.
+	 */
+	if (pulled_task || this_rq->ttwu_pending)
 		this_rq->idle_stamp = 0;
 	else
 		nohz_newidle_balance(this_rq);
