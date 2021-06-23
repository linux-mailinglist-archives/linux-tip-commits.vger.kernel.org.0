Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5E83B2362
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFWWOd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbhFWWN3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:13:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FBAC061149;
        Wed, 23 Jun 2021 15:09:28 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486166;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OPxcUAhICPfmWY/7RMLO62MdY/A4sENm55bTweR79z4=;
        b=GesONaSa4Z0cj4aMJ8cd8KhDtZQDvJ4Lb7uCHGWuDPPUgMkENLVRI6mljJWHqNSCgID4sl
        wV2ah6jHgRYezgJoZ0cLE2wmyG6saAvJvSw+96ldpjTW3MR5GeCUPRoYP9ke/CBgoKIYKV
        8IO4OYAaF8fnXVQXbB6aeH5vKjBBxCdD1S/I0HDGcgIS8lbhIBZZlRNZ8HiHupWNjOJfJs
        l2XfDzNiejG+Q+QIQlPaFc2Reoft7XFkutmLOgrFb4OUMFOTHrjmW92FeUd94RQ/RaZH0i
        OC7acGqu7Lv+HF35fDcz8452RO4MG9eU9r9wiwa69Y4N+nzaDA3vDH57Xna0Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486166;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OPxcUAhICPfmWY/7RMLO62MdY/A4sENm55bTweR79z4=;
        b=7hEUnjlAadGPRJm65yQl1Q7mhSsHEYgk1HCYsKrwoj5BY6xRS8YBlKu3bCx8CJaYQPpx/f
        zmaVkUaqDkZhqDBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Rename copy_xregs_to_kernel() and
 copy_kernel_to_xregs()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121453.830239347@linutronix.de>
References: <20210623121453.830239347@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448616564.395.2992513221405545428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     b16313f71c1050ad5c92548925e0e9cec26989ab
Gitweb:        https://git.kernel.org/tip/b16313f71c1050ad5c92548925e0e9cec26989ab
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:52 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:57:57 +02:00

x86/fpu: Rename copy_xregs_to_kernel() and copy_kernel_to_xregs()

The function names for xsave[s]/xrstor[s] operations are horribly named and
a permanent source of confusion.

Rename:
	copy_xregs_to_kernel() to os_xsave()
	copy_kernel_to_xregs() to os_xrstor()

These are truly low level wrappers around the actual instructions
XSAVE[OPT]/XRSTOR and XSAVES/XRSTORS with the twist that the selection
based on the available CPU features happens with an alternative to avoid
conditionals all over the place and to provide the best performance for hot
paths.

The os_ prefix tells that this is the OS selected mechanism.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121453.830239347@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 17 +++++++++++------
 arch/x86/kernel/fpu/core.c          |  7 +++----
 arch/x86/kernel/fpu/signal.c        | 21 +++++++++++----------
 arch/x86/kernel/fpu/xstate.c        |  2 +-
 4 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 854bfb0..dae1545 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -261,7 +261,7 @@ static inline void fxsave(struct fxregs_state *fx)
  * This function is called only during boot time when x86 caps are not set
  * up and alternative can not be used yet.
  */
