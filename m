Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5587C436557
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhJUPOo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhJUPOn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2B3C0613B9;
        Thu, 21 Oct 2021 08:12:26 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:12:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vVND0yEcZ71I0QbJC2oIjnPkdar6Kc4dpx/VytAAc0w=;
        b=E633KN1GviHOB+s3th9HMGxKqWAFtIA6kE9HLnNjk/yl8px+I8tUrTEbyGc5F0AEDx4exW
        m1g4NCyxs/REZOPfMXapVBZGY4F/kVD7gexG5DMPniNfloIFmCCMQF+nfXRmW1X0FqKUG+
        NOcCDo/bAZdMW3BasDTnhGY/RSGaPU31K9fThQmcizwBFVtDVYqDCdQ3f6bsriuuHIJB2x
        BauIpMvLs3uXX21Awl9YLNBEx62Z8+GlcEfHJpsIhSuZlYuHhV8Ty4vocP0SjVAZy6tPay
        WCCdVQTrA01DYiVZyOlnvCod1wQLuOPT0Sy660V7zjD92cE5SeRYXUXam56Vsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vVND0yEcZ71I0QbJC2oIjnPkdar6Kc4dpx/VytAAc0w=;
        b=mzJFtfaCWqlKYHtuYyfsT5NtP+09fR7gg4sVYFM+X8RJ0DlAC3HtSDy2JaewVvbb7TtLtg
        rLRQ3Zm1M3Cp4mCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Use fpstate for size and features
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87ilxz5iew.ffs@tglx>
References: <87ilxz5iew.ffs@tglx>
MIME-Version: 1.0
Message-ID: <163482914339.25758.17230652529422547201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     5509cc78080d29b23706dbf076d51691b69f3c79
Gitweb:        https://git.kernel.org/tip/5509cc78080d29b23706dbf076d51691b69f3c79
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 00:51:51 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 14:24:47 +02:00

x86/fpu/signal: Use fpstate for size and features

For dynamically enabled features it's required to get the features which
are enabled for that context when restoring from sigframe.

The same applies for all signal frame size calculations.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/87ilxz5iew.ffs@tglx
---
 arch/x86/kernel/fpu/signal.c | 44 +++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 935818b..f9af174 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -41,7 +41,7 @@ static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 	/* Check for the first magic field and other error scenarios. */
 	if (fx_sw->magic1 != FP_XSTATE_MAGIC1 ||
 	    fx_sw->xstate_size < min_xstate_size ||
-	    fx_sw->xstate_size > fpu_user_xstate_size ||
+	    fx_sw->xstate_size > current->thread.fpu.fpstate->user_size ||
 	    fx_sw->xstate_size > fx_sw->extended_size)
 		goto setfx;
 
@@ -98,7 +98,8 @@ static inline bool save_fsave_header(struct task_struct *tsk, void __user *buf)
 	return true;
 }
 
