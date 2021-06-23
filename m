Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570DC3B2308
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhFWWLo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40012 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhFWWL0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:26 -0400
Date:   Wed, 23 Jun 2021 22:09:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486147;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+DcehFnEhOmw2XdJy1+4tlmLp/foipARH4S2dnSD2aY=;
        b=UnbrIdav6Ie2q/r+teC+Mw62nTiYs85+H59fzD9Lwi4Xc4F51HcpbIRsxbUz/FiYVKsTIM
        gC75VnZDMWcTgsQF7Uvjf4CFjCuA89c5+pGnMS/0gT0NVvJ+3ifV8Ycv3Dks7OUEb3qvNp
        r5mojzRBbQhwtJtKKu6HgLMO3Ta7kJGD/V7Dpc++dUlaY1BX1evG6mWPqnzAVe5FKmc6m5
        aRSWato3oEh3wrNEF4esxktbpGvBtCy/XAclBebitCiMPdGhJZ9qlFO87G7z5GckIObsQg
        5MrXQZAALF79JGQ1Fk8Bb3evfKzIVHo5j6RqGuK6qPio2RCBqOLF+o43QSxtgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486147;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+DcehFnEhOmw2XdJy1+4tlmLp/foipARH4S2dnSD2aY=;
        b=xadID12prKIRipEbfPMMgxgBC1GS2ch+CegH52CwMVyyE3VL6rj8dyv/aYwfQ18wt2uHwD
        FgZpjXEwqwKf58Dw==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Clean up the fpu__clear() variants
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121455.922729522@linutronix.de>
References: <20210623121455.922729522@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448614600.395.8923389802793002837.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     33344368cb08f8d6bf55a32aa052318d3a69ea84
Gitweb:        https://git.kernel.org/tip/33344368cb08f8d6bf55a32aa052318d3a69ea84
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 23 Jun 2021 14:02:13 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:23:07 +02:00

x86/fpu: Clean up the fpu__clear() variants

fpu__clear() currently resets both register state and kernel XSAVE buffer
state.  It has two modes: one for all state (supervisor and user) and
another for user state only.  fpu__clear_all() uses the "all state"
(user_only=0) mode, while a number of signal paths use the user_only=1
mode.

Make fpu__clear() work only for user state (user_only=1) and remove the
"all state" (user_only=0) code.  Rename it to match so it can be used by
the signal paths.

Replace the "all state" (user_only=0) fpu__clear() functionality.  Use the
TIF_NEED_FPU_LOAD functionality instead of making any actual hardware
registers changes in this path.

Instead of invoking fpu__initialize() just memcpy() init_fpstate into the
task's FPU state because that has already the correct format and in case of
PKRU also contains the default PKRU value. Move the actual PKRU write out
into flush_thread() where it belongs and where it will end up anyway when
PKRU and XSTATE have been untangled.

For bisectability a workaround is required which stores the PKRU value in
the xstate memory until PKRU is untangled from XSTATE for context
switching and return to user.

