Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D4840C8AE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhIOPum (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:50:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41494 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbhIOPuk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:50:40 -0400
Date:   Wed, 15 Sep 2021 15:49:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pOF/pCkH1iN0iLIxl1I05RFAqpfEvp5YKgL3fDsPT1M=;
        b=Krfr8oGD12V3e7Ke36Zxm0jpHasuq/GsTP4sMUrqAtCrchL65nJTb8pOIJuo9W0am/1Akn
        K+n134JqNW+DEtBEShgxyBEhqJvXfJupf3MmGMNp80/jFtdq71yrZ68lPpTFF/Ika5VpLs
        DohB+mnDj5SX0EbJyqrSDq11DelfWEz10NliKr30kuFpbhx4FXoaeTuoLG11mMilMMbQ1S
        ZvNtiJxup0Q9khcj6GWT5uryq7xCtQmZE34UW/OWiIoA6RIFDaFdaOV734bhGQmwxoBK30
        AbjYfPvoXpehj2uv/U7Euq1SkhRVsBdAT3kUqfwx5tTCqbRaSa46wTjQiEb3Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pOF/pCkH1iN0iLIxl1I05RFAqpfEvp5YKgL3fDsPT1M=;
        b=MZLaGbnG1ji6/+8ucrCsuzSJ+xu8rIVZ9Wyf7vGHgurSrZ0Ix8Hej5IpivcCb6GmTdOgwi
        Rfod8Z0Fr6TeOoDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/xen: Rework the xen_{cpu,irq,mmu}_opsarrays
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095149.057262522@infradead.org>
References: <20210624095149.057262522@infradead.org>
MIME-Version: 1.0
Message-ID: <163172095689.25758.4959745468641148755.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     723a80b05f0b118c53a69ff20384d28b84219afa
Gitweb:        https://git.kernel.org/tip/723a80b05f0b118c53a69ff20384d28b84219afa
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:22 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:51 +02:00

x86/xen: Rework the xen_{cpu,irq,mmu}_opsarrays

In order to allow objtool to make sense of all the various paravirt
functions, it needs to either parse whole pv_ops[] tables, or observe
individual assignments in the form:

  bf87:       48 c7 05 00 00 00 00 00 00 00 00        movq   $0x0,0x0(%rip)
    bf92 <xen_init_spinlocks+0x5f>
    bf8a: R_X86_64_PC32     pv_ops+0x268

As is, xen_cpu_ops[] is at offset +0 in pv_ops[] and could thus be
parsed as a 'normal' pv_ops[] table, however xen_irq_ops[] and
xen_mmu_ops[] are not.

Worse, both the latter two are compiled into the individual assignment
for by current GCC, but that's not something one can rely on.

Therefore, convert all three into full pv_ops[] tables. This has the
benefit of not needing to teach objtool about the offsets and
resulting in more conservative code-gen.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20210624095149.057262522@infradead.org
---
 arch/x86/xen/enlighten_pv.c | 66 +++++++++++++-------------
 arch/x86/xen/irq.c          | 17 ++++---
 arch/x86/xen/mmu_pv.c       | 90 ++++++++++++++++++------------------
 3 files changed, 90 insertions(+), 83 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 2b1a8ba..6ed0af7 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1050,52 +1050,54 @@ static const struct pv_info xen_info __initconst = {
 	.name = "Xen",
 };
 
-static const struct pv_cpu_ops xen_cpu_ops __initconst = {
-	.cpuid = xen_cpuid,
+static const typeof(pv_ops) xen_cpu_ops __initconst = {
+	.cpu = {
+		.cpuid = xen_cpuid,
 
-	.set_debugreg = xen_set_debugreg,
-	.get_debugreg = xen_get_debugreg,
+		.set_debugreg = xen_set_debugreg,
+		.get_debugreg = xen_get_debugreg,
 
-	.read_cr0 = xen_read_cr0,
-	.write_cr0 = xen_write_cr0,
+		.read_cr0 = xen_read_cr0,
+		.write_cr0 = xen_write_cr0,
 
-	.write_cr4 = xen_write_cr4,
+		.write_cr4 = xen_write_cr4,
 
-	.wbinvd = native_wbinvd,
+		.wbinvd = native_wbinvd,
 
-	.read_msr = xen_read_msr,
-	.write_msr = xen_write_msr,
+		.read_msr = xen_read_msr,
+		.write_msr = xen_write_msr,
 
-	.read_msr_safe = xen_read_msr_safe,
-	.write_msr_safe = xen_write_msr_safe,
+		.read_msr_safe = xen_read_msr_safe,
+		.write_msr_safe = xen_write_msr_safe,
 
-	.read_pmc = xen_read_pmc,
+		.read_pmc = xen_read_pmc,
 
-	.load_tr_desc = paravirt_nop,
-	.set_ldt = xen_set_ldt,
-	.load_gdt = xen_load_gdt,
-	.load_idt = xen_load_idt,
-	.load_tls = xen_load_tls,
-	.load_gs_index = xen_load_gs_index,
+		.load_tr_desc = paravirt_nop,
+		.set_ldt = xen_set_ldt,
+		.load_gdt = xen_load_gdt,
+		.load_idt = xen_load_idt,
+		.load_tls = xen_load_tls,
+		.load_gs_index = xen_load_gs_index,
 
-	.alloc_ldt = xen_alloc_ldt,
-	.free_ldt = xen_free_ldt,
+		.alloc_ldt = xen_alloc_ldt,
+		.free_ldt = xen_free_ldt,
 
-	.store_tr = xen_store_tr,
+		.store_tr = xen_store_tr,
 
-	.write_ldt_entry = xen_write_ldt_entry,
-	.write_gdt_entry = xen_write_gdt_entry,
-	.write_idt_entry = xen_write_idt_entry,
-	.load_sp0 = xen_load_sp0,
+		.write_ldt_entry = xen_write_ldt_entry,
+		.write_gdt_entry = xen_write_gdt_entry,
+		.write_idt_entry = xen_write_idt_entry,
+		.load_sp0 = xen_load_sp0,
 
 #ifdef CONFIG_X86_IOPL_IOPERM
-	.invalidate_io_bitmap = xen_invalidate_io_bitmap,
-	.update_io_bitmap = xen_update_io_bitmap,
+		.invalidate_io_bitmap = xen_invalidate_io_bitmap,
+		.update_io_bitmap = xen_update_io_bitmap,
 #endif
-	.io_delay = xen_io_delay,
+		.io_delay = xen_io_delay,
 
-	.start_context_switch = paravirt_start_context_switch,
-	.end_context_switch = xen_end_context_switch,
+		.start_context_switch = paravirt_start_context_switch,
+		.end_context_switch = xen_end_context_switch,
+	},
 };
 
 static void xen_restart(char *msg)
@@ -1231,7 +1233,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
 
 	/* Install Xen paravirt ops */
 	pv_info = xen_info;
-	pv_ops.cpu = xen_cpu_ops;
+	pv_ops.cpu = xen_cpu_ops.cpu;
 	paravirt_iret = xen_iret;
 	xen_init_irq_ops();
 
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index 2f695b5..4fe387e 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -94,17 +94,20 @@ static void xen_halt(void)
 		xen_safe_halt();
 }
 
-static const struct pv_irq_ops xen_irq_ops __initconst = {
-	.save_fl = PV_CALLEE_SAVE(xen_save_fl),
-	.irq_disable = PV_CALLEE_SAVE(xen_irq_disable),
-	.irq_enable = PV_CALLEE_SAVE(xen_irq_enable),
+static const typeof(pv_ops) xen_irq_ops __initconst = {
+	.irq = {
 
-	.safe_halt = xen_safe_halt,
-	.halt = xen_halt,
+		.save_fl = PV_CALLEE_SAVE(xen_save_fl),
+		.irq_disable = PV_CALLEE_SAVE(xen_irq_disable),
+		.irq_enable = PV_CALLEE_SAVE(xen_irq_enable),
+
+		.safe_halt = xen_safe_halt,
+		.halt = xen_halt,
+	},
 };
 
 void __init xen_init_irq_ops(void)
 {
-	pv_ops.irq = xen_irq_ops;
+	pv_ops.irq = xen_irq_ops.irq;
 	x86_init.irqs.intr_init = xen_init_IRQ;
 }
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index f3cafe5..b9a4f79 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2076,67 +2076,69 @@ static void xen_leave_lazy_mmu(void)
 	preempt_enable();
 }
 
-static const struct pv_mmu_ops xen_mmu_ops __initconst = {
-	.read_cr2 = __PV_IS_CALLEE_SAVE(xen_read_cr2),
-	.write_cr2 = xen_write_cr2,
+static const typeof(pv_ops) xen_mmu_ops __initconst = {
+	.mmu = {
+		.read_cr2 = __PV_IS_CALLEE_SAVE(xen_read_cr2),
+		.write_cr2 = xen_write_cr2,
 
-	.read_cr3 = xen_read_cr3,
-	.write_cr3 = xen_write_cr3_init,
+		.read_cr3 = xen_read_cr3,
+		.write_cr3 = xen_write_cr3_init,
 
-	.flush_tlb_user = xen_flush_tlb,
-	.flush_tlb_kernel = xen_flush_tlb,
-	.flush_tlb_one_user = xen_flush_tlb_one_user,
-	.flush_tlb_multi = xen_flush_tlb_multi,
-	.tlb_remove_table = tlb_remove_table,
+		.flush_tlb_user = xen_flush_tlb,
+		.flush_tlb_kernel = xen_flush_tlb,
+		.flush_tlb_one_user = xen_flush_tlb_one_user,
+		.flush_tlb_multi = xen_flush_tlb_multi,
+		.tlb_remove_table = tlb_remove_table,
 
-	.pgd_alloc = xen_pgd_alloc,
-	.pgd_free = xen_pgd_free,
+		.pgd_alloc = xen_pgd_alloc,
+		.pgd_free = xen_pgd_free,
 
-	.alloc_pte = xen_alloc_pte_init,
-	.release_pte = xen_release_pte_init,
-	.alloc_pmd = xen_alloc_pmd_init,
-	.release_pmd = xen_release_pmd_init,
+		.alloc_pte = xen_alloc_pte_init,
+		.release_pte = xen_release_pte_init,
+		.alloc_pmd = xen_alloc_pmd_init,
+		.release_pmd = xen_release_pmd_init,
 
-	.set_pte = xen_set_pte_init,
-	.set_pmd = xen_set_pmd_hyper,
+		.set_pte = xen_set_pte_init,
+		.set_pmd = xen_set_pmd_hyper,
 
-	.ptep_modify_prot_start = xen_ptep_modify_prot_start,
-	.ptep_modify_prot_commit = xen_ptep_modify_prot_commit,
+		.ptep_modify_prot_start = xen_ptep_modify_prot_start,
+		.ptep_modify_prot_commit = xen_ptep_modify_prot_commit,
 
-	.pte_val = PV_CALLEE_SAVE(xen_pte_val),
-	.pgd_val = PV_CALLEE_SAVE(xen_pgd_val),
+		.pte_val = PV_CALLEE_SAVE(xen_pte_val),
+		.pgd_val = PV_CALLEE_SAVE(xen_pgd_val),
 
-	.make_pte = PV_CALLEE_SAVE(xen_make_pte_init),
-	.make_pgd = PV_CALLEE_SAVE(xen_make_pgd),
+		.make_pte = PV_CALLEE_SAVE(xen_make_pte_init),
+		.make_pgd = PV_CALLEE_SAVE(xen_make_pgd),
 
-	.set_pud = xen_set_pud_hyper,
+		.set_pud = xen_set_pud_hyper,
 
-	.make_pmd = PV_CALLEE_SAVE(xen_make_pmd),
-	.pmd_val = PV_CALLEE_SAVE(xen_pmd_val),
+		.make_pmd = PV_CALLEE_SAVE(xen_make_pmd),
+		.pmd_val = PV_CALLEE_SAVE(xen_pmd_val),
 
-	.pud_val = PV_CALLEE_SAVE(xen_pud_val),
-	.make_pud = PV_CALLEE_SAVE(xen_make_pud),
-	.set_p4d = xen_set_p4d_hyper,
+		.pud_val = PV_CALLEE_SAVE(xen_pud_val),
+		.make_pud = PV_CALLEE_SAVE(xen_make_pud),
+		.set_p4d = xen_set_p4d_hyper,
 
-	.alloc_pud = xen_alloc_pmd_init,
-	.release_pud = xen_release_pmd_init,
+		.alloc_pud = xen_alloc_pmd_init,
+		.release_pud = xen_release_pmd_init,
 
 #if CONFIG_PGTABLE_LEVELS >= 5
-	.p4d_val = PV_CALLEE_SAVE(xen_p4d_val),
-	.make_p4d = PV_CALLEE_SAVE(xen_make_p4d),
+		.p4d_val = PV_CALLEE_SAVE(xen_p4d_val),
+		.make_p4d = PV_CALLEE_SAVE(xen_make_p4d),
 #endif
 
-	.activate_mm = xen_activate_mm,
-	.dup_mmap = xen_dup_mmap,
-	.exit_mmap = xen_exit_mmap,
+		.activate_mm = xen_activate_mm,
+		.dup_mmap = xen_dup_mmap,
+		.exit_mmap = xen_exit_mmap,
 
-	.lazy_mode = {
-		.enter = paravirt_enter_lazy_mmu,
-		.leave = xen_leave_lazy_mmu,
-		.flush = paravirt_flush_lazy_mmu,
-	},
+		.lazy_mode = {
+			.enter = paravirt_enter_lazy_mmu,
+			.leave = xen_leave_lazy_mmu,
+			.flush = paravirt_flush_lazy_mmu,
+		},
 
-	.set_fixmap = xen_set_fixmap,
+		.set_fixmap = xen_set_fixmap,
+	},
 };
 
 void __init xen_init_mmu_ops(void)
@@ -2144,7 +2146,7 @@ void __init xen_init_mmu_ops(void)
 	x86_init.paging.pagetable_init = xen_pagetable_init;
 	x86_init.hyper.init_after_bootmem = xen_after_bootmem;
 
-	pv_ops.mmu = xen_mmu_ops;
+	pv_ops.mmu = xen_mmu_ops.mmu;
 
 	memset(dummy_mapping, 0xff, PAGE_SIZE);
 }
