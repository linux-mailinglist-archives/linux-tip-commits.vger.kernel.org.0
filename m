Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334443B235C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhFWWOC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhFWWMm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:12:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB094C0619FE;
        Wed, 23 Jun 2021 15:09:21 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486160;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+Sba5TFMDSsmizhXF4Zv50LpksvegwaRsHh5Stclwc=;
        b=3CnTeIbrFX/2KBzxpQ+fJYrKY+GnxjYzOyq0tX266mx0H6ZWZCinhns/lKTqFpG277a//A
        LPeLjpgQ1lm+CxIL/TTjpnF9LykK0tJdULM3cX64D2ci1s0Kvln+BXjFdlLct8IJ2IY6Ja
        wh6xt0yav2/dYbzC6UpPzA7i8n/bVtR/1/+TwcUu3GoR2JF7BKNbGJteO6IU/pd5lnuklx
        LoIQg90bi57fWUFvEoTxiBb2ZRoscwaiVgBu5FFFg2I9sc1mSUYe/JOAS4xI2k7SVlAtW0
        ptTLrHObh1XmMcviQLOPHMgnxOX82SQscIjH/xvtnwIiRlFWwqDFbRs9SeIXKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486160;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+Sba5TFMDSsmizhXF4Zv50LpksvegwaRsHh5Stclwc=;
        b=yE02VERMWfwIO0ELx60ltrKH7jN2RAoajJtAJ+5a/gV7P2DroWSI+FJbFibaCRsf/f2O/P
        gWCWYMfaPg6T8+BQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Rename copy_fpregs_to_fpstate() to
 save_fpregs_to_fpstate()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121454.508853062@linutronix.de>
References: <20210623121454.508853062@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448615869.395.17787639252217363543.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     ebe7234b08a42d69bae94c4062a84777ea26ef99
Gitweb:        https://git.kernel.org/tip/ebe7234b08a42d69bae94c4062a84777ea26ef99
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:59 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 18:26:43 +02:00

x86/fpu: Rename copy_fpregs_to_fpstate() to save_fpregs_to_fpstate()

A copy is guaranteed to leave the source intact, which is not the case when
FNSAVE is used as that reinitilizes the registers.

Save does not make such guarantees and it matches what this is about,
i.e. to save the state for a later restore.

Rename it to save_fpregs_to_fpstate().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121454.508853062@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h |  4 ++--
 arch/x86/kernel/fpu/core.c          | 10 +++++-----
 arch/x86/kvm/x86.c                  |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index cd88233..559dd30 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -375,7 +375,7 @@ static inline int os_xrstor_safe(struct xregs_state *xstate, u64 mask)
 	return err;
 }
 
-extern int copy_fpregs_to_fpstate(struct fpu *fpu);
+extern int save_fpregs_to_fpstate(struct fpu *fpu);
 
 static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask)
 {
@@ -507,7 +507,7 @@ static inline void __fpregs_load_activate(void)
 static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
 	if (static_cpu_has(X86_FEATURE_FPU) && !(current->flags & PF_KTHREAD)) {
-		if (!copy_fpregs_to_fpstate(old_fpu))
+		if (!save_fpregs_to_fpstate(old_fpu))
 			old_fpu->last_cpu = -1;
 		else
 			old_fpu->last_cpu = cpu;
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1d25876..dcf4d6b 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -92,7 +92,7 @@ EXPORT_SYMBOL(irq_fpu_usable);
  * Modern FPU state can be kept in registers, if there are
  * no pending FP exceptions.
  */
-int copy_fpregs_to_fpstate(struct fpu *fpu)
+int save_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
 		os_xsave(&fpu->state.xsave);
@@ -119,7 +119,7 @@ int copy_fpregs_to_fpstate(struct fpu *fpu)
 
 	return 0;
 }
-EXPORT_SYMBOL(copy_fpregs_to_fpstate);
+EXPORT_SYMBOL(save_fpregs_to_fpstate);
 
 void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 {
@@ -137,7 +137,7 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 		 * Ignore return value -- we don't care if reg state
 		 * is clobbered.
 		 */
-		copy_fpregs_to_fpstate(&current->thread.fpu);
+		save_fpregs_to_fpstate(&current->thread.fpu);
 	}
 	__cpu_invalidate_fpregs_state();
 
@@ -172,7 +172,7 @@ void fpu__save(struct fpu *fpu)
 	trace_x86_fpu_before_save(fpu);
 
 	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		if (!copy_fpregs_to_fpstate(fpu)) {
+		if (!save_fpregs_to_fpstate(fpu)) {
 			copy_kernel_to_fpregs(&fpu->state);
 		}
 	}
@@ -255,7 +255,7 @@ int fpu__copy(struct task_struct *dst, struct task_struct *src)
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
 		memcpy(&dst_fpu->state, &src_fpu->state, fpu_kernel_xstate_size);
 
-	else if (!copy_fpregs_to_fpstate(dst_fpu))
+	else if (!save_fpregs_to_fpstate(dst_fpu))
 		copy_kernel_to_fpregs(&dst_fpu->state);
 
 	fpregs_unlock();
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c25bf24..71bacb7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9637,7 +9637,7 @@ static void kvm_save_current_fpu(struct fpu *fpu)
 		memcpy(&fpu->state, &current->thread.fpu.state,
 		       fpu_kernel_xstate_size);
 	else
-		copy_fpregs_to_fpstate(fpu);
+		save_fpregs_to_fpstate(fpu);
 }
 
 /* Swap (qemu) user FPU context for the guest FPU context. */
