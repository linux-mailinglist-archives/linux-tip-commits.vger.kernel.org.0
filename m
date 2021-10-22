Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA463437EDF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Oct 2021 21:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhJVT6t (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Oct 2021 15:58:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41416 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbhJVT6s (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Oct 2021 15:58:48 -0400
Date:   Fri, 22 Oct 2021 19:56:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634932589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwVjqz1FZ7wd4rZz16Q6a3ynBMR1rPYcB1WypxinLrE=;
        b=OyZBTe7o3vbo9WABII3DKQpoiicu7O+93uGpk6MuyzBnAaB687HmsDk1fEshqGTB3wkobd
        dAQ2LKoeHQ7ObKGcGB+Dz8Z+mW3cCP6irV74oprrrdiYdnOcqQjE6d4ll+oyuqJzyh51zc
        HS0ssfkrOobwYBkhYLXhcGlAmyXNfCrqdovNBfNq3utRnfYhzQZWck18G63DsZr94wLkC3
        YlEJc9tz4SVQjVCjURe2j+OEOwrR+R99n5gnv8QIQUOM4XAvSnRf4SZ9hM/9MqxeqiWCpG
        t8fWsMKNkq9f+nptv9U7Z0ieXP50gxGdUlCxi93DJ/GxdMrbBVEQzPt8nKtNgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634932589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwVjqz1FZ7wd4rZz16Q6a3ynBMR1rPYcB1WypxinLrE=;
        b=3otMOIygIaWuBfVHk3NKQkaE9fCstqOp3IByo//kpUSEUQmdpaC0D/pHzOm4T9GLz4fHas
        ToJfEQWsMA5an6AQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Move xstate feature masks to fpu_*_cfg
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211014230739.352041752@linutronix.de>
References: <20211014230739.352041752@linutronix.de>
MIME-Version: 1.0
Message-ID: <163493258889.626.1055664731706024145.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     1c253ff2287fe31307a67938c4487936db967ff5
Gitweb:        https://git.kernel.org/tip/1c253ff2287fe31307a67938c4487936db967ff5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 01:09:35 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 20:36:58 +02:00

x86/fpu: Move xstate feature masks to fpu_*_cfg

Move the feature mask storage to the kernel and user config
structs. Default and maximum feature set are the same for now.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211014230739.352041752@linutronix.de
---
 arch/x86/include/asm/fpu/xstate.h | 10 ++---
 arch/x86/kernel/fpu/core.c        |  4 +-
 arch/x86/kernel/fpu/init.c        |  2 +-
 arch/x86/kernel/fpu/signal.c      |  3 +-
 arch/x86/kernel/fpu/xstate.c      | 57 +++++++++++++++---------------
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 61fcb15..fe7c9af 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -78,11 +78,9 @@
 				      XFEATURE_MASK_INDEPENDENT | \
 				      XFEATURE_MASK_SUPERVISOR_UNSUPPORTED)
 
-extern u64 xfeatures_mask_all;
-
 static inline u64 xfeatures_mask_supervisor(void)
 {
-	return xfeatures_mask_all & XFEATURE_MASK_SUPERVISOR_SUPPORTED;
+	return fpu_kernel_cfg.max_features & XFEATURE_MASK_SUPERVISOR_SUPPORTED;
 }
 
 /*
@@ -91,7 +89,7 @@ static inline u64 xfeatures_mask_supervisor(void)
  */
 static inline u64 xfeatures_mask_uabi(void)
 {
-	return xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
+	return fpu_kernel_cfg.max_features & XFEATURE_MASK_USER_SUPPORTED;
 }
 
 /*
@@ -102,7 +100,7 @@ static inline u64 xfeatures_mask_uabi(void)
  */
 static inline u64 xfeatures_mask_restore_user(void)
 {
-	return xfeatures_mask_all & XFEATURE_MASK_USER_RESTORE;
+	return fpu_kernel_cfg.max_features & XFEATURE_MASK_USER_RESTORE;
 }
 
 /*
@@ -111,7 +109,7 @@ static inline u64 xfeatures_mask_restore_user(void)
  */
 static inline u64 xfeatures_mask_fpstate(void)
 {
-	return xfeatures_mask_all & \
+	return fpu_kernel_cfg.max_features & \
 		(XFEATURE_MASK_USER_RESTORE | XFEATURE_MASK_SUPERVISOR_SUPPORTED);
 }
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 69abf3a..501e21c 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -349,8 +349,8 @@ void fpstate_reset(struct fpu *fpu)
 	/* Initialize sizes and feature masks */
 	fpu->fpstate->size		= fpu_kernel_cfg.default_size;
 	fpu->fpstate->user_size		= fpu_user_cfg.default_size;
-	fpu->fpstate->xfeatures		= xfeatures_mask_all;
-	fpu->fpstate->user_xfeatures	= xfeatures_mask_uabi();
+	fpu->fpstate->xfeatures		= fpu_kernel_cfg.default_features;
+	fpu->fpstate->user_xfeatures	= fpu_user_cfg.default_features;
 }
 
 #if IS_ENABLED(CONFIG_KVM)
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 58043ed..7074154 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -211,7 +211,7 @@ static void __init fpu__init_init_fpstate(void)
 {
 	/* Bring init_fpstate size and features up to date */
 	init_fpstate.size		= fpu_kernel_cfg.max_size;
-	init_fpstate.xfeatures		= xfeatures_mask_all;
+	init_fpstate.xfeatures		= fpu_kernel_cfg.max_features;
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index fab4403..c14f477 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -417,7 +417,8 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		u64 mask = user_xfeatures | xfeatures_mask_supervisor();
 
 		fpregs->xsave.header.xfeatures &= mask;
-		success = !os_xrstor_safe(&fpregs->xsave, xfeatures_mask_all);
+		success = !os_xrstor_safe(&fpregs->xsave,
+					  fpu_kernel_cfg.max_features);
 	} else {
 		success = !fxrstor_safe(&fpregs->fxsave);
 	}
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 94f5e37..8b496c0 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -62,12 +62,6 @@ static short xsave_cpuid_features[] __initdata = {
 	X86_FEATURE_ENQCMD,
 };
 
