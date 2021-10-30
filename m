Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142184409BB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 30 Oct 2021 16:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhJ3Ots (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 30 Oct 2021 10:49:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60926 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhJ3Otr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 30 Oct 2021 10:49:47 -0400
Date:   Sat, 30 Oct 2021 14:47:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635605236;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=avXkLKRvtdnLVtE1uvnaZL2F0bNJnwcDArTzEucHfZM=;
        b=jLmEnT6n7dYkBlZs3mtzYn1z9wIlwENmlR+quQzaBTTIoimEGgA1a5H+tQ5D6uF/gInIaV
        dXyzu5TQwvmKNlrVE+H+0SjMVVlWm3kh5ULBKROnmDupad4lnFS2YKp0DfEQyi0SdXmAaj
        klrOJ4RrlYXxH3bciCxeyfwTXM4XreqYACUy+0Y71TlwhTfMBGoDD4BMT1grNPa19MbkVr
        cOjuGu5cwA/ZOR9ab7beLTQEC98clhpvQoWHyJiKN47l3Ca9+kSv6MxKQDKpyD+0CRbhRr
        W986hv3ec3O1Ph3p+3Y+XKIYmeUmakvmxw86HzIrQoEZMwpIxriQVFWPAbUk0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635605236;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=avXkLKRvtdnLVtE1uvnaZL2F0bNJnwcDArTzEucHfZM=;
        b=ghs4mibPlfTdXfOgnusrzzlorn1EfXpYHRtccFxLO9CgiIEXyEr37yUJ1MCztOzP/yB9hq
        GjE9EvxVnJpJZOAQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Remove spin_lock_flags() etc
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211022120058.1031690-1-arnd@kernel.org>
References: <20211022120058.1031690-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <163560523522.626.4537467617773504613.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f98a3dccfcb0b9b9c3bef8df9edd61cda80ad937
Gitweb:        https://git.kernel.org/tip/f98a3dccfcb0b9b9c3bef8df9edd61cda80ad937
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Fri, 22 Oct 2021 13:59:38 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 30 Oct 2021 16:37:28 +02:00

locking: Remove spin_lock_flags() etc

parisc, ia64 and powerpc32 are the only remaining architectures that
provide custom arch_{spin,read,write}_lock_flags() functions, which are
meant to re-enable interrupts while waiting for a spinlock.

However, none of these can actually run into this codepath, because
it is only called on architectures without CONFIG_GENERIC_LOCKBREAK,
or when CONFIG_DEBUG_LOCK_ALLOC is set without CONFIG_LOCKDEP, and none
of those combinations are possible on the three architectures.

Going back in the git history, it appears that arch/mn10300 may have
been able to run into this code path, but there is a good chance that
it never worked. On the architectures that still exist, it was
already impossible to hit back in 2008 after the introduction of
CONFIG_GENERIC_LOCKBREAK, and possibly earlier.

As this is all dead code, just remove it and the helper functions built
around it. For arch/ia64, the inline asm could be cleaned up, but
it seems safer to leave it untouched.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Helge Deller <deller@gmx.de>  # parisc
Link: https://lore.kernel.org/r/20211022120058.1031690-1-arnd@kernel.org
---
 arch/ia64/include/asm/spinlock.h           | 23 +++++----------------
 arch/openrisc/include/asm/spinlock.h       |  3 +---
 arch/parisc/include/asm/spinlock.h         | 15 +--------------
 arch/powerpc/include/asm/simple_spinlock.h | 21 +-------------------
 arch/s390/include/asm/spinlock.h           |  8 +-------
 include/linux/lockdep.h                    | 17 +----------------
 include/linux/rwlock.h                     | 15 +--------------
 include/linux/rwlock_api_smp.h             |  6 +----
 include/linux/spinlock.h                   | 13 +------------
 include/linux/spinlock_api_smp.h           |  9 +--------
 include/linux/spinlock_up.h                |  1 +-
 kernel/locking/spinlock.c                  |  3 +--
 12 files changed, 9 insertions(+), 125 deletions(-)

diff --git a/arch/ia64/include/asm/spinlock.h b/arch/ia64/include/asm/spinlock.h
index 8647759..0e5c1ad 100644
--- a/arch/ia64/include/asm/spinlock.h
+++ b/arch/ia64/include/asm/spinlock.h
@@ -124,18 +124,13 @@ static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
 	__ticket_spin_unlock(lock);
 }
 
