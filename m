Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725D93EF346
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhHQUOu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34620 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbhHQUOo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:44 -0400
Date:   Tue, 17 Aug 2021 20:14:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231250;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJ6HaKKe48qID2bR0Xnaa0O3dHh4KBakG/8JXDZjvAE=;
        b=zlfAa7gWUHcnHPaI/SSsWA0iGukRmeQJBodmWechBLLeSFrZGc7E6QApzkLUyHyiDYJfa+
        eoWxOJQBijTXvlloGqD9wSjbf/ghcrkIky2dJDQigT6+RDFGu3POPgM2cBZxYrVSxYYD9C
        BZbxjt1berv4JOs59Pg5Vyrn7YeP04Yew8baKf/gU6l/OAXfHaRSVqTkxbeOcRMOlO+bQS
        V4jyas2ZEzTHGQ5Uhodk84cT0V7ieFDnscso7YQ7QsjclrCVCI2++UFxYDhT02T+nXylWH
        vNKF28cH4U7lUYPxEkDUmjCltrZ6D8/10gG8qs0Jz7NzeGNO7E39fO+nEIJCCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231250;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJ6HaKKe48qID2bR0Xnaa0O3dHh4KBakG/8JXDZjvAE=;
        b=xLE2INBzA9bxLL7PWeKeqrkBSisDk/6wiZ5KL1Tq0CMV+ScxxG3DqBTWRQ5KZij78nwqUT
        XPfIK7dKhgl/BtDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Implement rt_mutex accessors
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211304.790760545@linutronix.de>
References: <20210815211304.790760545@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923124931.25758.11752868870468766881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     dc4564f5dc2d4b11f3f3c8d3ac94012b1c7347d6
Gitweb:        https://git.kernel.org/tip/dc4564f5dc2d4b11f3f3c8d3ac94012b1c7347d6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 15 Aug 2021 23:28:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:06 +02:00

locking/ww_mutex: Implement rt_mutex accessors

Provide the type defines and the helper inlines for rtmutex based ww_mutexes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211304.790760545@linutronix.de
---
 kernel/locking/ww_mutex.h | 80 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+)

diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 309f3e4..7da9890 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
+#ifndef WW_RT
+
 #define MUTEX		mutex
 #define MUTEX_WAITER	mutex_waiter
 
@@ -83,6 +85,82 @@ static inline void lockdep_assert_wait_lock_held(struct mutex *lock)
 	lockdep_assert_held(&lock->wait_lock);
 }
 
+#else /* WW_RT */
+
+#define MUTEX		rt_mutex
+#define MUTEX_WAITER	rt_mutex_waiter
+
+static inline struct rt_mutex_waiter *
+__ww_waiter_first(struct rt_mutex *lock)
+{
+	struct rb_node *n = rb_first(&lock->rtmutex.waiters.rb_root);
+	if (!n)
+		return NULL;
+	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+}
+
+static inline struct rt_mutex_waiter *
+__ww_waiter_next(struct rt_mutex *lock, struct rt_mutex_waiter *w)
+{
+	struct rb_node *n = rb_next(&w->tree_entry);
+	if (!n)
+		return NULL;
+	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+}
+
+static inline struct rt_mutex_waiter *
+__ww_waiter_prev(struct rt_mutex *lock, struct rt_mutex_waiter *w)
+{
+	struct rb_node *n = rb_prev(&w->tree_entry);
+	if (!n)
+		return NULL;
+	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+}
+
+static inline struct rt_mutex_waiter *
+__ww_waiter_last(struct rt_mutex *lock)
+{
+	struct rb_node *n = rb_last(&lock->rtmutex.waiters.rb_root);
+	if (!n)
+		return NULL;
+	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+}
+
+static inline void
+__ww_waiter_add(struct rt_mutex *lock, struct rt_mutex_waiter *waiter, struct rt_mutex_waiter *pos)
+{
+	/* RT unconditionally adds the waiter first and then removes it on error */
+}
+
+static inline struct task_struct *
+__ww_mutex_owner(struct rt_mutex *lock)
+{
+	return rt_mutex_owner(&lock->rtmutex);
+}
+
+static inline bool
+__ww_mutex_has_waiters(struct rt_mutex *lock)
+{
+	return rt_mutex_has_waiters(&lock->rtmutex);
+}
+
+static inline void lock_wait_lock(struct rt_mutex *lock)
+{
+	raw_spin_lock(&lock->rtmutex.wait_lock);
+}
+
+static inline void unlock_wait_lock(struct rt_mutex *lock)
+{
+	raw_spin_unlock(&lock->rtmutex.wait_lock);
+}
+
+static inline void lockdep_assert_wait_lock_held(struct rt_mutex *lock)
+{
+	lockdep_assert_held(&lock->rtmutex.wait_lock);
+}
+
+#endif /* WW_RT */
+
 /*
  * Wait-Die:
  *   The newer transactions are killed when:
@@ -169,7 +247,9 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 
 	if (waiter->ww_ctx->acquired > 0 &&
 			__ww_ctx_stamp_after(waiter->ww_ctx, ww_ctx)) {
+#ifndef WW_RT
 		debug_mutex_wake_waiter(lock, waiter);
+#endif
 		wake_up_process(waiter->task);
 	}
 
