Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A956279DCD5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Sep 2023 01:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbjILXo1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Sep 2023 19:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237855AbjILXo0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Sep 2023 19:44:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AA51706;
        Tue, 12 Sep 2023 16:44:22 -0700 (PDT)
Date:   Tue, 12 Sep 2023 23:44:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694562260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=odXp+51aUBligK9fZRbnkNvRABSgY+C/nrO3GkeO9kc=;
        b=PVK+TkN0dw0QKazYCmqdmVFbczOZGj1ef+x+XvPyNWmhze5EP5ISr+yA/Ga8342ayqvmh0
        A4GO6FF4825UQDbo7Zup2kAWq4+Zwp/Gm3UDIuK8CnOD/WZZARhRSSKyn69n0oLtFfbLEC
        Qi7JD4b8pt7ox5wiP7EJfdUOZp90d/q88jWnvJSC876zRbRgmVetQeoR0zRaCO1hgLxzQT
        7uEnycGBtqLTfsnZ6a9ZVRQm10boeIV154mUmbSEK8pmw5e5WDx7/u7X9INuAa3kOCvKuU
        dkgYe6oSbLQ01WZrsFCNdeHe5woWjSvU9S2YHABz+d/GJwnQHtUEQSXO1By/Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694562260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=odXp+51aUBligK9fZRbnkNvRABSgY+C/nrO3GkeO9kc=;
        b=mzvCVfRxzCaw2KMJ9apXc2+ug+yP2bQ2bqDBiMOMHlu5LKdJmas6zPtqm/t0V88uopRGu+
        iQydbJO//6LjhvAA==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Reimplement __tdx_hypercall() using
 TDX_MODULE_CALL asm
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169456226015.27769.14457101647217258187.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     90f5ecd37faed9a59eb2788a56dac8deeee0a508
Gitweb:        https://git.kernel.org/tip/90f5ecd37faed9a59eb2788a56dac8deeee0a508
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Tue, 15 Aug 2023 23:02:02 +12:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 12 Sep 2023 16:30:14 -07:00

x86/tdx: Reimplement __tdx_hypercall() using TDX_MODULE_CALL asm

Now the TDX_HYPERCALL asm is basically identical to the TDX_MODULE_CALL
with both '\saved' and '\ret' enabled, with two minor things though:

1) The way to restore the structure pointer is different

The TDX_HYPERCALL uses RCX as spare to restore the structure pointer,
but the TDX_MODULE_CALL assumes no spare register can be used.  In other
words, TDX_MODULE_CALL already covers what TDX_HYPERCALL does.

2) TDX_MODULE_CALL only clears shared registers for TDH.VP.ENTER

For this just need to make that code available for the non-host case.

Thus, remove the TDX_HYPERCALL and reimplement the __tdx_hypercall()
using the TDX_MODULE_CALL.

Extend the TDX_MODULE_CALL to cover "clear shared registers" for
TDG.VP.VMCALL.  Introduce a new __tdcall_saved_ret() to replace the
temporary __tdcall_hypercall().

The __tdcall_saved_ret() can also be used for those new TDCALLs which
require more input/output registers than the basic TDCALLs do.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/e68a2473fb6f5bcd78b078cae7510e9d0753b3df.1692096753.git.kai.huang%40intel.com
---
 arch/x86/coco/tdx/tdcall.S        | 133 +----------------------------
 arch/x86/coco/tdx/tdx-shared.c    |   4 +-
 arch/x86/include/asm/shared/tdx.h |   2 +-
 arch/x86/virt/vmx/tdx/tdxcall.S   |   8 +-
 4 files changed, 15 insertions(+), 132 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 6d76d7d..52d9786 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm/asm-offsets.h>
 #include <asm/asm.h>
-#include <asm/frame.h>
 
 #include <linux/linkage.h>
 #include <linux/errno.h>
