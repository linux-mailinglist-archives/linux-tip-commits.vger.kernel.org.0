Return-Path: <linux-tip-commits+bounces-7338-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA22C5D16A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 13:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EB144ED555
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7FD315D47;
	Fri, 14 Nov 2025 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T/04Qe/K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p+P0C9BR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C3523370F;
	Fri, 14 Nov 2025 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122749; cv=none; b=i9qN4ByscQsTKndgbUydBO5+vmhekdq02jlwoa+JBQrUKtORBU6sEHJAkTdoqgs9Un98glz83lsbXz8+rl2XCG6bw1G58rlrELenZlwAXzSYZwxMjyhGiYtVseXaiRALv9CJL7hhZJi9A4Vk8Va2Rw4Px5CJgPrfg1zSGxm+Fms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122749; c=relaxed/simple;
	bh=429W8PMIzv/YspXwXx7mBvYdf90BQ/Pl+g3uE5yWjUE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aPzw17CDO2XPRPh11u81u6LcxuL3j21TpnvhOFgPzlvvDrhLtWpqArObh6j4NSn7NifP2JySTD4t8HK/g4f+vD4uh4B0PNgn0Bjnf4F7BziKnMG+Wa1/Xx3l9lSuZ9oZg6n9+HQshIfW+d0bJvXYqcXjf8jf151j6GE66SdOsao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T/04Qe/K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p+P0C9BR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 12:19:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763122745;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7MFLMVcDQEL909lLdK+YMky6bECdlTGy4CxvkLxzAA=;
	b=T/04Qe/Ko9h7cJJ/rPZVh/t8Fa8J9+5Sg9QzUsuL1m/ilchh5kl+j9N/LG8IMopdWzK12H
	eUwOu7jgT5oJCBaTuiAeo+dAT/F767g9N4WOpt+z/aPZnTmNNuQ5Q+/XuSwMtxHUy+shEX
	hKOCeDBVgadYZ0A85YbohXJjvmLszRwWiocTK7lGhKKumPp2FHV8s4z8OrzBFuRAJU9bKg
	8FVYfOq6V4P2ptp7CHjweHDsNx2NU32I4Ppo7DUDwNKOLzm2Ca5K1RvYy9DdvNO+TMFkWR
	hPFVbn4Akn+FQ3ByOhxXzVG9ReSxwr3F7OGkceUSAKrJ9xOzWSz5qMVXvpXr3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763122745;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7MFLMVcDQEL909lLdK+YMky6bECdlTGy4CxvkLxzAA=;
	b=p+P0C9BRtngDKtPhN/FVVl+UAsJHi7Cq+igZBcGuuhXT6G79QYF3kU12XQg66Sg7NmEALe
	sSlRKkjwf0lzURBQ==
From: "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Reimplement NEXT_BUDDY to align with
 EEVDF goals
Cc: Mel Gorman <mgorman@techsingularity.net>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251112122521.1331238-3-mgorman@techsingularity.net>
References: <20251112122521.1331238-3-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176312274389.498.14436910690168582466.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     523afd46059d80351189630355ab7e6eccd6451e
Gitweb:        https://git.kernel.org/tip/523afd46059d80351189630355ab7e6eccd=
6451e
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Wed, 12 Nov 2025 12:25:21=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Nov 2025 13:03:07 +01:00

sched/fair: Reimplement NEXT_BUDDY to align with EEVDF goals

Reimplement NEXT_BUDDY preemption to take into account the deadline and
eligibility of the wakee with respect to the waker. In the event
multiple buddies could be considered, the one with the earliest deadline
is selected.

Sync wakeups are treated differently to every other type of wakeup. The
WF_SYNC assumption is that the waker promises to sleep in the very near
future. This is violated in enough cases that WF_SYNC should be treated
as a suggestion instead of a contract. If a waker does go to sleep almost
immediately then the delay in wakeup is negligible. In other cases, it's
throttled based on the accumulated runtime of the waker so there is a
chance that some batched wakeups have been issued before preemption.

For all other wakeups, preemption happens if the wakee has a earlier
deadline than the waker and eligible to run.

While many workloads were tested, the two main targets were a modified
dbench4 benchmark and hackbench because the are on opposite ends of the
spectrum -- one prefers throughput by avoiding preemption and the other
relies on preemption.

First is the dbench throughput data even though it is a poor metric but
it is the default metric. The test machine is a 2-socket machine and the
backing filesystem is XFS as a lot of the IO work is dispatched to kernel
threads. It's important to note that these results are not representative
across all machines, especially Zen machines, as different bottlenecks
are exposed on different machines and filesystems.

dbench4 Throughput (misleading but traditional)
                            6.18-rc1               6.18-rc1
                             vanilla   sched-preemptnext-v5
Hmean     1       1268.80 (   0.00%)     1269.74 (   0.07%)
Hmean     4       3971.74 (   0.00%)     3950.59 (  -0.53%)
Hmean     7       5548.23 (   0.00%)     5420.08 (  -2.31%)
Hmean     12      7310.86 (   0.00%)     7165.57 (  -1.99%)
Hmean     21      8874.53 (   0.00%)     9149.04 (   3.09%)
Hmean     30      9361.93 (   0.00%)    10530.04 (  12.48%)
Hmean     48      9540.14 (   0.00%)    11820.40 (  23.90%)
Hmean     79      9208.74 (   0.00%)    12193.79 (  32.42%)
Hmean     110     8573.12 (   0.00%)    11933.72 (  39.20%)
Hmean     141     7791.33 (   0.00%)    11273.90 (  44.70%)
Hmean     160     7666.60 (   0.00%)    10768.72 (  40.46%)

As throughput is misleading, the benchmark is modified to use a short
loadfile report the completion time duration in milliseconds.

dbench4 Loadfile Execution Time
                             6.18-rc1               6.18-rc1
                              vanilla   sched-preemptnext-v5
Amean      1         14.62 (   0.00%)       14.69 (  -0.46%)
Amean      4         18.76 (   0.00%)       18.85 (  -0.45%)
Amean      7         23.71 (   0.00%)       24.38 (  -2.82%)
Amean      12        31.25 (   0.00%)       31.87 (  -1.97%)
Amean      21        45.12 (   0.00%)       43.69 (   3.16%)
Amean      30        61.07 (   0.00%)       54.33 (  11.03%)
Amean      48        95.91 (   0.00%)       77.22 (  19.49%)
Amean      79       163.38 (   0.00%)      123.08 (  24.66%)
Amean      110      243.91 (   0.00%)      175.11 (  28.21%)
Amean      141      343.47 (   0.00%)      239.10 (  30.39%)
Amean      160      401.15 (   0.00%)      283.73 (  29.27%)
Stddev     1          0.52 (   0.00%)        0.51 (   2.45%)
Stddev     4          1.36 (   0.00%)        1.30 (   4.04%)
Stddev     7          1.88 (   0.00%)        1.87 (   0.72%)
Stddev     12         3.06 (   0.00%)        2.45 (  19.83%)
Stddev     21         5.78 (   0.00%)        3.87 (  33.06%)
Stddev     30         9.85 (   0.00%)        5.25 (  46.76%)
Stddev     48        22.31 (   0.00%)        8.64 (  61.27%)
Stddev     79        35.96 (   0.00%)       18.07 (  49.76%)
Stddev     110       59.04 (   0.00%)       30.93 (  47.61%)
Stddev     141       85.38 (   0.00%)       40.93 (  52.06%)
Stddev     160       96.38 (   0.00%)       39.72 (  58.79%)

That is still looking good and the variance is reduced quite a bit.
Finally, fairness is a concern so the next report tracks how many
milliseconds does it take for all clients to complete a workfile. This
one is tricky because dbench makes to effort to synchronise clients so
the durations at benchmark start time differ substantially from typical
runtimes. This problem could be mitigated by warming up the benchmark
for a number of minutes but it's a matter of opinion whether that
counts as an evasion of inconvenient results.

dbench4 All Clients Loadfile Execution Time
                             6.18-rc1               6.18-rc1
                              vanilla   sched-preemptnext-v5
Amean      1         15.06 (   0.00%)       15.07 (  -0.03%)
Amean      4        603.81 (   0.00%)      524.29 (  13.17%)
Amean      7        855.32 (   0.00%)     1331.07 ( -55.62%)
Amean      12      1890.02 (   0.00%)     2323.97 ( -22.96%)
Amean      21      3195.23 (   0.00%)     2009.29 (  37.12%)
Amean      30     13919.53 (   0.00%)     4579.44 (  67.10%)
Amean      48     25246.07 (   0.00%)     5705.46 (  77.40%)
Amean      79     29701.84 (   0.00%)    15509.26 (  47.78%)
Amean      110    22803.03 (   0.00%)    23782.08 (  -4.29%)
Amean      141    36356.07 (   0.00%)    25074.20 (  31.03%)
Amean      160    17046.71 (   0.00%)    13247.62 (  22.29%)
Stddev     1          0.47 (   0.00%)        0.49 (  -3.74%)
Stddev     4        395.24 (   0.00%)      254.18 (  35.69%)
Stddev     7        467.24 (   0.00%)      764.42 ( -63.60%)
Stddev     12      1071.43 (   0.00%)     1395.90 ( -30.28%)
Stddev     21      1694.50 (   0.00%)     1204.89 (  28.89%)
Stddev     30      7945.63 (   0.00%)     2552.59 (  67.87%)
Stddev     48     14339.51 (   0.00%)     3227.55 (  77.49%)
Stddev     79     16620.91 (   0.00%)     8422.15 (  49.33%)
Stddev     110    12912.15 (   0.00%)    13560.95 (  -5.02%)
Stddev     141    20700.13 (   0.00%)    14544.51 (  29.74%)
Stddev     160     9079.16 (   0.00%)     7400.69 (  18.49%)

