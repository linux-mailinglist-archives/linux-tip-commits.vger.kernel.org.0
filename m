Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2605B32C780
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355618AbhCDAcI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582431AbhCCKVL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:21:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93EBC08EC2F;
        Wed,  3 Mar 2021 01:49:38 -0800 (PST)
Date:   Wed, 03 Mar 2021 09:49:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614764977;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gs9ZzgIItOpb66CTWgidjMbH9rx2aMPX0PYAefOGwxA=;
        b=EPdlTeSo1RaAr5xkerIsuYbKsJ2/XCKnclXJgy88cEj+xkWLA6jCRNzPCr7GQ/NkB9AKCX
        4Xminze9JFPG70uRSncytpxooM/2zCVS/1cWBqg7bXrbWiYbJCUMWBL862+Wzv4OmQiOdA
        HyKKdLmFYNwhpewiogvh4DjChCG0+ASYxvAY4xZK/bW73h7OeoGm//vXFBlwVjsmA+1f8b
        YkxBH6KKEtZentdoVNIPi4ZWCAJT8Lyt3x51ITY6K1o7sLNUviQnm391h+qsMWVblkLdRU
        OYreJ3dW/M/Mk8zH3nR4jJN2f4M1xPZ6mxrh9QH0UqMEN+F43kdEJG3V/wyGJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614764977;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gs9ZzgIItOpb66CTWgidjMbH9rx2aMPX0PYAefOGwxA=;
        b=BFU/kwMrpEefGXypkxrR6vP++jmohxoiekJ7P0WHCo31kz2X+1rbEe63Y6aesuFBKpuyuo
        jLzlPghrxcxsKbDQ==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix task utilization accountability in
 compute_energy()
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210225083612.1113823-2-vincent.donnefort@arm.com>
References: <20210225083612.1113823-2-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <161476497633.20312.518515728651071926.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2d120f71df4baeb7694f513c86fe6f85940f6f76
Gitweb:        https://git.kernel.org/tip/2d120f71df4baeb7694f513c86fe6f85940f6f76
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Thu, 25 Feb 2021 08:36:11 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 10:33:00 +01:00

sched/fair: Fix task utilization accountability in compute_energy()

find_energy_efficient_cpu() (feec()) computes for each perf_domain (pd) an
energy delta as follows:

  feec(task)
    for_each_pd
      base_energy = compute_energy(task, -1, pd)
        -> for_each_cpu(pd)
           -> cpu_util_next(cpu, task, -1)

      energy_delta = compute_energy(task, dst_cpu, pd)
        -> for_each_cpu(pd)
           -> cpu_util_next(cpu, task, dst_cpu)
      energy_delta -= base_energy

Then it picks the best CPU as being the one that minimizes energy_delta.

cpu_util_next() estimates the CPU utilization that would happen if the
task was placed on dst_cpu as follows:

  max(cpu_util + task_util, cpu_util_est + _task_util_est)

The task contribution to the energy delta can then be either:

  (1) _task_util_est, on a mostly idle CPU, where cpu_util is close to 0
      and _task_util_est > cpu_util.
  (2) task_util, on a mostly busy CPU, where cpu_util > _task_util_est.

  (cpu_util_est doesn't appear here. It is 0 when a CPU is idle and
   otherwise must be small enough so that feec() takes the CPU as a
   potential target for the task placement)

This is problematic for feec(), as cpu_util_next() might give an unfair
advantage to a CPU which is mostly busy (2) compared to one which is
mostly idle (1). _task_util_est being always bigger than task_util in
feec() (as the task is waking up), the task contribution to the energy
might look smaller on certain CPUs (2) and this breaks the energy
comparison.

This issue is, moreover, not sporadic. By starving idle CPUs, it keeps
their cpu_util < _task_util_est (1) while others will maintain cpu_util >
_task_util_est (2).

Fix this problem by always using max(task_util, _task_util_est) as a task
contribution to the energy (ENERGY_UTIL). The new estimated CPU
utilization for the energy would then be:

  max(cpu_util, cpu_util_est) + max(task_util, _task_util_est)

compute_energy() still needs to know which OPP would be selected if the
task would be migrated in the perf_domain (FREQUENCY_UTIL). Hence,
cpu_util_next() is still used to estimate the maximum util within the pd.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Quentin Perret <qperret@google.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lkml.kernel.org/r/20210225083612.1113823-2-vincent.donnefort@arm.com
---
 kernel/sched/fair.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f1b55f9..b994db9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6518,8 +6518,24 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 	 * its pd list and will not be accounted by compute_energy().
 	 */
 	for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
-		unsigned long cpu_util, util_cfs = cpu_util_next(cpu, p, dst_cpu);
-		struct task_struct *tsk = cpu == dst_cpu ? p : NULL;
+		unsigned long util_freq = cpu_util_next(cpu, p, dst_cpu);
+		unsigned long cpu_util, util_running = util_freq;
+		struct task_struct *tsk = NULL;
+
+		/*
+		 * When @p is placed on @cpu:
+		 *
+		 * util_running = max(cpu_util, cpu_util_est) +
+		 *		  max(task_util, _task_util_est)
+		 *
+		 * while cpu_util_next is: max(cpu_util + task_util,
+		 *			       cpu_util_est + _task_util_est)
+		 */
+		if (cpu == dst_cpu) {
+			tsk = p;
+			util_running =
+				cpu_util_next(cpu, p, -1) + task_util_est(p);
+		}
 
 		/*
 		 * Busy time computation: utilization clamping is not
@@ -6527,7 +6543,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * is already enough to scale the EM reported power
 		 * consumption at the (eventually clamped) cpu_capacity.
 		 */
-		sum_util += effective_cpu_util(cpu, util_cfs, cpu_cap,
+		sum_util += effective_cpu_util(cpu, util_running, cpu_cap,
 					       ENERGY_UTIL, NULL);
 
 		/*
@@ -6537,7 +6553,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * NOTE: in case RT tasks are running, by default the
 		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		cpu_util = effective_cpu_util(cpu, util_cfs, cpu_cap,
+		cpu_util = effective_cpu_util(cpu, util_freq, cpu_cap,
 					      FREQUENCY_UTIL, tsk);
 		max_util = max(max_util, cpu_util);
 	}
