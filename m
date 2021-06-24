Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0BB3B2983
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 09:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhFXHlw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 24 Jun 2021 03:41:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42810 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhFXHlr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 24 Jun 2021 03:41:47 -0400
Date:   Thu, 24 Jun 2021 07:39:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624520367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PmI9cZUSq26TXS8bMvhG03sj+FxJOsudhJo+QaObgq4=;
        b=c8irdFzja4tS+30tlntcZGQe1snFRK52IRPOxilli4j9Ox8pMofgdY7pj6JCvwsXp/nUMJ
        dTkSlLjcv+tU8VlBxPwdFL9hPdQ2NexLo7Lfzkg1mZr9GOh8W+ZmDbIboWuzq47TQ62SWk
        zYEyO8dHhI8I/GCqHSLI0tFpSouhNmGej82G+qmX4nYldo0GEFDNZRRvWGp9djUtHYekOT
        CiCio3ijfbMXgqJNO9xKpmbpMWUT/6G6vDqWrwsuZdX/w8lc7rUzSGkN2M0utYdtJpgLeN
        5NzmEAb+7MlmgGvi6CjWNH5eNIyyd6YUC1TV4nMgOw9K+ddOBqfYxdAgpfDqXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624520367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PmI9cZUSq26TXS8bMvhG03sj+FxJOsudhJo+QaObgq4=;
        b=gJrX7EIV5n553HGL+IXdBx6kd7b3/ZL9hmyREq4ajSLw0krN2XrV/J2yVBYZMVSDFHhb64
        fSpOI9xhvmCyvdCQ==
From:   "tip-bot2 for Huaixin Chang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Introduce the burstable CFS controller
Cc:     Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ben Segall <bsegall@google.com>, Tejun Heo <tj@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210621092800.23714-2-changhuaixin@linux.alibaba.com>
References: <20210621092800.23714-2-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <162452036714.395.9249272896491500398.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f4183717b370ad28dd0c0d74760142b20e6e7931
Gitweb:        https://git.kernel.org/tip/f4183717b370ad28dd0c0d74760142b20e6e7931
Author:        Huaixin Chang <changhuaixin@linux.alibaba.com>
AuthorDate:    Mon, 21 Jun 2021 17:27:58 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Jun 2021 09:07:50 +02:00

sched/fair: Introduce the burstable CFS controller

The CFS bandwidth controller limits CPU requests of a task group to
quota during each period. However, parallel workloads might be bursty
so that they get throttled even when their average utilization is under
quota. And they are latency sensitive at the same time so that
throttling them is undesired.

We borrow time now against our future underrun, at the cost of increased
interference against the other system users. All nicely bounded.

Traditional (UP-EDF) bandwidth control is something like:

  (U = \Sum u_i) <= 1

This guaranteeds both that every deadline is met and that the system is
stable. After all, if U were > 1, then for every second of walltime,
we'd have to run more than a second of program time, and obviously miss
our deadline, but the next deadline will be further out still, there is
never time to catch up, unbounded fail.

This work observes that a workload doesn't always executes the full
quota; this enables one to describe u_i as a statistical distribution.

For example, have u_i = {x,e}_i, where x is the p(95) and x+e p(100)
(the traditional WCET). This effectively allows u to be smaller,
increasing the efficiency (we can pack more tasks in the system), but at
the cost of missing deadlines when all the odds line up. However, it
does maintain stability, since every overrun must be paired with an
underrun as long as our x is above the average.

That is, suppose we have 2 tasks, both specify a p(95) value, then we
have a p(95)*p(95) = 90.25% chance both tasks are within their quota and
everything is good. At the same time we have a p(5)p(5) = 0.25% chance
both tasks will exceed their quota at the same time (guaranteed deadline
fail). Somewhere in between there's a threshold where one exceeds and
the other doesn't underrun enough to compensate; this depends on the
specific CDFs.

At the same time, we can say that the worst case deadline miss, will be
\Sum e_i; that is, there is a bounded tardiness (under the assumption
that x+e is indeed WCET).

The benefit of burst is seen when testing with schbench. Default value of
kernel.sched_cfs_bandwidth_slice_us(5ms) and CONFIG_HZ(1000) is used.

	mkdir /sys/fs/cgroup/cpu/test
	echo $$ > /sys/fs/cgroup/cpu/test/cgroup.procs
	echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
	echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us

	./schbench -m 1 -t 3 -r 20 -c 80000 -R 10

