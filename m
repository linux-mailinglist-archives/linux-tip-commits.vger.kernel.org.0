Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE821FE6F6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 22:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKOVNM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 16:13:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44633 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfKOVMl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 16:12:41 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVitR-0007Sg-9Y; Fri, 15 Nov 2019 22:12:37 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8A93E1C18D6;
        Fri, 15 Nov 2019 22:12:30 +0100 (CET)
Date:   Fri, 15 Nov 2019 21:12:30 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/cpu: Unify cpu_init()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191113210104.002114856@linutronix.de>
References: <20191113210104.002114856@linutronix.de>
MIME-Version: 1.0
Message-ID: <157385235053.12247.12605333592273145378.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/iopl branch of tip:

Commit-ID:     fff628d736f261ab0bebb94f97678710f48df75e
Gitweb:        https://git.kernel.org/tip/fff628d736f261ab0bebb94f97678710f48df75e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Nov 2019 21:42:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Nov 2019 20:15:00 +01:00

x86/cpu: Unify cpu_init()

Similar to copy_thread_tls() the 32bit and 64bit implementations of
cpu_init() are very similar and unification avoids duplicate changes in the
future.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191113210104.002114856@linutronix.de


---
 arch/x86/kernel/cpu/common.c | 173 ++++++++++++----------------------
 1 file changed, 65 insertions(+), 108 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9ae7d1b..d52ec1a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -53,10 +53,7 @@
 #include <asm/microcode_intel.h>
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
-
-#ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/uv/uv.h>
-#endif
 
 #include "cpu.h"
 
@@ -1749,7 +1746,7 @@ static void wait_for_master_cpu(int cpu)
 }
 
 #ifdef CONFIG_X86_64
-static void setup_getcpu(int cpu)
+static inline void setup_getcpu(int cpu)
 {
 	unsigned long cpudata = vdso_encode_cpunode(cpu, early_cpu_to_node(cpu));
 	struct desc_struct d = { };
@@ -1769,7 +1766,43 @@ static void setup_getcpu(int cpu)
 
 	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_CPUNODE, &d, DESCTYPE_S);
 }
+
+static inline void ucode_cpu_init(int cpu)
+{
+	if (cpu)
+		load_ucode_ap();
+}
+
+static inline void tss_setup_ist(struct tss_struct *tss)
+{
+	/* Set up the per-CPU TSS IST stacks */
+	tss->x86_tss.ist[IST_INDEX_DF] = __this_cpu_ist_top_va(DF);
+	tss->x86_tss.ist[IST_INDEX_NMI] = __this_cpu_ist_top_va(NMI);
+	tss->x86_tss.ist[IST_INDEX_DB] = __this_cpu_ist_top_va(DB);
+	tss->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
+}
+
+static inline void gdt_setup_doublefault_tss(int cpu) { }
+
+#else /* CONFIG_X86_64 */
+
+static inline void setup_getcpu(int cpu) { }
+
+static inline void ucode_cpu_init(int cpu)
+{
+	show_ucode_info_early();
+}
+
+static inline void tss_setup_ist(struct tss_struct *tss) { }
+
+static inline void gdt_setup_doublefault_tss(int cpu)
+{
+#ifdef CONFIG_DOUBLEFAULT
+	/* Set up the doublefault TSS pointer in the GDT */
+	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
 #endif
+}
+#endif /* !CONFIG_X86_64 */
 
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
@@ -1777,21 +1810,15 @@ static void setup_getcpu(int cpu)
  * and IDT. We reload them nevertheless, this function acts as a
  * 'CPU state barrier', nothing should get across.
  */
