Return-Path: <linux-tip-commits+bounces-7887-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D4BD11153
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F20D30BC345
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D56D347BBE;
	Mon, 12 Jan 2026 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TzqRrXWY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UCy7JE0x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2A9346AEB;
	Mon, 12 Jan 2026 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205011; cv=none; b=Q3N4zZnWvXfcjZlUKspAugZYw+o5U3pzWYbhUuCBDvkv4rCr0o4gdvLYdoJmH+dKUxzObo6ksx3TzMBh0OZQqGs5448EAcobAwYAq9t2u6TjszrTY0VFqSYRoyxhRhl4+kUY0/XgdaNmqvBtWHvo8C4Zx195hOKIqyzfjqoX5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205011; c=relaxed/simple;
	bh=gc6R2Wm/8zzFJTblBC/ANO+5PxWc5h8L1lCmeyttNqQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LVI3zs4T09hpSS4jXYDZ1NUKUCUigeWlSlVg1gIJd2+Zd/wV2FAA1CLBodwduw3sYa2L2Y17hC2UA8Pq0Vtu89JC0rMbTQ1uq+2AsnijpHECAjm16NKyEFJ5PFJ0szhA4Z7CWbomfQcskNIIoaxvhyl43GUf+FLvM19RWS55jvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TzqRrXWY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UCy7JE0x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768205005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tm2fN4ydeEPb/1BXIDn/6BTJ20evyUtHsHopl9bBf4g=;
	b=TzqRrXWYWs0tqsVB/yH7bipB1I1N8ow+zLTcd4NKT1K7o+ZYpxzSct/aBi7cTQ+vgvll9x
	d25pcbt3fkNVfr7CiX06d7HkGOs5XvmcUKrOBsOF5TSQhXpmQOp0SX4ULSyOeW2pYyFsX8
	6NEYr1cjRVEZ8EP27A6RG+fuyM+4NKrZb2g81VPINNNxF/B2Va1FOguidyrVIjKHWKkFsJ
	TXphN6QPT4e2IHNlVXzgB1poceR9RGDW0unW713/wcWtaNtZXxJ/MsC+fRlIQLjg1r6TDR
	OLvt4NnlFdIyoWpgZ001X0DhzIhLnfF8TS8ZKighpGhD13kynRZEdmu4WHEa1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768205005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tm2fN4ydeEPb/1BXIDn/6BTJ20evyUtHsHopl9bBf4g=;
	b=UCy7JE0xu9qA1ci0wYPQiaPHq9WHnAPafz8W/fIb2HpbJhNA1+uxqlNfy4uJM3N1Cyi10g
	Zc9/u91SBCwY9nAw==
From: "tip-bot2 for Blake Jones" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Reorder some fields in struct rq
Cc: Blake Jones <blakejones@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Josh Don <joshdon@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251202023743.1524247-1-blakejones@google.com>
References: <20251202023743.1524247-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820500452.510.9884477534610904063.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     89951fc1f8201df27366ac1eed1ddc9ee0f47729
Gitweb:        https://git.kernel.org/tip/89951fc1f8201df27366ac1eed1ddc9ee0f=
47729
Author:        Blake Jones <blakejones@google.com>
AuthorDate:    Mon, 01 Dec 2025 18:37:43 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 Jan 2026 12:43:56 +01:00

sched: Reorder some fields in struct rq

This colocates some hot fields in "struct rq" to be on the same cache line
as others that are often accessed at the same time or in similar ways.

Using data from a Google-internal fleet-scale profiler, I found three
distinct groups of hot fields in struct rq:

- (1) The runqueue lock: __lock.

- (2) Those accessed from hot code in pick_next_task_fair():
      nr_running, nr_numa_running, nr_preferred_running,
      ttwu_pending, cpu_capacity, curr, idle.

- (3) Those accessed from some other hot codepaths, e.g.
      update_curr(), update_rq_clock(), and scheduler_tick():
      clock_task, clock_pelt, clock, lost_idle_time,
      clock_update_flags, clock_pelt_idle, clock_idle.

