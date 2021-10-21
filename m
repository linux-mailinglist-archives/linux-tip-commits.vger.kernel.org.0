Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B055F436567
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhJUPO4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:14:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60788 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhJUPOu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:50 -0400
Date:   Thu, 21 Oct 2021 15:12:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829153;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NmURMdaogB67uga1aE/mOfit/T3V8mIXpawHlxKkHjc=;
        b=HEZExTAh1C/iDK2x3w9nxK8cEsRCeVX/Yw989iaEpfLKEZxJpobQf0WEYU62Gp6jlKgffO
        TFB8eAtsDO5ALGhXccDd/NrXIcxlogNr0+rUKCcBPeXJtwk0FDrOxsvyI60sRVUQzA08AL
        YXnKPzPGmZC0pu4MbyCavyOiKKXd5eGPPr/BqfgESUCuts4Ga/jbCTZQdBvat3nZx55jb0
        9GakaOUmqfCypsiD+OD3Wg+GIjd0BqsHEK7ElkzsqF8bJ4f/tDBxj3ZwDK8O8NEiLVvosO
        DlpBPAXjjF5GfjYGs6uZtAQm0FMoEv0bJurJHTNAMNkQaENj45U4Pf59/W+pfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829153;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NmURMdaogB67uga1aE/mOfit/T3V8mIXpawHlxKkHjc=;
        b=7FvwQqdZvQatoE4rcAUAlMrkKR/hcRSJaMTtc32Ozwrn0df7yv22AvRfR3kVlVJ3aUOAYc
        BMDgn02qWpA4H4Dg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Convert to fpstate
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145322.607370221@linutronix.de>
References: <20211013145322.607370221@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482915275.25758.13511822248163441750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     7e049e8b74591038c831e765585ae9038b7880a1
Gitweb:        https://git.kernel.org/tip/7e049e8b74591038c831e765585ae9038b7880a1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:37 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 22:41:15 +02:00

x86/fpu/signal: Convert to fpstate

Convert signal related code to the new register storage mechanism in
preparation for dynamically sized buffers.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145322.607370221@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 416a110..c54c2a3 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -72,13 +72,13 @@ setfx:
 static inline bool save_fsave_header(struct task_struct *tsk, void __user *buf)
 {
 	if (use_fxsr()) {
-		struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
+		struct xregs_state *xsave = &tsk->thread.fpu.fpstate->regs.xsave;
 		struct user_i387_ia32_struct env;
 		struct _fpstate_32 __user *fp = buf;
 
 		fpregs_lock();
 		if (!test_thread_flag(TIF_NEED_FPU_LOAD))
-			fxsave(&tsk->thread.fpu.state.fxsave);
+			fxsave(&tsk->thread.fpu.fpstate->regs.fxsave);
 		fpregs_unlock();
 
 		convert_from_fxsr(&env, tsk);
@@ -303,7 +303,7 @@ retry:
 	 * been restored from a user buffer directly.
 	 */
 	if (test_thread_flag(TIF_NEED_FPU_LOAD) && xfeatures_mask_supervisor())
-		os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
+		os_xrstor(&fpu->fpstate->regs.xsave, xfeatures_mask_supervisor());
 
 	fpregs_mark_activate();
 	fpregs_unlock();
@@ -317,6 +317,7 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 	struct task_struct *tsk = current;
 	struct fpu *fpu = &tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
+	union fpregs_state *fpregs;
 	u64 user_xfeatures = 0;
 	bool fx_only = false;
 	bool success;
@@ -349,6 +350,7 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 	if (__copy_from_user(&env, buf, sizeof(env)))
 		return false;
 
+	fpregs = &fpu->fpstate->regs;
 	/*
 	 * By setting TIF_NEED_FPU_LOAD it is ensured that our xstate is
 	 * not modified on context switch and that the xstate is considered
@@ -366,7 +368,7 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		 * the right place in memory. It's ia32 mode. Shrug.
 		 */
 		if (xfeatures_mask_supervisor())
-			os_xsave(&fpu->state.xsave);
+			os_xsave(&fpregs->xsave);
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 	}
 	__fpu_invalidate_fpregs_state(fpu);
@@ -374,29 +376,29 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 	fpregs_unlock();
 
 	if (use_xsave() && !fx_only) {
-		if (copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx))
+		if (copy_sigframe_from_user_to_xstate(&fpregs->xsave, buf_fx))
 			return false;
 	} else {
-		if (__copy_from_user(&fpu->state.fxsave, buf_fx,
-				     sizeof(fpu->state.fxsave)))
+		if (__copy_from_user(&fpregs->fxsave, buf_fx,
+				     sizeof(fpregs->fxsave)))
 			return false;
 
 		if (IS_ENABLED(CONFIG_X86_64)) {
 			/* Reject invalid MXCSR values. */
-			if (fpu->state.fxsave.mxcsr & ~mxcsr_feature_mask)
+			if (fpregs->fxsave.mxcsr & ~mxcsr_feature_mask)
 				return false;
 		} else {
 			/* Mask invalid bits out for historical reasons (broken hardware). */
-			fpu->state.fxsave.mxcsr &= mxcsr_feature_mask;
+			fpregs->fxsave.mxcsr &= mxcsr_feature_mask;
 		}
 
 		/* Enforce XFEATURE_MASK_FPSSE when XSAVE is enabled */
 		if (use_xsave())
-			fpu->state.xsave.header.xfeatures |= XFEATURE_MASK_FPSSE;
+			fpregs->xsave.header.xfeatures |= XFEATURE_MASK_FPSSE;
 	}
 
 	/* Fold the legacy FP storage */
-	convert_to_fxsr(&fpu->state.fxsave, &env);
+	convert_to_fxsr(&fpregs->fxsave, &env);
 
 	fpregs_lock();
 	if (use_xsave()) {
@@ -411,10 +413,10 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		 */
 		u64 mask = user_xfeatures | xfeatures_mask_supervisor();
 
-		fpu->state.xsave.header.xfeatures &= mask;
-		success = !os_xrstor_safe(&fpu->state.xsave, xfeatures_mask_all);
+		fpregs->xsave.header.xfeatures &= mask;
+		success = !os_xrstor_safe(&fpregs->xsave, xfeatures_mask_all);
 	} else {
-		success = !fxrstor_safe(&fpu->state.fxsave);
+		success = !fxrstor_safe(&fpregs->fxsave);
 	}
 
 	if (likely(success))
