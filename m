Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACAA436556
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhJUPOn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhJUPOn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8BAC061348;
        Thu, 21 Oct 2021 08:12:26 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:12:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829145;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wc1vy2778LRikArsGs1VeNeKCI2/I4IsxAt+v49wyvk=;
        b=hRiycZnxsvDBGt7MNZfnFvfQ9HZKQXmktAmd5n1/0p1csFqZupnVdp6B4+U15KrwvUUAii
        HrNOIdnCAsQOT/8BXH4v2+rhkaEL6ZQOSO2q2bXdZafIEVlxHc3CYCkwdquCcJswd5Lm5E
        wwSaWDa51+oSD3mhzOcqL0VJMPKE6JRWtJfFvoEnA0vXvZ9wdcaCRhsmpXIHMvrOOy98X1
        IuvVMVFTLBX2wSllfnBLUCusFCBeZY0OConW2PDA9iSyyb8/SnPkkwmi6ZA8bi6ZPOHFqe
        zXZp7gCgBOfyPcJQr3ng4SNAp2i6noeyViqw3NnSwrKiefj1mSLvJ4W7JKySNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829145;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wc1vy2778LRikArsGs1VeNeKCI2/I4IsxAt+v49wyvk=;
        b=rQzBs8eHPzV/fZlzJ3lMBSIGJWYB3pauxPY88zGsWfMqy2lgHmKIdDabuwa9dHxOyouH8V
        U4tfVIGUUCbEOEDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Use fpstate for copy_uabi_to_xstate()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145323.233529986@linutronix.de>
References: <20211013145323.233529986@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482914451.25758.7197982542465132827.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     49e4eb4125d506937e52e10c34c8cafd93ab0ed6
Gitweb:        https://git.kernel.org/tip/49e4eb4125d506937e52e10c34c8cafd93ab0ed6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:55 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 14:24:14 +02:00

x86/fpu/xstate: Use fpstate for copy_uabi_to_xstate()

Prepare for dynamically enabled states per task. The function needs to
retrieve the features and sizes which are valid in a fpstate
context. Retrieve them from fpstate.

Move the function declarations to the core header as they are not
required anywhere else.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145323.233529986@linutronix.de
---
 arch/x86/include/asm/fpu/xstate.h | 12 ------------
 arch/x86/kernel/fpu/core.c        |  2 +-
 arch/x86/kernel/fpu/regset.c      |  5 ++---
 arch/x86/kernel/fpu/signal.c      |  2 +-
 arch/x86/kernel/fpu/xstate.c      | 18 ++++++++++--------
 arch/x86/kernel/fpu/xstate.h      | 12 ++++++++++++
 6 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index fb329bb..61fcb15 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -129,20 +129,8 @@ extern void __init update_regset_xstate_info(unsigned int size,
 					     u64 xstate_mask);
 
 int xfeature_size(int xfeature_nr);
-int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
-int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
 
 void xsaves(struct xregs_state *xsave, u64 mask);
 void xrstors(struct xregs_state *xsave, u64 mask);
 
