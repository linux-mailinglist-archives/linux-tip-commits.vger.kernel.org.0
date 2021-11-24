Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A45445D0D3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Nov 2021 00:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352522AbhKXXJl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 24 Nov 2021 18:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352517AbhKXXJj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 24 Nov 2021 18:09:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3E2C061574;
        Wed, 24 Nov 2021 15:06:29 -0800 (PST)
Date:   Wed, 24 Nov 2021 23:06:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637795187;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pJ69y6FnHKbtk8hrtRhJTVH+IcAV1yE5JeMhgo0CTAg=;
        b=zBaxQDSSskgC7I5NjAR1c6j2+QczSkUORqsXRHS/WyZyX8Bxe2fhi8QqtrXim4Qv0Z1WQL
        eoHF8ba3eXtvQL25oFSbguRYH1t8W7e3jA2K9cn4pkblODj2PtOnlIe5vAZNYc1l3VHUIf
        66Sz2ZZeyzJ7ZPePyq7h8ae6USo/4tY26IdT+tu2Lu/Jzey760pCuoYb7Rti94S52Uda2f
        E3zKcrTomZ37CPnpF3wVA25+955TrPSouD36I/wkYryaZrMln+PCyL1EhOG3WP3u0SZ2JU
        zM9CJntr6CKyDaLog3EYjy2JHLdk53z+S0CQAWQl/8kARP24pFgfeAyv3fHVGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637795187;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pJ69y6FnHKbtk8hrtRhJTVH+IcAV1yE5JeMhgo0CTAg=;
        b=WZM90OvXMSe/oi/nOiqp5Q/uQ6ihcZGtzlsnCNK/wIeh3s+vmIF7xwFplQ3aLt6Zd4H+L7
        hQ/8ikIF+JWhAADQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Remove futex_cmpxchg detection
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026100432.1730393-2-arnd@kernel.org>
References: <20211026100432.1730393-2-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <163779518596.11128.3471115008300863348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3297481d688a5cc2973ea58bd78e66b8639748b1
Gitweb:        https://git.kernel.org/tip/3297481d688a5cc2973ea58bd78e66b8639748b1
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 26 Oct 2021 12:03:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Nov 2021 00:02:28 +01:00

futex: Remove futex_cmpxchg detection

Now that all architectures have a working futex implementation in any
configuration, remove the runtime detection code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Acked-by: Vineet Gupta <vgupta@kernel.org>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Link: https://lore.kernel.org/r/20211026100432.1730393-2-arnd@kernel.org

---
 arch/arc/Kconfig              |  1 +-
 arch/arm/Kconfig              |  1 +-
 arch/arm64/Kconfig            |  1 +-
 arch/csky/Kconfig             |  1 +-
 arch/m68k/Kconfig             |  1 +-
 arch/riscv/Kconfig            |  1 +-
 arch/s390/Kconfig             |  1 +-
 arch/sh/Kconfig               |  1 +-
 arch/um/Kconfig               |  1 +-
 arch/um/kernel/skas/uaccess.c |  1 +-
 arch/xtensa/Kconfig           |  1 +-
 init/Kconfig                  |  8 +--------
 kernel/futex/core.c           | 35 +----------------------------------
 kernel/futex/futex.h          |  6 +------
 kernel/futex/syscalls.c       | 22 +---------------------
 15 files changed, 82 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index b4ae605..f74d986 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -32,7 +32,6 @@ config ARC
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARC_MMU_V4
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DEBUG_KMEMLEAK
-	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_IOREMAP_PROT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZMA
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f0f9e8b..2948487 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -92,7 +92,6 @@ config ARM
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !(THUMB2_KERNEL && CC_IS_CLANG)
-	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4207cf..5e2dfef 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -194,7 +194,6 @@ config ARM64
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_FUNCTION_ARG_ACCESS_API
-	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index aed2b3e..132f43f 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -52,7 +52,6 @@ config CSKY
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
-	select HAVE_FUTEX_CMPXCHG if FUTEX && SMP
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 0b50da0..15a793c 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -20,7 +20,6 @@ config M68K
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !CPU_HAS_NO_UNALIGNED
-	select HAVE_FUTEX_CMPXCHG if MMU && FUTEX
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_UID16
 	select MMU_GATHER_NO_RANGE if MMU
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 821252b..09abf62 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -83,7 +83,6 @@ config RISCV
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_EBPF_JIT if MMU
 	select HAVE_FUNCTION_ERROR_INJECTION
-	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_VDSO if MMU && 64BIT
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8857ec3..f614562 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -165,7 +165,6 @@ config S390
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
-	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_VDSO
 	select HAVE_IOREMAP_PROT if PCI
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 70afb30..2474a04 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -34,7 +34,6 @@ config SUPERH
 	select HAVE_FAST_GUP if MMU
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
-	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_HW_BREAKPOINT
 	select HAVE_IOREMAP_PROT if MMU && !X2TLB
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index c18b45f..c906250 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -14,7 +14,6 @@ config UML
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_UID16
-	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_BUGVERBOSE
 	select NO_DMA if !UML_DMA_EMULATION
diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index a509be9..9e37a7c 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -348,7 +348,6 @@ EXPORT_SYMBOL(arch_futex_atomic_op_inuser);
  * 0 - On success
  * -EFAULT - User access resulted in a page fault
  * -EAGAIN - Atomic operation was unable to complete due to contention
- * -ENOSYS - Function not implemented (only if !HAVE_FUTEX_CMPXCHG)
  */
 
 int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 0e56bad..8ac599a 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -31,7 +31,6 @@ config XTENSA
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_EXIT_THREAD
 	select HAVE_FUNCTION_TRACER
