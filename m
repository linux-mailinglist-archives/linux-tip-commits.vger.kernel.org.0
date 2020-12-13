Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD592D8FD6
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgLMTEH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbgLMTBm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E79FC061793;
        Sun, 13 Dec 2020 11:01:02 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:00:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=S9U9R92tuompJjtXxNdeXU3BlzUbm52kfN1/dndvUg8=;
        b=2FctbWob5tCa26o+rCzWYGvHQ0CRfPD/jNrA3hQmZt8LBnkzz1ak/ryp+u9XaHm+KDqQ1U
        isiEpttkCzy29052N4gt9Ytf2QWdFKEgZ3jy2TIcUiumgce/f08JHvq9Hqfm8smyIlTapq
        Ml+F2oFBf0rKp6WY/qVpLdVOWcbgmK4lz1a8dB5lq9y8zSLmNKWax3FkSntt8HSIToKQCZ
        MnnLoqlc6ziLkEfZy0WqleAnyqxIVi4IlSltzBnaPmmS3uEGe5Eq45fqULGEAc92bc8/r+
        OWNFSyyz/F9fjm11+O+MStHRdZUu7ORX9Fix5KC+JEgGtyNkKwWB8R2QbXu0UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=S9U9R92tuompJjtXxNdeXU3BlzUbm52kfN1/dndvUg8=;
        b=SbavKxpPd+fnLlLLQIK0deQcbFE+tWqkwWbA2cMIwHVDyG/RtYjAOgRod7VNhsQECQbngp
        IUTKUJSV0UKZ+gDw==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: Defer kvfree_rcu() allocation to a clean context
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788605910.3364.1339126535985500040.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     56292e8609e39537297a7468dda4d87b9bd81d6a
Gitweb:        https://git.kernel.org/tip/56292e8609e39537297a7468dda4d87b9bd81d6a
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Thu, 29 Oct 2020 17:50:04 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 19 Nov 2020 19:37:17 -08:00

rcu/tree: Defer kvfree_rcu() allocation to a clean context

The current memmory-allocation interface causes the following difficulties
for kvfree_rcu():

a) If built with CONFIG_PROVE_RAW_LOCK_NESTING, the lockdep will
   complain about violation of the nesting rules, as in "BUG: Invalid
   wait context".  This Kconfig option checks for proper raw_spinlock
   vs. spinlock nesting, in particular, it is not legal to acquire a
   spinlock_t while holding a raw_spinlock_t.

   This is a problem because kfree_rcu() uses raw_spinlock_t whereas the
   "page allocator" internally deals with spinlock_t to access to its
   zones. The code also can be broken from higher level of view:
   <snip>
       raw_spin_lock(&some_lock);
       kfree_rcu(some_pointer, some_field_offset);
   <snip>

b) If built with CONFIG_PREEMPT_RT, spinlock_t is converted into
   sleeplock.  This means that invoking the page allocator from atomic
   contexts results in "BUG: scheduling while atomic".

c) Please note that call_rcu() is already invoked from raw atomic context,
   so it is only reasonable to expaect that kfree_rcu() and kvfree_rcu()
   will also be called from atomic raw context.

This commit therefore defers page allocation to a clean context using the
combination of an hrtimer and a workqueue.  The hrtimer stage is required
in order to avoid deadlocks with the scheduler.  This deferred allocation
is required only when kvfree_rcu()'s per-CPU page cache is empty.

Link: https://lore.kernel.org/lkml/20200630164543.4mdcf6zb4zfclhln@linutronix.de/
Fixes: 3042f83f19be ("rcu: Support reclaim for head-less object")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 109 +++++++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 43 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0f278d6..01918d8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -177,7 +177,7 @@ module_param(rcu_unlock_delay, int, 0444);
  * per-CPU. Object size is equal to one page. This value
  * can be changed at boot time.
  */
-static int rcu_min_cached_objs = 2;
+static int rcu_min_cached_objs = 5;
 module_param(rcu_min_cached_objs, int, 0444);
 
 /* Retrieve RCU kthreads priority for rcutorture */
@@ -3089,6 +3089,9 @@ struct kfree_rcu_cpu_work {
  *	In order to save some per-cpu space the list is singular.
  *	Even though it is lockless an access has to be protected by the
  *	per-cpu lock.
+ * @page_cache_work: A work to refill the cache when it is empty
+ * @work_in_progress: Indicates that page_cache_work is running
+ * @hrtimer: A hrtimer for scheduling a page_cache_work
  * @nr_bkv_objs: number of allocated objects at @bkvcache.
  *
  * This is a per-CPU structure.  The reason that it is not included in
@@ -3105,6 +3108,11 @@ struct kfree_rcu_cpu {
 	bool monitor_todo;
 	bool initialized;
 	int count;
+
+	struct work_struct page_cache_work;
+	atomic_t work_in_progress;
+	struct hrtimer hrtimer;
+
 	struct llist_head bkvcache;
 	int nr_bkv_objs;
 };
@@ -3222,10 +3230,10 @@ static void kfree_rcu_work(struct work_struct *work)
 			}
 			rcu_lock_release(&rcu_callback_map);
 