@@ -46,135 +45,19 @@ SYM_FUNC_START(__tdcall_ret)
 SYM_FUNC_END(__tdcall_ret)
 
 /*
- * TDX_HYPERCALL - Make hypercalls to a TDX VMM using TDVMCALL leaf of TDCALL
- * instruction
- *
- * Transforms values in  function call argument struct tdx_module_args @args
- * into the TDCALL register ABI. After TDCALL operation, VMM output is saved
- * back in @args, if \ret is 1.
- *
- * Depends on the caller to pass TDG.VP.VMCALL as the TDCALL leaf, and set
- * @args::rcx to TDVMCALL_EXPOSE_REGS_MASK.
- *
- *-------------------------------------------------------------------------
- * TD VMCALL ABI:
- *-------------------------------------------------------------------------
- *
- * Input Registers:
- *
- * RAX                 - TDCALL instruction leaf number (0 - TDG.VP.VMCALL)
- * RCX                 - BITMAP which controls which part of TD Guest GPR
- *                       is passed as-is to the VMM and back.
- * R10                 - Set 0 to indicate TDCALL follows standard TDX ABI
- *                       specification. Non zero value indicates vendor
- *                       specific ABI.
- * R11                 - VMCALL sub function number
- * RBX, RDX, RDI, RSI  - Used to pass VMCALL sub function specific arguments.
- * R8-R9, R12-R15      - Same as above.
- *
- * Output Registers:
- *
- * RAX                 - TDCALL instruction status (Not related to hypercall
- *                        output).
- * RBX, RDX, RDI, RSI  - Hypercall sub function specific output values.
- * R8-R15              - Same as above.
- *
- */
-.macro TDX_HYPERCALL
-	FRAME_BEGIN
-
-	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
-	push %r15
-	push %r14
-	push %r13
-	push %r12
-	push %rbx
-
-	/* Move Leaf ID to RAX */
-	movq %rdi, %rax
-
-	/* Move bitmap of shared registers to RCX */
-	movq TDX_MODULE_rcx(%rsi), %rcx
-
-	/* Copy hypercall registers from arg struct: */
-	movq TDX_MODULE_r8(%rsi),  %r8
-	movq TDX_MODULE_r9(%rsi),  %r9
-	movq TDX_MODULE_r10(%rsi), %r10
-	movq TDX_MODULE_r11(%rsi), %r11
-	movq TDX_MODULE_r12(%rsi), %r12
-	movq TDX_MODULE_r13(%rsi), %r13
-	movq TDX_MODULE_r14(%rsi), %r14
-	movq TDX_MODULE_r15(%rsi), %r15
-	movq TDX_MODULE_rdi(%rsi), %rdi
-	movq TDX_MODULE_rbx(%rsi), %rbx
-	movq TDX_MODULE_rdx(%rsi), %rdx
-
-	pushq %rsi
-	movq TDX_MODULE_rsi(%rsi), %rsi
-
-	tdcall
-
-	/*
-	 * Restore the pointer of the structure to save output registers.
-	 *
-	 * RCX is used as bitmap of shared registers and doesn't hold any
-	 * value provided by the VMM, thus it can be used as spare to
-	 * restore the structure pointer.
-	 */
-	popq %rcx
-	movq %rsi, TDX_MODULE_rsi(%rcx)
-	movq %rcx, %rsi
-
-	movq %r8,  TDX_MODULE_r8(%rsi)
-	movq %r9,  TDX_MODULE_r9(%rsi)
-	movq %r10, TDX_MODULE_r10(%rsi)
-	movq %r11, TDX_MODULE_r11(%rsi)
-	movq %r12, TDX_MODULE_r12(%rsi)
-	movq %r13, TDX_MODULE_r13(%rsi)
-	movq %r14, TDX_MODULE_r14(%rsi)
-	movq %r15, TDX_MODULE_r15(%rsi)
-	movq %rdi, TDX_MODULE_rdi(%rsi)
-	movq %rbx, TDX_MODULE_rbx(%rsi)
-	movq %rdx, TDX_MODULE_rdx(%rsi)
-
-	/*
-	 * Zero out registers exposed to the VMM to avoid speculative execution
-	 * with VMM-controlled values. This needs to include all registers
-	 * present in TDVMCALL_EXPOSE_REGS_MASK, except RBX, and R12-R15 which
-	 * will be restored.
-	 */
-	xor %r8d,  %r8d
-	xor %r9d,  %r9d
-	xor %r10d, %r10d
-	xor %r11d, %r11d
-	xor %rdi,  %rdi
-	xor %rsi,  %rsi
-	xor %rdx,  %rdx
-
-	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
-	pop %rbx
-	pop %r12
-	pop %r13
-	pop %r14
-	pop %r15
-
-	FRAME_END
-
-	RET
-.endm
-
-/*
+ * __tdcall_saved_ret() - Used by TDX guests to request services from the
+ * TDX module (including VMM services) using TDCALL instruction, with
+ * saving output registers to the 'struct tdx_module_args' used as input.
  *
- * __tdcall_hypercall() function ABI:
+ * __tdcall_saved_ret() function ABI:
  *
  * @fn   (RDI)	- TDCALL leaf ID, moved to RAX
  * @args (RSI)	- struct tdx_module_args for input/output
  *
- * @fn and @args::rcx from the caller must be TDG_VP_VMCALL and
- * TDVMCALL_EXPOSE_REGS_MASK respectively.
+ * All registers in @args are used as input/output registers.
  *
  * On successful completion, return the hypercall error code.
  */
-SYM_FUNC_START(__tdcall_hypercall)
-	TDX_HYPERCALL
-SYM_FUNC_END(__tdcall_hypercall)
+SYM_FUNC_START(__tdcall_saved_ret)
+	TDX_MODULE_CALL host=0 ret=1 saved=1
+SYM_FUNC_END(__tdcall_saved_ret)
diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index b47c8cc..344b381 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -89,11 +89,11 @@ noinstr u64 __tdx_hypercall(struct tdx_hypercall_args *args)
 	};
 
 	/*
-	 * Failure of __tdcall_hypercall() indicates a failure of the TDVMCALL
+	 * Failure of __tdcall_saved_ret() indicates a failure of the TDVMCALL
 	 * mechanism itself and that something has gone horribly wrong with
 	 * the TDX module.  __tdx_hypercall_failed() never returns.
 	 */
-	if (__tdcall_hypercall(TDG_VP_VMCALL, &margs))
+	if (__tdcall_saved_ret(TDG_VP_VMCALL, &margs))
 		__tdx_hypercall_failed();
 
 	args->r8  = margs.r8;
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 85493c4..f53a419 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -83,6 +83,7 @@ struct tdx_module_args {
 /* Used to communicate with the TDX module */
 u64 __tdcall(u64 fn, struct tdx_module_args *args);
 u64 __tdcall_ret(u64 fn, struct tdx_module_args *args);
+u64 __tdcall_saved_ret(u64 fn, struct tdx_module_args *args);
 
 /*
  * Used in __tdx_hypercall() to pass down and get back registers' values of
@@ -106,7 +107,6 @@ struct tdx_hypercall_args {
 };
 
 /* Used to request services from the VMM */
-u64 __tdcall_hypercall(u64 fn, struct tdx_module_args *args);
 u64 __tdx_hypercall(struct tdx_hypercall_args *args);
 
 /*
diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
index c54ea00..3f0b83a 100644
--- a/arch/x86/virt/vmx/tdx/tdxcall.S
+++ b/arch/x86/virt/vmx/tdx/tdxcall.S
@@ -142,10 +142,10 @@
 	movq %r11, TDX_MODULE_r11(%rsi)
 .endif	/* \ret */
 
-.if \host && \saved && \ret
+.if \saved && \ret
 	/*
-	 * Clear registers shared by guest for VP.ENTER to prevent
-	 * speculative use of guest's values, including those are
+	 * Clear registers shared by guest for VP.VMCALL/VP.ENTER to prevent
+	 * speculative use of guest's/VMM's values, including those are
 	 * restored from the stack.
 	 *
 	 * See arch/x86/kvm/vmx/vmenter.S:
@@ -170,7 +170,7 @@
 	xorl %r15d, %r15d
 	xorl %ebx,  %ebx
 	xorl %edi,  %edi
-.endif	/* \host && \ret && \host */
+.endif	/* \ret && \host */
 
 .if \host
 .Lout\@:
