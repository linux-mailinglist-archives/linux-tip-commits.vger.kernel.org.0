Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574A179D4E6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Sep 2023 17:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbjILPcK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Sep 2023 11:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbjILPcJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Sep 2023 11:32:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE9710E2;
        Tue, 12 Sep 2023 08:32:05 -0700 (PDT)
Date:   Tue, 12 Sep 2023 15:32:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694532723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PSB/sBxLFbVDwVjJ50yq+m5fPM8HndP/flearF1XETM=;
        b=KKPXKOdQQo+GYuvier4yXC/QbafHtvMChcyoEgeXAiyPgyvj2TRFoO3gXjKir5sd/KAjvs
        8qkO8DiNlRL10sqzFHTwTNIcYB4c1KbWDgW6m2HTqtscdlafl7SqaKQUgmELpObyB9AVUX
        cK1pmcHniRwF3idRJdMIWNhVNPfGslwirFdz7+SsqRGaTq2qQg42shoZaGAcrEc3mQ5aTv
        inLijJJZZxoAUm2/9f1KuCNcDZ9GglrQh604INQAeUWnHv6OKqECkxs4cKGK7smESWoDKn
        0sFWCUu51VjRCnteZeKxNBUoi651hTr1XmnchSFWSIACKQAwW/usXfdk8hg/tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694532723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PSB/sBxLFbVDwVjJ50yq+m5fPM8HndP/flearF1XETM=;
        b=44J5Mc3K8yB4GG8E7IhuxMvoRTfBR5jUnMHs1AXPspmvohISOX/CjcvsRBZ6CqPUvEAGLe
        dEl/Pgma2/EQryDA==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Pass TDCALL/SEAMCALL input/output registers
 via a structure
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169453272314.27769.16658890438965080580.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     57a420bb8186d1d0178b857e5dd5026093641654
Gitweb:        https://git.kernel.org/tip/57a420bb8186d1d0178b857e5dd5026093641654
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Tue, 15 Aug 2023 23:01:59 +12:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 11 Sep 2023 16:33:38 -07:00

x86/tdx: Pass TDCALL/SEAMCALL input/output registers via a structure

Currently, the TDX_MODULE_CALL asm macro, which handles both TDCALL and
SEAMCALL, takes one parameter for each input register and an optional
'struct tdx_module_output' (a collection of output registers) as output.
This is different from the TDX_HYPERCALL macro which uses a single
'struct tdx_hypercall_args' to carry all input/output registers.

The newer TDX versions introduce more TDCALLs/SEAMCALLs which use more
input/output registers.  Also, the TDH.VP.ENTER (which isn't covered
by the current TDX_MODULE_CALL macro) basically can use all registers
that the TDX_HYPERCALL does.  The current TDX_MODULE_CALL macro isn't
extendible to cover those cases.

Similar to the TDX_HYPERCALL macro, simplify the TDX_MODULE_CALL macro
to use a single structure 'struct tdx_module_args' to carry all the
input/output registers.  Currently, R10/R11 are only used as output
register but not as input by any TDCALL/SEAMCALL.  Change to also use
R10/R11 as input register to make input/output registers symmetric.

Currently, the TDX_MODULE_CALL macro depends on the caller to pass a
non-NULL 'struct tdx_module_output' to get additional output registers.
Similar to the TDX_HYPERCALL macro, change the TDX_MODULE_CALL macro to
take a new 'ret' macro argument to indicate whether to save the output
registers to the 'struct tdx_module_args'.  Also introduce a new
__tdcall_ret() for that purpose, similar to the __tdx_hypercall_ret().

