Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6619D2AEB08
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgKKIXk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgKKIXa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9082C0613D1;
        Wed, 11 Nov 2020 00:23:29 -0800 (PST)
Date:   Wed, 11 Nov 2020 08:23:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605083008;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FAYXvze2+Ys/Z9VM1VFV9I/4WxgxVdvJ0WfFur++3g0=;
        b=W7TV5BdBsMj/ORlEmqDOSEQnxt4jReO2nwbQOZ8CJWdYbPm0lXBVaGXQVnOOVDvkicRIwB
        66eoWF5v8uPWOxOBQ+i2uflmrIuASwdMiwUmjwG5ySzWLGB529C0qRkwMT7Cu4T2BttKM/
        WZMHVQvltlq6FFxrf0UgIyVW7Qx8FsLnIwnGbTNdKW1DIDQcqanBYUAue0y2o1/VW2wK9B
        HqE0aIty9bmFlKgMUdd8Ic1yqJEwalPLabKOptMjc2wJFe4/ZhkKtykjqrzoSQW/Bjfhua
        S1IBQYFNI85VZ9BHI8ar0/6O7lw8/5c2l7LxbUmBcCQUbe9Jdsz3n+M5QsRLzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605083008;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FAYXvze2+Ys/Z9VM1VFV9I/4WxgxVdvJ0WfFur++3g0=;
        b=DcVDp0tl8ntG3l4nilfv2DwL2eqkjDfoyG596jZ8pgeAPNpMiCo+Gw+05E8B/S2pT919m1
        VLg06yaQ0XqF7dAA==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Prefer prev cpu in asymmetric wakeup path
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201029161824.26389-1-vincent.guittot@linaro.org>
References: <20201029161824.26389-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <160508300739.11244.17687029072554394634.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     b4c9c9f15649c98a5b45408919d1ff4fd7f5531c
Gitweb:        https://git.kernel.org/tip/b4c9c9f15649c98a5b45408919d1ff4fd7f5531c
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Thu, 29 Oct 2020 17:18:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:38:48 +01:00

sched/fair: Prefer prev cpu in asymmetric wakeup path

During fast wakeup path, scheduler always check whether local or prev
cpus are good candidates for the task before looking for other cpus in
the domain. With commit b7a331615d25 ("sched/fair: Add asymmetric CPU
capacity wakeup scan") the heterogenous system gains a dedicated path
but doesn't try to reuse prev cpu whenever possible. If the previous
cpu is idle and belong to the LLC domain, we should check it 1st
before looking for another cpu because it stays one of the best
candidate and this also stabilizes task placement on the system.

This change aligns asymmetric path behavior with symmetric one and reduces
cases where the task migrates across all cpus of the sd_asym_cpucapacity
domains at wakeup.

This change does not impact normal EAS mode but only the overloaded case or
when EAS is not used.

- On hikey960 with performance governor (EAS disable)

./perf bench sched pipe -T -l 50000
             mainline           w/ patch
# migrations   999364                  0
ops/sec        149313(+/-0.28%)   182587(+/- 0.40) +22%

- On hikey with performance governor

./perf bench sched pipe -T -l 50000
             mainline           w/ patch
# migrations        0                  0
ops/sec         47721(+/-0.76%)    47899(+/- 0.56) +0.4%

According to test on hikey, the patch doesn't impact symmetric system
compared to current implementation (only tested on arm64)

Also read the uclamped value of task's utilization at most twice instead
instead each time we compare task's utilization with cpu's capacity.

Fixes: b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20201029161824.26389-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 67 ++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 210b15f..8e563cf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6172,21 +6172,21 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 static int
 select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 {
-	unsigned long best_cap = 0;
+	unsigned long task_util, best_cap = 0;
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
 
-	sync_entity_load_avg(&p->se);
-
 	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
+	task_util = uclamp_task_util(p);
+
 	for_each_cpu_wrap(cpu, cpus, target) {
 		unsigned long cpu_cap = capacity_of(cpu);
 
 		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
 			continue;
-		if (task_fits_capacity(p, cpu_cap))
+		if (fits_capacity(task_util, cpu_cap))
 			return cpu;
 
 		if (cpu_cap > best_cap) {
@@ -6198,44 +6198,42 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	return best_cpu;
 }
 
+static inline bool asym_fits_capacity(int task_util, int cpu)
+{
+	if (static_branch_unlikely(&sched_asym_cpucapacity))
+		return fits_capacity(task_util, capacity_of(cpu));
+
+	return true;
+}
+
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
 static int select_idle_sibling(struct task_struct *p, int prev, int target)
 {
 	struct sched_domain *sd;
+	unsigned long task_util;
 	int i, recent_used_cpu;
 
 	/*
-	 * For asymmetric CPU capacity systems, our domain of interest is
-	 * sd_asym_cpucapacity rather than sd_llc.
+	 * On asymmetric system, update task utilization because we will check
+	 * that the task fits with cpu's capacity.
 	 */
 	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
-		sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
-		/*
-		 * On an asymmetric CPU capacity system where an exclusive
-		 * cpuset defines a symmetric island (i.e. one unique
-		 * capacity_orig value through the cpuset), the key will be set
-		 * but the CPUs within that cpuset will not have a domain with
-		 * SD_ASYM_CPUCAPACITY. These should follow the usual symmetric
-		 * capacity path.
-		 */
-		if (!sd)
-			goto symmetric;
-
-		i = select_idle_capacity(p, sd, target);
-		return ((unsigned)i < nr_cpumask_bits) ? i : target;
+		sync_entity_load_avg(&p->se);
+		task_util = uclamp_task_util(p);
 	}
 
-symmetric:
-	if (available_idle_cpu(target) || sched_idle_cpu(target))
+	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
+	    asym_fits_capacity(task_util, target))
 		return target;
 
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
 	if (prev != target && cpus_share_cache(prev, target) &&
-	    (available_idle_cpu(prev) || sched_idle_cpu(prev)))
+	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
+	    asym_fits_capacity(task_util, prev))
 		return prev;
 
 	/*
@@ -6258,7 +6256,8 @@ symmetric:
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
-	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr)) {
+	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
+	    asym_fits_capacity(task_util, recent_used_cpu)) {
 		/*
 		 * Replace recent_used_cpu with prev as it is a potential
 		 * candidate for the next wake:
@@ -6267,6 +6266,26 @@ symmetric:
 		return recent_used_cpu;
 	}
 
+	/*
+	 * For asymmetric CPU capacity systems, our domain of interest is
+	 * sd_asym_cpucapacity rather than sd_llc.
+	 */
+	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+		sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
+		/*
+		 * On an asymmetric CPU capacity system where an exclusive
+		 * cpuset defines a symmetric island (i.e. one unique
+		 * capacity_orig value through the cpuset), the key will be set
+		 * but the CPUs within that cpuset will not have a domain with
+		 * SD_ASYM_CPUCAPACITY. These should follow the usual symmetric
+		 * capacity path.
+		 */
+		if (sd) {
+			i = select_idle_capacity(p, sd, target);
+			return ((unsigned)i < nr_cpumask_bits) ? i : target;
+		}
+	}
+
 	sd = rcu_dereference(per_cpu(sd_llc, target));
 	if (!sd)
 		return target;
