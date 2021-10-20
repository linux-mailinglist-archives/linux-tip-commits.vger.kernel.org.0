Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65AC434C5D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhJTNqv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:46:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52930 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhJTNqt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:49 -0400
Date:   Wed, 20 Oct 2021 13:44:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/6BkTBEPlyym58PXwAiFnbCStKKCf2PSB8Ll9lXqo6s=;
        b=pW8UzkPBqO/Gw6JXz9I2dyHM1knBKRkAcX0uskvbRdSlWubuYWOp4hW2P9wjy33vLEjn2l
        P24nIg/PhOPQbpQK2Yh5QBf7rTsZW0B21vggvqU0LMaIUVq3LbJoiIwOZpGZyHyrV+SHdq
        d8zOzTTER6OMUBOM3JyRifIVtWO5BGDUOi91nafenem8/gh7M1Aq7r/HqgJ2E58dh+ch8w
        Xu4mQ+joZdO8yhv7xKZQJr53SKtoxwhthmT9GgA/s9jdwjmqzUDV5sZZNF6dkxfbYgExbu
        jycPGyKXqNWS531yCdnQrx/VhEsEg/4Ufog91RSXi2sBqGC++zKpcgvouXn+sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/6BkTBEPlyym58PXwAiFnbCStKKCf2PSB8Ll9lXqo6s=;
        b=ernojgATVoE5cu6Rq0f7KmN6ir3S5VDrCkShykSR6xLYUrMahcrjQwfmNaxwKc38Il3uDD
        K4Fl6l29P6johYAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Move legacy ASM wrappers to core
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011539.572439164@linutronix.de>
References: <20211015011539.572439164@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473747346.25758.17742319638444376009.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     34002571cb4199a446f7582704424d20a01c276e
Gitweb:        https://git.kernel.org/tip/34002571cb4199a446f7582704424d20a01c276e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:26 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:28 +02:00

x86/fpu: Move legacy ASM wrappers to core

Nothing outside the core code requires them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011539.572439164@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 101 +-------------------------
 arch/x86/kernel/fpu/core.c          |   1 +-
 arch/x86/kernel/fpu/legacy.h        | 108 +++++++++++++++++++++++++++-
 arch/x86/kernel/fpu/signal.c        |   1 +-
 arch/x86/kernel/fpu/xstate.c        |   1 +-
 5 files changed, 111 insertions(+), 101 deletions(-)
 create mode 100644 arch/x86/kernel/fpu/legacy.h

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index b68f994..7722aad 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -60,107 +60,6 @@ extern void fpstate_init_soft(struct swregs_state *soft);
 static inline void fpstate_init_soft(struct swregs_state *soft) {}
 #endif
 
-/*
- * Returns 0 on success or the trap number when the operation raises an
- * exception.
- */
-#define user_insn(insn, output, input...)				\
-({									\
-	int err;							\
-									\
-	might_fault();							\
-									\
-	asm volatile(ASM_STAC "\n"					\
-		     "1: " #insn "\n"					\
-		     "2: " ASM_CLAC "\n"				\
-		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE)	\
-		     : [err] "=a" (err), output				\
-		     : "0"(0), input);					\
-	err;								\
-})
-
-#define kernel_insn_err(insn, output, input...)				\
-({									\
-	int err;							\
-	asm volatile("1:" #insn "\n\t"					\
-		     "2:\n"						\
-		     ".section .fixup,\"ax\"\n"				\
-		     "3:  movl $-1,%[err]\n"				\
-		     "    jmp  2b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE(1b, 3b)				\
-		     : [err] "=r" (err), output				\
-		     : "0"(0), input);					\
-	err;								\
-})
-
-#define kernel_insn(insn, output, input...)				\
-	asm volatile("1:" #insn "\n\t"					\
-		     "2:\n"						\
-		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FPU_RESTORE)	\
-		     : output : input)
-
-static inline int fnsave_to_user_sigframe(struct fregs_state __user *fx)
-{
-	return user_insn(fnsave %[fx]; fwait,  [fx] "=m" (*fx), "m" (*fx));
-}
-
-static inline int fxsave_to_user_sigframe(struct fxregs_state __user *fx)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		return user_insn(fxsave %[fx], [fx] "=m" (*fx), "m" (*fx));
-	else
-		return user_insn(fxsaveq %[fx], [fx] "=m" (*fx), "m" (*fx));
-
-}
-
-static inline void fxrstor(struct fxregs_state *fx)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		kernel_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
-	else
-		kernel_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
-}
-
-static inline int fxrstor_safe(struct fxregs_state *fx)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		return kernel_insn_err(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
-	else
-		return kernel_insn_err(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
-}
-
-static inline int fxrstor_from_user_sigframe(struct fxregs_state __user *fx)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		return user_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
-	else
-		return user_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
-}
-
-static inline void frstor(struct fregs_state *fx)
-{
-	kernel_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
-}
-
-static inline int frstor_safe(struct fregs_state *fx)
-{
-	return kernel_insn_err(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
-}
-
-static inline int frstor_from_user_sigframe(struct fregs_state __user *fx)
-{
-	return user_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
-}
-
-static inline void fxsave(struct fxregs_state *fx)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		asm volatile( "fxsave %[fx]" : [fx] "=m" (*fx));
-	else
-		asm volatile("fxsaveq %[fx]" : [fx] "=m" (*fx));
-}
-
 extern void restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask);
 
 extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index e9b51c7..a009c82 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -18,6 +18,7 @@
 #include <linux/pkeys.h>
 
 #include "internal.h"
