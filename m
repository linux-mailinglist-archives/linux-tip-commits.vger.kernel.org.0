Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E9434D4EA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Mar 2021 18:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhC2QYe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Mar 2021 12:24:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhC2QYL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Mar 2021 12:24:11 -0400
Date:   Mon, 29 Mar 2021 16:24:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617035050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Ts4Hf2oApYlnMKKo+hl+qLOxMxSOnod7qZAXHKQQYA=;
        b=wYlzwD19rWHYstjDR4c16iK3IE4Is3MHQzSBIe9Z0Km7H40t0qny022zGC1NFlSAWrHHuM
        1d/R98yatqs9rppociKt158OU+mBDlKsXHPEN+hM8LdXVlDmtPKG5wroHDXuKq1HrooKwS
        y6KE8sLLTJgL7bRJup8biJORpW1B3+C7RL5Iw5mWzNmdWLokNIA8vhiR5tcu63a9dr+nPe
        XExN2vTUoIlM6JvX26pXDVf588hR0okhE1NfJ+jQr0KPDDLlYyQXb1D+lnM/0V8wymqvPJ
        d5PDit1SlH+BU5SQxV5SoX1nzm0IpuAQ/f+Pv8DTigNFiLtI2S6T0yDz8Hvk6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617035050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Ts4Hf2oApYlnMKKo+hl+qLOxMxSOnod7qZAXHKQQYA=;
        b=lje+hLwu9ez1mnuTQwbNcu0SWWDX/GgtP7NQdUdJWe1WN18MTT654Zg2PnhM43J5O+M9zt
        E+yJVB/r3pp90MCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Remove pointless
 CONFIG_RT_MUTEXES=n stubs
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326153943.863379182@linutronix.de>
References: <20210326153943.863379182@linutronix.de>
MIME-Version: 1.0
Message-ID: <161703504993.29796.15530485380969433684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     37350e3b2655eb0fce4e0e6ce8ce631c781136fe
Gitweb:        https://git.kernel.org/tip/37350e3b2655eb0fce4e0e6ce8ce631c781136fe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 26 Mar 2021 16:29:37 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 29 Mar 2021 15:57:03 +02:00

locking/rtmutex: Remove pointless CONFIG_RT_MUTEXES=n stubs

None of these functions are used when CONFIG_RT_MUTEXES=n.

Remove the gunk. Remove pointless comments and clean up the coding style
mess while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210326153943.863379182@linutronix.de
---
 kernel/locking/rtmutex_common.h | 62 ++++++++++----------------------
 1 file changed, 20 insertions(+), 42 deletions(-)

diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index badb2a2..8596a71 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -23,29 +23,30 @@
  * @tree_entry:		pi node to enqueue into the mutex waiters tree
  * @pi_tree_entry:	pi node to enqueue into the mutex owner waiters tree
  * @task:		task reference to the blocked task
+ * @lock:		Pointer to the rt_mutex on which the waiter blocks
+ * @prio:		Priority of the waiter
+ * @deadline:		Deadline of the waiter if applicable
  */
 struct rt_mutex_waiter {
-	struct rb_node          tree_entry;
-	struct rb_node          pi_tree_entry;
+	struct rb_node		tree_entry;
+	struct rb_node		pi_tree_entry;
 	struct task_struct	*task;
 	struct rt_mutex		*lock;
-	int prio;
-	u64 deadline;
+	int			prio;
+	u64			deadline;
 };
 
 /*
- * Various helpers to access the waiters-tree:
+ * Must be guarded because this header is included from rcu/tree_plugin.h
+ * unconditionally.
  */
-
 #ifdef CONFIG_RT_MUTEXES
-
 static inline int rt_mutex_has_waiters(struct rt_mutex *lock)
 {
 	return !RB_EMPTY_ROOT(&lock->waiters.rb_root);
 }
 
-static inline struct rt_mutex_waiter *
-rt_mutex_top_waiter(struct rt_mutex *lock)
+static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex *lock)
 {
 	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
 	struct rt_mutex_waiter *w = NULL;
@@ -62,42 +63,12 @@ static inline int task_has_pi_waiters(struct task_struct *p)
 	return !RB_EMPTY_ROOT(&p->pi_waiters.rb_root);
 }
 
-static inline struct rt_mutex_waiter *
-task_top_pi_waiter(struct task_struct *p)
-{
-	return rb_entry(p->pi_waiters.rb_leftmost,
-			struct rt_mutex_waiter, pi_tree_entry);
-}
-
-#else
-
-static inline int rt_mutex_has_waiters(struct rt_mutex *lock)
-{
-	return false;
-}
-
-static inline struct rt_mutex_waiter *
-rt_mutex_top_waiter(struct rt_mutex *lock)
-{
-	return NULL;
-}
-
-static inline int task_has_pi_waiters(struct task_struct *p)
+static inline struct rt_mutex_waiter *task_top_pi_waiter(struct task_struct *p)
 {
-	return false;
+	return rb_entry(p->pi_waiters.rb_leftmost, struct rt_mutex_waiter,
+			pi_tree_entry);
 }
 
-static inline struct rt_mutex_waiter *
-task_top_pi_waiter(struct task_struct *p)
-{
-	return NULL;
-}
-
-#endif
-
-/*
- * lock->owner state tracking:
- */
 #define RT_MUTEX_HAS_WAITERS	1UL
 
 static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
@@ -106,6 +77,13 @@ static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
 
 	return (struct task_struct *) (owner & ~RT_MUTEX_HAS_WAITERS);
 }
+#else /* CONFIG_RT_MUTEXES */
+/* Used in rcu/tree_plugin.h */
+static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
+{
+	return NULL;
+}
+#endif  /* !CONFIG_RT_MUTEXES */
 
 /*
  * Constants for rt mutex functions which have a selectable deadlock
