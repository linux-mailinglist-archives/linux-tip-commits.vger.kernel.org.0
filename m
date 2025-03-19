Return-Path: <linux-tip-commits+bounces-4388-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F2AA68B2A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC19A3B84AC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60C3265CA8;
	Wed, 19 Mar 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ybM/YK3q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uNBc5fcL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C434D25D542;
	Wed, 19 Mar 2025 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382249; cv=none; b=l7O2T/4zz7IG6t8JBGqYvw9rTjzetO7ebzJUTtazeP+1Fg+I2ksP4C28nHh3eYGwPoycuNd13VHturk4gT5rxqoR+jtDrtcnxTnFWlFzfvFKxna9mTA70TSiYfbPn/0UfQoAzR4KV38rA8yL44SnlIPqaEj/ctjqTLbGxvwdrRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382249; c=relaxed/simple;
	bh=/HuDJcgqLtNdU2v+NNl6CN5tXWC3TAWU1rdJ/BL/aMM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y0DaiJ1B2rVrWYMVQHKZVJT0PLzYKptjkBrp9/Ktpq7z9WXvn+v6uy7tteef3T5teSPBGtBYdAaoJ7VnJbzP4SPPb7y5QeTqWAt0RNfJdbweN5c/BuLmcXSLXdzto3JLleC45fEqGjuPtN0n3xtxDMJvo6uQJoikUPlOFfGdIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ybM/YK3q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uNBc5fcL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:04:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDzKeeoQaAcqS+sgmRfvxAC6AWTgfMGjBrhkgY2MRVc=;
	b=ybM/YK3q+pxJ2MiwGcrUBGt7oh8YoFWNCnk1CAFnSZPkoeSCJ/sKwWJWEaBymanZQa6PkI
	OOpY/3BZ+jjVhzYK16UDztxqfunwgVFdsWdinJH1nvn1xu7BvcJlywmGSyj4C0bGuAD9er
	sfYna5Wa4Fg59xOe4AmpdUROCurGXjcF8R6HcSPLFVkVJakzy4lbE61dnC1tXTdz7VP4lg
	8VvZIhjOsPYQjWVGsxj3Xu50lhC/u5JEQdynAhutUpTobQs5+TrVZM4CqauANdUls/kMxy
	cVANMmSe9nm8c5wldd5ZgVx24D44spQozqHC7qyEo2i4HjHT8oV2RDABOEGMBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDzKeeoQaAcqS+sgmRfvxAC6AWTgfMGjBrhkgY2MRVc=;
	b=uNBc5fcLloSC922P9+zfQfIKIenDajOiKz46T+kPwujQwvdXteSyHWB4+S990O+0dFjdoC
	FpzvEf72BkG099AQ==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/mm: Handle global ASID context switch and TLB flush
Cc: Rik van Riel <riel@surriel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226030129.530345-9-riel@surriel.com>
References: <20250226030129.530345-9-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238224465.14745.7302200818016578754.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     be88a1dd6112bbcf40d0fe9da02fb71bfb427cfe
Gitweb:        https://git.kernel.org/tip/be88a1dd6112bbcf40d0fe9da02fb71bfb427cfe
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Tue, 25 Feb 2025 22:00:43 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:12:29 +01:00

x86/mm: Handle global ASID context switch and TLB flush

Do context switch and TLB flush support for processes that use a global
ASID and PCID across all CPUs.

At both context switch time and TLB flush time, it needs to be checked whether
a task is switching to a global ASID, and, if so, reload the TLB with the new
ASID as appropriate.

In both code paths, the TLB flush is avoided if a global ASID is used, because
the global ASIDs are always kept up to date across CPUs, even when the
process is not running on a CPU.

  [ bp:
   - Massage
   - :%s/\<static_cpu_has\>/cpu_feature_enabled/cgi
  ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250226030129.530345-9-riel@surriel.com
---
 arch/x86/include/asm/tlbflush.h | 14 ++++++-
 arch/x86/mm/tlb.c               | 77 +++++++++++++++++++++++++++++---
 2 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index f7b374b..1f61a39 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -240,6 +240,11 @@ static inline bool is_dyn_asid(u16 asid)
 	return asid < TLB_NR_DYN_ASIDS;
 }
 
+static inline bool is_global_asid(u16 asid)
+{
+	return !is_dyn_asid(asid);
+}
+
 #ifdef CONFIG_BROADCAST_TLB_FLUSH
 static inline u16 mm_global_asid(struct mm_struct *mm)
 {
@@ -266,9 +271,18 @@ static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid)
 	mm->context.asid_transition = true;
 	smp_store_release(&mm->context.global_asid, asid);
 }
+
+static inline bool mm_in_asid_transition(struct mm_struct *mm)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return false;
+
+	return mm && READ_ONCE(mm->context.asid_transition);
+}
 #else
 static inline u16 mm_global_asid(struct mm_struct *mm) { return 0; }
 static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid) { }
