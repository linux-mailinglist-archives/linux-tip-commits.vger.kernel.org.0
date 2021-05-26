Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B053915F5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhEZL0f (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbhEZL0M (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3490CC06138B;
        Wed, 26 May 2021 04:24:39 -0700 (PDT)
Date:   Wed, 26 May 2021 11:24:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028277;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yYcMArmu/l85VrAXH+kL57Xgi5tt6XyHGA+G3Ck1j50=;
        b=yFZX9Rt2/8qDISbMzSYIIeERi6zilgzyy4oXIQFgELEgdVLXQKYuhgBIdiRYnHB4iEmRz1
        SOqbV3eBqXJV6bxw9fVmupmIIftkb5dlvOfy0tGlTKW9b/b0B2cymHzclWJP2TY2gYVyUF
        +sClvQxo6ud0GDGHyOHuHxeATxSFUbhLtfMvijn2CXe6MoJO9wA4+UtdAinb9t3h7jYXEg
        O+Bw73y6DTdS1CzI1RkwmmrMKups/v7BtJgagUYaLENVEUU+w/FHg7kDJ0ix/t26Kn2g0k
        gUeVBFkg6z1iNOTAVthap61jMfQmWsX6ldEyIrYGL3DJo+XoUVn2gWkfNY9yVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028277;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yYcMArmu/l85VrAXH+kL57Xgi5tt6XyHGA+G3Ck1j50=;
        b=hZryZNlncFbsbqoN3v+SG5Th83q7k+CrO1IzMlLJJlnnEqe3bB30Pm5+OfG6hKv6bTVRlN
        wUikEOXHpeoWDfDA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: arm: move to ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-16-mark.rutland@arm.com>
References: <20210525140232.53872-16-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827697.29796.17214636356007409198.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     fc63a6e08a8c97a3dc3a6f2e1946b949b9a6c2d3
Gitweb:        https://git.kernel.org/tip/fc63a6e08a8c97a3dc3a6f2e1946b949b9a6c2d3
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:14 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:50 +02:00

locking/atomic: arm: move to ARCH_ATOMIC

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
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-16-mark.rutland@arm.com
---
 arch/arm/Kconfig                   |  1 +-
 arch/arm/include/asm/atomic.h      | 96 ++++++++++++++---------------
 arch/arm/include/asm/cmpxchg.h     | 16 ++---
 arch/arm/include/asm/sync_bitops.h |  2 +-
 4 files changed, 58 insertions(+), 57 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24804f1..b7334a6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -3,6 +3,7 @@ config ARM
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 455eb19..db8512d 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -22,8 +22,8 @@
  * strex/ldrex monitor on some implementations. The reason we can use it for
  * atomic_set() is the clrex or dummy strex done on every exception return.
  */
-#define atomic_read(v)	READ_ONCE((v)->counter)
-#define atomic_set(v,i)	WRITE_ONCE(((v)->counter), (i))
+#define arch_atomic_read(v)	READ_ONCE((v)->counter)
+#define arch_atomic_set(v,i)	WRITE_ONCE(((v)->counter), (i))
 
 #if __LINUX_ARM_ARCH__ >= 6
 
@@ -34,7 +34,7 @@
  */
 
 #define ATOMIC_OP(op, c_op, asm_op)					\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -52,7 +52,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int atomic_##op##_return_relaxed(int i, atomic_t *v)	\
+static inline int arch_atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -73,7 +73,7 @@ static inline int atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
+static inline int arch_atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 {									\
 	unsigned long tmp;						\
 	int result, val;						\
@@ -93,17 +93,17 @@ static inline int atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 	return result;							\
 }
 
-#define atomic_add_return_relaxed	atomic_add_return_relaxed
-#define atomic_sub_return_relaxed	atomic_sub_return_relaxed
-#define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
-#define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
+#define arch_atomic_add_return_relaxed		arch_atomic_add_return_relaxed
+#define arch_atomic_sub_return_relaxed		arch_atomic_sub_return_relaxed
+#define arch_atomic_fetch_add_relaxed		arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_sub_relaxed		arch_atomic_fetch_sub_relaxed
 
-#define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
-#define atomic_fetch_andnot_relaxed	atomic_fetch_andnot_relaxed
-#define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
-#define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
+#define arch_atomic_fetch_and_relaxed		arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_andnot_relaxed	arch_atomic_fetch_andnot_relaxed
+#define arch_atomic_fetch_or_relaxed		arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_xor_relaxed		arch_atomic_fetch_xor_relaxed
 
-static inline int atomic_cmpxchg_relaxed(atomic_t *ptr, int old, int new)
+static inline int arch_atomic_cmpxchg_relaxed(atomic_t *ptr, int old, int new)
 {
 	int oldval;
 	unsigned long res;
@@ -123,9 +123,9 @@ static inline int atomic_cmpxchg_relaxed(atomic_t *ptr, int old, int new)
 
 	return oldval;
 }
-#define atomic_cmpxchg_relaxed		atomic_cmpxchg_relaxed
+#define arch_atomic_cmpxchg_relaxed		arch_atomic_cmpxchg_relaxed
 
-static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
+static inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int oldval, newval;
 	unsigned long tmp;
@@ -151,7 +151,7 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 
 	return oldval;
 }
-#define atomic_fetch_add_unless		atomic_fetch_add_unless
+#define arch_atomic_fetch_add_unless		arch_atomic_fetch_add_unless
 
 #else /* ARM_ARCH_6 */
 
@@ -160,7 +160,7 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 #endif
 
 #define ATOMIC_OP(op, c_op, asm_op)					\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	unsigned long flags;						\
 									\
@@ -170,7 +170,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
 	int val;							\
@@ -184,7 +184,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
 	int val;							\
@@ -197,7 +197,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 	return val;							\
 }
 
