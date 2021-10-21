Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5134C436570
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhJUPPC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:15:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60862 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbhJUPOy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:54 -0400
Date:   Thu, 21 Oct 2021 15:12:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829157;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gR+osNqj1n9S3GImJe1Ewloeu6ubLrlRLXgiSnHkHDQ=;
        b=h077Yy0sFatEKtx7vySuA5FUCiSc1vasdzl13+47wEqf2rpBgBR2CewCxTHij2eVvLlt+N
        TnM8orGYSFwWAUGtMycgVofjH6sGg/HnyaWTWYjp7QGWwMEs84X4Gm0+9hzDf1yAhzID8V
        /cQwXEn9uoxbpPQgKFHI3Yjv801uLAxRDi9gfNoUhlNs5jtpTiLy+6u6H4hmQ68/OR9Gr5
        9ZGiKktx7+a+7l14rFuCxhyXC4Okz1eR5I+JzuJOVDEunYgSlQJvbefSdZ5BGmPm7l/BdH
        e972SIhlZn/rJaVzuJSbe/BauVhalu41bVVzhKuFt6bOJZQdmXlMOYz5bGzvgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829157;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gR+osNqj1n9S3GImJe1Ewloeu6ubLrlRLXgiSnHkHDQ=;
        b=JJsabvlSy4fhaIinRekC1eGT3WBeFjqOlqQykA911oLYWZFbB/MYAb3YVOm0EYpVM9ao6f
        O/jsiMYLsGwXklAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Convert fpstate_init() to struct fpstate
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145322.292157401@linutronix.de>
References: <20211013145322.292157401@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482915687.25758.196451508166876614.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     f83ac56acdad0815366bb541b6cc9d24f6cea2b2
Gitweb:        https://git.kernel.org/tip/f83ac56acdad0815366bb541b6cc9d24f6cea2b2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:28 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 22:26:34 +02:00

x86/fpu: Convert fpstate_init() to struct fpstate

Convert fpstate_init() and related code to the new register storage
mechanism in preparation for dynamically sized buffers.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145322.292157401@linutronix.de
---
 arch/x86/kernel/fpu/core.c     | 44 ++++++++++++++++-----------------
 arch/x86/kernel/fpu/internal.h |  4 +--
 arch/x86/kernel/fpu/signal.c   |  2 +-
 arch/x86/kernel/fpu/xstate.c   | 12 ++++-----
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index d764311..19e14b5 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -29,7 +29,7 @@
  * Represents the initial FPU state. It's mostly (but not completely) zeroes,
  * depending on the FPU hardware format:
  */
-union fpregs_state init_fpstate __ro_after_init;
+struct fpstate init_fpstate __ro_after_init;
 
 /*
  * Track whether the kernel is using the FPU state
@@ -157,7 +157,7 @@ void restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
 
 void fpu_reset_from_exception_fixup(void)
 {
-	restore_fpregs_from_fpstate(&init_fpstate, xfeatures_mask_fpstate());
+	restore_fpregs_from_fpstate(&init_fpstate.regs, xfeatures_mask_fpstate());
 }
 
 #if IS_ENABLED(CONFIG_KVM)
@@ -297,24 +297,24 @@ static inline unsigned int init_fpstate_copy_size(void)
 		return fpu_kernel_xstate_size;
 
 	/* XSAVE(S) just needs the legacy and the xstate header part */
-	return sizeof(init_fpstate.xsave);
+	return sizeof(init_fpstate.regs.xsave);
 }
 
-static inline void fpstate_init_fxstate(struct fxregs_state *fx)
+static inline void fpstate_init_fxstate(struct fpstate *fpstate)
 {
-	fx->cwd = 0x37f;
-	fx->mxcsr = MXCSR_DEFAULT;
+	fpstate->regs.fxsave.cwd = 0x37f;
+	fpstate->regs.fxsave.mxcsr = MXCSR_DEFAULT;
 }
 
 /*
  * Legacy x87 fpstate state init:
  */
-static inline void fpstate_init_fstate(struct fregs_state *fp)
+static inline void fpstate_init_fstate(struct fpstate *fpstate)
 {
-	fp->cwd = 0xffff037fu;
-	fp->swd = 0xffff0000u;
-	fp->twd = 0xffffffffu;
-	fp->fos = 0xffff0000u;
+	fpstate->regs.fsave.cwd = 0xffff037fu;
+	fpstate->regs.fsave.swd = 0xffff0000u;
+	fpstate->regs.fsave.twd = 0xffffffffu;
+	fpstate->regs.fsave.fos = 0xffff0000u;
 }
 
 /*
@@ -322,19 +322,19 @@ static inline void fpstate_init_fstate(struct fregs_state *fp)
  * 1) Early boot to setup init_fpstate for non XSAVE systems
  * 2) fpu_init_fpstate_user() which is invoked from KVM
  */
-void fpstate_init_user(union fpregs_state *state)
+void fpstate_init_user(struct fpstate *fpstate)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
-		fpstate_init_soft(&state->soft);
+		fpstate_init_soft(&fpstate->regs.soft);
 		return;
 	}
 
-	xstate_init_xcomp_bv(&state->xsave, xfeatures_mask_uabi());
+	xstate_init_xcomp_bv(&fpstate->regs.xsave, xfeatures_mask_uabi());
 
 	if (cpu_feature_enabled(X86_FEATURE_FXSR))
-		fpstate_init_fxstate(&state->fxsave);
+		fpstate_init_fxstate(fpstate);
 	else
