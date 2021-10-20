Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CE5434C7F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhJTNrm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhJTNrD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:47:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336DEC06176D;
        Wed, 20 Oct 2021 06:44:43 -0700 (PDT)
Date:   Wed, 20 Oct 2021 13:44:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q2ZAMGy2xlEcBWyDGaYqODxlPpqutMGh79Iys74BZyY=;
        b=h0VyW9FsR81IhEphPEyc22QnxG0SJ0IHKsq+trea8AAjfp/nuVew+HjUsNfp/6Uap/v5Ep
        hRzgwdmV/8Zyb3vI9/xgSPVHqWiHPS/AdAOLoxsaZJx4BD1+w1oMom8tpqGDt1ZE6MvSnB
        D2vy7AmhZ1T0j78CjuKtryIssef1NU+ufi0K3X+OOmwgMm1SmasUGZzXA6wWyAMxq4InEH
        jWYlh7rn5Yo0ZyNSLTbulVPMz3jtUmp2Nfml4O5DAdinO5PfVtl3rUcSJDyQ3LMBOtIf9e
        5G9DBxYk5pNkUzW2EZsEJDAQMzldlkqV/iLTX3Twcc1Zsce7InSaHKSDlTJe+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q2ZAMGy2xlEcBWyDGaYqODxlPpqutMGh79Iys74BZyY=;
        b=Cq7DExBTsXa3V1UrxZWG2ZTfGvd1m6xJZtHFyRl+vf3z7qWjIZEMz91BiPiEWkIVevpwmx
        zgMGftmQ9wL3dSCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Cleanup xstate xcomp_bv initialization
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011538.897664678@linutronix.de>
References: <20211015011538.897664678@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473748096.25758.16931381472086714229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     126fe0401883598b45b34dbbd5e0d7d8a0aefa21
Gitweb:        https://git.kernel.org/tip/126fe0401883598b45b34dbbd5e0d7d8a0aefa21
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:07 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:26 +02:00

x86/fpu: Cleanup xstate xcomp_bv initialization

No point in having this duplicated all over the place with needlessly
different defines.

Provide a proper initialization function which initializes user buffers
properly and make KVM use it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011538.897664678@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h |  4 ++-
 arch/x86/kernel/fpu/core.c          | 35 +++++++++++++++-------------
 arch/x86/kernel/fpu/init.c          |  6 ++---
 arch/x86/kernel/fpu/xstate.c        |  8 ++----
 arch/x86/kernel/fpu/xstate.h        | 18 ++++++++++++++-
 arch/x86/kvm/x86.c                  | 11 ++-------
 6 files changed, 49 insertions(+), 33 deletions(-)
 create mode 100644 arch/x86/kernel/fpu/xstate.h

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 1503750..df57f1a 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -80,7 +80,9 @@ static __always_inline __pure bool use_fxsr(void)
 
 extern union fpregs_state init_fpstate;
 
-extern void fpstate_init(union fpregs_state *state);
+extern void fpstate_init_user(union fpregs_state *state);
+extern void fpu_init_fpstate_user(struct fpu *fpu);
+
 #ifdef CONFIG_MATH_EMULATION
 extern void fpstate_init_soft(struct swregs_state *soft);
 #else
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 9a6b195..0789f0c 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -16,6 +16,8 @@
 #include <linux/hardirq.h>
 #include <linux/pkeys.h>
 
+#include "xstate.h"
+
 #define CREATE_TRACE_POINTS
 #include <asm/trace/fpu.h>
 
@@ -203,15 +205,6 @@ void fpu_sync_fpstate(struct fpu *fpu)
 	fpregs_unlock();
 }
 
-static inline void fpstate_init_xstate(struct xregs_state *xsave)
-{
-	/*
-	 * XRSTORS requires these bits set in xcomp_bv, or it will
-	 * trigger #GP:
-	 */
-	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_all;
-}
-
 static inline unsigned int init_fpstate_copy_size(void)
 {
 	if (!use_xsave())
@@ -238,23 +231,33 @@ static inline void fpstate_init_fstate(struct fregs_state *fp)
 	fp->fos = 0xffff0000u;
 }
 