-static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
+static inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	int ret;
 	unsigned long flags;
@@ -211,7 +211,7 @@ static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 	return ret;
 }
 
-#define atomic_fetch_andnot		atomic_fetch_andnot
+#define arch_atomic_fetch_andnot		arch_atomic_fetch_andnot
 
 #endif /* __LINUX_ARM_ARCH__ */
 
@@ -223,7 +223,7 @@ static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
 
-#define atomic_andnot atomic_andnot
+#define arch_atomic_andnot arch_atomic_andnot
 
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op, c_op, asm_op)					\
@@ -240,7 +240,7 @@ ATOMIC_OPS(xor, ^=, eor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), new))
 
 #ifndef CONFIG_GENERIC_ATOMIC64
 typedef struct {
@@ -250,7 +250,7 @@ typedef struct {
 #define ATOMIC64_INIT(i) { (i) }
 
 #ifdef CONFIG_ARM_LPAE
-static inline s64 atomic64_read(const atomic64_t *v)
+static inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	s64 result;
 
@@ -263,7 +263,7 @@ static inline s64 atomic64_read(const atomic64_t *v)
 	return result;
 }
 
-static inline void atomic64_set(atomic64_t *v, s64 i)
+static inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	__asm__ __volatile__("@ atomic64_set\n"
 "	strd	%2, %H2, [%1]"
@@ -272,7 +272,7 @@ static inline void atomic64_set(atomic64_t *v, s64 i)
 	);
 }
 #else
-static inline s64 atomic64_read(const atomic64_t *v)
+static inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	s64 result;
 
@@ -285,7 +285,7 @@ static inline s64 atomic64_read(const atomic64_t *v)
 	return result;
 }
 
-static inline void atomic64_set(atomic64_t *v, s64 i)
+static inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	s64 tmp;
 
@@ -302,7 +302,7 @@ static inline void atomic64_set(atomic64_t *v, s64 i)
 #endif
 
 #define ATOMIC64_OP(op, op1, op2)					\
