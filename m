Return-Path: <linux-tip-commits+bounces-5218-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49810AA84EB
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 10:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8749F3B9B32
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 08:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00441A23A0;
	Sun,  4 May 2025 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="piWAd84N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lJwlpJOg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A214D19CC3D;
	Sun,  4 May 2025 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746348871; cv=none; b=EYFnIXmiGfNqryhjDcOe4+CjC3PL9aN7SRpJqEMBNkVztc1tnQYHtFcSSSUE7msxa/3yGpiWUy40mI3J3fHz3nb4FiTIO6c58VYqQr6YtHiTwMi2HgxHAer8hNdo88qvJuw417x6x7BwIYx7fJG8pIS/ONk0kdUrwFYvsIzk2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746348871; c=relaxed/simple;
	bh=tSD7WzwfBsV0meUK9lW7e9C09OnQwW/tyhfmZJ51j2g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l81ZTwqN1oWzesUdTO2HNHeXY8cFXIamNG+GE6EBpNrRoIjDOjwJGVlbI9ybtrfLqbUpxJfBeJBIy8tsOFjE3Md2Ed15Mt6zZ4GzGsec7wMsNc4jlVBdgrZXdnLmE66SXr2n8mGFNII/N/RZ7GFj6+ycV19/aND6bC9G5w0mA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=piWAd84N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lJwlpJOg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 04 May 2025 08:54:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746348866;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhkTzVJcKZV8kOlhfsP0TZVlqQEhTQf5uAoV3Zx0HMQ=;
	b=piWAd84NP/qakHPOw4zjPZRoaaYDMbrRalOCKEnR95NUzz4ZT/bsoA+uQ8ZjB5+42gZqei
	BMVPljnMg55/fioyznhrN7eXTVnRJw3q5oDHkO02WXyp+WnJJWM4N3XF8Kaj0P/6ga+0vU
	hjQWvPJxUwJV9CytZtOTRZUekz6D2JwPekNz8P9StruWeQDwIKOz2NAjTY+GmmvH9f1xw8
	+VPOFb2T236iXkcQ3inTpbZ54iLownn6tPcntyVM8Wo89eG9ixp1e97SmTCinoumD97dDQ
	yFRhNt6yIqAOpnScL1N6Pp48CUbyo8DgTfnDLRt3qe5FULtqSKJloneLfnLnWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746348866;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhkTzVJcKZV8kOlhfsP0TZVlqQEhTQf5uAoV3Zx0HMQ=;
	b=lJwlpJOglwrjgOXXb9bmMlxwdYlHdWBFI4sAbnW0EMd95tScQrfGgxPnY9uBF37+cD7Zl4
	fGjd6oeO74DoCMCg==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Simplify the switch_fpu_prepare() +
 switch_fpu_finish() logic
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 "Chang S . Bae" <chang.seok.bae@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@amacapital.net>, Brian Gerst <brgerst@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250503143830.GA8982@redhat.com>
References: <20250503143830.GA8982@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174634886598.22196.692097907854010890.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     730faa15a069f4025a0f8c2a5244c3067da7ecbe
Gitweb:        https://git.kernel.org/tip/730faa15a069f4025a0f8c2a5244c3067da7ecbe
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sat, 03 May 2025 16:38:30 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 04 May 2025 10:29:24 +02:00

x86/fpu: Simplify the switch_fpu_prepare() + switch_fpu_finish() logic

Now that switch_fpu_finish() doesn't load the FPU state, it makes more
sense to fold it into switch_fpu_prepare() renamed to switch_fpu(), and
more importantly, use the "prev_p" task as a target for TIF_NEED_FPU_LOAD.
It doesn't make any sense to delay set_tsk_thread_flag(TIF_NEED_FPU_LOAD)
until "prev_p" is scheduled again.

There is no worry about the very first context switch, fpu_clone() must
always set TIF_NEED_FPU_LOAD.

Also, shift the test_tsk_thread_flag(TIF_NEED_FPU_LOAD) from the callers
to switch_fpu().

