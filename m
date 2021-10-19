Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1152433AA5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Oct 2021 17:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhJSPhx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Oct 2021 11:37:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46514 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJSPhw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Oct 2021 11:37:52 -0400
Date:   Tue, 19 Oct 2021 15:35:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634657738;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x/P7g0Zh6Qy/byTGY6asgJ/NyEUYUC3qrvGNB9kE778=;
        b=eIHSKHbbZ6ibvJUSyIZ47g7olx29HMXSbtJsHP2vHeNpFJRAgLj9uXCLi8zRO8xUsM1Z+C
        OZrzOVHXuU+lyNplG6RwmZ0cOnlGYMsUTPtYBIbbRH2/vweUW97pI5VORDeZZH5l8RINpl
        QuzlLxWXzuRU+yZoyLA+cfoxCSVwLbYPpY8kg0Ur5Kz0SIYEec/oBxCjerIRHl4K2iQcOg
        IFNYlz6UAroxD+vNnni05LGACsjLGSiItxiV5pJUHsrpJ2/FQZG+bnAAbDcQnmAAKVkPfl
        l8icmZJwOXSF1QmxQOKixxP/QyAyKwe5cy0zzvgNpdqbvHiuKW47DbtYbV2fCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634657738;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x/P7g0Zh6Qy/byTGY6asgJ/NyEUYUC3qrvGNB9kE778=;
        b=1o02xzkeKcawS/gwxws1o6VSjc0+9HcV1ZnFrLZeSxNJTTLjwyV7rippurONeJZA+Dpqwf
        +Qrv2evyhGLrrmBA==
From:   "tip-bot2 for Yanfei Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Disable preemption for spinning region
Cc:     Yanfei Xu <yanfei.xu@windriver.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211013134154.1085649-3-yanfei.xu@windriver.com>
References: <20211013134154.1085649-3-yanfei.xu@windriver.com>
MIME-Version: 1.0
Message-ID: <163465773747.25758.16516293859176730628.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7cdacc5f52d68a9370f182c844b5b3e6cc975cc1
Gitweb:        https://git.kernel.org/tip/7cdacc5f52d68a9370f182c844b5b3e6cc975cc1
Author:        Yanfei Xu <yanfei.xu@windriver.com>
AuthorDate:    Wed, 13 Oct 2021 21:41:53 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Oct 2021 17:27:05 +02:00

locking/rwsem: Disable preemption for spinning region

The spinning region rwsem_spin_on_owner() should not be preempted,
however the rwsem_down_write_slowpath() invokes it and don't disable
preemption. Fix it by adding a pair of preempt_disable/enable().

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
[peterz: Fix CONFIG_RWSEM_SPIN_ON_OWNER=n build]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20211013134154.1085649-3-yanfei.xu@windriver.com
---
 kernel/locking/rwsem.c | 53 +++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 000e8d5..29eea50 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -577,6 +577,24 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 	return true;
 }
 
+/*
+ * The rwsem_spin_on_owner() function returns the following 4 values
+ * depending on the lock owner state.
+ *   OWNER_NULL  : owner is currently NULL
+ *   OWNER_WRITER: when owner changes and is a writer
+ *   OWNER_READER: when owner changes and the new owner may be a reader.
+ *   OWNER_NONSPINNABLE:
+ *		   when optimistic spinning has to stop because either the
+ *		   owner stops running, is unknown, or its timeslice has
+ *		   been used up.
+ */
+enum owner_state {
+	OWNER_NULL		= 1 << 0,
+	OWNER_WRITER		= 1 << 1,
+	OWNER_READER		= 1 << 2,
+	OWNER_NONSPINNABLE	= 1 << 3,
+};
+
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 /*
  * Try to acquire write lock before the writer has been put on wait queue.
@@ -632,23 +650,6 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	return ret;
 }
 
-/*
- * The rwsem_spin_on_owner() function returns the following 4 values
- * depending on the lock owner state.
- *   OWNER_NULL  : owner is currently NULL
- *   OWNER_WRITER: when owner changes and is a writer
- *   OWNER_READER: when owner changes and the new owner may be a reader.
- *   OWNER_NONSPINNABLE:
- *		   when optimistic spinning has to stop because either the
- *		   owner stops running, is unknown, or its timeslice has
- *		   been used up.
- */
-enum owner_state {
-	OWNER_NULL		= 1 << 0,
-	OWNER_WRITER		= 1 << 1,
-	OWNER_READER		= 1 << 2,
-	OWNER_NONSPINNABLE	= 1 << 3,
-};
 #define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER | OWNER_READER)
 
 static inline enum owner_state
@@ -878,12 +879,11 @@ static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 
 static inline void clear_nonspinnable(struct rw_semaphore *sem) { }
 
-static inline int
+static inline enum owner_state
 rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
-	return 0;
+	return OWNER_NONSPINNABLE;
 }
-#define OWNER_NULL	1
 #endif
 
 /*
@@ -1095,9 +1095,16 @@ wait:
 		 * In this case, we attempt to acquire the lock again
 		 * without sleeping.
 		 */
-		if (wstate == WRITER_HANDOFF &&
-		    rwsem_spin_on_owner(sem) == OWNER_NULL)
-			goto trylock_again;
+		if (wstate == WRITER_HANDOFF) {
+			enum owner_state owner_state;
+
+			preempt_disable();
+			owner_state = rwsem_spin_on_owner(sem);
+			preempt_enable();
+
+			if (owner_state == OWNER_NULL)
+				goto trylock_again;
+		}
 
 		/* Block until there are no active lockers. */
 		for (;;) {
