Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C3A3FC552
	for <lists+linux-tip-commits@lfdr.de>; Tue, 31 Aug 2021 12:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240801AbhHaJzo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 31 Aug 2021 05:55:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57744 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240676AbhHaJzn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 31 Aug 2021 05:55:43 -0400
Date:   Tue, 31 Aug 2021 09:54:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630403687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfm5Dh5SK6+9u4dz2ZAmFeyk24/gOoWdWSWO6BRymwQ=;
        b=UJgHJMFuxENaq3TWdmZNJ6HpuomFb8hfAZIBo/RLm9Xe4tJTMYP108WZt9tf8/hM9Vczid
        vtWBAAyuDBssFEV+767a4sjKVhHt8zl8aNMCOO69hfA7UdhuXd2ElPDxzAid215Lhd3Run
        1c8g7HjwEpFiW+HSdE5qa/UQiUXw0m1L6QDMI4xXWY71NNJIUfmJlH0N0jJE95b8IoqWXs
        sn7LwZdHBi/it2dic5ybA7K8mUWSVUSaocGP7iYu2pU2YnDDTtMiD/1ihZN47a+nL8AAeg
        d8Vl/ya0YKHB/VjUPMoFSVdcsS550FA370XNRltVtdupeKksjzfL4+55RTYjQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630403687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfm5Dh5SK6+9u4dz2ZAmFeyk24/gOoWdWSWO6BRymwQ=;
        b=OYJxC3P57AWyrtV0QBszwRgNtNZ3aFMimk6ReJhbuhY8fuiS5mgm1dVMyXYeh122qajMeV
        cgwVrM71Vcc7xSDA==
From:   "tip-bot2 for Mike Galbraith" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/rwsem: Add missing __init_rwsem() for
 PREEMPT_RT
Cc:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <50a936b7d8f12277d6ec7ed2ef0421a381056909.camel@gmx.de>
References: <50a936b7d8f12277d6ec7ed2ef0421a381056909.camel@gmx.de>
MIME-Version: 1.0
Message-ID: <163040368671.25758.17254317330050347174.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     453624fa68444c9b93addb4325c9db59b6a43e21
Gitweb:        https://git.kernel.org/tip/453624fa68444c9b93addb4325c9db59b6a43e21
Author:        Mike Galbraith <efault@gmx.de>
AuthorDate:    Tue, 31 Aug 2021 08:38:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 31 Aug 2021 11:53:12 +02:00

locking/rwsem: Add missing __init_rwsem() for PREEMPT_RT

730633f0b7f95 became the first direct caller of __init_rwsem() vs the
usual init_rwsem(), exposing PREEMPT_RT's lack thereof.  Add it.

[ tglx: Move it out of line ]

Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/50a936b7d8f12277d6ec7ed2ef0421a381056909.camel@gmx.de
---
 include/linux/rwsem.h  | 12 ++----------
 kernel/locking/rwsem.c |  8 +++++---
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 426e98e..352c612 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -142,22 +142,14 @@ struct rw_semaphore {
 #define DECLARE_RWSEM(lockname) \
 	struct rw_semaphore lockname = __RWSEM_INITIALIZER(lockname)
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-extern void  __rwsem_init(struct rw_semaphore *rwsem, const char *name,
+extern void  __init_rwsem(struct rw_semaphore *rwsem, const char *name,
 			  struct lock_class_key *key);
-#else
-static inline void  __rwsem_init(struct rw_semaphore *rwsem, const char *name,
-				 struct lock_class_key *key)
-{
-}
-#endif
 
 #define init_rwsem(sem)						\
 do {								\
 	static struct lock_class_key __key;			\
 								\
-	init_rwbase_rt(&(sem)->rwbase);			\
-	__rwsem_init((sem), #sem, &__key);			\
+	__init_rwsem((sem), #sem, &__key);			\
 } while (0)
 
 static __always_inline int rwsem_is_locked(struct rw_semaphore *sem)
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 9215b4d..f18bbe8 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1376,15 +1376,17 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 
 #include "rwbase_rt.c"
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __rwsem_init(struct rw_semaphore *sem, const char *name,
 		  struct lock_class_key *key)
 {
+	init_rwbase_rt(&(sem)->rwbase);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
 	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
 	lockdep_init_map_wait(&sem->dep_map, name, key, 0, LD_WAIT_SLEEP);
-}
-EXPORT_SYMBOL(__rwsem_init);
 #endif
+}
+EXPORT_SYMBOL(__init_rwsem);
 
 static inline void __down_read(struct rw_semaphore *sem)
 {
