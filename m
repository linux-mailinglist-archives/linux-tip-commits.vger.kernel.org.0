Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53EAE86064
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2019 12:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfHHKyD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Aug 2019 06:54:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50443 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfHHKyD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Aug 2019 06:54:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78ArZa63126828
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 03:53:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78ArZa63126828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565261616;
        bh=QYwI+sHipcBva+twJQqfiRNaUP6XsbNGKTTXnVLHw18=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=03nc7PEQuNXP2nCT59bgu1GfUaNqmmWLPgb4O+d593+sVsxgDuvMDedEtPMdgriFj
         bMTPChZBx/Cj+LGgwmMsrs3xOCTPjYUwnZ28d3C4IXZrtmiIL1SgGZ4P+KBTyXHoPM
         yv2GiohC2p1wvLv6z4htRxhKJ0nk2NTegYYhCGiTstBk/LOEvV5jw6Xa6EGfSPqMuY
         2fRxYOcIoa0yuuOBAvaVKOaMcfAgbniKPYPCHnSGoSJQnIrW+dJSLXsxOZTzqqJUv4
         N8LQ82/be6aUPrPd4/Cwqwh/UE0TFVxHQx1AtblhCSB2WMVsScFqG3AOfYX5s+3k21
         b5N47irXTeS/g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78ArYuD3126823;
        Thu, 8 Aug 2019 03:53:34 -0700
Date:   Thu, 8 Aug 2019 03:53:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Chiluk <tipbot@zytor.com>
Message-ID: <tip-de53fd7aedb100f03e5d2231cfce0e4993282425@git.kernel.org>
Cc:     posk@posk.io, hpa@zytor.com, jhammond@indeed.com, mingo@redhat.com,
        gmunoz@netflix.com, corbet@lwn.net, tglx@linutronix.de,
        chiluk+linux@indeed.com, mingo@kernel.org, kwa@yelp.com,
        linux-kernel@vger.kernel.org, pauld@redhat.com,
        peterz@infradead.org, xiyou.wangcong@gmail.com, bsegall@google.com,
        bgregg@netflix.com
Reply-To: corbet@lwn.net, gmunoz@netflix.com, tglx@linutronix.de,
          chiluk+linux@indeed.com, linux-kernel@vger.kernel.org,
          kwa@yelp.com, mingo@kernel.org, posk@posk.io, hpa@zytor.com,
          jhammond@indeed.com, mingo@redhat.com, xiyou.wangcong@gmail.com,
          bgregg@netflix.com, bsegall@google.com, pauld@redhat.com,
          peterz@infradead.org
In-Reply-To: <1563900266-19734-2-git-send-email-chiluk+linux@indeed.com>
References: <1563900266-19734-2-git-send-email-chiluk+linux@indeed.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Fix low cpu usage with high throttling
 by removing expiration of cpu-local slices
Git-Commit-ID: de53fd7aedb100f03e5d2231cfce0e4993282425
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=1.8 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  de53fd7aedb100f03e5d2231cfce0e4993282425
Gitweb:     https://git.kernel.org/tip/de53fd7aedb100f03e5d2231cfce0e4993282425
Author:     Dave Chiluk <chiluk+linux@indeed.com>
AuthorDate: Tue, 23 Jul 2019 11:44:26 -0500
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Thu, 8 Aug 2019 09:09:30 +0200

sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices

It has been observed, that highly-threaded, non-cpu-bound applications
running under cpu.cfs_quota_us constraints can hit a high percentage of
periods throttled while simultaneously not consuming the allocated
amount of quota. This use case is typical of user-interactive non-cpu
bound applications, such as those running in kubernetes or mesos when
run on multiple cpu cores.

This has been root caused to cpu-local run queue being allocated per cpu
bandwidth slices, and then not fully using that slice within the period.
At which point the slice and quota expires. This expiration of unused
slice results in applications not being able to utilize the quota for
which they are allocated.

The non-expiration of per-cpu slices was recently fixed by
'commit 512ac999d275 ("sched/fair: Fix bandwidth timer clock drift
condition")'. Prior to that it appears that this had been broken since
at least 'commit 51f2176d74ac ("sched/fair: Fix unlocked reads of some
cfs_b->quota/period")' which was introduced in v3.16-rc1 in 2014. That
added the following conditional which resulted in slices never being
expired.

