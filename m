Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE843B22F4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFWWLP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhFWWLO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EE2C061574;
        Wed, 23 Jun 2021 15:08:55 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:08:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFvgKDHdxGLPEf7Dd/fY3WCXGphBJH7eaR3d0W41+AU=;
        b=DZ9EpKQxBEJuIXmcdu2sgiwzho2EQ+PMQ6xETAF36532K8ats77wv3GNka+bWzkCBsIrTX
        KXp03D9p7/szA88GPkMcKEnrER4CDnnLm3ozKBFe5TLNjD+4fXNLT9EZjjZLizzr9V2IlH
        j0l0vFBARxnxFVAQe9ivf0dazntBdw1BCYLjFkLCccuBRrRnbncOkLxRXEewuCGVl+wsZ8
        fcNlSHpVrjLaKYrdC8lSsR9kD3OYQGxNBLMkswWNwfbsSaVhvJSWec6s3snr10Geaf+Jhq
        dvAXXHUgg/M4CNx3Lgi1Z24CdphZrofSKVGj2Dgi9v4BujBbIuhfOpC5WN99qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFvgKDHdxGLPEf7Dd/fY3WCXGphBJH7eaR3d0W41+AU=;
        b=J3jrfQO2O4rimjI27eiOeI96N1NwyOkz0oG5mu2gb2gIO7K0BRPR6YCq6DMvvnrkkFyk6s
        B0+Rpoo3QBgCYECg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Let xrstor handle the features to init
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121457.804115017@linutronix.de>
References: <20210623121457.804115017@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448612843.395.15241204908461608511.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     6f9866a166cd1ad3ebb2dcdb3874aa8fee8dea2f
Gitweb:        https://git.kernel.org/tip/6f9866a166cd1ad3ebb2dcdb3874aa8fee8dea2f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:32 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 23:45:31 +02:00

x86/fpu/signal: Let xrstor handle the features to init

There is no reason to do an extra XRSTOR from init_fpstate for feature
bits which have been cleared by user space in the FX magic xfeatures
storage.

Just clear them in the task's XSTATE header and do a full restore which
will put these cleared features into init state.

There is no real difference in performance because the current code
already does a full restore when the xfeatures bits are preserved as the
signal frame setup has stored them, which is the full UABI feature set.

 [ bp: Use the negated mxcsr_feature_mask in the MXCSR check. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121457.804115017@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 89 ++++++++++++-----------------------
 1 file changed, 31 insertions(+), 58 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 4c252d0..445c57c 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -220,36 +220,6 @@ retry:
 	return 0;
 }
 
-static inline void
-sanitize_restored_user_xstate(union fpregs_state *state,
-			      struct user_i387_ia32_struct *ia32_env, u64 mask)
-{
-	struct xregs_state *xsave = &state->xsave;
-	struct xstate_header *header = &xsave->header;
-
-	if (use_xsave()) {
-		/*
-		 * Clear all feature bits which are not set in mask.
-		 *
-		 * Supervisor state has to be preserved. The sigframe
-		 * restore can only modify user features, i.e. @mask
-		 * cannot contain them.
-		 */
-		header->xfeatures &= mask | xfeatures_mask_supervisor();
-	}
-
-	if (use_fxsr()) {
-		/*
-		 * mscsr reserved bits must be masked to zero for security
-		 * reasons.
-		 */
-		xsave->i387.mxcsr &= mxcsr_feature_mask;
-
-		if (ia32_env)
-			convert_to_fxsr(&state->fxsave, ia32_env);
-	}
-}
-
 static int __restore_fpregs_from_user(void __user *buf, u64 xrestore,
 				      bool fx_only)
 {
@@ -352,6 +322,8 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		fx_only = !fx_sw_user.magic1;
 		state_size = fx_sw_user.xstate_size;
 		user_xfeatures = fx_sw_user.xfeatures;
+	} else {
+		user_xfeatures = XFEATURE_MASK_FPSSE;
 	}
 
 	if (likely(!ia32_fxstate)) {
@@ -395,54 +367,55 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 	}
 	__fpu_invalidate_fpregs_state(fpu);
+	__cpu_invalidate_fpregs_state();
 	fpregs_unlock();
 
 	if (use_xsave() && !fx_only) {
-		u64 init_bv = xfeatures_mask_uabi() & ~user_xfeatures;
-
 		ret = copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx);
 		if (ret)
 			return ret;
+	} else {
+		if (__copy_from_user(&fpu->state.fxsave, buf_fx,
+				     sizeof(fpu->state.fxsave)))
+			return -EFAULT;
 
-		sanitize_restored_user_xstate(&fpu->state, &env, user_xfeatures);
+		/* Reject invalid MXCSR values. */
+		if (fpu->state.fxsave.mxcsr & ~mxcsr_feature_mask)
+			return -EINVAL;
 
-		fpregs_lock();
-		if (unlikely(init_bv))
-			os_xrstor(&init_fpstate.xsave, init_bv);
+		/* Enforce XFEATURE_MASK_FPSSE when XSAVE is enabled */
+		if (use_xsave())
+			fpu->state.xsave.header.xfeatures |= XFEATURE_MASK_FPSSE;
+	}
+
+	/* Fold the legacy FP storage */
+	convert_to_fxsr(&fpu->state.fxsave, &env);
 
+	fpregs_lock();
+	if (use_xsave()) {
 		/*
-		 * Restore previously saved supervisor xstates along with
-		 * copied-in user xstates.
+		 * Remove all UABI feature bits not set in user_xfeatures
+		 * from the memory xstate header which makes the full
+		 * restore below bring them into init state. This works for
+		 * fx_only mode as well because that has only FP and SSE
+		 * set in user_xfeatures.
+		 *
+		 * Preserve supervisor states!
 		 */
-		ret = os_xrstor_safe(&fpu->state.xsave,
-				     user_xfeatures | xfeatures_mask_supervisor());
+		u64 mask = user_xfeatures | xfeatures_mask_supervisor();
 
+		fpu->state.xsave.header.xfeatures &= mask;
+		ret = os_xrstor_safe(&fpu->state.xsave, xfeatures_mask_all);
 	} else {
-		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
-		if (ret)
-			return -EFAULT;
-
-		sanitize_restored_user_xstate(&fpu->state, &env, user_xfeatures);
-
-		fpregs_lock();
-		if (use_xsave()) {
-			u64 init_bv;
-
-			init_bv = xfeatures_mask_uabi() & ~XFEATURE_MASK_FPSSE;
-			os_xrstor(&init_fpstate.xsave, init_bv);
-		}
-
 		ret = fxrstor_safe(&fpu->state.fxsave);
 	}
 
-	if (!ret)
+	if (likely(!ret))
 		fpregs_mark_activate();
-	else
-		fpregs_deactivate(fpu);
+
 	fpregs_unlock();
 	return ret;
 }
-
 static inline int xstate_sigframe_size(void)
 {
 	return use_xsave() ? fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE :
