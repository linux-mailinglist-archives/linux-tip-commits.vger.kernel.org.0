Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E26F3B22EF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhFWWLM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39916 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhFWWLL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:11 -0400
Date:   Wed, 23 Jun 2021 22:08:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486132;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWYstiCzyW44t0YR+lwnhSrqkqXfqzzImsMGm1Jj5h4=;
        b=LVbR4nnLRbxXEQthNsF2DbUnsey5qU/MfbngmzysjMjCjNyK6a4SyUzuOrJ2xEo84lCLlF
        +A6V3OhhyPwj2KKYJfudbeg39YJdUuZnr+j9U/E9auMgb/k1mCnb4hm3sGM0ZC/+T18xPA
        C81inHrZ2awx1PXe9o2DIau5zLDa/ByRw4RNiW12zS1JvSgx9nxlf/+U5TUDwm3BcBLUXq
        5lp3bgiITKZKTZzcQJusJFMPJ60IuMqiQVHdyEcQAgGF41O2Gf6T5VgdufYorvm3vynHnO
        J5QJncLHG/Sd/onyVlM+RYJpxASs/UsLQGXi3MS3kY1/tBeSI2/JQaiAu85OBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486132;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWYstiCzyW44t0YR+lwnhSrqkqXfqzzImsMGm1Jj5h4=;
        b=zIsOmCCndMXiPi0+82YKfX1LE54ome5EFFbpnCKNtpR0Dg/TVqdgmEK8d0uVxt8H3g6AZH
        0pm3KOR/J9l0FmCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Split out the direct restore code
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121457.493455414@linutronix.de>
References: <20210623121457.493455414@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448613105.395.13274798746048155095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     0a6c2e9ec91c96bde1e8ce063180ac6e05e680f7
Gitweb:        https://git.kernel.org/tip/0a6c2e9ec91c96bde1e8ce063180ac6e05e680f7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:29 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 20:03:44 +02:00

x86/fpu/signal: Split out the direct restore code

Prepare for smarter failure handling of the direct restore.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121457.493455414@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 112 +++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 54 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index a1a7013..aa268d9 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -250,10 +250,8 @@ sanitize_restored_user_xstate(union fpregs_state *state,
 	}
 }
 
-/*
- * Restore the FPU state directly from the userspace signal frame.
- */
-static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
+static int __restore_fpregs_from_user(void __user *buf, u64 xrestore,
+				      bool fx_only)
 {
 	if (use_xsave()) {
 		u64 init_bv = xfeatures_mask_uabi() & ~xrestore;
@@ -274,6 +272,57 @@ static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only
 	}
 }
 
+static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
+{
+	struct fpu *fpu = &current->thread.fpu;
+	int ret;
+
+	fpregs_lock();
+	pagefault_disable();
+	ret = __restore_fpregs_from_user(buf, xrestore, fx_only);
+	pagefault_enable();
+
+	if (unlikely(ret)) {
+		/*
+		 * The above did an FPU restore operation, restricted to
+		 * the user portion of the registers, and failed, but the
+		 * microcode might have modified the FPU registers
+		 * nevertheless.
+		 *
+		 * If the FPU registers do not belong to current, then
+		 * invalidate the FPU register state otherwise the task
+		 * might preempt current and return to user space with
+		 * corrupted FPU registers.
+		 *
+		 * In case current owns the FPU registers then no further
+		 * action is required. The fixup in the slow path will
+		 * handle it correctly.
+		 */
+		if (test_thread_flag(TIF_NEED_FPU_LOAD))
+			__cpu_invalidate_fpregs_state();
+		fpregs_unlock();
+		return ret;
+	}
+
+	/*
+	 * Restore supervisor states: previous context switch etc has done
+	 * XSAVES and saved the supervisor states in the kernel buffer from
+	 * which they can be restored now.
+	 *
+	 * It would be optimal to handle this with a single XRSTORS, but
+	 * this does not work because the rest of the FPU registers have
+	 * been restored from a user buffer directly. The single XRSTORS
+	 * happens below, when the user buffer has been copied to the
+	 * kernel one.
+	 */
+	if (test_thread_flag(TIF_NEED_FPU_LOAD) && xfeatures_mask_supervisor())
+		os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
+
+	fpregs_mark_activate();
+	fpregs_unlock();
+	return 0;
+}
+
 static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 			     bool ia32_fxstate)
 {
@@ -298,61 +347,16 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		user_xfeatures = fx_sw_user.xfeatures;
 	}
 
-	if (!ia32_fxstate) {
+	if (likely(!ia32_fxstate)) {
 		/*
 		 * Attempt to restore the FPU registers directly from user
-		 * memory. For that to succeed, the user access cannot cause
-		 * page faults. If it does, fall back to the slow path below,
-		 * going through the kernel buffer with the enabled pagefault
-		 * handler.
+		 * memory. For that to succeed, the user access cannot cause page
+		 * faults. If it does, fall back to the slow path below, going
+		 * through the kernel buffer with the enabled pagefault handler.
 		 */
-		fpregs_lock();
-		pagefault_disable();
 		ret = restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only);
-		pagefault_enable();
-		if (!ret) {
-
-			/*
-			 * Restore supervisor states: previous context switch
-			 * etc has done XSAVES and saved the supervisor states
-			 * in the kernel buffer from which they can be restored
-			 * now.
-			 *
-			 * We cannot do a single XRSTORS here - which would
-			 * be nice - because the rest of the FPU registers are
-			 * being restored from a user buffer directly. The
-			 * single XRSTORS happens below, when the user buffer
-			 * has been copied to the kernel one.
-			 */
-			if (test_thread_flag(TIF_NEED_FPU_LOAD) &&
-			    xfeatures_mask_supervisor()) {
-				os_xrstor(&fpu->state.xsave,
-					  xfeatures_mask_supervisor());
-			}
-			fpregs_mark_activate();
-			fpregs_unlock();
+		if (likely(!ret))
 			return 0;
-		}
-
-		/*
-		 * The above did an FPU restore operation, restricted to
-		 * the user portion of the registers, and failed, but the
-		 * microcode might have modified the FPU registers
-		 * nevertheless.
-		 *
-		 * If the FPU registers do not belong to current, then
-		 * invalidate the FPU register state otherwise the task might
-		 * preempt current and return to user space with corrupted
-		 * FPU registers.
-		 *
-		 * In case current owns the FPU registers then no further
-		 * action is required. The fixup below will handle it
-		 * correctly.
-		 */
-		if (test_thread_flag(TIF_NEED_FPU_LOAD))
-			__cpu_invalidate_fpregs_state();
-
-		fpregs_unlock();
 	} else {
 		/*
 		 * For 32-bit frames with fxstate, copy the fxstate so it can
