Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C77D33F07B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 13:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhCQMig (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 08:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhCQMiY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 08:38:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926A5C06174A;
        Wed, 17 Mar 2021 05:38:24 -0700 (PDT)
Date:   Wed, 17 Mar 2021 12:38:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984703;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7oc7UYQd8W6d7uCOyFltAhXahH6XmXSFK+gkVW7MSs=;
        b=e6Yiv/TOX+7iXoK8wfaKlz3F/+xT9kcGD1R05qwSizXUYdv2p3WMfCQc96SL0cAd8USv5e
        cs2/sxVjIaNnHiNS9qXZsPK4319ui5yuSZG9OTzpDww9kpsoKTfeB0dT5qJ1dyrAEvCp18
        G4ozs+DBS8Bb/F/iHKg3JFh/oUFkC7iYewOaifERt8nkiMwHE9GUkzy53QD+UuqSeTU3lJ
        df8Tpgd49l5Q7WFri5OCjSgj7JQOHEVnmzc0N+CQBwn71DVHJiwdzkOHfVBB+QBEXH5ugD
        sN5djH7zGPbCtMzLlLgAXzpu2UVs/MGYrY7xOLMazgGw9N2QetVW5kyIi0NCsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984703;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7oc7UYQd8W6d7uCOyFltAhXahH6XmXSFK+gkVW7MSs=;
        b=G1znLlYieLg0SMOl3IpyT7DGEmRhNL63tNazm3M4/b1F/vqyL+lnlSeTNvGomOeuDOqPOC
        Ozx/0UcJsYSA7VBw==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/ww_mutex: Simplify use_ww_ctx & ww_ctx handling
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210316153119.13802-2-longman@redhat.com>
References: <20210316153119.13802-2-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <161598470257.398.5006518584847290113.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     5de2055d31ea88fd9ae9709ac95c372a505a60fa
Gitweb:        https://git.kernel.org/tip/5de2055d31ea88fd9ae9709ac95c372a505a60fa
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Tue, 16 Mar 2021 11:31:16 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Mar 2021 09:56:44 +01:00

locking/ww_mutex: Simplify use_ww_ctx & ww_ctx handling

The use_ww_ctx flag is passed to mutex_optimistic_spin(), but the
function doesn't use it. The frequent use of the (use_ww_ctx && ww_ctx)
combination is repetitive.

In fact, ww_ctx should not be used at all if !use_ww_ctx.  Simplify
ww_mutex code by dropping use_ww_ctx from mutex_optimistic_spin() an
clear ww_ctx if !use_ww_ctx. In this way, we can replace (use_ww_ctx &&
ww_ctx) by just (ww_ctx).

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Link: https://lore.kernel.org/r/20210316153119.13802-2-longman@redhat.com
---
 kernel/locking/mutex.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index adb9350..622ebdf 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -626,7 +626,7 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
  */
 static __always_inline bool
 mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
-		      const bool use_ww_ctx, struct mutex_waiter *waiter)
+		      struct mutex_waiter *waiter)
 {
 	if (!waiter) {
 		/*
@@ -702,7 +702,7 @@ fail:
 #else
 static __always_inline bool
 mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
-		      const bool use_ww_ctx, struct mutex_waiter *waiter)
+		      struct mutex_waiter *waiter)
 {
 	return false;
 }
@@ -922,6 +922,9 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	struct ww_mutex *ww;
 	int ret;
 
+	if (!use_ww_ctx)
+		ww_ctx = NULL;
+
 	might_sleep();
 
 #ifdef CONFIG_DEBUG_MUTEXES
@@ -929,7 +932,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 #endif
 
 	ww = container_of(lock, struct ww_mutex, base);
-	if (use_ww_ctx && ww_ctx) {
+	if (ww_ctx) {
 		if (unlikely(ww_ctx == READ_ONCE(ww->ctx)))
 			return -EALREADY;
 
@@ -946,10 +949,10 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
 
 	if (__mutex_trylock(lock) ||
-	    mutex_optimistic_spin(lock, ww_ctx, use_ww_ctx, NULL)) {
+	    mutex_optimistic_spin(lock, ww_ctx, NULL)) {
 		/* got the lock, yay! */
 		lock_acquired(&lock->dep_map, ip);
-		if (use_ww_ctx && ww_ctx)
+		if (ww_ctx)
 			ww_mutex_set_context_fastpath(ww, ww_ctx);
 		preempt_enable();
 		return 0;
@@ -960,7 +963,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	 * After waiting to acquire the wait_lock, try again.
 	 */
 	if (__mutex_trylock(lock)) {
-		if (use_ww_ctx && ww_ctx)
+		if (ww_ctx)
 			__ww_mutex_check_waiters(lock, ww_ctx);
 
 		goto skip_wait;
@@ -1013,7 +1016,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 			goto err;
 		}
 
-		if (use_ww_ctx && ww_ctx) {
+		if (ww_ctx) {
 			ret = __ww_mutex_check_kill(lock, &waiter, ww_ctx);
 			if (ret)
 				goto err;
@@ -1026,7 +1029,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		 * ww_mutex needs to always recheck its position since its waiter
 		 * list is not FIFO ordered.
 		 */
-		if ((use_ww_ctx && ww_ctx) || !first) {
+		if (ww_ctx || !first) {
 			first = __mutex_waiter_is_first(lock, &waiter);
 			if (first)
 				__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
@@ -1039,7 +1042,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		 * or we must see its unlock and acquire.
 		 */
 		if (__mutex_trylock(lock) ||
-		    (first && mutex_optimistic_spin(lock, ww_ctx, use_ww_ctx, &waiter)))
+		    (first && mutex_optimistic_spin(lock, ww_ctx, &waiter)))
 			break;
 
 		spin_lock(&lock->wait_lock);
@@ -1048,7 +1051,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 acquired:
 	__set_current_state(TASK_RUNNING);
 
-	if (use_ww_ctx && ww_ctx) {
+	if (ww_ctx) {
 		/*
 		 * Wound-Wait; we stole the lock (!first_waiter), check the
 		 * waiters as anyone might want to wound us.
@@ -1068,7 +1071,7 @@ skip_wait:
 	/* got the lock - cleanup and rejoice! */
 	lock_acquired(&lock->dep_map, ip);
 
-	if (use_ww_ctx && ww_ctx)
+	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
 	spin_unlock(&lock->wait_lock);
