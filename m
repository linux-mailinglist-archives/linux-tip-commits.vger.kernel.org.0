Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BA13B231A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhFWWMP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40054 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhFWWLc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:32 -0400
Date:   Wed, 23 Jun 2021 22:09:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486153;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lj9aNjPI8t22BSqFKqWgFFZyNu0nwu4GYA/y+TSipZA=;
        b=s+EfkOyl/hdK3wD0Eb1RHnG4XGiqqvaDtQrBeR7mXdrF6nATKDG/OJomREAmsJU776lF+R
        K5wXQRy3BcdxB7n0qRLyqQM2EcpioK4NytA/Cs3lWXvp1qALTsLk0XzY1U1J0Arl3cnrGi
        PmFl1KPHanTZVOHnwXqjXhKGG55XbUf+wVc/YaHSUMLJaLI7os0VzobbYXzZcWvC6gt3z8
        9ru8F4VsTvY06l4Yy9w9jBhN70Bvwca9waTI/K3xCz64X+yOGugOSi4iwOCy6totMz2LmL
        0vXywK4/xIt97eNksJ5gPpn9IyS25aWlFWxGhacUc0VqDUv9vm2Y8CwM5rn3IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486153;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lj9aNjPI8t22BSqFKqWgFFZyNu0nwu4GYA/y+TSipZA=;
        b=GeurjUvjWAOjC9CYsR/jnHmRKb94CreBrDn4XshCL7VHIQqmbI7QyrLGl7VGs4dEX/4aaZ
        s2G4FYb5gE/0leCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Rename and sanitize fpu__save/copy()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121455.196727450@linutronix.de>
References: <20210623121455.196727450@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448615236.395.4081108305345528808.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     b2681e791dbcee6acb1dca7a5076a0285109ac4c
Gitweb:        https://git.kernel.org/tip/b2681e791dbcee6acb1dca7a5076a0285109ac4c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:06 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 18:55:56 +02:00

x86/fpu: Rename and sanitize fpu__save/copy()

Both function names are a misnomer.

fpu__save() is actually about synchronizing the hardware register state
into the task's memory state so that either coredump or a math exception
handler can inspect the state at the time where the problem happens.

The function guarantees to preserve the register state, while "save" is a
common terminology for saving the current state so it can be modified and
restored later. This is clearly not the case here.

Rename it to fpu_sync_fpstate().

fpu__copy() is used to clone the current task's FPU state when duplicating
task_struct. While the register state is a copy the rest of the FPU state
is not.

Name it accordingly and remove the really pointless @src argument along
with the warning which comes along with it.

Nothing can ever copy the FPU state of a non-current task. It's clearly
just a consequence of arch_dup_task_struct(), but it makes no sense to
proliferate that further.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121455.196727450@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h |  6 ++++--
 arch/x86/kernel/fpu/core.c          | 17 ++++++++---------
 arch/x86/kernel/fpu/regset.c        |  2 +-
 arch/x86/kernel/process.c           |  3 +--
 arch/x86/kernel/traps.c             |  5 +++--
 5 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 3558cd0..f5da2e9 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -26,14 +26,16 @@
 /*
  * High level FPU state handling functions:
  */
-extern void fpu__save(struct fpu *fpu);
 extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
 extern void fpu__drop(struct fpu *fpu);
-extern int  fpu__copy(struct task_struct *dst, struct task_struct *src);
 extern void fpu__clear_user_states(struct fpu *fpu);
 extern void fpu__clear_all(struct fpu *fpu);
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 
+extern void fpu_sync_fpstate(struct fpu *fpu);
+
+extern int  fpu_clone(struct task_struct *dst);
+
 /*
  * Boot time FPU initialization functions:
  */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 4a59e0f..8762b1a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -159,11 +159,10 @@ void kernel_fpu_end(void)
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
 
 /*
- * Save the FPU state (mark it for reload if necessary):
- *
- * This only ever gets called for the current task.
+ * Sync the FPU register state to current's memory register state when the
+ * current task owns the FPU. The hardware register state is preserved.
  */
-void fpu__save(struct fpu *fpu)
+void fpu_sync_fpstate(struct fpu *fpu)
 {
 	WARN_ON_FPU(fpu != &current->thread.fpu);
 
@@ -221,18 +220,18 @@ void fpstate_init(union fpregs_state *state)
 }
 EXPORT_SYMBOL_GPL(fpstate_init);
 
-int fpu__copy(struct task_struct *dst, struct task_struct *src)
+/* Clone current's FPU state on fork */
+int fpu_clone(struct task_struct *dst)
 {
+	struct fpu *src_fpu = &current->thread.fpu;
 	struct fpu *dst_fpu = &dst->thread.fpu;
-	struct fpu *src_fpu = &src->thread.fpu;
 
+	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
 
-	if (!static_cpu_has(X86_FEATURE_FPU))
+	if (!cpu_feature_enabled(X86_FEATURE_FPU))
 		return 0;
 
-	WARN_ON_FPU(src_fpu != &current->thread.fpu);
-
 	/*
 	 * Don't let 'init optimized' areas of the XSAVE area
 	 * leak into the child task:
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 892aec1..4575796 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -41,7 +41,7 @@ int regset_xregset_fpregs_active(struct task_struct *target, const struct user_r
 static void sync_fpstate(struct fpu *fpu)
 {
 	if (fpu == &current->thread.fpu)
-		fpu__save(fpu);
+		fpu_sync_fpstate(fpu);
 }
 
 /*
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5e1f381..af3db53 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -87,8 +87,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;
 #endif
-
-	return fpu__copy(dst, src);
+	return fpu_clone(dst);
 }
 
 /*
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 853ea7a..4c9c4aa 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1046,9 +1046,10 @@ static void math_error(struct pt_regs *regs, int trapnr)
 	}
 
 	/*
-	 * Save the info for the exception handler and clear the error.
+	 * Synchronize the FPU register state to the memory register state
+	 * if necessary. This allows the exception handler to inspect it.
 	 */
-	fpu__save(fpu);
+	fpu_sync_fpstate(fpu);
 
 	task->thread.trap_nr	= trapnr;
 	task->thread.error_code = 0;