-static inline void copy_kernel_to_xregs_booting(struct xregs_state *xstate)
+static inline void os_xrstor_booting(struct xregs_state *xstate)
 {
 	u64 mask = -1;
 	u32 lmask = mask;
@@ -284,8 +284,11 @@ static inline void copy_kernel_to_xregs_booting(struct xregs_state *xstate)
 
 /*
  * Save processor xstate to xsave area.
+ *
+ * Uses either XSAVE or XSAVEOPT or XSAVES depending on the CPU features
+ * and command line options. The choice is permanent until the next reboot.
  */
-static inline void copy_xregs_to_kernel(struct xregs_state *xstate)
+static inline void os_xsave(struct xregs_state *xstate)
 {
 	u64 mask = xfeatures_mask_all;
 	u32 lmask = mask;
@@ -302,8 +305,10 @@ static inline void copy_xregs_to_kernel(struct xregs_state *xstate)
 
 /*
  * Restore processor xstate from xsave area.
+ *
+ * Uses XRSTORS when XSAVES is used, XRSTOR otherwise.
  */
-static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
+static inline void os_xrstor(struct xregs_state *xstate, u64 mask)
 {
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
@@ -364,13 +369,13 @@ static inline int copy_user_to_xregs(struct xregs_state __user *buf, u64 mask)
  * Restore xstate from kernel space xsave area, return an error code instead of
  * an exception.
  */
-static inline int copy_kernel_to_xregs_err(struct xregs_state *xstate, u64 mask)
+static inline int os_xrstor_safe(struct xregs_state *xstate, u64 mask)
 {
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
 
-	if (static_cpu_has(X86_FEATURE_XSAVES))
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
 		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
 	else
 		XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
@@ -383,7 +388,7 @@ extern int copy_fpregs_to_fpstate(struct fpu *fpu);
 static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask)
 {
 	if (use_xsave()) {
-		copy_kernel_to_xregs(&fpstate->xsave, mask);
+		os_xrstor(&fpstate->xsave, mask);
 	} else {
 		if (use_fxsr())
 			copy_kernel_to_fxregs(&fpstate->fxsave);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 2243701..bfdcf7f 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -95,7 +95,7 @@ EXPORT_SYMBOL(irq_fpu_usable);
 int copy_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
-		copy_xregs_to_kernel(&fpu->state.xsave);
+		os_xsave(&fpu->state.xsave);
 
 		/*
 		 * AVX512 state is tracked here because its use is
@@ -314,7 +314,7 @@ void fpu__drop(struct fpu *fpu)
 static inline void copy_init_fpstate_to_fpregs(u64 features_mask)
 {
 	if (use_xsave())
-		copy_kernel_to_xregs(&init_fpstate.xsave, features_mask);
+		os_xrstor(&init_fpstate.xsave, features_mask);
 	else if (static_cpu_has(X86_FEATURE_FXSR))
 		copy_kernel_to_fxregs(&init_fpstate.fxsave);
 	else
@@ -345,8 +345,7 @@ static void fpu__clear(struct fpu *fpu, bool user_only)
 	if (user_only) {
 		if (!fpregs_state_valid(fpu, smp_processor_id()) &&
 		    xfeatures_mask_supervisor())
-			copy_kernel_to_xregs(&fpu->state.xsave,
-					     xfeatures_mask_supervisor());
+			os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
 		copy_init_fpstate_to_fpregs(xfeatures_mask_user());
 	} else {
 		copy_init_fpstate_to_fpregs(xfeatures_mask_all);
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 5010595..33675b3 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -261,14 +261,14 @@ static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
 
 			r = copy_user_to_fxregs(buf);
 			if (!r)
-				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+				os_xrstor(&init_fpstate.xsave, init_bv);
 			return r;
 		} else {
 			init_bv = xfeatures_mask_user() & ~xbv;
 
 			r = copy_user_to_xregs(buf, xbv);
 			if (!r && unlikely(init_bv))
-				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+				os_xrstor(&init_fpstate.xsave, init_bv);
 			return r;
 		}
 	} else if (use_fxsr()) {
@@ -356,9 +356,10 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			 * has been copied to the kernel one.
 			 */
 			if (test_thread_flag(TIF_NEED_FPU_LOAD) &&
-			    xfeatures_mask_supervisor())
-				copy_kernel_to_xregs(&fpu->state.xsave,
-						     xfeatures_mask_supervisor());
+			    xfeatures_mask_supervisor()) {
+				os_xrstor(&fpu->state.xsave,
+					  xfeatures_mask_supervisor());
+			}
 			fpregs_mark_activate();
 			fpregs_unlock();
 			return 0;
@@ -412,7 +413,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		 * above XRSTOR failed or ia32_fxstate is true. Shrug.
 		 */
 		if (xfeatures_mask_supervisor())
-			copy_xregs_to_kernel(&fpu->state.xsave);
+			os_xsave(&fpu->state.xsave);
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 	}
 	__fpu_invalidate_fpregs_state(fpu);
@@ -430,14 +431,14 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 
 		fpregs_lock();
 		if (unlikely(init_bv))
-			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+			os_xrstor(&init_fpstate.xsave, init_bv);
 
 		/*
 		 * Restore previously saved supervisor xstates along with
 		 * copied-in user xstates.
 		 */
-		ret = copy_kernel_to_xregs_err(&fpu->state.xsave,
-					       user_xfeatures | xfeatures_mask_supervisor());
+		ret = os_xrstor_safe(&fpu->state.xsave,
+				     user_xfeatures | xfeatures_mask_supervisor());
 
 	} else if (use_fxsr()) {
 		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
@@ -454,7 +455,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			u64 init_bv;
 
 			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
-			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+			os_xrstor(&init_fpstate.xsave, init_bv);
 		}
 
 		ret = copy_kernel_to_fxregs_err(&fpu->state.fxsave);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 427977b..4fca8a8 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -400,7 +400,7 @@ static void __init setup_init_fpu_buf(void)
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
 	 */
-	copy_kernel_to_xregs_booting(&init_fpstate.xsave);
+	os_xrstor_booting(&init_fpstate.xsave);
 
 	/*
 	 * All components are now in init state. Read the state back so