Note that the "PF_KTHREAD | PF_USER_WORKER" check can be removed but
this deserves a separate patch which can change more functions, say,
kernel_fpu_begin_mask().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Chang S . Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250503143830.GA8982@redhat.com
---
 arch/x86/include/asm/fpu/sched.h | 34 ++++++++-----------------------
 arch/x86/kernel/process_32.c     |  5 +----
 arch/x86/kernel/process_64.c     |  5 +----
 3 files changed, 11 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index 5fd1263..c060549 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -18,31 +18,25 @@ extern void fpu_flush_thread(void);
 /*
  * FPU state switching for scheduling.
  *
- * This is a two-stage process:
+ * switch_fpu() saves the old state and sets TIF_NEED_FPU_LOAD if
+ * TIF_NEED_FPU_LOAD is not set.  This is done within the context
+ * of the old process.
  *
- *  - switch_fpu_prepare() saves the old state.
- *    This is done within the context of the old process.
- *
- *  - switch_fpu_finish() sets TIF_NEED_FPU_LOAD; the floating point state
- *    will get loaded on return to userspace, or when the kernel needs it.
- *
- * If TIF_NEED_FPU_LOAD is cleared then the CPU's FPU registers
- * are saved in the current thread's FPU register state.
- *
- * If TIF_NEED_FPU_LOAD is set then CPU's FPU registers may not
- * hold current()'s FPU registers. It is required to load the
+ * Once TIF_NEED_FPU_LOAD is set, it is required to load the
  * registers before returning to userland or using the content
  * otherwise.
  *
  * The FPU context is only stored/restored for a user task and
  * PF_KTHREAD is used to distinguish between kernel and user threads.
  */
-static inline void switch_fpu_prepare(struct task_struct *old, int cpu)
+static inline void switch_fpu(struct task_struct *old, int cpu)
 {
-	if (cpu_feature_enabled(X86_FEATURE_FPU) &&
+	if (!test_tsk_thread_flag(old, TIF_NEED_FPU_LOAD) &&
+	    cpu_feature_enabled(X86_FEATURE_FPU) &&
 	    !(old->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		struct fpu *old_fpu = x86_task_fpu(old);
 
+		set_tsk_thread_flag(old, TIF_NEED_FPU_LOAD);
 		save_fpregs_to_fpstate(old_fpu);
 		/*
 		 * The save operation preserved register state, so the
@@ -50,7 +44,7 @@ static inline void switch_fpu_prepare(struct task_struct *old, int cpu)
 		 * current CPU number in @old_fpu, so the next return
 		 * to user space can avoid the FPU register restore
 		 * when is returns on the same CPU and still owns the
-		 * context.
+		 * context. See fpregs_restore_userregs().
 		 */
 		old_fpu->last_cpu = cpu;
 
@@ -58,14 +52,4 @@ static inline void switch_fpu_prepare(struct task_struct *old, int cpu)
 	}
 }
 
-/*
- * Delay loading of the complete FPU state until the return to userland.
- * PKRU is handled separately.
- */
-static inline void switch_fpu_finish(struct task_struct *new)
-{
-	if (cpu_feature_enabled(X86_FEATURE_FPU))
-		set_tsk_thread_flag(new, TIF_NEED_FPU_LOAD);
-}
-
 #endif /* _ASM_X86_FPU_SCHED_H */
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 4636ef3..9bd4fa6 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -160,8 +160,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
-	if (!test_tsk_thread_flag(prev_p, TIF_NEED_FPU_LOAD))
-		switch_fpu_prepare(prev_p, cpu);
+	switch_fpu(prev_p, cpu);
 
 	/*
 	 * Save away %gs. No need to save %fs, as it was saved on the
@@ -208,8 +207,6 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	raw_cpu_write(current_task, next_p);
 
-	switch_fpu_finish(next_p);
-
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in(next_p);
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 7196ca7..d55310d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -616,8 +616,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
 		     this_cpu_read(hardirq_stack_inuse));
 
-	if (!test_tsk_thread_flag(prev_p, TIF_NEED_FPU_LOAD))
-		switch_fpu_prepare(prev_p, cpu);
+	switch_fpu(prev_p, cpu);
 
 	/* We must save %fs and %gs before load_TLS() because
 	 * %fs and %gs may be cleared by load_TLS().
@@ -671,8 +670,6 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	raw_cpu_write(current_task, next_p);
 	raw_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
 
-	switch_fpu_finish(next_p);
-
 	/* Reload sp0. */
 	update_task_stack(next_p);
 