-static inline void atomic64_##op(s64 i, atomic64_t *v)			\
+static inline void arch_atomic64_##op(s64 i, atomic64_t *v)		\
 {									\
 	s64 result;							\
 	unsigned long tmp;						\
@@ -322,7 +322,7 @@ static inline void atomic64_##op(s64 i, atomic64_t *v)			\
 
 #define ATOMIC64_OP_RETURN(op, op1, op2)				\
 static inline s64							\
-atomic64_##op##_return_relaxed(s64 i, atomic64_t *v)			\
+arch_atomic64_##op##_return_relaxed(s64 i, atomic64_t *v)		\
 {									\
 	s64 result;							\
 	unsigned long tmp;						\
@@ -345,7 +345,7 @@ atomic64_##op##_return_relaxed(s64 i, atomic64_t *v)			\
 
 #define ATOMIC64_FETCH_OP(op, op1, op2)					\
 static inline s64							\
-atomic64_fetch_##op##_relaxed(s64 i, atomic64_t *v)			\
+arch_atomic64_fetch_##op##_relaxed(s64 i, atomic64_t *v)		\
 {									\
 	s64 result, val;						\
 	unsigned long tmp;						\
@@ -374,34 +374,34 @@ atomic64_fetch_##op##_relaxed(s64 i, atomic64_t *v)			\
 ATOMIC64_OPS(add, adds, adc)
 ATOMIC64_OPS(sub, subs, sbc)
 
-#define atomic64_add_return_relaxed	atomic64_add_return_relaxed
-#define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
-#define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
-#define atomic64_fetch_sub_relaxed	atomic64_fetch_sub_relaxed
+#define arch_atomic64_add_return_relaxed	arch_atomic64_add_return_relaxed
+#define arch_atomic64_sub_return_relaxed	arch_atomic64_sub_return_relaxed
+#define arch_atomic64_fetch_add_relaxed		arch_atomic64_fetch_add_relaxed
+#define arch_atomic64_fetch_sub_relaxed		arch_atomic64_fetch_sub_relaxed
 
 #undef ATOMIC64_OPS
 #define ATOMIC64_OPS(op, op1, op2)					\
 	ATOMIC64_OP(op, op1, op2)					\
 	ATOMIC64_FETCH_OP(op, op1, op2)
 
-#define atomic64_andnot atomic64_andnot
+#define arch_atomic64_andnot arch_atomic64_andnot
 
 ATOMIC64_OPS(and, and, and)
 ATOMIC64_OPS(andnot, bic, bic)
 ATOMIC64_OPS(or,  orr, orr)
 ATOMIC64_OPS(xor, eor, eor)
 
-#define atomic64_fetch_and_relaxed	atomic64_fetch_and_relaxed
-#define atomic64_fetch_andnot_relaxed	atomic64_fetch_andnot_relaxed
-#define atomic64_fetch_or_relaxed	atomic64_fetch_or_relaxed
-#define atomic64_fetch_xor_relaxed	atomic64_fetch_xor_relaxed
+#define arch_atomic64_fetch_and_relaxed		arch_atomic64_fetch_and_relaxed
+#define arch_atomic64_fetch_andnot_relaxed	arch_atomic64_fetch_andnot_relaxed
+#define arch_atomic64_fetch_or_relaxed		arch_atomic64_fetch_or_relaxed
+#define arch_atomic64_fetch_xor_relaxed		arch_atomic64_fetch_xor_relaxed
 
 #undef ATOMIC64_OPS
 #undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-static inline s64 atomic64_cmpxchg_relaxed(atomic64_t *ptr, s64 old, s64 new)
+static inline s64 arch_atomic64_cmpxchg_relaxed(atomic64_t *ptr, s64 old, s64 new)
 {
 	s64 oldval;
 	unsigned long res;
@@ -422,9 +422,9 @@ static inline s64 atomic64_cmpxchg_relaxed(atomic64_t *ptr, s64 old, s64 new)
 
 	return oldval;
 }
-#define atomic64_cmpxchg_relaxed	atomic64_cmpxchg_relaxed
+#define arch_atomic64_cmpxchg_relaxed	arch_atomic64_cmpxchg_relaxed
 
-static inline s64 atomic64_xchg_relaxed(atomic64_t *ptr, s64 new)
+static inline s64 arch_atomic64_xchg_relaxed(atomic64_t *ptr, s64 new)
 {
 	s64 result;
 	unsigned long tmp;
@@ -442,9 +442,9 @@ static inline s64 atomic64_xchg_relaxed(atomic64_t *ptr, s64 new)
 
 	return result;
 }
-#define atomic64_xchg_relaxed		atomic64_xchg_relaxed
+#define arch_atomic64_xchg_relaxed		arch_atomic64_xchg_relaxed
 
-static inline s64 atomic64_dec_if_positive(atomic64_t *v)
+static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 result;
 	unsigned long tmp;
@@ -470,9 +470,9 @@ static inline s64 atomic64_dec_if_positive(atomic64_t *v)
 
 	return result;
 }
-#define atomic64_dec_if_positive atomic64_dec_if_positive
+#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 
-static inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+static inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	s64 oldval, newval;
 	unsigned long tmp;
@@ -500,7 +500,7 @@ static inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 
 	return oldval;
 }
-#define atomic64_fetch_add_unless atomic64_fetch_add_unless
+#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
 
 #endif /* !CONFIG_GENERIC_ATOMIC64 */
 #endif
diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 06bd8ce..4dfe538 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -114,7 +114,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 	return ret;
 }
 
