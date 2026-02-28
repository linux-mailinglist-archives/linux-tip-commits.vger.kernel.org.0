Return-Path: <linux-tip-commits+bounces-8291-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAn/KX4Lo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8291-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:36:30 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6CF1C3FE7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA6F93083DD9
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D365F3EBF05;
	Sat, 28 Feb 2026 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qkBM8w6b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lAFOOO5o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F556280CF6;
	Sat, 28 Feb 2026 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292980; cv=none; b=RqDYEwGVzEU5rjm/WVzkjJI9wCgd7Kufv0cOTeScpltKJ7zYDiMxIJZ70QvnNlDyQLXWj5kytHe9Fj2967M5jY3ivs9KH0vbcN3j3xlKHFCBs1nPAgtsGzMRnslA4XqKQ5SHXKhkJEI3yXSofFdBajEUuC1tV7QS2dqLmjVWfHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292980; c=relaxed/simple;
	bh=JlvpEjWeEcwz2TYoY/1Krb08NnAbYnR86IXn06B4X6k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rBy0iyi7k+phoOAbs6YPD4rKPJ2X0+/h9Cr+FsI/NHiIyiBLy9iHpDXteph116PTcBXM2Z0mvgNYvJVf2adJLfgndV4xeUuQzP47ArGuMFL6mwumVijC8WAXgs5IhppuPgLIU7e2izJSchui7cZFASFKj8AocOiT1XPH83OAqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qkBM8w6b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lAFOOO5o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292977;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODgH+KmCA1peNG+K1Gqh5NT8tawSwrdw760nONqCBEA=;
	b=qkBM8w6bArAdIIUdb9HwOY2+8rvSy5V+CG/fuW4RYkAERgt0qMMDI3evo+ER2V9wpIGWWK
	hZt1yWqTYeknQFQIJY3uC9rwibRWdWeIneOfI5COv3L/JNX6L1YU8Pitazawx8ZGqf8BtJ
	HtzADPyww2mpV+8XmF2cdgeI3YJ/7ALi/5j+NPCfB5AEOC/flfIlpEcAaTBkfUAHb+ZguM
	yBA2MzW4f5tTtH/qZglmtDKZ66V+exWsWHBY+k4Ek5EjLPcoPYj8/tgeYRVHYrksvm+4x0
	jLslK9g9sAovrvFT+LIIeLzg2Z/MWtdio8ikTfTVnlDmpunFMyM9qA8QFq08Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292977;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODgH+KmCA1peNG+K1Gqh5NT8tawSwrdw760nONqCBEA=;
	b=lAFOOO5oVcAUzWGliBG1sHJLbgfD4nhU2aFPlSO6p5LJnD6LE1T2lo2nhIf68NTGqRtaZf
	+0y9BjeuPdGS6rAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] rbtree: Provide rbtree with links
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163431.668401024@kernel.org>
References: <20260224163431.668401024@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229297622.1647592.4743833943757174789.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8291-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,infradead.org:email];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 5B6CF1C3FE7
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     671047943dce5af24e023bca3c5cc244d7565f5a
Gitweb:        https://git.kernel.org/tip/671047943dce5af24e023bca3c5cc244d75=
65f5a
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:38:47 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:16 +01:00

rbtree: Provide rbtree with links

Some RB tree users require quick access to the next and the previous node,
e.g. to check whether a modification of the node results in a change of the
nodes position in the tree. If the node position does not change, then the
modification can happen in place without going through a full enqueue
requeue cycle. A upcoming use case for this are the timer queues of the
hrtimer subsystem as they can optimize for timers which are frequently
rearmed while enqueued.

This can be obviously achieved with rb_next() and rb_prev(), but those
turned out to be quite expensive for hotpath operations depending on the
tree depth.

Add a linked RB tree variant where add() and erase() maintain the links
between the nodes. Like the cached variant it provides a pointer to the
left most node in the root.

It intentionally does not use a [h]list head as there is no real need for
true list operations as the list is strictly coupled to the tree and
and cannot be manipulated independently.

It sets the nodes previous pointer to NULL for the left most node and the
next pointer to NULL for the right most node. This allows a quick check
especially for the left most node without consulting the list head address,
which creates better code.

Aside of the rb_leftmost cached pointer this could trivially provide a
rb_rightmost pointer as well, but there is no usage for that (yet).

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163431.668401024@kernel.org
---
 include/linux/rbtree.h       | 81 +++++++++++++++++++++++++++++++----
 include/linux/rbtree_types.h | 16 +++++++-
 lib/rbtree.c                 | 17 +++++++-
 3 files changed, 105 insertions(+), 9 deletions(-)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 4091e97..48acdc3 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -35,10 +35,15 @@
 #define RB_CLEAR_NODE(node)  \
 	((node)->__rb_parent_color =3D (unsigned long)(node))
=20
+#define RB_EMPTY_LINKED_NODE(lnode)  RB_EMPTY_NODE(&(lnode)->node)
+#define RB_CLEAR_LINKED_NODE(lnode)  ({					\
+	RB_CLEAR_NODE(&(lnode)->node);					\
+	(lnode)->prev =3D (lnode)->next =3D NULL;				\
+})
=20
 extern void rb_insert_color(struct rb_node *, struct rb_root *);
 extern void rb_erase(struct rb_node *, struct rb_root *);
-
+extern bool rb_erase_linked(struct rb_node_linked *, struct rb_root_linked *=
);
=20
 /* Find logical next and previous nodes in a tree */
 extern struct rb_node *rb_next(const struct rb_node *);
