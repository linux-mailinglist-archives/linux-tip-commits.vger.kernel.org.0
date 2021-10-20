Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8472434C65
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhJTNrE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:47:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52936 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhJTNqu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:50 -0400
Date:   Wed, 20 Oct 2021 13:44:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhaHcPx97x/EeOAI+KYTzf4rDFe0plUOp3oPIbMDyxU=;
        b=ncW+aYBJeRlJJML0BrkkFTYAIKTHDsQkzjHBFgbByb52wZVmvmh+DazbPLLSjfbJpTrLWj
        CUxQBDF9fNtLA1iE0BBh5N8TdvzuxTWMGaMNqb6YVxq7f5uDZXYAp+bObXwiAlmyZ8MaKY
        FSBC19frskeDTHwbJx4MDY6ULdRdUyfP8hj+16x92xhdlOrrBQ1Pxuc4yZ4qI4Itna01nW
        V7n/IZdL/64x58f7Kozbc16fw1/WDVsBytclXZyF2oRYBdACNO7jb5Zomq59En1q//KPI8
        rFiUPY5PhYNqeH7DmXFkvzoo0HGSLAluMIDLhC0iDlSntn3XkfxungHfdiV3Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhaHcPx97x/EeOAI+KYTzf4rDFe0plUOp3oPIbMDyxU=;
        b=j5G4BEq1K1h84IHt1vUYZ7yDWGdBP3iJRO41GGaNzRUjNWJf6TPZcaak5vwLarkvafhAxw
        IxOUS5aw6CoTgFDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Move os_xsave() and os_xrstor() to core
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011539.513368075@linutronix.de>
References: <20211015011539.513368075@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473747413.25758.1052733068242329282.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     df95b0f1aa56dfa71a0ef657e3e62294ee6d9034
Gitweb:        https://git.kernel.org/tip/df95b0f1aa56dfa71a0ef657e3e62294ee6d9034
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:24 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:28 +02:00

x86/fpu: Move os_xsave() and os_xrstor() to core

Nothing outside the core code needs these.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011539.513368075@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 165 +--------------------------
 arch/x86/include/asm/fpu/xstate.h   |   6 +-
 arch/x86/kernel/fpu/signal.c        |   1 +-
 arch/x86/kernel/fpu/xstate.h        | 174 +++++++++++++++++++++++++++-
 4 files changed, 175 insertions(+), 171 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 3ad2ae7..b68f994 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -161,171 +161,6 @@ static inline void fxsave(struct fxregs_state *fx)
 		asm volatile("fxsaveq %[fx]" : [fx] "=m" (*fx));
 }
 
