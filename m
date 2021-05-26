Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586053915EA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhEZL0R (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbhEZL0I (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B1EC061760;
        Wed, 26 May 2021 04:24:36 -0700 (PDT)
Date:   Wed, 26 May 2021 11:24:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028275;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=21wgryU50oDqWERrmsyvUqcXBLnja7XxxDl29UzDfHA=;
        b=u9s7Y+CClqExwMvaCgan6OUNWtHKZSzT7/Kv7sX1ijYaF+X0KiOLVHCRpW+9XHmmwTgShT
        BPYUJ5McfkBpdbfxT+nmkYMaTq5vfPJkkBcFKNdErNyNq9l9DsdY9bk0kcB4Bwe50dOdDu
        Y54tB3et4Eb3VqqbvQ89I44SMAKneySGPXfR9UP6BBgsu8ODx0FZEMkKLBRqTa4kq66Mbr
        Z/PJeeo8mi8xfzihom88yGZkdEP9M6NhUQidmCi5n/W7iWZB6hau5SM5CbKuY86VGLhlTl
        OpdS97p7LXCsyh3pLe96GVgbvqFvB42mnOXutAMSY1AcZssrgqJUk+2pWu6ZGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028275;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=21wgryU50oDqWERrmsyvUqcXBLnja7XxxDl29UzDfHA=;
        b=K2F+zVig/X1v+hbH8b6OK54q+HGBLT/kyZu/nhVna8DgUf9ll1OHehaMamxdkwNBZkLVn0
        dNZP0rl/v+/z93Bg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: m68k: move to ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-21-mark.rutland@arm.com>
References: <20210525140232.53872-21-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827475.29796.7968310303452149218.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e86e793c28e76ab5a0288c468713ab513b79fdd0
Gitweb:        https://git.kernel.org/tip/e86e793c28e76ab5a0288c468713ab513b79fdd0
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:19 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:51 +02:00

locking/atomic: m68k: move to ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates m68k to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

While atomic_dec_and_test_lt() is not part of the common atomic API, it
is also given an `arch_` prefix for consistency.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Greg Ungerer <gerg@linux-m68k.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-21-mark.rutland@arm.com
---
 arch/m68k/Kconfig                   |  1 +-
 arch/m68k/include/asm/atomic.h      | 60 ++++++++++++++--------------
 arch/m68k/include/asm/cmpxchg.h     | 10 ++---
 arch/m68k/include/asm/mmu_context.h |  2 +-
 4 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 372e4e6..d1d91ac 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -3,6 +3,7 @@ config M68K
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
diff --git a/arch/m68k/include/asm/atomic.h b/arch/m68k/include/asm/atomic.h
index 756c5cc..8637bf8 100644
--- a/arch/m68k/include/asm/atomic.h
+++ b/arch/m68k/include/asm/atomic.h
@@ -16,8 +16,8 @@
  * We do not have SMP m68k systems, so we don't have to deal with that.
  */
 
-#define atomic_read(v)		READ_ONCE((v)->counter)
-#define atomic_set(v, i)	WRITE_ONCE(((v)->counter), (i))
+#define arch_atomic_read(v)	READ_ONCE((v)->counter)
+#define arch_atomic_set(v, i)	WRITE_ONCE(((v)->counter), (i))
 
 /*
  * The ColdFire parts cannot do some immediate to memory operations,
@@ -30,7 +30,7 @@
 #endif
 
 #define ATOMIC_OP(op, c_op, asm_op)					\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	__asm__ __volatile__(#asm_op "l %1,%0" : "+m" (*v) : ASM_DI (i));\
 }									\
@@ -38,7 +38,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 #ifdef CONFIG_RMW_INSNS
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	int t, tmp;							\
 									\
@@ -48,12 +48,12 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 			"	casl %2,%1,%0\n"			\
 			"	jne 1b"					\
 			: "+m" (*v), "=&d" (t), "=&d" (tmp)		\
-			: "g" (i), "2" (atomic_read(v)));		\
+			: "g" (i), "2" (arch_atomic_read(v)));		\
 	return t;							\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	int t, tmp;							\
 									\
@@ -63,14 +63,14 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 			"	casl %2,%1,%0\n"			\
 			"	jne 1b"					\
 			: "+m" (*v), "=&d" (t), "=&d" (tmp)		\
-			: "g" (i), "2" (atomic_read(v)));		\
+			: "g" (i), "2" (arch_atomic_read(v)));		\
 	return tmp;							\
 }
 
 #else
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int atomic_##op##_return(int i, atomic_t * v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t * v)	\
 {									\
 	unsigned long flags;						\
 	int t;								\
@@ -83,7 +83,7 @@ static inline int atomic_##op##_return(int i, atomic_t * v)		\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int atomic_fetch_##op(int i, atomic_t * v)		\
+static inline int arch_atomic_fetch_##op(int i, atomic_t * v)		\
 {									\
 	unsigned long flags;						\
 	int t;								\
@@ -120,27 +120,27 @@ ATOMIC_OPS(xor, ^=, eor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-static inline void atomic_inc(atomic_t *v)
+static inline void arch_atomic_inc(atomic_t *v)
 {
 	__asm__ __volatile__("addql #1,%0" : "+m" (*v));
 }
-#define atomic_inc atomic_inc
+#define arch_atomic_inc arch_atomic_inc
 
-static inline void atomic_dec(atomic_t *v)
+static inline void arch_atomic_dec(atomic_t *v)
 {
 	__asm__ __volatile__("subql #1,%0" : "+m" (*v));
 }
-#define atomic_dec atomic_dec
+#define arch_atomic_dec arch_atomic_dec
 
-static inline int atomic_dec_and_test(atomic_t *v)
+static inline int arch_atomic_dec_and_test(atomic_t *v)
 {
 	char c;
 	__asm__ __volatile__("subql #1,%1; seq %0" : "=d" (c), "+m" (*v));
 	return c != 0;
 }
-#define atomic_dec_and_test atomic_dec_and_test
+#define arch_atomic_dec_and_test arch_atomic_dec_and_test
 
-static inline int atomic_dec_and_test_lt(atomic_t *v)
+static inline int arch_atomic_dec_and_test_lt(atomic_t *v)
 {
 	char c;
 	__asm__ __volatile__(
@@ -150,49 +150,49 @@ static inline int atomic_dec_and_test_lt(atomic_t *v)
 	return c != 0;
 }
 
-static inline int atomic_inc_and_test(atomic_t *v)
+static inline int arch_atomic_inc_and_test(atomic_t *v)
 {
 	char c;
 	__asm__ __volatile__("addql #1,%1; seq %0" : "=d" (c), "+m" (*v));
 	return c != 0;
 }
-#define atomic_inc_and_test atomic_inc_and_test
+#define arch_atomic_inc_and_test arch_atomic_inc_and_test
 
 #ifdef CONFIG_RMW_INSNS
 
-#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic_cmpxchg(v, o, n) ((int)arch_cmpxchg(&((v)->counter), (o), (n)))
+#define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), new))
 
 #else /* !CONFIG_RMW_INSNS */
 
-static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
+static inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	unsigned long flags;
 	int prev;
 
 	local_irq_save(flags);
-	prev = atomic_read(v);
+	prev = arch_atomic_read(v);
 	if (prev == old)
-		atomic_set(v, new);
+		arch_atomic_set(v, new);
 	local_irq_restore(flags);
 	return prev;
 }
 
-static inline int atomic_xchg(atomic_t *v, int new)
+static inline int arch_atomic_xchg(atomic_t *v, int new)
 {
 	unsigned long flags;
 	int prev;
 
 	local_irq_save(flags);
-	prev = atomic_read(v);
-	atomic_set(v, new);
+	prev = arch_atomic_read(v);
+	arch_atomic_set(v, new);
 	local_irq_restore(flags);
 	return prev;
 }
 
 #endif /* !CONFIG_RMW_INSNS */
 
-static inline int atomic_sub_and_test(int i, atomic_t *v)
+static inline int arch_atomic_sub_and_test(int i, atomic_t *v)
 {
 	char c;
 	__asm__ __volatile__("subl %2,%1; seq %0"
@@ -200,9 +200,9 @@ static inline int atomic_sub_and_test(int i, atomic_t *v)
 			     : ASM_DI (i));
 	return c != 0;
 }
-#define atomic_sub_and_test atomic_sub_and_test
+#define arch_atomic_sub_and_test arch_atomic_sub_and_test
 
-static inline int atomic_add_negative(int i, atomic_t *v)
+static inline int arch_atomic_add_negative(int i, atomic_t *v)
 {
 	char c;
 	__asm__ __volatile__("addl %2,%1; smi %0"
@@ -210,6 +210,6 @@ static inline int atomic_add_negative(int i, atomic_t *v)
 			     : ASM_DI (i));
 	return c != 0;
 }
-#define atomic_add_negative atomic_add_negative
+#define arch_atomic_add_negative arch_atomic_add_negative
 
 #endif /* __ARCH_M68K_ATOMIC __ */
diff --git a/arch/m68k/include/asm/cmpxchg.h b/arch/m68k/include/asm/cmpxchg.h
index 7629c9c..e8ca4b0 100644
--- a/arch/m68k/include/asm/cmpxchg.h
+++ b/arch/m68k/include/asm/cmpxchg.h
@@ -76,11 +76,11 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 }
 #endif
 
