Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292993EF345
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbhHQUOt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbhHQUOn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F9EC0617AD;
        Tue, 17 Aug 2021 13:14:10 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231248;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wy7ySavLHevfsF2krBMaZBGlEkJdUjZix8MQsdx1uO4=;
        b=FE+EgQlHXgmxecqlF5zLM2x+PsZP0RiPjtOn9AVAN3k47lHN85xtqkVTkguUxq4r9MqPGJ
        eV9iVErS0aw6KmEmT8tXNTV0N2IosZ1ud/RYH+P1vV107edrMcQLpowAuyW79e0PxusLCr
        evXJ6ROgIaeWcxUcoJ0iylKRC0GUaFt55jR87AJOjto4ZokHc6Hj/i6e4HtBnXZtvW77yS
        XeFtFDZb+lC8bwtewzGjhaZZSkLfI0nFoPe7wHXQBsegakiXN2pcm6atJxpzMF8B8KhtEK
        rqNrvJT6Sc+RR4TLNAXx/OW1kLLC/oOM9qySaTcCxFRkAhqMd11v866fWTHGUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231248;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wy7ySavLHevfsF2krBMaZBGlEkJdUjZix8MQsdx1uO4=;
        b=HGM7qkICtj+9CJQPTfgt0moaPaJL+JL22uvwss/2VHHtgH62Y6JOjLhN+xoIOYOFSxRRdE
        JDP5o8FWpOLuFLCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Add rt_mutex based lock type
 and accessors
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211304.908012566@linutronix.de>
References: <20210815211304.908012566@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923124800.25758.14253419026562761404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2408f7a3782a6bfa69a573f5408b3a9666db78ca
Gitweb:        https://git.kernel.org/tip/2408f7a3782a6bfa69a573f5408b3a9666db78ca
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 15 Aug 2021 23:28:56 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:11 +02:00

locking/ww_mutex: Add rt_mutex based lock type and accessors

Provide the defines for RT mutex based ww_mutexes and fix up the debug logic
so it's either enabled by DEBUG_MUTEXES or DEBUG_RT_MUTEXES on RT kernels.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211304.908012566@linutronix.de
---
 include/linux/ww_mutex.h  | 33 ++++++++++++++++++++++++---------
 kernel/locking/ww_mutex.h |  6 +++---
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 3438e30..29db736 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -18,11 +18,24 @@
 #define __LINUX_WW_MUTEX_H
 
 #include <linux/mutex.h>
+#include <linux/rtmutex.h>
 
+#if defined(CONFIG_DEBUG_MUTEXES) || \
+   (defined(CONFIG_PREEMPT_RT) && defined(CONFIG_DEBUG_RT_MUTEXES))
+#define DEBUG_WW_MUTEXES
+#endif
+
+#ifndef CONFIG_PREEMPT_RT
 #define WW_MUTEX_BASE			mutex
 #define ww_mutex_base_init(l,n,k)	__mutex_init(l,n,k)
 #define ww_mutex_base_trylock(l)	mutex_trylock(l)
 #define ww_mutex_base_is_locked(b)	mutex_is_locked((b))
+#else
+#define WW_MUTEX_BASE			rt_mutex
+#define ww_mutex_base_init(l,n,k)	__rt_mutex_init(l,n,k)
+#define ww_mutex_base_trylock(l)	rt_mutex_trylock(l)
+#define ww_mutex_base_is_locked(b)	rt_mutex_base_is_locked(&(b)->rtmutex)
+#endif
 
 struct ww_class {
 	atomic_long_t stamp;
@@ -36,7 +49,7 @@ struct ww_class {
 struct ww_mutex {
 	struct WW_MUTEX_BASE base;
 	struct ww_acquire_ctx *ctx;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	struct ww_class *ww_class;
 #endif
 };
@@ -47,10 +60,10 @@ struct ww_acquire_ctx {
 	unsigned int acquired;
 	unsigned short wounded;
 	unsigned short is_wait_die;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	unsigned int done_acquire;
 	struct ww_class *ww_class;
-	struct ww_mutex *contending_lock;
+	void *contending_lock;
 #endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
@@ -89,7 +102,7 @@ static inline void ww_mutex_init(struct ww_mutex *lock,
 {
 	ww_mutex_base_init(&lock->base, ww_class->mutex_name, &ww_class->mutex_key);
 	lock->ctx = NULL;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	lock->ww_class = ww_class;
 #endif
 }
@@ -126,7 +139,7 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
 	ctx->acquired = 0;
 	ctx->wounded = false;
 	ctx->is_wait_die = ww_class->is_wait_die;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	ctx->ww_class = ww_class;
 	ctx->done_acquire = 0;
 	ctx->contending_lock = NULL;
@@ -156,7 +169,7 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
  */
 static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
 {
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	lockdep_assert_held(ctx);
 
 	DEBUG_LOCKS_WARN_ON(ctx->done_acquire);
@@ -176,7 +189,7 @@ static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	mutex_release(&ctx->dep_map, _THIS_IP_);
 #endif
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	DEBUG_LOCKS_WARN_ON(ctx->acquired);
 	if (!IS_ENABLED(CONFIG_PROVE_LOCKING))
 		/*
@@ -282,7 +295,7 @@ static inline void
 ww_mutex_lock_slow(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
 	int ret;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	DEBUG_LOCKS_WARN_ON(!ctx->contending_lock);
 #endif
 	ret = ww_mutex_lock(lock, ctx);
@@ -318,7 +331,7 @@ static inline int __must_check
 ww_mutex_lock_slow_interruptible(struct ww_mutex *lock,
 				 struct ww_acquire_ctx *ctx)
 {
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	DEBUG_LOCKS_WARN_ON(!ctx->contending_lock);
 #endif
 	return ww_mutex_lock_interruptible(lock, ctx);
@@ -348,7 +361,9 @@ static inline int __must_check ww_mutex_trylock(struct ww_mutex *lock)
  */
 static inline void ww_mutex_destroy(struct ww_mutex *lock)
 {
+#ifndef CONFIG_PREEMPT_RT
 	mutex_destroy(&lock->base);
+#endif
 }
 
 /**
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 2dce4f0..56f1392 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -180,7 +180,7 @@ static inline void lockdep_assert_wait_lock_held(struct rt_mutex *lock)
 static __always_inline void
 ww_mutex_lock_acquired(struct ww_mutex *ww, struct ww_acquire_ctx *ww_ctx)
 {
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	/*
 	 * If this WARN_ON triggers, you used ww_mutex_lock to acquire,
 	 * but released with a normal mutex_unlock in this call.
@@ -413,7 +413,7 @@ static __always_inline int
 __ww_mutex_kill(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
 {
 	if (ww_ctx->acquired > 0) {
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 		struct ww_mutex *ww;
 
 		ww = container_of(lock, struct ww_mutex, base);
@@ -559,7 +559,7 @@ __ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
 static inline void __ww_mutex_unlock(struct ww_mutex *lock)
 {
 	if (lock->ctx) {
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 		DEBUG_LOCKS_WARN_ON(!lock->ctx->acquired);
 #endif
 		if (lock->ctx->acquired > 0)