-/* These macros all use (%edi)/(%rdi) as the single memory argument. */
-#define XSAVE		".byte " REX_PREFIX "0x0f,0xae,0x27"
-#define XSAVEOPT	".byte " REX_PREFIX "0x0f,0xae,0x37"
-#define XSAVES		".byte " REX_PREFIX "0x0f,0xc7,0x2f"
-#define XRSTOR		".byte " REX_PREFIX "0x0f,0xae,0x2f"
-#define XRSTORS		".byte " REX_PREFIX "0x0f,0xc7,0x1f"
-
-/*
- * After this @err contains 0 on success or the trap number when the
- * operation raises an exception.
- */
-#define XSTATE_OP(op, st, lmask, hmask, err)				\
-	asm volatile("1:" op "\n\t"					\
-		     "xor %[err], %[err]\n"				\
-		     "2:\n\t"						\
-		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE)	\
-		     : [err] "=a" (err)					\
-		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
-		     : "memory")
-
-/*
- * If XSAVES is enabled, it replaces XSAVEOPT because it supports a compact
- * format and supervisor states in addition to modified optimization in
- * XSAVEOPT.
- *
- * Otherwise, if XSAVEOPT is enabled, XSAVEOPT replaces XSAVE because XSAVEOPT
- * supports modified optimization which is not supported by XSAVE.
- *
- * We use XSAVE as a fallback.
- *
- * The 661 label is defined in the ALTERNATIVE* macros as the address of the
- * original instruction which gets replaced. We need to use it here as the
- * address of the instruction where we might get an exception at.
- */
-#define XSTATE_XSAVE(st, lmask, hmask, err)				\
-	asm volatile(ALTERNATIVE_2(XSAVE,				\
-				   XSAVEOPT, X86_FEATURE_XSAVEOPT,	\
-				   XSAVES,   X86_FEATURE_XSAVES)	\
-		     "\n"						\
-		     "xor %[err], %[err]\n"				\
-		     "3:\n"						\
-		     ".pushsection .fixup,\"ax\"\n"			\
-		     "4: movl $-2, %[err]\n"				\
-		     "jmp 3b\n"						\
-		     ".popsection\n"					\
-		     _ASM_EXTABLE(661b, 4b)				\
-		     : [err] "=r" (err)					\
-		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
-		     : "memory")
-
-/*
- * Use XRSTORS to restore context if it is enabled. XRSTORS supports compact
- * XSAVE area format.
- */
-#define XSTATE_XRESTORE(st, lmask, hmask)				\
-	asm volatile(ALTERNATIVE(XRSTOR,				\
-				 XRSTORS, X86_FEATURE_XSAVES)		\
-		     "\n"						\
-		     "3:\n"						\
-		     _ASM_EXTABLE_TYPE(661b, 3b, EX_TYPE_FPU_RESTORE)	\
-		     :							\
-		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
-		     : "memory")
-
-/*
- * Save processor xstate to xsave area.
- *
- * Uses either XSAVE or XSAVEOPT or XSAVES depending on the CPU features
- * and command line options. The choice is permanent until the next reboot.
- */
-static inline void os_xsave(struct xregs_state *xstate)
-{
-	u64 mask = xfeatures_mask_all;
-	u32 lmask = mask;
-	u32 hmask = mask >> 32;
-	int err;
-
-	WARN_ON_FPU(!alternatives_patched);
-
-	XSTATE_XSAVE(xstate, lmask, hmask, err);
-
-	/* We should never fault when copying to a kernel buffer: */
-	WARN_ON_FPU(err);
-}
-
-/*
- * Restore processor xstate from xsave area.
- *
- * Uses XRSTORS when XSAVES is used, XRSTOR otherwise.
- */
-static inline void os_xrstor(struct xregs_state *xstate, u64 mask)
-{
-	u32 lmask = mask;
-	u32 hmask = mask >> 32;
-
-	XSTATE_XRESTORE(xstate, lmask, hmask);
-}
-
-/*
- * Save xstate to user space xsave area.
- *
- * We don't use modified optimization because xrstor/xrstors might track
- * a different application.
- *
- * We don't use compacted format xsave area for backward compatibility for
- * old applications which don't understand the compacted format of the
- * xsave area.
- *
- * The caller has to zero buf::header before calling this because XSAVE*
- * does not touch the reserved fields in the header.
- */
-static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
-{
-	/*
-	 * Include the features which are not xsaved/rstored by the kernel
-	 * internally, e.g. PKRU. That's user space ABI and also required
-	 * to allow the signal handler to modify PKRU.
-	 */
-	u64 mask = xfeatures_mask_uabi();
-	u32 lmask = mask;
-	u32 hmask = mask >> 32;
-	int err;
-
-	stac();
-	XSTATE_OP(XSAVE, buf, lmask, hmask, err);
-	clac();
-
-	return err;
-}
-
-/*
- * Restore xstate from user space xsave area.
- */
-static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64 mask)
-{
-	struct xregs_state *xstate = ((__force struct xregs_state *)buf);
-	u32 lmask = mask;
-	u32 hmask = mask >> 32;
-	int err;
-
-	stac();
-	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
-	clac();
-
-	return err;
-}
-
-/*
- * Restore xstate from kernel space xsave area, return an error code instead of
- * an exception.
- */
-static inline int os_xrstor_safe(struct xregs_state *xstate, u64 mask)
-{
-	u32 lmask = mask;
-	u32 hmask = mask >> 32;
-	int err;
-
-	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
-		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
-	else
-		XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
-
-	return err;
-}
-
 extern void restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask);
 
 extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 109dfcc..b8cebc0 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -78,12 +78,6 @@
 				      XFEATURE_MASK_INDEPENDENT | \
 				      XFEATURE_MASK_SUPERVISOR_UNSUPPORTED)
 
-#ifdef CONFIG_X86_64
-#define REX_PREFIX	"0x48, "
-#else
-#define REX_PREFIX
-#endif
-
 extern u64 xfeatures_mask_all;
 
 static inline u64 xfeatures_mask_supervisor(void)
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 2a4d1d0..3b38c59 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -17,6 +17,7 @@
 #include <asm/trace/fpu.h>
 
 #include "internal.h"
+#include "xstate.h"
 
 static struct _fpx_sw_bytes fx_sw_reserved __ro_after_init;
 static struct _fpx_sw_bytes fx_sw_reserved_ia32 __ro_after_init;
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 81f4202..ae61baa 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -18,4 +18,178 @@ static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
 extern void __copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
 				      u32 pkru_val, enum xstate_copy_mode copy_mode);
 
