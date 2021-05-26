Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B2E3915EF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhEZL02 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54750 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbhEZL0L (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:11 -0400
Date:   Wed, 26 May 2021 11:24:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tC5h934RbgcbHnOv0D1xEacwov6Sur0DCw4wAHgcvc=;
        b=b2l7s5yIahYj1EcTs/dJPEYMfARMiJULDiGIEkYhKeqtopMXgO9bek0kdGz5COos+1L6/q
        UqletefphAyE16UoF4s8OUXkAhf6FZ3VPy5B51DIul2HIHMD8voqamTvVL5pBfny5hVbcj
        BKUcZkUOEq2Eagfnm4WEyQTjbhejqdlHIn1I1nfEkkvHdWgUFB8m85EDZMzG/eKQHWrNv+
        42F5J/0HWCqx5F8VrC1CA385/6dSSTgtqfxJJyj2JfeL/Ru5W9TskyiGNIfVKx54XR+g8a
        lsYpOL+1vSF+seR2SAXcp2cuVFPFXx3W5kB56z5vTfneQZosIMrDaf+QObpuOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tC5h934RbgcbHnOv0D1xEacwov6Sur0DCw4wAHgcvc=;
        b=Nv8Dmxxh1lKnfOSVQk+ETgHfqwZSM3ZiNd7F9/Xr0WQeh/gVoSE6ARoFNhKkrkaiMoPS0w
        7DYrPCmLlSU6HLCw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: alpha: move to ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-14-mark.rutland@arm.com>
References: <20210525140232.53872-14-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827782.29796.9581539600681274775.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     96d330aff7060f0882a5440ddb281cc3ab232d96
Gitweb:        https://git.kernel.org/tip/96d330aff7060f0882a5440ddb281cc3ab232d96
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:50 +02:00

locking/atomic: alpha: move to ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates alpha to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Note: xchg_local() is NOT currently part of the generic atomic
arch_atomic API, and is not instrumented.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-14-mark.rutland@arm.com
---
 arch/alpha/Kconfig               |  1 +-
 arch/alpha/include/asm/atomic.h  | 88 ++++++++++++++++---------------
 arch/alpha/include/asm/cmpxchg.h | 12 ++--
 3 files changed, 54 insertions(+), 47 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 5998106..7920fc2 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -2,6 +2,7 @@
 config ALPHA
 	bool
 	default y
+	select ARCH_ATOMIC
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index e41c113..f2861a4 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -26,11 +26,11 @@
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-#define atomic_read(v)		READ_ONCE((v)->counter)
-#define atomic64_read(v)	READ_ONCE((v)->counter)
+#define arch_atomic_read(v)	READ_ONCE((v)->counter)
+#define arch_atomic64_read(v)	READ_ONCE((v)->counter)
 
-#define atomic_set(v,i)		WRITE_ONCE((v)->counter, (i))
-#define atomic64_set(v,i)	WRITE_ONCE((v)->counter, (i))
+#define arch_atomic_set(v,i)	WRITE_ONCE((v)->counter, (i))
+#define arch_atomic64_set(v,i)	WRITE_ONCE((v)->counter, (i))
 
 /*
  * To get proper branch prediction for the main line, we must branch
@@ -39,7 +39,7 @@
  */
 
 #define ATOMIC_OP(op, asm_op)						\
-static __inline__ void atomic_##op(int i, atomic_t * v)			\
+static __inline__ void arch_atomic_##op(int i, atomic_t * v)		\
 {									\
 	unsigned long temp;						\
 	__asm__ __volatile__(						\
@@ -55,7 +55,7 @@ static __inline__ void atomic_##op(int i, atomic_t * v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op, asm_op)					\
-static inline int atomic_##op##_return_relaxed(int i, atomic_t *v)	\
+static inline int arch_atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 {									\
 	long temp, result;						\
 	__asm__ __volatile__(						\
@@ -74,7 +74,7 @@ static inline int atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 }
 
 #define ATOMIC_FETCH_OP(op, asm_op)					\
-static inline int atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
+static inline int arch_atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 {									\
 	long temp, result;						\
 	__asm__ __volatile__(						\
@@ -92,7 +92,7 @@ static inline int atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 }
 
 #define ATOMIC64_OP(op, asm_op)						\
-static __inline__ void atomic64_##op(s64 i, atomic64_t * v)		\
+static __inline__ void arch_atomic64_##op(s64 i, atomic64_t * v)	\
 {									\
 	s64 temp;							\
 	__asm__ __volatile__(						\
@@ -108,7 +108,8 @@ static __inline__ void atomic64_##op(s64 i, atomic64_t * v)		\
 }									\
 
 #define ATOMIC64_OP_RETURN(op, asm_op)					\
-static __inline__ s64 atomic64_##op##_return_relaxed(s64 i, atomic64_t * v)	\
+static __inline__ s64							\
+arch_atomic64_##op##_return_relaxed(s64 i, atomic64_t * v)		\
 {									\
 	s64 temp, result;						\
 	__asm__ __volatile__(						\
@@ -127,7 +128,8 @@ static __inline__ s64 atomic64_##op##_return_relaxed(s64 i, atomic64_t * v)	\
 }
 
 #define ATOMIC64_FETCH_OP(op, asm_op)					\
-static __inline__ s64 atomic64_fetch_##op##_relaxed(s64 i, atomic64_t * v)	\
+static __inline__ s64							\
+arch_atomic64_fetch_##op##_relaxed(s64 i, atomic64_t * v)		\
 {									\
 	s64 temp, result;						\
 	__asm__ __volatile__(						\
@@ -155,18 +157,18 @@ static __inline__ s64 atomic64_fetch_##op##_relaxed(s64 i, atomic64_t * v)	\
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
-#define atomic_add_return_relaxed	atomic_add_return_relaxed
-#define atomic_sub_return_relaxed	atomic_sub_return_relaxed
-#define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
-#define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
+#define arch_atomic_add_return_relaxed		arch_atomic_add_return_relaxed
+#define arch_atomic_sub_return_relaxed		arch_atomic_sub_return_relaxed
+#define arch_atomic_fetch_add_relaxed		arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_sub_relaxed		arch_atomic_fetch_sub_relaxed
 
-#define atomic64_add_return_relaxed	atomic64_add_return_relaxed
-#define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
-#define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
-#define atomic64_fetch_sub_relaxed	atomic64_fetch_sub_relaxed
+#define arch_atomic64_add_return_relaxed	arch_atomic64_add_return_relaxed
+#define arch_atomic64_sub_return_relaxed	arch_atomic64_sub_return_relaxed
+#define arch_atomic64_fetch_add_relaxed		arch_atomic64_fetch_add_relaxed
+#define arch_atomic64_fetch_sub_relaxed		arch_atomic64_fetch_sub_relaxed
 
-#define atomic_andnot atomic_andnot
-#define atomic64_andnot atomic64_andnot
+#define arch_atomic_andnot			arch_atomic_andnot
+#define arch_atomic64_andnot			arch_atomic64_andnot
 
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op, asm)						\
@@ -180,15 +182,15 @@ ATOMIC_OPS(andnot, bic)
 ATOMIC_OPS(or, bis)
 ATOMIC_OPS(xor, xor)
 
-#define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
-#define atomic_fetch_andnot_relaxed	atomic_fetch_andnot_relaxed
-#define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
-#define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
+#define arch_atomic_fetch_and_relaxed		arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_andnot_relaxed	arch_atomic_fetch_andnot_relaxed
+#define arch_atomic_fetch_or_relaxed		arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_xor_relaxed		arch_atomic_fetch_xor_relaxed
 
-#define atomic64_fetch_and_relaxed	atomic64_fetch_and_relaxed
-#define atomic64_fetch_andnot_relaxed	atomic64_fetch_andnot_relaxed
-#define atomic64_fetch_or_relaxed	atomic64_fetch_or_relaxed
-#define atomic64_fetch_xor_relaxed	atomic64_fetch_xor_relaxed
+#define arch_atomic64_fetch_and_relaxed		arch_atomic64_fetch_and_relaxed
+#define arch_atomic64_fetch_andnot_relaxed	arch_atomic64_fetch_andnot_relaxed
+#define arch_atomic64_fetch_or_relaxed		arch_atomic64_fetch_or_relaxed
+#define arch_atomic64_fetch_xor_relaxed		arch_atomic64_fetch_xor_relaxed
 
 #undef ATOMIC_OPS
 #undef ATOMIC64_FETCH_OP
@@ -198,14 +200,18 @@ ATOMIC_OPS(xor, xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define atomic64_cmpxchg(v, old, new) (cmpxchg(&((v)->counter), old, new))
-#define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic64_cmpxchg(v, old, new) \
+	(arch_cmpxchg(&((v)->counter), old, new))
+#define arch_atomic64_xchg(v, new) \
+	(arch_xchg(&((v)->counter), new))
 
-#define atomic_cmpxchg(v, old, new) (cmpxchg(&((v)->counter), old, new))
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic_cmpxchg(v, old, new) \
+	(arch_cmpxchg(&((v)->counter), old, new))
+#define arch_atomic_xchg(v, new) \
+	(arch_xchg(&((v)->counter), new))
 
 /**
- * atomic_fetch_add_unless - add unless the number is a given value
+ * arch_atomic_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -213,7 +219,7 @@ ATOMIC_OPS(xor, xor)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
+static __inline__ int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c, new, old;
 	smp_mb();
@@ -234,10 +240,10 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 	smp_mb();
 	return old;
 }
-#define atomic_fetch_add_unless atomic_fetch_add_unless
+#define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
 
 /**
- * atomic64_fetch_add_unless - add unless the number is a given value
+ * arch_atomic64_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic64_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -245,7 +251,7 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+static __inline__ s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	s64 c, new, old;
 	smp_mb();
@@ -266,16 +272,16 @@ static __inline__ s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 	smp_mb();
 	return old;
 }
-#define atomic64_fetch_add_unless atomic64_fetch_add_unless
+#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
 
 /*
- * atomic64_dec_if_positive - decrement by 1 if old value positive
+ * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
  * @v: pointer of type atomic_t
  *
  * The function returns the old value of *v minus 1, even if
  * the atomic variable, v, was not decremented.
  */
-static inline s64 atomic64_dec_if_positive(atomic64_t *v)
+static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 old, tmp;
 	smp_mb();
@@ -295,6 +301,6 @@ static inline s64 atomic64_dec_if_positive(atomic64_t *v)
 	smp_mb();
 	return old - 1;
 }
-#define atomic64_dec_if_positive atomic64_dec_if_positive
+#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 
 #endif /* _ALPHA_ATOMIC_H */
diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
index 6c7c394..6e0a850 100644
--- a/arch/alpha/include/asm/cmpxchg.h
+++ b/arch/alpha/include/asm/cmpxchg.h
@@ -17,7 +17,7 @@
 				       sizeof(*(ptr)));			\
 })
 
-#define cmpxchg_local(ptr, o, n)					\
+#define arch_cmpxchg_local(ptr, o, n)					\
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
@@ -26,7 +26,7 @@
 					  sizeof(*(ptr)));		\
 })
 
-#define cmpxchg64_local(ptr, o, n)					\
+#define arch_cmpxchg64_local(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
 	cmpxchg_local((ptr), (o), (n));					\
@@ -42,7 +42,7 @@
  * The leading and the trailing memory barriers guarantee that these
  * operations are fully ordered.
  */
-#define xchg(ptr, x)							\
+#define arch_xchg(ptr, x)						\
 ({									\
 	__typeof__(*(ptr)) __ret;					\
 	__typeof__(*(ptr)) _x_ = (x);					\
@@ -53,7 +53,7 @@
 	__ret;								\
 })
 
-#define cmpxchg(ptr, o, n)						\
+#define arch_cmpxchg(ptr, o, n)						\
 ({									\
 	__typeof__(*(ptr)) __ret;					\
 	__typeof__(*(ptr)) _o_ = (o);					\
@@ -65,10 +65,10 @@
 	__ret;								\
 })
 
-#define cmpxchg64(ptr, o, n)						\
+#define arch_cmpxchg64(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg((ptr), (o), (n));					\
+	arch_cmpxchg((ptr), (o), (n));					\
 })
 
 #undef ____cmpxchg
