Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B499443655B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhJUPOp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:14:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60788 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhJUPOp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:45 -0400
Date:   Thu, 21 Oct 2021 15:12:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6E7hAIkQyI/+UZmFAUQVcjF8QjMWBSsMiErcrjBkSEc=;
        b=mcN5cUmpqcgWLkjYMp4/pTYI1n1LCo6GXXFqi4YX9fp+omnXf2o9CuUUGyx4lTsDBbrjUU
        lCcU+/xRwkF+G3O12L+G0t0uikm5sh9umh/zvnr/NHG4a33ZKmuY06IgyK1LNQKh23C6od
        zpiLFwdIcOZMf7h4WyxUXQWaGw9OY4kSM7R7rVdABep6ObnftH9sTpsihBWLnupw+q6pr0
        2QxyMCiALD//QTCZ5h0VcJhFr8jwxVPt3N8JTngYHDcwFF4AvAT8lYQ+frbHUrJYhDvS2L
        YP82Kisyhm4OyU4PrxtWVhTP39plVl/wmbz3PxQRwbbq5ElSHxSEVkVLNElY9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6E7hAIkQyI/+UZmFAUQVcjF8QjMWBSsMiErcrjBkSEc=;
        b=JD+F47lKzoQ1utyemxeAdkQgyjSY2Nj/68101TygUdRtCcGhfIzIBfVSsRezNL9mNNFF1T
        3vo8lqYjlDeVNeAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Use fpstate for os_xsave()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145323.025695590@linutronix.de>
References: <20211013145323.025695590@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482914724.25758.8980640166539220402.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     073e627a4537e682c43a1e8df659ce24cbced40c
Gitweb:        https://git.kernel.org/tip/073e627a4537e682c43a1e8df659ce24cbced40c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:49 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 14:03:36 +02:00

x86/fpu/xstate: Use fpstate for os_xsave()

With variable feature sets XSAVE[S] requires to know the feature set for
which the buffer is valid. Retrieve it from fpstate.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145323.025695590@linutronix.de
---
 arch/x86/kernel/fpu/core.c   | 2 +-
 arch/x86/kernel/fpu/signal.c | 4 ++--
 arch/x86/kernel/fpu/xstate.h | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index cb48c80..f4db70b 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -105,7 +105,7 @@ EXPORT_SYMBOL(irq_fpu_usable);
 void save_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
-		os_xsave(&fpu->fpstate->regs.xsave);
+		os_xsave(fpu->fpstate);
 
 		/*
 		 * AVX512 state is tracked here because its use is
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index aa93291..5aca418 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -349,7 +349,6 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 	if (__copy_from_user(&env, buf, sizeof(env)))
 		return false;
 
-	fpregs = &fpu->fpstate->regs;
 	/*
 	 * By setting TIF_NEED_FPU_LOAD it is ensured that our xstate is
 	 * not modified on context switch and that the xstate is considered
@@ -367,13 +366,14 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		 * the right place in memory. It's ia32 mode. Shrug.
 		 */
 		if (xfeatures_mask_supervisor())
-			os_xsave(&fpregs->xsave);
+			os_xsave(fpu->fpstate);
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 	}
 	__fpu_invalidate_fpregs_state(fpu);
 	__cpu_invalidate_fpregs_state();
 	fpregs_unlock();
 
+	fpregs = &fpu->fpstate->regs;
 	if (use_xsave() && !fx_only) {
 		if (copy_sigframe_from_user_to_xstate(&fpregs->xsave, buf_fx))
 			return false;
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 99f8cfe..24a1479 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -101,16 +101,16 @@ extern void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
  * Uses either XSAVE or XSAVEOPT or XSAVES depending on the CPU features
  * and command line options. The choice is permanent until the next reboot.
  */
-static inline void os_xsave(struct xregs_state *xstate)
+static inline void os_xsave(struct fpstate *fpstate)
 {
-	u64 mask = xfeatures_mask_all;
+	u64 mask = fpstate->xfeatures;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
 
 	WARN_ON_FPU(!alternatives_patched);
 
-	XSTATE_XSAVE(xstate, lmask, hmask, err);
+	XSTATE_XSAVE(&fpstate->regs.xsave, lmask, hmask, err);
 
 	/* We should never fault when copying to a kernel buffer: */
 	WARN_ON_FPU(err);
