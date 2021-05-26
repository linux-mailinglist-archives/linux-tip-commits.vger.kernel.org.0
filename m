Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5773915DE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbhEZL0I (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54596 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbhEZL0E (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:04 -0400
Date:   Wed, 26 May 2021 11:24:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXrx2Az6xMgA2loqVEsI+9XCleQ+b3EN4Ow7X2d3hrc=;
        b=3c8OvpYDxD3MM4bNbdXBOp3kuK3YCAAky7YGJS6qM+cj8A8P2up02x5DXfRZyeqT31lXjs
        jXS3rIZ3xgF1DN++K5xFXqJKglSjVmfiW1cYBJvXT/8UPdXUvVH84D08tVpks1iWKFsgxs
        5T3YNhFhawKLfL5EJ0qZG1fMcVmcouOlfdRQ1ENke3WwRTclLb5nEmW+PVCa3iaHWcPi6Z
        JveVp/Ql2XSnsqZ8amiggFXJqbEEEM4TNTH4MIQAhu8f/ZpmL2xD9b686Va4fbpxM46kPi
        8rzD18R396FJb2JsFAaXjq+IRrMQXvj/Ut4pnSoGx0Kg+V/cu3qRNapF8WI0Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXrx2Az6xMgA2loqVEsI+9XCleQ+b3EN4Ow7X2d3hrc=;
        b=Snd39mrAASptrcvCWkhyWp3zVrVJzxjbS5HB79txGmyuNLbLlriBtuyyJcNWhRrn51HNTY
        GVFUB72vi6LQ8BBQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: powerpc: move to ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-28-mark.rutland@arm.com>
References: <20210525140232.53872-28-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827146.29796.11094617774052287534.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9eaa82935dccb74a22e3da5045bed1dac59ad2b0
Gitweb:        https://git.kernel.org/tip/9eaa82935dccb74a22e3da5045bed1dac59ad2b0
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:26 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:52 +02:00

locking/atomic: powerpc: move to ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates powerpc to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

While atomic_try_cmpxchg_lock() is not part of the common atomic API, it
is given an `arch_` prefix for consistency.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-28-mark.rutland@arm.com
---
 arch/powerpc/Kconfig                 |   1 +-
 arch/powerpc/include/asm/atomic.h    | 140 +++++++++++++-------------
 arch/powerpc/include/asm/cmpxchg.h   |  30 +++---
 arch/powerpc/include/asm/qspinlock.h |   2 +-
 4 files changed, 90 insertions(+), 83 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 088dd2a..d143c2b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -118,6 +118,7 @@ config PPC
 	# Please keep this list sorted alphabetically.
 	#
 	select ARCH_32BIT_OFF_T if PPC32
+	select ARCH_ATOMIC
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_COPY_MC			if PPC64
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 61c6e8b..a1732a7 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -23,7 +23,7 @@
 #define __atomic_release_fence()					\
 	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory")
 
-static __inline__ int atomic_read(const atomic_t *v)
+static __inline__ int arch_atomic_read(const atomic_t *v)
 {
 	int t;
 
@@ -32,13 +32,13 @@ static __inline__ int atomic_read(const atomic_t *v)
 	return t;
 }
 
-static __inline__ void atomic_set(atomic_t *v, int i)
+static __inline__ void arch_atomic_set(atomic_t *v, int i)
 {
 	__asm__ __volatile__("stw%U0%X0 %1,%0" : "=m"UPD_CONSTR(v->counter) : "r"(i));
 }
 
 #define ATOMIC_OP(op, asm_op)						\
-static __inline__ void atomic_##op(int a, atomic_t *v)			\
+static __inline__ void arch_atomic_##op(int a, atomic_t *v)		\
 {									\
 	int t;								\
 									\
@@ -53,7 +53,7 @@ static __inline__ void atomic_##op(int a, atomic_t *v)			\
 }									\
 
 #define ATOMIC_OP_RETURN_RELAXED(op, asm_op)				\
-static inline int atomic_##op##_return_relaxed(int a, atomic_t *v)	\
+static inline int arch_atomic_##op##_return_relaxed(int a, atomic_t *v)	\
 {									\
 	int t;								\
 									\
@@ -70,7 +70,7 @@ static inline int atomic_##op##_return_relaxed(int a, atomic_t *v)	\
 }
 
 #define ATOMIC_FETCH_OP_RELAXED(op, asm_op)				\
-static inline int atomic_fetch_##op##_relaxed(int a, atomic_t *v)	\
+static inline int arch_atomic_fetch_##op##_relaxed(int a, atomic_t *v)	\
 {									\
 	int res, t;							\
 									\
@@ -94,11 +94,11 @@ static inline int atomic_fetch_##op##_relaxed(int a, atomic_t *v)	\
 ATOMIC_OPS(add, add)
 ATOMIC_OPS(sub, subf)
 
-#define atomic_add_return_relaxed atomic_add_return_relaxed
-#define atomic_sub_return_relaxed atomic_sub_return_relaxed
+#define arch_atomic_add_return_relaxed arch_atomic_add_return_relaxed
+#define arch_atomic_sub_return_relaxed arch_atomic_sub_return_relaxed
 
-#define atomic_fetch_add_relaxed atomic_fetch_add_relaxed
-#define atomic_fetch_sub_relaxed atomic_fetch_sub_relaxed
+#define arch_atomic_fetch_add_relaxed arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_sub_relaxed arch_atomic_fetch_sub_relaxed
 
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op, asm_op)						\
@@ -109,16 +109,16 @@ ATOMIC_OPS(and, and)
 ATOMIC_OPS(or, or)
 ATOMIC_OPS(xor, xor)
 
-#define atomic_fetch_and_relaxed atomic_fetch_and_relaxed
-#define atomic_fetch_or_relaxed  atomic_fetch_or_relaxed
-#define atomic_fetch_xor_relaxed atomic_fetch_xor_relaxed
+#define arch_atomic_fetch_and_relaxed arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_or_relaxed  arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_xor_relaxed arch_atomic_fetch_xor_relaxed
 
 #undef ATOMIC_OPS
 #undef ATOMIC_FETCH_OP_RELAXED
 #undef ATOMIC_OP_RETURN_RELAXED
 #undef ATOMIC_OP
 
-static __inline__ void atomic_inc(atomic_t *v)
+static __inline__ void arch_atomic_inc(atomic_t *v)
 {
 	int t;
 
@@ -131,9 +131,9 @@ static __inline__ void atomic_inc(atomic_t *v)
 	: "r" (&v->counter)
 	: "cc", "xer");
 }
-#define atomic_inc atomic_inc
+#define arch_atomic_inc arch_atomic_inc
 
-static __inline__ int atomic_inc_return_relaxed(atomic_t *v)
+static __inline__ int arch_atomic_inc_return_relaxed(atomic_t *v)
 {
 	int t;
 
@@ -149,7 +149,7 @@ static __inline__ int atomic_inc_return_relaxed(atomic_t *v)
 	return t;
 }
 
-static __inline__ void atomic_dec(atomic_t *v)
+static __inline__ void arch_atomic_dec(atomic_t *v)
 {
 	int t;
 
@@ -162,9 +162,9 @@ static __inline__ void atomic_dec(atomic_t *v)
 	: "r" (&v->counter)
 	: "cc", "xer");
 }
