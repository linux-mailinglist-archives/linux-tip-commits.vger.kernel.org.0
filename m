Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAC4016681A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Feb 2020 21:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgBTUJe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 20 Feb 2020 15:09:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43871 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbgBTUJU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 20 Feb 2020 15:09:20 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j4s8H-0006hT-TJ; Thu, 20 Feb 2020 21:09:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8653C1C20C5;
        Thu, 20 Feb 2020 21:09:13 +0100 (CET)
Date:   Thu, 20 Feb 2020 20:09:13 -0000
From:   "tip-bot2 for Morten Rasmussen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Add asymmetric CPU capacity wakeup scan
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Quentin Perret <qperret@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200206191957.12325-2-valentin.schneider@arm.com>
References: <20200206191957.12325-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <158222935329.13786.16711123258402589223.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b7a331615d254191e7f5f0e35aec9adcd6acdc54
Gitweb:        https://git.kernel.org/tip/b7a331615d254191e7f5f0e35aec9adcd6acdc54
Author:        Morten Rasmussen <morten.rasmussen@arm.com>
AuthorDate:    Thu, 06 Feb 2020 19:19:54 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Feb 2020 21:03:14 +01:00

sched/fair: Add asymmetric CPU capacity wakeup scan

Issue
=====

On asymmetric CPU capacity topologies, we currently rely on wake_cap() to
drive select_task_rq_fair() towards either:

- its slow-path (find_idlest_cpu()) if either the previous or
  current (waking) CPU has too little capacity for the waking task
- its fast-path (select_idle_sibling()) otherwise

Commit:

  3273163c6775 ("sched/fair: Let asymmetric CPU configurations balance at wake-up")

points out that this relies on the assumption that "[...]the CPU capacities
within an SD_SHARE_PKG_RESOURCES domain (sd_llc) are homogeneous".

This assumption no longer holds on newer generations of big.LITTLE
systems (DynamIQ), which can accommodate CPUs of different compute capacity
within a single LLC domain. To hopefully paint a better picture, a regular
big.LITTLE topology would look like this:

  +---------+ +---------+
  |   L2    | |   L2    |
  +----+----+ +----+----+
  |CPU0|CPU1| |CPU2|CPU3|
  +----+----+ +----+----+
      ^^^         ^^^
    LITTLEs      bigs

which would result in the following scheduler topology:

  DIE [         ] <- sd_asym_cpucapacity
  MC  [   ] [   ] <- sd_llc
       0 1   2 3

Conversely, a DynamIQ topology could look like:

  +-------------------+
  |        L3         |
  +----+----+----+----+
  | L2 | L2 | L2 | L2 |
  +----+----+----+----+
  |CPU0|CPU1|CPU2|CPU3|
  +----+----+----+----+
     ^^^^^     ^^^^^
    LITTLEs    bigs

which would result in the following scheduler topology:

  MC [       ] <- sd_llc, sd_asym_cpucapacity
      0 1 2 3

What this means is that, on DynamIQ systems, we could pass the wake_cap()
test (IOW presume the waking task fits on the CPU capacities of some LLC
domain), thus go through select_idle_sibling().
This function operates on an LLC domain, which here spans both bigs and
LITTLEs, so it could very well pick a CPU of too small capacity for the
task, despite there being fitting idle CPUs - it very much depends on the
CPU iteration order, on which we have absolutely no guarantees
capacity-wise.

Implementation
==============

Introduce yet another select_idle_sibling() helper function that takes CPU
capacity into account. The policy is to pick the first idle CPU which is
big enough for the task (task_util * margin < cpu_capacity). If no
idle CPU is big enough, we pick the idle one with the highest capacity.

Unlike other select_idle_sibling() helpers, this one operates on the
sd_asym_cpucapacity sched_domain pointer, which is guaranteed to span all
known CPU capacities in the system. As such, this will work for both
"legacy" big.LITTLE (LITTLEs & bigs split at MC, joined at DIE) and for
newer DynamIQ systems (e.g. LITTLEs and bigs in the same MC domain).

Note that this limits the scope of select_idle_sibling() to
select_idle_capacity() for asymmetric CPU capacity systems - the LLC domain
will not be scanned, and no further heuristic will be applied.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Quentin Perret <qperret@google.com>
Link: https://lkml.kernel.org/r/20200206191957.12325-2-valentin.schneider@arm.com

---
 kernel/sched/fair.c | 56 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a0ce83..6fb47a2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5897,6 +5897,40 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 }
 
 /*
+ * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
+ * the task fits. If no CPU is big enough, but there are idle ones, try to
+ * maximize capacity.
+ */
+static int
+select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
+{
+	unsigned long best_cap = 0;
+	int cpu, best_cpu = -1;
+	struct cpumask *cpus;
+
+	sync_entity_load_avg(&p->se);
+
+	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+
+	for_each_cpu_wrap(cpu, cpus, target) {
+		unsigned long cpu_cap = capacity_of(cpu);
+
+		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
+			continue;
+		if (task_fits_capacity(p, cpu_cap))
+			return cpu;
+
+		if (cpu_cap > best_cap) {
+			best_cap = cpu_cap;
+			best_cpu = cpu;
+		}
+	}
+
+	return best_cpu;
+}
+
+/*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
 static int select_idle_sibling(struct task_struct *p, int prev, int target)
@@ -5904,6 +5938,28 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	struct sched_domain *sd;
 	int i, recent_used_cpu;
 
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
+		if (!sd)
+			goto symmetric;
+
+		i = select_idle_capacity(p, sd, target);
+		return ((unsigned)i < nr_cpumask_bits) ? i : target;
+	}
+
+symmetric:
 	if (available_idle_cpu(target) || sched_idle_cpu(target))
 		return target;
 
