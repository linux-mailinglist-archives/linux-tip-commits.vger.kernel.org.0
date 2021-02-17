Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB6A31DA2C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhBQNTL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:19:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45336 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbhBQNSX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:23 -0500
Date:   Wed, 17 Feb 2021 13:17:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TmPvPzeDIJHSnmklP7bvMkLX/nCDvLZW6VFfYT/XK4Y=;
        b=0y+nVTW8zbQCkZntN02SeYGYhhA9rJUfYvKD0IVBLO7ogbMvvsmimrxvVWUlLgG9eTVJEg
        AFsbT1mgwV/pPe3Q2MaJOSQKP403fE9HqlFcZ0LSCgb0wW9ItOJb++AsStoayTZegz18wn
        5c8fKYGknEmA2b8PuVRXwfMItIH2EINd7p+n3ZvZxOqlffoAl+j0+WGJg3SR7VaxoOERM3
        yjjRBzec6iUiE5YhuJeKa+63JiB/+IWYxf4aITw3jLCq8qXaU+0xs6W5WHHdjkAh/Puvkx
        yMoPRFpxdCzU8E6+KoLqMRoAN+QR+LVePHqLXHH8yz/lsKJ93mYTUExPt7uysQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TmPvPzeDIJHSnmklP7bvMkLX/nCDvLZW6VFfYT/XK4Y=;
        b=8S7jpp0oTfhFuPPEQcUWXL6nHWIPNWshpGAKKFSITQQxjOAI7SF56C+gf4624166GpbV3k
        L1CegX1vz17zwRDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rbtree: Add generic add and find helpers
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161356785868.20312.16705119540462191828.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2d24dd5798d0474d9bf705bfca8725e7d20f9d54
Gitweb:        https://git.kernel.org/tip/2d24dd5798d0474d9bf705bfca8725e7d20f9d54
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 29 Apr 2020 17:03:22 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:07:31 +01:00

rbtree: Add generic add and find helpers

I've always been bothered by the endless (fragile) boilerplate for
rbtree, and I recently wrote some rbtree helpers for objtool and
figured I should lift them into the kernel and use them more widely.

Provide:

partial-order; less() based:
 - rb_add(): add a new entry to the rbtree
 - rb_add_cached(): like rb_add(), but for a rb_root_cached

total-order; cmp() based:
 - rb_find(): find an entry in an rbtree
 - rb_find_add(): find an entry, and add if not found

 - rb_find_first(): find the first (leftmost) matching entry
 - rb_next_match(): continue from rb_find_first()
 - rb_for_each(): iterate a sub-tree using the previous two

Inlining and constant propagation should see the compiler inline the
whole thing, including the various compare functions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Michel Lespinasse <walken@google.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/rbtree.h       | 190 ++++++++++++++++++++++++++++++++++-
 tools/include/linux/rbtree.h | 192 +++++++++++++++++++++++++++++++++-
 tools/objtool/elf.c          |  73 +------------
 3 files changed, 392 insertions(+), 63 deletions(-)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index d7db179..e0b300d 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -158,4 +158,194 @@ static inline void rb_replace_node_cached(struct rb_node *victim,
 	rb_replace_node(victim, new, &root->rb_root);
 }
 
+/*
+ * The below helper functions use 2 operators with 3 different
+ * calling conventions. The operators are related like:
+ *
+ *	comp(a->key,b) < 0  := less(a,b)
+ *	comp(a->key,b) > 0  := less(b,a)
+ *	comp(a->key,b) == 0 := !less(a,b) && !less(b,a)
+ *
+ * If these operators define a partial order on the elements we make no
+ * guarantee on which of the elements matching the key is found. See
+ * rb_find().
+ *
+ * The reason for this is to allow the find() interface without requiring an
+ * on-stack dummy object, which might not be feasible due to object size.
+ */
+
+/**
+ * rb_add_cached() - insert @node into the leftmost cached tree @tree
+ * @node: node to insert
+ * @tree: leftmost cached tree to insert @node into
+ * @less: operator defining the (partial) node order
+ */
+static __always_inline void
+rb_add_cached(struct rb_node *node, struct rb_root_cached *tree,
+	      bool (*less)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	bool leftmost = true;
+
+	while (*link) {
+		parent = *link;
+		if (less(node, parent)) {
+			link = &parent->rb_left;
+		} else {
+			link = &parent->rb_right;
+			leftmost = false;
+		}
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color_cached(node, tree, leftmost);
+}
+
+/**
+ * rb_add() - insert @node into @tree
+ * @node: node to insert
+ * @tree: tree to insert @node into
+ * @less: operator defining the (partial) node order
+ */
+static __always_inline void
+rb_add(struct rb_node *node, struct rb_root *tree,
+       bool (*less)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+
+	while (*link) {
+		parent = *link;
+		if (less(node, parent))
+			link = &parent->rb_left;
+		else
+			link = &parent->rb_right;
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color(node, tree);
+}
+
+/**
+ * rb_find_add() - find equivalent @node in @tree, or add @node
+ * @node: node to look-for / insert
+ * @tree: tree to search / modify
+ * @cmp: operator defining the node order
+ *
+ * Returns the rb_node matching @node, or NULL when no match is found and @node
+ * is inserted.
+ */
+static __always_inline struct rb_node *
+rb_find_add(struct rb_node *node, struct rb_root *tree,
+	    int (*cmp)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+	int c;
+
+	while (*link) {
+		parent = *link;
+		c = cmp(node, parent);
+
+		if (c < 0)
+			link = &parent->rb_left;
+		else if (c > 0)
+			link = &parent->rb_right;
+		else
+			return parent;
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color(node, tree);
+	return NULL;
+}
+
+/**
+ * rb_find() - find @key in tree @tree
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining the node order
+ *
+ * Returns the rb_node matching @key or NULL.
+ */
+static __always_inline struct rb_node *
+rb_find(const void *key, const struct rb_root *tree,
+	int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+
+	while (node) {
+		int c = cmp(key, node);
+
+		if (c < 0)
+			node = node->rb_left;
+		else if (c > 0)
+			node = node->rb_right;
+		else
+			return node;
+	}
+
+	return NULL;
+}
+
+/**
+ * rb_find_first() - find the first @key in @tree
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining node order
+ *
+ * Returns the leftmost node matching @key, or NULL.
+ */
+static __always_inline struct rb_node *
+rb_find_first(const void *key, const struct rb_root *tree,
+	      int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+	struct rb_node *match = NULL;
+
+	while (node) {
+		int c = cmp(key, node);
+
+		if (c <= 0) {
+			if (!c)
+				match = node;
+			node = node->rb_left;
+		} else if (c > 0) {
+			node = node->rb_right;
+		}
+	}
+
+	return match;
+}
+
+/**
+ * rb_next_match() - find the next @key in @tree
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining node order
+ *
+ * Returns the next node matching @key, or NULL.
+ */
+static __always_inline struct rb_node *
+rb_next_match(const void *key, struct rb_node *node,
+	      int (*cmp)(const void *key, const struct rb_node *))
+{
+	node = rb_next(node);
+	if (node && cmp(key, node))
+		node = NULL;
+	return node;
+}
+
+/**
+ * rb_for_each() - iterates a subtree matching @key
+ * @node: iterator
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining node order
+ */
+#define rb_for_each(node, key, tree, cmp) \
+	for ((node) = rb_find_first((key), (tree), (cmp)); \
+	     (node); (node) = rb_next_match((key), (node), (cmp)))
+
 #endif	/* _LINUX_RBTREE_H */
diff --git a/tools/include/linux/rbtree.h b/tools/include/linux/rbtree.h
index 30dd21f..2680f2e 100644
--- a/tools/include/linux/rbtree.h
+++ b/tools/include/linux/rbtree.h
@@ -152,4 +152,194 @@ static inline void rb_replace_node_cached(struct rb_node *victim,
 	rb_replace_node(victim, new, &root->rb_root);
 }
 
-#endif /* __TOOLS_LINUX_PERF_RBTREE_H */
+/*
+ * The below helper functions use 2 operators with 3 different
+ * calling conventions. The operators are related like:
+ *
+ *	comp(a->key,b) < 0  := less(a,b)
+ *	comp(a->key,b) > 0  := less(b,a)
+ *	comp(a->key,b) == 0 := !less(a,b) && !less(b,a)
+ *
+ * If these operators define a partial order on the elements we make no
+ * guarantee on which of the elements matching the key is found. See
+ * rb_find().
+ *
+ * The reason for this is to allow the find() interface without requiring an
+ * on-stack dummy object, which might not be feasible due to object size.
+ */
+
+/**
+ * rb_add_cached() - insert @node into the leftmost cached tree @tree
+ * @node: node to insert
+ * @tree: leftmost cached tree to insert @node into
+ * @less: operator defining the (partial) node order
+ */
+static __always_inline void
+rb_add_cached(struct rb_node *node, struct rb_root_cached *tree,
+	      bool (*less)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	bool leftmost = true;
+
+	while (*link) {
+		parent = *link;
+		if (less(node, parent)) {
+			link = &parent->rb_left;
+		} else {
+			link = &parent->rb_right;
+			leftmost = false;
+		}
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color_cached(node, tree, leftmost);
+}
+
+/**
+ * rb_add() - insert @node into @tree
+ * @node: node to insert
+ * @tree: tree to insert @node into
+ * @less: operator defining the (partial) node order
+ */
+static __always_inline void
+rb_add(struct rb_node *node, struct rb_root *tree,
+       bool (*less)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+
+	while (*link) {
+		parent = *link;
+		if (less(node, parent))
+			link = &parent->rb_left;
+		else
+			link = &parent->rb_right;
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color(node, tree);
+}
+
+/**
+ * rb_find_add() - find equivalent @node in @tree, or add @node
+ * @node: node to look-for / insert
+ * @tree: tree to search / modify
+ * @cmp: operator defining the node order
+ *
+ * Returns the rb_node matching @node, or NULL when no match is found and @node
+ * is inserted.
+ */
+static __always_inline struct rb_node *
+rb_find_add(struct rb_node *node, struct rb_root *tree,
+	    int (*cmp)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+	int c;
+
+	while (*link) {
+		parent = *link;
+		c = cmp(node, parent);
+
+		if (c < 0)
+			link = &parent->rb_left;
+		else if (c > 0)
+			link = &parent->rb_right;
+		else
+			return parent;
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color(node, tree);
+	return NULL;
+}
+
+/**
+ * rb_find() - find @key in tree @tree
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining the node order
+ *
+ * Returns the rb_node matching @key or NULL.
+ */
+static __always_inline struct rb_node *
+rb_find(const void *key, const struct rb_root *tree,
+	int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+
+	while (node) {
+		int c = cmp(key, node);
+
+		if (c < 0)
+			node = node->rb_left;
+		else if (c > 0)
+			node = node->rb_right;
+		else
+			return node;
+	}
+
+	return NULL;
+}
+
+/**
+ * rb_find_first() - find the first @key in @tree
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining node order
+ *
+ * Returns the leftmost node matching @key, or NULL.
+ */
+static __always_inline struct rb_node *
+rb_find_first(const void *key, const struct rb_root *tree,
+	      int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+	struct rb_node *match = NULL;
+
+	while (node) {
+		int c = cmp(key, node);
+
+		if (c <= 0) {
+			if (!c)
+				match = node;
+			node = node->rb_left;
+		} else if (c > 0) {
+			node = node->rb_right;
+		}
+	}
+
+	return match;
+}
+
+/**
+ * rb_next_match() - find the next @key in @tree
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining node order
+ *
+ * Returns the next node matching @key, or NULL.
+ */
+static __always_inline struct rb_node *
+rb_next_match(const void *key, struct rb_node *node,
+	      int (*cmp)(const void *key, const struct rb_node *))
+{
+	node = rb_next(node);
+	if (node && cmp(key, node))
+		node = NULL;
+	return node;
+}
+
+/**
+ * rb_for_each() - iterates a subtree matching @key
+ * @node: iterator
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining node order
+ */
+#define rb_for_each(node, key, tree, cmp) \
+	for ((node) = rb_find_first((key), (tree), (cmp)); \
+	     (node); (node) = rb_next_match((key), (node), (cmp)))
+
+#endif	/* __TOOLS_LINUX_PERF_RBTREE_H */
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d8421e1..e85988c 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -43,75 +43,24 @@ static void elf_hash_init(struct hlist_head *table)
 #define elf_hash_for_each_possible(name, obj, member, key)			\
 	hlist_for_each_entry(obj, &name[hash_min(key, elf_hash_bits())], member)
 
-static void rb_add(struct rb_root *tree, struct rb_node *node,
-		   int (*cmp)(struct rb_node *, const struct rb_node *))
-{
-	struct rb_node **link = &tree->rb_node;
-	struct rb_node *parent = NULL;
-
-	while (*link) {
-		parent = *link;
-		if (cmp(node, parent) < 0)
-			link = &parent->rb_left;
-		else
-			link = &parent->rb_right;
-	}
-
-	rb_link_node(node, parent, link);
-	rb_insert_color(node, tree);
-}
-
-static struct rb_node *rb_find_first(const struct rb_root *tree, const void *key,
-			       int (*cmp)(const void *key, const struct rb_node *))
-{
-	struct rb_node *node = tree->rb_node;
-	struct rb_node *match = NULL;
-
-	while (node) {
-		int c = cmp(key, node);
-		if (c <= 0) {
-			if (!c)
-				match = node;
-			node = node->rb_left;
-		} else if (c > 0) {
-			node = node->rb_right;
-		}
-	}
-
-	return match;
-}
-
-static struct rb_node *rb_next_match(struct rb_node *node, const void *key,
-				    int (*cmp)(const void *key, const struct rb_node *))
-{
-	node = rb_next(node);
-	if (node && cmp(key, node))
-		node = NULL;
-	return node;
-}
-
-#define rb_for_each(tree, node, key, cmp) \
-	for ((node) = rb_find_first((tree), (key), (cmp)); \
-	     (node); (node) = rb_next_match((node), (key), (cmp)))
-
-static int symbol_to_offset(struct rb_node *a, const struct rb_node *b)
+static bool symbol_to_offset(struct rb_node *a, const struct rb_node *b)
 {
 	struct symbol *sa = rb_entry(a, struct symbol, node);
 	struct symbol *sb = rb_entry(b, struct symbol, node);
 
 	if (sa->offset < sb->offset)
-		return -1;
+		return true;
 	if (sa->offset > sb->offset)
-		return 1;
+		return false;
 
 	if (sa->len < sb->len)
-		return -1;
+		return true;
 	if (sa->len > sb->len)
-		return 1;
+		return false;
 
 	sa->alias = sb;
 
-	return 0;
+	return false;
 }
 
 static int symbol_by_offset(const void *key, const struct rb_node *node)
@@ -165,7 +114,7 @@ struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
 {
 	struct rb_node *node;
 
-	rb_for_each(&sec->symbol_tree, node, &offset, symbol_by_offset) {
+	rb_for_each(node, &offset, &sec->symbol_tree, symbol_by_offset) {
 		struct symbol *s = rb_entry(node, struct symbol, node);
 
 		if (s->offset == offset && s->type != STT_SECTION)
@@ -179,7 +128,7 @@ struct symbol *find_func_by_offset(struct section *sec, unsigned long offset)
 {
 	struct rb_node *node;
 
-	rb_for_each(&sec->symbol_tree, node, &offset, symbol_by_offset) {
+	rb_for_each(node, &offset, &sec->symbol_tree, symbol_by_offset) {
 		struct symbol *s = rb_entry(node, struct symbol, node);
 
 		if (s->offset == offset && s->type == STT_FUNC)
@@ -193,7 +142,7 @@ struct symbol *find_symbol_containing(const struct section *sec, unsigned long o
 {
 	struct rb_node *node;
 
-	rb_for_each(&sec->symbol_tree, node, &offset, symbol_by_offset) {
+	rb_for_each(node, &offset, &sec->symbol_tree, symbol_by_offset) {
 		struct symbol *s = rb_entry(node, struct symbol, node);
 
 		if (s->type != STT_SECTION)
@@ -207,7 +156,7 @@ struct symbol *find_func_containing(struct section *sec, unsigned long offset)
 {
 	struct rb_node *node;
 
-	rb_for_each(&sec->symbol_tree, node, &offset, symbol_by_offset) {
+	rb_for_each(node, &offset, &sec->symbol_tree, symbol_by_offset) {
 		struct symbol *s = rb_entry(node, struct symbol, node);
 
 		if (s->type == STT_FUNC)
@@ -442,7 +391,7 @@ static int read_symbols(struct elf *elf)
 		sym->offset = sym->sym.st_value;
 		sym->len = sym->sym.st_size;
 
-		rb_add(&sym->sec->symbol_tree, &sym->node, symbol_to_offset);
+		rb_add(&sym->node, &sym->sec->symbol_tree, symbol_to_offset);
 		pnode = rb_prev(&sym->node);
 		if (pnode)
 			entry = &rb_entry(pnode, struct symbol, node)->list;
