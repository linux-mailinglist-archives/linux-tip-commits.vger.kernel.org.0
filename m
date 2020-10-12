Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D7428BEBD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Oct 2020 19:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404078AbgJLRIi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Oct 2020 13:08:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46384 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404041AbgJLRI3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Oct 2020 13:08:29 -0400
Date:   Mon, 12 Oct 2020 17:08:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602522506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9NQNo3Ey3SjkLVCOUR9lgFO8qlHmzKkG2gaUkj9dNg=;
        b=Vt2KYckoMlIlYSTbcQYAWWGdbsysR14AJXgkPeAyYyHr0aH//8NQMOzImPWWIFg4v/P9me
        CX4pCNk03jEptbnwnisXkYq3epcDeb5EQITy+N6vJFYcXmwY0uAxSqQk7SDzFALyt2c2Jl
        7XoeAU5IQJzO0pYmkUgfFpGWo7KTc1tPMADrGitfl77b5Q/Or9gT28AGWVVnDU2Q9q4x95
        myprnnNUIrbNlyOrSEShXUs1/A5hXUVQc058sahlpKyTjs2yV6BiWefCgbhps03BKmFvVW
        wv7fMlIyllzTYiw9n9eXkd2kavlxO17Un+bcH2vL4HXaItuGcB1tnv1BP8Jpvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602522506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9NQNo3Ey3SjkLVCOUR9lgFO8qlHmzKkG2gaUkj9dNg=;
        b=WP8Xr6doCnXc5ydtqwT1s2sgdOrkfL9pPUPjmdj0/zJPFw4ZDdo5PRMht2B2s4Ze8jreHw
        9aJQYy2PP8nupTCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/kprobes] freelist: Implement lockless freelist
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <159870622579.1229682.16729440870040944993.stgit@devnote2>
References: <159870622579.1229682.16729440870040944993.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160252250537.7002.15126371510858917504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/kprobes branch of tip:

Commit-ID:     e563604a5f5a891283b6a8db4001cee833a7c6b8
Gitweb:        https://git.kernel.org/tip/e563604a5f5a891283b6a8db4001cee833a7c6b8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 29 Aug 2020 22:03:46 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 12 Oct 2020 18:27:28 +02:00

freelist: Implement lockless freelist

A simple CAS-based lock-free free list. Not the fastest thing in the world
under heavy contention, but simple and correct (assuming nodes are never
freed until after the free list is destroyed), and fairly speedy under low
contention.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/159870622579.1229682.16729440870040944993.stgit@devnote2
---
 include/linux/freelist.h | 129 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+)
 create mode 100644 include/linux/freelist.h

diff --git a/include/linux/freelist.h b/include/linux/freelist.h
new file mode 100644
index 0000000..fc1842b
--- /dev/null
+++ b/include/linux/freelist.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+#ifndef FREELIST_H
+#define FREELIST_H
+
+#include <linux/atomic.h>
+
+/*
+ * Copyright: cameron@moodycamel.com
+ *
+ * A simple CAS-based lock-free free list. Not the fastest thing in the world
+ * under heavy contention, but simple and correct (assuming nodes are never
+ * freed until after the free list is destroyed), and fairly speedy under low
+ * contention.
+ *
+ * Adapted from: https://moodycamel.com/blog/2014/solving-the-aba-problem-for-lock-free-free-lists
+ */
+
+struct freelist_node {
+	atomic_t		refs;
+	struct freelist_node	*next;
+};
+
+struct freelist_head {
+	struct freelist_node	*head;
+};
+
+#define REFS_ON_FREELIST 0x80000000
+#define REFS_MASK	 0x7FFFFFFF
+
+static inline void __freelist_add(struct freelist_node *node, struct freelist_head *list)
+{
+	/*
+	 * Since the refcount is zero, and nobody can increase it once it's
+	 * zero (except us, and we run only one copy of this method per node at
+	 * a time, i.e. the single thread case), then we know we can safely
+	 * change the next pointer of the node; however, once the refcount is
+	 * back above zero, then other threads could increase it (happens under
+	 * heavy contention, when the refcount goes to zero in between a load
+	 * and a refcount increment of a node in try_get, then back up to
+	 * something non-zero, then the refcount increment is done by the other
+	 * thread) -- so if the CAS to add the node to the actual list fails,
+	 * decrese the refcount and leave the add operation to the next thread
+	 * who puts the refcount back to zero (which could be us, hence the
+	 * loop).
+	 */
+	struct freelist_node *head = READ_ONCE(list->head);
+
+	for (;;) {
+		WRITE_ONCE(node->next, head);
+		atomic_set_release(&node->refs, 1);
+
+		if (!try_cmpxchg_release(&list->head, &head, node)) {
+			/*
+			 * Hmm, the add failed, but we can only try again when
+			 * the refcount goes back to zero.
+			 */
+			if (atomic_fetch_add_release(REFS_ON_FREELIST - 1, &node->refs) == 1)
+				continue;
+		}
+		return;
+	}
+}
+
+static inline void freelist_add(struct freelist_node *node, struct freelist_head *list)
+{
+	/*
+	 * We know that the should-be-on-freelist bit is 0 at this point, so
+	 * it's safe to set it using a fetch_add.
+	 */
+	if (!atomic_fetch_add_release(REFS_ON_FREELIST, &node->refs)) {
+		/*
+		 * Oh look! We were the last ones referencing this node, and we
+		 * know we want to add it to the free list, so let's do it!
+		 */
+		__freelist_add(node, list);
+	}
+}
+
+static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
+{
+	struct freelist_node *prev, *next, *head = smp_load_acquire(&list->head);
+	unsigned int refs;
+
+	while (head) {
+		prev = head;
+		refs = atomic_read(&head->refs);
+		if ((refs & REFS_MASK) == 0 ||
+		    !atomic_try_cmpxchg_acquire(&head->refs, &refs, refs+1)) {
+			head = smp_load_acquire(&list->head);
+			continue;
+		}
+
+		/*
+		 * Good, reference count has been incremented (it wasn't at
+		 * zero), which means we can read the next and not worry about
+		 * it changing between now and the time we do the CAS.
+		 */
+		next = READ_ONCE(head->next);
+		if (try_cmpxchg_acquire(&list->head, &head, next)) {
+			/*
+			 * Yay, got the node. This means it was on the list,
+			 * which means should-be-on-freelist must be false no
+			 * matter the refcount (because nobody else knows it's
+			 * been taken off yet, it can't have been put back on).
+			 */
+			WARN_ON_ONCE(atomic_read(&head->refs) & REFS_ON_FREELIST);
+
+			/*
+			 * Decrease refcount twice, once for our ref, and once
+			 * for the list's ref.
+			 */
+			atomic_fetch_add(-2, &head->refs);
+
+			return head;
+		}
+
+		/*
+		 * OK, the head must have changed on us, but we still need to decrement
+		 * the refcount we increased.
+		 */
+		refs = atomic_fetch_add(-1, &prev->refs);
+		if (refs == REFS_ON_FREELIST + 1)
+			__freelist_add(prev, list);
+	}
+
+	return NULL;
+}
+
+#endif /* FREELIST_H */
