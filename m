Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBF23915F1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhEZL02 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54580 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbhEZL0M (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:12 -0400
Date:   Wed, 26 May 2021 11:24:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028280;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V4kml1K5PomnuMYWLx+wdaJlr7hLxtN0QbffyoAlQY4=;
        b=H7Tn24PPvhNp6slrDfuOaK3nbofOZIzUHGb1cMJWtfhNjKDTBaeQ+9HrtcAoh3FFLGPMsh
        glZq+fEksU895GWxrw/nPe67tanN89XzznyYDFDLGHznKg2mJH/YduAH0fbNUhX5arRv8c
        YByadAcEET6n6XYbFlTz6VKPqga2jhbnY+MwpCXzgj9Z03WQMFtdRYDWttef093R89mqT1
        QkIgG7HuveJ6ls8N7730RaRwof5kF1o+YwtmzGEXyfwwq7RXkJCQli1WXK1ceLAa3Hj/C+
        vIbB4rpvXENtuMQnVYvjO0cMxC7R1mn7BmXS2tzDTWB4/EPxspIAfkjt/l5Uzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028280;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V4kml1K5PomnuMYWLx+wdaJlr7hLxtN0QbffyoAlQY4=;
        b=yuBhNt77w6AjUjejo9TTHbwxxI9UchEs05MdJAByPMId0Xitq/GOktbv65Q5Ssb8JWQdgg
        yfIAU0Ao2BQM78AA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: atomic: support ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-10-mark.rutland@arm.com>
References: <20210525140232.53872-10-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827953.29796.6315532244871874735.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f8b6455a9d381fc513efbec0be0c312b96e6eb6b
Gitweb:        https://git.kernel.org/tip/f8b6455a9d381fc513efbec0be0c312b96e6eb6b
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:08 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:50 +02:00

locking/atomic: atomic: support ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as this will
enable functionality, and once all architectures are converted it will
be possible to make significant cleanups to the atomic headers.

A number of architectures use asm-generic/atomic.h, and it's impractical
to convert the header and all these architectures in one go. To make it
possible to convert them one-by-one, let's make the asm-generic
implementation function as either atomic_*() or arch_atomic_*()
depending on whether ARCH_ATOMIC is selected. To do this, the C
implementations are prefixed as generic_atomic_*(), and preprocessor
definitions map atomic_*()/arch_atomic_*() onto these as
appropriate.

Once all users are moved over to ARCH_ATOMIC the ifdeffery in the header
can be simplified and/or removed entirely.

For existing users (none of which select ARCH_ATOMIC), there should be
no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-10-mark.rutland@arm.com
---
 include/asm-generic/atomic.h | 71 ++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 316c82a..649060f 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -12,39 +12,47 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
+#ifdef CONFIG_ARCH_ATOMIC
+#define __ga_cmpxchg	arch_cmpxchg
+#define __ga_xchg	arch_xchg
+#else
+#define __ga_cmpxchg	cmpxchg
+#define __ga_xchg	xchg
+#endif
+
 #ifdef CONFIG_SMP
 
 /* we can build all atomic primitives from cmpxchg */
 
 #define ATOMIC_OP(op, c_op)						\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void generic_atomic_##op(int i, atomic_t *v)		\
 {									\
 	int c, old;							\
 									\
 	c = v->counter;							\
-	while ((old = cmpxchg(&v->counter, c, c c_op i)) != c)		\
+	while ((old = __ga_cmpxchg(&v->counter, c, c c_op i)) != c)	\
 		c = old;						\
 }
 
 #define ATOMIC_OP_RETURN(op, c_op)					\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int generic_atomic_##op##_return(int i, atomic_t *v)	\
 {									\
 	int c, old;							\
 									\
 	c = v->counter;							\
-	while ((old = cmpxchg(&v->counter, c, c c_op i)) != c)		\
+	while ((old = __ga_cmpxchg(&v->counter, c, c c_op i)) != c)	\
 		c = old;						\
 									\
 	return c c_op i;						\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op)					\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	int c, old;							\
 									\
 	c = v->counter;							\
-	while ((old = cmpxchg(&v->counter, c, c c_op i)) != c)		\
+	while ((old = __ga_cmpxchg(&v->counter, c, c c_op i)) != c)	\
 		c = old;						\
 									\
 	return c;							\
@@ -55,7 +63,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 #include <linux/irqflags.h>
 
 #define ATOMIC_OP(op, c_op)						\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void generic_atomic_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
 									\
@@ -65,7 +73,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }
 
 #define ATOMIC_OP_RETURN(op, c_op)					\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int generic_atomic_##op##_return(int i, atomic_t *v)	\
 {									\
 	unsigned long flags;						\
 	int ret;							\
@@ -78,7 +86,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op)					\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
 	int ret;							\
@@ -112,10 +120,55 @@ ATOMIC_OP(xor, ^)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
+#undef __ga_cmpxchg
+#undef __ga_xchg
+
+#ifdef CONFIG_ARCH_ATOMIC
+
+#define arch_atomic_add_return			generic_atomic_add_return
+#define arch_atomic_sub_return			generic_atomic_sub_return
+
+#define arch_atomic_fetch_add			generic_atomic_fetch_add
+#define arch_atomic_fetch_sub			generic_atomic_fetch_sub
+#define arch_atomic_fetch_and			generic_atomic_fetch_and
+#define arch_atomic_fetch_or			generic_atomic_fetch_or
+#define arch_atomic_fetch_xor			generic_atomic_fetch_xor
+
+#define arch_atomic_add				generic_atomic_add
+#define arch_atomic_sub				generic_atomic_sub
+#define arch_atomic_and				generic_atomic_and
+#define arch_atomic_or				generic_atomic_or
+#define arch_atomic_xor				generic_atomic_xor
+
+#define arch_atomic_read(v)			READ_ONCE((v)->counter)
+#define arch_atomic_set(v, i)			WRITE_ONCE(((v)->counter), (i))
+
+#define arch_atomic_xchg(ptr, v)		(arch_xchg(&(ptr)->counter, (v)))
+#define arch_atomic_cmpxchg(v, old, new)	(arch_cmpxchg(&((v)->counter), (old), (new)))
+
+#else /* CONFIG_ARCH_ATOMIC */
+
+#define atomic_add_return		generic_atomic_add_return
+#define atomic_sub_return		generic_atomic_sub_return
+
+#define atomic_fetch_add		generic_atomic_fetch_add
+#define atomic_fetch_sub		generic_atomic_fetch_sub
+#define atomic_fetch_and		generic_atomic_fetch_and
+#define atomic_fetch_or			generic_atomic_fetch_or
+#define atomic_fetch_xor		generic_atomic_fetch_xor
+
+#define atomic_add			generic_atomic_add
+#define atomic_sub			generic_atomic_sub
+#define atomic_and			generic_atomic_and
+#define atomic_or			generic_atomic_or
+#define atomic_xor			generic_atomic_xor
+
 #define atomic_read(v)			READ_ONCE((v)->counter)
 #define atomic_set(v, i)		WRITE_ONCE(((v)->counter), (i))
 
 #define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
 #define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
 
+#endif /* CONFIG_ARCH_ATOMIC */
+
 #endif /* __ASM_GENERIC_ATOMIC_H */
