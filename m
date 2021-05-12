Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D4037BB99
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 13:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhELLRG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 07:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhELLRF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 07:17:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF43FC061574;
        Wed, 12 May 2021 04:15:57 -0700 (PDT)
Date:   Wed, 12 May 2021 11:15:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620818155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IFt9iNOxubuLMOoxpYIWZpruFL3OD+fJv7HG6qe/Teo=;
        b=nSZDr0agiIxIblBAJ/dqzWB5OEa5KuZFoLlh3ACs5PW3vJc1nwgmonBmVOTwKCwCHfzOBL
        YFdvvySztOM8a865lG8oHdtHiLLfAmYfElQiGhuOqf+YxDsAwsLpgC1uT2vKyG/ZqMjCyj
        UlwXL6N9XxF+z6vkI8Wsd0jBhBG9B1244OYUYid7Fbm+mlHBwPjJ4wTSIS0SEs/uWxZR9M
        wktRDIvDj8UqaXSHZ/fIcCDYPC5EqiKC3cGAgfkv3G+mhfOY7sFw3GMFB88srHvD5BTcbC
        fQD3HdaQoeJKKAsjNrZGTzPmD0BNbrv7VxAorz02CWST4k6TkhxpyIWNMzW3Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620818155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IFt9iNOxubuLMOoxpYIWZpruFL3OD+fJv7HG6qe/Teo=;
        b=pWEtzRL0CznIzup9aTTd2KbA5n75F56pA9Txd6a67/u6G55Oqm6n1q5h+NNuoYH2zFrVvD
        sJnaZ2TTvjV7DOBQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Initialize the idle task with
 preemption disabled
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210512094636.2958515-1-valentin.schneider@arm.com>
References: <20210512094636.2958515-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162081815405.29796.14574924529325899839.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674
Gitweb:        https://git.kernel.org/tip/f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 12 May 2021 10:46:36 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 13:01:45 +02:00

sched/core: Initialize the idle task with preemption disabled

As pointed out by commit

  de9b8f5dcbd9 ("sched: Fix crash trying to dequeue/enqueue the idle thread")

init_idle() can and will be invoked more than once on the same idle
task. At boot time, it is invoked for the boot CPU thread by
sched_init(). Then smp_init() creates the threads for all the secondary
CPUs and invokes init_idle() on them.

As the hotplug machinery brings the secondaries to life, it will issue
calls to idle_thread_get(), which itself invokes init_idle() yet again.
In this case it's invoked twice more per secondary: at _cpu_up(), and at
bringup_cpu().

Given smp_init() already initializes the idle tasks for all *possible*
CPUs, no further initialization should be required. Now, removing
init_idle() from idle_thread_get() exposes some interesting expectations
with regards to the idle task's preempt_count: the secondary startup always
issues a preempt_disable(), requiring some reset of the preempt count to 0
between hot-unplug and hotplug, which is currently served by
idle_thread_get() -> idle_init().

Given the idle task is supposed to have preemption disabled once and never
see it re-enabled, it seems that what we actually want is to initialize its
preempt_count to PREEMPT_DISABLED and leave it there. Do that, and remove
init_idle() from idle_thread_get().

Secondary startups were patched via coccinelle:

  @begone@
  @@

  -preempt_disable();
  ...
  cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210512094636.2958515-1-valentin.schneider@arm.com
---
 arch/alpha/kernel/smp.c          | 1 -
 arch/arc/kernel/smp.c            | 1 -
 arch/arm/kernel/smp.c            | 1 -
 arch/arm64/include/asm/preempt.h | 2 +-
 arch/arm64/kernel/smp.c          | 1 -
 arch/csky/kernel/smp.c           | 1 -
 arch/ia64/kernel/smpboot.c       | 1 -
 arch/mips/kernel/smp.c           | 1 -
 arch/openrisc/kernel/smp.c       | 2 --
 arch/parisc/kernel/smp.c         | 1 -
 arch/powerpc/kernel/smp.c        | 1 -
 arch/riscv/kernel/smpboot.c      | 1 -
 arch/s390/include/asm/preempt.h  | 4 ++--
 arch/s390/kernel/smp.c           | 1 -
 arch/sh/kernel/smp.c             | 2 --
 arch/sparc/kernel/smp_32.c       | 1 -
 arch/sparc/kernel/smp_64.c       | 3 ---
 arch/x86/include/asm/preempt.h   | 2 +-
 arch/x86/kernel/smpboot.c        | 1 -
 arch/xtensa/kernel/smp.c         | 1 -
 include/asm-generic/preempt.h    | 2 +-
 init/main.c                      | 6 +-----
 kernel/fork.c                    | 2 +-
 kernel/sched/core.c              | 2 +-
 kernel/smpboot.c                 | 1 -
 25 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index f4dd9f3..4b2575f 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -166,7 +166,6 @@ smp_callin(void)
 	DBGS(("smp_callin: commencing CPU %d current %p active_mm %p\n",
 	      cpuid, current, current->active_mm));
 
