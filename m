Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB123AC66D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 10:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbhFRIsT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 04:48:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54074 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhFRIsQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 04:48:16 -0400
Date:   Fri, 18 Jun 2021 08:46:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624005966;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZTQQyjbl0jO4fYZ5VyuXJ4E9UG9CoQuROM6iP9Lzgs4=;
        b=YcAGazejXvyFGWhbq5mlJC3WBUSxzs/gAHtBNwrTehlQB6BzHIh2oM8lAYCoQqVvkWDrJy
        qCDJKV9Kau2r7zY+nvCNmfvMl2fOg6PTVxc1ctEmpodKLxed6AwbmiqijIQMLvJpzp+Uk1
        k87pVhNawmEWbqyTxH9oUf9RRENwG2BTNbMBioZY1K7RTWWPHjzTIh3lN9S7tRoUDnmjOg
        +j/LfPYMjuxmlAwKmTQhxSENXVqwBs3nW0yrWnWznusfVmNnIkOEOqtmuQyoY07ecyXiPH
        9Oaq2uPiXu3+vbXlhfrPrxyVG3+HLS0YJxBJ+BVZLh7DkEJT2HMKGqNaA4jvhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624005966;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZTQQyjbl0jO4fYZ5VyuXJ4E9UG9CoQuROM6iP9Lzgs4=;
        b=ycYFACz/RHs7xnNnfq/4B1oGRMHPCWn18XP6kRlizJQPufaRr15PWe9vWekWXZ6Mr3OUCT
        1TgO5KsO9MoM75Dw==
From:   "tip-bot2 for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cpufreq: Consider reduced CPU capacity in
 energy calculation
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210614191238.23224-1-lukasz.luba@arm.com>
References: <20210614191238.23224-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <162400596556.19906.12591122664820352576.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8f1b971b4750e83e8fbd2f91a9efd4a38ad0ae51
Gitweb:        https://git.kernel.org/tip/8f1b971b4750e83e8fbd2f91a9efd4a38ad0ae51
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Mon, 14 Jun 2021 20:12:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 17 Jun 2021 14:11:43 +02:00

sched/cpufreq: Consider reduced CPU capacity in energy calculation

Energy Aware Scheduling (EAS) needs to predict the decisions made by
SchedUtil. The map_util_freq() exists to do that.

There are corner cases where the max allowed frequency might be reduced
(due to thermal). SchedUtil as a CPUFreq governor, is aware of that
but EAS is not. This patch aims to address it.

SchedUtil stores the maximum allowed frequency in
'sugov_policy::next_freq' field. EAS has to predict that value, which is
the real used frequency. That value is made after a call to
cpufreq_driver_resolve_freq() which clamps to the CPUFreq policy limits.
In the existing code EAS is not able to predict that real frequency.
This leads to energy estimation errors.

To avoid wrong energy estimation in EAS (due to frequency miss prediction)
make sure that the step which calculates Performance Domain frequency,
is also aware of the allowed CPU capacity.

Furthermore, modify map_util_freq() to not extend the frequency value.
Instead, use map_util_perf() to extend the util value in both places:
SchedUtil and EAS, but for EAS clamp it to max allowed CPU capacity.
In the end, we achieve the same desirable behavior for both subsystems
and alignment in regards to the real CPU frequency.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com> (For the schedutil part)
Link: https://lore.kernel.org/r/20210614191238.23224-1-lukasz.luba@arm.com
---
 include/linux/energy_model.h     | 16 +++++++++++++---
 include/linux/sched/cpufreq.h    |  2 +-
 kernel/sched/cpufreq_schedutil.c |  1 +
 kernel/sched/fair.c              |  2 +-
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 757fc60..3f221db 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -91,6 +91,8 @@ void em_dev_unregister_perf_domain(struct device *dev);
  * @pd		: performance domain for which energy has to be estimated
  * @max_util	: highest utilization among CPUs of the domain
  * @sum_util	: sum of the utilization of all CPUs in the domain
+ * @allowed_cpu_cap	: maximum allowed CPU capacity for the @pd, which
+			  might reflect reduced frequency (due to thermal)
  *
  * This function must be used only for CPU devices. There is no validation,
  * i.e. if the EM is a CPU type and has cpumask allocated. It is called from
@@ -100,7 +102,8 @@ void em_dev_unregister_perf_domain(struct device *dev);
  * a capacity state satisfying the max utilization of the domain.
  */
 static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
-				unsigned long max_util, unsigned long sum_util)
+				unsigned long max_util, unsigned long sum_util,
+				unsigned long allowed_cpu_cap)
 {
 	unsigned long freq, scale_cpu;
 	struct em_perf_state *ps;
@@ -112,11 +115,17 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	/*
 	 * In order to predict the performance state, map the utilization of
 	 * the most utilized CPU of the performance domain to a requested
-	 * frequency, like schedutil.
+	 * frequency, like schedutil. Take also into account that the real
+	 * frequency might be set lower (due to thermal capping). Thus, clamp
+	 * max utilization to the allowed CPU capacity before calculating
+	 * effective frequency.
 	 */
 	cpu = cpumask_first(to_cpumask(pd->cpus));
 	scale_cpu = arch_scale_cpu_capacity(cpu);
 	ps = &pd->table[pd->nr_perf_states - 1];
+
+	max_util = map_util_perf(max_util);
+	max_util = min(max_util, allowed_cpu_cap);
 	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
 
 	/*
@@ -209,7 +218,8 @@ static inline struct em_perf_domain *em_pd_get(struct device *dev)
 	return NULL;
 }
 static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
-			unsigned long max_util, unsigned long sum_util)
+			unsigned long max_util, unsigned long sum_util,
+			unsigned long allowed_cpu_cap)
 {
 	return 0;
 }
diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index 6205578..bdd31ab 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -26,7 +26,7 @@ bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy);
 static inline unsigned long map_util_freq(unsigned long util,
 					unsigned long freq, unsigned long cap)
 {
-	return (freq + (freq >> 2)) * util / cap;
+	return freq * util / cap;
 }
 
 static inline unsigned long map_util_perf(unsigned long util)
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4f09afd..5712461 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -151,6 +151,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	unsigned int freq = arch_scale_freq_invariant() ?
 				policy->cpuinfo.max_freq : policy->cur;
 
+	util = map_util_perf(util);
 	freq = map_util_freq(util, freq, max);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0d6d190..ed7df1b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6592,7 +6592,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		max_util = max(max_util, min(cpu_util, _cpu_cap));
 	}
 
-	return em_cpu_energy(pd->em_pd, max_util, sum_util);
+	return em_cpu_energy(pd->em_pd, max_util, sum_util, _cpu_cap);
 }
 
 /*