-#define atomic_dec atomic_dec
+#define arch_atomic_dec arch_atomic_dec
 
-static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
+static __inline__ int arch_atomic_dec_return_relaxed(atomic_t *v)
 {
 	int t;
 
@@ -180,17 +180,20 @@ static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
 	return t;
 }
 
-#define atomic_inc_return_relaxed atomic_inc_return_relaxed
-#define atomic_dec_return_relaxed atomic_dec_return_relaxed
+#define arch_atomic_inc_return_relaxed arch_atomic_inc_return_relaxed
+#define arch_atomic_dec_return_relaxed arch_atomic_dec_return_relaxed
 
-#define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
-#define atomic_cmpxchg_relaxed(v, o, n) \
-	cmpxchg_relaxed(&((v)->counter), (o), (n))
-#define atomic_cmpxchg_acquire(v, o, n) \
-	cmpxchg_acquire(&((v)->counter), (o), (n))
+#define arch_atomic_cmpxchg(v, o, n) \
+	(arch_cmpxchg(&((v)->counter), (o), (n)))
+#define arch_atomic_cmpxchg_relaxed(v, o, n) \
+	arch_cmpxchg_relaxed(&((v)->counter), (o), (n))
+#define arch_atomic_cmpxchg_acquire(v, o, n) \
+	arch_cmpxchg_acquire(&((v)->counter), (o), (n))
 
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
-#define atomic_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
+#define arch_atomic_xchg(v, new) \
+	(arch_xchg(&((v)->counter), new))
+#define arch_atomic_xchg_relaxed(v, new) \
+	arch_xchg_relaxed(&((v)->counter), (new))
 
 /*
  * Don't want to override the generic atomic_try_cmpxchg_acquire, because
@@ -199,7 +202,7 @@ static __inline__ int atomic_dec_return_relaxed(atomic_t *v)
  * would be a surprise).
  */
 static __always_inline bool