-#ifdef CONFIG_X86_64
-
 void cpu_init(void)
 {
+	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
+	struct task_struct *cur = current;
 	int cpu = raw_smp_processor_id();
-	struct task_struct *me;
-	struct tss_struct *t;
-	int i;
 
 	wait_for_master_cpu(cpu);
 
-	if (cpu)
-		load_ucode_ap();
-
-	t = &per_cpu(cpu_tss_rw, cpu);
+	ucode_cpu_init(cpu);
 
 #ifdef CONFIG_NUMA
 	if (this_cpu_read(numa_node) == 0 &&
@@ -1800,63 +1827,48 @@ void cpu_init(void)
 #endif
 	setup_getcpu(cpu);
 
-	me = current;
-
 	pr_debug("Initializing CPU#%d\n", cpu);
 
-	cr4_clear_bits(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
+	if (IS_ENABLED(CONFIG_X86_64) || cpu_feature_enabled(X86_FEATURE_VME) ||
+	    boot_cpu_has(X86_FEATURE_TSC) || boot_cpu_has(X86_FEATURE_DE))
+		cr4_clear_bits(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
 
 	/*
 	 * Initialize the per-CPU GDT with the boot GDT,
 	 * and set up the GDT descriptor:
 	 */
-
 	switch_to_new_gdt(cpu);
-	loadsegment(fs, 0);
-
 	load_current_idt();
 
-	memset(me->thread.tls_array, 0, GDT_ENTRY_TLS_ENTRIES * 8);
-	syscall_init();
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		loadsegment(fs, 0);
+		memset(cur->thread.tls_array, 0, GDT_ENTRY_TLS_ENTRIES * 8);
+		syscall_init();
 
-	wrmsrl(MSR_FS_BASE, 0);
-	wrmsrl(MSR_KERNEL_GS_BASE, 0);
-	barrier();
+		wrmsrl(MSR_FS_BASE, 0);
+		wrmsrl(MSR_KERNEL_GS_BASE, 0);
+		barrier();
 
-	x86_configure_nx();
-	x2apic_setup();
-
-	/*
-	 * set up and load the per-CPU TSS
-	 */
-	if (!t->x86_tss.ist[0]) {
-		t->x86_tss.ist[IST_INDEX_DF] = __this_cpu_ist_top_va(DF);
-		t->x86_tss.ist[IST_INDEX_NMI] = __this_cpu_ist_top_va(NMI);
-		t->x86_tss.ist[IST_INDEX_DB] = __this_cpu_ist_top_va(DB);
-		t->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
+		x2apic_setup();
 	}
 
-	t->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET;
-
-	/*
-	 * <= is required because the CPU will access up to
-	 * 8 bits beyond the end of the IO permission bitmap.
-	 */
-	for (i = 0; i <= IO_BITMAP_LONGS; i++)
-		t->io_bitmap[i] = ~0UL;
-
 	mmgrab(&init_mm);
-	me->active_mm = &init_mm;
-	BUG_ON(me->mm);
+	cur->active_mm = &init_mm;
+	BUG_ON(cur->mm);
 	initialize_tlbstate_and_flush();
-	enter_lazy_tlb(&init_mm, me);
+	enter_lazy_tlb(&init_mm, cur);
 
-	/*
-	 * Initialize the TSS.  sp0 points to the entry trampoline stack
-	 * regardless of what task is running.
-	 */
+	/* Initialize the TSS. */
+	tss_setup_ist(tss);
+	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET;
+	memset(tss->io_bitmap, 0xff, sizeof(tss->io_bitmap));
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
+
 	load_TR_desc();
+	/*
+	 * sp0 points to the entry trampoline stack regardless of what task
+	 * is running.
+	 */
 	load_sp0((unsigned long)(cpu_entry_stack(cpu) + 1));
 
 	load_mm_ldt(&init_mm);
@@ -1864,6 +1876,8 @@ void cpu_init(void)
 	clear_all_debug_regs();
 	dbg_restore_debug_regs();
 
+	gdt_setup_doublefault_tss(cpu);
+
 	fpu__init_cpu();
 
 	if (is_uv_system())
@@ -1872,63 +1886,6 @@ void cpu_init(void)
 	load_fixmap_gdt(cpu);
 }
 
-#else
-
-void cpu_init(void)
-{
-	int cpu = smp_processor_id();
-	struct task_struct *curr = current;
-	struct tss_struct *t = &per_cpu(cpu_tss_rw, cpu);
-
-	wait_for_master_cpu(cpu);
-
-	show_ucode_info_early();
-
-	pr_info("Initializing CPU#%d\n", cpu);
-
-	if (cpu_feature_enabled(X86_FEATURE_VME) ||
-	    boot_cpu_has(X86_FEATURE_TSC) ||
-	    boot_cpu_has(X86_FEATURE_DE))
-		cr4_clear_bits(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
-
-	load_current_idt();
-	switch_to_new_gdt(cpu);
-
-	/*
-	 * Set up and load the per-CPU TSS and LDT
-	 */
-	mmgrab(&init_mm);
-	curr->active_mm = &init_mm;
-	BUG_ON(curr->mm);
-	initialize_tlbstate_and_flush();
-	enter_lazy_tlb(&init_mm, curr);
-
-	/*
-	 * Initialize the TSS.  sp0 points to the entry trampoline stack
-	 * regardless of what task is running.
-	 */
-	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
-	load_TR_desc();
-	load_sp0((unsigned long)(cpu_entry_stack(cpu) + 1));
-
-	load_mm_ldt(&init_mm);
-
-	t->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET;
-
-#ifdef CONFIG_DOUBLEFAULT
-	/* Set up doublefault TSS pointer in the GDT */
-	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
-#endif
-
-	clear_all_debug_regs();
-	dbg_restore_debug_regs();
-
-	fpu__init_cpu();
-
-	load_fixmap_gdt(cpu);
-}
-#endif
-
 /*
  * The microcode loader calls this upon late microcode load to recheck features,
  * only when microcode has been updated. Caller holds microcode_mutex and CPU