if (cfs_rq->runtime_expires != cfs_b->runtime_expires) {
	/* extend local deadline, drift is bounded above by 2 ticks */
	cfs_rq->runtime_expires += TICK_NSEC;

Because this was broken for nearly 5 years, and has recently been fixed
and is now being noticed by many users running kubernetes
(https://github.com/kubernetes/kubernetes/issues/67577) it is my opinion
that the mechanisms around expiring runtime should be removed
altogether.

This allows quota already allocated to per-cpu run-queues to live longer
than the period boundary. This allows threads on runqueues that do not
use much CPU to continue to use their remaining slice over a longer
period of time than cpu.cfs_period_us. However, this helps prevent the
above condition of hitting throttling while also not fully utilizing
your cpu quota.

This theoretically allows a machine to use slightly more than its
allotted quota in some periods. This overflow would be bounded by the
remaining quota left on each per-cpu runqueueu. This is typically no
more than min_cfs_rq_runtime=1ms per cpu. For CPU bound tasks this will
change nothing, as they should theoretically fully utilize all of their
quota in each period. For user-interactive tasks as described above this
provides a much better user/application experience as their cpu
utilization will more closely match the amount they requested when they
hit throttling. This means that cpu limits no longer strictly apply per
period for non-cpu bound applications, but that they are still accurate
over longer timeframes.

This greatly improves performance of high-thread-count, non-cpu bound
applications with low cfs_quota_us allocation on high-core-count
machines. In the case of an artificial testcase (10ms/100ms of quota on
80 CPU machine), this commit resulted in almost 30x performance
improvement, while still maintaining correct cpu quota restrictions.
That testcase is available at https://github.com/indeedeng/fibtest.

Fixes: 512ac999d275 ("sched/fair: Fix bandwidth timer clock drift condition")
Signed-off-by: Dave Chiluk <chiluk+linux@indeed.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Ben Segall <bsegall@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: John Hammond <jhammond@indeed.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kyle Anderson <kwa@yelp.com>
Cc: Gabriel Munos <gmunoz@netflix.com>
Cc: Peter Oskolkov <posk@posk.io>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Brendan Gregg <bgregg@netflix.com>
Link: https://lkml.kernel.org/r/1563900266-19734-2-git-send-email-chiluk+linux@indeed.com
---
 Documentation/scheduler/sched-bwc.rst | 74 ++++++++++++++++++++++++++++-------
 kernel/sched/fair.c                   | 72 ++++------------------------------
 kernel/sched/sched.h                  |  4 --
 3 files changed, 67 insertions(+), 83 deletions(-)

diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
index 3a9064219656..9801d6b284b1 100644
--- a/Documentation/scheduler/sched-bwc.rst
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -9,15 +9,16 @@ CFS bandwidth control is a CONFIG_FAIR_GROUP_SCHED extension which allows the
 specification of the maximum CPU bandwidth available to a group or hierarchy.
 
 The bandwidth allowed for a group is specified using a quota and period. Within
-each given "period" (microseconds), a group is allowed to consume only up to
-"quota" microseconds of CPU time.  When the CPU bandwidth consumption of a
-group exceeds this limit (for that period), the tasks belonging to its
-hierarchy will be throttled and are not allowed to run again until the next
-period.
-
-A group's unused runtime is globally tracked, being refreshed with quota units
-above at each period boundary.  As threads consume this bandwidth it is
-transferred to cpu-local "silos" on a demand basis.  The amount transferred
+each given "period" (microseconds), a task group is allocated up to "quota"
+microseconds of CPU time. That quota is assigned to per-cpu run queues in
+slices as threads in the cgroup become runnable. Once all quota has been
+assigned any additional requests for quota will result in those threads being
+throttled. Throttled threads will not be able to run again until the next
+period when the quota is replenished.
+
+A group's unassigned quota is globally tracked, being refreshed back to
+cfs_quota units at each period boundary. As threads consume this bandwidth it
+is transferred to cpu-local "silos" on a demand basis. The amount transferred
 within each of these updates is tunable and described as the "slice".
 
 Management
@@ -35,12 +36,12 @@ The default values are::
 
 A value of -1 for cpu.cfs_quota_us indicates that the group does not have any
 bandwidth restriction in place, such a group is described as an unconstrained
-bandwidth group.  This represents the traditional work-conserving behavior for
+bandwidth group. This represents the traditional work-conserving behavior for
 CFS.
 
 Writing any (valid) positive value(s) will enact the specified bandwidth limit.
-The minimum quota allowed for the quota or period is 1ms.  There is also an
-upper bound on the period length of 1s.  Additional restrictions exist when
+The minimum quota allowed for the quota or period is 1ms. There is also an
+upper bound on the period length of 1s. Additional restrictions exist when
 bandwidth limits are used in a hierarchical fashion, these are explained in
 more detail below.
 
@@ -53,8 +54,8 @@ unthrottled if it is in a constrained state.
 System wide settings
 --------------------
 For efficiency run-time is transferred between the global pool and CPU local
-"silos" in a batch fashion.  This greatly reduces global accounting pressure
-on large systems.  The amount transferred each time such an update is required
+"silos" in a batch fashion. This greatly reduces global accounting pressure
+on large systems. The amount transferred each time such an update is required
 is described as the "slice".
 
 This is tunable via procfs::
@@ -97,6 +98,51 @@ There are two ways in which a group may become throttled:
 In case b) above, even though the child may have runtime remaining it will not
 be allowed to until the parent's runtime is refreshed.
 
+CFS Bandwidth Quota Caveats
+---------------------------
+Once a slice is assigned to a cpu it does not expire.  However all but 1ms of
+the slice may be returned to the global pool if all threads on that cpu become
+unrunnable. This is configured at compile time by the min_cfs_rq_runtime
+variable. This is a performance tweak that helps prevent added contention on
+the global lock.
+
+The fact that cpu-local slices do not expire results in some interesting corner
+cases that should be understood.
+
+For cgroup cpu constrained applications that are cpu limited this is a
+relatively moot point because they will naturally consume the entirety of their
+quota as well as the entirety of each cpu-local slice in each period. As a
+result it is expected that nr_periods roughly equal nr_throttled, and that
+cpuacct.usage will increase roughly equal to cfs_quota_us in each period.
+
+For highly-threaded, non-cpu bound applications this non-expiration nuance
+allows applications to briefly burst past their quota limits by the amount of
+unused slice on each cpu that the task group is running on (typically at most
+1ms per cpu or as defined by min_cfs_rq_runtime).  This slight burst only
+applies if quota had been assigned to a cpu and then not fully used or returned
+in previous periods. This burst amount will not be transferred between cores.
+As a result, this mechanism still strictly limits the task group to quota
+average usage, albeit over a longer time window than a single period.  This
+also limits the burst ability to no more than 1ms per cpu.  This provides
+better more predictable user experience for highly threaded applications with
+small quota limits on high core count machines. It also eliminates the
+propensity to throttle these applications while simultanously using less than
+quota amounts of cpu. Another way to say this, is that by allowing the unused
+portion of a slice to remain valid across periods we have decreased the
+possibility of wastefully expiring quota on cpu-local silos that don't need a
+full slice's amount of cpu time.
+
+The interaction between cpu-bound and non-cpu-bound-interactive applications
+should also be considered, especially when single core usage hits 100%. If you
+gave each of these applications half of a cpu-core and they both got scheduled
+on the same CPU it is theoretically possible that the non-cpu bound application
+will use up to 1ms additional quota in some periods, thereby preventing the
+cpu-bound application from fully using its quota by that same amount. In these
+instances it will be up to the CFS algorithm (see sched-design-CFS.rst) to
+decide which application is chosen to run, as they will both be runnable and
+have remaining quota. This runtime discrepancy will be made up in the following
+periods when the interactive application idles.
+
 Examples
 --------
 1. Limit a group to 1 CPU worth of runtime::
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fb75c0bea80f..7d8043fc8317 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4371,8 +4371,6 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 
 	now = sched_clock_cpu(smp_processor_id());
 	cfs_b->runtime = cfs_b->quota;
-	cfs_b->runtime_expires = now + ktime_to_ns(cfs_b->period);
-	cfs_b->expires_seq++;
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -4394,8 +4392,7 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 {
 	struct task_group *tg = cfs_rq->tg;
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(tg);
-	u64 amount = 0, min_amount, expires;
-	int expires_seq;
+	u64 amount = 0, min_amount;
 
 	/* note: this is a positive sum as runtime_remaining <= 0 */
 	min_amount = sched_cfs_bandwidth_slice() - cfs_rq->runtime_remaining;
@@ -4412,61 +4409,17 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 			cfs_b->idle = 0;
 		}
 	}
