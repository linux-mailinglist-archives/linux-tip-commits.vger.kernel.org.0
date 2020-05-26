Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA001CF75F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 May 2020 16:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbgELOhD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 May 2020 10:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730326AbgELOhC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 May 2020 10:37:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E5DC061A0C;
        Tue, 12 May 2020 07:37:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYW1d-0005lj-MN; Tue, 12 May 2020 16:36:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 428D51C02FC;
        Tue, 12 May 2020 16:36:53 +0200 (CEST)
Date:   Tue, 12 May 2020 14:36:53 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] locking/atomics: Flip fallbacks and instrumentation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134058.769149955@linutronix.de>
References: <20200505134058.769149955@linutronix.de>
MIME-Version: 1.0
Message-ID: <158929421313.390.4946639130716614973.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     6bcc8f459fe790f35dfd8e3bb0f43e530d44ee9a
Gitweb:        https://git.kernel.org/tip/6bcc8f459fe790f35dfd8e3bb0f43e530d44ee9a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 24 Jan 2020 22:13:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 16:35:06 +02:00

locking/atomics: Flip fallbacks and instrumentation

Currently instrumentation of atomic primitives is done at the architecture
level, while composites or fallbacks are provided at the generic level.

The result is that there are no uninstrumented variants of the
fallbacks. Since there is now need of such variants to isolate text poke
from any form of instrumentation invert this ordering.

Doing this means moving the instrumentation into the generic code as
well as having (for now) two variants of the fallbacks.

Notes:

 - the various *cond_read* primitives are not proper fallbacks
   and got moved into linux/atomic.c. No arch_ variants are
   generated because the base primitives smp_cond_load*()
   are instrumented.

 - once all architectures are moved over to arch_atomic_ one of the
   fallback variants can be removed and some 2300 lines reclaimed.

 - atomic_{read,set}*() are no longer double-instrumented

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lkml.kernel.org/r/20200505134058.769149955@linutronix.de
---
 arch/arm64/include/asm/atomic.h              |    6 +-
 arch/x86/include/asm/atomic.h                |   17 +-
 arch/x86/include/asm/atomic64_32.h           |    9 +-
 arch/x86/include/asm/atomic64_64.h           |   15 +-
 include/linux/atomic-arch-fallback.h         | 2291 +++++++++++++++++-
 include/linux/atomic-fallback.h              |    8 +-
 include/linux/atomic.h                       |   11 +-
 scripts/atomic/fallbacks/acquire             |    4 +-
 scripts/atomic/fallbacks/add_negative        |    6 +-
 scripts/atomic/fallbacks/add_unless          |    6 +-
 scripts/atomic/fallbacks/andnot              |    4 +-
 scripts/atomic/fallbacks/dec                 |    4 +-
 scripts/atomic/fallbacks/dec_and_test        |    6 +-
 scripts/atomic/fallbacks/dec_if_positive     |    6 +-
 scripts/atomic/fallbacks/dec_unless_positive |    6 +-
 scripts/atomic/fallbacks/fence               |    4 +-
 scripts/atomic/fallbacks/fetch_add_unless    |    8 +-
 scripts/atomic/fallbacks/inc                 |    4 +-
 scripts/atomic/fallbacks/inc_and_test        |    6 +-
 scripts/atomic/fallbacks/inc_not_zero        |    6 +-
 scripts/atomic/fallbacks/inc_unless_negative |    6 +-
 scripts/atomic/fallbacks/read_acquire        |    2 +-
 scripts/atomic/fallbacks/release             |    4 +-
 scripts/atomic/fallbacks/set_release         |    2 +-
 scripts/atomic/fallbacks/sub_and_test        |    6 +-
 scripts/atomic/fallbacks/try_cmpxchg         |    4 +-
 scripts/atomic/gen-atomic-fallback.sh        |   29 +-
 scripts/atomic/gen-atomics.sh                |    5 +-
 28 files changed, 2403 insertions(+), 82 deletions(-)
 create mode 100644 include/linux/atomic-arch-fallback.h

diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index 9543b5e..a08890d 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -101,8 +101,8 @@ static inline long arch_atomic64_dec_if_positive(atomic64_t *v)
 
 #define ATOMIC_INIT(i)	{ (i) }
 
-#define arch_atomic_read(v)			READ_ONCE((v)->counter)
-#define arch_atomic_set(v, i)			WRITE_ONCE(((v)->counter), (i))
+#define arch_atomic_read(v)			__READ_ONCE((v)->counter)
+#define arch_atomic_set(v, i)			__WRITE_ONCE(((v)->counter), (i))
 
 #define arch_atomic_add_return_relaxed		arch_atomic_add_return_relaxed
 #define arch_atomic_add_return_acquire		arch_atomic_add_return_acquire
@@ -225,6 +225,6 @@ static inline long arch_atomic64_dec_if_positive(atomic64_t *v)
 
 #define arch_atomic64_dec_if_positive		arch_atomic64_dec_if_positive
 
-#include <asm-generic/atomic-instrumented.h>
+#define ARCH_ATOMIC
 
 #endif /* __ASM_ATOMIC_H */
diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 115127c..a9ae588 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -28,7 +28,7 @@ static __always_inline int arch_atomic_read(const atomic_t *v)
 	 * Note for KASAN: we deliberately don't use READ_ONCE_NOCHECK() here,
 	 * it's non-inlined function that increases binary size and stack usage.
 	 */
-	return READ_ONCE((v)->counter);
+	return __READ_ONCE((v)->counter);
 }
 
 /**
@@ -40,7 +40,7 @@ static __always_inline int arch_atomic_read(const atomic_t *v)
  */
 static __always_inline void arch_atomic_set(atomic_t *v, int i)
 {
-	WRITE_ONCE(v->counter, i);
+	__WRITE_ONCE(v->counter, i);
 }
 
 /**
@@ -166,6 +166,7 @@ static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
 {
 	return i + xadd(&v->counter, i);
 }
+#define arch_atomic_add_return arch_atomic_add_return
 
 /**
  * arch_atomic_sub_return - subtract integer and return
@@ -178,32 +179,37 @@ static __always_inline int arch_atomic_sub_return(int i, atomic_t *v)
 {
 	return arch_atomic_add_return(-i, v);
 }
+#define arch_atomic_sub_return arch_atomic_sub_return
 
 static __always_inline int arch_atomic_fetch_add(int i, atomic_t *v)
 {
 	return xadd(&v->counter, i);
 }
+#define arch_atomic_fetch_add arch_atomic_fetch_add
 
 static __always_inline int arch_atomic_fetch_sub(int i, atomic_t *v)
 {
 	return xadd(&v->counter, -i);
 }
+#define arch_atomic_fetch_sub arch_atomic_fetch_sub
 
 static __always_inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	return arch_cmpxchg(&v->counter, old, new);
 }
+#define arch_atomic_cmpxchg arch_atomic_cmpxchg
 
-#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
 static __always_inline bool arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	return try_cmpxchg(&v->counter, old, new);
 }
+#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
 
 static inline int arch_atomic_xchg(atomic_t *v, int new)
 {
 	return arch_xchg(&v->counter, new);
 }
+#define arch_atomic_xchg arch_atomic_xchg
 
 static inline void arch_atomic_and(int i, atomic_t *v)
 {
@@ -221,6 +227,7 @@ static inline int arch_atomic_fetch_and(int i, atomic_t *v)
 
 	return val;
 }
+#define arch_atomic_fetch_and arch_atomic_fetch_and
 
 static inline void arch_atomic_or(int i, atomic_t *v)
 {
@@ -238,6 +245,7 @@ static inline int arch_atomic_fetch_or(int i, atomic_t *v)
 
 	return val;
 }
+#define arch_atomic_fetch_or arch_atomic_fetch_or
 
 static inline void arch_atomic_xor(int i, atomic_t *v)
 {
@@ -255,6 +263,7 @@ static inline int arch_atomic_fetch_xor(int i, atomic_t *v)
 
 	return val;
 }
+#define arch_atomic_fetch_xor arch_atomic_fetch_xor
 
 #ifdef CONFIG_X86_32
 # include <asm/atomic64_32.h>
@@ -262,6 +271,6 @@ static inline int arch_atomic_fetch_xor(int i, atomic_t *v)
 # include <asm/atomic64_64.h>
 #endif
 
-#include <asm-generic/atomic-instrumented.h>
+#define ARCH_ATOMIC
 
 #endif /* _ASM_X86_ATOMIC_H */
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 52cfaec..5efd01b 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -75,6 +75,7 @@ static inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
 {
 	return arch_cmpxchg64(&v->counter, o, n);
 }
+#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
 
 /**
  * arch_atomic64_xchg - xchg atomic64 variable
@@ -94,6 +95,7 @@ static inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
 			     : "memory");
 	return o;
 }
+#define arch_atomic64_xchg arch_atomic64_xchg
 
 /**
  * arch_atomic64_set - set atomic64 variable
@@ -138,6 +140,7 @@ static inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 			     ASM_NO_INPUT_CLOBBER("memory"));
 	return i;
 }
+#define arch_atomic64_add_return arch_atomic64_add_return
 
 /*
  * Other variants with different arithmetic operators:
@@ -149,6 +152,7 @@ static inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
 			     ASM_NO_INPUT_CLOBBER("memory"));
 	return i;
 }
+#define arch_atomic64_sub_return arch_atomic64_sub_return
 
 static inline s64 arch_atomic64_inc_return(atomic64_t *v)
 {
@@ -242,6 +246,7 @@ static inline int arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 			     "S" (v) : "memory");
 	return (int)a;
 }
+#define arch_atomic64_add_unless arch_atomic64_add_unless
 
 static inline int arch_atomic64_inc_not_zero(atomic64_t *v)
 {
@@ -281,6 +286,7 @@ static inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 
 	return old;
 }
+#define arch_atomic64_fetch_and arch_atomic64_fetch_and
 
 static inline void arch_atomic64_or(s64 i, atomic64_t *v)
 {
@@ -299,6 +305,7 @@ static inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 
 	return old;
 }
+#define arch_atomic64_fetch_or arch_atomic64_fetch_or
 
 static inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 {
@@ -317,6 +324,7 @@ static inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 
 	return old;
 }
+#define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
 
 static inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
@@ -327,6 +335,7 @@ static inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 
 	return old;
 }
+#define arch_atomic64_fetch_add arch_atomic64_fetch_add
 
 #define arch_atomic64_fetch_sub(i, v)	arch_atomic64_fetch_add(-(i), (v))
 
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 95c6cea..809bd01 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -19,7 +19,7 @@
  */
 static inline s64 arch_atomic64_read(const atomic64_t *v)
 {
-	return READ_ONCE((v)->counter);
+	return __READ_ONCE((v)->counter);
 }
 
 /**
@@ -31,7 +31,7 @@ static inline s64 arch_atomic64_read(const atomic64_t *v)
  */
 static inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
