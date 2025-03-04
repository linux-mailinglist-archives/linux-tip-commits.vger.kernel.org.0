Return-Path: <linux-tip-commits+bounces-3920-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD9DA4DAE0
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624AD3AF707
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF78B20127D;
	Tue,  4 Mar 2025 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3DEv5xL8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u75vwD8f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926F201021;
	Tue,  4 Mar 2025 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084594; cv=none; b=Z+vrzDiETXldrlgUyaF5I2LsTqe9v0PNdwH+JQNUKelHGdyD3RPHfmF3pYgD1TlcTpARTxim8wJyiZB3ro8iZmC5uXLJW+aDWaQl00JbnleutFWB2sTiWe/YqDap/k6A3UWZl2C/KllRXgm6dwE6AUN6CNCt2NRumfe7A6p1/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084594; c=relaxed/simple;
	bh=xKRCoLsAPW32liwRNh6RbWGkQ9nnA3sIdc5bA7VgSRM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NjemfkHOU/Mswa+x+qujKSQcEtmchyEur5NgzL7BsRrCqqxCVaIisFM6A2EE6jba8dzYCVtr8zk0Di9xnJ8NLwZr1YRj4Gcvo3/e4jVxcUfxJ6+i9RAnJ8mfxbRjPgurzV5qEhNT6l6XqzYhkPRtatXrIKWM31Dyz70g8Elzsiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3DEv5xL8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u75vwD8f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:36:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741084591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MBGEPpiBnh4luRPuw5Gb45vdZt1YJ2CtBa7x8kTRRNY=;
	b=3DEv5xL8c/rxwHNFUpY2J7lbOM3OYG/3E0NFISkVXxbg5HgsJbMGJysmtjS875VzR5HGmi
	Wvyq8P5znwqbyP5j5R6oTj+P5dIebAcCFKC0YW6IcLkaY264iMT2NaCrubVGoARCVRcEP+
	oH7GQfD3OzZ19trrEZHgQ7oRl3RZTw9Evhx6YLExlzKVUjj6t4I0PHft3vTIDZDmNF2+oF
	JyJJikoI7HNmQFalqYVe/wgZB47JboH5/fs6LvOSnr7FUyF6lRdOVkOzMDctLMWo8n1K0b
	biy4mLwWGySzmlTaN8Y5CxeyrG9jCyWAWfVMktdEu4dQ48bUAj1/qZnpqW+8sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741084591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MBGEPpiBnh4luRPuw5Gb45vdZt1YJ2CtBa7x8kTRRNY=;
	b=u75vwD8fuQwUk1DlXQzFxhDunjnba5x2Mop/j3V0tNMNjCiTRrEkwBR4mKFI8uBS0rqoMF
	i7Fwv4YKwnc77GBQ==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/percpu: Move current_task to percpu hot section
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303165246.2175811-10-brgerst@gmail.com>
References: <20250303165246.2175811-10-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108458981.14745.11391945364780788398.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     f19a605f4334e0dab51c839202a089f79c46579d
Gitweb:        https://git.kernel.org/tip/f19a605f4334e0dab51c839202a089f79c46579d
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:44 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:24:29 +01:00

x86/percpu: Move current_task to percpu hot section

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303165246.2175811-10-brgerst@gmail.com
---
 arch/x86/include/asm/current.h | 17 ++++++-----------
 arch/x86/include/asm/percpu.h  |  2 +-
 arch/x86/kernel/asm-offsets.c  |  1 -
 arch/x86/kernel/cpu/common.c   |  8 +++-----
 arch/x86/kernel/head_64.S      |  4 ++--
 arch/x86/kernel/process_32.c   |  2 +-
 arch/x86/kernel/process_64.c   |  2 +-
 arch/x86/kernel/smpboot.c      |  2 +-
 arch/x86/kernel/vmlinux.lds.S  |  2 +-
 scripts/gdb/linux/cpus.py      |  2 +-
 10 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 3d1b123..dea7d8b 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -12,22 +12,17 @@
 
 struct task_struct;
 
