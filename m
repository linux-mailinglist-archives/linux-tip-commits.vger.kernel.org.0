Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763BC3D7799
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jul 2021 15:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhG0N6s (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Jul 2021 09:58:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51390 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhG0N6q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Jul 2021 09:58:46 -0400
Date:   Tue, 27 Jul 2021 13:58:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627394325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uCYUgEQIvSOQpd05d/mtEx+fvUKgCusFxBrcz+D13hQ=;
        b=ZSOHNThh1/QgDkIMa7Gc1knLc36auR5fZm11vb1w8NbUzYwTyc6En29IjahxSUZEfgQACu
        W4hzru8vfKvK2/iEj4mdA4SHBQzMLgV+9LygtXDlALkvW7kcWz/MKotGVx20lY7VNXFwf+
        HjahnvIrecUJ0kmenAjhRLLdrfQqjD9Y6GL2jGS3jXaqcgqgYAi6c+V9xTj7vtCmtOX6lE
        XBMkBm98Uz4AcrDXfhJ6GMo98H+CLfA1j4mJAq1Me2oSXFmSNTPzDyWu8UVR/NvJ4kNwqc
        2EMMX4nJD9/1/avuWiDwnnZYGjJ8aAULyTPN63DgU0O3O9y0SAeP4QgmCB4aig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627394325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uCYUgEQIvSOQpd05d/mtEx+fvUKgCusFxBrcz+D13hQ=;
        b=s436pX+B8lfB7CXm+Lm4BnggRreXqGg21ZhWcQg8YdBrkJoYp4J4OL1SNYciacocBx0piY
        rhcy/cST862TM9Bg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: add generic arch_*() bitops
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210713105253.7615-6-mark.rutland@arm.com>
References: <20210713105253.7615-6-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162739432417.395.3707177574186239363.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     cf3ee3c8c29dc349b2cf52e5e72e8cb805ff5e57
Gitweb:        https://git.kernel.org/tip/cf3ee3c8c29dc349b2cf52e5e72e8cb805ff5e57
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 13 Jul 2021 11:52:53 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jul 2021 18:46:45 +02:00

locking/atomic: add generic arch_*() bitops

Now that all architectures provide arch_atomic_long_*(), we can
implement the generic bitops atop these rather than atop
atomic_long_*(), and provide arch_*() forms of the bitops that are safe
to use in noinstr code.

Now that all architectures provide arch_atomic_long_*(), we can
build the generic arch_*() bitops atop these, which can be safely used
in noinstr code. The regular bitop wrappers are built atop these.

As the generic non-atomic bitops use plain accesses, these will be
implicitly instrumented unless they are inlined into noinstr functions
(which is similar to arch_atomic*_read() when based on READ_ONCE()).
The wrappers are modified so that where the underlying arch_*() function
uses a plain access, no explicit instrumentation is added, as this is
redundant and could result in confusing reports.

Since function prototypes get excessively long with both an `arch_`
prefix and `__always_inline` attribute, the return type and function
attributes have been split onto a separate line, matching the style of
the generated atomic headers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210713105253.7615-6-mark.rutland@arm.com
---
 include/asm-generic/bitops/atomic.h                  | 32 +++++----
 include/asm-generic/bitops/instrumented-non-atomic.h | 21 ++++--
 include/asm-generic/bitops/lock.h                    | 39 +++++-----
 include/asm-generic/bitops/non-atomic.h              | 41 +++++++----
 4 files changed, 83 insertions(+), 50 deletions(-)

diff --git a/include/asm-generic/bitops/atomic.h b/include/asm-generic/bitops/atomic.h
index 0e7316a..3096f08 100644
--- a/include/asm-generic/bitops/atomic.h
+++ b/include/asm-generic/bitops/atomic.h
@@ -11,25 +11,29 @@
  * See Documentation/atomic_bitops.txt for details.
  */
 
-static __always_inline void set_bit(unsigned int nr, volatile unsigned long *p)
+static __always_inline void
+arch_set_bit(unsigned int nr, volatile unsigned long *p)
 {
 	p += BIT_WORD(nr);
-	atomic_long_or(BIT_MASK(nr), (atomic_long_t *)p);
+	arch_atomic_long_or(BIT_MASK(nr), (atomic_long_t *)p);
 }
 
-static __always_inline void clear_bit(unsigned int nr, volatile unsigned long *p)
+static __always_inline void
+arch_clear_bit(unsigned int nr, volatile unsigned long *p)
 {
 	p += BIT_WORD(nr);
-	atomic_long_andnot(BIT_MASK(nr), (atomic_long_t *)p);
+	arch_atomic_long_andnot(BIT_MASK(nr), (atomic_long_t *)p);
 }
 
-static __always_inline void change_bit(unsigned int nr, volatile unsigned long *p)
+static __always_inline void
+arch_change_bit(unsigned int nr, volatile unsigned long *p)
 {
 	p += BIT_WORD(nr);
-	atomic_long_xor(BIT_MASK(nr), (atomic_long_t *)p);
+	arch_atomic_long_xor(BIT_MASK(nr), (atomic_long_t *)p);
 }
 
-static inline int test_and_set_bit(unsigned int nr, volatile unsigned long *p)
+static __always_inline int
+arch_test_and_set_bit(unsigned int nr, volatile unsigned long *p)
 {
 	long old;
 	unsigned long mask = BIT_MASK(nr);
@@ -38,11 +42,12 @@ static inline int test_and_set_bit(unsigned int nr, volatile unsigned long *p)
 	if (READ_ONCE(*p) & mask)
 		return 1;
 
-	old = atomic_long_fetch_or(mask, (atomic_long_t *)p);
+	old = arch_atomic_long_fetch_or(mask, (atomic_long_t *)p);
 	return !!(old & mask);
 }
 
-static inline int test_and_clear_bit(unsigned int nr, volatile unsigned long *p)
+static __always_inline int
+arch_test_and_clear_bit(unsigned int nr, volatile unsigned long *p)
 {
 	long old;
 	unsigned long mask = BIT_MASK(nr);
@@ -51,18 +56,21 @@ static inline int test_and_clear_bit(unsigned int nr, volatile unsigned long *p)
 	if (!(READ_ONCE(*p) & mask))
 		return 0;
 
-	old = atomic_long_fetch_andnot(mask, (atomic_long_t *)p);
+	old = arch_atomic_long_fetch_andnot(mask, (atomic_long_t *)p);
 	return !!(old & mask);
 }
 
-static inline int test_and_change_bit(unsigned int nr, volatile unsigned long *p)
+static __always_inline int
+arch_test_and_change_bit(unsigned int nr, volatile unsigned long *p)
 {
 	long old;
 	unsigned long mask = BIT_MASK(nr);
 
 	p += BIT_WORD(nr);
-	old = atomic_long_fetch_xor(mask, (atomic_long_t *)p);
+	old = arch_atomic_long_fetch_xor(mask, (atomic_long_t *)p);
 	return !!(old & mask);
 }
 
+#include <asm-generic/bitops/instrumented-atomic.h>
+
 #endif /* _ASM_GENERIC_BITOPS_ATOMIC_H */
diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
index 37363d5..e6c1540 100644
--- a/include/asm-generic/bitops/instrumented-non-atomic.h
+++ b/include/asm-generic/bitops/instrumented-non-atomic.h
@@ -24,7 +24,8 @@
  */
 static inline void __set_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_write(addr + BIT_WORD(nr), sizeof(long));
+	if (!__is_defined(arch___set_bit_uses_plain_access))
+		instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___set_bit(nr, addr);
 }
 
