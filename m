Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988A33AC66E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 10:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhFRIsT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 04:48:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54086 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbhFRIsQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 04:48:16 -0400
Date:   Fri, 18 Jun 2021 08:46:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624005966;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHlADSx85SgtpBS1Jz34E+efIQsz+CUboNPLcr+BF4A=;
        b=sTXPphX6TR/WmbcvYDLWQztSaWRuNxCzz3yfcyKBjF/tnFt5RowYBI/JdyUbLzc5b0hram
        3byBN6HZ13M7AyIdzD9zpqzxq2Y1DrS12PX+maQjbW2gaEFh4A9bvOyaKNvwjbJmSy+77q
        WGURnublUzJ4lE6Y5VheqH18Adxi/zSRTh9bGWTTogaS3ZtzBaAJUvm6SuyCcSmLDVw3tl
        AxmdVRn7lmVlIvwFbVCseN+6G9Hf5tXHDnA2p6PVFnbuxVMkOd6WuD1TJQlz69Qe/XiPOq
        sgKUGhYza7SJbP8DPCNZELSdquzLQkQMVx7u4yg83SHnBoIpJsPc00vIe5RSDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624005966;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHlADSx85SgtpBS1Jz34E+efIQsz+CUboNPLcr+BF4A=;
        b=Ow0XMEOxYYNMmORccmhwmlL7IZ390GekV8+in2jtnxTSFGu4ScgTnNxnbyfPPUpSdYtm5+
        T87pNygTCoR9wWDA==
From:   "tip-bot2 for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Take thermal pressure into account
 while estimating energy
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210614191128.22735-1-lukasz.luba@arm.com>
References: <20210614191128.22735-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <162400596606.19906.9808076258804198098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     489f16459e0008c7a5c4c5af34bd80898aa82c2d
Gitweb:        https://git.kernel.org/tip/489f16459e0008c7a5c4c5af34bd80898aa82c2d
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Mon, 14 Jun 2021 20:11:28 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 17 Jun 2021 14:11:43 +02:00

sched/fair: Take thermal pressure into account while estimating energy

Energy Aware Scheduling (EAS) needs to be able to predict the frequency
requests made by the SchedUtil governor to properly estimate energy used
in the future. It has to take into account CPUs utilization and forecast
Performance Domain (PD) frequency. There is a corner case when the max
allowed frequency might be reduced due to thermal. SchedUtil is aware of
that reduced frequency, so it should be taken into account also in EAS
estimations.

SchedUtil, as a CPUFreq governor, knows the maximum allowed frequency of
a CPU, thanks to cpufreq_driver_resolve_freq() and internal clamping
to 'policy::max'. SchedUtil is responsible to respect that upper limit
while setting the frequency through CPUFreq drivers. This effective
frequency is stored internally in 'sugov_policy::next_freq' and EAS has
to predict that value.

In the existing code the raw value of arch_scale_cpu_capacity() is used
for clamping the returned CPU utilization from effective_cpu_util().
This patch fixes issue with too big single CPU utilization, by introducing
clamping to the allowed CPU capacity. The allowed CPU capacity is a CPU
capacity reduced by thermal pressure raw value.

Thanks to knowledge about allowed CPU capacity, we don't get too big value
for a single CPU utilization, which is then added to the util sum. The
util sum is used as a source of information for estimating whole PD energy.
To avoid wrong energy estimation in EAS (due to capped frequency), make
sure that the calculation of util sum is aware of allowed CPU capacity.

This thermal pressure might be visible in scenarios where the CPUs are not
heavily loaded, but some other component (like GPU) drastically reduced
available power budget and increased the SoC temperature. Thus, we still
use EAS for task placement and CPUs are not over-utilized.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20210614191128.22735-1-lukasz.luba@arm.com
---
 kernel/sched/fair.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 06c8ba7..0d6d190 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6535,8 +6535,11 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 	struct cpumask *pd_mask = perf_domain_span(pd);
 	unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
 	unsigned long max_util = 0, sum_util = 0;
+	unsigned long _cpu_cap = cpu_cap;
 	int cpu;
 
+	_cpu_cap -= arch_scale_thermal_pressure(cpumask_first(pd_mask));
+
 	/*
 	 * The capacity state of CPUs of the current rd can be driven by CPUs
 	 * of another rd if they belong to the same pd. So, account for the
@@ -6572,8 +6575,10 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * is already enough to scale the EM reported power
 		 * consumption at the (eventually clamped) cpu_capacity.
 		 */
-		sum_util += effective_cpu_util(cpu, util_running, cpu_cap,
-					       ENERGY_UTIL, NULL);
+		cpu_util = effective_cpu_util(cpu, util_running, cpu_cap,
+					      ENERGY_UTIL, NULL);
+
+		sum_util += min(cpu_util, _cpu_cap);
 
 		/*
 		 * Performance domain frequency: utilization clamping
@@ -6584,7 +6589,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 */
 		cpu_util = effective_cpu_util(cpu, util_freq, cpu_cap,
 					      FREQUENCY_UTIL, tsk);
-		max_util = max(max_util, cpu_util);
+		max_util = max(max_util, min(cpu_util, _cpu_cap));
 	}
 
 	return em_cpu_energy(pd->em_pd, max_util, sum_util);
