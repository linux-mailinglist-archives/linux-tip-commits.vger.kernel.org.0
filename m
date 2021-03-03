Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD7632B097
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbhCCDjL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:39:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36060 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577824AbhCBJzc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 04:55:32 -0500
Date:   Tue, 02 Mar 2021 09:54:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614678888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bluRlmT4yHnldE9cjCoqykRGOUcItHyzpRtXNx/xb3M=;
        b=F1TAl0OH7rq308C81owhDm9DindFgor93MUDE5YQ0hPb1dQtnsTtOZ3ACOMDjIBW2ITM1E
        SEMn2UvkEVbSD4obsa3TQ2Io8LihoW8E/GdZdRI4vR87mxbf/p7urXQem6nDP+0EssbL4M
        0ckHQtoq/JROjcI8F0Au/WxXcLmcx2srdM9WdEIMjsAOTJ50zfWecqMwLOgr46t9jhtVya
        bjo31yKJiPJY9ArvZ8G9KaDrgpVOqKDzMeT2zp3T+HOKbyMWbpTTJaIVOf3Du8/cz5hihY
        55YzaasHPm3MyMyVnURMlxWl/kD38d9ySMi8H8imUggJ7UA6nFn5/EOrkhKqMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614678888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bluRlmT4yHnldE9cjCoqykRGOUcItHyzpRtXNx/xb3M=;
        b=D1tB9lhMKoYCb1YN2TOU9XI4AnrJzS5Lz5C47kuIhXl3maGYuTZyZeBeWLeRwktjlIRtaP
        nhYV4QylQsgoS/CA==
From:   "tip-bot2 for Nadav Amit" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/tlb: Flush remote and local TLBs concurrently
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210220231712.2475218-5-namit@vmware.com>
References: <20210220231712.2475218-5-namit@vmware.com>
MIME-Version: 1.0
Message-ID: <161467888786.20312.1100775441207824413.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     efa72447b0b95cd5e8b2bd7cf55ae23c716f8702
Gitweb:        https://git.kernel.org/tip/efa72447b0b95cd5e8b2bd7cf55ae23c716f8702
Author:        Nadav Amit <namit@vmware.com>
AuthorDate:    Sat, 20 Feb 2021 15:17:07 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Mar 2021 08:01:37 +01:00

x86/mm/tlb: Flush remote and local TLBs concurrently

To improve TLB shootdown performance, flush the remote and local TLBs
concurrently. Introduce flush_tlb_multi() that does so. Introduce
paravirtual versions of flush_tlb_multi() for KVM, Xen and hyper-v (Xen
and hyper-v are only compile-tested).

While the updated smp infrastructure is capable of running a function on
a single local core, it is not optimized for this case. The multiple
function calls and the indirect branch introduce some overhead, and
might make local TLB flushes slower than they were before the recent
changes.

Before calling the SMP infrastructure, check if only a local TLB flush
is needed to restore the lost performance in this common case. This
requires to check mm_cpumask() one more time, but unless this mask is
updated very frequently, this should impact performance negatively.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Michael Kelley <mikelley@microsoft.com> # Hyper-v parts
Reviewed-by: Juergen Gross <jgross@suse.com> # Xen and paravirt parts
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20210220231712.2475218-5-namit@vmware.com
---
 arch/x86/hyperv/mmu.c                 | 10 +++---
 arch/x86/include/asm/paravirt.h       |  6 +--
 arch/x86/include/asm/paravirt_types.h |  4 +-
 arch/x86/include/asm/tlbflush.h       |  4 +-
 arch/x86/include/asm/trace/hyperv.h   |  2 +-
 arch/x86/kernel/kvm.c                 | 11 ++++--
 arch/x86/kernel/paravirt.c            |  2 +-
 arch/x86/mm/tlb.c                     | 46 ++++++++++++++++----------
 arch/x86/xen/mmu_pv.c                 | 11 ++----
 include/trace/events/xen.h            |  2 +-
 10 files changed, 57 insertions(+), 41 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 2c87350..681dba8 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -52,8 +52,8 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
 	return gva_n - offset;
 }
 
-static void hyperv_flush_tlb_others(const struct cpumask *cpus,
-				    const struct flush_tlb_info *info)
+static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
+				   const struct flush_tlb_info *info)
 {
 	int cpu, vcpu, gva_n, max_gvas;
 	struct hv_tlb_flush **flush_pcpu;
@@ -61,7 +61,7 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 	u64 status = U64_MAX;
 	unsigned long flags;
 
-	trace_hyperv_mmu_flush_tlb_others(cpus, info);
+	trace_hyperv_mmu_flush_tlb_multi(cpus, info);
 
 	if (!hv_hypercall_pg)
 		goto do_native;
@@ -164,7 +164,7 @@ check_status:
 	if (!(status & HV_HYPERCALL_RESULT_MASK))
 		return;
 do_native:
-	native_flush_tlb_others(cpus, info);
+	native_flush_tlb_multi(cpus, info);
 }
 
 static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
