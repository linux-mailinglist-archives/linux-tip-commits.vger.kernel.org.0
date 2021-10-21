Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2824943655F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhJUPOr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhJUPOq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CB7C0613B9;
        Thu, 21 Oct 2021 08:12:30 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:12:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQaBZ8n2v5ZtIG5XA6pUQw3NIaf4nnJDGjayKlhRIZ8=;
        b=ydKn9i3EIieOQf29UL98FEjmOIVWkXu92b48QymL3CGVbicUjlhyZMmKDDAtrPCCVkTAJC
        Gn/YXTZoUfyy9ukSFQoklQhfhh9O2gmfDjfofhmQh5YRz7IOvgL4dEw+foUfQU1NGU8zbZ
        XpQ5fGx9lqLZ67bBcH2KtA1FcjKYNXLBW2CecADP4GPkzxJ4F/N79yyhpJZmD7pQz9rTej
        Yi2xBEUlAiIGjaCzRtsLKIKYKCkVKc88HaDWkIv4Vcp0vpEUngZEj/PBR5K5Du9iDeC7v3
        iVsINL1z/ZBoeo7E/3PRVSiI3LZscfwv9spLKClLhy9isDnUjtXCaZzjJbMiRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQaBZ8n2v5ZtIG5XA6pUQw3NIaf4nnJDGjayKlhRIZ8=;
        b=/OBCBtcfvlNGHu5YZkgpv0K3iPhxcahRl5CwQEUbNj0wOpywrSfdbdPUlNrqLhJcnroKnd
        qmNFXSi1S84GECAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Use fpstate::size
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145322.973518954@linutronix.de>
References: <20211013145322.973518954@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482914796.25758.6331180410187095503.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     be31dfdfd75b172af3ddcfa7511cdc3bb7adb25e
Gitweb:        https://git.kernel.org/tip/be31dfdfd75b172af3ddcfa7511cdc3bb7adb25e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:48 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 14:02:25 +02:00

x86/fpu: Use fpstate::size

Make use of fpstate::size in various places which require the buffer size
information for sanity checks or memcpy() sizing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145322.973518954@linutronix.de
---
 arch/x86/kernel/fpu/core.c   | 13 ++++++-------
 arch/x86/kernel/fpu/signal.c |  7 +++----
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index a8cc20e..cb48c80 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -166,13 +166,12 @@ void fpu_swap_kvm_fpu(struct fpu *save, struct fpu *rstor, u64 restore_mask)
 	fpregs_lock();
 
 	if (save) {
-		if (test_thread_flag(TIF_NEED_FPU_LOAD)) {
-			memcpy(&save->fpstate->regs,
-			       &current->thread.fpu.fpstate->regs,
-			       fpu_kernel_xstate_size);
-		} else {
+		struct fpstate *fpcur = current->thread.fpu.fpstate;
+
+		if (test_thread_flag(TIF_NEED_FPU_LOAD))
+			memcpy(&save->fpstate->regs, &fpcur->regs, fpcur->size);
+		else
 			save_fpregs_to_fpstate(save);
-		}
 	}
 
 	if (rstor) {
@@ -398,7 +397,7 @@ int fpu_clone(struct task_struct *dst)
 	fpregs_lock();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		memcpy(&dst_fpu->fpstate->regs, &src_fpu->fpstate->regs,
-		       fpu_kernel_xstate_size);
+		       dst_fpu->fpstate->size);
 	} else {
 		save_fpregs_to_fpstate(dst_fpu);
 	}
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index c54c2a3..aa93291 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -313,15 +313,13 @@ retry:
 static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 			      bool ia32_fxstate)
 {
-	int state_size = fpu_kernel_xstate_size;
 	struct task_struct *tsk = current;
 	struct fpu *fpu = &tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
+	bool success, fx_only = false;
 	union fpregs_state *fpregs;
+	unsigned int state_size;
 	u64 user_xfeatures = 0;
-	bool fx_only = false;
-	bool success;
-
 
 	if (use_xsave()) {
 		struct _fpx_sw_bytes fx_sw_user;
@@ -334,6 +332,7 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		user_xfeatures = fx_sw_user.xfeatures;
 	} else {
 		user_xfeatures = XFEATURE_MASK_FPSSE;
+		state_size = fpu->fpstate->size;
 	}
 
 	if (likely(!ia32_fxstate)) {