The average CPU usage is at 80%. I run this for 10 times, and got long tail
latency for 6 times and got throttled for 8 times.

Tail latencies are shown below, and it wasn't the worst case.

	Latency percentiles (usec)
		50.0000th: 19872
		75.0000th: 21344
		90.0000th: 22176
		95.0000th: 22496
		*99.0000th: 22752
		99.5000th: 22752
		99.9000th: 22752
		min=0, max=22727
	rps: 9.90 p95 (usec) 22496 p99 (usec) 22752 p95/cputime 28.12% p99/cputime 28.44%

The interferenece when using burst is valued by the possibilities for
missing the deadline and the average WCET. Test results showed that when
there many cgroups or CPU is under utilized, the interference is
limited. More details are shown in:
https://lore.kernel.org/lkml/5371BD36-55AE-4F71-B9D7-B86DC32E3D2B@linux.alibaba.com/

Co-developed-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Co-developed-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ben Segall <bsegall@google.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20210621092800.23714-2-changhuaixin@linux.alibaba.com
---
 kernel/sched/core.c  | 68 +++++++++++++++++++++++++++++++++++++++----
 kernel/sched/fair.c  | 14 ++++++---
 kernel/sched/sched.h |  1 +-
 3 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fc231d6..2883c22 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9780,7 +9780,8 @@ static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