-atomic_try_cmpxchg_lock(atomic_t *v, int *old, int new)
+arch_atomic_try_cmpxchg_lock(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
 
@@ -229,7 +232,7 @@ atomic_try_cmpxchg_lock(atomic_t *v, int *old, int new)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
+static __inline__ int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int t;
 
@@ -250,7 +253,7 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 
 	return t;
 }
-#define atomic_fetch_add_unless atomic_fetch_add_unless
+#define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
 
 /**
  * atomic_inc_not_zero - increment unless the number is zero
@@ -259,7 +262,7 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
  * Atomically increments @v by 1, so long as @v is non-zero.
  * Returns non-zero if @v was non-zero, and zero otherwise.
  */
-static __inline__ int atomic_inc_not_zero(atomic_t *v)
+static __inline__ int arch_atomic_inc_not_zero(atomic_t *v)
 {
 	int t1, t2;
 
@@ -280,14 +283,14 @@ static __inline__ int atomic_inc_not_zero(atomic_t *v)
 
 	return t1;
 }
-#define atomic_inc_not_zero(v) atomic_inc_not_zero((v))
+#define arch_atomic_inc_not_zero(v) arch_atomic_inc_not_zero((v))
 
 /*
  * Atomically test *v and decrement if it is greater than 0.
  * The function returns the old value of *v minus 1, even if
  * the atomic variable, v, was not decremented.
  */
-static __inline__ int atomic_dec_if_positive(atomic_t *v)
+static __inline__ int arch_atomic_dec_if_positive(atomic_t *v)
 {
 	int t;
 
@@ -307,13 +310,13 @@ static __inline__ int atomic_dec_if_positive(atomic_t *v)
 
 	return t;
 }
-#define atomic_dec_if_positive atomic_dec_if_positive
+#define arch_atomic_dec_if_positive arch_atomic_dec_if_positive
 
 #ifdef __powerpc64__
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-static __inline__ s64 atomic64_read(const atomic64_t *v)
+static __inline__ s64 arch_atomic64_read(const atomic64_t *v)
 {
 	s64 t;
 
@@ -322,13 +325,13 @@ static __inline__ s64 atomic64_read(const atomic64_t *v)
 	return t;
 }
 
-static __inline__ void atomic64_set(atomic64_t *v, s64 i)
+static __inline__ void arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	__asm__ __volatile__("std%U0%X0 %1,%0" : "=m"UPD_CONSTR(v->counter) : "r"(i));
 }
 
 #define ATOMIC64_OP(op, asm_op)						\
