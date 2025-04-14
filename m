Return-Path: <linux-tip-commits+bounces-4963-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79103A878E2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 09:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131263AE2DA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 07:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1350E25D212;
	Mon, 14 Apr 2025 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ux6Dv3J0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zm6rBZs7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA4325A325;
	Mon, 14 Apr 2025 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616095; cv=none; b=mhBnFnVP7DNMaNTC45Wy612AM3Ezn3xgSknDt22v5zGNlMWe/zjKMdizsMyJVctbIsyWqPoe4maXoi13hALLojue1y1PSEbjoBTlNz8GKx0AiyZGssHW+9Rlpr5RzQXkaJQjpaSoUrs2VWdEsF87siH33x1iANVn2er/QiZ7N8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616095; c=relaxed/simple;
	bh=Wwb8wiCjUXRoS51n1YW5fSADqddEq5BZ7DBFTfFgYUo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OxrpnDp+yvZWN7MovonvsmEKxfCuqwxJyBxfKz+BdEkpERitzLeM2U5dFNL4pIww9cJmhGFW0pJNMLeMeBpw2O8aPKUi+ZdBan9RuCvtatFXmPNfbU5oGJz3/D4suBSZlF1h8vvsTTwXGsPr6OpOz1D76FUFubCdxxBV4Gev1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ux6Dv3J0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zm6rBZs7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 07:34:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744616090;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKHKhDxFpOhaggY6U0fzTMlqE8tX7xaxLL1lesGeFuc=;
	b=ux6Dv3J0KnCN3ql9l6XWroOGA091vbxsazJTHW1y0fZ2kANSlPZsXt0bw6QNKw9DYQXHTn
	mljpsMIHb8vROU81d5nWtbHBuMZKcxkiPIQfn/B261STD27byn8LZAYzfCfC3sSGK0tbpN
	sqKugmo0SwB7JtuOF4HUs0WVTPwR9BNxm4rqoKFywZvxiYGd7GCKzArY/8nAweMsS4D3qY
	qEBDPCxVgqbutECMFV6XYJLGq+U/8ei4bcp5iSTsQ8zWtFOl5rihNXX6yxPkzVO2aRmTGt
	tTSjnNBoOi/nazshTlsnAKD6jhNgF3Uoz6JN+S0xgzdXrWLpErn/yIdTCVfmEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744616090;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKHKhDxFpOhaggY6U0fzTMlqE8tX7xaxLL1lesGeFuc=;
	b=Zm6rBZs76tFbKF6iTUJmLfRFvSNaFR1H0l9blvzppUTIf2zZ7DGpNEnLXIt7wIKy6CXbD1
	jJmmO9XQeOGdyOCg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/fpu: Convert task_struct::thread.fpu accesses to
 use x86_task_fpu()
Cc: Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, "Chang S. Bae" <chang.seok.bae@intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250409211127.3544993-3-mingo@kernel.org>
References: <20250409211127.3544993-3-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174461608992.31282.16936623661859912269.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     e3bfa3859936da3edd1e16d0b74fdaaa19bb5087
Gitweb:        https://git.kernel.org/tip/e3bfa3859936da3edd1e16d0b74fdaaa19bb5087
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 23:11:21 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 08:18:29 +02:00

x86/fpu: Convert task_struct::thread.fpu accesses to use x86_task_fpu()

This will make the removal of the task_struct::thread.fpu array
easier.

