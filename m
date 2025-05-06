Return-Path: <linux-tip-commits+bounces-5256-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB90CAAC02C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 11:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6383189F82D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 09:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DA92777E4;
	Tue,  6 May 2025 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DxuIHvrg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bUXF1F5u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FFA27703D;
	Tue,  6 May 2025 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524554; cv=none; b=HwZtIqraZ2ikYcpDazE8PZvZJFNhuRvWM1JKYX5XAcAkOd3YhBMtbEE4prHr+mWXGS9QCzI6iHYVDa7uDxh2Oq3CN98wsYDBk5Tblvl+SSPOm4FAuMrA8AQFb2UkNSkegZWQH+jOQnaX/OOUYCJZqcmEQXz648fP/LYkhk29GpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524554; c=relaxed/simple;
	bh=P9a2pNHPAdAkPwbRHauhlTEXGppXguI6212ViJ55eaI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q1rD6BRXMFKhbf/1Alir+eUibFz1VQHT1rh9/M/f5oahf181ltUXzlSoZiOxcvCrIspjH/Rz7K4YllWBtIRKbOuTdKboY+CeiQvSFzXNya0aIuJibfcBhJXlyYI3sczugABIyKT3tEQgcEMVGAf5UWHqE1dQ1QsZ+cV/4DpzCkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DxuIHvrg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bUXF1F5u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 09:42:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746524549;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8YI95wP4mSj9oc4W3VJlQVPMAGQ0JQ9GE5xAfT/SlM=;
	b=DxuIHvrgj938Q3AuS7EfnA0L5BXcCCthiLlmcGtKBhgaXyxz2bKH49Qq8RS33xgNv24WrA
	DczTuhYza5Dk/ATXT3kEuFQNHC+gxqe192dpuyiK8AjTzS3earT2eLsJy7ULdYrBgZQw2X
	9NfCsyfLEX6PnGdXbgZFvPIx86gj7a2FyYo58WCAbTupTRSj+UYPk+/ZRaSvxydNA7U/ye
	rJxxs+oXCDQe4qbn36QMTVe7hzn9sTwOaHM1UG/FicbVcR8kH9j7Qlci8KrCW/NnNJcWtC
	oG88IPv2CpzvjJwRlOVO57RsdlKi2qpr/wNZGVHzuTC/HPjEfDIEPq7ACZlZfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746524549;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8YI95wP4mSj9oc4W3VJlQVPMAGQ0JQ9GE5xAfT/SlM=;
	b=bUXF1F5utZK3vaUBPTdjqZvAGlTgkNTYyyf2ri7bNnknzvtHu1EHvfB0RqYd/ky4ndSrsM
	5GPRwJ6KPLaPU4CA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/mm: Fix false positive warning in
 switch_mm_irqs_off()
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Juergen Gross <jgross@suse.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Rik van Riel <riel@surriel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250430081154.GH4439@noisy.programming.kicks-ass.net>
References: <20250430081154.GH4439@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174652454811.406.13340350863311949872.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     7f9958230d8a79d474829bee25ec9426397335ce
Gitweb:        https://git.kernel.org/tip/7f9958230d8a79d474829bee25ec9426397335ce
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 30 Apr 2025 10:11:54 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 06 May 2025 11:28:57 +02:00

x86/mm: Fix false positive warning in switch_mm_irqs_off()

Multiple testers reported the following new warning:

	WARNING: CPU: 0 PID: 0 at arch/x86/mm/tlb.c:795

Which corresponds to:

	if (IS_ENABLED(CONFIG_DEBUG_VM) && WARN_ON_ONCE(prev != &init_mm &&
	    !cpumask_test_cpu(cpu, mm_cpumask(next))))
		cpumask_set_cpu(cpu, mm_cpumask(next));

So the problem is that unuse_temporary_mm() explicitly clears
that bit; and it has to, because otherwise the flush_tlb_mm_range() in
__text_poke() will try sending IPIs, which are not at all needed.

See also:

   https://lore.kernel.org/all/20241113095550.GBZzR3pg-RhJKPDazS@fat_crate.local/

