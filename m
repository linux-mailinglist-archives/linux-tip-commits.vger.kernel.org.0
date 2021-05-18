Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BB1387935
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 May 2021 14:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244549AbhERMyC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 18 May 2021 08:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244238AbhERMyB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 18 May 2021 08:54:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FADCC061573;
        Tue, 18 May 2021 05:52:43 -0700 (PDT)
Date:   Tue, 18 May 2021 12:52:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621342360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+5B4L2l45iVUWq5xO8x1wE11+/M3UlE3CB7C4GTh8O4=;
        b=TizdyBTsNCmYY2ZoTOnqOfdKxGpIknym/hLAdcq2FnjorYlos8wINr9MJ5Y+qM+jdjbZxq
        ZSjRGYvOYFXfJBeBZpHE0ORfS7UcDbuVqoL093YwciTFdlTm/o+3wwvibMjeXEyJa6GHXz
        uYbu4m7vBSVZG+qBU/XIurSqq5V23y2TXKUBXX9uRhfz3Sl9msyX0UFr2WTrx+izLRRPYs
        zypSCw1SPnCguF2mDaw7dbXNSCdiWbhFCjQVdxSxLqWvEoCootvBcr6iHIA5meYbcKzLnK
        gvgUxsfUQbk9IDZ4F7xB1nO9ZYXTaur7k0TXcXEeDCvuHKaCKpVW+XZIsG5PpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621342360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+5B4L2l45iVUWq5xO8x1wE11+/M3UlE3CB7C4GTh8O4=;
        b=PUYydTdjErI6/UR6DJtzW9ifv882pzP3XPNME0I7k0brOw2g4rSTrTSqgtip3o+KiX8HFU
        mIStkwIiKzg6INBA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu: Init AP exception handling from cpu_init_secondary()
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87k0o6gtvu.ffs@nanos.tec.linutronix.de>
References: <87k0o6gtvu.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <162134235888.29796.6870292258763745495.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     b1efd0ff4bd16e8bb8607ba566b03f2024a830bb
Gitweb:        https://git.kernel.org/tip/b1efd0ff4bd16e8bb8607ba566b03f2024a830bb
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 10 May 2021 23:29:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 May 2021 14:49:21 +02:00

x86/cpu: Init AP exception handling from cpu_init_secondary()

SEV-ES guests require properly setup task register with which the TSS
descriptor in the GDT can be located so that the IST-type #VC exception
handler which they need to function properly, can be executed.

This setup needs to happen before attempting to load microcode in
ucode_cpu_init() on secondary CPUs which can cause such #VC exceptions.

Simplify the machinery by running that exception setup from a new function
cpu_init_secondary() and explicitly call cpu_init_exception_handling() for
the boot CPU before cpu_init(). The latter prepares for fixing and
simplifying the exception/IST setup on the boot CPU.

There should be no functional changes resulting from this patch.

[ tglx: Reworked it so cpu_init_exception_handling() stays seperate ]

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lai Jiangshan <laijs@linux.alibaba.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>                                                                                                                                                                                                                        
Link: https://lore.kernel.org/r/87k0o6gtvu.ffs@nanos.tec.linutronix.de


---
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/kernel/cpu/common.c     | 28 +++++++++++++++-------------
 arch/x86/kernel/smpboot.c        |  3 +--
 arch/x86/kernel/traps.c          |  4 +---
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 556b2b1..364d0e4 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -663,6 +663,7 @@ extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
 extern void load_percpu_segment(int);
 extern void cpu_init(void);
+extern void cpu_init_secondary(void);
 extern void cpu_init_exception_handling(void);
 extern void cr4_init(void);
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a1b756c..212e8bc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1938,13 +1938,12 @@ void cpu_init_exception_handling(void)
 
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
- * initialized (naturally) in the bootstrap process, such as the GDT
- * and IDT. We reload them nevertheless, this function acts as a
- * 'CPU state barrier', nothing should get across.
+ * initialized (naturally) in the bootstrap process, such as the GDT.  We
+ * reload it nevertheless, this function acts as a 'CPU state barrier',
+ * nothing should get across.
  */
 void cpu_init(void)
 {
-	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
 	struct task_struct *cur = current;
 	int cpu = raw_smp_processor_id();
 
@@ -1957,8 +1956,6 @@ void cpu_init(void)
 	    early_cpu_to_node(cpu) != NUMA_NO_NODE)
 		set_numa_node(early_cpu_to_node(cpu));
 #endif
-	setup_getcpu(cpu);
-
 	pr_debug("Initializing CPU#%d\n", cpu);
 
 	if (IS_ENABLED(CONFIG_X86_64) || cpu_feature_enabled(X86_FEATURE_VME) ||
@@ -1970,7 +1967,6 @@ void cpu_init(void)
 	 * and set up the GDT descriptor:
 	 */
 	switch_to_new_gdt(cpu);
-	load_current_idt();
 
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		loadsegment(fs, 0);
@@ -1990,12 +1986,6 @@ void cpu_init(void)
 	initialize_tlbstate_and_flush();
 	enter_lazy_tlb(&init_mm, cur);
 
-	/* Initialize the TSS. */
-	tss_setup_ist(tss);
-	tss_setup_io_bitmap(tss);
-	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
-
-	load_TR_desc();
 	/*
 	 * sp0 points to the entry trampoline stack regardless of what task
 	 * is running.
@@ -2017,6 +2007,18 @@ void cpu_init(void)
 	load_fixmap_gdt(cpu);
 }
 
+#ifdef CONFIG_SMP
+void cpu_init_secondary(void)
+{
+	/*
+	 * Relies on the BP having set-up the IDT tables, which are loaded
+	 * on this CPU in cpu_init_exception_handling().
+	 */
+	cpu_init_exception_handling();
+	cpu_init();
+}
+#endif
+
 /*
  * The microcode loader calls this upon late microcode load to recheck features,
  * only when microcode has been updated. Caller holds microcode_mutex and CPU
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 7770245..2ed45b0 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -232,8 +232,7 @@ static void notrace start_secondary(void *unused)
 	load_cr3(swapper_pg_dir);
 	__flush_tlb_all();
 #endif
-	cpu_init_exception_handling();
-	cpu_init();
+	cpu_init_secondary();
 	rcu_cpu_starting(raw_smp_processor_id());
 	x86_cpuinit.early_percpu_clock_init();
 	preempt_disable();
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 853ea7a..41f7dc4 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1162,9 +1162,7 @@ void __init trap_init(void)
 
 	idt_setup_traps();
 
-	/*
-	 * Should be a barrier for any external CPU state:
-	 */
+	cpu_init_exception_handling();
 	cpu_init();
 
 	idt_setup_ist_traps();
