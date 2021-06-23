Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F693B15A4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jun 2021 10:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFWIVc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 04:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFWIV3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 04:21:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF91C06175F;
        Wed, 23 Jun 2021 01:19:12 -0700 (PDT)
Date:   Wed, 23 Jun 2021 08:19:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624436351;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N797cMyl9YosM2RnmL5SnfRRXVdPPyA1nuXn+8rIv1s=;
        b=X9zHk4PrFcGouIRANcvZjNozR93d8xO94/uXk8wWdzeOZwirJf1mADXGhZ6rQstVEq4BYe
        ETNMETQ4zsdHsI+rps9Vl4HfXbal4Mm3G1CKF5bqdTOtvge7H6tIqpiOU+1PFHBZejSSKv
        F1BEB+6nus3RJNUN45anifK1yXrb+nIJehGkeSpDf9xKOqB1zqTXfHJs6esoELOBiA89vw
        //RSPTDcP/cTFaw5I+oQrI1mLzbIdm9ZCKolqCW8VfvD0493fE782pPK7ZcXeUeoOzA3b9
        0/MNGWoArhxV6fTkR72OYPR8CYSO8K0EJRm68kyUfG93rkXAcsPCu/GX9ldP3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624436351;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N797cMyl9YosM2RnmL5SnfRRXVdPPyA1nuXn+8rIv1s=;
        b=DPw1LK8pxmfp4vnnEZ1yM64swwcGIrBgJW1hnFRqkUcXHOMFPrH+9lIw3QoF3SEuZTaKe2
        yODRVecQ7Veu+fDA==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Fix the dep path printing for
 backwards BFS
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210618170110.3699115-2-boqun.feng@gmail.com>
References: <20210618170110.3699115-2-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <162443635069.395.8024885317751883584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     69c7a5fb2482636f525f016c8333fdb9111ecb9d
Gitweb:        https://git.kernel.org/tip/69c7a5fb2482636f525f016c8333fdb9111ecb9d
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Sat, 19 Jun 2021 01:01:07 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 22 Jun 2021 16:42:06 +02:00

locking/lockdep: Fix the dep path printing for backwards BFS

We use the same code to print backwards lock dependency path as the
forwards lock dependency path, and this could result into incorrect
printing because for a backwards lock_list ->trace is not the call trace
where the lock of ->class is acquired.

Fix this by introducing a separate function on printing the backwards
dependency path. Also add a few comments about the printing while we are
at it.

Reported-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210618170110.3699115-2-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c | 108 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 48d736a..3b32cd9 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2304,7 +2304,56 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 }
 
 /*
- * printk the shortest lock dependencies from @start to @end in reverse order:
+ * Dependency path printing:
+ *
+ * After BFS we get a lock dependency path (linked via ->parent of lock_list),
+ * printing out each lock in the dependency path will help on understanding how
+ * the deadlock could happen. Here are some details about dependency path
+ * printing:
+ *
+ * 1)	A lock_list can be either forwards or backwards for a lock dependency,
+ * 	for a lock dependency A -> B, there are two lock_lists:
+ *
+ * 	a)	lock_list in the ->locks_after list of A, whose ->class is B and
+ * 		->links_to is A. In this case, we can say the lock_list is
+ * 		"A -> B" (forwards case).
+ *
+ * 	b)	lock_list in the ->locks_before list of B, whose ->class is A
+ * 		and ->links_to is B. In this case, we can say the lock_list is
+ * 		"B <- A" (bacwards case).
+ *
+ * 	The ->trace of both a) and b) point to the call trace where B was
+ * 	acquired with A held.
+ *
+ * 2)	A "helper" lock_list is introduced during BFS, this lock_list doesn't
+ * 	represent a certain lock dependency, it only provides an initial entry
+ * 	for BFS. For example, BFS may introduce a "helper" lock_list whose
+ * 	->class is A, as a result BFS will search all dependencies starting with
+ * 	A, e.g. A -> B or A -> C.
+ *
+ * 	The notation of a forwards helper lock_list is like "-> A", which means
+ * 	we should search the forwards dependencies starting with "A", e.g A -> B
+ * 	or A -> C.
+ *
+ * 	The notation of a bacwards helper lock_list is like "<- B", which means
+ * 	we should search the backwards dependencies ending with "B", e.g.
+ * 	B <- A or B <- C.
+ */
+
+/*
+ * printk the shortest lock dependencies from @root to @leaf in reverse order.
+ *
+ * We have a lock dependency path as follow:
+ *
+ *    @root                                                                 @leaf
+ *      |                                                                     |
+ *      V                                                                     V
+ *	          ->parent                                   ->parent
+ * | lock_list | <--------- | lock_list | ... | lock_list  | <--------- | lock_list |
+ * |    -> L1  |            | L1 -> L2  | ... |Ln-2 -> Ln-1|            | Ln-1 -> Ln|
+ *
+ * , so it's natural that we start from @leaf and print every ->class and
+ * ->trace until we reach the @root.
  */
 static void __used
 print_shortest_lock_dependencies(struct lock_list *leaf,
@@ -2332,6 +2381,61 @@ print_shortest_lock_dependencies(struct lock_list *leaf,
 	} while (entry && (depth >= 0));
 }
 
