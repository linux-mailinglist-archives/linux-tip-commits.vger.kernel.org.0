Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD31F3915D9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhEZL0E (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhEZL0D (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC184C061756;
        Wed, 26 May 2021 04:24:31 -0700 (PDT)
Date:   Wed, 26 May 2021 11:24:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMtCxz5TPoGAQ5vTdsG1XBQf+ggVZx2f9LKAdnuWSgA=;
        b=L4r9AdWzfgrZgEUVoElv0U6r6YZ6uO+T94dO5koJgyG/2/hEZd2iB2pxWs01Lae7DoA/G6
        n+du0nFc+VNjJYP4ZEf6xbD93cLNyvyCNM2+KdeymX2OIPbbYGorVrzWRx7hEF2bpv/EHa
        TNBGMQjUNBozo0sVj8I9j6vRQMdvJmkXwo6NkHm7HNkzHVPfotYyz1ZfsG6sYfM4IZhTdx
        1A4U025D82LYnLja8o7FNSzDDamssAkaHLc/zc2F9MitwB7Z8lkmY5stE0EVuyvxumulbs
        pOqsIdEelB8gU0lXHlfHCEBO8o/335iXaOrCGndpn1rzzqN46Ba3X1HSsMCZ8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMtCxz5TPoGAQ5vTdsG1XBQf+ggVZx2f9LKAdnuWSgA=;
        b=3rnXwUQrD9A8lcsia4DBI18yGRZhbj8XGHN2P2dIQqwfeg9tjbXrNR0GdIJlA/VmTAfOKv
        Vf4WdPhzIyplhBAQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: delete !ARCH_ATOMIC remnants
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-33-mark.rutland@arm.com>
References: <20210525140232.53872-33-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202826925.29796.10328414600305574282.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3c1885187bc1faa0a1c52f7bd34550740a208169
Gitweb:        https://git.kernel.org/tip/3c1885187bc1faa0a1c52f7bd34550740a208169
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:31 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:52 +02:00

locking/atomic: delete !ARCH_ATOMIC remnants

Now that all architectures implement ARCH_ATOMIC, we can make it
mandatory, removing the Kconfig symbol and logic for !ARCH_ATOMIC.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-33-mark.rutland@arm.com
---
 arch/Kconfig                    |    3 +-
 arch/alpha/Kconfig              |    1 +-
 arch/arc/Kconfig                |    1 +-
 arch/arm/Kconfig                |    1 +-
 arch/arm64/Kconfig              |    1 +-
 arch/csky/Kconfig               |    1 +-
 arch/h8300/Kconfig              |    1 +-
 arch/hexagon/Kconfig            |    1 +-
 arch/ia64/Kconfig               |    1 +-
 arch/m68k/Kconfig               |    1 +-
 arch/microblaze/Kconfig         |    1 +-
 arch/mips/Kconfig               |    1 +-
 arch/nds32/Kconfig              |    1 +-
 arch/nios2/Kconfig              |    1 +-
 arch/openrisc/Kconfig           |    1 +-
 arch/parisc/Kconfig             |    1 +-
 arch/powerpc/Kconfig            |    1 +-
 arch/riscv/Kconfig              |    1 +-
 arch/s390/Kconfig               |    1 +-
 arch/sh/Kconfig                 |    1 +-
 arch/sparc/Kconfig              |    1 +-
 arch/um/Kconfig                 |    1 +-
 arch/x86/Kconfig                |    1 +-
 arch/xtensa/Kconfig             |    1 +-
 include/asm-generic/atomic.h    |   44 +-
 include/asm-generic/atomic64.h  |   29 +-
 include/asm-generic/cmpxchg.h   |   21 +-
 include/linux/atomic-fallback.h | 2595 +------------------------------
 include/linux/atomic.h          |    4 +-
 scripts/atomic/check-atomics.sh |    1 +-
 scripts/atomic/gen-atomics.sh   |    1 +-
 31 files changed, 3 insertions(+), 2718 deletions(-)
 delete mode 100644 include/linux/atomic-fallback.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 3fb3b12..c45b770 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -11,9 +11,6 @@ source "arch/$(SRCARCH)/Kconfig"
 
 menu "General architecture-dependent options"
 
-config ARCH_ATOMIC
-	bool
-
 config CRASH_CORE
 	bool
 
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 7920fc2..5998106 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -2,7 +2,6 @@
 config ALPHA
 	bool
 	default y
-	select ARCH_ATOMIC
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 098ecc7..2d98501 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -6,7 +6,6 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
-	select ARCH_ATOMIC
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_PREP_COHERENT
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b7334a6..24804f1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -3,7 +3,6 @@ config ARM
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 62ab429..9f1d856 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -9,7 +9,6 @@ config ARM64
 	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_SPCR_TABLE if ACPI
 	select ACPI_PPTT if ACPI
-	select ARCH_ATOMIC
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 3521f14..8de5b98 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -2,7 +2,6 @@
 config CSKY
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index bdf05ad..3e3e0f1 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -2,7 +2,6 @@
 config H8300
         def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_BINFMT_FLAT
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 	select BINFMT_FLAT_OLD_ALWAYS_RAM
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 1368954..44a4099 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -5,7 +5,6 @@ comment "Linux Kernel Configuration for Hexagon"
 config HEXAGON
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_PREEMPT
 	# Other pending projects/to-do items.
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index c5414dc..279252e 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -8,7 +8,6 @@ menu "Processor type and features"
 
 config IA64
 	bool
-	select ARCH_ATOMIC
 	select ARCH_HAS_DMA_MARK_CLEAN
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index d1d91ac..372e4e6 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -3,7 +3,6 @@ config M68K
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 5a52922..0660f47 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -2,7 +2,6 @@
 config MICROBLAZE
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_NO_SWAP
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 55b4da9..ed51970 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3,7 +3,6 @@ config MIPS
 	bool
 	default y
 	select ARCH_32BIT_OFF_T if !64BIT
-	select ARCH_ATOMIC
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
 	select ARCH_HAS_DEBUG_VIRTUAL if !64BIT
 	select ARCH_HAS_FORTIFY_SOURCE
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 3529135..6231390 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -7,7 +7,6 @@
 config NDS32
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 67dae88..c24955c 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -2,7 +2,6 @@
 config NIOS2
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 8c50bc9..591acc5 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -7,7 +7,6 @@
 config OPENRISC
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_DMA_SET_UNCACHED
 	select ARCH_HAS_DMA_CLEAR_UNCACHED
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index bfa120a..bde9907 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -2,7 +2,6 @@
 config PARISC
 	def_bool y
 	select ARCH_32BIT_OFF_T if !64BIT
-	select ARCH_ATOMIC
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select HAVE_IDE
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d143c2b..088dd2a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -118,7 +118,6 @@ config PPC
 	# Please keep this list sorted alphabetically.
 	#
 	select ARCH_32BIT_OFF_T if PPC32
-	select ARCH_ATOMIC
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_COPY_MC			if PPC64
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c59b9f4..a8ad8eb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,7 +12,6 @@ config 32BIT
 
 config RISCV
 	def_bool y
-	select ARCH_ATOMIC
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 85374a3..b4c7c34 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -58,7 +58,6 @@ config S390
 	# Note: keep this list sorted alphabetically
 	#
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
-	select ARCH_ATOMIC
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d2925cb..6812953 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -2,7 +2,6 @@
 config SUPERH
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && MMU
 	select ARCH_ENABLE_MEMORY_HOTREMOVE if SPARSEMEM && MMU
 	select ARCH_HAVE_CUSTOM_GPIO_H
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 4679008..164a525 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -13,7 +13,6 @@ config 64BIT
 config SPARC
 	bool
 	default y
-	select ARCH_ATOMIC
 	select ARCH_MIGHT_HAVE_PC_PARPORT if SPARC64 && PCI
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select DMA_OPS
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 4370a95..57cfd9a 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -5,7 +5,6 @@ menu "UML-specific options"
 config UML
 	bool
 	default y
-	select ARCH_ATOMIC
 	select ARCH_EPHEMERAL_INODES
 	select ARCH_HAS_KCOV
 	select ARCH_NO_PREEMPT
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 11a2756..0045e1b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -58,7 +58,6 @@ config X86
 	#
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
-	select ARCH_ATOMIC
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 39bb9bd..2332b21 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -2,7 +2,6 @@
 config XTENSA
 	def_bool y
 	select ARCH_32BIT_OFF_T
-	select ARCH_ATOMIC
 	select ARCH_HAS_BINFMT_FLAT if !MMU
 	select ARCH_HAS_DMA_PREP_COHERENT if MMU
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if MMU
diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 649060f..04b8be9 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -12,14 +12,6 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
-#ifdef CONFIG_ARCH_ATOMIC
-#define __ga_cmpxchg	arch_cmpxchg
-#define __ga_xchg	arch_xchg
-#else
-#define __ga_cmpxchg	cmpxchg
-#define __ga_xchg	xchg
-#endif
-
 #ifdef CONFIG_SMP
 
 /* we can build all atomic primitives from cmpxchg */
@@ -30,7 +22,7 @@ static inline void generic_atomic_##op(int i, atomic_t *v)		\
 	int c, old;							\
 									\
 	c = v->counter;							\
-	while ((old = __ga_cmpxchg(&v->counter, c, c c_op i)) != c)	\
+	while ((old = arch_cmpxchg(&v->counter, c, c c_op i)) != c)	\
 		c = old;						\
 }
 
@@ -40,7 +32,7 @@ static inline int generic_atomic_##op##_return(int i, atomic_t *v)	\
 	int c, old;							\
 									\
 	c = v->counter;							\
-	while ((old = __ga_cmpxchg(&v->counter, c, c c_op i)) != c)	\
+	while ((old = arch_cmpxchg(&v->counter, c, c c_op i)) != c)	\
 		c = old;						\
 									\
 	return c c_op i;						\
@@ -52,7 +44,7 @@ static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
 	int c, old;							\
 									\
 	c = v->counter;							\
-	while ((old = __ga_cmpxchg(&v->counter, c, c c_op i)) != c)	\
+	while ((old = arch_cmpxchg(&v->counter, c, c c_op i)) != c)	\
 		c = old;						\
 									\
 	return c;							\
@@ -120,11 +112,6 @@ ATOMIC_OP(xor, ^)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#undef __ga_cmpxchg
-#undef __ga_xchg
-
-#ifdef CONFIG_ARCH_ATOMIC
-
 #define arch_atomic_add_return			generic_atomic_add_return
 #define arch_atomic_sub_return			generic_atomic_sub_return
 
@@ -146,29 +133,4 @@ ATOMIC_OP(xor, ^)
 #define arch_atomic_xchg(ptr, v)		(arch_xchg(&(ptr)->counter, (v)))
 #define arch_atomic_cmpxchg(v, old, new)	(arch_cmpxchg(&((v)->counter), (old), (new)))
 
-#else /* CONFIG_ARCH_ATOMIC */
-
-#define atomic_add_return		generic_atomic_add_return
-#define atomic_sub_return		generic_atomic_sub_return
-
-#define atomic_fetch_add		generic_atomic_fetch_add
-#define atomic_fetch_sub		generic_atomic_fetch_sub
-#define atomic_fetch_and		generic_atomic_fetch_and
-#define atomic_fetch_or			generic_atomic_fetch_or
-#define atomic_fetch_xor		generic_atomic_fetch_xor
-
-#define atomic_add			generic_atomic_add
-#define atomic_sub			generic_atomic_sub
-#define atomic_and			generic_atomic_and
-#define atomic_or			generic_atomic_or
-#define atomic_xor			generic_atomic_xor
-
-#define atomic_read(v)			READ_ONCE((v)->counter)
-#define atomic_set(v, i)		WRITE_ONCE(((v)->counter), (i))
-
-#define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
-#define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
-
-#endif /* CONFIG_ARCH_ATOMIC */
-
 #endif /* __ASM_GENERIC_ATOMIC_H */
diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index c8c7d9f..100d24b 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -49,8 +49,6 @@ extern s64 generic_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n);
 extern s64 generic_atomic64_xchg(atomic64_t *v, s64 new);
 extern s64 generic_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u);
 
