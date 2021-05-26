Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516203915E1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbhEZL0K (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbhEZL0F (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AA6C061574;
        Wed, 26 May 2021 04:24:34 -0700 (PDT)
Date:   Wed, 26 May 2021 11:24:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QRga/QSkDW9sFZsOG+W7wNP6v4OXeHvH554zwADXPd0=;
        b=xLC1UuQ1WQQjRYcnOGQPNmR4lzmdQtEzWvvXYwKIRafSVHUOQsP/sWCAvPhI0qE0rsudzr
        tDcWNIqXO6Ut06mUFH3wBFxg51gV9o18ObSlDoWZYfYqGiQDIWfEmWfawQZSaWzq6k7XIL
        4Z7Rpp0iR6Q8Is71gxNQXi8xUr6Myf2F+N2gjW+9XpxB8e/h+xybI0s0b9Z08A6Lu65ofo
        N/Bnd5o8bgEwmsYpAdOnSe35fDAPbMfoFGW5PE2nU7oqQRHqoF5yieJD4hSElvhU4lGElW
        HjwqBDqdctzsjydPc434i3itIa15e02paX5OdochQzK41qMt0kjojDsEPcJAxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QRga/QSkDW9sFZsOG+W7wNP6v4OXeHvH554zwADXPd0=;
        b=eaCU3FxOSm7s/bGkIkaOxlnmA/OwV+hRO7omB811mIhu0WvKwP+BIB4olIAp9WBTqZ92kH
        rjylqtldO5oarZBA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: parisc: move to ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-27-mark.rutland@arm.com>
References: <20210525140232.53872-27-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827188.29796.814053207644201966.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     329c161b8baeff5fff69fe37d3ebb4bcffef91fa
Gitweb:        https://git.kernel.org/tip/329c161b8baeff5fff69fe37d3ebb4bcffef91fa
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:25 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:51 +02:00

locking/atomic: parisc: move to ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates parisc to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-27-mark.rutland@arm.com
---
 arch/parisc/Kconfig               |  1 +-
 arch/parisc/include/asm/atomic.h  | 34 +++++++++++++++---------------
 arch/parisc/include/asm/cmpxchg.h | 12 +++++------
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index bde9907..bfa120a 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -2,6 +2,7 @@
 config PARISC
 	def_bool y
 	select ARCH_32BIT_OFF_T if !64BIT
+	select ARCH_ATOMIC
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select HAVE_IDE
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
index 21b375c..dd5a299 100644
--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -56,7 +56,7 @@ extern arch_spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] __lock_aligned;
  * are atomic, so a reader never sees inconsistent values.
  */
 
-static __inline__ void atomic_set(atomic_t *v, int i)
+static __inline__ void arch_atomic_set(atomic_t *v, int i)
 {
 	unsigned long flags;
 	_atomic_spin_lock_irqsave(v, flags);
@@ -66,19 +66,19 @@ static __inline__ void atomic_set(atomic_t *v, int i)
 	_atomic_spin_unlock_irqrestore(v, flags);
 }
 
-#define atomic_set_release(v, i)	atomic_set((v), (i))
+#define arch_atomic_set_release(v, i)	arch_atomic_set((v), (i))
 
-static __inline__ int atomic_read(const atomic_t *v)
+static __inline__ int arch_atomic_read(const atomic_t *v)
 {
 	return READ_ONCE((v)->counter);
 }
 
 /* exported interface */
-#define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic_cmpxchg(v, o, n)	(arch_cmpxchg(&((v)->counter), (o), (n)))
+#define arch_atomic_xchg(v, new)	(arch_xchg(&((v)->counter), new))
 
 #define ATOMIC_OP(op, c_op)						\
-static __inline__ void atomic_##op(int i, atomic_t *v)			\
+static __inline__ void arch_atomic_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
 									\
@@ -88,7 +88,7 @@ static __inline__ void atomic_##op(int i, atomic_t *v)			\
 }
 
 #define ATOMIC_OP_RETURN(op, c_op)					\
