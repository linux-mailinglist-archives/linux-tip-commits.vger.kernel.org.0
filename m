Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271A73EF353
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbhHQUO5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34620 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbhHQUOu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:50 -0400
Date:   Tue, 17 Aug 2021 20:14:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yY2xc8gK7rdDmZkiX5HNLqpAQ8Jc/mlzluzaKHvqykA=;
        b=CC+/XttfVZbNhoLB5Z3dbBJ+6cPjpBVwCs+jk6okTGAuZQx6G0DAWEVDhFXo28ryXM54LY
        4mwavBd86rvTNVfbpyXjp6UeeQ4dpryXI6vjCH/HQEI0bKCT5Lzc92OUeMkgRzATdig+Fu
        ImmqCxy+1TajOjlYKfH5Q2cY5a4YuuIkCzu4JVHHc7rsEkNfWByShvb0p/OX1JyXMw1+YA
        FMuFTf/G4e52EHBwTegmlvoHdqsmqVWEBMdVqdG2JvQ52CWOWG6XAN+coWmupaLbMgVDgk
        egDV3t/8zxlxhRT9FHVDO3KvCjOTsXB1me0cbYa5SM6o+nzyoMSs/9cBJemrOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yY2xc8gK7rdDmZkiX5HNLqpAQ8Jc/mlzluzaKHvqykA=;
        b=6sG2TywtAMkd2ZTqVgSpBOj1z1pKw6raeW7gWQQuvn9NDbAkXRUfAl94/vk/CsypWCI2R5
        QvzeOIOiSBmy8FCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Simplify lockdep annotations
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211304.222921634@linutronix.de>
References: <20210815211304.222921634@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923125517.25758.13445491665048883484.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     cf702eddcd03dca3184947170930bf284aea27e9
Gitweb:        https://git.kernel.org/tip/cf702eddcd03dca3184947170930bf284aea27e9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 15 Aug 2021 23:28:38 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:04:28 +02:00

locking/ww_mutex: Simplify lockdep annotations

No functional change.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211304.222921634@linutronix.de
---
 kernel/locking/mutex.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 17c194b..73ad862 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -951,6 +951,10 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		 */
 		if (ww_ctx->acquired == 0)
 			ww_ctx->wounded = 0;
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+		nest_lock = &ww_ctx->dep_map;
+#endif
 	}
 
 	preempt_disable();
@@ -1098,10 +1102,9 @@ __mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
 
 static int __sched
 __ww_mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
-		struct lockdep_map *nest_lock, unsigned long ip,
-		struct ww_acquire_ctx *ww_ctx)
+		unsigned long ip, struct ww_acquire_ctx *ww_ctx)
 {
-	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, ww_ctx, true);
+	return __mutex_lock_common(lock, state, subclass, NULL, ip, ww_ctx, true);
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -1181,8 +1184,7 @@ ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 
 	might_sleep();
 	ret =  __ww_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE,
-			       0, ctx ? &ctx->dep_map : NULL, _RET_IP_,
-			       ctx);
+			       0, _RET_IP_, ctx);
 	if (!ret && ctx && ctx->acquired > 1)
 		return ww_mutex_deadlock_injection(lock, ctx);
 
@@ -1197,8 +1199,7 @@ ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 
 	might_sleep();
 	ret = __ww_mutex_lock(&lock->base, TASK_INTERRUPTIBLE,
-			      0, ctx ? &ctx->dep_map : NULL, _RET_IP_,
-			      ctx);
+			      0, _RET_IP_, ctx);
 
 	if (!ret && ctx && ctx->acquired > 1)
 		return ww_mutex_deadlock_injection(lock, ctx);
@@ -1364,7 +1365,7 @@ __mutex_lock_interruptible_slowpath(struct mutex *lock)
 static noinline int __sched
 __ww_mutex_lock_slowpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
-	return __ww_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE, 0, NULL,
+	return __ww_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE, 0,
 			       _RET_IP_, ctx);
 }
 
@@ -1372,7 +1373,7 @@ static noinline int __sched
 __ww_mutex_lock_interruptible_slowpath(struct ww_mutex *lock,
 					    struct ww_acquire_ctx *ctx)
 {
-	return __ww_mutex_lock(&lock->base, TASK_INTERRUPTIBLE, 0, NULL,
+	return __ww_mutex_lock(&lock->base, TASK_INTERRUPTIBLE, 0,
 			       _RET_IP_, ctx);
 }
 
