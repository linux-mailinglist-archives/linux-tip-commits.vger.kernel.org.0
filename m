Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499B932B057
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhCCDhT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378857AbhCBJDa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 04:03:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC11C0617A9;
        Tue,  2 Mar 2021 01:01:58 -0800 (PST)
Date:   Tue, 02 Mar 2021 09:01:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614675716;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gL2L6mzB88JT9RgI7oNm8yR02xN4CGy+373opBtjD0A=;
        b=sgX7aRna8p6A33gDu+Rn1AzbQP6CuNUoA5EL4VoqKk3so2FwhuQgIqdO7Y57b7kdVtmKxH
        a5eZBq+WQGZM/9Q99xctxIA1WDVw3cekKC062k4DW21mqbW/52sY0/1v/tUyFQmF0QMQdq
        uu5TFoixWHzEFa/Ei9yrjNmKvhqrMfHzbNompFRtlVItduKp3N1Q7IZ5ymmuy8leXmyTWP
        iAPXP0pQjxHLQE7tSnOqcmhF6fUiHQBbL0yEamDzTPHRzKXcbawjJHaOcO4c9WJ9rQw1+I
        bqRLrjY4MgaYLipfYXWeRS1/eceeK9ptU3AlgnvE/8HguwQydQHkkLdoi5iHUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614675716;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gL2L6mzB88JT9RgI7oNm8yR02xN4CGy+373opBtjD0A=;
        b=lBn/NQJcj8kxjXgV73skej0sENNZGAAw8EMGmdQKpdfF9hnpWW/XOob3r7EBqJuVPva07H
        fv3obsNFbVQ/DDBw==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove update of blocked load from
 newidle_balance
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224133007.28644-2-vincent.guittot@linaro.org>
References: <20210224133007.28644-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <161467571597.20312.15461052399950119430.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     06a35afe89800789fc47ca5c41fbe435cc77d8e0
Gitweb:        https://git.kernel.org/tip/06a35afe89800789fc47ca5c41fbe435cc77d8e0
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 24 Feb 2021 14:30:01 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 18:17:23 +01:00

sched/fair: Remove update of blocked load from newidle_balance

newidle_balance runs with both preempt and irq disabled which prevent
local irq to run during this period. The duration for updating the
blocked load of CPUs varies according to the number of CPU cgroups
with non-decayed load and extends this critical period to an uncontrolled
level.

Remove the update from newidle_balance and trigger a normal ILB that
will take care of the update instead.

This reduces the IRQ latency from O(nr_cgroups * nr_nohz_cpus) to
O(nr_cgroups).

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224133007.28644-2-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb..806e16f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7392,8 +7392,6 @@ enum migration_type {
 #define LBF_NEED_BREAK	0x02
 #define LBF_DST_PINNED  0x04
 #define LBF_SOME_PINNED	0x08
-#define LBF_NOHZ_STATS	0x10
-#define LBF_NOHZ_AGAIN	0x20
 
 struct lb_env {
 	struct sched_domain	*sd;
@@ -8397,9 +8395,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
 
-		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq, false))
-			env->flags |= LBF_NOHZ_AGAIN;
-
 		sgs->group_load += cpu_load(rq);
 		sgs->group_util += cpu_util(i);
 		sgs->group_runnable += cpu_runnable(rq);
@@ -8940,11 +8935,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sg_lb_stats tmp_sgs;
 	int sg_status = 0;
 
-#ifdef CONFIG_NO_HZ_COMMON
-	if (env->idle == CPU_NEWLY_IDLE && READ_ONCE(nohz.has_blocked))
-		env->flags |= LBF_NOHZ_STATS;
-#endif
-
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
 		int local_group;
@@ -8981,14 +8971,6 @@ next_group:
 	/* Tag domain that child domain prefers tasks go to siblings first */
 	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
 
-#ifdef CONFIG_NO_HZ_COMMON
-	if ((env->flags & LBF_NOHZ_AGAIN) &&
-	    cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd))) {
-
-		WRITE_ONCE(nohz.next_blocked,
-			   jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD));
-	}
-#endif
 
 	if (env->sd->flags & SD_NUMA)
 		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
@@ -10517,16 +10499,11 @@ static void nohz_newidle_balance(struct rq *this_rq)
 	    time_before(jiffies, READ_ONCE(nohz.next_blocked)))
 		return;
 
-	raw_spin_unlock(&this_rq->lock);
 	/*
-	 * This CPU is going to be idle and blocked load of idle CPUs
-	 * need to be updated. Run the ilb locally as it is a good
-	 * candidate for ilb instead of waking up another idle CPU.
-	 * Kick an normal ilb if we failed to do the update.
+	 * Blocked load of idle CPUs need to be updated.
+	 * Kick an ILB to update statistics.
 	 */
-	if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
-		kick_ilb(NOHZ_STATS_KICK);
-	raw_spin_lock(&this_rq->lock);
+	kick_ilb(NOHZ_STATS_KICK);
 }
 
 #else /* !CONFIG_NO_HZ_COMMON */
@@ -10587,8 +10564,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 			update_next_balance(sd, &next_balance);
 		rcu_read_unlock();
 
-		nohz_newidle_balance(this_rq);
-
 		goto out;
 	}
 
@@ -10654,6 +10629,8 @@ out:
 
 	if (pulled_task)
 		this_rq->idle_stamp = 0;
+	else
+		nohz_newidle_balance(this_rq);
 
 	rq_repin_lock(this_rq, rf);
 
