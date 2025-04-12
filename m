Return-Path: <linux-tip-commits+bounces-4910-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A14FA86EFF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 20:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB6917E9B7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 18:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69347224AE9;
	Sat, 12 Apr 2025 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CuGGDLMt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XGhtEzOI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D965222565;
	Sat, 12 Apr 2025 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483621; cv=none; b=ZTN5x28ghcGc+zFeOr1o7GHV77Is2no8E6TgZ64tXAFkvbkY6QJFjw9eFQ8gXUctPp7EHzPD2PC2Mmt2JovT/wN2SiGPMDq4jMk3+eTI0myCxQYRdiONl3mtRcYwD9nPcqik+znmNA2mFhk8GYmcaDKomzs/1gL43bKYccDbVqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483621; c=relaxed/simple;
	bh=j/zVCFJCkEt8cBpg+yHmt883Y2dWYrLsaWxtfyX3808=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kTvpbrrafAOjVoM3CB+9Hr8Cyo9/XYFVscqVc1TsVEVdsW99+kHkS6Go2X1dS3Pc/YVSFGPywsLXqSgqKsKvCilI1rF5LT5HrmAe0IBeprPrfka7hBRwIs2FBYOp6PWzpX7oahIPLnB69c3YMe9oxCgfqJEJPQNjs+5a1I5sCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CuGGDLMt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XGhtEzOI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Apr 2025 18:46:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744483617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhmmXsDnezAvBpIsub+8VpsTRkUKOyJ/HFAfSdaqR14=;
	b=CuGGDLMtlzaaukw+Kg6Lso1chMavF3pq60z8nKQOT+oMqZgT4VeqcNWOWVaACrtCyrOnfr
	ise+p5WXWQ0xJ1287hmo7kUAjFp97tXhYLN5iwR0rXwv9ZFXOfoBUk7B7O/e7EuReQ4PQG
	lUGyzqwwL/snl4whe1lEtaGCbvW62ToZ6ws+QUj1L4EE1XUJKpKdbMz7ekhdyw0V9Fs40O
	EGCeQoJKUhzSIVItpXQsqR+Ya1uhuZvaADZ4fusd7cWwg0zHxfXAhgw+X9edDaY7IlL6Ph
	LxSeHwMB6VV5DYT9C4MghRLUJut3q+ZSJINGgt5UFZHMRsQRK7KBhMg3eGXt4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744483617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhmmXsDnezAvBpIsub+8VpsTRkUKOyJ/HFAfSdaqR14=;
	b=XGhtEzOISJLPGqcDR5F6+Zg2dF6Rw7mJPOzFm2eRwB4OwiRNgloj9kCByWhsmvdaxAB2Tr
	GUfohbJN9zVYt9BQ==
From: "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/alternatives] x86/mm: Make use_/unuse_temporary_mm() non-static
Cc: Andy Lutomirski <luto@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250402094540.3586683-4-mingo@kernel.org>
References: <20250402094540.3586683-4-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174448361238.31282.8932105642465781613.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     d376972c9825ac4e8ad74872ee0730a5b4292e44
Gitweb:        https://git.kernel.org/tip/d376972c9825ac4e8ad74872ee0730a5b4292e44
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 02 Apr 2025 11:45:36 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Apr 2025 10:05:52 +02:00

x86/mm: Make use_/unuse_temporary_mm() non-static

This prepares them for use outside of the alternative machinery.
The code is unchanged.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/20250402094540.3586683-4-mingo@kernel.org
---
 arch/x86/include/asm/mmu_context.h |  3 +-
 arch/x86/kernel/alternative.c      | 64 +-----------------------------
 arch/x86/mm/tlb.c                  | 64 +++++++++++++++++++++++++++++-
 3 files changed, 67 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 2398058..b103e17 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -272,4 +272,7 @@ unsigned long __get_current_cr3_fast(void);
 
 #include <asm-generic/mmu_context.h>
 
+extern struct mm_struct *use_temporary_mm(struct mm_struct *temp_mm);
+extern void unuse_temporary_mm(struct mm_struct *mm, struct mm_struct *prev_mm);
+
 #endif /* _ASM_X86_MMU_CONTEXT_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 95053e8..bdbdfa0 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2111,73 +2111,9 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 	}
 }
 
