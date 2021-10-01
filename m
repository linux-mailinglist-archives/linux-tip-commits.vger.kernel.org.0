Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02E941F05A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354814AbhJAPHR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:07:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57978 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354800AbhJAPHO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:14 -0400
Date:   Fri, 01 Oct 2021 15:05:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VKjLxFWWtV74OvLgCjd4WH4OlseNzJvAKYl24P26Va0=;
        b=VUVH6FZTjYTeZG/h/kLN6qfKSve5mA/3wR9CdAXnnepyQtD3mPfPn80d7UsuyrCt4pkOj4
        P8elXqd8U7FCWfgLsZ3hTgu1Rk8ApZ82gc0ESlq32reWlM5J3KUeOjVGGGh4XFw/l431f0
        O7WcHXqTsj8q9F149Qwr9CskuA5YtH8n/HQkF4FbzTekB73BYWr1f+iuCfbhFiudUmZz80
        Cvk4cK0bnHS7HFAMTqg/BzQyIXzzjBux8hbBs6Eoiue2us9Uo9wc5+PG9DXSN4Mh+CYeyi
        o92E/Q6lFLZox7c1GttJc8swo2lCzQxe4lBIs6m50TxW3DJcZLRps7iXtlr/bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VKjLxFWWtV74OvLgCjd4WH4OlseNzJvAKYl24P26Va0=;
        b=8oGCd1JLyIMO70o7Q0eVJEcux1WoE0M8Y2gD4xQ0pNfVbvdBEkX4vAw7G0WqEkHKcNrMaR
        iI0RFQd8jyaqdQDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched: Make cond_resched_lock() variants RT aware
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923165358.305969211@linutronix.de>
References: <20210923165358.305969211@linutronix.de>
MIME-Version: 1.0
Message-ID: <163310072885.25758.10180627249630779863.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3e9cc688e56cc2abb9b6067f57c8397f6c96d42c
Gitweb:        https://git.kernel.org/tip/3e9cc688e56cc2abb9b6067f57c8397f6c96d42c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Sep 2021 18:54:44 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:57:51 +02:00

sched: Make cond_resched_lock() variants RT aware

The __might_resched() checks in the cond_resched_lock() variants use
PREEMPT_LOCK_OFFSET for preempt count offset checking which takes the
preemption disable by the spin_lock() which is still held at that point
into account.

On PREEMPT_RT enabled kernels spin/rw_lock held sections stay preemptible
which means PREEMPT_LOCK_OFFSET is 0, but that still triggers the
__might_resched() check because that takes RCU read side nesting into
account.

On RT enabled kernels spin/read/write_lock() issue rcu_read_lock() to
resemble the !RT semantics, which means in cond_resched_lock() the might
resched check will see preempt_count() == 0 and rcu_preempt_depth() == 1.

Introduce PREEMPT_LOCK_SCHED_OFFSET for those might resched checks and map
them depending on CONFIG_PREEMPT_RT.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210923165358.305969211@linutronix.de
---
 include/linux/preempt.h |  5 +++--
 include/linux/sched.h   | 34 +++++++++++++++++++++++++---------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 4d244e2..031898b 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -122,9 +122,10 @@
  * The preempt_count offset after spin_lock()
  */
 #if !defined(CONFIG_PREEMPT_RT)
-#define PREEMPT_LOCK_OFFSET	PREEMPT_DISABLE_OFFSET
+#define PREEMPT_LOCK_OFFSET		PREEMPT_DISABLE_OFFSET
 #else
-#define PREEMPT_LOCK_OFFSET	0
+/* Locks on RT do not disable preemption */
+#define PREEMPT_LOCK_OFFSET		0
 #endif
 
 /*
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b448c74..21b7cd0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2049,19 +2049,35 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 #define MIGHT_RESCHED_RCU_SHIFT		8
 #define MIGHT_RESCHED_PREEMPT_MASK	((1U << MIGHT_RESCHED_RCU_SHIFT) - 1)
 
-#define cond_resched_lock(lock) ({					\
-	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
-	__cond_resched_lock(lock);					\
+#ifndef CONFIG_PREEMPT_RT
+/*
+ * Non RT kernels have an elevated preempt count due to the held lock,
+ * but are not allowed to be inside a RCU read side critical section
+ */
+# define PREEMPT_LOCK_RESCHED_OFFSETS	PREEMPT_LOCK_OFFSET
+#else
+/*
+ * spin/rw_lock() on RT implies rcu_read_lock(). The might_sleep() check in
+ * cond_resched*lock() has to take that into account because it checks for
+ * preempt_count() and rcu_preempt_depth().
+ */
+# define PREEMPT_LOCK_RESCHED_OFFSETS	\
+	(PREEMPT_LOCK_OFFSET + (1U << MIGHT_RESCHED_RCU_SHIFT))
+#endif
+
+#define cond_resched_lock(lock) ({						\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
+	__cond_resched_lock(lock);						\
 })
 
-#define cond_resched_rwlock_read(lock) ({				\
-	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
-	__cond_resched_rwlock_read(lock);				\
+#define cond_resched_rwlock_read(lock) ({					\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
+	__cond_resched_rwlock_read(lock);					\
 })
 
-#define cond_resched_rwlock_write(lock) ({				\
-	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
-	__cond_resched_rwlock_write(lock);				\
+#define cond_resched_rwlock_write(lock) ({					\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
+	__cond_resched_rwlock_write(lock);					\
 })
 
 static inline void cond_resched_rcu(void)
