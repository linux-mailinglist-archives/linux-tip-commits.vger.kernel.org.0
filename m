Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478A23B2311
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhFWWMC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhFWWL2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5609C061574;
        Wed, 23 Jun 2021 15:09:05 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zZtaD8veJ9/tI+szEmuO4vIkE6L2bl/kHRe0rwwZKDM=;
        b=yYvLv8lCaMzwL/wZsgG3Q4LMsIsUYIsuDfvebuX67+j7J0eu4ByWptFQODXSDL8D5UE2lw
        QlTIm3Cg83EzKKP5tmnVKKP7bNDmVHmYgl/gScwvFT7WjJBUuYm3Wb+rpKcYekQgr35ib0
        yjOdw1leHOlCL5NKwJQkq1g9QyURSZVfD4gne8FNhQmG0GVKhyfLo8pvHy4g7QWiqec3ii
        uxfLaFso0tEcgRWMiKgIYgmYigK8urZ2o7FessOtABD52GPFCldQVKXo/5KS1iFQCAVWaQ
        7B+Y1G515qSdWr+6PPf6cG0Zlq4BT7VLYtMSjV016wJACU58Cr9EnjCQQzWOrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zZtaD8veJ9/tI+szEmuO4vIkE6L2bl/kHRe0rwwZKDM=;
        b=y9Ir7thG1j0uMBZAhjE+b1gQPePpvB3YuEt0dgmrxAX3kJTNj/aWkbIQbSJ7O92FK7GRrx
        S1iXCAo3RJIy/aAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Rename xfeatures_mask_user() to xfeatures_mask_uabi()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121456.211585137@linutronix.de>
References: <20210623121456.211585137@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448614288.395.4209787331863394292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     65e952102122bf89f0e4f1bebf8664e32587aaed
Gitweb:        https://git.kernel.org/tip/65e952102122bf89f0e4f1bebf8664e32587aaed
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:16 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:29:52 +02:00

x86/fpu: Rename xfeatures_mask_user() to xfeatures_mask_uabi()

Rename it so it's clear that this is about user ABI features which can
differ from the feature set which the kernel saves and restores because the
kernel handles e.g. PKRU differently. But the user ABI (ptrace, signal
frame) expects it to be there.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121456.211585137@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h |  7 ++++++-
 arch/x86/include/asm/fpu/xstate.h   |  6 +++++-
 arch/x86/kernel/fpu/core.c          |  2 +-
 arch/x86/kernel/fpu/signal.c        | 10 +++++-----
 arch/x86/kernel/fpu/xstate.c        | 18 +++++++++---------
 5 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 63d9796..bcfb636 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -324,7 +324,12 @@ static inline void os_xrstor(struct xregs_state *xstate, u64 mask)
  */
 static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 {
-	u64 mask = xfeatures_mask_user();
+	/*
+	 * Include the features which are not xsaved/rstored by the kernel
+	 * internally, e.g. PKRU. That's user space ABI and also required
+	 * to allow the signal handler to modify PKRU.
+	 */
+	u64 mask = xfeatures_mask_uabi();
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 5764cbe..af9ea13 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -83,7 +83,11 @@ static inline u64 xfeatures_mask_supervisor(void)
 	return xfeatures_mask_all & XFEATURE_MASK_SUPERVISOR_SUPPORTED;
 }
 
-static inline u64 xfeatures_mask_user(void)
+/*
+ * The xfeatures which are enabled in XCR0 and expected to be in ptrace
+ * buffers and signal frames.
+ */
+static inline u64 xfeatures_mask_uabi(void)
 {
 	return xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
 }
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index afd0dee..1243738 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -404,7 +404,7 @@ void fpu__clear_user_states(struct fpu *fpu)
 	}
 
 	/* Reset user states in registers. */
