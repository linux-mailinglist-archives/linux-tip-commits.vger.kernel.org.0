Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3896F3B2367
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhFWWOp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFWWNs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:13:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46733C06114C;
        Wed, 23 Jun 2021 15:09:32 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486170;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YzsxAQj9rJFo4rHX9dYK+RG6ql3ACgzoUxt5JtMSTcU=;
        b=xSZohBS2DDvzjIV1CiLQ7/orhk64g30szwbNmXZ/sd/9rg3Do27x6eHMb4ZMi8lbet00c/
        iORZDw9VmknN00FoGNq63IfR1Mdi5Yw9CbCYcAEQK9EOVFx1FmWAwiDPiKHk2EQootk+Ge
        8oVDwKjoTRQGjFuJLhDeegEIWV9BV5ICgp4M2/zzwQyhJmobrAqfC6vJ8gczeHzdsz7t6m
        zRFbNbwtjUXoOskSdz6PKttpheMjfXFd5AwuII/R5s4c0r/qsnxF2PamEvTPa1jDNGHjk6
        VkCtR1+e0EklYEyzze6ZgjA55Nfyqye2T6SD1RhlEUrDpzvdQoPrVA57PtBJ3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486170;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YzsxAQj9rJFo4rHX9dYK+RG6ql3ACgzoUxt5JtMSTcU=;
        b=2mfaiOh+kGj0+SgE3V4/B6IJCt9UrR24+tdyHDq6udRLsjhoQfxMmyd7syrGFwCDG59qmZ
        2ma1oBq8UGmAX8DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Move fpu__write_begin() to regset
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121453.328652975@linutronix.de>
References: <20210623121453.328652975@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448617005.395.16836356982355899488.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     dbb60ac764581e62f2116c5a6b8926ba3a872dd4
Gitweb:        https://git.kernel.org/tip/dbb60ac764581e62f2116c5a6b8926ba3a872dd4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:47 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:47 +02:00

x86/fpu: Move fpu__write_begin() to regset

The only usecase for fpu__write_begin is the set() callback of regset, so
the function is pointlessly global.

Move it to the regset code and rename it to fpu_force_restore() which is
exactly decribing what the function does.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121453.328652975@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h |  1 -
 arch/x86/kernel/fpu/core.c          | 24 ------------------------
 arch/x86/kernel/fpu/regset.c        | 25 ++++++++++++++++++++++---
 3 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 4c669f3..854bfb0 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -26,7 +26,6 @@
 /*
  * High level FPU state handling functions:
  */
-extern void fpu__prepare_write(struct fpu *fpu);
 extern void fpu__save(struct fpu *fpu);
 extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
 extern void fpu__drop(struct fpu *fpu);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index d390644..2243701 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -282,30 +282,6 @@ static void fpu__initialize(struct fpu *fpu)
 }
 
 /*
- * This function must be called before we write a task's fpstate.
- *
- * Invalidate any cached FPU registers.
- *
- * After this function call, after registers in the fpstate are
- * modified and the child task has woken up, the child task will
- * restore the modified FPU state from the modified context. If we
- * didn't clear its cached status here then the cached in-registers
- * state pending on its former CPU could be restored, corrupting
- * the modifications.
- */
-void fpu__prepare_write(struct fpu *fpu)
-{
-	/*
-	 * Only stopped child tasks can be used to modify the FPU
-	 * state in the fpstate buffer:
-	 */
-	WARN_ON_FPU(fpu == &current->thread.fpu);
-
-	/* Invalidate any cached state: */
-	__fpu_invalidate_fpregs_state(fpu);
-}
-
-/*
  * Drops current FPU state: deactivates the fpregs and
  * the fpstate. NOTE: it still leaves previous contents
  * in the fpregs in the eager-FPU case.
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 937adf7..ddc290d 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -44,6 +44,25 @@ static void sync_fpstate(struct fpu *fpu)
 		fpu__save(fpu);
 }
 
+/*
+ * Invalidate cached FPU registers before modifying the stopped target
+ * task's fpstate.
+ *
+ * This forces the target task on resume to restore the FPU registers from
+ * modified fpstate. Otherwise the task might skip the restore and operate
+ * with the cached FPU registers which discards the modifications.
+ */
+static void fpu_force_restore(struct fpu *fpu)
+{
+	/*
+	 * Only stopped child tasks can be used to modify the FPU
+	 * state in the fpstate buffer:
+	 */
+	WARN_ON_FPU(fpu == &current->thread.fpu);
+
+	__fpu_invalidate_fpregs_state(fpu);
+}
+
 int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf to)
 {
@@ -88,7 +107,7 @@ int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
 	if (newstate.mxcsr & ~mxcsr_feature_mask)
 		return -EINVAL;
 
-	fpu__prepare_write(fpu);
+	fpu_force_restore(fpu);
 
 	/* Copy the state  */
 	memcpy(&fpu->state.fxsave, &newstate, sizeof(newstate));
@@ -146,7 +165,7 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 		}
 	}
 
-	fpu__prepare_write(fpu);
+	fpu_force_restore(fpu);
 	ret = copy_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
 
 out:
@@ -346,7 +365,7 @@ int fpregs_set(struct task_struct *target, const struct user_regset *regset,
 	if (ret)
 		return ret;
 
-	fpu__prepare_write(fpu);
+	fpu_force_restore(fpu);
 
 	if (cpu_feature_enabled(X86_FEATURE_FXSR))
 		convert_to_fxsr(&fpu->state.fxsave, &env);