-	expires_seq = cfs_b->expires_seq;
-	expires = cfs_b->runtime_expires;
 	raw_spin_unlock(&cfs_b->lock);
 
 	cfs_rq->runtime_remaining += amount;
-	/*
-	 * we may have advanced our local expiration to account for allowed
-	 * spread between our sched_clock and the one on which runtime was
-	 * issued.
-	 */
-	if (cfs_rq->expires_seq != expires_seq) {
-		cfs_rq->expires_seq = expires_seq;
-		cfs_rq->runtime_expires = expires;
-	}
 
 	return cfs_rq->runtime_remaining > 0;
 }
 
-/*
- * Note: This depends on the synchronization provided by sched_clock and the
- * fact that rq->clock snapshots this value.
- */
-static void expire_cfs_rq_runtime(struct cfs_rq *cfs_rq)
-{
-	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
-
-	/* if the deadline is ahead of our clock, nothing to do */
-	if (likely((s64)(rq_clock(rq_of(cfs_rq)) - cfs_rq->runtime_expires) < 0))
-		return;
-
-	if (cfs_rq->runtime_remaining < 0)
-		return;
-
-	/*
-	 * If the local deadline has passed we have to consider the
-	 * possibility that our sched_clock is 'fast' and the global deadline
-	 * has not truly expired.
-	 *
-	 * Fortunately we can check determine whether this the case by checking
-	 * whether the global deadline(cfs_b->expires_seq) has advanced.
-	 */
-	if (cfs_rq->expires_seq == cfs_b->expires_seq) {
-		/* extend local deadline, drift is bounded above by 2 ticks */
-		cfs_rq->runtime_expires += TICK_NSEC;
-	} else {
-		/* global deadline is ahead, expiration has passed */
-		cfs_rq->runtime_remaining = 0;
-	}
-}
-
 static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 {
 	/* dock delta_exec before expiring quota (as it could span periods) */
 	cfs_rq->runtime_remaining -= delta_exec;
-	expire_cfs_rq_runtime(cfs_rq);
 
 	if (likely(cfs_rq->runtime_remaining > 0))
 		return;
@@ -4661,8 +4614,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		resched_curr(rq);
 }
 
