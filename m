Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E07437EE1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Oct 2021 21:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhJVT6v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Oct 2021 15:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbhJVT6t (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Oct 2021 15:58:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC144C061764;
        Fri, 22 Oct 2021 12:56:30 -0700 (PDT)
Date:   Fri, 22 Oct 2021 19:56:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634932588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ymRUo9N14ExxaBx3oMZ+6FjY+N0b4MfbD5pygJwVS8g=;
        b=Njes2g4sKdpjESEA4OSXZy1Wa37XsAV8/UOkyfpXijDt5HgmpV08K5t+KZaUBD20poDlRu
        q8RYtL5PYO6bXJXadp0zOXfhF64DE7/qnoE54wqkl5ys+EWU6Q50gJhjE5kZbZDK27+4m4
        VkEBXC5foSXYGOBbSETPxyKpxeDMQxi7OQLqz+Rr52JIuhOsYJiiNsjMzKFjrIvDXp5sB+
        T16gcqWJzDnTimBFQR06baZNmJG9Z38gDxTVFa/MT10YRd5n3n2J0Qln/XVCGezEgCcm84
        0I5oBrhtvyt1neS9/NnYfE2384XVAVwwZgOjCYllDoCVaYxMai0bDSLjVoy4TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634932588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ymRUo9N14ExxaBx3oMZ+6FjY+N0b4MfbD5pygJwVS8g=;
        b=I1BEosT1Itb73Ztqfrez5JKFG7qFxA/z1Aiq9rPg8eXi9SbzcT0upEJhDgbf03xxhw6iM5
        +8ucrgFdeW55PLBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Rework restore_regs_from_fpstate()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211014230739.461348278@linutronix.de>
References: <20211014230739.461348278@linutronix.de>
MIME-Version: 1.0
Message-ID: <163493258725.626.17966444711717045433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     eda32f4f93b452c5fe3c352523e7f7cc085c8205
Gitweb:        https://git.kernel.org/tip/eda32f4f93b452c5fe3c352523e7f7cc085c8205
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 01:09:38 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 22 Oct 2021 11:09:15 +02:00

x86/fpu: Rework restore_regs_from_fpstate()

xfeatures_mask_fpstate() is no longer valid when dynamically enabled
features come into play.

Rework restore_regs_from_fpstate() so it takes a constant mask which will
then be applied against the maximum feature set so that the restore
operation brings all features which are not in the xsave buffer xfeature
bitmap into init state.

This ensures that if the previous task used a dynamically enabled feature
that the task which restores has all unused components properly initialized.

Cleanup the last user of xfeatures_mask_fpstate() as well and remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211014230739.461348278@linutronix.de
---
 arch/x86/include/asm/fpu/xstate.h | 27 +++++++--------------------
 arch/x86/kernel/fpu/context.h     |  6 +-----
 arch/x86/kernel/fpu/core.c        | 17 ++++++++++++++---
 arch/x86/kernel/fpu/xstate.c      |  2 +-
 4 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 3c890b9..61ae396 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -78,30 +78,17 @@
 				      XFEATURE_MASK_INDEPENDENT | \
 				      XFEATURE_MASK_SUPERVISOR_UNSUPPORTED)
 
-static inline u64 xfeatures_mask_supervisor(void)
-{
-	return fpu_kernel_cfg.max_features & XFEATURE_MASK_SUPERVISOR_SUPPORTED;
-}
-
 /*
- * The xfeatures which are restored by the kernel when returning to user
- * mode. This is not necessarily the same as xfeatures_mask_uabi() as the
- * kernel does not manage all XCR0 enabled features via xsave/xrstor as
- * some of them have to be switched eagerly on context switch and exec().
+ * The feature mask required to restore FPU state:
+ * - All user states which are not eagerly switched in switch_to()/exec()
+ * - The suporvisor states
  */
