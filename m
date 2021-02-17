Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4454631DA38
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhBQNTw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbhBQNT2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:19:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72552C061356;
        Wed, 17 Feb 2021 05:17:40 -0800 (PST)
Date:   Wed, 17 Feb 2021 13:17:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IWtMROH6UtVEqnnOS8T+fJs9Czza09lonxeI6K0/ySo=;
        b=M38tjeGlAlywxvEGnCzF6uJyPTas2pW/Jfhld2TAm27dKyJtNW1TeJAIJmU+zKcUi1QWvB
        Ee5UU3bRX1m8moOn8Su/ZwxWrA/amXlo25CuL9zDuUMKtnk9a9Vw+EOeuUdM4cbRHW9G6x
        INi4K7juk3VsJBFJzHLs8s3+clwTczyYFXXrcrPPlWTm7Gm/TYgdPmUDyJrZHvZqQuFmbL
        Bf/DNoayuX7DF8e5+niSWsKrxBbaEs6KPm4ZGnqWbDnjIZu7SD5oPFhuoetj4SaUIUqr0A
        d1kaKO+EUXDYbdb1YHcoBhfXmj15ufhai2RM81Gci/PBjFAknrt8H9F/3nKCpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IWtMROH6UtVEqnnOS8T+fJs9Czza09lonxeI6K0/ySo=;
        b=MJr5KXnmZFxVSvPLhjdsOsqb+j8LEGGD68gGY3C2ZP29Yy1Uz1WqRKyvqBDUS2ePJPKmTL
        FwgWKK4hTj3D03Dg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rbtree, perf: Use new rbtree helpers
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161356785782.20312.6517258331763018562.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a3b89864554bbce1594b7abdb5739fc708c1ca95
Gitweb:        https://git.kernel.org/tip/a3b89864554bbce1594b7abdb5739fc708c1ca95
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 29 Apr 2020 17:05:15 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:07:48 +01:00

rbtree, perf: Use new rbtree helpers

Reduce rbtree boiler plate by using the new helpers.

One noteworthy change is unification of the various (partial) compare
functions. We construct a subtree match by forcing the sub-order to
always match, see __group_cmp().

Due to 'const' we had to touch cgroup_id().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/cgroup.h |   4 +-
 kernel/events/core.c   | 195 ++++++++++++++++++----------------------
 2 files changed, 92 insertions(+), 107 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 451c2d2..4f2f79d 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -307,7 +307,7 @@ void css_task_iter_end(struct css_task_iter *it);
  * Inline functions.
  */
 
-static inline u64 cgroup_id(struct cgroup *cgrp)
+static inline u64 cgroup_id(const struct cgroup *cgrp)
 {
 	return cgrp->kn->id;
 }
@@ -701,7 +701,7 @@ void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
 struct cgroup_subsys_state;
 struct cgroup;
 
-static inline u64 cgroup_id(struct cgroup *cgrp) { return 1; }
+static inline u64 cgroup_id(const struct cgroup *cgrp) { return 1; }
 static inline void css_get(struct cgroup_subsys_state *css) {}
 static inline void css_put(struct cgroup_subsys_state *css) {}
 static inline int cgroup_attach_task_all(struct task_struct *from,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 55d1879..3d89096 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1595,50 +1595,91 @@ static void perf_event_groups_init(struct perf_event_groups *groups)
 	groups->index = 0;
 }
 
+static inline struct cgroup *event_cgroup(const struct perf_event *event)
+{
+	struct cgroup *cgroup = NULL;
+
+#ifdef CONFIG_CGROUP_PERF
+	if (event->cgrp)
+		cgroup = event->cgrp->css.cgroup;
+#endif
+
+	return cgroup;
+}
+
 /*
  * Compare function for event groups;
  *
  * Implements complex key that first sorts by CPU and then by virtual index
  * which provides ordering when rotating groups for the same CPU.
  */
-static bool
-perf_event_groups_less(struct perf_event *left, struct perf_event *right)
+static __always_inline int
+perf_event_groups_cmp(const int left_cpu, const struct cgroup *left_cgroup,
+		      const u64 left_group_index, const struct perf_event *right)
 {
-	if (left->cpu < right->cpu)
-		return true;
-	if (left->cpu > right->cpu)
-		return false;
+	if (left_cpu < right->cpu)
+		return -1;
+	if (left_cpu > right->cpu)
+		return 1;
 
 #ifdef CONFIG_CGROUP_PERF
-	if (left->cgrp != right->cgrp) {
-		if (!left->cgrp || !left->cgrp->css.cgroup) {
-			/*
-			 * Left has no cgroup but right does, no cgroups come
-			 * first.
-			 */
-			return true;
-		}
-		if (!right->cgrp || !right->cgrp->css.cgroup) {
-			/*
-			 * Right has no cgroup but left does, no cgroups come
-			 * first.
-			 */
-			return false;
-		}
-		/* Two dissimilar cgroups, order by id. */
-		if (left->cgrp->css.cgroup->kn->id < right->cgrp->css.cgroup->kn->id)
-			return true;
+	{
+		const struct cgroup *right_cgroup = event_cgroup(right);
 
-		return false;
+		if (left_cgroup != right_cgroup) {
+			if (!left_cgroup) {
+				/*
+				 * Left has no cgroup but right does, no
+				 * cgroups come first.
+				 */
+				return -1;
+			}
+			if (!right_cgroup) {
+				/*
+				 * Right has no cgroup but left does, no
+				 * cgroups come first.
+				 */
+				return 1;
+			}
+			/* Two dissimilar cgroups, order by id. */
+			if (cgroup_id(left_cgroup) < cgroup_id(right_cgroup))
+				return -1;
+
+			return 1;
+		}
 	}
 #endif
 
-	if (left->group_index < right->group_index)
-		return true;
-	if (left->group_index > right->group_index)
-		return false;
+	if (left_group_index < right->group_index)
+		return -1;
+	if (left_group_index > right->group_index)
+		return 1;
 
-	return false;
+	return 0;
+}
+
+#define __node_2_pe(node) \
+	rb_entry((node), struct perf_event, group_node)
+
+static inline bool __group_less(struct rb_node *a, const struct rb_node *b)
+{
+	struct perf_event *e = __node_2_pe(a);
+	return perf_event_groups_cmp(e->cpu, event_cgroup(e), e->group_index,
+				     __node_2_pe(b)) < 0;
+}
+
+struct __group_key {
+	int cpu;
+	struct cgroup *cgroup;
+};
+
+static inline int __group_cmp(const void *key, const struct rb_node *node)
+{
+	const struct __group_key *a = key;
+	const struct perf_event *b = __node_2_pe(node);
+
+	/* partial/subtree match: @cpu, @cgroup; ignore: @group_index */
+	return perf_event_groups_cmp(a->cpu, a->cgroup, b->group_index, b);
 }
 
 /*
@@ -1650,27 +1691,9 @@ static void
 perf_event_groups_insert(struct perf_event_groups *groups,
 			 struct perf_event *event)
 {
-	struct perf_event *node_event;
-	struct rb_node *parent;
-	struct rb_node **node;
-
 	event->group_index = ++groups->index;
 
-	node = &groups->tree.rb_node;
-	parent = *node;
-
-	while (*node) {
-		parent = *node;
-		node_event = container_of(*node, struct perf_event, group_node);
-
-		if (perf_event_groups_less(event, node_event))
-			node = &parent->rb_left;
-		else
-			node = &parent->rb_right;
-	}
-
-	rb_link_node(&event->group_node, parent, node);
-	rb_insert_color(&event->group_node, &groups->tree);
+	rb_add(&event->group_node, &groups->tree, __group_less);
 }
 
 /*
@@ -1718,45 +1741,17 @@ static struct perf_event *
 perf_event_groups_first(struct perf_event_groups *groups, int cpu,
 			struct cgroup *cgrp)
 {
-	struct perf_event *node_event = NULL, *match = NULL;
-	struct rb_node *node = groups->tree.rb_node;
-#ifdef CONFIG_CGROUP_PERF
-	u64 node_cgrp_id, cgrp_id = 0;
-
-	if (cgrp)
-		cgrp_id = cgrp->kn->id;
-#endif
-
-	while (node) {
-		node_event = container_of(node, struct perf_event, group_node);
-
-		if (cpu < node_event->cpu) {
-			node = node->rb_left;
-			continue;
-		}
-		if (cpu > node_event->cpu) {
-			node = node->rb_right;
-			continue;
-		}
-#ifdef CONFIG_CGROUP_PERF
-		node_cgrp_id = 0;
-		if (node_event->cgrp && node_event->cgrp->css.cgroup)
-			node_cgrp_id = node_event->cgrp->css.cgroup->kn->id;
+	struct __group_key key = {
+		.cpu = cpu,
+		.cgroup = cgrp,
+	};
+	struct rb_node *node;
 
-		if (cgrp_id < node_cgrp_id) {
-			node = node->rb_left;
-			continue;
-		}
-		if (cgrp_id > node_cgrp_id) {
-			node = node->rb_right;
-			continue;
-		}
-#endif
-		match = node_event;
-		node = node->rb_left;
-	}
+	node = rb_find_first(&key, &groups->tree, __group_cmp);
+	if (node)
+		return __node_2_pe(node);
 
-	return match;
+	return NULL;
 }
 
 /*
@@ -1765,27 +1760,17 @@ perf_event_groups_first(struct perf_event_groups *groups, int cpu,
 static struct perf_event *
 perf_event_groups_next(struct perf_event *event)
 {
-	struct perf_event *next;
-#ifdef CONFIG_CGROUP_PERF
-	u64 curr_cgrp_id = 0;
-	u64 next_cgrp_id = 0;
-#endif
-
-	next = rb_entry_safe(rb_next(&event->group_node), typeof(*event), group_node);
-	if (next == NULL || next->cpu != event->cpu)
-		return NULL;
-
-#ifdef CONFIG_CGROUP_PERF
-	if (event->cgrp && event->cgrp->css.cgroup)
-		curr_cgrp_id = event->cgrp->css.cgroup->kn->id;
+	struct __group_key key = {
+		.cpu = event->cpu,
+		.cgroup = event_cgroup(event),
+	};
+	struct rb_node *next;
 
-	if (next->cgrp && next->cgrp->css.cgroup)
-		next_cgrp_id = next->cgrp->css.cgroup->kn->id;
+	next = rb_next_match(&key, &event->group_node, __group_cmp);
+	if (next)
+		return __node_2_pe(next);
 
-	if (curr_cgrp_id != next_cgrp_id)
-		return NULL;
-#endif
-	return next;
+	return NULL;
 }
 
 /*
