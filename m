Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AC932B02E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbhCCDeV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:34:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35676 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378834AbhCBJD0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 04:03:26 -0500
Date:   Tue, 02 Mar 2021 09:01:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614675715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lnQBqspKnaJ5Y75c1V9aAxjYCtEOnrvS+l3yIJtyQ28=;
        b=OM1BqwLs8t06fQo6N7Aq2Ch1HL9MKECqcUmNUlDSmsJQ0jlZG3JHwjthZaN6VQ2HQBKyQn
        9aeUV70JfbuDfN5rRj2LyGvuyhmXOvud4+TXEHB23leWJxphhlxE2iLky/drqP82UxxloC
        jaiNWUWJ86mXPApEkQvSkeVFXD1WBedN/Bt9BGDi3v6kCncMkTtZG69lrrCD+Y7X0ENxbN
        l18DFp2RaobeTJM+Sir0TXxnW8FVgf/1bddX+fVhnE8in3A57ZfJk2xZGVRS0Tf2vCnAKN
        W2Azwq3YNcxfxqo2cXi5WfAefsO2xFpsB3E1bsYSm/8M0SZ6z+zNqRazkD0uZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614675715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lnQBqspKnaJ5Y75c1V9aAxjYCtEOnrvS+l3yIJtyQ28=;
        b=CcuMzFWWjHO6MAIyvJMIrePmMOnfG+6C3AEyPSbqB7Xv/WAbS+INpc728mE5noNNbZvjz4
        WUQQnfbmF+51igBw==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Reorder newidle_balance pulled_task tests
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224133007.28644-6-vincent.guittot@linaro.org>
References: <20210224133007.28644-6-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <161467571486.20312.3954173688719118401.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0c067f38e1b9640e9121fb7e0bb38fa8f867a248
Gitweb:        https://git.kernel.org/tip/0c067f38e1b9640e9121fb7e0bb38fa8f867a248
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 24 Feb 2021 14:30:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 18:17:24 +01:00

sched/fair: Reorder newidle_balance pulled_task tests

Reorder the tests and skip useless ones when no load balance has been
performed and rq lock has not been released.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224133007.28644-6-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3c00918..356a245 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10584,7 +10584,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost = curr_cost;
 
-out:
 	/*
 	 * While browsing the domains, we released the rq lock, a task could
 	 * have been enqueued in the meantime. Since we're not going idle,
@@ -10593,14 +10592,15 @@ out:
 	if (this_rq->cfs.h_nr_running && !pulled_task)
 		pulled_task = 1;
 
-	/* Move the next balance forward */
-	if (time_after(this_rq->next_balance, next_balance))
-		this_rq->next_balance = next_balance;
-
 	/* Is there a task of a high priority class? */
 	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
 		pulled_task = -1;
 
+out:
+	/* Move the next balance forward */
+	if (time_after(this_rq->next_balance, next_balance))
+		this_rq->next_balance = next_balance;
+
 	if (pulled_task)
 		this_rq->idle_stamp = 0;
 	else