-#ifdef CONFIG_ARCH_ATOMIC
-
 #define arch_atomic64_read		generic_atomic64_read
 #define arch_atomic64_set		generic_atomic64_set
 #define arch_atomic64_set_release	generic_atomic64_set
@@ -74,31 +72,4 @@ extern s64 generic_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u);
 #define arch_atomic64_xchg		generic_atomic64_xchg
 #define arch_atomic64_fetch_add_unless	generic_atomic64_fetch_add_unless
 
-#else /* CONFIG_ARCH_ATOMIC */
-
-#define atomic64_read			generic_atomic64_read
-#define atomic64_set			generic_atomic64_set
-#define atomic64_set_release		generic_atomic64_set
-
-#define atomic64_add			generic_atomic64_add
-#define atomic64_add_return		generic_atomic64_add_return
-#define atomic64_fetch_add		generic_atomic64_fetch_add
-#define atomic64_sub			generic_atomic64_sub
-#define atomic64_sub_return		generic_atomic64_sub_return
-#define atomic64_fetch_sub		generic_atomic64_fetch_sub
-
-#define atomic64_and			generic_atomic64_and
-#define atomic64_fetch_and		generic_atomic64_fetch_and
-#define atomic64_or			generic_atomic64_or
-#define atomic64_fetch_or		generic_atomic64_fetch_or
-#define atomic64_xor			generic_atomic64_xor
-#define atomic64_fetch_xor		generic_atomic64_fetch_xor
-
-#define atomic64_dec_if_positive	generic_atomic64_dec_if_positive
-#define atomic64_cmpxchg		generic_atomic64_cmpxchg
-#define atomic64_xchg			generic_atomic64_xchg
-#define atomic64_fetch_add_unless	generic_atomic64_fetch_add_unless
-
-#endif /* CONFIG_ARCH_ATOMIC */
-
 #endif  /*  _ASM_GENERIC_ATOMIC64_H  */
diff --git a/include/asm-generic/cmpxchg.h b/include/asm-generic/cmpxchg.h
index 98c9311..dca4419 100644
--- a/include/asm-generic/cmpxchg.h
+++ b/include/asm-generic/cmpxchg.h
@@ -97,8 +97,6 @@ unsigned long __generic_xchg(unsigned long x, volatile void *ptr, int size)
 	__generic_cmpxchg64_local((ptr), (o), (n))
 
 
-#ifdef CONFIG_ARCH_ATOMIC
-
 #ifndef arch_xchg
 #define arch_xchg		generic_xchg
 #endif
@@ -114,23 +112,4 @@ unsigned long __generic_xchg(unsigned long x, volatile void *ptr, int size)
 #define arch_cmpxchg		arch_cmpxchg_local
 #define arch_cmpxchg64		arch_cmpxchg64_local
 
-#else /* CONFIG_ARCH_ATOMIC */
-
-#ifndef xchg
-#define xchg			generic_xchg
-#endif
-
-#ifndef cmpxchg_local
-#define cmpxchg_local		generic_cmpxchg_local
-#endif
-
-#ifndef cmpxchg64_local
-#define cmpxchg64_local		generic_cmpxchg64_local
-#endif
-
-#define cmpxchg			cmpxchg_local
-#define cmpxchg64		cmpxchg64_local
-
-#endif /* CONFIG_ARCH_ATOMIC */
-
 #endif /* __ASM_GENERIC_CMPXCHG_H */
