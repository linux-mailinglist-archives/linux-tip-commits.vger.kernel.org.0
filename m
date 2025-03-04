Return-Path: <linux-tip-commits+bounces-3921-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC9CA4DAE5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15F51882336
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BF3202984;
	Tue,  4 Mar 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0O/E1k/L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OYSYQh99"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF39201103;
	Tue,  4 Mar 2025 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084595; cv=none; b=IlMSbwMlm+GPK30fSl/xmX/dZbSbcf0TdtJclga18bvghr/Lq1wXzO5hu68RhfzY/rrnnARmGrwMcz2Ewd+8lHWJJIZ660SWwXRmqc0NwkVcu6cCMLNzTEluPK5SRfXO9p7XU3IWui611j+c3Xq/I2lP5TuDY7Mm2NQzv+OxBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084595; c=relaxed/simple;
	bh=3mb9uAXNVKn4H9pHkJVqR+l70zEXUaXDQ6orm0Vw+qM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G4oF2La9uZpqmkG07CppVGBHZzeWWVL3ytkjoyyTrR7drWC7jfV70N9vuuONSPJ3UYecc5yGftBslVHwnLG8EHC9fxhmatKF4BX8HkiRuW1uJt86frhhKvhXru4PpcCgFIUbp+0bRYsuYeJ819XEVYYxAN2erRBRP5LzR/98aS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0O/E1k/L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OYSYQh99; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:36:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741084591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKFZvTZv7wmN7gBOzqbT3ZK9405hMwi+Lz/NtWpKgBQ=;
	b=0O/E1k/Llx6uoveVojYl8Ic+WT+Nj9CmgKuvd0TOsCssxkTVlTBzRdDGxh27lC2Yoaefe7
	yUYaeq0oktPQp7NOXle9M57//nLdyl78IaqD0JKeAQfKATFXxR8wNYtWz8l8IXnUghP6s1
	njzRDpVdxYw95vi6YuUUEjCLqERKIYgSV0KkMNCS2iR7pJLIeZ3GQZDKqxzfO9NxaE7bsD
	EY3fcvce73iTm+Ln4vb44xdnXosvxV23l9rRbqUpYXYPw0l4PDGv+ot8TZvjK+gTNTNdsE
	yEknfHuNYRYyn7UPPIVlAbkznTzCfLX1/uOCXpWhDRklzv5C/E+z5zuIU4bRdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741084591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKFZvTZv7wmN7gBOzqbT3ZK9405hMwi+Lz/NtWpKgBQ=;
	b=OYSYQh99fU8xK8Aj4FTHZI/bh/dSKHIf6Qcr67JFMS5uPXLYv9NVrljrFHNoXe3b9hiIeM
	tQloAca/IL7h6MAw==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/percpu: Move top_of_stack to percpu hot section
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303165246.2175811-9-brgerst@gmail.com>
References: <20250303165246.2175811-9-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108459091.14745.18119571714588212427.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     648e4e21fa7ec7fbe34e1fb2ec12b86c3f616b88
Gitweb:        https://git.kernel.org/tip/648e4e21fa7ec7fbe34e1fb2ec12b86c3f616b88
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:43 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:24:28 +01:00

x86/percpu: Move top_of_stack to percpu hot section

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303165246.2175811-9-brgerst@gmail.com
---
 arch/x86/entry/entry_32.S        |  4 ++--
 arch/x86/entry/entry_64.S        |  6 +++---
 arch/x86/entry/entry_64_compat.S |  4 ++--
 arch/x86/include/asm/current.h   |  1 -
 arch/x86/include/asm/percpu.h    |  2 +-
 arch/x86/include/asm/processor.h |  9 +++++++--
 arch/x86/kernel/asm-offsets.c    |  1 -
 arch/x86/kernel/cpu/common.c     |  3 ++-
 arch/x86/kernel/process_32.c     |  4 ++--
 arch/x86/kernel/process_64.c     |  2 +-
 arch/x86/kernel/smpboot.c        |  2 +-
 arch/x86/kernel/vmlinux.lds.S    |  1 +
 12 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 20be575..92c0b4a 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1153,7 +1153,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 * is using the thread stack right now, so it's safe for us to use it.
 	 */
 	movl	%esp, %ebx
-	movl	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %esp
+	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esp
 	call	exc_nmi
 	movl	%ebx, %esp
 
@@ -1217,7 +1217,7 @@ SYM_CODE_START(rewind_stack_and_make_dead)
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
 
-	movl	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %esi
+	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esi
 	leal	-TOP_OF_KERNEL_STACK_PADDING-PTREGS_SIZE(%esi), %esp
 
 	call	make_task_dead
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 49d3b22..f40bdf9 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -92,7 +92,7 @@ SYM_CODE_START(entry_SYSCALL_64)
 	/* tss.sp2 is scratch space. */
 	movq	%rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
