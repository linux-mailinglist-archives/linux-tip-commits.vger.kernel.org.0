Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB50104A84
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Nov 2019 07:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfKUGDf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Nov 2019 01:03:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59720 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfKUGDe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Nov 2019 01:03:34 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXfYg-0004QY-7C; Thu, 21 Nov 2019 07:03:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D28CF1C1A33;
        Thu, 21 Nov 2019 07:03:13 +0100 (CET)
Date:   Thu, 21 Nov 2019 06:03:13 -0000
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Convert the PAT tree to a generic interval tree
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>, dave@stgolabs.net,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191021231924.25373-2-dave@stgolabs.net>
References: <20191021231924.25373-2-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <157431619377.21853.9126757707947424006.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     218bf1a8c73b9dcc2f85df9919578050359aa6ef
Gitweb:        https://git.kernel.org/tip/218bf1a8c73b9dcc2f85df9919578050359aa6ef
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Mon, 21 Oct 2019 16:19:21 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Nov 2019 09:08:42 +01:00

x86/mm/pat: Convert the PAT tree to a generic interval tree

With some considerations, the custom pat_rbtree implementation can be
simplified to use most of the generic interval_tree machinery:

 - The tree inorder traversal can slightly differ when there are key
   ('start') collisions in the tree due to one going left and another right.
   This, however, only affects the output of debugfs' pat_memtype_list file.

 - Generic interval trees are now fully closed [a, b], for which we need
   to adjust the last endpoint (ie: end - 1).

 - Erasing logic must remain untouched as well.

In order for the types to remain u64, 'memtype_interval' calls are
introduced, as opposed to simply using struct interval_tree.

In addition, the PAT tree might potentially also benefit by the fast overlap
detection for the insertion case when looking up the first overlapping node
in the tree.

Finally, I've tested this on various servers, via sanity warnings, running
side by side with the current version and so far see no differences in the
returned pointer node when doing memtype_rb_lowest_match() lookups.

No change in functionality intended.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dave@stgolabs.net
Link: https://lkml.kernel.org/r/20191021231924.25373-2-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pat_rbtree.c | 164 +++++++++-----------------------------
 1 file changed, 43 insertions(+), 121 deletions(-)

diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
index 65ebe4b..4998d69 100644
--- a/arch/x86/mm/pat_rbtree.c
+++ b/arch/x86/mm/pat_rbtree.c
@@ -5,14 +5,13 @@
  * Authors: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
  *          Suresh B Siddha <suresh.b.siddha@intel.com>
  *
- * Interval tree (augmented rbtree) used to store the PAT memory type
- * reservations.
+ * Interval tree used to store the PAT memory type reservations.
  */
 
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
 #include <linux/kernel.h>
-#include <linux/rbtree_augmented.h>
+#include <linux/interval_tree_generic.h>
 #include <linux/sched.h>
 #include <linux/gfp.h>
 
@@ -33,72 +32,33 @@
  *
  * memtype_lock protects the rbtree.
  */
-
-static struct rb_root memtype_rbroot = RB_ROOT;
-
-static int is_node_overlap(struct memtype *node, u64 start, u64 end)
+static inline u64 memtype_interval_start(struct memtype *memtype)
 {
-	if (node->start >= end || node->end <= start)
-		return 0;
-
-	return 1;
+	return memtype->start;
 }
 
-static u64 get_subtree_max_end(struct rb_node *node)
+static inline u64 memtype_interval_end(struct memtype *memtype)
 {
-	u64 ret = 0;
-	if (node) {
-		struct memtype *data = rb_entry(node, struct memtype, rb);
-		ret = data->subtree_max_end;
-	}
-	return ret;
+	return memtype->end - 1;
 }
+INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
+		     memtype_interval_start, memtype_interval_end,
+		     static, memtype_interval)
 
