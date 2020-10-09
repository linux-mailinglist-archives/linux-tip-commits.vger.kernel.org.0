Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0738288F87
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 19:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390095AbgJIRCn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 13:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389892AbgJIRBZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 13:01:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176B6C0613D2;
        Fri,  9 Oct 2020 10:01:25 -0700 (PDT)
Date:   Fri, 09 Oct 2020 17:01:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602262883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=V0/UTzULg5aCxSRyWc/XUuQRUiyZrQKuQ2d9ThHHL3U=;
        b=XQ7ALwpO8R14PRKL31b1tpt2dRnSrbBdcewHVO84fZlvYrApea0a3p0KwENW54KKwRcIos
        R9dU7KezEZAP1+7N414ITOO9DkTviVJIjdYpMVeLVawwLQCyFLQvw8NoYCrkOjUOXilqF2
        aNCMWQiGYg4Sh7WvH4KeFZNgEuAeWDFoSgKi7f0ODX9At5TC7eVA0hTtPOX03gHe2n0m4k
        5TwwADYZ9nIiVvFFxp+s2EjPy8G59mvSST6U3/3+VwRyE+QBKWN7eYQ2MzKKnxiaZ26WMT
        h1TVVwNh/rrszfN993qHPgSfyiGtwD3VHBOwOuuQOcnLGrw+0v2lJIeJCQrP0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602262883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=V0/UTzULg5aCxSRyWc/XUuQRUiyZrQKuQ2d9ThHHL3U=;
        b=PcjrnffPWzaWSvZjZ6k0KdDkJg9LxeQPO7e1BndoI48qrUjw0myz+znyujjjlHyKDxCS9+
        2deuwnVLJLyIMRCQ==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: Allocate a page when caller is preemptible
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160226288230.7002.9877987550062680834.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     16a6320addfc4692a79aa452eefd40460fff4959
Gitweb:        https://git.kernel.org/tip/16a6320addfc4692a79aa452eefd40460fff4959
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Tue, 22 Sep 2020 21:06:22 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 01 Oct 2020 09:05:17 -07:00

rcu/tree: Allocate a page when caller is preemptible

The current memory-allocation interface poses the following challenges:

a)	In kernels built with CONFIG_PROVE_RAW_LOCK_NESTING, lockdep
	complains ("BUG: Invalid wait context").  This complaint is due
	to the memory allocator acquiring non-raw spinlocks while a raw
	spinlocks is held.  This problem can also arise if kvfree_rcu()
	is invoked while holding a raw spinlock.

b)	In -rt kernels built with CONFIG_PREEMPT_RT, the situation
	described in (a) above results in an attempt to acquire a
	sleeplock while holding a spinlock, which is of course forbidden.
	This can lead to "BUG: scheduling while atomic".

c)	Please note that call_rcu() is invoked from raw atomic context,
	so that kfree_rcu() and kvfree_rcu() are therefore also expected
	to be callable from atomic raw context as well.

However given that CONFIG_PREEMPT_COUNT is unconditionally enabled
by the earlier commits in this series, the preemptible() macro now
properly detects preempt-disable code regions even in kernels built
with CONFIG_PREEMPT_NONE.

This commit therefore uses preemptible() to determine whether allocation
is possible at all for double-argument kvfree_rcu().  If !preemptible(),
then allocation is not possible, and kvfree_rcu() falls back to using
the less cache-friendly rcu_head approach.  Even when preemptible(),
the caller might be involved in reclaim, so the GFP_ flags used by
double-argument kvfree_rcu() must avoid invoking reclaim processing.

Note that single-argument kvfree_rcu() must be invoked in sleepable
contexts, and that its fallback is the relatively high latency
synchronize_rcu().  Single-argument kvfree_rcu() therefore uses
GFP_KERNEL|__GFP_RETRY_MAYFAIL to allow limited sleeping within the
memory allocator.

