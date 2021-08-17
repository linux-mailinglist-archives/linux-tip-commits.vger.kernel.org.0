Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185B93EF378
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhHQUPr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbhHQUPO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00160C0612AF;
        Tue, 17 Aug 2021 13:14:22 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rX6UN2G2Eec3psqvx0wbJUZCzaRbi3DUxopVScKDnco=;
        b=L/Kz5cleeBJvowctraJgAuzwNgBCwnf1HRgvOf5GeNNxtSLmKjhs/XVOzs3Q2B+xsPnZNM
        40qmEA3s6fPh7k0oYQvkxApZhh0CKjObPBNxp7ofU+lduOq21LRMCZh9EsWRd2zfq+fMy6
        rfNka1RJtGy3Mq4v0/QmZxJUfVGgMmm6w9Tus8I9+W4x4Oz4FXhmQz1nvLTsEkltDyj2t5
        hV2D6nygVD/JRqUyjLMEka5xANBO+082sq91T0sLOQANSZ0S6l4PVSxZk0HOa+VJEDlgiQ
        P0eptlcjztnNlAWdkiC2+lij4QNMTyGk921KzHnnjl2IHnVCJm2FsRqBC2KGZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rX6UN2G2Eec3psqvx0wbJUZCzaRbi3DUxopVScKDnco=;
        b=rC8+xoW056iAaDMuvCUihbeqTHjG+1ijWeb6spEv7Y6TMcbOKBeaAFxZ6mVNecm9S9iqpw
        BVa80Lq4oANZN6Cw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/spinlock: Provide RT variant header:
 <linux/spinlock_rt.h>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211303.712897671@linutronix.de>
References: <20210815211303.712897671@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923126079.25758.13320696954880142093.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     342a93247e0837101f27bbcca26f402902df98dc
Gitweb:        https://git.kernel.org/tip/342a93247e0837101f27bbcca26f402902df98dc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:23 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:43:24 +02:00

locking/spinlock: Provide RT variant header: <linux/spinlock_rt.h>

Provide the necessary wrappers around the actual rtmutex based spinlock
implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211303.712897671@linutronix.de
---
 include/linux/spinlock.h         |  11 +-
 include/linux/spinlock_api_smp.h |   3 +-
 include/linux/spinlock_rt.h      | 149 ++++++++++++++++++++++++++++++-
 3 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/spinlock_rt.h

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 5803b56..45310ea 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -312,8 +312,10 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 	1 : ({ local_irq_restore(flags); 0; }); \
 })
 
-/* Include rwlock functions */
+#ifndef CONFIG_PREEMPT_RT
+/* Include rwlock functions for !RT */
 #include <linux/rwlock.h>
+#endif
 
 /*
  * Pull the _spin_*()/_read_*()/_write_*() functions/declarations:
@@ -324,6 +326,9 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 # include <linux/spinlock_api_up.h>
 #endif
 
+/* Non PREEMPT_RT kernel, map to raw spinlocks: */
+#ifndef CONFIG_PREEMPT_RT
+
 /*
  * Map the spin_lock functions to the raw variants for PREEMPT_RT=n
  */
@@ -458,6 +463,10 @@ static __always_inline int spin_is_contended(spinlock_t *lock)
 
 #define assert_spin_locked(lock)	assert_raw_spin_locked(&(lock)->rlock)
 
+#else  /* !CONFIG_PREEMPT_RT */
+# include <linux/spinlock_rt.h>
+#endif /* CONFIG_PREEMPT_RT */
+
 /*
  * Pull the atomic_t declaration:
  * (asm-mips/atomic.h needs above definitions)
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 19a9be9..6b8e1a0 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -187,6 +187,9 @@ static inline int __raw_spin_trylock_bh(raw_spinlock_t *lock)
 	return 0;
 }
 
+/* PREEMPT_RT has its own rwlock implementation */
+#ifndef CONFIG_PREEMPT_RT
 #include <linux/rwlock_api_smp.h>