+/*
+ * printk the shortest lock dependencies from @leaf to @root.
+ *
+ * We have a lock dependency path (from a backwards search) as follow:
+ *
+ *    @leaf                                                                 @root
+ *      |                                                                     |
+ *      V                                                                     V
+ *	          ->parent                                   ->parent
+ * | lock_list | ---------> | lock_list | ... | lock_list  | ---------> | lock_list |
+ * | L2 <- L1  |            | L3 <- L2  | ... | Ln <- Ln-1 |            |    <- Ln  |
+ *
+ * , so when we iterate from @leaf to @root, we actually print the lock
+ * dependency path L1 -> L2 -> .. -> Ln in the non-reverse order.
+ *
+ * Another thing to notice here is that ->class of L2 <- L1 is L1, while the
+ * ->trace of L2 <- L1 is the call trace of L2, in fact we don't have the call
+ * trace of L1 in the dependency path, which is alright, because most of the
+ * time we can figure out where L1 is held from the call trace of L2.
+ */
+static void __used
+print_shortest_lock_dependencies_backwards(struct lock_list *leaf,
+					   struct lock_list *root)
+{
+	struct lock_list *entry = leaf;
+	const struct lock_trace *trace = NULL;
+	int depth;
+
+	/*compute depth from generated tree by BFS*/
+	depth = get_lock_depth(leaf);
+
+	do {
+		print_lock_class_header(entry->class, depth);
+		if (trace) {
+			printk("%*s ... acquired at:\n", depth, "");
+			print_lock_trace(trace, 2);
+			printk("\n");
+		}
+
+		/*
+		 * Record the pointer to the trace for the next lock_list
+		 * entry, see the comments for the function.
+		 */
+		trace = entry->trace;
+
+		if (depth == 0 && (entry != root)) {
+			printk("lockdep:%s bad path found in chain graph\n", __func__);
+			break;
+		}
+
+		entry = get_lock_parent(entry);
+		depth--;
+	} while (entry && (depth >= 0));
+}
+
 static void
 print_irq_lock_scenario(struct lock_list *safe_entry,
 			struct lock_list *unsafe_entry,
@@ -2449,7 +2553,7 @@ print_bad_irq_dependency(struct task_struct *curr,
 	prev_root->trace = save_trace();
 	if (!prev_root->trace)
 		return;
-	print_shortest_lock_dependencies(backwards_entry, prev_root);
+	print_shortest_lock_dependencies_backwards(backwards_entry, prev_root);
 
 	pr_warn("\nthe dependencies between the lock to be acquired");
 	pr_warn(" and %s-irq-unsafe lock:\n", irqclass);
