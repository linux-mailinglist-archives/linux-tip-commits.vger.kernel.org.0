Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C38F2D4933
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbgLISkK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733214AbgLISkJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:40:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ECFC0617A6;
        Wed,  9 Dec 2020 10:38:52 -0800 (PST)
Date:   Wed, 09 Dec 2020 18:38:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0y3sceUgBRhZYZVpiBwCuyuF9u3CjWj1N+sKMh5dPcU=;
        b=PgEMM9Ma4YkuhJUD80T4S5loKR5ENnXpzi/D5JTP7pny+3KTgsSareXrm870R02RR9qT95
        jVjm4OmkliYdjRB0aVyiXrr1t+Zj+C8ZGmEfjl5Fkxj1JCYhHriZN1VyC+Agq7eS2deDtn
        2FBk8ObmvEXFC9dDIQHWxVXatzLlvzyonQce0bULAjzr4Z8EUx3bZOh6q+PTqLwMq4dP2W
        hI3o6nPugiI4t674mNaaoIEwjj6a98KygMgnyTahkF2bY6JQCqJ3IjiRL14liz4COPoCB+
        CKAHho+LvL9XWm6dquHA/NypX/sBCUUYlxWpDprfV/bnSvBJEX7YWnB5z32+hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0y3sceUgBRhZYZVpiBwCuyuF9u3CjWj1N+sKMh5dPcU=;
        b=WQZPUqHAd5gMiRkRg9I4vfQb+CEn5bKR7lRszxl2MOmx3GeCzZJW9fW2xbQB6ceBmME3cX
        OlrdptxkRS/rceCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Better collate rwsem_read_trylock()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201207090243.GE3040@hirez.programming.kicks-ass.net>
References: <20201207090243.GE3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160753912872.3364.17787139748341246196.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3379116a0ca965b00e6522c7ea3f16c9dbd8f9f9
Gitweb:        https://git.kernel.org/tip/3379116a0ca965b00e6522c7ea3f16c9dbd8f9f9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Dec 2020 10:22:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:47 +01:00

locking/rwsem: Better collate rwsem_read_trylock()

All users of rwsem_read_trylock() do rwsem_set_reader_owned(sem) on
success, move it into rwsem_read_trylock() proper.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201207090243.GE3040@hirez.programming.kicks-ass.net
---
 kernel/locking/rwsem.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index a163542..5c0dc7e 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -273,9 +273,16 @@ static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
 static inline bool rwsem_read_trylock(struct rw_semaphore *sem)
 {
 	long cnt = atomic_long_add_return_acquire(RWSEM_READER_BIAS, &sem->count);
+
 	if (WARN_ON_ONCE(cnt < 0))
 		rwsem_set_nonspinnable(sem);
-	return !(cnt & RWSEM_READ_FAILED_MASK);
+
+	if (!(cnt & RWSEM_READ_FAILED_MASK)) {
+		rwsem_set_reader_owned(sem);
+		return true;
+	}
+
+	return false;
 }
 
 /*
@@ -1340,8 +1347,6 @@ static inline void __down_read(struct rw_semaphore *sem)
 	if (!rwsem_read_trylock(sem)) {
 		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
-	} else {
-		rwsem_set_reader_owned(sem);
 	}
 }
 
@@ -1351,8 +1356,6 @@ static inline int __down_read_interruptible(struct rw_semaphore *sem)
 		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_INTERRUPTIBLE)))
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
-	} else {
-		rwsem_set_reader_owned(sem);
 	}
 	return 0;
 }
@@ -1363,8 +1366,6 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE)))
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
-	} else {
-		rwsem_set_reader_owned(sem);
 	}
 	return 0;
 }
