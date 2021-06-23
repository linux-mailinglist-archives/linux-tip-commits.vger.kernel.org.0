Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834843B232F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhFWWMn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40188 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhFWWLu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:50 -0400
Date:   Wed, 23 Jun 2021 22:09:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lKHhVnlFVxfyUN9n1y00gyt5AaXrHFMEAH09wQvZQys=;
        b=no8R6V4+0Pm0wBEY7QfmSrmenS+wi4TZoJYKZLfDIf7yBHkfSqIVisFoJTjN4i7XdkEg3R
        z1FpZCjO60/wJhaZPcpNjB9GRGUn5M6Ol4YjlcEzNkUhOKFOgV3ZE6awxSzCuq7TIYM4wO
        yCHIoddeaR7E7AtWyz8qvs2355/V2O9M3Ncf3j5yVMuY20rybcaO45cYpvZDhCgZEc7fIO
        S2dZ2H7TNa6y3AgzRi6AScwHEU8cTqdPntLFv8wxIQRr2x3w39dsBuDm8EQPlmoLaKLpU+
        zVg+mkn4Sj6kK5NzsNQ9H9TmRXYpaQz1Xlmz5Opj0OLMzumzpU51egHIBYQcgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lKHhVnlFVxfyUN9n1y00gyt5AaXrHFMEAH09wQvZQys=;
        b=3FXP+DAJSbl0tqebJoH7dYryFc9QWerhcIn3+N1nK3FkF53fPozRKzGbz/vYA8+EcAMrq4
        Oj07p6s6qY8N31Dw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/regset: Move fpu__read_begin() into regset
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121453.234942936@linutronix.de>
References: <20210623121453.234942936@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448617082.395.13202555998624495069.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     5a32fac8dbe8adc08c10e2c8770c95aebfc627cd
Gitweb:        https://git.kernel.org/tip/5a32fac8dbe8adc08c10e2c8770c95aebfc627cd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:46 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:47 +02:00

x86/fpu/regset: Move fpu__read_begin() into regset

The function can only be used from the regset get() callbacks safely. So
there is no reason to have it globally exposed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121453.234942936@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h |  1 -
 arch/x86/kernel/fpu/core.c          | 20 --------------------
 arch/x86/kernel/fpu/regset.c        | 22 +++++++++++++++++++---
 3 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 0148791..4c669f3 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -26,7 +26,6 @@
 /*
  * High level FPU state handling functions:
  */
-extern void fpu__prepare_read(struct fpu *fpu);
 extern void fpu__prepare_write(struct fpu *fpu);
 extern void fpu__save(struct fpu *fpu);
 extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 9ff467b..d390644 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -282,26 +282,6 @@ static void fpu__initialize(struct fpu *fpu)
 }
 
 /*
- * This function must be called before we read a task's fpstate.
- *
- * There's two cases where this gets called:
- *
- * - for the current task (when coredumping), in which case we have
- *   to save the latest FPU registers into the fpstate,
- *
- * - or it's called for stopped tasks (ptrace), in which case the
- *   registers were already saved by the context-switch code when
- *   the task scheduled out.
- *
- * If the task has used the FPU before then save it.
- */
-void fpu__prepare_read(struct fpu *fpu)
-{
-	if (fpu == &current->thread.fpu)
-		fpu__save(fpu);
-}
-
-/*
  * This function must be called before we write a task's fpstate.
  *
  * Invalidate any cached FPU registers.
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 4b799e4..937adf7 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -28,6 +28,22 @@ int regset_xregset_fpregs_active(struct task_struct *target, const struct user_r
 		return 0;
 }
 
+/*
+ * The regset get() functions are invoked from:
+ *
+ *   - coredump to dump the current task's fpstate. If the current task
+ *     owns the FPU then the memory state has to be synchronized and the
+ *     FPU register state preserved. Otherwise fpstate is already in sync.
+ *
+ *   - ptrace to dump fpstate of a stopped task, in which case the registers
+ *     have already been saved to fpstate on context switch.
+ */
+static void sync_fpstate(struct fpu *fpu)
+{
+	if (fpu == &current->thread.fpu)
+		fpu__save(fpu);
+}
+
 int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf to)
 {
@@ -36,7 +52,7 @@ int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
 	if (!cpu_feature_enabled(X86_FEATURE_FXSR))
 		return -ENODEV;
 
-	fpu__prepare_read(fpu);
+	sync_fpstate(fpu);
 
 	if (!use_xsave()) {
 		return membuf_write(&to, &fpu->state.fxsave,
@@ -96,7 +112,7 @@ int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 	if (!cpu_feature_enabled(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
-	fpu__prepare_read(fpu);
+	sync_fpstate(fpu);
 
 	copy_xstate_to_uabi_buf(to, &fpu->state.xsave, XSTATE_COPY_XSAVE);
 	return 0;
@@ -287,7 +303,7 @@ int fpregs_get(struct task_struct *target, const struct user_regset *regset,
 	struct user_i387_ia32_struct env;
 	struct fxregs_state fxsave, *fx;
 
-	fpu__prepare_read(fpu);
+	sync_fpstate(fpu);
 
 	if (!cpu_feature_enabled(X86_FEATURE_FPU))
 		return fpregs_soft_get(target, regset, to);