-static __inline__ void atomic64_##op(s64 a, atomic64_t *v)		\
+static __inline__ void arch_atomic64_##op(s64 a, atomic64_t *v)		\
 {									\
 	s64 t;								\
 									\
@@ -344,7 +347,7 @@ static __inline__ void atomic64_##op(s64 a, atomic64_t *v)		\
 
 #define ATOMIC64_OP_RETURN_RELAXED(op, asm_op)				\
 static inline s64							\
-atomic64_##op##_return_relaxed(s64 a, atomic64_t *v)			\
+arch_atomic64_##op##_return_relaxed(s64 a, atomic64_t *v)		\
 {									\
 	s64 t;								\
 									\
@@ -362,7 +365,7 @@ atomic64_##op##_return_relaxed(s64 a, atomic64_t *v)			\
 
 #define ATOMIC64_FETCH_OP_RELAXED(op, asm_op)				\
 static inline s64							\
-atomic64_fetch_##op##_relaxed(s64 a, atomic64_t *v)			\
+arch_atomic64_fetch_##op##_relaxed(s64 a, atomic64_t *v)		\
 {									\
 	s64 res, t;							\
 									\
@@ -386,11 +389,11 @@ atomic64_fetch_##op##_relaxed(s64 a, atomic64_t *v)			\
 ATOMIC64_OPS(add, add)
 ATOMIC64_OPS(sub, subf)
 
-#define atomic64_add_return_relaxed atomic64_add_return_relaxed
-#define atomic64_sub_return_relaxed atomic64_sub_return_relaxed
+#define arch_atomic64_add_return_relaxed arch_atomic64_add_return_relaxed
+#define arch_atomic64_sub_return_relaxed arch_atomic64_sub_return_relaxed
 
-#define atomic64_fetch_add_relaxed atomic64_fetch_add_relaxed
-#define atomic64_fetch_sub_relaxed atomic64_fetch_sub_relaxed
+#define arch_atomic64_fetch_add_relaxed arch_atomic64_fetch_add_relaxed
+#define arch_atomic64_fetch_sub_relaxed arch_atomic64_fetch_sub_relaxed
 
 #undef ATOMIC64_OPS
 #define ATOMIC64_OPS(op, asm_op)					\
@@ -401,16 +404,16 @@ ATOMIC64_OPS(and, and)
 ATOMIC64_OPS(or, or)
 ATOMIC64_OPS(xor, xor)
 
-#define atomic64_fetch_and_relaxed atomic64_fetch_and_relaxed
-#define atomic64_fetch_or_relaxed  atomic64_fetch_or_relaxed
-#define atomic64_fetch_xor_relaxed atomic64_fetch_xor_relaxed
+#define arch_atomic64_fetch_and_relaxed arch_atomic64_fetch_and_relaxed
+#define arch_atomic64_fetch_or_relaxed  arch_atomic64_fetch_or_relaxed
+#define arch_atomic64_fetch_xor_relaxed arch_atomic64_fetch_xor_relaxed
 
 #undef ATOPIC64_OPS
 #undef ATOMIC64_FETCH_OP_RELAXED
 #undef ATOMIC64_OP_RETURN_RELAXED
 #undef ATOMIC64_OP
 
-static __inline__ void atomic64_inc(atomic64_t *v)
+static __inline__ void arch_atomic64_inc(atomic64_t *v)
 {
 	s64 t;
 
@@ -423,9 +426,9 @@ static __inline__ void atomic64_inc(atomic64_t *v)
 	: "r" (&v->counter)
 	: "cc", "xer");
 }
-#define atomic64_inc atomic64_inc
+#define arch_atomic64_inc arch_atomic64_inc
 
-static __inline__ s64 atomic64_inc_return_relaxed(atomic64_t *v)
+static __inline__ s64 arch_atomic64_inc_return_relaxed(atomic64_t *v)
 {
 	s64 t;
 
@@ -441,7 +444,7 @@ static __inline__ s64 atomic64_inc_return_relaxed(atomic64_t *v)
 	return t;
 }
 
-static __inline__ void atomic64_dec(atomic64_t *v)
+static __inline__ void arch_atomic64_dec(atomic64_t *v)
 {
 	s64 t;
 
@@ -454,9 +457,9 @@ static __inline__ void atomic64_dec(atomic64_t *v)
 	: "r" (&v->counter)
 	: "cc", "xer");
 }
-#define atomic64_dec atomic64_dec
+#define arch_atomic64_dec arch_atomic64_dec
 
-static __inline__ s64 atomic64_dec_return_relaxed(atomic64_t *v)
+static __inline__ s64 arch_atomic64_dec_return_relaxed(atomic64_t *v)
 {
 	s64 t;
 
@@ -472,14 +475,14 @@ static __inline__ s64 atomic64_dec_return_relaxed(atomic64_t *v)
 	return t;
 }
 
-#define atomic64_inc_return_relaxed atomic64_inc_return_relaxed
-#define atomic64_dec_return_relaxed atomic64_dec_return_relaxed
+#define arch_atomic64_inc_return_relaxed arch_atomic64_inc_return_relaxed
+#define arch_atomic64_dec_return_relaxed arch_atomic64_dec_return_relaxed
 
 /*
  * Atomically test *v and decrement if it is greater than 0.
  * The function returns the old value of *v minus 1.
  */
-static __inline__ s64 atomic64_dec_if_positive(atomic64_t *v)
+static __inline__ s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 t;
 
@@ -498,16 +501,19 @@ static __inline__ s64 atomic64_dec_if_positive(atomic64_t *v)
 
 	return t;
 }