@@ -39,7 +40,8 @@ static inline void __set_bit(long nr, volatile unsigned long *addr)
  */
 static inline void __clear_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_write(addr + BIT_WORD(nr), sizeof(long));
+	if (!__is_defined(arch___clear_bit_uses_plain_access))
+		instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___clear_bit(nr, addr);
 }
 
@@ -54,7 +56,8 @@ static inline void __clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline void __change_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_write(addr + BIT_WORD(nr), sizeof(long));
+	if (!__is_defined(arch___change_bit_uses_plain_access))
+		instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___change_bit(nr, addr);
 }
 
@@ -92,7 +95,8 @@ static inline void __instrument_read_write_bitop(long nr, volatile unsigned long
  */
 static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	__instrument_read_write_bitop(nr, addr);
+	if (!__is_defined(arch___test_and_set_bit_uses_plain_access))
+		__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_set_bit(nr, addr);
 }
 
@@ -106,7 +110,8 @@ static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	__instrument_read_write_bitop(nr, addr);
+	if (!__is_defined(arch___test_and_clear_bit_uses_plain_access))
+		__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_clear_bit(nr, addr);
 }
 
@@ -120,7 +125,8 @@ static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	__instrument_read_write_bitop(nr, addr);
+	if (!__is_defined(arch___test_and_change_bit_uses_plain_access))
+		__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_change_bit(nr, addr);
 }
 