-static inline u64 xfeatures_mask_restore_user(void)
-{
-	return fpu_kernel_cfg.max_features & XFEATURE_MASK_USER_RESTORE;
-}
+#define XFEATURE_MASK_FPSTATE	(XFEATURE_MASK_USER_RESTORE | \
+				 XFEATURE_MASK_SUPERVISOR_SUPPORTED)
 
-/*
- * Like xfeatures_mask_restore_user() but additionally restors the
- * supported supervisor states.
- */
-static inline u64 xfeatures_mask_fpstate(void)
+static inline u64 xfeatures_mask_supervisor(void)
 {
-	return fpu_kernel_cfg.max_features & \
-		(XFEATURE_MASK_USER_RESTORE | XFEATURE_MASK_SUPERVISOR_SUPPORTED);
+	return fpu_kernel_cfg.max_features & XFEATURE_MASK_SUPERVISOR_SUPPORTED;
 }
 
 static inline u64 xfeatures_mask_independent(void)
diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
index f8f5105..a06ebf3 100644
--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/kernel/fpu/context.h
@@ -61,8 +61,6 @@ static inline void fpregs_restore_userregs(void)
 		return;
 
 	if (!fpregs_state_valid(fpu, cpu)) {
-		u64 mask;
-
 		/*
 		 * This restores _all_ xstate which has not been
 		 * established yet.
@@ -72,9 +70,7 @@ static inline void fpregs_restore_userregs(void)
 		 * flush_thread(). So it is excluded because it might be
 		 * not up to date in current->thread.fpu.xsave state.
 		 */
-		mask = xfeatures_mask_restore_user() |
-			xfeatures_mask_supervisor();
-		restore_fpregs_from_fpstate(fpu->fpstate, mask);
+		restore_fpregs_from_fpstate(fpu->fpstate, XFEATURE_MASK_FPSTATE);
 
 		fpregs_activate(fpu);
 		fpu->last_cpu = cpu;
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 5acc077..0fb9def 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -150,6 +150,17 @@ void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask)
 	}
 
 	if (use_xsave()) {
+		/*
+		 * Restoring state always needs to modify all features
+		 * which are in @mask even if the current task cannot use
+		 * extended features.
+		 *
+		 * So fpstate->xfeatures cannot be used here, because then
+		 * a feature for which the task has no permission but was
+		 * used by the previous task would not go into init state.
+		 */
+		mask = fpu_kernel_cfg.max_features & mask;
+
 		os_xrstor(&fpstate->regs.xsave, mask);
 	} else {
 		if (use_fxsr())
@@ -161,7 +172,7 @@ void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask)
 
 void fpu_reset_from_exception_fixup(void)
 {
-	restore_fpregs_from_fpstate(&init_fpstate, xfeatures_mask_fpstate());
+	restore_fpregs_from_fpstate(&init_fpstate, XFEATURE_MASK_FPSTATE);
 }
 
 #if IS_ENABLED(CONFIG_KVM)
@@ -179,7 +190,7 @@ void fpu_swap_kvm_fpu(struct fpu *save, struct fpu *rstor, u64 restore_mask)
 	}
 
 	if (rstor) {
-		restore_mask &= xfeatures_mask_fpstate();
+		restore_mask &= XFEATURE_MASK_FPSTATE;
 		restore_fpregs_from_fpstate(rstor->fpstate, restore_mask);
 	}
 
@@ -518,7 +529,7 @@ void fpu__clear_user_states(struct fpu *fpu)
 	}
 
 	/* Reset user states in registers. */
-	restore_fpregs_from_init_fpstate(xfeatures_mask_restore_user());
+	restore_fpregs_from_init_fpstate(XFEATURE_MASK_USER_RESTORE);
 
 	/*
 	 * Now all FPU registers have their desired values.  Inform the FPU
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9f92abd..cbba381 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -344,7 +344,7 @@ static void __init print_xstate_offset_size(void)
  */
 static __init void os_xrstor_booting(struct xregs_state *xstate)
 {
-	u64 mask = xfeatures_mask_fpstate();
+	u64 mask = fpu_kernel_cfg.max_features & XFEATURE_MASK_FPSTATE;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
