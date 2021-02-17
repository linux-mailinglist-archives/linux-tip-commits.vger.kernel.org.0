Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C17E31DA27
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhBQNSu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:18:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45296 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbhBQNSV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:21 -0500
Date:   Wed, 17 Feb 2021 13:17:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Hk3hXl46m71iNJ/h86EQ4bBz+PJHkf4mWd568adpOTo=;
        b=3IqjJJk90NF6/UVcZ4nqNnPbHcz9JGOKpHgVC5RAkDVyLmHWWiTdofXwEKPVqo3u83U+Rk
        03t8z5X4ou8DlE1+NzrGG6wTk9tI4CIo4iMSqfTZBwEUUf96C/5YqloA49Kt/geudaChB+
        oW70EqxylKRa4WuFDpUVnmp2nSB2SfhWcWpyKQT+bUDJxULXFf/kiytr9Ic6ueXwkod2v1
        WbHJao8j89v/e5FHud8L07l30YKI7vc7fg8v5u3n3UrPh+Dlef1FGLEbCxhXOBGVuzCCWB
        IP1mdoB47I+liFkkqTiPZkDy9SwPl6dJl9LrbNYD9Ck3WSJWLAlxubIhlv3nUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Hk3hXl46m71iNJ/h86EQ4bBz+PJHkf4mWd568adpOTo=;
        b=TR5Q5dTnSWYDVX5nsQdS/43IPC62smJ4X7fi0c1/DyY1IR5K41IssWOctwsIQGvVu/n/lq
        FwK+QgXPr8e0SjDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rbtree, rtmutex: Use rb_add_cached()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161356785728.20312.7772121827108396177.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5a7987253ef0909d94e176cd97e511013de0fe19
Gitweb:        https://git.kernel.org/tip/5a7987253ef0909d94e176cd97e511013de0fe19
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 29 Apr 2020 17:29:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:07:57 +01:00

rbtree, rtmutex: Use rb_add_cached()

Reduce rbtree boiler plate by using the new helpers.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/locking/rtmutex.c | 54 +++++++++++++--------------------------
 1 file changed, 18 insertions(+), 36 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2f8cd61..57e3804 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -267,27 +267,18 @@ rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
 	return 1;
 }
 
+#define __node_2_waiter(node) \
+	rb_entry((node), struct rt_mutex_waiter, tree_entry)
+
+static inline bool __waiter_less(struct rb_node *a, const struct rb_node *b)
+{
+	return rt_mutex_waiter_less(__node_2_waiter(a), __node_2_waiter(b));
+}
+
 static void
 rt_mutex_enqueue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
 {
-	struct rb_node **link = &lock->waiters.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct rt_mutex_waiter *entry;
-	bool leftmost = true;
-
-	while (*link) {
-		parent = *link;
-		entry = rb_entry(parent, struct rt_mutex_waiter, tree_entry);
-		if (rt_mutex_waiter_less(waiter, entry)) {
-			link = &parent->rb_left;
-		} else {
-			link = &parent->rb_right;
-			leftmost = false;
-		}
-	}
-
-	rb_link_node(&waiter->tree_entry, parent, link);
-	rb_insert_color_cached(&waiter->tree_entry, &lock->waiters, leftmost);
+	rb_add_cached(&waiter->tree_entry, &lock->waiters, __waiter_less);
 }
 
 static void
@@ -300,27 +291,18 @@ rt_mutex_dequeue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
 	RB_CLEAR_NODE(&waiter->tree_entry);
 }
 
+#define __node_2_pi_waiter(node) \
+	rb_entry((node), struct rt_mutex_waiter, pi_tree_entry)
+
+static inline bool __pi_waiter_less(struct rb_node *a, const struct rb_node *b)
+{
+	return rt_mutex_waiter_less(__node_2_pi_waiter(a), __node_2_pi_waiter(b));
+}
+
 static void
 rt_mutex_enqueue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 {
-	struct rb_node **link = &task->pi_waiters.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct rt_mutex_waiter *entry;
-	bool leftmost = true;
-
-	while (*link) {
-		parent = *link;
-		entry = rb_entry(parent, struct rt_mutex_waiter, pi_tree_entry);
-		if (rt_mutex_waiter_less(waiter, entry)) {
-			link = &parent->rb_left;
-		} else {
-			link = &parent->rb_right;
-			leftmost = false;
-		}
-	}
-
-	rb_link_node(&waiter->pi_tree_entry, parent, link);
-	rb_insert_color_cached(&waiter->pi_tree_entry, &task->pi_waiters, leftmost);
+	rb_add_cached(&waiter->pi_tree_entry, &task->pi_waiters, __pi_waiter_less);
 }
 
 static void
