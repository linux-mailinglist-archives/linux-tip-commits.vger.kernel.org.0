Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550A33915D7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbhEZL0D (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbhEZL0D (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7706C06175F;
        Wed, 26 May 2021 04:24:31 -0700 (PDT)
Date:   Wed, 26 May 2021 11:24:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kkxMUtoEIHBoPcGRVy4S3mo7lkbiy6dN+f71Zckj9Eo=;
        b=mmBEh0ssGAyYTYQZ/Fzx6D0F95wgyoTVE9HEOcKCjpMCFN8phDnHcYjjZGTK1jtFqEU+tp
        a7u+sqddyqf3xae6Jd867XfPeijC+Rik+adBpF/+q6wHcodXp9xc/Y+1LHMpkfu+s2rp5r
        F3UHHoQ0NbTF+OTv/oxb1CQK3ySDFK4rQwKwfAEkz/XyZnTj3N1/DL/Hufp2nethKWkM82
        IjYjaQNzS9fjvTegAELGaeTFUDx5hpTusEoFeaAhmGt4R4UbY5dUSi6DV8JFWQuRAORv2p
        GMweQuAE8s5Mnpy5+75pbiqou5KJmARxRkBWnfFZj8TjryHhsNcsBz0J2aNXYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kkxMUtoEIHBoPcGRVy4S3mo7lkbiy6dN+f71Zckj9Eo=;
        b=iDBAAOo6x9M2jNSAWtYdnevSjddnO/BxO0GBWH3qjpzhb56hgVPJCnCQYypY+Gs0Dct96w
        r/v+3NmIHg196iAw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: xtensa: move to ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-32-mark.rutland@arm.com>
References: <20210525140232.53872-32-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202826968.29796.11862884489739002495.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b9b12978a8e9a4bb77746e74eae37e587f7f8994
Gitweb:        https://git.kernel.org/tip/b9b12978a8e9a4bb77746e74eae37e587f7f8994
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:30 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:52 +02:00

locking/atomic: xtensa: move to ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates xtensa to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-32-mark.rutland@arm.com
---
 arch/xtensa/Kconfig               |  1 +
 arch/xtensa/include/asm/atomic.h  | 26 +++++++++++++-------------
 arch/xtensa/include/asm/cmpxchg.h | 10 +++++-----
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 2332b21..39bb9bd 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -2,6 +2,7 @@
 config XTENSA
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_HAS_BINFMT_FLAT if !MMU
 	select ARCH_HAS_DMA_PREP_COHERENT if MMU
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if MMU
diff --git a/arch/xtensa/include/asm/atomic.h b/arch/xtensa/include/asm/atomic.h
index 744c2f4..4361fe4 100644
--- a/arch/xtensa/include/asm/atomic.h
+++ b/arch/xtensa/include/asm/atomic.h
@@ -43,7 +43,7 @@
  *
  * Atomically reads the value of @v.
  */
-#define atomic_read(v)		READ_ONCE((v)->counter)
+#define arch_atomic_read(v)		READ_ONCE((v)->counter)
 
 /**
  * atomic_set - set atomic variable
@@ -52,11 +52,11 @@
  *
  * Atomically sets the value of @v to @i.
  */
-#define atomic_set(v,i)		WRITE_ONCE((v)->counter, (i))
+#define arch_atomic_set(v,i)		WRITE_ONCE((v)->counter, (i))
 
 #if XCHAL_HAVE_EXCLUSIVE
 #define ATOMIC_OP(op)							\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -74,7 +74,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op)						\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -95,7 +95,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op)						\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -116,7 +116,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 
 #elif XCHAL_HAVE_S32C1I
 #define ATOMIC_OP(op)							\
-static inline void atomic_##op(int i, atomic_t * v)			\
+static inline void arch_atomic_##op(int i, atomic_t * v)		\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -135,7 +135,7 @@ static inline void atomic_##op(int i, atomic_t * v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op)						\
-static inline int atomic_##op##_return(int i, atomic_t * v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t * v)	\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -157,7 +157,7 @@ static inline int atomic_##op##_return(int i, atomic_t * v)		\
 }
 
 #define ATOMIC_FETCH_OP(op)						\
-static inline int atomic_fetch_##op(int i, atomic_t * v)		\
+static inline int arch_atomic_fetch_##op(int i, atomic_t * v)		\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -180,7 +180,7 @@ static inline int atomic_fetch_##op(int i, atomic_t * v)		\
 #else /* XCHAL_HAVE_S32C1I */
 
 #define ATOMIC_OP(op)							\
-static inline void atomic_##op(int i, atomic_t * v)			\
+static inline void arch_atomic_##op(int i, atomic_t * v)		\
 {									\
 	unsigned int vval;						\
 									\
@@ -198,7 +198,7 @@ static inline void atomic_##op(int i, atomic_t * v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op)						\
-static inline int atomic_##op##_return(int i, atomic_t * v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t * v)	\
 {									\
 	unsigned int vval;						\
 									\
@@ -218,7 +218,7 @@ static inline int atomic_##op##_return(int i, atomic_t * v)		\
 }
 
 #define ATOMIC_FETCH_OP(op)						\
-static inline int atomic_fetch_##op(int i, atomic_t * v)		\
+static inline int arch_atomic_fetch_##op(int i, atomic_t * v)		\
 {									\
 	unsigned int tmp, vval;						\
 									\
@@ -257,7 +257,7 @@ ATOMIC_OPS(xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic_cmpxchg(v, o, n) ((int)arch_cmpxchg(&((v)->counter), (o), (n)))
+#define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), new))
 
 #endif /* _XTENSA_ATOMIC_H */
diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index 9c4d6e5..3699e28 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -80,7 +80,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 	}
 }
 
-#define cmpxchg(ptr,o,n)						      \
+#define arch_cmpxchg(ptr,o,n)						      \
 	({ __typeof__(*(ptr)) _o_ = (o);				      \
 	   __typeof__(*(ptr)) _n_ = (n);				      \
 	   (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,	      \
@@ -107,11 +107,11 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
  * cmpxchg_local and cmpxchg64_local are atomic wrt current CPU. Always make
  * them available.
  */
-#define cmpxchg_local(ptr, o, n)				  	       \
+#define arch_cmpxchg_local(ptr, o, n)				  	       \
 	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),\
 			(unsigned long)(n), sizeof(*(ptr))))
-#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
-#define cmpxchg64(ptr, o, n)    cmpxchg64_local((ptr), (o), (n))
+#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+#define arch_cmpxchg64(ptr, o, n)    arch_cmpxchg64_local((ptr), (o), (n))
 
 /*
  * xchg_u32
@@ -169,7 +169,7 @@ static inline unsigned long xchg_u32(volatile int * m, unsigned long val)
 #endif
 }
 
-#define xchg(ptr,x) \
+#define arch_xchg(ptr,x) \
 	((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
 
 static inline u32 xchg_small(volatile void *ptr, u32 x, int size)