This is more of a mixed bag but it at least shows that fairness
is not crippled.

The hackbench results are more neutral but this is still important.
It's possible to boost the dbench figures by a large amount but only by
crippling the performance of a workload like hackbench. The WF_SYNC
behaviour is important for these workloads and is why the WF_SYNC
changes are not a separate patch.

hackbench-process-pipes
                          6.18-rc1             6.18-rc1
                             vanilla   sched-preemptnext-v5
Amean     1        0.2657 (   0.00%)      0.2150 (  19.07%)
Amean     4        0.6107 (   0.00%)      0.6060 (   0.76%)
Amean     7        0.7923 (   0.00%)      0.7440 (   6.10%)
Amean     12       1.1500 (   0.00%)      1.1263 (   2.06%)
Amean     21       1.7950 (   0.00%)      1.7987 (  -0.20%)
Amean     30       2.3207 (   0.00%)      2.5053 (  -7.96%)
Amean     48       3.5023 (   0.00%)      3.9197 ( -11.92%)
Amean     79       4.8093 (   0.00%)      5.2247 (  -8.64%)
Amean     110      6.1160 (   0.00%)      6.6650 (  -8.98%)
Amean     141      7.4763 (   0.00%)      7.8973 (  -5.63%)
Amean     172      8.9560 (   0.00%)      9.3593 (  -4.50%)
Amean     203     10.4783 (   0.00%)     10.8347 (  -3.40%)
Amean     234     12.4977 (   0.00%)     13.0177 (  -4.16%)
Amean     265     14.7003 (   0.00%)     15.5630 (  -5.87%)
Amean     296     16.1007 (   0.00%)     17.4023 (  -8.08%)

Processes using pipes are impacted but the variance (not presented) indicates
it's close to noise and the results are not always reproducible. If executed
across multiple reboots, it may show neutral or small gains so the worst
measured results are presented.

Hackbench using sockets is more reliably neutral as the wakeup
mechanisms are different between sockets and pipes.

hackbench-process-sockets
                          6.18-rc1             6.18-rc1
                             vanilla   sched-preemptnext-v2
Amean     1        0.3073 (   0.00%)      0.3263 (  -6.18%)
Amean     4        0.7863 (   0.00%)      0.7930 (  -0.85%)
Amean     7        1.3670 (   0.00%)      1.3537 (   0.98%)
Amean     12       2.1337 (   0.00%)      2.1903 (  -2.66%)
Amean     21       3.4683 (   0.00%)      3.4940 (  -0.74%)
Amean     30       4.7247 (   0.00%)      4.8853 (  -3.40%)
Amean     48       7.6097 (   0.00%)      7.8197 (  -2.76%)
Amean     79      14.7957 (   0.00%)     16.1000 (  -8.82%)
Amean     110     21.3413 (   0.00%)     21.9997 (  -3.08%)
Amean     141     29.0503 (   0.00%)     29.0353 (   0.05%)
Amean     172     36.4660 (   0.00%)     36.1433 (   0.88%)
Amean     203     39.7177 (   0.00%)     40.5910 (  -2.20%)
Amean     234     42.1120 (   0.00%)     43.5527 (  -3.42%)
Amean     265     45.7830 (   0.00%)     50.0560 (  -9.33%)
Amean     296     50.7043 (   0.00%)     54.3657 (  -7.22%)

As schbench has been mentioned in numerous bugs recently, the results
are interesting. A test case that represents the default schbench
behaviour is

schbench Wakeup Latency (usec)
                                       6.18.0-rc1             6.18.0-rc1
                                          vanilla   sched-preemptnext-v5
Amean     Wakeup-50th-80          7.17 (   0.00%)        6.00 (  16.28%)
Amean     Wakeup-90th-80         46.56 (   0.00%)       19.78 (  57.52%)
Amean     Wakeup-99th-80        119.61 (   0.00%)       89.94 (  24.80%)
Amean     Wakeup-99.9th-80     3193.78 (   0.00%)      328.22 (  89.72%)

