Return-Path: <linux-tip-commits+bounces-3729-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 642FCA49514
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 10:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689B63BC418
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 09:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C75B257453;
	Fri, 28 Feb 2025 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oVLXUnOn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ItyjmeQk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C271125335E;
	Fri, 28 Feb 2025 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734933; cv=none; b=kF8livH65YZIo3cqvaXsScyAXp8hrWpHpT8F26lr8mQX6LYD1gHnMemcJzTZ8S6agNwEuWZ1JqLuzzoROMcW2sEW9khiEZVjRKSyo0FG6gTsHDOMtD8kbqtHbFd2TKovSRH53yzYO97paqU8hnGTYrgIPHFN953W1CobTcp/lwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734933; c=relaxed/simple;
	bh=UWdEkwmQSd5RN3XbDvZInCegn9+g4c/I3N5soOTqBUI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jiDbaGVdAJWfQyLESYkzdky3qYieH8tazgYAPbFy10M1gnVYFnfsjpUJYRMvxYpl7bIedhHVLtRO/sSE0BhdO5hBswS9+GQPnh8RcZLh+7irsKrs+aivMXCJPNT8JEJaDLwV4Z57g54nqwsx27QcHkz13f4kY82k0ffFys7LD1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oVLXUnOn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ItyjmeQk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Feb 2025 09:28:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740734923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5KXKFDv51Vv6rCZ4mecvKZYZ8RbaGXYpLD2asuihIg=;
	b=oVLXUnOnq90/QxxB2giTnFOjZaYkXtLErLYR7D6HBEkKR1zghYTMkVnkGHTD3Ec/ria/uA
	YE1ZU+Wv53Rt35+AeHbFQ3rh8Gmc6vNxu/h5GKnVMBsAKsIRhnZYMVi64wqBPCa9SZo38r
	2sBTv8657Y4QHtvwutBJVCAzn6ret3YWdrwI06g9Pfk5lff4AQJ6uh+w0DXXZYKGMHw5UL
	plyHw3Dp5LuWnxClPsmZyDPkrLyc1wrB3XwYVedrYEI2Gw4eO4NcE+bFrCiH4d7lpIKbIO
	reOMZIsNAI21/ZIJZANQGnILi+txfdc7kTTh6p8RHgYVoTAZVXPNmwDjrv3TKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740734923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5KXKFDv51Vv6rCZ4mecvKZYZ8RbaGXYpLD2asuihIg=;
	b=ItyjmeQkiC/DouVEZsF/OiYkfhCv+Pz7xqcB2/jEXdttC4JaRzD/DxgVhNyJjy/DLIEwrf
	P9iwSAXznqLh7eCA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86/locking: Remove semicolon from "lock" prefix
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250228085149.2478245-1-ubizjak@gmail.com>
References: <20250228085149.2478245-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174073491910.10177.9422897371260856615.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     023f3290b02552ea006c1a2013e373750d2cbff6
Gitweb:        https://git.kernel.org/tip/023f3290b02552ea006c1a2013e373750d2cbff6
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 28 Feb 2025 09:51:15 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 28 Feb 2025 10:18:26 +01:00

x86/locking: Remove semicolon from "lock" prefix

Minimum version of binutils required to compile the kernel is 2.25.
This version correctly handles the "lock" prefix, so it is possible
to remove the semicolon, which was used to support ancient versions
of GNU as.

Due to the semicolon, the compiler considers "lock; insn" as two
separate instructions. Removing the semicolon makes asm length
calculations more accurate, consequently making scheduling and
inlining decisions of the compiler more accurate.