+/* XSAVE/XRSTOR wrapper functions */
+
+#ifdef CONFIG_X86_64
+#define REX_PREFIX	"0x48, "
+#else
+#define REX_PREFIX
+#endif
+
+/* These macros all use (%edi)/(%rdi) as the single memory argument. */
+#define XSAVE		".byte " REX_PREFIX "0x0f,0xae,0x27"
+#define XSAVEOPT	".byte " REX_PREFIX "0x0f,0xae,0x37"
+#define XSAVES		".byte " REX_PREFIX "0x0f,0xc7,0x2f"
+#define XRSTOR		".byte " REX_PREFIX "0x0f,0xae,0x2f"
+#define XRSTORS		".byte " REX_PREFIX "0x0f,0xc7,0x1f"
+
+/*
+ * After this @err contains 0 on success or the trap number when the
+ * operation raises an exception.
+ */
+#define XSTATE_OP(op, st, lmask, hmask, err)				\
+	asm volatile("1:" op "\n\t"					\
+		     "xor %[err], %[err]\n"				\
+		     "2:\n\t"						\
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE)	\
+		     : [err] "=a" (err)					\
+		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
+		     : "memory")
+
+/*
+ * If XSAVES is enabled, it replaces XSAVEOPT because it supports a compact
+ * format and supervisor states in addition to modified optimization in
+ * XSAVEOPT.
+ *
+ * Otherwise, if XSAVEOPT is enabled, XSAVEOPT replaces XSAVE because XSAVEOPT
+ * supports modified optimization which is not supported by XSAVE.
+ *
+ * We use XSAVE as a fallback.
+ *
+ * The 661 label is defined in the ALTERNATIVE* macros as the address of the
+ * original instruction which gets replaced. We need to use it here as the
+ * address of the instruction where we might get an exception at.
+ */
+#define XSTATE_XSAVE(st, lmask, hmask, err)				\
+	asm volatile(ALTERNATIVE_2(XSAVE,				\
+				   XSAVEOPT, X86_FEATURE_XSAVEOPT,	\
+				   XSAVES,   X86_FEATURE_XSAVES)	\
+		     "\n"						\
+		     "xor %[err], %[err]\n"				\
+		     "3:\n"						\
+		     ".pushsection .fixup,\"ax\"\n"			\
+		     "4: movl $-2, %[err]\n"				\
+		     "jmp 3b\n"						\
+		     ".popsection\n"					\
+		     _ASM_EXTABLE(661b, 4b)				\
+		     : [err] "=r" (err)					\
+		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
+		     : "memory")
+
+/*
+ * Use XRSTORS to restore context if it is enabled. XRSTORS supports compact
+ * XSAVE area format.
+ */
+#define XSTATE_XRESTORE(st, lmask, hmask)				\
+	asm volatile(ALTERNATIVE(XRSTOR,				\
+				 XRSTORS, X86_FEATURE_XSAVES)		\
+		     "\n"						\
+		     "3:\n"						\
+		     _ASM_EXTABLE_TYPE(661b, 3b, EX_TYPE_FPU_RESTORE)	\
+		     :							\
+		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
+		     : "memory")
+
+/*
+ * Save processor xstate to xsave area.
+ *
+ * Uses either XSAVE or XSAVEOPT or XSAVES depending on the CPU features
+ * and command line options. The choice is permanent until the next reboot.
+ */
+static inline void os_xsave(struct xregs_state *xstate)
+{
+	u64 mask = xfeatures_mask_all;
+	u32 lmask = mask;
+	u32 hmask = mask >> 32;
+	int err;
+
+	WARN_ON_FPU(!alternatives_patched);
+
+	XSTATE_XSAVE(xstate, lmask, hmask, err);
+
+	/* We should never fault when copying to a kernel buffer: */
+	WARN_ON_FPU(err);
+}
+
+/*
+ * Restore processor xstate from xsave area.
+ *
+ * Uses XRSTORS when XSAVES is used, XRSTOR otherwise.
+ */
+static inline void os_xrstor(struct xregs_state *xstate, u64 mask)
+{
+	u32 lmask = mask;
+	u32 hmask = mask >> 32;
+
+	XSTATE_XRESTORE(xstate, lmask, hmask);
+}
+
+/*
+ * Save xstate to user space xsave area.
+ *
+ * We don't use modified optimization because xrstor/xrstors might track
+ * a different application.
+ *
+ * We don't use compacted format xsave area for backward compatibility for
+ * old applications which don't understand the compacted format of the
+ * xsave area.
+ *
+ * The caller has to zero buf::header before calling this because XSAVE*
+ * does not touch the reserved fields in the header.
+ */
+static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
+{
+	/*
+	 * Include the features which are not xsaved/rstored by the kernel
+	 * internally, e.g. PKRU. That's user space ABI and also required
+	 * to allow the signal handler to modify PKRU.
+	 */
+	u64 mask = xfeatures_mask_uabi();
+	u32 lmask = mask;
+	u32 hmask = mask >> 32;
+	int err;
+
+	stac();
+	XSTATE_OP(XSAVE, buf, lmask, hmask, err);
+	clac();
+
+	return err;
+}
+
+/*
+ * Restore xstate from user space xsave area.
+ */
+static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64 mask)
+{
+	struct xregs_state *xstate = ((__force struct xregs_state *)buf);
+	u32 lmask = mask;
+	u32 hmask = mask >> 32;
+	int err;
+
+	stac();
+	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
+	clac();
+
+	return err;
+}
+
+/*
+ * Restore xstate from kernel space xsave area, return an error code instead of
+ * an exception.
+ */
+static inline int os_xrstor_safe(struct xregs_state *xstate, u64 mask)
+{
+	u32 lmask = mask;
+	u32 hmask = mask >> 32;
+	int err;
+
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
+		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
+	else
+		XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
+
+	return err;
+}
+
+
 #endif
