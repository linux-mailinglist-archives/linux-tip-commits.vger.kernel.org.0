Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0278F3B2327
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhFWWM2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40134 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhFWWLo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:44 -0400
Date:   Wed, 23 Jun 2021 22:09:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9FBCXAiLAWFQ4HNx7qGXSTjsOLvLRxDhOi9epIzfRQ=;
        b=drQ2dSM+0VQ5fWR9NPCjHl0Ib/MK0LyWGafEDaA1nJpydvjs7IX6/k4cI/GSRknRc81w8U
        +0zfg29OrJDOjyH8K4sBso0np/MewYabQ0wP3Q89xGqHalnVkVnXJ/pe03ZPlcNzNBeEcE
        PlAZXMKGtI5oZmSea6Vu9/U8ix0b0j/QnRO0isQ2ys3R0yIECzu5eaUawRfHIwhxnN0TrX
        xGBrfrARB0IC5TwWHw62XofQnBkiNK30oYGOd93q9WH/0rdjYbat8v4HKmiQi5P1+eMvSx
        uKfos3rHlqM1a7tBuUGV+kaeTCKrgaK3MpnezOFDOJ6iGUHbYAMa+JfpCWTayQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9FBCXAiLAWFQ4HNx7qGXSTjsOLvLRxDhOi9epIzfRQ=;
        b=nb2Pd+pv4dnMSpvWOD6ZI9lH4RAmIr6se0AtQHfBrF8eiD4z7eN1EPK/CPL4Z8Asln9QI9
        Il6S6S7UskDEUPAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Rename fxregs-related copy functions
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121454.017863494@linutronix.de>
References: <20210623121454.017863494@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448616369.395.8971546057725194872.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     16dcf4385933a02bb21d0af86a04439d151ad42a
Gitweb:        https://git.kernel.org/tip/16dcf4385933a02bb21d0af86a04439d151ad42a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:54 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 18:12:30 +02:00

x86/fpu: Rename fxregs-related copy functions

The function names for fxsave/fxrstor operations are horribly named and
a permanent source of confusion.

Rename:
	copy_fxregs_to_kernel() to fxsave()
	copy_kernel_to_fxregs() to fxrstor()
	copy_fxregs_to_user() to fxsave_to_user_sigframe()
	copy_user_to_fxregs() to fxrstor_from_user_sigframe()

so it's clear what these are doing. All these functions are really low
level wrappers around the equally named instructions, so mapping to the
documentation is just natural.

While at it, replace the static_cpu_has(X86_FEATURE_FXSR) with
use_fxsr() to be consistent with the rest of the code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121454.017863494@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 18 +++++-------------
 arch/x86/kernel/fpu/core.c          |  6 +++---
 arch/x86/kernel/fpu/signal.c        | 10 +++++-----
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index a2ab744..7806f39 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -129,7 +129,7 @@ static inline int copy_fregs_to_user(struct fregs_state __user *fx)
 	return user_insn(fnsave %[fx]; fwait,  [fx] "=m" (*fx), "m" (*fx));
 }
 
-static inline int copy_fxregs_to_user(struct fxregs_state __user *fx)
+static inline int fxsave_to_user_sigframe(struct fxregs_state __user *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		return user_insn(fxsave %[fx], [fx] "=m" (*fx), "m" (*fx));
@@ -138,7 +138,7 @@ static inline int copy_fxregs_to_user(struct fxregs_state __user *fx)
 
 }
 
-static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
+static inline void fxrstor(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		kernel_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
@@ -146,7 +146,7 @@ static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
 		kernel_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_kernel_to_fxregs_err(struct fxregs_state *fx)
+static inline int fxrstor_safe(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		return kernel_insn_err(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
@@ -154,7 +154,7 @@ static inline int copy_kernel_to_fxregs_err(struct fxregs_state *fx)
 		return kernel_insn_err(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_user_to_fxregs(struct fxregs_state __user *fx)
+static inline int fxrstor_from_user_sigframe(struct fxregs_state __user *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		return user_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
@@ -177,14 +177,6 @@ static inline int copy_user_to_fregs(struct fregs_state __user *fx)
 	return user_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline void copy_fxregs_to_kernel(struct fpu *fpu)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		asm volatile( "fxsave %[fx]" : [fx] "=m" (fpu->state.fxsave));
-	else
-		asm volatile("fxsaveq %[fx]" : [fx] "=m" (fpu->state.fxsave));
-}
-
 static inline void fxsave(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
@@ -391,7 +383,7 @@ static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask
 		os_xrstor(&fpstate->xsave, mask);
 	} else {
 		if (use_fxsr())
-			copy_kernel_to_fxregs(&fpstate->fxsave);
+			fxrstor(&fpstate->fxsave);
 		else
 			copy_kernel_to_fregs(&fpstate->fsave);
 	}
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index bfdcf7f..035487d 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -107,7 +107,7 @@ int copy_fpregs_to_fpstate(struct fpu *fpu)
 	}
 
 	if (likely(use_fxsr())) {
-		copy_fxregs_to_kernel(fpu);
+		fxsave(&fpu->state.fxsave);
 		return 1;
 	}
 
@@ -315,8 +315,8 @@ static inline void copy_init_fpstate_to_fpregs(u64 features_mask)
 {
 	if (use_xsave())
 		os_xrstor(&init_fpstate.xsave, features_mask);
-	else if (static_cpu_has(X86_FEATURE_FXSR))
-		copy_kernel_to_fxregs(&init_fpstate.fxsave);
+	else if (use_fxsr())
+		fxrstor(&init_fpstate.fxsave);
 	else
 		copy_kernel_to_fregs(&init_fpstate.fsave);
 
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 4fe632f..05f8445 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -64,7 +64,7 @@ static inline int save_fsave_header(struct task_struct *tsk, void __user *buf)
 
 		fpregs_lock();
 		if (!test_thread_flag(TIF_NEED_FPU_LOAD))
-			copy_fxregs_to_kernel(&tsk->thread.fpu);
+			fxsave(&tsk->thread.fpu.state.fxsave);
 		fpregs_unlock();
 
 		convert_from_fxsr(&env, tsk);
@@ -131,7 +131,7 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
 	if (use_xsave())
 		err = xsave_to_user_sigframe(buf);
 	else if (use_fxsr())
-		err = copy_fxregs_to_user((struct fxregs_state __user *) buf);
+		err = fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
 	else
 		err = copy_fregs_to_user((struct fregs_state __user *) buf);
 
@@ -259,7 +259,7 @@ static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
 		if (fx_only) {
 			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
 
-			r = copy_user_to_fxregs(buf);
+			r = fxrstor_from_user_sigframe(buf);
 			if (!r)
 				os_xrstor(&init_fpstate.xsave, init_bv);
 			return r;
@@ -272,7 +272,7 @@ static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
 			return r;
 		}
 	} else if (use_fxsr()) {
-		return copy_user_to_fxregs(buf);
+		return fxrstor_from_user_sigframe(buf);
 	} else
 		return copy_user_to_fregs(buf);
 }
@@ -458,7 +458,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			os_xrstor(&init_fpstate.xsave, init_bv);
 		}
 
-		ret = copy_kernel_to_fxregs_err(&fpu->state.fxsave);
+		ret = fxrstor_safe(&fpu->state.fxsave);
 	} else {
 		ret = __copy_from_user(&fpu->state.fsave, buf_fx, state_size);
 		if (ret)