-/*
- * This represents the full set of bits that should ever be set in a kernel
- * XSAVE buffer, both supervisor and user xstates.
- */
-u64 xfeatures_mask_all __ro_after_init;
-
 static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_init =
@@ -84,7 +78,7 @@ static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] __ro_after_init
  */
 int cpu_has_xfeatures(u64 xfeatures_needed, const char **feature_name)
 {
-	u64 xfeatures_missing = xfeatures_needed & ~xfeatures_mask_all;
+	u64 xfeatures_missing = xfeatures_needed & ~fpu_kernel_cfg.max_features;
 
 	if (unlikely(feature_name)) {
 		long xfeature_idx, max_idx;
@@ -134,7 +128,7 @@ static bool xfeature_is_supervisor(int xfeature_nr)
  */
 void fpu__init_cpu_xstate(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask_all)
+	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !fpu_kernel_cfg.max_features)
 		return;
 
 	cr4_set_bits(X86_CR4_OSXSAVE);
@@ -144,7 +138,7 @@ void fpu__init_cpu_xstate(void)
 	 * managed by XSAVE{C, OPT, S} and XRSTOR{S}.  Only XSAVE user
 	 * states can be set here.
 	 */
-	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_uabi());
+	xsetbv(XCR_XFEATURE_ENABLED_MASK, fpu_user_cfg.max_features);
 
 	/*
 	 * MSR_IA32_XSS sets supervisor states managed by XSAVES.
@@ -157,7 +151,7 @@ void fpu__init_cpu_xstate(void)
 
 static bool xfeature_enabled(enum xfeature xfeature)
 {
-	return xfeatures_mask_all & BIT_ULL(xfeature);
+	return fpu_kernel_cfg.max_features & BIT_ULL(xfeature);
 }
 
 /*
@@ -183,7 +177,7 @@ static void __init setup_xstate_features(void)
 	xstate_sizes[XFEATURE_SSE]	= sizeof_field(struct fxregs_state,
 						       xmm_space);
 
-	for_each_extended_xfeature(i, xfeatures_mask_all) {
+	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
 		cpuid_count(XSTATE_CPUID, i, &eax, &ebx, &ecx, &edx);
 
 		xstate_sizes[i] = eax;
@@ -288,14 +282,14 @@ static void __init setup_xstate_comp_offsets(void)
 						     xmm_space);
 
 	if (!cpu_feature_enabled(X86_FEATURE_XSAVES)) {
-		for_each_extended_xfeature(i, xfeatures_mask_all)
+		for_each_extended_xfeature(i, fpu_kernel_cfg.max_features)
 			xstate_comp_offsets[i] = xstate_offsets[i];
 		return;
 	}
 
 	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 
-	for_each_extended_xfeature(i, xfeatures_mask_all) {
+	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
 		if (xfeature_is_aligned(i))
 			next_offset = ALIGN(next_offset, 64);
 
@@ -319,7 +313,7 @@ static void __init setup_supervisor_only_offsets(void)
 
 	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 
-	for_each_extended_xfeature(i, xfeatures_mask_all) {
+	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
 		if (!xfeature_is_supervisor(i))
 			continue;
 
@@ -338,7 +332,7 @@ static void __init print_xstate_offset_size(void)
 {
 	int i;
 
-	for_each_extended_xfeature(i, xfeatures_mask_all) {
+	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
 		pr_info("x86/fpu: xstate_offset[%d]: %4d, xstate_sizes[%d]: %4d\n",
 			 i, xstate_comp_offsets[i], i, xstate_sizes[i]);
 	}
@@ -401,7 +395,7 @@ static void __init setup_init_fpu_buf(void)
 	setup_xstate_features();
 	print_xstate_features();
 
-	xstate_init_xcomp_bv(&init_fpstate.regs.xsave, xfeatures_mask_all);
+	xstate_init_xcomp_bv(&init_fpstate.regs.xsave, fpu_kernel_cfg.max_features);
 
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
@@ -570,7 +564,7 @@ static bool __init paranoid_xstate_size_valid(unsigned int kernel_size)
 	unsigned int size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 	int i;
 
-	for_each_extended_xfeature(i, xfeatures_mask_all) {
+	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
 		if (!check_xstate_against_struct(i))
 			return false;
 		/*
@@ -724,7 +718,7 @@ static int __init init_xstate_size(void)
  */
 static void __init fpu__init_disable_system_xstate(unsigned int legacy_size)
 {
-	xfeatures_mask_all = 0;
+	fpu_kernel_cfg.max_features = 0;
 	cr4_clear_bits(X86_CR4_OSXSAVE);
 	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
 
@@ -768,13 +762,13 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	 * Find user xstates supported by the processor.
 	 */
 	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
-	xfeatures_mask_all = eax + ((u64)edx << 32);
+	fpu_kernel_cfg.max_features = eax + ((u64)edx << 32);
 
 	/*
 	 * Find supervisor xstates supported by the processor.
 	 */
 	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
-	xfeatures_mask_all |= ecx + ((u64)edx << 32);
+	fpu_kernel_cfg.max_features |= ecx + ((u64)edx << 32);
 
 	if ((xfeatures_mask_uabi() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
 		/*
@@ -783,7 +777,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		 * booting without it.  This is too early to BUG().
 		 */
 		pr_err("x86/fpu: FP/SSE not present amongst the CPU's xstate features: 0x%llx.\n",
-		       xfeatures_mask_all);
+		       fpu_kernel_cfg.max_features);
 		goto out_disable;
 	}
 
@@ -792,14 +786,21 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	 */
 	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
 		if (!boot_cpu_has(xsave_cpuid_features[i]))
-			xfeatures_mask_all &= ~BIT_ULL(i);
+			fpu_kernel_cfg.max_features &= ~BIT_ULL(i);
 	}
 
