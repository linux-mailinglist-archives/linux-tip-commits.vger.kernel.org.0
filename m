Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDE23915E8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhEZL0Q (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54596 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbhEZL0H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:07 -0400
Date:   Wed, 26 May 2021 11:24:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=844rWOHsZk4qE/BA1+7k+BYwPSDFrX7dFh61cCG0w6Q=;
        b=hh5bNqSlTjSb4/oEW60u/xewvabF7AEWCY+siP5VMlV3Q/xU2hR5RHRkCs2owcfTOP1G7y
        kwtsWJsvaZ9LPfbCf5xVC1wLFO04uYfNYdKFD9B+gSNFaM5U/rXtQMfQRucrWvd8i71jUf
        dNSlIbAE6u1mGTMnwtvFOqZLSPsT6MNVFu1bgyfvMMyTQGLVxJD+z5nRDZ50g4otlOg3l4
        sAkbjTi/AI8T8WB3E76Ia4nJwrFbJwOvkd+Ck00Yda78TTsm1jv0JxU1WFENlHh5KPrQvU
        E5sww2mqqoIaY+yT9VI6Dqm0BbRNX0tLZPCgFQfIkbgKmE/CIjlLJzPGv+Kckg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=844rWOHsZk4qE/BA1+7k+BYwPSDFrX7dFh61cCG0w6Q=;
        b=0iixF45LRpsaSY0hpZpWw9rXEcYxODxvGIa+MLgdFNY1+T3OFP7Hqg3tmP3pdN5j/ToDlT
        D7LBxdH7zB6ejeBA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: mips: move to ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-23-mark.rutland@arm.com>
References: <20210525140232.53872-23-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827385.29796.15731213902378955393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c7b5fd6faa1dc6cdc721a978d9d122cd31bbd7b1
Gitweb:        https://git.kernel.org/tip/c7b5fd6faa1dc6cdc721a978d9d122cd31bbd7b1
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:21 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:51 +02:00

locking/atomic: mips: move to ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates mips to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-23-mark.rutland@arm.com
---
 arch/mips/Kconfig               |  1 +-
 arch/mips/include/asm/atomic.h  | 55 ++++++++++++++++----------------
 arch/mips/include/asm/cmpxchg.h | 22 ++++++-------
 arch/mips/kernel/cmpxchg.c      |  4 +-
 4 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ed51970..55b4da9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3,6 +3,7 @@ config MIPS
 	bool
 	default y
 	select ARCH_32BIT_OFF_T if !64BIT
+	select ARCH_ATOMIC
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
 	select ARCH_HAS_DEBUG_VIRTUAL if !64BIT
 	select ARCH_HAS_FORTIFY_SOURCE
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 27ad767..95e1f7f 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -25,24 +25,25 @@
 #include <asm/war.h>
 
 #define ATOMIC_OPS(pfx, type)						\
-static __always_inline type pfx##_read(const pfx##_t *v)		\
+static __always_inline type arch_##pfx##_read(const pfx##_t *v)		\
 {									\
 	return READ_ONCE(v->counter);					\
 }									\
 									\
-static __always_inline void pfx##_set(pfx##_t *v, type i)		\
+static __always_inline void arch_##pfx##_set(pfx##_t *v, type i)	\
 {									\
 	WRITE_ONCE(v->counter, i);					\
 }									\
 									\
-static __always_inline type pfx##_cmpxchg(pfx##_t *v, type o, type n)	\
+static __always_inline type						\
+arch_##pfx##_cmpxchg(pfx##_t *v, type o, type n)			\
 {									\
-	return cmpxchg(&v->counter, o, n);				\
+	return arch_cmpxchg(&v->counter, o, n);				\
 }									\
 									\
-static __always_inline type pfx##_xchg(pfx##_t *v, type n)		\
+static __always_inline type arch_##pfx##_xchg(pfx##_t *v, type n)	\
 {									\
-	return xchg(&v->counter, n);					\
+	return arch_xchg(&v->counter, n);				\
 }
 
 ATOMIC_OPS(atomic, int)
@@ -53,7 +54,7 @@ ATOMIC_OPS(atomic64, s64)
 #endif
 
 #define ATOMIC_OP(pfx, op, type, c_op, asm_op, ll, sc)			\
-static __inline__ void pfx##_##op(type i, pfx##_t * v)			\
+static __inline__ void arch_##pfx##_##op(type i, pfx##_t * v)		\
 {									\
 	type temp;							\
 									\
@@ -80,7 +81,8 @@ static __inline__ void pfx##_##op(type i, pfx##_t * v)			\
 }
 
 #define ATOMIC_OP_RETURN(pfx, op, type, c_op, asm_op, ll, sc)		\
-static __inline__ type pfx##_##op##_return_relaxed(type i, pfx##_t * v)	\
+static __inline__ type							\
+arch_##pfx##_##op##_return_relaxed(type i, pfx##_t * v)			\
 {									\
 	type temp, result;						\
 									\
@@ -113,7 +115,8 @@ static __inline__ type pfx##_##op##_return_relaxed(type i, pfx##_t * v)	\
 }
 
 #define ATOMIC_FETCH_OP(pfx, op, type, c_op, asm_op, ll, sc)		\
-static __inline__ type pfx##_fetch_##op##_relaxed(type i, pfx##_t * v)	\
+static __inline__ type							\
+arch_##pfx##_fetch_##op##_relaxed(type i, pfx##_t * v)			\
 {									\
 	int temp, result;						\
 									\
@@ -153,18 +156,18 @@ static __inline__ type pfx##_fetch_##op##_relaxed(type i, pfx##_t * v)	\
 ATOMIC_OPS(atomic, add, int, +=, addu, ll, sc)
 ATOMIC_OPS(atomic, sub, int, -=, subu, ll, sc)
 
-#define atomic_add_return_relaxed	atomic_add_return_relaxed
-#define atomic_sub_return_relaxed	atomic_sub_return_relaxed
-#define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
-#define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
+#define arch_atomic_add_return_relaxed	arch_atomic_add_return_relaxed
+#define arch_atomic_sub_return_relaxed	arch_atomic_sub_return_relaxed
+#define arch_atomic_fetch_add_relaxed	arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_sub_relaxed	arch_atomic_fetch_sub_relaxed
 
 #ifdef CONFIG_64BIT
 ATOMIC_OPS(atomic64, add, s64, +=, daddu, lld, scd)
 ATOMIC_OPS(atomic64, sub, s64, -=, dsubu, lld, scd)
-# define atomic64_add_return_relaxed	atomic64_add_return_relaxed
-# define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
-# define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
-# define atomic64_fetch_sub_relaxed	atomic64_fetch_sub_relaxed
+# define arch_atomic64_add_return_relaxed	arch_atomic64_add_return_relaxed
+# define arch_atomic64_sub_return_relaxed	arch_atomic64_sub_return_relaxed
+# define arch_atomic64_fetch_add_relaxed	arch_atomic64_fetch_add_relaxed
+# define arch_atomic64_fetch_sub_relaxed	arch_atomic64_fetch_sub_relaxed
 #endif /* CONFIG_64BIT */
 
 #undef ATOMIC_OPS
@@ -176,17 +179,17 @@ ATOMIC_OPS(atomic, and, int, &=, and, ll, sc)
 ATOMIC_OPS(atomic, or, int, |=, or, ll, sc)
 ATOMIC_OPS(atomic, xor, int, ^=, xor, ll, sc)
 
-#define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
-#define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
-#define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
+#define arch_atomic_fetch_and_relaxed	arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_or_relaxed	arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_xor_relaxed	arch_atomic_fetch_xor_relaxed
 
 #ifdef CONFIG_64BIT
 ATOMIC_OPS(atomic64, and, s64, &=, and, lld, scd)
 ATOMIC_OPS(atomic64, or, s64, |=, or, lld, scd)
 ATOMIC_OPS(atomic64, xor, s64, ^=, xor, lld, scd)
-# define atomic64_fetch_and_relaxed	atomic64_fetch_and_relaxed
-# define atomic64_fetch_or_relaxed	atomic64_fetch_or_relaxed
-# define atomic64_fetch_xor_relaxed	atomic64_fetch_xor_relaxed
+# define arch_atomic64_fetch_and_relaxed	arch_atomic64_fetch_and_relaxed
+# define arch_atomic64_fetch_or_relaxed		arch_atomic64_fetch_or_relaxed
+# define arch_atomic64_fetch_xor_relaxed	arch_atomic64_fetch_xor_relaxed
 #endif
 
 #undef ATOMIC_OPS
@@ -203,7 +206,7 @@ ATOMIC_OPS(atomic64, xor, s64, ^=, xor, lld, scd)
  * The function returns the old value of @v minus @i.
  */
 #define ATOMIC_SIP_OP(pfx, type, op, ll, sc)				\
-static __inline__ int pfx##_sub_if_positive(type i, pfx##_t * v)	\
+static __inline__ int arch_##pfx##_sub_if_positive(type i, pfx##_t * v)	\
 {									\
 	type temp, result;						\
 									\
@@ -255,11 +258,11 @@ static __inline__ int pfx##_sub_if_positive(type i, pfx##_t * v)	\
 }
 
 ATOMIC_SIP_OP(atomic, int, subu, ll, sc)
-#define atomic_dec_if_positive(v)	atomic_sub_if_positive(1, v)
+#define arch_atomic_dec_if_positive(v)	arch_atomic_sub_if_positive(1, v)
 
 #ifdef CONFIG_64BIT
 ATOMIC_SIP_OP(atomic64, s64, dsubu, lld, scd)
-#define atomic64_dec_if_positive(v)	atomic64_sub_if_positive(1, v)
+#define arch_atomic64_dec_if_positive(v)	arch_atomic64_sub_if_positive(1, v)
 #endif
 
 #undef ATOMIC_SIP_OP
diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index c7e0455..0b98380 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -90,7 +90,7 @@ unsigned long __xchg(volatile void *ptr, unsigned long x, int size)
 	}
 }
 
