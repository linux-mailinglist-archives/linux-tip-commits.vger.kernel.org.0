Return-Path: <linux-tip-commits+bounces-3847-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68726A4D64A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED65F1713B2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 08:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6940C1FC119;
	Tue,  4 Mar 2025 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IzG2nsyU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DS4Ttey/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449DD1FBCA9;
	Tue,  4 Mar 2025 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076871; cv=none; b=ldL+LvE4GYakAvqwRDa7UQSj49TG38TpuMRBba+FdBd6xs3pACsjRRXjcnNjXprE1m7s2j92Dz3k4EL6h9PIpJfPf/uigWW1ea3CtJSotwgpb6LUcE7O6/ydbMMV80+dM9b2E9xkBpWRQnONKw555u/LVQqSoZMP14m0OGm9eDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076871; c=relaxed/simple;
	bh=7B6Dd4z1tXDgSzsrRNRbL1yjfLO1eCa5S9QMplDmwf4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vANnD2TZc47ZDM2fX5B/EpGfM4LyWMkC/k5UvVMDaw4Hdq+T43MpyUanHW/2BnFNWWy74zIndG5YZni9PzjLjBnppQmBrMFGJjGywwwFMMkBTUJ6UkUqaa1ayK5YbPjm3T5XwzVdzE0uYEY3CvtiMgabKdJHFGD7l3Hz6nRAwm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IzG2nsyU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DS4Ttey/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:27:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741076867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKV1E6hBdptBMKcL7aqq4GddtOHcg+epFseXtf+pbOE=;
	b=IzG2nsyUPPSfrtH97KzAkRn7+YqQRcracLeGyjoGLAEeel9R/hD8uHs/d9OrferdXZi5F6
	n1K3/uxvPlbayIsLjTgcPdKhktULlcJwJYnUCYscuP27+QX0S2rwmYfjE1rcHWmAw4//9c
	EI9JgLG/a1QyTFu5GTbfKJFsb7HJtSQhJ8Umd1ufCyltTt29eetczwOqhW2RpoGiIKlhMg
	ZkE0thCVyqZ1xDnXvimkQcPw+/TdEhVCaBqPo3+mFhgEgG6KL/BYIMlifvUcfXBKYqGqOG
	nkN8w7w+y02Dtz+aIAb7hcW+2SfZNgehdOUhNJYWcN+JEbG5+gNmlWQ3HQfIig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741076867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKV1E6hBdptBMKcL7aqq4GddtOHcg+epFseXtf+pbOE=;
	b=DS4Ttey/PmvH4JJrcYQ3q/v6fAErNsU1Vw+SMDinuicLUcNiTplbe9xrj0Jiwx4l0HGbBv
	IL5dYp30gx3GOhBA==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/irq: Move irq stacks to percpu hot section
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303165246.2175811-8-brgerst@gmail.com>
References: <20250303165246.2175811-8-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107686692.14745.9588821701434915484.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     e4ac257c96fa96eae93d24a9d296c8cbc9c72db1
Gitweb:        https://git.kernel.org/tip/e4ac257c96fa96eae93d24a9d296c8cbc9c72db1
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:42 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 21:37:41 +01:00

x86/irq: Move irq stacks to percpu hot section

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303165246.2175811-8-brgerst@gmail.com
---
 arch/x86/include/asm/current.h   |  6 ------
 arch/x86/include/asm/irq_stack.h | 12 ++++++------
 arch/x86/include/asm/processor.h |  7 +++++++
 arch/x86/kernel/dumpstack_32.c   |  4 ++--
 arch/x86/kernel/dumpstack_64.c   |  2 +-
 arch/x86/kernel/irq.c            |  2 ++
 arch/x86/kernel/irq_32.c         | 12 +++++++-----
 arch/x86/kernel/irq_64.c         |  7 ++++---
 arch/x86/kernel/process_64.c     |  2 +-
 9 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index f153c77..6fad5a4 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -15,12 +15,6 @@ struct task_struct;
 struct pcpu_hot {
 	struct task_struct	*current_task;
 	unsigned long		top_of_stack;
-	void			*hardirq_stack_ptr;
-#ifdef CONFIG_X86_64
-	bool			hardirq_stack_inuse;
-#else
-	void			*softirq_stack_ptr;
-#endif
 };
 
 DECLARE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot);
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 8e56a07..3ce0314 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -117,7 +117,7 @@
 	ASM_CALL_ARG2
 
 #define call_on_irqstack(func, asm_call, argconstr...)			\
