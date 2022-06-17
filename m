Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C614054FF85
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Jun 2022 23:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbiFQVxf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Jun 2022 17:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiFQVxX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Jun 2022 17:53:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8225F192A7;
        Fri, 17 Jun 2022 14:53:20 -0700 (PDT)
Date:   Fri, 17 Jun 2022 21:53:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655502799;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=94tLLIuj3eVlV6K+upi4isWO6gEhzbqn9S83VO3rXzM=;
        b=QNJzYMTkgX/H43CsvSLs6rIZIHy5QCnECWyhS4RZJsA8jgILVU0g3NUnhrl80eXHduIkmN
        kQx0LjClhDhne/XvBY6O4QjpxZYNCC3iVbc0Y25JEF21tIGcJ8YZkNKPOCaMhGWo88nt8u
        0+tSF/4cymDEZsywjmD2AxvqxwlHu5qmdOLCLbNlHJc714gZTAYEl3ioHOFbk5aocdjYQq
        TCaWFDbW5d0NgfUDmaHmlFqNhMY8FThrvSu7Dm1GloFzHzR/yKePIo7YQKEIImbUvT0JXZ
        Qdli7ESb/uNU6XcbWRWUbvii3ZhzAMUvLS4CCYTBB8Uyca60WrT4yzEg4CAaoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655502799;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=94tLLIuj3eVlV6K+upi4isWO6gEhzbqn9S83VO3rXzM=;
        b=TwqDwKyXlnlYf5EbDf3xM+xJIaoVGWz8JsV9e2TtHReImeeJa+PV9P5szPJOPbIMO05uDe
        9arbl7xI/5EOlZCQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/tdx: Clarify RIP adjustments in #VE handler
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220614120135.14812-3-kirill.shutemov@linux.intel.com>
References: <20220614120135.14812-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <165550279835.4207.11105284912381038768.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     cdd85786f4b3b9273e4376e69aa95a2d71722764
Gitweb:        https://git.kernel.org/tip/cdd85786f4b3b9273e4376e69aa95a2d71722764
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 14 Jun 2022 15:01:34 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 15 Jun 2022 11:05:16 -07:00

x86/tdx: Clarify RIP adjustments in #VE handler

After successful #VE handling, tdx_handle_virt_exception() has to move
RIP to the next instruction. The handler needs to know the length of the
instruction.

If the #VE happened due to instruction execution, the GET_VEINFO TDX
module call provides info on the instruction in R10, including its length.

For #VE due to EPT violation, the info in R10 is not populand and the
kernel must decode the instruction manually to find out its length.

Restructure the code to make it explicit that the instruction length
depends on the type of #VE. Make individual #VE handlers return
the instruction length on success or -errno on failure.

[ dhansen: fix up changelog and comments ]

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220614120135.14812-3-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/tdx/tdx.c | 178 ++++++++++++++++++++++++++-------------
 1 file changed, 123 insertions(+), 55 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index faae53f..c8d44f4 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -124,6 +124,51 @@ static u64 get_cc_mask(void)
 	return BIT_ULL(gpa_width - 1);
 }
 
+/*
+ * The TDX module spec states that #VE may be injected for a limited set of
+ * reasons:
+ *
+ *  - Emulation of the architectural #VE injection on EPT violation;
+ *
+ *  - As a result of guest TD execution of a disallowed instruction,
+ *    a disallowed MSR access, or CPUID virtualization;
+ *
+ *  - A notification to the guest TD about anomalous behavior;
+ *
+ * The last one is opt-in and is not used by the kernel.
+ *
+ * The Intel Software Developer's Manual describes cases when instruction
+ * length field can be used in section "Information for VM Exits Due to
+ * Instruction Execution".
+ *
+ * For TDX, it ultimately means GET_VEINFO provides reliable instruction length
+ * information if #VE occurred due to instruction execution, but not for EPT
+ * violations.
+ */
+static int ve_instr_len(struct ve_info *ve)
+{
+	switch (ve->exit_reason) {
+	case EXIT_REASON_HLT:
+	case EXIT_REASON_MSR_READ:
+	case EXIT_REASON_MSR_WRITE:
+	case EXIT_REASON_CPUID:
+	case EXIT_REASON_IO_INSTRUCTION:
+		/* It is safe to use ve->instr_len for #VE due instructions */
+		return ve->instr_len;
+	case EXIT_REASON_EPT_VIOLATION:
+		/*
+		 * For EPT violations, ve->insn_len is not defined. For those,
+		 * the kernel must decode instructions manually and should not
+		 * be using this function.
+		 */
+		WARN_ONCE(1, "ve->instr_len is not defined for EPT violations");
+		return 0;
+	default:
+		WARN_ONCE(1, "Unexpected #VE-type: %lld\n", ve->exit_reason);
+		return ve->instr_len;
+	}
+}
+
 static u64 __cpuidle __halt(const bool irq_disabled, const bool do_sti)
 {
 	struct tdx_hypercall_args args = {
@@ -147,7 +192,7 @@ static u64 __cpuidle __halt(const bool irq_disabled, const bool do_sti)
 	return __tdx_hypercall(&args, do_sti ? TDX_HCALL_ISSUE_STI : 0);
 }
 
-static bool handle_halt(void)
+static int handle_halt(struct ve_info *ve)
 {
 	/*
 	 * Since non safe halt is mainly used in CPU offlining
@@ -158,9 +203,9 @@ static bool handle_halt(void)
 	const bool do_sti = false;
 
 	if (__halt(irq_disabled, do_sti))
-		return false;
+		return -EIO;
 
-	return true;
+	return ve_instr_len(ve);
 }
 
 void __cpuidle tdx_safe_halt(void)
@@ -180,7 +225,7 @@ void __cpuidle tdx_safe_halt(void)
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
 }
 
-static bool read_msr(struct pt_regs *regs)
+static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_hypercall_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
@@ -194,14 +239,14 @@ static bool read_msr(struct pt_regs *regs)
 	 * (GHCI), section titled "TDG.VP.VMCALL<Instruction.RDMSR>".
 	 */
 	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
-		return false;
+		return -EIO;
 
 	regs->ax = lower_32_bits(args.r11);
 	regs->dx = upper_32_bits(args.r11);
-	return true;
+	return ve_instr_len(ve);
 }
 
-static bool write_msr(struct pt_regs *regs)
+static int write_msr(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_hypercall_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
@@ -215,10 +260,13 @@ static bool write_msr(struct pt_regs *regs)
 	 * can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI) section titled "TDG.VP.VMCALL<Instruction.WRMSR>".
 	 */
-	return !__tdx_hypercall(&args, 0);
+	if (__tdx_hypercall(&args, 0))
+		return -EIO;
+
+	return ve_instr_len(ve);
 }
 
