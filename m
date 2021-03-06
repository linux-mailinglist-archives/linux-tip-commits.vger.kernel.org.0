Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B01A32FA0B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhCFLmf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhCFLmZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E236BC061760;
        Sat,  6 Mar 2021 03:42:24 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:42:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qsw2WE1+MvXulfIXG8A3/jUIUo5ACxc908hJJVX9mA8=;
        b=FomlMWEGidlKAWkqPNhQYPDH69UaJrTnURfC11D0NQYpm1hqHPvqaLLQUiPi0voEBRfnyp
        mtdLP3A3JjkvMGmvntQJY8Zih4yDA/Q01Zb9VOMiTgPvxjStBbAlp1iA4sZVlic/XiKItf
        zaTv0Z5qwq+X3QG3+5zhra84ZbAo84jW1mH2zqqCuO0sxj0zCaguPXKNHSgzXEzFUng4R3
        TJDruHJFaHs6gmxamK0Gtn1VSHlLBxyZImwnsOh6BiZ/64qeN55vXB73tKrXgK2uoD9YME
        eEYJKNAKNs+Pe4RHgme/A6iJXFXSuIubBXEJgrwKKljdBjC0+4RMHr70hfn3zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qsw2WE1+MvXulfIXG8A3/jUIUo5ACxc908hJJVX9mA8=;
        b=X3rj9nWmxketGkKyCs8/hkCpGfVw7L0oWGILmAtyfY9DsETJ1B0YrlLcBoilkCRfZ2CI4r
        Un22FErI4KFlplDg==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Reorder newidle_balance pulled_task tests
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224133007.28644-6-vincent.guittot@linaro.org>
References: <20210224133007.28644-6-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <161503094242.398.15769339852881637506.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6553fc18179113a11835d5fde1735259f8943a55
Gitweb:        https://git.kernel.org/tip/6553fc18179113a11835d5fde1735259f8943a55
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 24 Feb 2021 14:30:05 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:21 +01:00

sched/fair: Reorder newidle_balance pulled_task tests

Reorder the tests and skip useless ones when no load balance has been
performed and rq lock has not been released.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