-static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
+static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
+				u64 burst)
 {
 	int i, ret = 0, runtime_enabled, runtime_was_enabled;
 	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
@@ -9810,6 +9811,10 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 	if (quota != RUNTIME_INF && quota > max_cfs_runtime)
 		return -EINVAL;
 
+	if (quota != RUNTIME_INF && (burst > quota ||
+				     burst + quota > max_cfs_runtime))
+		return -EINVAL;
+
 	/*
 	 * Prevent race between setting of cfs_rq->runtime_enabled and
 	 * unthrottle_offline_cfs_rqs().
@@ -9831,6 +9836,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 	raw_spin_lock_irq(&cfs_b->lock);
 	cfs_b->period = ns_to_ktime(period);
 	cfs_b->quota = quota;
+	cfs_b->burst = burst;
 
 	__refill_cfs_bandwidth_runtime(cfs_b);
 
@@ -9864,9 +9870,10 @@ out_unlock:
 
 static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 {
-	u64 quota, period;
+	u64 quota, period, burst;
 
 	period = ktime_to_ns(tg->cfs_bandwidth.period);
+	burst = tg->cfs_bandwidth.burst;
 	if (cfs_quota_us < 0)
 		quota = RUNTIME_INF;
 	else if ((u64)cfs_quota_us <= U64_MAX / NSEC_PER_USEC)
@@ -9874,7 +9881,7 @@ static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 	else
 		return -EINVAL;
 
-	return tg_set_cfs_bandwidth(tg, period, quota);
+	return tg_set_cfs_bandwidth(tg, period, quota, burst);
 }
 
 static long tg_get_cfs_quota(struct task_group *tg)
@@ -9892,15 +9899,16 @@ static long tg_get_cfs_quota(struct task_group *tg)
 
 static int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 {
-	u64 quota, period;
+	u64 quota, period, burst;
 
 	if ((u64)cfs_period_us > U64_MAX / NSEC_PER_USEC)
 		return -EINVAL;
 
 	period = (u64)cfs_period_us * NSEC_PER_USEC;
 	quota = tg->cfs_bandwidth.quota;
+	burst = tg->cfs_bandwidth.burst;
 
-	return tg_set_cfs_bandwidth(tg, period, quota);
+	return tg_set_cfs_bandwidth(tg, period, quota, burst);
 }
 
 static long tg_get_cfs_period(struct task_group *tg)
@@ -9913,6 +9921,30 @@ static long tg_get_cfs_period(struct task_group *tg)
 	return cfs_period_us;
 }
 
+static int tg_set_cfs_burst(struct task_group *tg, long cfs_burst_us)
+{
+	u64 quota, period, burst;
+
+	if ((u64)cfs_burst_us > U64_MAX / NSEC_PER_USEC)
+		return -EINVAL;
+
+	burst = (u64)cfs_burst_us * NSEC_PER_USEC;
+	period = ktime_to_ns(tg->cfs_bandwidth.period);
+	quota = tg->cfs_bandwidth.quota;
+
+	return tg_set_cfs_bandwidth(tg, period, quota, burst);
+}
+
+static long tg_get_cfs_burst(struct task_group *tg)
+{
+	u64 burst_us;
+
+	burst_us = tg->cfs_bandwidth.burst;
+	do_div(burst_us, NSEC_PER_USEC);
+
+	return burst_us;
+}
+
 static s64 cpu_cfs_quota_read_s64(struct cgroup_subsys_state *css,
 				  struct cftype *cft)
 {
@@ -9937,6 +9969,18 @@ static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
 	return tg_set_cfs_period(css_tg(css), cfs_period_us);
 }
 
+static u64 cpu_cfs_burst_read_u64(struct cgroup_subsys_state *css,
+				  struct cftype *cft)
+{
+	return tg_get_cfs_burst(css_tg(css));
+}
+
+static int cpu_cfs_burst_write_u64(struct cgroup_subsys_state *css,
+				   struct cftype *cftype, u64 cfs_burst_us)
+{
+	return tg_set_cfs_burst(css_tg(css), cfs_burst_us);
+}
+
 struct cfs_schedulable_data {
 	struct task_group *tg;
 	u64 period, quota;
@@ -10090,6 +10134,11 @@ static struct cftype cpu_legacy_files[] = {
 		.write_u64 = cpu_cfs_period_write_u64,
 	},
 	{
+		.name = "cfs_burst_us",
+		.read_u64 = cpu_cfs_burst_read_u64,
+		.write_u64 = cpu_cfs_burst_write_u64,
+	},
+	{
 		.name = "stat",
 		.seq_show = cpu_cfs_stat_show,
 	},
@@ -10254,12 +10303,13 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 {
 	struct task_group *tg = css_tg(of_css(of));
 	u64 period = tg_get_cfs_period(tg);
+	u64 burst = tg_get_cfs_burst(tg);
 	u64 quota;
 	int ret;
 
 	ret = cpu_period_quota_parse(buf, &period, &quota);
 	if (!ret)
-		ret = tg_set_cfs_bandwidth(tg, period, quota);
+		ret = tg_set_cfs_bandwidth(tg, period, quota, burst);
 	return ret ?: nbytes;
 }
 #endif
@@ -10286,6 +10336,12 @@ static struct cftype cpu_files[] = {
 		.seq_show = cpu_max_show,
 		.write = cpu_max_write,
 	},
+	{
+		.name = "max.burst",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_cfs_burst_read_u64,
+		.write_u64 = cpu_cfs_burst_write_u64,
+	},
 #endif
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	{
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7b8990f..4a3e61a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4626,8 +4626,11 @@ static inline u64 sched_cfs_bandwidth_slice(void)
  */
 void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 {
-	if (cfs_b->quota != RUNTIME_INF)
-		cfs_b->runtime = cfs_b->quota;
+	if (unlikely(cfs_b->quota == RUNTIME_INF))
+		return;
+
+	cfs_b->runtime += cfs_b->quota;
+	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -4988,6 +4991,9 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
 	throttled = !list_empty(&cfs_b->throttled_cfs_rq);
 	cfs_b->nr_periods += overrun;
 
+	/* Refill extra burst quota even if cfs_b->idle */
+	__refill_cfs_bandwidth_runtime(cfs_b);
+
 	/*
 	 * idle depends on !throttled (for the case of a large deficit), and if
 	 * we're going inactive then everything else can be deferred
@@ -4995,8 +5001,6 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
 	if (cfs_b->idle && !throttled)
 		goto out_deactivate;
 
-	__refill_cfs_bandwidth_runtime(cfs_b);
-
 	if (!throttled) {
 		/* mark as potentially idle for the upcoming period */
 		cfs_b->idle = 1;
@@ -5246,6 +5250,7 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 			if (new < max_cfs_quota_period) {
 				cfs_b->period = ns_to_ktime(new);
 				cfs_b->quota *= 2;
+				cfs_b->burst *= 2;
 
 				pr_warn_ratelimited(
 	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us = %lld, cfs_quota_us = %lld)\n",
@@ -5277,6 +5282,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->runtime = 0;
 	cfs_b->quota = RUNTIME_INF;
 	cfs_b->period = ns_to_ktime(default_cfs_period());
+	cfs_b->burst = 0;
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
 	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 01e48f6..c80d42e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -366,6 +366,7 @@ struct cfs_bandwidth {
 	ktime_t			period;
 	u64			quota;
 	u64			runtime;
+	u64			burst;
 	s64			hierarchical_quota;
 
 	u8			idle;
