Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30B62CD3D1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 11:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389017AbgLCKgm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 05:36:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40042 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730152AbgLCKg2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 05:36:28 -0500
Date:   Thu, 03 Dec 2020 10:35:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606991745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jb9PXDUd/ZJXnrfqEAiBDSdWlVXGbZUl/rv3nJqMwIk=;
        b=ahm8x6tXU2C4Umyx30ne+WfHHs5RH1hK6Wn5Lup3Vq471oQWxJikb2qrpmo+b9BVYMWO01
        5j1sRWrM6RT3nGMU9Q8tXdigKEhbNbWoASRDE75oGdq68mqdc0ZAvV25WaXDJhRz8zowJh
        qIO3YhjAxyy2KdhxCt4Pa1ZsxeoyfvEHERIhCQWYcX5mv37e+sQ+2MaqJVZLn7M3SCSDnC
        ea3e1efRwttsfXqQ1Ugi11L5kjCNmXv1jWxWCNw+nb5LDTG0CEkEQ2y33vSOzadod2QQH+
        WwxCV8jbu9IlLihGixF2yXEoh2IUkzlqd9nWK4oNCMLV25wCoERWHzlFQaj9Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606991745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jb9PXDUd/ZJXnrfqEAiBDSdWlVXGbZUl/rv3nJqMwIk=;
        b=OTqr/kUwrR2LCvYJtP670dxGwV0JWICAmnj2vaKvaaC9ZK8hQZI7PuXfXqPU3cgzc/hJ2W
        bxl6SMl7PFynSbAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep/selftests: Fix PROVE_RAW_LOCK_NESTING
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160699174476.3364.2618787050636820701.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a2e9ae58d5042b3aa4a61f676ff6975ff3bc7bc7
Gitweb:        https://git.kernel.org/tip/a2e9ae58d5042b3aa4a61f676ff6975ff3bc7bc7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 30 Oct 2020 12:37:43 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 11:20:50 +01:00

lockdep/selftests: Fix PROVE_RAW_LOCK_NESTING

The selftest nests rwlock_t inside raw_spinlock_t, this is invalid.

Reported-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/locking-selftest.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index a899b3f..afa7d4b 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -58,10 +58,10 @@ static struct ww_mutex o, o2, o3;
  * Normal standalone locks, for the circular and irq-context
  * dependency tests:
  */
-static DEFINE_RAW_SPINLOCK(lock_A);
-static DEFINE_RAW_SPINLOCK(lock_B);
-static DEFINE_RAW_SPINLOCK(lock_C);
-static DEFINE_RAW_SPINLOCK(lock_D);
+static DEFINE_SPINLOCK(lock_A);
+static DEFINE_SPINLOCK(lock_B);
+static DEFINE_SPINLOCK(lock_C);
+static DEFINE_SPINLOCK(lock_D);
 
 static DEFINE_RWLOCK(rwlock_A);
 static DEFINE_RWLOCK(rwlock_B);
@@ -93,12 +93,12 @@ static DEFINE_RT_MUTEX(rtmutex_D);
  * but X* and Y* are different classes. We do this so that
  * we do not trigger a real lockup:
  */
-static DEFINE_RAW_SPINLOCK(lock_X1);
-static DEFINE_RAW_SPINLOCK(lock_X2);
-static DEFINE_RAW_SPINLOCK(lock_Y1);
-static DEFINE_RAW_SPINLOCK(lock_Y2);
-static DEFINE_RAW_SPINLOCK(lock_Z1);
-static DEFINE_RAW_SPINLOCK(lock_Z2);
+static DEFINE_SPINLOCK(lock_X1);
+static DEFINE_SPINLOCK(lock_X2);
+static DEFINE_SPINLOCK(lock_Y1);
+static DEFINE_SPINLOCK(lock_Y2);
+static DEFINE_SPINLOCK(lock_Z1);
+static DEFINE_SPINLOCK(lock_Z2);
 
 static DEFINE_RWLOCK(rwlock_X1);
 static DEFINE_RWLOCK(rwlock_X2);
@@ -138,10 +138,10 @@ static DEFINE_RT_MUTEX(rtmutex_Z2);
  */
 #define INIT_CLASS_FUNC(class) 				\
 static noinline void					\
-init_class_##class(raw_spinlock_t *lock, rwlock_t *rwlock, \
+init_class_##class(spinlock_t *lock, rwlock_t *rwlock, \
 	struct mutex *mutex, struct rw_semaphore *rwsem)\
 {							\
-	raw_spin_lock_init(lock);			\
+	spin_lock_init(lock);			\
 	rwlock_init(rwlock);				\
 	mutex_init(mutex);				\
 	init_rwsem(rwsem);				\
@@ -210,10 +210,10 @@ static void init_shared_classes(void)
  * Shortcuts for lock/unlock API variants, to keep
  * the testcases compact:
  */
-#define L(x)			raw_spin_lock(&lock_##x)
-#define U(x)			raw_spin_unlock(&lock_##x)
+#define L(x)			spin_lock(&lock_##x)
+#define U(x)			spin_unlock(&lock_##x)
 #define LU(x)			L(x); U(x)
-#define SI(x)			raw_spin_lock_init(&lock_##x)
+#define SI(x)			spin_lock_init(&lock_##x)
 
 #define WL(x)			write_lock(&rwlock_##x)
 #define WU(x)			write_unlock(&rwlock_##x)
@@ -1341,7 +1341,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_wlock)
 
 #define I2(x)					\
 	do {					\
-		raw_spin_lock_init(&lock_##x);	\
+		spin_lock_init(&lock_##x);	\
 		rwlock_init(&rwlock_##x);	\
 		mutex_init(&mutex_##x);		\
 		init_rwsem(&rwsem_##x);		\
@@ -2005,7 +2005,7 @@ static void ww_test_edeadlk_acquire_wrong_slow(void)
 
 static void ww_test_spin_nest_unlocked(void)
 {
-	raw_spin_lock_nest_lock(&lock_A, &o.base);
+	spin_lock_nest_lock(&lock_A, &o.base);
 	U(A);
 }
 
