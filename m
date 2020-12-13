Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581782D8FD5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgLMTD6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:03:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46480 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgLMTBp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:45 -0500
Date:   Sun, 13 Dec 2020 19:01:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LFFRhYwRKePmX3B7oQ/gnKzrUi9yNYQipqp12rX2xgE=;
        b=rf6fFLvRr0+t889p6qMreepiCBoNm1vU25rOWlIE2mPVzp/B9fEsylMHpu5d3iinkWwv8Z
        E81dnu+JZuBEw9LonqEwRa6Wuf5UKijjBe8wGvfAX/mmTWf3u83c2OZ9+nq0UeHLMUnXvQ
        rFgcqvf4kONQxCYORJYgrHbKs54/hzg/QqWQDVUnsY/h8/9fv8d8ntmBFZrRbxTo1DLP81
        AitcLdGfo9gu+7WxRL+CyFxXpJqm11kv6KzB1DI4rtdhU9V/iFL+xye6B6Z2aktfH9oKa9
        esO/1eFAIcs9JLqfCiEfPojz6aXNcDR7GuRHZBh4EI7IaJfgVHpsp+7hBFUI5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LFFRhYwRKePmX3B7oQ/gnKzrUi9yNYQipqp12rX2xgE=;
        b=7nBh26svZJj96iKbVtiam5UHhru5GNCcJPwXhfzYBmWucxPbh5ijlGbR3meQDcTl53p5Ap
        jTSDtfkqHWx/n6Ag==
From:   "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Fix single-CPU check in rcu_blocking_is_gp()
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606214.3364.8772322600812299902.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ed73860cecc3ec12aa50a6dcfb4900e5b4ae9507
Gitweb:        https://git.kernel.org/tip/ed73860cecc3ec12aa50a6dcfb4900e5b4ae9507
Author:        Neeraj Upadhyay <neeraju@codeaurora.org>
AuthorDate:    Wed, 23 Sep 2020 12:59:33 +05:30
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 19 Nov 2020 19:37:16 -08:00

rcu: Fix single-CPU check in rcu_blocking_is_gp()

Currently, for CONFIG_PREEMPTION=n kernels, rcu_blocking_is_gp() uses
num_online_cpus() to determine whether there is only one CPU online.  When
there is only a single CPU online, the simple fact that synchronize_rcu()
could be legally called implies that a full grace period has elapsed.
Therefore, in the single-CPU case, synchronize_rcu() simply returns
immediately.  Unfortunately, num_online_cpus() is unreliable while a
CPU-hotplug operation is transitioning to or from single-CPU operation
because:

1.	num_online_cpus() uses atomic_read(&__num_online_cpus) to
	locklessly sample the number of online CPUs.  The hotplug locks
	are not held, which means that an incoming CPU can concurrently
	update this count.  This in turn means that an RCU read-side
	critical section on the incoming CPU might observe updates
	prior to the grace period, but also that this critical section
	might extend beyond the end of the optimized synchronize_rcu().
	This breaks RCU's fundamental guarantee.

2.	In addition, num_online_cpus() does no ordering, thus providing
	another way that RCU's fundamental guarantee can be broken by
	the current code.

3.	The most probable failure mode happens on outgoing CPUs.
	The outgoing CPU updates the count of online CPUs in the
	CPUHP_TEARDOWN_CPU stop-machine handler, which is fine in
	and of itself due to preemption being disabled at the call
	to num_online_cpus().  Unfortunately, after that stop-machine
	handler returns, the CPU takes one last trip through the
	scheduler (which has RCU readers) and, after the resulting
	context switch, one final dive into the idle loop.  During this
	time, RCU needs to keep track of two CPUs, but num_online_cpus()
	will say that there is only one, which in turn means that the
	surviving CPU will incorrectly ignore the outgoing CPU's RCU
	read-side critical sections.

This problem is illustrated by the following litmus test in which P0()
corresponds to synchronize_rcu() and P1() corresponds to the incoming CPU.
The herd7 tool confirms that the "exists" clause can be satisfied,
thus demonstrating that this breakage can happen according to the Linux
kernel memory model.

   {
     int x = 0;
     atomic_t numonline = ATOMIC_INIT(1);
   }

   P0(int *x, atomic_t *numonline)
   {
     int r0;
     WRITE_ONCE(*x, 1);
     r0 = atomic_read(numonline);
     if (r0 == 1) {
       smp_mb();
     } else {
       synchronize_rcu();
     }
     WRITE_ONCE(*x, 2);
   }

   P1(int *x, atomic_t *numonline)
   {
     int r0; int r1;

     atomic_inc(numonline);
     smp_mb();
     rcu_read_lock();
     r0 = READ_ONCE(*x);
     smp_rmb();
     r1 = READ_ONCE(*x);
     rcu_read_unlock();
   }

   locations [x;numonline;]

   exists (1:r0=0 /\ 1:r1=2)

