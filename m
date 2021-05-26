Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC133915F6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhEZL0h (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbhEZL0N (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38445C06138C;
        Wed, 26 May 2021 04:24:40 -0700 (PDT)
Date:   Wed, 26 May 2021 11:24:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XDBRPdMvdOOohTQobqTIwNDDOL82iR2PvUCLwXLNdpk=;
        b=gHyUlnl0tYwR2MjKVQ3d9kV8hXx+C/6+qyqDlsrcf++2YRtTwHtwNB2h2i7fpfflooUFv7
        mzH3vpz/hvs/8kV7Y+geTu4wtVAYzo3EQEZxL+dzuJ3PkdiTu3oR/AUfnosJYxj5Oipcr+
        O69QHq/r4S4XgTOuT+MPomKitclDs2dLIKx/LALBdn8wmEj6JL5uVjIq3sO6FlQur5kUJB
        s6G6mxwnkTSr6pYk3ViCLFjFmQpaVZNJWmND7SwD8CnU1BV6W5YJ8x0ga2R6cyqlgB0cBb
        oMz2xxMupWVyKkmLnh0tVD5hzyDAYRIrn+bOGhYfWC5pIWEvQQ5Dfi2lurChgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XDBRPdMvdOOohTQobqTIwNDDOL82iR2PvUCLwXLNdpk=;
        b=s28vFkxf4IBcQSxqCLHokFsEre8MqWi9XjrLjqfy2i7Vp+RSmSDQZNpXFdZeqGP3zsvcB8
        5kJhqjoZHN9/s9Cg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: arc: move to ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-15-mark.rutland@arm.com>
References: <20210525140232.53872-15-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827739.29796.14323536574919607297.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6db5d99304dce6d3b9b1251b788f0ff6aaf1c054
Gitweb:        https://git.kernel.org/tip/6db5d99304dce6d3b9b1251b788f0ff6aaf1c054
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:13 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:50 +02:00

locking/atomic: arc: move to ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates alpha to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Vineet Gupta <vgupta@synopsys.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-15-mark.rutland@arm.com
---
 arch/arc/Kconfig               |  1 +-
 arch/arc/include/asm/atomic.h  | 60 ++++++++++++++++-----------------
 arch/arc/include/asm/cmpxchg.h | 10 +++---
 3 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 2d98501..098ecc7 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -6,6 +6,7 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
+	select ARCH_ATOMIC
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_PREP_COHERENT
diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 5afc79c..7a36d79 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -14,14 +14,14 @@
 #include <asm/barrier.h>
 #include <asm/smp.h>
 
-#define atomic_read(v)  READ_ONCE((v)->counter)
+#define arch_atomic_read(v)  READ_ONCE((v)->counter)
 
 #ifdef CONFIG_ARC_HAS_LLSC
 
-#define atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
+#define arch_atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
 
 #define ATOMIC_OP(op, c_op, asm_op)					\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	unsigned int val;						\
 									\
@@ -37,7 +37,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	unsigned int val;						\
 									\
@@ -63,7 +63,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	unsigned int val, orig;						\
 									\
@@ -94,11 +94,11 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 #ifndef CONFIG_SMP
 
  /* violating atomic_xxx API locking protocol in UP for optimization sake */
-#define atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
+#define arch_atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
 
 #else
 
-static inline void atomic_set(atomic_t *v, int i)
+static inline void arch_atomic_set(atomic_t *v, int i)
 {
 	/*
 	 * Independent of hardware support, all of the atomic_xxx() APIs need
@@ -116,7 +116,7 @@ static inline void atomic_set(atomic_t *v, int i)
 	atomic_ops_unlock(flags);
 }
 
-#define atomic_set_release(v, i)	atomic_set((v), (i))
+#define arch_atomic_set_release(v, i)	arch_atomic_set((v), (i))
 
 #endif
 
@@ -126,7 +126,7 @@ static inline void atomic_set(atomic_t *v, int i)
  */
 
 #define ATOMIC_OP(op, c_op, asm_op)					\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	unsigned long flags;						\
 									\
@@ -136,7 +136,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
 	unsigned long temp;						\
@@ -154,7 +154,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
 	unsigned long orig;						\
@@ -180,9 +180,6 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
 
-#define atomic_andnot		atomic_andnot
-#define atomic_fetch_andnot	atomic_fetch_andnot
-
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op, c_op, asm_op)					\
 	ATOMIC_OP(op, c_op, asm_op)					\
@@ -193,6 +190,9 @@ ATOMIC_OPS(andnot, &= ~, bic)
 ATOMIC_OPS(or, |=, or)
 ATOMIC_OPS(xor, ^=, xor)
 
+#define arch_atomic_andnot		arch_atomic_andnot
+#define arch_atomic_fetch_andnot	arch_atomic_fetch_andnot
+
 #undef ATOMIC_OPS
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
@@ -220,7 +220,7 @@ typedef struct {
 
 #define ATOMIC64_INIT(a) { (a) }
 
-static inline s64 atomic64_read(const atomic64_t *v)
+static inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	s64 val;
 
@@ -232,7 +232,7 @@ static inline s64 atomic64_read(const atomic64_t *v)
 	return val;
 }
 
-static inline void atomic64_set(atomic64_t *v, s64 a)
+static inline void arch_atomic64_set(atomic64_t *v, s64 a)
 {
 	/*
 	 * This could have been a simple assignment in "C" but would need
@@ -253,7 +253,7 @@ static inline void atomic64_set(atomic64_t *v, s64 a)
 }
 
 #define ATOMIC64_OP(op, op1, op2)					\
-static inline void atomic64_##op(s64 a, atomic64_t *v)			\
+static inline void arch_atomic64_##op(s64 a, atomic64_t *v)		\
 {									\
 	s64 val;							\
 									\
@@ -270,7 +270,7 @@ static inline void atomic64_##op(s64 a, atomic64_t *v)			\
 }									\
 
 #define ATOMIC64_OP_RETURN(op, op1, op2)		        	\
-static inline s64 atomic64_##op##_return(s64 a, atomic64_t *v)		\
+static inline s64 arch_atomic64_##op##_return(s64 a, atomic64_t *v)	\
 {									\
 	s64 val;							\
 									\
@@ -293,7 +293,7 @@ static inline s64 atomic64_##op##_return(s64 a, atomic64_t *v)		\
 }
 
 #define ATOMIC64_FETCH_OP(op, op1, op2)		        		\
-static inline s64 atomic64_fetch_##op(s64 a, atomic64_t *v)		\
+static inline s64 arch_atomic64_fetch_##op(s64 a, atomic64_t *v)	\
 {									\
 	s64 val, orig;							\
 									\
@@ -320,9 +320,6 @@ static inline s64 atomic64_fetch_##op(s64 a, atomic64_t *v)		\
 	ATOMIC64_OP_RETURN(op, op1, op2)				\
 	ATOMIC64_FETCH_OP(op, op1, op2)
 
-#define atomic64_andnot		atomic64_andnot
-#define atomic64_fetch_andnot	atomic64_fetch_andnot
-
 ATOMIC64_OPS(add, add.f, adc)
 ATOMIC64_OPS(sub, sub.f, sbc)
 ATOMIC64_OPS(and, and, and)
@@ -330,13 +327,16 @@ ATOMIC64_OPS(andnot, bic, bic)
 ATOMIC64_OPS(or, or, or)
 ATOMIC64_OPS(xor, xor, xor)
 
+#define arch_atomic64_andnot		arch_atomic64_andnot
+#define arch_atomic64_fetch_andnot	arch_atomic64_fetch_andnot
+
 #undef ATOMIC64_OPS
 #undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
 static inline s64
-atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
+arch_atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
 {
 	s64 prev;
 
@@ -358,7 +358,7 @@ atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
 	return prev;
 }
 
-static inline s64 atomic64_xchg(atomic64_t *ptr, s64 new)
+static inline s64 arch_atomic64_xchg(atomic64_t *ptr, s64 new)
 {
 	s64 prev;
 
@@ -379,14 +379,14 @@ static inline s64 atomic64_xchg(atomic64_t *ptr, s64 new)
 }
 
 /**
- * atomic64_dec_if_positive - decrement by 1 if old value positive
+ * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
  * @v: pointer of type atomic64_t
  *
  * The function returns the old value of *v minus 1, even if
  * the atomic variable, v, was not decremented.
  */
 
-static inline s64 atomic64_dec_if_positive(atomic64_t *v)
+static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 val;
 
@@ -408,10 +408,10 @@ static inline s64 atomic64_dec_if_positive(atomic64_t *v)
 
 	return val;
 }
-#define atomic64_dec_if_positive atomic64_dec_if_positive
+#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 
 /**
- * atomic64_fetch_add_unless - add unless the number is a given value
+ * arch_atomic64_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic64_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -419,7 +419,7 @@ static inline s64 atomic64_dec_if_positive(atomic64_t *v)
  * Atomically adds @a to @v, if it was not @u.
  * Returns the old value of @v
  */
-static inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+static inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	s64 old, temp;
 
@@ -443,7 +443,7 @@ static inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 
 	return old;
 }
-#define atomic64_fetch_add_unless atomic64_fetch_add_unless
+#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
 
 #endif	/* !CONFIG_GENERIC_ATOMIC64 */
 
diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 9b87e16..d1781bd 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -63,7 +63,7 @@ __cmpxchg(volatile void *ptr, unsigned long expected, unsigned long new)
 
 #endif
 
-#define cmpxchg(ptr, o, n) ({				\
+#define arch_cmpxchg(ptr, o, n) ({			\
 	(typeof(*(ptr)))__cmpxchg((ptr),		\
 				  (unsigned long)(o),	\
 				  (unsigned long)(n));	\
@@ -75,7 +75,7 @@ __cmpxchg(volatile void *ptr, unsigned long expected, unsigned long new)
  *  !LLSC: cmpxchg() has to use an external lock atomic_ops_lock to guarantee
  *         semantics, and this lock also happens to be used by atomic_*()
  */
-#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+#define arch_atomic_cmpxchg(v, o, n) ((int)arch_cmpxchg(&((v)->counter), (o), (n)))
 
 
 /*
@@ -123,7 +123,7 @@ static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
 
 #if !defined(CONFIG_ARC_HAS_LLSC) && defined(CONFIG_SMP)
 
-#define xchg(ptr, with)			\
+#define arch_xchg(ptr, with)		\
 ({					\
 	unsigned long flags;		\
 	typeof(*(ptr)) old_val;		\
@@ -136,7 +136,7 @@ static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
 
 #else
 
-#define xchg(ptr, with)  _xchg(ptr, with)
+#define arch_xchg(ptr, with)  _xchg(ptr, with)
 
 #endif
 
@@ -153,6 +153,6 @@ static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
  *         can't be clobbered by others. Thus no serialization required when
  *         atomic_xchg is involved.
  */
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), new))
 
 #endif
