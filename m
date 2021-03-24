Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA5134725A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Mar 2021 08:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhCXHWq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 24 Mar 2021 03:22:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38668 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbhCXHWa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 24 Mar 2021 03:22:30 -0400
Date:   Wed, 24 Mar 2021 07:22:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616570549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eS/MEA/ap2FbZKXRkDjvMCQpW/MxEZi4Pu1p3eUklKI=;
        b=U9vofMFPIa/+v6cC39AWBOLT00oVUkzErh1+RahNy5zgRkwKhQZrMu0SOC7EWIP4hS7TEM
        o6hIWEVIx3BvZkgBCVeeiFoIQWQqMbAVhVrVKWbGKGr93Laykse3E3f4gmx5oO3mzxAfjQ
        F8srn9tC3M/bcmr1LUd9w8HC2xYiBAsT3iv80oJeI4TwgwRaIce+68uFAf7FIJTF1DnJNN
        JxMh99bf2rKU81F70FoHb2jaYl0UZNTcSuJuUKeu7y/RPRXLOCVkipyF+q2YyCDc+ztU5z
        +fIU6tg38RiK9afn1fuf4lLHkugpUV+QJoiVMvDBcJiKF8TvOWN3jt20g9xQPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616570549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eS/MEA/ap2FbZKXRkDjvMCQpW/MxEZi4Pu1p3eUklKI=;
        b=K3YVJUC0kNXd+AGOrqKNpT6sTBNwKBnjQafiibt5JX3d0Jbsu49L0YPmLIEvgEtpsyQ+GU
        zfbHX8rgT6ImeFBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Remove pointless
 CONFIG_RT_MUTEXES=n stubs
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210323213708.305191020@linutronix.de>
References: <20210323213708.305191020@linutronix.de>
MIME-Version: 1.0
Message-ID: <161657054891.398.5545173778907504540.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     18970ac4e37011fd0c709b6c2a640f01eecf2dd7
Gitweb:        https://git.kernel.org/tip/18970ac4e37011fd0c709b6c2a640f01eecf2dd7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 23 Mar 2021 22:30:27 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Mar 2021 08:06:08 +01:00

locking/rtmutex: Remove pointless CONFIG_RT_MUTEXES=n stubs

None of these functions is used when CONFIG_RT_MUTEXES=n.

Remove the gunk. Remove pointless comments and clean up the coding style
mess while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210323213708.305191020@linutronix.de
---
 kernel/locking/rtmutex_common.h | 56 ++++++--------------------------
 1 file changed, 11 insertions(+), 45 deletions(-)

diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index badb2a2..0350ae3 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -23,29 +23,25 @@
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
 
-/*
- * Various helpers to access the waiters-tree:
- */
-
-#ifdef CONFIG_RT_MUTEXES
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
@@ -62,42 +58,12 @@ static inline int task_has_pi_waiters(struct task_struct *p)
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
-{
-	return false;
-}
-
-static inline struct rt_mutex_waiter *
-task_top_pi_waiter(struct task_struct *p)
+static inline struct rt_mutex_waiter *task_top_pi_waiter(struct task_struct *p)
 {
-	return NULL;
+	return rb_entry(p->pi_waiters.rb_leftmost, struct rt_mutex_waiter,
+			pi_tree_entry);
 }
 
-#endif
-
-/*
- * lock->owner state tracking:
- */
 #define RT_MUTEX_HAS_WAITERS	1UL
 
 static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
