Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D911B3915E3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhEZL0L (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54626 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbhEZL0F (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:05 -0400
Date:   Wed, 26 May 2021 11:24:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p0qYPegNXZmeysja+VN1dFwIvdGWu3FhSSiXfL0zg58=;
        b=BOxmw1/lVB4X2JA6URUkDLUfyAQyhkC7M+uypfeGelMLCnbgeXk1aPrVoXheWzylUle3YR
        fBDPaQy5QMjCs6zfdUlMPa8O+q1+DhayG9TrPQsfapUvc7miGAT/Xw+NKfsNNWvo5dOE5l
        83WBWMxons5U7Ff9gofKixoBtCfZQlnkdKHOsoDnBsKeJLqUJDsu7c2kfbJJHaTKYW2+Vi
        h0vp8Ka0ubiD6YATOXhHFG9PBPqeV9zOUikXGfHxCQUFAqG08OAMFTQmUfZPwy4cS02Qry
        vHSwRmsDZkYGHLXddHoGtBoHw4ypO04xTvZlyEm7G3UwDx3ujvIPL+U2mtlxMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p0qYPegNXZmeysja+VN1dFwIvdGWu3FhSSiXfL0zg58=;
        b=HVxQDx9fnSi9aNV4x8xAX97ZYGDTDXqEBktyksbEhzAQTvvc9oC3vw35vo45De3hA7NZwt
        xKcabUeKTJLDcvDA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: openrisc: move to ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Stafford Horne <shorne@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-26-mark.rutland@arm.com>
References: <20210525140232.53872-26-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827230.29796.9744917103091656063.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3f1e931d158124bbdd5c25300333096bfff805db
Gitweb:        https://git.kernel.org/tip/3f1e931d158124bbdd5c25300333096bfff805db
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:51 +02:00

locking/atomic: openrisc: move to ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates openrisc to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Stafford Horne <shorne@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-26-mark.rutland@arm.com
---
 arch/openrisc/Kconfig               |  1 +-
 arch/openrisc/include/asm/atomic.h  | 42 +++++++++++++++-------------
 arch/openrisc/include/asm/cmpxchg.h |  4 +--
 3 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 591acc5..8c50bc9 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -7,6 +7,7 @@
 config OPENRISC
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_HAS_DMA_SET_UNCACHED
 	select ARCH_HAS_DMA_CLEAR_UNCACHED
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
diff --git a/arch/openrisc/include/asm/atomic.h b/arch/openrisc/include/asm/atomic.h
index cb86970..326167e 100644
--- a/arch/openrisc/include/asm/atomic.h
+++ b/arch/openrisc/include/asm/atomic.h
@@ -13,7 +13,7 @@
 
 /* Atomically perform op with v->counter and i */
 #define ATOMIC_OP(op)							\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	int tmp;							\
 									\
@@ -30,7 +30,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 
 /* Atomically perform op with v->counter and i, return the result */
 #define ATOMIC_OP_RETURN(op)						\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	int tmp;							\
 									\
@@ -49,7 +49,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 
 /* Atomically perform op with v->counter and i, return orig v->counter */
 #define ATOMIC_FETCH_OP(op)						\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	int tmp, old;							\
 									\
@@ -75,6 +75,8 @@ ATOMIC_FETCH_OP(and)
 ATOMIC_FETCH_OP(or)
 ATOMIC_FETCH_OP(xor)
 
+ATOMIC_OP(add)
+ATOMIC_OP(sub)
 ATOMIC_OP(and)
 ATOMIC_OP(or)
 ATOMIC_OP(xor)
@@ -83,16 +85,18 @@ ATOMIC_OP(xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define atomic_add_return	atomic_add_return
-#define atomic_sub_return	atomic_sub_return
-#define atomic_fetch_add	atomic_fetch_add
-#define atomic_fetch_sub	atomic_fetch_sub
-#define atomic_fetch_and	atomic_fetch_and
-#define atomic_fetch_or		atomic_fetch_or
-#define atomic_fetch_xor	atomic_fetch_xor
-#define atomic_and	atomic_and
-#define atomic_or	atomic_or
-#define atomic_xor	atomic_xor
+#define arch_atomic_add_return	arch_atomic_add_return
+#define arch_atomic_sub_return	arch_atomic_sub_return
+#define arch_atomic_fetch_add	arch_atomic_fetch_add
+#define arch_atomic_fetch_sub	arch_atomic_fetch_sub
+#define arch_atomic_fetch_and	arch_atomic_fetch_and
+#define arch_atomic_fetch_or	arch_atomic_fetch_or
+#define arch_atomic_fetch_xor	arch_atomic_fetch_xor
+#define arch_atomic_add		arch_atomic_add
+#define arch_atomic_sub		arch_atomic_sub
+#define arch_atomic_and		arch_atomic_and
+#define arch_atomic_or		arch_atomic_or
+#define arch_atomic_xor		arch_atomic_xor
 
 /*
  * Atomically add a to v->counter as long as v is not already u.
@@ -100,7 +104,7 @@ ATOMIC_OP(xor)
  *
  * This is often used through atomic_inc_not_zero()
  */
-static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
+static inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int old, tmp;
 
@@ -119,14 +123,14 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 
 	return old;
 }
-#define atomic_fetch_add_unless	atomic_fetch_add_unless
+#define arch_atomic_fetch_add_unless	arch_atomic_fetch_add_unless
 
-#define atomic_read(v)			READ_ONCE((v)->counter)
-#define atomic_set(v,i)			WRITE_ONCE((v)->counter, (i))
+#define arch_atomic_read(v)		READ_ONCE((v)->counter)
+#define arch_atomic_set(v,i)		WRITE_ONCE((v)->counter, (i))
 
 #include <asm/cmpxchg.h>
 
-#define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
-#define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
+#define arch_atomic_xchg(ptr, v)		(arch_xchg(&(ptr)->counter, (v)))
+#define arch_atomic_cmpxchg(v, old, new)	(arch_cmpxchg(&((v)->counter), (old), (new)))
 
 #endif /* __ASM_OPENRISC_ATOMIC_H */
diff --git a/arch/openrisc/include/asm/cmpxchg.h b/arch/openrisc/include/asm/cmpxchg.h
index f9cd43a..79fd161 100644
--- a/arch/openrisc/include/asm/cmpxchg.h
+++ b/arch/openrisc/include/asm/cmpxchg.h
@@ -132,7 +132,7 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	}
 }
 
-#define cmpxchg(ptr, o, n)						\
+#define arch_cmpxchg(ptr, o, n)						\
 	({								\
 		(__typeof__(*(ptr))) __cmpxchg((ptr),			\
 					       (unsigned long)(o),	\
@@ -161,7 +161,7 @@ static inline unsigned long __xchg(volatile void *ptr, unsigned long with,
 	}
 }
 
-#define xchg(ptr, with) 						\
+#define arch_xchg(ptr, with) 						\
 	({								\
 		(__typeof__(*(ptr))) __xchg((ptr),			\
 					    (unsigned long)(with),	\
