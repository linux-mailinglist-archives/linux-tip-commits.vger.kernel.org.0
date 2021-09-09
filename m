Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7B8404914
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 13:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbhIILTi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 07:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbhIILTh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 07:19:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A78C061756;
        Thu,  9 Sep 2021 04:18:27 -0700 (PDT)
Date:   Thu, 09 Sep 2021 11:18:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631186306;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qojfv8p+CGt/FAzck2WkiIXF4yIo260CHEMylymc2ok=;
        b=vZVs0CdPYra0Z+3tTcyCmli8j+Ff3yn9iYqMj7idLKQjxz3KGaLmpDwaVPwW5mNhwNpfY4
        EKhFLuX3qj5ayY2cuuPKzyCDF8TQF74NAHjKJ+mOG6bmHLa7uazFYl4F4jUHZoBV08+kUD
        /9YCH7T9qOPbGgMKbGa+WmleQxa1vxZwKp1IsfoJMUiryXHB6D1sVkTs3xfvcNcz53v9x2
        WogtQg8kF9jFLw4zA76PEk/FohXfSVXf+aQlQ2i4r5E/6ZkeH11OuPXUg87aBBP4JpVQsK
        I/jFLGWmb/vtX1xYwbA+PYof1EidtHvDELuSdcpFci0/QWBzL3yiiEBn9X4RHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631186306;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qojfv8p+CGt/FAzck2WkiIXF4yIo260CHEMylymc2ok=;
        b=Oopeu6qRRrgZQ4FOQSf5KMuSqODR0AtuF8n82FnvxPWudKcwCoMN4iY/HX9yDhiAevViMo
        ib5TU/CkHuHiOTDA==
From:   "tip-bot2 for Huaixin Chang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Add document for burstable CFS bandwidth
Cc:     Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210830032215.16302-3-changhuaixin@linux.alibaba.com>
References: <20210830032215.16302-3-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <163118630518.25758.11503634763541992980.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9de47777ee77c2b9bedf43ba92900b199cf1457e
Gitweb:        https://git.kernel.org/tip/9de47777ee77c2b9bedf43ba92900b199cf1457e
Author:        Huaixin Chang <changhuaixin@linux.alibaba.com>
AuthorDate:    Mon, 30 Aug 2021 11:22:15 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 09 Sep 2021 11:27:32 +02:00

sched/fair: Add document for burstable CFS bandwidth

Basic description of usage and effect for CFS Bandwidth Control Burst.

Co-developed-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Co-developed-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20210830032215.16302-3-changhuaixin@linux.alibaba.com
---
 Documentation/admin-guide/cgroup-v2.rst |  8 ++-
 Documentation/scheduler/sched-bwc.rst   | 84 +++++++++++++++++++++---
 2 files changed, 83 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index b1e81aa..4cee0f3 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1000,6 +1000,8 @@ All time durations are in microseconds.
 	- nr_periods
 	- nr_throttled
 	- throttled_usec
+	- nr_bursts
+	- burst_usec
 
   cpu.weight
 	A read-write single value file which exists on non-root
@@ -1031,6 +1033,12 @@ All time durations are in microseconds.
 	$PERIOD duration.  "max" for $MAX indicates no limit.  If only
 	one number is written, $MAX is updated.
 
+  cpu.max.burst
+	A read-write single value file which exists on non-root
+	cgroups.  The default is "0".
+
+	The burst in the range [0, $MAX].
+
   cpu.pressure
 	A read-write nested-keyed file.
 
diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
index 845eee6..023b366 100644
--- a/Documentation/scheduler/sched-bwc.rst
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -22,9 +22,52 @@ cfs_quota units at each period boundary. As threads consume this bandwidth it
 is transferred to cpu-local "silos" on a demand basis. The amount transferred
 within each of these updates is tunable and described as the "slice".
 
+Burst feature
+-------------
+This feature borrows time now against our future underrun, at the cost of
+increased interference against the other system users. All nicely bounded.
+
+Traditional (UP-EDF) bandwidth control is something like:
+
+  (U = \Sum u_i) <= 1
+
+This guaranteeds both that every deadline is met and that the system is
+stable. After all, if U were > 1, then for every second of walltime,
+we'd have to run more than a second of program time, and obviously miss
+our deadline, but the next deadline will be further out still, there is
+never time to catch up, unbounded fail.
+
+The burst feature observes that a workload doesn't always executes the full
+quota; this enables one to describe u_i as a statistical distribution.
+
+For example, have u_i = {x,e}_i, where x is the p(95) and x+e p(100)
+(the traditional WCET). This effectively allows u to be smaller,
+increasing the efficiency (we can pack more tasks in the system), but at
+the cost of missing deadlines when all the odds line up. However, it
+does maintain stability, since every overrun must be paired with an
+underrun as long as our x is above the average.
+
+That is, suppose we have 2 tasks, both specify a p(95) value, then we
+have a p(95)*p(95) = 90.25% chance both tasks are within their quota and
+everything is good. At the same time we have a p(5)p(5) = 0.25% chance
+both tasks will exceed their quota at the same time (guaranteed deadline
+fail). Somewhere in between there's a threshold where one exceeds and
+the other doesn't underrun enough to compensate; this depends on the
+specific CDFs.
+
+At the same time, we can say that the worst case deadline miss, will be
+\Sum e_i; that is, there is a bounded tardiness (under the assumption
+that x+e is indeed WCET).
+
+The interferenece when using burst is valued by the possibilities for
+missing the deadline and the average WCET. Test results showed that when
+there many cgroups or CPU is under utilized, the interference is
+limited. More details are shown in:
+https://lore.kernel.org/lkml/5371BD36-55AE-4F71-B9D7-B86DC32E3D2B@linux.alibaba.com/
+
 Management
 ----------