Note the tdcall(), which is a wrapper of __tdcall(), is called by three
callers: tdx_parse_tdinfo(), tdx_get_ve_info() and tdx_early_init().
The former two need the additional output but the last one doesn't.  For
simplicity, make tdcall() always call __tdcall_ret() to avoid another
"_ret()" wrapper.  The last caller tdx_early_init() isn't performance
critical anyway.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/483616c1762d85eb3a3c3035a7de061cfacf2f14.1692096753.git.kai.huang%40intel.com
---
 arch/x86/coco/tdx/tdcall.S        | 47 +++++----------
 arch/x86/coco/tdx/tdx-shared.c    |  6 +-
 arch/x86/coco/tdx/tdx.c           | 44 +++++++-------
 arch/x86/include/asm/shared/tdx.h |  8 +--
 arch/x86/kernel/asm-offsets.c     | 12 ++--
 arch/x86/virt/vmx/tdx/tdxcall.S   | 95 ++++++++++++------------------
 6 files changed, 95 insertions(+), 117 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 6aebac0..56b9cd3 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -43,37 +43,10 @@
  * __tdcall()  - Used by TDX guests to request services from the TDX
  * module (does not include VMM services) using TDCALL instruction.
  *
- * Transforms function call register arguments into the TDCALL register ABI.
- * After TDCALL operation, TDX module output is saved in @out (if it is
- * provided by the user).
- *
- *-------------------------------------------------------------------------
- * TDCALL ABI:
- *-------------------------------------------------------------------------
- * Input Registers:
- *
- * RAX                 - TDCALL Leaf number.
- * RCX,RDX,R8-R9       - TDCALL Leaf specific input registers.
- *
- * Output Registers:
- *
- * RAX                 - TDCALL instruction error code.
- * RCX,RDX,R8-R11      - TDCALL Leaf specific output registers.
- *
- *-------------------------------------------------------------------------
- *
  * __tdcall() function ABI:
  *
- * @fn  (RDI)          - TDCALL Leaf ID,    moved to RAX
- * @rcx (RSI)          - Input parameter 1, moved to RCX
- * @rdx (RDX)          - Input parameter 2, moved to RDX
- * @r8  (RCX)          - Input parameter 3, moved to R8
- * @r9  (R8)           - Input parameter 4, moved to R9
- *
- * @out (R9)           - struct tdx_module_output pointer
- *                       stored temporarily in R12 (not
- *                       shared with the TDX module). It
- *                       can be NULL.
+ * @fn   (RDI)	- TDCALL Leaf ID, moved to RAX
+ * @args (RSI)	- struct tdx_module_args for input
  *
  * Return status of TDCALL via RAX.
  */
@@ -82,6 +55,22 @@ SYM_FUNC_START(__tdcall)
 SYM_FUNC_END(__tdcall)
 
 /*
+ * __tdcall_ret() - Used by TDX guests to request services from the TDX
+ * module (does not include VMM services) using TDCALL instruction, with
+ * saving output registers to the 'struct tdx_module_args' used as input.
+ *
+ * __tdcall_ret() function ABI:
+ *
+ * @fn   (RDI)	- TDCALL Leaf ID, moved to RAX
+ * @args (RSI)	- struct tdx_module_args for input and output
+ *
+ * Return status of TDCALL via RAX.
+ */
+SYM_FUNC_START(__tdcall_ret)
+	TDX_MODULE_CALL host=0 ret=1
+SYM_FUNC_END(__tdcall_ret)
+
+/*
  * TDX_HYPERCALL - Make hypercalls to a TDX VMM using TDVMCALL leaf of TDCALL
  * instruction
  *
diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index 90631ab..a7396d0 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -5,7 +5,7 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 				    enum pg_level pg_level)
 {
 	unsigned long accept_size = page_level_size(pg_level);
-	u64 tdcall_rcx;
+	struct tdx_module_args args = {};
 	u8 page_size;
 
 	if (!IS_ALIGNED(start, accept_size))
@@ -34,8 +34,8 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 		return 0;
 	}
 
-	tdcall_rcx = start | page_size;
-	if (__tdcall(TDG_MEM_PAGE_ACCEPT, tdcall_rcx, 0, 0, 0, NULL))
+	args.rcx = start | page_size;
+	if (__tdcall(TDG_MEM_PAGE_ACCEPT, &args))
 		return 0;
 
 	return accept_size;
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 9833c81..0741a9d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -66,10 +66,9 @@ EXPORT_SYMBOL_GPL(tdx_kvm_hypercall);
  * should only be used for calls that have no legitimate reason to fail
  * or where the kernel can not survive the call failing.
  */