-	WRITE_ONCE(v->counter, i);
+	__WRITE_ONCE(v->counter, i);
 }
 
 /**
@@ -159,37 +159,43 @@ static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 {
 	return i + xadd(&v->counter, i);
 }
+#define arch_atomic64_add_return arch_atomic64_add_return
 
 static inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	return arch_atomic64_add_return(-i, v);
 }
+#define arch_atomic64_sub_return arch_atomic64_sub_return
 
 static inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	return xadd(&v->counter, i);
 }
+#define arch_atomic64_fetch_add arch_atomic64_fetch_add
 
 static inline s64 arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
 	return xadd(&v->counter, -i);
 }
+#define arch_atomic64_fetch_sub arch_atomic64_fetch_sub
 
 static inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
 	return arch_cmpxchg(&v->counter, old, new);
 }
+#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
 
-#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
 static __always_inline bool arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	return try_cmpxchg(&v->counter, old, new);
 }
+#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
 
 static inline s64 arch_atomic64_xchg(atomic64_t *v, s64 new)
 {
 	return arch_xchg(&v->counter, new);
 }
+#define arch_atomic64_xchg arch_atomic64_xchg
 
 static inline void arch_atomic64_and(s64 i, atomic64_t *v)
 {
@@ -207,6 +213,7 @@ static inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 	} while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
 	return val;
 }
+#define arch_atomic64_fetch_and arch_atomic64_fetch_and
 
 static inline void arch_atomic64_or(s64 i, atomic64_t *v)
 {
@@ -224,6 +231,7 @@ static inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 	} while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
 	return val;
 }
+#define arch_atomic64_fetch_or arch_atomic64_fetch_or
 
 static inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 {
@@ -241,5 +249,6 @@ static inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 	} while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
 	return val;
 }
+#define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
 
 #endif /* _ASM_X86_ATOMIC64_64_H */
