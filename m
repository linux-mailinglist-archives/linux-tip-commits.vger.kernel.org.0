Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A37436578
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhJUPPK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbhJUPO6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F15C06122C;
        Thu, 21 Oct 2021 08:12:39 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:12:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829158;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EYBH4mN10qyiTvrI0APYt83GPOCeMnbqOSW3aMw9Ec8=;
        b=BDZyrzkwwvn67cUCt1Rv9PK+1Ujq9MShT/l6S339bSpcvcW6HoaBm7ZQhFRDfsB44XDk8C
        zRJCxkVdCbyZHA46wchEcEip4nelhrkk/edGJkXVUJB6tQfy6UzvVo2NQpuUQ6D6YxZiYW
        rJLggwuT7ULROBzlPao8gI/DbxHMOHd+p9SLWrkJTU6Y5N1RCFml/Fp6FElqh9QF8hFjbO
        UTzFiW2YSiC8F3/nFAxdFWyzyBqGT1/UbKOaiykMppUnLjOCs7fIqFpj8+qisc3URQZbze
        Si1mX6VCy2k3RZlrJmqMs9j3xGn/ESWPuQvwfdQZO/2KxG82ZET4hgf236ZMZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829158;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EYBH4mN10qyiTvrI0APYt83GPOCeMnbqOSW3aMw9Ec8=;
        b=mQa4rG2ahTvczql68bEFx4ou4H0tHrZsIJV1/jJQP7j81K7A0zQ/DJh3XhzhkJ7P2MqrF4
        cZ8aeehicJA5o5CQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/core: Convert to fpstate
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145322.659456185@linutronix.de>
References: <20211013145322.659456185@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482915211.25758.2348429991543426049.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     c20942ce5128ef92e2c451f943ba33462ad2fbc4
Gitweb:        https://git.kernel.org/tip/c20942ce5128ef92e2c451f943ba33462ad2fbc4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:39 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 23:54:26 +02:00

x86/fpu/core: Convert to fpstate

Convert the rest of the core code to the new register storage mechanism in
preparation for dynamically sized buffers.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145322.659456185@linutronix.de
---
 arch/x86/include/asm/fpu/api.h |  4 +--
 arch/x86/kernel/fpu/core.c     | 44 +++++++++++++++++----------------
 arch/x86/kernel/fpu/init.c     |  2 +-
 arch/x86/kernel/fpu/xstate.c   |  2 +-
 4 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index a97cf3e..9ce8314 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -50,9 +50,9 @@ static inline void kernel_fpu_begin(void)
 }
 
 /*
- * Use fpregs_lock() while editing CPU's FPU registers or fpu->state.
+ * Use fpregs_lock() while editing CPU's FPU registers or fpu->fpstate.
  * A context switch will (and softirq might) save CPU's FPU registers to
- * fpu->state and set TIF_NEED_FPU_LOAD leaving CPU's FPU registers in
+ * fpu->fpstate.regs and set TIF_NEED_FPU_LOAD leaving CPU's FPU registers in
  * a random state.
  *
  * local_bh_disable() protects against both preemption and soft interrupts
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 03926bf..14560fd 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -89,7 +89,7 @@ bool irq_fpu_usable(void)
 EXPORT_SYMBOL(irq_fpu_usable);
 
 /*
- * Save the FPU register state in fpu->state. The register state is
+ * Save the FPU register state in fpu->fpstate->regs. The register state is
  * preserved.
  *
  * Must be called with fpregs_lock() held.
@@ -105,19 +105,19 @@ EXPORT_SYMBOL(irq_fpu_usable);
 void save_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
-		os_xsave(&fpu->state.xsave);
+		os_xsave(&fpu->fpstate->regs.xsave);
 
 		/*
 		 * AVX512 state is tracked here because its use is
 		 * known to slow the max clock speed of the core.
 		 */
-		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
+		if (fpu->fpstate->regs.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
 			fpu->avx512_timestamp = jiffies;
 		return;
 	}
 
 	if (likely(use_fxsr())) {
-		fxsave(&fpu->state.fxsave);
+		fxsave(&fpu->fpstate->regs.fxsave);
 		return;
 	}
 
@@ -125,8 +125,8 @@ void save_fpregs_to_fpstate(struct fpu *fpu)
 	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
 	 * so we have to reload them from the memory state.
 	 */
-	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->state.fsave));
-	frstor(&fpu->state.fsave);
+	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->fpstate->regs.fsave));
+	frstor(&fpu->fpstate->regs.fsave);
 }
 
 void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask)
