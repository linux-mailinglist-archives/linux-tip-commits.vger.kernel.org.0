Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA52F5FEE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbhANL3m (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbhANL3l (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:29:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DE2C061573;
        Thu, 14 Jan 2021 03:29:01 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:28:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7ElghXqbyYlGzc5QV9v8h53ovqw4qehqVJMEruNxno4=;
        b=jl5UYtSGBraw/uZ5HiP8Vn7rSo5+aWcRnt7MqV4GqbYSUkZjlG0r5iUYtHsh8BzSK9QnAy
        4Cnmsy4qg/1orm1hq3ABt2xNMd8GP0bFmJOHrYgeqDCXH4KrNBPBbJxkxvYTrc7UqKg2UA
        cZdD5pWodww5T6xkJQeKf6MdfSx6YvOm/U+ACcOphwnIe8iTUiOX5YnFsmc/RPCaSuP9wU
        dG47qn/ThkmtJw1qI812xx3Rw7JyBvdFxULf2iSwl05ICpetr8py3Ff5fYqXLegNHWPWFS
        Vj2p4CbN5bXBr7kp8FHy172wLoRn2jd/W+33vptpVCHBCoeOxj5VJxHBuZbsOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7ElghXqbyYlGzc5QV9v8h53ovqw4qehqVJMEruNxno4=;
        b=UNUVvJBZqASoPORZVXqL7PyCiL+yD2LTpJk7uB62VMzrDz2gbU3OxYut6aSlYrVUKo0MqW
        wapxttahjJNb6YDA==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Exclude local_lock_t from IRQ inversions
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161062373899.414.8013987347101564172.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5f2962401c6e195222f320d12b3a55377b2d4653
Gitweb:        https://git.kernel.org/tip/5f2962401c6e195222f320d12b3a55377b2d4653
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Thu, 10 Dec 2020 11:15:00 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:17 +01:00

locking/lockdep: Exclude local_lock_t from IRQ inversions

The purpose of local_lock_t is to abstract: preempt_disable() /
local_bh_disable() / local_irq_disable(). These are the traditional
means of gaining access to per-cpu data, but are fundamentally
non-preemptible.

local_lock_t provides a per-cpu lock, that on !PREEMPT_RT reduces to
no-ops, just like regular spinlocks do on UP.

This gives rise to:

	CPU0			CPU1

	local_lock(B)		spin_lock_irq(A)
	<IRQ>
	  spin_lock(A)		local_lock(B)

Where lockdep then figures things will lock up; which would be true if
B were any other kind of lock. However this is a false positive, no
such deadlock actually exists.

For !RT the above local_lock(B) is preempt_disable(), and there's
obviously no deadlock; alternatively, CPU0's B != CPU1's B.

For RT the argument is that since local_lock() nests inside
spin_lock(), it cannot be used in hardirq context, and therefore CPU0
cannot in fact happen. Even though B is a real lock, it is a
preemptible lock and any threaded-irq would simply schedule out and
let the preempted task (which holds B) continue such that the task on
CPU1 can make progress, after which the threaded-irq resumes and can
finish.

This means that we can never form an IRQ inversion on a local_lock
dependency, so terminate the graph walk when looking for IRQ
inversions when we encounter one.

One consequence is that (for LOCKDEP_SMALL) when we look for redundant
dependencies, A -> B is not redundant in the presence of A -> L -> B.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
[peterz: Changelog]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c | 57 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index f2ae8a6..ad9afd8 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2200,6 +2200,44 @@ static inline bool usage_match(struct lock_list *entry, void *mask)
 		return !!((entry->class->usage_mask & LOCKF_IRQ) & *(unsigned long *)mask);
 }
 
+static inline bool usage_skip(struct lock_list *entry, void *mask)
+{
+	/*
+	 * Skip local_lock() for irq inversion detection.
+	 *
+	 * For !RT, local_lock() is not a real lock, so it won't carry any
+	 * dependency.
+	 *
+	 * For RT, an irq inversion happens when we have lock A and B, and on
+	 * some CPU we can have:
+	 *
+	 *	lock(A);
+	 *	<interrupted>
+	 *	  lock(B);
+	 *
+	 * where lock(B) cannot sleep, and we have a dependency B -> ... -> A.
+	 *
+	 * Now we prove local_lock() cannot exist in that dependency. First we
+	 * have the observation for any lock chain L1 -> ... -> Ln, for any
+	 * 1 <= i <= n, Li.inner_wait_type <= L1.inner_wait_type, otherwise
+	 * wait context check will complain. And since B is not a sleep lock,
+	 * therefore B.inner_wait_type >= 2, and since the inner_wait_type of
+	 * local_lock() is 3, which is greater than 2, therefore there is no
+	 * way the local_lock() exists in the dependency B -> ... -> A.
+	 *
+	 * As a result, we will skip local_lock(), when we search for irq
+	 * inversion bugs.
+	 */
+	if (entry->class->lock_type == LD_LOCK_PERCPU) {
+		if (DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
+			return false;
+
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * Find a node in the forwards-direction dependency sub-graph starting
  * at @root->class that matches @bit.
@@ -2215,7 +2253,7 @@ find_usage_forwards(struct lock_list *root, unsigned long usage_mask,
 
 	debug_atomic_inc(nr_find_usage_forwards_checks);
 
-	result = __bfs_forwards(root, &usage_mask, usage_match, NULL, target_entry);
+	result = __bfs_forwards(root, &usage_mask, usage_match, usage_skip, target_entry);
 
 	return result;
 }
@@ -2232,7 +2270,7 @@ find_usage_backwards(struct lock_list *root, unsigned long usage_mask,
 
 	debug_atomic_inc(nr_find_usage_backwards_checks);
 
-	result = __bfs_backwards(root, &usage_mask, usage_match, NULL, target_entry);
+	result = __bfs_backwards(root, &usage_mask, usage_match, usage_skip, target_entry);
 
 	return result;
 }
@@ -2597,7 +2635,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	 */
 	bfs_init_rootb(&this, prev);
 
-	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, NULL, NULL);
+	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, usage_skip, NULL);
 	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;
@@ -2664,6 +2702,12 @@ static inline int check_irq_usage(struct task_struct *curr,
 {
 	return 1;
 }
+
+static inline bool usage_skip(struct lock_list *entry, void *mask)
+{
+	return false;
+}
+
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
 #ifdef CONFIG_LOCKDEP_SMALL
@@ -2697,7 +2741,12 @@ check_redundant(struct held_lock *src, struct held_lock *target)
 
 	debug_atomic_inc(nr_redundant_checks);
 
-	ret = check_path(target, &src_entry, hlock_equal, NULL, &target_entry);
+	/*
+	 * Note: we skip local_lock() for redundant check, because as the
+	 * comment in usage_skip(), A -> local_lock() -> B and A -> B are not
+	 * the same.
+	 */
+	ret = check_path(target, &src_entry, hlock_equal, usage_skip, &target_entry);
 
 	if (ret == BFS_RMATCH)
 		debug_atomic_inc(nr_redundant);