schbench Requests Per Second (ops/sec)
                                  6.18.0-rc1             6.18.0-rc1
                                     vanilla   sched-preemptnext-v5
Hmean     RPS-20th-80     8900.91 (   0.00%)     9176.78 (   3.10%)
Hmean     RPS-50th-80     8987.41 (   0.00%)     9217.89 (   2.56%)
Hmean     RPS-90th-80     9123.73 (   0.00%)     9273.25 (   1.64%)
Hmean     RPS-max-80      9193.50 (   0.00%)     9301.47 (   1.17%)

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251112122521.1331238-3-mgorman@techsingulari=
ty.net
---
 kernel/sched/fair.c | 152 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 130 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 320eedd..11d480e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -929,6 +929,16 @@ static struct sched_entity *__pick_eevdf(struct cfs_rq *=
cfs_rq, bool protect)
 	if (cfs_rq->nr_queued =3D=3D 1)
 		return curr && curr->on_rq ? curr : se;
=20
+	/*
+	 * Picking the ->next buddy will affect latency but not fairness.
+	 */
+	if (sched_feat(PICK_BUDDY) &&
+	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
+		/* ->next will never be delayed */
+		WARN_ON_ONCE(cfs_rq->next->sched_delayed);
+		return cfs_rq->next;
+	}
+
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr =3D NULL;
=20
@@ -1167,6 +1177,8 @@ static s64 update_se(struct rq *rq, struct sched_entity=
 *se)
 	return delta_exec;
 }
=20
+static void set_next_buddy(struct sched_entity *se);
+
 /*
  * Used by other classes to account runtime.
  */
@@ -5466,16 +5478,6 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *se;
=20
-	/*
-	 * Picking the ->next buddy will affect latency but not fairness.
-	 */
-	if (sched_feat(PICK_BUDDY) &&
-	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
-		/* ->next will never be delayed */
-		WARN_ON_ONCE(cfs_rq->next->sched_delayed);
-		return cfs_rq->next;
-	}
-
 	se =3D pick_eevdf(cfs_rq);
 	if (se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
@@ -6988,8 +6990,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p,=
 int flags)
 	hrtick_update(rq);
 }
=20
-static void set_next_buddy(struct sched_entity *se);
-
 /*
  * Basically dequeue_task_fair(), except it can deal with dequeue_entity()
  * failing half-way through and resume the dequeue later.
@@ -8676,16 +8676,81 @@ static void set_next_buddy(struct sched_entity *se)
 	}
 }
=20
+enum preempt_wakeup_action {
+	PREEMPT_WAKEUP_NONE,	/* No preemption. */
+	PREEMPT_WAKEUP_SHORT,	/* Ignore slice protection. */
+	PREEMPT_WAKEUP_PICK,	/* Let __pick_eevdf() decide. */
+	PREEMPT_WAKEUP_RESCHED,	/* Force reschedule. */
+};
+
+static inline bool
+set_preempt_buddy(struct cfs_rq *cfs_rq, int wake_flags,
+		  struct sched_entity *pse, struct sched_entity *se)
+{
+	/*
+	 * Keep existing buddy if the deadline is sooner than pse.
+	 * The older buddy may be cache cold and completely unrelated
+	 * to the current wakeup but that is unpredictable where as
+	 * obeying the deadline is more in line with EEVDF objectives.
+	 */
+	if (cfs_rq->next && entity_before(cfs_rq->next, pse))
+		return false;
+
+	set_next_buddy(pse);
+	return true;
+}
+
+/*
+ * WF_SYNC|WF_TTWU indicates the waker expects to sleep but it is not
+ * strictly enforced because the hint is either misunderstood or
+ * multiple tasks must be woken up.
+ */
+static inline enum preempt_wakeup_action
+preempt_sync(struct rq *rq, int wake_flags,
+	     struct sched_entity *pse, struct sched_entity *se)
+{
+	u64 threshold, delta;
+
+	/*
+	 * WF_SYNC without WF_TTWU is not expected so warn if it happens even
+	 * though it is likely harmless.
+	 */
+	WARN_ON_ONCE(!(wake_flags & WF_TTWU));
+
+	threshold =3D sysctl_sched_migration_cost;
+	delta =3D rq_clock_task(rq) - se->exec_start;
+	if ((s64)delta < 0)
+		delta =3D 0;
+
+	/*
+	 * WF_RQ_SELECTED implies the tasks are stacking on a CPU when they
+	 * could run on other CPUs. Reduce the threshold before preemption is
+	 * allowed to an arbitrary lower value as it is more likely (but not
+	 * guaranteed) the waker requires the wakee to finish.
+	 */
+	if (wake_flags & WF_RQ_SELECTED)
+		threshold >>=3D 2;
+
+	/*
+	 * As WF_SYNC is not strictly obeyed, allow some runtime for batch
+	 * wakeups to be issued.
+	 */
+	if (entity_before(pse, se) && delta >=3D threshold)
+		return PREEMPT_WAKEUP_RESCHED;
+
+	return PREEMPT_WAKEUP_NONE;
+}
+
 /*
  * Preempt the current task with a newly woken task if needed:
  */
 static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, =
