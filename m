Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE32F32FA02
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhCFLmd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhCFLmY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0528BC061760;
        Sat,  6 Mar 2021 03:42:24 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:42:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NTsvTQKnWIRTQqsGWDQqELV2Q9dUHECVFtsq0JELzZw=;
        b=EzdHkUZMlZcxMCnJbPvG1O017AOSYURW1Dgy6+1+JRYatcOX3NKyJ6GNUSGborIKuBn8EK
        15KzHPDAnCi8cOXQnGsGE4BSh6WTMmrMoX1EIs1FhhP2Y1tqxi3ZI4D1B/qjQ/c6SffpkG
        0ogCOf9q5KjNFpH6qoKC/w0PZ2YrcLQ5CkGCWcc+H3Oi3ui1ewpwGRy/rdRVe4YLk8Bs79
        +YZmgCcbYTU1o/mF1uY80bBE9GG4jKH60D4vQFg1u6Ukv72ZIBZzxGT6y3kTkneLTLlXP8
        RidmSCEEb9Uv/s7S6TrfWH2wjN5JZt40fRp8hCc7Ey0Mv+gWy4jVZ2oCjiGdsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NTsvTQKnWIRTQqsGWDQqELV2Q9dUHECVFtsq0JELzZw=;
        b=p2cmu+fRY3A+sd0JrY/SRg4JMNgGBrZo/PWgAxTVvi9E2lsxpkOsEoloWcLkFLBrYtlQNU
        khjz0Oj5tPGaIDCA==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix task utilization accountability in
 compute_energy()
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210225083612.1113823-2-vincent.donnefort@arm.com>
References: <20210225083612.1113823-2-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <161503094165.398.11054733174951657037.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0372e1cf70c28de6babcba38ef97b6ae3400b101
Gitweb:        https://git.kernel.org/tip/0372e1cf70c28de6babcba38ef97b6ae3400b101
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Thu, 25 Feb 2021 08:36:11 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:22 +01:00

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