+#include "legacy.h"
 #include "xstate.h"
 
 #define CREATE_TRACE_POINTS
diff --git a/arch/x86/kernel/fpu/legacy.h b/arch/x86/kernel/fpu/legacy.h
new file mode 100644
index 0000000..2ff36b0
--- /dev/null
+++ b/arch/x86/kernel/fpu/legacy.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __X86_KERNEL_FPU_LEGACY_H
+#define __X86_KERNEL_FPU_LEGACY_H
+
+#include <asm/fpu/types.h>
+
+/*
+ * Returns 0 on success or the trap number when the operation raises an
+ * exception.
+ */
+#define user_insn(insn, output, input...)				\
+({									\
+	int err;							\
+									\
+	might_fault();							\
+									\
+	asm volatile(ASM_STAC "\n"					\
+		     "1: " #insn "\n"					\
+		     "2: " ASM_CLAC "\n"				\
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE)	\
+		     : [err] "=a" (err), output				\
+		     : "0"(0), input);					\
+	err;								\
+})
+
+#define kernel_insn_err(insn, output, input...)				\
+({									\
+	int err;							\
+	asm volatile("1:" #insn "\n\t"					\
+		     "2:\n"						\
+		     ".section .fixup,\"ax\"\n"				\
+		     "3:  movl $-1,%[err]\n"				\
+		     "    jmp  2b\n"					\
+		     ".previous\n"					\
+		     _ASM_EXTABLE(1b, 3b)				\
+		     : [err] "=r" (err), output				\
+		     : "0"(0), input);					\
+	err;								\
+})
+
+#define kernel_insn(insn, output, input...)				\
+	asm volatile("1:" #insn "\n\t"					\
+		     "2:\n"						\
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FPU_RESTORE)	\
+		     : output : input)
+
+static inline int fnsave_to_user_sigframe(struct fregs_state __user *fx)
+{
+	return user_insn(fnsave %[fx]; fwait,  [fx] "=m" (*fx), "m" (*fx));
+}
+
+static inline int fxsave_to_user_sigframe(struct fxregs_state __user *fx)
+{
+	if (IS_ENABLED(CONFIG_X86_32))
+		return user_insn(fxsave %[fx], [fx] "=m" (*fx), "m" (*fx));
+	else
+		return user_insn(fxsaveq %[fx], [fx] "=m" (*fx), "m" (*fx));
+
+}
+
+static inline void fxrstor(struct fxregs_state *fx)
+{
+	if (IS_ENABLED(CONFIG_X86_32))
+		kernel_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
+	else
+		kernel_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
+}
+
+static inline int fxrstor_safe(struct fxregs_state *fx)
+{
+	if (IS_ENABLED(CONFIG_X86_32))
+		return kernel_insn_err(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
+	else
+		return kernel_insn_err(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
+}
+
+static inline int fxrstor_from_user_sigframe(struct fxregs_state __user *fx)
+{
+	if (IS_ENABLED(CONFIG_X86_32))
+		return user_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
+	else
+		return user_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
+}
+
+static inline void frstor(struct fregs_state *fx)
+{
+	kernel_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
+}
+
+static inline int frstor_safe(struct fregs_state *fx)
+{
+	return kernel_insn_err(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
+}
+
+static inline int frstor_from_user_sigframe(struct fregs_state __user *fx)
+{
+	return user_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
+}
+
+static inline void fxsave(struct fxregs_state *fx)
+{
+	if (IS_ENABLED(CONFIG_X86_32))
+		asm volatile( "fxsave %[fx]" : [fx] "=m" (*fx));
+	else
+		asm volatile("fxsaveq %[fx]" : [fx] "=m" (*fx));
+}
+
+#endif
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 3b38c59..e0198b2 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -17,6 +17,7 @@
 #include <asm/trace/fpu.h>
 
 #include "internal.h"
+#include "legacy.h"
 #include "xstate.h"
 
 static struct _fpx_sw_bytes fx_sw_reserved __ro_after_init;
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index b712c06..246a7fe 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -20,6 +20,7 @@
 #include <asm/tlbflush.h>
 
 #include "internal.h"
+#include "legacy.h"
 #include "xstate.h"
 
 #define for_each_extended_xfeature(bit, mask)				\
