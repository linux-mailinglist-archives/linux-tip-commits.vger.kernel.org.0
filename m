Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B67231DA29
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhBQNTH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:19:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45312 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhBQNSW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:22 -0500
Date:   Wed, 17 Feb 2021 13:17:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ovWnuwf97ds2RS8L/kJq/EfUvwpxA+aHXV1H0VXnmcY=;
        b=KgzIBSBiwn+o+j71QLPN5KbTC9nfA2dneX3UsW00d7phjC7GziFQYgaQMG3/vXLLMMxLu1
        l3hKQSTN5fnDTmlfbfAPjipVuWYanMDg49q9/HKftRa9PICKEZrzh7vMtVBFENnMN27iFL
        R96tP4xCdJyABvE0IPgOP3/1EVZU0++ufrKg9XaJA2BvqS/GCtiw+rk23ZdPFtLyxL6oKv
        qCrmPyKeAroNgPHLzPSSpV2C7ObunzpQf6W06AOZ6CugGHH+BPK9H77xLiIocP9RyPFV7D
        LCV7DZ94zJyj70d/By13tAXFnqqneRxOGEtFlYXtEWAU66NiT0EovIExmTtRsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ovWnuwf97ds2RS8L/kJq/EfUvwpxA+aHXV1H0VXnmcY=;
        b=Xs1rdjFgLEJq60sF0hOJWh4LZ/gf9uu09AE1dD03egAqF9VmGJbEwjywPCrCCt8ePU/mXu
        cYu6UTC3OZfN51Dg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rbtree, sched/deadline: Use rb_add_cached()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161356785815.20312.12584548346844077530.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8ecca39483ed4e4e97096d0d6f8e25fdd323b189
Gitweb:        https://git.kernel.org/tip/8ecca39483ed4e4e97096d0d6f8e25fdd323b189
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 29 Apr 2020 17:04:41 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:07:44 +01:00

rbtree, sched/deadline: Use rb_add_cached()

Reduce rbtree boiler plate by using the new helpers.

Make rb_add_cached() / rb_erase_cached() return a pointer to the
leftmost node to aid in updating additional state.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/rbtree.h  | 18 +++++++--
 kernel/sched/deadline.c | 77 ++++++++++++++--------------------------
 2 files changed, 42 insertions(+), 53 deletions(-)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index e0b300d..d31ecaf 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -141,12 +141,18 @@ static inline void rb_insert_color_cached(struct rb_node *node,
 	rb_insert_color(node, &root->rb_root);
 }
 