-	select HAVE_FUTEX_CMPXCHG if !MMU && FUTEX
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_PCI
diff --git a/init/Kconfig b/init/Kconfig
index 3f5aa50..76d89db 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1592,14 +1592,6 @@ config FUTEX_PI
 	depends on FUTEX && RT_MUTEXES
 	default y
 
-config HAVE_FUTEX_CMPXCHG
-	bool
-	depends on FUTEX
-	help
-	  Architectures should select this if futex_atomic_cmpxchg_inatomic()
-	  is implemented and always working. This removes a couple of runtime
-	  checks.
-
 config EPOLL
 	bool "Enable eventpoll support" if EXPERT
 	default y
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 25d8a88..926c2bb 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -41,11 +41,6 @@
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
 
-#ifndef CONFIG_HAVE_FUTEX_CMPXCHG
-int  __read_mostly futex_cmpxchg_enabled;
-#endif
-
-
 /*
  * The base of the bucket array and its size are always used together
  * (after initialization only in futex_hash()), so ensure that they
@@ -776,9 +771,6 @@ static void exit_robust_list(struct task_struct *curr)
 	unsigned long futex_offset;
 	int rc;
 
-	if (!futex_cmpxchg_enabled)
-		return;
-
 	/*
 	 * Fetch the list head (which was registered earlier, via
 	 * sys_set_robust_list()):
@@ -874,9 +866,6 @@ static void compat_exit_robust_list(struct task_struct *curr)
 	compat_long_t futex_offset;
 	int rc;
 
-	if (!futex_cmpxchg_enabled)
-		return;
-
 	/*
 	 * Fetch the list head (which was registered earlier, via
 	 * sys_set_robust_list()):
@@ -950,8 +939,6 @@ static void exit_pi_state_list(struct task_struct *curr)
 	struct futex_hash_bucket *hb;
 	union futex_key key = FUTEX_KEY_INIT;
 
-	if (!futex_cmpxchg_enabled)
-		return;
 	/*
 	 * We are a ZOMBIE and nobody can enqueue itself on
 	 * pi_state_list anymore, but we have to be careful
@@ -1125,26 +1112,6 @@ void futex_exit_release(struct task_struct *tsk)
 	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
 }
 
-static void __init futex_detect_cmpxchg(void)
-{
-#ifndef CONFIG_HAVE_FUTEX_CMPXCHG
-	u32 curval;
-
-	/*
-	 * This will fail and we want it. Some arch implementations do
-	 * runtime detection of the futex_atomic_cmpxchg_inatomic()
-	 * functionality. We want to know that before we call in any
-	 * of the complex code paths. Also we want to prevent
-	 * registration of robust lists in that case. NULL is
-	 * guaranteed to fault and we get -EFAULT on functional
-	 * implementation, the non-functional ones will return
-	 * -ENOSYS.
-	 */
-	if (futex_cmpxchg_value_locked(&curval, NULL, 0, 0) == -EFAULT)
-		futex_cmpxchg_enabled = 1;
-#endif
-}
-
 static int __init futex_init(void)
 {
 	unsigned int futex_shift;
@@ -1163,8 +1130,6 @@ static int __init futex_init(void)
 					       futex_hashsize, futex_hashsize);
 	futex_hashsize = 1UL << futex_shift;
 
-	futex_detect_cmpxchg();
-
 	for (i = 0; i < futex_hashsize; i++) {
 		atomic_set(&futex_queues[i].waiters, 0);
 		plist_head_init(&futex_queues[i].chain);
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 040ae42..c264cbe 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -27,12 +27,6 @@
 #define FLAGS_CLOCKRT		0x02
 #define FLAGS_HAS_TIMEOUT	0x04
 
-#ifdef CONFIG_HAVE_FUTEX_CMPXCHG
-#define futex_cmpxchg_enabled 1
-#else
-extern int  __read_mostly futex_cmpxchg_enabled;
-#endif
-
 #ifdef CONFIG_FAIL_FUTEX
 extern bool should_fail_futex(bool fshared);
 #else
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 6f91a07..086a22d 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -29,8 +29,6 @@
 SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
 		size_t, len)
 {
-	if (!futex_cmpxchg_enabled)
-		return -ENOSYS;
 	/*
 	 * The kernel knows only one size for now:
 	 */
@@ -56,9 +54,6 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 	unsigned long ret;
 	struct task_struct *p;
 
-	if (!futex_cmpxchg_enabled)
-		return -ENOSYS;
-
 	rcu_read_lock();
 
 	ret = -ESRCH;
@@ -104,17 +99,6 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	}
 
 	switch (cmd) {
-	case FUTEX_LOCK_PI:
-	case FUTEX_LOCK_PI2:
-	case FUTEX_UNLOCK_PI:
-	case FUTEX_TRYLOCK_PI:
-	case FUTEX_WAIT_REQUEUE_PI:
-	case FUTEX_CMP_REQUEUE_PI:
-		if (!futex_cmpxchg_enabled)
-			return -ENOSYS;
-	}
-
-	switch (cmd) {
 	case FUTEX_WAIT:
 		val3 = FUTEX_BITSET_MATCH_ANY;
 		fallthrough;
@@ -323,9 +307,6 @@ COMPAT_SYSCALL_DEFINE2(set_robust_list,
 		struct compat_robust_list_head __user *, head,
 		compat_size_t, len)
 {
-	if (!futex_cmpxchg_enabled)
-		return -ENOSYS;
-
 	if (unlikely(len != sizeof(*head)))
 		return -EINVAL;
 
@@ -342,9 +323,6 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 	unsigned long ret;
 	struct task_struct *p;
 
-	if (!futex_cmpxchg_enabled)
-		return -ENOSYS;
-
 	rcu_read_lock();
 
 	ret = -ESRCH;