No change in functionality - code generated before and after this
commit is identical on x86-defconfig:

  kepler:~/tip> diff -up vmlinux.before.asm vmlinux.after.asm
  kepler:~/tip>

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250409211127.3544993-3-mingo@kernel.org
---
 arch/x86/include/asm/fpu/sched.h |  2 +-
 arch/x86/kernel/fpu/context.h    |  4 ++--
 arch/x86/kernel/fpu/core.c       | 30 +++++++++++++++---------------
 arch/x86/kernel/fpu/init.c       |  8 ++++----
 arch/x86/kernel/fpu/regset.c     | 22 +++++++++++-----------
 arch/x86/kernel/fpu/signal.c     | 18 +++++++++---------
 arch/x86/kernel/fpu/xstate.c     | 22 +++++++++++-----------
 arch/x86/kernel/fpu/xstate.h     |  6 +++---
 arch/x86/kernel/process.c        |  6 +++---
 arch/x86/kernel/signal.c         |  6 +++---
 arch/x86/kernel/traps.c          |  2 +-
 arch/x86/math-emu/fpu_aux.c      |  2 +-
 arch/x86/math-emu/fpu_entry.c    |  4 ++--
 arch/x86/math-emu/fpu_system.h   |  2 +-
 arch/x86/mm/extable.c            |  2 +-
 15 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index c485f19..1feaa68 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -41,7 +41,7 @@ static inline void switch_fpu_prepare(struct task_struct *old, int cpu)
 {
 	if (cpu_feature_enabled(X86_FEATURE_FPU) &&
 	    !(old->flags & (PF_KTHREAD | PF_USER_WORKER))) {
-		struct fpu *old_fpu = &old->thread.fpu;
+		struct fpu *old_fpu = x86_task_fpu(old);
 
 		save_fpregs_to_fpstate(old_fpu);
 		/*
diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
index f6d856b..10d0a72 100644
--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/kernel/fpu/context.h
@@ -53,7 +53,7 @@ static inline void fpregs_activate(struct fpu *fpu)
 /* Internal helper for switch_fpu_return() and signal frame setup */
 static inline void fpregs_restore_userregs(void)
 {
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 	int cpu = smp_processor_id();
 
 	if (WARN_ON_ONCE(current->flags & (PF_KTHREAD | PF_USER_WORKER)))
@@ -67,7 +67,7 @@ static inline void fpregs_restore_userregs(void)
 		 * If PKRU is enabled, then the PKRU value is already
 		 * correct because it was either set in switch_to() or in
 		 * flush_thread(). So it is excluded because it might be
-		 * not up to date in current->thread.fpu.xsave state.
+		 * not up to date in current->thread.fpu->xsave state.
 		 *
 		 * XFD state is handled in restore_fpregs_from_fpstate().
 		 */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 91d6341..dc6d7f9 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -211,7 +211,7 @@ static void fpu_init_guest_permissions(struct fpu_guest *gfpu)
 		return;
 
 	spin_lock_irq(&current->sighand->siglock);
-	fpuperm = &current->group_leader->thread.fpu.guest_perm;
+	fpuperm = &x86_task_fpu(current->group_leader)->guest_perm;
 	perm = fpuperm->__state_perm;
 
 	/* First fpstate allocation locks down permissions. */
@@ -323,7 +323,7 @@ EXPORT_SYMBOL_GPL(fpu_update_guest_xfd);
  */
 void fpu_sync_guest_vmexit_xfd_state(void)
 {
-	struct fpstate *fps = current->thread.fpu.fpstate;
+	struct fpstate *fps = x86_task_fpu(current)->fpstate;
 
 	lockdep_assert_irqs_disabled();
 	if (fpu_state_size_dynamic()) {
@@ -337,7 +337,7 @@ EXPORT_SYMBOL_GPL(fpu_sync_guest_vmexit_xfd_state);
 int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
 {
 	struct fpstate *guest_fps = guest_fpu->fpstate;
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 	struct fpstate *cur_fps = fpu->fpstate;
 
 	fpregs_lock();
@@ -438,7 +438,7 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
 	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		set_thread_flag(TIF_NEED_FPU_LOAD);
-		save_fpregs_to_fpstate(&current->thread.fpu);
+		save_fpregs_to_fpstate(x86_task_fpu(current));
 	}
 	__cpu_invalidate_fpregs_state();
 
@@ -467,7 +467,7 @@ EXPORT_SYMBOL_GPL(kernel_fpu_end);
  */
 void fpu_sync_fpstate(struct fpu *fpu)
 {
-	WARN_ON_FPU(fpu != &current->thread.fpu);
+	WARN_ON_FPU(fpu != x86_task_fpu(current));
 
 	fpregs_lock();
 	trace_x86_fpu_before_save(fpu);
@@ -552,7 +552,7 @@ void fpstate_reset(struct fpu *fpu)
 static inline void fpu_inherit_perms(struct fpu *dst_fpu)
 {
 	if (fpu_state_size_dynamic()) {
-		struct fpu *src_fpu = &current->group_leader->thread.fpu;
+		struct fpu *src_fpu = x86_task_fpu(current->group_leader);
 
 		spin_lock_irq(&current->sighand->siglock);
 		/* Fork also inherits the permissions of the parent */
@@ -572,7 +572,7 @@ static int update_fpu_shstk(struct task_struct *dst, unsigned long ssp)
 	if (!ssp)
 		return 0;
 
-	xstate = get_xsave_addr(&dst->thread.fpu.fpstate->regs.xsave,
+	xstate = get_xsave_addr(&x86_task_fpu(dst)->fpstate->regs.xsave,
 				XFEATURE_CET_USER);
 
 	/*
@@ -593,8 +593,8 @@ static int update_fpu_shstk(struct task_struct *dst, unsigned long ssp)
 int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	      unsigned long ssp)
 {
-	struct fpu *src_fpu = &current->thread.fpu;
-	struct fpu *dst_fpu = &dst->thread.fpu;
+	struct fpu *src_fpu = x86_task_fpu(current);
+	struct fpu *dst_fpu = x86_task_fpu(dst);
 
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
@@ -686,7 +686,7 @@ void fpu__drop(struct fpu *fpu)
 {
 	preempt_disable();
 
-	if (fpu == &current->thread.fpu) {
+	if (fpu == x86_task_fpu(current)) {
 		/* Ignore delayed exceptions from user space */
 		asm volatile("1: fwait\n"
 			     "2:\n"
@@ -720,7 +720,7 @@ static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
  */
 static void fpu_reset_fpregs(void)
 {
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 
 	fpregs_lock();
 	__fpu_invalidate_fpregs_state(fpu);
@@ -749,7 +749,7 @@ static void fpu_reset_fpregs(void)
  */
 void fpu__clear_user_states(struct fpu *fpu)
 {
-	WARN_ON_FPU(fpu != &current->thread.fpu);
+	WARN_ON_FPU(fpu != x86_task_fpu(current));
 
 	fpregs_lock();
 	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
@@ -782,7 +782,7 @@ void fpu__clear_user_states(struct fpu *fpu)
 
 void fpu_flush_thread(void)
 {
-	fpstate_reset(&current->thread.fpu);
+	fpstate_reset(x86_task_fpu(current));
 	fpu_reset_fpregs();
 }
 /*
@@ -823,7 +823,7 @@ void fpregs_lock_and_load(void)
  */
 void fpregs_assert_state_consistent(void)
 {
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
 		return;
@@ -835,7 +835,7 @@ EXPORT_SYMBOL_GPL(fpregs_assert_state_consistent);
 
 void fpregs_mark_activate(void)
 {
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 
 	fpregs_activate(fpu);
 	fpu->last_cpu = smp_processor_id();
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 998a08f..ad5cb29 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -38,7 +38,7 @@ static void fpu__init_cpu_generic(void)
 	/* Flush out any pending x87 state: */
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU))
-		fpstate_init_soft(&current->thread.fpu.fpstate->regs.soft);
+		fpstate_init_soft(&x86_task_fpu(current)->fpstate->regs.soft);
 	else
 #endif
 		asm volatile ("fninit");
@@ -154,7 +154,7 @@ static void __init fpu__init_task_struct_size(void)
 	 * Subtract off the static size of the register state.
 	 * It potentially has a bunch of padding.
 	 */
-	task_size -= sizeof(current->thread.fpu.__fpstate.regs);
+	task_size -= sizeof(union fpregs_state);
 
 	/*
 	 * Add back the dynamically-calculated register state
@@ -204,7 +204,7 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	fpu_kernel_cfg.default_size = size;
 	fpu_user_cfg.max_size = size;
 	fpu_user_cfg.default_size = size;
-	fpstate_reset(&current->thread.fpu);
+	fpstate_reset(x86_task_fpu(current));
 }
 
 /*
@@ -213,7 +213,7 @@ static void __init fpu__init_system_xstate_size_legacy(void)
  */
 void __init fpu__init_system(void)
 {
-	fpstate_reset(&current->thread.fpu);
+	fpstate_reset(x86_task_fpu(current));
 	fpu__init_system_early_generic();
 
 	/*
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 887b0b8..0986c22 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -45,7 +45,7 @@ int regset_xregset_fpregs_active(struct task_struct *target, const struct user_r
  */
 static void sync_fpstate(struct fpu *fpu)
 {
-	if (fpu == &current->thread.fpu)
+	if (fpu == x86_task_fpu(current))
 		fpu_sync_fpstate(fpu);
 }
 
@@ -63,7 +63,7 @@ static void fpu_force_restore(struct fpu *fpu)
 	 * Only stopped child tasks can be used to modify the FPU
 	 * state in the fpstate buffer:
 	 */
-	WARN_ON_FPU(fpu == &current->thread.fpu);
+	WARN_ON_FPU(fpu == x86_task_fpu(current));
 
 	__fpu_invalidate_fpregs_state(fpu);
 }
@@ -71,7 +71,7 @@ static void fpu_force_restore(struct fpu *fpu)
 int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf to)
 {
-	struct fpu *fpu = &target->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(target);
 
 	if (!cpu_feature_enabled(X86_FEATURE_FXSR))
 		return -ENODEV;
@@ -91,7 +91,7 @@ int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
 		unsigned int pos, unsigned int count,
 		const void *kbuf, const void __user *ubuf)
 {
-	struct fpu *fpu = &target->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(target);
 	struct fxregs_state newstate;
 	int ret;
 
@@ -133,7 +133,7 @@ int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 	if (!cpu_feature_enabled(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
-	sync_fpstate(&target->thread.fpu);
+	sync_fpstate(x86_task_fpu(target));
 
 	copy_xstate_to_uabi_buf(to, target, XSTATE_COPY_XSAVE);
 	return 0;
@@ -143,7 +143,7 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 		  unsigned int pos, unsigned int count,
 		  const void *kbuf, const void __user *ubuf)
 {
-	struct fpu *fpu = &target->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(target);
 	struct xregs_state *tmpbuf = NULL;
 	int ret;
 
@@ -187,7 +187,7 @@ int ssp_active(struct task_struct *target, const struct user_regset *regset)
 int ssp_get(struct task_struct *target, const struct user_regset *regset,
 	    struct membuf to)
 {
-	struct fpu *fpu = &target->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(target);
 	struct cet_user_state *cetregs;
 
 	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
@@ -214,7 +214,7 @@ int ssp_set(struct task_struct *target, const struct user_regset *regset,
 	    unsigned int pos, unsigned int count,
 	    const void *kbuf, const void __user *ubuf)
 {
-	struct fpu *fpu = &target->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(target);
 	struct xregs_state *xsave = &fpu->fpstate->regs.xsave;
 	struct cet_user_state *cetregs;
 	unsigned long user_ssp;
@@ -368,7 +368,7 @@ static void __convert_from_fxsr(struct user_i387_ia32_struct *env,
 void
 convert_from_fxsr(struct user_i387_ia32_struct *env, struct task_struct *tsk)
 {
-	__convert_from_fxsr(env, tsk, &tsk->thread.fpu.fpstate->regs.fxsave);
+	__convert_from_fxsr(env, tsk, &x86_task_fpu(tsk)->fpstate->regs.fxsave);
 }
 
 void convert_to_fxsr(struct fxregs_state *fxsave,
@@ -401,7 +401,7 @@ void convert_to_fxsr(struct fxregs_state *fxsave,
 int fpregs_get(struct task_struct *target, const struct user_regset *regset,
 	       struct membuf to)
 {
-	struct fpu *fpu = &target->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(target);
 	struct user_i387_ia32_struct env;
 	struct fxregs_state fxsave, *fx;
 
@@ -433,7 +433,7 @@ int fpregs_set(struct task_struct *target, const struct user_regset *regset,
 	       unsigned int pos, unsigned int count,
 	       const void *kbuf, const void __user *ubuf)
 {
-	struct fpu *fpu = &target->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(target);
 	struct user_i387_ia32_struct env;
 	int ret;
 
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 6c69cb2..b8b4fa9 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -43,13 +43,13 @@ static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 	 * fpstate layout with out copying the extended state information
 	 * in the memory layout.
 	 */
-	if (__get_user(magic2, (__u32 __user *)(fpstate + current->thread.fpu.fpstate->user_size)))
+	if (__get_user(magic2, (__u32 __user *)(fpstate + x86_task_fpu(current)->fpstate->user_size)))
 		return false;
 
 	if (likely(magic2 == FP_XSTATE_MAGIC2))
 		return true;
 setfx:
-	trace_x86_fpu_xstate_check_failed(&current->thread.fpu);
+	trace_x86_fpu_xstate_check_failed(x86_task_fpu(current));
 
 	/* Set the parameters for fx only state */
 	fx_sw->magic1 = 0;
@@ -64,13 +64,13 @@ setfx:
 static inline bool save_fsave_header(struct task_struct *tsk, void __user *buf)
 {
 	if (use_fxsr()) {
-		struct xregs_state *xsave = &tsk->thread.fpu.fpstate->regs.xsave;
+		struct xregs_state *xsave = &x86_task_fpu(tsk)->fpstate->regs.xsave;
 		struct user_i387_ia32_struct env;
 		struct _fpstate_32 __user *fp = buf;
 
 		fpregs_lock();
 		if (!test_thread_flag(TIF_NEED_FPU_LOAD))
-			fxsave(&tsk->thread.fpu.fpstate->regs.fxsave);
+			fxsave(&x86_task_fpu(tsk)->fpstate->regs.fxsave);
 		fpregs_unlock();
 
 		convert_from_fxsr(&env, tsk);
@@ -184,7 +184,7 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf, u32 pk
 bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size, u32 pkru)
 {
 	struct task_struct *tsk = current;
-	struct fpstate *fpstate = tsk->thread.fpu.fpstate;
+	struct fpstate *fpstate = x86_task_fpu(tsk)->fpstate;
 	bool ia32_fxstate = (buf != buf_fx);
 	int ret;
 
@@ -272,7 +272,7 @@ static int __restore_fpregs_from_user(void __user *buf, u64 ufeatures,
  */
 static bool restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
 {
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 	int ret;
 
 	/* Restore enabled features only. */
@@ -332,7 +332,7 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 			      bool ia32_fxstate)
 {
 	struct task_struct *tsk = current;
-	struct fpu *fpu = &tsk->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(tsk);
 	struct user_i387_ia32_struct env;
 	bool success, fx_only = false;
 	union fpregs_state *fpregs;
@@ -452,7 +452,7 @@ static inline unsigned int xstate_sigframe_size(struct fpstate *fpstate)
  */
 bool fpu__restore_sig(void __user *buf, int ia32_frame)
 {
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 	void __user *buf_fx = buf;
 	bool ia32_fxstate = false;
 	bool success = false;
@@ -499,7 +499,7 @@ unsigned long
 fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 		     unsigned long *buf_fx, unsigned long *size)
 {
-	unsigned long frame_size = xstate_sigframe_size(current->thread.fpu.fpstate);
+	unsigned long frame_size = xstate_sigframe_size(x86_task_fpu(current)->fpstate);
 
 	*buf_fx = sp = round_down(sp - frame_size, 64);
 	if (ia32_frame && use_fxsr()) {
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 46c45e2..253da5a 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -763,7 +763,7 @@ static void __init fpu__init_disable_system_xstate(unsigned int legacy_size)
 	 */
 	init_fpstate.xfd = 0;
 
-	fpstate_reset(&current->thread.fpu);
+	fpstate_reset(x86_task_fpu(current));
 }
 
 /*
@@ -871,7 +871,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		goto out_disable;
 
 	/* Reset the state for the current task */
-	fpstate_reset(&current->thread.fpu);
+	fpstate_reset(x86_task_fpu(current));
 
 	/*
 	 * Update info used for ptrace frames; use standard-format size and no
@@ -945,7 +945,7 @@ void fpu__resume_cpu(void)
 	}
 
 	if (fpu_state_size_dynamic())
-		wrmsrl(MSR_IA32_XFD, current->thread.fpu.fpstate->xfd);
+		wrmsrl(MSR_IA32_XFD, x86_task_fpu(current)->fpstate->xfd);
 }
 
 /*
@@ -1227,8 +1227,8 @@ out:
 void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 			     enum xstate_copy_mode copy_mode)
 {
-	__copy_xstate_to_uabi_buf(to, tsk->thread.fpu.fpstate,
-				  tsk->thread.fpu.fpstate->user_xfeatures,
+	__copy_xstate_to_uabi_buf(to, x86_task_fpu(tsk)->fpstate,
+				  x86_task_fpu(tsk)->fpstate->user_xfeatures,
 				  tsk->thread.pkru, copy_mode);
 }
 
@@ -1368,7 +1368,7 @@ int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf, u
 int copy_sigframe_from_user_to_xstate(struct task_struct *tsk,
 				      const void __user *ubuf)
 {
-	return copy_uabi_to_xstate(tsk->thread.fpu.fpstate, NULL, ubuf, &tsk->thread.pkru);
+	return copy_uabi_to_xstate(x86_task_fpu(tsk)->fpstate, NULL, ubuf, &tsk->thread.pkru);
 }
 
 static bool validate_independent_components(u64 mask)
@@ -1462,7 +1462,7 @@ static bool xstate_op_valid(struct fpstate *fpstate, u64 mask, bool rstor)
 	  * The XFD MSR does not match fpstate->xfd. That's invalid when
 	  * the passed in fpstate is current's fpstate.
 	  */
-	if (fpstate->xfd == current->thread.fpu.fpstate->xfd)
+	if (fpstate->xfd == x86_task_fpu(current)->fpstate->xfd)
 		return false;
 
 	/*
@@ -1539,7 +1539,7 @@ void fpstate_free(struct fpu *fpu)
 static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
 			   unsigned int usize, struct fpu_guest *guest_fpu)
 {
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 	struct fpstate *curfps, *newfps = NULL;
 	unsigned int fpsize;
 	bool in_use;
@@ -1632,7 +1632,7 @@ static int __xstate_request_perm(u64 permitted, u64 requested, bool guest)
 	 * AVX512.
 	 */
 	bool compacted = cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
-	struct fpu *fpu = &current->group_leader->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current->group_leader);
 	struct fpu_state_perm *perm;
 	unsigned int ksize, usize;
 	u64 mask;
@@ -1735,7 +1735,7 @@ int __xfd_enable_feature(u64 xfd_err, struct fpu_guest *guest_fpu)
 		return -EPERM;
 	}
 
-	fpu = &current->group_leader->thread.fpu;
+	fpu = x86_task_fpu(current->group_leader);
 	perm = guest_fpu ? &fpu->guest_perm : &fpu->perm;
 	ksize = perm->__state_size;
 	usize = perm->__user_state_size;
@@ -1840,7 +1840,7 @@ long fpu_xstate_prctl(int option, unsigned long arg2)
  */
 static void avx512_status(struct seq_file *m, struct task_struct *task)
 {
-	unsigned long timestamp = READ_ONCE(task->thread.fpu.avx512_timestamp);
+	unsigned long timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
 	long delta;
 
 	if (!timestamp) {
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 0fd34f5..9a3a8cc 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -22,7 +22,7 @@ static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
 
 static inline u64 xstate_get_group_perm(bool guest)
 {
-	struct fpu *fpu = &current->group_leader->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current->group_leader);
 	struct fpu_state_perm *perm;
 
 	/* Pairs with WRITE_ONCE() in xstate_request_perm() */
@@ -288,7 +288,7 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf, u32 pkr
 	 * internally, e.g. PKRU. That's user space ABI and also required
 	 * to allow the signal handler to modify PKRU.
 	 */
-	struct fpstate *fpstate = current->thread.fpu.fpstate;
+	struct fpstate *fpstate = x86_task_fpu(current)->fpstate;
 	u64 mask = fpstate->user_xfeatures;
 	u32 lmask;
 	u32 hmask;
@@ -322,7 +322,7 @@ static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64 
 	u32 hmask = mask >> 32;
 	int err;
 
-	xfd_validate_state(current->thread.fpu.fpstate, mask, true);
+	xfd_validate_state(x86_task_fpu(current)->fpstate, mask, true);
 
 	stac();
 	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 962c3ce..47694e3 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -103,7 +103,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	dst->thread.vm86 = NULL;
 #endif
 	/* Drop the copied pointer to current's fpstate */
-	dst->thread.fpu.fpstate = NULL;
+	x86_task_fpu(dst)->fpstate = NULL;
 
 	return 0;
 }
@@ -112,7 +112,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 void arch_release_task_struct(struct task_struct *tsk)
 {
 	if (fpu_state_size_dynamic())
-		fpstate_free(&tsk->thread.fpu);
+		fpstate_free(x86_task_fpu(tsk));
 }
 #endif
 
@@ -122,7 +122,7 @@ void arch_release_task_struct(struct task_struct *tsk)
 void exit_thread(struct task_struct *tsk)
 {
 	struct thread_struct *t = &tsk->thread;
-	struct fpu *fpu = &t->fpu;
+	struct fpu *fpu = x86_task_fpu(tsk);
 
 	if (test_thread_flag(TIF_IO_BITMAP))
 		io_bitmap_exit(tsk);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 5f44103..2404233 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -255,7 +255,7 @@ static void
 handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	bool stepping, failed;
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(current);
 
 	if (v8086_mode(regs))
 		save_v86_state((struct kernel_vm86_regs *) regs, VM86_SIGNAL);
@@ -423,14 +423,14 @@ bool sigaltstack_size_valid(size_t ss_size)
 	if (!fpu_state_size_dynamic() && !strict_sigaltstack_size)
 		return true;
 
-	fsize += current->group_leader->thread.fpu.perm.__user_state_size;
+	fsize += x86_task_fpu(current->group_leader)->perm.__user_state_size;
 	if (likely(ss_size > fsize))
 		return true;
 
 	if (strict_sigaltstack_size)
 		return ss_size > fsize;
 
-	mask = current->group_leader->thread.fpu.perm.__state_perm;
+	mask = x86_task_fpu(current->group_leader)->perm.__state_perm;
 	if (mask & XFEATURE_MASK_USER_DYNAMIC)
 		return ss_size > fsize;
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9f88b8a..f48325d 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1295,7 +1295,7 @@ DEFINE_IDTENTRY_RAW(exc_debug)
 static void math_error(struct pt_regs *regs, int trapnr)
 {
 	struct task_struct *task = current;
-	struct fpu *fpu = &task->thread.fpu;
+	struct fpu *fpu = x86_task_fpu(task);
 	int si_code;
 	char *str = (trapnr == X86_TRAP_MF) ? "fpu exception" :
 						"simd exception";
diff --git a/arch/x86/math-emu/fpu_aux.c b/arch/x86/math-emu/fpu_aux.c
index d62662b..5f253ae 100644
--- a/arch/x86/math-emu/fpu_aux.c
+++ b/arch/x86/math-emu/fpu_aux.c
@@ -53,7 +53,7 @@ void fpstate_init_soft(struct swregs_state *soft)
 
 void finit(void)
 {
-	fpstate_init_soft(&current->thread.fpu.fpstate->regs.soft);
+	fpstate_init_soft(&x86_task_fpu(current)->fpstate->regs.soft);
 }
 
 /*
diff --git a/arch/x86/math-emu/fpu_entry.c b/arch/x86/math-emu/fpu_entry.c
index 91c52ea..5034df6 100644
--- a/arch/x86/math-emu/fpu_entry.c
+++ b/arch/x86/math-emu/fpu_entry.c
@@ -641,7 +641,7 @@ int fpregs_soft_set(struct task_struct *target,
 		    unsigned int pos, unsigned int count,
 		    const void *kbuf, const void __user *ubuf)
 {
-	struct swregs_state *s387 = &target->thread.fpu.fpstate->regs.soft;
+	struct swregs_state *s387 = &x86_task_fpu(target)->fpstate->regs.soft;
 	void *space = s387->st_space;
 	int ret;
 	int offset, other, i, tags, regnr, tag, newtop;
@@ -692,7 +692,7 @@ int fpregs_soft_get(struct task_struct *target,
 		    const struct user_regset *regset,
 		    struct membuf to)
 {
-	struct swregs_state *s387 = &target->thread.fpu.fpstate->regs.soft;
+	struct swregs_state *s387 = &x86_task_fpu(target)->fpstate->regs.soft;
 	const void *space = s387->st_space;
 	int offset = (S387->ftop & 7) * 10, other = 80 - offset;
 
diff --git a/arch/x86/math-emu/fpu_system.h b/arch/x86/math-emu/fpu_system.h
index eec3e48..5e238e9 100644
--- a/arch/x86/math-emu/fpu_system.h
+++ b/arch/x86/math-emu/fpu_system.h
@@ -73,7 +73,7 @@ static inline bool seg_writable(struct desc_struct *d)
 	return (d->type & SEG_TYPE_EXECUTE_MASK) == SEG_TYPE_WRITABLE;
 }
 
-#define I387			(&current->thread.fpu.fpstate->regs)
+#define I387			(&x86_task_fpu(current)->fpstate->regs)
 #define FPU_info		(I387->soft.info)
 
 #define FPU_CS			(*(unsigned short *) &(FPU_info->regs->cs))
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 51986e8..bf8dab1 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -111,7 +111,7 @@ static bool ex_handler_sgx(const struct exception_table_entry *fixup,
 
 /*
  * Handler for when we fail to restore a task's FPU state.  We should never get
- * here because the FPU state of a task using the FPU (task->thread.fpu.state)
+ * here because the FPU state of a task using the FPU (struct fpu::fpstate)
  * should always be valid.  However, past bugs have allowed userspace to set
  * reserved bits in the XSAVE area using PTRACE_SETREGSET or sys_rt_sigreturn().
  * These caused XRSTOR to fail when switching to the task, leaking the FPU