-static inline void rb_erase_cached(struct rb_node *node,
-				   struct rb_root_cached *root)
+
+static inline struct rb_node *
+rb_erase_cached(struct rb_node *node, struct rb_root_cached *root)
 {
+	struct rb_node *leftmost = NULL;
+
 	if (root->rb_leftmost == node)
-		root->rb_leftmost = rb_next(node);
+		leftmost = root->rb_leftmost = rb_next(node);
+
 	rb_erase(node, &root->rb_root);
+
+	return leftmost;
 }
 
 static inline void rb_replace_node_cached(struct rb_node *victim,
@@ -179,8 +185,10 @@ static inline void rb_replace_node_cached(struct rb_node *victim,
  * @node: node to insert
  * @tree: leftmost cached tree to insert @node into
  * @less: operator defining the (partial) node order
+ *
+ * Returns @node when it is the new leftmost, or NULL.
  */
-static __always_inline void
+static __always_inline struct rb_node *
 rb_add_cached(struct rb_node *node, struct rb_root_cached *tree,
 	      bool (*less)(struct rb_node *, const struct rb_node *))
 {
@@ -200,6 +208,8 @@ rb_add_cached(struct rb_node *node, struct rb_root_cached *tree,
 
 	rb_link_node(node, parent, link);
 	rb_insert_color_cached(node, tree, leftmost);
+
+	return leftmost ? node : NULL;
 }
 
 /**
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5421782..1508d12 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -517,58 +517,44 @@ static void dec_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 	update_dl_migration(dl_rq);
 }
 
+#define __node_2_pdl(node) \
+	rb_entry((node), struct task_struct, pushable_dl_tasks)
+
+static inline bool __pushable_less(struct rb_node *a, const struct rb_node *b)
+{
+	return dl_entity_preempt(&__node_2_pdl(a)->dl, &__node_2_pdl(b)->dl);
+}
+
 /*
  * The list of pushable -deadline task is not a plist, like in
  * sched_rt.c, it is an rb-tree with tasks ordered by deadline.
  */
 static void enqueue_pushable_dl_task(struct rq *rq, struct task_struct *p)
 {
-	struct dl_rq *dl_rq = &rq->dl;
-	struct rb_node **link = &dl_rq->pushable_dl_tasks_root.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct task_struct *entry;
-	bool leftmost = true;
+	struct rb_node *leftmost;
 
 	BUG_ON(!RB_EMPTY_NODE(&p->pushable_dl_tasks));
 
-	while (*link) {
-		parent = *link;
-		entry = rb_entry(parent, struct task_struct,
-				 pushable_dl_tasks);
-		if (dl_entity_preempt(&p->dl, &entry->dl))
-			link = &parent->rb_left;
-		else {
-			link = &parent->rb_right;
-			leftmost = false;
-		}
-	}
-
+	leftmost = rb_add_cached(&p->pushable_dl_tasks,
+				 &rq->dl.pushable_dl_tasks_root,
+				 __pushable_less);
 	if (leftmost)
-		dl_rq->earliest_dl.next = p->dl.deadline;
-
-	rb_link_node(&p->pushable_dl_tasks, parent, link);
-	rb_insert_color_cached(&p->pushable_dl_tasks,
-			       &dl_rq->pushable_dl_tasks_root, leftmost);
+		rq->dl.earliest_dl.next = p->dl.deadline;
 }
 
 static void dequeue_pushable_dl_task(struct rq *rq, struct task_struct *p)
 {
 	struct dl_rq *dl_rq = &rq->dl;
+	struct rb_root_cached *root = &dl_rq->pushable_dl_tasks_root;
+	struct rb_node *leftmost;
 
 	if (RB_EMPTY_NODE(&p->pushable_dl_tasks))
 		return;
 
-	if (dl_rq->pushable_dl_tasks_root.rb_leftmost == &p->pushable_dl_tasks) {
-		struct rb_node *next_node;
-
-		next_node = rb_next(&p->pushable_dl_tasks);
-		if (next_node) {
-			dl_rq->earliest_dl.next = rb_entry(next_node,
-				struct task_struct, pushable_dl_tasks)->dl.deadline;
-		}
-	}
+	leftmost = rb_erase_cached(&p->pushable_dl_tasks, root);
+	if (leftmost)
+		dl_rq->earliest_dl.next = __node_2_pdl(leftmost)->dl.deadline;
 
-	rb_erase_cached(&p->pushable_dl_tasks, &dl_rq->pushable_dl_tasks_root);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
 }
 
@@ -1478,29 +1464,21 @@ void dec_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 	dec_dl_migration(dl_se, dl_rq);
 }
 
+#define __node_2_dle(node) \
+	rb_entry((node), struct sched_dl_entity, rb_node)
+
+static inline bool __dl_less(struct rb_node *a, const struct rb_node *b)
+{
+	return dl_time_before(__node_2_dle(a)->deadline, __node_2_dle(b)->deadline);
+}
+
 static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
-	struct rb_node **link = &dl_rq->root.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct sched_dl_entity *entry;
-	int leftmost = 1;
 
 	BUG_ON(!RB_EMPTY_NODE(&dl_se->rb_node));
 
-	while (*link) {
-		parent = *link;
-		entry = rb_entry(parent, struct sched_dl_entity, rb_node);
-		if (dl_time_before(dl_se->deadline, entry->deadline))
-			link = &parent->rb_left;
-		else {
-			link = &parent->rb_right;
-			leftmost = 0;
-		}
-	}
-
-	rb_link_node(&dl_se->rb_node, parent, link);
-	rb_insert_color_cached(&dl_se->rb_node, &dl_rq->root, leftmost);
+	rb_add_cached(&dl_se->rb_node, &dl_rq->root, __dl_less);
 
 	inc_dl_tasks(dl_se, dl_rq);
 }
@@ -1513,6 +1491,7 @@ static void __dequeue_dl_entity(struct sched_dl_entity *dl_se)
 		return;
 
 	rb_erase_cached(&dl_se->rb_node, &dl_rq->root);
+
 	RB_CLEAR_NODE(&dl_se->rb_node);
 
 	dec_dl_tasks(dl_se, dl_rq);