-#define xchg(ptr, x)							\
+#define arch_xchg(ptr, x)						\
 ({									\
 	__typeof__(*(ptr)) __res;					\
 									\
@@ -175,14 +175,14 @@ unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	}
 }
 
-#define cmpxchg_local(ptr, old, new)					\
+#define arch_cmpxchg_local(ptr, old, new)				\
 	((__typeof__(*(ptr)))						\
 		__cmpxchg((ptr),					\
 			  (unsigned long)(__typeof__(*(ptr)))(old),	\
 			  (unsigned long)(__typeof__(*(ptr)))(new),	\
 			  sizeof(*(ptr))))
 
-#define cmpxchg(ptr, old, new)						\
+#define arch_cmpxchg(ptr, old, new)					\
 ({									\
 	__typeof__(*(ptr)) __res;					\
 									\
@@ -194,7 +194,7 @@ unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	if (__SYNC_loongson3_war == 0)					\
 		smp_mb__before_llsc();					\
 									\
-	__res = cmpxchg_local((ptr), (old), (new));			\
+	__res = arch_cmpxchg_local((ptr), (old), (new));		\
 									\
 	/*								\
 	 * In the Loongson3 workaround case __cmpxchg_asm() already	\
@@ -208,21 +208,21 @@ unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 })
 
 #ifdef CONFIG_64BIT
-#define cmpxchg64_local(ptr, o, n)					\
+#define arch_cmpxchg64_local(ptr, o, n)					\
   ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg_local((ptr), (o), (n));					\
+	arch_cmpxchg_local((ptr), (o), (n));				\
   })
 
-#define cmpxchg64(ptr, o, n)						\
+#define arch_cmpxchg64(ptr, o, n)					\
   ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg((ptr), (o), (n));					\
+	arch_cmpxchg((ptr), (o), (n));					\
   })
 #else
 
 # include <asm-generic/cmpxchg-local.h>
-# define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+# define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 
 # ifdef CONFIG_SMP
 
@@ -294,7 +294,7 @@ static inline unsigned long __cmpxchg64(volatile void *ptr,
 	return ret;
 }
 
-#  define cmpxchg64(ptr, o, n) ({					\
+#  define arch_cmpxchg64(ptr, o, n) ({					\
 	unsigned long long __old = (__typeof__(*(ptr)))(o);		\
 	unsigned long long __new = (__typeof__(*(ptr)))(n);		\
 	__typeof__(*(ptr)) __res;					\
@@ -317,7 +317,7 @@ static inline unsigned long __cmpxchg64(volatile void *ptr,
 })
 
 # else /* !CONFIG_SMP */
-#  define cmpxchg64(ptr, o, n) cmpxchg64_local((ptr), (o), (n))
+#  define arch_cmpxchg64(ptr, o, n) arch_cmpxchg64_local((ptr), (o), (n))
 # endif /* !CONFIG_SMP */
 #endif /* !CONFIG_64BIT */
 
diff --git a/arch/mips/kernel/cmpxchg.c b/arch/mips/kernel/cmpxchg.c
index 89107de..ac9c8cf 100644
--- a/arch/mips/kernel/cmpxchg.c
+++ b/arch/mips/kernel/cmpxchg.c
@@ -41,7 +41,7 @@ unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int s
 	do {
 		old32 = load32;
 		new32 = (load32 & ~mask) | (val << shift);
-		load32 = cmpxchg(ptr32, old32, new32);
+		load32 = arch_cmpxchg(ptr32, old32, new32);
 	} while (load32 != old32);
 
 	return (load32 & mask) >> shift;
@@ -97,7 +97,7 @@ unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
 		 */
 		old32 = (load32 & ~mask) | (old << shift);
 		new32 = (load32 & ~mask) | (new << shift);
-		load32 = cmpxchg(ptr32, old32, new32);
+		load32 = arch_cmpxchg(ptr32, old32, new32);
 		if (load32 == old32)
 			return old;
 	}