-static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
-		u64 remaining, u64 expires)
+static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
 {
 	struct cfs_rq *cfs_rq;
 	u64 runtime;
@@ -4684,7 +4636,6 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
 		remaining -= runtime;
 
 		cfs_rq->runtime_remaining += runtime;
-		cfs_rq->runtime_expires = expires;
 
 		/* we check whether we're throttled above */
 		if (cfs_rq->runtime_remaining > 0)
@@ -4709,7 +4660,7 @@ next:
  */
 static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, unsigned long flags)
 {
-	u64 runtime, runtime_expires;
+	u64 runtime;
 	int throttled;
 
 	/* no need to continue the timer with no bandwidth constraint */
@@ -4737,8 +4688,6 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
 	/* account preceding periods in which throttling occurred */
 	cfs_b->nr_throttled += overrun;
 
-	runtime_expires = cfs_b->runtime_expires;
-
 	/*
 	 * This check is repeated as we are holding onto the new bandwidth while
 	 * we unthrottle. This can potentially race with an unthrottled group
@@ -4751,8 +4700,7 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
 		cfs_b->distribute_running = 1;
 		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		/* we can't nest cfs_b->lock while distributing bandwidth */
-		runtime = distribute_cfs_runtime(cfs_b, runtime,
-						 runtime_expires);
+		runtime = distribute_cfs_runtime(cfs_b, runtime);
 		raw_spin_lock_irqsave(&cfs_b->lock, flags);
 
 		cfs_b->distribute_running = 0;
@@ -4834,8 +4782,7 @@ static void __return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 		return;
 
 	raw_spin_lock(&cfs_b->lock);
-	if (cfs_b->quota != RUNTIME_INF &&
-	    cfs_rq->runtime_expires == cfs_b->runtime_expires) {
+	if (cfs_b->quota != RUNTIME_INF) {
 		cfs_b->runtime += slack_runtime;
 
 		/* we are under rq->lock, defer unthrottling using a timer */
@@ -4868,7 +4815,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 {
 	u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
 	unsigned long flags;
-	u64 expires;
 
 	/* confirm we're still not at a refresh boundary */
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
@@ -4886,7 +4832,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	if (cfs_b->quota != RUNTIME_INF && cfs_b->runtime > slice)
 		runtime = cfs_b->runtime;
 
-	expires = cfs_b->runtime_expires;
 	if (runtime)
 		cfs_b->distribute_running = 1;
 
@@ -4895,11 +4840,10 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	if (!runtime)
 		return;
 
-	runtime = distribute_cfs_runtime(cfs_b, runtime, expires);
+	runtime = distribute_cfs_runtime(cfs_b, runtime);
 
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
-	if (expires == cfs_b->runtime_expires)
-		lsub_positive(&cfs_b->runtime, runtime);
+	lsub_positive(&cfs_b->runtime, runtime);
 	cfs_b->distribute_running = 0;
 	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 }
@@ -5056,8 +5000,6 @@ void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 
 	cfs_b->period_active = 1;
 	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
-	cfs_b->runtime_expires += (overrun + 1) * ktime_to_ns(cfs_b->period);
-	cfs_b->expires_seq++;
 	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7583faddba33..ea48aa5daeee 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -335,8 +335,6 @@ struct cfs_bandwidth {
 	u64			quota;
 	u64			runtime;
 	s64			hierarchical_quota;
-	u64			runtime_expires;
-	int			expires_seq;
 
 	u8			idle;
 	u8			period_active;
@@ -557,8 +555,6 @@ struct cfs_rq {
 
 #ifdef CONFIG_CFS_BANDWIDTH
 	int			runtime_enabled;
-	int			expires_seq;
-	u64			runtime_expires;
 	s64			runtime_remaining;
 
 	u64			throttled_clock;
