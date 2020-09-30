Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FF427E440
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 10:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgI3IzG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 04:55:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54878 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3IzG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 04:55:06 -0400
Date:   Wed, 30 Sep 2020 08:55:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601456103;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6N0iaelY4ikmLve5Or3fzn/VZ/Vl1cVoe+8BBCXOFTM=;
        b=h7hTG9RrmTfegh+K4gCmEoF5eEHWbSXTw6kdx9Pzx6T0bmzut3PXQbCeHFjyQVUvYgeXiS
        dytOU2gnqwcUHge4X9fq2wtn9VxvLX+Acz5vVJ7V01C3U0KdKiFq7Ar7Noek6dg7qjVUnu
        QgCP1Qn85JTFRO/FHA69TgIPCCTlf8Yg6Om+fpKIqG2TNfBz9pMohhGv6LY/6vOLLfFWIp
        5csO/eXTSjbF8qtHEexa+So/+/VqKkCG56GX2RemAP67sT/nFhWonSYFWRJIzeTHt0hgyM
        5Pyb0lkSrC1Y1AQmvt4jSPRSR3o8AOS8U737MUk08auxgJGbIbK11uUCaGlH4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601456103;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6N0iaelY4ikmLve5Or3fzn/VZ/Vl1cVoe+8BBCXOFTM=;
        b=nVuiATD3IJo5CJJLYrF8UfkLuiNFXJtwzjJKmBZcuDWqaPrrt7h4kduSdDmrKiS6oBnPDb
        yCWI1I8ktootd7CA==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Optimize the memory usage of circular queue
Cc:     Qian Cai <cai@redhat.com>,
        syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com,
        Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200917080210.108095-1-boqun.feng@gmail.com>
References: <20200917080210.108095-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <160145610239.7002.7023986646655063041.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6d1823ccc480866e571ab1206665d693aeb600cf
Gitweb:        https://git.kernel.org/tip/6d1823ccc480866e571ab1206665d693aeb600cf
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Thu, 17 Sep 2020 16:01:50 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 29 Sep 2020 09:56:59 +02:00

lockdep: Optimize the memory usage of circular queue

Qian Cai reported a BFS_EQUEUEFULL warning [1] after read recursive
deadlock detection merged into tip tree recently. Unlike the previous
lockep graph searching, which iterate every lock class (every node in
the graph) exactly once, the graph searching for read recurisve deadlock
detection needs to iterate every lock dependency (every edge in the
graph) once, as a result, the maximum memory cost of the circular queue
changes from O(V), where V is the number of lock classes (nodes or
vertices) in the graph, to O(E), where E is the number of lock
dependencies (edges), because every lock class or dependency gets
enqueued once in the BFS. Therefore we hit the BFS_EQUEUEFULL case.

However, actually we don't need to enqueue all dependencies for the BFS,
because every time we enqueue a dependency, we almostly enqueue all
other dependencies in the same dependency list ("almostly" is because
we currently check before enqueue, so if a dependency doesn't pass the
check stage we won't enqueue it, however, we can always do in reverse
ordering), based on this, we can only enqueue the first dependency from
a dependency list and every time we want to fetch a new dependency to
work, we can either:

  1)	fetch the dependency next to the current dependency in the
	dependency list
or

  2)	if the dependency in 1) doesn't exist, fetch the dependency from
	the queue.

With this approach, the "max bfs queue depth" for a x86_64_defconfig +
lockdep and selftest config kernel can get descreased from:

        max bfs queue depth:                   201

to (after apply this patch)

        max bfs queue depth:                   61

While I'm at it, clean up the code logic a little (e.g. directly return
other than set a "ret" value and goto the "exit" label).

[1]: https://lore.kernel.org/lkml/17343f6f7f2438fc376125384133c5ba70c2a681.camel@redhat.com/

Reported-by: Qian Cai <cai@redhat.com>
Reported-by: syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200917080210.108095-1-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c |  99 +++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 39 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index cccf4bc..9560a4e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1606,6 +1606,15 @@ static inline void bfs_init_rootb(struct lock_list *lock,
 	lock->only_xr = (hlock->read != 0);
 }
 
