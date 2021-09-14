Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210DD40B7D0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhINTUv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:20:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35352 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhINTUs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:48 -0400
Date:   Tue, 14 Sep 2021 19:19:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647169;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5U4WfpfZbpw1gjpd2I1YXpPjaUBpBxs/fvB3RBgavG4=;
        b=NljBO+u7m+IFmYNFIGVw8lnF4iykGO1hXICe3AbQcFDFiZ+R22mAbYAy7LBHzS8odC+mvd
        fb0JNdffMwjmq3AQZWcRlVsogNLu/CEYDEGOVPrmHmF+Mlu0fBNLyvcChERCOsqxWQw2HQ
        69HpCk+r8wZ9dirGL1DrKTajEgQmqG7d1x6DY6xsMnZEWc3Fz+/1AkhmSrGnZxiOYGvQji
        wltICs8KLQ/NuqiDKvR5uiWlqmQJPkkopYSvAhNmMlC7LztRJVWid63+iYDlj6jc+wBIn6
        JPtN2JUXH5rPUW3uRNgnwZzTKbuLBMtQDL//W4UZlSOtjyVh37IFHGVjrL6H7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647169;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5U4WfpfZbpw1gjpd2I1YXpPjaUBpBxs/fvB3RBgavG4=;
        b=4gZNwQ+yXPWK2ASXmqqXoMXMQ9rJTXnpcjn9SjIONnuOQcapuIpEqJSjX333tKGXzQ4TeY
        eVRjV4YbrMzJeBBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Change return type of
 copy_fpstate_to_sigframe() to boolean
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210908132525.736773588@linutronix.de>
References: <20210908132525.736773588@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164716860.25758.14576439201841108170.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     052adee668284b67105375c0a524f16a423f1424
Gitweb:        https://git.kernel.org/tip/052adee668284b67105375c0a524f16a423f1424
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:32 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Sep 2021 21:10:03 +02:00

x86/fpu/signal: Change return type of copy_fpstate_to_sigframe() to boolean

None of the call sites cares about the actual return code. Change the
return type to boolean and return 'true' on success.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210908132525.736773588@linutronix.de
---
 arch/x86/ia32/ia32_signal.c         |  4 ++--
 arch/x86/include/asm/fpu/internal.h |  2 +-
 arch/x86/kernel/fpu/signal.c        | 20 ++++++++++----------
 arch/x86/kernel/signal.c            |  4 +---
 4 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 5e3d9b7..023198e 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -220,8 +220,8 @@ static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 
 	sp = fpu__alloc_mathframe(sp, 1, &fx_aligned, &math_size);
 	*fpstate = (struct _fpstate_32 __user *) sp;
-	if (copy_fpstate_to_sigframe(*fpstate, (void __user *)fx_aligned,
-				     math_size) < 0)
+	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)fx_aligned,
+				      math_size))
 		return (void __user *) -1L;
 
 	sp -= frame_size;
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index c856ca4..74aa53e 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -386,7 +386,7 @@ static inline void restore_fpregs_from_fpstate(union fpregs_state *fpstate)
 	__restore_fpregs_from_fpstate(fpstate, xfeatures_mask_fpstate());
 }
 
-extern int copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
+extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
 
 /*
  * FPU context switch related helper methods:
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index c4abbd9..7ce396d 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -165,7 +165,7 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  * For [f]xsave state, update the SW reserved fields in the [f]xsave frame
  * indicating the absence/presence of the extended state to the user.
  */
-int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
+bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
 	struct task_struct *tsk = current;
 	int ia32_fxstate = (buf != buf_fx);
@@ -176,13 +176,14 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 
 	if (!static_cpu_has(X86_FEATURE_FPU)) {
 		struct user_i387_ia32_struct fp;
+
 		fpregs_soft_get(current, NULL, (struct membuf){.p = &fp,
 						.left = sizeof(fp)});
-		return copy_to_user(buf, &fp, sizeof(fp)) ? -EFAULT : 0;
+		return !copy_to_user(buf, &fp, sizeof(fp));
 	}
 
 	if (!access_ok(buf, size))
-		return -EACCES;
+		return false;
 
 	if (use_xsave()) {
 		struct xregs_state __user *xbuf = buf_fx;
@@ -191,9 +192,8 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 		 * Clear the xsave header first, so that reserved fields are
 		 * initialized to zero.
 		 */
-		ret = __clear_user(&xbuf->header, sizeof(xbuf->header));
-		if (unlikely(ret))
-			return ret;
+		if (__clear_user(&xbuf->header, sizeof(xbuf->header)))
+			return false;
 	}
 retry:
 	/*
@@ -214,17 +214,17 @@ retry:
 	if (ret) {
 		if (!__clear_user(buf_fx, fpu_user_xstate_size))
 			goto retry;
-		return -1;
+		return false;
 	}
 
 	/* Save the fsave header for the 32-bit frames. */
 	if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
-		return -1;
+		return false;
 
 	if (use_fxsr() && save_xstate_epilog(buf_fx, ia32_fxstate))
-		return -1;
+		return false;
 
-	return 0;
+	return true;
 }
 
 static int __restore_fpregs_from_user(void __user *buf, u64 xrestore,
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index f4d21e4..5f623a1 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -244,7 +244,6 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	unsigned long math_size = 0;
 	unsigned long sp = regs->sp;
 	unsigned long buf_fx = 0;
-	int ret;
 
 	/* redzone */
 	if (IS_ENABLED(CONFIG_X86_64))
@@ -292,8 +291,7 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	}
 
 	/* save i387 and extended state */
-	ret = copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size);
-	if (ret < 0)
+	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size))
 		return (void __user *)-1L;
 
 	return (void __user *)sp;
