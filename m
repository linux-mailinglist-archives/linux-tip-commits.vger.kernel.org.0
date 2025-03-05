Return-Path: <linux-tip-commits+bounces-4017-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92444A50DBC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 22:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C111889760
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 21:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6CA25D20B;
	Wed,  5 Mar 2025 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2jeGAlOw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O/EQhXJt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1202586C2;
	Wed,  5 Mar 2025 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210590; cv=none; b=YTRim0E+dg9Fdm4Scr//Sxfls+pYIwzyp3tBiSb9lA2EhiH9eYVppQq8BSdkyGDT+jQOrdSope5OFLQYZPSv9Wyk6swbTBzMPYyRTJvNC+ULy/W8KH3z603mETrTMCuhfWQktxwBsyT7Vw53JKU7Fr/+f6UVsixzzZBByQghWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210590; c=relaxed/simple;
	bh=q/1ECC1MVPFzwAXmv1C5kX9GLsLk1LWtv12qjlSp07o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=D1KbY1pH0potA3pZTfsZe2tlgTyKSplzU2KkM6PF7dejnB4/IrGzo4UmtyzwR9QkpTuor6PCXXtSJvbPFecuhz0y5u4OJwsPhKtfg2wiNiVR8mPNQm4HZyUEPqoICi7jsROiqsN8+PCvmD9FjdzyWwzoLMoWVBnSpbXYmzvc5Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2jeGAlOw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O/EQhXJt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Mar 2025 21:36:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741210585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGfVPJ6rXbSWMh1kP08yrqlEaTs99szQtrJEXhaAZ44=;
	b=2jeGAlOwfZdcXWndBR4eSJlS4z/nbhqHNuRD8uPMyKlLyXvLqK98/USB5uyVksVDrRuYd4
	Ct1F5hFZkoizvF7+1SBcauP7h9SSf9d1koYnAOV5cLSsmCtBOVJCAus0n2nK79ehqgH/cC
	lCG0QMC98qqyCkDk+S6sWuCSXpmy6BpigIQGWGaWy9ZZdV1QS4pXHl7FU9pSBmVHgiTxGn
	guO9O4D9SWd+0r9DTySV2wti1YgwnarqBGkLoZDMGx7awD91P3kfbJxvpclr4JDHzdpyPM
	rAptwXvywc8yNy0tzuCDfXfTfqDZcr0bdRT/YOq0c4iEd7MZHSKxyJrTSpOmXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741210585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGfVPJ6rXbSWMh1kP08yrqlEaTs99szQtrJEXhaAZ44=;
	b=O/EQhXJtCnNKa8hzcGtdXjX27r1u6sUerh44W0YrCWm6wVZ95EirjEgiNGihY3IU4ehqVS
	NeJE2BgBl4xw5EBQ==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Add global ASID allocation helper functions
Cc: Rik van Riel <riel@surriel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226030129.530345-8-riel@surriel.com>
References: <20250226030129.530345-8-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174121058521.14745.12833413721825703938.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     6a7a65ddfd6d78ca2f075b0fe0a582792081fc03
Gitweb:        https://git.kernel.org/tip/6a7a65ddfd6d78ca2f075b0fe0a582792081fc03
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Tue, 25 Feb 2025 22:00:42 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Mar 2025 17:19:52 +01:00

x86/mm: Add global ASID allocation helper functions

Add functions to manage global ASID space. Multithreaded processes that are
simultaneously active on 4 or more CPUs can get a global ASID, resulting in the
same PCID being used for that process on every CPU.