-static inline bool save_xstate_epilog(void __user *buf, int ia32_frame)
+static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
+				      unsigned int usize)
 {
 	struct xregs_state __user *x = buf;
 	struct _fpx_sw_bytes *sw_bytes;
@@ -113,7 +114,7 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame)
 		return !err;
 
 	err |= __put_user(FP_XSTATE_MAGIC2,
-			  (__u32 __user *)(buf + fpu_user_xstate_size));
+			  (__u32 __user *)(buf + usize));
 
 	/*
 	 * Read the xfeatures which we copied (directly from the cpu or
@@ -171,6 +172,7 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
 bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
 	struct task_struct *tsk = current;
+	struct fpstate *fpstate = tsk->thread.fpu.fpstate;
 	int ia32_fxstate = (buf != buf_fx);
 	int ret;
 
@@ -215,7 +217,7 @@ retry:
 	fpregs_unlock();
 
 	if (ret) {
-		if (!__clear_user(buf_fx, fpu_user_xstate_size))
+		if (!__clear_user(buf_fx, fpstate->user_size))
 			goto retry;
 		return false;
 	}
@@ -224,17 +226,18 @@ retry:
 	if ((ia32_fxstate || !use_fxsr()) && !save_fsave_header(tsk, buf))
 		return false;
 
-	if (use_fxsr() && !save_xstate_epilog(buf_fx, ia32_fxstate))
+	if (use_fxsr() &&
+	    !save_xstate_epilog(buf_fx, ia32_fxstate, fpstate->user_size))
 		return false;
 
 	return true;
 }
 
-static int __restore_fpregs_from_user(void __user *buf, u64 xrestore,
-				      bool fx_only)
+static int __restore_fpregs_from_user(void __user *buf, u64 ufeatures,
+				      u64 xrestore, bool fx_only)
 {
 	if (use_xsave()) {
-		u64 init_bv = xfeatures_mask_uabi() & ~xrestore;
+		u64 init_bv = ufeatures & ~xrestore;
 		int ret;
 
 		if (likely(!fx_only))
@@ -265,7 +268,8 @@ static bool restore_fpregs_from_user(void __user *buf, u64 xrestore,
 retry:
 	fpregs_lock();
 	pagefault_disable();
-	ret = __restore_fpregs_from_user(buf, xrestore, fx_only);
+	ret = __restore_fpregs_from_user(buf, fpu->fpstate->user_xfeatures,
+					 xrestore, fx_only);
 	pagefault_enable();
 
 	if (unlikely(ret)) {
@@ -332,7 +336,7 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		user_xfeatures = fx_sw_user.xfeatures;
 	} else {
 		user_xfeatures = XFEATURE_MASK_FPSSE;
-		state_size = fpu->fpstate->size;
+		state_size = fpu->fpstate->user_size;
 	}
 
 	if (likely(!ia32_fxstate)) {
@@ -425,10 +429,11 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 	return success;
 }
 
-static inline int xstate_sigframe_size(void)
+static inline unsigned int xstate_sigframe_size(struct fpstate *fpstate)
 {
-	return use_xsave() ? fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE :
-			fpu_user_xstate_size;
+	unsigned int size = fpstate->user_size;
+
+	return use_xsave() ? size + FP_XSTATE_MAGIC2_SIZE : size;
 }
 
 /*
@@ -436,17 +441,19 @@ static inline int xstate_sigframe_size(void)
  */
 bool fpu__restore_sig(void __user *buf, int ia32_frame)
 {
-	unsigned int size = xstate_sigframe_size();
 	struct fpu *fpu = &current->thread.fpu;
 	void __user *buf_fx = buf;
 	bool ia32_fxstate = false;
 	bool success = false;
+	unsigned int size;
 
 	if (unlikely(!buf)) {
 		fpu__clear_user_states(fpu);
 		return true;
 	}
 
+	size = xstate_sigframe_size(fpu->fpstate);
+
 	ia32_frame &= (IS_ENABLED(CONFIG_X86_32) ||
 		       IS_ENABLED(CONFIG_IA32_EMULATION));
 
@@ -481,7 +488,7 @@ unsigned long
 fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 		     unsigned long *buf_fx, unsigned long *size)
 {
-	unsigned long frame_size = xstate_sigframe_size();
+	unsigned long frame_size = xstate_sigframe_size(current->thread.fpu.fpstate);
 
 	*buf_fx = sp = round_down(sp - frame_size, 64);
 	if (ia32_frame && use_fxsr()) {
@@ -494,9 +501,12 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 	return sp;
 }
 
-unsigned long fpu__get_fpstate_size(void)
+unsigned long __init fpu__get_fpstate_size(void)
 {
-	unsigned long ret = xstate_sigframe_size();
+	unsigned long ret = fpu_user_xstate_size;
+
+	if (use_xsave())
+		ret += FP_XSTATE_MAGIC2_SIZE;
 
 	/*
 	 * This space is needed on (most) 32-bit kernels, or when a 32-bit
