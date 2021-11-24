Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672AB45D0D4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Nov 2021 00:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352524AbhKXXJm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 24 Nov 2021 18:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352521AbhKXXJk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 24 Nov 2021 18:09:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3AAC06173E;
        Wed, 24 Nov 2021 15:06:30 -0800 (PST)
Date:   Wed, 24 Nov 2021 23:06:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637795188;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Si3XAO2NXAWYs8ik7qlyQJSOmGFSTCHoFWj3eFlgSlA=;
        b=FHOHK17cMhbqxoN+OoTkR8Isutj5YR7OQ/dGiFgh6KFiuOr2G7QexTRr0hM0tUY5PqO8xs
        YUBOTxT1ApoT6VmSnzZ5Ai2IbPE6gzvGQetweo4pJVUxa5OuxE4K0VrUQ/oIwvwfEREz1E
        UqHIlHeGfUdbZjveFkJUdH352jwovn3va5My4Xsog9bjWEd1VLi9s2qmVsb/eCKkT3tGK6
        iZaSHuVjtrPpySAVZKzZOQzH7CjVzD9XkPSoWj4/qJU7KtYBoSNIBC6mdywOves+E44AlU
        XBF44cpb1AKsY74KLQnTio5Y6N07vpAJ2KE51B6rZsqDB3kGxt6BAAMOBZPxJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637795188;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Si3XAO2NXAWYs8ik7qlyQJSOmGFSTCHoFWj3eFlgSlA=;
        b=O7R9eh1pv+qJyhynQUANlRxoC80iF0QGzqiztrkjK+gaR448eaImB4VAFZT+GAq1MHzuVo
        /3SQCy3iG8ToCdDA==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Ensure futex_atomic_cmpxchg_inatomic() is present
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rich Felker <dalias@libc.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026100432.1730393-1-arnd@kernel.org>
References: <20211026100432.1730393-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <163779518751.11128.9469245015141659026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3f2bedabb62c6210df63b604dc988d2f7f56f947
Gitweb:        https://git.kernel.org/tip/3f2bedabb62c6210df63b604dc988d2f7f56f947
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 26 Oct 2021 12:03:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Nov 2021 00:02:28 +01:00

futex: Ensure futex_atomic_cmpxchg_inatomic() is present

The boot-time detection of futex_atomic_cmpxchg_inatomic() has a bug on
some 32-bit arm builds, and Thomas Gleixner suggested that setting
CONFIG_HAVE_FUTEX_CMPXCHG would avoid the problem, as it is always present
anyway.

Looking into which other architectures could do the same showed that almost
all architectures have it, the exceptions being:

 - some old 32-bit MIPS uniprocessor cores without ll/sc
 - one xtensa variant with no SMP
 - 32-bit SPARC when built for SMP

Fix MIPS And Xtensa by rearranging the generic code to let it be used
as a fallback.

For SPARC, the SMP definition just ends up turning off futex anyway, so
this can be done at Kconfig time instead. Note that sparc32 glibc requires
the CASA instruction for its mutexes anyway, which is only available when
running on SPARCv9 or LEON CPUs, but needs to be implemented in the sparc32
kernel for those.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Rich Felker <dalias@libc.org>
Link: https://lore.kernel.org/r/20211026100432.1730393-1-arnd@kernel.org

---
 arch/mips/include/asm/futex.h   | 29 ++++++++++++++++++-----------
 arch/xtensa/include/asm/futex.h |  8 ++++++--
 include/asm-generic/futex.h     | 31 +++++++++++--------------------
 init/Kconfig                    |  1 +
 4 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index d852484..9287110 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -19,7 +19,11 @@
 #include <asm/sync.h>
 #include <asm/war.h>
 
-#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)		\
+#define arch_futex_atomic_op_inuser arch_futex_atomic_op_inuser
+#define futex_atomic_cmpxchg_inatomic futex_atomic_cmpxchg_inatomic
+#include <asm-generic/futex.h>
+
+#define __futex_atomic_op(op, insn, ret, oldval, uaddr, oparg)		\
 {									\
 	if (cpu_has_llsc && IS_ENABLED(CONFIG_WAR_R10000_LLSC)) {	\
 		__asm__ __volatile__(					\
@@ -80,9 +84,11 @@
 		: "0" (0), GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oparg),	\
 		  "i" (-EFAULT)						\
 		: "memory");						\
-	} else								\
-		ret = -ENOSYS;						\
-}
+	} else {							\
+		/* fallback for non-SMP */				\
+		ret = arch_futex_atomic_op_inuser_local(op, oparg, oval,\
+							uaddr);	\
+	}
 
 static inline int
 arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
