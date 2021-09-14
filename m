Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D53A40B7C9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhINTUq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbhINTUp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2532C061574;
        Tue, 14 Sep 2021 12:19:27 -0700 (PDT)
Date:   Tue, 14 Sep 2021 19:19:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647166;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sRfytcSqwLD4co8hoF+up0Mrny0fjFUnFcGO5JGR51s=;
        b=bMc+n3dmSnQUVllCAXKAOTQGw0qoI6S/ft+NSeshri5+GJJleY0ey6eKObgxYP6hlmTsqd
        9rPE9HN9nTyWu8HGKDYd8bw3D8PJ99W0l0mctTlZVnyq98hrMo6hu2EpqwzwjBgfEjtVSB
        Vii247LUe7yo//DamtYrS7EednjPdDhZUiyn8mdkxGV18bgbNsaPCo4yalO171Y6gJrvnT
        elkwQkkSTcyyy9VZM0KflVv4iz8f7ytQ3LYKGx4RNCcIn62oDIy7BZeODhRwfNG97a07pq
        J6W4aCMCQqIvzsZmPIO2s7Hd1JsAxOhoSNFZ4kbyvm7gidUJ5OCepf51g0u8uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647166;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sRfytcSqwLD4co8hoF+up0Mrny0fjFUnFcGO5JGR51s=;
        b=uiCriZxpXn8k7DJ7doC9ASMUKsng3BGsuzlWjXCBb/RQfQ8l/dp8XMt8m8vUQqgYu/OAg1
        ddGFtseNjfFSosBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Change return type of
 __fpu_restore_sig() to boolean
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210908132525.966197097@linutronix.de>
References: <20210908132525.966197097@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164716547.25758.15806977710913904680.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     1193f408cd5140f2cfd38c7e60a2d39d39cd485f
Gitweb:        https://git.kernel.org/tip/1193f408cd5140f2cfd38c7e60a2d39d39cd485f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:38 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Sep 2021 21:10:03 +02:00

x86/fpu/signal: Change return type of __fpu_restore_sig() to boolean

Now that fpu__restore_sig() returns a boolean get rid of the individual
error codes in __fpu_restore_sig() as well.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210908132525.966197097@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 41 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index d418d28..912d770 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -309,8 +309,8 @@ retry:
 	return 0;
 }
 
-static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
-			     bool ia32_fxstate)
+static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
+			      bool ia32_fxstate)
 {
 	int state_size = fpu_kernel_xstate_size;
 	struct task_struct *tsk = current;
@@ -318,14 +318,14 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 	struct user_i387_ia32_struct env;
 	u64 user_xfeatures = 0;
 	bool fx_only = false;
-	int ret;
+	bool success;
+
 
 	if (use_xsave()) {
 		struct _fpx_sw_bytes fx_sw_user;
 
-		ret = check_xstate_in_sigframe(buf_fx, &fx_sw_user);
-		if (unlikely(ret))
-			return ret;
+		if (check_xstate_in_sigframe(buf_fx, &fx_sw_user))
+			return false;
 
 		fx_only = !fx_sw_user.magic1;
 		state_size = fx_sw_user.xstate_size;
@@ -341,8 +341,8 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		 * faults. If it does, fall back to the slow path below, going
 		 * through the kernel buffer with the enabled pagefault handler.
 		 */
-		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
-						state_size);
+		return !restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
+						 state_size);
 	}
 
 	/*
@@ -350,9 +350,8 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 	 * to be ignored for histerical raisins. The legacy state is folded
 	 * in once the larger state has been copied.
 	 */
-	ret = __copy_from_user(&env, buf, sizeof(env));
-	if (ret)
-		return ret;
+	if (__copy_from_user(&env, buf, sizeof(env)))
+		return false;
 
 	/*
 	 * By setting TIF_NEED_FPU_LOAD it is ensured that our xstate is
@@ -379,17 +378,16 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 	fpregs_unlock();
 
 	if (use_xsave() && !fx_only) {
-		ret = copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx);
-		if (ret)
-			return ret;
+		if (copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx))
+			return false;
 	} else {
 		if (__copy_from_user(&fpu->state.fxsave, buf_fx,
 				     sizeof(fpu->state.fxsave)))
-			return -EFAULT;
+			return false;
 
 		/* Reject invalid MXCSR values. */
 		if (fpu->state.fxsave.mxcsr & ~mxcsr_feature_mask)
-			return -EINVAL;
+			return false;
 
 		/* Enforce XFEATURE_MASK_FPSSE when XSAVE is enabled */
 		if (use_xsave())
@@ -413,17 +411,18 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		u64 mask = user_xfeatures | xfeatures_mask_supervisor();
 
 		fpu->state.xsave.header.xfeatures &= mask;
-		ret = os_xrstor_safe(&fpu->state.xsave, xfeatures_mask_all) ? -EINVAL : 0;
+		success = !os_xrstor_safe(&fpu->state.xsave, xfeatures_mask_all);
 	} else {
-		ret = fxrstor_safe(&fpu->state.fxsave);
+		success = !fxrstor_safe(&fpu->state.fxsave);
 	}
 
-	if (likely(!ret))
+	if (likely(success))
 		fpregs_mark_activate();
 
 	fpregs_unlock();
-	return ret;
+	return success;
 }
+
 static inline int xstate_sigframe_size(void)
 {
 	return use_xsave() ? fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE :
@@ -467,7 +466,7 @@ bool fpu__restore_sig(void __user *buf, int ia32_frame)
 					   sizeof(struct user_i387_ia32_struct),
 					   NULL, buf);
 	} else {
-		success = !__fpu_restore_sig(buf, buf_fx, ia32_fxstate);
+		success = __fpu_restore_sig(buf, buf_fx, ia32_fxstate);
 	}
 
 out:
