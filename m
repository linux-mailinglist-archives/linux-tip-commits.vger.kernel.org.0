Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AA7437EE2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Oct 2021 21:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhJVT6w (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Oct 2021 15:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhJVT6t (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Oct 2021 15:58:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC258C061766;
        Fri, 22 Oct 2021 12:56:30 -0700 (PDT)
Date:   Fri, 22 Oct 2021 19:56:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634932589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lDPSlpzGDriOQymRRKHffhmVQTWYVb5ASAHUZX07kNY=;
        b=D/4YHYTfV7hPNtwTq4cFpVmSwoIwtvMKQkFWqAOeMAnY8x8/ebUAT86bPMZ0qTuPoSekMv
        s5b+k9RfAWT6jQ+lKJ90Y3rrh/u5ZjmYUjM8ZkzwAtshxZNakD+HiiQyQOG2TuSF6sn/rv
        BS7Gxg2OHpB0CjLm4LQWoV8aoU27W48TVjX5GdogHAYndjRDpJRC5uhW92wUcF9bI8q2Ep
        ecIGdd4gVmNE/Om8koTh4/Iuhycwy44Mzywd4LzfMR2fyf713S1/KuJneOLrBgatvFLrmv
        Xq0mA8GlhthFDHCCpzitj9S153DozqkyTKifI6IDlRhwW4K7GLemK0IS2MftEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634932589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lDPSlpzGDriOQymRRKHffhmVQTWYVb5ASAHUZX07kNY=;
        b=AkqCTUhtZQ8FBpfvX5C6quZynniZQwEOYxuk34z24rITp8BJ5hbHVizVGGEt5ALmHWmzl9
        DWC0eL3tzekGjSDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Mop up xfeatures_mask_uabi()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211014230739.408879849@linutronix.de>
References: <20211014230739.408879849@linutronix.de>
MIME-Version: 1.0
Message-ID: <163493258807.626.8129757377933393504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     daddee24731938781b7876d20335ea3754d23484
Gitweb:        https://git.kernel.org/tip/daddee24731938781b7876d20335ea3754d23484
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 01:09:37 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 22 Oct 2021 11:04:46 +02:00

x86/fpu: Mop up xfeatures_mask_uabi()

Use the new fpu_user_cfg to retrieve the information instead of
xfeatures_mask_uabi() which will be no longer correct when dynamically
enabled features become available.

Using fpu_user_cfg is appropriate when setting XCOMP_BV in the
init_fpstate since it has space allocated for "max_features". But,
normal fpstates might only have space for default xfeatures. Since
XRSTOR* derives the format of the XSAVE buffer from XCOMP_BV, this can
lead to XRSTOR reading out of bounds.

So when copying actively used fpstate, simply read the XCOMP_BV features
bits directly out of the fpstate instead.

This correction courtesy of Dave Hansen <dave.hansen@linux.intel.com>

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211014230739.408879849@linutronix.de
---
 arch/x86/include/asm/fpu/xstate.h |  9 ---------
 arch/x86/kernel/fpu/core.c        |  4 ++--
 arch/x86/kernel/fpu/signal.c      |  2 +-
 arch/x86/kernel/fpu/xstate.c      |  6 +++---
 4 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index fe7c9af..3c890b9 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -84,15 +84,6 @@ static inline u64 xfeatures_mask_supervisor(void)
 }
 
 /*
- * The xfeatures which are enabled in XCR0 and expected to be in ptrace
- * buffers and signal frames.
- */
-static inline u64 xfeatures_mask_uabi(void)
-{
-	return fpu_kernel_cfg.max_features & XFEATURE_MASK_USER_SUPPORTED;
-}
-
-/*
  * The xfeatures which are restored by the kernel when returning to user
  * mode. This is not necessarily the same as xfeatures_mask_uabi() as the
  * kernel does not manage all XCR0 enabled features via xsave/xrstor as
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 501e21c..5acc077 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -237,7 +237,7 @@ int fpu_copy_kvm_uabi_to_fpstate(struct fpu *fpu, const void *buf, u64 xcr0,
 	}
 
 	/* Ensure that XCOMP_BV is set up for XSAVES */
-	xstate_init_xcomp_bv(&kstate->regs.xsave, xfeatures_mask_uabi());
+	xstate_init_xcomp_bv(&kstate->regs.xsave, kstate->xfeatures);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fpu_copy_kvm_uabi_to_fpstate);
@@ -333,7 +333,7 @@ void fpstate_init_user(struct fpstate *fpstate)
 		return;
 	}
 
-	xstate_init_xcomp_bv(&fpstate->regs.xsave, xfeatures_mask_uabi());
+	xstate_init_xcomp_bv(&fpstate->regs.xsave, fpstate->xfeatures);
 
 	if (cpu_feature_enabled(X86_FEATURE_FXSR))
 		fpstate_init_fxstate(fpstate);
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index c14f477..3e42e6e 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -536,7 +536,7 @@ void __init fpu__init_prepare_fx_sw_frame(void)
 
 	fx_sw_reserved.magic1 = FP_XSTATE_MAGIC1;
 	fx_sw_reserved.extended_size = size;
-	fx_sw_reserved.xfeatures = xfeatures_mask_uabi();
+	fx_sw_reserved.xfeatures = fpu_user_cfg.default_features;
 	fx_sw_reserved.xstate_size = fpu_user_cfg.default_size;
 
 	if (IS_ENABLED(CONFIG_IA32_EMULATION) ||
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 8b496c0..9f92abd 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -770,7 +770,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
 	fpu_kernel_cfg.max_features |= ecx + ((u64)edx << 32);
 
-	if ((xfeatures_mask_uabi() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
+	if ((fpu_kernel_cfg.max_features & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
 		/*
 		 * This indicates that something really unexpected happened
 		 * with the enumeration.  Disable XSAVE and try to continue
@@ -815,7 +815,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	 * supervisor xstates:
 	 */
 	update_regset_xstate_info(fpu_user_cfg.max_size,
-				  xfeatures_mask_uabi());
+				  fpu_user_cfg.max_features);
 
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
@@ -853,7 +853,7 @@ void fpu__resume_cpu(void)
 	 * Restore XCR0 on xsave capable CPUs:
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_XSAVE))
-		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_uabi());
+		xsetbv(XCR_XFEATURE_ENABLED_MASK, fpu_user_cfg.max_features);
 
 	/*
 	 * Restore IA32_XSS. The same CPUID bit enumerates support
