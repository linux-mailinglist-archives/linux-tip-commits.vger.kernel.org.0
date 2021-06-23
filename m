Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AC33B2358
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhFWWNw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhFWWMa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:12:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6C0C061767;
        Wed, 23 Jun 2021 15:09:20 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486158;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4M3HQym/VA/dPxsVtloPKiYq61achH+dDBt9ik54ZVw=;
        b=lgpjwexP7LbVk62o3zhz9XPbE3Y71Ce2bCk7pF6uYWhSLDIzqdDG6aco5eAbRT9aUtqO3z
        1cTNfjxQthi5ESHmFI6OqnGmE1VfrIJk+796aVRC2lVF0E/sPgt7PrFwEcJ2Ij+JFX6SvL
        Kg6f49lgYpF7POpSqV4zR8GrDMv4G0BVmHv82eq77gl984i+d99w2XNOoqJozKlDVGpW9O
        QQvN7XJFvozh8ZrnB59gsP5YxLndnTCCeYG91Aedn15NocSTypfzdsRq0+FEz5PUAdk26R
        PkWGC7Sxem/Qbt6zEY366GZakJIbO2VTjDjNB7zOhny6iPmz83AQIEbLuZgc+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486158;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4M3HQym/VA/dPxsVtloPKiYq61achH+dDBt9ik54ZVw=;
        b=quBx46myiaMRd3DQ4UruFg+UZRmETEdlox1rvcxCYejdJM/ML6AK0PjeB/fhLhSAFi0ZYp
        dkfqWXnRyt4k9IAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Get rid of the FNSAVE optimization
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121454.617369268@linutronix.de>
References: <20210623121454.617369268@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448615766.395.9151791237541087678.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     08ded2cd18a09749e67a14426aa7fd1b04ab1dc0
Gitweb:        https://git.kernel.org/tip/08ded2cd18a09749e67a14426aa7fd1b04ab1dc0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:00 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 18:29:41 +02:00

x86/fpu: Get rid of the FNSAVE optimization

The FNSAVE support requires conditionals in quite some call paths because
FNSAVE reinitializes the FPU hardware. If the save has to preserve the FPU
register state then the caller has to conditionally restore it from memory
when FNSAVE is in use.

This also requires a conditional in context switch because the restore
avoidance optimization cannot work with FNSAVE. As this only affects 20+
years old CPUs there is really no reason to keep this optimization
effective for FNSAVE. It's about time to not optimize for antiques anymore.

Just unconditionally FRSTOR the save content to the registers and clean up
the conditionals all over the place.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121454.617369268@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 18 +++++----
 arch/x86/kernel/fpu/core.c          | 54 +++++++++++-----------------
 2 files changed, 34 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 559dd30..3e0eeda 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -83,6 +83,7 @@ extern void fpstate_init_soft(struct swregs_state *soft);
 #else
 static inline void fpstate_init_soft(struct swregs_state *soft) {}
 #endif
