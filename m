Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E773EF349
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbhHQUOw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhHQUOr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052D1C0617AF;
        Tue, 17 Aug 2021 13:14:12 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231250;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GEoLY1jYpaOs30K/3U1BO+yv9sjmj5X5JKLD2cCFOqY=;
        b=br3gDhCCg3UKSfZtBWf5SfuaeNt0BDjS5kLJdiq1S43zbMBOkyuJTwS8wyFQx9J/QJEK/D
        tG2ZI6pLA0f1Y2z9pBd4OWhWt0phD1lnzhAQMZO8dG9hUNoTHUjX0t6YgvSXZ6gCKuI0Aa
        5QrD70wcsGfzzMNoLInuYTaScrbRygoLS+Lm7qQzHN4NZZTvMUpY3+m1Pa/bdynJODK1Ce
        /F7wqvdv6P1mMThXIOtAwNUntBzHjM8PHkdysbfRYUBRmraT1+S/nu5PnwfAm+TTW1Y1/M
        oZnjac2zGqEhdmVfUQhW5DXaLTjoA8hzpxT5enF3g24F6s1fNflon9mapoUjuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231250;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GEoLY1jYpaOs30K/3U1BO+yv9sjmj5X5JKLD2cCFOqY=;
        b=6erq1rPtmFlrl5lwvDech8xtim3p6UyWGSwdSYj1pKVv1Haf+UUtHYRBqUffOVXqk2x/37
        81/Dw6h9BNeXDMDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Abstract out internal lock accesses
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211304.734635961@linutronix.de>
References: <20210815211304.734635961@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923124996.25758.6115725413992769511.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     653a5b0bd9b405db999d5f4bfe08d34691e2c55a
Gitweb:        https://git.kernel.org/tip/653a5b0bd9b405db999d5f4bfe08d34691e2c55a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:52 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:03 +02:00

locking/ww_mutex: Abstract out internal lock accesses

Accessing the internal wait_lock of mutex and rtmutex is slightly
different. Provide helper functions for that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211304.734635961@linutronix.de
---
 include/linux/ww_mutex.h  | 13 +++++++++----
 kernel/locking/ww_mutex.h | 23 +++++++++++++++++++----
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 590aaa2..3438e30 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -19,6 +19,11 @@
 
 #include <linux/mutex.h>
 
+#define WW_MUTEX_BASE			mutex
+#define ww_mutex_base_init(l,n,k)	__mutex_init(l,n,k)
+#define ww_mutex_base_trylock(l)	mutex_trylock(l)
+#define ww_mutex_base_is_locked(b)	mutex_is_locked((b))
+
 struct ww_class {
 	atomic_long_t stamp;
 	struct lock_class_key acquire_key;
@@ -29,7 +34,7 @@ struct ww_class {
 };
 
 struct ww_mutex {
-	struct mutex base;
+	struct WW_MUTEX_BASE base;
 	struct ww_acquire_ctx *ctx;
 #ifdef CONFIG_DEBUG_MUTEXES
 	struct ww_class *ww_class;
@@ -82,7 +87,7 @@ struct ww_acquire_ctx {
 static inline void ww_mutex_init(struct ww_mutex *lock,
 				 struct ww_class *ww_class)
 {
-	__mutex_init(&lock->base, ww_class->mutex_name, &ww_class->mutex_key);
+	ww_mutex_base_init(&lock->base, ww_class->mutex_name, &ww_class->mutex_key);
 	lock->ctx = NULL;
 #ifdef CONFIG_DEBUG_MUTEXES
 	lock->ww_class = ww_class;
@@ -330,7 +335,7 @@ extern void ww_mutex_unlock(struct ww_mutex *lock);
  */
 static inline int __must_check ww_mutex_trylock(struct ww_mutex *lock)
 {
-	return mutex_trylock(&lock->base);
+	return ww_mutex_base_trylock(&lock->base);
 }
 
 /***
@@ -354,7 +359,7 @@ static inline void ww_mutex_destroy(struct ww_mutex *lock)
  */
 static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
 {
-	return mutex_is_locked(&lock->base);
+	return ww_mutex_base_is_locked(&lock->base);
 }
 
 #endif
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 31b075f..309f3e4 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -68,6 +68,21 @@ __ww_mutex_has_waiters(struct mutex *lock)
 	return atomic_long_read(&lock->owner) & MUTEX_FLAG_WAITERS;
 }
 
+static inline void lock_wait_lock(struct mutex *lock)
+{
+	raw_spin_lock(&lock->wait_lock);
+}
+
+static inline void unlock_wait_lock(struct mutex *lock)
+{
+	raw_spin_unlock(&lock->wait_lock);
+}
+
+static inline void lockdep_assert_wait_lock_held(struct mutex *lock)
+{
+	lockdep_assert_held(&lock->wait_lock);
+}
+
 /*
  * Wait-Die:
  *   The newer transactions are killed when:
@@ -174,7 +189,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 {
 	struct task_struct *owner = __ww_mutex_owner(lock);
 
-	lockdep_assert_held(&lock->wait_lock);
+	lockdep_assert_wait_lock_held(lock);
 
 	/*
 	 * Possible through __ww_mutex_add_waiter() when we race with
@@ -227,7 +242,7 @@ __ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
 {
 	struct MUTEX_WAITER *cur;
 
-	lockdep_assert_held(&lock->wait_lock);
+	lockdep_assert_wait_lock_held(lock);
 
 	for (cur = __ww_waiter_first(lock); cur;
 	     cur = __ww_waiter_next(lock, cur)) {
@@ -275,9 +290,9 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * Uh oh, we raced in fastpath, check if any of the waiters need to
 	 * die or wound us.
 	 */
-	raw_spin_lock(&lock->base.wait_lock);
+	lock_wait_lock(&lock->base);
 	__ww_mutex_check_waiters(&lock->base, ctx);
-	raw_spin_unlock(&lock->base.wait_lock);
+	unlock_wait_lock(&lock->base);
 }
 
 static __always_inline int
