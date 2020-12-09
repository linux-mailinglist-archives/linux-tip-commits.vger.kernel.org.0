Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F482D4938
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbgLISjr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733044AbgLISjc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:39:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D852C061794;
        Wed,  9 Dec 2020 10:38:52 -0800 (PST)
Date:   Wed, 09 Dec 2020 18:38:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ykuuADfa5Pc7iAimMqBPavZD1tfeQyEkHktEjVPlayI=;
        b=XNbhY5nD9Zx1zFHB3gA613H1vefonHvkXTn4+vYk7dSBWlUd89XVbI0Kh4GoFI4w2dhmtG
        cafT2W6gZYbkykVfJ7u1OCI6YVcl6Ewk2Eq+Rkw+A63g+ZaVFkucOkGmmQoUoAy4sSVIFh
        jiuJtLvjCAk7JkCgHEie9wF8o2GRZvNss8WJvGLylCYFhXNDcmh/OYqaWzwKM1dRJhP9WB
        9UdjBNkpQoK6yDnSLJRUBM+bVsJr8mGPlIvSx9ACDQt+LUiYJjJzxcvoeQT2f7/X6j6rSg
        wlpfK2Ey7MnLO7DfsXjPkDZNFlGby4N4xum/KBWeNdTy3+ZpchdsbgNBBMFgnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ykuuADfa5Pc7iAimMqBPavZD1tfeQyEkHktEjVPlayI=;
        b=X8cjxk0WTg9gfxaXYhqK/Oc9thZvBrzY4v0nLgKjOHC3u0BKBH71o7HKFqamkpasUGg0yj
        RfyprkohdNXCE5BA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Introduce rwsem_write_trylock()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201207090243.GE3040@hirez.programming.kicks-ass.net>
References: <20201207090243.GE3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160753912849.3364.5418908733944209234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     285c61aedf6bc5d81b37e4dc48c19012e8ff9836
Gitweb:        https://git.kernel.org/tip/285c61aedf6bc5d81b37e4dc48c19012e8ff9836
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Dec 2020 10:25:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:47 +01:00

locking/rwsem: Introduce rwsem_write_trylock()

One copy of this logic is better than three.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201207090243.GE3040@hirez.programming.kicks-ass.net
---
 kernel/locking/rwsem.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 5c0dc7e..7915456 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -285,6 +285,18 @@ static inline bool rwsem_read_trylock(struct rw_semaphore *sem)
 	return false;
 }
 
+static inline bool rwsem_write_trylock(struct rw_semaphore *sem)
+{
+	long tmp = RWSEM_UNLOCKED_VALUE;
+
+	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp, RWSEM_WRITER_LOCKED)) {
+		rwsem_set_owner(sem);
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * Return just the real task structure pointer of the owner
  */
@@ -1395,42 +1407,24 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
  */
 static inline void __down_write(struct rw_semaphore *sem)
 {
-	long tmp = RWSEM_UNLOCKED_VALUE;
-
-	if (unlikely(!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
-						      RWSEM_WRITER_LOCKED)))
+	if (unlikely(!rwsem_write_trylock(sem)))
 		rwsem_down_write_slowpath(sem, TASK_UNINTERRUPTIBLE);
-	else
-		rwsem_set_owner(sem);
 }
 
 static inline int __down_write_killable(struct rw_semaphore *sem)
 {
-	long tmp = RWSEM_UNLOCKED_VALUE;
-
-	if (unlikely(!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
-						      RWSEM_WRITER_LOCKED))) {
+	if (unlikely(!rwsem_write_trylock(sem))) {
 		if (IS_ERR(rwsem_down_write_slowpath(sem, TASK_KILLABLE)))
 			return -EINTR;
-	} else {
-		rwsem_set_owner(sem);
 	}
+
 	return 0;
 }
 
 static inline int __down_write_trylock(struct rw_semaphore *sem)
 {
-	long tmp;
-
 	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
-
-	tmp  = RWSEM_UNLOCKED_VALUE;
-	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
-					    RWSEM_WRITER_LOCKED)) {
-		rwsem_set_owner(sem);
-		return true;
-	}
-	return false;
+	return rwsem_write_trylock(sem);
 }
 
 /*
