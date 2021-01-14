Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA1D2F5FFC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbhANLaI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:30:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58842 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbhANL3m (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:29:42 -0500
Date:   Thu, 14 Jan 2021 11:28:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rgyvNa3OnpTxZzw0qYhwlJz+EuwkJ6TD8eZVlsvYY1Y=;
        b=0UDPJ2B86tRi/tE4BLSl2MOwFq4f7AeA1L6cZRAdMEzx2ZFZDd9GmRQzLgOp3K1nG0D7L9
        yVEmjE1RSMPvrc36gBXTz8nqZLCTlzgWwueILWwpK5x8VTMlyeXOjTzthMEcMhy5hTw518
        OZdoj19uDkpqmCQUSU4Dpi6hJKlaaynQ76s4KySzMQfRJCvMlN8oNNQVDjAIOKOVfDGu32
        BfW3US5oq8DvpqCNAIRvv/tmjldD6DAS6k879gllbXeYLChUAbZDxwVEiDwkvl05FnwHCo
        VOjcxMRuVCScDCd7r1HxSgPQO21HuzehV0Oh1t5mzrYLObLBHpACfpVne6ciCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rgyvNa3OnpTxZzw0qYhwlJz+EuwkJ6TD8eZVlsvYY1Y=;
        b=8S9lcHwD/eMjYTjyBcnYL7jF5F/2VInyc2YW58IDXk9swLAKeRtFYk7+JaFe/I7i83bEtg
        jhA03pK3eb9WiFBg==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Add a skip() function to __bfs()
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161062373933.414.15171897280478446742.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bc2dd71b283665f0a409d5b6fc603d5a6fdc219e
Gitweb:        https://git.kernel.org/tip/bc2dd71b283665f0a409d5b6fc603d5a6fdc219e
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Thu, 10 Dec 2020 11:02:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:17 +01:00

locking/lockdep: Add a skip() function to __bfs()

Some __bfs() walks will have additional iteration constraints (beyond
the path being strong). Provide an additional function to allow
terminating graph walks.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b061e29..f50f026 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1672,6 +1672,7 @@ static inline struct lock_list *__bfs_next(struct lock_list *lock, int offset)
 static enum bfs_result __bfs(struct lock_list *source_entry,
 			     void *data,
 			     bool (*match)(struct lock_list *entry, void *data),
+			     bool (*skip)(struct lock_list *entry, void *data),
 			     struct lock_list **target_entry,
 			     int offset)
 {
@@ -1732,7 +1733,12 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 		/*
 		 * Step 3: we haven't visited this and there is a strong
 		 *         dependency path to this, so check with @match.
+		 *         If @skip is provide and returns true, we skip this
+		 *         lock (and any path this lock is in).
 		 */
+		if (skip && skip(lock, data))
+			continue;
+
 		if (match(lock, data)) {
 			*target_entry = lock;
 			return BFS_RMATCH;
@@ -1775,9 +1781,10 @@ static inline enum bfs_result
 __bfs_forwards(struct lock_list *src_entry,
 	       void *data,
 	       bool (*match)(struct lock_list *entry, void *data),
+	       bool (*skip)(struct lock_list *entry, void *data),
 	       struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry,
+	return __bfs(src_entry, data, match, skip, target_entry,
 		     offsetof(struct lock_class, locks_after));
 
 }
@@ -1786,9 +1793,10 @@ static inline enum bfs_result
 __bfs_backwards(struct lock_list *src_entry,
 		void *data,
 		bool (*match)(struct lock_list *entry, void *data),
+	       bool (*skip)(struct lock_list *entry, void *data),
 		struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry,
+	return __bfs(src_entry, data, match, skip, target_entry,
 		     offsetof(struct lock_class, locks_before));
 
 }
@@ -2019,7 +2027,7 @@ static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
 	unsigned long  count = 0;
 	struct lock_list *target_entry;
 
-	__bfs_forwards(this, (void *)&count, noop_count, &target_entry);
+	__bfs_forwards(this, (void *)&count, noop_count, NULL, &target_entry);
 
 	return count;
 }
@@ -2044,7 +2052,7 @@ static unsigned long __lockdep_count_backward_deps(struct lock_list *this)
 	unsigned long  count = 0;
 	struct lock_list *target_entry;
 
-	__bfs_backwards(this, (void *)&count, noop_count, &target_entry);
+	__bfs_backwards(this, (void *)&count, noop_count, NULL, &target_entry);
 
 	return count;
 }
@@ -2072,11 +2080,12 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 static noinline enum bfs_result
 check_path(struct held_lock *target, struct lock_list *src_entry,
 	   bool (*match)(struct lock_list *entry, void *data),
+	   bool (*skip)(struct lock_list *entry, void *data),
 	   struct lock_list **target_entry)
 {
 	enum bfs_result ret;
 
-	ret = __bfs_forwards(src_entry, target, match, target_entry);
+	ret = __bfs_forwards(src_entry, target, match, skip, target_entry);
 
 	if (unlikely(bfs_error(ret)))
 		print_bfs_bug(ret);
@@ -2103,7 +2112,7 @@ check_noncircular(struct held_lock *src, struct held_lock *target,
 
 	debug_atomic_inc(nr_cyclic_checks);
 
-	ret = check_path(target, &src_entry, hlock_conflict, &target_entry);
+	ret = check_path(target, &src_entry, hlock_conflict, NULL, &target_entry);
 
 	if (unlikely(ret == BFS_RMATCH)) {
 		if (!*trace) {
@@ -2152,7 +2161,7 @@ check_redundant(struct held_lock *src, struct held_lock *target)
 
 	debug_atomic_inc(nr_redundant_checks);
 
-	ret = check_path(target, &src_entry, hlock_equal, &target_entry);
+	ret = check_path(target, &src_entry, hlock_equal, NULL, &target_entry);
 
 	if (ret == BFS_RMATCH)
 		debug_atomic_inc(nr_redundant);
@@ -2246,7 +2255,7 @@ find_usage_forwards(struct lock_list *root, unsigned long usage_mask,
 
 	debug_atomic_inc(nr_find_usage_forwards_checks);
 
-	result = __bfs_forwards(root, &usage_mask, usage_match, target_entry);
+	result = __bfs_forwards(root, &usage_mask, usage_match, NULL, target_entry);
 
 	return result;
 }
@@ -2263,7 +2272,7 @@ find_usage_backwards(struct lock_list *root, unsigned long usage_mask,
 
 	debug_atomic_inc(nr_find_usage_backwards_checks);
 
-	result = __bfs_backwards(root, &usage_mask, usage_match, target_entry);
+	result = __bfs_backwards(root, &usage_mask, usage_match, NULL, target_entry);
 
 	return result;
 }
@@ -2628,7 +2637,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	 */
 	bfs_init_rootb(&this, prev);
 
-	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, NULL);
+	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, NULL, NULL);
 	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;