-void fpstate_init(union fpregs_state *state)
+/*
+ * Used in two places:
+ * 1) Early boot to setup init_fpstate for non XSAVE systems
+ * 2) fpu_init_fpstate_user() which is invoked from KVM
+ */
+void fpstate_init_user(union fpregs_state *state)
 {
-	if (!static_cpu_has(X86_FEATURE_FPU)) {
+	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
 		fpstate_init_soft(&state->soft);
 		return;
 	}
 
-	memset(state, 0, fpu_kernel_xstate_size);
+	xstate_init_xcomp_bv(&state->xsave, xfeatures_mask_uabi());
 
-	if (static_cpu_has(X86_FEATURE_XSAVES))
-		fpstate_init_xstate(&state->xsave);
-	if (static_cpu_has(X86_FEATURE_FXSR))
+	if (cpu_feature_enabled(X86_FEATURE_FXSR))
 		fpstate_init_fxstate(&state->fxsave);
 	else
 		fpstate_init_fstate(&state->fsave);
 }
-EXPORT_SYMBOL_GPL(fpstate_init);
+
+#if IS_ENABLED(CONFIG_KVM)
+void fpu_init_fpstate_user(struct fpu *fpu)
+{
+	fpstate_init_user(&fpu->state);
+}
+EXPORT_SYMBOL_GPL(fpu_init_fpstate_user);
+#endif
 
 /* Clone current's FPU state on fork */
 int fpu_clone(struct task_struct *dst)
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 86bc975..37f8726 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -121,10 +121,10 @@ static void __init fpu__init_system_mxcsr(void)
 static void __init fpu__init_system_generic(void)
 {
 	/*
-	 * Set up the legacy init FPU context. (xstate init might overwrite this
-	 * with a more modern format, if the CPU supports it.)
+	 * Set up the legacy init FPU context. Will be updated when the
+	 * CPU supports XSAVE[S].
 	 */
-	fpstate_init(&init_fpstate);
+	fpstate_init_user(&init_fpstate);
 
 	fpu__init_system_mxcsr();
 }
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d6b5f22..259951d 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -15,10 +15,10 @@
 #include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
-#include <asm/fpu/xstate.h>
 
 #include <asm/tlbflush.h>
-#include <asm/cpufeature.h>
+
+#include "xstate.h"
 
 /*
  * Although we spell it out in here, the Processor Trace
@@ -389,9 +389,7 @@ static void __init setup_init_fpu_buf(void)
 	setup_xstate_features();
 	print_xstate_features();
 
-	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		init_fpstate.xsave.header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT |
-						     xfeatures_mask_all;
+	xstate_init_xcomp_bv(&init_fpstate.xsave, xfeatures_mask_all);
 
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
new file mode 100644
index 0000000..0789a04
--- /dev/null
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __X86_KERNEL_FPU_XSTATE_H
+#define __X86_KERNEL_FPU_XSTATE_H
+
+#include <asm/cpufeature.h>
+#include <asm/fpu/xstate.h>
+
+static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
+{
+	/*
+	 * XRSTORS requires these bits set in xcomp_bv, or it will
+	 * trigger #GP:
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
+		xsave->header.xcomp_bv = mask | XCOMP_BV_COMPACTED_FORMAT;
+}
+
+#endif
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index aabd3a2..74712e5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10626,14 +10626,6 @@ static int sync_regs(struct kvm_vcpu *vcpu)
 
 static void fx_init(struct kvm_vcpu *vcpu)
 {
-	if (!vcpu->arch.guest_fpu)
-		return;
-
-	fpstate_init(&vcpu->arch.guest_fpu->state);
-	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		vcpu->arch.guest_fpu->state.xsave.header.xcomp_bv =
-			host_xcr0 | XSTATE_COMPACTION_ENABLED;
-
 	/*
 	 * Ensure guest xcr0 is valid for loading
 	 */
@@ -10720,6 +10712,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 		pr_err("kvm: failed to allocate vcpu's fpu\n");
 		goto free_user_fpu;
 	}
+
+	fpu_init_fpstate_user(vcpu->arch.user_fpu);
+	fpu_init_fpstate_user(vcpu->arch.guest_fpu);
 	fx_init(vcpu);
 
 	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
