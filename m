Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F6A439189
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Oct 2021 10:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhJYIj0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 25 Oct 2021 04:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhJYIjU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 25 Oct 2021 04:39:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7E2C061230;
        Mon, 25 Oct 2021 01:36:36 -0700 (PDT)
Date:   Mon, 25 Oct 2021 08:36:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635150994;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HUE+S9rdSLIPaqr1W+1AKQKpvYiJgDCj2CF5fl1vHNs=;
        b=IKpIgiOeRqV9wuq2heSeBAg5hZvZyYL7Ep1d1Tv+heTRHEzC2Lv6n6HFUukpo01dAuvVW1
        7CmCC5mzGtnGWKdWyxA6KvjuyiMbv0ONq7zv2XEGwhMRoBTFZQlx3c9npZPf3c8M4ZY6yv
        Y3l+kaV0b4VtWgKq3MOUcBTUXhxxy8kwl+z5e+Flq3E4TnA1emlqy8VZLKx4dc5hYlflhw
        grDfxKG2V9L6bTWPh7MApSzyakyKYqmEk2eSv2i+wQglTaD5r+WAz7ogWF4XMNemwZhlLF
        qqAl78V/bmdO+6kC5J3jYwlqmgZBtOWqMV6nXgVuuGgawJuOcTX6oE55OD/R2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635150994;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HUE+S9rdSLIPaqr1W+1AKQKpvYiJgDCj2CF5fl1vHNs=;
        b=v+nzOIswh67xDwXp2a2rORcBh1qnoHnnimCaLNRnsRHSK1trMKO5fFUpVVq3kuEIauJjY3
        Qco04mViKPZzGvCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Remove old KVM FPU interface
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211022185313.074853631@linutronix.de>
References: <20211022185313.074853631@linutronix.de>
MIME-Version: 1.0
Message-ID: <163515099334.626.9671958390453110224.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     c341f1fe1543dfaf94916cef298aa60be545235f
Gitweb:        https://git.kernel.org/tip/c341f1fe1543dfaf94916cef298aa60be545235f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 22 Oct 2021 20:55:54 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 25 Oct 2021 10:24:16 +02:00

x86/fpu: Remove old KVM FPU interface

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211022185313.074853631@linutronix.de
---
 arch/x86/include/asm/fpu/api.h |  2 --
 arch/x86/kernel/fpu/core.c     | 32 --------------------------------
 2 files changed, 34 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 5e5f172..e9379d7 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -131,14 +131,12 @@ static inline void fpstate_init_soft(struct swregs_state *soft) {}
 DECLARE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
 /* fpstate-related functions which are exported to KVM */
-extern void fpu_init_fpstate_user(struct fpu *fpu);
 extern void fpstate_clear_xstate_component(struct fpstate *fps, unsigned int xfeature);
 
 /* KVM specific functions */
 extern bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu);
 extern void fpu_free_guest_fpstate(struct fpu_guest *gfpu);
 extern int fpu_swap_kvm_fpstate(struct fpu_guest *gfpu, bool enter_guest);
-extern void fpu_swap_kvm_fpu(struct fpu *save, struct fpu *rstor, u64 restore_mask);
 
 extern void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf, unsigned int size, u32 pkru);
 extern int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf, u64 xcr0, u32 *vpkru);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 64c98a4..c55013f 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -246,29 +246,6 @@ int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
 }
 EXPORT_SYMBOL_GPL(fpu_swap_kvm_fpstate);
 
-void fpu_swap_kvm_fpu(struct fpu *save, struct fpu *rstor, u64 restore_mask)
-{
-	fpregs_lock();
-
-	if (save) {
-		struct fpstate *fpcur = current->thread.fpu.fpstate;
-
-		if (test_thread_flag(TIF_NEED_FPU_LOAD))
-			memcpy(&save->fpstate->regs, &fpcur->regs, fpcur->size);
-		else
-			save_fpregs_to_fpstate(save);
-	}
-
-	if (rstor) {
-		restore_mask &= XFEATURE_MASK_FPSTATE;
-		restore_fpregs_from_fpstate(rstor->fpstate, restore_mask);
-	}
-
-	fpregs_mark_activate();
-	fpregs_unlock();
-}
-EXPORT_SYMBOL_GPL(fpu_swap_kvm_fpu);
-
 void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf,
 				    unsigned int size, u32 pkru)
 {
@@ -438,15 +415,6 @@ void fpstate_reset(struct fpu *fpu)
 	__fpstate_reset(fpu->fpstate);
 }
 
-#if IS_ENABLED(CONFIG_KVM)
-void fpu_init_fpstate_user(struct fpu *fpu)
-{
-	fpstate_reset(fpu);
-	fpstate_init_user(fpu->fpstate);
-}
-EXPORT_SYMBOL_GPL(fpu_init_fpstate_user);
-#endif
-
 /* Clone current's FPU state on fork */
 int fpu_clone(struct task_struct *dst)
 {
