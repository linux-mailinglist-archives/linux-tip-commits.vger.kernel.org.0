Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3207132FA8F
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 13:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhCFMNY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 07:13:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhCFMM6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 07:12:58 -0500
Date:   Sat, 06 Mar 2021 12:12:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615032776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cs0Mc2T/vWWK9yKFx9CfY/EoluMgW2JLyi3qfW4cQQY=;
        b=ifq9MF0wZDoU+byOHH65SiUOEiL6NWn+xXAQz7H/WqDurrjziwXOWJ+0QDwPt7E8VJekoS
        PKkBkDogfL5DJ2/Uo4bw52CyzpYmcPCXOk3IR117LGKR1yT7Fi3b3mVVNTJVNFUFZKCt10
        vmZCTRrHDr+htwgcbXdgq1wB6chaAxbDhLERx2JIqYBGFHqEbYRmzeDaQTQmzhdpYEFT2X
        5g/UnPGeXHZyrejeMwOY0Z3j18gS7mrQTQ13WJdVgkBZw89GOQRdfQFa4Do6aux4d5x7cR
        KANqJpDll8krGwBlEAd5g2n47D2Fhn9tfkXMAAzLZRvcyJpd0Dap96MrbADpdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615032776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cs0Mc2T/vWWK9yKFx9CfY/EoluMgW2JLyi3qfW4cQQY=;
        b=zhVJ97Ia4W1IQQUgdOxyuUILlMRey65Ubd1FLv37uf1jqR9N7WBizS+3zvJHCBRC94a2W8
        euY+Vuf0YYQmSABg==
From:   "tip-bot2 for Nadav Amit" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/tlb: Unify flush_tlb_func_local() and
 flush_tlb_func_remote()
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210220231712.2475218-3-namit@vmware.com>
References: <20210220231712.2475218-3-namit@vmware.com>
MIME-Version: 1.0
Message-ID: <161503277618.398.5929775526004611160.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     4c1ba3923e6c8aa736e40f481a278c21b956c072
Gitweb:        https://git.kernel.org/tip/4c1ba3923e6c8aa736e40f481a278c21b956c072
Author:        Nadav Amit <namit@vmware.com>
AuthorDate:    Sat, 20 Feb 2021 15:17:05 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:59:09 +01:00

x86/mm/tlb: Unify flush_tlb_func_local() and flush_tlb_func_remote()

The unification of these two functions allows to use them in the updated
SMP infrastrucutre.

To do so, remove the reason argument from flush_tlb_func_local(), add
a member to struct tlb_flush_info that says which CPU initiated the
flush and act accordingly. Optimize the size of flush_tlb_info while we
are at it.

Unfortunately, this prevents us from using a constant tlb_flush_info for
arch_tlbbatch_flush(), but in a later stage we may be able to inline
tlb_flush_info into the IPI data, so it should not have an impact
eventually.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20210220231712.2475218-3-namit@vmware.com
---
 arch/x86/include/asm/tlbflush.h |  5 +-
 arch/x86/mm/tlb.c               | 81 ++++++++++++++------------------
 2 files changed, 39 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 8c87a2e..a7a598a 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -201,8 +201,9 @@ struct flush_tlb_info {
 	unsigned long		start;
 	unsigned long		end;
 	u64			new_tlb_gen;
-	unsigned int		stride_shift;
-	bool			freed_tables;
+	unsigned int		initiating_cpu;
+	u8			stride_shift;
+	u8			freed_tables;
 };
 
 void flush_tlb_local(void);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 569ac1d..bf12371 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -439,7 +439,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * NB: leave_mm() calls us with prev == NULL and tsk == NULL.
 	 */
 
-	/* We don't want flush_tlb_func_* to run concurrently with us. */
+	/* We don't want flush_tlb_func() to run concurrently with us. */
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
 		WARN_ON_ONCE(!irqs_disabled());
 
@@ -647,14 +647,13 @@ void initialize_tlbstate_and_flush(void)
 }
 
 /*
- * flush_tlb_func_common()'s memory ordering requirement is that any
+ * flush_tlb_func()'s memory ordering requirement is that any
  * TLB fills that happen after we flush the TLB are ordered after we
  * read active_mm's tlb_gen.  We don't need any explicit barriers
  * because all x86 flush operations are serializing and the
  * atomic64_read operation won't be reordered by the compiler.
  */
-static void flush_tlb_func_common(const struct flush_tlb_info *f,
-				  bool local, enum tlb_flush_reason reason)
+static void flush_tlb_func(void *info)
 {
 	/*
 	 * We have three different tlb_gen values in here.  They are:
@@ -665,14 +664,26 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	 * - f->new_tlb_gen: the generation that the requester of the flush
 	 *                   wants us to catch up to.
 	 */
+	const struct flush_tlb_info *f = info;
 	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
 	u64 mm_tlb_gen = atomic64_read(&loaded_mm->context.tlb_gen);
 	u64 local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
+	bool local = smp_processor_id() == f->initiating_cpu;
+	unsigned long nr_invalidate = 0;
 
 	/* This code cannot presently handle being reentered. */
 	VM_WARN_ON(!irqs_disabled());
 
+	if (!local) {
+		inc_irq_stat(irq_tlb_count);
+		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
+
+		/* Can only happen on remote CPUs */
+		if (f->mm && f->mm != loaded_mm)
+			return;
+	}
+
 	if (unlikely(loaded_mm == &init_mm))
 		return;
 
@@ -700,8 +711,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 		 * be handled can catch us all the way up, leaving no work for
 		 * the second flush.
 		 */
-		trace_tlb_flush(reason, 0);
-		return;
+		goto done;
 	}
 
 	WARN_ON_ONCE(local_tlb_gen > mm_tlb_gen);