-#define atomic64_dec_if_positive atomic64_dec_if_positive
+#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 
-#define atomic64_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
-#define atomic64_cmpxchg_relaxed(v, o, n) \
-	cmpxchg_relaxed(&((v)->counter), (o), (n))
-#define atomic64_cmpxchg_acquire(v, o, n) \
-	cmpxchg_acquire(&((v)->counter), (o), (n))
+#define arch_atomic64_cmpxchg(v, o, n) \
+	(arch_cmpxchg(&((v)->counter), (o), (n)))
+#define arch_atomic64_cmpxchg_relaxed(v, o, n) \
+	arch_cmpxchg_relaxed(&((v)->counter), (o), (n))
+#define arch_atomic64_cmpxchg_acquire(v, o, n) \
+	arch_cmpxchg_acquire(&((v)->counter), (o), (n))
 
-#define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
-#define atomic64_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
+#define arch_atomic64_xchg(v, new) \
+	(arch_xchg(&((v)->counter), new))
+#define arch_atomic64_xchg_relaxed(v, new) \
+	arch_xchg_relaxed(&((v)->counter), (new))
 
 /**
  * atomic64_fetch_add_unless - add unless the number is a given value
@@ -518,7 +524,7 @@ static __inline__ s64 atomic64_dec_if_positive(atomic64_t *v)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+static __inline__ s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	s64 t;
 
@@ -539,7 +545,7 @@ static __inline__ s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 
 	return t;
 }
-#define atomic64_fetch_add_unless atomic64_fetch_add_unless
+#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
 
 /**
  * atomic_inc64_not_zero - increment unless the number is zero
@@ -548,7 +554,7 @@ static __inline__ s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
  * Atomically increments @v by 1, so long as @v is non-zero.
  * Returns non-zero if @v was non-zero, and zero otherwise.
  */
-static __inline__ int atomic64_inc_not_zero(atomic64_t *v)
+static __inline__ int arch_atomic64_inc_not_zero(atomic64_t *v)
 {
 	s64 t1, t2;
 
@@ -569,7 +575,7 @@ static __inline__ int atomic64_inc_not_zero(atomic64_t *v)
 
 	return t1 != 0;
 }