@@ -94,23 +100,23 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 
 	switch (op) {
 	case FUTEX_OP_SET:
-		__futex_atomic_op("move $1, %z5", ret, oldval, uaddr, oparg);
+		__futex_atomic_op(op, "move $1, %z5", ret, oldval, uaddr, oparg);
 		break;
 
 	case FUTEX_OP_ADD:
-		__futex_atomic_op("addu $1, %1, %z5",
+		__futex_atomic_op(op, "addu $1, %1, %z5",
 				  ret, oldval, uaddr, oparg);
 		break;
 	case FUTEX_OP_OR:
-		__futex_atomic_op("or	$1, %1, %z5",
+		__futex_atomic_op(op, "or	$1, %1, %z5",
 				  ret, oldval, uaddr, oparg);
 		break;
 	case FUTEX_OP_ANDN:
-		__futex_atomic_op("and	$1, %1, %z5",
+		__futex_atomic_op(op, "and	$1, %1, %z5",
 				  ret, oldval, uaddr, ~oparg);
 		break;
 	case FUTEX_OP_XOR:
-		__futex_atomic_op("xor	$1, %1, %z5",
+		__futex_atomic_op(op, "xor	$1, %1, %z5",
 				  ret, oldval, uaddr, oparg);
 		break;
 	default:
@@ -193,8 +199,9 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		: GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
 		  "i" (-EFAULT)
 		: "memory");
-	} else
-		return -ENOSYS;
+	} else {
+		return futex_atomic_cmpxchg_inatomic_local(uval, uaddr, oldval, newval);
+	}
 
 	*uval = val;
 	return ret;
diff --git a/arch/xtensa/include/asm/futex.h b/arch/xtensa/include/asm/futex.h
index a1a27b2..fe8f315 100644
--- a/arch/xtensa/include/asm/futex.h
+++ b/arch/xtensa/include/asm/futex.h
@@ -16,6 +16,10 @@
 #include <linux/uaccess.h>
 #include <linux/errno.h>
 
+#define arch_futex_atomic_op_inuser arch_futex_atomic_op_inuser
+#define futex_atomic_cmpxchg_inatomic futex_atomic_cmpxchg_inatomic
+#include <asm-generic/futex.h>
+
 #if XCHAL_HAVE_EXCLUSIVE
 #define __futex_atomic_op(insn, ret, old, uaddr, arg)	\
 	__asm__ __volatile(				\
@@ -105,7 +109,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 
 	return ret;
 #else
-	return -ENOSYS;
+	return arch_futex_atomic_op_inuser_local(op, oparg, oval, uaddr);
 #endif
 }
 
@@ -156,7 +160,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 
 	return ret;
 #else
-	return -ENOSYS;
+	return futex_atomic_cmpxchg_inatomic_local(uval, uaddr, oldval, newval);
 #endif
 }
 
diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index f4c3470..30e7fa6 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -6,15 +6,22 @@
 #include <linux/uaccess.h>
 #include <asm/errno.h>
 
+#ifndef futex_atomic_cmpxchg_inatomic
 #ifndef CONFIG_SMP
 /*
  * The following implementation only for uniprocessor machines.
  * It relies on preempt_disable() ensuring mutual exclusion.
  *
  */
+#define futex_atomic_cmpxchg_inatomic(uval, uaddr, oldval, newval) \
+	futex_atomic_cmpxchg_inatomic_local_generic(uval, uaddr, oldval, newval)
+#define arch_futex_atomic_op_inuser(op, oparg, oval, uaddr) \
+	arch_futex_atomic_op_inuser_local_generic(op, oparg, oval, uaddr)
+#endif /* CONFIG_SMP */
+#endif
 
 /**
- * arch_futex_atomic_op_inuser() - Atomic arithmetic operation with constant
+ * arch_futex_atomic_op_inuser_local() - Atomic arithmetic operation with constant
  *			  argument and comparison of the previous
  *			  futex value with another constant.
  *
@@ -28,7 +35,7 @@
  * -ENOSYS - Operation not supported
  */
 static inline int
-arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
+futex_atomic_op_inuser_local(int op, u32 oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval, ret;
 	u32 tmp;
@@ -75,7 +82,7 @@ out_pagefault_enable:
 }
 
 /**
- * futex_atomic_cmpxchg_inatomic() - Compare and exchange the content of the
+ * futex_atomic_cmpxchg_inatomic_local() - Compare and exchange the content of the
  *				uaddr with newval if the current value is
  *				oldval.
  * @uval:	pointer to store content of @uaddr
@@ -87,10 +94,9 @@ out_pagefault_enable:
  * 0 - On success
  * -EFAULT - User access resulted in a page fault
  * -EAGAIN - Atomic operation was unable to complete due to contention
- * -ENOSYS - Function not implemented (only if !HAVE_FUTEX_CMPXCHG)
  */
 static inline int
-futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+futex_atomic_cmpxchg_inatomic_local(u32 *uval, u32 __user *uaddr,
 			      u32 oldval, u32 newval)
 {
 	u32 val;
@@ -112,19 +118,4 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	return 0;
 }
 
-#else
-static inline int
-arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
-{
-	return -ENOSYS;
-}
-
-static inline int
-futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
-			      u32 oldval, u32 newval)
-{
-	return -ENOSYS;
-}
-
-#endif /* CONFIG_SMP */
 #endif
diff --git a/init/Kconfig b/init/Kconfig
index 036b750..3f5aa50 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1579,6 +1579,7 @@ config BASE_FULL
 
 config FUTEX
 	bool "Enable futex support" if EXPERT
+	depends on !(SPARC32 && SMP)
 	default y
 	imply RT_MUTEXES
 	help
