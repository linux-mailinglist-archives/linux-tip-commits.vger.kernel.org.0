Return-Path: <linux-tip-commits+bounces-3581-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8EAA3F8FA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 16:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB33705A59
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 15:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82BC1F8EF2;
	Fri, 21 Feb 2025 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oZFUmTNq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NoEWNHu6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB5821146E;
	Fri, 21 Feb 2025 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151811; cv=none; b=Xo87Wvw/ImHkEw1hHkKK/XYo0ezhJnuQS6CbXe3HmCvNLwvhdLgdxeZS+WUVAMJQbDXF3gM87AGfHRACCSDTyU3lR0AGO6+f9pOhg40HQrOYGwDRALb3iCxaDnccuuqC6O0TMZKJDLHuI5ZqjQP/Zpw8pbHMuLwsS5fYwLYdRWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151811; c=relaxed/simple;
	bh=Yw+zxpq9ffzcImlBX0gmtFDqfDoEgRlTWSpd7O8gAyo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LOVSyHoYJDnF+OqgLcyzDgkBKdf+X8pc/YCgmtBsBFXc7hIbHV3DbnF80Dos6IX21lOTF39Hgkdx0m52EW9QIPc0eixPyOsLdwd8QzkfVsb22VaHnG/4uslWK8sNbCMk42D/4Cej1VreOk+jhCyKef9xk8wYnzSTTprcSsaSjCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oZFUmTNq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NoEWNHu6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 15:30:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740151806;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+WbqXhSby1aDKPGr0M/T81DyILQ5YV8cdLMRKnBZks=;
	b=oZFUmTNqoZCXtCccczNB2I0s/epXK1+Tzcov9dGO/qLEtxIuYAq4aOsB/OJMAJgk+LaLYv
	6rpi1uznDapN2lcrfioW4ubvbXct7znsKtBFNWS5YcofBbqSX6hYvnberz7c4rBX57LP5i
	OTR+nAYbMyGWdqjbH0kO78dKTA7a4+XNKUM34KUa0vude3sYIeHLYI7ULDcab2VllNRPd1
	LJqFVNlLowNGTeKD+ALFxwROyU9qqkM20+bZGKxpRfV3xal36qPUzJx6/6eUmN0g2vb3uf
	HPi+o+2T9n9ulOhUypO+hUibbDc2X6o0ZnW2T6IUvdqq8f6hxQ19OAtsiK8SBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740151806;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+WbqXhSby1aDKPGr0M/T81DyILQ5YV8cdLMRKnBZks=;
	b=NoEWNHu6lbMfvXTYBbgIrwXiPrurnnhndQvpaSyjK3goRf5Kw/moR9bD/mgo84d1K2vl8O
	84FdeZa2Yo/xDfBw==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Make MMU_GATHER_RCU_TABLE_FREE unconditional
Cc: Peter Zijlstra <peterz@infradead.org>, Rik van Riel <riel@surriel.com>,
 Ingo Molnar <mingo@kernel.org>, Manali Shukla <Manali.Shukla@amd.com>,
 Brendan Jackman <jackmanb@google.com>, Michael Kelley <mhklinux@outlook.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250213161423.449435-2-riel@surriel.com>
References: <20250213161423.449435-2-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174015180599.10177.1867663349266914555.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     a37259732a7dc33047fa1e4f9a338088f452e017
Gitweb:        https://git.kernel.org/tip/a37259732a7dc33047fa1e4f9a338088f452e017
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Thu, 13 Feb 2025 11:13:52 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 16:20:11 +01:00

x86/mm: Make MMU_GATHER_RCU_TABLE_FREE unconditional

Currently x86 uses CONFIG_MMU_GATHER_TABLE_FREE when using
paravirt, and not when running on bare metal.

There is no real good reason to do things differently for
each setup. Make them all the same.

Currently get_user_pages_fast synchronizes against page table
freeing in two different ways:

 - on bare metal, by blocking IRQs, which block TLB flush IPIs
 - on paravirt, with MMU_GATHER_RCU_TABLE_FREE

This is done because some paravirt TLB flush implementations
handle the TLB flush in the hypervisor, and will do the flush
even when the target CPU has interrupts disabled.

Always handle page table freeing with MMU_GATHER_RCU_TABLE_FREE.
Using RCU synchronization between page table freeing and get_user_pages_fast()
allows bare metal to also do TLB flushing while interrupts are disabled.

Various places in the mm do still block IRQs or disable preemption
as an implicit way to block RCU frees.

That makes it safe to use INVLPGB on AMD CPUs.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/20250213161423.449435-2-riel@surriel.com
---
 arch/x86/Kconfig           |  2 +-
 arch/x86/kernel/paravirt.c | 17 +----------------
 arch/x86/mm/pgtable.c      | 27 ++++-----------------------
 3 files changed, 6 insertions(+), 40 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c4175f4..d581634 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -278,7 +278,7 @@ config X86
 	select HAVE_PCI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select MMU_GATHER_RCU_TABLE_FREE	if PARAVIRT
+	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_MERGE_VMAS
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 1ccaa33..527f560 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -59,21 +59,6 @@ void __init native_pv_lock_init(void)
 		static_branch_enable(&virt_spin_lock_key);
 }
 
-#ifndef CONFIG_PT_RECLAIM
-static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	struct ptdesc *ptdesc = (struct ptdesc *)table;
-
-	pagetable_dtor(ptdesc);
-	tlb_remove_page(tlb, ptdesc_page(ptdesc));
-}
-#else
-static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	tlb_remove_table(tlb, table);
-}
-#endif
-
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
@@ -195,7 +180,7 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
 	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
 	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
-	.mmu.tlb_remove_table	= native_tlb_remove_table,
+	.mmu.tlb_remove_table	= tlb_remove_table,
 
 	.mmu.exit_mmap		= paravirt_nop,
 	.mmu.notify_page_enc_status_changed	= paravirt_nop,
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 1fef5ad..b1c1f72 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -18,25 +18,6 @@ EXPORT_SYMBOL(physical_mask);
 #define PGTABLE_HIGHMEM 0
 #endif
 
-#ifndef CONFIG_PARAVIRT
-#ifndef CONFIG_PT_RECLAIM
-static inline
-void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	struct ptdesc *ptdesc = (struct ptdesc *)table;
-
-	pagetable_dtor(ptdesc);
-	tlb_remove_page(tlb, ptdesc_page(ptdesc));
-}
-#else
-static inline
-void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	tlb_remove_table(tlb, table);
-}
-#endif /* !CONFIG_PT_RECLAIM */
-#endif /* !CONFIG_PARAVIRT */
-
 gfp_t __userpte_alloc_gfp = GFP_PGTABLE_USER | PGTABLE_HIGHMEM;
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
@@ -64,7 +45,7 @@ early_param("userpte", setup_userpte);
 void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {
 	paravirt_release_pte(page_to_pfn(pte));
-	paravirt_tlb_remove_table(tlb, page_ptdesc(pte));
+	tlb_remove_table(tlb, page_ptdesc(pte));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 2
@@ -78,21 +59,21 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 #ifdef CONFIG_X86_PAE
 	tlb->need_flush_all = 1;
 #endif
-	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(pmd));
+	tlb_remove_table(tlb, virt_to_ptdesc(pmd));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 3
 void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 {
 	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
-	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(pud));
+	tlb_remove_table(tlb, virt_to_ptdesc(pud));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
-	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(p4d));
+	tlb_remove_table(tlb, virt_to_ptdesc(p4d));
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 4 */
 #endif	/* CONFIG_PGTABLE_LEVELS > 3 */

