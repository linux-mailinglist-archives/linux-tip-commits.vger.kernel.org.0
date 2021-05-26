Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411943915DC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhEZL0G (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54570 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbhEZL0D (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:03 -0400
Date:   Wed, 26 May 2021 11:24:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028271;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhazkkaDr3ScnHjT/m6mrciX5i/R4bcqL2td5HXlssA=;
        b=qdOo3zD1EVm2tq5DG9Lij9j2EaPEOpoxvj/3T4znjZewxeJHf8y8jblzhSrEt1sxo4+ku6
        a7X5tO87rzWYXiKeBu33Z8+cf/1IXEEcm0/24NQ2UY1pJ9i/fpHZ9yKek3BUXhb+9YdKvA
        CCz/gzo971saUsa6nTHOY5IKGj/1Sp1vfLnOd623pLwpS+3+bcRMeh2+xAhnI6Bnvs8Zd7
        NPxHyJBRuiGTr7b01Mn0w1QNsNOmoKGSxu2owjD2fH5+ZPSKNccsCFy+bFYbC/PE9kNRLL
        od3W/xUCzGQjUmK8QnNzVdr57fJS/iRORlCRYKkXC0Vq4TC28ibtcf1/ALM+ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028271;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhazkkaDr3ScnHjT/m6mrciX5i/R4bcqL2td5HXlssA=;
        b=pN18hpFXNXrbsddvXbfsZnVblw2j+8OW1vOrk/IfMiEtK/1IOJPwM6Jf/J4erRSIFKDVkD
        Q7KjGCLqXD5ElSCw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: sh: move to ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rich Felker <dalias@libc.org>, Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-30-mark.rutland@arm.com>
References: <20210525140232.53872-30-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827051.29796.8259294851315527425.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8c6417551309fe3654b5f761214303aef361d3e8
Gitweb:        https://git.kernel.org/tip/8c6417551309fe3654b5f761214303aef361d3e8
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:28 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:52 +02:00

locking/atomic: sh: move to ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates sh to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Will Deacon <will@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-30-mark.rutland@arm.com
---
 arch/sh/Kconfig                   | 1 +
 arch/sh/include/asm/atomic-grb.h  | 6 +++---
 arch/sh/include/asm/atomic-irq.h  | 6 +++---
 arch/sh/include/asm/atomic-llsc.h | 6 +++---
 arch/sh/include/asm/atomic.h      | 8 ++++----
 arch/sh/include/asm/cmpxchg.h     | 4 ++--
 6 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 6812953..d2925cb 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -2,6 +2,7 @@
 config SUPERH
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && MMU
 	select ARCH_ENABLE_MEMORY_HOTREMOVE if SPARSEMEM && MMU
 	select ARCH_HAVE_CUSTOM_GPIO_H
diff --git a/arch/sh/include/asm/atomic-grb.h b/arch/sh/include/asm/atomic-grb.h
index aace62d..059791f 100644
--- a/arch/sh/include/asm/atomic-grb.h
+++ b/arch/sh/include/asm/atomic-grb.h
@@ -3,7 +3,7 @@
 #define __ASM_SH_ATOMIC_GRB_H
 
 #define ATOMIC_OP(op)							\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	int tmp;							\
 									\
@@ -23,7 +23,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op)						\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	int tmp;							\
 									\
@@ -45,7 +45,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op)						\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	int res, tmp;							\
 									\
diff --git a/arch/sh/include/asm/atomic-irq.h b/arch/sh/include/asm/atomic-irq.h
index ee523bd..7665de9 100644
--- a/arch/sh/include/asm/atomic-irq.h
+++ b/arch/sh/include/asm/atomic-irq.h
@@ -11,7 +11,7 @@
  */
 
 #define ATOMIC_OP(op, c_op)						\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	unsigned long flags;						\
 									\
@@ -21,7 +21,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }
 
 #define ATOMIC_OP_RETURN(op, c_op)					\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	unsigned long temp, flags;					\
 									\
@@ -35,7 +35,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op)					\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long temp, flags;					\
 									\
diff --git a/arch/sh/include/asm/atomic-llsc.h b/arch/sh/include/asm/atomic-llsc.h
index 1d06e4d..b63dcfb 100644
--- a/arch/sh/include/asm/atomic-llsc.h
+++ b/arch/sh/include/asm/atomic-llsc.h
@@ -17,7 +17,7 @@
  */
 
 #define ATOMIC_OP(op)							\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	unsigned long tmp;						\
 									\
@@ -32,7 +32,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }
 
 #define ATOMIC_OP_RETURN(op)						\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	unsigned long temp;						\
 									\
@@ -50,7 +50,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op)						\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long res, temp;					\
 									\
diff --git a/arch/sh/include/asm/atomic.h b/arch/sh/include/asm/atomic.h
index 7c2a8a7..528bfed 100644
--- a/arch/sh/include/asm/atomic.h
+++ b/arch/sh/include/asm/atomic.h
@@ -19,8 +19,8 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
-#define atomic_read(v)		READ_ONCE((v)->counter)
-#define atomic_set(v,i)		WRITE_ONCE((v)->counter, (i))
+#define arch_atomic_read(v)		READ_ONCE((v)->counter)
+#define arch_atomic_set(v,i)		WRITE_ONCE((v)->counter, (i))
 
 #if defined(CONFIG_GUSA_RB)
 #include <asm/atomic-grb.h>
@@ -30,8 +30,8 @@
 #include <asm/atomic-irq.h>
 #endif
 
-#define atomic_xchg(v, new)		(xchg(&((v)->counter), new))
-#define atomic_cmpxchg(v, o, n)		(cmpxchg(&((v)->counter), (o), (n)))
+#define arch_atomic_xchg(v, new)	(arch_xchg(&((v)->counter), new))
+#define arch_atomic_cmpxchg(v, o, n)	(arch_cmpxchg(&((v)->counter), (o), (n)))
 
 #endif /* CONFIG_CPU_J2 */
 
diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index e9501d8..0ed9b3f 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -45,7 +45,7 @@ extern void __xchg_called_with_bad_pointer(void);
 	__xchg__res;					\
 })
 
-#define xchg(ptr,x)	\
+#define arch_xchg(ptr,x)	\
 	((__typeof__(*(ptr)))__xchg((ptr),(unsigned long)(x), sizeof(*(ptr))))
 
 /* This function doesn't exist, so you'll get a linker error
@@ -63,7 +63,7 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
 	return old;
 }
 
-#define cmpxchg(ptr,o,n)						 \
+#define arch_cmpxchg(ptr,o,n)						 \
   ({									 \
      __typeof__(*(ptr)) _o_ = (o);					 \
      __typeof__(*(ptr)) _n_ = (n);					 \
