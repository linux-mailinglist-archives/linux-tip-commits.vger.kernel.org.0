Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66CC43656A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhJUPPA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhJUPOx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B160BC061224;
        Thu, 21 Oct 2021 08:12:35 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:12:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829154;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jWtRbH2WSfaDVgll/7m6o4p2UkrAQdDc3D+VOK+b4FY=;
        b=vRAV5cBRIJ6iDAPYrWgJr2ywxZyAQMN9MAXD1IdjrzD6HTl/EFEZ3zN7UE4Wkdk4z3Duu8
        YkNUqToDQaxwuQw8S+k6uz7wFcJHb/Gk0yTR2EEIQmv3cxnbJNzKiUhwOXyb2mrJIxDJ4H
        R9Q+dPqSGN+lJvsg/umxZGSeNjHlRB/T/BF5VTqr9boaXdwxICZWGynYKiuG9rNw6biI8y
        0SyWtOABB1pKTwsjhth3R+A2qFlp+adiar0kzvB+lmbSazyXbc7dG1OFkCIEmV73fS3kO8
        +hKIFEnPpoJUvxG551l0+Jfp2HhmkziXNYmdkWX0pLYGHw5pnFtbPxqW5p5l1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829154;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jWtRbH2WSfaDVgll/7m6o4p2UkrAQdDc3D+VOK+b4FY=;
        b=UyhcXHqVWzaibmYi6fSluYgyAh6bTpISS0rtFAa/d3CUt9azYOX33O/4gHybZY+h8vgWj3
        3f5uW0HGB4qH79AQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/regset: Convert to fpstate
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145322.555239736@linutronix.de>
References: <20211013145322.555239736@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482915341.25758.6298773277711142435.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     caee31a36c33ed7788d0b3d93a663860157f6c55
Gitweb:        https://git.kernel.org/tip/caee31a36c33ed7788d0b3d93a663860157f6c55
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:36 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 22:35:29 +02:00

x86/fpu/regset: Convert to fpstate

Convert regset related code to the new register storage mechanism in
preparation for dynamically sized buffers.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145322.555239736@linutronix.de
---
 arch/x86/kernel/fpu/regset.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 01a1d97..ec77779 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -78,8 +78,8 @@ int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
 	sync_fpstate(fpu);
 
 	if (!use_xsave()) {
-		return membuf_write(&to, &fpu->state.fxsave,
-				    sizeof(fpu->state.fxsave));
+		return membuf_write(&to, &fpu->fpstate->regs.fxsave,
+				    sizeof(fpu->fpstate->regs.fxsave));
 	}
 
 	copy_xstate_to_uabi_buf(to, target, XSTATE_COPY_FX);
@@ -114,15 +114,15 @@ int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
 	fpu_force_restore(fpu);
 
 	/* Copy the state  */
-	memcpy(&fpu->state.fxsave, &newstate, sizeof(newstate));
+	memcpy(&fpu->fpstate->regs.fxsave, &newstate, sizeof(newstate));
 
 	/* Clear xmm8..15 */
-	BUILD_BUG_ON(sizeof(fpu->state.fxsave.xmm_space) != 16 * 16);
-	memset(&fpu->state.fxsave.xmm_space[8], 0, 8 * 16);
+	BUILD_BUG_ON(sizeof(fpu->__fpstate.regs.fxsave.xmm_space) != 16 * 16);
+	memset(&fpu->fpstate->regs.fxsave.xmm_space[8], 0, 8 * 16);
 
 	/* Mark FP and SSE as in use when XSAVE is enabled */
 	if (use_xsave())
-		fpu->state.xsave.header.xfeatures |= XFEATURE_MASK_FPSSE;
+		fpu->fpstate->regs.xsave.header.xfeatures |= XFEATURE_MASK_FPSSE;
 
 	return 0;
 }
@@ -168,7 +168,8 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	}
 
 	fpu_force_restore(fpu);
-	ret = copy_uabi_from_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
+	ret = copy_uabi_from_kernel_to_xstate(&fpu->fpstate->regs.xsave,
+					      kbuf ?: tmpbuf);
 
 out:
 	vfree(tmpbuf);
@@ -287,7 +288,7 @@ static void __convert_from_fxsr(struct user_i387_ia32_struct *env,
 void
 convert_from_fxsr(struct user_i387_ia32_struct *env, struct task_struct *tsk)
 {
-	__convert_from_fxsr(env, tsk, &tsk->thread.fpu.state.fxsave);
+	__convert_from_fxsr(env, tsk, &tsk->thread.fpu.fpstate->regs.fxsave);
 }
 
 void convert_to_fxsr(struct fxregs_state *fxsave,
@@ -330,7 +331,7 @@ int fpregs_get(struct task_struct *target, const struct user_regset *regset,
 		return fpregs_soft_get(target, regset, to);
 
 	if (!cpu_feature_enabled(X86_FEATURE_FXSR)) {
-		return membuf_write(&to, &fpu->state.fsave,
+		return membuf_write(&to, &fpu->fpstate->regs.fsave,
 				    sizeof(struct fregs_state));
 	}
 
@@ -341,7 +342,7 @@ int fpregs_get(struct task_struct *target, const struct user_regset *regset,
 		copy_xstate_to_uabi_buf(mb, target, XSTATE_COPY_FP);
 		fx = &fxsave;
 	} else {
-		fx = &fpu->state.fxsave;
+		fx = &fpu->fpstate->regs.fxsave;
 	}
 
 	__convert_from_fxsr(&env, target, fx);
@@ -370,16 +371,16 @@ int fpregs_set(struct task_struct *target, const struct user_regset *regset,
 	fpu_force_restore(fpu);
 
 	if (cpu_feature_enabled(X86_FEATURE_FXSR))
-		convert_to_fxsr(&fpu->state.fxsave, &env);
+		convert_to_fxsr(&fpu->fpstate->regs.fxsave, &env);
 	else
-		memcpy(&fpu->state.fsave, &env, sizeof(env));
+		memcpy(&fpu->fpstate->regs.fsave, &env, sizeof(env));
 
 	/*
 	 * Update the header bit in the xsave header, indicating the
 	 * presence of FP.
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_XSAVE))
-		fpu->state.xsave.header.xfeatures |= XFEATURE_MASK_FP;
+		fpu->fpstate->regs.xsave.header.xfeatures |= XFEATURE_MASK_FP;
 
 	return 0;
 }
