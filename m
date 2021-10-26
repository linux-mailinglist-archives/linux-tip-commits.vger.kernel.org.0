Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F0A43B6CA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbhJZQTJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbhJZQTF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEA4C061767;
        Tue, 26 Oct 2021 09:16:41 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:16:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635265000;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPu+jYf0mY/aL4cGvxol9erNlIKlD5UhWlWkOOQB+3o=;
        b=Sb1FDoVGeH60cwOrTPy+TNlC8An9HEkbaIWv5CAqCPACcHSXvMtkzIO2ivb+e7E9sxCzPV
        XF8vLUqsCwiTeuuIwiTLvC2RpPLPXCC4lLAB+5OTanfm7sf0CXPbYuf4rfDA/S7PXDgoeZ
        m27o9OPVR1gmb0XRDgYRhKlmdA18S+etb6WCji5P5ctT3kO1YgjjztF4HPqWIOaeDnhtYY
        Rpw710de75q96dpzfN5/CK9s3W8F7Zx7pnEXvlxKs+IUfdP+OiKyt5vcwnIvJ+v+6Xq/+k
        WbTeg3hbqdYmLXRgJFvXrxbv5MaESVuiO46Mgv7/OP9UXhOC7KN+nEHZruWzxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635265000;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPu+jYf0mY/aL4cGvxol9erNlIKlD5UhWlWkOOQB+3o=;
        b=xOoRcyEc3OHR6RPDH97M3EAUPCFxTT87M8b2gqHPwXb9dS7IkmjrdVGJRT8oFXYP6LVP1I
        qPq+UR6TTRxbZUCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Add sanity checks for XFD
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-16-chang.seok.bae@intel.com>
References: <20211021225527.10184-16-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526499912.626.10125840061859248991.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     5529acf47ec31ece0815f69d43f5e6a1e485a0f3
Gitweb:        https://git.kernel.org/tip/5529acf47ec31ece0815f69d43f5e6a1e485a0f3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 Oct 2021 15:55:19 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:52:35 +02:00

x86/fpu: Add sanity checks for XFD

Add debug functionality to ensure that the XFD MSR is up to date for XSAVE*
and XRSTOR* operations.

 [ tglx: Improve comment. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211021225527.10184-16-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/core.c   |  9 ++---
 arch/x86/kernel/fpu/signal.c |  6 ++--
 arch/x86/kernel/fpu/xstate.c | 58 +++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/fpu/xstate.h | 34 ++++++++++++++++++---
 4 files changed, 95 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 3b72cdd..b5f5b08 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -166,7 +166,7 @@ void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask)
 		 */
 		mask = fpu_kernel_cfg.max_features & mask;
 