+extern void save_fpregs_to_fpstate(struct fpu *fpu);
 
 #define user_insn(insn, output, input...)				\
 ({									\
@@ -375,8 +376,6 @@ static inline int os_xrstor_safe(struct xregs_state *xstate, u64 mask)
 	return err;
 }
 
-extern int save_fpregs_to_fpstate(struct fpu *fpu);
-
 static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask)
 {
 	if (use_xsave()) {
@@ -507,12 +506,17 @@ static inline void __fpregs_load_activate(void)
 static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
 	if (static_cpu_has(X86_FEATURE_FPU) && !(current->flags & PF_KTHREAD)) {
-		if (!save_fpregs_to_fpstate(old_fpu))
-			old_fpu->last_cpu = -1;
-		else
-			old_fpu->last_cpu = cpu;
+		save_fpregs_to_fpstate(old_fpu);
+		/*
+		 * The save operation preserved register state, so the
+		 * fpu_fpregs_owner_ctx is still @old_fpu. Store the
+		 * current CPU number in @old_fpu, so the next return
+		 * to user space can avoid the FPU register restore
+		 * when is returns on the same CPU and still owns the
+		 * context.
+		 */
+		old_fpu->last_cpu = cpu;
 
-		/* But leave fpu_fpregs_owner_ctx! */
 		trace_x86_fpu_regs_deactivated(old_fpu);
 	}
 }
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index dcf4d6b..c290ba2 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -83,16 +83,20 @@ bool irq_fpu_usable(void)
 EXPORT_SYMBOL(irq_fpu_usable);
 
 /*
- * These must be called with preempt disabled. Returns
- * 'true' if the FPU state is still intact and we can
- * keep registers active.
+ * Save the FPU register state in fpu->state. The register state is
+ * preserved.
  *
- * The legacy FNSAVE instruction cleared all FPU state
- * unconditionally, so registers are essentially destroyed.
- * Modern FPU state can be kept in registers, if there are
- * no pending FP exceptions.
+ * Must be called with fpregs_lock() held.
+ *
+ * The legacy FNSAVE instruction clears all FPU state unconditionally, so
+ * register state has to be reloaded. That might be a pointless exercise
+ * when the FPU is going to be used by another task right after that. But
+ * this only affects 20+ years old 32bit systems and avoids conditionals all
+ * over the place.
+ *
+ * FXSAVE and all XSAVE variants preserve the FPU register state.
  */
-int save_fpregs_to_fpstate(struct fpu *fpu)
+void save_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
 		os_xsave(&fpu->state.xsave);
@@ -103,21 +107,20 @@ int save_fpregs_to_fpstate(struct fpu *fpu)
 		 */
 		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
 			fpu->avx512_timestamp = jiffies;
-		return 1;
+		return;
 	}
 
 	if (likely(use_fxsr())) {
 		fxsave(&fpu->state.fxsave);
-		return 1;
+		return;
 	}
 
 	/*
 	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
-	 * so we have to mark them inactive:
+	 * so we have to reload them from the memory state.
 	 */
 	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->state.fsave));
-
-	return 0;
+	frstor(&fpu->state.fsave);
 }
 EXPORT_SYMBOL(save_fpregs_to_fpstate);
 
@@ -133,10 +136,6 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 	if (!(current->flags & PF_KTHREAD) &&
 	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		set_thread_flag(TIF_NEED_FPU_LOAD);
-		/*
-		 * Ignore return value -- we don't care if reg state
-		 * is clobbered.
-		 */
 		save_fpregs_to_fpstate(&current->thread.fpu);
 	}
 	__cpu_invalidate_fpregs_state();
@@ -171,11 +170,8 @@ void fpu__save(struct fpu *fpu)
 	fpregs_lock();
 	trace_x86_fpu_before_save(fpu);
 
-	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		if (!save_fpregs_to_fpstate(fpu)) {
-			copy_kernel_to_fpregs(&fpu->state);
-		}
-	}
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
+		save_fpregs_to_fpstate(fpu);
 
 	trace_x86_fpu_after_save(fpu);
 	fpregs_unlock();
@@ -244,20 +240,16 @@ int fpu__copy(struct task_struct *dst, struct task_struct *src)
 	memset(&dst_fpu->state.xsave, 0, fpu_kernel_xstate_size);
 
 	/*
-	 * If the FPU registers are not current just memcpy() the state.
-	 * Otherwise save current FPU registers directly into the child's FPU
-	 * context, without any memory-to-memory copying.
-	 *
-	 * ( The function 'fails' in the FNSAVE case, which destroys
-	 *   register contents so we have to load them back. )
+	 * If the FPU registers are not owned by current just memcpy() the
+	 * state.  Otherwise save the FPU registers directly into the
+	 * child's FPU context, without any memory-to-memory copying.
 	 */
 	fpregs_lock();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
 		memcpy(&dst_fpu->state, &src_fpu->state, fpu_kernel_xstate_size);
 
-	else if (!save_fpregs_to_fpstate(dst_fpu))
-		copy_kernel_to_fpregs(&dst_fpu->state);
-
+	else
+		save_fpregs_to_fpstate(dst_fpu);
 	fpregs_unlock();
 
 	set_tsk_thread_flag(dst, TIF_NEED_FPU_LOAD);
