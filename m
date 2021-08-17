Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877393EF343
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhHQUOt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34614 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbhHQUOn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:43 -0400
Date:   Tue, 17 Aug 2021 20:14:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231249;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ucziT0Apgm2nWVrP9p3I60LxjflSBIMwqs4U+tZT4kA=;
        b=hbeaKuK4A8JwG75SRhCLH/UXZTwGevPSmQBm82Yztzueal9M1zxDRe4q8KBpi3Y8yFDLQF
        8PG+b1/c4z6aSo6+rO5BAx5LWlTx6SUF6MYvnDivpL9scfcQWDFf/uNS9hGlv41DaL+vmU
        /p2OZ7ESiqCXmCrbj4zqlfV+j3uYOn17lWK12LJeOx8P6TB5GtlM3lHe8ozrP4sQ7+2hpX
        SgdE5Swy048QNo4Xpp3RzEXw8NFn6EBJaEwQ/PlisfdWgae6fzK5bY6SgDMeQLmi4h6Z50
        kaLjHBwB0j1EEj+TIMsYW8H1Xqh5LAAK5jTq5KHwZWOcNgP+Pzt5kXk28JarAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231249;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ucziT0Apgm2nWVrP9p3I60LxjflSBIMwqs4U+tZT4kA=;
        b=BHz3gVH19UDhGd87J7XVeABJ0+pCdO1f++OzKFAT/1H3oKGHm3xbjaVYYc0EOhxhNvQFtG
        Bu0ZTfyeH0iKA5AQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Add RT priority to W/W order
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211304.847536630@linutronix.de>
References: <20210815211304.847536630@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923124867.25758.16331379250721685764.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8850d773703f8114d7c8a2421fd20bde8a558f96
Gitweb:        https://git.kernel.org/tip/8850d773703f8114d7c8a2421fd20bde8a558f96
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 15 Aug 2021 23:28:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:08 +02:00

locking/ww_mutex: Add RT priority to W/W order

RT mutex based ww_mutexes cannot order based on timestamps. They have to
order based on priority. Add the necessary decision logic.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211304.847536630@linutronix.de
---
 kernel/locking/ww_mutex.h | 64 +++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 7da9890..2dce4f0 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -219,19 +219,54 @@ ww_mutex_lock_acquired(struct ww_mutex *ww, struct ww_acquire_ctx *ww_ctx)
 }
 
 /*
- * Determine if context @a is 'after' context @b. IOW, @a is a younger
- * transaction than @b and depending on algorithm either needs to wait for
- * @b or die.
+ * Determine if @a is 'less' than @b. IOW, either @a is a lower priority task
+ * or, when of equal priority, a younger transaction than @b.
+ *
+ * Depending on the algorithm, @a will either need to wait for @b, or die.
  */
 static inline bool
-__ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
+__ww_ctx_less(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
 {
+/*
+ * Can only do the RT prio for WW_RT, because task->prio isn't stable due to PI,
+ * so the wait_list ordering will go wobbly. rt_mutex re-queues the waiter and
+ * isn't affected by this.
+ */
+#ifdef WW_RT
+	/* kernel prio; less is more */
+	int a_prio = a->task->prio;
+	int b_prio = b->task->prio;
+
+	if (rt_prio(a_prio) || rt_prio(b_prio)) {
+
+		if (a_prio > b_prio)
+			return true;
+
+		if (a_prio < b_prio)
+			return false;
+
+		/* equal static prio */
+
+		if (dl_prio(a_prio)) {
+			if (dl_time_before(b->task->dl.deadline,
+					   a->task->dl.deadline))
+				return true;
+
+			if (dl_time_before(a->task->dl.deadline,
+					   b->task->dl.deadline))
+				return false;
+		}
+
+		/* equal prio */
+	}
+#endif
 
+	/* FIFO order tie break -- bigger is younger */
 	return (signed long)(a->stamp - b->stamp) > 0;
 }
 
 /*
- * Wait-Die; wake a younger waiter context (when locks held) such that it can
+ * Wait-Die; wake a lesser waiter context (when locks held) such that it can
  * die.
  *
  * Among waiters with context, only the first one can have other locks acquired
@@ -245,8 +280,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 	if (!ww_ctx->is_wait_die)
 		return false;
 
-	if (waiter->ww_ctx->acquired > 0 &&
-			__ww_ctx_stamp_after(waiter->ww_ctx, ww_ctx)) {
+	if (waiter->ww_ctx->acquired > 0 && __ww_ctx_less(waiter->ww_ctx, ww_ctx)) {
 #ifndef WW_RT
 		debug_mutex_wake_waiter(lock, waiter);
 #endif
@@ -257,10 +291,10 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 }
 
 /*
- * Wound-Wait; wound a younger @hold_ctx if it holds the lock.
+ * Wound-Wait; wound a lesser @hold_ctx if it holds the lock.
  *
- * Wound the lock holder if there are waiters with older transactions than
- * the lock holders. Even if multiple waiters may wound the lock holder,
+ * Wound the lock holder if there are waiters with more important transactions
+ * than the lock holders. Even if multiple waiters may wound the lock holder,
  * it's sufficient that only one does.
  */
 static bool __ww_mutex_wound(struct MUTEX *lock,
@@ -287,7 +321,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 	if (!owner)
 		return false;
 
-	if (ww_ctx->acquired > 0 && __ww_ctx_stamp_after(hold_ctx, ww_ctx)) {
+	if (ww_ctx->acquired > 0 && __ww_ctx_less(hold_ctx, ww_ctx)) {
 		hold_ctx->wounded = 1;
 
 		/*
@@ -306,8 +340,8 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 }
 
 /*
- * We just acquired @lock under @ww_ctx, if there are later contexts waiting
- * behind us on the wait-list, check if they need to die, or wound us.
+ * We just acquired @lock under @ww_ctx, if there are more important contexts
+ * waiting behind us on the wait-list, check if they need to die, or wound us.
  *
  * See __ww_mutex_add_waiter() for the list-order construction; basically the
  * list is ordered by stamp, smallest (oldest) first.
@@ -421,7 +455,7 @@ __ww_mutex_check_kill(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		return 0;
 	}
 
-	if (hold_ctx && __ww_ctx_stamp_after(ctx, hold_ctx))
+	if (hold_ctx && __ww_ctx_less(ctx, hold_ctx))
 		return __ww_mutex_kill(lock, ctx);
 
 	/*
@@ -479,7 +513,7 @@ __ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
 		if (!cur->ww_ctx)
 			continue;
 
-		if (__ww_ctx_stamp_after(ww_ctx, cur->ww_ctx)) {
+		if (__ww_ctx_less(ww_ctx, cur->ww_ctx)) {
 			/*
 			 * Wait-Die: if we find an older context waiting, there
 			 * is no point in queueing behind it, as we'd have to
