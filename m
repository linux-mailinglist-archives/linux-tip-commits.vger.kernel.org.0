Return-Path: <linux-tip-commits+bounces-3923-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9A9A4DAE7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238FA3B10F7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E7A202C20;
	Tue,  4 Mar 2025 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xKpBeXNF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UciscArE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC16620124E;
	Tue,  4 Mar 2025 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084596; cv=none; b=krNUqNbiQssiXx4u80bVKM8n84RWeH8LDfqnSGpw0cmcTE3rKM4IpmcvrubL2x5qNkRvYhGWjOK3e+PBBMkbLGHV9/t5WYAtJUU58tYPQd0TxwhxBOx2KrYk85+Ve54pfggBdCgDfNWaJYv8ajOqFengnXtfJ6AD97D2OObGcWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084596; c=relaxed/simple;
	bh=sB7Ur8FF+nSdqg9x7xsYvoo7c2pznKRrYpxPFN2uuHI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WnkMGptjM67sMgGI6GGdQUufSGztiG3N3EObyegSOsfpkuBeqs3HJBZm6Zpl0N+fLeWBxuhLEWwunM+7r2tZnTk2TnzcemHLk/ZyKfNt8uQNzEU29Fg8Rb218yutTEQA+WbQxsQ6xIgJL8QZC/NhzdRlQ+o6PFn3Y7YGkA06nog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xKpBeXNF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UciscArE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:36:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741084592;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+OJeDYXDsz24te1bG9pivImm5M40+4JTcbEtYGa7/E=;
	b=xKpBeXNFPgeTaXyAlzpd2vW3Y8UzUKKRJujdlRhZWMlFvPlWmxc38J7OFRmJpLVkBGSZVj
	5L7HdDrR0t7F6DNNYoRoT2jhD+yFWAIXLU6g0KSkV5iDDjcmqoK54OlFKdZeYAH7zSIWeb
	BJa1TpWDfYwrunY/8hNWbOt8CdiiYyki4Oc/pFKKmp2LUrmhK4JwbDA2eeZgqLoqcKjurZ
	azb9AFg+POxAQNoNS9HjGsopshfWpsYr605tu8ekKpjBc+4ESOCuBcDtAJrrG1s2dY9u5Z
	1curoUhLnFxSwsjRs2fVVmXkna2r+Tb2ibCG/F56ExoepJ4GeGmT/MQpuHUqUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741084592;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+OJeDYXDsz24te1bG9pivImm5M40+4JTcbEtYGa7/E=;
	b=UciscArESTwY03C+NzJOC+8B0inrUxvII/SpbBZbJaUCsvn/v75HJkEHCkf5OEwCwpPGPB
	TSLGdg7Wcn18JlAw==
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
Message-ID: <174108459145.14745.1160217657496786079.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     7ef636dcf031898ea6775c89d27e914979071cf9
Gitweb:        https://git.kernel.org/tip/7ef636dcf031898ea6775c89d27e914979071cf9
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:42 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:24:28 +01:00

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
index c241dbc..6bb6af0 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -415,6 +415,13 @@ struct irq_stack {
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
index 566a93d..86bf535 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -49,6 +49,8 @@ static inline bool check_stack_overflow(void) { return false; }
 static inline void print_stack_overflow(void) { }
 #endif
 
+DEFINE_PER_CPU_CACHE_HOT(struct irq_stack *, softirq_stack_ptr);
+
 static void call_on_stack(void *func, void *stack)
 {
 	asm volatile("xchgl %[sp], %%esp\n"
@@ -71,7 +73,7 @@ static inline bool execute_on_irq_stack(bool overflow, struct irq_desc *desc)
 	u32 *isp, *prev_esp;
 
 	curstk = (struct irq_stack *) current_stack();
-	irqstk = __this_cpu_read(pcpu_hot.hardirq_stack_ptr);
+	irqstk = __this_cpu_read(hardirq_stack_ptr);
 
 	/*
 	 * this is where we switch to the IRQ stack. However, if we are
@@ -109,7 +111,7 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 	int node = cpu_to_node(cpu);
 	struct page *ph, *ps;
 
-	if (per_cpu(pcpu_hot.hardirq_stack_ptr, cpu))
+	if (per_cpu(hardirq_stack_ptr, cpu))
 		return 0;
 
 	ph = alloc_pages_node(node, THREADINFO_GFP, THREAD_SIZE_ORDER);
@@ -121,8 +123,8 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 		return -ENOMEM;
 	}
 
-	per_cpu(pcpu_hot.hardirq_stack_ptr, cpu) = page_address(ph);
-	per_cpu(pcpu_hot.softirq_stack_ptr, cpu) = page_address(ps);
+	per_cpu(hardirq_stack_ptr, cpu) = page_address(ph);
+	per_cpu(softirq_stack_ptr, cpu) = page_address(ps);
 	return 0;
 }
 
@@ -132,7 +134,7 @@ void do_softirq_own_stack(void)
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

