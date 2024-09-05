Return-Path: <linux-tip-commits+bounces-2176-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFF496DD2B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 17:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9251D1C2301A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2864619CCEC;
	Thu,  5 Sep 2024 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QZjVTEvM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e4jtAKgi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C3FC8FE;
	Thu,  5 Sep 2024 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548608; cv=none; b=icWV0byv1tODpK9MVfikwSdhN353Bw9SW4v1CbajwSEGySrREc//IbN7dbPw5gjifuaHZQ6gBTcrjIhyby7WTjgBIcEWW6PANdPlxQ1bumPjoOZa+4l/nJI9EzMT38qhi/iMe/qXFWTTiJAcZr63RRwBu1olpS1pWq/rmM/GjDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548608; c=relaxed/simple;
	bh=FdD2pS0jz7n0VhbbsIp93+03le20NnyRkdccNrhKOwY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LX7/7Wpmy2ESYJIRm8XrV/vFQe9a0jHAV5rl/02aMoKeGULHhhwVL25nao4ndGbgWHuZHWxF6JTXDg+p4LnBQcYY322HsXd4ppjT50ECGb8hB0/vUBN+jdOlw6HCMnw2q6Pw3vOIeNFPE6RZbMjN6+YPKABfBkkLyoaPgqwI/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QZjVTEvM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e4jtAKgi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Sep 2024 15:03:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725548604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OgyDtjXsLzGDiczrMtoTx1MlyILOl84s11YhTIJnDRo=;
	b=QZjVTEvMtFCNDraDNKllg+4KNEGYnLIKqfcNjPCfCEmDxlJZ8SyAS3UlggrqM0CKADr3eE
	XbMV2ttItCnqMzOohISq/VcmuI5avZm46JYoFpjz+lyE1vTZVCRx9wvQpfHt6sZ7iBtzGr
	26aTTQZ6+yNzZm0qQsbkTgXfQ4ohIvps31cw/2SlmFU6OUA1poEpomtWANBtc9gY3ybU2g
	v8KtTr2Utb0JC9BsHqoY1KPGRsCu3HMa03ecZYPvMwP6vH5mr8k37Bm6p2emFi3uCvzyIh
	oO547YfZG2qsaH9SXZwhvm1p2qvFk0U0DTwITd6NzKIppn3/d8Bywyt3ld7xoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725548604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OgyDtjXsLzGDiczrMtoTx1MlyILOl84s11YhTIJnDRo=;
	b=e4jtAKgi96T8RWjxeyJQ/WE2XKByS3N6JSPuCZb4/Kbt9gfSxkCbPI6AR+sjCZ7prj9DLL
	PGkykMcFU0nJeYCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] rbtree: provide rb_find_rcu() / rb_find_add_rcu()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240903174603.3554182-7-andrii@kernel.org>
References: <20240903174603.3554182-7-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172554860447.2215.4987009061801937984.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     50a38035ed5ccc2ab8a28eaf70c3c7a87e060345
Gitweb:        https://git.kernel.org/tip/50a38035ed5ccc2ab8a28eaf70c3c7a87e060345
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 03 Sep 2024 10:46:01 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Sep 2024 16:56:15 +02:00

rbtree: provide rb_find_rcu() / rb_find_add_rcu()

Much like latch_tree, add two RCU methods for the regular RB-tree,
which can be used in conjunction with a seqcount to provide lockless
lookups.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20240903174603.3554182-7-andrii@kernel.org
---
 include/linux/rbtree.h | 67 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index f7edca3..7c173aa 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -245,6 +245,42 @@ rb_find_add(struct rb_node *node, struct rb_root *tree,
 }
 
 /**
+ * rb_find_add_rcu() - find equivalent @node in @tree, or add @node
+ * @node: node to look-for / insert
+ * @tree: tree to search / modify
+ * @cmp: operator defining the node order
+ *
+ * Adds a Store-Release for link_node.
+ *
+ * Returns the rb_node matching @node, or NULL when no match is found and @node
+ * is inserted.
+ */
+static __always_inline struct rb_node *
+rb_find_add_rcu(struct rb_node *node, struct rb_root *tree,
+		int (*cmp)(struct rb_node *, const struct rb_node *))
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
+	rb_link_node_rcu(node, parent, link);
+	rb_insert_color(node, tree);
+	return NULL;
+}
+
+/**
  * rb_find() - find @key in tree @tree
  * @key: key to match
  * @tree: tree to search
@@ -273,6 +309,37 @@ rb_find(const void *key, const struct rb_root *tree,
 }
 
 /**
+ * rb_find_rcu() - find @key in tree @tree
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining the node order
+ *
+ * Notably, tree descent vs concurrent tree rotations is unsound and can result
+ * in false-negatives.
+ *
+ * Returns the rb_node matching @key or NULL.
+ */
+static __always_inline struct rb_node *
+rb_find_rcu(const void *key, const struct rb_root *tree,
+	    int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+
+	while (node) {
+		int c = cmp(key, node);
+
+		if (c < 0)
+			node = rcu_dereference_raw(node->rb_left);
+		else if (c > 0)
+			node = rcu_dereference_raw(node->rb_right);
+		else
+			return node;
+	}
+
+	return NULL;
+}
+
+/**
  * rb_find_first() - find the first @key in @tree
  * @key: key to match
  * @tree: tree to search

