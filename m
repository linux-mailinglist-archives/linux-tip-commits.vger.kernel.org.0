Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58A437BA77
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhELK3x (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50400 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhELK3l (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:41 -0400
Date:   Wed, 12 May 2021 10:28:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K4oBgIsjQwEosAJqX2F4TZhKbU8JPG85TZpmEdlyPmI=;
        b=3Nvmry3yl6FzpDJgTn7ZoxJb2yyOOGQCdRziIAT9IbsctycTPgxW+CSIZZPoKo6+e7RnGh
        CkEt/F3xRjffC4aVESdtga23M4OB5mHeSW0SlTWJilVs5f46B1+UzwleHdQcAl6nCjx/XN
        2Yqya8xBCx2sNfX3m64lcMEC4E5Oejg52/rXNNxREVHkZQlQeEz91y6WJP+3I0MtD2tI/h
        Qnixim4eoQ1PCsPDzoc7TSY7qPmuO1JW1gggf5tT/l2tpG/e9Q59LU/PYfqCSY0cfhQmUY
        hXaL3QZDvC7l2tLLz60jQDX5a9T2S0AfWwKYGmJGI40uNbf4EjKo8E/EKGDrug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K4oBgIsjQwEosAJqX2F4TZhKbU8JPG85TZpmEdlyPmI=;
        b=lCrCUf+MWY6eFkZYmBqdBg8EFGkCC2F3EHfBEuAp7CRWqRs4ror8tMlJgo8p7XgFvrJ9la
        NlN80iXsDF1PXxAw==
From:   "tip-bot2 for Pierre Gondois" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix negative energy delta in
 find_energy_efficient_cpu()
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210504090743.9688-3-Pierre.Gondois@arm.com>
References: <20210504090743.9688-3-Pierre.Gondois@arm.com>
MIME-Version: 1.0
Message-ID: <162081531169.29796.8830310821003652693.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     619e090c8e409e09bd3e8edcd5a73d83f689890c
Gitweb:        https://git.kernel.org/tip/619e090c8e409e09bd3e8edcd5a73d83f689890c
Author:        Pierre Gondois <Pierre.Gondois@arm.com>
AuthorDate:    Tue, 04 May 2021 10:07:43 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:23 +02:00

sched/fair: Fix negative energy delta in find_energy_efficient_cpu()

find_energy_efficient_cpu() (feec()) searches the best energy CPU
to place a task on. To do so, compute_energy() estimates the energy
impact of placing the task on a CPU, based on CPU and task utilization
signals.

Utilization signals can be concurrently updated while evaluating a
performance domain (pd). In some cases, this leads to having a
'negative delta', i.e. placing the task in the pd is seen as an
energy gain. Thus, any further energy comparison is biased.

In case of a 'negative delta', return prev_cpu since:
1. a 'negative delta' happens in less than 0.5% of feec() calls,
   on a Juno with 6 CPUs (4 little, 2 big)
2. it is unlikely to have two consecutive 'negative delta' for
   a task, so if the first call fails, feec() will correctly
   place the task in the next feec() call
3. EAS current behavior tends to select prev_cpu if the task
   doesn't raise the OPP of its current pd. prev_cpu is EAS's
   generic decision
4. prev_cpu should be preferred to returning an error code.
   In the latter case, select_idle_sibling() would do the placement,
   selecting a big (and not energy efficient) CPU. As 3., the task
   would potentially reside on the big CPU for a long time

Reported-by: Xuewen Yan <xuewen.yan@unisoc.com>
Suggested-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Donnefort <vincent.donnefort@arm.com>
Link: https://lkml.kernel.org/r/20210504090743.9688-3-Pierre.Gondois@arm.com
---
 kernel/sched/fair.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b229d0c..c209f68 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6661,15 +6661,15 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
 	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
 	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
+	int cpu, best_energy_cpu = prev_cpu, target = -1;
 	unsigned long cpu_cap, util, base_energy = 0;
-	int cpu, best_energy_cpu = prev_cpu;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
 
 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
 	if (!pd || READ_ONCE(rd->overutilized))
-		goto fail;
+		goto unlock;
 
 	/*
 	 * Energy-aware wake-up happens on the lowest sched_domain starting
@@ -6679,7 +6679,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	while (sd && !cpumask_test_cpu(prev_cpu, sched_domain_span(sd)))
 		sd = sd->parent;
 	if (!sd)
-		goto fail;
+		goto unlock;
+
+	target = prev_cpu;
 
 	sync_entity_load_avg(&p->se);
 	if (!task_util_est(p))
@@ -6734,6 +6736,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		/* Evaluate the energy impact of using prev_cpu. */
 		if (compute_prev_delta) {
 			prev_delta = compute_energy(p, prev_cpu, pd);
+			if (prev_delta < base_energy_pd)
+				goto unlock;
 			prev_delta -= base_energy_pd;
 			best_delta = min(best_delta, prev_delta);
 		}
@@ -6741,6 +6745,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		/* Evaluate the energy impact of using max_spare_cap_cpu. */
 		if (max_spare_cap_cpu >= 0) {
 			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
+			if (cur_delta < base_energy_pd)
+				goto unlock;
 			cur_delta -= base_energy_pd;
 			if (cur_delta < best_delta) {
 				best_delta = cur_delta;
@@ -6748,25 +6754,22 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			}
 		}
 	}
-unlock:
 	rcu_read_unlock();
 
 	/*
 	 * Pick the best CPU if prev_cpu cannot be used, or if it saves at
 	 * least 6% of the energy used by prev_cpu.
 	 */
-	if (prev_delta == ULONG_MAX)
-		return best_energy_cpu;
+	if ((prev_delta == ULONG_MAX) ||
+	    (prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
+		target = best_energy_cpu;
 
-	if ((prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
-		return best_energy_cpu;
-
-	return prev_cpu;
+	return target;
 
-fail:
+unlock:
 	rcu_read_unlock();
 
-	return -1;
+	return target;
 }
 
 /*
