Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E383915EB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhEZL0S (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54694 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbhEZL0I (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:08 -0400
Date:   Wed, 26 May 2021 11:24:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028276;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=28QRtym177L2fnhGHGTbhy0O4Sr104tzJ9hIFYXcWvY=;
        b=jVEQzgS1r5dpNZf4vkqB/hI8X1E2v4uq0Ej/HD79lOkH8aLXDuLSjxH8rbk+EO3wQZ0qqf
        Qzg8aLEY64+sArd8C75sypGkscRDhwThpzPLO1s5OpOi82fIvHRtBwlCkdsNvU5TtjaXgM
        UEyb+aC2ZVlk5lVqy7J5mTYV6CDWz3qnZGWz0XtHjjuKmkF6Wk6WWcpP31GpPHOGxn0k8r
        /ZTIfvZ6HhrH4YxLQgy1xnMgbg8VMJNXdIk92jLsm4NMFKevG2Bw9rG3yJfgQAkPUG659M
        T86RTVYoaeUMG2aef9DxzC8EhE0y+GprNY0za8MQ0tGf70aOFlE96HcCdunbMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028276;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=28QRtym177L2fnhGHGTbhy0O4Sr104tzJ9hIFYXcWvY=;
        b=0xxWRts60XNh2BMLCjWkvnMVHvxnm+45TtY3LReG9rWVTycrftmV4FBJhFnMpRz3wlUDUU
        /sVhLrdLSYOr/zAg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: hexagon: move to ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Brian Cain <bcain@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-19-mark.rutland@arm.com>
References: <20210525140232.53872-19-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827563.29796.11232325717918546855.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     94b63eb6e131a7fe94f1c1eb8e10162931506176
Gitweb:        https://git.kernel.org/tip/94b63eb6e131a7fe94f1c1eb8e10162931506176
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:17 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:51 +02:00

locking/atomic: hexagon: move to ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates hexagon to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-19-mark.rutland@arm.com
---
 arch/hexagon/Kconfig               |  1 +
 arch/hexagon/include/asm/atomic.h  | 28 ++++++++++++++--------------
 arch/hexagon/include/asm/cmpxchg.h |  4 ++--
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 44a4099..1368954 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -5,6 +5,7 @@ comment "Linux Kernel Configuration for Hexagon"
 config HEXAGON
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_PREEMPT
 	# Other pending projects/to-do items.
diff --git a/arch/hexagon/include/asm/atomic.h b/arch/hexagon/include/asm/atomic.h
index 4ab895d..6e94f8d 100644
--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -14,7 +14,7 @@
 
 /*  Normal writes in our arch don't clear lock reservations  */
 
-static inline void atomic_set(atomic_t *v, int new)
+static inline void arch_atomic_set(atomic_t *v, int new)
 {
 	asm volatile(
 		"1:	r6 = memw_locked(%0);\n"
@@ -26,26 +26,26 @@ static inline void atomic_set(atomic_t *v, int new)
 	);
 }
 
-#define atomic_set_release(v, i)	atomic_set((v), (i))
+#define arch_atomic_set_release(v, i)	arch_atomic_set((v), (i))
 
 /**
- * atomic_read - reads a word, atomically
+ * arch_atomic_read - reads a word, atomically
  * @v: pointer to atomic value
  *
  * Assumes all word reads on our architecture are atomic.
  */
-#define atomic_read(v)		READ_ONCE((v)->counter)
+#define arch_atomic_read(v)		READ_ONCE((v)->counter)
 
 /**
- * atomic_xchg - atomic
+ * arch_atomic_xchg - atomic
  * @v: pointer to memory to change
  * @new: new value (technically passed in a register -- see xchg)
  */
-#define atomic_xchg(v, new)	(xchg(&((v)->counter), (new)))
+#define arch_atomic_xchg(v, new)	(arch_xchg(&((v)->counter), (new)))
 
 
 /**
- * atomic_cmpxchg - atomic compare-and-exchange values
+ * arch_atomic_cmpxchg - atomic compare-and-exchange values
  * @v: pointer to value to change
  * @old:  desired old value to match
  * @new:  new value to put in
@@ -61,7 +61,7 @@ static inline void atomic_set(atomic_t *v, int new)
  *
  * "old" is "expected" old val, __oldval is actual old value
  */
-static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
+static inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	int __oldval;
 
@@ -81,7 +81,7 @@ static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 }
 
 #define ATOMIC_OP(op)							\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	int output;							\
 									\
@@ -97,7 +97,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op)						\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	int output;							\
 									\
@@ -114,7 +114,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op)						\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	int output, val;						\
 									\
@@ -148,7 +148,7 @@ ATOMIC_OPS(xor)
 #undef ATOMIC_OP
 
 /**
- * atomic_fetch_add_unless - add unless the number is a given value
+ * arch_atomic_fetch_add_unless - add unless the number is a given value
  * @v: pointer to value
  * @a: amount to add
  * @u: unless value is equal to u
@@ -157,7 +157,7 @@ ATOMIC_OPS(xor)
  *
  */
 
-static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
+static inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int __oldval;
 	register int tmp;
@@ -180,6 +180,6 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 	);
 	return __oldval;
 }
-#define atomic_fetch_add_unless atomic_fetch_add_unless
+#define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
 
 #endif
diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
index 92b8a02..cdb705e 100644
--- a/arch/hexagon/include/asm/cmpxchg.h
+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -42,7 +42,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr,
  * Atomically swap the contents of a register with memory.  Should be atomic
  * between multiple CPU's and within interrupts on the same CPU.
  */
-#define xchg(ptr, v) ((__typeof__(*(ptr)))__xchg((unsigned long)(v), (ptr), \
+#define arch_xchg(ptr, v) ((__typeof__(*(ptr)))__xchg((unsigned long)(v), (ptr), \
 	sizeof(*(ptr))))
 
 /*
@@ -51,7 +51,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr,
  *  variable casting.
  */
 
-#define cmpxchg(ptr, old, new)					\
+#define arch_cmpxchg(ptr, old, new)				\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
 	__typeof__(*(ptr)) __old = (old);			\
