Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B8A2F5FEF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbhANL3m (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbhANL3l (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:29:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E35C061574;
        Thu, 14 Jan 2021 03:29:01 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:28:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PZsdJ/a0zYTQabjCkSspQGCF7aTGYepY66YQNJdeG04=;
        b=4oTtPbX4gVSTXy4U33nMxSb9BEwWEtxQ1uCOLNBD22p682QI/cqXgLxWiXAX0l0AJ+B3mB
        TL9NAQthaSEsBgYSeQPaWkLqdoK7tvdsAxlDiyP39UfdB9li8hx1pvXDqOtJ3bHWOKLMjq
        Yqg/NVeMF7acb8ZBzkRWcPbanLDKNGetVNhb9mK40ARxhn+Mg8CJTZlWx6TbLyWhOUi7d9
        mhh9FlWJN8OE2O8KzFsbo1WknwVsVqVJvmsMGFDkeZqU4Aio+6KShx46NIvl8BkPXUvbsR
        dmd+SqWeWUiQFPpuKbfO7KE2WV3lItGHZ5D1JzO0Xium2iqbK9i+fSqTgZ5tUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PZsdJ/a0zYTQabjCkSspQGCF7aTGYepY66YQNJdeG04=;
        b=HMJ29xdzkt/IGguWU/Pfqgb+uk2V9VlxzmziLJMu0pfvWmBLdJkuHru/7ECehNziRDhlkE
        WtuVGfOLg2qBC8DQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Clean up check_redundant() a bit
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161062373915.414.16842040757243490898.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     175b1a60e8805617d74aefe17ce0d3a32eceb55c
Gitweb:        https://git.kernel.org/tip/175b1a60e8805617d74aefe17ce0d3a32eceb55c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 10 Dec 2020 11:16:34 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:17 +01:00

locking/lockdep: Clean up check_redundant() a bit

In preparation for adding an TRACE_IRQFLAGS dependent skip function to
check_redundant(), move it below the TRACE_IRQFLAGS #ifdef.

While there, provide a stub function to reduce #ifdef usage.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c | 91 +++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 42 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index f50f026..f2ae8a6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2130,46 +2130,6 @@ check_noncircular(struct held_lock *src, struct held_lock *target,
 	return ret;
 }
 
-#ifdef CONFIG_LOCKDEP_SMALL
-/*
- * Check that the dependency graph starting at <src> can lead to
- * <target> or not. If it can, <src> -> <target> dependency is already
- * in the graph.
- *
- * Return BFS_RMATCH if it does, or BFS_RMATCH if it does not, return BFS_E* if
- * any error appears in the bfs search.
- */
-static noinline enum bfs_result
-check_redundant(struct held_lock *src, struct held_lock *target)
-{
-	enum bfs_result ret;
-	struct lock_list *target_entry;
-	struct lock_list src_entry;
-
-	bfs_init_root(&src_entry, src);
-	/*
-	 * Special setup for check_redundant().
-	 *
-	 * To report redundant, we need to find a strong dependency path that
-	 * is equal to or stronger than <src> -> <target>. So if <src> is E,
-	 * we need to let __bfs() only search for a path starting at a -(E*)->,
-	 * we achieve this by setting the initial node's ->only_xr to true in
-	 * that case. And if <prev> is S, we set initial ->only_xr to false
-	 * because both -(S*)-> (equal) and -(E*)-> (stronger) are redundant.
-	 */
-	src_entry.only_xr = src->read == 0;
-
-	debug_atomic_inc(nr_redundant_checks);
-
-	ret = check_path(target, &src_entry, hlock_equal, NULL, &target_entry);
-
-	if (ret == BFS_RMATCH)
-		debug_atomic_inc(nr_redundant);
-
-	return ret;
-}
-#endif
-
 #ifdef CONFIG_TRACE_IRQFLAGS
 
 /*
@@ -2706,6 +2666,55 @@ static inline int check_irq_usage(struct task_struct *curr,
 }
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
+#ifdef CONFIG_LOCKDEP_SMALL
+/*
+ * Check that the dependency graph starting at <src> can lead to
+ * <target> or not. If it can, <src> -> <target> dependency is already
+ * in the graph.
+ *
+ * Return BFS_RMATCH if it does, or BFS_RMATCH if it does not, return BFS_E* if
+ * any error appears in the bfs search.
+ */
+static noinline enum bfs_result
+check_redundant(struct held_lock *src, struct held_lock *target)
+{
+	enum bfs_result ret;
+	struct lock_list *target_entry;
+	struct lock_list src_entry;
+
+	bfs_init_root(&src_entry, src);
+	/*
+	 * Special setup for check_redundant().
+	 *
+	 * To report redundant, we need to find a strong dependency path that
+	 * is equal to or stronger than <src> -> <target>. So if <src> is E,
+	 * we need to let __bfs() only search for a path starting at a -(E*)->,
+	 * we achieve this by setting the initial node's ->only_xr to true in
+	 * that case. And if <prev> is S, we set initial ->only_xr to false
+	 * because both -(S*)-> (equal) and -(E*)-> (stronger) are redundant.
+	 */
+	src_entry.only_xr = src->read == 0;
+
+	debug_atomic_inc(nr_redundant_checks);
+
+	ret = check_path(target, &src_entry, hlock_equal, NULL, &target_entry);
+
+	if (ret == BFS_RMATCH)
+		debug_atomic_inc(nr_redundant);
+
+	return ret;
+}
+
+#else
+
+static inline enum bfs_result
+check_redundant(struct held_lock *src, struct held_lock *target)
+{
+	return BFS_RNOMATCH;
+}
+
+#endif
+
 static void inc_chains(int irq_context)
 {
 	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
@@ -2926,7 +2935,6 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 		}
 	}
 
-#ifdef CONFIG_LOCKDEP_SMALL
 	/*
 	 * Is the <prev> -> <next> link redundant?
 	 */
@@ -2935,7 +2943,6 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 		return 0;
 	else if (ret == BFS_RMATCH)
 		return 2;
-#endif
 
 	if (!*trace) {
 		*trace = save_trace();
