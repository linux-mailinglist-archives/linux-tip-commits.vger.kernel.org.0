Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFA13B22F9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhFWWLT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhFWWLP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0D8C061768;
        Wed, 23 Jun 2021 15:08:57 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:08:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Y2TxnAynPLc5oynvpR8lHwosTO3y/vumdDA82wSs3U=;
        b=VbqwOjslIgIhdkMOVeh/t8BvKSg4IJFVjs2iZfmsO72y4IOX55R4S1GWcKjjjhXVrDZd7M
        RNRVLl68nr292WoXm4KZkeap5+N/jWZFKCtCxMkkWZe2guo4Vi05iUhH+5xrhcaKTP9k30
        t8AwO2sJfkedLUiwUZZqmQibb4rHaFn5/L5CaHnXz3OPWV3UvAPW9rq1fo5/LpkQ/paa1n
        H4mflEmb1hkA1+LSzqSS5y23LJefqXVrB5pf0IFYW5+5ThzfnTBuWqwoTCIrO/DABE7PHa
        yXjs/GQt9BELgkgrXOWP8teR0qrMXOy3GUEjdVJ2lTeHOa/yZAk/Ann5TgmuNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Y2TxnAynPLc5oynvpR8lHwosTO3y/vumdDA82wSs3U=;
        b=yIqhIf2CBjQ1EKgxnCRnCIiBDgxK/3WNH9EV1MwRh632kLx94CsugaNNGACJOftVIgWnf6
        onIDeJbPZCinXJBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Move initial checks into fpu__restore_sig()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121457.086336154@linutronix.de>
References: <20210623121457.086336154@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448613475.395.379488066155976873.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     99a5901951b70251965b0d1542d4a8c616842a99
Gitweb:        https://git.kernel.org/tip/99a5901951b70251965b0d1542d4a8c616842a99
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:25 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:59:57 +02:00

x86/fpu/signal: Move initial checks into fpu__restore_sig()

__fpu__restore_sig() is convoluted and some of the basic checks can
trivially be done in the calling function as well as the final error
handling of clearing user state.

 [ bp: Fixup typos. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121457.086336154@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 76 ++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index a42bc9d..42e85c3 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -277,11 +277,11 @@ static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
 		return frstor_from_user_sigframe(buf);
 }
 
-static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
+static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
+			     bool ia32_fxstate)
 {
 	struct user_i387_ia32_struct *envp = NULL;
 	int state_size = fpu_kernel_xstate_size;
-	int ia32_fxstate = (buf != buf_fx);
 	struct task_struct *tsk = current;
 	struct fpu *fpu = &tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
@@ -289,26 +289,6 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	int fx_only = 0;
 	int ret = 0;
 
-	ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
-			 IS_ENABLED(CONFIG_IA32_EMULATION));
-
-	if (!buf) {
-		fpu__clear_user_states(fpu);
-		return 0;
-	}
-
-	if (!access_ok(buf, size)) {
-		ret = -EACCES;
-		goto out;
-	}
-
-	if (!static_cpu_has(X86_FEATURE_FPU)) {
-		ret = fpregs_soft_set(current, NULL, 0,
-				      sizeof(struct user_i387_ia32_struct),
-				      NULL, buf);
-		goto out;
-	}
-
 	if (use_xsave()) {
 		struct _fpx_sw_bytes fx_sw_user;
 		if (unlikely(check_for_xstate(buf_fx, buf_fx, &fx_sw_user))) {
@@ -391,7 +371,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		 */
 		ret = __copy_from_user(&env, buf, sizeof(env));
 		if (ret)
-			goto out;
+			return ret;
 		envp = &env;
 	}
 
@@ -424,7 +404,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 
 		ret = copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx);
 		if (ret)
-			goto out;
+			return ret;
 
 		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures,
 					      fx_only);
@@ -442,10 +422,8 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 
 	} else if (use_fxsr()) {
 		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
-		if (ret) {
-			ret = -EFAULT;
-			goto out;
-		}
+		if (ret)
+			return -EFAULT;
 
 		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures,
 					      fx_only);
@@ -462,7 +440,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	} else {
 		ret = __copy_from_user(&fpu->state.fsave, buf_fx, state_size);
 		if (ret)
-			goto out;
+			return ret;
 
 		fpregs_lock();
 		ret = frstor_safe(&fpu->state.fsave);
@@ -472,10 +450,6 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	else
 		fpregs_deactivate(fpu);
 	fpregs_unlock();
-
-out:
-	if (ret)
-		fpu__clear_user_states(fpu);
 	return ret;
 }
 
@@ -490,15 +464,47 @@ static inline int xstate_sigframe_size(void)
  */
 int fpu__restore_sig(void __user *buf, int ia32_frame)
 {
+	unsigned int size = xstate_sigframe_size();
+	struct fpu *fpu = &current->thread.fpu;
 	void __user *buf_fx = buf;
-	int size = xstate_sigframe_size();
+	bool ia32_fxstate = false;
+	int ret;
+
+	if (unlikely(!buf)) {
+		fpu__clear_user_states(fpu);
+		return 0;
+	}
 
+	ia32_frame &= (IS_ENABLED(CONFIG_X86_32) ||
+		       IS_ENABLED(CONFIG_IA32_EMULATION));
+
+	/*
+	 * Only FXSR enabled systems need the FX state quirk.
+	 * FRSTOR does not need it and can use the fast path.
+	 */
 	if (ia32_frame && use_fxsr()) {
 		buf_fx = buf + sizeof(struct fregs_state);
 		size += sizeof(struct fregs_state);
+		ia32_fxstate = true;
 	}
 
-	return __fpu__restore_sig(buf, buf_fx, size);
+	if (!access_ok(buf, size)) {
+		ret = -EACCES;
+		goto out;
+	}
+
+	if (!IS_ENABLED(CONFIG_X86_64) && !cpu_feature_enabled(X86_FEATURE_FPU)) {
+		ret = fpregs_soft_set(current, NULL, 0,
+				      sizeof(struct user_i387_ia32_struct),
+				      NULL, buf);
+	} else {
+		ret = __fpu_restore_sig(buf, buf_fx, ia32_fxstate);
+	}
+
+out:
+	if (unlikely(ret))
+		fpu__clear_user_states(fpu);
+	return ret;
 }
 
 unsigned long
