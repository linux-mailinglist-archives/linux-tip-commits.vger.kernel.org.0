Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C9E3BF6FB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Jul 2021 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhGHIpV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Jul 2021 04:45:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50206 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhGHIpT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Jul 2021 04:45:19 -0400
Date:   Thu, 08 Jul 2021 08:42:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625733756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DcVliIRC5ZvODmWJUoFyF+Y+gGNDIorQYpII2ZqIcYQ=;
        b=OqGOR33lS53Zt1ZsSzvUEPWCA/PWmY6xR52+EV5hhcUo5cBq/JJv29iAOMXz3miDr5G2N0
        Yalxq0osn/tK+JL/WBFT4xt290NURa1RfG5cusmxaetf6LPv2UH9/jdjl58+wyqgBKYGF2
        CAL1uiLS7CVksfTnqaorpV9G9bv93gumR24yiZyTXM7cCrXs6+RP+/oGK8PgKRDDv6b/6u
        l3ymbDQVHZPnw1UtnHXCJOtTs6fsZGG5lor2CpyhYMSf6yYKMzEFgdvdK6ozbgeuRD0Fh1
        KoMAZ/P9lly4+AC78dDGSMooYeEHzQA8pNjdg2+0n6NNNFCQ8ZJb4+AiFEZfVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625733756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DcVliIRC5ZvODmWJUoFyF+Y+gGNDIorQYpII2ZqIcYQ=;
        b=lmvs33n6syJ0958hxisQ2sCMrp+CW0uMQt2qUR+QwM+b50YK0MxSbZMessTIeltrq7+L7a
        pPUCRVTRIEoyFvAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Use try_cmpxchg()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Yanfei Xu <yanfei.xu@windriver.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210630154114.834438545@infradead.org>
References: <20210630154114.834438545@infradead.org>
MIME-Version: 1.0
Message-ID: <162573375592.395.17270740953253800450.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ab4e4d9f79b2c95ef268985d2a9625a03a73c49a
Gitweb:        https://git.kernel.org/tip/ab4e4d9f79b2c95ef268985d2a9625a03a73c49a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 30 Jun 2021 17:35:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Jul 2021 13:53:24 +02:00

locking/mutex: Use try_cmpxchg()

For simpler and better code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Yanfei Xu <yanfei.xu@windriver.com>
Link: https://lore.kernel.org/r/20210630154114.834438545@infradead.org
---
 kernel/locking/mutex.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cb6b112..cab7163 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -100,7 +100,7 @@ static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
 
 	owner = atomic_long_read(&lock->owner);
 	for (;;) { /* must loop, can race against a flag */
-		unsigned long old, flags = __owner_flags(owner);
+		unsigned long flags = __owner_flags(owner);
 		unsigned long task = owner & ~MUTEX_FLAGS;
 
 		if (task) {
@@ -124,11 +124,8 @@ static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
 		 */
 		flags &= ~MUTEX_FLAG_HANDOFF;
 
-		old = atomic_long_cmpxchg_acquire(&lock->owner, owner, curr | flags);
-		if (old == owner)
+		if (atomic_long_try_cmpxchg_acquire(&lock->owner, &owner, curr | flags))
 			return NULL;
-
-		owner = old;
 	}
 
 	return __owner_task(owner);
@@ -168,10 +165,7 @@ static __always_inline bool __mutex_unlock_fast(struct mutex *lock)
 {
 	unsigned long curr = (unsigned long)current;
 
-	if (atomic_long_cmpxchg_release(&lock->owner, curr, 0UL) == curr)
-		return true;
-
-	return false;
+	return atomic_long_try_cmpxchg_release(&lock->owner, &curr, 0UL);
 }
 #endif
 
@@ -216,7 +210,7 @@ static void __mutex_handoff(struct mutex *lock, struct task_struct *task)
 	unsigned long owner = atomic_long_read(&lock->owner);
 
 	for (;;) {
-		unsigned long old, new;
+		unsigned long new;
 
 #ifdef CONFIG_DEBUG_MUTEXES
 		DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current);
@@ -228,11 +222,8 @@ static void __mutex_handoff(struct mutex *lock, struct task_struct *task)
 		if (task)
 			new |= MUTEX_FLAG_PICKUP;
 
-		old = atomic_long_cmpxchg_release(&lock->owner, owner, new);
-		if (old == owner)
+		if (atomic_long_try_cmpxchg_release(&lock->owner, &owner, new))
 			break;
-
-		owner = old;
 	}
 }
 
@@ -1229,8 +1220,6 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	 */
 	owner = atomic_long_read(&lock->owner);
 	for (;;) {
-		unsigned long old;
-
 #ifdef CONFIG_DEBUG_MUTEXES
 		DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current);
 		DEBUG_LOCKS_WARN_ON(owner & MUTEX_FLAG_PICKUP);
@@ -1239,16 +1228,12 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		if (owner & MUTEX_FLAG_HANDOFF)
 			break;
 
-		old = atomic_long_cmpxchg_release(&lock->owner, owner,
-						  __owner_flags(owner));
-		if (old == owner) {
+		if (atomic_long_try_cmpxchg_release(&lock->owner, &owner, __owner_flags(owner))) {
 			if (owner & MUTEX_FLAG_WAITERS)
 				break;
 
 			return;
 		}
-
-		owner = old;
 	}
 
 	spin_lock(&lock->wait_lock);