-static bool handle_cpuid(struct pt_regs *regs)
+static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_hypercall_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
@@ -236,7 +284,7 @@ static bool handle_cpuid(struct pt_regs *regs)
 	 */
 	if (regs->ax < 0x40000000 || regs->ax > 0x4FFFFFFF) {
 		regs->ax = regs->bx = regs->cx = regs->dx = 0;
-		return true;
+		return ve_instr_len(ve);
 	}
 
 	/*
@@ -245,7 +293,7 @@ static bool handle_cpuid(struct pt_regs *regs)
 	 * (GHCI), section titled "VP.VMCALL<Instruction.CPUID>".
 	 */
 	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
-		return false;
+		return -EIO;
 
 	/*
 	 * As per TDX GHCI CPUID ABI, r12-r15 registers contain contents of
@@ -257,7 +305,7 @@ static bool handle_cpuid(struct pt_regs *regs)
 	regs->cx = args.r14;
 	regs->dx = args.r15;
 
-	return true;
+	return ve_instr_len(ve);
 }
 
 static bool mmio_read(int size, unsigned long addr, unsigned long *val)
@@ -283,7 +331,7 @@ static bool mmio_write(int size, unsigned long addr, unsigned long val)
 			       EPT_WRITE, addr, val);
 }
 
-static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
+static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 {
 	char buffer[MAX_INSN_SIZE];
 	unsigned long *reg, val;
@@ -294,34 +342,36 @@ static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 
 	/* Only in-kernel MMIO is supported */
 	if (WARN_ON_ONCE(user_mode(regs)))
-		return false;
+		return -EFAULT;
 
 	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
