Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688D3438482
	for <lists+linux-tip-commits@lfdr.de>; Sat, 23 Oct 2021 19:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhJWRiR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 23 Oct 2021 13:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhJWRiP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 23 Oct 2021 13:38:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E088C061714;
        Sat, 23 Oct 2021 10:35:55 -0700 (PDT)
Date:   Sat, 23 Oct 2021 17:35:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635010552;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ld3PBqhHXQQ8REpduHJdYbWLoQMHANxqsB60VhZASV0=;
        b=L+iTiP7WbIPuO0MOG0gi4ctH9FMYgwYG6JlszG1pHSDwPIosLSEHVWq2t0mbni8RhMm5sX
        yawZ9ZOyw9MSnFW7RQSHdeDrIozChdldSAofpKYEjJkRQg9jzjsSizvdlfC82A7vXcQUQ7
        qYDOX8dU3Y/KDiNs2Vn8kbE9PD9D4Ya3mve+vP2+AReYRizyw2zp78C3Bfh/Baw+XUW8mx
        GYwx1xpRauUzILA8k0GCg9DUisZjU6Kd41/WWpYmciCpFqgRd55LT/FQLkfzUA91tPNK/U
        bO+cKFtQVuRg7WsUz3H5sugHbf4KmFLp699OukUyIHGzaBEnx0fCMsPv6SjwPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635010552;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ld3PBqhHXQQ8REpduHJdYbWLoQMHANxqsB60VhZASV0=;
        b=v0ADWm+hDsNy5os3qdBqrZGO23AbhM2cK6GL0L4Ddwxvc2gkdXgVTsAQdDa8gWcBD6CN/m
        QAcTmbV3pzmWECBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Provide infrastructure for KVM FPU cleanup
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211022185312.954684740@linutronix.de>
References: <20211022185312.954684740@linutronix.de>
MIME-Version: 1.0
Message-ID: <163501055181.626.14047534977251705961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     69f6ed1d14c6bcf712f4bb22a231c15eeab401e7
Gitweb:        https://git.kernel.org/tip/69f6ed1d14c6bcf712f4bb22a231c15eeab401e7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 22 Oct 2021 20:55:51 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 23 Oct 2021 14:50:19 +02:00

x86/fpu: Provide infrastructure for KVM FPU cleanup

For the upcoming AMX support it's necessary to do a proper integration with
KVM. Currently KVM allocates two FPU structs which are used for saving the user
state of the vCPU thread and restoring the guest state when entering
vcpu_run() and doing the reverse operation before leaving vcpu_run().

With the new fpstate mechanism this can be reduced to one extra buffer by
swapping the fpstate pointer in current::thread::fpu. This makes the
upcoming support for AMX and XFD simpler because then fpstate information
(features, sizes, xfd) are always consistent and it does not require any
nasty workarounds.

Provide:

  - An allocator which initializes the state properly

  - A replacement for the existing FPU swap mechanim

Aside of the reduced memory footprint, this also makes state switching
more efficient when TIF_FPU_NEED_LOAD is set. It does not require a
memcpy as the state is already correct in the to be swapped out fpstate.

The existing interfaces will be removed once KVM is converted over.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211022185312.954684740@linutronix.de
---
 arch/x86/include/asm/fpu/api.h | 13 +++++-
 arch/x86/kernel/fpu/core.c     | 85 ++++++++++++++++++++++++++++++---
 2 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 9ce8314..de85bca 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -135,9 +135,22 @@ extern void fpu_init_fpstate_user(struct fpu *fpu);
 extern void fpstate_clear_xstate_component(struct fpstate *fps, unsigned int xfeature);
 
 /* KVM specific functions */
+extern bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu);
+extern void fpu_free_guest_fpstate(struct fpu_guest *gfpu);
+extern int fpu_swap_kvm_fpstate(struct fpu_guest *gfpu, bool enter_guest);
 extern void fpu_swap_kvm_fpu(struct fpu *save, struct fpu *rstor, u64 restore_mask);
 
 extern int fpu_copy_kvm_uabi_to_fpstate(struct fpu *fpu, const void *buf, u64 xcr0, u32 *pkru);
 extern void fpu_copy_fpstate_to_kvm_uabi(struct fpu *fpu, void *buf, unsigned int size, u32 pkru);
 
