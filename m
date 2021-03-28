Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDD734BEFE
	for <lists+linux-tip-commits@lfdr.de>; Sun, 28 Mar 2021 22:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhC1UrC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 28 Mar 2021 16:47:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39508 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhC1Uqm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 28 Mar 2021 16:46:42 -0400
Date:   Sun, 28 Mar 2021 20:46:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616964400;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLg6dbigB9vFBSEyHShbuWKPjyxTtFqMk2ReiMKKDec=;
        b=YuEZxbmoSe9ZYNtZphrX+gJWh8htF8JbX7n0ntlipVVtgpUSz+hmrFxztcwk7KRkiVR0p7
        ve4g0HOUBBAjm0slDnBMAhRGfDkAlcN3dDkHWZJH7H5sH2WY2PdJFqHeYyn86r4R48bceJ
        MJxQM7Z5dQuovu+kPyUUhG9ZqsBTKxVuClvruEFwpttUqvSdk/QM9PLEk9rq7JULvltY1D
        /25A9lgH0xNptGsiamtsCBiHPMpgmAjPqcIBWkoC+UinDPAmViTrg4CvcViA/SQtb+/2u5
        71j9XCL0Ep5PAH7zT3M40YiNdsrPYb9uVLEms7opDMPiVqkieW4PTbm4eYhS2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616964400;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLg6dbigB9vFBSEyHShbuWKPjyxTtFqMk2ReiMKKDec=;
        b=Ly45ExpyDacLE2QrHlbUdpC7tpK5+2uUHNOxC2h/cpWL1CqWxkc2ztaAfxP9ZfOqF8j5uI
        fa/OBcB/dqINLqBg==
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/process/64: Move cpu_current_top_of_stack out of TSS
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210125173444.22696-2-jiangshanlai@gmail.com>
References: <20210125173444.22696-2-jiangshanlai@gmail.com>
MIME-Version: 1.0
Message-ID: <161696440012.398.1619141495286191611.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     1591584e2e762edecefde403c44d9c26c9ff72c9
Gitweb:        https://git.kernel.org/tip/1591584e2e762edecefde403c44d9c26c9ff72c9
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Tue, 26 Jan 2021 01:34:29 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 28 Mar 2021 22:40:10 +02:00

x86/process/64: Move cpu_current_top_of_stack out of TSS

cpu_current_top_of_stack is currently stored in TSS.sp1. TSS is exposed
through the cpu_entry_area which is visible with user CR3 when PTI is
enabled and active.

This makes it a coveted fruit for attackers.  An attacker can fetch the
kernel stack top from it and continue next steps of actions based on the
kernel stack.

But it is actualy not necessary to be stored in the TSS.  It is only
accessed after the entry code switched to kernel CR3 and kernel GS_BASE
which means it can be in any regular percpu variable.

The reason why it is in TSS is historical (pre PTI) because TSS is also
used as scratch space in SYSCALL_64 and therefore cache hot.

A syscall also needs the per CPU variable current_task and eventually
__preempt_count, so placing cpu_current_top_of_stack next to them makes it
likely that they end up in the same cache line which should avoid
performance regressions. This is not enforced as the compiler is free to
place these variables, so these entry relevant variables should move into
a data structure to make this enforceable.

The seccomp_benchmark doesn't show any performance loss in the "getpid
native" test result.  Actually, the result changes from 93ns before to 92ns
with this change when KPTI is disabled. The test is very stable and
although the test doesn't show a higher degree of precision it gives enough
confidence that moving cpu_current_top_of_stack does not cause a
regression.