-Quota and period are managed within the cpu subsystem via cgroupfs.
+Quota, period and burst are managed within the cpu subsystem via cgroupfs.
 
 .. note::
    The cgroupfs files described in this section are only applicable
@@ -32,29 +75,37 @@ Quota and period are managed within the cpu subsystem via cgroupfs.
    :ref:`Documentation/admin-guide/cgroupv2.rst <cgroup-v2-cpu>`.
 
 - cpu.cfs_quota_us: the total available run-time within a period (in
-  microseconds)
+- cpu.cfs_quota_us: run-time replenished within a period (in microseconds)
 - cpu.cfs_period_us: the length of a period (in microseconds)
 - cpu.stat: exports throttling statistics [explained further below]
+- cpu.cfs_burst_us: the maximum accumulated run-time (in microseconds)
 
 The default values are::
 
 	cpu.cfs_period_us=100ms
-	cpu.cfs_quota=-1
+	cpu.cfs_quota_us=-1
+	cpu.cfs_burst_us=0
 
 A value of -1 for cpu.cfs_quota_us indicates that the group does not have any
 bandwidth restriction in place, such a group is described as an unconstrained
 bandwidth group. This represents the traditional work-conserving behavior for
 CFS.
 
-Writing any (valid) positive value(s) will enact the specified bandwidth limit.
-The minimum quota allowed for the quota or period is 1ms. There is also an
-upper bound on the period length of 1s. Additional restrictions exist when
-bandwidth limits are used in a hierarchical fashion, these are explained in
-more detail below.
+Writing any (valid) positive value(s) no smaller than cpu.cfs_burst_us will
+enact the specified bandwidth limit. The minimum quota allowed for the quota or
+period is 1ms. There is also an upper bound on the period length of 1s.
+Additional restrictions exist when bandwidth limits are used in a hierarchical
+fashion, these are explained in more detail below.
 
 Writing any negative value to cpu.cfs_quota_us will remove the bandwidth limit
 and return the group to an unconstrained state once more.
 
+A value of 0 for cpu.cfs_burst_us indicates that the group can not accumulate
+any unused bandwidth. It makes the traditional bandwidth control behavior for
+CFS unchanged. Writing any (valid) positive value(s) no larger than
+cpu.cfs_quota_us into cpu.cfs_burst_us will enact the cap on unused bandwidth
+accumulation.
+
 Any updates to a group's bandwidth specification will result in it becoming
 unthrottled if it is in a constrained state.
 
@@ -74,7 +125,7 @@ for more fine-grained consumption.
 
 Statistics
 ----------
-A group's bandwidth statistics are exported via 3 fields in cpu.stat.
+A group's bandwidth statistics are exported via 5 fields in cpu.stat.
 
 cpu.stat:
 
@@ -82,6 +133,9 @@ cpu.stat:
 - nr_throttled: Number of times the group has been throttled/limited.
 - throttled_time: The total time duration (in nanoseconds) for which entities
   of the group have been throttled.
+- nr_bursts: Number of periods burst occurs.
+- burst_time: Cumulative wall-time (in nanoseconds) that any CPUs has used
+  above quota in respective periods
 
 This interface is read-only.
 
@@ -179,3 +233,15 @@ Examples
 
    By using a small period here we are ensuring a consistent latency
    response at the expense of burst capacity.
+
+4. Limit a group to 40% of 1 CPU, and allow accumulate up to 20% of 1 CPU
+   additionally, in case accumulation has been done.
+
+   With 50ms period, 20ms quota will be equivalent to 40% of 1 CPU.
+   And 10ms burst will be equivalent to 20% of 1 CPU.
+
+	# echo 20000 > cpu.cfs_quota_us /* quota = 20ms */
+	# echo 50000 > cpu.cfs_period_us /* period = 50ms */
+	# echo 10000 > cpu.cfs_burst_us /* burst = 10ms */
+
+   Larger buffer setting (no larger than quota) allows greater burst capacity.
