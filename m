Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804163B22EE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFWWLL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39898 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhFWWLK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:10 -0400
Date:   Wed, 23 Jun 2021 22:08:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQSrh0rf3ZhqBj51BFCIwsanUg7t0IJ/2rC/IXBqKgU=;
        b=X956ikzlT08CUVVsoBJHlqZb2JwqsGOffXFxaU1vLbdFePIrAH1k3eRbE/iSo2dcBVDZNs
        RiHfaTwWwBqfSKIZCsw3bF4eTFlgPVlyZ5Q2fu0SJ42NklUUYh4mYC6arevdfNl2mmJtgv
        R6Ynyz7Fw4S7cosyGLetNMe1ErwfL5tInTw+bILWKdkMjygDMsTs+0ewCJOTE5i2xfFhk6
        9Funp5JXY06GCT8S4d0zSO5ZYdunylNyAqSAT4OSknJ7PR1OjoouMcJtWC321Vgkwqut0d
        gXtpPKXbqqi1sajAm60wOJmcSSX6F0K3l1LG1MjMmsa0mSy7mWJInSV3jhbLTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQSrh0rf3ZhqBj51BFCIwsanUg7t0IJ/2rC/IXBqKgU=;
        b=lsds9KASnrBYC5X0yJB3umFOHCbwyArJ1rBJrwLJELjPenjt8iwqGTfdJ3IXdz3xI/JMgJ
        0u7/OZCGyAfeDDAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Handle #PF in the direct restore path
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121457.696022863@linutronix.de>
References: <20210623121457.696022863@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448612941.395.11659574309358890895.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     fcb3635f5018e53024c6be3c3213737f469f74ff
Gitweb:        https://git.kernel.org/tip/fcb3635f5018e53024c6be3c3213737f469f74ff
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:31 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 20:05:33 +02:00

x86/fpu/signal: Handle #PF in the direct restore path

If *RSTOR raises an exception, then the slow path is taken. That's wrong
because if the reason was not #PF then going through the slow path is waste
of time because that will end up with the same conclusion that the data is
invalid.

Now that the wrapper around *RSTOR return an negative error code, which is
the negated trap number, it's possible to differentiate.

If the *RSTOR raised #PF then handle it directly in the fast path and if it
was some other exception, e.g. #GP, then give up and do not try the fast
path.

This removes the legacy frame FRSTOR code from the slow path because FRSTOR
is not a ia32_fxstate frame and is therefore handled in the fast path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121457.696022863@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 67 +++++++++++++++++------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index aa268d9..4c252d0 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -272,11 +272,17 @@ static int __restore_fpregs_from_user(void __user *buf, u64 xrestore,
 	}
 }
 
-static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
+/*
+ * Attempt to restore the FPU registers directly from user memory.
+ * Pagefaults are handled and any errors returned are fatal.
+ */
+static int restore_fpregs_from_user(void __user *buf, u64 xrestore,
+				    bool fx_only, unsigned int size)
 {
 	struct fpu *fpu = &current->thread.fpu;
 	int ret;
 
+retry:
 	fpregs_lock();
 	pagefault_disable();
 	ret = __restore_fpregs_from_user(buf, xrestore, fx_only);
@@ -293,14 +299,18 @@ static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only
 		 * invalidate the FPU register state otherwise the task
 		 * might preempt current and return to user space with
 		 * corrupted FPU registers.
-		 *
-		 * In case current owns the FPU registers then no further
-		 * action is required. The fixup in the slow path will
-		 * handle it correctly.
 		 */
 		if (test_thread_flag(TIF_NEED_FPU_LOAD))
 			__cpu_invalidate_fpregs_state();
 		fpregs_unlock();
+
+		/* Try to handle #PF, but anything else is fatal. */
+		if (ret != -EFAULT)
+			return -EINVAL;
+
+		ret = fault_in_pages_readable(buf, size);
+		if (!ret)
+			goto retry;
 		return ret;
 	}
 
@@ -311,9 +321,7 @@ static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only
 	 *
 	 * It would be optimal to handle this with a single XRSTORS, but
 	 * this does not work because the rest of the FPU registers have
-	 * been restored from a user buffer directly. The single XRSTORS
-	 * happens below, when the user buffer has been copied to the
-	 * kernel one.
+	 * been restored from a user buffer directly.
 	 */
 	if (test_thread_flag(TIF_NEED_FPU_LOAD) && xfeatures_mask_supervisor())
 		os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
@@ -326,14 +334,13 @@ static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only
 static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 			     bool ia32_fxstate)
 {
-	struct user_i387_ia32_struct *envp = NULL;
 	int state_size = fpu_kernel_xstate_size;
 	struct task_struct *tsk = current;
 	struct fpu *fpu = &tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
 	u64 user_xfeatures = 0;
 	bool fx_only = false;
-	int ret = 0;
+	int ret;
 
 	if (use_xsave()) {
 		struct _fpx_sw_bytes fx_sw_user;
@@ -354,21 +361,20 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		 * faults. If it does, fall back to the slow path below, going
 		 * through the kernel buffer with the enabled pagefault handler.
 		 */
-		ret = restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only);
-		if (likely(!ret))
-			return 0;
-	} else {
-		/*
-		 * For 32-bit frames with fxstate, copy the fxstate so it can
-		 * be reconstructed later.
-		 */
-		ret = __copy_from_user(&env, buf, sizeof(env));
-		if (ret)
-			return ret;
-		envp = &env;
+		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
+						state_size);
 	}
 
 	/*
+	 * Copy the legacy state because the FP portion of the FX frame has
+	 * to be ignored for histerical raisins. The legacy state is folded
+	 * in once the larger state has been copied.
+	 */
+	ret = __copy_from_user(&env, buf, sizeof(env));
+	if (ret)
+		return ret;
+
+	/*
 	 * By setting TIF_NEED_FPU_LOAD it is ensured that our xstate is
 	 * not modified on context switch and that the xstate is considered
 	 * to be loaded again on return to userland (overriding last_cpu avoids
@@ -382,8 +388,7 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		 * supervisor state is preserved. Save the full state for
 		 * simplicity. There is no point in optimizing this by only
 		 * saving the supervisor states and then shuffle them to
-		 * the right place in memory. This is the slow path and the
-		 * above XRSTOR failed or ia32_fxstate is true. Shrug.
+		 * the right place in memory. It's ia32 mode. Shrug.
 		 */
 		if (xfeatures_mask_supervisor())
 			os_xsave(&fpu->state.xsave);
@@ -399,7 +404,7 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		if (ret)
 			return ret;
 
-		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures);
+		sanitize_restored_user_xstate(&fpu->state, &env, user_xfeatures);
 
 		fpregs_lock();
 		if (unlikely(init_bv))
@@ -412,12 +417,12 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		ret = os_xrstor_safe(&fpu->state.xsave,
 				     user_xfeatures | xfeatures_mask_supervisor());
 
-	} else if (use_fxsr()) {
+	} else {
 		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
 		if (ret)
 			return -EFAULT;
 
-		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures);
+		sanitize_restored_user_xstate(&fpu->state, &env, user_xfeatures);
 
 		fpregs_lock();
 		if (use_xsave()) {
@@ -428,14 +433,8 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		}
 
 		ret = fxrstor_safe(&fpu->state.fxsave);
-	} else {
-		ret = __copy_from_user(&fpu->state.fsave, buf_fx, state_size);
-		if (ret)
-			return ret;
-
-		fpregs_lock();
-		ret = frstor_safe(&fpu->state.fsave);
 	}
+
 	if (!ret)
 		fpregs_mark_activate();
 	else