-static inline void tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
-			  struct tdx_module_output *out)
+static inline void tdcall(u64 fn, struct tdx_module_args *args)
 {
-	if (__tdcall(fn, rcx, rdx, r8, r9, out))
+	if (__tdcall_ret(fn, args))
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
@@ -89,11 +88,14 @@ static inline void tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
  */
 int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
 {
+	struct tdx_module_args args = {
+		.rcx = virt_to_phys(tdreport),
+		.rdx = virt_to_phys(reportdata),
+		.r8 = TDREPORT_SUBTYPE_0,
+	};
 	u64 ret;
 
-	ret = __tdcall(TDG_MR_REPORT, virt_to_phys(tdreport),
-			virt_to_phys(reportdata), TDREPORT_SUBTYPE_0,
-			0, NULL);
+	ret = __tdcall(TDG_MR_REPORT, &args);
 	if (ret) {
 		if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
 			return -EINVAL;
@@ -141,7 +143,7 @@ static void __noreturn tdx_panic(const char *msg)
 
 static void tdx_parse_tdinfo(u64 *cc_mask)
 {
-	struct tdx_module_output out;
+	struct tdx_module_args args = {};
 	unsigned int gpa_width;
 	u64 td_attr;
 
@@ -152,7 +154,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 * Guest-Host-Communication Interface (GHCI), section 2.4.2 TDCALL
 	 * [TDG.VP.INFO].
 	 */
-	tdcall(TDG_VP_INFO, 0, 0, 0, 0, &out);
+	tdcall(TDG_VP_INFO, &args);
 
 	/*
 	 * The highest bit of a guest physical address is the "sharing" bit.
@@ -161,7 +163,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 * The GPA width that comes out of this call is critical. TDX guests
 	 * can not meaningfully run without it.
 	 */
-	gpa_width = out.rcx & GENMASK(5, 0);
+	gpa_width = args.rcx & GENMASK(5, 0);
 	*cc_mask = BIT_ULL(gpa_width - 1);
 
 	/*
@@ -169,7 +171,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 * memory.  Ensure that no #VE will be delivered for accesses to
 	 * TD-private memory.  Only VMM-shared memory (MMIO) will #VE.
 	 */
-	td_attr = out.rdx;
+	td_attr = args.rdx;
 	if (!(td_attr & ATTR_SEPT_VE_DISABLE)) {
 		const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
 
@@ -577,7 +579,7 @@ __init bool tdx_early_handle_ve(struct pt_regs *regs)
 
 void tdx_get_ve_info(struct ve_info *ve)
 {
-	struct tdx_module_output out;
+	struct tdx_module_args args = {};
 
 	/*
 	 * Called during #VE handling to retrieve the #VE info from the
@@ -594,15 +596,15 @@ void tdx_get_ve_info(struct ve_info *ve)
 	 * Note, the TDX module treats virtual NMIs as inhibited if the #VE
 	 * valid flag is set. It means that NMI=>#VE will not result in a #DF.
 	 */
-	tdcall(TDG_VP_VEINFO_GET, 0, 0, 0, 0, &out);
+	tdcall(TDG_VP_VEINFO_GET, &args);
 
 	/* Transfer the output parameters */
-	ve->exit_reason = out.rcx;
-	ve->exit_qual   = out.rdx;
-	ve->gla         = out.r8;
-	ve->gpa         = out.r9;
-	ve->instr_len   = lower_32_bits(out.r10);
-	ve->instr_info  = upper_32_bits(out.r10);
+	ve->exit_reason = args.rcx;
+	ve->exit_qual   = args.rdx;
+	ve->gla         = args.r8;
+	ve->gpa         = args.r9;
+	ve->instr_len   = lower_32_bits(args.r10);
+	ve->instr_info  = upper_32_bits(args.r10);
 }
 
 /*
@@ -799,6 +801,10 @@ static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 
 void __init tdx_early_init(void)
 {
+	struct tdx_module_args args = {
+		.rdx = TDCS_NOTIFY_ENABLES,
+		.r9 = -1ULL,
+	};
 	u64 cc_mask;
 	u32 eax, sig[3];
 
@@ -814,7 +820,7 @@ void __init tdx_early_init(void)
 	cc_set_mask(cc_mask);
 
 	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
-	tdcall(TDG_VM_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
+	tdcall(TDG_VM_WR, &args);
 
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index c11c0d9..ca8a681 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -76,11 +76,11 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
 void __tdx_hypercall_failed(void);
 
 /*
- * Used in __tdx_module_call() to gather the output registers' values of the
+ * Used in __tdcall*() to gather the input/output registers' values of the
  * TDCALL instruction when requesting services from the TDX module. This is a
  * software only structure and not part of the TDX module/VMM ABI
  */
-struct tdx_module_output {
+struct tdx_module_args {
 	u64 rcx;
 	u64 rdx;
 	u64 r8;
@@ -90,8 +90,8 @@ struct tdx_module_output {
 };
 
 /* Used to communicate with the TDX module */
-u64 __tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
-	     struct tdx_module_output *out);
+u64 __tdcall(u64 fn, struct tdx_module_args *args);
+u64 __tdcall_ret(u64 fn, struct tdx_module_args *args);
 
 bool tdx_accept_memory(phys_addr_t start, phys_addr_t end);
 
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index dc35763..50383bc 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -68,12 +68,12 @@ static void __used common(void)
 #endif
 
 	BLANK();
-	OFFSET(TDX_MODULE_rcx, tdx_module_output, rcx);
-	OFFSET(TDX_MODULE_rdx, tdx_module_output, rdx);
-	OFFSET(TDX_MODULE_r8,  tdx_module_output, r8);
-	OFFSET(TDX_MODULE_r9,  tdx_module_output, r9);
-	OFFSET(TDX_MODULE_r10, tdx_module_output, r10);
-	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
+	OFFSET(TDX_MODULE_rcx, tdx_module_args, rcx);
+	OFFSET(TDX_MODULE_rdx, tdx_module_args, rdx);
+	OFFSET(TDX_MODULE_r8,  tdx_module_args, r8);
+	OFFSET(TDX_MODULE_r9,  tdx_module_args, r9);
+	OFFSET(TDX_MODULE_r10, tdx_module_args, r10);
+	OFFSET(TDX_MODULE_r11, tdx_module_args, r11);
 
 	BLANK();
 	OFFSET(TDX_HYPERCALL_r8,  tdx_hypercall_args, r8);
diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
index 6bdf6e1..e9e19e7 100644
--- a/arch/x86/virt/vmx/tdx/tdxcall.S
+++ b/arch/x86/virt/vmx/tdx/tdxcall.S
@@ -17,34 +17,35 @@
  *            TDX module and hypercalls to the VMM.
  * SEAMCALL - used by TDX hosts to make requests to the
  *            TDX module.
+ *
+ *-------------------------------------------------------------------------
+ * TDCALL/SEAMCALL ABI:
+ *-------------------------------------------------------------------------
+ * Input Registers:
+ *
+ * RAX                 - TDCALL/SEAMCALL Leaf number.
+ * RCX,RDX,R8-R11      - TDCALL/SEAMCALL Leaf specific input registers.
+ *
+ * Output Registers:
+ *
+ * RAX                 - TDCALL/SEAMCALL instruction error code.
+ * RCX,RDX,R8-R11      - TDCALL/SEAMCALL Leaf specific output registers.
+ *
+ *-------------------------------------------------------------------------
  */
-.macro TDX_MODULE_CALL host:req
+.macro TDX_MODULE_CALL host:req ret=0
 	FRAME_BEGIN
-	/*
-	 * R12 will be used as temporary storage for struct tdx_module_output
-	 * pointer. Since R12-R15 registers are not used by TDCALL/SEAMCALL
-	 * services supported by this function, it can be reused.
-	 */
-
-	/* Callee saved, so preserve it */
-	push %r12
-
-	/*
-	 * Push output pointer to stack.
-	 * After the operation, it will be fetched into R12 register.
-	 */
-	push %r9
 
-	/* Mangle function call ABI into TDCALL/SEAMCALL ABI: */
 	/* Move Leaf ID to RAX */
 	mov %rdi, %rax
-	/* Move input 4 to R9 */
-	mov %r8,  %r9
-	/* Move input 3 to R8 */
-	mov %rcx, %r8
-	/* Move input 1 to RCX */
-	mov %rsi, %rcx
-	/* Leave input param 2 in RDX */
+
+	/* Move other input regs from 'struct tdx_module_args' */
+	movq	TDX_MODULE_rcx(%rsi), %rcx
+	movq	TDX_MODULE_rdx(%rsi), %rdx
+	movq	TDX_MODULE_r8(%rsi),  %r8
+	movq	TDX_MODULE_r9(%rsi),  %r9
+	movq	TDX_MODULE_r10(%rsi), %r10
+	movq	TDX_MODULE_r11(%rsi), %r11
 
 .if \host
 	seamcall
@@ -59,49 +60,31 @@
 	 * This value will never be used as actual SEAMCALL error code as
 	 * it is from the Reserved status code class.
 	 */
-	jc .Lseamcall_vmfailinvalid
+	jc .Lseamcall_vmfailinvalid\@
 .else
 	tdcall
 .endif
 
-	/*
-	 * Fetch output pointer from stack to R12 (It is used
-	 * as temporary storage)
-	 */
-	pop %r12
-
-	/*
-	 * Since this macro can be invoked with NULL as an output pointer,
-	 * check if caller provided an output struct before storing output
-	 * registers.
-	 *
-	 * Update output registers, even if the call failed (RAX != 0).
-	 * Other registers may contain details of the failure.
-	 */
-	test %r12, %r12
-	jz .Lout
-
-	/* Copy result registers to output struct: */
-	movq %rcx, TDX_MODULE_rcx(%r12)
-	movq %rdx, TDX_MODULE_rdx(%r12)
-	movq %r8,  TDX_MODULE_r8(%r12)
-	movq %r9,  TDX_MODULE_r9(%r12)
-	movq %r10, TDX_MODULE_r10(%r12)
-	movq %r11, TDX_MODULE_r11(%r12)
-
-.Lout:
-	/* Restore the state of R12 register */
-	pop %r12
+.if \ret
+	/* Copy output registers to the structure */
+	movq %rcx, TDX_MODULE_rcx(%rsi)
+	movq %rdx, TDX_MODULE_rdx(%rsi)
+	movq %r8,  TDX_MODULE_r8(%rsi)
+	movq %r9,  TDX_MODULE_r9(%rsi)
+	movq %r10, TDX_MODULE_r10(%rsi)
+	movq %r11, TDX_MODULE_r11(%rsi)
+.endif
 
+.if \host
+.Lout\@:
+.endif
 	FRAME_END
 	RET
 
 .if \host
-.Lseamcall_vmfailinvalid:
+.Lseamcall_vmfailinvalid\@:
 	mov $TDX_SEAMCALL_VMFAILINVALID, %rax
-	/* pop the unused output pointer back to %r9 */
-	pop %r9
-	jmp .Lout
+	jmp .Lout\@
 .endif	/* \host */
 
 .endm