@@ -213,15 +218,10 @@ rb_add_cached(struct rb_node *node, struct rb_root_cach=
ed *tree,
 	return leftmost ? node : NULL;
 }
=20
-/**
- * rb_add() - insert @node into @tree
- * @node: node to insert
- * @tree: tree to insert @node into
- * @less: operator defining the (partial) node order
- */
 static __always_inline void
-rb_add(struct rb_node *node, struct rb_root *tree,
-       bool (*less)(struct rb_node *, const struct rb_node *))
+__rb_add(struct rb_node *node, struct rb_root *tree,
+	 bool (*less)(struct rb_node *, const struct rb_node *),
+	 void (*linkop)(struct rb_node *, struct rb_node *, struct rb_node **))
 {
 	struct rb_node **link =3D &tree->rb_node;
 	struct rb_node *parent =3D NULL;
@@ -234,10 +234,73 @@ rb_add(struct rb_node *node, struct rb_root *tree,
 			link =3D &parent->rb_right;
 	}
=20
+	linkop(node, parent, link);
 	rb_link_node(node, parent, link);
 	rb_insert_color(node, tree);
 }
=20
+#define __node_2_linked_node(_n) \
+	rb_entry((_n), struct rb_node_linked, node)
+
+static inline void
+rb_link_linked_node(struct rb_node *node, struct rb_node *parent, struct rb_=
node **link)
+{
+	if (!parent)
+		return;
+
+	struct rb_node_linked *nnew =3D __node_2_linked_node(node);
+	struct rb_node_linked *npar =3D __node_2_linked_node(parent);
+
+	if (link =3D=3D &parent->rb_left) {
+		nnew->prev =3D npar->prev;
+		nnew->next =3D npar;
+		npar->prev =3D nnew;
+		if (nnew->prev)
+			nnew->prev->next =3D nnew;
+	} else {
+		nnew->next =3D npar->next;
+		nnew->prev =3D npar;
+		npar->next =3D nnew;
+		if (nnew->next)
+			nnew->next->prev =3D nnew;
+	}
+}
+
+/**
+ * rb_add_linked() - insert @node into the leftmost linked tree @tree
+ * @node: node to insert
+ * @tree: linked tree to insert @node into
+ * @less: operator defining the (partial) node order
+ *
+ * Returns @true when @node is the new leftmost, @false otherwise.
+ */
+static __always_inline bool
+rb_add_linked(struct rb_node_linked *node, struct rb_root_linked *tree,
+	      bool (*less)(struct rb_node *, const struct rb_node *))
+{
+	__rb_add(&node->node, &tree->rb_root, less, rb_link_linked_node);
+	if (!node->prev)
+		tree->rb_leftmost =3D node;
+	return !node->prev;
+}
+
+/* Empty linkop function which is optimized away by the compiler */
+static __always_inline void
+rb_link_noop(struct rb_node *n, struct rb_node *p, struct rb_node **l) { }
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
+	__rb_add(node, tree, less, rb_link_noop);
+}
+
 /**
  * rb_find_add_cached() - find equivalent @node in @tree, or add @node
  * @node: node to look-for / insert
diff --git a/include/linux/rbtree_types.h b/include/linux/rbtree_types.h
index 45b6ecd..3c7ae53 100644
--- a/include/linux/rbtree_types.h
+++ b/include/linux/rbtree_types.h
@@ -9,6 +9,12 @@ struct rb_node {
 } __attribute__((aligned(sizeof(long))));
 /* The alignment might seem pointless, but allegedly CRIS needs it */
=20
+struct rb_node_linked {
+	struct rb_node		node;
+	struct rb_node_linked	*prev;
+	struct rb_node_linked	*next;
+};
+
 struct rb_root {
 	struct rb_node *rb_node;
 };
@@ -28,7 +34,17 @@ struct rb_root_cached {
 	struct rb_node *rb_leftmost;
 };
=20
+/*
+ * Leftmost tree with links. This would allow a trivial rb_rightmost update,
+ * but that has been omitted due to the lack of users.
+ */
+struct rb_root_linked {
+	struct rb_root		rb_root;
+	struct rb_node_linked	*rb_leftmost;
+};
+
 #define RB_ROOT (struct rb_root) { NULL, }
 #define RB_ROOT_CACHED (struct rb_root_cached) { {NULL, }, NULL }
+#define RB_ROOT_LINKED (struct rb_root_linked) { {NULL, }, NULL }
=20
 #endif
diff --git a/lib/rbtree.c b/lib/rbtree.c
index 18d42bc..5790d6e 100644
--- a/lib/rbtree.c
+++ b/lib/rbtree.c
@@ -446,6 +446,23 @@ void rb_erase(struct rb_node *node, struct rb_root *root)
 }
 EXPORT_SYMBOL(rb_erase);
=20
+bool rb_erase_linked(struct rb_node_linked *node, struct rb_root_linked *roo=
t)
+{
+	if (node->prev)
+		node->prev->next =3D node->next;
+	else
+		root->rb_leftmost =3D node->next;
+
+	if (node->next)
+		node->next->prev =3D node->prev;
+
+	rb_erase(&node->node, &root->rb_root);
+	RB_CLEAR_LINKED_NODE(node);
+
+	return !!root->rb_leftmost;
+}
+EXPORT_SYMBOL_GPL(rb_erase_linked);
+
 /*
  * Augmented rbtree manipulation functions.
  *

