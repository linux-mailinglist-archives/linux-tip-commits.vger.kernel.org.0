Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6F73B2332
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhFWWMp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40198 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhFWWLx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:53 -0400
Date:   Wed, 23 Jun 2021 22:09:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486173;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eE68RpTX7J0GXP33Yf6BmO32Mk0rvx9w/9BqN5RliEs=;
        b=nCkw17ks9bizFMdrk/gw9uxiVZ68KzXdS+4+5ZbVv0TJb5nNtuA7AFcMw+kmNWNSWpJsjk
        rmRFdexk1UPtMFyw/1cWQ7O8Z+ia2WO88/LnGT+VAGchA9f902isTIi6KY9taxYxB87JM0
        wspbN51rL4id+nYHSbDVd9wS1UdSUVs5FTHqk7D7gaOJtqypNwezrKgfKp5UF4HQ24A2Zv
        NmHaPZz/WjqshlMF30gn2Rjqdj7c9J9ZNLaNcr/5OxuSCMkJJoLwjdvGstbh1pvsTb3b0h
        AsR3ejKjATyFVnxxOfP3wDSsTGzV06tRF2e2rYufBwyY4YYfsx5x0zflowG5XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486173;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eE68RpTX7J0GXP33Yf6BmO32Mk0rvx9w/9BqN5RliEs=;
        b=mE9ECFPYDVSC6m+TtUqbhYtHDwAtilBDpDZB0q+fzoxtxBvsCIDcUjMdvHI1ACYZpZanj/
        6lxjtDR5PXRwvbDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Use copy_xstate_to_uabi_buf() in fpregs_get()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121453.014441775@linutronix.de>
References: <20210623121453.014441775@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448617275.395.6432458676442236133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     3f7f75634ccefefcc929696f346db7a748e78f79
Gitweb:        https://git.kernel.org/tip/3f7f75634ccefefcc929696f346db7a748e78f79
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:44 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:47 +02:00

x86/fpu: Use copy_xstate_to_uabi_buf() in fpregs_get()

Use the new functionality of copy_xstate_to_uabi_buf() to retrieve the
FX state when XSAVE* is in use. This avoids to overwrite the FPU state
buffer with fpstate_sanitize_xstate() which is error prone and duplicated
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121453.014441775@linutronix.de
---
 arch/x86/kernel/fpu/regset.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index ccbe25f..4b799e4 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -210,10 +210,10 @@ static inline u32 twd_fxsr_to_i387(struct fxregs_state *fxsave)
  * FXSR floating point environment conversions.
  */
 
-void
-convert_from_fxsr(struct user_i387_ia32_struct *env, struct task_struct *tsk)
+static void __convert_from_fxsr(struct user_i387_ia32_struct *env,
+				struct task_struct *tsk,
+				struct fxregs_state *fxsave)
 {
-	struct fxregs_state *fxsave = &tsk->thread.fpu.state.fxsave;
 	struct _fpreg *to = (struct _fpreg *) &env->st_space[0];
 	struct _fpxreg *from = (struct _fpxreg *) &fxsave->st_space[0];
 	int i;
@@ -247,6 +247,12 @@ convert_from_fxsr(struct user_i387_ia32_struct *env, struct task_struct *tsk)
 		memcpy(&to[i], &from[i], sizeof(to[0]));
 }
 
+void
+convert_from_fxsr(struct user_i387_ia32_struct *env, struct task_struct *tsk)
+{
+	__convert_from_fxsr(env, tsk, &tsk->thread.fpu.state.fxsave);
+}
+
 void convert_to_fxsr(struct fxregs_state *fxsave,
 		     const struct user_i387_ia32_struct *env)
 
@@ -279,25 +285,29 @@ int fpregs_get(struct task_struct *target, const struct user_regset *regset,
 {
 	struct fpu *fpu = &target->thread.fpu;
 	struct user_i387_ia32_struct env;
+	struct fxregs_state fxsave, *fx;
 
 	fpu__prepare_read(fpu);
 
-	if (!boot_cpu_has(X86_FEATURE_FPU))
+	if (!cpu_feature_enabled(X86_FEATURE_FPU))
 		return fpregs_soft_get(target, regset, to);
 
-	if (!boot_cpu_has(X86_FEATURE_FXSR)) {
+	if (!cpu_feature_enabled(X86_FEATURE_FXSR)) {
 		return membuf_write(&to, &fpu->state.fsave,
 				    sizeof(struct fregs_state));
 	}
 
-	fpstate_sanitize_xstate(fpu);
+	if (use_xsave()) {
+		struct membuf mb = { .p = &fxsave, .left = sizeof(fxsave) };
 
-	if (to.left == sizeof(env)) {
-		convert_from_fxsr(to.p, target);
-		return 0;
+		/* Handle init state optimized xstate correctly */
+		copy_xstate_to_uabi_buf(mb, &fpu->state.xsave, XSTATE_COPY_FP);
+		fx = &fxsave;
+	} else {
+		fx = &fpu->state.fxsave;
 	}
 
-	convert_from_fxsr(&env, target);
+	__convert_from_fxsr(&env, target, fx);
 	return membuf_write(&to, &env, sizeof(env));
 }
 