-#define xchg(ptr,x) ({(__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr)));})
+#define arch_xchg(ptr,x) ({(__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr)));})
 
 #include <asm-generic/cmpxchg-local.h>
 
-#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 
 extern unsigned long __invalid_cmpxchg_size(volatile void *,
 					    unsigned long, unsigned long, int);
@@ -118,14 +118,14 @@ static inline unsigned long __cmpxchg(volatile void *p, unsigned long old,
 	return old;
 }
 
-#define cmpxchg(ptr, o, n)						    \
+#define arch_cmpxchg(ptr, o, n)						    \
 	({(__typeof__(*(ptr)))__cmpxchg((ptr), (unsigned long)(o),	    \
 			(unsigned long)(n), sizeof(*(ptr)));})
-#define cmpxchg_local(ptr, o, n)					    \
+#define arch_cmpxchg_local(ptr, o, n)					    \
 	({(__typeof__(*(ptr)))__cmpxchg((ptr), (unsigned long)(o),	    \
 			(unsigned long)(n), sizeof(*(ptr)));})
 
-#define cmpxchg64(ptr, o, n)	cmpxchg64_local((ptr), (o), (n))
+#define arch_cmpxchg64(ptr, o, n)	arch_cmpxchg64_local((ptr), (o), (n))
 
 #else
 
diff --git a/arch/m68k/include/asm/mmu_context.h b/arch/m68k/include/asm/mmu_context.h
index a5d3588..8ed6ac1 100644
--- a/arch/m68k/include/asm/mmu_context.h
+++ b/arch/m68k/include/asm/mmu_context.h
@@ -31,7 +31,7 @@ static inline void get_mmu_context(struct mm_struct *mm)
 
 	if (mm->context != NO_CONTEXT)
 		return;
-	while (atomic_dec_and_test_lt(&nr_free_contexts)) {
+	while (arch_atomic_dec_and_test_lt(&nr_free_contexts)) {
 		atomic_inc(&nr_free_contexts);
 		steal_context();
 	}