Link: https://lore.kernel.org/lkml/20200630164543.4mdcf6zb4zfclhln@linutronix.de/
Fixes: 3042f83f19be ("rcu: Support reclaim for head-less object")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[ paulmck: Add add_ptr_to_bulk_krc_lock header comment per Michal Hocko. ]
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 78 ++++++++++++++++------------------------------
 1 file changed, 28 insertions(+), 50 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8ce77d9..39ac930 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3166,7 +3166,7 @@ static void kfree_rcu_work(struct work_struct *work)
 			krc_this_cpu_unlock(krcp, flags);
 
 			if (bkvhead[i])
-				free_page((unsigned long) bkvhead[i]);
+				kfree(bkvhead[i]);
 
 			cond_resched_tasks_rcu_qs();
 		}
@@ -3290,44 +3290,37 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
+// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
+// state specified by flags.  If can_sleep is true, the caller must
+// be schedulable and not be holding any locks or mutexes that might be
+// acquired by the memory allocator or anything that it might invoke.
+// If !can_sleep, then if !preemptible() no allocation will be undertaken,
+// otherwise the allocation will use GFP_ATOMIC to avoid the remainder of
+// the aforementioned deadlock possibilities.  Returns true iff ptr was
+// successfully recorded, else the caller must use a fallback.
 static inline bool
-kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
+add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
+	unsigned long *flags, void *ptr, bool can_sleep)
 {
 	struct kvfree_rcu_bulk_data *bnode;
+	bool can_alloc_page = preemptible();
+	gfp_t gfp = (can_sleep ? GFP_KERNEL | __GFP_RETRY_MAYFAIL : GFP_ATOMIC) | __GFP_NOWARN;
 	int idx;
 
-	if (unlikely(!krcp->initialized))
+	*krcp = krc_this_cpu_lock(flags);
+	if (unlikely(!(*krcp)->initialized))
 		return false;
 
-	lockdep_assert_held(&krcp->lock);
 	idx = !!is_vmalloc_addr(ptr);
 
 	/* Check if a new block is required. */
-	if (!krcp->bkvhead[idx] ||
-			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
-		bnode = get_cached_bnode(krcp);
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
+	if (!(*krcp)->bkvhead[idx] ||
+			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
+		bnode = get_cached_bnode(*krcp);
+		if (!bnode && can_alloc_page) {
+			krc_this_cpu_unlock(*krcp, *flags);
+			bnode = kmalloc(PAGE_SIZE, gfp);
+			*krcp = krc_this_cpu_lock(flags);
 		}
 
 		/* Switch to emergency path. */
@@ -3336,15 +3329,15 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 
 		/* Initialize the new block. */
 		bnode->nr_records = 0;
-		bnode->next = krcp->bkvhead[idx];
+		bnode->next = (*krcp)->bkvhead[idx];
 
 		/* Attach it to the head. */
-		krcp->bkvhead[idx] = bnode;
+		(*krcp)->bkvhead[idx] = bnode;
 	}
 
 	/* Finally insert. */
-	krcp->bkvhead[idx]->records
-		[krcp->bkvhead[idx]->nr_records++] = ptr;
+	(*krcp)->bkvhead[idx]->records
+		[(*krcp)->bkvhead[idx]->nr_records++] = ptr;
 
 	return true;
 }
@@ -3382,24 +3375,20 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		ptr = (unsigned long *) func;
 	}
 
-	krcp = krc_this_cpu_lock(&flags);
-
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
 
-		// Mark as success and leave.
-		success = true;
-		goto unlock_return;
+		return;
 	}
 
 	/*
 	 * Under high memory pressure GFP_NOWAIT can fail,
 	 * in that case the emergency path is maintained.
 	 */
-	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
+	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
 	if (!success) {
 		if (head == NULL)
 			// Inline if kvfree_rcu(one_arg) call.
@@ -4394,23 +4383,12 @@ static void __init kfree_rcu_batch_init(void)
 
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
 		krcp->initialized = true;
 	}