-		return false;
+		return -EFAULT;
 
 	if (insn_decode(&insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
-		return false;
+		return -EINVAL;
 
 	mmio = insn_decode_mmio(&insn, &size);
 	if (WARN_ON_ONCE(mmio == MMIO_DECODE_FAILED))
-		return false;
+		return -EINVAL;
 
 	if (mmio != MMIO_WRITE_IMM && mmio != MMIO_MOVS) {
 		reg = insn_get_modrm_reg_ptr(&insn, regs);
 		if (!reg)
-			return false;
+			return -EINVAL;
 	}
 
-	ve->instr_len = insn.length;
-
 	/* Handle writes first */
 	switch (mmio) {
 	case MMIO_WRITE:
 		memcpy(&val, reg, size);
-		return mmio_write(size, ve->gpa, val);
+		if (!mmio_write(size, ve->gpa, val))
+			return -EIO;
+		return insn.length;
 	case MMIO_WRITE_IMM:
 		val = insn.immediate.value;
-		return mmio_write(size, ve->gpa, val);
+		if (!mmio_write(size, ve->gpa, val))
+			return -EIO;
+		return insn.length;
 	case MMIO_READ:
 	case MMIO_READ_ZERO_EXTEND:
 	case MMIO_READ_SIGN_EXTEND:
@@ -334,15 +384,15 @@ static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 		 * decoded or handled properly. It was likely not using io.h
 		 * helpers or accessed MMIO accidentally.
 		 */
-		return false;
+		return -EINVAL;
 	default:
 		WARN_ONCE(1, "Unknown insn_decode_mmio() decode value?");
-		return false;
+		return -EINVAL;
 	}
 
 	/* Handle reads */
 	if (!mmio_read(size, ve->gpa, &val))
-		return false;
+		return -EIO;
 
 	switch (mmio) {
 	case MMIO_READ:
@@ -364,13 +414,13 @@ static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	default:
 		/* All other cases has to be covered with the first switch() */
 		WARN_ON_ONCE(1);
-		return false;
+		return -EINVAL;
 	}
 
 	if (extend_size)
 		memset(reg, extend_val, extend_size);
 	memcpy(reg, &val, size);
-	return true;
+	return insn.length;
 }
 
 static bool handle_in(struct pt_regs *regs, int size, int port)
@@ -421,13 +471,14 @@ static bool handle_out(struct pt_regs *regs, int size, int port)
  *
  * Return True on success or False on failure.
  */
-static bool handle_io(struct pt_regs *regs, u32 exit_qual)
+static int handle_io(struct pt_regs *regs, struct ve_info *ve)
 {
+	u32 exit_qual = ve->exit_qual;
 	int size, port;
-	bool in;
+	bool in, ret;
 
 	if (VE_IS_IO_STRING(exit_qual))
-		return false;
+		return -EIO;
 
 	in   = VE_IS_IO_IN(exit_qual);
 	size = VE_GET_IO_SIZE(exit_qual);
@@ -435,9 +486,13 @@ static bool handle_io(struct pt_regs *regs, u32 exit_qual)
 
 
 	if (in)
-		return handle_in(regs, size, port);
+		ret = handle_in(regs, size, port);
 	else
-		return handle_out(regs, size, port);
+		ret = handle_out(regs, size, port);
+	if (!ret)
+		return -EIO;
+
+	return ve_instr_len(ve);
 }
 
 /*
@@ -447,17 +502,19 @@ static bool handle_io(struct pt_regs *regs, u32 exit_qual)
 __init bool tdx_early_handle_ve(struct pt_regs *regs)
 {
 	struct ve_info ve;
-	bool ret;
+	int insn_len;
 
 	tdx_get_ve_info(&ve);
 
 	if (ve.exit_reason != EXIT_REASON_IO_INSTRUCTION)
 		return false;
 
-	ret = handle_io(regs, ve.exit_qual);
-	if (ret)
-		regs->ip += ve.instr_len;
-	return ret;
+	insn_len = handle_io(regs, &ve);
+	if (insn_len < 0)
+		return false;
+
+	regs->ip += insn_len;
+	return true;
 }
 
 void tdx_get_ve_info(struct ve_info *ve)
@@ -490,54 +547,65 @@ void tdx_get_ve_info(struct ve_info *ve)
 	ve->instr_info  = upper_32_bits(out.r10);
 }
 
-/* Handle the user initiated #VE */
-static bool virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
+/*
+ * Handle the user initiated #VE.
+ *
+ * On success, returns the number of bytes RIP should be incremented (>=0)
+ * or -errno on error.
+ */
+static int virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
 {
 	switch (ve->exit_reason) {
 	case EXIT_REASON_CPUID:
-		return handle_cpuid(regs);
+		return handle_cpuid(regs, ve);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
-		return false;
+		return -EIO;
 	}
 }
 
-/* Handle the kernel #VE */
-static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
+/*
+ * Handle the kernel #VE.
+ *
+ * On success, returns the number of bytes RIP should be incremented (>=0)
+ * or -errno on error.
+ */
+static int virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 {
 	switch (ve->exit_reason) {
 	case EXIT_REASON_HLT:
-		return handle_halt();
+		return handle_halt(ve);
 	case EXIT_REASON_MSR_READ:
-		return read_msr(regs);
+		return read_msr(regs, ve);
 	case EXIT_REASON_MSR_WRITE:
-		return write_msr(regs);
+		return write_msr(regs, ve);
 	case EXIT_REASON_CPUID:
-		return handle_cpuid(regs);
+		return handle_cpuid(regs, ve);
 	case EXIT_REASON_EPT_VIOLATION:
 		return handle_mmio(regs, ve);
 	case EXIT_REASON_IO_INSTRUCTION:
-		return handle_io(regs, ve->exit_qual);
+		return handle_io(regs, ve);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
-		return false;
+		return -EIO;
 	}
 }
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
 {
-	bool ret;
+	int insn_len;
 
 	if (user_mode(regs))
-		ret = virt_exception_user(regs, ve);
+		insn_len = virt_exception_user(regs, ve);
 	else
-		ret = virt_exception_kernel(regs, ve);
+		insn_len = virt_exception_kernel(regs, ve);
+	if (insn_len < 0)
+		return false;
 
 	/* After successful #VE handling, move the IP */
-	if (ret)
-		regs->ip += ve->instr_len;
+	regs->ip += insn_len;
 
-	return ret;
+	return true;
 }
 
 static bool tdx_tlb_flush_required(bool private)
