Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479182C4179
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Nov 2020 14:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgKYN5N (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Nov 2020 08:57:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50262 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKYN5M (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Nov 2020 08:57:12 -0500
Date:   Wed, 25 Nov 2020 13:57:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606312629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3MxHwdjTyGdUbdERyKZrcVK8pRbjPHgBVDVWR9J3/jI=;
        b=Chiz84t3oFOoxu9JjP1hcFiRff3iHVy9++O08o2R5q9oWG72A+/I+j9R6g1GOd2jsUTw9m
        5f4CYYB1sxKlgyBviu9FlOIm/N7BW5Az/rtVKahg76abjnhv8DLceOdMTlqyYR3kGJBuSb
        WzC6bG+NHD/jydO8moIeLcC2VIBx196Hl3YTG8T55Ie4pOdz1cX1MjOSEAShKMyhd0Crht
        iw3ACM1RfhHOVCYAeWL1uqFBrShEccez9oBSMH0GSkYfYnKrV0iFZ/Ksk8o9eMaCvXNz3A
        8obgp/eVIoxSUHrWTyKLKvoOPWzl4KxSMIOqRho47C7yw8Lt+pSCIo2D5GrH/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606312629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3MxHwdjTyGdUbdERyKZrcVK8pRbjPHgBVDVWR9J3/jI=;
        b=ZTL3Yizh82OFhkmC5fs8uFeQ9rmeKjti/RjwY7yun+Ccce175AzC0aIJXgIEMnnTxgODhp
        9DdvXfdj8YDSb5DA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] sched/idle: Fix arch_cpu_idle() vs tracing
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201120114925.594122626@infradead.org>
References: <20201120114925.594122626@infradead.org>
MIME-Version: 1.0
Message-ID: <160631262815.3364.3410643528817844628.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     58c644ba512cfbc2e39b758dd979edd1d6d00e27
Gitweb:        https://git.kernel.org/tip/58c644ba512cfbc2e39b758dd979edd1d6d00e27
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 20 Nov 2020 11:50:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 24 Nov 2020 16:47:35 +01:00

sched/idle: Fix arch_cpu_idle() vs tracing

We call arch_cpu_idle() with RCU disabled, but then use
local_irq_{en,dis}able(), which invokes tracing, which relies on RCU.

Switch all arch_cpu_idle() implementations to use
raw_local_irq_{en,dis}able() and carefully manage the
lockdep,rcu,tracing state like we do in entry.

(XXX: we really should change arch_cpu_idle() to not return with
interrupts enabled)

Reported-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lkml.kernel.org/r/20201120114925.594122626@infradead.org
---
 arch/alpha/kernel/process.c      |  2 +-
 arch/arm/kernel/process.c        |  2 +-
 arch/arm64/kernel/process.c      |  2 +-
 arch/csky/kernel/process.c       |  2 +-
 arch/h8300/kernel/process.c      |  2 +-
 arch/hexagon/kernel/process.c    |  2 +-
 arch/ia64/kernel/process.c       |  2 +-
 arch/microblaze/kernel/process.c |  2 +-
 arch/mips/kernel/idle.c          | 12 ++++++------
 arch/nios2/kernel/process.c      |  2 +-
 arch/openrisc/kernel/process.c   |  2 +-
 arch/parisc/kernel/process.c     |  2 +-
 arch/powerpc/kernel/idle.c       |  4 ++--
 arch/riscv/kernel/process.c      |  2 +-
 arch/s390/kernel/idle.c          |  6 +++---
 arch/sh/kernel/idle.c            |  2 +-
 arch/sparc/kernel/leon_pmc.c     |  4 ++--
 arch/sparc/kernel/process_32.c   |  2 +-
 arch/sparc/kernel/process_64.c   |  4 ++--
 arch/um/kernel/process.c         |  2 +-
 arch/x86/include/asm/mwait.h     |  2 --
 arch/x86/kernel/process.c        | 12 +++++++-----
 kernel/sched/idle.c              | 28 +++++++++++++++++++++++++++-
 23 files changed, 64 insertions(+), 38 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 7462a79..4c7b041 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -57,7 +57,7 @@ EXPORT_SYMBOL(pm_power_off);
 void arch_cpu_idle(void)
 {
 	wtint(0);
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void arch_cpu_idle_dead(void)
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 8e6ace0..9f199b1 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -71,7 +71,7 @@ void arch_cpu_idle(void)
 		arm_pm_idle();
 	else
 		cpu_do_idle();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void arch_cpu_idle_prepare(void)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 4784011..9ebe025 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -126,7 +126,7 @@ void arch_cpu_idle(void)
 	 * tricks
 	 */
 	cpu_do_idle();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index f730869..69af6bc 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -102,6 +102,6 @@ void arch_cpu_idle(void)
 #ifdef CONFIG_CPU_PM_STOP
 	asm volatile("stop\n");
 #endif
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 #endif
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index aea0a40..bc1364d 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -57,7 +57,7 @@ asmlinkage void ret_from_kernel_thread(void);
  */
 void arch_cpu_idle(void)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 	__asm__("sleep");
 }
 
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 5a0a95d..67767c5 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -44,7 +44,7 @@ void arch_cpu_idle(void)
 {
 	__vmwait();
 	/*  interrupts wake us up, but irqs are still disabled */
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /*
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 6b61a70..c9ff879 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -239,7 +239,7 @@ void arch_cpu_idle(void)
 	if (mark_idle)
 		(*mark_idle)(1);
 
-	safe_halt();
+	raw_safe_halt();
 
 	if (mark_idle)
 		(*mark_idle)(0);
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index a9e46e5..f998607 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -149,5 +149,5 @@ int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpregs)
 
 void arch_cpu_idle(void)
 {
-       local_irq_enable();
+       raw_local_irq_enable();
 }
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 5bc3b04..18e69eb 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -33,19 +33,19 @@ static void __cpuidle r3081_wait(void)
 {
 	unsigned long cfg = read_c0_conf();
 	write_c0_conf(cfg | R30XX_CONF_HALT);
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 static void __cpuidle r39xx_wait(void)
 {
 	if (!need_resched())
 		write_c0_conf(read_c0_conf() | TX39_CONF_HALT);
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void __cpuidle r4k_wait(void)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 	__r4k_wait();
 }
 
@@ -64,7 +64,7 @@ void __cpuidle r4k_wait_irqoff(void)
 		"	.set	arch=r4000	\n"
 		"	wait			\n"
 		"	.set	pop		\n");
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /*
@@ -84,7 +84,7 @@ static void __cpuidle rm7k_wait_irqoff(void)
 		"	wait						\n"
 		"	mtc0	$1, $12		# stalls until W stage	\n"
 		"	.set	pop					\n");
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /*
@@ -257,7 +257,7 @@ void arch_cpu_idle(void)
 	if (cpu_wait)
 		cpu_wait();
 	else
-		local_irq_enable();
+		raw_local_irq_enable();
 }
 
 #ifdef CONFIG_CPU_IDLE
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index 4ffe857..50b4eb1 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -33,7 +33,7 @@ EXPORT_SYMBOL(pm_power_off);
 
 void arch_cpu_idle(void)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /*
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 0ff391f..3c98728 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -79,7 +79,7 @@ void machine_power_off(void)
  */
 void arch_cpu_idle(void)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 	if (mfspr(SPR_UPR) & SPR_UPR_PMP)
 		mtspr(SPR_PMR, mfspr(SPR_PMR) | SPR_PMR_DME);
 }
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index f196d96..a92a23d 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -169,7 +169,7 @@ void __cpuidle arch_cpu_idle_dead(void)
 
 void __cpuidle arch_cpu_idle(void)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 
 	/* nop on real hardware, qemu will idle sleep. */
 	asm volatile("or %%r10,%%r10,%%r10\n":::);
diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index ae0e263..1f83553 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -52,9 +52,9 @@ void arch_cpu_idle(void)
 		 * interrupts enabled, some don't.
 		 */
 		if (irqs_disabled())
-			local_irq_enable();
+			raw_local_irq_enable();
 	} else {
-		local_irq_enable();
+		raw_local_irq_enable();
 		/*
 		 * Go into low thread priority and possibly
 		 * low power mode.
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 19225ec..dd5f985 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -36,7 +36,7 @@ extern asmlinkage void ret_from_kernel_thread(void);
 void arch_cpu_idle(void)
 {
 	wait_for_interrupt();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void show_regs(struct pt_regs *regs)
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index f7f1e64..2b85096 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -33,10 +33,10 @@ void enabled_wait(void)
 		PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK;
 	clear_cpu_flag(CIF_NOHZ_DELAY);
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	/* Call the assembler magic in entry.S */
 	psw_idle(idle, psw_mask);
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 
 	/* Account time spent with enabled wait psw loaded as idle time. */
 	raw_write_seqcount_begin(&idle->seqcount);
@@ -123,7 +123,7 @@ void arch_cpu_idle_enter(void)
 void arch_cpu_idle(void)
 {
 	enabled_wait();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void arch_cpu_idle_exit(void)
diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
index 0dc0f52..f598149 100644
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -22,7 +22,7 @@ static void (*sh_idle)(void);
 void default_idle(void)
 {
 	set_bl_bit();
-	local_irq_enable();
+	raw_local_irq_enable();
 	/* Isn't this racy ? */
 	cpu_sleep();
 	clear_bl_bit();
diff --git a/arch/sparc/kernel/leon_pmc.c b/arch/sparc/kernel/leon_pmc.c
index 065e2d4..396f46b 100644
--- a/arch/sparc/kernel/leon_pmc.c
+++ b/arch/sparc/kernel/leon_pmc.c
@@ -50,7 +50,7 @@ static void pmc_leon_idle_fixup(void)
 	register unsigned int address = (unsigned int)leon3_irqctrl_regs;
 
 	/* Interrupts need to be enabled to not hang the CPU */
-	local_irq_enable();
+	raw_local_irq_enable();
 
 	__asm__ __volatile__ (
 		"wr	%%g0, %%asr19\n"
@@ -66,7 +66,7 @@ static void pmc_leon_idle_fixup(void)
 static void pmc_leon_idle(void)
 {
 	/* Interrupts need to be enabled to not hang the CPU */
-	local_irq_enable();
+	raw_local_irq_enable();
 
 	/* For systems without power-down, this will be no-op */
 	__asm__ __volatile__ ("wr	%g0, %asr19\n\t");
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index adfcaea..a023637 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -74,7 +74,7 @@ void arch_cpu_idle(void)
 {
 	if (sparc_idle)
 		(*sparc_idle)();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /* XXX cli/sti -> local_irq_xxx here, check this works once SMP is fixed. */
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index a75093b..6f8c782 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -62,11 +62,11 @@ void arch_cpu_idle(void)
 {
 	if (tlb_type != hypervisor) {
 		touch_nmi_watchdog();
-		local_irq_enable();
+		raw_local_irq_enable();
 	} else {
 		unsigned long pstate;
 
-		local_irq_enable();
+		raw_local_irq_enable();
 
                 /* The sun4v sleeping code requires that we have PSTATE.IE cleared over
                  * the cpu sleep hypervisor call.
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 3bed095..9505a7e 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -217,7 +217,7 @@ void arch_cpu_idle(void)
 {
 	cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
 	um_idle_sleep();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 int __cant_sleep(void) {
diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index e039a93..29dd27b 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -88,8 +88,6 @@ static inline void __mwaitx(unsigned long eax, unsigned long ebx,
 
 static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
-	trace_hardirqs_on();
-
 	mds_idle_clear_cpu_buffers();
 	/* "mwait %eax, %ecx;" */
 	asm volatile("sti; .byte 0x0f, 0x01, 0xc9;"
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ba4593a..145a7ac 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -685,7 +685,7 @@ void arch_cpu_idle(void)
  */
 void __cpuidle default_idle(void)
 {
-	safe_halt();
+	raw_safe_halt();
 }
 #if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
 EXPORT_SYMBOL(default_idle);
@@ -736,6 +736,8 @@ void stop_this_cpu(void *dummy)
 /*
  * AMD Erratum 400 aware idle routine. We handle it the same way as C3 power
  * states (local apic timer and TSC stop).
+ *
+ * XXX this function is completely buggered vs RCU and tracing.
  */
 static void amd_e400_idle(void)
 {
@@ -757,9 +759,9 @@ static void amd_e400_idle(void)
 	 * The switch back from broadcast mode needs to be called with
 	 * interrupts disabled.
 	 */
-	local_irq_disable();
+	raw_local_irq_disable();
 	tick_broadcast_exit();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /*
@@ -801,9 +803,9 @@ static __cpuidle void mwait_idle(void)
 		if (!need_resched())
 			__sti_mwait(0, 0);
 		else
-			local_irq_enable();
+			raw_local_irq_enable();
 	} else {
-		local_irq_enable();
+		raw_local_irq_enable();
 	}
 	__current_clr_polling();
 }
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 24d0ee2..c6932b8 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -78,7 +78,7 @@ void __weak arch_cpu_idle_dead(void) { }
 void __weak arch_cpu_idle(void)
 {
 	cpu_idle_force_poll = 1;
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /**
@@ -94,9 +94,35 @@ void __cpuidle default_idle_call(void)
 
 		trace_cpu_idle(1, smp_processor_id());
 		stop_critical_timings();
+
+		/*
+		 * arch_cpu_idle() is supposed to enable IRQs, however
+		 * we can't do that because of RCU and tracing.
+		 *
+		 * Trace IRQs enable here, then switch off RCU, and have
+		 * arch_cpu_idle() use raw_local_irq_enable(). Note that
+		 * rcu_idle_enter() relies on lockdep IRQ state, so switch that
+		 * last -- this is very similar to the entry code.
+		 */
+		trace_hardirqs_on_prepare();
+		lockdep_hardirqs_on_prepare(_THIS_IP_);
 		rcu_idle_enter();
+		lockdep_hardirqs_on(_THIS_IP_);
+
 		arch_cpu_idle();
+
+		/*
+		 * OK, so IRQs are enabled here, but RCU needs them disabled to
+		 * turn itself back on.. funny thing is that disabling IRQs
+		 * will cause tracing, which needs RCU. Jump through hoops to
+		 * make it 'work'.
+		 */
+		raw_local_irq_disable();
+		lockdep_hardirqs_off(_THIS_IP_);
 		rcu_idle_exit();
+		lockdep_hardirqs_on(_THIS_IP_);
+		raw_local_irq_enable();
+
 		start_critical_timings();
 		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 	}