@@ -239,6 +239,6 @@ void hyperv_setup_mmu_ops(void)
 		return;
 
 	pr_info("Using hypercall for remote TLB flush\n");
-	pv_ops.mmu.flush_tlb_others = hyperv_flush_tlb_others;
+	pv_ops.mmu.flush_tlb_multi = hyperv_flush_tlb_multi;
 	pv_ops.mmu.tlb_remove_table = tlb_remove_table;
 }
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 4abf110..45b55e3 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -50,7 +50,7 @@ static inline void slow_down_io(void)
 void native_flush_tlb_local(void);
 void native_flush_tlb_global(void);
 void native_flush_tlb_one_user(unsigned long addr);
-void native_flush_tlb_others(const struct cpumask *cpumask,
+void native_flush_tlb_multi(const struct cpumask *cpumask,
 			     const struct flush_tlb_info *info);
 
 static inline void __flush_tlb_local(void)
@@ -68,10 +68,10 @@ static inline void __flush_tlb_one_user(unsigned long addr)
 	PVOP_VCALL1(mmu.flush_tlb_one_user, addr);
 }
 
-static inline void __flush_tlb_others(const struct cpumask *cpumask,
+static inline void __flush_tlb_multi(const struct cpumask *cpumask,
 				      const struct flush_tlb_info *info)
 {
-	PVOP_VCALL2(mmu.flush_tlb_others, cpumask, info);
+	PVOP_VCALL2(mmu.flush_tlb_multi, cpumask, info);
 }
 
 static inline void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index de87087..b7b35d5 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -188,8 +188,8 @@ struct pv_mmu_ops {
 	void (*flush_tlb_user)(void);
 	void (*flush_tlb_kernel)(void);
 	void (*flush_tlb_one_user)(unsigned long addr);
-	void (*flush_tlb_others)(const struct cpumask *cpus,
-				 const struct flush_tlb_info *info);
+	void (*flush_tlb_multi)(const struct cpumask *cpus,
+				const struct flush_tlb_info *info);
 
 	void (*tlb_remove_table)(struct mmu_gather *tlb, void *table);
 
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index a7a598a..3c6681d 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -175,7 +175,7 @@ extern void initialize_tlbstate_and_flush(void);
  *  - flush_tlb_page(vma, vmaddr) flushes one page
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
- *  - flush_tlb_others(cpumask, info) flushes TLBs on other cpus
+ *  - flush_tlb_multi(cpumask, info) flushes TLBs on multiple cpus
  *
  * ..but the i386 has somewhat limited tlb flushing capabilities,
  * and page-granular flushes are available only on i486 and up.
@@ -209,7 +209,7 @@ struct flush_tlb_info {
 void flush_tlb_local(void);
 void flush_tlb_one_user(unsigned long addr);
 void flush_tlb_one_kernel(unsigned long addr);
-void flush_tlb_others(const struct cpumask *cpumask,
+void flush_tlb_multi(const struct cpumask *cpumask,
 		      const struct flush_tlb_info *info);
 
 #ifdef CONFIG_PARAVIRT
diff --git a/arch/x86/include/asm/trace/hyperv.h b/arch/x86/include/asm/trace/hyperv.h
index 4d705cb..a8e5a7a 100644
--- a/arch/x86/include/asm/trace/hyperv.h
+++ b/arch/x86/include/asm/trace/hyperv.h
@@ -8,7 +8,7 @@
 
 #if IS_ENABLED(CONFIG_HYPERV)
 
-TRACE_EVENT(hyperv_mmu_flush_tlb_others,
+TRACE_EVENT(hyperv_mmu_flush_tlb_multi,
 	    TP_PROTO(const struct cpumask *cpus,
 		     const struct flush_tlb_info *info),
 	    TP_ARGS(cpus, info),
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5e78e01..38ea9de 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -613,7 +613,7 @@ static int kvm_cpu_down_prepare(unsigned int cpu)
 }
 #endif
 
-static void kvm_flush_tlb_others(const struct cpumask *cpumask,
+static void kvm_flush_tlb_multi(const struct cpumask *cpumask,
 			const struct flush_tlb_info *info)
 {
 	u8 state;
@@ -627,6 +627,11 @@ static void kvm_flush_tlb_others(const struct cpumask *cpumask,
 	 * queue flush_on_enter for pre-empted vCPUs
 	 */
 	for_each_cpu(cpu, flushmask) {
+		/*
+		 * The local vCPU is never preempted, so we do not explicitly
+		 * skip check for local vCPU - it will never be cleared from
+		 * flushmask.
+		 */
 		src = &per_cpu(steal_time, cpu);
 		state = READ_ONCE(src->preempted);
 		if ((state & KVM_VCPU_PREEMPTED)) {
@@ -636,7 +641,7 @@ static void kvm_flush_tlb_others(const struct cpumask *cpumask,
 		}
 	}
 
-	native_flush_tlb_others(flushmask, info);
+	native_flush_tlb_multi(flushmask, info);
 }
 
 static void __init kvm_guest_init(void)
@@ -654,7 +659,7 @@ static void __init kvm_guest_init(void)
 	}
 
 	if (pv_tlb_flush_supported()) {
-		pv_ops.mmu.flush_tlb_others = kvm_flush_tlb_others;
+		pv_ops.mmu.flush_tlb_multi = kvm_flush_tlb_multi;
 		pv_ops.mmu.tlb_remove_table = tlb_remove_table;
 		pr_info("KVM setup pv remote TLB flush\n");
 	}
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c60222a..197a126 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -330,7 +330,7 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.flush_tlb_user	= native_flush_tlb_local,
 	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
 	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
-	.mmu.flush_tlb_others	= native_flush_tlb_others,
+	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
 	.mmu.tlb_remove_table	=
 			(void (*)(struct mmu_gather *, void *))tlb_remove_page,
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 07b6701..8db87cd 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -24,7 +24,7 @@
 # define __flush_tlb_local		native_flush_tlb_local
 # define __flush_tlb_global		native_flush_tlb_global
 # define __flush_tlb_one_user(addr)	native_flush_tlb_one_user(addr)
-# define __flush_tlb_others(msk, info)	native_flush_tlb_others(msk, info)
+# define __flush_tlb_multi(msk, info)	native_flush_tlb_multi(msk, info)
 #endif
 
 /*
@@ -490,7 +490,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		/*
 		 * Even in lazy TLB mode, the CPU should stay set in the
 		 * mm_cpumask. The TLB shootdown code can figure out from
-		 * from cpu_tlbstate.is_lazy whether or not to send an IPI.
+		 * cpu_tlbstate.is_lazy whether or not to send an IPI.
 		 */
 		if (WARN_ON_ONCE(real_prev != &init_mm &&
 				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
@@ -697,7 +697,7 @@ static void flush_tlb_func(void *info)
 		 * garbage into our TLB.  Since switching to init_mm is barely
 		 * slower than a minimal flush, just switch to init_mm.
 		 *
-		 * This should be rare, with native_flush_tlb_others skipping
+		 * This should be rare, with native_flush_tlb_multi() skipping
 		 * IPIs to lazy TLB mode CPUs.
 		 */
 		switch_mm_irqs_off(NULL, &init_mm, NULL);
@@ -795,9 +795,14 @@ static bool tlb_is_not_lazy(int cpu)
 
 static DEFINE_PER_CPU(cpumask_t, flush_tlb_mask);
 
-STATIC_NOPV void native_flush_tlb_others(const struct cpumask *cpumask,
+STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 					 const struct flush_tlb_info *info)
 {
+	/*
+	 * Do accounting and tracing. Note that there are (and have always been)
+	 * cases in which a remote TLB flush will be traced, but eventually
+	 * would not happen.
+	 */
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
 	if (info->end == TLB_FLUSH_ALL)
 		trace_tlb_flush(TLB_REMOTE_SEND_IPI, TLB_FLUSH_ALL);
@@ -816,8 +821,7 @@ STATIC_NOPV void native_flush_tlb_others(const struct cpumask *cpumask,
 	 * doing a speculative memory access.
 	 */
 	if (info->freed_tables) {
-		smp_call_function_many(cpumask, flush_tlb_func,
-			       (void *)info, 1);
+		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
 	} else {
 		/*
 		 * Although we could have used on_each_cpu_cond_mask(),
@@ -844,14 +848,14 @@ STATIC_NOPV void native_flush_tlb_others(const struct cpumask *cpumask,
 			if (tlb_is_not_lazy(cpu))
 				__cpumask_set_cpu(cpu, cond_cpumask);
 		}
-		smp_call_function_many(cond_cpumask, flush_tlb_func, (void *)info, 1);
+		on_each_cpu_mask(cond_cpumask, flush_tlb_func, (void *)info, true);
 	}
 }
 
-void flush_tlb_others(const struct cpumask *cpumask,
+void flush_tlb_multi(const struct cpumask *cpumask,
 		      const struct flush_tlb_info *info)
 {
-	__flush_tlb_others(cpumask, info);
+	__flush_tlb_multi(cpumask, info);
 }
 
 /*
@@ -931,16 +935,20 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	info = get_flush_tlb_info(mm, start, end, stride_shift, freed_tables,
 				  new_tlb_gen);
 
-	if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
+	/*
+	 * flush_tlb_multi() is not optimized for the common case in which only
+	 * a local TLB flush is needed. Optimize this use-case by calling
+	 * flush_tlb_func_local() directly in this case.
+	 */
+	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
+		flush_tlb_multi(mm_cpumask(mm), info);
+	} else if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();
 		flush_tlb_func(info);
 		local_irq_enable();
 	}
 
-	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
-		flush_tlb_others(mm_cpumask(mm), info);
-
 	put_flush_tlb_info();
 	put_cpu();
 }
@@ -1152,16 +1160,20 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	int cpu = get_cpu();
 
 	info = get_flush_tlb_info(NULL, 0, TLB_FLUSH_ALL, 0, false, 0);
-	if (cpumask_test_cpu(cpu, &batch->cpumask)) {
+	/*
+	 * flush_tlb_multi() is not optimized for the common case in which only
+	 * a local TLB flush is needed. Optimize this use-case by calling
+	 * flush_tlb_func_local() directly in this case.
+	 */
+	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
+		flush_tlb_multi(&batch->cpumask, info);
+	} else if (cpumask_test_cpu(cpu, &batch->cpumask)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();
 		flush_tlb_func(info);
 		local_irq_enable();
 	}
 
-	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids)
-		flush_tlb_others(&batch->cpumask, info);
-
 	cpumask_clear(&batch->cpumask);
 
 	put_flush_tlb_info();
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index cf2ade8..09b95c0 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1247,8 +1247,8 @@ static void xen_flush_tlb_one_user(unsigned long addr)
 	preempt_enable();
 }
 
-static void xen_flush_tlb_others(const struct cpumask *cpus,
-				 const struct flush_tlb_info *info)
+static void xen_flush_tlb_multi(const struct cpumask *cpus,
+				const struct flush_tlb_info *info)
 {
 	struct {
 		struct mmuext_op op;
@@ -1258,7 +1258,7 @@ static void xen_flush_tlb_others(const struct cpumask *cpus,
 	const size_t mc_entry_size = sizeof(args->op) +
 		sizeof(args->mask[0]) * BITS_TO_LONGS(num_possible_cpus());
 
-	trace_xen_mmu_flush_tlb_others(cpus, info->mm, info->start, info->end);
+	trace_xen_mmu_flush_tlb_multi(cpus, info->mm, info->start, info->end);
 
 	if (cpumask_empty(cpus))
 		return;		/* nothing to do */
@@ -1267,9 +1267,8 @@ static void xen_flush_tlb_others(const struct cpumask *cpus,
 	args = mcs.args;
 	args->op.arg2.vcpumask = to_cpumask(args->mask);
 
-	/* Remove us, and any offline CPUS. */
+	/* Remove any offline CPUs */
 	cpumask_and(to_cpumask(args->mask), cpus, cpu_online_mask);
-	cpumask_clear_cpu(smp_processor_id(), to_cpumask(args->mask));
 
 	args->op.cmd = MMUEXT_TLB_FLUSH_MULTI;
 	if (info->end != TLB_FLUSH_ALL &&
@@ -2086,7 +2085,7 @@ static const struct pv_mmu_ops xen_mmu_ops __initconst = {
 	.flush_tlb_user = xen_flush_tlb,
 	.flush_tlb_kernel = xen_flush_tlb,
 	.flush_tlb_one_user = xen_flush_tlb_one_user,
-	.flush_tlb_others = xen_flush_tlb_others,
+	.flush_tlb_multi = xen_flush_tlb_multi,
 	.tlb_remove_table = tlb_remove_table,
 
 	.pgd_alloc = xen_pgd_alloc,
diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
index 3b61b58..44a3f56 100644
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -346,7 +346,7 @@ TRACE_EVENT(xen_mmu_flush_tlb_one_user,
 	    TP_printk("addr %lx", __entry->addr)
 	);
 
-TRACE_EVENT(xen_mmu_flush_tlb_others,
+TRACE_EVENT(xen_mmu_flush_tlb_multi,
 	    TP_PROTO(const struct cpumask *cpus, struct mm_struct *mm,
 		     unsigned long addr, unsigned long end),
 	    TP_ARGS(cpus, mm, addr, end),
