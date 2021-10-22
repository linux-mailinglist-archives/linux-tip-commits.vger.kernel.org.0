Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268E9437EE3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Oct 2021 21:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbhJVT6x (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Oct 2021 15:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbhJVT6u (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Oct 2021 15:58:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC59C061767;
        Fri, 22 Oct 2021 12:56:31 -0700 (PDT)
Date:   Fri, 22 Oct 2021 19:56:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634932590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7CEGLW7uPhfbNG7kRBCtRC3CQgg9vGVyqNxzdGgaWbs=;
        b=fABSWrYHDtduF9R/om3C3oPZ6y8ImA4sj9QxNRuw0Yq3myltt8PQJKr3gTgpF8AW8eRTJU
        8EA2sP7Ah1RZRUAFxxRogeed3b2Ql1b7sgwkmcj0ez8Hy8+GImpA3VZAyf6+WzcReTindI
        fZ8jcsSIJm7cLmgjUWowR7vqzCQRd55ja5IKm3JbRH18oWdDmWLhHu19tXQh7CnDzgJrON
        OKonFVpgdPtab1Np/+X4X+G+8UXkiwKdqd9HS8bLhluLiuzwvuE+430qq1+dTY6Ha8iiJk
        dbzEw23bEMQ2ZiaCil9fky7G1Wfb/Vf/opsjK5qJX1fG+TtqMx2xg91RNBnJiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634932590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7CEGLW7uPhfbNG7kRBCtRC3CQgg9vGVyqNxzdGgaWbs=;
        b=276bPz3fvr64IyNH40xm9L/HHvoRWQpv5lJWJ+Dd3uwYHX87uvK4DrNMKb28sng2DhMny4
        Dy3X4TBj44jrTkBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Move xstate size to fpu_*_cfg
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211014230739.296830097@linutronix.de>
References: <20211014230739.296830097@linutronix.de>
MIME-Version: 1.0
Message-ID: <163493258960.626.5345204742295306160.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     2bd264bce238cedbf00bde1f28ad51ba45b9114e
Gitweb:        https://git.kernel.org/tip/2bd264bce238cedbf00bde1f28ad51ba45b9114e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 01:09:34 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 19:38:55 +02:00

x86/fpu: Move xstate size to fpu_*_cfg

Use the new kernel and user space config storage to store and retrieve the
XSTATE buffer sizes. The default and the maximum size are the same for now,
but will change when support for dynamically enabled features is added.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211014230739.296830097@linutronix.de
---
 arch/x86/kernel/fpu/core.c     |  8 ++++----
 arch/x86/kernel/fpu/init.c     | 31 ++++++++++++++-----------------
 arch/x86/kernel/fpu/internal.h |  2 --
 arch/x86/kernel/fpu/regset.c   |  2 +-
 arch/x86/kernel/fpu/signal.c   |  6 +++---
 arch/x86/kernel/fpu/xstate.c   | 32 ++++++++++++++++++--------------
 arch/x86/kernel/fpu/xstate.h   |  2 +-
 7 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 3512bb2..69abf3a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -298,7 +298,7 @@ void fpu_sync_fpstate(struct fpu *fpu)
 static inline unsigned int init_fpstate_copy_size(void)
 {
 	if (!use_xsave())
-		return fpu_kernel_xstate_size;
+		return fpu_kernel_cfg.default_size;
 
 	/* XSAVE(S) just needs the legacy and the xstate header part */
 	return sizeof(init_fpstate.regs.xsave);
@@ -347,8 +347,8 @@ void fpstate_reset(struct fpu *fpu)
 	fpu->fpstate = &fpu->__fpstate;
 
 	/* Initialize sizes and feature masks */
-	fpu->fpstate->size		= fpu_kernel_xstate_size;
-	fpu->fpstate->user_size		= fpu_user_xstate_size;
+	fpu->fpstate->size		= fpu_kernel_cfg.default_size;
+	fpu->fpstate->user_size		= fpu_user_cfg.default_size;
 	fpu->fpstate->xfeatures		= xfeatures_mask_all;
 	fpu->fpstate->user_xfeatures	= xfeatures_mask_uabi();
 }
@@ -420,7 +420,7 @@ int fpu_clone(struct task_struct *dst)
 void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
 {
 	*offset = offsetof(struct thread_struct, fpu.__fpstate.regs);
-	*size = fpu_kernel_xstate_size;
+	*size = fpu_kernel_cfg.default_size;
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index c9293ad..58043ed 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -133,14 +133,6 @@ static void __init fpu__init_system_generic(void)
 	fpu__init_system_mxcsr();
 }
 
-/*
- * Size of the FPU context state. All tasks in the system use the
- * same context size, regardless of what portion they use.
- * This is inherent to the XSAVE architecture which puts all state
- * components into a single, continuous memory block:
- */
-unsigned int fpu_kernel_xstate_size __ro_after_init;
-
 /* Get alignment of the TYPE. */
 #define TYPE_ALIGN(TYPE) offsetof(struct { char x; TYPE test; }, test)
 
@@ -171,7 +163,7 @@ static void __init fpu__init_task_struct_size(void)
 	 * Add back the dynamically-calculated register state
 	 * size.
 	 */
-	task_size += fpu_kernel_xstate_size;
+	task_size += fpu_kernel_cfg.default_size;
 
 	/*
 	 * We dynamically size 'struct fpu', so we require that
@@ -195,25 +187,30 @@ static void __init fpu__init_task_struct_size(void)
  */
 static void __init fpu__init_system_xstate_size_legacy(void)
 {
+	unsigned int size;
+
 	/*
-	 * Note that xstate sizes might be overwritten later during
-	 * fpu__init_system_xstate().
+	 * Note that the size configuration might be overwritten later
+	 * during fpu__init_system_xstate().
 	 */
 	if (!cpu_feature_enabled(X86_FEATURE_FPU))
-		fpu_kernel_xstate_size = sizeof(struct swregs_state);
+		size = sizeof(struct swregs_state);
 	else if (cpu_feature_enabled(X86_FEATURE_FXSR))
-		fpu_kernel_xstate_size = sizeof(struct fxregs_state);
+		size = sizeof(struct fxregs_state);
 	else
-		fpu_kernel_xstate_size = sizeof(struct fregs_state);
+		size = sizeof(struct fregs_state);
 
-	fpu_user_xstate_size = fpu_kernel_xstate_size;
+	fpu_kernel_cfg.max_size = size;
+	fpu_kernel_cfg.default_size = size;
+	fpu_user_cfg.max_size = size;
+	fpu_user_cfg.default_size = size;
 	fpstate_reset(&current->thread.fpu);
 }
 
 static void __init fpu__init_init_fpstate(void)
 {
 	/* Bring init_fpstate size and features up to date */
-	init_fpstate.size		= fpu_kernel_xstate_size;
+	init_fpstate.size		= fpu_kernel_cfg.max_size;
 	init_fpstate.xfeatures		= xfeatures_mask_all;
 }
 
@@ -234,7 +231,7 @@ void __init fpu__init_system(struct cpuinfo_x86 *c)
 
 	fpu__init_system_generic();
 	fpu__init_system_xstate_size_legacy();
-	fpu__init_system_xstate();
+	fpu__init_system_xstate(fpu_kernel_cfg.max_size);
 	fpu__init_task_struct_size();
 	fpu__init_init_fpstate();
 }
diff --git a/arch/x86/kernel/fpu/internal.h b/arch/x86/kernel/fpu/internal.h
index 5c4f71f..e1d8a35 100644
--- a/arch/x86/kernel/fpu/internal.h
+++ b/arch/x86/kernel/fpu/internal.h
@@ -2,8 +2,6 @@
 #ifndef __X86_KERNEL_FPU_INTERNAL_H
 #define __X86_KERNEL_FPU_INTERNAL_H
 
-extern unsigned int fpu_kernel_xstate_size;
-extern unsigned int fpu_user_xstate_size;
 extern struct fpstate init_fpstate;
 
 /* CPU feature check wrappers */
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index f8c485a..437d7c9 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -153,7 +153,7 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	/*
 	 * A whole standard-format XSAVE buffer is needed:
 	 */
-	if (pos != 0 || count != fpu_user_xstate_size)
+	if (pos != 0 || count != fpu_user_cfg.max_size)
 		return -EFAULT;
 
 	if (!kbuf) {
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index f9af174..fab4403 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -503,7 +503,7 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 
 unsigned long __init fpu__get_fpstate_size(void)
 {
-	unsigned long ret = fpu_user_xstate_size;
+	unsigned long ret = fpu_user_cfg.max_size;
 
 	if (use_xsave())
 		ret += FP_XSTATE_MAGIC2_SIZE;
@@ -531,12 +531,12 @@ unsigned long __init fpu__get_fpstate_size(void)
  */
 void __init fpu__init_prepare_fx_sw_frame(void)
 {
-	int size = fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE;
+	int size = fpu_user_cfg.default_size + FP_XSTATE_MAGIC2_SIZE;
 
 	fx_sw_reserved.magic1 = FP_XSTATE_MAGIC1;
 	fx_sw_reserved.extended_size = size;
 	fx_sw_reserved.xfeatures = xfeatures_mask_uabi();
-	fx_sw_reserved.xstate_size = fpu_user_xstate_size;
+	fx_sw_reserved.xstate_size = fpu_user_cfg.default_size;
 
 	if (IS_ENABLED(CONFIG_IA32_EMULATION) ||
 	    IS_ENABLED(CONFIG_X86_32)) {
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c5582bd..94f5e37 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -78,13 +78,6 @@ static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] __ro_after_init
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 
 /*
- * The XSAVE area of kernel can be in standard or compacted format;
- * it is always in standard format for user mode. This is the user
- * mode standard format size used for signal and ptrace frames.
- */
-unsigned int fpu_user_xstate_size __ro_after_init;
-
-/*
  * Return whether the system supports a given xfeature.
  *
  * Also return the name of the (most advanced) feature that the caller requested:
@@ -716,8 +709,11 @@ static int __init init_xstate_size(void)
 	if (!paranoid_xstate_size_valid(kernel_size))
 		return -EINVAL;
 
-	fpu_kernel_xstate_size = kernel_size;
-	fpu_user_xstate_size = user_size;
+	/* Keep it the same for now */
+	fpu_kernel_cfg.max_size = kernel_size;
+	fpu_kernel_cfg.default_size = kernel_size;
+	fpu_user_cfg.max_size = user_size;
+	fpu_user_cfg.default_size = user_size;
 
 	return 0;
 }
@@ -726,11 +722,18 @@ static int __init init_xstate_size(void)
  * We enabled the XSAVE hardware, but something went wrong and
  * we can not use it.  Disable it.
  */
-static void __init fpu__init_disable_system_xstate(void)
+static void __init fpu__init_disable_system_xstate(unsigned int legacy_size)
 {
 	xfeatures_mask_all = 0;
 	cr4_clear_bits(X86_CR4_OSXSAVE);
 	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
+
+	/* Restore the legacy size.*/
+	fpu_kernel_cfg.max_size = legacy_size;
+	fpu_kernel_cfg.default_size = legacy_size;
+	fpu_user_cfg.max_size = legacy_size;
+	fpu_user_cfg.default_size = legacy_size;
+
 	fpstate_reset(&current->thread.fpu);
 }
 
@@ -738,7 +741,7 @@ static void __init fpu__init_disable_system_xstate(void)
  * Enable and initialize the xsave feature.
  * Called once per system bootup.
  */
-void __init fpu__init_system_xstate(void)
+void __init fpu__init_system_xstate(unsigned int legacy_size)
 {
 	unsigned int eax, ebx, ecx, edx;
 	u64 xfeatures;
@@ -810,7 +813,8 @@ void __init fpu__init_system_xstate(void)
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
 	 */
-	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_uabi());
+	update_regset_xstate_info(fpu_user_cfg.max_size,
+				  xfeatures_mask_uabi());
 
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
@@ -830,13 +834,13 @@ void __init fpu__init_system_xstate(void)
 	print_xstate_offset_size();
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
 		xfeatures_mask_all,
-		fpu_kernel_xstate_size,
+		fpu_kernel_cfg.max_size,
 		boot_cpu_has(X86_FEATURE_XSAVES) ? "compacted" : "standard");
 	return;
 
 out_disable:
 	/* something went wrong, try to boot without any XSAVE support */
-	fpu__init_disable_system_xstate();
+	fpu__init_disable_system_xstate(legacy_size);
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 379dbfa..3d45eb0 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -31,7 +31,7 @@ extern int copy_sigframe_from_user_to_xstate(struct fpstate *fpstate, const void
 
 
 extern void fpu__init_cpu_xstate(void);
-extern void fpu__init_system_xstate(void);
+extern void fpu__init_system_xstate(unsigned int legacy_size);
 
 extern void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 