The cycles spent on accessing these different groups of fields broke down
roughly as follows:

- 50% on group (1) (the runqueue lock, always read-write)
- 39% on group (2) (load:store ratio around 38:1)
-  8% on group (3) (load:store ratio around 5:1)
-  3% on all the other fields

Most of the fields in group (3) are already in a cache line grouping; this
patch just adds "clock" and "clock_update_flags" to that group. The fields
in group (2) are scattered across several cache lines; the main effect of
this patch is to group them together, on a single line at the beginning of
the structure. A few other less performance-critical fields (nr_switches,
numa_migrate_on, has_blocked_load, nohz_csd, last_blocked_load_update_tick)
were also reordered to reduce holes in the data structure.

Since the runqueue lock is acquired from so many different contexts, and is
basically always accessed using an atomic operation, putting it on either
of the cache lines for groups (2) or (3) would slow down accesses to those
fields dramatically, since those groups are read-mostly accesses.

To test this, I wrote a focused load test that would put load on the
pick_next_task_fair() path. A parent process would fork many child
processes, and each child would nanosleep() for 1 msec many times in a
loop. The load test was monitored with "perf", and I looked at the amount
of cycles that were spent with sched_balance_rq() on the stack. The test
was reliably spending ~5% of all of its cycles there. I ran it 100 times
on a pair of 2-socket Intel Haswell machines (72 vCPUs per machine) - one
running the tip of sched/core, the other running this change - using 360
child processes and 8192 1-msec sleeps per child.  The mean cycle count
dropped from 5.14B to 4.91B, or a *4.6% decrease* in relevant scheduler
cycles.

Given that this change reduces cache misses in a very hot kernel codepath,
there's likely to be additional application performance improvement due to
reduced cache conflicts from kernel data structures.

On a Power11 system with 128-byte cache lines, my test showed a ~5%
decrease in relevant scheduler cycles, along with a slight increase in user
time - both positive indicators. This data comes from
https://lore.kernel.org/lkml/affdc6b1-9980-44d1-89db-d90730c1e384@linux.ibm.c=
om/
This is the case even though the additional "____cacheline_aligned" that
puts the runqueue lock on the next cache line adds an additional 64 bytes
of padding on those machines. This patch does not change the size of
"struct rq" on machines with 64-byte cache lines.

I also ran "hackbench" to try to test this change, but it didn't show
conclusive results.  Looking at a CPU cycle profile of the hackbench run,
it was spending 95% of its cycles inside __alloc_skb(), __kfree_skb(), or
kmem_cache_free() - almost all of which was spent updating memcg counters
or contending on the list_lock in kmem_cache_node. And it spent less than
0.5% of its cycles inside either schedule() or try_to_wake_up().  So it's
not surprising that it didn't show useful results here.

The "__no_randomize_layout" was added to reflect the fact that performance
of code that references this data structure is unusually sensitive to
placement of its members.