+static inline struct lock_list *__bfs_next(struct lock_list *lock, int offset)
+{
+	if (!lock || !lock->parent)
+		return NULL;
+
+	return list_next_or_null_rcu(get_dep_list(lock->parent, offset),
+				     &lock->entry, struct lock_list, entry);
+}
+
 /*
  * Breadth-First Search to find a strong path in the dependency graph.
  *
@@ -1639,36 +1648,25 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 			     struct lock_list **target_entry,
 			     int offset)
 {
+	struct circular_queue *cq = &lock_cq;
+	struct lock_list *lock = NULL;
 	struct lock_list *entry;
-	struct lock_list *lock;
 	struct list_head *head;
-	struct circular_queue *cq = &lock_cq;
-	enum bfs_result ret = BFS_RNOMATCH;
+	unsigned int cq_depth;
+	bool first;
 
 	lockdep_assert_locked();
 
-	if (match(source_entry, data)) {
-		*target_entry = source_entry;
-		ret = BFS_RMATCH;
-		goto exit;
-	}
-
-	head = get_dep_list(source_entry, offset);
-	if (list_empty(head))
-		goto exit;
-
 	__cq_init(cq);
 	__cq_enqueue(cq, source_entry);
 
-	while ((lock = __cq_dequeue(cq))) {
-		bool prev_only_xr;
-
-		if (!lock->class) {
-			ret = BFS_EINVALIDNODE;
-			goto exit;
-		}
+	while ((lock = __bfs_next(lock, offset)) || (lock = __cq_dequeue(cq))) {
+		if (!lock->class)
+			return BFS_EINVALIDNODE;
 
 		/*
+		 * Step 1: check whether we already finish on this one.
+		 *
 		 * If we have visited all the dependencies from this @lock to
 		 * others (iow, if we have visited all lock_list entries in
 		 * @lock->class->locks_{after,before}) we skip, otherwise go
@@ -1680,13 +1678,13 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 		else
 			mark_lock_accessed(lock);
 
-		head = get_dep_list(lock, offset);
-
-		prev_only_xr = lock->only_xr;
-
-		list_for_each_entry_rcu(entry, head, entry) {
-			unsigned int cq_depth;
-			u8 dep = entry->dep;
+		/*
+		 * Step 2: check whether prev dependency and this form a strong
+		 *         dependency path.
+		 */
+		if (lock->parent) { /* Parent exists, check prev dependency */
+			u8 dep = lock->dep;
+			bool prev_only_xr = lock->parent->only_xr;
 
 			/*
 			 * Mask out all -(S*)-> if we only have *R in previous
@@ -1701,26 +1699,49 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 				continue;
 
 			/* If there are only -(*R)-> left, set that for the next step */
-			entry->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
+			lock->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
+		}
 
+		/*
+		 * Step 3: we haven't visited this and there is a strong
+		 *         dependency path to this, so check with @match.
+		 */
+		if (match(lock, data)) {
+			*target_entry = lock;
+			return BFS_RMATCH;
+		}
+
+		/*
+		 * Step 4: if not match, expand the path by adding the
+		 *         forward or backwards dependencis in the search
+		 *
+		 */
+		first = true;
+		head = get_dep_list(lock, offset);
+		list_for_each_entry_rcu(entry, head, entry) {
 			visit_lock_entry(entry, lock);
-			if (match(entry, data)) {
-				*target_entry = entry;
-				ret = BFS_RMATCH;
-				goto exit;
-			}
 
-			if (__cq_enqueue(cq, entry)) {
-				ret = BFS_EQUEUEFULL;
-				goto exit;
-			}
+			/*
+			 * Note we only enqueue the first of the list into the
+			 * queue, because we can always find a sibling
+			 * dependency from one (see __bfs_next()), as a result
+			 * the space of queue is saved.
+			 */
+			if (!first)
+				continue;
+
+			first = false;
+
+			if (__cq_enqueue(cq, entry))
+				return BFS_EQUEUEFULL;
+
 			cq_depth = __cq_get_elem_count(cq);
 			if (max_bfs_queue_depth < cq_depth)
 				max_bfs_queue_depth = cq_depth;
 		}
 	}
-exit:
-	return ret;
+
+	return BFS_RNOMATCH;
 }
 
 static inline enum bfs_result