@@ -167,7 +167,8 @@ void fpu_swap_kvm_fpu(struct fpu *save, struct fpu *rstor, u64 restore_mask)
 
 	if (save) {
 		if (test_thread_flag(TIF_NEED_FPU_LOAD)) {
-			memcpy(&save->state, &current->thread.fpu.state,
+			memcpy(&save->fpstate->regs,
+			       &current->thread.fpu.fpstate->regs,
 			       fpu_kernel_xstate_size);
 		} else {
 			save_fpregs_to_fpstate(save);
@@ -187,7 +188,7 @@ EXPORT_SYMBOL_GPL(fpu_swap_kvm_fpu);
 void fpu_copy_fpstate_to_kvm_uabi(struct fpu *fpu, void *buf,
 			       unsigned int size, u32 pkru)
 {
-	union fpregs_state *kstate = &fpu->state;
+	union fpregs_state *kstate = &fpu->fpstate->regs;
 	union fpregs_state *ustate = buf;
 	struct membuf mb = { .p = buf, .left = size };
 
@@ -205,7 +206,7 @@ EXPORT_SYMBOL_GPL(fpu_copy_fpstate_to_kvm_uabi);
 int fpu_copy_kvm_uabi_to_fpstate(struct fpu *fpu, const void *buf, u64 xcr0,
 				 u32 *vpkru)
 {
-	union fpregs_state *kstate = &fpu->state;
+	union fpregs_state *kstate = &fpu->fpstate->regs;
 	const union fpregs_state *ustate = buf;
 	struct pkru_state *xpkru;
 	int ret;
@@ -378,7 +379,7 @@ int fpu_clone(struct task_struct *dst)
 	 */
 	if (dst->flags & (PF_KTHREAD | PF_IO_WORKER)) {
 		/* Clear out the minimal state */
-		memcpy(&dst_fpu->state, &init_fpstate.regs,
+		memcpy(&dst_fpu->fpstate->regs, &init_fpstate.regs,
 		       init_fpstate_copy_size());
 		return 0;
 	}
@@ -389,11 +390,12 @@ int fpu_clone(struct task_struct *dst)
 	 * child's FPU context, without any memory-to-memory copying.
 	 */
 	fpregs_lock();
-	if (test_thread_flag(TIF_NEED_FPU_LOAD))
-		memcpy(&dst_fpu->state, &src_fpu->state, fpu_kernel_xstate_size);
-
-	else
+	if (test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		memcpy(&dst_fpu->fpstate->regs, &src_fpu->fpstate->regs,
+		       fpu_kernel_xstate_size);
+	} else {
 		save_fpregs_to_fpstate(dst_fpu);
+	}
 	fpregs_unlock();
 
 	trace_x86_fpu_copy_src(src_fpu);
@@ -466,7 +468,7 @@ static void fpu_reset_fpstate(void)
 	 * user space as PKRU is eagerly written in switch_to() and
 	 * flush_thread().
 	 */
-	memcpy(&fpu->state, &init_fpstate.regs, init_fpstate_copy_size());
+	memcpy(&fpu->fpstate->regs, &init_fpstate.regs, init_fpstate_copy_size());
 	set_thread_flag(TIF_NEED_FPU_LOAD);
 	fpregs_unlock();
 }
@@ -493,7 +495,7 @@ void fpu__clear_user_states(struct fpu *fpu)
 	 */
 	if (xfeatures_mask_supervisor() &&
 	    !fpregs_state_valid(fpu, smp_processor_id())) {
-		os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
+		os_xrstor(&fpu->fpstate->regs.xsave, xfeatures_mask_supervisor());
 	}
 
 	/* Reset user states in registers. */
@@ -574,11 +576,11 @@ int fpu__exception_code(struct fpu *fpu, int trap_nr)
 		 * fully reproduce the context of the exception.
 		 */
 		if (boot_cpu_has(X86_FEATURE_FXSR)) {
-			cwd = fpu->state.fxsave.cwd;
-			swd = fpu->state.fxsave.swd;
+			cwd = fpu->fpstate->regs.fxsave.cwd;
+			swd = fpu->fpstate->regs.fxsave.swd;
 		} else {
-			cwd = (unsigned short)fpu->state.fsave.cwd;
-			swd = (unsigned short)fpu->state.fsave.swd;
+			cwd = (unsigned short)fpu->fpstate->regs.fsave.cwd;
+			swd = (unsigned short)fpu->fpstate->regs.fsave.swd;
 		}
 
 		err = swd & ~cwd;
@@ -592,7 +594,7 @@ int fpu__exception_code(struct fpu *fpu, int trap_nr)
 		unsigned short mxcsr = MXCSR_DEFAULT;
 
 		if (boot_cpu_has(X86_FEATURE_XMM))
-			mxcsr = fpu->state.fxsave.mxcsr;
+			mxcsr = fpu->fpstate->regs.fxsave.mxcsr;
 
 		err = ~(mxcsr >> 7) & mxcsr;
 	}
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 31ecbfb..b524cd0 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -38,7 +38,7 @@ static void fpu__init_cpu_generic(void)
 	/* Flush out any pending x87 state: */
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU))
-		fpstate_init_soft(&current->thread.fpu.state.soft);
+		fpstate_init_soft(&current->thread.fpu.fpstate->regs.soft);
 	else
 #endif
 		asm volatile ("fninit");
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index b1409a7..ca72a3e 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1094,7 +1094,7 @@ out:
 void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 			     enum xstate_copy_mode copy_mode)
 {
-	__copy_xstate_to_uabi_buf(to, &tsk->thread.fpu.state.xsave,
+	__copy_xstate_to_uabi_buf(to, &tsk->thread.fpu.fpstate->regs.xsave,
 				  tsk->thread.pkru, copy_mode);
 }
 