-	preempt_disable();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
index 52906d3..db0e104 100644
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -189,7 +189,6 @@ void start_kernel_secondary(void)
 	pr_info("## CPU%u LIVE ##: Executing Code...\n", cpu);
 
 	local_irq_enable();
-	preempt_disable();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 7467924..c7bb168 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -432,7 +432,6 @@ asmlinkage void secondary_start_kernel(void)
 #endif
 	pr_debug("CPU%u: Booted secondary processor\n", cpu);
 
-	preempt_disable();
 	trace_hardirqs_off();
 
 	/*
diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 80e946b..e83f098 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -23,7 +23,7 @@ static inline void preempt_count_set(u64 pc)
 } while (0)
 
 #define init_idle_preempt_count(p, cpu) do { \
-	task_thread_info(p)->preempt_count = PREEMPT_ENABLED; \
+	task_thread_info(p)->preempt_count = PREEMPT_DISABLED; \
 } while (0)
 
 static inline void set_preempt_need_resched(void)
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index dcd7041..6671000 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -224,7 +224,6 @@ asmlinkage notrace void secondary_start_kernel(void)
 		init_gic_priority_masking();
 
 	rcu_cpu_starting(cpu);
-	preempt_disable();
 	trace_hardirqs_off();
 
 	/*
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 0f9f5ee..e299353 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -281,7 +281,6 @@ void csky_start_secondary(void)
 	pr_info("CPU%u Online: %s...\n", cpu, __func__);
 
 	local_irq_enable();
-	preempt_disable();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
diff --git a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
index 49b4885..d10f780 100644
--- a/arch/ia64/kernel/smpboot.c
+++ b/arch/ia64/kernel/smpboot.c
@@ -441,7 +441,6 @@ start_secondary (void *unused)
 #endif
 	efi_map_pal_code();
 	cpu_init();
-	preempt_disable();
 	smp_callin();
 
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index ef86fba..d542fb7 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -348,7 +348,6 @@ asmlinkage void start_secondary(void)
 	 */
 
 	calibrate_delay();
-	preempt_disable();
 	cpu = smp_processor_id();
 	cpu_data[cpu].udelay_val = loops_per_jiffy;
 
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 48e1092..415e209 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -145,8 +145,6 @@ asmlinkage __init void secondary_start_kernel(void)
 	set_cpu_online(cpu, true);
 
 	local_irq_enable();
-
-	preempt_disable();
 	/*
 	 * OK, it's off to the idle thread for us
 	 */
diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
index 10227f6..1405b60 100644
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -302,7 +302,6 @@ void __init smp_callin(unsigned long pdce_proc)
 #endif
 
 	smp_cpu_init(slave_id);
-	preempt_disable();
 
 	flush_cache_all_local(); /* start with known state */
 	flush_tlb_all_local(NULL);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 2e05c78..6c6e4d9 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1547,7 +1547,6 @@ void start_secondary(void *unused)
 	smp_store_cpu_info(cpu);
 	set_dec(tb_ticks_per_jiffy);
 	rcu_cpu_starting(cpu);
-	preempt_disable();
 	cpu_callin_map[cpu] = 1;
 
 	if (smp_ops->setup_cpu)
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 9a408e2..bd82375 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -180,7 +180,6 @@ asmlinkage __visible void smp_callin(void)
 	 * Disable preemption before enabling interrupts, so we don't try to
 	 * schedule a CPU that hasn't actually started yet.
 	 */
-	preempt_disable();
 	local_irq_enable();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index b49e049..23ff51b 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -32,7 +32,7 @@ static inline void preempt_count_set(int pc)
 #define init_task_preempt_count(p)	do { } while (0)
 
 #define init_idle_preempt_count(p, cpu)	do { \
-	S390_lowcore.preempt_count = PREEMPT_ENABLED; \
+	S390_lowcore.preempt_count = PREEMPT_DISABLED; \
 } while (0)
 
 static inline void set_preempt_need_resched(void)
@@ -91,7 +91,7 @@ static inline void preempt_count_set(int pc)
 #define init_task_preempt_count(p)	do { } while (0)
 
 #define init_idle_preempt_count(p, cpu)	do { \
