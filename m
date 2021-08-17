Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C9C3EF363
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhHQUP0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34620 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbhHQUO5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:57 -0400
Date:   Tue, 17 Aug 2021 20:14:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231263;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dtmF6otD8TY4fYvwVwZb3UVDRjWPmc3qLiuKiyclm14=;
        b=b+PD8Yf12Da0QlVYL63bPLeaox84b7Pq/X6SpLxQuNN+V66iFnacMAoMwl4svN8hPsgWac
        zxEOA2zA9yZq266Bgu53vWPeFlqH7anuWoDhG5E2ZItTBo+7nlgfG3Pa5j7Vq/s1WJv/gf
        L8A9EjVRD0m4fFQPvofVfZvpjJbnTB2wugUdAV4HFtfh4gStm8cX0/x3XW2xX9ISrupWa1
        5KycCIKWpgvn00JutCbjMQl7pCMutRLCmR+AztTM59Ff0C6rS2ZsKri0AelydaBX2PmA8k
        X4fztuXO7AOlDiiXXaVaUc3p+BU6ACb42q8ynoIeL7uFzQypa94iKWAwF+BdxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231263;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dtmF6otD8TY4fYvwVwZb3UVDRjWPmc3qLiuKiyclm14=;
        b=l2WSn0gA933+OqpcRI1Xr9K85yKwmlu0bUmk1vabAdhGE5I+AQlG3CJOjpq4LeCtBd7sWp
        18w1y1h+kKOq9kBw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rbtree: Split out the rbtree type definitions
 into <linux/rbtree_types.h>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211303.542123501@linutronix.de>
References: <20210815211303.542123501@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923126248.25758.5457405827666220106.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     089050cafa10f408c9e18ad53965db839b894840
Gitweb:        https://git.kernel.org/tip/089050cafa10f408c9e18ad53965db839b894840
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:19 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:36:48 +02:00

rbtree: Split out the rbtree type definitions into <linux/rbtree_types.h>

So we have this header dependency problem on RT:

 - <linux/rtmutex.h> needs the definition of 'struct rb_root_cached'.
 - <linux/rbtree.h> includes <linux/kernel.h>, which includes <linux/spinlock.h>.

That works nicely for non-RT enabled kernels, but on RT enabled kernels
spinlocks are based on rtmutexes, which creates another circular header
dependency, as <linux/spinlocks.h> will require <linux/rtmutex.h>.

Split out the type definitions and move them into their own header file so
the rtmutex header can include just those.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211303.542123501@linutronix.de
---
 include/linux/rbtree.h       | 31 ++-----------------------------
 include/linux/rbtree_types.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 29 deletions(-)
 create mode 100644 include/linux/rbtree_types.h

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index d31ecaf..235047d 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -17,24 +17,14 @@
 #ifndef	_LINUX_RBTREE_H
 #define	_LINUX_RBTREE_H
 
+#include <linux/rbtree_types.h>
+
 #include <linux/kernel.h>
 #include <linux/stddef.h>
 #include <linux/rcupdate.h>
 
-struct rb_node {
-	unsigned long  __rb_parent_color;
-	struct rb_node *rb_right;
-	struct rb_node *rb_left;
-} __attribute__((aligned(sizeof(long))));
-    /* The alignment might seem pointless, but allegedly CRIS needs it */
-
-struct rb_root {
-	struct rb_node *rb_node;
-};
-
 #define rb_parent(r)   ((struct rb_node *)((r)->__rb_parent_color & ~3))
 
-#define RB_ROOT	(struct rb_root) { NULL, }
 #define	rb_entry(ptr, type, member) container_of(ptr, type, member)
 
 #define RB_EMPTY_ROOT(root)  (READ_ONCE((root)->rb_node) == NULL)
@@ -112,23 +102,6 @@ static inline void rb_link_node_rcu(struct rb_node *node, struct rb_node *parent
 			typeof(*pos), field); 1; }); \
 	     pos = n)
 
-/*
- * Leftmost-cached rbtrees.
- *
- * We do not cache the rightmost node based on footprint
- * size vs number of potential users that could benefit
- * from O(1) rb_last(). Just not worth it, users that want
- * this feature can always implement the logic explicitly.
- * Furthermore, users that want to cache both pointers may
- * find it a bit asymmetric, but that's ok.
- */
-struct rb_root_cached {
-	struct rb_root rb_root;
-	struct rb_node *rb_leftmost;
-};
-
-#define RB_ROOT_CACHED (struct rb_root_cached) { {NULL, }, NULL }
-
 /* Same as rb_first(), but O(1) */
 #define rb_first_cached(root) (root)->rb_leftmost
 
diff --git a/include/linux/rbtree_types.h b/include/linux/rbtree_types.h
new file mode 100644
index 0000000..45b6ecd
--- /dev/null
+++ b/include/linux/rbtree_types.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LINUX_RBTREE_TYPES_H
+#define _LINUX_RBTREE_TYPES_H
+
+struct rb_node {
+	unsigned long  __rb_parent_color;
+	struct rb_node *rb_right;
+	struct rb_node *rb_left;
+} __attribute__((aligned(sizeof(long))));
+/* The alignment might seem pointless, but allegedly CRIS needs it */
+
+struct rb_root {
+	struct rb_node *rb_node;
+};
+
+/*
+ * Leftmost-cached rbtrees.
+ *
+ * We do not cache the rightmost node based on footprint
+ * size vs number of potential users that could benefit
+ * from O(1) rb_last(). Just not worth it, users that want
+ * this feature can always implement the logic explicitly.
+ * Furthermore, users that want to cache both pointers may
+ * find it a bit asymmetric, but that's ok.
+ */
+struct rb_root_cached {
+	struct rb_root rb_root;
+	struct rb_node *rb_leftmost;
+};
+
+#define RB_ROOT (struct rb_root) { NULL, }
+#define RB_ROOT_CACHED (struct rb_root_cached) { {NULL, }, NULL }
+
+#endif