-		os_xrstor(&fpstate->regs.xsave, mask);
+		os_xrstor(fpstate, mask);
 	} else {
 		if (use_fxsr())
 			fxrstor(&fpstate->regs.fxsave);
@@ -534,7 +534,7 @@ void fpu__drop(struct fpu *fpu)
 static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
 {
 	if (use_xsave())
-		os_xrstor(&init_fpstate.regs.xsave, features_mask);
+		os_xrstor(&init_fpstate, features_mask);
 	else if (use_fxsr())
 		fxrstor(&init_fpstate.regs.fxsave);
 	else
@@ -591,9 +591,8 @@ void fpu__clear_user_states(struct fpu *fpu)
 	 * corresponding registers.
 	 */
 	if (xfeatures_mask_supervisor() &&
-	    !fpregs_state_valid(fpu, smp_processor_id())) {
-		os_xrstor(&fpu->fpstate->regs.xsave, xfeatures_mask_supervisor());
-	}
+	    !fpregs_state_valid(fpu, smp_processor_id()))
+		os_xrstor_supervisor(fpu->fpstate);
 
 	/* Reset user states in registers. */
 	restore_fpregs_from_init_fpstate(XFEATURE_MASK_USER_RESTORE);
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 3b7f7d0..16fdecd 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -261,7 +261,7 @@ static int __restore_fpregs_from_user(void __user *buf, u64 ufeatures,
 			ret = fxrstor_from_user_sigframe(buf);
 
 		if (!ret && unlikely(init_bv))
-			os_xrstor(&init_fpstate.regs.xsave, init_bv);
+			os_xrstor(&init_fpstate, init_bv);
 		return ret;
 	} else if (use_fxsr()) {
 		return fxrstor_from_user_sigframe(buf);
@@ -322,7 +322,7 @@ retry:
 	 * been restored from a user buffer directly.
 	 */
 	if (test_thread_flag(TIF_NEED_FPU_LOAD) && xfeatures_mask_supervisor())
-		os_xrstor(&fpu->fpstate->regs.xsave, xfeatures_mask_supervisor());
+		os_xrstor_supervisor(fpu->fpstate);
 
 	fpregs_mark_activate();
 	fpregs_unlock();
@@ -432,7 +432,7 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		u64 mask = user_xfeatures | xfeatures_mask_supervisor();
 
 		fpregs->xsave.header.xfeatures &= mask;
-		success = !os_xrstor_safe(&fpregs->xsave,
+		success = !os_xrstor_safe(fpu->fpstate,
 					  fpu_kernel_cfg.max_features);
 	} else {
 		success = !fxrstor_safe(&fpregs->fxsave);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index bf42ee2..603edeb 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1301,6 +1301,64 @@ EXPORT_SYMBOL_GPL(fpstate_clear_xstate_component);
 #endif
 
 #ifdef CONFIG_X86_64
+
+#ifdef CONFIG_X86_DEBUG_FPU
+/*
+ * Ensure that a subsequent XSAVE* or XRSTOR* instruction with RFBM=@mask
+ * can safely operate on the @fpstate buffer.
+ */
+static bool xstate_op_valid(struct fpstate *fpstate, u64 mask, bool rstor)
+{
+	u64 xfd = __this_cpu_read(xfd_state);
+
+	if (fpstate->xfd == xfd)
+		return true;
+
+	 /*
+	  * The XFD MSR does not match fpstate->xfd. That's invalid when
+	  * the passed in fpstate is current's fpstate.
+	  */
+	if (fpstate->xfd == current->thread.fpu.fpstate->xfd)
+		return false;
+
+	/*
+	 * XRSTOR(S) from init_fpstate are always correct as it will just
+	 * bring all components into init state and not read from the
+	 * buffer. XSAVE(S) raises #PF after init.
+	 */
+	if (fpstate == &init_fpstate)
+		return rstor;
+
+	/*
+	 * XSAVE(S): clone(), fpu_swap_kvm_fpu()
+	 * XRSTORS(S): fpu_swap_kvm_fpu()
+	 */
+
+	/*
+	 * No XSAVE/XRSTOR instructions (except XSAVE itself) touch
+	 * the buffer area for XFD-disabled state components.
+	 */
+	mask &= ~xfd;
+
+	/*
+	 * Remove features which are valid in fpstate. They
+	 * have space allocated in fpstate.
+	 */
+	mask &= ~fpstate->xfeatures;
+
+	/*
+	 * Any remaining state components in 'mask' might be written
+	 * by XSAVE/XRSTOR. Fail validation it found.
+	 */
+	return !mask;
+}
+
+void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor)
+{
+	WARN_ON_ONCE(!xstate_op_valid(fpstate, mask, rstor));
+}
+#endif /* CONFIG_X86_DEBUG_FPU */
+
 static int validate_sigaltstack(unsigned int usize)
 {
 	struct task_struct *thread, *leader = current->group_leader;
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 32a4dee..2902424 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -130,6 +130,12 @@ static inline u64 xfeatures_mask_independent(void)
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
+#if defined(CONFIG_X86_64) && defined(CONFIG_X86_DEBUG_FPU)
+extern void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor);
+#else
+static inline void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor) { }
+#endif
+
 /*
  * Save processor xstate to xsave area.
  *
@@ -144,6 +150,7 @@ static inline void os_xsave(struct fpstate *fpstate)
 	int err;
 
 	WARN_ON_FPU(!alternatives_patched);
+	xfd_validate_state(fpstate, mask, false);
 
 	XSTATE_XSAVE(&fpstate->regs.xsave, lmask, hmask, err);
 
@@ -156,12 +163,23 @@ static inline void os_xsave(struct fpstate *fpstate)
  *
  * Uses XRSTORS when XSAVES is used, XRSTOR otherwise.
  */
-static inline void os_xrstor(struct xregs_state *xstate, u64 mask)
+static inline void os_xrstor(struct fpstate *fpstate, u64 mask)
+{
+	u32 lmask = mask;
+	u32 hmask = mask >> 32;
+
+	xfd_validate_state(fpstate, mask, true);
+	XSTATE_XRESTORE(&fpstate->regs.xsave, lmask, hmask);
+}
+
+/* Restore of supervisor state. Does not require XFD */
+static inline void os_xrstor_supervisor(struct fpstate *fpstate)
 {
+	u64 mask = xfeatures_mask_supervisor();
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 
-	XSTATE_XRESTORE(xstate, lmask, hmask);
+	XSTATE_XRESTORE(&fpstate->regs.xsave, lmask, hmask);
 }
 
 /*
@@ -184,11 +202,14 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 	 * internally, e.g. PKRU. That's user space ABI and also required
 	 * to allow the signal handler to modify PKRU.
 	 */
-	u64 mask = current->thread.fpu.fpstate->user_xfeatures;
+	struct fpstate *fpstate = current->thread.fpu.fpstate;
+	u64 mask = fpstate->user_xfeatures;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
 
+	xfd_validate_state(fpstate, mask, false);
+
 	stac();
 	XSTATE_OP(XSAVE, buf, lmask, hmask, err);
 	clac();
@@ -206,6 +227,8 @@ static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64 
 	u32 hmask = mask >> 32;
 	int err;
 
+	xfd_validate_state(current->thread.fpu.fpstate, mask, true);
+
 	stac();
 	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
 	clac();
@@ -217,12 +240,15 @@ static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64 
  * Restore xstate from kernel space xsave area, return an error code instead of
  * an exception.
  */
-static inline int os_xrstor_safe(struct xregs_state *xstate, u64 mask)
+static inline int os_xrstor_safe(struct fpstate *fpstate, u64 mask)
 {
+	struct xregs_state *xstate = &fpstate->regs.xsave;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
 
+	/* Must enforce XFD update here */
+
 	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
 		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
 	else
