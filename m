Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E690F3915FF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhEZL0z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbhEZL0R (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C5DC06175F;
        Wed, 26 May 2021 04:24:44 -0700 (PDT)
Date:   Wed, 26 May 2021 11:24:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028282;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEgt019CB4a7C4zHT5gjHTfTlkIRTgB8UKWVfsFkHWY=;
        b=DeCJpcBjqz3C7CF4n/SLCU5XU1TNuo9c1Ns4dBEds3EJud7GBUAKAgmTPwJmUMq6G7LH9S
        I2z6h56O+bsLabZZCxTVFMBhQNTIr5EToRG3YBtON3FpedyLxkgWCIyNESwn1olonqAoXh
        40pJg/icz1yNtXPKRxgdZH01A+/R/Wisjcdaxu6ynxJ/wmOfIiLOKsbCX/cv8Bewp8lA7h
        8MxA/nlbHF3NOxjSZydFv0lve33eZjogKlGBbzaGzSl0gEmaHkMsbTvnsYQL7aLlhIKy5f
        LTRjAHbVeugE9JbBiOyncfaMotddQV/GTstaDxXRAuRfnpoMomvAT9YeRkZoHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028282;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEgt019CB4a7C4zHT5gjHTfTlkIRTgB8UKWVfsFkHWY=;
        b=jGlDp8Bq+ntrBukNsBTysPP1UYAyBH34FsxgKSVRe3KJ23zTulIzvgcYgwk8CRswL6lBeL
        q8ikQkXrJc2YSvCg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: h8300: use asm-generic exclusively
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-4-mark.rutland@arm.com>
References: <20210525140232.53872-4-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202828224.29796.8736655408611360182.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c7178cdecdbef8321f418fac55f3afaca3bb4c96
Gitweb:        https://git.kernel.org/tip/c7178cdecdbef8321f418fac55f3afaca3bb4c96
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:49 +02:00

locking/atomic: h8300: use asm-generic exclusively

As h8300's implementation of the atomics isn't using any arch-specific
functionality, and its implementation of cmpxchg only uses assembly to
non-atomically swap two elements in memory, we may as well use the
asm-generic atomic.h and cmpxchg.h, and avoid the duplicate code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-4-mark.rutland@arm.com
---
 arch/h8300/include/asm/Kbuild    |  1 +-
 arch/h8300/include/asm/atomic.h  | 97 +-------------------------------
 arch/h8300/include/asm/cmpxchg.h | 66 +---------------------
 3 files changed, 1 insertion(+), 163 deletions(-)
 delete mode 100644 arch/h8300/include/asm/atomic.h
 delete mode 100644 arch/h8300/include/asm/cmpxchg.h

diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index 60ee7f0..e23139c 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += asm-offsets.h
+generic-y += cmpxchg.h
 generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
diff --git a/arch/h8300/include/asm/atomic.h b/arch/h8300/include/asm/atomic.h
deleted file mode 100644
index a990d15..0000000
--- a/arch/h8300/include/asm/atomic.h
+++ /dev/null
@@ -1,97 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ARCH_H8300_ATOMIC__
-#define __ARCH_H8300_ATOMIC__
-
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include <asm/cmpxchg.h>
-#include <asm/irqflags.h>
-
-/*
- * Atomic operations that C can't guarantee us.  Useful for
- * resource counting etc..
- */
-
-#define atomic_read(v)		READ_ONCE((v)->counter)
-#define atomic_set(v, i)	WRITE_ONCE(((v)->counter), (i))
-
-#define ATOMIC_OP_RETURN(op, c_op)				\
-static inline int atomic_##op##_return(int i, atomic_t *v)	\
-{								\
-	h8300flags flags;					\
-	int ret;						\
-								\
-	flags = arch_local_irq_save();				\
-	ret = v->counter c_op i;				\
-	arch_local_irq_restore(flags);				\
-	return ret;						\
-}
-
-#define ATOMIC_FETCH_OP(op, c_op)				\
-static inline int atomic_fetch_##op(int i, atomic_t *v)		\
-{								\
-	h8300flags flags;					\
-	int ret;						\
-								\
-	flags = arch_local_irq_save();				\
-	ret = v->counter;					\
-	v->counter c_op i;					\
-	arch_local_irq_restore(flags);				\
-	return ret;						\
-}
-
-#define ATOMIC_OP(op, c_op)					\
-static inline void atomic_##op(int i, atomic_t *v)		\
-{								\
-	h8300flags flags;					\
-								\
-	flags = arch_local_irq_save();				\
-	v->counter c_op i;					\
-	arch_local_irq_restore(flags);				\
-}
-
-ATOMIC_OP_RETURN(add, +=)
-ATOMIC_OP_RETURN(sub, -=)
-
-#define ATOMIC_OPS(op, c_op)					\
-	ATOMIC_OP(op, c_op)					\
-	ATOMIC_FETCH_OP(op, c_op)
-
-ATOMIC_OPS(and, &=)
-ATOMIC_OPS(or,  |=)
-ATOMIC_OPS(xor, ^=)
-ATOMIC_OPS(add, +=)
-ATOMIC_OPS(sub, -=)
-
-#undef ATOMIC_OPS
-#undef ATOMIC_OP_RETURN
-#undef ATOMIC_OP
-
-static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
-{
-	int ret;
-	h8300flags flags;
-
-	flags = arch_local_irq_save();
-	ret = v->counter;
-	if (likely(ret == old))
-		v->counter = new;
-	arch_local_irq_restore(flags);
-	return ret;
-}
-
-static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	int ret;
-	h8300flags flags;
-
-	flags = arch_local_irq_save();
-	ret = v->counter;
-	if (ret != u)
-		v->counter += a;
-	arch_local_irq_restore(flags);
-	return ret;
-}
-#define atomic_fetch_add_unless		atomic_fetch_add_unless
-
-#endif /* __ARCH_H8300_ATOMIC __ */
diff --git a/arch/h8300/include/asm/cmpxchg.h b/arch/h8300/include/asm/cmpxchg.h
deleted file mode 100644
index c64bb38..0000000
--- a/arch/h8300/include/asm/cmpxchg.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ARCH_H8300_CMPXCHG__
-#define __ARCH_H8300_CMPXCHG__
-
-#include <linux/irqflags.h>
-
-#define xchg(ptr, x) \
-	((__typeof__(*(ptr)))__xchg((unsigned long)(x), (ptr), \
-				    sizeof(*(ptr))))
-
-struct __xchg_dummy { unsigned long a[100]; };
-#define __xg(x) ((volatile struct __xchg_dummy *)(x))
-
-static inline unsigned long __xchg(unsigned long x,
-				   volatile void *ptr, int size)
-{
-	unsigned long tmp, flags;
-
-	local_irq_save(flags);
-
-	switch (size) {
-	case 1:
-		__asm__ __volatile__
-			("mov.b %2,%0\n\t"
-			 "mov.b %1,%2"
-			 : "=&r" (tmp) : "r" (x), "m" (*__xg(ptr)));
-		break;
-	case 2:
-		__asm__ __volatile__
-			("mov.w %2,%0\n\t"
-			 "mov.w %1,%2"
-			 : "=&r" (tmp) : "r" (x), "m" (*__xg(ptr)));
-		break;
-	case 4:
-		__asm__ __volatile__
-			("mov.l %2,%0\n\t"
-			 "mov.l %1,%2"
-			 : "=&r" (tmp) : "r" (x), "m" (*__xg(ptr)));
-		break;
-	default:
-		tmp = 0;
-	}
-	local_irq_restore(flags);
-	return tmp;
-}
-
-#include <asm-generic/cmpxchg-local.h>
-
-/*
- * cmpxchg_local and cmpxchg64_local are atomic wrt current CPU. Always make
- * them available.
- */
-#define cmpxchg_local(ptr, o, n)					 \
-	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr),		 \
-						     (unsigned long)(o), \
-						     (unsigned long)(n), \
-						     sizeof(*(ptr))))
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
-
-#ifndef CONFIG_SMP
-#include <asm-generic/cmpxchg.h>
-#endif
-
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
-
-#endif /* __ARCH_H8300_CMPXCHG__ */