-#define atomic64_inc_not_zero(v) atomic64_inc_not_zero((v))
+#define arch_atomic64_inc_not_zero(v) arch_atomic64_inc_not_zero((v))
 
 #endif /* __powerpc64__ */
 
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index 69f52fd..05f246c 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -185,14 +185,14 @@ __xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
 	BUILD_BUG_ON_MSG(1, "Unsupported size for __xchg_local");
 	return x;
 }
-#define xchg_local(ptr,x)						     \
+#define arch_xchg_local(ptr,x)						     \
   ({									     \
      __typeof__(*(ptr)) _x_ = (x);					     \
      (__typeof__(*(ptr))) __xchg_local((ptr),				     \
      		(unsigned long)_x_, sizeof(*(ptr))); 			     \
   })
 
-#define xchg_relaxed(ptr, x)						\
+#define arch_xchg_relaxed(ptr, x)					\
 ({									\
 	__typeof__(*(ptr)) _x_ = (x);					\
 	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
@@ -467,7 +467,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 	BUILD_BUG_ON_MSG(1, "Unsupported size for __cmpxchg_acquire");
 	return old;
 }
-#define cmpxchg(ptr, o, n)						 \
+#define arch_cmpxchg(ptr, o, n)						 \
   ({									 \
      __typeof__(*(ptr)) _o_ = (o);					 \
      __typeof__(*(ptr)) _n_ = (n);					 \
@@ -476,7 +476,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
   })
 
 
-#define cmpxchg_local(ptr, o, n)					 \
+#define arch_cmpxchg_local(ptr, o, n)					 \
   ({									 \
      __typeof__(*(ptr)) _o_ = (o);					 \
      __typeof__(*(ptr)) _n_ = (n);					 \
@@ -484,7 +484,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 				    (unsigned long)_n_, sizeof(*(ptr))); \
   })
 
-#define cmpxchg_relaxed(ptr, o, n)					\
+#define arch_cmpxchg_relaxed(ptr, o, n)					\
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
@@ -493,7 +493,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 			sizeof(*(ptr)));				\
 })
 
-#define cmpxchg_acquire(ptr, o, n)					\
+#define arch_cmpxchg_acquire(ptr, o, n)					\
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
@@ -502,29 +502,29 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 			sizeof(*(ptr)));				\
 })
 #ifdef CONFIG_PPC64
-#define cmpxchg64(ptr, o, n)						\
+#define arch_cmpxchg64(ptr, o, n)					\
   ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg((ptr), (o), (n));					\
+	arch_cmpxchg((ptr), (o), (n));					\
   })
-#define cmpxchg64_local(ptr, o, n)					\
+#define arch_cmpxchg64_local(ptr, o, n)					\
   ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg_local((ptr), (o), (n));					\
+	arch_cmpxchg_local((ptr), (o), (n));				\
   })
-#define cmpxchg64_relaxed(ptr, o, n)					\
+#define arch_cmpxchg64_relaxed(ptr, o, n)				\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg_relaxed((ptr), (o), (n));				\
+	arch_cmpxchg_relaxed((ptr), (o), (n));				\
 })
-#define cmpxchg64_acquire(ptr, o, n)					\
+#define arch_cmpxchg64_acquire(ptr, o, n)				\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg_acquire((ptr), (o), (n));				\
+	arch_cmpxchg_acquire((ptr), (o), (n));				\
 })
 #else
 #include <asm-generic/cmpxchg-local.h>
-#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
index 07318bc..b676c4f 100644
--- a/arch/powerpc/include/asm/qspinlock.h
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -37,7 +37,7 @@ static __always_inline void queued_spin_lock(struct qspinlock *lock)
 {
 	u32 val = 0;
 
-	if (likely(atomic_try_cmpxchg_lock(&lock->val, &val, _Q_LOCKED_VAL)))
+	if (likely(arch_atomic_try_cmpxchg_lock(&lock->val, &val, _Q_LOCKED_VAL)))
 		return;
 
 	queued_spin_lock_slowpath(lock, val);
