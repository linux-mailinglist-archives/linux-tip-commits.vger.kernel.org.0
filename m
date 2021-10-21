Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A743656B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhJUPPB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:15:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60854 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhJUPOy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:54 -0400
Date:   Thu, 21 Oct 2021 15:12:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829157;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whLh5JfzIHyTDmRND7mImM1+/Mx1n1YRH6GK0F1n238=;
        b=2Jy+tLi8LZ8pOXa8ALNAgXHX2kZ895Tg3bM+wBQgKEnv9KMEdBUSkW2piPMq5a4Hcg/dyr
        HRvn8bY+dPE2ADRwQtmX8iGBS4nJEU0iEDT1CMYuH5xjG70Yxb3tSxymgyRVQ3xhwICglX
        8ZwEeE6YVHtiSnSU2kd1X3Q8IyTWfHWmDcUa1R7FLPLhORQJJxtT2i53p6YVyYV0znijZh
        tRZV1WYfVKjF3hzMEjJv6BAyQ7Sz8kME1duiJE9Ox0jntbxjJ2idAZJmRWG+aXDI64h/RR
        9XoYBq6SBmgl1ciUQU9Q5mMU6Kxm8kzlkHgINsQYn7jayGj7+X65/hVL/Iwl2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829157;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whLh5JfzIHyTDmRND7mImM1+/Mx1n1YRH6GK0F1n238=;
        b=PxtfsihDxwmY0iQZ+wNzxnA5AwVYZy8eWLMXyp3M9CWIKGPqV0BvDp+GPE8odsC1NTfaHn
        e6HuDzFYJIk+uzBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Convert restore_fpregs_from_fpstate() to
 struct fpstate
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145322.347395546@linutronix.de>
References: <20211013145322.347395546@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482915615.25758.9060918340402854894.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     18b3fa1ad15fa8d777ac32f117553cce1a968460
Gitweb:        https://git.kernel.org/tip/18b3fa1ad15fa8d777ac32f117553cce1a968460
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:30 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 22:26:38 +02:00

x86/fpu: Convert restore_fpregs_from_fpstate() to struct fpstate

Convert restore_fpregs_from_fpstate() and related code to the new
register storage mechanism in preparation for dynamically sized buffers.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145322.347395546@linutronix.de
---
 arch/x86/include/asm/fpu/signal.h |  2 +-
 arch/x86/kernel/fpu/context.h     |  2 +-
 arch/x86/kernel/fpu/core.c        | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 9a63a21..22b0273 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -40,7 +40,7 @@ extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size
 extern void fpu__clear_user_states(struct fpu *fpu);
 extern bool fpu__restore_sig(void __user *buf, int ia32_frame);
 
-extern void restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask);
+extern void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask);
 
 extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
 
diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
index e652282..f8f5105 100644
--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/kernel/fpu/context.h
@@ -74,7 +74,7 @@ static inline void fpregs_restore_userregs(void)
 		 */
 		mask = xfeatures_mask_restore_user() |
 			xfeatures_mask_supervisor();
-		restore_fpregs_from_fpstate(&fpu->state, mask);
+		restore_fpregs_from_fpstate(fpu->fpstate, mask);
 
 		fpregs_activate(fpu);
 		fpu->last_cpu = cpu;
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 19e14b5..03926bf 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -129,7 +129,7 @@ void save_fpregs_to_fpstate(struct fpu *fpu)
 	frstor(&fpu->state.fsave);
 }
 
-void restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
+void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask)
 {
 	/*
 	 * AMD K7/K8 and later CPUs up to Zen don't save/restore
@@ -146,18 +146,18 @@ void restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
 	}
 
 	if (use_xsave()) {
-		os_xrstor(&fpstate->xsave, mask);
+		os_xrstor(&fpstate->regs.xsave, mask);
 	} else {
 		if (use_fxsr())
-			fxrstor(&fpstate->fxsave);
+			fxrstor(&fpstate->regs.fxsave);
 		else
-			frstor(&fpstate->fsave);
+			frstor(&fpstate->regs.fsave);
 	}
 }
 
 void fpu_reset_from_exception_fixup(void)
 {
-	restore_fpregs_from_fpstate(&init_fpstate.regs, xfeatures_mask_fpstate());
+	restore_fpregs_from_fpstate(&init_fpstate, xfeatures_mask_fpstate());
 }
 
 #if IS_ENABLED(CONFIG_KVM)
@@ -176,7 +176,7 @@ void fpu_swap_kvm_fpu(struct fpu *save, struct fpu *rstor, u64 restore_mask)
 
 	if (rstor) {
 		restore_mask &= xfeatures_mask_fpstate();
-		restore_fpregs_from_fpstate(&rstor->state, restore_mask);
+		restore_fpregs_from_fpstate(rstor->fpstate, restore_mask);
 	}
 
 	fpregs_mark_activate();