This in turn will allow the kernel to use hardware-assisted TLB flushing
through AMD INVLPGB or Intel RAR for these processes.

  [ bp:
   - Extend use_global_asid() comment
   - s/X86_BROADCAST_TLB_FLUSH/BROADCAST_TLB_FLUSH/g
   - other touchups ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250226030129.530345-8-riel@surriel.com
---
 arch/x86/include/asm/mmu.h         |  12 ++-
 arch/x86/include/asm/mmu_context.h |   2 +-
 arch/x86/include/asm/tlbflush.h    |  37 +++++++-
 arch/x86/mm/tlb.c                  | 154 +++++++++++++++++++++++++++-
 4 files changed, 202 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 3b496cd..8b8055a 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -69,6 +69,18 @@ typedef struct {
 	u16 pkey_allocation_map;
 	s16 execute_only_pkey;
 #endif
+
+#ifdef CONFIG_BROADCAST_TLB_FLUSH
+	/*
+	 * The global ASID will be a non-zero value when the process has
+	 * the same ASID across all CPUs, allowing it to make use of
+	 * hardware-assisted remote TLB invalidation like AMD INVLPGB.
+	 */
+	u16 global_asid;
+
+	/* The process is transitioning to a new global ASID number. */
+	bool asid_transition;
+#endif
 } mm_context_t;
 
 #define INIT_MM_CONTEXT(mm)						\
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 795fdd5..a2c70e4 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -139,6 +139,8 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
 #define enter_lazy_tlb enter_lazy_tlb
 extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
 
+extern void mm_free_global_asid(struct mm_struct *mm);
+
 /*
  * Init a new mm.  Used on mm copies, like at fork()
  * and on mm's that are brand-new, like at execve().
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 855c13d..f7b374b 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -6,6 +6,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/sched.h>
 
+#include <asm/barrier.h>
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 #include <asm/special_insns.h>
@@ -234,6 +235,42 @@ void flush_tlb_one_kernel(unsigned long addr);
 void flush_tlb_multi(const struct cpumask *cpumask,
 		      const struct flush_tlb_info *info);
 
+static inline bool is_dyn_asid(u16 asid)
+{
+	return asid < TLB_NR_DYN_ASIDS;
+}
+
+#ifdef CONFIG_BROADCAST_TLB_FLUSH
+static inline u16 mm_global_asid(struct mm_struct *mm)
+{
+	u16 asid;
+
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return 0;
+
+	asid = smp_load_acquire(&mm->context.global_asid);
+
+	/* mm->context.global_asid is either 0, or a global ASID */
+	VM_WARN_ON_ONCE(asid && is_dyn_asid(asid));
+
+	return asid;
+}
+
+static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid)
+{
+	/*
+	 * Notably flush_tlb_mm_range() -> broadcast_tlb_flush() ->
+	 * finish_asid_transition() needs to observe asid_transition = true
+	 * once it observes global_asid.
+	 */
+	mm->context.asid_transition = true;
+	smp_store_release(&mm->context.global_asid, asid);
+}
+#else
+static inline u16 mm_global_asid(struct mm_struct *mm) { return 0; }
+static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid) { }
+#endif /* CONFIG_BROADCAST_TLB_FLUSH */
+
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #endif
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 76b4a88..6c24d96 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -74,13 +74,15 @@
  * use different names for each of them:
  *
  * ASID  - [0, TLB_NR_DYN_ASIDS-1]
- *         the canonical identifier for an mm
+ *         the canonical identifier for an mm, dynamically allocated on each CPU
+ *         [TLB_NR_DYN_ASIDS, MAX_ASID_AVAILABLE-1]
+ *         the canonical, global identifier for an mm, identical across all CPUs
  *
- * kPCID - [1, TLB_NR_DYN_ASIDS]
+ * kPCID - [1, MAX_ASID_AVAILABLE]
  *         the value we write into the PCID part of CR3; corresponds to the
  *         ASID+1, because PCID 0 is special.
  *
- * uPCID - [2048 + 1, 2048 + TLB_NR_DYN_ASIDS]
+ * uPCID - [2048 + 1, 2048 + MAX_ASID_AVAILABLE]
  *         for KPTI each mm has two address spaces and thus needs two
  *         PCID values, but we can still do with a single ASID denomination
  *         for each mm. Corresponds to kPCID + 2048.
