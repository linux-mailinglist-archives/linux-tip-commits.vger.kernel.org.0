Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1CF3B230B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFWWLy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhFWWL2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BF5C0617A8;
        Wed, 23 Jun 2021 15:09:02 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:08:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486141;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eNR5IlmSezAxkFwMEjb3Q/d5hIRbTEizirlCh7sKx0k=;
        b=U3aA2lIxuwyDazMAFYLJ5MVrQpvvIOHRU2+0xB+NeLPhyxseafTclRq5587Xe6sHnM6Bgt
        /ZYo4hTVGMyRc6eA7BLQ1OmH+9iBi56h24e06IP6My9X5PMtkTZs3UGKyxzS4QfQDXz+VR
        3zKtHBXsMW3CbyCfJdnw0zhE01LAIOvG01poGffo3Yek6NVpJpud/j3pFjkYQdQrDe+Vro
        Hc2hXfPztmWwSkMwy0k0DMNPqHWC8heYzKNvSLL1ZkhN+XClJSJXWmGDTtrgSZ+sNjsG8F
        9u27a9hLVf4GyjxaDGZnvzpwpNOefZC/9bJLDEowo1U7y19oZ1BUjUFfLcoWgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486141;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eNR5IlmSezAxkFwMEjb3Q/d5hIRbTEizirlCh7sKx0k=;
        b=ztV0f/DCgNOS0NgAqIPTsBPtWoZbpzqQ36k03J0Nw2IO6Gkh1keH8ibbZH+Ai5xkn+gQcl
        rpt/WgyzkKV3iFBQ==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Hook up PKRU into ptrace()
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121456.508770763@linutronix.de>
References: <20210623121456.508770763@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448613998.395.125080521935989980.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     e84ba47e313dbc097bf859bb6e4f9219883d5f78
Gitweb:        https://git.kernel.org/tip/e84ba47e313dbc097bf859bb6e4f9219883d5f78
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Wed, 23 Jun 2021 14:02:19 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:44:24 +02:00

x86/fpu: Hook up PKRU into ptrace()

One nice thing about having PKRU be XSAVE-managed is that it gets naturally
exposed into the XSAVE-using ABIs.  Now that XSAVE will not be used to
manage PKRU, these ABIs need to be manually enabled to deal with PKRU.

ptrace() uses copy_uabi_xstate_to_kernel() to collect the tracee's
XSTATE. As PKRU is not in the task's XSTATE buffer, use task->thread.pkru
for filling in up the ptrace buffer.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121456.508770763@linutronix.de
---
 arch/x86/include/asm/fpu/xstate.h |  2 +-
 arch/x86/kernel/fpu/regset.c      | 10 ++++------
 arch/x86/kernel/fpu/xstate.c      | 25 ++++++++++++++++++-------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 6a0aaaf..4ff4a00 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -139,7 +139,7 @@ enum xstate_copy_mode {
 };
 
 struct membuf;
-void copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
+void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 			     enum xstate_copy_mode mode);
 
 #endif
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 4575796..66ed317 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -78,7 +78,7 @@ int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
 				    sizeof(fpu->state.fxsave));
 	}
 
-	copy_xstate_to_uabi_buf(to, &fpu->state.xsave, XSTATE_COPY_FX);
+	copy_xstate_to_uabi_buf(to, target, XSTATE_COPY_FX);
 	return 0;
 }
 
@@ -126,14 +126,12 @@ int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
 int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf to)
 {
-	struct fpu *fpu = &target->thread.fpu;
-
 	if (!cpu_feature_enabled(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
-	sync_fpstate(fpu);
+	sync_fpstate(&target->thread.fpu);
 
-	copy_xstate_to_uabi_buf(to, &fpu->state.xsave, XSTATE_COPY_XSAVE);
+	copy_xstate_to_uabi_buf(to, target, XSTATE_COPY_XSAVE);
 	return 0;
 }
 
@@ -336,7 +334,7 @@ int fpregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf mb = { .p = &fxsave, .left = sizeof(fxsave) };
 
 		/* Handle init state optimized xstate correctly */
-		copy_xstate_to_uabi_buf(mb, &fpu->state.xsave, XSTATE_COPY_FP);
+		copy_xstate_to_uabi_buf(mb, target, XSTATE_COPY_FP);
 		fx = &fxsave;
 	} else {
 		fx = &fpu->state.fxsave;
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c513596..9fd124a 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -962,7 +962,7 @@ static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
 /**
  * copy_xstate_to_uabi_buf - Copy kernel saved xstate to a UABI buffer
  * @to:		membuf descriptor
- * @xsave:	The kernel xstate buffer to copy from
+ * @tsk:	The task from which to copy the saved xstate
  * @copy_mode:	The requested copy mode
  *
  * Converts from kernel XSAVE or XSAVES compacted format to UABI conforming
@@ -971,10 +971,11 @@ static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
  *
  * It supports partial copy but @to.pos always starts from zero.
  */
-void copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
+void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 			     enum xstate_copy_mode copy_mode)
 {
 	const unsigned int off_mxcsr = offsetof(struct fxregs_state, mxcsr);
+	struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
 	struct xregs_state *xinit = &init_fpstate.xsave;
 	struct xstate_header header;
 	unsigned int zerofrom;
@@ -1048,11 +1049,21 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
 		if (zerofrom < xstate_offsets[i])
 			membuf_zero(&to, xstate_offsets[i] - zerofrom);
 
-		copy_feature(header.xfeatures & BIT_ULL(i), &to,
-			     __raw_xsave_addr(xsave, i),
-			     __raw_xsave_addr(xinit, i),
-			     xstate_sizes[i]);
-
+		if (i == XFEATURE_PKRU) {
+			struct pkru_state pkru = {0};
+			/*
+			 * PKRU is not necessarily up to date in the
+			 * thread's XSAVE buffer.  Fill this part from the
+			 * per-thread storage.
+			 */
+			pkru.pkru = tsk->thread.pkru;
+			membuf_write(&to, &pkru, sizeof(pkru));
+		} else {
+			copy_feature(header.xfeatures & BIT_ULL(i), &to,
+				     __raw_xsave_addr(xsave, i),
+				     __raw_xsave_addr(xinit, i),
+				     xstate_sizes[i]);
+		}
 		/*
 		 * Keep track of the last copied state in the non-compacted
 		 * target buffer for gap zeroing.