-			krcp = krc_this_cpu_lock(&flags);
+			raw_spin_lock_irqsave(&krcp->lock, flags);
 			if (put_cached_bnode(krcp, bkvhead[i]))
 				bkvhead[i] = NULL;
-			krc_this_cpu_unlock(krcp, flags);
+			raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 			if (bkvhead[i])
 				free_page((unsigned long) bkvhead[i]);
@@ -3352,6 +3360,57 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
+static enum hrtimer_restart
+schedule_page_work_fn(struct hrtimer *t)
+{
+	struct kfree_rcu_cpu *krcp =
+		container_of(t, struct kfree_rcu_cpu, hrtimer);
+
+	queue_work(system_highpri_wq, &krcp->page_cache_work);
+	return HRTIMER_NORESTART;
+}
+
+static void fill_page_cache_func(struct work_struct *work)
+{
+	struct kvfree_rcu_bulk_data *bnode;
+	struct kfree_rcu_cpu *krcp =
+		container_of(work, struct kfree_rcu_cpu,
+			page_cache_work);
+	unsigned long flags;
+	bool pushed;
+	int i;
+
+	for (i = 0; i < rcu_min_cached_objs; i++) {
+		bnode = (struct kvfree_rcu_bulk_data *)
+			__get_free_page(GFP_KERNEL | __GFP_NOWARN);
+
+		if (bnode) {
+			raw_spin_lock_irqsave(&krcp->lock, flags);
+			pushed = put_cached_bnode(krcp, bnode);
+			raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+			if (!pushed) {
+				free_page((unsigned long) bnode);
+				break;
+			}
+		}
+	}
+
+	atomic_set(&krcp->work_in_progress, 0);
+}
+
+static void
+run_page_cache_worker(struct kfree_rcu_cpu *krcp)
+{
+	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
+			!atomic_xchg(&krcp->work_in_progress, 1)) {
+		hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
+			HRTIMER_MODE_REL);
+		krcp->hrtimer.function = schedule_page_work_fn;
+		hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
+	}
+}
+
 static inline bool
 kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 {
@@ -3368,32 +3427,8 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 	if (!krcp->bkvhead[idx] ||
 			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
 		bnode = get_cached_bnode(krcp);
-		if (!bnode) {
-			/*
-			 * To keep this path working on raw non-preemptible
-			 * sections, prevent the optional entry into the
-			 * allocator as it uses sleeping locks. In fact, even
-			 * if the caller of kfree_rcu() is preemptible, this
-			 * path still is not, as krcp->lock is a raw spinlock.
-			 * With additional page pre-allocation in the works,
-			 * hitting this return is going to be much less likely.
-			 */
-			if (IS_ENABLED(CONFIG_PREEMPT_RT))
-				return false;
-
-			/*
-			 * NOTE: For one argument of kvfree_rcu() we can
-			 * drop the lock and get the page in sleepable
-			 * context. That would allow to maintain an array
-			 * for the CONFIG_PREEMPT_RT as well if no cached
-			 * pages are available.
-			 */
-			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
-		}
-
 		/* Switch to emergency path. */
-		if (unlikely(!bnode))
+		if (!bnode)
 			return false;
 
 		/* Initialize the new block. */
@@ -3457,12 +3492,10 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		goto unlock_return;
 	}
 
-	/*
-	 * Under high memory pressure GFP_NOWAIT can fail,
-	 * in that case the emergency path is maintained.
-	 */
 	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
 	if (!success) {
+		run_page_cache_worker(krcp);
+
 		if (head == NULL)
 			// Inline if kvfree_rcu(one_arg) call.
 			goto unlock_return;
@@ -4482,24 +4515,14 @@ static void __init kfree_rcu_batch_init(void)
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
-		struct kvfree_rcu_bulk_data *bnode;
 
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
 		}
 
-		for (i = 0; i < rcu_min_cached_objs; i++) {
-			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
-
-			if (bnode)
-				put_cached_bnode(krcp, bnode);
-			else
-				pr_err("Failed to preallocate for %d CPU!\n", cpu);
-		}
-
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
+		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
 	if (register_shrinker(&kfree_rcu_shrinker))