-	xfeatures_mask_all &= XFEATURE_MASK_USER_SUPPORTED |
+	fpu_kernel_cfg.max_features &= XFEATURE_MASK_USER_SUPPORTED |
 			      XFEATURE_MASK_SUPERVISOR_SUPPORTED;
 
+	fpu_user_cfg.max_features = fpu_kernel_cfg.max_features;
+	fpu_user_cfg.max_features &= XFEATURE_MASK_USER_SUPPORTED;
+
+	/* Identical for now */
+	fpu_kernel_cfg.default_features = fpu_kernel_cfg.max_features;
+	fpu_user_cfg.default_features = fpu_user_cfg.max_features;
+
 	/* Store it for paranoia check at the end */
-	xfeatures = xfeatures_mask_all;
+	xfeatures = fpu_kernel_cfg.max_features;
 
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
@@ -825,15 +826,15 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	 * Paranoia check whether something in the setup modified the
 	 * xfeatures mask.
 	 */
-	if (xfeatures != xfeatures_mask_all) {
+	if (xfeatures != fpu_kernel_cfg.max_features) {
 		pr_err("x86/fpu: xfeatures modified from 0x%016llx to 0x%016llx during init, disabling XSAVE\n",
-		       xfeatures, xfeatures_mask_all);
+		       xfeatures, fpu_kernel_cfg.max_features);
 		goto out_disable;
 	}
 
 	print_xstate_offset_size();
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
-		xfeatures_mask_all,
+		fpu_kernel_cfg.max_features,
 		fpu_kernel_cfg.max_size,
 		boot_cpu_has(X86_FEATURE_XSAVES) ? "compacted" : "standard");
 	return;
@@ -908,7 +909,7 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 	 * We should not ever be requesting features that we
 	 * have not enabled.
 	 */
-	WARN_ONCE(!(xfeatures_mask_all & BIT_ULL(xfeature_nr)),
+	WARN_ONCE(!(fpu_kernel_cfg.max_features & BIT_ULL(xfeature_nr)),
 		  "get of unsupported state");
 	/*
 	 * This assumes the last 'xsave*' instruction to
