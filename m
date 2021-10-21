Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F5D43656F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhJUPPC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:15:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60782 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbhJUPOz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:55 -0400
Date:   Thu, 21 Oct 2021 15:12:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829158;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+gb6VNGWCTMmyqsH1VqpvVdzU/3snC8sU25WjplbZgo=;
        b=EBCAZjzYd+GNACP3Dh+73XcltBHuftlXhkA7pN2FJhLfctP486mg6+VPGd46vjiWOcpQze
        ghQGV7BoL2GebkITQqx7bFpuqrbBWwAzOJVSJVNfOKU0uUoUeSxwDJisXFnwAMCAxhFEZ9
        faiLhVS5a/0dIEALfnIjiVwbbdjkEo3R1TuBgW+Ar5Rv+bxGSf2lm6/xeoxKlUkSJnv2n2
        9VkFG2zx4nHrQvW3CUasqNnR2KyXuGqCH8nyAQNgIL8uKJxTmfesewjqu63Tzy0IWzvNbg
        tzzknJzzvoeDvS5gDaafH3xc8w/s16ljuvuLOInuKQQ5tnjuSJr+3CzB/QJU3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829158;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+gb6VNGWCTMmyqsH1VqpvVdzU/3snC8sU25WjplbZgo=;
        b=44t0Ti+A8DnB+tnQXcJJFt5JPcR+6QuQPPyVLxUie90lvXriBo8NoDkaRPtUvo9rwCVu6a
        QD/bkV72dxS4XXBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Provide struct fpstate
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145322.234458659@linutronix.de>
References: <20211013145322.234458659@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482915760.25758.12256434435144948018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     87d0e5be0fac322f4415128def9f16a71a267a40
Gitweb:        https://git.kernel.org/tip/87d0e5be0fac322f4415128def9f16a71a267a40
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:27 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 22:26:24 +02:00

x86/fpu: Provide struct fpstate

New xfeatures will not longer be automatically stored in the regular XSAVE
buffer in thread_struct::fpu.

The kernel will provide the default sized buffer for storing the regular
features up to AVX512 in thread_struct::fpu and if a task requests to use
one of the new features then the register storage has to be extended.

The state will be accessed via a pointer in thread_struct::fpu which
defaults to the builtin storage and can be switched when extended storage
is required.

To avoid conditionals all over the code, create a new container for the
register storage which will gain other information, e.g. size, feature
masks etc., later. For now it just contains the register storage, which
gives it exactly the same layout as the exiting fpu::state.

Stick fpu::state and the new fpu::__fpstate into an anonymous union and
initialize the pointer. Add build time checks to validate that both are
at the same place and have the same size.

This allows step by step conversion of all users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145322.234458659@linutronix.de
---
 arch/x86/include/asm/fpu/types.h | 20 +++++++++++++++++++-
 arch/x86/include/asm/processor.h |  4 ++--
 arch/x86/kernel/fpu/core.c       | 11 ++++++++++-
 arch/x86/kernel/fpu/init.c       |  9 +++++++--
 arch/x86/kernel/fpu/internal.h   |  1 +
 5 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index f5a38a5..3bb6277 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -309,6 +309,13 @@ union fpregs_state {
 	u8 __padding[PAGE_SIZE];
 };
 
+struct fpstate {
+	/* @regs: The register state union for all supported formats */
+	union fpregs_state		regs;
+
+	/* @regs is dynamically sized! Don't add anything after @regs! */
+} __aligned(64);
+
 /*
  * Highest level per task FPU state data structure that
  * contains the FPU register state plus various FPU
@@ -337,6 +344,14 @@ struct fpu {
 	unsigned long			avx512_timestamp;
 
 	/*
+	 * @fpstate:
+	 *
+	 * Pointer to the active struct fpstate. Initialized to
+	 * point at @__fpstate below.
+	 */
+	struct fpstate			*fpstate;
+
+	/*
 	 * @state:
 	 *
 	 * In-memory copy of all FPU registers that we save/restore
@@ -345,7 +360,10 @@ struct fpu {
 	 * copy. If the task context-switches away then they get
 	 * saved here and represent the FPU state.
 	 */