[ Dave Hansen: Polished changelog ]
[ tglx: Fixed the PKRU fallout ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121455.922729522@linutronix.de
---
 arch/x86/kernel/fpu/core.c | 113 ++++++++++++++++++++++++------------
 arch/x86/kernel/process.c  |  10 +++-
 2 files changed, 86 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 4b69be9..aa7e808 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -260,19 +260,6 @@ int fpu_clone(struct task_struct *dst)
 }
 
 /*
- * Activate the current task's in-memory FPU context,
- * if it has not been used before:
- */
-static void fpu__initialize(struct fpu *fpu)
-{
-	WARN_ON_FPU(fpu != &current->thread.fpu);
-
-	set_thread_flag(TIF_NEED_FPU_LOAD);
-	fpstate_init(&fpu->state);
-	trace_x86_fpu_init_state(fpu);
-}
-
-/*
  * Drops current FPU state: deactivates the fpregs and
  * the fpstate. NOTE: it still leaves previous contents
  * in the fpregs in the eager-FPU case.
@@ -314,47 +301,99 @@ static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
 	pkru_write_default();
 }
 
+static inline unsigned int init_fpstate_copy_size(void)
+{
+	if (!use_xsave())
+		return fpu_kernel_xstate_size;
+
+	/* XSAVE(S) just needs the legacy and the xstate header part */
+	return sizeof(init_fpstate.xsave);
+}
+
+/* Temporary workaround. Will be removed once PKRU and XSTATE are untangled. */
+static inline void pkru_set_default_in_xstate(struct xregs_state *xsave)
+{
+	struct pkru_state *pk;
+
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return;
+	/*
+	 * Force XFEATURE_PKRU to be set in the header otherwise
+	 * get_xsave_addr() does not work and it also needs to be set to
+	 * make XRSTOR(S) load it.
+	 */
+	xsave->header.xfeatures |= XFEATURE_MASK_PKRU;
+	pk = get_xsave_addr(xsave, XFEATURE_PKRU);
+	pk->pkru = pkru_get_init_value();
+}
+
 /*
- * Clear the FPU state back to init state.
- *
- * Called by sys_execve(), by the signal handler code and by various
- * error paths.
+ * Reset current->fpu memory state to the init values.
+ */
+static void fpu_reset_fpstate(void)
+{
+	struct fpu *fpu = &current->thread.fpu;
+
+	fpregs_lock();
+	fpu__drop(fpu);
+	/*
+	 * This does not change the actual hardware registers. It just
+	 * resets the memory image and sets TIF_NEED_FPU_LOAD so a
+	 * subsequent return to usermode will reload the registers from the
+	 * task's memory image.
+	 *
+	 * Do not use fpstate_init() here. Just copy init_fpstate which has
+	 * the correct content already except for PKRU.
+	 */
+	memcpy(&fpu->state, &init_fpstate, init_fpstate_copy_size());
+	pkru_set_default_in_xstate(&fpu->state.xsave);
+	set_thread_flag(TIF_NEED_FPU_LOAD);
+	fpregs_unlock();
+}
+
+/*
+ * Reset current's user FPU states to the init states.  current's
+ * supervisor states, if any, are not modified by this function.  The
+ * caller guarantees that the XSTATE header in memory is intact.
  */
-static void fpu__clear(struct fpu *fpu, bool user_only)
+void fpu__clear_user_states(struct fpu *fpu)
 {
 	WARN_ON_FPU(fpu != &current->thread.fpu);
 
-	if (!static_cpu_has(X86_FEATURE_FPU)) {
-		fpu__drop(fpu);
-		fpu__initialize(fpu);
+	fpregs_lock();
+	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
+		fpu_reset_fpstate();
+		fpregs_unlock();
 		return;
 	}
 
-	fpregs_lock();
-
-	if (user_only) {
-		if (!fpregs_state_valid(fpu, smp_processor_id()) &&
-		    xfeatures_mask_supervisor())
-			os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
-		restore_fpregs_from_init_fpstate(xfeatures_mask_user());
-	} else {
-		restore_fpregs_from_init_fpstate(xfeatures_mask_all);
+	/*
+	 * Ensure that current's supervisor states are loaded into their
+	 * corresponding registers.
+	 */
+	if (xfeatures_mask_supervisor() &&
+	    !fpregs_state_valid(fpu, smp_processor_id())) {
+		os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
 	}
 
+	/* Reset user states in registers. */
+	restore_fpregs_from_init_fpstate(xfeatures_mask_user());
+
+	/*
+	 * Now all FPU registers have their desired values.  Inform the FPU
+	 * state machine that current's FPU registers are in the hardware
+	 * registers. The memory image does not need to be updated because
+	 * any operation relying on it has to save the registers first when
+	 * current's FPU is marked active.
+	 */
 	fpregs_mark_activate();
 	fpregs_unlock();
 }
 
-void fpu__clear_user_states(struct fpu *fpu)
-{
-	fpu__clear(fpu, true);
-}
-
 void fpu_flush_thread(void)
 {
-	fpu__clear(&current->thread.fpu, false);
+	fpu_reset_fpstate();
 }
-
 /*
  * Load FPU context before returning to userspace.
  */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 19d05d3..de942b0 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -198,6 +198,15 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	return ret;
 }
 
+static void pkru_flush_thread(void)
+{
+	/*
+	 * If PKRU is enabled the default PKRU value has to be loaded into
+	 * the hardware right here (similar to context switch).
+	 */
+	pkru_write_default();
+}
+
 void flush_thread(void)
 {
 	struct task_struct *tsk = current;
@@ -206,6 +215,7 @@ void flush_thread(void)
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
 
 	fpu_flush_thread();
+	pkru_flush_thread();
 }
 
 void disable_TSC(void)
