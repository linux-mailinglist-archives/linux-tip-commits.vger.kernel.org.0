Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1193F3EF34A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbhHQUOx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbhHQUOr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A37C0613A4;
        Tue, 17 Aug 2021 13:14:12 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231251;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b0USmUn1LTXcdny7gQI/5wBy9pSIsJ9gmaqknPoAxN8=;
        b=hdptATl1a65PqDtyIlTJpQa7tQ6eXa0RbPWvpkWpQGnq+tU2CzhKiQGMbqZ9eji9klqL2C
        uG11uGFe4t5Y7JEDR+xCRBcnMo5a0srpVpbNGCYDWA82PzzUfbAtexs8lABUQpU6Poin6z
        EV49A6PXC0hTDlRk6ivgz33P951G3GwFWBn/Ua42tmtdugrevgl5BbVG7P/oxxHuPfuPyi
        lxyaCjKS7EwTrC4j/QW78CcBrVieBaTVOUfCOerXNXBqWRmel40TWJIjVxEEoyONQw1+xF
        /Tt5LEiRkIPIapESbPJ4FBvY1rTJM/Ej5a5FJKkQVx/Sc536DCV0Ezr1L/F54Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231251;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b0USmUn1LTXcdny7gQI/5wBy9pSIsJ9gmaqknPoAxN8=;
        b=2kunXh5t/KJfxmLkh3SKdeQ5wvgwY2Xpg5dJw8jpaYfm/OMOZ+ViqChPUjLb9oGCfmhGxh
        qKg23xrPj4F9lVDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Abstract out mutex types
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211304.678720245@linutronix.de>
References: <20210815211304.678720245@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923125052.25758.1277934162067404343.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bdb189148ded4ffa826a1387074c795fda43b3ba
Gitweb:        https://git.kernel.org/tip/bdb189148ded4ffa826a1387074c795fda43b3ba
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 15 Aug 2021 23:28:50 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:00 +02:00

locking/ww_mutex: Abstract out mutex types

Some ww_mutex helper functions use pointers for the underlying mutex and
mutex_waiter. The upcoming rtmutex based implementation needs to share
these functions. Add and use defines for the types and replace the direct
types in the affected functions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211304.678720245@linutronix.de
---
 kernel/locking/ww_mutex.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 842dbed..31b075f 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -1,5 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
+#define MUTEX		mutex
+#define MUTEX_WAITER	mutex_waiter
+
 static inline struct mutex_waiter *
 __ww_waiter_first(struct mutex *lock)
 {
@@ -143,7 +146,7 @@ __ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
  * __ww_mutex_check_kill() wake any but the earliest context.
  */
 static bool
-__ww_mutex_die(struct mutex *lock, struct mutex_waiter *waiter,
+__ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 	       struct ww_acquire_ctx *ww_ctx)
 {
 	if (!ww_ctx->is_wait_die)
@@ -165,7 +168,7 @@ __ww_mutex_die(struct mutex *lock, struct mutex_waiter *waiter,
  * the lock holders. Even if multiple waiters may wound the lock holder,
  * it's sufficient that only one does.
  */
-static bool __ww_mutex_wound(struct mutex *lock,
+static bool __ww_mutex_wound(struct MUTEX *lock,
 			     struct ww_acquire_ctx *ww_ctx,
 			     struct ww_acquire_ctx *hold_ctx)
 {
@@ -220,9 +223,9 @@ static bool __ww_mutex_wound(struct mutex *lock,
  * The current task must not be on the wait list.
  */
 static void
-__ww_mutex_check_waiters(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
+__ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
 {
-	struct mutex_waiter *cur;
+	struct MUTEX_WAITER *cur;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -278,7 +281,7 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 }
 
 static __always_inline int
-__ww_mutex_kill(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
+__ww_mutex_kill(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
 {
 	if (ww_ctx->acquired > 0) {
 #ifdef CONFIG_DEBUG_MUTEXES
@@ -306,12 +309,12 @@ __ww_mutex_kill(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
  * look at waiters before us in the wait-list.
  */
 static inline int
-__ww_mutex_check_kill(struct mutex *lock, struct mutex_waiter *waiter,
+__ww_mutex_check_kill(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		      struct ww_acquire_ctx *ctx)
 {
 	struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
 	struct ww_acquire_ctx *hold_ctx = READ_ONCE(ww->ctx);
-	struct mutex_waiter *cur;
+	struct MUTEX_WAITER *cur;
 
 	if (ctx->acquired == 0)
 		return 0;
@@ -354,11 +357,11 @@ __ww_mutex_check_kill(struct mutex *lock, struct mutex_waiter *waiter,
  * Wound-Wait ensure we wound the owning context when it is younger.
  */
 static inline int
-__ww_mutex_add_waiter(struct mutex_waiter *waiter,
-		      struct mutex *lock,
+__ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
+		      struct MUTEX *lock,
 		      struct ww_acquire_ctx *ww_ctx)
 {
-	struct mutex_waiter *cur, *pos = NULL;
+	struct MUTEX_WAITER *cur, *pos = NULL;
 	bool is_wait_die;
 
 	if (!ww_ctx) {
