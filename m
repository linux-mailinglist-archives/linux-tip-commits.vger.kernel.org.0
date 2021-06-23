Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B9E3B22F7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhFWWLR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhFWWLO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F80BC061760;
        Wed, 23 Jun 2021 15:08:56 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:08:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QalD2PMf44+KYzpUv+VQeYAS0Y9HBnOOL+SvtzIJvCY=;
        b=UpicamRUmPrRXTzv4/IrPmYt23RCJW/fRbpAeZVLjSLnScxKb5qnC3BcNYhh7/RpKwJ8ic
        dnCo5CuNVo3pi5gNeVrYo4TkLS2ADrVtbgKVw3g1JfYY1SdAKj+6RYbqNy6uSRR03uHeJJ
        BJix9T+FLGaY2jVamkM38p1qV+cSgDo9bYEf5CxtghiUssSbc9sFZPaQWNcSM+998+/vFw
        X+JhnEIieEBvy+OVPe2QK4oO99b5hYOC4zQZBS3JwqjQ+jIZQnNXDLE90L9ITRFFoR5eYe
        n2fljNiCY6IzLJtpFpJ4PnYhYdvc1afUqFey1QFzGof1JmPBqgjTD7kxAkM+rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QalD2PMf44+KYzpUv+VQeYAS0Y9HBnOOL+SvtzIJvCY=;
        b=7FvsjdzhE2H91mXGht0YrlgggbPvYUlf5IFIn6j5T8Fz0SItZ5v0tYMgBeCUtXnoZZg8rh
        W3voMbptO0oyX6DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Sanitize the xstate check on sigframe
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121457.277738268@linutronix.de>
References: <20210623121457.277738268@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448613303.395.13125419427982349539.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     1258a8c896044564514c1b53795ba3033b1e9fd6
Gitweb:        https://git.kernel.org/tip/1258a8c896044564514c1b53795ba3033b1e9fd6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:27 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 20:02:46 +02:00

x86/fpu/signal: Sanitize the xstate check on sigframe

Utilize the check for the extended state magic in the FX software reserved
bytes and set the parameters for restoring fx_only in the relevant members
of fw_sw_user.

This allows further cleanups on top because the data is consistent.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121457.277738268@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 70 ++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 8a327c0..d552410 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -15,29 +15,30 @@
 #include <asm/sigframe.h>
 #include <asm/trace/fpu.h>
 
-static struct _fpx_sw_bytes fx_sw_reserved, fx_sw_reserved_ia32;
+static struct _fpx_sw_bytes fx_sw_reserved __ro_after_init;
+static struct _fpx_sw_bytes fx_sw_reserved_ia32 __ro_after_init;
 
 /*
  * Check for the presence of extended state information in the
  * user fpstate pointer in the sigcontext.
  */
-static inline int check_for_xstate(struct fxregs_state __user *buf,
-				   void __user *fpstate,
-				   struct _fpx_sw_bytes *fx_sw)
+static inline int check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
+					   struct _fpx_sw_bytes *fx_sw)
 {
 	int min_xstate_size = sizeof(struct fxregs_state) +
 			      sizeof(struct xstate_header);
+	void __user *fpstate = fxbuf;
 	unsigned int magic2;
 
-	if (__copy_from_user(fx_sw, &buf->sw_reserved[0], sizeof(*fx_sw)))
-		return -1;
+	if (__copy_from_user(fx_sw, &fxbuf->sw_reserved[0], sizeof(*fx_sw)))
+		return -EFAULT;
 
 	/* Check for the first magic field and other error scenarios. */
 	if (fx_sw->magic1 != FP_XSTATE_MAGIC1 ||
 	    fx_sw->xstate_size < min_xstate_size ||
 	    fx_sw->xstate_size > fpu_user_xstate_size ||
 	    fx_sw->xstate_size > fx_sw->extended_size)
-		return -1;
+		goto setfx;
 
 	/*
 	 * Check for the presence of second magic word at the end of memory
@@ -45,10 +46,18 @@ static inline int check_for_xstate(struct fxregs_state __user *buf,
 	 * fpstate layout with out copying the extended state information
 	 * in the memory layout.
 	 */
-	if (__get_user(magic2, (__u32 __user *)(fpstate + fx_sw->xstate_size))
-	    || magic2 != FP_XSTATE_MAGIC2)
-		return -1;
+	if (__get_user(magic2, (__u32 __user *)(fpstate + fx_sw->xstate_size)))
+		return -EFAULT;
 
+	if (likely(magic2 == FP_XSTATE_MAGIC2))
+		return 0;
+setfx:
+	trace_x86_fpu_xstate_check_failed(&current->thread.fpu);
+
+	/* Set the parameters for fx only state */
+	fx_sw->magic1 = 0;
+	fx_sw->xstate_size = sizeof(struct fxregs_state);
+	fx_sw->xfeatures = XFEATURE_MASK_FPSSE;
 	return 0;
 }
 
@@ -213,21 +222,15 @@ retry:
 
 static inline void
 sanitize_restored_user_xstate(union fpregs_state *state,
-			      struct user_i387_ia32_struct *ia32_env,
-			      u64 user_xfeatures, int fx_only)
+			      struct user_i387_ia32_struct *ia32_env, u64 mask)
 {
 	struct xregs_state *xsave = &state->xsave;
 	struct xstate_header *header = &xsave->header;
 
 	if (use_xsave()) {
 		/*
-		 * Clear all feature bits which are not set in
-		 * user_xfeatures and clear all extended features
-		 * for fx_only mode.
-		 */
-		u64 mask = fx_only ? XFEATURE_MASK_FPSSE : user_xfeatures;
-
-		/*
+		 * Clear all feature bits which are not set in mask.
+		 *
 		 * Supervisor state has to be preserved. The sigframe
 		 * restore can only modify user features, i.e. @mask
 		 * cannot contain them.
@@ -286,24 +289,19 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 	struct fpu *fpu = &tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
 	u64 user_xfeatures = 0;
-	int fx_only = 0;
+	bool fx_only = false;
 	int ret = 0;
 
 	if (use_xsave()) {
 		struct _fpx_sw_bytes fx_sw_user;
-		if (unlikely(check_for_xstate(buf_fx, buf_fx, &fx_sw_user))) {
-			/*
-			 * Couldn't find the extended state information in the
-			 * memory layout. Restore just the FP/SSE and init all
-			 * the other extended state.
-			 */
-			state_size = sizeof(struct fxregs_state);
-			fx_only = 1;
-			trace_x86_fpu_xstate_check_failed(fpu);
-		} else {
-			state_size = fx_sw_user.xstate_size;
-			user_xfeatures = fx_sw_user.xfeatures;
-		}
+
+		ret = check_xstate_in_sigframe(buf_fx, &fx_sw_user);
+		if (unlikely(ret))
+			return ret;
+
+		fx_only = !fx_sw_user.magic1;
+		state_size = fx_sw_user.xstate_size;
+		user_xfeatures = fx_sw_user.xfeatures;
 	}
 
 	if (!ia32_fxstate) {
@@ -403,8 +401,7 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		if (ret)
 			return ret;
 
-		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures,
-					      fx_only);
+		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures);
 
 		fpregs_lock();
 		if (unlikely(init_bv))
@@ -422,8 +419,7 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		if (ret)
 			return -EFAULT;
 
-		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures,
-					      fx_only);
+		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures);
 
 		fpregs_lock();
 		if (use_xsave()) {