-enum xstate_copy_mode {
-	XSTATE_COPY_FP,
-	XSTATE_COPY_FX,
-	XSTATE_COPY_XSAVE,
-};
-
-struct membuf;
-void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
-			     enum xstate_copy_mode mode);
-
 #endif
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 04fef47..b497eca 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -222,7 +222,7 @@ int fpu_copy_kvm_uabi_to_fpstate(struct fpu *fpu, const void *buf, u64 xcr0,
 	if (ustate->xsave.header.xfeatures & ~xcr0)
 		return -EINVAL;
 
-	ret = copy_uabi_from_kernel_to_xstate(&kstate->regs.xsave, ustate);
+	ret = copy_uabi_from_kernel_to_xstate(kstate, ustate);
 	if (ret)
 		return ret;
 
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index ec77779..f8c485a 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -8,11 +8,11 @@
 #include <asm/fpu/api.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
-#include <asm/fpu/xstate.h>
 
 #include "context.h"
 #include "internal.h"
 #include "legacy.h"
+#include "xstate.h"
 
 /*
  * The xstateregs_active() routine is the same as the regset_fpregs_active() routine,
@@ -168,8 +168,7 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	}
 
 	fpu_force_restore(fpu);
-	ret = copy_uabi_from_kernel_to_xstate(&fpu->fpstate->regs.xsave,
-					      kbuf ?: tmpbuf);
+	ret = copy_uabi_from_kernel_to_xstate(fpu->fpstate, kbuf ?: tmpbuf);
 
 out:
 	vfree(tmpbuf);
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 5aca418..935818b 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -375,7 +375,7 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 
 	fpregs = &fpu->fpstate->regs;
 	if (use_xsave() && !fx_only) {
-		if (copy_sigframe_from_user_to_xstate(&fpregs->xsave, buf_fx))
+		if (copy_sigframe_from_user_to_xstate(fpu->fpstate, buf_fx))
 			return false;
 	} else {
 		if (__copy_from_user(&fpregs->fxsave, buf_fx,
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 54cc0a4..4cfd3bc 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -463,10 +463,11 @@ int xfeature_size(int xfeature_nr)
 }
 
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-static int validate_user_xstate_header(const struct xstate_header *hdr)
+static int validate_user_xstate_header(const struct xstate_header *hdr,
+				       struct fpstate *fpstate)
 {
 	/* No unknown or supervisor features may be set */
-	if (hdr->xfeatures & ~xfeatures_mask_uabi())
+	if (hdr->xfeatures & ~fpstate->user_xfeatures)
 		return -EINVAL;
 
 	/* Userspace must use the uncompacted format */
@@ -1115,9 +1116,10 @@ static int copy_from_buffer(void *dst, unsigned int offset, unsigned int size,
 }
 
 
-static int copy_uabi_to_xstate(struct xregs_state *xsave, const void *kbuf,
+static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
 			       const void __user *ubuf)
 {
+	struct xregs_state *xsave = &fpstate->regs.xsave;
 	unsigned int offset, size;
 	struct xstate_header hdr;
 	u64 mask;
@@ -1127,7 +1129,7 @@ static int copy_uabi_to_xstate(struct xregs_state *xsave, const void *kbuf,
 	if (copy_from_buffer(&hdr, offset, sizeof(hdr), kbuf, ubuf))
 		return -EFAULT;
 
-	if (validate_user_xstate_header(&hdr))
+	if (validate_user_xstate_header(&hdr, fpstate))
 		return -EINVAL;
 
 	/* Validate MXCSR when any of the related features is in use */
@@ -1182,9 +1184,9 @@ static int copy_uabi_to_xstate(struct xregs_state *xsave, const void *kbuf,
  * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S]
  * format and copy to the target thread. Used by ptrace and KVM.
  */
-int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
+int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf)
 {
-	return copy_uabi_to_xstate(xsave, kbuf, NULL);
+	return copy_uabi_to_xstate(fpstate, kbuf, NULL);
 }
 
 /*
@@ -1192,10 +1194,10 @@ int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
  * XSAVE[S] format and copy to the target thread. This is called from the
  * sigreturn() and rt_sigreturn() system calls.
  */
-int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave,
+int copy_sigframe_from_user_to_xstate(struct fpstate *fpstate,
 				      const void __user *ubuf)
 {
-	return copy_uabi_to_xstate(xsave, NULL, ubuf);
+	return copy_uabi_to_xstate(fpstate, NULL, ubuf);
 }
 
 static bool validate_independent_components(u64 mask)
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index b74c595..379dbfa 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -15,8 +15,20 @@ static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
 		xsave->header.xcomp_bv = mask | XCOMP_BV_COMPACTED_FORMAT;
 }
 
+enum xstate_copy_mode {
+	XSTATE_COPY_FP,
+	XSTATE_COPY_FX,
+	XSTATE_COPY_XSAVE,
+};
+
+struct membuf;
 extern void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 				      u32 pkru_val, enum xstate_copy_mode copy_mode);
+extern void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
+				    enum xstate_copy_mode mode);
+extern int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf);
+extern int copy_sigframe_from_user_to_xstate(struct fpstate *fpstate, const void __user *ubuf);
+
 
 extern void fpu__init_cpu_xstate(void);
 extern void fpu__init_system_xstate(void);