diff --git a/include/linux/atomic-fallback.h b/include/linux/atomic-fallback.h
deleted file mode 100644
index 2a3f55d..0000000
--- a/include/linux/atomic-fallback.h
+++ /dev/null
@@ -1,2595 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-// Generated by scripts/atomic/gen-atomic-fallback.sh
-// DO NOT MODIFY THIS FILE DIRECTLY
-
-#ifndef _LINUX_ATOMIC_FALLBACK_H
-#define _LINUX_ATOMIC_FALLBACK_H
-
-#include <linux/compiler.h>
-
-#ifndef xchg_relaxed
-#define xchg_acquire xchg
-#define xchg_release xchg
-#define xchg_relaxed xchg
-#else /* xchg_relaxed */
-
-#ifndef xchg_acquire
-#define xchg_acquire(...) \
-	__atomic_op_acquire(xchg, __VA_ARGS__)
-#endif
-
-#ifndef xchg_release
-#define xchg_release(...) \
-	__atomic_op_release(xchg, __VA_ARGS__)
-#endif
-
-#ifndef xchg
-#define xchg(...) \
-	__atomic_op_fence(xchg, __VA_ARGS__)
-#endif
-
-#endif /* xchg_relaxed */
-
-#ifndef cmpxchg_relaxed
-#define cmpxchg_acquire cmpxchg
-#define cmpxchg_release cmpxchg
-#define cmpxchg_relaxed cmpxchg
-#else /* cmpxchg_relaxed */
-
-#ifndef cmpxchg_acquire
-#define cmpxchg_acquire(...) \
-	__atomic_op_acquire(cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef cmpxchg_release
-#define cmpxchg_release(...) \
-	__atomic_op_release(cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef cmpxchg
-#define cmpxchg(...) \
-	__atomic_op_fence(cmpxchg, __VA_ARGS__)
-#endif
-
-#endif /* cmpxchg_relaxed */
-
-#ifndef cmpxchg64_relaxed
-#define cmpxchg64_acquire cmpxchg64
-#define cmpxchg64_release cmpxchg64
-#define cmpxchg64_relaxed cmpxchg64
-#else /* cmpxchg64_relaxed */
-
-#ifndef cmpxchg64_acquire
-#define cmpxchg64_acquire(...) \
-	__atomic_op_acquire(cmpxchg64, __VA_ARGS__)
-#endif
-
-#ifndef cmpxchg64_release
-#define cmpxchg64_release(...) \
-	__atomic_op_release(cmpxchg64, __VA_ARGS__)
-#endif
-
-#ifndef cmpxchg64
-#define cmpxchg64(...) \
-	__atomic_op_fence(cmpxchg64, __VA_ARGS__)
-#endif
-
-#endif /* cmpxchg64_relaxed */
-
-#ifndef try_cmpxchg_relaxed
-#ifdef try_cmpxchg
-#define try_cmpxchg_acquire try_cmpxchg
-#define try_cmpxchg_release try_cmpxchg
-#define try_cmpxchg_relaxed try_cmpxchg
-#endif /* try_cmpxchg */
-
-#ifndef try_cmpxchg
-#define try_cmpxchg(_ptr, _oldp, _new) \
-({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = cmpxchg((_ptr), ___o, (_new)); \
-	if (unlikely(___r != ___o)) \
-		*___op = ___r; \
-	likely(___r == ___o); \
-})
-#endif /* try_cmpxchg */
-
-#ifndef try_cmpxchg_acquire
-#define try_cmpxchg_acquire(_ptr, _oldp, _new) \
-({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = cmpxchg_acquire((_ptr), ___o, (_new)); \
-	if (unlikely(___r != ___o)) \
-		*___op = ___r; \
-	likely(___r == ___o); \
-})
-#endif /* try_cmpxchg_acquire */
-
-#ifndef try_cmpxchg_release
-#define try_cmpxchg_release(_ptr, _oldp, _new) \
-({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = cmpxchg_release((_ptr), ___o, (_new)); \
-	if (unlikely(___r != ___o)) \
-		*___op = ___r; \
-	likely(___r == ___o); \
-})
-#endif /* try_cmpxchg_release */
-
-#ifndef try_cmpxchg_relaxed
-#define try_cmpxchg_relaxed(_ptr, _oldp, _new) \
-({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = cmpxchg_relaxed((_ptr), ___o, (_new)); \
-	if (unlikely(___r != ___o)) \
-		*___op = ___r; \
-	likely(___r == ___o); \
-})
-#endif /* try_cmpxchg_relaxed */
-
-#else /* try_cmpxchg_relaxed */
-
-#ifndef try_cmpxchg_acquire
-#define try_cmpxchg_acquire(...) \
-	__atomic_op_acquire(try_cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef try_cmpxchg_release
-#define try_cmpxchg_release(...) \
-	__atomic_op_release(try_cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef try_cmpxchg
-#define try_cmpxchg(...) \
-	__atomic_op_fence(try_cmpxchg, __VA_ARGS__)
-#endif
-
-#endif /* try_cmpxchg_relaxed */
-
-#define arch_atomic_read atomic_read
-#define arch_atomic_read_acquire atomic_read_acquire
-
-#ifndef atomic_read_acquire
-static __always_inline int
-atomic_read_acquire(const atomic_t *v)
-{
-	return smp_load_acquire(&(v)->counter);
-}
-#define atomic_read_acquire atomic_read_acquire
-#endif
-
-#define arch_atomic_set atomic_set
-#define arch_atomic_set_release atomic_set_release
-
-#ifndef atomic_set_release
-static __always_inline void
-atomic_set_release(atomic_t *v, int i)
-{
-	smp_store_release(&(v)->counter, i);
-}
-#define atomic_set_release atomic_set_release
-#endif
-
-#define arch_atomic_add atomic_add
-
-#define arch_atomic_add_return atomic_add_return
-#define arch_atomic_add_return_acquire atomic_add_return_acquire
-#define arch_atomic_add_return_release atomic_add_return_release
-#define arch_atomic_add_return_relaxed atomic_add_return_relaxed
-
-#ifndef atomic_add_return_relaxed
-#define atomic_add_return_acquire atomic_add_return
-#define atomic_add_return_release atomic_add_return
-#define atomic_add_return_relaxed atomic_add_return
-#else /* atomic_add_return_relaxed */
-
-#ifndef atomic_add_return_acquire
-static __always_inline int
-atomic_add_return_acquire(int i, atomic_t *v)
-{
-	int ret = atomic_add_return_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic_add_return_acquire atomic_add_return_acquire
-#endif
-
-#ifndef atomic_add_return_release
-static __always_inline int
-atomic_add_return_release(int i, atomic_t *v)
-{
-	__atomic_release_fence();
-	return atomic_add_return_relaxed(i, v);
-}
-#define atomic_add_return_release atomic_add_return_release
-#endif
-
-#ifndef atomic_add_return
-static __always_inline int
-atomic_add_return(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = atomic_add_return_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic_add_return atomic_add_return
-#endif
-
-#endif /* atomic_add_return_relaxed */
-
-#define arch_atomic_fetch_add atomic_fetch_add
-#define arch_atomic_fetch_add_acquire atomic_fetch_add_acquire
-#define arch_atomic_fetch_add_release atomic_fetch_add_release
-#define arch_atomic_fetch_add_relaxed atomic_fetch_add_relaxed
-
-#ifndef atomic_fetch_add_relaxed
-#define atomic_fetch_add_acquire atomic_fetch_add
-#define atomic_fetch_add_release atomic_fetch_add
-#define atomic_fetch_add_relaxed atomic_fetch_add
-#else /* atomic_fetch_add_relaxed */
-
-#ifndef atomic_fetch_add_acquire
-static __always_inline int
-atomic_fetch_add_acquire(int i, atomic_t *v)
-{
-	int ret = atomic_fetch_add_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic_fetch_add_acquire atomic_fetch_add_acquire
-#endif
-
-#ifndef atomic_fetch_add_release
-static __always_inline int
-atomic_fetch_add_release(int i, atomic_t *v)
-{
-	__atomic_release_fence();
-	return atomic_fetch_add_relaxed(i, v);
-}
-#define atomic_fetch_add_release atomic_fetch_add_release
-#endif
-
-#ifndef atomic_fetch_add
-static __always_inline int
-atomic_fetch_add(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = atomic_fetch_add_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic_fetch_add atomic_fetch_add
-#endif
-
-#endif /* atomic_fetch_add_relaxed */
-
-#define arch_atomic_sub atomic_sub
-
-#define arch_atomic_sub_return atomic_sub_return
-#define arch_atomic_sub_return_acquire atomic_sub_return_acquire
-#define arch_atomic_sub_return_release atomic_sub_return_release
-#define arch_atomic_sub_return_relaxed atomic_sub_return_relaxed
-
-#ifndef atomic_sub_return_relaxed
-#define atomic_sub_return_acquire atomic_sub_return
-#define atomic_sub_return_release atomic_sub_return
-#define atomic_sub_return_relaxed atomic_sub_return
-#else /* atomic_sub_return_relaxed */
-
-#ifndef atomic_sub_return_acquire
-static __always_inline int
-atomic_sub_return_acquire(int i, atomic_t *v)
-{
-	int ret = atomic_sub_return_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic_sub_return_acquire atomic_sub_return_acquire
-#endif
-
-#ifndef atomic_sub_return_release
-static __always_inline int
-atomic_sub_return_release(int i, atomic_t *v)
-{
-	__atomic_release_fence();
-	return atomic_sub_return_relaxed(i, v);
-}
-#define atomic_sub_return_release atomic_sub_return_release
-#endif
-
-#ifndef atomic_sub_return
-static __always_inline int
-atomic_sub_return(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = atomic_sub_return_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic_sub_return atomic_sub_return
-#endif
-
-#endif /* atomic_sub_return_relaxed */
-
-#define arch_atomic_fetch_sub atomic_fetch_sub
-#define arch_atomic_fetch_sub_acquire atomic_fetch_sub_acquire
-#define arch_atomic_fetch_sub_release atomic_fetch_sub_release
-#define arch_atomic_fetch_sub_relaxed atomic_fetch_sub_relaxed
-
-#ifndef atomic_fetch_sub_relaxed
-#define atomic_fetch_sub_acquire atomic_fetch_sub
-#define atomic_fetch_sub_release atomic_fetch_sub
-#define atomic_fetch_sub_relaxed atomic_fetch_sub
-#else /* atomic_fetch_sub_relaxed */
-
-#ifndef atomic_fetch_sub_acquire
-static __always_inline int
-atomic_fetch_sub_acquire(int i, atomic_t *v)
-{
-	int ret = atomic_fetch_sub_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic_fetch_sub_acquire atomic_fetch_sub_acquire
-#endif
-
-#ifndef atomic_fetch_sub_release
-static __always_inline int
-atomic_fetch_sub_release(int i, atomic_t *v)
-{
-	__atomic_release_fence();
-	return atomic_fetch_sub_relaxed(i, v);
-}
-#define atomic_fetch_sub_release atomic_fetch_sub_release
-#endif
-
-#ifndef atomic_fetch_sub
-static __always_inline int
-atomic_fetch_sub(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = atomic_fetch_sub_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic_fetch_sub atomic_fetch_sub
-#endif
-
-#endif /* atomic_fetch_sub_relaxed */
-
-#define arch_atomic_inc atomic_inc
-
-#ifndef atomic_inc
-static __always_inline void
-atomic_inc(atomic_t *v)
-{
-	atomic_add(1, v);
-}
-#define atomic_inc atomic_inc
-#endif
-
-#define arch_atomic_inc_return atomic_inc_return
-#define arch_atomic_inc_return_acquire atomic_inc_return_acquire
-#define arch_atomic_inc_return_release atomic_inc_return_release
-#define arch_atomic_inc_return_relaxed atomic_inc_return_relaxed
-
-#ifndef atomic_inc_return_relaxed
-#ifdef atomic_inc_return
-#define atomic_inc_return_acquire atomic_inc_return
-#define atomic_inc_return_release atomic_inc_return
-#define atomic_inc_return_relaxed atomic_inc_return
-#endif /* atomic_inc_return */
-
-#ifndef atomic_inc_return
-static __always_inline int
-atomic_inc_return(atomic_t *v)
-{
-	return atomic_add_return(1, v);
-}
-#define atomic_inc_return atomic_inc_return
-#endif
-
-#ifndef atomic_inc_return_acquire
-static __always_inline int
-atomic_inc_return_acquire(atomic_t *v)
-{
-	return atomic_add_return_acquire(1, v);
-}
-#define atomic_inc_return_acquire atomic_inc_return_acquire
-#endif
-
-#ifndef atomic_inc_return_release
-static __always_inline int
-atomic_inc_return_release(atomic_t *v)
-{
-	return atomic_add_return_release(1, v);
-}
-#define atomic_inc_return_release atomic_inc_return_release
-#endif
-
-#ifndef atomic_inc_return_relaxed
-static __always_inline int
-atomic_inc_return_relaxed(atomic_t *v)
-{
-	return atomic_add_return_relaxed(1, v);
-}
-#define atomic_inc_return_relaxed atomic_inc_return_relaxed
-#endif
-
-#else /* atomic_inc_return_relaxed */
-
-#ifndef atomic_inc_return_acquire
-static __always_inline int
-atomic_inc_return_acquire(atomic_t *v)
-{
-	int ret = atomic_inc_return_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic_inc_return_acquire atomic_inc_return_acquire
-#endif
-
-#ifndef atomic_inc_return_release
-static __always_inline int
-atomic_inc_return_release(atomic_t *v)
-{
-	__atomic_release_fence();
-	return atomic_inc_return_relaxed(v);
-}
-#define atomic_inc_return_release atomic_inc_return_release
-#endif
-
-#ifndef atomic_inc_return
-static __always_inline int
-atomic_inc_return(atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = atomic_inc_return_relaxed(v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic_inc_return atomic_inc_return
-#endif
-
-#endif /* atomic_inc_return_relaxed */
-
-#define arch_atomic_fetch_inc atomic_fetch_inc
-#define arch_atomic_fetch_inc_acquire atomic_fetch_inc_acquire
-#define arch_atomic_fetch_inc_release atomic_fetch_inc_release
-#define arch_atomic_fetch_inc_relaxed atomic_fetch_inc_relaxed
-
-#ifndef atomic_fetch_inc_relaxed
-#ifdef atomic_fetch_inc
-#define atomic_fetch_inc_acquire atomic_fetch_inc
-#define atomic_fetch_inc_release atomic_fetch_inc
-#define atomic_fetch_inc_relaxed atomic_fetch_inc
-#endif /* atomic_fetch_inc */
-
-#ifndef atomic_fetch_inc
-static __always_inline int
-atomic_fetch_inc(atomic_t *v)
-{
-	return atomic_fetch_add(1, v);
-}
-#define atomic_fetch_inc atomic_fetch_inc
-#endif
-
-#ifndef atomic_fetch_inc_acquire
-static __always_inline int
-atomic_fetch_inc_acquire(atomic_t *v)
-{
-	return atomic_fetch_add_acquire(1, v);
-}
-#define atomic_fetch_inc_acquire atomic_fetch_inc_acquire
-#endif
-
-#ifndef atomic_fetch_inc_release
-static __always_inline int
-atomic_fetch_inc_release(atomic_t *v)
-{
-	return atomic_fetch_add_release(1, v);
-}
-#define atomic_fetch_inc_release atomic_fetch_inc_release
-#endif
-
-#ifndef atomic_fetch_inc_relaxed
-static __always_inline int
-atomic_fetch_inc_relaxed(atomic_t *v)
-{
-	return atomic_fetch_add_relaxed(1, v);
-}
-#define atomic_fetch_inc_relaxed atomic_fetch_inc_relaxed
-#endif
-
-#else /* atomic_fetch_inc_relaxed */
-
-#ifndef atomic_fetch_inc_acquire
-static __always_inline int
-atomic_fetch_inc_acquire(atomic_t *v)
-{
-	int ret = atomic_fetch_inc_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic_fetch_inc_acquire atomic_fetch_inc_acquire
-#endif
-
-#ifndef atomic_fetch_inc_release
-static __always_inline int
-atomic_fetch_inc_release(atomic_t *v)
-{
-	__atomic_release_fence();
-	return atomic_fetch_inc_relaxed(v);
-}
-#define atomic_fetch_inc_release atomic_fetch_inc_release
-#endif
-
-#ifndef atomic_fetch_inc
-static __always_inline int
-atomic_fetch_inc(atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = atomic_fetch_inc_relaxed(v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic_fetch_inc atomic_fetch_inc
-#endif
-
-#endif /* atomic_fetch_inc_relaxed */
-
-#define arch_atomic_dec atomic_dec
-
-#ifndef atomic_dec
-static __always_inline void
-atomic_dec(atomic_t *v)
-{
-	atomic_sub(1, v);
-}
-#define atomic_dec atomic_dec
-#endif
-
-#define arch_atomic_dec_return atomic_dec_return
-#define arch_atomic_dec_return_acquire atomic_dec_return_acquire
-#define arch_atomic_dec_return_release atomic_dec_return_release
-#define arch_atomic_dec_return_relaxed atomic_dec_return_relaxed
-
-#ifndef atomic_dec_return_relaxed
-#ifdef atomic_dec_return
-#define atomic_dec_return_acquire atomic_dec_return
-#define atomic_dec_return_release atomic_dec_return
-#define atomic_dec_return_relaxed atomic_dec_return
-#endif /* atomic_dec_return */
-
-#ifndef atomic_dec_return
-static __always_inline int
-atomic_dec_return(atomic_t *v)
-{
-	return atomic_sub_return(1, v);
-}
-#define atomic_dec_return atomic_dec_return
-#endif
-
-#ifndef atomic_dec_return_acquire
-static __always_inline int
-atomic_dec_return_acquire(atomic_t *v)
-{
-	return atomic_sub_return_acquire(1, v);
-}
-#define atomic_dec_return_acquire atomic_dec_return_acquire
-#endif
-
-#ifndef atomic_dec_return_release
-static __always_inline int
-atomic_dec_return_release(atomic_t *v)
-{
-	return atomic_sub_return_release(1, v);
-}
-#define atomic_dec_return_release atomic_dec_return_release
-#endif
-
-#ifndef atomic_dec_return_relaxed
-static __always_inline int
-atomic_dec_return_relaxed(atomic_t *v)
-{
-	return atomic_sub_return_relaxed(1, v);
-}
-#define atomic_dec_return_relaxed atomic_dec_return_relaxed
-#endif
-
-#else /* atomic_dec_return_relaxed */
-
-#ifndef atomic_dec_return_acquire
-static __always_inline int
-atomic_dec_return_acquire(atomic_t *v)
-{
-	int ret = atomic_dec_return_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic_dec_return_acquire atomic_dec_return_acquire
-#endif
-
-#ifndef atomic_dec_return_release
-static __always_inline int
-atomic_dec_return_release(atomic_t *v)
-{
-	__atomic_release_fence();
-	return atomic_dec_return_relaxed(v);
-}
-#define atomic_dec_return_release atomic_dec_return_release
-#endif
-
-#ifndef atomic_dec_return
-static __always_inline int
-atomic_dec_return(atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = atomic_dec_return_relaxed(v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic_dec_return atomic_dec_return
-#endif
-
-#endif /* atomic_dec_return_relaxed */
-
-#define arch_atomic_fetch_dec atomic_fetch_dec
-#define arch_atomic_fetch_dec_acquire atomic_fetch_dec_acquire
-#define arch_atomic_fetch_dec_release atomic_fetch_dec_release
-#define arch_atomic_fetch_dec_relaxed atomic_fetch_dec_relaxed
-
-#ifndef atomic_fetch_dec_relaxed
-#ifdef atomic_fetch_dec
-#define atomic_fetch_dec_acquire atomic_fetch_dec
-#define atomic_fetch_dec_release atomic_fetch_dec
-#define atomic_fetch_dec_relaxed atomic_fetch_dec
-#endif /* atomic_fetch_dec */
-
-#ifndef atomic_fetch_dec
-static __always_inline int
-atomic_fetch_dec(atomic_t *v)
-{
-	return atomic_fetch_sub(1, v);
-}
-#define atomic_fetch_dec atomic_fetch_dec
-#endif
-
-#ifndef atomic_fetch_dec_acquire
-static __always_inline int
-atomic_fetch_dec_acquire(atomic_t *v)
-{
-	return atomic_fetch_sub_acquire(1, v);
-}
-#define atomic_fetch_dec_acquire atomic_fetch_dec_acquire
-#endif
-
-#ifndef atomic_fetch_dec_release
-static __always_inline int
-atomic_fetch_dec_release(atomic_t *v)
-{
-	return atomic_fetch_sub_release(1, v);
-}
-#define atomic_fetch_dec_release atomic_fetch_dec_release
-#endif
-
-#ifndef atomic_fetch_dec_relaxed
-static __always_inline int
-atomic_fetch_dec_relaxed(atomic_t *v)
-{
-	return atomic_fetch_sub_relaxed(1, v);
-}
-#define atomic_fetch_dec_relaxed atomic_fetch_dec_relaxed
-#endif
-
-#else /* atomic_fetch_dec_relaxed */
-
-#ifndef atomic_fetch_dec_acquire
-static __always_inline int
-atomic_fetch_dec_acquire(atomic_t *v)
-{
-	int ret = atomic_fetch_dec_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic_fetch_dec_acquire atomic_fetch_dec_acquire
-#endif
-
-#ifndef atomic_fetch_dec_release
-static __always_inline int
-atomic_fetch_dec_release(atomic_t *v)
-{
-	__atomic_release_fence();
-	return atomic_fetch_dec_relaxed(v);
-}
-#define atomic_fetch_dec_release atomic_fetch_dec_release
-#endif
-
-#ifndef atomic_fetch_dec
-static __always_inline int
-atomic_fetch_dec(atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = atomic_fetch_dec_relaxed(v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic_fetch_dec atomic_fetch_dec
-#endif
-
-#endif /* atomic_fetch_dec_relaxed */
-
-#define arch_atomic_and atomic_and
-
-#define arch_atomic_fetch_and atomic_fetch_and
-#define arch_atomic_fetch_and_acquire atomic_fetch_and_acquire
-#define arch_atomic_fetch_and_release atomic_fetch_and_release
-#define arch_atomic_fetch_and_relaxed atomic_fetch_and_relaxed
-
-#ifndef atomic_fetch_and_relaxed
-#define atomic_fetch_and_acquire atomic_fetch_and
-#define atomic_fetch_and_release atomic_fetch_and
-#define atomic_fetch_and_relaxed atomic_fetch_and
-#else /* atomic_fetch_and_relaxed */
-
-#ifndef atomic_fetch_and_acquire
-static __always_inline int
-atomic_fetch_and_acquire(int i, atomic_t *v)
-{
-	int ret = atomic_fetch_and_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic_fetch_and_acquire atomic_fetch_and_acquire
-#endif
-
-#ifndef atomic_fetch_and_release
-static __always_inline int
-atomic_fetch_and_release(int i, atomic_t *v)
-{
-	__atomic_release_fence();
-	return atomic_fetch_and_relaxed(i, v);
-}
-#define atomic_fetch_and_release atomic_fetch_and_release
-#endif
-
-#ifndef atomic_fetch_and
-static __always_inline int
-atomic_fetch_and(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = atomic_fetch_and_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic_fetch_and atomic_fetch_and
-#endif
-
-#endif /* atomic_fetch_and_relaxed */
-
-#define arch_atomic_andnot atomic_andnot
-
-#ifndef atomic_andnot
-static __always_inline void
-atomic_andnot(int i, atomic_t *v)
-{
-	atomic_and(~i, v);
-}
-#define atomic_andnot atomic_andnot
-#endif
-
-#define arch_atomic_fetch_andnot atomic_fetch_andnot
-#define arch_atomic_fetch_andnot_acquire atomic_fetch_andnot_acquire
-#define arch_atomic_fetch_andnot_release atomic_fetch_andnot_release
-#define arch_atomic_fetch_andnot_relaxed atomic_fetch_andnot_relaxed
-
-#ifndef atomic_fetch_andnot_relaxed
-#ifdef atomic_fetch_andnot
-#define atomic_fetch_andnot_acquire atomic_fetch_andnot
-#define atomic_fetch_andnot_release atomic_fetch_andnot
-#define atomic_fetch_andnot_relaxed atomic_fetch_andnot
-#endif /* atomic_fetch_andnot */
-
-#ifndef atomic_fetch_andnot
-static __always_inline int
-atomic_fetch_andnot(int i, atomic_t *v)
-{
-	return atomic_fetch_and(~i, v);
-}
-#define atomic_fetch_andnot atomic_fetch_andnot
-#endif
-
-#ifndef atomic_fetch_andnot_acquire
-static __always_inline int
-atomic_fetch_andnot_acquire(int i, atomic_t *v)
-{
-	return atomic_fetch_and_acquire(~i, v);
-}
-#define atomic_fetch_andnot_acquire atomic_fetch_andnot_acquire
-#endif
-
-#ifndef atomic_fetch_andnot_release
-static __always_inline int
-atomic_fetch_andnot_release(int i, atomic_t *v)
-{
-	return atomic_fetch_and_release(~i, v);
-}
-#define atomic_fetch_andnot_release atomic_fetch_andnot_release
-#endif
-
-#ifndef atomic_fetch_andnot_relaxed
-static __always_inline int
-atomic_fetch_andnot_relaxed(int i, atomic_t *v)
-{
-	return atomic_fetch_and_relaxed(~i, v);
-}
-#define atomic_fetch_andnot_relaxed atomic_fetch_andnot_relaxed
-#endif
-
-#else /* atomic_fetch_andnot_relaxed */
-
-#ifndef atomic_fetch_andnot_acquire
-static __always_inline int
-atomic_fetch_andnot_acquire(int i, atomic_t *v)
-{
-	int ret = atomic_fetch_andnot_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic_fetch_andnot_acquire atomic_fetch_andnot_acquire
-#endif
-
-#ifndef atomic_fetch_andnot_release
-static __always_inline int
-atomic_fetch_andnot_release(int i, atomic_t *v)
-{
-	__atomic_release_fence();
-	return atomic_fetch_andnot_relaxed(i, v);
-}
-#define atomic_fetch_andnot_release atomic_fetch_andnot_release
-#endif
-
-#ifndef atomic_fetch_andnot
-static __always_inline int
-atomic_fetch_andnot(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = atomic_fetch_andnot_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic_fetch_andnot atomic_fetch_andnot
-#endif
-
-#endif /* atomic_fetch_andnot_relaxed */
-
-#define arch_atomic_or atomic_or
-
-#define arch_atomic_fetch_or atomic_fetch_or
-#define arch_atomic_fetch_or_acquire atomic_fetch_or_acquire
-#define arch_atomic_fetch_or_release atomic_fetch_or_release
-#define arch_atomic_fetch_or_relaxed atomic_fetch_or_relaxed
-
-#ifndef atomic_fetch_or_relaxed
-#define atomic_fetch_or_acquire atomic_fetch_or
-#define atomic_fetch_or_release atomic_fetch_or
-#define atomic_fetch_or_relaxed atomic_fetch_or
-#else /* atomic_fetch_or_relaxed */
-
-#ifndef atomic_fetch_or_acquire
-static __always_inline int
-atomic_fetch_or_acquire(int i, atomic_t *v)
-{
-	int ret = atomic_fetch_or_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic_fetch_or_acquire atomic_fetch_or_acquire
-#endif
-
-#ifndef atomic_fetch_or_release
-static __always_inline int
-atomic_fetch_or_release(int i, atomic_t *v)
-{
-	__atomic_release_fence();
-	return atomic_fetch_or_relaxed(i, v);
-}
-#define atomic_fetch_or_release atomic_fetch_or_release
-#endif
-
-#ifndef atomic_fetch_or
-static __always_inline int
-atomic_fetch_or(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = atomic_fetch_or_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic_fetch_or atomic_fetch_or
-#endif
-
-#endif /* atomic_fetch_or_relaxed */
-
-#define arch_atomic_xor atomic_xor
-
-#define arch_atomic_fetch_xor atomic_fetch_xor
-#define arch_atomic_fetch_xor_acquire atomic_fetch_xor_acquire
-#define arch_atomic_fetch_xor_release atomic_fetch_xor_release
-#define arch_atomic_fetch_xor_relaxed atomic_fetch_xor_relaxed
-
-#ifndef atomic_fetch_xor_relaxed
-#define atomic_fetch_xor_acquire atomic_fetch_xor
-#define atomic_fetch_xor_release atomic_fetch_xor
-#define atomic_fetch_xor_relaxed atomic_fetch_xor
-#else /* atomic_fetch_xor_relaxed */
-
-#ifndef atomic_fetch_xor_acquire
-static __always_inline int
-atomic_fetch_xor_acquire(int i, atomic_t *v)
-{
-	int ret = atomic_fetch_xor_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic_fetch_xor_acquire atomic_fetch_xor_acquire
-#endif
-
-#ifndef atomic_fetch_xor_release
-static __always_inline int
-atomic_fetch_xor_release(int i, atomic_t *v)
-{
-	__atomic_release_fence();
-	return atomic_fetch_xor_relaxed(i, v);
-}
-#define atomic_fetch_xor_release atomic_fetch_xor_release
-#endif
-
-#ifndef atomic_fetch_xor
-static __always_inline int
-atomic_fetch_xor(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = atomic_fetch_xor_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic_fetch_xor atomic_fetch_xor
-#endif
-
-#endif /* atomic_fetch_xor_relaxed */
-
-#define arch_atomic_xchg atomic_xchg
-#define arch_atomic_xchg_acquire atomic_xchg_acquire
-#define arch_atomic_xchg_release atomic_xchg_release
-#define arch_atomic_xchg_relaxed atomic_xchg_relaxed
-
-#ifndef atomic_xchg_relaxed
-#define atomic_xchg_acquire atomic_xchg
-#define atomic_xchg_release atomic_xchg
-#define atomic_xchg_relaxed atomic_xchg
-#else /* atomic_xchg_relaxed */
-
-#ifndef atomic_xchg_acquire
-static __always_inline int
-atomic_xchg_acquire(atomic_t *v, int i)
-{
-	int ret = atomic_xchg_relaxed(v, i);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic_xchg_acquire atomic_xchg_acquire
-#endif
-
-#ifndef atomic_xchg_release
-static __always_inline int
-atomic_xchg_release(atomic_t *v, int i)
-{
-	__atomic_release_fence();
-	return atomic_xchg_relaxed(v, i);
-}
-#define atomic_xchg_release atomic_xchg_release
-#endif
-
-#ifndef atomic_xchg
-static __always_inline int
-atomic_xchg(atomic_t *v, int i)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = atomic_xchg_relaxed(v, i);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic_xchg atomic_xchg
-#endif
-
-#endif /* atomic_xchg_relaxed */
-
-#define arch_atomic_cmpxchg atomic_cmpxchg
-#define arch_atomic_cmpxchg_acquire atomic_cmpxchg_acquire
-#define arch_atomic_cmpxchg_release atomic_cmpxchg_release
-#define arch_atomic_cmpxchg_relaxed atomic_cmpxchg_relaxed
-
-#ifndef atomic_cmpxchg_relaxed
-#define atomic_cmpxchg_acquire atomic_cmpxchg
-#define atomic_cmpxchg_release atomic_cmpxchg
-#define atomic_cmpxchg_relaxed atomic_cmpxchg
-#else /* atomic_cmpxchg_relaxed */
-
-#ifndef atomic_cmpxchg_acquire
-static __always_inline int
-atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
-{
-	int ret = atomic_cmpxchg_relaxed(v, old, new);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic_cmpxchg_acquire atomic_cmpxchg_acquire
-#endif
-
-#ifndef atomic_cmpxchg_release
-static __always_inline int
-atomic_cmpxchg_release(atomic_t *v, int old, int new)
-{
-	__atomic_release_fence();
-	return atomic_cmpxchg_relaxed(v, old, new);
-}
-#define atomic_cmpxchg_release atomic_cmpxchg_release
-#endif
-
-#ifndef atomic_cmpxchg
-static __always_inline int
-atomic_cmpxchg(atomic_t *v, int old, int new)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = atomic_cmpxchg_relaxed(v, old, new);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic_cmpxchg atomic_cmpxchg
-#endif
-
-#endif /* atomic_cmpxchg_relaxed */
-
-#define arch_atomic_try_cmpxchg atomic_try_cmpxchg
-#define arch_atomic_try_cmpxchg_acquire atomic_try_cmpxchg_acquire
-#define arch_atomic_try_cmpxchg_release atomic_try_cmpxchg_release
-#define arch_atomic_try_cmpxchg_relaxed atomic_try_cmpxchg_relaxed
-
-#ifndef atomic_try_cmpxchg_relaxed
-#ifdef atomic_try_cmpxchg
-#define atomic_try_cmpxchg_acquire atomic_try_cmpxchg
-#define atomic_try_cmpxchg_release atomic_try_cmpxchg
-#define atomic_try_cmpxchg_relaxed atomic_try_cmpxchg
-#endif /* atomic_try_cmpxchg */
-
-#ifndef atomic_try_cmpxchg
-static __always_inline bool
-atomic_try_cmpxchg(atomic_t *v, int *old, int new)
-{
-	int r, o = *old;
-	r = atomic_cmpxchg(v, o, new);
-	if (unlikely(r != o))
-		*old = r;
-	return likely(r == o);
-}
-#define atomic_try_cmpxchg atomic_try_cmpxchg
-#endif
-
-#ifndef atomic_try_cmpxchg_acquire
-static __always_inline bool
-atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
-{
-	int r, o = *old;
-	r = atomic_cmpxchg_acquire(v, o, new);
-	if (unlikely(r != o))
-		*old = r;
-	return likely(r == o);
-}
-#define atomic_try_cmpxchg_acquire atomic_try_cmpxchg_acquire
-#endif
-
-#ifndef atomic_try_cmpxchg_release
-static __always_inline bool
-atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
-{
-	int r, o = *old;
-	r = atomic_cmpxchg_release(v, o, new);
-	if (unlikely(r != o))
-		*old = r;
-	return likely(r == o);
-}
-#define atomic_try_cmpxchg_release atomic_try_cmpxchg_release
-#endif
-
-#ifndef atomic_try_cmpxchg_relaxed
-static __always_inline bool
-atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
-{
-	int r, o = *old;
-	r = atomic_cmpxchg_relaxed(v, o, new);
-	if (unlikely(r != o))
-		*old = r;
-	return likely(r == o);
-}
-#define atomic_try_cmpxchg_relaxed atomic_try_cmpxchg_relaxed
-#endif
-
-#else /* atomic_try_cmpxchg_relaxed */
-
-#ifndef atomic_try_cmpxchg_acquire
-static __always_inline bool
-atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
-{
-	bool ret = atomic_try_cmpxchg_relaxed(v, old, new);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic_try_cmpxchg_acquire atomic_try_cmpxchg_acquire
-#endif
-
-#ifndef atomic_try_cmpxchg_release
-static __always_inline bool
-atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
-{
-	__atomic_release_fence();
-	return atomic_try_cmpxchg_relaxed(v, old, new);
-}
-#define atomic_try_cmpxchg_release atomic_try_cmpxchg_release
-#endif
-
-#ifndef atomic_try_cmpxchg
-static __always_inline bool
-atomic_try_cmpxchg(atomic_t *v, int *old, int new)
-{
-	bool ret;
-	__atomic_pre_full_fence();
-	ret = atomic_try_cmpxchg_relaxed(v, old, new);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic_try_cmpxchg atomic_try_cmpxchg
-#endif
-
-#endif /* atomic_try_cmpxchg_relaxed */
-
-#define arch_atomic_sub_and_test atomic_sub_and_test
-
-#ifndef atomic_sub_and_test
-/**
- * atomic_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
-static __always_inline bool
-atomic_sub_and_test(int i, atomic_t *v)
-{
-	return atomic_sub_return(i, v) == 0;
-}
-#define atomic_sub_and_test atomic_sub_and_test
-#endif
-
-#define arch_atomic_dec_and_test atomic_dec_and_test
-
-#ifndef atomic_dec_and_test
-/**
- * atomic_dec_and_test - decrement and test
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
-static __always_inline bool
-atomic_dec_and_test(atomic_t *v)
-{
-	return atomic_dec_return(v) == 0;
-}
-#define atomic_dec_and_test atomic_dec_and_test
-#endif
-
-#define arch_atomic_inc_and_test atomic_inc_and_test
-
-#ifndef atomic_inc_and_test
-/**
- * atomic_inc_and_test - increment and test
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-static __always_inline bool
-atomic_inc_and_test(atomic_t *v)
-{
-	return atomic_inc_return(v) == 0;
-}
-#define atomic_inc_and_test atomic_inc_and_test
-#endif
-
-#define arch_atomic_add_negative atomic_add_negative
-
-#ifndef atomic_add_negative
-/**
- * atomic_add_negative - add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns true
- * if the result is negative, or false when
- * result is greater than or equal to zero.
- */
-static __always_inline bool
-atomic_add_negative(int i, atomic_t *v)
-{
-	return atomic_add_return(i, v) < 0;
-}
-#define atomic_add_negative atomic_add_negative
-#endif
-
-#define arch_atomic_fetch_add_unless atomic_fetch_add_unless
-
-#ifndef atomic_fetch_add_unless
-/**
- * atomic_fetch_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns original value of @v
- */
-static __always_inline int
-atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	int c = atomic_read(v);
-
-	do {
-		if (unlikely(c == u))
-			break;
-	} while (!atomic_try_cmpxchg(v, &c, c + a));
-
-	return c;
-}
-#define atomic_fetch_add_unless atomic_fetch_add_unless
-#endif
-
-#define arch_atomic_add_unless atomic_add_unless
-
-#ifndef atomic_add_unless
-/**
- * atomic_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, if @v was not already @u.
- * Returns true if the addition was done.
- */
-static __always_inline bool
-atomic_add_unless(atomic_t *v, int a, int u)
-{
-	return atomic_fetch_add_unless(v, a, u) != u;
-}
-#define atomic_add_unless atomic_add_unless
-#endif
-
-#define arch_atomic_inc_not_zero atomic_inc_not_zero
-
-#ifndef atomic_inc_not_zero
-/**
- * atomic_inc_not_zero - increment unless the number is zero
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1, if @v is non-zero.
- * Returns true if the increment was done.
- */
-static __always_inline bool
-atomic_inc_not_zero(atomic_t *v)
-{
-	return atomic_add_unless(v, 1, 0);
-}
-#define atomic_inc_not_zero atomic_inc_not_zero
-#endif
-
-#define arch_atomic_inc_unless_negative atomic_inc_unless_negative
-
-#ifndef atomic_inc_unless_negative
-static __always_inline bool
-atomic_inc_unless_negative(atomic_t *v)
-{
-	int c = atomic_read(v);
-
-	do {
-		if (unlikely(c < 0))
-			return false;
-	} while (!atomic_try_cmpxchg(v, &c, c + 1));
-
-	return true;
-}
-#define atomic_inc_unless_negative atomic_inc_unless_negative
-#endif
-
-#define arch_atomic_dec_unless_positive atomic_dec_unless_positive
-
-#ifndef atomic_dec_unless_positive
-static __always_inline bool
-atomic_dec_unless_positive(atomic_t *v)
-{
-	int c = atomic_read(v);
-
-	do {
-		if (unlikely(c > 0))
-			return false;
-	} while (!atomic_try_cmpxchg(v, &c, c - 1));
-
-	return true;
-}
-#define atomic_dec_unless_positive atomic_dec_unless_positive
-#endif
-
-#define arch_atomic_dec_if_positive atomic_dec_if_positive
-
-#ifndef atomic_dec_if_positive
-static __always_inline int
-atomic_dec_if_positive(atomic_t *v)
-{
-	int dec, c = atomic_read(v);
-
-	do {
-		dec = c - 1;
-		if (unlikely(dec < 0))
-			break;
-	} while (!atomic_try_cmpxchg(v, &c, dec));
-
-	return dec;
-}
-#define atomic_dec_if_positive atomic_dec_if_positive
-#endif
-
-#ifdef CONFIG_GENERIC_ATOMIC64
-#include <asm-generic/atomic64.h>
-#endif
-
-#define arch_atomic64_read atomic64_read
-#define arch_atomic64_read_acquire atomic64_read_acquire
-
-#ifndef atomic64_read_acquire
-static __always_inline s64
-atomic64_read_acquire(const atomic64_t *v)
-{
-	return smp_load_acquire(&(v)->counter);
-}
-#define atomic64_read_acquire atomic64_read_acquire
-#endif
-
-#define arch_atomic64_set atomic64_set
-#define arch_atomic64_set_release atomic64_set_release
-
-#ifndef atomic64_set_release
-static __always_inline void
-atomic64_set_release(atomic64_t *v, s64 i)
-{
-	smp_store_release(&(v)->counter, i);
-}
-#define atomic64_set_release atomic64_set_release
-#endif
-
-#define arch_atomic64_add atomic64_add
-
-#define arch_atomic64_add_return atomic64_add_return
-#define arch_atomic64_add_return_acquire atomic64_add_return_acquire
-#define arch_atomic64_add_return_release atomic64_add_return_release
-#define arch_atomic64_add_return_relaxed atomic64_add_return_relaxed
-
-#ifndef atomic64_add_return_relaxed
-#define atomic64_add_return_acquire atomic64_add_return
-#define atomic64_add_return_release atomic64_add_return
-#define atomic64_add_return_relaxed atomic64_add_return
-#else /* atomic64_add_return_relaxed */
-
-#ifndef atomic64_add_return_acquire
-static __always_inline s64
-atomic64_add_return_acquire(s64 i, atomic64_t *v)
-{
-	s64 ret = atomic64_add_return_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic64_add_return_acquire atomic64_add_return_acquire
-#endif
-
-#ifndef atomic64_add_return_release
-static __always_inline s64
-atomic64_add_return_release(s64 i, atomic64_t *v)
-{
-	__atomic_release_fence();
-	return atomic64_add_return_relaxed(i, v);
-}
-#define atomic64_add_return_release atomic64_add_return_release
-#endif
-
-#ifndef atomic64_add_return
-static __always_inline s64
-atomic64_add_return(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = atomic64_add_return_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic64_add_return atomic64_add_return
-#endif
-
-#endif /* atomic64_add_return_relaxed */
-
-#define arch_atomic64_fetch_add atomic64_fetch_add
-#define arch_atomic64_fetch_add_acquire atomic64_fetch_add_acquire
-#define arch_atomic64_fetch_add_release atomic64_fetch_add_release
-#define arch_atomic64_fetch_add_relaxed atomic64_fetch_add_relaxed
-
-#ifndef atomic64_fetch_add_relaxed
-#define atomic64_fetch_add_acquire atomic64_fetch_add
-#define atomic64_fetch_add_release atomic64_fetch_add
-#define atomic64_fetch_add_relaxed atomic64_fetch_add
-#else /* atomic64_fetch_add_relaxed */
-
-#ifndef atomic64_fetch_add_acquire
-static __always_inline s64
-atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
-{
-	s64 ret = atomic64_fetch_add_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic64_fetch_add_acquire atomic64_fetch_add_acquire
-#endif
-
-#ifndef atomic64_fetch_add_release
-static __always_inline s64
-atomic64_fetch_add_release(s64 i, atomic64_t *v)
-{
-	__atomic_release_fence();
-	return atomic64_fetch_add_relaxed(i, v);
-}
-#define atomic64_fetch_add_release atomic64_fetch_add_release
-#endif
-
-#ifndef atomic64_fetch_add
-static __always_inline s64
-atomic64_fetch_add(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = atomic64_fetch_add_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic64_fetch_add atomic64_fetch_add
-#endif
-
-#endif /* atomic64_fetch_add_relaxed */
-
-#define arch_atomic64_sub atomic64_sub
-
-#define arch_atomic64_sub_return atomic64_sub_return
-#define arch_atomic64_sub_return_acquire atomic64_sub_return_acquire
-#define arch_atomic64_sub_return_release atomic64_sub_return_release
-#define arch_atomic64_sub_return_relaxed atomic64_sub_return_relaxed
-
-#ifndef atomic64_sub_return_relaxed
-#define atomic64_sub_return_acquire atomic64_sub_return
-#define atomic64_sub_return_release atomic64_sub_return
-#define atomic64_sub_return_relaxed atomic64_sub_return
-#else /* atomic64_sub_return_relaxed */
-
-#ifndef atomic64_sub_return_acquire
-static __always_inline s64
-atomic64_sub_return_acquire(s64 i, atomic64_t *v)
-{
-	s64 ret = atomic64_sub_return_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic64_sub_return_acquire atomic64_sub_return_acquire
-#endif
-
-#ifndef atomic64_sub_return_release
-static __always_inline s64
-atomic64_sub_return_release(s64 i, atomic64_t *v)
-{
-	__atomic_release_fence();
-	return atomic64_sub_return_relaxed(i, v);
-}
-#define atomic64_sub_return_release atomic64_sub_return_release
-#endif
-
-#ifndef atomic64_sub_return
-static __always_inline s64
-atomic64_sub_return(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = atomic64_sub_return_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic64_sub_return atomic64_sub_return
-#endif
-
-#endif /* atomic64_sub_return_relaxed */
-
-#define arch_atomic64_fetch_sub atomic64_fetch_sub
-#define arch_atomic64_fetch_sub_acquire atomic64_fetch_sub_acquire
-#define arch_atomic64_fetch_sub_release atomic64_fetch_sub_release
-#define arch_atomic64_fetch_sub_relaxed atomic64_fetch_sub_relaxed
-
-#ifndef atomic64_fetch_sub_relaxed
-#define atomic64_fetch_sub_acquire atomic64_fetch_sub
-#define atomic64_fetch_sub_release atomic64_fetch_sub
-#define atomic64_fetch_sub_relaxed atomic64_fetch_sub
-#else /* atomic64_fetch_sub_relaxed */
-
-#ifndef atomic64_fetch_sub_acquire
-static __always_inline s64
-atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
-{
-	s64 ret = atomic64_fetch_sub_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic64_fetch_sub_acquire atomic64_fetch_sub_acquire
-#endif
-
-#ifndef atomic64_fetch_sub_release
-static __always_inline s64
-atomic64_fetch_sub_release(s64 i, atomic64_t *v)
-{
-	__atomic_release_fence();
-	return atomic64_fetch_sub_relaxed(i, v);
-}
-#define atomic64_fetch_sub_release atomic64_fetch_sub_release
-#endif
-
-#ifndef atomic64_fetch_sub
-static __always_inline s64
-atomic64_fetch_sub(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = atomic64_fetch_sub_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic64_fetch_sub atomic64_fetch_sub
-#endif
-
-#endif /* atomic64_fetch_sub_relaxed */
-
-#define arch_atomic64_inc atomic64_inc
-
-#ifndef atomic64_inc
-static __always_inline void
-atomic64_inc(atomic64_t *v)
-{
-	atomic64_add(1, v);
-}
-#define atomic64_inc atomic64_inc
-#endif
-
-#define arch_atomic64_inc_return atomic64_inc_return
-#define arch_atomic64_inc_return_acquire atomic64_inc_return_acquire
-#define arch_atomic64_inc_return_release atomic64_inc_return_release
-#define arch_atomic64_inc_return_relaxed atomic64_inc_return_relaxed
-
-#ifndef atomic64_inc_return_relaxed
-#ifdef atomic64_inc_return
-#define atomic64_inc_return_acquire atomic64_inc_return
-#define atomic64_inc_return_release atomic64_inc_return
-#define atomic64_inc_return_relaxed atomic64_inc_return
-#endif /* atomic64_inc_return */
-
-#ifndef atomic64_inc_return
-static __always_inline s64
-atomic64_inc_return(atomic64_t *v)
-{
-	return atomic64_add_return(1, v);
-}
-#define atomic64_inc_return atomic64_inc_return
-#endif
-
-#ifndef atomic64_inc_return_acquire
-static __always_inline s64
-atomic64_inc_return_acquire(atomic64_t *v)
-{
-	return atomic64_add_return_acquire(1, v);
-}
-#define atomic64_inc_return_acquire atomic64_inc_return_acquire
-#endif
-
-#ifndef atomic64_inc_return_release
-static __always_inline s64
-atomic64_inc_return_release(atomic64_t *v)
-{
-	return atomic64_add_return_release(1, v);
-}
-#define atomic64_inc_return_release atomic64_inc_return_release
-#endif
-
-#ifndef atomic64_inc_return_relaxed
-static __always_inline s64
-atomic64_inc_return_relaxed(atomic64_t *v)
-{
-	return atomic64_add_return_relaxed(1, v);
-}
-#define atomic64_inc_return_relaxed atomic64_inc_return_relaxed
-#endif
-
-#else /* atomic64_inc_return_relaxed */
-
-#ifndef atomic64_inc_return_acquire
-static __always_inline s64
-atomic64_inc_return_acquire(atomic64_t *v)
-{
-	s64 ret = atomic64_inc_return_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic64_inc_return_acquire atomic64_inc_return_acquire
-#endif
-
-#ifndef atomic64_inc_return_release
-static __always_inline s64
-atomic64_inc_return_release(atomic64_t *v)
-{
-	__atomic_release_fence();
-	return atomic64_inc_return_relaxed(v);
-}
-#define atomic64_inc_return_release atomic64_inc_return_release
-#endif
-
-#ifndef atomic64_inc_return
-static __always_inline s64
-atomic64_inc_return(atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = atomic64_inc_return_relaxed(v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic64_inc_return atomic64_inc_return
-#endif
-
-#endif /* atomic64_inc_return_relaxed */
-
-#define arch_atomic64_fetch_inc atomic64_fetch_inc
-#define arch_atomic64_fetch_inc_acquire atomic64_fetch_inc_acquire
-#define arch_atomic64_fetch_inc_release atomic64_fetch_inc_release
-#define arch_atomic64_fetch_inc_relaxed atomic64_fetch_inc_relaxed
-
-#ifndef atomic64_fetch_inc_relaxed
-#ifdef atomic64_fetch_inc
-#define atomic64_fetch_inc_acquire atomic64_fetch_inc
-#define atomic64_fetch_inc_release atomic64_fetch_inc
-#define atomic64_fetch_inc_relaxed atomic64_fetch_inc
-#endif /* atomic64_fetch_inc */
-
-#ifndef atomic64_fetch_inc
-static __always_inline s64
-atomic64_fetch_inc(atomic64_t *v)
-{
-	return atomic64_fetch_add(1, v);
-}
-#define atomic64_fetch_inc atomic64_fetch_inc
-#endif
-
-#ifndef atomic64_fetch_inc_acquire
-static __always_inline s64
-atomic64_fetch_inc_acquire(atomic64_t *v)
-{
-	return atomic64_fetch_add_acquire(1, v);
-}
-#define atomic64_fetch_inc_acquire atomic64_fetch_inc_acquire
-#endif
-
-#ifndef atomic64_fetch_inc_release
-static __always_inline s64
-atomic64_fetch_inc_release(atomic64_t *v)
-{
-	return atomic64_fetch_add_release(1, v);
-}
-#define atomic64_fetch_inc_release atomic64_fetch_inc_release
-#endif
-
-#ifndef atomic64_fetch_inc_relaxed
-static __always_inline s64
-atomic64_fetch_inc_relaxed(atomic64_t *v)
-{
-	return atomic64_fetch_add_relaxed(1, v);
-}
-#define atomic64_fetch_inc_relaxed atomic64_fetch_inc_relaxed
-#endif
-
-#else /* atomic64_fetch_inc_relaxed */
-
-#ifndef atomic64_fetch_inc_acquire
-static __always_inline s64
-atomic64_fetch_inc_acquire(atomic64_t *v)
-{
-	s64 ret = atomic64_fetch_inc_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic64_fetch_inc_acquire atomic64_fetch_inc_acquire
-#endif
-
-#ifndef atomic64_fetch_inc_release
-static __always_inline s64
-atomic64_fetch_inc_release(atomic64_t *v)
-{
-	__atomic_release_fence();
-	return atomic64_fetch_inc_relaxed(v);
-}
-#define atomic64_fetch_inc_release atomic64_fetch_inc_release
-#endif
-
-#ifndef atomic64_fetch_inc
-static __always_inline s64
-atomic64_fetch_inc(atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = atomic64_fetch_inc_relaxed(v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic64_fetch_inc atomic64_fetch_inc
-#endif
-
-#endif /* atomic64_fetch_inc_relaxed */
-
-#define arch_atomic64_dec atomic64_dec
-
-#ifndef atomic64_dec
-static __always_inline void
-atomic64_dec(atomic64_t *v)
-{
-	atomic64_sub(1, v);
-}
-#define atomic64_dec atomic64_dec
-#endif
-
-#define arch_atomic64_dec_return atomic64_dec_return
-#define arch_atomic64_dec_return_acquire atomic64_dec_return_acquire
-#define arch_atomic64_dec_return_release atomic64_dec_return_release
-#define arch_atomic64_dec_return_relaxed atomic64_dec_return_relaxed
-
-#ifndef atomic64_dec_return_relaxed
-#ifdef atomic64_dec_return
-#define atomic64_dec_return_acquire atomic64_dec_return
-#define atomic64_dec_return_release atomic64_dec_return
-#define atomic64_dec_return_relaxed atomic64_dec_return
-#endif /* atomic64_dec_return */
-
-#ifndef atomic64_dec_return
-static __always_inline s64
-atomic64_dec_return(atomic64_t *v)
-{
-	return atomic64_sub_return(1, v);
-}
-#define atomic64_dec_return atomic64_dec_return
-#endif
-
-#ifndef atomic64_dec_return_acquire
-static __always_inline s64
-atomic64_dec_return_acquire(atomic64_t *v)
-{
-	return atomic64_sub_return_acquire(1, v);
-}
-#define atomic64_dec_return_acquire atomic64_dec_return_acquire
-#endif
-
-#ifndef atomic64_dec_return_release
-static __always_inline s64
-atomic64_dec_return_release(atomic64_t *v)
-{
-	return atomic64_sub_return_release(1, v);
-}
-#define atomic64_dec_return_release atomic64_dec_return_release
-#endif
-
-#ifndef atomic64_dec_return_relaxed
-static __always_inline s64
-atomic64_dec_return_relaxed(atomic64_t *v)
-{
-	return atomic64_sub_return_relaxed(1, v);
-}
-#define atomic64_dec_return_relaxed atomic64_dec_return_relaxed
-#endif
-
-#else /* atomic64_dec_return_relaxed */
-
-#ifndef atomic64_dec_return_acquire
-static __always_inline s64
-atomic64_dec_return_acquire(atomic64_t *v)
-{
-	s64 ret = atomic64_dec_return_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic64_dec_return_acquire atomic64_dec_return_acquire
-#endif
-
-#ifndef atomic64_dec_return_release
-static __always_inline s64
-atomic64_dec_return_release(atomic64_t *v)
-{
-	__atomic_release_fence();
-	return atomic64_dec_return_relaxed(v);
-}
-#define atomic64_dec_return_release atomic64_dec_return_release
-#endif
-
-#ifndef atomic64_dec_return
-static __always_inline s64
-atomic64_dec_return(atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = atomic64_dec_return_relaxed(v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic64_dec_return atomic64_dec_return
-#endif
-
-#endif /* atomic64_dec_return_relaxed */
-
-#define arch_atomic64_fetch_dec atomic64_fetch_dec
-#define arch_atomic64_fetch_dec_acquire atomic64_fetch_dec_acquire
-#define arch_atomic64_fetch_dec_release atomic64_fetch_dec_release
-#define arch_atomic64_fetch_dec_relaxed atomic64_fetch_dec_relaxed
-
-#ifndef atomic64_fetch_dec_relaxed
-#ifdef atomic64_fetch_dec
-#define atomic64_fetch_dec_acquire atomic64_fetch_dec
-#define atomic64_fetch_dec_release atomic64_fetch_dec
-#define atomic64_fetch_dec_relaxed atomic64_fetch_dec
-#endif /* atomic64_fetch_dec */
-
-#ifndef atomic64_fetch_dec
-static __always_inline s64
-atomic64_fetch_dec(atomic64_t *v)
-{
-	return atomic64_fetch_sub(1, v);
-}
-#define atomic64_fetch_dec atomic64_fetch_dec
-#endif
-
-#ifndef atomic64_fetch_dec_acquire
-static __always_inline s64
-atomic64_fetch_dec_acquire(atomic64_t *v)
-{
-	return atomic64_fetch_sub_acquire(1, v);
-}
-#define atomic64_fetch_dec_acquire atomic64_fetch_dec_acquire
-#endif
-
-#ifndef atomic64_fetch_dec_release
-static __always_inline s64
-atomic64_fetch_dec_release(atomic64_t *v)
-{
-	return atomic64_fetch_sub_release(1, v);
-}
-#define atomic64_fetch_dec_release atomic64_fetch_dec_release
-#endif
-
-#ifndef atomic64_fetch_dec_relaxed
-static __always_inline s64
-atomic64_fetch_dec_relaxed(atomic64_t *v)
-{
-	return atomic64_fetch_sub_relaxed(1, v);
-}
-#define atomic64_fetch_dec_relaxed atomic64_fetch_dec_relaxed
-#endif
-
-#else /* atomic64_fetch_dec_relaxed */
-
-#ifndef atomic64_fetch_dec_acquire
-static __always_inline s64
-atomic64_fetch_dec_acquire(atomic64_t *v)
-{
-	s64 ret = atomic64_fetch_dec_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic64_fetch_dec_acquire atomic64_fetch_dec_acquire
-#endif
-
-#ifndef atomic64_fetch_dec_release
-static __always_inline s64
-atomic64_fetch_dec_release(atomic64_t *v)
-{
-	__atomic_release_fence();
-	return atomic64_fetch_dec_relaxed(v);
-}
-#define atomic64_fetch_dec_release atomic64_fetch_dec_release
-#endif
-
-#ifndef atomic64_fetch_dec
-static __always_inline s64
-atomic64_fetch_dec(atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = atomic64_fetch_dec_relaxed(v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic64_fetch_dec atomic64_fetch_dec
-#endif
-
-#endif /* atomic64_fetch_dec_relaxed */
-
-#define arch_atomic64_and atomic64_and
-
-#define arch_atomic64_fetch_and atomic64_fetch_and
-#define arch_atomic64_fetch_and_acquire atomic64_fetch_and_acquire
-#define arch_atomic64_fetch_and_release atomic64_fetch_and_release
-#define arch_atomic64_fetch_and_relaxed atomic64_fetch_and_relaxed
-
-#ifndef atomic64_fetch_and_relaxed
-#define atomic64_fetch_and_acquire atomic64_fetch_and
-#define atomic64_fetch_and_release atomic64_fetch_and
-#define atomic64_fetch_and_relaxed atomic64_fetch_and
-#else /* atomic64_fetch_and_relaxed */
-
-#ifndef atomic64_fetch_and_acquire
-static __always_inline s64
-atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
-{
-	s64 ret = atomic64_fetch_and_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic64_fetch_and_acquire atomic64_fetch_and_acquire
-#endif
-
-#ifndef atomic64_fetch_and_release
-static __always_inline s64
-atomic64_fetch_and_release(s64 i, atomic64_t *v)
-{
-	__atomic_release_fence();
-	return atomic64_fetch_and_relaxed(i, v);
-}
-#define atomic64_fetch_and_release atomic64_fetch_and_release
-#endif
-
-#ifndef atomic64_fetch_and
-static __always_inline s64
-atomic64_fetch_and(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = atomic64_fetch_and_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic64_fetch_and atomic64_fetch_and
-#endif
-
-#endif /* atomic64_fetch_and_relaxed */
-
-#define arch_atomic64_andnot atomic64_andnot
-
-#ifndef atomic64_andnot
-static __always_inline void
-atomic64_andnot(s64 i, atomic64_t *v)
-{
-	atomic64_and(~i, v);
-}
-#define atomic64_andnot atomic64_andnot
-#endif
-
-#define arch_atomic64_fetch_andnot atomic64_fetch_andnot
-#define arch_atomic64_fetch_andnot_acquire atomic64_fetch_andnot_acquire
-#define arch_atomic64_fetch_andnot_release atomic64_fetch_andnot_release
-#define arch_atomic64_fetch_andnot_relaxed atomic64_fetch_andnot_relaxed
-
-#ifndef atomic64_fetch_andnot_relaxed
-#ifdef atomic64_fetch_andnot
-#define atomic64_fetch_andnot_acquire atomic64_fetch_andnot
-#define atomic64_fetch_andnot_release atomic64_fetch_andnot
-#define atomic64_fetch_andnot_relaxed atomic64_fetch_andnot
-#endif /* atomic64_fetch_andnot */
-
-#ifndef atomic64_fetch_andnot
-static __always_inline s64
-atomic64_fetch_andnot(s64 i, atomic64_t *v)
-{
-	return atomic64_fetch_and(~i, v);
-}
-#define atomic64_fetch_andnot atomic64_fetch_andnot
-#endif
-
-#ifndef atomic64_fetch_andnot_acquire
-static __always_inline s64
-atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
-{
-	return atomic64_fetch_and_acquire(~i, v);
-}
-#define atomic64_fetch_andnot_acquire atomic64_fetch_andnot_acquire
-#endif
-
-#ifndef atomic64_fetch_andnot_release
-static __always_inline s64
-atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
-{
-	return atomic64_fetch_and_release(~i, v);
-}
-#define atomic64_fetch_andnot_release atomic64_fetch_andnot_release
-#endif
-
-#ifndef atomic64_fetch_andnot_relaxed
-static __always_inline s64
-atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
-{
-	return atomic64_fetch_and_relaxed(~i, v);
-}
-#define atomic64_fetch_andnot_relaxed atomic64_fetch_andnot_relaxed
-#endif
-
-#else /* atomic64_fetch_andnot_relaxed */
-
-#ifndef atomic64_fetch_andnot_acquire
-static __always_inline s64
-atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
-{
-	s64 ret = atomic64_fetch_andnot_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic64_fetch_andnot_acquire atomic64_fetch_andnot_acquire
-#endif
-
-#ifndef atomic64_fetch_andnot_release
-static __always_inline s64
-atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
-{
-	__atomic_release_fence();
-	return atomic64_fetch_andnot_relaxed(i, v);
-}
-#define atomic64_fetch_andnot_release atomic64_fetch_andnot_release
-#endif
-
-#ifndef atomic64_fetch_andnot
-static __always_inline s64
-atomic64_fetch_andnot(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = atomic64_fetch_andnot_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic64_fetch_andnot atomic64_fetch_andnot
-#endif
-
-#endif /* atomic64_fetch_andnot_relaxed */
-
-#define arch_atomic64_or atomic64_or
-
-#define arch_atomic64_fetch_or atomic64_fetch_or
-#define arch_atomic64_fetch_or_acquire atomic64_fetch_or_acquire
-#define arch_atomic64_fetch_or_release atomic64_fetch_or_release
-#define arch_atomic64_fetch_or_relaxed atomic64_fetch_or_relaxed
-
-#ifndef atomic64_fetch_or_relaxed
-#define atomic64_fetch_or_acquire atomic64_fetch_or
-#define atomic64_fetch_or_release atomic64_fetch_or
-#define atomic64_fetch_or_relaxed atomic64_fetch_or
-#else /* atomic64_fetch_or_relaxed */
-
-#ifndef atomic64_fetch_or_acquire
-static __always_inline s64
-atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
-{
-	s64 ret = atomic64_fetch_or_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic64_fetch_or_acquire atomic64_fetch_or_acquire
-#endif
-
-#ifndef atomic64_fetch_or_release
-static __always_inline s64
-atomic64_fetch_or_release(s64 i, atomic64_t *v)
-{
-	__atomic_release_fence();
-	return atomic64_fetch_or_relaxed(i, v);
-}
-#define atomic64_fetch_or_release atomic64_fetch_or_release
-#endif
-
-#ifndef atomic64_fetch_or
-static __always_inline s64
-atomic64_fetch_or(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = atomic64_fetch_or_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic64_fetch_or atomic64_fetch_or
-#endif
-
-#endif /* atomic64_fetch_or_relaxed */
-
-#define arch_atomic64_xor atomic64_xor
-
-#define arch_atomic64_fetch_xor atomic64_fetch_xor
-#define arch_atomic64_fetch_xor_acquire atomic64_fetch_xor_acquire
-#define arch_atomic64_fetch_xor_release atomic64_fetch_xor_release
-#define arch_atomic64_fetch_xor_relaxed atomic64_fetch_xor_relaxed
-
-#ifndef atomic64_fetch_xor_relaxed
-#define atomic64_fetch_xor_acquire atomic64_fetch_xor
-#define atomic64_fetch_xor_release atomic64_fetch_xor
-#define atomic64_fetch_xor_relaxed atomic64_fetch_xor
-#else /* atomic64_fetch_xor_relaxed */
-
-#ifndef atomic64_fetch_xor_acquire
-static __always_inline s64
-atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
-{
-	s64 ret = atomic64_fetch_xor_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic64_fetch_xor_acquire atomic64_fetch_xor_acquire
-#endif
-
-#ifndef atomic64_fetch_xor_release
-static __always_inline s64
-atomic64_fetch_xor_release(s64 i, atomic64_t *v)
-{
-	__atomic_release_fence();
-	return atomic64_fetch_xor_relaxed(i, v);
-}
-#define atomic64_fetch_xor_release atomic64_fetch_xor_release
-#endif
-
-#ifndef atomic64_fetch_xor
-static __always_inline s64
-atomic64_fetch_xor(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = atomic64_fetch_xor_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic64_fetch_xor atomic64_fetch_xor
-#endif
-
-#endif /* atomic64_fetch_xor_relaxed */
-
-#define arch_atomic64_xchg atomic64_xchg
-#define arch_atomic64_xchg_acquire atomic64_xchg_acquire
-#define arch_atomic64_xchg_release atomic64_xchg_release
-#define arch_atomic64_xchg_relaxed atomic64_xchg_relaxed
-
-#ifndef atomic64_xchg_relaxed
-#define atomic64_xchg_acquire atomic64_xchg
-#define atomic64_xchg_release atomic64_xchg
-#define atomic64_xchg_relaxed atomic64_xchg
-#else /* atomic64_xchg_relaxed */
-
-#ifndef atomic64_xchg_acquire
-static __always_inline s64
-atomic64_xchg_acquire(atomic64_t *v, s64 i)
-{
-	s64 ret = atomic64_xchg_relaxed(v, i);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic64_xchg_acquire atomic64_xchg_acquire
-#endif
-
-#ifndef atomic64_xchg_release
-static __always_inline s64
-atomic64_xchg_release(atomic64_t *v, s64 i)
-{
-	__atomic_release_fence();
-	return atomic64_xchg_relaxed(v, i);
-}
-#define atomic64_xchg_release atomic64_xchg_release
-#endif
-
-#ifndef atomic64_xchg
-static __always_inline s64
-atomic64_xchg(atomic64_t *v, s64 i)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = atomic64_xchg_relaxed(v, i);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic64_xchg atomic64_xchg
-#endif
-
-#endif /* atomic64_xchg_relaxed */
-
-#define arch_atomic64_cmpxchg atomic64_cmpxchg
-#define arch_atomic64_cmpxchg_acquire atomic64_cmpxchg_acquire
-#define arch_atomic64_cmpxchg_release atomic64_cmpxchg_release
-#define arch_atomic64_cmpxchg_relaxed atomic64_cmpxchg_relaxed
-
-#ifndef atomic64_cmpxchg_relaxed
-#define atomic64_cmpxchg_acquire atomic64_cmpxchg
-#define atomic64_cmpxchg_release atomic64_cmpxchg
-#define atomic64_cmpxchg_relaxed atomic64_cmpxchg
-#else /* atomic64_cmpxchg_relaxed */
-
-#ifndef atomic64_cmpxchg_acquire
-static __always_inline s64
-atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
-{
-	s64 ret = atomic64_cmpxchg_relaxed(v, old, new);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic64_cmpxchg_acquire atomic64_cmpxchg_acquire
-#endif
-
-#ifndef atomic64_cmpxchg_release
-static __always_inline s64
-atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
-{
-	__atomic_release_fence();
-	return atomic64_cmpxchg_relaxed(v, old, new);
-}
-#define atomic64_cmpxchg_release atomic64_cmpxchg_release
-#endif
-
-#ifndef atomic64_cmpxchg
-static __always_inline s64
-atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = atomic64_cmpxchg_relaxed(v, old, new);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic64_cmpxchg atomic64_cmpxchg
-#endif
-
-#endif /* atomic64_cmpxchg_relaxed */
-
-#define arch_atomic64_try_cmpxchg atomic64_try_cmpxchg
-#define arch_atomic64_try_cmpxchg_acquire atomic64_try_cmpxchg_acquire
-#define arch_atomic64_try_cmpxchg_release atomic64_try_cmpxchg_release
-#define arch_atomic64_try_cmpxchg_relaxed atomic64_try_cmpxchg_relaxed
-
-#ifndef atomic64_try_cmpxchg_relaxed
-#ifdef atomic64_try_cmpxchg
-#define atomic64_try_cmpxchg_acquire atomic64_try_cmpxchg
-#define atomic64_try_cmpxchg_release atomic64_try_cmpxchg
-#define atomic64_try_cmpxchg_relaxed atomic64_try_cmpxchg
-#endif /* atomic64_try_cmpxchg */
-
-#ifndef atomic64_try_cmpxchg
-static __always_inline bool
-atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
-{
-	s64 r, o = *old;
-	r = atomic64_cmpxchg(v, o, new);
-	if (unlikely(r != o))
-		*old = r;
-	return likely(r == o);
-}
-#define atomic64_try_cmpxchg atomic64_try_cmpxchg
-#endif
-
-#ifndef atomic64_try_cmpxchg_acquire
-static __always_inline bool
-atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
-{
-	s64 r, o = *old;
-	r = atomic64_cmpxchg_acquire(v, o, new);
-	if (unlikely(r != o))
-		*old = r;
-	return likely(r == o);
-}
-#define atomic64_try_cmpxchg_acquire atomic64_try_cmpxchg_acquire
-#endif
-
-#ifndef atomic64_try_cmpxchg_release
-static __always_inline bool
-atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
-{
-	s64 r, o = *old;
-	r = atomic64_cmpxchg_release(v, o, new);
-	if (unlikely(r != o))
-		*old = r;
-	return likely(r == o);
-}
-#define atomic64_try_cmpxchg_release atomic64_try_cmpxchg_release
-#endif
-
-#ifndef atomic64_try_cmpxchg_relaxed
-static __always_inline bool
-atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
-{
-	s64 r, o = *old;
-	r = atomic64_cmpxchg_relaxed(v, o, new);
-	if (unlikely(r != o))
-		*old = r;
-	return likely(r == o);
-}
-#define atomic64_try_cmpxchg_relaxed atomic64_try_cmpxchg_relaxed
-#endif
-
-#else /* atomic64_try_cmpxchg_relaxed */
-
-#ifndef atomic64_try_cmpxchg_acquire
-static __always_inline bool
-atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
-{
-	bool ret = atomic64_try_cmpxchg_relaxed(v, old, new);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define atomic64_try_cmpxchg_acquire atomic64_try_cmpxchg_acquire
-#endif
-
-#ifndef atomic64_try_cmpxchg_release
-static __always_inline bool
-atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
-{
-	__atomic_release_fence();
-	return atomic64_try_cmpxchg_relaxed(v, old, new);
-}
-#define atomic64_try_cmpxchg_release atomic64_try_cmpxchg_release
-#endif
-
-#ifndef atomic64_try_cmpxchg
-static __always_inline bool
-atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
-{
-	bool ret;
-	__atomic_pre_full_fence();
-	ret = atomic64_try_cmpxchg_relaxed(v, old, new);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define atomic64_try_cmpxchg atomic64_try_cmpxchg
-#endif
-
-#endif /* atomic64_try_cmpxchg_relaxed */
-
-#define arch_atomic64_sub_and_test atomic64_sub_and_test
-
-#ifndef atomic64_sub_and_test
-/**
- * atomic64_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer of type atomic64_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
-static __always_inline bool
-atomic64_sub_and_test(s64 i, atomic64_t *v)
-{
-	return atomic64_sub_return(i, v) == 0;
-}
-#define atomic64_sub_and_test atomic64_sub_and_test
-#endif
-
-#define arch_atomic64_dec_and_test atomic64_dec_and_test
-
-#ifndef atomic64_dec_and_test
-/**
- * atomic64_dec_and_test - decrement and test
- * @v: pointer of type atomic64_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
-static __always_inline bool
-atomic64_dec_and_test(atomic64_t *v)
-{
-	return atomic64_dec_return(v) == 0;
-}
-#define atomic64_dec_and_test atomic64_dec_and_test
-#endif
-
-#define arch_atomic64_inc_and_test atomic64_inc_and_test
-
-#ifndef atomic64_inc_and_test
-/**
- * atomic64_inc_and_test - increment and test
- * @v: pointer of type atomic64_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-static __always_inline bool
-atomic64_inc_and_test(atomic64_t *v)
-{
-	return atomic64_inc_return(v) == 0;
-}
-#define atomic64_inc_and_test atomic64_inc_and_test
-#endif
-
-#define arch_atomic64_add_negative atomic64_add_negative
-
-#ifndef atomic64_add_negative
-/**
- * atomic64_add_negative - add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic64_t
- *
- * Atomically adds @i to @v and returns true
- * if the result is negative, or false when
- * result is greater than or equal to zero.
- */
-static __always_inline bool
-atomic64_add_negative(s64 i, atomic64_t *v)
-{
-	return atomic64_add_return(i, v) < 0;
-}
-#define atomic64_add_negative atomic64_add_negative
-#endif
-
-#define arch_atomic64_fetch_add_unless atomic64_fetch_add_unless
-
-#ifndef atomic64_fetch_add_unless
-/**
- * atomic64_fetch_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns original value of @v
- */
-static __always_inline s64
-atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
-{
-	s64 c = atomic64_read(v);
-
-	do {
-		if (unlikely(c == u))
-			break;
-	} while (!atomic64_try_cmpxchg(v, &c, c + a));
-
-	return c;
-}
-#define atomic64_fetch_add_unless atomic64_fetch_add_unless
-#endif
-
-#define arch_atomic64_add_unless atomic64_add_unless
-
-#ifndef atomic64_add_unless
-/**
- * atomic64_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, if @v was not already @u.
- * Returns true if the addition was done.
- */
-static __always_inline bool
-atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
-{
-	return atomic64_fetch_add_unless(v, a, u) != u;
-}
-#define atomic64_add_unless atomic64_add_unless
-#endif
-
-#define arch_atomic64_inc_not_zero atomic64_inc_not_zero
-
-#ifndef atomic64_inc_not_zero
-/**
- * atomic64_inc_not_zero - increment unless the number is zero
- * @v: pointer of type atomic64_t
- *
- * Atomically increments @v by 1, if @v is non-zero.
- * Returns true if the increment was done.
- */
-static __always_inline bool
-atomic64_inc_not_zero(atomic64_t *v)
-{
-	return atomic64_add_unless(v, 1, 0);
-}
-#define atomic64_inc_not_zero atomic64_inc_not_zero
-#endif
-
-#define arch_atomic64_inc_unless_negative atomic64_inc_unless_negative
-
-#ifndef atomic64_inc_unless_negative
-static __always_inline bool
-atomic64_inc_unless_negative(atomic64_t *v)
-{
-	s64 c = atomic64_read(v);
-
-	do {
-		if (unlikely(c < 0))
-			return false;
-	} while (!atomic64_try_cmpxchg(v, &c, c + 1));
-
-	return true;
-}
-#define atomic64_inc_unless_negative atomic64_inc_unless_negative
-#endif
-
-#define arch_atomic64_dec_unless_positive atomic64_dec_unless_positive
-
-#ifndef atomic64_dec_unless_positive
-static __always_inline bool
-atomic64_dec_unless_positive(atomic64_t *v)
-{
-	s64 c = atomic64_read(v);
-
-	do {
-		if (unlikely(c > 0))
-			return false;
-	} while (!atomic64_try_cmpxchg(v, &c, c - 1));
-
-	return true;
-}
-#define atomic64_dec_unless_positive atomic64_dec_unless_positive
-#endif
-
-#define arch_atomic64_dec_if_positive atomic64_dec_if_positive
-
-#ifndef atomic64_dec_if_positive
-static __always_inline s64
-atomic64_dec_if_positive(atomic64_t *v)
-{
-	s64 dec, c = atomic64_read(v);
-
-	do {
-		dec = c - 1;
-		if (unlikely(dec < 0))
-			break;
-	} while (!atomic64_try_cmpxchg(v, &c, dec));
-
-	return dec;
-}
-#define atomic64_dec_if_positive atomic64_dec_if_positive
-#endif
-
-#endif /* _LINUX_ATOMIC_FALLBACK_H */
-// d78e6c293c661c15188f0ec05bce45188c8d5892
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 4f8d83f..ed1d3ff 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -77,12 +77,8 @@
 	__ret;								\
 })
 
-#ifdef CONFIG_ARCH_ATOMIC
 #include <linux/atomic-arch-fallback.h>
 #include <asm-generic/atomic-instrumented.h>
-#else
-#include <linux/atomic-fallback.h>
-#endif
 
 #include <asm-generic/atomic-long.h>
 
diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
index 82748d4..9c7fbd4 100755
--- a/scripts/atomic/check-atomics.sh
+++ b/scripts/atomic/check-atomics.sh
@@ -17,7 +17,6 @@ cat <<EOF |
 asm-generic/atomic-instrumented.h
 asm-generic/atomic-long.h
 linux/atomic-arch-fallback.h
-linux/atomic-fallback.h
 EOF
 while read header; do
 	OLDSUM="$(tail -n 1 ${LINUXDIR}/include/${header})"
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
index d29e159..f776a57 100755
--- a/scripts/atomic/gen-atomics.sh
+++ b/scripts/atomic/gen-atomics.sh
@@ -11,7 +11,6 @@ cat <<EOF |
 gen-atomic-instrumented.sh      asm-generic/atomic-instrumented.h
 gen-atomic-long.sh              asm-generic/atomic-long.h
 gen-atomic-fallback.sh          linux/atomic-arch-fallback.h		arch_
-gen-atomic-fallback.sh          linux/atomic-fallback.h
 EOF
 while read script header args; do
 	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} ${args} > ${LINUXDIR}/include/${header}
