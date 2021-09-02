Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790B63FF4AC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  2 Sep 2021 22:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345524AbhIBUPd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 2 Sep 2021 16:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345522AbhIBUPc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 2 Sep 2021 16:15:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1A7C061575;
        Thu,  2 Sep 2021 13:14:33 -0700 (PDT)
Date:   Thu, 02 Sep 2021 20:14:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630613672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49+gjQxJGFuoNNdQY/0uc4SSe/U/0IFK8zhkJTzEwgw=;
        b=Bvljnnvneg+9qt1d3jJvp0yREOlHdnWL8YN5/Lw/lqOkqDL8Z9kgW2qmQCcMml4jLcgBGB
        ohUPYvuc3JsT0c9Fvbtj5BBeQ8jhDdt0ozt30CZFxFYPsXwGS8hB9pckqnsriW8K1p0CF5
        TKlrc8aoSHhZy2VZV/pL2ToqsQXV+IaUzHu9CnPVFYtXaSTiVBif5lPRhLrg9Fm/2eNV2c
        b3qCL2iLZkUW8QzKfGcuhuFhVrzpPWXPt9g3H26G9K8AcejfHjPeAEg7J6cC0R8RskDapp
        Ai1laDk3XaG1m/qAXANVRADMjiOv7gwOQYQgdc8rYfyAf/gO+PJGOhyg0WXkwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630613672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49+gjQxJGFuoNNdQY/0uc4SSe/U/0IFK8zhkJTzEwgw=;
        b=B1PpJ6FGqtqakjzqQYcZZmwsjbkZnJY/dklWyvOf/ny2DhD5W0qPs/tNzPzBCv0eJ6rfqs
        7FfNCGR+ZBD+70AQ==
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
Message-ID: <163061367170.25758.10664619926039078214.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     15eb7c888e749fbd1cc0370f3d38de08ad903700
Gitweb:        https://git.kernel.org/tip/15eb7c888e749fbd1cc0370f3d38de08ad903700
Author:        Mike Galbraith <efault@gmx.de>
AuthorDate:    Tue, 31 Aug 2021 08:38:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 02 Sep 2021 22:07:17 +02:00

locking/rwsem: Add missing __init_rwsem() for PREEMPT_RT

730633f0b7f95 became the first direct caller of __init_rwsem() vs the
usual init_rwsem(), exposing PREEMPT_RT's lack thereof.  Add it.

[ tglx: Move it out of line ]

Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/50a936b7d8f12277d6ec7ed2ef0421a381056909.camel@gmx.de

---
 include/linux/rwsem.h  | 12 ++----------
 kernel/locking/rwsem.c | 10 ++++++----
 2 files changed, 8 insertions(+), 14 deletions(-)

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
index 9215b4d..000e8d5 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1376,15 +1376,17 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 
 #include "rwbase_rt.c"
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-void __rwsem_init(struct rw_semaphore *sem, const char *name,
+void __init_rwsem(struct rw_semaphore *sem, const char *name,
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