Notably, the whole {,un}use_temporary_mm() thing requires preemption to
be disabled across it with the express purpose of keeping all TLB
nonsense CPU local, such that invalidations can also stay local etc.

However, as a side-effect, we violate this above WARN(), which sorta
makes sense for the normal case, but very much doesn't make sense here.

Change unuse_temporary_mm() to mark the mm_struct such that a further
exception (beyond init_mm) can be grafted, to keep the warning for all
the other cases.

Reported-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reported-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rik van Riel <riel@surriel.com>
Link: https://lore.kernel.org/r/20250430081154.GH4439@noisy.programming.kicks-ass.net
---
 arch/x86/include/asm/mmu.h         |  4 ++--
 arch/x86/include/asm/mmu_context.h | 10 ++++++++++
 arch/x86/mm/init.c                 |  3 +++
 arch/x86/mm/tlb.c                  |  3 ++-
 arch/x86/platform/efi/efi_64.c     |  1 +
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 8b8055a..0fe9c56 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -16,6 +16,8 @@
 #define MM_CONTEXT_LOCK_LAM		2
 /* Allow LAM and SVA coexisting */
 #define MM_CONTEXT_FORCE_TAGGED_SVA	3
+/* Tracks mm_cpumask */
+#define MM_CONTEXT_NOTRACK		4
 
 /*
  * x86 has arch-specific MMU state beyond what lives in mm_struct.
@@ -44,9 +46,7 @@ typedef struct {
 	struct ldt_struct	*ldt;
 #endif
 
-#ifdef CONFIG_X86_64
 	unsigned long flags;
-#endif
 
 #ifdef CONFIG_ADDRESS_MASKING
 	/* Active LAM mode:  X86_CR3_LAM_U48 or X86_CR3_LAM_U57 or 0 (disabled) */
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index c511f85..73bf3b1 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -247,6 +247,16 @@ static inline bool is_64bit_mm(struct mm_struct *mm)
 }
 #endif
 
+static inline bool is_notrack_mm(struct mm_struct *mm)
+{
+	return test_bit(MM_CONTEXT_NOTRACK, &mm->context.flags);
+}
+
+static inline void set_notrack_mm(struct mm_struct *mm)
+{
+	set_bit(MM_CONTEXT_NOTRACK, &mm->context.flags);
+}
+
 /*
  * We only want to enforce protection keys on the current process
  * because we effectively have no access to PKRU for other
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index f8c74d1..aa56d9a 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -28,6 +28,7 @@
 #include <asm/text-patching.h>
 #include <asm/memtype.h>
 #include <asm/paravirt.h>
+#include <asm/mmu_context.h>
 
 /*
  * We need to define the tracepoints somewhere, and tlb.c
@@ -830,6 +831,8 @@ void __init poking_init(void)
 	/* Xen PV guests need the PGD to be pinned. */
 	paravirt_enter_mmap(text_poke_mm);
 
+	set_notrack_mm(text_poke_mm);
+
 	/*
 	 * Randomize the poking address, but make sure that the following page
 	 * will be mapped at the same PMD. We need 2 pages, so find space for 3,
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 39761c7..f5b990e 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -847,7 +847,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		 * mm_cpumask. The TLB shootdown code can figure out from
 		 * cpu_tlbstate_shared.is_lazy whether or not to send an IPI.
 		 */
-		if (IS_ENABLED(CONFIG_DEBUG_VM) && WARN_ON_ONCE(prev != &init_mm &&
+		if (IS_ENABLED(CONFIG_DEBUG_VM) &&
+		    WARN_ON_ONCE(prev != &init_mm && !is_notrack_mm(prev) &&
 				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index a5d3496..ce4c08a 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -89,6 +89,7 @@ int __init efi_alloc_page_tables(void)
 	efi_mm.pgd = efi_pgd;
 	mm_init_cpumask(&efi_mm);
 	init_new_context(NULL, &efi_mm);
+	set_notrack_mm(&efi_mm);
 
 	return 0;
 