Removing the semicolon also enables assembler checks involving lock
prefix. Trying to assemble e.g. "lock andl %eax, %ebx" results in:

  Error: expecting lockable instruction after `lock'

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250228085149.2478245-1-ubizjak@gmail.com
---
 arch/x86/include/asm/alternative.h |  2 +-
 arch/x86/include/asm/barrier.h     |  8 ++++----
 arch/x86/include/asm/cmpxchg.h     |  4 ++--
 arch/x86/include/asm/cmpxchg_32.h  |  4 ++--
 arch/x86/include/asm/edac.h        |  2 +-
 arch/x86/include/asm/sync_bitops.h | 12 ++++++------
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index e3903b7..3b3d3aa 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -48,7 +48,7 @@
 		".popsection\n"				\
 		"671:"
 
-#define LOCK_PREFIX LOCK_PREFIX_HERE "\n\tlock; "
+#define LOCK_PREFIX LOCK_PREFIX_HERE "\n\tlock "
 
 #else /* ! CONFIG_SMP */
 #define LOCK_PREFIX_HERE ""
diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 7b44b3c..db70832 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -12,11 +12,11 @@
  */
 
 #ifdef CONFIG_X86_32
-#define mb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "mfence", \
+#define mb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "mfence", \
 				      X86_FEATURE_XMM2) ::: "memory", "cc")
-#define rmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "lfence", \
+#define rmb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "lfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
-#define wmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "sfence", \
+#define wmb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "sfence", \
 				       X86_FEATURE_XMM2) ::: "memory", "cc")
 #else
 #define __mb()	asm volatile("mfence":::"memory")
@@ -50,7 +50,7 @@
 #define __dma_rmb()	barrier()
 #define __dma_wmb()	barrier()
 
-#define __smp_mb()	asm volatile("lock; addl $0,-4(%%" _ASM_SP ")" ::: "memory", "cc")
+#define __smp_mb()	asm volatile("lock addl $0,-4(%%" _ASM_SP ")" ::: "memory", "cc")
 
 #define __smp_rmb()	dma_rmb()
 #define __smp_wmb()	barrier()
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index 5612648..fd8afc1 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -134,7 +134,7 @@ extern void __add_wrong_size(void)
 	__raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
 
 #define __sync_cmpxchg(ptr, old, new, size)				\
-	__raw_cmpxchg((ptr), (old), (new), (size), "lock; ")
+	__raw_cmpxchg((ptr), (old), (new), (size), "lock ")
 
 #define __cmpxchg_local(ptr, old, new, size)				\
 	__raw_cmpxchg((ptr), (old), (new), (size), "")
@@ -222,7 +222,7 @@ extern void __add_wrong_size(void)
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
 
 #define __sync_try_cmpxchg(ptr, pold, new, size)			\
-	__raw_try_cmpxchg((ptr), (pold), (new), (size), "lock; ")
+	__raw_try_cmpxchg((ptr), (pold), (new), (size), "lock ")
 
 #define __try_cmpxchg_local(ptr, pold, new, size)			\
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), "")
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 95b5f99..8806c64 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -105,7 +105,7 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp, 
 
 static __always_inline u64 arch_cmpxchg64(volatile u64 *ptr, u64 old, u64 new)
 {
-	return __arch_cmpxchg64_emu(ptr, old, new, LOCK_PREFIX_HERE, "lock; ");
+	return __arch_cmpxchg64_emu(ptr, old, new, LOCK_PREFIX_HERE, "lock ");
 }
 #define arch_cmpxchg64 arch_cmpxchg64
 
@@ -140,7 +140,7 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64 
 
 static __always_inline bool arch_try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64 new)
 {
-	return __arch_try_cmpxchg64_emu(ptr, oldp, new, LOCK_PREFIX_HERE, "lock; ");
+	return __arch_try_cmpxchg64_emu(ptr, oldp, new, LOCK_PREFIX_HERE, "lock ");
 }
 #define arch_try_cmpxchg64 arch_try_cmpxchg64
 
diff --git a/arch/x86/include/asm/edac.h b/arch/x86/include/asm/edac.h
index 426fc53..dfbd1eb 100644
--- a/arch/x86/include/asm/edac.h
+++ b/arch/x86/include/asm/edac.h
@@ -13,7 +13,7 @@ static inline void edac_atomic_scrub(void *va, u32 size)
 	 * are interrupt, DMA and SMP safe.
 	 */
 	for (i = 0; i < size / 4; i++, virt_addr++)
-		asm volatile("lock; addl $0, %0"::"m" (*virt_addr));
+		asm volatile("lock addl $0, %0"::"m" (*virt_addr));
 }
 
 #endif /* _ASM_X86_EDAC_H */
diff --git a/arch/x86/include/asm/sync_bitops.h b/arch/x86/include/asm/sync_bitops.h
index 6d8d6bc..cd21a04 100644
--- a/arch/x86/include/asm/sync_bitops.h
+++ b/arch/x86/include/asm/sync_bitops.h
@@ -31,7 +31,7 @@
  */
 static inline void sync_set_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("lock; " __ASM_SIZE(bts) " %1,%0"
+	asm volatile("lock " __ASM_SIZE(bts) " %1,%0"
 		     : "+m" (ADDR)
 		     : "Ir" (nr)
 		     : "memory");
@@ -49,7 +49,7 @@ static inline void sync_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline void sync_clear_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("lock; " __ASM_SIZE(btr) " %1,%0"
+	asm volatile("lock " __ASM_SIZE(btr) " %1,%0"
 		     : "+m" (ADDR)
 		     : "Ir" (nr)
 		     : "memory");
@@ -66,7 +66,7 @@ static inline void sync_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline void sync_change_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("lock; " __ASM_SIZE(btc) " %1,%0"
+	asm volatile("lock " __ASM_SIZE(btc) " %1,%0"
 		     : "+m" (ADDR)
 		     : "Ir" (nr)
 		     : "memory");
@@ -82,7 +82,7 @@ static inline void sync_change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool sync_test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	return GEN_BINARY_RMWcc("lock; " __ASM_SIZE(bts), *addr, c, "Ir", nr);
+	return GEN_BINARY_RMWcc("lock " __ASM_SIZE(bts), *addr, c, "Ir", nr);
 }
 
 /**
@@ -95,7 +95,7 @@ static inline bool sync_test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline int sync_test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	return GEN_BINARY_RMWcc("lock; " __ASM_SIZE(btr), *addr, c, "Ir", nr);
+	return GEN_BINARY_RMWcc("lock " __ASM_SIZE(btr), *addr, c, "Ir", nr);
 }
 
 /**
@@ -108,7 +108,7 @@ static inline int sync_test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline int sync_test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	return GEN_BINARY_RMWcc("lock; " __ASM_SIZE(btc), *addr, c, "Ir", nr);
+	return GEN_BINARY_RMWcc("lock " __ASM_SIZE(btc), *addr, c, "Ir", nr);
 }
 
 #define sync_test_bit(nr, addr) test_bit(nr, addr)

