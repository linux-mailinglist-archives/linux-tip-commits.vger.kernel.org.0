Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2787843B6CF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbhJZQTM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34616 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237353AbhJZQTJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:09 -0400
Date:   Tue, 26 Oct 2021 16:16:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635265003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IAirAetsHHT1nRztU70EB/5VLugxerIjwwBZu4dffbM=;
        b=2oOg5kwyFAsBzakwvzcN8nwbwl14jJs5WtNdixQMEiWVDHZkUgQBc1N2tWoZY7rFjLBQ/r
        ywg7eXjm9c+KZpa0q73oPDauZRqFeOOjKamIlmZrZKEVOq/tgOkn7F4a8oGZe5ZEt27iOo
        GDXz4apJtzw1u+CRgyS0xdN+zjJrNifiorLY5v3O5Ch12AaXF2hLA0M9eLBDKKAF1m8h7I
        5GAioJaf6oG3mJcZty6tiV3vqzzg6RrvcUQkormqpgnPlDpJ6QkfEzM6UI5U8/+4hYrOPV
        h2lJ0Rt7bkxCGf0gfukFEDcy7rCVScI9J3fhKUiAYA4t6blFl+QpWRCFoam0wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635265003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IAirAetsHHT1nRztU70EB/5VLugxerIjwwBZu4dffbM=;
        b=zB3iL4CaNYW7Gq4V8FriHb2XgeDYE43Qn+Oh7jt+qkcvHrAk6/2h8V6aecbcZ4rEaFZeur
        etiaM04JKmPWzUDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Prepare fpu_clone() for dynamically enabled features
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-11-chang.seok.bae@intel.com>
References: <20211021225527.10184-11-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526500273.626.12198381538366775281.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     9e798e9aa14c45fb94e47b30bf6347b369ce9df7
Gitweb:        https://git.kernel.org/tip/9e798e9aa14c45fb94e47b30bf6347b369ce9df7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 Oct 2021 15:55:14 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:18:09 +02:00

x86/fpu: Prepare fpu_clone() for dynamically enabled features

The default portion of the parent's FPU state is saved in a child task.
With dynamic features enabled, the non-default portion is not saved in a
child's fpstate because these register states are defined to be
caller-saved. The new task's fpstate is therefore the default buffer.

Fork inherits the permission of the parent.

Also, do not use memcpy() when TIF_NEED_FPU_LOAD is set because it is
invalid when the parent has dynamic features.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211021225527.10184-11-chang.seok.bae@intel.com
---
 arch/x86/include/asm/fpu/sched.h |  2 +-
 arch/x86/kernel/fpu/core.c       | 35 ++++++++++++++++++++++---------
 arch/x86/kernel/process.c        |  2 +-
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index cdb78d5..99a8820 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -11,7 +11,7 @@
 
 extern void save_fpregs_to_fpstate(struct fpu *fpu);
 extern void fpu__drop(struct fpu *fpu);
-extern int  fpu_clone(struct task_struct *dst);
+extern int  fpu_clone(struct task_struct *dst, unsigned long clone_flags);
 extern void fpu_flush_thread(void);
 
 /*
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 4018083..1ff6b83 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -423,8 +423,20 @@ void fpstate_reset(struct fpu *fpu)
 	fpu->perm.__user_state_size	= fpu_user_cfg.default_size;
 }
 
+static inline void fpu_inherit_perms(struct fpu *dst_fpu)
+{
+	if (fpu_state_size_dynamic()) {
+		struct fpu *src_fpu = &current->group_leader->thread.fpu;
+
+		spin_lock_irq(&current->sighand->siglock);
+		/* Fork also inherits the permissions of the parent */
+		dst_fpu->perm = src_fpu->perm;
+		spin_unlock_irq(&current->sighand->siglock);
+	}
+}
+
 /* Clone current's FPU state on fork */
-int fpu_clone(struct task_struct *dst)
+int fpu_clone(struct task_struct *dst, unsigned long clone_flags)
 {
 	struct fpu *src_fpu = &current->thread.fpu;
 	struct fpu *dst_fpu = &dst->thread.fpu;
@@ -455,17 +467,20 @@ int fpu_clone(struct task_struct *dst)
 	}
 
 	/*
-	 * If the FPU registers are not owned by current just memcpy() the
-	 * state.  Otherwise save the FPU registers directly into the
-	 * child's FPU context, without any memory-to-memory copying.
+	 * Save the default portion of the current FPU state into the
+	 * clone. Assume all dynamic features to be defined as caller-
+	 * saved, which enables skipping both the expansion of fpstate
+	 * and the copying of any dynamic state.
+	 *
+	 * Do not use memcpy() when TIF_NEED_FPU_LOAD is set because
+	 * copying is not valid when current uses non-default states.
 	 */
 	fpregs_lock();
-	if (test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		memcpy(&dst_fpu->fpstate->regs, &src_fpu->fpstate->regs,
-		       dst_fpu->fpstate->size);
-	} else {
-		save_fpregs_to_fpstate(dst_fpu);
-	}
+	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+		fpregs_restore_userregs();
+	save_fpregs_to_fpstate(dst_fpu);
+	if (!(clone_flags & CLONE_THREAD))
+		fpu_inherit_perms(dst_fpu);
 	fpregs_unlock();
 
 	trace_x86_fpu_copy_src(src_fpu);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 97fea16..99025e3 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -157,7 +157,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	frame->flags = X86_EFLAGS_FIXED;
 #endif
 
-	fpu_clone(p);
+	fpu_clone(p, clone_flags);
 
 	/* Kernel thread ? */
 	if (unlikely(p->flags & PF_KTHREAD)) {