@@ -131,7 +137,8 @@ static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_bit(long nr, const volatile unsigned long *addr)
 {
-	instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
+	if (!__is_defined(arch_test_bit_uses_plain_access))
+		instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_bit(nr, addr);
 }
 
diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
index 3ae0213..630f2f6 100644
--- a/include/asm-generic/bitops/lock.h
+++ b/include/asm-generic/bitops/lock.h
@@ -7,7 +7,7 @@
 #include <asm/barrier.h>
 
 /**
- * test_and_set_bit_lock - Set a bit and return its old value, for lock
+ * arch_test_and_set_bit_lock - Set a bit and return its old value, for lock
  * @nr: Bit to set
  * @addr: Address to count from
  *
@@ -15,8 +15,8 @@
  * the returned value is 0.
  * It can be used to implement bit locks.
  */
-static inline int test_and_set_bit_lock(unsigned int nr,
-					volatile unsigned long *p)
+static __always_inline int
+arch_test_and_set_bit_lock(unsigned int nr, volatile unsigned long *p)
 {
 	long old;
 	unsigned long mask = BIT_MASK(nr);
@@ -25,26 +25,27 @@ static inline int test_and_set_bit_lock(unsigned int nr,
 	if (READ_ONCE(*p) & mask)
 		return 1;
 
-	old = atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
+	old = arch_atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
 	return !!(old & mask);
 }
 
 
 /**
- * clear_bit_unlock - Clear a bit in memory, for unlock
+ * arch_clear_bit_unlock - Clear a bit in memory, for unlock
  * @nr: the bit to set
  * @addr: the address to start counting from
  *
  * This operation is atomic and provides release barrier semantics.
  */
-static inline void clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
+static __always_inline void
+arch_clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
 {
 	p += BIT_WORD(nr);
-	atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)p);
+	arch_atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)p);
 }
 
 /**
- * __clear_bit_unlock - Clear a bit in memory, for unlock
+ * arch___clear_bit_unlock - Clear a bit in memory, for unlock
  * @nr: the bit to set
  * @addr: the address to start counting from
  *
@@ -54,38 +55,40 @@ static inline void clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
  *
  * See for example x86's implementation.
  */
-static inline void __clear_bit_unlock(unsigned int nr,
-				      volatile unsigned long *p)
+static inline void
+arch___clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
 {
 	unsigned long old;
 
 	p += BIT_WORD(nr);
 	old = READ_ONCE(*p);
 	old &= ~BIT_MASK(nr);
-	atomic_long_set_release((atomic_long_t *)p, old);
+	arch_atomic_long_set_release((atomic_long_t *)p, old);
 }
 
 /**
- * clear_bit_unlock_is_negative_byte - Clear a bit in memory and test if bottom
- *                                     byte is negative, for unlock.
+ * arch_clear_bit_unlock_is_negative_byte - Clear a bit in memory and test if bottom
+ *                                          byte is negative, for unlock.
  * @nr: the bit to clear
  * @addr: the address to start counting from
  *
  * This is a bit of a one-trick-pony for the filemap code, which clears
  * PG_locked and tests PG_waiters,
  */