diff --git a/include/linux/atomic-arch-fallback.h b/include/linux/atomic-arch-fallback.h
new file mode 100644
index 0000000..bcb6aa2
--- /dev/null
+++ b/include/linux/atomic-arch-fallback.h
@@ -0,0 +1,2291 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by scripts/atomic/gen-atomic-fallback.sh
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+#ifndef _LINUX_ATOMIC_FALLBACK_H
+#define _LINUX_ATOMIC_FALLBACK_H
+
+#include <linux/compiler.h>
+
+#ifndef arch_xchg_relaxed
+#define arch_xchg_relaxed		arch_xchg
+#define arch_xchg_acquire		arch_xchg
+#define arch_xchg_release		arch_xchg
+#else /* arch_xchg_relaxed */
+
+#ifndef arch_xchg_acquire
+#define arch_xchg_acquire(...) \
+	__atomic_op_acquire(arch_xchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_xchg_release
+#define arch_xchg_release(...) \
+	__atomic_op_release(arch_xchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_xchg
+#define arch_xchg(...) \
+	__atomic_op_fence(arch_xchg, __VA_ARGS__)
+#endif
+
+#endif /* arch_xchg_relaxed */
+
+#ifndef arch_cmpxchg_relaxed
+#define arch_cmpxchg_relaxed		arch_cmpxchg
+#define arch_cmpxchg_acquire		arch_cmpxchg
+#define arch_cmpxchg_release		arch_cmpxchg
+#else /* arch_cmpxchg_relaxed */
+
+#ifndef arch_cmpxchg_acquire
+#define arch_cmpxchg_acquire(...) \
+	__atomic_op_acquire(arch_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg_release
+#define arch_cmpxchg_release(...) \
+	__atomic_op_release(arch_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg
+#define arch_cmpxchg(...) \
+	__atomic_op_fence(arch_cmpxchg, __VA_ARGS__)
+#endif
+
+#endif /* arch_cmpxchg_relaxed */
+
+#ifndef arch_cmpxchg64_relaxed
+#define arch_cmpxchg64_relaxed		arch_cmpxchg64
+#define arch_cmpxchg64_acquire		arch_cmpxchg64
+#define arch_cmpxchg64_release		arch_cmpxchg64
+#else /* arch_cmpxchg64_relaxed */
+
+#ifndef arch_cmpxchg64_acquire
+#define arch_cmpxchg64_acquire(...) \
+	__atomic_op_acquire(arch_cmpxchg64, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg64_release
+#define arch_cmpxchg64_release(...) \
+	__atomic_op_release(arch_cmpxchg64, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg64
+#define arch_cmpxchg64(...) \
+	__atomic_op_fence(arch_cmpxchg64, __VA_ARGS__)
+#endif
+
+#endif /* arch_cmpxchg64_relaxed */
+
+#ifndef arch_atomic_read_acquire
+static __always_inline int
+arch_atomic_read_acquire(const atomic_t *v)
+{
+	return smp_load_acquire(&(v)->counter);
+}
+#define arch_atomic_read_acquire arch_atomic_read_acquire
+#endif
+
+#ifndef arch_atomic_set_release
+static __always_inline void
+arch_atomic_set_release(atomic_t *v, int i)
+{
+	smp_store_release(&(v)->counter, i);
+}
+#define arch_atomic_set_release arch_atomic_set_release
+#endif
+
+#ifndef arch_atomic_add_return_relaxed
+#define arch_atomic_add_return_acquire arch_atomic_add_return
+#define arch_atomic_add_return_release arch_atomic_add_return
+#define arch_atomic_add_return_relaxed arch_atomic_add_return
+#else /* arch_atomic_add_return_relaxed */
+
+#ifndef arch_atomic_add_return_acquire
+static __always_inline int
+arch_atomic_add_return_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_add_return_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_add_return_acquire arch_atomic_add_return_acquire
+#endif
+
+#ifndef arch_atomic_add_return_release
+static __always_inline int
+arch_atomic_add_return_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_add_return_relaxed(i, v);
+}
+#define arch_atomic_add_return_release arch_atomic_add_return_release
+#endif
+
+#ifndef arch_atomic_add_return
+static __always_inline int
+arch_atomic_add_return(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_add_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_add_return arch_atomic_add_return
+#endif
+
+#endif /* arch_atomic_add_return_relaxed */
+
+#ifndef arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_add_acquire arch_atomic_fetch_add
+#define arch_atomic_fetch_add_release arch_atomic_fetch_add
+#define arch_atomic_fetch_add_relaxed arch_atomic_fetch_add
+#else /* arch_atomic_fetch_add_relaxed */
+
+#ifndef arch_atomic_fetch_add_acquire
+static __always_inline int
+arch_atomic_fetch_add_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_add_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_add_acquire arch_atomic_fetch_add_acquire
+#endif
+
+#ifndef arch_atomic_fetch_add_release
+static __always_inline int
+arch_atomic_fetch_add_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_add_relaxed(i, v);
+}
+#define arch_atomic_fetch_add_release arch_atomic_fetch_add_release
+#endif
+
+#ifndef arch_atomic_fetch_add
+static __always_inline int
+arch_atomic_fetch_add(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_add_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_add arch_atomic_fetch_add
+#endif
+
+#endif /* arch_atomic_fetch_add_relaxed */
+
+#ifndef arch_atomic_sub_return_relaxed
+#define arch_atomic_sub_return_acquire arch_atomic_sub_return
+#define arch_atomic_sub_return_release arch_atomic_sub_return
+#define arch_atomic_sub_return_relaxed arch_atomic_sub_return
+#else /* arch_atomic_sub_return_relaxed */
+
+#ifndef arch_atomic_sub_return_acquire
+static __always_inline int
+arch_atomic_sub_return_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_sub_return_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_sub_return_acquire arch_atomic_sub_return_acquire
+#endif
+
+#ifndef arch_atomic_sub_return_release
+static __always_inline int
+arch_atomic_sub_return_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_sub_return_relaxed(i, v);
+}
+#define arch_atomic_sub_return_release arch_atomic_sub_return_release
+#endif
+
+#ifndef arch_atomic_sub_return
+static __always_inline int
+arch_atomic_sub_return(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_sub_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_sub_return arch_atomic_sub_return
+#endif
+
+#endif /* arch_atomic_sub_return_relaxed */
+
+#ifndef arch_atomic_fetch_sub_relaxed
+#define arch_atomic_fetch_sub_acquire arch_atomic_fetch_sub
+#define arch_atomic_fetch_sub_release arch_atomic_fetch_sub
+#define arch_atomic_fetch_sub_relaxed arch_atomic_fetch_sub
+#else /* arch_atomic_fetch_sub_relaxed */
+
+#ifndef arch_atomic_fetch_sub_acquire
+static __always_inline int
+arch_atomic_fetch_sub_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_sub_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_sub_acquire arch_atomic_fetch_sub_acquire
+#endif
+
+#ifndef arch_atomic_fetch_sub_release
+static __always_inline int
+arch_atomic_fetch_sub_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_sub_relaxed(i, v);
+}
+#define arch_atomic_fetch_sub_release arch_atomic_fetch_sub_release
+#endif
+
+#ifndef arch_atomic_fetch_sub
+static __always_inline int
+arch_atomic_fetch_sub(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_sub_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_sub arch_atomic_fetch_sub
+#endif
+
+#endif /* arch_atomic_fetch_sub_relaxed */
+
+#ifndef arch_atomic_inc
+static __always_inline void
+arch_atomic_inc(atomic_t *v)
+{
+	arch_atomic_add(1, v);
+}
+#define arch_atomic_inc arch_atomic_inc
+#endif
+
+#ifndef arch_atomic_inc_return_relaxed
+#ifdef arch_atomic_inc_return
+#define arch_atomic_inc_return_acquire arch_atomic_inc_return
+#define arch_atomic_inc_return_release arch_atomic_inc_return
+#define arch_atomic_inc_return_relaxed arch_atomic_inc_return
+#endif /* arch_atomic_inc_return */
+
+#ifndef arch_atomic_inc_return
+static __always_inline int
+arch_atomic_inc_return(atomic_t *v)
+{
+	return arch_atomic_add_return(1, v);
+}
+#define arch_atomic_inc_return arch_atomic_inc_return
+#endif
+
+#ifndef arch_atomic_inc_return_acquire
+static __always_inline int
+arch_atomic_inc_return_acquire(atomic_t *v)
+{
+	return arch_atomic_add_return_acquire(1, v);
+}
+#define arch_atomic_inc_return_acquire arch_atomic_inc_return_acquire
+#endif
+
+#ifndef arch_atomic_inc_return_release
+static __always_inline int
+arch_atomic_inc_return_release(atomic_t *v)
+{
+	return arch_atomic_add_return_release(1, v);
+}
+#define arch_atomic_inc_return_release arch_atomic_inc_return_release
+#endif
+
+#ifndef arch_atomic_inc_return_relaxed
+static __always_inline int
+arch_atomic_inc_return_relaxed(atomic_t *v)
+{
+	return arch_atomic_add_return_relaxed(1, v);
+}
+#define arch_atomic_inc_return_relaxed arch_atomic_inc_return_relaxed
+#endif
+
+#else /* arch_atomic_inc_return_relaxed */
+
+#ifndef arch_atomic_inc_return_acquire
+static __always_inline int
+arch_atomic_inc_return_acquire(atomic_t *v)
+{
+	int ret = arch_atomic_inc_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_inc_return_acquire arch_atomic_inc_return_acquire
+#endif
+
+#ifndef arch_atomic_inc_return_release
+static __always_inline int
+arch_atomic_inc_return_release(atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_inc_return_relaxed(v);
+}
+#define arch_atomic_inc_return_release arch_atomic_inc_return_release
+#endif
+
+#ifndef arch_atomic_inc_return
+static __always_inline int
+arch_atomic_inc_return(atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_inc_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_inc_return arch_atomic_inc_return
+#endif
+
+#endif /* arch_atomic_inc_return_relaxed */
+
+#ifndef arch_atomic_fetch_inc_relaxed
+#ifdef arch_atomic_fetch_inc
+#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc
+#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc
+#define arch_atomic_fetch_inc_relaxed arch_atomic_fetch_inc
+#endif /* arch_atomic_fetch_inc */
+
+#ifndef arch_atomic_fetch_inc
+static __always_inline int
+arch_atomic_fetch_inc(atomic_t *v)
+{
+	return arch_atomic_fetch_add(1, v);
+}
+#define arch_atomic_fetch_inc arch_atomic_fetch_inc
+#endif
+
+#ifndef arch_atomic_fetch_inc_acquire
+static __always_inline int
+arch_atomic_fetch_inc_acquire(atomic_t *v)
+{
+	return arch_atomic_fetch_add_acquire(1, v);
+}
+#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc_acquire
+#endif
+
+#ifndef arch_atomic_fetch_inc_release
+static __always_inline int
+arch_atomic_fetch_inc_release(atomic_t *v)
+{
+	return arch_atomic_fetch_add_release(1, v);
+}
+#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc_release
+#endif
+
+#ifndef arch_atomic_fetch_inc_relaxed
+static __always_inline int
+arch_atomic_fetch_inc_relaxed(atomic_t *v)
+{
+	return arch_atomic_fetch_add_relaxed(1, v);
+}
+#define arch_atomic_fetch_inc_relaxed arch_atomic_fetch_inc_relaxed
+#endif
+
+#else /* arch_atomic_fetch_inc_relaxed */
+
+#ifndef arch_atomic_fetch_inc_acquire
+static __always_inline int
+arch_atomic_fetch_inc_acquire(atomic_t *v)
+{
+	int ret = arch_atomic_fetch_inc_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc_acquire
+#endif
+
+#ifndef arch_atomic_fetch_inc_release
+static __always_inline int
+arch_atomic_fetch_inc_release(atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_inc_relaxed(v);
+}
+#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc_release
+#endif
+
+#ifndef arch_atomic_fetch_inc
+static __always_inline int
+arch_atomic_fetch_inc(atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_inc_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_inc arch_atomic_fetch_inc
+#endif
+
+#endif /* arch_atomic_fetch_inc_relaxed */
+
+#ifndef arch_atomic_dec
+static __always_inline void
+arch_atomic_dec(atomic_t *v)
+{
+	arch_atomic_sub(1, v);
+}
+#define arch_atomic_dec arch_atomic_dec
+#endif
+
+#ifndef arch_atomic_dec_return_relaxed
+#ifdef arch_atomic_dec_return
+#define arch_atomic_dec_return_acquire arch_atomic_dec_return
+#define arch_atomic_dec_return_release arch_atomic_dec_return
+#define arch_atomic_dec_return_relaxed arch_atomic_dec_return
+#endif /* arch_atomic_dec_return */
+
+#ifndef arch_atomic_dec_return
+static __always_inline int
+arch_atomic_dec_return(atomic_t *v)
+{
+	return arch_atomic_sub_return(1, v);
+}
+#define arch_atomic_dec_return arch_atomic_dec_return
+#endif
+
+#ifndef arch_atomic_dec_return_acquire
+static __always_inline int
+arch_atomic_dec_return_acquire(atomic_t *v)
+{
+	return arch_atomic_sub_return_acquire(1, v);
+}
+#define arch_atomic_dec_return_acquire arch_atomic_dec_return_acquire
+#endif
+
+#ifndef arch_atomic_dec_return_release
+static __always_inline int
+arch_atomic_dec_return_release(atomic_t *v)
+{
+	return arch_atomic_sub_return_release(1, v);
+}
+#define arch_atomic_dec_return_release arch_atomic_dec_return_release
+#endif
+
+#ifndef arch_atomic_dec_return_relaxed
+static __always_inline int
+arch_atomic_dec_return_relaxed(atomic_t *v)
+{
+	return arch_atomic_sub_return_relaxed(1, v);
+}
+#define arch_atomic_dec_return_relaxed arch_atomic_dec_return_relaxed
+#endif
+
+#else /* arch_atomic_dec_return_relaxed */
+
+#ifndef arch_atomic_dec_return_acquire
+static __always_inline int
+arch_atomic_dec_return_acquire(atomic_t *v)
+{
+	int ret = arch_atomic_dec_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_dec_return_acquire arch_atomic_dec_return_acquire
+#endif
+
+#ifndef arch_atomic_dec_return_release
+static __always_inline int
+arch_atomic_dec_return_release(atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_dec_return_relaxed(v);
+}
+#define arch_atomic_dec_return_release arch_atomic_dec_return_release
+#endif
+
+#ifndef arch_atomic_dec_return
+static __always_inline int
+arch_atomic_dec_return(atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_dec_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_dec_return arch_atomic_dec_return
+#endif
+
+#endif /* arch_atomic_dec_return_relaxed */
+
+#ifndef arch_atomic_fetch_dec_relaxed
+#ifdef arch_atomic_fetch_dec
+#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec
+#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec
+#define arch_atomic_fetch_dec_relaxed arch_atomic_fetch_dec
+#endif /* arch_atomic_fetch_dec */
+
+#ifndef arch_atomic_fetch_dec
+static __always_inline int
+arch_atomic_fetch_dec(atomic_t *v)
+{
+	return arch_atomic_fetch_sub(1, v);
+}
+#define arch_atomic_fetch_dec arch_atomic_fetch_dec
+#endif
+
+#ifndef arch_atomic_fetch_dec_acquire
+static __always_inline int
+arch_atomic_fetch_dec_acquire(atomic_t *v)
+{
+	return arch_atomic_fetch_sub_acquire(1, v);
+}
+#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec_acquire
+#endif
+
+#ifndef arch_atomic_fetch_dec_release
+static __always_inline int
+arch_atomic_fetch_dec_release(atomic_t *v)
+{
+	return arch_atomic_fetch_sub_release(1, v);
+}
+#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec_release
+#endif
+
+#ifndef arch_atomic_fetch_dec_relaxed
+static __always_inline int
+arch_atomic_fetch_dec_relaxed(atomic_t *v)
+{
+	return arch_atomic_fetch_sub_relaxed(1, v);
+}
+#define arch_atomic_fetch_dec_relaxed arch_atomic_fetch_dec_relaxed
+#endif
+
+#else /* arch_atomic_fetch_dec_relaxed */
+
+#ifndef arch_atomic_fetch_dec_acquire
+static __always_inline int
+arch_atomic_fetch_dec_acquire(atomic_t *v)
+{
+	int ret = arch_atomic_fetch_dec_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec_acquire
+#endif
+
+#ifndef arch_atomic_fetch_dec_release
+static __always_inline int
+arch_atomic_fetch_dec_release(atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_dec_relaxed(v);
+}
+#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec_release
+#endif
+
+#ifndef arch_atomic_fetch_dec
+static __always_inline int
+arch_atomic_fetch_dec(atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_dec_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_dec arch_atomic_fetch_dec
+#endif
+
+#endif /* arch_atomic_fetch_dec_relaxed */
+
+#ifndef arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_and_acquire arch_atomic_fetch_and
+#define arch_atomic_fetch_and_release arch_atomic_fetch_and
+#define arch_atomic_fetch_and_relaxed arch_atomic_fetch_and
+#else /* arch_atomic_fetch_and_relaxed */
+
+#ifndef arch_atomic_fetch_and_acquire
+static __always_inline int
+arch_atomic_fetch_and_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_and_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_and_acquire arch_atomic_fetch_and_acquire
+#endif
+
+#ifndef arch_atomic_fetch_and_release
+static __always_inline int
+arch_atomic_fetch_and_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_and_relaxed(i, v);
+}
+#define arch_atomic_fetch_and_release arch_atomic_fetch_and_release
+#endif
+
+#ifndef arch_atomic_fetch_and
+static __always_inline int
+arch_atomic_fetch_and(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_and_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_and arch_atomic_fetch_and
+#endif
+
+#endif /* arch_atomic_fetch_and_relaxed */
+
+#ifndef arch_atomic_andnot
+static __always_inline void
+arch_atomic_andnot(int i, atomic_t *v)
+{
+	arch_atomic_and(~i, v);
+}
+#define arch_atomic_andnot arch_atomic_andnot
+#endif
+
+#ifndef arch_atomic_fetch_andnot_relaxed
+#ifdef arch_atomic_fetch_andnot
+#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot
+#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot
+#define arch_atomic_fetch_andnot_relaxed arch_atomic_fetch_andnot
+#endif /* arch_atomic_fetch_andnot */
+
+#ifndef arch_atomic_fetch_andnot
+static __always_inline int
+arch_atomic_fetch_andnot(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and(~i, v);
+}
+#define arch_atomic_fetch_andnot arch_atomic_fetch_andnot
+#endif
+
+#ifndef arch_atomic_fetch_andnot_acquire
+static __always_inline int
+arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and_acquire(~i, v);
+}
+#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
+#endif
+
+#ifndef arch_atomic_fetch_andnot_release
+static __always_inline int
+arch_atomic_fetch_andnot_release(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and_release(~i, v);
+}
+#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
+#endif
+
+#ifndef arch_atomic_fetch_andnot_relaxed
+static __always_inline int
+arch_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and_relaxed(~i, v);
+}
+#define arch_atomic_fetch_andnot_relaxed arch_atomic_fetch_andnot_relaxed
+#endif
+
+#else /* arch_atomic_fetch_andnot_relaxed */
+
+#ifndef arch_atomic_fetch_andnot_acquire
+static __always_inline int
+arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_andnot_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
+#endif
+
+#ifndef arch_atomic_fetch_andnot_release
+static __always_inline int
+arch_atomic_fetch_andnot_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_andnot_relaxed(i, v);
+}
+#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
+#endif
+
+#ifndef arch_atomic_fetch_andnot
+static __always_inline int
+arch_atomic_fetch_andnot(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_andnot_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_andnot arch_atomic_fetch_andnot
+#endif
+
+#endif /* arch_atomic_fetch_andnot_relaxed */
+
+#ifndef arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_or_acquire arch_atomic_fetch_or
+#define arch_atomic_fetch_or_release arch_atomic_fetch_or
+#define arch_atomic_fetch_or_relaxed arch_atomic_fetch_or
+#else /* arch_atomic_fetch_or_relaxed */
+
+#ifndef arch_atomic_fetch_or_acquire
+static __always_inline int
+arch_atomic_fetch_or_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_or_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_or_acquire arch_atomic_fetch_or_acquire
+#endif
+
+#ifndef arch_atomic_fetch_or_release
+static __always_inline int
+arch_atomic_fetch_or_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_or_relaxed(i, v);
+}
+#define arch_atomic_fetch_or_release arch_atomic_fetch_or_release
+#endif
+
+#ifndef arch_atomic_fetch_or
+static __always_inline int
+arch_atomic_fetch_or(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_or_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_or arch_atomic_fetch_or
+#endif
+
+#endif /* arch_atomic_fetch_or_relaxed */
+
+#ifndef arch_atomic_fetch_xor_relaxed
+#define arch_atomic_fetch_xor_acquire arch_atomic_fetch_xor
+#define arch_atomic_fetch_xor_release arch_atomic_fetch_xor
+#define arch_atomic_fetch_xor_relaxed arch_atomic_fetch_xor
+#else /* arch_atomic_fetch_xor_relaxed */
+
+#ifndef arch_atomic_fetch_xor_acquire
+static __always_inline int
+arch_atomic_fetch_xor_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_xor_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_xor_acquire arch_atomic_fetch_xor_acquire
+#endif
+
+#ifndef arch_atomic_fetch_xor_release
+static __always_inline int
+arch_atomic_fetch_xor_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_xor_relaxed(i, v);
+}
+#define arch_atomic_fetch_xor_release arch_atomic_fetch_xor_release
+#endif
+
+#ifndef arch_atomic_fetch_xor
+static __always_inline int
+arch_atomic_fetch_xor(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_xor_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_xor arch_atomic_fetch_xor
+#endif
+
+#endif /* arch_atomic_fetch_xor_relaxed */
+
+#ifndef arch_atomic_xchg_relaxed
+#define arch_atomic_xchg_acquire arch_atomic_xchg
+#define arch_atomic_xchg_release arch_atomic_xchg
+#define arch_atomic_xchg_relaxed arch_atomic_xchg
+#else /* arch_atomic_xchg_relaxed */
+
+#ifndef arch_atomic_xchg_acquire
+static __always_inline int
+arch_atomic_xchg_acquire(atomic_t *v, int i)
+{
+	int ret = arch_atomic_xchg_relaxed(v, i);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_xchg_acquire arch_atomic_xchg_acquire
+#endif
+
+#ifndef arch_atomic_xchg_release
+static __always_inline int
+arch_atomic_xchg_release(atomic_t *v, int i)
+{
+	__atomic_release_fence();
+	return arch_atomic_xchg_relaxed(v, i);
+}
+#define arch_atomic_xchg_release arch_atomic_xchg_release
+#endif
+
+#ifndef arch_atomic_xchg
+static __always_inline int
+arch_atomic_xchg(atomic_t *v, int i)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_xchg_relaxed(v, i);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_xchg arch_atomic_xchg
+#endif
+
+#endif /* arch_atomic_xchg_relaxed */
+
+#ifndef arch_atomic_cmpxchg_relaxed
+#define arch_atomic_cmpxchg_acquire arch_atomic_cmpxchg
+#define arch_atomic_cmpxchg_release arch_atomic_cmpxchg
+#define arch_atomic_cmpxchg_relaxed arch_atomic_cmpxchg
+#else /* arch_atomic_cmpxchg_relaxed */
+
+#ifndef arch_atomic_cmpxchg_acquire
+static __always_inline int
+arch_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
+{
+	int ret = arch_atomic_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_cmpxchg_acquire arch_atomic_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic_cmpxchg_release
+static __always_inline int
+arch_atomic_cmpxchg_release(atomic_t *v, int old, int new)
+{
+	__atomic_release_fence();
+	return arch_atomic_cmpxchg_relaxed(v, old, new);
+}
+#define arch_atomic_cmpxchg_release arch_atomic_cmpxchg_release
+#endif
+
+#ifndef arch_atomic_cmpxchg
+static __always_inline int
+arch_atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_cmpxchg_relaxed(v, old, new);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_cmpxchg arch_atomic_cmpxchg
+#endif
+
+#endif /* arch_atomic_cmpxchg_relaxed */
+
+#ifndef arch_atomic_try_cmpxchg_relaxed
+#ifdef arch_atomic_try_cmpxchg
+#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg
+#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg
+#define arch_atomic_try_cmpxchg_relaxed arch_atomic_try_cmpxchg
+#endif /* arch_atomic_try_cmpxchg */
+
+#ifndef arch_atomic_try_cmpxchg
+static __always_inline bool
+arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+	r = arch_atomic_cmpxchg(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
+#endif
+
+#ifndef arch_atomic_try_cmpxchg_acquire
+static __always_inline bool
+arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+	r = arch_atomic_cmpxchg_acquire(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic_try_cmpxchg_release
+static __always_inline bool
+arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+	r = arch_atomic_cmpxchg_release(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg_release
+#endif
+
+#ifndef arch_atomic_try_cmpxchg_relaxed
+static __always_inline bool
+arch_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+	r = arch_atomic_cmpxchg_relaxed(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic_try_cmpxchg_relaxed arch_atomic_try_cmpxchg_relaxed
+#endif
+
+#else /* arch_atomic_try_cmpxchg_relaxed */
+
+#ifndef arch_atomic_try_cmpxchg_acquire
+static __always_inline bool
+arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
+{
+	bool ret = arch_atomic_try_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic_try_cmpxchg_release
+static __always_inline bool
+arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
+{
+	__atomic_release_fence();
+	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
+}
+#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg_release
+#endif
+
+#ifndef arch_atomic_try_cmpxchg
+static __always_inline bool
+arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
+{
+	bool ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_try_cmpxchg_relaxed(v, old, new);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
+#endif
+
+#endif /* arch_atomic_try_cmpxchg_relaxed */
+
+#ifndef arch_atomic_sub_and_test
+/**
+ * arch_atomic_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer of type atomic_t
+ *
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static __always_inline bool
+arch_atomic_sub_and_test(int i, atomic_t *v)
+{
+	return arch_atomic_sub_return(i, v) == 0;
+}
+#define arch_atomic_sub_and_test arch_atomic_sub_and_test
+#endif
+
+#ifndef arch_atomic_dec_and_test
+/**
+ * arch_atomic_dec_and_test - decrement and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+static __always_inline bool
+arch_atomic_dec_and_test(atomic_t *v)
+{
+	return arch_atomic_dec_return(v) == 0;
+}
+#define arch_atomic_dec_and_test arch_atomic_dec_and_test
+#endif
+
+#ifndef arch_atomic_inc_and_test
+/**
+ * arch_atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+static __always_inline bool
+arch_atomic_inc_and_test(atomic_t *v)
+{
+	return arch_atomic_inc_return(v) == 0;
+}
+#define arch_atomic_inc_and_test arch_atomic_inc_and_test
+#endif
+
+#ifndef arch_atomic_add_negative
+/**
+ * arch_atomic_add_negative - add and test if negative
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+static __always_inline bool
+arch_atomic_add_negative(int i, atomic_t *v)
+{
+	return arch_atomic_add_return(i, v) < 0;
+}
+#define arch_atomic_add_negative arch_atomic_add_negative
+#endif
+
+#ifndef arch_atomic_fetch_add_unless
+/**
+ * arch_atomic_fetch_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as @v was not already @u.
+ * Returns original value of @v
+ */
+static __always_inline int
+arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
+{
+	int c = arch_atomic_read(v);
+
+	do {
+		if (unlikely(c == u))
+			break;
+	} while (!arch_atomic_try_cmpxchg(v, &c, c + a));
+
+	return c;
+}
+#define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
+#endif
+
+#ifndef arch_atomic_add_unless
+/**
+ * arch_atomic_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, if @v was not already @u.
+ * Returns true if the addition was done.
+ */
+static __always_inline bool
+arch_atomic_add_unless(atomic_t *v, int a, int u)
+{
+	return arch_atomic_fetch_add_unless(v, a, u) != u;
+}
+#define arch_atomic_add_unless arch_atomic_add_unless
+#endif
+
+#ifndef arch_atomic_inc_not_zero
+/**
+ * arch_atomic_inc_not_zero - increment unless the number is zero
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1, if @v is non-zero.
+ * Returns true if the increment was done.
+ */
+static __always_inline bool
+arch_atomic_inc_not_zero(atomic_t *v)
+{
+	return arch_atomic_add_unless(v, 1, 0);
+}
+#define arch_atomic_inc_not_zero arch_atomic_inc_not_zero
+#endif
+
+#ifndef arch_atomic_inc_unless_negative
+static __always_inline bool
+arch_atomic_inc_unless_negative(atomic_t *v)
+{
+	int c = arch_atomic_read(v);
+
+	do {
+		if (unlikely(c < 0))
+			return false;
+	} while (!arch_atomic_try_cmpxchg(v, &c, c + 1));
+
+	return true;
+}
+#define arch_atomic_inc_unless_negative arch_atomic_inc_unless_negative
+#endif
+
+#ifndef arch_atomic_dec_unless_positive
+static __always_inline bool
+arch_atomic_dec_unless_positive(atomic_t *v)
+{
+	int c = arch_atomic_read(v);
+
+	do {
+		if (unlikely(c > 0))
+			return false;
+	} while (!arch_atomic_try_cmpxchg(v, &c, c - 1));
+
+	return true;
+}
+#define arch_atomic_dec_unless_positive arch_atomic_dec_unless_positive
+#endif
+
+#ifndef arch_atomic_dec_if_positive
+static __always_inline int
+arch_atomic_dec_if_positive(atomic_t *v)
+{
+	int dec, c = arch_atomic_read(v);
+
+	do {
+		dec = c - 1;
+		if (unlikely(dec < 0))
+			break;
+	} while (!arch_atomic_try_cmpxchg(v, &c, dec));
+
+	return dec;
+}
+#define arch_atomic_dec_if_positive arch_atomic_dec_if_positive
+#endif
+
+#ifdef CONFIG_GENERIC_ATOMIC64
+#include <asm-generic/atomic64.h>
+#endif
+
+#ifndef arch_atomic64_read_acquire
+static __always_inline s64
+arch_atomic64_read_acquire(const atomic64_t *v)
+{
+	return smp_load_acquire(&(v)->counter);
+}
+#define arch_atomic64_read_acquire arch_atomic64_read_acquire
+#endif
+
+#ifndef arch_atomic64_set_release
+static __always_inline void
+arch_atomic64_set_release(atomic64_t *v, s64 i)
+{
+	smp_store_release(&(v)->counter, i);
+}
+#define arch_atomic64_set_release arch_atomic64_set_release
+#endif
+
+#ifndef arch_atomic64_add_return_relaxed
+#define arch_atomic64_add_return_acquire arch_atomic64_add_return
+#define arch_atomic64_add_return_release arch_atomic64_add_return
+#define arch_atomic64_add_return_relaxed arch_atomic64_add_return
+#else /* arch_atomic64_add_return_relaxed */
+
+#ifndef arch_atomic64_add_return_acquire
+static __always_inline s64
+arch_atomic64_add_return_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_add_return_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_add_return_acquire arch_atomic64_add_return_acquire
+#endif
+
+#ifndef arch_atomic64_add_return_release
+static __always_inline s64
+arch_atomic64_add_return_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_add_return_relaxed(i, v);
+}
+#define arch_atomic64_add_return_release arch_atomic64_add_return_release
+#endif
+
+#ifndef arch_atomic64_add_return
+static __always_inline s64
+arch_atomic64_add_return(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_add_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_add_return arch_atomic64_add_return
+#endif
+
+#endif /* arch_atomic64_add_return_relaxed */
+
+#ifndef arch_atomic64_fetch_add_relaxed
+#define arch_atomic64_fetch_add_acquire arch_atomic64_fetch_add
+#define arch_atomic64_fetch_add_release arch_atomic64_fetch_add
+#define arch_atomic64_fetch_add_relaxed arch_atomic64_fetch_add
+#else /* arch_atomic64_fetch_add_relaxed */
+
+#ifndef arch_atomic64_fetch_add_acquire
+static __always_inline s64
+arch_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_add_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_add_acquire arch_atomic64_fetch_add_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_add_release
+static __always_inline s64
+arch_atomic64_fetch_add_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_add_relaxed(i, v);
+}
+#define arch_atomic64_fetch_add_release arch_atomic64_fetch_add_release
+#endif
+
+#ifndef arch_atomic64_fetch_add
+static __always_inline s64
+arch_atomic64_fetch_add(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_add_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_add arch_atomic64_fetch_add
+#endif
+
+#endif /* arch_atomic64_fetch_add_relaxed */
+
+#ifndef arch_atomic64_sub_return_relaxed
+#define arch_atomic64_sub_return_acquire arch_atomic64_sub_return
+#define arch_atomic64_sub_return_release arch_atomic64_sub_return
+#define arch_atomic64_sub_return_relaxed arch_atomic64_sub_return
+#else /* arch_atomic64_sub_return_relaxed */
+
+#ifndef arch_atomic64_sub_return_acquire
+static __always_inline s64
+arch_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_sub_return_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_sub_return_acquire arch_atomic64_sub_return_acquire
+#endif
+
+#ifndef arch_atomic64_sub_return_release
+static __always_inline s64
+arch_atomic64_sub_return_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_sub_return_relaxed(i, v);
+}
+#define arch_atomic64_sub_return_release arch_atomic64_sub_return_release
+#endif
+
+#ifndef arch_atomic64_sub_return
+static __always_inline s64
+arch_atomic64_sub_return(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_sub_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_sub_return arch_atomic64_sub_return
+#endif
+
+#endif /* arch_atomic64_sub_return_relaxed */
+
+#ifndef arch_atomic64_fetch_sub_relaxed
+#define arch_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub
+#define arch_atomic64_fetch_sub_release arch_atomic64_fetch_sub
+#define arch_atomic64_fetch_sub_relaxed arch_atomic64_fetch_sub
+#else /* arch_atomic64_fetch_sub_relaxed */
+
+#ifndef arch_atomic64_fetch_sub_acquire
+static __always_inline s64
+arch_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_sub_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_sub_release
+static __always_inline s64
+arch_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_sub_relaxed(i, v);
+}
+#define arch_atomic64_fetch_sub_release arch_atomic64_fetch_sub_release
+#endif
+
+#ifndef arch_atomic64_fetch_sub
+static __always_inline s64
+arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_sub_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_sub arch_atomic64_fetch_sub
+#endif
+
+#endif /* arch_atomic64_fetch_sub_relaxed */
+
+#ifndef arch_atomic64_inc
+static __always_inline void
+arch_atomic64_inc(atomic64_t *v)
+{
+	arch_atomic64_add(1, v);
+}
+#define arch_atomic64_inc arch_atomic64_inc
+#endif
+
+#ifndef arch_atomic64_inc_return_relaxed
+#ifdef arch_atomic64_inc_return
+#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return
+#define arch_atomic64_inc_return_release arch_atomic64_inc_return
+#define arch_atomic64_inc_return_relaxed arch_atomic64_inc_return
+#endif /* arch_atomic64_inc_return */
+
+#ifndef arch_atomic64_inc_return
+static __always_inline s64
+arch_atomic64_inc_return(atomic64_t *v)
+{
+	return arch_atomic64_add_return(1, v);
+}
+#define arch_atomic64_inc_return arch_atomic64_inc_return
+#endif
+
+#ifndef arch_atomic64_inc_return_acquire
+static __always_inline s64
+arch_atomic64_inc_return_acquire(atomic64_t *v)
+{
+	return arch_atomic64_add_return_acquire(1, v);
+}
+#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return_acquire
+#endif
+
+#ifndef arch_atomic64_inc_return_release
+static __always_inline s64
+arch_atomic64_inc_return_release(atomic64_t *v)
+{
+	return arch_atomic64_add_return_release(1, v);
+}
+#define arch_atomic64_inc_return_release arch_atomic64_inc_return_release
+#endif
+
+#ifndef arch_atomic64_inc_return_relaxed
+static __always_inline s64
+arch_atomic64_inc_return_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_add_return_relaxed(1, v);
+}
+#define arch_atomic64_inc_return_relaxed arch_atomic64_inc_return_relaxed
+#endif
+
+#else /* arch_atomic64_inc_return_relaxed */
+
+#ifndef arch_atomic64_inc_return_acquire
+static __always_inline s64
+arch_atomic64_inc_return_acquire(atomic64_t *v)
+{
+	s64 ret = arch_atomic64_inc_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return_acquire
+#endif
+
+#ifndef arch_atomic64_inc_return_release
+static __always_inline s64
+arch_atomic64_inc_return_release(atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_inc_return_relaxed(v);
+}
+#define arch_atomic64_inc_return_release arch_atomic64_inc_return_release
+#endif
+
+#ifndef arch_atomic64_inc_return
+static __always_inline s64
+arch_atomic64_inc_return(atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_inc_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_inc_return arch_atomic64_inc_return
+#endif
+
+#endif /* arch_atomic64_inc_return_relaxed */
+
+#ifndef arch_atomic64_fetch_inc_relaxed
+#ifdef arch_atomic64_fetch_inc
+#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc
+#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc
+#define arch_atomic64_fetch_inc_relaxed arch_atomic64_fetch_inc
+#endif /* arch_atomic64_fetch_inc */
+
+#ifndef arch_atomic64_fetch_inc
+static __always_inline s64
+arch_atomic64_fetch_inc(atomic64_t *v)
+{
+	return arch_atomic64_fetch_add(1, v);
+}
+#define arch_atomic64_fetch_inc arch_atomic64_fetch_inc
+#endif
+
+#ifndef arch_atomic64_fetch_inc_acquire
+static __always_inline s64
+arch_atomic64_fetch_inc_acquire(atomic64_t *v)
+{
+	return arch_atomic64_fetch_add_acquire(1, v);
+}
+#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_inc_release
+static __always_inline s64
+arch_atomic64_fetch_inc_release(atomic64_t *v)
+{
+	return arch_atomic64_fetch_add_release(1, v);
+}
+#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc_release
+#endif
+
+#ifndef arch_atomic64_fetch_inc_relaxed
+static __always_inline s64
+arch_atomic64_fetch_inc_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_fetch_add_relaxed(1, v);
+}
+#define arch_atomic64_fetch_inc_relaxed arch_atomic64_fetch_inc_relaxed
+#endif
+
+#else /* arch_atomic64_fetch_inc_relaxed */
+
+#ifndef arch_atomic64_fetch_inc_acquire
+static __always_inline s64
+arch_atomic64_fetch_inc_acquire(atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_inc_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_inc_release
+static __always_inline s64
+arch_atomic64_fetch_inc_release(atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_inc_relaxed(v);
+}
+#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc_release
+#endif
+
+#ifndef arch_atomic64_fetch_inc
+static __always_inline s64
+arch_atomic64_fetch_inc(atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_inc_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_inc arch_atomic64_fetch_inc
+#endif
+
+#endif /* arch_atomic64_fetch_inc_relaxed */
+
+#ifndef arch_atomic64_dec
+static __always_inline void
+arch_atomic64_dec(atomic64_t *v)
+{
+	arch_atomic64_sub(1, v);
+}
+#define arch_atomic64_dec arch_atomic64_dec
+#endif
+
+#ifndef arch_atomic64_dec_return_relaxed
+#ifdef arch_atomic64_dec_return
+#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return
+#define arch_atomic64_dec_return_release arch_atomic64_dec_return
+#define arch_atomic64_dec_return_relaxed arch_atomic64_dec_return
+#endif /* arch_atomic64_dec_return */
+
+#ifndef arch_atomic64_dec_return
+static __always_inline s64
+arch_atomic64_dec_return(atomic64_t *v)
+{
+	return arch_atomic64_sub_return(1, v);
+}
+#define arch_atomic64_dec_return arch_atomic64_dec_return
+#endif
+
+#ifndef arch_atomic64_dec_return_acquire
+static __always_inline s64
+arch_atomic64_dec_return_acquire(atomic64_t *v)
+{
+	return arch_atomic64_sub_return_acquire(1, v);
+}
+#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return_acquire
+#endif
+
+#ifndef arch_atomic64_dec_return_release
+static __always_inline s64
+arch_atomic64_dec_return_release(atomic64_t *v)
+{
+	return arch_atomic64_sub_return_release(1, v);
+}
+#define arch_atomic64_dec_return_release arch_atomic64_dec_return_release
+#endif
+
+#ifndef arch_atomic64_dec_return_relaxed
+static __always_inline s64
+arch_atomic64_dec_return_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_sub_return_relaxed(1, v);
+}
+#define arch_atomic64_dec_return_relaxed arch_atomic64_dec_return_relaxed
+#endif
+
+#else /* arch_atomic64_dec_return_relaxed */
+
+#ifndef arch_atomic64_dec_return_acquire
+static __always_inline s64
+arch_atomic64_dec_return_acquire(atomic64_t *v)
+{
+	s64 ret = arch_atomic64_dec_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return_acquire
+#endif
+
+#ifndef arch_atomic64_dec_return_release
+static __always_inline s64
+arch_atomic64_dec_return_release(atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_dec_return_relaxed(v);
+}
+#define arch_atomic64_dec_return_release arch_atomic64_dec_return_release
+#endif
+
+#ifndef arch_atomic64_dec_return
+static __always_inline s64
+arch_atomic64_dec_return(atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_dec_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_dec_return arch_atomic64_dec_return
+#endif
+
+#endif /* arch_atomic64_dec_return_relaxed */
+
+#ifndef arch_atomic64_fetch_dec_relaxed
+#ifdef arch_atomic64_fetch_dec
+#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec
+#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec
+#define arch_atomic64_fetch_dec_relaxed arch_atomic64_fetch_dec
+#endif /* arch_atomic64_fetch_dec */
+
+#ifndef arch_atomic64_fetch_dec
+static __always_inline s64
+arch_atomic64_fetch_dec(atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub(1, v);
+}
+#define arch_atomic64_fetch_dec arch_atomic64_fetch_dec
+#endif
+
+#ifndef arch_atomic64_fetch_dec_acquire
+static __always_inline s64
+arch_atomic64_fetch_dec_acquire(atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub_acquire(1, v);
+}
+#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_dec_release
+static __always_inline s64
+arch_atomic64_fetch_dec_release(atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub_release(1, v);
+}
+#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec_release
+#endif
+
+#ifndef arch_atomic64_fetch_dec_relaxed
+static __always_inline s64
+arch_atomic64_fetch_dec_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub_relaxed(1, v);
+}
+#define arch_atomic64_fetch_dec_relaxed arch_atomic64_fetch_dec_relaxed
+#endif
+
+#else /* arch_atomic64_fetch_dec_relaxed */
+
+#ifndef arch_atomic64_fetch_dec_acquire
+static __always_inline s64
+arch_atomic64_fetch_dec_acquire(atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_dec_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_dec_release
+static __always_inline s64
+arch_atomic64_fetch_dec_release(atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_dec_relaxed(v);
+}
+#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec_release
+#endif
+
+#ifndef arch_atomic64_fetch_dec
+static __always_inline s64
+arch_atomic64_fetch_dec(atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_dec_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_dec arch_atomic64_fetch_dec
+#endif
+
+#endif /* arch_atomic64_fetch_dec_relaxed */
+
+#ifndef arch_atomic64_fetch_and_relaxed
+#define arch_atomic64_fetch_and_acquire arch_atomic64_fetch_and
+#define arch_atomic64_fetch_and_release arch_atomic64_fetch_and
+#define arch_atomic64_fetch_and_relaxed arch_atomic64_fetch_and
+#else /* arch_atomic64_fetch_and_relaxed */
+
+#ifndef arch_atomic64_fetch_and_acquire
+static __always_inline s64
+arch_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_and_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_and_acquire arch_atomic64_fetch_and_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_and_release
+static __always_inline s64
+arch_atomic64_fetch_and_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_and_relaxed(i, v);
+}
+#define arch_atomic64_fetch_and_release arch_atomic64_fetch_and_release
+#endif
+
+#ifndef arch_atomic64_fetch_and
+static __always_inline s64
+arch_atomic64_fetch_and(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_and_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_and arch_atomic64_fetch_and
+#endif
+
+#endif /* arch_atomic64_fetch_and_relaxed */
+
+#ifndef arch_atomic64_andnot
+static __always_inline void
+arch_atomic64_andnot(s64 i, atomic64_t *v)
+{
+	arch_atomic64_and(~i, v);
+}
+#define arch_atomic64_andnot arch_atomic64_andnot
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_relaxed
+#ifdef arch_atomic64_fetch_andnot
+#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot
+#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot
+#define arch_atomic64_fetch_andnot_relaxed arch_atomic64_fetch_andnot
+#endif /* arch_atomic64_fetch_andnot */
+
+#ifndef arch_atomic64_fetch_andnot
+static __always_inline s64
+arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and(~i, v);
+}
+#define arch_atomic64_fetch_andnot arch_atomic64_fetch_andnot
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_acquire
+static __always_inline s64
+arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and_acquire(~i, v);
+}
+#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_release
+static __always_inline s64
+arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and_release(~i, v);
+}
+#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot_release
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_relaxed
+static __always_inline s64
+arch_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and_relaxed(~i, v);
+}
+#define arch_atomic64_fetch_andnot_relaxed arch_atomic64_fetch_andnot_relaxed
+#endif
+
+#else /* arch_atomic64_fetch_andnot_relaxed */
+
+#ifndef arch_atomic64_fetch_andnot_acquire
+static __always_inline s64
+arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_andnot_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_release
+static __always_inline s64
+arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_andnot_relaxed(i, v);
+}
+#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot_release
+#endif
+
+#ifndef arch_atomic64_fetch_andnot
+static __always_inline s64
+arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_andnot_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_andnot arch_atomic64_fetch_andnot
+#endif
+
+#endif /* arch_atomic64_fetch_andnot_relaxed */
+
+#ifndef arch_atomic64_fetch_or_relaxed
+#define arch_atomic64_fetch_or_acquire arch_atomic64_fetch_or
+#define arch_atomic64_fetch_or_release arch_atomic64_fetch_or
+#define arch_atomic64_fetch_or_relaxed arch_atomic64_fetch_or
+#else /* arch_atomic64_fetch_or_relaxed */
+
+#ifndef arch_atomic64_fetch_or_acquire
+static __always_inline s64
+arch_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_or_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_or_acquire arch_atomic64_fetch_or_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_or_release
+static __always_inline s64
+arch_atomic64_fetch_or_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_or_relaxed(i, v);
+}
+#define arch_atomic64_fetch_or_release arch_atomic64_fetch_or_release
+#endif
+
+#ifndef arch_atomic64_fetch_or
+static __always_inline s64
+arch_atomic64_fetch_or(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_or_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_or arch_atomic64_fetch_or
+#endif
+
+#endif /* arch_atomic64_fetch_or_relaxed */
+
+#ifndef arch_atomic64_fetch_xor_relaxed
+#define arch_atomic64_fetch_xor_acquire arch_atomic64_fetch_xor
+#define arch_atomic64_fetch_xor_release arch_atomic64_fetch_xor
+#define arch_atomic64_fetch_xor_relaxed arch_atomic64_fetch_xor
+#else /* arch_atomic64_fetch_xor_relaxed */
+
+#ifndef arch_atomic64_fetch_xor_acquire
+static __always_inline s64
+arch_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_xor_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_xor_acquire arch_atomic64_fetch_xor_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_xor_release
+static __always_inline s64
+arch_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_xor_relaxed(i, v);
+}
+#define arch_atomic64_fetch_xor_release arch_atomic64_fetch_xor_release
+#endif
+
+#ifndef arch_atomic64_fetch_xor
+static __always_inline s64
+arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_xor_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
+#endif
+
+#endif /* arch_atomic64_fetch_xor_relaxed */
+
+#ifndef arch_atomic64_xchg_relaxed
+#define arch_atomic64_xchg_acquire arch_atomic64_xchg
+#define arch_atomic64_xchg_release arch_atomic64_xchg
+#define arch_atomic64_xchg_relaxed arch_atomic64_xchg
+#else /* arch_atomic64_xchg_relaxed */
+
+#ifndef arch_atomic64_xchg_acquire
+static __always_inline s64
+arch_atomic64_xchg_acquire(atomic64_t *v, s64 i)
+{
+	s64 ret = arch_atomic64_xchg_relaxed(v, i);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_xchg_acquire arch_atomic64_xchg_acquire
+#endif
+
+#ifndef arch_atomic64_xchg_release
+static __always_inline s64
+arch_atomic64_xchg_release(atomic64_t *v, s64 i)
+{
+	__atomic_release_fence();
+	return arch_atomic64_xchg_relaxed(v, i);
+}
+#define arch_atomic64_xchg_release arch_atomic64_xchg_release
+#endif
+
+#ifndef arch_atomic64_xchg
+static __always_inline s64
+arch_atomic64_xchg(atomic64_t *v, s64 i)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_xchg_relaxed(v, i);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_xchg arch_atomic64_xchg
+#endif
+
+#endif /* arch_atomic64_xchg_relaxed */
+
+#ifndef arch_atomic64_cmpxchg_relaxed
+#define arch_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg
+#define arch_atomic64_cmpxchg_release arch_atomic64_cmpxchg
+#define arch_atomic64_cmpxchg_relaxed arch_atomic64_cmpxchg
+#else /* arch_atomic64_cmpxchg_relaxed */
+
+#ifndef arch_atomic64_cmpxchg_acquire
+static __always_inline s64
+arch_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
+{
+	s64 ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic64_cmpxchg_release
+static __always_inline s64
+arch_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
+{
+	__atomic_release_fence();
+	return arch_atomic64_cmpxchg_relaxed(v, old, new);
+}
+#define arch_atomic64_cmpxchg_release arch_atomic64_cmpxchg_release
+#endif
+
+#ifndef arch_atomic64_cmpxchg
+static __always_inline s64
+arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
+#endif
+
+#endif /* arch_atomic64_cmpxchg_relaxed */
+
+#ifndef arch_atomic64_try_cmpxchg_relaxed
+#ifdef arch_atomic64_try_cmpxchg
+#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg
+#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg
+#define arch_atomic64_try_cmpxchg_relaxed arch_atomic64_try_cmpxchg
+#endif /* arch_atomic64_try_cmpxchg */
+
+#ifndef arch_atomic64_try_cmpxchg
+static __always_inline bool
+arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	s64 r, o = *old;
+	r = arch_atomic64_cmpxchg(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg_acquire
+static __always_inline bool
+arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
+{
+	s64 r, o = *old;
+	r = arch_atomic64_cmpxchg_acquire(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg_release
+static __always_inline bool
+arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
+{
+	s64 r, o = *old;
+	r = arch_atomic64_cmpxchg_release(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg_release
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg_relaxed
+static __always_inline bool
+arch_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
+{
+	s64 r, o = *old;
+	r = arch_atomic64_cmpxchg_relaxed(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic64_try_cmpxchg_relaxed arch_atomic64_try_cmpxchg_relaxed
+#endif
+
+#else /* arch_atomic64_try_cmpxchg_relaxed */
+
+#ifndef arch_atomic64_try_cmpxchg_acquire
+static __always_inline bool
+arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
+{
+	bool ret = arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg_release
+static __always_inline bool
+arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
+{
+	__atomic_release_fence();
+	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+}
+#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg_release
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg
+static __always_inline bool
+arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	bool ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
+#endif
+
+#endif /* arch_atomic64_try_cmpxchg_relaxed */
+
+#ifndef arch_atomic64_sub_and_test
+/**
+ * arch_atomic64_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static __always_inline bool
+arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_sub_return(i, v) == 0;
+}
+#define arch_atomic64_sub_and_test arch_atomic64_sub_and_test
+#endif
+
+#ifndef arch_atomic64_dec_and_test
+/**
+ * arch_atomic64_dec_and_test - decrement and test
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+static __always_inline bool
+arch_atomic64_dec_and_test(atomic64_t *v)
+{
+	return arch_atomic64_dec_return(v) == 0;
+}
+#define arch_atomic64_dec_and_test arch_atomic64_dec_and_test
+#endif
+
+#ifndef arch_atomic64_inc_and_test
+/**
+ * arch_atomic64_inc_and_test - increment and test
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+static __always_inline bool
+arch_atomic64_inc_and_test(atomic64_t *v)
+{
+	return arch_atomic64_inc_return(v) == 0;
+}
+#define arch_atomic64_inc_and_test arch_atomic64_inc_and_test
+#endif
+
+#ifndef arch_atomic64_add_negative
+/**
+ * arch_atomic64_add_negative - add and test if negative
+ * @i: integer value to add
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+static __always_inline bool
+arch_atomic64_add_negative(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_add_return(i, v) < 0;
+}
+#define arch_atomic64_add_negative arch_atomic64_add_negative
+#endif
+
+#ifndef arch_atomic64_fetch_add_unless
+/**
+ * arch_atomic64_fetch_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic64_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as @v was not already @u.
+ * Returns original value of @v
+ */
+static __always_inline s64
+arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	s64 c = arch_atomic64_read(v);
+
+	do {
+		if (unlikely(c == u))
+			break;
+	} while (!arch_atomic64_try_cmpxchg(v, &c, c + a));
+
+	return c;
+}
+#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
+#endif
+
+#ifndef arch_atomic64_add_unless
+/**
+ * arch_atomic64_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic64_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, if @v was not already @u.
+ * Returns true if the addition was done.
+ */
+static __always_inline bool
+arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	return arch_atomic64_fetch_add_unless(v, a, u) != u;
+}
+#define arch_atomic64_add_unless arch_atomic64_add_unless
+#endif
+
+#ifndef arch_atomic64_inc_not_zero
+/**
+ * arch_atomic64_inc_not_zero - increment unless the number is zero
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increments @v by 1, if @v is non-zero.
+ * Returns true if the increment was done.
+ */
+static __always_inline bool
+arch_atomic64_inc_not_zero(atomic64_t *v)
+{
+	return arch_atomic64_add_unless(v, 1, 0);
+}
+#define arch_atomic64_inc_not_zero arch_atomic64_inc_not_zero
+#endif
+
+#ifndef arch_atomic64_inc_unless_negative
+static __always_inline bool
+arch_atomic64_inc_unless_negative(atomic64_t *v)
+{
+	s64 c = arch_atomic64_read(v);
+
+	do {
+		if (unlikely(c < 0))
+			return false;
+	} while (!arch_atomic64_try_cmpxchg(v, &c, c + 1));
+
+	return true;
+}
+#define arch_atomic64_inc_unless_negative arch_atomic64_inc_unless_negative
+#endif
+
+#ifndef arch_atomic64_dec_unless_positive
+static __always_inline bool
+arch_atomic64_dec_unless_positive(atomic64_t *v)
+{
+	s64 c = arch_atomic64_read(v);
+
+	do {
+		if (unlikely(c > 0))
+			return false;
+	} while (!arch_atomic64_try_cmpxchg(v, &c, c - 1));
+
+	return true;
+}
+#define arch_atomic64_dec_unless_positive arch_atomic64_dec_unless_positive
+#endif
+
+#ifndef arch_atomic64_dec_if_positive
+static __always_inline s64
+arch_atomic64_dec_if_positive(atomic64_t *v)
+{
+	s64 dec, c = arch_atomic64_read(v);
+
+	do {
+		dec = c - 1;
+		if (unlikely(dec < 0))
+			break;
+	} while (!arch_atomic64_try_cmpxchg(v, &c, dec));
+
+	return dec;
+}
+#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
+#endif
+
+#endif /* _LINUX_ATOMIC_FALLBACK_H */
+// 90cd26cfd69d2250303d654955a0cc12620fb91b
diff --git a/include/linux/atomic-fallback.h b/include/linux/atomic-fallback.h
index 656b548..2c4927b 100644
--- a/include/linux/atomic-fallback.h
+++ b/include/linux/atomic-fallback.h
@@ -1180,9 +1180,6 @@ atomic_dec_if_positive(atomic_t *v)
 #define atomic_dec_if_positive atomic_dec_if_positive
 #endif
 
-#define atomic_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
-#define atomic_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
-
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #endif
@@ -2290,8 +2287,5 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define atomic64_dec_if_positive atomic64_dec_if_positive
 #endif
 
-#define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
-#define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
-
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// baaf45f4c24ed88ceae58baca39d7fd80bb8101b
+// 1fac0941c79bf0ae100723cc2ac9b94061f0b67a
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 4c0d009..571a110 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -25,6 +25,12 @@
  * See Documentation/memory-barriers.txt for ACQUIRE/RELEASE definitions.
  */
 
+#define atomic_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
+#define atomic_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
+
+#define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
+#define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
+
 /*
  * The idea here is to build acquire/release variants by adding explicit
  * barriers on top of the relaxed variant. In the case where the relaxed
@@ -71,7 +77,12 @@
 	__ret;								\
 })
 
+#ifdef ARCH_ATOMIC
+#include <linux/atomic-arch-fallback.h>
+#include <asm-generic/atomic-instrumented.h>
+#else
 #include <linux/atomic-fallback.h>
+#endif
 
 #include <asm-generic/atomic-long.h>
 
diff --git a/scripts/atomic/fallbacks/acquire b/scripts/atomic/fallbacks/acquire
index ea489ac..59c0052 100755
--- a/scripts/atomic/fallbacks/acquire
+++ b/scripts/atomic/fallbacks/acquire
@@ -1,8 +1,8 @@
 cat <<EOF
 static __always_inline ${ret}
-${atomic}_${pfx}${name}${sfx}_acquire(${params})
+${arch}${atomic}_${pfx}${name}${sfx}_acquire(${params})
 {
-	${ret} ret = ${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+	${ret} ret = ${arch}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 	__atomic_acquire_fence();
 	return ret;
 }
diff --git a/scripts/atomic/fallbacks/add_negative b/scripts/atomic/fallbacks/add_negative
index 03cc2e0..a66635b 100755
--- a/scripts/atomic/fallbacks/add_negative
+++ b/scripts/atomic/fallbacks/add_negative
@@ -1,6 +1,6 @@
 cat <<EOF
 /**
- * ${atomic}_add_negative - add and test if negative
+ * ${arch}${atomic}_add_negative - add and test if negative
  * @i: integer value to add
  * @v: pointer of type ${atomic}_t
  *
@@ -9,8 +9,8 @@ cat <<EOF
  * result is greater than or equal to zero.
  */
 static __always_inline bool
-${atomic}_add_negative(${int} i, ${atomic}_t *v)
+${arch}${atomic}_add_negative(${int} i, ${atomic}_t *v)
 {
-	return ${atomic}_add_return(i, v) < 0;
+	return ${arch}${atomic}_add_return(i, v) < 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/add_unless b/scripts/atomic/fallbacks/add_unless
index daf87a0..2ff598a 100755
--- a/scripts/atomic/fallbacks/add_unless
+++ b/scripts/atomic/fallbacks/add_unless
@@ -1,6 +1,6 @@
 cat << EOF
 /**
- * ${atomic}_add_unless - add unless the number is already a given value
+ * ${arch}${atomic}_add_unless - add unless the number is already a given value
  * @v: pointer of type ${atomic}_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -9,8 +9,8 @@ cat << EOF
  * Returns true if the addition was done.
  */
 static __always_inline bool
-${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
+${arch}${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
-	return ${atomic}_fetch_add_unless(v, a, u) != u;
+	return ${arch}${atomic}_fetch_add_unless(v, a, u) != u;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/andnot b/scripts/atomic/fallbacks/andnot
index 14efce0..3f18663 100755
--- a/scripts/atomic/fallbacks/andnot
+++ b/scripts/atomic/fallbacks/andnot
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline ${ret}
-${atomic}_${pfx}andnot${sfx}${order}(${int} i, ${atomic}_t *v)
+${arch}${atomic}_${pfx}andnot${sfx}${order}(${int} i, ${atomic}_t *v)
 {
-	${retstmt}${atomic}_${pfx}and${sfx}${order}(~i, v);
+	${retstmt}${arch}${atomic}_${pfx}and${sfx}${order}(~i, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec b/scripts/atomic/fallbacks/dec
index 118282f..e2e01f0 100755
--- a/scripts/atomic/fallbacks/dec
+++ b/scripts/atomic/fallbacks/dec
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline ${ret}
-${atomic}_${pfx}dec${sfx}${order}(${atomic}_t *v)
+${arch}${atomic}_${pfx}dec${sfx}${order}(${atomic}_t *v)
 {
-	${retstmt}${atomic}_${pfx}sub${sfx}${order}(1, v);
+	${retstmt}${arch}${atomic}_${pfx}sub${sfx}${order}(1, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec_and_test b/scripts/atomic/fallbacks/dec_and_test
index f8967a8..e8a5e49 100755
--- a/scripts/atomic/fallbacks/dec_and_test
+++ b/scripts/atomic/fallbacks/dec_and_test
@@ -1,6 +1,6 @@
 cat <<EOF
 /**
- * ${atomic}_dec_and_test - decrement and test
+ * ${arch}${atomic}_dec_and_test - decrement and test
  * @v: pointer of type ${atomic}_t
  *
  * Atomically decrements @v by 1 and
@@ -8,8 +8,8 @@ cat <<EOF
  * cases.
  */
 static __always_inline bool
-${atomic}_dec_and_test(${atomic}_t *v)
+${arch}${atomic}_dec_and_test(${atomic}_t *v)
 {
-	return ${atomic}_dec_return(v) == 0;
+	return ${arch}${atomic}_dec_return(v) == 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec_if_positive b/scripts/atomic/fallbacks/dec_if_positive
index cfb380b..527adec 100755
--- a/scripts/atomic/fallbacks/dec_if_positive
+++ b/scripts/atomic/fallbacks/dec_if_positive
@@ -1,14 +1,14 @@
 cat <<EOF
 static __always_inline ${ret}
-${atomic}_dec_if_positive(${atomic}_t *v)
+${arch}${atomic}_dec_if_positive(${atomic}_t *v)
 {
-	${int} dec, c = ${atomic}_read(v);
+	${int} dec, c = ${arch}${atomic}_read(v);
 
 	do {
 		dec = c - 1;
 		if (unlikely(dec < 0))
 			break;
-	} while (!${atomic}_try_cmpxchg(v, &c, dec));
+	} while (!${arch}${atomic}_try_cmpxchg(v, &c, dec));
 
 	return dec;
 }
diff --git a/scripts/atomic/fallbacks/dec_unless_positive b/scripts/atomic/fallbacks/dec_unless_positive
index 69cb7aa..dcab684 100755
--- a/scripts/atomic/fallbacks/dec_unless_positive
+++ b/scripts/atomic/fallbacks/dec_unless_positive
@@ -1,13 +1,13 @@
 cat <<EOF
 static __always_inline bool
-${atomic}_dec_unless_positive(${atomic}_t *v)
+${arch}${atomic}_dec_unless_positive(${atomic}_t *v)
 {
-	${int} c = ${atomic}_read(v);
+	${int} c = ${arch}${atomic}_read(v);
 
 	do {
 		if (unlikely(c > 0))
 			return false;
-	} while (!${atomic}_try_cmpxchg(v, &c, c - 1));
+	} while (!${arch}${atomic}_try_cmpxchg(v, &c, c - 1));
 
 	return true;
 }
diff --git a/scripts/atomic/fallbacks/fence b/scripts/atomic/fallbacks/fence
index 92a3a46..3764fc8 100755
--- a/scripts/atomic/fallbacks/fence
+++ b/scripts/atomic/fallbacks/fence
@@ -1,10 +1,10 @@
 cat <<EOF
 static __always_inline ${ret}
-${atomic}_${pfx}${name}${sfx}(${params})
+${arch}${atomic}_${pfx}${name}${sfx}(${params})
 {
 	${ret} ret;
 	__atomic_pre_full_fence();
-	ret = ${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+	ret = ${arch}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 	__atomic_post_full_fence();
 	return ret;
 }
diff --git a/scripts/atomic/fallbacks/fetch_add_unless b/scripts/atomic/fallbacks/fetch_add_unless
index fffbc0d..0e0b9ae 100755
--- a/scripts/atomic/fallbacks/fetch_add_unless
+++ b/scripts/atomic/fallbacks/fetch_add_unless
@@ -1,6 +1,6 @@
 cat << EOF
 /**
- * ${atomic}_fetch_add_unless - add unless the number is already a given value
+ * ${arch}${atomic}_fetch_add_unless - add unless the number is already a given value
  * @v: pointer of type ${atomic}_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -9,14 +9,14 @@ cat << EOF
  * Returns original value of @v
  */
 static __always_inline ${int}
-${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
+${arch}${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
-	${int} c = ${atomic}_read(v);
+	${int} c = ${arch}${atomic}_read(v);
 
 	do {
 		if (unlikely(c == u))
 			break;
-	} while (!${atomic}_try_cmpxchg(v, &c, c + a));
+	} while (!${arch}${atomic}_try_cmpxchg(v, &c, c + a));
 
 	return c;
 }
diff --git a/scripts/atomic/fallbacks/inc b/scripts/atomic/fallbacks/inc
index 10751cd..15ec629 100755
--- a/scripts/atomic/fallbacks/inc
+++ b/scripts/atomic/fallbacks/inc
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline ${ret}
-${atomic}_${pfx}inc${sfx}${order}(${atomic}_t *v)
+${arch}${atomic}_${pfx}inc${sfx}${order}(${atomic}_t *v)
 {
-	${retstmt}${atomic}_${pfx}add${sfx}${order}(1, v);
+	${retstmt}${arch}${atomic}_${pfx}add${sfx}${order}(1, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_and_test b/scripts/atomic/fallbacks/inc_and_test
index 4acea9c..cecc832 100755
--- a/scripts/atomic/fallbacks/inc_and_test
+++ b/scripts/atomic/fallbacks/inc_and_test
@@ -1,6 +1,6 @@
 cat <<EOF
 /**
- * ${atomic}_inc_and_test - increment and test
+ * ${arch}${atomic}_inc_and_test - increment and test
  * @v: pointer of type ${atomic}_t
  *
  * Atomically increments @v by 1
@@ -8,8 +8,8 @@ cat <<EOF
  * other cases.
  */
 static __always_inline bool
-${atomic}_inc_and_test(${atomic}_t *v)
+${arch}${atomic}_inc_and_test(${atomic}_t *v)
 {
-	return ${atomic}_inc_return(v) == 0;
+	return ${arch}${atomic}_inc_return(v) == 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_not_zero b/scripts/atomic/fallbacks/inc_not_zero
index d9f7b97..50f2d4d 100755
--- a/scripts/atomic/fallbacks/inc_not_zero
+++ b/scripts/atomic/fallbacks/inc_not_zero
@@ -1,14 +1,14 @@
 cat <<EOF
 /**
- * ${atomic}_inc_not_zero - increment unless the number is zero
+ * ${arch}${atomic}_inc_not_zero - increment unless the number is zero
  * @v: pointer of type ${atomic}_t
  *
  * Atomically increments @v by 1, if @v is non-zero.
  * Returns true if the increment was done.
  */
 static __always_inline bool
-${atomic}_inc_not_zero(${atomic}_t *v)
+${arch}${atomic}_inc_not_zero(${atomic}_t *v)
 {
-	return ${atomic}_add_unless(v, 1, 0);
+	return ${arch}${atomic}_add_unless(v, 1, 0);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_unless_negative b/scripts/atomic/fallbacks/inc_unless_negative
index 177a7cb..87629e0 100755
--- a/scripts/atomic/fallbacks/inc_unless_negative
+++ b/scripts/atomic/fallbacks/inc_unless_negative
@@ -1,13 +1,13 @@
 cat <<EOF
 static __always_inline bool
-${atomic}_inc_unless_negative(${atomic}_t *v)
+${arch}${atomic}_inc_unless_negative(${atomic}_t *v)
 {
-	${int} c = ${atomic}_read(v);
+	${int} c = ${arch}${atomic}_read(v);
 
 	do {
 		if (unlikely(c < 0))
 			return false;
-	} while (!${atomic}_try_cmpxchg(v, &c, c + 1));
+	} while (!${arch}${atomic}_try_cmpxchg(v, &c, c + 1));
 
 	return true;
 }
diff --git a/scripts/atomic/fallbacks/read_acquire b/scripts/atomic/fallbacks/read_acquire
index 12fa83c..341a88d 100755
--- a/scripts/atomic/fallbacks/read_acquire
+++ b/scripts/atomic/fallbacks/read_acquire
@@ -1,6 +1,6 @@
 cat <<EOF
 static __always_inline ${ret}
-${atomic}_read_acquire(const ${atomic}_t *v)
+${arch}${atomic}_read_acquire(const ${atomic}_t *v)
 {
 	return smp_load_acquire(&(v)->counter);
 }
diff --git a/scripts/atomic/fallbacks/release b/scripts/atomic/fallbacks/release
index 730d2a6..f8906d5 100755
--- a/scripts/atomic/fallbacks/release
+++ b/scripts/atomic/fallbacks/release
@@ -1,8 +1,8 @@
 cat <<EOF
 static __always_inline ${ret}
-${atomic}_${pfx}${name}${sfx}_release(${params})
+${arch}${atomic}_${pfx}${name}${sfx}_release(${params})
 {
 	__atomic_release_fence();
-	${retstmt}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+	${retstmt}${arch}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 }
 EOF
diff --git a/scripts/atomic/fallbacks/set_release b/scripts/atomic/fallbacks/set_release
index e5d72c7..7606827 100755
--- a/scripts/atomic/fallbacks/set_release
+++ b/scripts/atomic/fallbacks/set_release
@@ -1,6 +1,6 @@
 cat <<EOF
 static __always_inline void
-${atomic}_set_release(${atomic}_t *v, ${int} i)
+${arch}${atomic}_set_release(${atomic}_t *v, ${int} i)
 {
 	smp_store_release(&(v)->counter, i);
 }
diff --git a/scripts/atomic/fallbacks/sub_and_test b/scripts/atomic/fallbacks/sub_and_test
index 6cfe4ed..c580f4c 100755
--- a/scripts/atomic/fallbacks/sub_and_test
+++ b/scripts/atomic/fallbacks/sub_and_test
@@ -1,6 +1,6 @@
 cat <<EOF
 /**
- * ${atomic}_sub_and_test - subtract value from variable and test result
+ * ${arch}${atomic}_sub_and_test - subtract value from variable and test result
  * @i: integer value to subtract
  * @v: pointer of type ${atomic}_t
  *
@@ -9,8 +9,8 @@ cat <<EOF
  * other cases.
  */
 static __always_inline bool
-${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
+${arch}${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
 {
-	return ${atomic}_sub_return(i, v) == 0;
+	return ${arch}${atomic}_sub_return(i, v) == 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/try_cmpxchg b/scripts/atomic/fallbacks/try_cmpxchg
index c7a2621..06db0f7 100755
--- a/scripts/atomic/fallbacks/try_cmpxchg
+++ b/scripts/atomic/fallbacks/try_cmpxchg
@@ -1,9 +1,9 @@
 cat <<EOF
 static __always_inline bool
-${atomic}_try_cmpxchg${order}(${atomic}_t *v, ${int} *old, ${int} new)
+${arch}${atomic}_try_cmpxchg${order}(${atomic}_t *v, ${int} *old, ${int} new)
 {
 	${int} r, o = *old;
-	r = ${atomic}_cmpxchg${order}(v, o, new);
+	r = ${arch}${atomic}_cmpxchg${order}(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index b6c6f5d..0fd1cf0 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -2,10 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ATOMICDIR=$(dirname $0)
+ARCH=$2
 
 . ${ATOMICDIR}/atomic-tbl.sh
 
-#gen_template_fallback(template, meta, pfx, name, sfx, order, atomic, int, args...)
+#gen_template_fallback(template, meta, pfx, name, sfx, order, arch, atomic, int, args...)
 gen_template_fallback()
 {
 	local template="$1"; shift
@@ -14,10 +15,11 @@ gen_template_fallback()
 	local name="$1"; shift
 	local sfx="$1"; shift
 	local order="$1"; shift
+	local arch="$1"; shift
 	local atomic="$1"; shift
 	local int="$1"; shift
 
-	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
+	local atomicname="${arch}${atomic}_${pfx}${name}${sfx}${order}"
 
 	local ret="$(gen_ret_type "${meta}" "${int}")"
 	local retstmt="$(gen_ret_stmt "${meta}")"
@@ -32,7 +34,7 @@ gen_template_fallback()
 	fi
 }
 
-#gen_proto_fallback(meta, pfx, name, sfx, order, atomic, int, args...)
+#gen_proto_fallback(meta, pfx, name, sfx, order, arch, atomic, int, args...)
 gen_proto_fallback()
 {
 	local meta="$1"; shift
@@ -56,16 +58,17 @@ cat << EOF
 EOF
 }
 
-#gen_proto_order_variants(meta, pfx, name, sfx, atomic, int, args...)
+#gen_proto_order_variants(meta, pfx, name, sfx, arch, atomic, int, args...)
 gen_proto_order_variants()
 {
 	local meta="$1"; shift
 	local pfx="$1"; shift
 	local name="$1"; shift
 	local sfx="$1"; shift
-	local atomic="$1"
+	local arch="$1"
+	local atomic="$2"
 
-	local basename="${atomic}_${pfx}${name}${sfx}"
+	local basename="${arch}${atomic}_${pfx}${name}${sfx}"
 
 	local template="$(find_fallback_template "${pfx}" "${name}" "${sfx}" "${order}")"
 
@@ -94,7 +97,7 @@ gen_proto_order_variants()
 	gen_basic_fallbacks "${basename}"
 
 	if [ ! -z "${template}" ]; then
-		printf "#endif /* ${atomic}_${pfx}${name}${sfx} */\n\n"
+		printf "#endif /* ${arch}${atomic}_${pfx}${name}${sfx} */\n\n"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
@@ -153,18 +156,15 @@ cat << EOF
 
 EOF
 
-for xchg in "xchg" "cmpxchg" "cmpxchg64"; do
+for xchg in "${ARCH}xchg" "${ARCH}cmpxchg" "${ARCH}cmpxchg64"; do
 	gen_xchg_fallbacks "${xchg}"
 done
 
 grep '^[a-z]' "$1" | while read name meta args; do
-	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
+	gen_proto "${meta}" "${name}" "${ARCH}" "atomic" "int" ${args}
 done
 
 cat <<EOF
-#define atomic_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
-#define atomic_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
-
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #endif
@@ -172,12 +172,9 @@ cat <<EOF
 EOF
 
 grep '^[a-z]' "$1" | while read name meta args; do
-	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
+	gen_proto "${meta}" "${name}" "${ARCH}" "atomic64" "s64" ${args}
 done
 
 cat <<EOF
-#define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
-#define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
-
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
 EOF
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
index 000dc64..d29e159 100644
--- a/scripts/atomic/gen-atomics.sh
+++ b/scripts/atomic/gen-atomics.sh
@@ -10,10 +10,11 @@ LINUXDIR=${ATOMICDIR}/../..
 cat <<EOF |
 gen-atomic-instrumented.sh      asm-generic/atomic-instrumented.h
 gen-atomic-long.sh              asm-generic/atomic-long.h
+gen-atomic-fallback.sh          linux/atomic-arch-fallback.h		arch_
 gen-atomic-fallback.sh          linux/atomic-fallback.h
 EOF
-while read script header; do
-	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} > ${LINUXDIR}/include/${header}
+while read script header args; do
+	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} ${args} > ${LINUXDIR}/include/${header}
 	HASH="$(sha1sum ${LINUXDIR}/include/${header})"
 	HASH="${HASH%% *}"
 	printf "// %s\n" "${HASH}" >> ${LINUXDIR}/include/${header}