@@ -748,46 +758,34 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	    f->new_tlb_gen == local_tlb_gen + 1 &&
 	    f->new_tlb_gen == mm_tlb_gen) {
 		/* Partial flush */
-		unsigned long nr_invalidate = (f->end - f->start) >> f->stride_shift;
 		unsigned long addr = f->start;
 
+		nr_invalidate = (f->end - f->start) >> f->stride_shift;
+
 		while (addr < f->end) {
 			flush_tlb_one_user(addr);
 			addr += 1UL << f->stride_shift;
 		}
 		if (local)
 			count_vm_tlb_events(NR_TLB_LOCAL_FLUSH_ONE, nr_invalidate);
-		trace_tlb_flush(reason, nr_invalidate);
 	} else {
 		/* Full flush. */
+		nr_invalidate = TLB_FLUSH_ALL;
+
 		flush_tlb_local();
 		if (local)
 			count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
-		trace_tlb_flush(reason, TLB_FLUSH_ALL);
 	}
 
 	/* Both paths above update our state to mm_tlb_gen. */
 	this_cpu_write(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen, mm_tlb_gen);
-}
-
-static void flush_tlb_func_local(const void *info, enum tlb_flush_reason reason)
-{
-	const struct flush_tlb_info *f = info;
-
-	flush_tlb_func_common(f, true, reason);
-}
 
-static void flush_tlb_func_remote(void *info)
-{
-	const struct flush_tlb_info *f = info;
-
-	inc_irq_stat(irq_tlb_count);
-
-	if (f->mm && f->mm != this_cpu_read(cpu_tlbstate.loaded_mm))
-		return;
-
-	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
-	flush_tlb_func_common(f, false, TLB_REMOTE_SHOOTDOWN);
+	/* Tracing is done in a unified manner to reduce the code size */
+done:
+	trace_tlb_flush(!local ? TLB_REMOTE_SHOOTDOWN :
+				(f->mm == NULL) ? TLB_LOCAL_SHOOTDOWN :
+						  TLB_LOCAL_MM_SHOOTDOWN,
+			nr_invalidate);
 }
 
 static bool tlb_is_not_lazy(int cpu, void *data)
@@ -816,10 +814,10 @@ STATIC_NOPV void native_flush_tlb_others(const struct cpumask *cpumask,
 	 * doing a speculative memory access.
 	 */
 	if (info->freed_tables)
-		smp_call_function_many(cpumask, flush_tlb_func_remote,
+		smp_call_function_many(cpumask, flush_tlb_func,
 			       (void *)info, 1);
 	else
-		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func_remote,
+		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
 				(void *)info, 1, cpumask);
 }
 
@@ -869,6 +867,7 @@ static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 	info->stride_shift	= stride_shift;
 	info->freed_tables	= freed_tables;
 	info->new_tlb_gen	= new_tlb_gen;
+	info->initiating_cpu	= smp_processor_id();
 
 	return info;
 }
@@ -908,7 +907,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();
-		flush_tlb_func_local(info, TLB_LOCAL_MM_SHOOTDOWN);
+		flush_tlb_func(info);
 		local_irq_enable();
 	}
 
@@ -1119,34 +1118,26 @@ void __flush_tlb_all(void)
 }
 EXPORT_SYMBOL_GPL(__flush_tlb_all);
 
-/*
- * arch_tlbbatch_flush() performs a full TLB flush regardless of the active mm.
- * This means that the 'struct flush_tlb_info' that describes which mappings to
- * flush is actually fixed. We therefore set a single fixed struct and use it in
- * arch_tlbbatch_flush().
- */
-static const struct flush_tlb_info full_flush_tlb_info = {
-	.mm = NULL,
-	.start = 0,
-	.end = TLB_FLUSH_ALL,
-};
-
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
+	struct flush_tlb_info *info;
+
 	int cpu = get_cpu();
 
+	info = get_flush_tlb_info(NULL, 0, TLB_FLUSH_ALL, 0, false, 0);
 	if (cpumask_test_cpu(cpu, &batch->cpumask)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();
-		flush_tlb_func_local(&full_flush_tlb_info, TLB_LOCAL_SHOOTDOWN);
+		flush_tlb_func(info);
 		local_irq_enable();
 	}
 
 	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids)
-		flush_tlb_others(&batch->cpumask, &full_flush_tlb_info);
+		flush_tlb_others(&batch->cpumask, info);
 
 	cpumask_clear(&batch->cpumask);
 
+	put_flush_tlb_info();
 	put_cpu();
 }
 
