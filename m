Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F861D61BF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 16 May 2020 17:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgEPPKn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 16 May 2020 11:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgEPPKc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 16 May 2020 11:10:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328F1C061A0C;
        Sat, 16 May 2020 08:10:32 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jZySA-0000rN-AG; Sat, 16 May 2020 17:10:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6C2A21C0440;
        Sat, 16 May 2020 17:10:16 +0200 (CEST)
Date:   Sat, 16 May 2020 15:10:16 -0000
From:   "tip-bot2 for Yu-cheng Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Preserve supervisor states for the
 slow path in __fpu__restore_sig()
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512145444.15483-10-yu-cheng.yu@intel.com>
References: <20200512145444.15483-10-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Message-ID: <158964181633.17951.13893473131310795449.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     98265c17efa9f2279c59262cd27679aca12e0bb8
Gitweb:        https://git.kernel.org/tip/98265c17efa9f2279c59262cd27679aca12e0bb8
Author:        Yu-cheng Yu <yu-cheng.yu@intel.com>
AuthorDate:    Tue, 12 May 2020 07:54:43 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 16 May 2020 12:09:11 +02:00

x86/fpu/xstate: Preserve supervisor states for the slow path in __fpu__restore_sig()

The signal return code is responsible for taking an XSAVE buffer
present in user memory and loading it into the hardware registers. This
operation only affects user XSAVE state and never affects supervisor
state.

The fast path through this code simply points XRSTOR directly at the
user buffer. However, since user memory is not guaranteed to be always
mapped, this XRSTOR can fail. If it fails, the signal return code falls
back to a slow path which can tolerate page faults.

That slow path copies the xfeatures one by one out of the user buffer
into the task's fpu state area. However, by being in a context where it
can handle page faults, the code can also schedule.

The lazy-fpu-load code would think it has an up-to-date fpstate and
would fail to save the supervisor state when scheduling the task out.
When scheduling back in, it would likely restore stale supervisor state.

To fix that, preserve supervisor state before the slow path.  Modify
copy_user_to_fpregs_zeroing() so that if it fails, fpregs are not zeroed,
and there is no need for fpregs_deactivate() and supervisor states are
preserved.

Move set_thread_flag(TIF_NEED_FPU_LOAD) to the slow path.  Without doing
this, the fast path also needs supervisor states to be saved first.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200512145444.15483-10-yu-cheng.yu@intel.com
---
 arch/x86/kernel/fpu/signal.c | 53 ++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 77e5c2e..6184fe7 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -262,19 +262,23 @@ sanitize_restored_user_xstate(union fpregs_state *state,
 static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
 {
 	u64 init_bv;
+	int r;
 
 	if (use_xsave()) {
 		if (fx_only) {
 			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
 
-			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-			return copy_user_to_fxregs(buf);
+			r = copy_user_to_fxregs(buf);
+			if (!r)
+				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+			return r;
 		} else {
 			init_bv = xfeatures_mask_user() & ~xbv;
 
-			if (unlikely(init_bv))
+			r = copy_user_to_xregs(buf, xbv);
+			if (!r && unlikely(init_bv))
 				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-			return copy_user_to_xregs(buf, xbv);
+			return r;
 		}
 	} else if (use_fxsr()) {
 		return copy_user_to_fxregs(buf);
@@ -327,28 +331,10 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		}
 	}
 
-	/*
-	 * The current state of the FPU registers does not matter. By setting
-	 * TIF_NEED_FPU_LOAD unconditionally it is ensured that the our xstate
-	 * is not modified on context switch and that the xstate is considered
-	 * to be loaded again on return to userland (overriding last_cpu avoids
-	 * the optimisation).
-	 */
-	set_thread_flag(TIF_NEED_FPU_LOAD);
-	__fpu_invalidate_fpregs_state(fpu);
-
 	if ((unsigned long)buf_fx % 64)
 		fx_only = 1;
-	/*
-	 * For 32-bit frames with fxstate, copy the fxstate so it can be
-	 * reconstructed later.
-	 */
-	if (ia32_fxstate) {
-		ret = __copy_from_user(&env, buf, sizeof(env));
-		if (ret)
-			goto err_out;
-		envp = &env;
-	} else {
+
+	if (!ia32_fxstate) {
 		/*
 		 * Attempt to restore the FPU registers directly from user
 		 * memory. For that to succeed, the user access cannot cause
@@ -365,10 +351,27 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			fpregs_unlock();
 			return 0;
 		}
-		fpregs_deactivate(fpu);
 		fpregs_unlock();
+	} else {
+		/*
+		 * For 32-bit frames with fxstate, copy the fxstate so it can
+		 * be reconstructed later.
+		 */
+		ret = __copy_from_user(&env, buf, sizeof(env));
+		if (ret)
+			goto err_out;
+		envp = &env;
 	}
 
+	/*
+	 * The current state of the FPU registers does not matter. By setting
+	 * TIF_NEED_FPU_LOAD unconditionally it is ensured that the our xstate
+	 * is not modified on context switch and that the xstate is considered
+	 * to be loaded again on return to userland (overriding last_cpu avoids
+	 * the optimisation).
+	 */
+	set_thread_flag(TIF_NEED_FPU_LOAD);
+	__fpu_invalidate_fpregs_state(fpu);
 
 	if (use_xsave() && !fx_only) {
 		u64 init_bv = xfeatures_mask_user() & ~user_xfeatures;
