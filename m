Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C789431DA37
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhBQNTv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhBQNTC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:19:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE085C0617AB;
        Wed, 17 Feb 2021 05:17:39 -0800 (PST)
Date:   Wed, 17 Feb 2021 13:17:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ep0/fEEv+0SuSo3EUORfFUJeyfp6RHWuXX2iz5jBIH0=;
        b=2Urc0DrkPp0BielVCUoXbqe26FjyjXEWOBzuv+eElqVTt6TtEkRvOgWHbBO0Y/pJewzDD9
        ymOvME02hvV5+9gi3D9Hrq1hip5ZmLq/en6SGZVLLWBrpzub2uirxQl+1PVT0x79mbYsbj
        kYm1d/YOoXtCTNoXRGCzSrt/4dTI7yfDsHPFx1k7AgYQeRMd3ot2s4LAXyzaw0R4a/RZOb
        u3qIvc+Qz2HPYNG/hCZcpWXWck6fw3gTI6frcFJoT/WeZx5vg8YZz3Y+PqUyihNDBPPxRW
        qyc2jxJ/HjatdZ02p1bwlG9rb4FqNRlxO0PPSjL+ZZw+qaAAKEJ/ia86SHMpsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ep0/fEEv+0SuSo3EUORfFUJeyfp6RHWuXX2iz5jBIH0=;
        b=y3hFkRNm30mIcP5xqeEl+KULMtnsrPD8eOKPA2K3XlJTlll99ovUqGUg2yfAcZN9mX9rpo
        fMK8y8xKKYZFOwDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rbtree, uprobes: Use rbtree helpers
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161356785754.20312.10402032931275465475.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a905e84e64083a0ee701f61810badee234050825
Gitweb:        https://git.kernel.org/tip/a905e84e64083a0ee701f61810badee234050825
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 29 Apr 2020 17:06:27 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:07:52 +01:00

rbtree, uprobes: Use rbtree helpers

Reduce rbtree boilerplate by using the new helpers.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/events/uprobes.c | 80 +++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 41 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index bf9edd8..fd5160d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -613,41 +613,56 @@ static void put_uprobe(struct uprobe *uprobe)
 	}
 }
 
-static int match_uprobe(struct uprobe *l, struct uprobe *r)
+static __always_inline
+int uprobe_cmp(const struct inode *l_inode, const loff_t l_offset,
+	       const struct uprobe *r)
 {
-	if (l->inode < r->inode)
+	if (l_inode < r->inode)
 		return -1;
 
-	if (l->inode > r->inode)
+	if (l_inode > r->inode)
 		return 1;
 
-	if (l->offset < r->offset)
+	if (l_offset < r->offset)
 		return -1;
 
-	if (l->offset > r->offset)
+	if (l_offset > r->offset)
 		return 1;
 
 	return 0;
 }
 
+#define __node_2_uprobe(node) \
+	rb_entry((node), struct uprobe, rb_node)
+
+struct __uprobe_key {
+	struct inode *inode;
+	loff_t offset;
+};
+
+static inline int __uprobe_cmp_key(const void *key, const struct rb_node *b)
+{
+	const struct __uprobe_key *a = key;
+	return uprobe_cmp(a->inode, a->offset, __node_2_uprobe(b));
+}
+
+static inline int __uprobe_cmp(struct rb_node *a, const struct rb_node *b)
+{
+	struct uprobe *u = __node_2_uprobe(a);
+	return uprobe_cmp(u->inode, u->offset, __node_2_uprobe(b));
+}
+
 static struct uprobe *__find_uprobe(struct inode *inode, loff_t offset)
 {
-	struct uprobe u = { .inode = inode, .offset = offset };
-	struct rb_node *n = uprobes_tree.rb_node;
-	struct uprobe *uprobe;
-	int match;
+	struct __uprobe_key key = {
+		.inode = inode,
+		.offset = offset,
+	};
+	struct rb_node *node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
 
-	while (n) {
-		uprobe = rb_entry(n, struct uprobe, rb_node);
-		match = match_uprobe(&u, uprobe);
-		if (!match)
-			return get_uprobe(uprobe);
+	if (node)
+		return __node_2_uprobe(node);
 
-		if (match < 0)
-			n = n->rb_left;
-		else
-			n = n->rb_right;
-	}
 	return NULL;
 }
 
@@ -668,32 +683,15 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
 
 static struct uprobe *__insert_uprobe(struct uprobe *uprobe)
 {
-	struct rb_node **p = &uprobes_tree.rb_node;
-	struct rb_node *parent = NULL;
-	struct uprobe *u;
-	int match;
+	struct rb_node *node;
 
-	while (*p) {
-		parent = *p;
-		u = rb_entry(parent, struct uprobe, rb_node);
-		match = match_uprobe(uprobe, u);
-		if (!match)
-			return get_uprobe(u);
+	node = rb_find_add(&uprobe->rb_node, &uprobes_tree, __uprobe_cmp);
+	if (node)
+		return get_uprobe(__node_2_uprobe(node));
 
-		if (match < 0)
-			p = &parent->rb_left;
-		else
-			p = &parent->rb_right;
-
-	}
-
-	u = NULL;
-	rb_link_node(&uprobe->rb_node, parent, p);
-	rb_insert_color(&uprobe->rb_node, &uprobes_tree);
 	/* get access + creation ref */
 	refcount_set(&uprobe->ref, 2);
-
-	return u;
+	return NULL;
 }
 
 /*
