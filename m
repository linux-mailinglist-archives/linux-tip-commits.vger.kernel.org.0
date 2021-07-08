Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D573BF6F7
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Jul 2021 10:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhGHIpT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Jul 2021 04:45:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50168 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhGHIpR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Jul 2021 04:45:17 -0400
Date:   Thu, 08 Jul 2021 08:42:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625733755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LJCeU4IrOt6mkOdccmtuDW8xJdFF+XTU0UUC3g04gWk=;
        b=oceRwLuXGWa/srz70UqmZvYmuLF+Ul9749ZcjXyeYnu4vq1cqTnlIyAjZKC/qZ1HtmSzWT
        2fXsUUDOl0A7p6sQaLqmT+FTf3ltQONL3uYxDhTZUAwXC2xBlKEqIKeBbupG6jLnAooekD
        IfGU+9C9CCEFpKAcxqb/zn/ofsHbblO9iI09zd5gNjMOp4EvyrIi8mC8R4XC62BDJu9mc0
        HeiG1A97HYdADN9YWzKgi65hgIpVFdGwuFKfjmrz38QWqOiDpoUZSG3rybqONuKdFpiRr8
        bp1/uCTDn+Tzll9c5WkjlEA9aDldXVJEDL4h1WGy4hXP0KNiaXipRrCd23nidQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625733755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LJCeU4IrOt6mkOdccmtuDW8xJdFF+XTU0UUC3g04gWk=;
        b=ekTWa3xia+56mZfje2YOOgbAToYF0cEes+a3kyQazvMSTPnOPemZE7le+w0tVWikiTiILg
        jN2DVb1PcKZ5pSDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Add MUTEX_WARN_ON
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Yanfei Xu <yanfei.xu@windriver.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210630154115.020298650@infradead.org>
References: <20210630154115.020298650@infradead.org>
MIME-Version: 1.0
Message-ID: <162573375442.395.6170610162030878254.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e6b4457b05f36bb9e371f29ab1dd2d97272a1540
Gitweb:        https://git.kernel.org/tip/e6b4457b05f36bb9e371f29ab1dd2d97272a1540
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 30 Jun 2021 17:35:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Jul 2021 13:53:25 +02:00

locking/mutex: Add MUTEX_WARN_ON

Cleanup some #ifdef'fery.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Yanfei Xu <yanfei.xu@windriver.com>
Link: https://lore.kernel.org/r/20210630154115.020298650@infradead.org
---
 kernel/locking/mutex.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index b81ec97..633bf0d 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -32,8 +32,10 @@
 
 #ifdef CONFIG_DEBUG_MUTEXES
 # include "mutex-debug.h"
+# define MUTEX_WARN_ON(cond) DEBUG_LOCKS_WARN_ON(cond)
 #else
 # include "mutex.h"
+# define MUTEX_WARN_ON(cond)
 #endif
 
 void
@@ -113,9 +115,7 @@ static inline struct task_struct *__mutex_trylock_common(struct mutex *lock, boo
 				break;
 			}
 		} else {
-#ifdef CONFIG_DEBUG_MUTEXES
-			DEBUG_LOCKS_WARN_ON(flags & (MUTEX_FLAG_HANDOFF | MUTEX_FLAG_PICKUP));
-#endif
+			MUTEX_WARN_ON(flags & (MUTEX_FLAG_HANDOFF | MUTEX_FLAG_PICKUP));
 			task = curr;
 		}
 
@@ -218,10 +218,8 @@ static void __mutex_handoff(struct mutex *lock, struct task_struct *task)
 	for (;;) {
 		unsigned long new;
 
-#ifdef CONFIG_DEBUG_MUTEXES
-		DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current);
-		DEBUG_LOCKS_WARN_ON(owner & MUTEX_FLAG_PICKUP);
-#endif
+		MUTEX_WARN_ON(__owner_task(owner) != current);
+		MUTEX_WARN_ON(owner & MUTEX_FLAG_PICKUP);
 
 		new = (owner & MUTEX_FLAG_WAITERS);
 		new |= (unsigned long)task;
@@ -754,9 +752,7 @@ void __sched ww_mutex_unlock(struct ww_mutex *lock)
 	 * into 'unlocked' state:
 	 */
 	if (lock->ctx) {
-#ifdef CONFIG_DEBUG_MUTEXES
-		DEBUG_LOCKS_WARN_ON(!lock->ctx->acquired);
-#endif
+		MUTEX_WARN_ON(!lock->ctx->acquired);
 		if (lock->ctx->acquired > 0)
 			lock->ctx->acquired--;
 		lock->ctx = NULL;
@@ -931,9 +927,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 
 	might_sleep();
 
-#ifdef CONFIG_DEBUG_MUTEXES
-	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
-#endif
+	MUTEX_WARN_ON(lock->magic != lock);
 
 	ww = container_of(lock, struct ww_mutex, base);
 	if (ww_ctx) {
@@ -1227,10 +1221,8 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	 */
 	owner = atomic_long_read(&lock->owner);
 	for (;;) {
-#ifdef CONFIG_DEBUG_MUTEXES
-		DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current);
-		DEBUG_LOCKS_WARN_ON(owner & MUTEX_FLAG_PICKUP);
-#endif
+		MUTEX_WARN_ON(__owner_task(owner) != current);
+		MUTEX_WARN_ON(owner & MUTEX_FLAG_PICKUP);
 
 		if (owner & MUTEX_FLAG_HANDOFF)
 			break;
@@ -1396,9 +1388,7 @@ int __sched mutex_trylock(struct mutex *lock)
 {
 	bool locked;
 
-#ifdef CONFIG_DEBUG_MUTEXES
-	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
-#endif
+	MUTEX_WARN_ON(lock->magic != lock);
 
 	locked = __mutex_trylock(lock);
 	if (locked)
