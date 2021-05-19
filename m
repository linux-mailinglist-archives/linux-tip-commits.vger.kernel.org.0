Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B026A3890A0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 16:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347077AbhESOU4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 10:20:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39768 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346063AbhESOUz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 10:20:55 -0400
Date:   Wed, 19 May 2021 14:19:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621433974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ESpqIYZeaXjblcpOT4EZw9HNNOx2IyXw7Nb2tL5rhlo=;
        b=BM1SQcex8wu6oNZ0iHamUv1FkqmGT3e8DZDw1HhbXGhWGLRcOnRW+etCTjDE/aP4XC77vh
        9jxslVuDuUGvXbmpV1urnP5AN/seBs6pERLSwbLs0brE3MiUrXQtY0514P2QvsEdDSxPZT
        ZJZA5S5pxcCR2fZn30zyNPKngydJgIBE2O5AbeYLbvfBym8aDJwX2jHNfxll2Du0i2ErWl
        LecOrwL0b4riPE6MGxVhrdX3Pi7w9fIJWfKrlGxvGWnxMDKURP7L+uDXdDUTGvS3o7CgSg
        tC4kPwJTfyqUEBZTtv2RK0xLW1JZ2+PzJMchM0KneRSn0dh1KgNLzSwBZQCTUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621433974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ESpqIYZeaXjblcpOT4EZw9HNNOx2IyXw7Nb2tL5rhlo=;
        b=wXdq7oEc5nFrc3aAqQBKwAGhDVn83iMNEooEySCXh7LdkvvXYH+dxSsE44lOs9/FBfwnka
        warveEiiOQhnP9Aw==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/elf: Support a new ELF aux vector AT_MINSIGSTKSZ
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210518200320.17239-4-chang.seok.bae@intel.com>
References: <20210518200320.17239-4-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <162143397291.29796.8808994957174145740.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     1c33bb0507508af24fd754dd7123bd8e997fab2f
Gitweb:        https://git.kernel.org/tip/1c33bb0507508af24fd754dd7123bd8e997fab2f
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 18 May 2021 13:03:17 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 May 2021 12:18:45 +02:00

x86/elf: Support a new ELF aux vector AT_MINSIGSTKSZ

Historically, signal.h defines MINSIGSTKSZ (2KB) and SIGSTKSZ (8KB), for
use by all architectures with sigaltstack(2). Over time, the hardware state
size grew, but these constants did not evolve. Today, literal use of these
constants on several architectures may result in signal stack overflow, and
thus user data corruption.

A few years ago, the ARM team addressed this issue by establishing
getauxval(AT_MINSIGSTKSZ). This enables the kernel to supply a value
at runtime that is an appropriate replacement on current and future
hardware.

Add getauxval(AT_MINSIGSTKSZ) support to x86, analogous to the support
added for ARM in

  94b07c1f8c39 ("arm64: signal: Report signal frame size to userspace via auxv").

Also, include a documentation to describe x86-specific auxiliary vectors.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Len Brown <len.brown@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20210518200320.17239-4-chang.seok.bae@intel.com
---
 Documentation/x86/elf_auxvec.rst   | 53 +++++++++++++++++++++++++++++-
 Documentation/x86/index.rst        |  1 +-
 arch/x86/include/asm/elf.h         |  4 ++-
 arch/x86/include/uapi/asm/auxvec.h |  4 +-
 arch/x86/kernel/signal.c           |  5 +++-
 5 files changed, 65 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/x86/elf_auxvec.rst