-	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 SYM_INNER_LABEL(entry_SYSCALL_64_safe_stack, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
@@ -1168,7 +1168,7 @@ SYM_CODE_START(asm_exc_nmi)
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
-	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 	UNWIND_HINT_IRET_REGS base=%rdx offset=8
 	pushq	5*8(%rdx)	/* pt_regs->ss */
 	pushq	4*8(%rdx)	/* pt_regs->rsp */
@@ -1486,7 +1486,7 @@ SYM_CODE_START_NOALIGN(rewind_stack_and_make_dead)
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
 
-	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rax
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rax
 	leaq	-PTREGS_SIZE(%rax), %rsp
 	UNWIND_HINT_REGS
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index ed0a5f2..a45e112 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -57,7 +57,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 	popq	%rax
 
-	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER_DS		/* pt_regs->ss */
@@ -193,7 +193,7 @@ SYM_CODE_START(entry_SYSCALL_compat)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
 
 	/* Switch to the kernel stack */
-	movq	PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 6fad5a4..3d1b123 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -14,7 +14,6 @@ struct task_struct;
 
 struct pcpu_hot {
 	struct task_struct	*current_task;
-	unsigned long		top_of_stack;
 };
 
 DECLARE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot);
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 60390a0..1ca290b 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -549,7 +549,7 @@ do {									\
  * it is accessed while this_cpu_read_stable() allows the value to be cached.
  * this_cpu_read_stable() is more efficient and can be used if its value
  * is guaranteed to be valid across CPUs.  The current users include
- * pcpu_hot.current_task and pcpu_hot.top_of_stack, both of which are
+ * pcpu_hot.current_task and cpu_current_top_of_stack, both of which are
  * actually per-thread variables implemented as per-CPU variables and
  * thus stable for the duration of the respective task.
  */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 6bb6af0..7a39183 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -422,6 +422,11 @@ DECLARE_PER_CPU_CACHE_HOT(bool, hardirq_stack_inuse);
 DECLARE_PER_CPU_CACHE_HOT(struct irq_stack *, softirq_stack_ptr);
 #endif
 
+DECLARE_PER_CPU_CACHE_HOT(unsigned long, cpu_current_top_of_stack);
+/* const-qualified alias provided by the linker. */
+DECLARE_PER_CPU_CACHE_HOT(const unsigned long __percpu_seg_override,
+			  const_cpu_current_top_of_stack);
+
 #ifdef CONFIG_X86_64
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
@@ -547,9 +552,9 @@ static __always_inline unsigned long current_top_of_stack(void)
 	 *  entry trampoline.
 	 */
 	if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
-		return this_cpu_read_const(const_pcpu_hot.top_of_stack);
+		return this_cpu_read_const(const_cpu_current_top_of_stack);
 
-	return this_cpu_read_stable(pcpu_hot.top_of_stack);
+	return this_cpu_read_stable(cpu_current_top_of_stack);
 }
 
 static __always_inline bool on_thread_stack(void)
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 6fae88f..54ace80 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -107,7 +107,6 @@ static void __used common(void)
 	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
-	OFFSET(X86_top_of_stack, pcpu_hot, top_of_stack);
 	OFFSET(X86_current_task, pcpu_hot, current_task);
 #if IS_ENABLED(CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64)
 	/* Offset for fields in aria_ctx */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index fd224ae..51653e0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2066,7 +2066,6 @@ __setup("setcpuid=", setup_setcpuid);
 
 DEFINE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot) = {
 	.current_task	= &init_task,
-	.top_of_stack	= TOP_OF_INIT_STACK,
 };
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
@@ -2074,6 +2073,8 @@ EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
 DEFINE_PER_CPU_CACHE_HOT(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
+DEFINE_PER_CPU_CACHE_HOT(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
+
 #ifdef CONFIG_X86_64
 /*
  * Note: Do not make this dependant on CONFIG_MITIGATION_CALL_DEPTH_TRACKING
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 2bdab41..8ec44ac 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -190,13 +190,13 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	arch_end_context_switch(next_p);
 
 	/*
-	 * Reload esp0 and pcpu_hot.top_of_stack.  This changes
+	 * Reload esp0 and cpu_current_top_of_stack.  This changes
 	 * current_thread_info().  Refresh the SYSENTER configuration in
 	 * case prev or next is vm86.
 	 */
 	update_task_stack(next_p);
 	refresh_sysenter_cs(next);
-	this_cpu_write(pcpu_hot.top_of_stack,
+	this_cpu_write(cpu_current_top_of_stack,
 		       (unsigned long)task_stack_page(next_p) +
 		       THREAD_SIZE);
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 2f38416..d8f4bce 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -669,7 +669,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	 * Switch the PDA and FPU contexts.
 	 */
 	raw_cpu_write(pcpu_hot.current_task, next_p);
-	raw_cpu_write(pcpu_hot.top_of_stack, task_top_of_stack(next_p));
+	raw_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
 
 	switch_fpu_finish(next_p);
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c5aabdd..c3a26e6 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -832,7 +832,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 
 #ifdef CONFIG_X86_32
 	/* Stack for startup_32 can be just as for start_secondary onwards */
-	per_cpu(pcpu_hot.top_of_stack, cpu) = task_top_of_stack(idle);
+	per_cpu(cpu_current_top_of_stack, cpu) = task_top_of_stack(idle);
 #endif
 	return 0;
 }
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0ef9870..475f671 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -44,6 +44,7 @@ ENTRY(phys_startup_64)
 
 jiffies = jiffies_64;
 const_pcpu_hot = pcpu_hot;
+const_cpu_current_top_of_stack = cpu_current_top_of_stack;
 
 #if defined(CONFIG_X86_64)
 /*

