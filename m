Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12A9436558
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhJUPOo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:14:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60770 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhJUPOn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:43 -0400
Date:   Thu, 21 Oct 2021 15:12:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829146;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3yxVjkLYJk8AF6UKolWwukXYCWFj6uq3WwGQypV1Jg0=;
        b=oJ+WLzS3sR8v3U/LiJMoxl6+j4X/GjovN79kJfAP1zfZCwnHO07IzlzGPTwRyl7uzEi6ii
        l8PvfsaFT82+cPzqBrfp9/FlbJL1fcMFUWZkO9G6LHPkqgd28PqB8/3g8toaJRRTIu7JBi
        DSH5QFbf57Z5sM2faXTBybTu3z65wtY+EWfBvIiqNjmorpyp38qR6D1MgT3JtleijiJIK/
        jwNW6R9fzF5tYxhoXaBfQihbUFvnGqsH6qy/tlEE2IsZMgubn3lHkEpgoVDg96s7k39gN7
        XVKYHMU48ZI286xiBZYUmxu7BZ7iUSrF8lXbEEtMs6JaGKrrWJkfephIepEZqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829146;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3yxVjkLYJk8AF6UKolWwukXYCWFj6uq3WwGQypV1Jg0=;
        b=8EnRnC8ZWAhlW+m9vGqNJsakS2m0hakkLXOaKLqP4ztQ9JIiTVZr5VaItTGpYHFIqBRDog
        OzVtGK0Tm2wbN2DQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Use fpstate in __copy_xstate_to_uabi_buf()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145323.181495492@linutronix.de>
References: <20211013145323.181495492@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482914518.25758.5531112398345900121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     3ac8d75778fc8c1c22daad9bc674166b862f6f6e
Gitweb:        https://git.kernel.org/tip/3ac8d75778fc8c1c22daad9bc674166b862f6f6e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:54 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 14:18:23 +02:00

x86/fpu: Use fpstate in __copy_xstate_to_uabi_buf()

With dynamically enabled features the copy function must know the features
and the size which is valid for the task. Retrieve them from fpstate.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145323.181495492@linutronix.de
---
 arch/x86/kernel/fpu/core.c   |  8 ++++----
 arch/x86/kernel/fpu/xstate.c | 11 ++++++-----
 arch/x86/kernel/fpu/xstate.h |  2 +-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 052e5ef..04fef47 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -187,15 +187,15 @@ EXPORT_SYMBOL_GPL(fpu_swap_kvm_fpu);
 void fpu_copy_fpstate_to_kvm_uabi(struct fpu *fpu, void *buf,
 			       unsigned int size, u32 pkru)
 {
-	union fpregs_state *kstate = &fpu->fpstate->regs;
+	struct fpstate *kstate = fpu->fpstate;
 	union fpregs_state *ustate = buf;
 	struct membuf mb = { .p = buf, .left = size };
 
 	if (cpu_feature_enabled(X86_FEATURE_XSAVE)) {
-		__copy_xstate_to_uabi_buf(mb, &kstate->xsave, pkru,
-					  XSTATE_COPY_XSAVE);
+		__copy_xstate_to_uabi_buf(mb, kstate, pkru, XSTATE_COPY_XSAVE);
 	} else {
-		memcpy(&ustate->fxsave, &kstate->fxsave, sizeof(ustate->fxsave));
+		memcpy(&ustate->fxsave, &kstate->regs.fxsave,
+		       sizeof(ustate->fxsave));
 		/* Make it restorable on a XSAVE enabled host */
 		ustate->xsave.header.xfeatures = XFEATURE_MASK_FPSSE;
 	}
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 4beb010..54cc0a4 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -969,7 +969,7 @@ static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
 /**
  * __copy_xstate_to_uabi_buf - Copy kernel saved xstate to a UABI buffer
  * @to:		membuf descriptor
- * @xsave:	The xsave from which to copy
+ * @fpstate:	The fpstate buffer from which to copy
  * @pkru_val:	The PKRU value to store in the PKRU component
  * @copy_mode:	The requested copy mode
  *
@@ -979,11 +979,12 @@ static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
  *
  * It supports partial copy but @to.pos always starts from zero.
  */
-void __copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
+void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 			       u32 pkru_val, enum xstate_copy_mode copy_mode)
 {
 	const unsigned int off_mxcsr = offsetof(struct fxregs_state, mxcsr);
 	struct xregs_state *xinit = &init_fpstate.regs.xsave;
+	struct xregs_state *xsave = &fpstate->regs.xsave;
 	struct xstate_header header;
 	unsigned int zerofrom;
 	u64 mask;
@@ -1003,7 +1004,7 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
 		break;
 
 	case XSTATE_COPY_XSAVE:
-		header.xfeatures &= xfeatures_mask_uabi();
+		header.xfeatures &= fpstate->user_xfeatures;
 		break;
 	}
 
@@ -1046,7 +1047,7 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
 	 * but there is no state to copy from in the compacted
 	 * init_fpstate. The gap tracking will zero these states.
 	 */
-	mask = xfeatures_mask_uabi();
+	mask = fpstate->user_xfeatures;
 
 	for_each_extended_xfeature(i, mask) {
 		/*
@@ -1097,7 +1098,7 @@ out:
 void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 			     enum xstate_copy_mode copy_mode)
 {
-	__copy_xstate_to_uabi_buf(to, &tsk->thread.fpu.fpstate->regs.xsave,
+	__copy_xstate_to_uabi_buf(to, tsk->thread.fpu.fpstate,
 				  tsk->thread.pkru, copy_mode);
 }
 
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 3e9eaf9..b74c595 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -15,7 +15,7 @@ static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
 		xsave->header.xcomp_bv = mask | XCOMP_BV_COMPACTED_FORMAT;
 }
 
-extern void __copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
+extern void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 				      u32 pkru_val, enum xstate_copy_mode copy_mode);
 
 extern void fpu__init_cpu_xstate(void);
