Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90EE43847A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 23 Oct 2021 19:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhJWRiN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 23 Oct 2021 13:38:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45418 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhJWRiM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 23 Oct 2021 13:38:12 -0400
Date:   Sat, 23 Oct 2021 17:35:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635010551;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5FS2cPBt5yP84j8yAK8Wa+8EPVDKcPO123/waYiUBDc=;
        b=eujwDhM2Y2WVcdAMnENwD9fqwzo0J/ZMVaPVxJBh9VCib6ABaAeWsyTzrtYuzUXaWUzaX5
        1dHPT7x+WTSP2Z3C9U1lQzrA8VF6WTBNKH7bXr8e6O1OoQZOpUjErQuo8UxukNgEuvxmR9
        j+Shx9a0n9oUO8N3F6xLFV4/61vutC9ztwJaKdjgoy/HlisnKgzYlKgHL9+AYf3Y30gCHw
        8zGNDJvCWiyVWDhSj4+Wf5mmEoVy6uLRPiCDPo4PIeK2K2Ma2NSkko2b3O9QwdQd2vh9Lo
        s8dSyhrB4s9ACOlmHt+q9x6y4fKjdCFd5p1gaDHw3/RX6YHuZYydHaeQEZ477g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635010551;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5FS2cPBt5yP84j8yAK8Wa+8EPVDKcPO123/waYiUBDc=;
        b=r8erWlil6kUcWpeVikbJrAKvvOfk0iH6WRG7zTTncgLJmxz1kpPv4uCUHti3eNYuVPOd31
        LUuuB2y48D5d+uBA==
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
Message-ID: <163501055012.626.9422814218488225986.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     582b01b6ab2714a0a4d554cea7f0d4efeaa2154d
Gitweb:        https://git.kernel.org/tip/582b01b6ab2714a0a4d554cea7f0d4efeaa2154d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 22 Oct 2021 20:55:54 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 23 Oct 2021 17:05:19 +02:00

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
index 01fbf7c..9c475e2 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -245,29 +245,6 @@ int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
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
@@ -437,15 +414,6 @@ void fpstate_reset(struct fpu *fpu)
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