-static __always_inline void arch_spin_lock_flags(arch_spinlock_t *lock,
-						  unsigned long flags)
-{
-	arch_spin_lock(lock);
-}
-#define arch_spin_lock_flags	arch_spin_lock_flags
-
 #ifdef ASM_SUPPORTED
 
 static __always_inline void
-arch_read_lock_flags(arch_rwlock_t *lock, unsigned long flags)
+arch_read_lock(arch_rwlock_t *lock)
 {
+	unsigned long flags = 0;
+
 	__asm__ __volatile__ (
 		"tbit.nz p6, p0 = %1,%2\n"
 		"br.few 3f\n"
@@ -157,13 +152,8 @@ arch_read_lock_flags(arch_rwlock_t *lock, unsigned long flags)
 		: "p6", "p7", "r2", "memory");
 }
 
-#define arch_read_lock_flags arch_read_lock_flags
-#define arch_read_lock(lock) arch_read_lock_flags(lock, 0)
-
 #else /* !ASM_SUPPORTED */
 
-#define arch_read_lock_flags(rw, flags) arch_read_lock(rw)
-
 #define arch_read_lock(rw)								\
 do {											\
 	arch_rwlock_t *__read_lock_ptr = (rw);						\
@@ -186,8 +176,10 @@ do {								\
 #ifdef ASM_SUPPORTED
 
 static __always_inline void
-arch_write_lock_flags(arch_rwlock_t *lock, unsigned long flags)
+arch_write_lock(arch_rwlock_t *lock)
 {
+	unsigned long flags = 0;
+
 	__asm__ __volatile__ (
 		"tbit.nz p6, p0 = %1, %2\n"
 		"mov ar.ccv = r0\n"
@@ -210,9 +202,6 @@ arch_write_lock_flags(arch_rwlock_t *lock, unsigned long flags)
 		: "ar.ccv", "p6", "p7", "r2", "r29", "memory");
 }
 
-#define arch_write_lock_flags arch_write_lock_flags
-#define arch_write_lock(rw) arch_write_lock_flags(rw, 0)
-
 #define arch_write_trylock(rw)							\
 ({										\
 	register long result;							\
diff --git a/arch/openrisc/include/asm/spinlock.h b/arch/openrisc/include/asm/spinlock.h
index a8940bd..264944a 100644
--- a/arch/openrisc/include/asm/spinlock.h
+++ b/arch/openrisc/include/asm/spinlock.h
@@ -19,9 +19,6 @@
 
 #include <asm/qrwlock.h>
 
-#define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
-#define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
-
 #define arch_spin_relax(lock)	cpu_relax()
 #define arch_read_relax(lock)	cpu_relax()
 #define arch_write_relax(lock)	cpu_relax()
diff --git a/arch/parisc/include/asm/spinlock.h b/arch/parisc/include/asm/spinlock.h
index fa5ee8a..a6e5d66 100644
--- a/arch/parisc/include/asm/spinlock.h
+++ b/arch/parisc/include/asm/spinlock.h
@@ -23,21 +23,6 @@ static inline void arch_spin_lock(arch_spinlock_t *x)
 			continue;
 }
 
-static inline void arch_spin_lock_flags(arch_spinlock_t *x,
-					unsigned long flags)
-{
-	volatile unsigned int *a;
-
-	a = __ldcw_align(x);
-	while (__ldcw(a) == 0)
-		while (*a == 0)
-			if (flags & PSW_SM_I) {
-				local_irq_enable();
-				local_irq_disable();
-			}
-}
-#define arch_spin_lock_flags arch_spin_lock_flags
-
 static inline void arch_spin_unlock(arch_spinlock_t *x)
 {
 	volatile unsigned int *a;
diff --git a/arch/powerpc/include/asm/simple_spinlock.h b/arch/powerpc/include/asm/simple_spinlock.h
index 8985791..7ae6aee 100644
--- a/arch/powerpc/include/asm/simple_spinlock.h
+++ b/arch/powerpc/include/asm/simple_spinlock.h
@@ -123,27 +123,6 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 	}
 }
 
-static inline
-void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long flags)
-{
-	unsigned long flags_dis;
-
-	while (1) {
-		if (likely(__arch_spin_trylock(lock) == 0))
-			break;
-		local_save_flags(flags_dis);
-		local_irq_restore(flags);
-		do {
-			HMT_low();
-			if (is_shared_processor())
-				splpar_spin_yield(lock);
-		} while (unlikely(lock->slock != 0));
-		HMT_medium();
-		local_irq_restore(flags_dis);
-	}
-}
-#define arch_spin_lock_flags arch_spin_lock_flags
-
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
 	__asm__ __volatile__("# arch_spin_unlock\n\t"
diff --git a/arch/s390/include/asm/spinlock.h b/arch/s390/include/asm/spinlock.h
index ef59588..888a2f1 100644
--- a/arch/s390/include/asm/spinlock.h
+++ b/arch/s390/include/asm/spinlock.h
@@ -67,14 +67,6 @@ static inline void arch_spin_lock(arch_spinlock_t *lp)
 		arch_spin_lock_wait(lp);
 }
 
-static inline void arch_spin_lock_flags(arch_spinlock_t *lp,
-					unsigned long flags)
-{
-	if (!arch_spin_trylock_once(lp))
-		arch_spin_lock_wait(lp);
-}
-#define arch_spin_lock_flags	arch_spin_lock_flags
-
 static inline int arch_spin_trylock(arch_spinlock_t *lp)
 {
 	if (!arch_spin_trylock_once(lp))
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 9fe165b..467b942 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -481,23 +481,6 @@ do {								\
 
 #endif /* CONFIG_LOCK_STAT */
 
-#ifdef CONFIG_LOCKDEP
-
-/*
- * On lockdep we dont want the hand-coded irq-enable of
- * _raw_*_lock_flags() code, because lockdep assumes
- * that interrupts are not re-enabled during lock-acquire:
- */
-#define LOCK_CONTENDED_FLAGS(_lock, try, lock, lockfl, flags) \
-	LOCK_CONTENDED((_lock), (try), (lock))
-
-#else /* CONFIG_LOCKDEP */
-
-#define LOCK_CONTENDED_FLAGS(_lock, try, lock, lockfl, flags) \
-	lockfl((_lock), (flags))
-
-#endif /* CONFIG_LOCKDEP */
-
 #ifdef CONFIG_PROVE_LOCKING
 extern void print_irqtrace_events(struct task_struct *curr);
 #else
diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index 7ce9a51..2c0ad41 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -30,31 +30,16 @@ do {								\
 
 #ifdef CONFIG_DEBUG_SPINLOCK
  extern void do_raw_read_lock(rwlock_t *lock) __acquires(lock);
-#define do_raw_read_lock_flags(lock, flags) do_raw_read_lock(lock)
  extern int do_raw_read_trylock(rwlock_t *lock);
  extern void do_raw_read_unlock(rwlock_t *lock) __releases(lock);
  extern void do_raw_write_lock(rwlock_t *lock) __acquires(lock);
-#define do_raw_write_lock_flags(lock, flags) do_raw_write_lock(lock)
  extern int do_raw_write_trylock(rwlock_t *lock);
  extern void do_raw_write_unlock(rwlock_t *lock) __releases(lock);
 #else
-
-#ifndef arch_read_lock_flags
-# define arch_read_lock_flags(lock, flags)	arch_read_lock(lock)
-#endif
-
-#ifndef arch_write_lock_flags
-# define arch_write_lock_flags(lock, flags)	arch_write_lock(lock)
-#endif
-
 # define do_raw_read_lock(rwlock)	do {__acquire(lock); arch_read_lock(&(rwlock)->raw_lock); } while (0)
-# define do_raw_read_lock_flags(lock, flags) \
-		do {__acquire(lock); arch_read_lock_flags(&(lock)->raw_lock, *(flags)); } while (0)
 # define do_raw_read_trylock(rwlock)	arch_read_trylock(&(rwlock)->raw_lock)
 # define do_raw_read_unlock(rwlock)	do {arch_read_unlock(&(rwlock)->raw_lock); __release(lock); } while (0)
 # define do_raw_write_lock(rwlock)	do {__acquire(lock); arch_write_lock(&(rwlock)->raw_lock); } while (0)
-# define do_raw_write_lock_flags(lock, flags) \
-		do {__acquire(lock); arch_write_lock_flags(&(lock)->raw_lock, *(flags)); } while (0)
 # define do_raw_write_trylock(rwlock)	arch_write_trylock(&(rwlock)->raw_lock)
 # define do_raw_write_unlock(rwlock)	do {arch_write_unlock(&(rwlock)->raw_lock); __release(lock); } while (0)
 #endif
diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index abfb53a..f1db6f1 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -157,8 +157,7 @@ static inline unsigned long __raw_read_lock_irqsave(rwlock_t *lock)
 	local_irq_save(flags);
 	preempt_disable();
 	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
-	LOCK_CONTENDED_FLAGS(lock, do_raw_read_trylock, do_raw_read_lock,
-			     do_raw_read_lock_flags, &flags);
+	LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
 	return flags;
 }
 
@@ -184,8 +183,7 @@ static inline unsigned long __raw_write_lock_irqsave(rwlock_t *lock)
 	local_irq_save(flags);
 	preempt_disable();
 	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	LOCK_CONTENDED_FLAGS(lock, do_raw_write_trylock, do_raw_write_lock,
-			     do_raw_write_lock_flags, &flags);
+	LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
 	return flags;
 }
 
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 45310ea..f044706 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -177,7 +177,6 @@ do {									\
 
 #ifdef CONFIG_DEBUG_SPINLOCK
  extern void do_raw_spin_lock(raw_spinlock_t *lock) __acquires(lock);
-#define do_raw_spin_lock_flags(lock, flags) do_raw_spin_lock(lock)
  extern int do_raw_spin_trylock(raw_spinlock_t *lock);
  extern void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock);
 #else
@@ -188,18 +187,6 @@ static inline void do_raw_spin_lock(raw_spinlock_t *lock) __acquires(lock)
 	mmiowb_spin_lock();
 }
 
-#ifndef arch_spin_lock_flags
-#define arch_spin_lock_flags(lock, flags)	arch_spin_lock(lock)
-#endif
-
-static inline void
-do_raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long *flags) __acquires(lock)
-{
-	__acquire(lock);
-	arch_spin_lock_flags(&lock->raw_lock, *flags);
-	mmiowb_spin_lock();
-}
-
 static inline int do_raw_spin_trylock(raw_spinlock_t *lock)
 {
 	int ret = arch_spin_trylock(&(lock)->raw_lock);
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 6b8e1a0..51fa0da 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -108,16 +108,7 @@ static inline unsigned long __raw_spin_lock_irqsave(raw_spinlock_t *lock)
 	local_irq_save(flags);
 	preempt_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	/*
-	 * On lockdep we dont want the hand-coded irq-enable of
-	 * do_raw_spin_lock_flags() code, because lockdep assumes
-	 * that interrupts are not re-enabled during lock-acquire:
-	 */
-#ifdef CONFIG_LOCKDEP
 	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
-#else
-	do_raw_spin_lock_flags(lock, &flags);
-#endif
 	return flags;
 }
 