-	restore_fpregs_from_init_fpstate(xfeatures_mask_user());
+	restore_fpregs_from_init_fpstate(xfeatures_mask_uabi());
 
 	/*
 	 * Now all FPU registers have their desired values.  Inform the FPU
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index b12665c..a42bc9d 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -257,14 +257,14 @@ static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
 
 	if (use_xsave()) {
 		if (fx_only) {
-			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
+			init_bv = xfeatures_mask_uabi() & ~XFEATURE_MASK_FPSSE;
 
 			r = fxrstor_from_user_sigframe(buf);
 			if (!r)
 				os_xrstor(&init_fpstate.xsave, init_bv);
 			return r;
 		} else {
-			init_bv = xfeatures_mask_user() & ~xbv;
+			init_bv = xfeatures_mask_uabi() & ~xbv;
 
 			r = xrstor_from_user_sigframe(buf, xbv);
 			if (!r && unlikely(init_bv))
@@ -420,7 +420,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	fpregs_unlock();
 
 	if (use_xsave() && !fx_only) {
-		u64 init_bv = xfeatures_mask_user() & ~user_xfeatures;
+		u64 init_bv = xfeatures_mask_uabi() & ~user_xfeatures;
 
 		ret = copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx);
 		if (ret)
@@ -454,7 +454,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		if (use_xsave()) {
 			u64 init_bv;
 
-			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
+			init_bv = xfeatures_mask_uabi() & ~XFEATURE_MASK_FPSSE;
 			os_xrstor(&init_fpstate.xsave, init_bv);
 		}
 
@@ -549,7 +549,7 @@ void fpu__init_prepare_fx_sw_frame(void)
 
 	fx_sw_reserved.magic1 = FP_XSTATE_MAGIC1;
 	fx_sw_reserved.extended_size = size;
-	fx_sw_reserved.xfeatures = xfeatures_mask_user();
+	fx_sw_reserved.xfeatures = xfeatures_mask_uabi();
 	fx_sw_reserved.xstate_size = fpu_user_xstate_size;
 
 	if (IS_ENABLED(CONFIG_IA32_EMULATION) ||
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index bc71609..c513596 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -144,7 +144,7 @@ void fpu__init_cpu_xstate(void)
 	 * managed by XSAVE{C, OPT, S} and XRSTOR{S}.  Only XSAVE user
 	 * states can be set here.
 	 */
-	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
+	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_uabi());
 
 	/*
 	 * MSR_IA32_XSS sets supervisor states managed by XSAVES.
@@ -453,7 +453,7 @@ int xfeature_size(int xfeature_nr)
 static int validate_user_xstate_header(const struct xstate_header *hdr)
 {
 	/* No unknown or supervisor features may be set */
-	if (hdr->xfeatures & ~xfeatures_mask_user())
+	if (hdr->xfeatures & ~xfeatures_mask_uabi())
 		return -EINVAL;
 
 	/* Userspace must use the uncompacted format */
@@ -756,7 +756,7 @@ void __init fpu__init_system_xstate(void)
 	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
 	xfeatures_mask_all |= ecx + ((u64)edx << 32);
 
-	if ((xfeatures_mask_user() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
+	if ((xfeatures_mask_uabi() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
 		/*
 		 * This indicates that something really unexpected happened
 		 * with the enumeration.  Disable XSAVE and try to continue
@@ -791,7 +791,7 @@ void __init fpu__init_system_xstate(void)
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
 	 */
-	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_user());
+	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_uabi());
 
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
@@ -828,14 +828,14 @@ void fpu__resume_cpu(void)
 	/*
 	 * Restore XCR0 on xsave capable CPUs:
 	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVE))
-		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
+	if (cpu_feature_enabled(X86_FEATURE_XSAVE))
+		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_uabi());
 
 	/*
 	 * Restore IA32_XSS. The same CPUID bit enumerates support
 	 * of XSAVES and MSR_IA32_XSS.
 	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES)) {
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
 				     xfeatures_mask_independent());
 	}
@@ -993,7 +993,7 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
 		break;
 
 	case XSTATE_COPY_XSAVE:
-		header.xfeatures &= xfeatures_mask_user();
+		header.xfeatures &= xfeatures_mask_uabi();
 		break;
 	}
 
@@ -1038,7 +1038,7 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
 		 * compacted init_fpstate. The gap tracking will zero this
 		 * later.
 		 */
-		if (!(xfeatures_mask_user() & BIT_ULL(i)))
+		if (!(xfeatures_mask_uabi() & BIT_ULL(i)))
 			continue;
 
 		/*