diff --git a/Documentation/x86/elf_auxvec.rst b/Documentation/x86/elf_auxvec.rst
new file mode 100644
index 0000000..18e4744
--- /dev/null
+++ b/Documentation/x86/elf_auxvec.rst
@@ -0,0 +1,53 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+x86-specific ELF Auxiliary Vectors
+==================================
+
+This document describes the semantics of the x86 auxiliary vectors.
+
+Introduction
+============
+
+ELF Auxiliary vectors enable the kernel to efficiently provide
+configuration-specific parameters to userspace. In this example, a program
+allocates an alternate stack based on the kernel-provided size::
+
+   #include <sys/auxv.h>
+   #include <elf.h>
+   #include <signal.h>
+   #include <stdlib.h>
+   #include <assert.h>
+   #include <err.h>
+
+   #ifndef AT_MINSIGSTKSZ
+   #define AT_MINSIGSTKSZ	51
+   #endif
+
+   ....
+   stack_t ss;
+
+   ss.ss_sp = malloc(ss.ss_size);
+   assert(ss.ss_sp);
+
+   ss.ss_size = getauxval(AT_MINSIGSTKSZ) + SIGSTKSZ;
+   ss.ss_flags = 0;
+
+   if (sigaltstack(&ss, NULL))
+        err(1, "sigaltstack");
+
+
+The exposed auxiliary vectors
+=============================
+
+AT_SYSINFO is used for locating the vsyscall entry point.  It is not
+exported on 64-bit mode.
+
+AT_SYSINFO_EHDR is the start address of the page containing the vDSO.
+
+AT_MINSIGSTKSZ denotes the minimum stack size required by the kernel to
+deliver a signal to user-space.  AT_MINSIGSTKSZ comprehends the space
+consumed by the kernel to accommodate the user context for the current
+hardware configuration.  It does not comprehend subsequent user-space stack
+consumption, which must be added by the user.  (e.g. Above, user-space adds
+SIGSTKSZ to AT_MINSIGSTKSZ.)
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 4693e19..d58614d 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -35,3 +35,4 @@ x86-specific Documentation
    sva
    sgx
    features
+   elf_auxvec
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 7d75008..29fea18 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -312,6 +312,7 @@ do {									\
 		NEW_AUX_ENT(AT_SYSINFO,	VDSO_ENTRY);			\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR, VDSO_CURRENT_BASE);	\
 	}								\
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());		\
 } while (0)
 
 /*
@@ -328,6 +329,7 @@ extern unsigned long task_size_32bit(void);
 extern unsigned long task_size_64bit(int full_addr_space);
 extern unsigned long get_mmap_base(int is_legacy);
 extern bool mmap_address_hint_valid(unsigned long addr, unsigned long len);
+extern unsigned long get_sigframe_size(void);
 
 #ifdef CONFIG_X86_32
 
@@ -349,6 +351,7 @@ do {									\
 	if (vdso64_enabled)						\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
 			    (unsigned long __force)current->mm->context.vdso); \
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());		\
 } while (0)
 
 /* As a historical oddity, the x32 and x86_64 vDSOs are controlled together. */
@@ -357,6 +360,7 @@ do {									\
 	if (vdso64_enabled)						\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
 			    (unsigned long __force)current->mm->context.vdso); \
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());		\
 } while (0)
 
 #define AT_SYSINFO		32
diff --git a/arch/x86/include/uapi/asm/auxvec.h b/arch/x86/include/uapi/asm/auxvec.h
index 580e3c5..6beb55b 100644
--- a/arch/x86/include/uapi/asm/auxvec.h
+++ b/arch/x86/include/uapi/asm/auxvec.h
@@ -12,9 +12,9 @@
 
 /* entries in ARCH_DLINFO: */
 #if defined(CONFIG_IA32_EMULATION) || !defined(CONFIG_X86_64)
-# define AT_VECTOR_SIZE_ARCH 2
+# define AT_VECTOR_SIZE_ARCH 3
 #else /* else it's non-compat x86-64 */
-# define AT_VECTOR_SIZE_ARCH 1
+# define AT_VECTOR_SIZE_ARCH 2
 #endif
 
 #endif /* _ASM_X86_AUXVEC_H */
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 689a4b6..86e5386 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -718,6 +718,11 @@ void __init init_sigframe_size(void)
 	pr_info("max sigframe size: %lu\n", max_frame_size);
 }
 
+unsigned long get_sigframe_size(void)
+{
+	return max_frame_size;
+}
+
 static inline int is_ia32_compat_frame(struct ksignal *ksig)
 {
 	return IS_ENABLED(CONFIG_IA32_EMULATION) &&