-static __inline__ int atomic_##op##_return(int i, atomic_t *v)		\
+static __inline__ int arch_atomic_##op##_return(int i, atomic_t *v)	\
 {									\
 	unsigned long flags;						\
 	int ret;							\
@@ -101,7 +101,7 @@ static __inline__ int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op)					\
-static __inline__ int atomic_fetch_##op(int i, atomic_t *v)		\
+static __inline__ int arch_atomic_fetch_##op(int i, atomic_t *v)	\
 {									\
 	unsigned long flags;						\
 	int ret;							\
@@ -141,7 +141,7 @@ ATOMIC_OPS(xor, ^=)
 #define ATOMIC64_INIT(i) { (i) }
 
 #define ATOMIC64_OP(op, c_op)						\
-static __inline__ void atomic64_##op(s64 i, atomic64_t *v)		\
+static __inline__ void arch_atomic64_##op(s64 i, atomic64_t *v)		\
 {									\
 	unsigned long flags;						\
 									\
@@ -151,7 +151,7 @@ static __inline__ void atomic64_##op(s64 i, atomic64_t *v)		\
 }
 
 #define ATOMIC64_OP_RETURN(op, c_op)					\
-static __inline__ s64 atomic64_##op##_return(s64 i, atomic64_t *v)	\
+static __inline__ s64 arch_atomic64_##op##_return(s64 i, atomic64_t *v)	\
 {									\
 	unsigned long flags;						\
 	s64 ret;							\
@@ -164,7 +164,7 @@ static __inline__ s64 atomic64_##op##_return(s64 i, atomic64_t *v)	\
 }
 
 #define ATOMIC64_FETCH_OP(op, c_op)					\
-static __inline__ s64 atomic64_fetch_##op(s64 i, atomic64_t *v)		\
+static __inline__ s64 arch_atomic64_fetch_##op(s64 i, atomic64_t *v)	\
 {									\
 	unsigned long flags;						\
 	s64 ret;							\
@@ -200,7 +200,7 @@ ATOMIC64_OPS(xor, ^=)
 #undef ATOMIC64_OP
 
 static __inline__ void
-atomic64_set(atomic64_t *v, s64 i)
+arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	unsigned long flags;
 	_atomic_spin_lock_irqsave(v, flags);
@@ -210,18 +210,18 @@ atomic64_set(atomic64_t *v, s64 i)
 	_atomic_spin_unlock_irqrestore(v, flags);
 }
 
-#define atomic64_set_release(v, i)	atomic64_set((v), (i))
+#define arch_atomic64_set_release(v, i)	arch_atomic64_set((v), (i))
 
 static __inline__ s64
-atomic64_read(const atomic64_t *v)
+arch_atomic64_read(const atomic64_t *v)
 {
 	return READ_ONCE((v)->counter);
 }
 
 /* exported interface */
-#define atomic64_cmpxchg(v, o, n) \
-	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
-#define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic64_cmpxchg(v, o, n) \
+	((__typeof__((v)->counter))arch_cmpxchg(&((v)->counter), (o), (n)))
+#define arch_atomic64_xchg(v, new) (arch_xchg(&((v)->counter), new))
 
 #endif /* !CONFIG_64BIT */
 
diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
index c201565..5f274be 100644
--- a/arch/parisc/include/asm/cmpxchg.h
+++ b/arch/parisc/include/asm/cmpxchg.h
@@ -44,7 +44,7 @@ __xchg(unsigned long x, volatile void *ptr, int size)
 **		if (((unsigned long)p & 0xf) == 0)
 **			return __ldcw(p);
 */
-#define xchg(ptr, x)							\
+#define arch_xchg(ptr, x)						\
 ({									\
 	__typeof__(*(ptr)) __ret;					\
 	__typeof__(*(ptr)) _x_ = (x);					\
@@ -78,7 +78,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 	return old;
 }
 
-#define cmpxchg(ptr, o, n)						 \
+#define arch_cmpxchg(ptr, o, n)						 \
 ({									 \
 	__typeof__(*(ptr)) _o_ = (o);					 \
 	__typeof__(*(ptr)) _n_ = (n);					 \
@@ -106,19 +106,19 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
  * cmpxchg_local and cmpxchg64_local are atomic wrt current CPU. Always make
  * them available.
  */
-#define cmpxchg_local(ptr, o, n)					\
+#define arch_cmpxchg_local(ptr, o, n)					\
 	((__typeof__(*(ptr)))__cmpxchg_local((ptr), (unsigned long)(o),	\
 			(unsigned long)(n), sizeof(*(ptr))))
 #ifdef CONFIG_64BIT
-#define cmpxchg64_local(ptr, o, n)					\
+#define arch_cmpxchg64_local(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
 	cmpxchg_local((ptr), (o), (n));					\
 })
 #else
-#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 #endif
 
-#define cmpxchg64(ptr, o, n) __cmpxchg_u64(ptr, o, n)
+#define arch_cmpxchg64(ptr, o, n) __cmpxchg_u64(ptr, o, n)
 
 #endif /* _ASM_PARISC_CMPXCHG_H_ */
