Return-Path: <linux-tip-commits+bounces-4960-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00245A878DD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 09:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95053AB864
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 07:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8076425A64B;
	Mon, 14 Apr 2025 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M7DXM+QG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t5Jcdpa2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7BC259CB4;
	Mon, 14 Apr 2025 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616093; cv=none; b=rgH2d5rlkal+PC7GDcH77INNbg25KrcpLYXv/qTjy+CwJhAmGgLQddzrWMOfqtPZbg+/yfKGsAjWrNIGIqPGRNqAfUqjgHnfbRo6Yf7ukel9RX3s0taqNa5OH8d58UiiZOcdJ+f5q9/yNeLwWEkHEZCk700SEnFjuxQec5hF8JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616093; c=relaxed/simple;
	bh=Vu4ARyyxKFerMoLOXzMzx5Gc++3E4XOyvaqOX79pXPk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eO4cjWLFCbzts9bmsyPJ/upx3gC6gyzWV3VYds3lE6Z8ixV9KzB57rzXdBacQxZzOXry6Q1RkTI/1gKa/RvQ1tgEfYQ/82o2KC9eiiy5nQ08gseiaboH6Z0qNv78HRjXNqWVkS9brRDlwLGD9BRdhJFRSBEm9yV29W57W5XUIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M7DXM+QG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t5Jcdpa2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 07:34:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744616089;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyU+nWU4a7n//NboP9f4k47sjGjb+ctZ+kH6gaEuAD8=;
	b=M7DXM+QGlU5TwQDzazqn7zK4R5i52lWFtgkvIj/ytnaUXdr3L5deWqE4dhq4Sz3XZ63GfE
	h81S37RXLvdu5rinhwYKW0c2axSqezC4+NTbkTVBULdKc37i18W7cXx78c15gvyNiguQoW
	gfn8zLdgJrzWZZsTZpwh2AC2CliaPK8u9JZ5UKtmnJaMOBi0g9uxc0YeLmScIEnhDGhBQx
	djAUnjF3uknnR+SUIiw/EcoJZujiYR3MQzHvMf7Lh2wopmWFA/aibNIy8AUWhajcb5lrhS
	se90wDh/dbMDbxUfw2caR31dU2CoYwbgmMojWnTdc4x8VpGYzNHmCva89Aoe/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744616089;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyU+nWU4a7n//NboP9f4k47sjGjb+ctZ+kH6gaEuAD8=;
	b=t5Jcdpa20k6LLiZ/e/56ln/spWFb609MLJvhQTF7H+MR3J2TisXqdT4OHIh2Cv8YhzcG4Q
	N+Zidf7dq3ajvbDA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/fpu: Make task_struct::thread constant size
Cc: Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, "Chang S. Bae" <chang.seok.bae@intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250409211127.3544993-4-mingo@kernel.org>
References: <20250409211127.3544993-4-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174461608898.31282.7663316545402138900.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     cb7ca40a3882360ce87191793449d48df0b29184
Gitweb:        https://git.kernel.org/tip/cb7ca40a3882360ce87191793449d48df0b29184
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 23:11:22 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 08:18:29 +02:00

x86/fpu: Make task_struct::thread constant size

Turn thread.fpu into a pointer. Since most FPU code internals work by passing
around the FPU pointer already, the code generation impact is small.

This allows us to remove the old kludge of task_struct being variable size:

  struct task_struct {

       ...
       /*
        * New fields for task_struct should be added above here, so that
        * they are included in the randomized portion of task_struct.
        */
       randomized_struct_fields_end

       /* CPU-specific state of this task: */
       struct thread_struct            thread;

       /*
        * WARNING: on x86, 'thread_struct' contains a variable-sized
        * structure.  It *MUST* be at the end of 'task_struct'.
        *
        * Do not put anything below here!
        */
  };

... which creates a number of problems, such as requiring thread_struct to be
the last member of the struct - not allowing it to be struct-randomized, etc.

But the primary motivation is to allow the decoupling of task_struct from
hardware details (<asm/processor.h> in particular), and to eventually allow
the per-task infrastructure:

   DECLARE_PER_TASK(type, name);
   ...
   per_task(current, name) = val;

... which requires task_struct to be a constant size struct.

The fpu_thread_struct_whitelist() quirk to hardened usercopy can be removed,
now that the FPU structure is not embedded in the task struct anymore, which
reduces text footprint a bit.

Fixed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250409211127.3544993-4-mingo@kernel.org
---
 arch/x86/include/asm/processor.h | 20 +++++++++-----------
 arch/x86/kernel/fpu/core.c       | 23 ++++++++++++-----------
 arch/x86/kernel/fpu/init.c       | 17 ++++++++++-------
 arch/x86/kernel/process.c        |  2 +-
 include/linux/sched.h            | 15 ++++-----------
 5 files changed, 36 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2f631e0..5ea7e5d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -516,21 +516,19 @@ struct thread_struct {
 #endif
 
 	/* Floating point and extended processor state */
-	struct fpu		fpu;
-	/*
-	 * WARNING: 'fpu' is dynamically-sized.  It *MUST* be at
-	 * the end.
-	 */
+	struct fpu		*fpu;
 };
 