-#define NODE_END(node) ((node)->end)
-
-RB_DECLARE_CALLBACKS_MAX(static, memtype_rb_augment_cb,
-			 struct memtype, rb, u64, subtree_max_end, NODE_END)
-
-/* Find the first (lowest start addr) overlapping range from rb tree */
-static struct memtype *memtype_rb_lowest_match(struct rb_root *root,
-				u64 start, u64 end)
-{
-	struct rb_node *node = root->rb_node;
-	struct memtype *last_lower = NULL;
-
-	while (node) {
-		struct memtype *data = rb_entry(node, struct memtype, rb);
-
-		if (get_subtree_max_end(node->rb_left) > start) {
-			/* Lowest overlap if any must be on left side */
-			node = node->rb_left;
-		} else if (is_node_overlap(data, start, end)) {
-			last_lower = data;
-			break;
-		} else if (start >= data->start) {
-			/* Lowest overlap if any must be on right side */
-			node = node->rb_right;
-		} else {
-			break;
-		}
-	}
-	return last_lower; /* Returns NULL if there is no overlap */
-}
+static struct rb_root_cached memtype_rbroot = RB_ROOT_CACHED;
 
 enum {
 	MEMTYPE_EXACT_MATCH	= 0,
 	MEMTYPE_END_MATCH	= 1
 };
 
-static struct memtype *memtype_rb_match(struct rb_root *root,
-				u64 start, u64 end, int match_type)
+static struct memtype *memtype_match(struct rb_root_cached *root,
+				     u64 start, u64 end, int match_type)
 {
 	struct memtype *match;
 
-	match = memtype_rb_lowest_match(root, start, end);
+	match = memtype_interval_iter_first(root, start, end);
 	while (match != NULL && match->start < end) {
-		struct rb_node *node;
-
 		if ((match_type == MEMTYPE_EXACT_MATCH) &&
 		    (match->start == start) && (match->end == end))
 			return match;
@@ -107,26 +67,21 @@ static struct memtype *memtype_rb_match(struct rb_root *root,
 		    (match->start < start) && (match->end == end))
 			return match;
 
-		node = rb_next(&match->rb);
-		if (node)
-			match = rb_entry(node, struct memtype, rb);
-		else
-			match = NULL;
+		match = memtype_interval_iter_next(match, start, end);
 	}
 
 	return NULL; /* Returns NULL if there is no match */
 }
 
-static int memtype_rb_check_conflict(struct rb_root *root,
+static int memtype_rb_check_conflict(struct rb_root_cached *root,
 				u64 start, u64 end,
 				enum page_cache_mode reqtype,
 				enum page_cache_mode *newtype)
 {
-	struct rb_node *node;
 	struct memtype *match;
 	enum page_cache_mode found_type = reqtype;
 
-	match = memtype_rb_lowest_match(&memtype_rbroot, start, end);
+	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
 	if (match == NULL)
 		goto success;
 
@@ -136,19 +91,12 @@ static int memtype_rb_check_conflict(struct rb_root *root,
 	dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
 	found_type = match->type;
 
-	node = rb_next(&match->rb);
-	while (node) {
-		match = rb_entry(node, struct memtype, rb);
-
-		if (match->start >= end) /* Checked all possible matches */
-			goto success;
-
-		if (is_node_overlap(match, start, end) &&
-		    match->type != found_type) {
+	match = memtype_interval_iter_next(match, start, end);
+	while (match) {
+		if (match->type != found_type)
 			goto failure;
-		}
 
-		node = rb_next(&match->rb);
+		match = memtype_interval_iter_next(match, start, end);
 	}
 success:
 	if (newtype)
@@ -163,43 +111,20 @@ failure:
 	return -EBUSY;
 }
 
-static void memtype_rb_insert(struct rb_root *root, struct memtype *newdata)
-{
-	struct rb_node **node = &(root->rb_node);
-	struct rb_node *parent = NULL;
-
-	while (*node) {
-		struct memtype *data = rb_entry(*node, struct memtype, rb);
-
-		parent = *node;
-		if (data->subtree_max_end < newdata->end)
-			data->subtree_max_end = newdata->end;
-		if (newdata->start <= data->start)
-			node = &((*node)->rb_left);
-		else if (newdata->start > data->start)
-			node = &((*node)->rb_right);
-	}
-
-	newdata->subtree_max_end = newdata->end;
-	rb_link_node(&newdata->rb, parent, node);
-	rb_insert_augmented(&newdata->rb, root, &memtype_rb_augment_cb);
-}
-
 int rbt_memtype_check_insert(struct memtype *new,
 			     enum page_cache_mode *ret_type)
 {
 	int err = 0;
 
 	err = memtype_rb_check_conflict(&memtype_rbroot, new->start, new->end,
-						new->type, ret_type);
-
-	if (!err) {
-		if (ret_type)
-			new->type = *ret_type;
-
-		new->subtree_max_end = new->end;
-		memtype_rb_insert(&memtype_rbroot, new);
-	}
+					new->type, ret_type);
+	if (err)
+		goto done;
+
+	if (ret_type)
+		new->type = *ret_type;
+	memtype_interval_insert(new, &memtype_rbroot);
+done:
 	return err;
 }
 
@@ -214,26 +139,23 @@ struct memtype *rbt_memtype_erase(u64 start, u64 end)
 	 * it then checks with END_MATCH, i.e. shrink the size of a node
 	 * from the end for the mremap case.
 	 */
-	data = memtype_rb_match(&memtype_rbroot, start, end,
-				MEMTYPE_EXACT_MATCH);
+	data = memtype_match(&memtype_rbroot, start, end,
+			     MEMTYPE_EXACT_MATCH);
 	if (!data) {
-		data = memtype_rb_match(&memtype_rbroot, start, end,
-					MEMTYPE_END_MATCH);
+		data = memtype_match(&memtype_rbroot, start, end,
+				     MEMTYPE_END_MATCH);
 		if (!data)
 			return ERR_PTR(-EINVAL);
 	}
 
 	if (data->start == start) {
 		/* munmap: erase this node */
-		rb_erase_augmented(&data->rb, &memtype_rbroot,
-					&memtype_rb_augment_cb);
+		memtype_interval_remove(data, &memtype_rbroot);
 	} else {
 		/* mremap: update the end value of this node */
-		rb_erase_augmented(&data->rb, &memtype_rbroot,
-					&memtype_rb_augment_cb);
+		memtype_interval_remove(data, &memtype_rbroot);
 		data->end = start;
-		data->subtree_max_end = data->end;
-		memtype_rb_insert(&memtype_rbroot, data);
+		memtype_interval_insert(data, &memtype_rbroot);
 		return NULL;
 	}
 
@@ -242,24 +164,24 @@ struct memtype *rbt_memtype_erase(u64 start, u64 end)
 
 struct memtype *rbt_memtype_lookup(u64 addr)
 {
-	return memtype_rb_lowest_match(&memtype_rbroot, addr, addr + PAGE_SIZE);
+	return memtype_interval_iter_first(&memtype_rbroot, addr,
+					   addr + PAGE_SIZE);
 }
 
 #if defined(CONFIG_DEBUG_FS)
 int rbt_memtype_copy_nth_element(struct memtype *out, loff_t pos)
 {
-	struct rb_node *node;
+	struct memtype *match;
 	int i = 1;
 
-	node = rb_first(&memtype_rbroot);
-	while (node && pos != i) {
-		node = rb_next(node);
+	match = memtype_interval_iter_first(&memtype_rbroot, 0, ULONG_MAX);
+	while (match && pos != i) {
+		match = memtype_interval_iter_next(match, 0, ULONG_MAX);
 		i++;
 	}
 
-	if (node) { /* pos == i */
-		struct memtype *this = rb_entry(node, struct memtype, rb);
-		*out = *this;
+	if (match) { /* pos == i */
+		*out = *match;
 		return 0;
 	} else {
 		return 1;