@@ -252,6 +254,152 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
 }
 
 /*
+ * Global ASIDs are allocated for multi-threaded processes that are
+ * active on multiple CPUs simultaneously, giving each of those
+ * processes the same PCID on every CPU, for use with hardware-assisted
+ * TLB shootdown on remote CPUs, like AMD INVLPGB or Intel RAR.
+ *
+ * These global ASIDs are held for the lifetime of the process.
+ */
+static DEFINE_RAW_SPINLOCK(global_asid_lock);
+static u16 last_global_asid = MAX_ASID_AVAILABLE;
+static DECLARE_BITMAP(global_asid_used, MAX_ASID_AVAILABLE);
+static DECLARE_BITMAP(global_asid_freed, MAX_ASID_AVAILABLE);
+static int global_asid_available = MAX_ASID_AVAILABLE - TLB_NR_DYN_ASIDS - 1;
+
+/*
+ * When the search for a free ASID in the global ASID space reaches
+ * MAX_ASID_AVAILABLE, a global TLB flush guarantees that previously
+ * freed global ASIDs are safe to re-use.
+ *
+ * This way the global flush only needs to happen at ASID rollover
+ * time, and not at ASID allocation time.
+ */
+static void reset_global_asid_space(void)
+{
+	lockdep_assert_held(&global_asid_lock);
+
+	invlpgb_flush_all_nonglobals();
+
+	/*
+	 * The TLB flush above makes it safe to re-use the previously
+	 * freed global ASIDs.
+	 */
+	bitmap_andnot(global_asid_used, global_asid_used,
+			global_asid_freed, MAX_ASID_AVAILABLE);
+	bitmap_clear(global_asid_freed, 0, MAX_ASID_AVAILABLE);
+
+	/* Restart the search from the start of global ASID space. */
+	last_global_asid = TLB_NR_DYN_ASIDS;
+}
+
+static u16 allocate_global_asid(void)
+{
+	u16 asid;
+
+	lockdep_assert_held(&global_asid_lock);
+
+	/* The previous allocation hit the edge of available address space */
+	if (last_global_asid >= MAX_ASID_AVAILABLE - 1)
+		reset_global_asid_space();
+
+	asid = find_next_zero_bit(global_asid_used, MAX_ASID_AVAILABLE, last_global_asid);
+
+	if (asid >= MAX_ASID_AVAILABLE && !global_asid_available) {
+		/* This should never happen. */
+		VM_WARN_ONCE(1, "Unable to allocate global ASID despite %d available\n",
+				global_asid_available);
+		return 0;
+	}
+
+	/* Claim this global ASID. */
+	__set_bit(asid, global_asid_used);
+	last_global_asid = asid;
+	global_asid_available--;
+	return asid;
+}
+
+/*
+ * Check whether a process is currently active on more than @threshold CPUs.
+ * This is a cheap estimation on whether or not it may make sense to assign
+ * a global ASID to this process, and use broadcast TLB invalidation.
+ */
+static bool mm_active_cpus_exceeds(struct mm_struct *mm, int threshold)
+{
+	int count = 0;
+	int cpu;
+
+	/* This quick check should eliminate most single threaded programs. */
+	if (cpumask_weight(mm_cpumask(mm)) <= threshold)
+		return false;
+
+	/* Slower check to make sure. */
+	for_each_cpu(cpu, mm_cpumask(mm)) {
+		/* Skip the CPUs that aren't really running this process. */
+		if (per_cpu(cpu_tlbstate.loaded_mm, cpu) != mm)
+			continue;
+
+		if (per_cpu(cpu_tlbstate_shared.is_lazy, cpu))
+			continue;
+
+		if (++count > threshold)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * Assign a global ASID to the current process, protecting against
+ * races between multiple threads in the process.
+ */
+static void use_global_asid(struct mm_struct *mm)
+{
+	u16 asid;
+
+	guard(raw_spinlock_irqsave)(&global_asid_lock);
+
+	/* This process is already using broadcast TLB invalidation. */
+	if (mm_global_asid(mm))
+		return;
+
+	/*
+	 * The last global ASID was consumed while waiting for the lock.
+	 *
+	 * If this fires, a more aggressive ASID reuse scheme might be
+	 * needed.
+	 */
+	if (!global_asid_available) {
+		VM_WARN_ONCE(1, "Ran out of global ASIDs\n");
+		return;
+	}
+
+	asid = allocate_global_asid();
+	if (!asid)
+		return;
+
+	mm_assign_global_asid(mm, asid);
+}
+
+void mm_free_global_asid(struct mm_struct *mm)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return;
+
+	if (!mm_global_asid(mm))
+		return;
+
+	guard(raw_spinlock_irqsave)(&global_asid_lock);
+
+	/* The global ASID can be re-used only after flush at wrap-around. */
+#ifdef CONFIG_BROADCAST_TLB_FLUSH
+	__set_bit(mm->context.global_asid, global_asid_freed);
+
+	mm->context.global_asid = 0;
+	global_asid_available++;
+#endif
+}
+
+/*
  * Given an ASID, flush the corresponding user ASID.  We can delay this
  * until the next time we switch to it.
  *