-#define x86_task_fpu(task) (&(task)->thread.fpu)
-
-extern void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size);
+#define x86_task_fpu(task) ((task)->thread.fpu)
 
-static inline void arch_thread_struct_whitelist(unsigned long *offset,
-						unsigned long *size)
+/*
+ * X86 doesn't need any embedded-FPU-struct quirks:
+ */
+static inline void
+arch_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
 {
-	fpu_thread_struct_whitelist(offset, size);
+	*offset = 0;
+	*size = 0;
 }
 
 static inline void
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index dc6d7f9..853a738 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -593,8 +593,19 @@ static int update_fpu_shstk(struct task_struct *dst, unsigned long ssp)
 int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	      unsigned long ssp)
 {
+	/*
+	 * We allocate the new FPU structure right after the end of the task struct.
+	 * task allocation size already took this into account.
+	 *
+	 * This is safe because task_struct size is a multiple of cacheline size.
+	 */
 	struct fpu *src_fpu = x86_task_fpu(current);
-	struct fpu *dst_fpu = x86_task_fpu(dst);
+	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
+
+	BUILD_BUG_ON(sizeof(*dst) % SMP_CACHE_BYTES != 0);
+	BUG_ON(!src_fpu);
+
+	dst->thread.fpu = dst_fpu;
 
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
@@ -664,16 +675,6 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 }
 
 /*
- * Whitelist the FPU register state embedded into task_struct for hardened
- * usercopy.
- */
-void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
-{
-	*offset = offsetof(struct thread_struct, fpu.__fpstate.regs);
-	*size = fpu_kernel_cfg.default_size;
-}
-
-/*
  * Drops current FPU state: deactivates the fpregs and
  * the fpstate. NOTE: it still leaves previous contents
  * in the fpregs in the eager-FPU case.
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index ad5cb29..848ea79 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -71,8 +71,15 @@ static bool __init fpu__probe_without_cpuid(void)
 	return fsw == 0 && (fcw & 0x103f) == 0x003f;
 }
 
+static struct fpu x86_init_fpu __attribute__ ((aligned (64))) __read_mostly;
+
 static void __init fpu__init_system_early_generic(void)
 {
+	fpstate_reset(&x86_init_fpu);
+	current->thread.fpu = &x86_init_fpu;
+	set_thread_flag(TIF_NEED_FPU_LOAD);
+	x86_init_fpu.last_cpu = -1;
+
 	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
 	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {
 		if (fpu__probe_without_cpuid())
@@ -150,6 +157,8 @@ static void __init fpu__init_task_struct_size(void)
 {
 	int task_size = sizeof(struct task_struct);
 
+	task_size += sizeof(struct fpu);
+
 	/*
 	 * Subtract off the static size of the register state.
 	 * It potentially has a bunch of padding.
@@ -164,14 +173,9 @@ static void __init fpu__init_task_struct_size(void)
 
 	/*
 	 * We dynamically size 'struct fpu', so we require that
-	 * it be at the end of 'thread_struct' and that
-	 * 'thread_struct' be at the end of 'task_struct'.  If
-	 * you hit a compile error here, check the structure to
-	 * see if something got added to the end.
+	 * 'state' be at the end of 'it:
 	 */
 	CHECK_MEMBER_AT_END_OF(struct fpu, __fpstate);
-	CHECK_MEMBER_AT_END_OF(struct thread_struct, fpu);
-	CHECK_MEMBER_AT_END_OF(struct task_struct, thread);
 
 	arch_task_struct_size = task_size;
 }
@@ -213,7 +217,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
  */
 void __init fpu__init_system(void)
 {
-	fpstate_reset(x86_task_fpu(current));
 	fpu__init_system_early_generic();
 
 	/*
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 47694e3..3ce4cce 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -103,7 +103,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	dst->thread.vm86 = NULL;
 #endif
 	/* Drop the copied pointer to current's fpstate */
-	x86_task_fpu(dst)->fpstate = NULL;
+	dst->thread.fpu = NULL;
 
 	return 0;
 }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f96ac19..4ecc0c6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1646,22 +1646,15 @@ struct task_struct {
 	struct user_event_mm		*user_event_mm;
 #endif
 
-	/*
-	 * New fields for task_struct should be added above here, so that
-	 * they are included in the randomized portion of task_struct.
-	 */
-	randomized_struct_fields_end
-
 	/* CPU-specific state of this task: */
 	struct thread_struct		thread;
 
 	/*
-	 * WARNING: on x86, 'thread_struct' contains a variable-sized
-	 * structure.  It *MUST* be at the end of 'task_struct'.
-	 *
-	 * Do not put anything below here!
+	 * New fields for task_struct should be added above here, so that
+	 * they are included in the randomized portion of task_struct.
 	 */
-};
+	randomized_struct_fields_end
+} __attribute__ ((aligned (64)));
 
 #define TASK_REPORT_IDLE	(TASK_REPORT + 1)
 #define TASK_REPORT_MAX		(TASK_REPORT_IDLE << 1)