-	S390_lowcore.preempt_count = PREEMPT_ENABLED; \
+	S390_lowcore.preempt_count = PREEMPT_DISABLED; \
 } while (0)
 
 static inline void set_preempt_need_resched(void)
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 2fec2b8..111909a 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -878,7 +878,6 @@ static void smp_init_secondary(void)
 	restore_access_regs(S390_lowcore.access_regs_save_area);
 	cpu_init();
 	rcu_cpu_starting(cpu);
-	preempt_disable();
 	init_cpu_timer();
 	vtime_init();
 	vdso_getcpu_init();
diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index 372acdc..65924d9 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -186,8 +186,6 @@ asmlinkage void start_secondary(void)
 
 	per_cpu_trap_init();
 
-	preempt_disable();
-
 	notify_cpu_starting(cpu);
 
 	local_irq_enable();
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 50c127a..22b148e 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -348,7 +348,6 @@ static void sparc_start_secondary(void *arg)
 	 */
 	arch_cpu_pre_starting(arg);
 
-	preempt_disable();
 	cpu = smp_processor_id();
 
 	notify_cpu_starting(cpu);
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index e38d8bf..ae5faa1 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -138,9 +138,6 @@ void smp_callin(void)
 
 	set_cpu_online(cpuid, true);
 
-	/* idle thread is expected to have preempt disabled */
-	preempt_disable();
-
 	local_irq_enable();
 
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index f8cb8af..fe5efbc 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -44,7 +44,7 @@ static __always_inline void preempt_count_set(int pc)
 #define init_task_preempt_count(p) do { } while (0)
 
 #define init_idle_preempt_count(p, cpu) do { \
-	per_cpu(__preempt_count, (cpu)) = PREEMPT_ENABLED; \
+	per_cpu(__preempt_count, (cpu)) = PREEMPT_DISABLED; \
 } while (0)
 
 /*
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0ad5214..0936f5b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -236,7 +236,6 @@ static void notrace start_secondary(void *unused)
 	cpu_init();
 	rcu_cpu_starting(raw_smp_processor_id());
 	x86_cpuinit.early_percpu_clock_init();
-	preempt_disable();
 	smp_callin();
 
 	enable_start_cpu0 = 0;
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index cd85a7a..1254da0 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -145,7 +145,6 @@ void secondary_start_kernel(void)
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
 	enter_lazy_tlb(mm, current);
 
-	preempt_disable();
 	trace_hardirqs_off();
 
 	calibrate_delay();
diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index d683f5e..b4d43a4 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -29,7 +29,7 @@ static __always_inline void preempt_count_set(int pc)
 } while (0)
 
 #define init_idle_preempt_count(p, cpu) do { \
-	task_thread_info(p)->preempt_count = PREEMPT_ENABLED; \
+	task_thread_info(p)->preempt_count = PREEMPT_DISABLED; \
 } while (0)
 
 static __always_inline void set_preempt_need_resched(void)
diff --git a/init/main.c b/init/main.c
index eb01e12..7b027d9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -941,11 +941,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	 * time - but meanwhile we still have a functioning scheduler.
 	 */
 	sched_init();
-	/*
-	 * Disable preemption - early bootup scheduling is extremely
-	 * fragile until we cpu_idle() for the first time.
-	 */
-	preempt_disable();
+
 	if (WARN(!irqs_disabled(),
 		 "Interrupts were enabled *very* early, fixing it\n"))
 		local_irq_disable();
diff --git a/kernel/fork.c b/kernel/fork.c
index e7fd928..ace4631 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2412,7 +2412,7 @@ static inline void init_idle_pids(struct task_struct *idle)
 	}
 }
 
-struct task_struct *fork_idle(int cpu)
+struct task_struct * __init fork_idle(int cpu)
 {
 	struct task_struct *task;
 	struct kernel_clone_args args = {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 55b2d93..9d00f49 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8227,7 +8227,7 @@ void show_state_filter(unsigned long state_filter)
  * NOTE: this function does not set the idle thread's NEED_RESCHED
  * flag, to make booting more robust.
  */
-void init_idle(struct task_struct *idle, int cpu)
+void __init init_idle(struct task_struct *idle, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index f25208e..e416304 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -33,7 +33,6 @@ struct task_struct *idle_thread_get(unsigned int cpu)
 
 	if (!tsk)
 		return ERR_PTR(-ENOMEM);
-	init_idle(tsk, cpu);
 	return tsk;
 }
 