int wake_flags)
 {
+	enum preempt_wakeup_action preempt_action =3D PREEMPT_WAKEUP_PICK;
 	struct task_struct *donor =3D rq->donor;
 	struct sched_entity *se =3D &donor->se, *pse =3D &p->se;
 	struct cfs_rq *cfs_rq =3D task_cfs_rq(donor);
 	int cse_is_idle, pse_is_idle;
-	bool do_preempt_short =3D false;
=20
 	if (unlikely(se =3D=3D pse))
 		return;
@@ -8699,10 +8764,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, s=
truct task_struct *p, int=20
 	if (task_is_throttled(p))
 		return;
=20
-	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delaye=
d) {
-		set_next_buddy(pse);
-	}
-
 	/*
 	 * We can come here with TIF_NEED_RESCHED already set from new task
 	 * wake up path.
@@ -8734,7 +8795,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, st=
ruct task_struct *p, int=20
 		 * When non-idle entity preempt an idle entity,
 		 * don't give idle entity slice protection.
 		 */
-		do_preempt_short =3D true;
+		preempt_action =3D PREEMPT_WAKEUP_SHORT;
 		goto preempt;
 	}
=20
@@ -8753,21 +8814,68 @@ static void check_preempt_wakeup_fair(struct rq *rq, =
struct task_struct *p, int=20
 	 * If @p has a shorter slice than current and @p is eligible, override
 	 * current's slice protection in order to allow preemption.
 	 */
-	do_preempt_short =3D sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice);
+	if (sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice)) {
+		preempt_action =3D PREEMPT_WAKEUP_SHORT;
+		goto pick;
+	}
=20
 	/*
+	 * Ignore wakee preemption on WF_FORK as it is less likely that
+	 * there is shared data as exec often follow fork. Do not
+	 * preempt for tasks that are sched_delayed as it would violate
+	 * EEVDF to forcibly queue an ineligible task.
+	 */
+	if ((wake_flags & WF_FORK) || pse->sched_delayed)
+		return;
+
+	/*
+	 * If @p potentially is completing work required by current then
+	 * consider preemption.
+	 *
+	 * Reschedule if waker is no longer eligible. */
+	if (in_task() && !entity_eligible(cfs_rq, se)) {
+		preempt_action =3D PREEMPT_WAKEUP_RESCHED;
+		goto preempt;
+	}
+
+	/* Prefer picking wakee soon if appropriate. */
+	if (sched_feat(NEXT_BUDDY) &&
+	    set_preempt_buddy(cfs_rq, wake_flags, pse, se)) {
+
+		/*
+		 * Decide whether to obey WF_SYNC hint for a new buddy. Old
+		 * buddies are ignored as they may not be relevant to the
+		 * waker and less likely to be cache hot.
+		 */
+		if (wake_flags & WF_SYNC)
+			preempt_action =3D preempt_sync(rq, wake_flags, pse, se);
+	}
+
+	switch (preempt_action) {
+	case PREEMPT_WAKEUP_NONE:
+		return;
+	case PREEMPT_WAKEUP_RESCHED:
+		goto preempt;
+	case PREEMPT_WAKEUP_SHORT:
+		fallthrough;
+	case PREEMPT_WAKEUP_PICK:
+		break;
+	}
+
+pick:
+	/*
 	 * If @p has become the most eligible task, force preemption.
 	 */
-	if (__pick_eevdf(cfs_rq, !do_preempt_short) =3D=3D pse)
+	if (__pick_eevdf(cfs_rq, preempt_action !=3D PREEMPT_WAKEUP_SHORT) =3D=3D p=
se)
 		goto preempt;
=20
-	if (sched_feat(RUN_TO_PARITY) && do_preempt_short)
+	if (sched_feat(RUN_TO_PARITY))
 		update_protect_slice(cfs_rq, se);
=20
 	return;
=20
 preempt:
-	if (do_preempt_short)
+	if (preempt_action =3D=3D PREEMPT_WAKEUP_SHORT)
 		cancel_protect_slice(se);
=20
 	resched_curr_lazy(rq);