-struct pcpu_hot {
-	struct task_struct	*current_task;
-};
-
-DECLARE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot);
-
-/* const-qualified alias to pcpu_hot, aliased by linker. */
-DECLARE_PER_CPU_CACHE_HOT(const struct pcpu_hot __percpu_seg_override,
-			const_pcpu_hot);
+DECLARE_PER_CPU_CACHE_HOT(struct task_struct *, current_task);
+/* const-qualified alias provided by the linker. */
+DECLARE_PER_CPU_CACHE_HOT(struct task_struct * const __percpu_seg_override,
+			  const_current_task);
 
 static __always_inline struct task_struct *get_current(void)
 {
 	if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
-		return this_cpu_read_const(const_pcpu_hot.current_task);
+		return this_cpu_read_const(const_current_task);
 
-	return this_cpu_read_stable(pcpu_hot.current_task);
+	return this_cpu_read_stable(current_task);
 }
 
 #define current get_current()
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 1ca290b..6fbb52a 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -549,7 +549,7 @@ do {									\
  * it is accessed while this_cpu_read_stable() allows the value to be cached.
  * this_cpu_read_stable() is more efficient and can be used if its value
  * is guaranteed to be valid across CPUs.  The current users include
- * pcpu_hot.current_task and cpu_current_top_of_stack, both of which are
+ * current_task and cpu_current_top_of_stack, both of which are
  * actually per-thread variables implemented as per-CPU variables and
  * thus stable for the duration of the respective task.
  */
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 54ace80..ad4ea6f 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -107,7 +107,6 @@ static void __used common(void)
 	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
-	OFFSET(X86_current_task, pcpu_hot, current_task);
 #if IS_ENABLED(CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64)
 	/* Offset for fields in aria_ctx */
 	BLANK();
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 51653e0..3f45fdd 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2064,11 +2064,9 @@ static __init int setup_setcpuid(char *arg)
 }
 __setup("setcpuid=", setup_setcpuid);
 
-DEFINE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot) = {
-	.current_task	= &init_task,
-};
-EXPORT_PER_CPU_SYMBOL(pcpu_hot);
-EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
+DEFINE_PER_CPU_CACHE_HOT(struct task_struct *, current_task) = &init_task;
+EXPORT_PER_CPU_SYMBOL(current_task);
+EXPORT_PER_CPU_SYMBOL(const_current_task);
 
 DEFINE_PER_CPU_CACHE_HOT(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 2843b0a..fefe2a2 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -322,7 +322,7 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
 	 *
 	 * RDX contains the per-cpu offset
 	 */
-	movq	pcpu_hot + X86_current_task(%rdx), %rax
+	movq	current_task(%rdx), %rax
 	movq	TASK_threadsp(%rax), %rsp
 
 	/*
@@ -433,7 +433,7 @@ SYM_CODE_START(soft_restart_cpu)
 	UNWIND_HINT_END_OF_STACK
 
 	/* Find the idle task stack */
-	movq	PER_CPU_VAR(pcpu_hot + X86_current_task), %rcx
+	movq	PER_CPU_VAR(current_task), %rcx
 	movq	TASK_threadsp(%rcx), %rsp
 
 	jmp	.Ljump_to_C_code
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 8ec44ac..4636ef3 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -206,7 +206,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	if (prev->gs | next->gs)
 		loadsegment(gs, next->gs);
 
-	raw_cpu_write(pcpu_hot.current_task, next_p);
+	raw_cpu_write(current_task, next_p);
 
 	switch_fpu_finish(next_p);
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index d8f4bce..7196ca7 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -668,7 +668,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/*
 	 * Switch the PDA and FPU contexts.
 	 */
-	raw_cpu_write(pcpu_hot.current_task, next_p);
+	raw_cpu_write(current_task, next_p);
 	raw_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
 
 	switch_fpu_finish(next_p);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c3a26e6..42ca131 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -822,7 +822,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 	/* Just in case we booted with a single CPU. */
 	alternatives_enable_smp();
 
-	per_cpu(pcpu_hot.current_task, cpu) = idle;
+	per_cpu(current_task, cpu) = idle;
 	cpu_init_stack_canary(cpu, idle);
 
 	/* Initialize the interrupt stack(s) */
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 475f671..31f9102 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -43,7 +43,7 @@ ENTRY(phys_startup_64)
 #endif
 
 jiffies = jiffies_64;
-const_pcpu_hot = pcpu_hot;
+const_current_task = current_task;
 const_cpu_current_top_of_stack = cpu_current_top_of_stack;
 
 #if defined(CONFIG_X86_64)
diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 13eb8b3..8f7c4fb 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -164,7 +164,7 @@ def get_current_task(cpu):
             var_ptr = gdb.parse_and_eval("(struct task_struct *)cpu_tasks[0].task")
             return var_ptr.dereference()
         else:
-            var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
+            var_ptr = gdb.parse_and_eval("&current_task")
             return per_cpu(var_ptr, cpu).dereference()
     elif utils.is_target_arch("aarch64"):
         current_task_addr = gdb.parse_and_eval("(unsigned long)$SP_EL0")