-		fpstate_init_fstate(&state->fsave);
+		fpstate_init_fstate(fpstate);
 }
 
 void fpstate_reset(struct fpu *fpu)
@@ -347,7 +347,7 @@ void fpstate_reset(struct fpu *fpu)
 void fpu_init_fpstate_user(struct fpu *fpu)
 {
 	fpstate_reset(fpu);
-	fpstate_init_user(&fpu->fpstate->regs);
+	fpstate_init_user(fpu->fpstate);
 }
 EXPORT_SYMBOL_GPL(fpu_init_fpstate_user);
 #endif
@@ -378,7 +378,7 @@ int fpu_clone(struct task_struct *dst)
 	 */
 	if (dst->flags & (PF_KTHREAD | PF_IO_WORKER)) {
 		/* Clear out the minimal state */
-		memcpy(&dst_fpu->state, &init_fpstate,
+		memcpy(&dst_fpu->state, &init_fpstate.regs,
 		       init_fpstate_copy_size());
 		return 0;
 	}
@@ -435,11 +435,11 @@ void fpu__drop(struct fpu *fpu)
 static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
 {
 	if (use_xsave())
-		os_xrstor(&init_fpstate.xsave, features_mask);
+		os_xrstor(&init_fpstate.regs.xsave, features_mask);
 	else if (use_fxsr())
-		fxrstor(&init_fpstate.fxsave);
+		fxrstor(&init_fpstate.regs.fxsave);
 	else
-		frstor(&init_fpstate.fsave);
+		frstor(&init_fpstate.regs.fsave);
 
 	pkru_write_default();
 }
@@ -466,7 +466,7 @@ static void fpu_reset_fpstate(void)
 	 * user space as PKRU is eagerly written in switch_to() and
 	 * flush_thread().
 	 */
-	memcpy(&fpu->state, &init_fpstate, init_fpstate_copy_size());
+	memcpy(&fpu->state, &init_fpstate.regs, init_fpstate_copy_size());
 	set_thread_flag(TIF_NEED_FPU_LOAD);
 	fpregs_unlock();
 }
diff --git a/arch/x86/kernel/fpu/internal.h b/arch/x86/kernel/fpu/internal.h
index 63bd75f..e1d8a35 100644
--- a/arch/x86/kernel/fpu/internal.h
+++ b/arch/x86/kernel/fpu/internal.h
@@ -2,7 +2,7 @@
 #ifndef __X86_KERNEL_FPU_INTERNAL_H
 #define __X86_KERNEL_FPU_INTERNAL_H
 
-extern union fpregs_state init_fpstate;
+extern struct fpstate init_fpstate;
 
 /* CPU feature check wrappers */
 static __always_inline __pure bool use_xsave(void)
@@ -25,7 +25,7 @@ static __always_inline __pure bool use_fxsr(void)
 extern void fpu__init_prepare_fx_sw_frame(void);
 
 /* Used in init.c */
-extern void fpstate_init_user(union fpregs_state *state);
+extern void fpstate_init_user(struct fpstate *fpstate);
 extern void fpstate_reset(struct fpu *fpu);
 
 #endif
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 274cd58..416a110 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -243,7 +243,7 @@ static int __restore_fpregs_from_user(void __user *buf, u64 xrestore,
 			ret = fxrstor_from_user_sigframe(buf);
 
 		if (!ret && unlikely(init_bv))
-			os_xrstor(&init_fpstate.xsave, init_bv);
+			os_xrstor(&init_fpstate.regs.xsave, init_bv);
 		return ret;
 	} else if (use_fxsr()) {
 		return fxrstor_from_user_sigframe(buf);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index b022df9..937ad5b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -408,12 +408,12 @@ static void __init setup_init_fpu_buf(void)
 	setup_xstate_features();
 	print_xstate_features();
 
-	xstate_init_xcomp_bv(&init_fpstate.xsave, xfeatures_mask_all);
+	xstate_init_xcomp_bv(&init_fpstate.regs.xsave, xfeatures_mask_all);
 
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
 	 */
-	os_xrstor_booting(&init_fpstate.xsave);
+	os_xrstor_booting(&init_fpstate.regs.xsave);
 
 	/*
 	 * All components are now in init state. Read the state back so
@@ -431,7 +431,7 @@ static void __init setup_init_fpu_buf(void)
 	 * state is all zeroes or if not to add the necessary handling
 	 * here.
 	 */
-	fxsave(&init_fpstate.fxsave);
+	fxsave(&init_fpstate.regs.fxsave);
 }
 
 static int xfeature_uncompacted_offset(int xfeature_nr)
@@ -672,11 +672,11 @@ static unsigned int __init get_xsave_size(void)
  */
 static bool __init is_supported_xstate_size(unsigned int test_xstate_size)
 {
-	if (test_xstate_size <= sizeof(union fpregs_state))
+	if (test_xstate_size <= sizeof(init_fpstate.regs))
 		return true;
 
 	pr_warn("x86/fpu: xstate buffer too small (%zu < %d), disabling xsave\n",
-			sizeof(union fpregs_state), test_xstate_size);
+			sizeof(init_fpstate.regs), test_xstate_size);
 	return false;
 }
 
@@ -981,7 +981,7 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
 			       u32 pkru_val, enum xstate_copy_mode copy_mode)
 {
 	const unsigned int off_mxcsr = offsetof(struct fxregs_state, mxcsr);
-	struct xregs_state *xinit = &init_fpstate.xsave;
+	struct xregs_state *xinit = &init_fpstate.regs.xsave;
 	struct xstate_header header;
 	unsigned int zerofrom;
 	u64 mask;
