Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E5C3B2329
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhFWWMa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40148 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhFWWLr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:47 -0400
Date:   Wed, 23 Jun 2021 22:09:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486167;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxuEuzBB1TktAqleIbxIvfhAmgYUTgLVGUEpVnXrYG8=;
        b=TWo00dCvhf0IoCpuJjiqz0RzgnKTx3tMqVrSgY0hkIehibPgGxtdUsod8CRA3mRe4m4Aye
        gblGiamd/GOVi/IrnD9JnCCm85y1nnVpt5EfckIGyeR1rZqinlirflMyUJn/PQMyFm34VC
        MBegmWITJz7lICqMCJpYeYWY41rQ67kUMyqMU61bTeHSQ3x5TN7nIEfKW3toceuS7WMW2u
        6STYOgNo1wGCgKWa7GGUTdfiopq5RPJU47UMHTiGgnDI85Lgif6L5ZzWkRUref/8lrEvW/
        zy8w9wo5oeNeYRhl7oWxrOkr8fK2ATgh+dTdr1D2KW3MT9348pNheAtGk76tRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486167;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxuEuzBB1TktAqleIbxIvfhAmgYUTgLVGUEpVnXrYG8=;
        b=oxpR+2HTZo+uLuG+Yo8mae2O9Iy/+PfoWOCIdnudWBSfmgRORU1gj1cS4VnO3A67fpExar
        I/Owpz4Y/mto6MDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Get rid of copy_supervisor_to_kernel()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121453.734561971@linutronix.de>
References: <20210623121453.734561971@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448616653.395.16352179070822739733.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     1f3171252dc586745bb548d48f3bcedfea34b58d
Gitweb:        https://git.kernel.org/tip/1f3171252dc586745bb548d48f3bcedfea34b58d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:51 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:53:31 +02:00

x86/fpu: Get rid of copy_supervisor_to_kernel()

If the fast path of restoring the FPU state on sigreturn fails or is not
taken and the current task's FPU is active then the FPU has to be
deactivated for the slow path to allow a safe update of the tasks FPU
memory state.

With supervisor states enabled, this requires to save the supervisor state
in the memory state first. Supervisor states require XSAVES so saving only
the supervisor state requires to reshuffle the memory buffer because XSAVES
uses the compacted format and therefore stores the supervisor states at the
beginning of the memory state. That's just an overengineered optimization.

Get rid of it and save the full state for this case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121453.734561971@linutronix.de
---
 arch/x86/include/asm/fpu/xstate.h |  1 +-
 arch/x86/kernel/fpu/signal.c      | 13 ++++---
 arch/x86/kernel/fpu/xstate.c      | 55 +------------------------------
 3 files changed, 8 insertions(+), 61 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 6e5ba42..6611e06 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -104,7 +104,6 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 int xfeature_size(int xfeature_nr);
 int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
-void copy_supervisor_to_kernel(struct xregs_state *xsave);
 void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
 void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
 
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 888c8e0..5010595 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -401,15 +401,18 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	 * the optimisation).
 	 */
 	fpregs_lock();
-
 	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
-
 		/*
-		 * Supervisor states are not modified by user space input.  Save
-		 * current supervisor states first and invalidate the FPU regs.
+		 * If supervisor states are available then save the
+		 * hardware state in current's fpstate so that the
+		 * supervisor state is preserved. Save the full state for
+		 * simplicity. There is no point in optimizing this by only
+		 * saving the supervisor states and then shuffle them to
+		 * the right place in memory. This is the slow path and the
+		 * above XRSTOR failed or ia32_fxstate is true. Shrug.
 		 */
 		if (xfeatures_mask_supervisor())
-			copy_supervisor_to_kernel(&fpu->state.xsave);
+			copy_xregs_to_kernel(&fpu->state.xsave);
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 	}
 	__fpu_invalidate_fpregs_state(fpu);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 579e343..427977b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1204,61 +1204,6 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 	return 0;
 }
 
-/*
- * Save only supervisor states to the kernel buffer.  This blows away all
- * old states, and is intended to be used only in __fpu__restore_sig(), where
- * user states are restored from the user buffer.
- */
-void copy_supervisor_to_kernel(struct xregs_state *xstate)
-{
-	struct xstate_header *header;
-	u64 max_bit, min_bit;
-	u32 lmask, hmask;
-	int err, i;
-
-	if (WARN_ON(!boot_cpu_has(X86_FEATURE_XSAVES)))
-		return;
-
-	if (!xfeatures_mask_supervisor())
-		return;
-
-	max_bit = __fls(xfeatures_mask_supervisor());
-	min_bit = __ffs(xfeatures_mask_supervisor());
-
-	lmask = xfeatures_mask_supervisor();
-	hmask = xfeatures_mask_supervisor() >> 32;
-	XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
-
-	/* We should never fault when copying to a kernel buffer: */
-	if (WARN_ON_FPU(err))
-		return;
-
-	/*
-	 * At this point, the buffer has only supervisor states and must be
-	 * converted back to normal kernel format.
-	 */
-	header = &xstate->header;
-	header->xcomp_bv |= xfeatures_mask_all;
-
-	/*
-	 * This only moves states up in the buffer.  Start with
-	 * the last state and move backwards so that states are
-	 * not overwritten until after they are moved.  Note:
-	 * memmove() allows overlapping src/dst buffers.
-	 */
-	for (i = max_bit; i >= min_bit; i--) {
-		u8 *xbuf = (u8 *)xstate;
-
-		if (!((header->xfeatures >> i) & 1))
-			continue;
-
-		/* Move xfeature 'i' into its normal location */
-		memmove(xbuf + xstate_comp_offsets[i],
-			xbuf + xstate_supervisor_only_offsets[i],
-			xstate_sizes[i]);
-	}
-}
-
 /**
  * copy_dynamic_supervisor_to_kernel() - Save dynamic supervisor states to
  *                                       an xsave area