-#ifndef clear_bit_unlock_is_negative_byte
-static inline bool clear_bit_unlock_is_negative_byte(unsigned int nr,
-						     volatile unsigned long *p)
+#ifndef arch_clear_bit_unlock_is_negative_byte
+static inline bool arch_clear_bit_unlock_is_negative_byte(unsigned int nr,
+							  volatile unsigned long *p)
 {
 	long old;
 	unsigned long mask = BIT_MASK(nr);
 
 	p += BIT_WORD(nr);
-	old = atomic_long_fetch_andnot_release(mask, (atomic_long_t *)p);
+	old = arch_atomic_long_fetch_andnot_release(mask, (atomic_long_t *)p);
 	return !!(old & BIT(7));
 }
-#define clear_bit_unlock_is_negative_byte clear_bit_unlock_is_negative_byte
+#define arch_clear_bit_unlock_is_negative_byte arch_clear_bit_unlock_is_negative_byte
 #endif
 
+#include <asm-generic/bitops/instrumented-lock.h>
+
 #endif /* _ASM_GENERIC_BITOPS_LOCK_H_ */
diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bitops/non-atomic.h
index 7e10c4b..c8149cd 100644
--- a/include/asm-generic/bitops/non-atomic.h
+++ b/include/asm-generic/bitops/non-atomic.h
@@ -5,7 +5,7 @@
 #include <asm/types.h>
 
 /**
- * __set_bit - Set a bit in memory
+ * arch___set_bit - Set a bit in memory
  * @nr: the bit to set
  * @addr: the address to start counting from
  *
@@ -13,24 +13,28 @@
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static inline void __set_bit(int nr, volatile unsigned long *addr)
+static __always_inline void
+arch___set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
 
 	*p  |= mask;
 }
+#define arch___set_bit_uses_plain_access
 
-static inline void __clear_bit(int nr, volatile unsigned long *addr)
+static __always_inline void
+arch___clear_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
 
 	*p &= ~mask;
 }
+#define arch___clear_bit_uses_plain_access
 
 /**
- * __change_bit - Toggle a bit in memory
+ * arch___change_bit - Toggle a bit in memory
  * @nr: the bit to change
  * @addr: the address to start counting from
  *
@@ -38,16 +42,18 @@ static inline void __clear_bit(int nr, volatile unsigned long *addr)
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static inline void __change_bit(int nr, volatile unsigned long *addr)
+static __always_inline
+void arch___change_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
 
 	*p ^= mask;
 }
+#define arch___change_bit_uses_plain_access
 
 /**
- * __test_and_set_bit - Set a bit and return its old value
+ * arch___test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
  *
@@ -55,7 +61,8 @@ static inline void __change_bit(int nr, volatile unsigned long *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
+static __always_inline int
+arch___test_and_set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -64,9 +71,10 @@ static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
 	*p = old | mask;
 	return (old & mask) != 0;
 }
+#define arch___test_and_set_bit_uses_plain_access
 
 /**
- * __test_and_clear_bit - Clear a bit and return its old value
+ * arch___test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to clear
  * @addr: Address to count from
  *
@@ -74,7 +82,8 @@ static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
+static __always_inline int
+arch___test_and_clear_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -83,10 +92,11 @@ static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
 	*p = old & ~mask;
 	return (old & mask) != 0;
 }
+#define arch___test_and_clear_bit_uses_plain_access
 
 /* WARNING: non atomic and it can be reordered! */
-static inline int __test_and_change_bit(int nr,
-					    volatile unsigned long *addr)
+static __always_inline int
+arch___test_and_change_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -95,15 +105,20 @@ static inline int __test_and_change_bit(int nr,
 	*p = old ^ mask;
 	return (old & mask) != 0;
 }
+#define arch___test_and_change_bit_uses_plain_access
 
 /**
- * test_bit - Determine whether a bit is set
+ * arch_test_bit - Determine whether a bit is set
  * @nr: bit number to test
  * @addr: Address to start counting from
  */
-static inline int test_bit(int nr, const volatile unsigned long *addr)
+static __always_inline int
+arch_test_bit(int nr, const volatile unsigned long *addr)
 {
 	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
 }
+#define arch_test_bit_uses_plain_access
+
+#include <asm-generic/bitops/instrumented-non-atomic.h>
 
 #endif /* _ASM_GENERIC_BITOPS_NON_ATOMIC_H_ */
