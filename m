Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE5C440DC1
	for <lists+linux-tip-commits@lfdr.de>; Sun, 31 Oct 2021 11:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhJaKS7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 31 Oct 2021 06:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhJaKS7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 31 Oct 2021 06:18:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81149C061714;
        Sun, 31 Oct 2021 03:16:27 -0700 (PDT)
Date:   Sun, 31 Oct 2021 10:16:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635675385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ZLpN3sHVB4W40wqrPn0vVBgzb8YZ4HVDFiUeXMVVh4=;
        b=Zk3JvXiMqln8G8roUGM5rQ9TcdX69IdXTyR41jgYL5zaOoNAxg91ODO1Bn7VhNI9g3Sy8q
        jNwas8F0GPRMS/VWtc7gMI0iqNjP7KMFyJCeAZSkoZWVkmT0elsU/unYEZ3Xvibn4OG5Gr
        LwrJ3CoaoRZvxsT7ovUNAWXgUbsf9codrR9OlPvxg+Axyc52JyKfggKd+LZ6YS+y8Pe45W
        AmLvCLcT87PoUwU82zkaEviupQ3wBD4hds9KBwep/o2fSZz8KeSvzzlbIHWEvLXjdnSi1F
        ZmojOdb9Pckg6syqP/jcx8Fp0JLjKWbHG/dqsOrr48IPkE2K6dIXKMxKDnAWDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635675385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ZLpN3sHVB4W40wqrPn0vVBgzb8YZ4HVDFiUeXMVVh4=;
        b=t9JN2r8IdyTC6BX9qTI0+xNArY+Jh56ojnsTwF+4NPfuIr06+hwlFGwgxzGETjnJKmaBzj
        uJRLUbWecC6f8EAg==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Cleanup newidle_balance
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211019123537.17146-6-vincent.guittot@linaro.org>
References: <20211019123537.17146-6-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <163567538377.626.7918130057155925733.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8ea9183db4ad8afbcb7089a77c23eaf965b0cacd
Gitweb:        https://git.kernel.org/tip/8ea9183db4ad8afbcb7089a77c23eaf965b0cacd
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 19 Oct 2021 14:35:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 31 Oct 2021 11:11:38 +01:00

sched/fair: Cleanup newidle_balance

update_next_balance() uses sd->last_balance which is not modified by
load_balance() so we can merge the 2 calls in one place.

No functional change

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20211019123537.17146-6-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 57eae0e..13950be 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10916,10 +10916,10 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		int continue_balancing = 1;
 		u64 domain_cost;
 
-		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
-			update_next_balance(sd, &next_balance);
+		update_next_balance(sd, &next_balance);
+
+		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
 			break;
-		}
 
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
 
@@ -10935,8 +10935,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 			t0 = t1;
 		}
 
-		update_next_balance(sd, &next_balance);
-
 		/*
 		 * Stop searching for tasks to pull if there are
 		 * now runnable tasks on this rq.