-	union fpregs_state		state;
+	union {
+		struct fpstate			__fpstate;
+		union fpregs_state		state;
+	};
 	/*
 	 * WARNING: 'state' is dynamically-sized.  Do not put
 	 * anything after it here.
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 9ad2aca..4519d33 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -537,11 +537,11 @@ struct thread_struct {
 	 */
 };
 
-/* Whitelist the FPU state from the task_struct for hardened usercopy. */
+/* Whitelist the FPU register state from the task_struct for hardened usercopy. */
 static inline void arch_thread_struct_whitelist(unsigned long *offset,
 						unsigned long *size)
 {
-	*offset = offsetof(struct thread_struct, fpu.state);
+	*offset = offsetof(struct thread_struct, fpu.__fpstate.regs);
 	*size = fpu_kernel_xstate_size;
 }
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index ac540a7..d764311 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -337,10 +337,17 @@ void fpstate_init_user(union fpregs_state *state)
 		fpstate_init_fstate(&state->fsave);
 }
 
+void fpstate_reset(struct fpu *fpu)
+{
+	/* Set the fpstate pointer to the default fpstate */
+	fpu->fpstate = &fpu->__fpstate;
+}
+
 #if IS_ENABLED(CONFIG_KVM)
 void fpu_init_fpstate_user(struct fpu *fpu)
 {
-	fpstate_init_user(&fpu->state);
+	fpstate_reset(fpu);
+	fpstate_init_user(&fpu->fpstate->regs);
 }
 EXPORT_SYMBOL_GPL(fpu_init_fpstate_user);
 #endif
@@ -354,6 +361,8 @@ int fpu_clone(struct task_struct *dst)
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
 
+	fpstate_reset(dst_fpu);
+
 	if (!cpu_feature_enabled(X86_FEATURE_FPU))
 		return 0;
 
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 2379135..31ecbfb 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -165,7 +165,7 @@ static void __init fpu__init_task_struct_size(void)
 	 * Subtract off the static size of the register state.
 	 * It potentially has a bunch of padding.
 	 */
-	task_size -= sizeof(((struct task_struct *)0)->thread.fpu.state);
+	task_size -= sizeof(current->thread.fpu.__fpstate.regs);
 
 	/*
 	 * Add back the dynamically-calculated register state
@@ -180,10 +180,14 @@ static void __init fpu__init_task_struct_size(void)
 	 * you hit a compile error here, check the structure to
 	 * see if something got added to the end.
 	 */
-	CHECK_MEMBER_AT_END_OF(struct fpu, state);
+	CHECK_MEMBER_AT_END_OF(struct fpu, __fpstate);
 	CHECK_MEMBER_AT_END_OF(struct thread_struct, fpu);
 	CHECK_MEMBER_AT_END_OF(struct task_struct, thread);
 
+	BUILD_BUG_ON(sizeof(struct fpstate) != sizeof(union fpregs_state));
+	BUILD_BUG_ON(offsetof(struct thread_struct, fpu.state) !=
+		     offsetof(struct thread_struct, fpu.__fpstate));
+
 	arch_task_struct_size = task_size;
 }
 
@@ -220,6 +224,7 @@ static void __init fpu__init_system_xstate_size_legacy(void)
  */
 void __init fpu__init_system(struct cpuinfo_x86 *c)
 {
+	fpstate_reset(&current->thread.fpu);
 	fpu__init_system_early_generic(c);
 
 	/*
diff --git a/arch/x86/kernel/fpu/internal.h b/arch/x86/kernel/fpu/internal.h
index 479f2db..63bd75f 100644
--- a/arch/x86/kernel/fpu/internal.h
+++ b/arch/x86/kernel/fpu/internal.h
@@ -26,5 +26,6 @@ extern void fpu__init_prepare_fx_sw_frame(void);
 
 /* Used in init.c */
 extern void fpstate_init_user(union fpregs_state *state);
+extern void fpstate_reset(struct fpu *fpu);
 
 #endif
