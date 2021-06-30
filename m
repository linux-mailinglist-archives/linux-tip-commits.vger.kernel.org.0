Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5933B83E3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhF3NvI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:51:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32992 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbhF3Nu3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:29 -0400
Date:   Wed, 30 Jun 2021 13:47:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=V3gAERCWoulqFR5mc8p2/PBHD736hDxopG4qX7ip2+c=;
        b=yudzKC+CyGWXBxrjOTjKQQoti/CeMk5kw9PeOfu67VseQWrBOO0y1aLOoL50Pg2kByif32
        CsOQCXJJAjdFFwkDWTGsyHYOlG56oFIi1JmLjqwiD9gPZTrjQqD3qCSYL84loNBp5fYyEX
        XbGUdY5oKXYjEMKA6aMxeEdMrJzbJVn/QraYQmVMWGOE/tY9ZZ39DQq9YNC8wSp9yw7kB/
        WV1R5ALPCqwvJxrETcuORofdtxlgXMHBy12LGVozqAgrMsIgrr+1DTEtOZhBn+kkYL5UtO
        xJGgIS+lhdE6LOdCSanDvlQShRdpaDWt6WOSBWTNCXhsvm5wrAn2reT4oV9d5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=V3gAERCWoulqFR5mc8p2/PBHD736hDxopG4qX7ip2+c=;
        b=uQQ0qc0pYD0EgcSWBlT1erkXahbTUYvSvc8gknGYBQ0kWJ0WqqefvHrIEjPpgE/kElr8Bm
        TCXLKqMOHdBJiICA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Fix broken node geometry after early ssp init
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506087230.395.6769005365821860016.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b5befe842e6612cf894cf4a199924ee872d8b7d8
Gitweb:        https://git.kernel.org/tip/b5befe842e6612cf894cf4a199924ee872d8b7d8
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sat, 17 Apr 2021 15:16:49 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:03:35 -07:00

srcu: Fix broken node geometry after early ssp init

An srcu_struct structure that is initialized before rcu_init_geometry()
will have its srcu_node hierarchy based on CONFIG_NR_CPUS.  Once
rcu_init_geometry() is called, this hierarchy is compressed as needed
for the actual maximum number of CPUs for this system.

Later on, that srcu_struct structure is confused, sometimes referring
to its initial CONFIG_NR_CPUS-based hierarchy, and sometimes instead
to the new num_possible_cpus() hierarchy.  For example, each of its
->mynode fields continues to reference the original leaf rcu_node
structures, some of which might no longer exist.  On the other hand,
srcu_for_each_node_breadth_first() traverses to the new node hierarchy.

There are at least two bad possible outcomes to this:

1) a) A callback enqueued early on an srcu_data structure (call it
      *sdp) is recorded pending on sdp->mynode->srcu_data_have_cbs in
      srcu_funnel_gp_start() with sdp->mynode pointing to a deep leaf
      (say 3 levels).

   b) The grace period ends after rcu_init_geometry() shrinks the
      nodes level to a single one.  srcu_gp_end() walks through the new
      srcu_node hierarchy without ever reaching the old leaves so the
      callback is never executed.

   This is easily reproduced on an 8 CPUs machine with CONFIG_NR_CPUS >= 32
   and "rcupdate.rcu_self_test=1". The srcu_barrier() after early tests
   verification never completes and the boot hangs:

	[ 5413.141029] INFO: task swapper/0:1 blocked for more than 4915 seconds.
	[ 5413.147564]       Not tainted 5.12.0-rc4+ #28
	[ 5413.151927] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
	[ 5413.159753] task:swapper/0       state:D stack:    0 pid:    1 ppid:     0 flags:0x00004000
	[ 5413.168099] Call Trace:
	[ 5413.170555]  __schedule+0x36c/0x930
	[ 5413.174057]  ? wait_for_completion+0x88/0x110
	[ 5413.178423]  schedule+0x46/0xf0
	[ 5413.181575]  schedule_timeout+0x284/0x380
	[ 5413.185591]  ? wait_for_completion+0x88/0x110
	[ 5413.189957]  ? mark_held_locks+0x61/0x80
	[ 5413.193882]  ? mark_held_locks+0x61/0x80
	[ 5413.197809]  ? _raw_spin_unlock_irq+0x24/0x50
	[ 5413.202173]  ? wait_for_completion+0x88/0x110
	[ 5413.206535]  wait_for_completion+0xb4/0x110
	[ 5413.210724]  ? srcu_torture_stats_print+0x110/0x110
	[ 5413.215610]  srcu_barrier+0x187/0x200
	[ 5413.219277]  ? rcu_tasks_verify_self_tests+0x50/0x50
	[ 5413.224244]  ? rdinit_setup+0x2b/0x2b
	[ 5413.227907]  rcu_verify_early_boot_tests+0x2d/0x40
	[ 5413.232700]  do_one_initcall+0x63/0x310
	[ 5413.236541]  ? rdinit_setup+0x2b/0x2b
	[ 5413.240207]  ? rcu_read_lock_sched_held+0x52/0x80
	[ 5413.244912]  kernel_init_freeable+0x253/0x28f
	[ 5413.249273]  ? rest_init+0x250/0x250
	[ 5413.252846]  kernel_init+0xa/0x110
	[ 5413.256257]  ret_from_fork+0x22/0x30

2) An srcu_struct structure that is initialized before rcu_init_geometry()
   and used afterward will always have stale rdp->mynode references,
   resulting in callbacks to be missed in srcu_gp_end(), just like in
   the previous scenario.

This commit therefore causes init_srcu_struct_nodes to initialize the
geometry, if needed.  This ensures that the srcu_node hierarchy is
properly built and distributed from the get-go.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h      |  2 ++
 kernel/rcu/srcutree.c |  3 +++
 kernel/rcu/tree.c     | 16 +++++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index ca3f2af..28de768 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -308,6 +308,8 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
 	}
 }
 
+extern void rcu_init_geometry(void);
+
 /* Returns a pointer to the first leaf rcu_node structure. */
 #define rcu_first_leaf_node() (rcu_state.level[rcu_num_lvls - 1])
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 9ec35c1..5fdbde6 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -90,6 +90,9 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp)
 	struct srcu_node *snp;
 	struct srcu_node *snp_first;
 
+	/* Initialize geometry if it has not already been initialized. */
+	rcu_init_geometry();
+
 	/* Work out the overall tree geometry. */
 	ssp->level[0] = &ssp->node[0];
 	for (i = 1; i < rcu_num_lvls; i++)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c35b152..0420b23 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4582,11 +4582,25 @@ static void __init rcu_init_one(void)
  * replace the definitions in tree.h because those are needed to size
  * the ->node array in the rcu_state structure.
  */
-static void __init rcu_init_geometry(void)
+void rcu_init_geometry(void)
 {
 	ulong d;
 	int i;
+	static unsigned long old_nr_cpu_ids;
 	int rcu_capacity[RCU_NUM_LVLS];
+	static bool initialized;
+
+	if (initialized) {
+		/*
+		 * Warn if setup_nr_cpu_ids() had not yet been invoked,
+		 * unless nr_cpus_ids == NR_CPUS, in which case who cares?
+		 */
+		WARN_ON_ONCE(old_nr_cpu_ids != nr_cpu_ids);
+		return;
+	}
+
+	old_nr_cpu_ids = nr_cpu_ids;
+	initialized = true;
 
 	/*
 	 * Initialize any unspecified boot parameters.