It is important to note that these problems arise only when the system
is transitioning to or from single-CPU operation.

One solution would be to hold the CPU-hotplug locks while sampling
num_online_cpus(), which was in fact the intent of the (redundant)
preempt_disable() and preempt_enable() surrounding this call to
num_online_cpus().  Actually blocking CPU hotplug would not only result
in excessive overhead, but would also unnecessarily impede CPU-hotplug
operations.

This commit therefore follows long-standing RCU tradition by maintaining
a separate RCU-specific set of CPU-hotplug books.

This separate set of books is implemented by a new ->n_online_cpus field
in the rcu_state structure that maintains RCU's count of the online CPUs.
This count is incremented early in the CPU-online process, so that
the critical transition away from single-CPU operation will occur when
there is only a single CPU.  Similarly for the critical transition to
single-CPU operation, the counter is decremented late in the CPU-offline
process, again while there is only a single CPU.  Because there is only
ever a single CPU when the ->n_online_cpus field undergoes the critical
1->2 and 2->1 transitions, full memory ordering and mutual exclusion is
provided implicitly and, better yet, for free.

In the case where the CPU is coming online, nothing will happen until
the current CPU helps it come online.  Therefore, the new CPU will see
all accesses prior to the optimized grace period, which means that RCU
does not need to further delay this new CPU.  In the case where the CPU
is going offline, the outgoing CPU is totally out of the picture before
the optimized grace period starts, which means that this outgoing CPU
cannot see any of the accesses following that grace period.  Again,
RCU needs no further interaction with the outgoing CPU.

This does mean that synchronize_rcu() will unnecessarily do a few grace
periods the hard way just before the second CPU comes online and just
after the second-to-last CPU goes offline, but it is not worth optimizing
this uncommon case.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 19 +++++++++++++++++--
 kernel/rcu/tree.h |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0ccdca4..39e14cf 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2396,6 +2396,7 @@ int rcutree_dead_cpu(unsigned int cpu)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
 
+	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
 	/* Adjust any no-longer-needed kthreads. */
 	rcu_boost_kthread_setaffinity(rnp, -1);
 	/* Do any needed no-CB deferred wakeups from this CPU. */
@@ -3577,7 +3578,20 @@ static int rcu_blocking_is_gp(void)
 		return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
 	might_sleep();  /* Check for RCU read-side critical section. */
 	preempt_disable();
-	ret = num_online_cpus() <= 1;
+	/*
+	 * If the rcu_state.n_online_cpus counter is equal to one,
+	 * there is only one CPU, and that CPU sees all prior accesses
+	 * made by any CPU that was online at the time of its access.
+	 * Furthermore, if this counter is equal to one, its value cannot
+	 * change until after the preempt_enable() below.
+	 *
+	 * Furthermore, if rcu_state.n_online_cpus is equal to one here,
+	 * all later CPUs (both this one and any that come online later
+	 * on) are guaranteed to see all accesses prior to this point
+	 * in the code, without the need for additional memory barriers.
+	 * Those memory barriers are provided by CPU-hotplug code.
+	 */
+	ret = READ_ONCE(rcu_state.n_online_cpus) <= 1;
 	preempt_enable();
 	return ret;
 }
@@ -3622,7 +3636,7 @@ void synchronize_rcu(void)
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_rcu() in RCU read-side critical section");
 	if (rcu_blocking_is_gp())
-		return;
+		return;  // Context allows vacuous grace periods.
 	if (rcu_gp_is_expedited())
 		synchronize_rcu_expedited();
 	else
@@ -3962,6 +3976,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	rcu_prepare_kthreads(cpu);
 	rcu_spawn_cpu_nocb_kthread(cpu);
+	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus + 1);
 
 	return 0;
 }
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e4f66b8..805c9eb 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -298,6 +298,7 @@ struct rcu_state {
 						/* Hierarchy levels (+1 to */
 						/*  shut bogus gcc warning) */
 	int ncpus;				/* # CPUs seen so far. */
+	int n_online_cpus;			/* # CPUs online for RCU. */
 
 	/* The following fields are guarded by the root rcu_node's lock. */
 
