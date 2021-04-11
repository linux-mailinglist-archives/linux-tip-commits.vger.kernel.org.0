Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569F535B515
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbhDKNpJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33034 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbhDKNoY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:24 -0400
Date:   Sun, 11 Apr 2021 13:43:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lrRzlnORWci0ZimAhgFyoL5a8nWVcle3jqADVOBMR3Y=;
        b=rIinKJ6X4bCo06YkJBPltMOXYidpASH7KcAKsVSCe2fTMFFOZIcEL/CWT4SJDgu/YpdwdW
        xcegM3kJ+YExt4podvGiEe6pYTvSrBTPyw/O8yVveHizEkaUaS4JJ2EJlfcbFVjvV5n4fm
        m4jXOjqfRtzx79htSPUmbYArzGh2bJdyCoWPJROja4DLjKV8JxAbTGs3ZjWp8GIiE6wwKj
        R2w9aSJlhIYC259ByMuRFoOZmGYFttcPLPoNGYbIlEuELtlzjI05OWSxMvOU7tZ5diOvFh
        Koh3M5bH9HYhggoxyeWYKzsh2nPO3ve3m4a9rwI8DHVceW5RkjNicxFN8QYsuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lrRzlnORWci0ZimAhgFyoL5a8nWVcle3jqADVOBMR3Y=;
        b=6N0GMAORQZEZfZNGmquuHYXEVo8BDbsPX2bCtl3Mmd5kWqhUfKOHUt9IxCGxey8nsAMJEH
        PmShmZ+st5vutYAA==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] kvfree_rcu: Directly allocate page for single-argument case
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862113.29796.15693621303462252752.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     148e3731d124079a036b3acf780f3d35c1b9c0aa
Gitweb:        https://git.kernel.org/tip/148e3731d124079a036b3acf780f3d35c1b9c0aa
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Wed, 20 Jan 2021 17:21:46 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:18:07 -08:00

kvfree_rcu: Directly allocate page for single-argument case

Single-argument kvfree_rcu() must be invoked from sleepable contexts,
so we can directly allocate pages.  Furthermmore, the fallback in case
of page-allocation failure is the high-latency synchronize_rcu(), so it
makes sense to do these page allocations from the fastpath, and even to
permit limited sleeping within the allocator.

This commit therefore allocates if needed on the fastpath using
GFP_KERNEL|__GFP_RETRY_MAYFAIL.  This also has the beneficial effect
of leaving kvfree_rcu()'s per-CPU caches to the double-argument variant
of kvfree_rcu(), given that the double-argument variant cannot directly
invoke the allocator.

[ paulmck: Add add_ptr_to_bulk_krc_lock header comment per Michal Hocko. ]
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da6f521..1f8c980 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3493,37 +3493,50 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 	}
 }
 
+// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
+// state specified by flags.  If can_alloc is true, the caller must
+// be schedulable and not be holding any locks or mutexes that might be
+// acquired by the memory allocator or anything that it might invoke.
+// Returns true if ptr was successfully recorded, else the caller must
+// use a fallback.
 static inline bool
-kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
+add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
+	unsigned long *flags, void *ptr, bool can_alloc)
 {
 	struct kvfree_rcu_bulk_data *bnode;
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
-		/* Switch to emergency path. */
+	if (!(*krcp)->bkvhead[idx] ||
+			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
+		bnode = get_cached_bnode(*krcp);
+		if (!bnode && can_alloc) {
+			krc_this_cpu_unlock(*krcp, *flags);
+			bnode = (struct kvfree_rcu_bulk_data *)
+				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
+			*krcp = krc_this_cpu_lock(flags);
+		}
+
 		if (!bnode)
 			return false;
 
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
@@ -3561,8 +3574,6 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		ptr = (unsigned long *) func;
 	}
 
-	krcp = krc_this_cpu_lock(&flags);
-
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
@@ -3570,12 +3581,11 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 			  __func__, head);
 
 		// Mark as success and leave.
-		success = true;
-		goto unlock_return;
+		return;
 	}
 
 	kasan_record_aux_stack(ptr);
-	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
+	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
 	if (!success) {
 		run_page_cache_worker(krcp);
 