Signed-off-by: Blake Jones <blakejones@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reviewed-by: Josh Don <joshdon@google.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Link: https://patch.msgid.link/20251202023743.1524247-1-blakejones@google.com
---
 kernel/sched/sched.h | 75 ++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3ceaa9d..58c9d24 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1115,26 +1115,50 @@ DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
  * acquire operations must be ordered by ascending &runqueue.
  */
 struct rq {
-	/* runqueue lock: */
-	raw_spinlock_t		__lock;
-
+	/*
+	 * The following members are loaded together, without holding the
+	 * rq->lock, in an extremely hot loop in update_sg_lb_stats()
+	 * (called from pick_next_task()). To reduce cache pollution from
+	 * this operation, they are placed together on this dedicated cache
+	 * line. Even though some of them are frequently modified, they are
+	 * loaded much more frequently than they are stored.
+	 */
 	unsigned int		nr_running;
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int		nr_numa_running;
 	unsigned int		nr_preferred_running;
-	unsigned int		numa_migrate_on;
 #endif
+	unsigned int		ttwu_pending;
+	unsigned long		cpu_capacity;
+#ifdef CONFIG_SCHED_PROXY_EXEC
+	struct task_struct __rcu	*donor;  /* Scheduling context */
+	struct task_struct __rcu	*curr;   /* Execution context */
+#else
+	union {
+		struct task_struct __rcu *donor; /* Scheduler context */
+		struct task_struct __rcu *curr;  /* Execution context */
+	};
+#endif
+	struct task_struct	*idle;
+	/* padding left here deliberately */
+
+	/*
+	 * The next cacheline holds the (hot) runqueue lock, as well as
+	 * some other less performance-critical fields.
+	 */
+	u64			nr_switches	____cacheline_aligned;
+
+	/* runqueue lock: */
+	raw_spinlock_t		__lock;
+
 #ifdef CONFIG_NO_HZ_COMMON
-	unsigned long		last_blocked_load_update_tick;
-	unsigned int		has_blocked_load;
-	call_single_data_t	nohz_csd;
 	unsigned int		nohz_tick_stopped;
 	atomic_t		nohz_flags;
+	unsigned int		has_blocked_load;
+	unsigned long		last_blocked_load_update_tick;
+	call_single_data_t	nohz_csd;
 #endif /* CONFIG_NO_HZ_COMMON */
=20
-	unsigned int		ttwu_pending;
-	u64			nr_switches;
-
 #ifdef CONFIG_UCLAMP_TASK
 	/* Utilization clamp values based on CPU's RUNNABLE tasks */
 	struct uclamp_rq	uclamp[UCLAMP_CNT] ____cacheline_aligned;
@@ -1157,6 +1181,9 @@ struct rq {
 	struct list_head	*tmp_alone_branch;
 #endif /* CONFIG_FAIR_GROUP_SCHED */
=20
+#ifdef CONFIG_NUMA_BALANCING
+	unsigned int		numa_migrate_on;
+#endif
 	/*
 	 * This is part of a global counter where only the total sum
 	 * over all CPUs matters. A task can increase this counter on
@@ -1165,37 +1192,29 @@ struct rq {
 	 */
 	unsigned long		nr_uninterruptible;
=20
-#ifdef CONFIG_SCHED_PROXY_EXEC
-	struct task_struct __rcu	*donor;  /* Scheduling context */
-	struct task_struct __rcu	*curr;   /* Execution context */
-#else
-	union {
-		struct task_struct __rcu *donor; /* Scheduler context */
-		struct task_struct __rcu *curr;  /* Execution context */
-	};
-#endif
 	struct sched_dl_entity	*dl_server;
-	struct task_struct	*idle;
 	struct task_struct	*stop;
 	const struct sched_class *next_class;
 	unsigned long		next_balance;
 	struct mm_struct	*prev_mm;
=20
-	unsigned int		clock_update_flags;
-	u64			clock;
-	/* Ensure that all clocks are in the same cache line */
+	/*
+	 * The following fields of clock data are frequently referenced
+	 * and updated together, and should go on their own cache line.
+	 */
 	u64			clock_task ____cacheline_aligned;
 	u64			clock_pelt;
+	u64			clock;
 	unsigned long		lost_idle_time;
+	unsigned int		clock_update_flags;
 	u64			clock_pelt_idle;
 	u64			clock_idle;
+
 #ifndef CONFIG_64BIT
 	u64			clock_pelt_idle_copy;
 	u64			clock_idle_copy;
 #endif
=20
-	atomic_t		nr_iowait;
-
 	u64 last_seen_need_resched_ns;
 	int ticks_without_resched;
=20
@@ -1206,8 +1225,6 @@ struct rq {
 	struct root_domain		*rd;
 	struct sched_domain __rcu	*sd;
=20
-	unsigned long		cpu_capacity;
-
 	struct balance_callback *balance_callback;
=20
 	unsigned char		nohz_idle_balance;
@@ -1317,7 +1334,9 @@ struct rq {
 	call_single_data_t	cfsb_csd;
 	struct list_head	cfsb_csd_list;
 #endif
-};
+
+	atomic_t		nr_iowait;
+} __no_randomize_layout;
=20
 #ifdef CONFIG_FAIR_GROUP_SCHED
=20