[ tglx: Removed unneeded export. Massaged changelog ]

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210125173444.22696-2-jiangshanlai@gmail.com
---
 arch/x86/include/asm/processor.h   | 10 ----------
 arch/x86/include/asm/switch_to.h   |  7 +------
 arch/x86/include/asm/thread_info.h |  8 +-------
 arch/x86/kernel/cpu/common.c       |  2 ++
 arch/x86/kernel/process.c          |  7 +------
 arch/x86/mm/pti.c                  |  7 +++----
 6 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 8b3ed21..185142b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -314,11 +314,6 @@ struct x86_hw_tss {
 struct x86_hw_tss {
 	u32			reserved1;
 	u64			sp0;
-
-	/*
-	 * We store cpu_current_top_of_stack in sp1 so it's always accessible.
-	 * Linux does not use ring 1, so sp1 is not otherwise needed.
-	 */
 	u64			sp1;
 
 	/*
@@ -426,12 +421,7 @@ struct irq_stack {
 	char		stack[IRQ_STACK_SIZE];
 } __aligned(IRQ_STACK_SIZE);
 
-#ifdef CONFIG_X86_32
 DECLARE_PER_CPU(unsigned long, cpu_current_top_of_stack);
-#else
-/* The RO copy can't be accessed with this_cpu_xyz(), so use the RW copy. */
-#define cpu_current_top_of_stack cpu_tss_rw.x86_tss.sp1
-#endif
 
 #ifdef CONFIG_X86_64
 struct fixed_percpu_data {
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index 9f69cc4..b5f0d2f 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -71,12 +71,7 @@ static inline void update_task_stack(struct task_struct *task)
 	else
 		this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
 #else
-	/*
-	 * x86-64 updates x86_tss.sp1 via cpu_current_top_of_stack. That
-	 * doesn't work on x86-32 because sp1 and
-	 * cpu_current_top_of_stack have different values (because of
-	 * the non-zero stack-padding on 32bit).
-	 */
+	/* Xen PV enters the kernel on the thread stack. */
 	if (static_cpu_has(X86_FEATURE_XENPV))
 		load_sp0(task_top_of_stack(task));
 #endif
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 06b740b..de406d9 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -197,13 +197,7 @@ static inline int arch_within_stack_frames(const void * const stack,
 #endif
 }
 
-#else /* !__ASSEMBLY__ */
-
-#ifdef CONFIG_X86_64
-# define cpu_current_top_of_stack (cpu_tss_rw + TSS_sp1)
-#endif
-
-#endif
+#endif  /* !__ASSEMBLY__ */
 
 /*
  * Thread-synchronous status.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1aa5f0a..3401078 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1748,6 +1748,8 @@ DEFINE_PER_CPU(bool, hardirq_stack_inuse);
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
+DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
+
 /* May not be marked __init: used by software suspend */
 void syscall_init(void)
 {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index cdfe5b4..43cbfc8 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -63,14 +63,9 @@ __visible DEFINE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw) = {
 		 */
 		.sp0 = (1UL << (BITS_PER_LONG-1)) + 1,
 
-		/*
-		 * .sp1 is cpu_current_top_of_stack.  The init task never
-		 * runs user code, but cpu_current_top_of_stack should still
-		 * be well defined before the first context switch.
-		 */
+#ifdef CONFIG_X86_32
 		.sp1 = TOP_OF_INIT_STACK,
 
-#ifdef CONFIG_X86_32
 		.ss0 = __KERNEL_DS,
 		.ss1 = __KERNEL_CS,
 #endif
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index b377604..5d5c7bb 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -440,10 +440,9 @@ static void __init pti_clone_user_shared(void)
 
 	for_each_possible_cpu(cpu) {
 		/*
-		 * The SYSCALL64 entry code needs to be able to find the
-		 * thread stack and needs one word of scratch space in which
-		 * to spill a register.  All of this lives in the TSS, in
-		 * the sp1 and sp2 slots.
+		 * The SYSCALL64 entry code needs one word of scratch space
+		 * in which to spill a register.  It lives in the sp2 slot
+		 * of the CPU's TSS.
 		 *
 		 * This is done for all possible CPUs during boot to ensure
 		 * that it's propagated to all mms.
