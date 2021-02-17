Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8AF31DA2A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhBQNTI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:19:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45334 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhBQNSW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:22 -0500
Date:   Wed, 17 Feb 2021 13:17:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DQpWP1VeQnZt43Wq9J2SJ+ZQmWf95pz4X7jpOHYn7Eo=;
        b=0LKmRWyJpfn57Ipe2OpdOiqLpKrOBOqdyZ36SyvVDII+lDrr8+YX/B/7Zr7d684mnKt3qg
        hf7LMMroUUmlutNhlEWb7lDXpSrAtfX6ZE4+vFfs6er3EWkOXiVy8Gy4uTbVyUfd3aK3mb
        M2/n/pE354P2LoxYC+UJ7nstBuksgSe+aGpuFLhDz1bnOJ8iXzRgfKX1//sGjJpO5eXUDB
        rKWoBTRbuB5Fvgi06Mr66RZLsTQWIaXCw6iDHPteDNgK7R5W0g1x/2KyBX8WOyfcxZ2sNu
        Juv35dkMGZO3ULdDtQhPDsXf0eBlhY8VoRMpBfiyXIxXYa7QrbLOTjm5IsiTiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DQpWP1VeQnZt43Wq9J2SJ+ZQmWf95pz4X7jpOHYn7Eo=;
        b=eu8MsHVhWXa9mZGNl5aNIyvpAlW8G8jAz7IwG1QNoUNTbyN+g1kPSJYgmk3agxBkrO4Rpr
        4woADzBl3Sa0q1DQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rbtree, sched/fair: Use rb_add_cached()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161356785839.20312.17407148777810074305.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     bf9be9a163b464aa90f60af13b336da2db8b2ea1
Gitweb:        https://git.kernel.org/tip/bf9be9a163b464aa90f60af13b336da2db8b2ea1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 29 Apr 2020 17:04:12 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:07:39 +01:00

rbtree, sched/fair: Use rb_add_cached()

Reduce rbtree boiler plate by using the new helper function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/sched/fair.c | 46 +++++++++++++-------------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c73d588..59b645e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -531,12 +531,15 @@ static inline u64 min_vruntime(u64 min_vruntime, u64 vruntime)
 	return min_vruntime;
 }
 
-static inline int entity_before(struct sched_entity *a,
+static inline bool entity_before(struct sched_entity *a,
 				struct sched_entity *b)
 {
 	return (s64)(a->vruntime - b->vruntime) < 0;
 }
 
+#define __node_2_se(node) \
+	rb_entry((node), struct sched_entity, run_node)
+
 static void update_min_vruntime(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
@@ -552,8 +555,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 	}
 
 	if (leftmost) { /* non-empty tree */
-		struct sched_entity *se;
-		se = rb_entry(leftmost, struct sched_entity, run_node);
+		struct sched_entity *se = __node_2_se(leftmost);
 
 		if (!curr)
 			vruntime = se->vruntime;
@@ -569,37 +571,17 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 #endif
 }
 
+static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
+{
+	return entity_before(__node_2_se(a), __node_2_se(b));
+}
+
 /*
  * Enqueue an entity into the rb-tree:
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	struct rb_node **link = &cfs_rq->tasks_timeline.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct sched_entity *entry;
-	bool leftmost = true;
-
-	/*
-	 * Find the right place in the rbtree:
-	 */
-	while (*link) {
-		parent = *link;
-		entry = rb_entry(parent, struct sched_entity, run_node);
-		/*
-		 * We dont care about collisions. Nodes with
-		 * the same key stay together.
-		 */
-		if (entity_before(se, entry)) {
-			link = &parent->rb_left;
-		} else {
-			link = &parent->rb_right;
-			leftmost = false;
-		}
-	}
-
-	rb_link_node(&se->run_node, parent, link);
-	rb_insert_color_cached(&se->run_node,
-			       &cfs_rq->tasks_timeline, leftmost);
+	rb_add_cached(&se->run_node, &cfs_rq->tasks_timeline, __entity_less);
 }
 
 static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -614,7 +596,7 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 	if (!left)
 		return NULL;
 
-	return rb_entry(left, struct sched_entity, run_node);
+	return __node_2_se(left);
 }
 
 static struct sched_entity *__pick_next_entity(struct sched_entity *se)
@@ -624,7 +606,7 @@ static struct sched_entity *__pick_next_entity(struct sched_entity *se)
 	if (!next)
 		return NULL;
 
-	return rb_entry(next, struct sched_entity, run_node);
+	return __node_2_se(next);
 }
 
 #ifdef CONFIG_SCHED_DEBUG
@@ -635,7 +617,7 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 	if (!last)
 		return NULL;
 
-	return rb_entry(last, struct sched_entity, run_node);
+	return __node_2_se(last);
 }
 
 /**************************************************************
