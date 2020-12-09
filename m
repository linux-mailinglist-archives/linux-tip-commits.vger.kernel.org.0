Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D602D493C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbgLISjq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733046AbgLISjc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:39:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DADCC06179C;
        Wed,  9 Dec 2020 10:38:52 -0800 (PST)
Date:   Wed, 09 Dec 2020 18:38:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+S5wWvEvrpSBGRf+MkVA+RTRrayNxxtZ+hqFmzuKAk=;
        b=GRPewOYf0OoWt9OVO+YX+ZjeitjAkvuwWU5ioOgz6Bwwnuz/IbCevDvadG9QW41n+rsoFi
        rudV/RyUXJykdADEAQlj9IIzWgCavHfAj0XrtcXp6e3eeFpd0lRINYtt0OEjF96aSTv0pR
        9Bb88neK94pMf7MjNVt62QOU9YaWou0B8xB5K0wvud+izOF/8PqnDHpKLsc1LvSBSrpb9p
        0fbYnSV0XYYWgLcyWxIFeZB5T69tKoMw2hKx0m4/UYXSI/eAuNAZAEWeAD/qTeWBPGN3ns
        dg6CevIheK0NnzaU5hXJDzZkHFjkaVe7mKt2GMzGfkh/CuEt9nSKD6DOD/GRqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+S5wWvEvrpSBGRf+MkVA+RTRrayNxxtZ+hqFmzuKAk=;
        b=N1Ejo39ghgojF1yjvqhrxffMz4VQI87RwcURMIF2gp99TOWREYz0f/xkJIqHlRy62V8w4I
        ob9JvwGooTr2LLBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Fold __down_{read,write}*()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201207090243.GE3040@hirez.programming.kicks-ass.net>
References: <20201207090243.GE3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160753912826.3364.3121296739044708542.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c995e638ccbbc65a76d1713c4fdcf927e7e2cb83
Gitweb:        https://git.kernel.org/tip/c995e638ccbbc65a76d1713c4fdcf927e7e2cb83
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Dec 2020 10:27:41 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:47 +01:00

locking/rwsem: Fold __down_{read,write}*()

There's a lot needless duplication in __down_{read,write}*(), cure
that with a helper.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201207090243.GE3040@hirez.programming.kicks-ass.net
---
 kernel/locking/rwsem.c | 45 ++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 7915456..67ae366 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1354,32 +1354,29 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 /*
  * lock for reading
  */
-static inline void __down_read(struct rw_semaphore *sem)
+static inline int __down_read_common(struct rw_semaphore *sem, int state)
 {
 	if (!rwsem_read_trylock(sem)) {
-		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
+		if (IS_ERR(rwsem_down_read_slowpath(sem, state)))
+			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	}
+	return 0;
+}
+
+static inline void __down_read(struct rw_semaphore *sem)
+{
+	__down_read_common(sem, TASK_UNINTERRUPTIBLE);
 }
 
 static inline int __down_read_interruptible(struct rw_semaphore *sem)
 {
-	if (!rwsem_read_trylock(sem)) {
-		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_INTERRUPTIBLE)))
-			return -EINTR;
-		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
-	}
-	return 0;
+	return __down_read_common(sem, TASK_INTERRUPTIBLE);
 }
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
-	if (!rwsem_read_trylock(sem)) {
-		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE)))
-			return -EINTR;
-		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
-	}
-	return 0;
+	return __down_read_common(sem, TASK_KILLABLE);
 }
 
 static inline int __down_read_trylock(struct rw_semaphore *sem)
@@ -1405,22 +1402,26 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 /*
  * lock for writing
  */
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	if (unlikely(!rwsem_write_trylock(sem)))
-		rwsem_down_write_slowpath(sem, TASK_UNINTERRUPTIBLE);
-}
-
-static inline int __down_write_killable(struct rw_semaphore *sem)
+static inline int __down_write_common(struct rw_semaphore *sem, int state)
 {
 	if (unlikely(!rwsem_write_trylock(sem))) {
-		if (IS_ERR(rwsem_down_write_slowpath(sem, TASK_KILLABLE)))
+		if (IS_ERR(rwsem_down_write_slowpath(sem, state)))
 			return -EINTR;
 	}
 
 	return 0;
 }
 
+static inline void __down_write(struct rw_semaphore *sem)
+{
+	__down_write_common(sem, TASK_UNINTERRUPTIBLE);
+}
+
+static inline int __down_write_killable(struct rw_semaphore *sem)
+{
+	return __down_write_common(sem, TASK_KILLABLE);
+}
+
 static inline int __down_write_trylock(struct rw_semaphore *sem)
 {
 	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