diff --git a/include/linux/spinlock_up.h b/include/linux/spinlock_up.h
index 0ac9112..1652107 100644
--- a/include/linux/spinlock_up.h
+++ b/include/linux/spinlock_up.h
@@ -62,7 +62,6 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 #define arch_spin_is_locked(lock)	((void)(lock), 0)
 /* for sched/core.c and kernel_lock.c: */
 # define arch_spin_lock(lock)		do { barrier(); (void)(lock); } while (0)
-# define arch_spin_lock_flags(lock, flags)	do { barrier(); (void)(lock); } while (0)
 # define arch_spin_unlock(lock)	do { barrier(); (void)(lock); } while (0)
 # define arch_spin_trylock(lock)	({ barrier(); (void)(lock); 1; })
 #endif /* DEBUG_SPINLOCK */
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index c5830cf..b562f92 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -378,8 +378,7 @@ unsigned long __lockfunc _raw_spin_lock_irqsave_nested(raw_spinlock_t *lock,
 	local_irq_save(flags);
 	preempt_disable();
 	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
-	LOCK_CONTENDED_FLAGS(lock, do_raw_spin_trylock, do_raw_spin_lock,
-				do_raw_spin_lock_flags, &flags);
+	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
 	return flags;
 }
 EXPORT_SYMBOL(_raw_spin_lock_irqsave_nested);