+static inline bool mm_in_asid_transition(struct mm_struct *mm) { return false; }
 #endif /* CONFIG_BROADCAST_TLB_FLUSH */
 
 #ifdef CONFIG_PARAVIRT
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 6c24d96..b5681e6 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -227,6 +227,20 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
 		return;
 	}
 
+	/*
+	 * TLB consistency for global ASIDs is maintained with hardware assisted
+	 * remote TLB flushing. Global ASIDs are always up to date.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
+		u16 global_asid = mm_global_asid(next);
+
+		if (global_asid) {
+			*new_asid = global_asid;
+			*need_flush = false;
+			return;
+		}
+	}
+
 	if (this_cpu_read(cpu_tlbstate.invalidate_other))
 		clear_asid_other();
 
@@ -400,6 +414,23 @@ void mm_free_global_asid(struct mm_struct *mm)
 }
 
 /*
+ * Is the mm transitioning from a CPU-local ASID to a global ASID?
+ */
+static bool mm_needs_global_asid(struct mm_struct *mm, u16 asid)
+{
+	u16 global_asid = mm_global_asid(mm);
+
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return false;
+
+	/* Process is transitioning to a global ASID */
+	if (global_asid && asid != global_asid)
+		return true;
+
+	return false;
+}
+
+/*
  * Given an ASID, flush the corresponding user ASID.  We can delay this
  * until the next time we switch to it.
  *
@@ -704,7 +735,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	 */
 	if (prev == next) {
 		/* Not actually switching mm's */
-		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
+		VM_WARN_ON(is_dyn_asid(prev_asid) &&
+			   this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
 			   next->context.ctx_id);
 
 		/*
@@ -721,6 +753,20 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 
+		/* Check if the current mm is transitioning to a global ASID */
+		if (mm_needs_global_asid(next, prev_asid)) {
+			next_tlb_gen = atomic64_read(&next->context.tlb_gen);
+			choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
+			goto reload_tlb;
+		}
+
+		/*
+		 * Broadcast TLB invalidation keeps this ASID up to date
+		 * all the time.
+		 */
+		if (is_global_asid(prev_asid))
+			return;
+
 		/*
 		 * If the CPU is not in lazy TLB mode, we are just switching
 		 * from one thread in a process to another thread in the same
@@ -755,6 +801,13 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		cond_mitigation(tsk);
 
 		/*
+		 * Let nmi_uaccess_okay() and finish_asid_transition()
+		 * know that CR3 is changing.
+		 */
+		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
+		barrier();
+
+		/*
 		 * Leave this CPU in prev's mm_cpumask. Atomic writes to
 		 * mm_cpumask can be expensive under contention. The CPU
 		 * will be removed lazily at TLB flush time.
@@ -768,14 +821,12 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
 
 		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
-
-		/* Let nmi_uaccess_okay() know that we're changing CR3. */
-		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
-		barrier();
 	}
 
+reload_tlb:
 	new_lam = mm_lam_cr3_mask(next);
 	if (need_flush) {
+		VM_WARN_ON_ONCE(is_global_asid(new_asid));
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
 		load_new_mm_cr3(next->pgd, new_asid, new_lam, true);
@@ -894,7 +945,7 @@ static void flush_tlb_func(void *info)
 	const struct flush_tlb_info *f = info;
 	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	u64 local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
+	u64 local_tlb_gen;
 	bool local = smp_processor_id() == f->initiating_cpu;
 	unsigned long nr_invalidate = 0;
 	u64 mm_tlb_gen;
@@ -917,6 +968,16 @@ static void flush_tlb_func(void *info)
 	if (unlikely(loaded_mm == &init_mm))
 		return;
 
+	/* Reload the ASID if transitioning into or out of a global ASID */
+	if (mm_needs_global_asid(loaded_mm, loaded_mm_asid)) {
+		switch_mm_irqs_off(NULL, loaded_mm, NULL);
+		loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	}
+
+	/* Broadcast ASIDs are always kept up to date with INVLPGB. */
+	if (is_global_asid(loaded_mm_asid))
+		return;
+
 	VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].ctx_id) !=
 		   loaded_mm->context.ctx_id);
 
@@ -934,6 +995,8 @@ static void flush_tlb_func(void *info)
 		return;
 	}
 
+	local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
+
 	if (unlikely(f->new_tlb_gen != TLB_GENERATION_INVALID &&
 		     f->new_tlb_gen <= local_tlb_gen)) {
 		/*
@@ -1101,7 +1164,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 	 * up on the new contents of what used to be page tables, while
 	 * doing a speculative memory access.
 	 */
-	if (info->freed_tables)
+	if (info->freed_tables || mm_in_asid_transition(info->mm))
 		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
 	else
 		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,