-/*
- * Using a temporary mm allows to set temporary mappings that are not accessible
- * by other CPUs. Such mappings are needed to perform sensitive memory writes
- * that override the kernel memory protections (e.g., W^X), without exposing the
- * temporary page-table mappings that are required for these write operations to
- * other CPUs. Using a temporary mm also allows to avoid TLB shootdowns when the
- * mapping is torn down.
- *
- * Context: The temporary mm needs to be used exclusively by a single core. To
- *          harden security IRQs must be disabled while the temporary mm is
- *          loaded, thereby preventing interrupt handler bugs from overriding
- *          the kernel memory protection.
- */
-static inline struct mm_struct *use_temporary_mm(struct mm_struct *temp_mm)
-{
-	struct mm_struct *prev_mm;
-
-	lockdep_assert_irqs_disabled();
-
-	/*
-	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
-	 * with a stale address space WITHOUT being in lazy mode after
-	 * restoring the previous mm.
-	 */
-	if (this_cpu_read(cpu_tlbstate_shared.is_lazy))
-		leave_mm();
-
-	prev_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
-	switch_mm_irqs_off(NULL, temp_mm, current);
-
-	/*
-	 * If breakpoints are enabled, disable them while the temporary mm is
-	 * used. Userspace might set up watchpoints on addresses that are used
-	 * in the temporary mm, which would lead to wrong signals being sent or
-	 * crashes.
-	 *
-	 * Note that breakpoints are not disabled selectively, which also causes
-	 * kernel breakpoints (e.g., perf's) to be disabled. This might be
-	 * undesirable, but still seems reasonable as the code that runs in the
-	 * temporary mm should be short.
-	 */
-	if (hw_breakpoint_active())
-		hw_breakpoint_disable();
-
-	return prev_mm;
-}
-
 __ro_after_init struct mm_struct *text_poke_mm;
 __ro_after_init unsigned long text_poke_mm_addr;
 
-static inline void unuse_temporary_mm(struct mm_struct *mm, struct mm_struct *prev_mm)
-{
-	lockdep_assert_irqs_disabled();
-
-	switch_mm_irqs_off(NULL, prev_mm, current);
-
-	/* Clear the cpumask, to indicate no TLB flushing is needed anywhere */
-	cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(mm));
-
-	/*
-	 * Restore the breakpoints if they were disabled before the temporary mm
-	 * was loaded.
-	 */
-	if (hw_breakpoint_active())
-		hw_breakpoint_restore();
-}
-
 static void text_poke_memcpy(void *dst, const void *src, size_t len)
 {
 	memcpy(dst, src, len);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e459d97..f3da20b 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -972,6 +972,70 @@ void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 }
 
 /*
+ * Using a temporary mm allows to set temporary mappings that are not accessible
+ * by other CPUs. Such mappings are needed to perform sensitive memory writes
+ * that override the kernel memory protections (e.g., W^X), without exposing the
+ * temporary page-table mappings that are required for these write operations to
+ * other CPUs. Using a temporary mm also allows to avoid TLB shootdowns when the
+ * mapping is torn down.
+ *
+ * Context: The temporary mm needs to be used exclusively by a single core. To
+ *          harden security IRQs must be disabled while the temporary mm is
+ *          loaded, thereby preventing interrupt handler bugs from overriding
+ *          the kernel memory protection.
+ */
+struct mm_struct *use_temporary_mm(struct mm_struct *temp_mm)
+{
+	struct mm_struct *prev_mm;
+
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
+	 * with a stale address space WITHOUT being in lazy mode after
+	 * restoring the previous mm.
+	 */
+	if (this_cpu_read(cpu_tlbstate_shared.is_lazy))
+		leave_mm();
+
+	prev_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
+	switch_mm_irqs_off(NULL, temp_mm, current);
+
+	/*
+	 * If breakpoints are enabled, disable them while the temporary mm is
+	 * used. Userspace might set up watchpoints on addresses that are used
+	 * in the temporary mm, which would lead to wrong signals being sent or
+	 * crashes.
+	 *
+	 * Note that breakpoints are not disabled selectively, which also causes
+	 * kernel breakpoints (e.g., perf's) to be disabled. This might be
+	 * undesirable, but still seems reasonable as the code that runs in the
+	 * temporary mm should be short.
+	 */
+	if (hw_breakpoint_active())
+		hw_breakpoint_disable();
+
+	return prev_mm;
+}
+
+void unuse_temporary_mm(struct mm_struct *mm, struct mm_struct *prev_mm)
+{
+	lockdep_assert_irqs_disabled();
+
+	switch_mm_irqs_off(NULL, prev_mm, current);
+
+	/* Clear the cpumask, to indicate no TLB flushing is needed anywhere */
+	cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(mm));
+
+	/*
+	 * Restore the breakpoints if they were disabled before the temporary mm
+	 * was loaded.
+	 */
+	if (hw_breakpoint_active())
+		hw_breakpoint_restore();
+}
+
+/*
  * Call this when reinitializing a CPU.  It fixes the following potential
  * problems:
  *