-	call_on_stack(__this_cpu_read(pcpu_hot.hardirq_stack_ptr),	\
+	call_on_stack(__this_cpu_read(hardirq_stack_ptr),		\
 		      func, asm_call, argconstr)
 
 /* Macros to assert type correctness for run_*_on_irqstack macros */
@@ -136,7 +136,7 @@
 	 * User mode entry and interrupt on the irq stack do not	\
 	 * switch stacks. If from user mode the task stack is empty.	\
 	 */								\
-	if (user_mode(regs) || __this_cpu_read(pcpu_hot.hardirq_stack_inuse)) { \
+	if (user_mode(regs) || __this_cpu_read(hardirq_stack_inuse)) {	\
 		irq_enter_rcu();					\
 		func(c_args);						\
 		irq_exit_rcu();						\
@@ -147,9 +147,9 @@
 		 * places. Invoke the stack switch macro with the call	\
 		 * sequence which matches the above direct invocation.	\
 		 */							\
-		__this_cpu_write(pcpu_hot.hardirq_stack_inuse, true);	\
+		__this_cpu_write(hardirq_stack_inuse, true);		\
 		call_on_irqstack(func, asm_call, constr);		\
-		__this_cpu_write(pcpu_hot.hardirq_stack_inuse, false);	\
+		__this_cpu_write(hardirq_stack_inuse, false);		\
 	}								\
 }
 
@@ -213,9 +213,9 @@
  */
 #define do_softirq_own_stack()						\
 {									\
-	__this_cpu_write(pcpu_hot.hardirq_stack_inuse, true);		\
+	__this_cpu_write(hardirq_stack_inuse, true);			\
 	call_on_irqstack(__do_softirq, ASM_CALL_ARG0);			\
-	__this_cpu_write(pcpu_hot.hardirq_stack_inuse, false);		\
+	__this_cpu_write(hardirq_stack_inuse, false);			\
 }
 
 #endif
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 0e8602e..2ba079d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -420,6 +420,13 @@ struct irq_stack {
 	char		stack[IRQ_STACK_SIZE];
 } __aligned(IRQ_STACK_SIZE);
 
+DECLARE_PER_CPU_CACHE_HOT(struct irq_stack *, hardirq_stack_ptr);
+#ifdef CONFIG_X86_64
+DECLARE_PER_CPU_CACHE_HOT(bool, hardirq_stack_inuse);
+#else
+DECLARE_PER_CPU_CACHE_HOT(struct irq_stack *, softirq_stack_ptr);
+#endif
+
 #ifdef CONFIG_X86_64
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index b4905d5..722fd71 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -37,7 +37,7 @@ const char *stack_type_name(enum stack_type type)
 
 static bool in_hardirq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *begin = (unsigned long *)this_cpu_read(pcpu_hot.hardirq_stack_ptr);
+	unsigned long *begin = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
 	unsigned long *end   = begin + (THREAD_SIZE / sizeof(long));
 
 	/*
@@ -62,7 +62,7 @@ static bool in_hardirq_stack(unsigned long *stack, struct stack_info *info)
 
 static bool in_softirq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *begin = (unsigned long *)this_cpu_read(pcpu_hot.softirq_stack_ptr);
+	unsigned long *begin = (unsigned long *)this_cpu_read(softirq_stack_ptr);
 	unsigned long *end   = begin + (THREAD_SIZE / sizeof(long));
 
 	/*
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index f05339f..6c5defd 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -134,7 +134,7 @@ static __always_inline bool in_exception_stack(unsigned long *stack, struct stac
 
 static __always_inline bool in_irq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *end = (unsigned long *)this_cpu_read(pcpu_hot.hardirq_stack_ptr);
+	unsigned long *end = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
 	unsigned long *begin;
 
 	/*
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 83a5252..81f9b78 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -36,6 +36,8 @@ EXPORT_PER_CPU_SYMBOL(irq_stat);
 DEFINE_PER_CPU_CACHE_HOT(u16, __softirq_pending);
 EXPORT_PER_CPU_SYMBOL(__softirq_pending);
 
+DEFINE_PER_CPU_CACHE_HOT(struct irq_stack *, hardirq_stack_ptr);
+
 atomic_t irq_err_count;
 
 /*
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index dc1049c..48a27cd 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -52,6 +52,8 @@ static inline int check_stack_overflow(void) { return 0; }
 static inline void print_stack_overflow(void) { }
 #endif
 
+DEFINE_PER_CPU_CACHE_HOT(struct irq_stack *, softirq_stack_ptr);
+
 static void call_on_stack(void *func, void *stack)
 {
 	asm volatile("xchgl	%%ebx,%%esp	\n"
@@ -74,7 +76,7 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 	u32 *isp, *prev_esp, arg1;
 
 	curstk = (struct irq_stack *) current_stack();
-	irqstk = __this_cpu_read(pcpu_hot.hardirq_stack_ptr);
+	irqstk = __this_cpu_read(hardirq_stack_ptr);
 
 	/*
 	 * this is where we switch to the IRQ stack. However, if we are
@@ -112,7 +114,7 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 	int node = cpu_to_node(cpu);
 	struct page *ph, *ps;
 
-	if (per_cpu(pcpu_hot.hardirq_stack_ptr, cpu))
+	if (per_cpu(hardirq_stack_ptr, cpu))
 		return 0;
 
 	ph = alloc_pages_node(node, THREADINFO_GFP, THREAD_SIZE_ORDER);
@@ -124,8 +126,8 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 		return -ENOMEM;
 	}
 
-	per_cpu(pcpu_hot.hardirq_stack_ptr, cpu) = page_address(ph);
-	per_cpu(pcpu_hot.softirq_stack_ptr, cpu) = page_address(ps);
+	per_cpu(hardirq_stack_ptr, cpu) = page_address(ph);
+	per_cpu(softirq_stack_ptr, cpu) = page_address(ps);
 	return 0;
 }
 
@@ -135,7 +137,7 @@ void do_softirq_own_stack(void)
 	struct irq_stack *irqstk;
 	u32 *isp, *prev_esp;
 
-	irqstk = __this_cpu_read(pcpu_hot.softirq_stack_ptr);
+	irqstk = __this_cpu_read(softirq_stack_ptr);
 
 	/* build the stack frame on the softirq stack */
 	isp = (u32 *) ((char *)irqstk + sizeof(*irqstk));
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index 56bdeec..ca78dce 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -26,6 +26,7 @@
 #include <asm/io_apic.h>
 #include <asm/apic.h>
 
+DEFINE_PER_CPU_CACHE_HOT(bool, hardirq_stack_inuse);
 DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;
 
 #ifdef CONFIG_VMAP_STACK
@@ -50,7 +51,7 @@ static int map_irq_stack(unsigned int cpu)
 		return -ENOMEM;
 
 	/* Store actual TOS to avoid adjustment in the hotpath */
-	per_cpu(pcpu_hot.hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
+	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
 	return 0;
 }
 #else
@@ -63,14 +64,14 @@ static int map_irq_stack(unsigned int cpu)
 	void *va = per_cpu_ptr(&irq_stack_backing_store, cpu);
 
 	/* Store actual TOS to avoid adjustment in the hotpath */
-	per_cpu(pcpu_hot.hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
+	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
 	return 0;
 }
 #endif
 
 int irq_init_percpu_irqstack(unsigned int cpu)
 {
-	if (per_cpu(pcpu_hot.hardirq_stack_ptr, cpu))
+	if (per_cpu(hardirq_stack_ptr, cpu))
 		return 0;
 	return map_irq_stack(cpu);
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index f983d2a..2f38416 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -614,7 +614,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	int cpu = smp_processor_id();
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
-		     this_cpu_read(pcpu_hot.hardirq_stack_inuse));
+		     this_cpu_read(hardirq_stack_inuse));
 
 	if (!test_tsk_thread_flag(prev_p, TIF_NEED_FPU_LOAD))
 		switch_fpu_prepare(prev_p, cpu);

