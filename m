Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF983B8391
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhF3NuH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbhF3Nt6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:49:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A54CC0613A3;
        Wed, 30 Jun 2021 06:47:29 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZHeoUZhbZabmrTUUbMclAsfWoD6nsZRwbPSj9wRJmtc=;
        b=do1Q3pqQO3YamNFCjtGh6ES3d9jdYcWWW0uZ6zCbt+UJD43ZNOrCO/SiIjaVgiJlkYANeZ
        Lnx25SoNmqZm6IEkBfA4GsN+xKD6wOyKdzmR2XDmLz9XsyH+SWX00hAThIMn6TgOB1lRc4
        5y1X61En3QhWOaWrCH3OmH07t0w6s0Mk0MIbIL2tlWWuFcknqOr1pvCvljO3ZCYzECTmlJ
        H4LJA1V2CkDON2+j0+9wNC7Hgf6T0glVJ3SHjpgkiLKULxXfrNqnD+PAAGzAEnGHKcjUvX
        xDkWQ01p/iQbLXhg1v/sqRg777gmA7Lf3KR8w7tyFmusTt825V8N4uk6B6Z5JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZHeoUZhbZabmrTUUbMclAsfWoD6nsZRwbPSj9wRJmtc=;
        b=VV6sCY+sfWFps6N3c4LiXk/tBGd1rizWWHm0+EzsV+vMG28Zaf8/toryaCxA47MNoFCSYI
        ZFiJ375ZzVusFJCw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Fix various typos in comments
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506084688.395.16277413984460958821.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a616aec9aa140ef1ca61b06cec467391cbef11d7
Gitweb:        https://git.kernel.org/tip/a616aec9aa140ef1ca61b06cec467391cbef11d7
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 22 Mar 2021 22:29:10 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 12 May 2021 12:11:05 -07:00

rcu: Fix various typos in comments

Fix ~12 single-word typos in RCU code comments.

[ paulmck: Apply feedback from Randy Dunlap. ]
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c                                           | 4 ++--
 kernel/rcu/sync.c                                               | 4 ++--
 kernel/rcu/tasks.h                                              | 8 +++----
 kernel/rcu/tree.c                                               | 6 ++---
 kernel/rcu/tree.h                                               | 2 +-
 kernel/rcu/tree_plugin.h                                        | 2 +-
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h | 2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index e26547b..036ff54 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -777,9 +777,9 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
 	spin_unlock_irqrestore_rcu_node(sdp, flags);
 
 	/*
-	 * No local callbacks, so probabalistically probe global state.
+	 * No local callbacks, so probabilistically probe global state.
 	 * Exact information would require acquiring locks, which would
-	 * kill scalability, hence the probabalistic nature of the probe.
+	 * kill scalability, hence the probabilistic nature of the probe.
 	 */
 
 	/* First, see if enough time has passed since the last GP. */
diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index d4558ab..33d896d 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -94,9 +94,9 @@ static void rcu_sync_func(struct rcu_head *rhp)
 		rcu_sync_call(rsp);
 	} else {
 		/*
-		 * We're at least a GP after the last rcu_sync_exit(); eveybody
+		 * We're at least a GP after the last rcu_sync_exit(); everybody
 		 * will now have observed the write side critical section.
-		 * Let 'em rip!.
+		 * Let 'em rip!
 		 */
 		WRITE_ONCE(rsp->gp_state, GP_IDLE);
 	}
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 350ebf5..da906b7 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -23,7 +23,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * struct rcu_tasks - Definition for a Tasks-RCU-like mechanism.
  * @cbs_head: Head of callback list.
  * @cbs_tail: Tail pointer for callback list.
- * @cbs_wq: Wait queue allowning new callback to get kthread's attention.
+ * @cbs_wq: Wait queue allowing new callback to get kthread's attention.
  * @cbs_lock: Lock protecting callback list.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
@@ -504,7 +504,7 @@ DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
  * or transition to usermode execution.  As such, there are no read-side
  * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
  * this primitive is intended to determine that all tasks have passed
- * through a safe state, not so much for data-strcuture synchronization.
+ * through a safe state, not so much for data-structure synchronization.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
@@ -637,7 +637,7 @@ DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude,
  * there are no read-side primitives analogous to rcu_read_lock() and
  * rcu_read_unlock() because this primitive is intended to determine
  * that all tasks have passed through a safe state, not so much for
- * data-strcuture synchronization.
+ * data-structure synchronization.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
@@ -1163,7 +1163,7 @@ static void exit_tasks_rcu_finish_trace(struct task_struct *t)
  * there are no read-side primitives analogous to rcu_read_lock() and
  * rcu_read_unlock() because this primitive is intended to determine
  * that all tasks have passed through a safe state, not so much for
- * data-strcuture synchronization.
+ * data-structure synchronization.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5f1545a..ed1b546 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2489,7 +2489,7 @@ int rcutree_dead_cpu(unsigned int cpu)
 
 /*
  * Invoke any RCU callbacks that have made it to the end of their grace
- * period.  Thottle as specified by rdp->blimit.
+ * period.  Throttle as specified by rdp->blimit.
  */
 static void rcu_do_batch(struct rcu_data *rdp)
 {
@@ -3848,7 +3848,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
  *
  * If a full RCU grace period has elapsed since the earlier call from
  * which oldstate was obtained, return @true, otherwise return @false.
- * If @false is returned, it is the caller's responsibilty to invoke this
+ * If @false is returned, it is the caller's responsibility to invoke this
  * function later on until it does return @true.  Alternatively, the caller
  * can explicitly wait for a grace period, for example, by passing @oldstate
  * to cond_synchronize_rcu() or by directly invoking synchronize_rcu().
@@ -4094,7 +4094,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier);
 /*
  * Propagate ->qsinitmask bits up the rcu_node tree to account for the
  * first CPU in a given leaf rcu_node structure coming online.  The caller
- * must hold the corresponding leaf rcu_node ->lock with interrrupts
+ * must hold the corresponding leaf rcu_node ->lock with interrupts
  * disabled.
  */
 static void rcu_init_new_rnp(struct rcu_node *rnp_leaf)
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9a16487..c1ed047 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -153,7 +153,7 @@ struct rcu_data {
 	unsigned long	gp_seq;		/* Track rsp->gp_seq counter. */
 	unsigned long	gp_seq_needed;	/* Track furthest future GP request. */
 	union rcu_noqs	cpu_no_qs;	/* No QSes yet for this CPU. */
-	bool		core_needs_qs;	/* Core waits for quiesc state. */
+	bool		core_needs_qs;	/* Core waits for quiescent state. */
 	bool		beenonline;	/* CPU online at least once. */
 	bool		gpwrap;		/* Possible ->gp_seq wrap. */
 	bool		exp_deferred_qs; /* This CPU awaiting a deferred QS? */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index dfb048e..b0c3fb4 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2857,7 +2857,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 	waslocked = raw_spin_is_locked(&rdp->nocb_gp_lock);
 	wassleep = swait_active(&rdp->nocb_gp_wq);
 	if (!rdp->nocb_gp_sleep && !waslocked && !wassleep)
-		return;  /* Nothing untowards. */
+		return;  /* Nothing untoward. */
 
 	pr_info("   nocb GP activity on CB-only CPU!!! %c%c%c %c\n",
 		"lL"[waslocked],
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h
index cf6938d..1e24827 100644
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h
+++ b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h
@@ -174,7 +174,7 @@ static inline bool spin_trylock(spinlock_t *lock)
 }
 
 struct completion {
-	/* Hopefuly this won't overflow. */
+	/* Hopefully this won't overflow. */
 	unsigned int count;
 };
 