+static inline void fpstate_set_confidential(struct fpu_guest *gfpu)
+{
+	gfpu->fpstate->is_confidential = true;
+}
+
+static inline bool fpstate_is_confidential(struct fpu_guest *gfpu)
+{
+	return gfpu->fpstate->is_confidential;
+}
+
 #endif /* _ASM_X86_FPU_API_H */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 0fb9def..748d7b2 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -176,6 +176,75 @@ void fpu_reset_from_exception_fixup(void)
 }
 
 #if IS_ENABLED(CONFIG_KVM)
+static void __fpstate_reset(struct fpstate *fpstate);
+
+bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
+{
+	struct fpstate *fpstate;
+	unsigned int size;
+
+	size = fpu_user_cfg.default_size + ALIGN(offsetof(struct fpstate, regs), 64);
+	fpstate = vzalloc(size);
+	if (!fpstate)
+		return false;
+
+	__fpstate_reset(fpstate);
+	fpstate_init_user(fpstate);
+	fpstate->is_valloc	= true;
+	fpstate->is_guest	= true;
+
+	gfpu->fpstate = fpstate;
+	return true;
+}
+EXPORT_SYMBOL_GPL(fpu_alloc_guest_fpstate);
+
+void fpu_free_guest_fpstate(struct fpu_guest *gfpu)
+{
+	struct fpstate *fps = gfpu->fpstate;
+
+	if (!fps)
+		return;
+
+	if (WARN_ON_ONCE(!fps->is_valloc || !fps->is_guest || fps->in_use))
+		return;
+
+	gfpu->fpstate = NULL;
+	vfree(fps);
+}
+EXPORT_SYMBOL_GPL(fpu_free_guest_fpstate);
+
+int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
+{
+	struct fpstate *guest_fps = guest_fpu->fpstate;
+	struct fpu *fpu = &current->thread.fpu;
+	struct fpstate *cur_fps = fpu->fpstate;
+
+	fpregs_lock();
+	if (!cur_fps->is_confidential && !test_thread_flag(TIF_NEED_FPU_LOAD))
+		save_fpregs_to_fpstate(fpu);
+
+	/* Swap fpstate */
+	if (enter_guest) {
+		fpu->__task_fpstate = cur_fps;
+		fpu->fpstate = guest_fps;
+		guest_fps->in_use = true;
+	} else {
+		guest_fps->in_use = false;
+		fpu->fpstate = fpu->__task_fpstate;
+		fpu->__task_fpstate = NULL;
+	}
+
+	cur_fps = fpu->fpstate;
+
+	if (!cur_fps->is_confidential)
+		restore_fpregs_from_fpstate(cur_fps, XFEATURE_MASK_FPSTATE);
+
+	fpregs_mark_activate();
+	fpregs_unlock();
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fpu_swap_kvm_fpstate);
+
 void fpu_swap_kvm_fpu(struct fpu *save, struct fpu *rstor, u64 restore_mask)
 {
 	fpregs_lock();
@@ -352,16 +421,20 @@ void fpstate_init_user(struct fpstate *fpstate)
 		fpstate_init_fstate(fpstate);
 }
 
+static void __fpstate_reset(struct fpstate *fpstate)
+{
+	/* Initialize sizes and feature masks */
+	fpstate->size		= fpu_kernel_cfg.default_size;
+	fpstate->user_size	= fpu_user_cfg.default_size;
+	fpstate->xfeatures	= fpu_kernel_cfg.default_features;
+	fpstate->user_xfeatures	= fpu_user_cfg.default_features;
+}
+
 void fpstate_reset(struct fpu *fpu)
 {
 	/* Set the fpstate pointer to the default fpstate */
 	fpu->fpstate = &fpu->__fpstate;
-
-	/* Initialize sizes and feature masks */
-	fpu->fpstate->size		= fpu_kernel_cfg.default_size;
-	fpu->fpstate->user_size		= fpu_user_cfg.default_size;
-	fpu->fpstate->xfeatures		= fpu_kernel_cfg.default_features;
-	fpu->fpstate->user_xfeatures	= fpu_user_cfg.default_features;
+	__fpstate_reset(fpu->fpstate);
 }
 
 #if IS_ENABLED(CONFIG_KVM)
