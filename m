Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1D0345300
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 00:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhCVXad (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 22 Mar 2021 19:30:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57118 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhCVXaK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 22 Mar 2021 19:30:10 -0400
Date:   Mon, 22 Mar 2021 23:30:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616455808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6qpoETrLH6F2FM7sQD5UILM3RWz1c3tqhKamEgY30A=;
        b=FIPcDogexnwrop6DFAwsHeQAAuJIiPoMeoLKqig/wTiJodvpwmudIegvjc0T8pUGXUBTN9
        jYhLwzZaYTV/ne57pvE+bKQFY/Rza1b23WBOiiVlu4L1APGAFNIkPm9WYrD/TYWZT0AZ4I
        m9FMIWM6pCWMawZMgVf0OlvYySpTlCwHiSmG5yLw+twymi17hgxnloRsHlHTD7g417YoV5
        QTitN2X8Tkou3zCnLmNFGV9lVwlJT4WDdRT9mIMsh1TjYNa75jzkZLv78bbpLG4+bWPIJa
        wzqUD/86gBMu/VhP4hVtZon3ZWyO0LYNQAr5Aj2cN2n8/eyxlVTqLli4i6WafA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616455808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6qpoETrLH6F2FM7sQD5UILM3RWz1c3tqhKamEgY30A=;
        b=ZqlUdY2riyrXGgW1+20CprLXd9UHeEjc3MbEBm6XBzKMdEweFVwmCGgmTE8EciF7V132/P
        WWJ7p1DB1QULp7Bg==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] static_call: Fix function type mismatch
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210322214309.730556-1-arnd@kernel.org>
References: <20210322214309.730556-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <161645580767.398.731817901273202970.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     335c73e7c8f7deb23537afbbbe4f8ab48bd5de52
Gitweb:        https://git.kernel.org/tip/335c73e7c8f7deb23537afbbbe4f8ab48bd5de52
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 22 Mar 2021 22:42:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 23 Mar 2021 00:08:53 +01:00

static_call: Fix function type mismatch

The __static_call_return0() function is declared to return a 'long',
while it aliases a couple of functions that all return 'int'. When
building with 'make W=1', gcc warns about this:

  kernel/sched/core.c:5420:37: error: cast between incompatible function types from 'long int (*)(void)' to 'int (*)(void)' [-Werror=cast-function-type]
   5420 |   static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);

Change all these function to return 'long' as well, but remove the cast to
ensure we get a warning if any of the types ever change.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210322214309.730556-1-arnd@kernel.org
---
 include/linux/kernel.h |  4 ++--
 include/linux/sched.h  | 14 +++++++-------
 kernel/sched/core.c    |  8 ++++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5b7ed6d..db24f8c 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -82,12 +82,12 @@ struct user;
 
 #ifdef CONFIG_PREEMPT_VOLUNTARY
 
-extern int __cond_resched(void);
+extern long __cond_resched(void);
 # define might_resched() __cond_resched()
 
 #elif defined(CONFIG_PREEMPT_DYNAMIC)
 
-extern int __cond_resched(void);
+extern long __cond_resched(void);
 
 DECLARE_STATIC_CALL(might_resched, __cond_resched);
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ef00bb2..b08080d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1875,20 +1875,20 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
  * cond_resched_lock() will drop the spinlock before scheduling,
  */
 #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
-extern int __cond_resched(void);
+extern long __cond_resched(void);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
 DECLARE_STATIC_CALL(cond_resched, __cond_resched);
 
-static __always_inline int _cond_resched(void)
+static __always_inline long _cond_resched(void)
 {
 	return static_call_mod(cond_resched)();
 }
 
 #else
 
-static inline int _cond_resched(void)
+static inline long _cond_resched(void)
 {
 	return __cond_resched();
 }
@@ -1897,7 +1897,7 @@ static inline int _cond_resched(void)
 
 #else
 
-static inline int _cond_resched(void) { return 0; }
+static inline long _cond_resched(void) { return 0; }
 
 #endif /* !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC) */
 
@@ -1906,9 +1906,9 @@ static inline int _cond_resched(void) { return 0; }
 	_cond_resched();			\
 })
 
-extern int __cond_resched_lock(spinlock_t *lock);
-extern int __cond_resched_rwlock_read(rwlock_t *lock);
-extern int __cond_resched_rwlock_write(rwlock_t *lock);
+extern long __cond_resched_lock(spinlock_t *lock);
+extern long __cond_resched_rwlock_read(rwlock_t *lock);
+extern long __cond_resched_rwlock_write(rwlock_t *lock);
 
 #define cond_resched_lock(lock) ({				\
 	___might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);\
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9819121..927fd82 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6976,7 +6976,7 @@ SYSCALL_DEFINE0(sched_yield)
 }
 
 #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
-int __sched __cond_resched(void)
+long __sched __cond_resched(void)
 {
 	if (should_resched(0)) {
 		preempt_schedule_common();
@@ -7006,7 +7006,7 @@ EXPORT_STATIC_CALL_TRAMP(might_resched);
  * operations here to prevent schedule() from being called twice (once via
  * spin_unlock(), once by hand).
  */
-int __cond_resched_lock(spinlock_t *lock)
+long __cond_resched_lock(spinlock_t *lock)
 {
 	int resched = should_resched(PREEMPT_LOCK_OFFSET);
 	int ret = 0;
@@ -7026,7 +7026,7 @@ int __cond_resched_lock(spinlock_t *lock)
 }
 EXPORT_SYMBOL(__cond_resched_lock);
 
-int __cond_resched_rwlock_read(rwlock_t *lock)
+long __cond_resched_rwlock_read(rwlock_t *lock)
 {
 	int resched = should_resched(PREEMPT_LOCK_OFFSET);
 	int ret = 0;
@@ -7046,7 +7046,7 @@ int __cond_resched_rwlock_read(rwlock_t *lock)
 }
 EXPORT_SYMBOL(__cond_resched_rwlock_read);
 
-int __cond_resched_rwlock_write(rwlock_t *lock)
+long __cond_resched_rwlock_write(rwlock_t *lock)
 {
 	int resched = should_resched(PREEMPT_LOCK_OFFSET);
 	int ret = 0;