+#endif
 
 #endif /* __LINUX_SPINLOCK_API_SMP_H */
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
new file mode 100644
index 0000000..21228d3
--- /dev/null
+++ b/include/linux/spinlock_rt.h
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef __LINUX_SPINLOCK_RT_H
+#define __LINUX_SPINLOCK_RT_H
+
+#ifndef __LINUX_SPINLOCK_H
+#error Do not include directly. Use spinlock.h
+#endif
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+extern void __rt_spin_lock_init(spinlock_t *lock, const char *name,
+				struct lock_class_key *key);
+#else
+static inline void __rt_spin_lock_init(spinlock_t *lock, const char *name,
+				       struct lock_class_key *key)
+{
+}
+#endif
+
+#define spin_lock_init(slock)				\
+do {							\
+	static struct lock_class_key __key;		\
+							\
+	rt_mutex_base_init(&(slock)->lock);		\
+	__rt_spin_lock_init(slock, #slock, &__key);	\
+} while (0)
+
+extern void rt_spin_lock(spinlock_t *lock);
+extern void rt_spin_lock_nested(spinlock_t *lock, int subclass);
+extern void rt_spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *nest_lock);
+extern void rt_spin_unlock(spinlock_t *lock);
+extern void rt_spin_lock_unlock(spinlock_t *lock);
+extern int rt_spin_trylock_bh(spinlock_t *lock);
+extern int rt_spin_trylock(spinlock_t *lock);
+
+static __always_inline void spin_lock(spinlock_t *lock)
+{
+	rt_spin_lock(lock);
+}
+
+#ifdef CONFIG_LOCKDEP
+# define __spin_lock_nested(lock, subclass)				\
+	rt_spin_lock_nested(lock, subclass)
+
+# define __spin_lock_nest_lock(lock, nest_lock)				\
+	do {								\
+		typecheck(struct lockdep_map *, &(nest_lock)->dep_map);	\
+		rt_spin_lock_nest_lock(lock, &(nest_lock)->dep_map);	\
+	} while (0)
+# define __spin_lock_irqsave_nested(lock, flags, subclass)	\
+	do {							\
+		typecheck(unsigned long, flags);		\
+		flags = 0;					\
+		__spin_lock_nested(lock, subclass);		\
+	} while (0)
+
+#else
+ /*
+  * Always evaluate the 'subclass' argument to avoid that the compiler
+  * warns about set-but-not-used variables when building with
+  * CONFIG_DEBUG_LOCK_ALLOC=n and with W=1.
+  */
+# define __spin_lock_nested(lock, subclass)	spin_lock(((void)(subclass), (lock)))
+# define __spin_lock_nest_lock(lock, subclass)	spin_lock(((void)(subclass), (lock)))
+# define __spin_lock_irqsave_nested(lock, flags, subclass)	\
+	spin_lock_irqsave(((void)(subclass), (lock)), flags)
+#endif
+
+#define spin_lock_nested(lock, subclass)		\
+	__spin_lock_nested(lock, subclass)
+
+#define spin_lock_nest_lock(lock, nest_lock)		\
+	__spin_lock_nest_lock(lock, nest_lock)
+
+#define spin_lock_irqsave_nested(lock, flags, subclass)	\
+	__spin_lock_irqsave_nested(lock, flags, subclass)
+
+static __always_inline void spin_lock_bh(spinlock_t *lock)
+{
+	/* Investigate: Drop bh when blocking ? */
+	local_bh_disable();
+	rt_spin_lock(lock);
+}
+
+static __always_inline void spin_lock_irq(spinlock_t *lock)
+{
+	rt_spin_lock(lock);
+}
+
+#define spin_lock_irqsave(lock, flags)			 \
+	do {						 \
+		typecheck(unsigned long, flags);	 \
+		flags = 0;				 \
+		spin_lock(lock);			 \
+	} while (0)
+
+static __always_inline void spin_unlock(spinlock_t *lock)
+{
+	rt_spin_unlock(lock);
+}
+
+static __always_inline void spin_unlock_bh(spinlock_t *lock)
+{
+	rt_spin_unlock(lock);
+	local_bh_enable();
+}
+
+static __always_inline void spin_unlock_irq(spinlock_t *lock)
+{
+	rt_spin_unlock(lock);
+}
+
+static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
+						   unsigned long flags)
+{
+	rt_spin_unlock(lock);
+}
+
+#define spin_trylock(lock)				\
+	__cond_lock(lock, rt_spin_trylock(lock))
+
+#define spin_trylock_bh(lock)				\
+	__cond_lock(lock, rt_spin_trylock_bh(lock))
+
+#define spin_trylock_irq(lock)				\
+	__cond_lock(lock, rt_spin_trylock(lock))
+
+#define __spin_trylock_irqsave(lock, flags)		\
+({							\
+	int __locked;					\
+							\
+	typecheck(unsigned long, flags);		\
+	flags = 0;					\
+	__locked = spin_trylock(lock);			\
+	__locked;					\
+})
+
+#define spin_trylock_irqsave(lock, flags)		\
+	__cond_lock(lock, __spin_trylock_irqsave(lock, flags))
+
+#define spin_is_contended(lock)		(((void)(lock), 0))
+
+static inline int spin_is_locked(spinlock_t *lock)
+{
+	return rt_mutex_base_is_locked(&lock->lock);
+}
+
+#define assert_spin_locked(lock) BUG_ON(!spin_is_locked(lock))
+
+#endif