-#define xchg_relaxed(ptr, x) ({						\
+#define arch_xchg_relaxed(ptr, x) ({					\
 	(__typeof__(*(ptr)))__xchg((unsigned long)(x), (ptr),		\
 				   sizeof(*(ptr)));			\
 })
@@ -128,20 +128,20 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 #error "SMP is not supported on this platform"
 #endif
 
-#define xchg xchg_relaxed
+#define arch_xchg arch_xchg_relaxed
 
 /*
  * cmpxchg_local and cmpxchg64_local are atomic wrt current CPU. Always make
  * them available.
  */
-#define cmpxchg_local(ptr, o, n) ({					\
+#define arch_cmpxchg_local(ptr, o, n) ({				\
 	(__typeof(*ptr))__generic_cmpxchg_local((ptr),			\
 					        (unsigned long)(o),	\
 					        (unsigned long)(n),	\
 					        sizeof(*(ptr)));	\
 })
 
-#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 
 #include <asm-generic/cmpxchg.h>
 
@@ -207,7 +207,7 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	return oldval;
 }
 
-#define cmpxchg_relaxed(ptr,o,n) ({					\
+#define arch_cmpxchg_relaxed(ptr,o,n) ({				\
 	(__typeof__(*(ptr)))__cmpxchg((ptr),				\
 				      (unsigned long)(o),		\
 				      (unsigned long)(n),		\
@@ -234,7 +234,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 	return ret;
 }
 
-#define cmpxchg_local(ptr, o, n) ({					\
+#define arch_cmpxchg_local(ptr, o, n) ({				\
 	(__typeof(*ptr))__cmpxchg_local((ptr),				\
 				        (unsigned long)(o),		\
 				        (unsigned long)(n),		\
@@ -266,13 +266,13 @@ static inline unsigned long long __cmpxchg64(unsigned long long *ptr,
 	return oldval;
 }
 
-#define cmpxchg64_relaxed(ptr, o, n) ({					\
+#define arch_cmpxchg64_relaxed(ptr, o, n) ({				\
 	(__typeof__(*(ptr)))__cmpxchg64((ptr),				\
 					(unsigned long long)(o),	\
 					(unsigned long long)(n));	\
 })
 
-#define cmpxchg64_local(ptr, o, n) cmpxchg64_relaxed((ptr), (o), (n))
+#define arch_cmpxchg64_local(ptr, o, n) arch_cmpxchg64_relaxed((ptr), (o), (n))
 
 #endif	/* __LINUX_ARM_ARCH__ >= 6 */
 
diff --git a/arch/arm/include/asm/sync_bitops.h b/arch/arm/include/asm/sync_bitops.h
index 39ff217..6f5d627 100644
--- a/arch/arm/include/asm/sync_bitops.h
+++ b/arch/arm/include/asm/sync_bitops.h
@@ -21,7 +21,7 @@
 #define sync_test_and_clear_bit(nr, p)	_test_and_clear_bit(nr, p)
 #define sync_test_and_change_bit(nr, p)	_test_and_change_bit(nr, p)
 #define sync_test_bit(nr, addr)		test_bit(nr, addr)
-#define sync_cmpxchg			cmpxchg
+#define arch_sync_cmpxchg		arch_cmpxchg
 
 
 #endif
