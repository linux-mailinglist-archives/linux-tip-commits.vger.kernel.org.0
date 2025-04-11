Return-Path: <linux-tip-commits+bounces-4878-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42606A8591A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39D28C3EF7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A176124DC61;
	Fri, 11 Apr 2025 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gHD+D87i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jVP9xNl3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE95238C1D;
	Fri, 11 Apr 2025 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365740; cv=none; b=rkvmVXx6nnqPl1vFj4Nk9otU/Oc4mkoNcv3yLMKabtFgy+UGI4TCfZYb5v8q7IgIZ+aNUOPCLtFookBg1yuf8PSsHS62cVw/atS7qv7xtNEPWmE+3kilokxIxOsO6ZQ22z8M0xu9Xo4jJpVRKHDviGkhwqDAFnHDfqUIKCdqcDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365740; c=relaxed/simple;
	bh=rXYUoCY5cTRw9oWxdtC17jPUYcuqZrcw1fG3lqV4Yo8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cJuwX1np6EwEN8oxMRiE1lOyW2s+OLA8gZLMHpU36S7xDGkz0tfxrelMnocHctHrIguffzayhwqUS+gpX5Nzid/7SVdBv9p0AnsgE5WAqFAk2NanL2vAVqrVIE1ZZwValVbAG7e/UkogUKfJKPuz7KTumnriH24/kSwwMShy+rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gHD+D87i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jVP9xNl3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365737;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owvqiXSL4GyNicDFwG13QMzNwtQ5P3as10A2Ol+xxaE=;
	b=gHD+D87ivgHZFQir1UputCKM3t/YyY1//OcPCa9XJiLRYQuDn+RmELlfJd0hxKlpY4wgli
	hCZqpihOok0MRNunA9+Q8BRfsKr6O5eOgthO6pBerf7+YV/pCC/rM5wTHn6KJsbnPeIEo/
	lzNLplOb+xqARhE63i+95JXzUwVfCYRGYcuXks7mKbmw4xfbUvFRdcYH5BR+LjqF49Ipxr
	nyWylpTGOjEJnDuN8LWLFahq4sBId0PcaN9VwLs1V5ZNzpbOtdck+zJ0WsPEiExltalmyB
	gSpjygNk6sJU+DmkbZ4SdldQxA0vm5ydTc680axtZe0v+Egfw4qCrD7hcpEhWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365737;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owvqiXSL4GyNicDFwG13QMzNwtQ5P3as10A2Ol+xxaE=;
	b=jVP9xNl3tcz4zWNrBC4oJJc03ZmFdt/L6EFt6IqR6rxKfo8YtUFWpYXA2uf2C7Cu+6lrJ0
	7zv7xAPfqu7nLqAw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename 'poking_addr' to
 'text_poke_mm_addr'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-10-mingo@kernel.org>
References: <20250411054105.2341982-10-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436573633.31282.4677765718126736719.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     da364fc547897ed98fbf2192d86b5242439d7762
Gitweb:        https://git.kernel.org/tip/da364fc547897ed98fbf2192d86b5242439d7762
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:21 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Rename 'poking_addr' to 'text_poke_mm_addr'

Put it into the text_poke_* namespace of <asm/text-patching.h>.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-10-mingo@kernel.org
---
 arch/x86/include/asm/text-patching.h |  2 +-
 arch/x86/kernel/alternative.c        | 16 ++++++++--------
 arch/x86/mm/init.c                   | 10 +++++-----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 7a95c08..c8eac8c 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -129,7 +129,7 @@ void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
 
 extern int after_bootmem;
 extern __ro_after_init struct mm_struct *text_poke_mm;
-extern __ro_after_init unsigned long poking_addr;
+extern __ro_after_init unsigned long text_poke_mm_addr;
 
 #ifndef CONFIG_UML_X86
 static __always_inline
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8ce0d46..62d7444 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2192,7 +2192,7 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 }
 
 __ro_after_init struct mm_struct *text_poke_mm;
-__ro_after_init unsigned long poking_addr;
+__ro_after_init unsigned long text_poke_mm_addr;
 
 static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
 {
@@ -2266,7 +2266,7 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 	/*
 	 * The lock is not really needed, but this allows to avoid open-coding.
 	 */
-	ptep = get_locked_pte(text_poke_mm, poking_addr, &ptl);
+	ptep = get_locked_pte(text_poke_mm, text_poke_mm_addr, &ptl);
 
 	/*
 	 * This must not fail; preallocated in poking_init().
@@ -2276,11 +2276,11 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 	local_irq_save(flags);
 
 	pte = mk_pte(pages[0], pgprot);
-	set_pte_at(text_poke_mm, poking_addr, ptep, pte);
+	set_pte_at(text_poke_mm, text_poke_mm_addr, ptep, pte);
 
 	if (cross_page_boundary) {
 		pte = mk_pte(pages[1], pgprot);
-		set_pte_at(text_poke_mm, poking_addr + PAGE_SIZE, ptep + 1, pte);
+		set_pte_at(text_poke_mm, text_poke_mm_addr + PAGE_SIZE, ptep + 1, pte);
 	}
 
 	/*
@@ -2290,7 +2290,7 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 	prev = use_temporary_mm(text_poke_mm);
 
 	kasan_disable_current();
-	func((u8 *)poking_addr + offset_in_page(addr), src, len);
+	func((u8 *)text_poke_mm_addr + offset_in_page(addr), src, len);
 	kasan_enable_current();
 
 	/*
@@ -2299,9 +2299,9 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 	 */
 	barrier();
 
-	pte_clear(text_poke_mm, poking_addr, ptep);
+	pte_clear(text_poke_mm, text_poke_mm_addr, ptep);
 	if (cross_page_boundary)
-		pte_clear(text_poke_mm, poking_addr + PAGE_SIZE, ptep + 1);
+		pte_clear(text_poke_mm, text_poke_mm_addr + PAGE_SIZE, ptep + 1);
 
 	/*
 	 * Loading the previous page-table hierarchy requires a serializing
@@ -2314,7 +2314,7 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 	 * Flushing the TLB might involve IPIs, which would require enabled
 	 * IRQs, but not if the mm is not used, as it is in this point.
 	 */
-	flush_tlb_mm_range(text_poke_mm, poking_addr, poking_addr +
+	flush_tlb_mm_range(text_poke_mm, text_poke_mm_addr, text_poke_mm_addr +
 			   (cross_page_boundary ? 2 : 1) * PAGE_SIZE,
 			   PAGE_SHIFT, false);
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 84b52a1..f8c74d1 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -835,20 +835,20 @@ void __init poking_init(void)
 	 * will be mapped at the same PMD. We need 2 pages, so find space for 3,
 	 * and adjust the address if the PMD ends after the first one.
 	 */
-	poking_addr = TASK_UNMAPPED_BASE;
+	text_poke_mm_addr = TASK_UNMAPPED_BASE;
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
-		poking_addr += (kaslr_get_random_long("Poking") & PAGE_MASK) %
+		text_poke_mm_addr += (kaslr_get_random_long("Poking") & PAGE_MASK) %
 			(TASK_SIZE - TASK_UNMAPPED_BASE - 3 * PAGE_SIZE);
 
-	if (((poking_addr + PAGE_SIZE) & ~PMD_MASK) == 0)
-		poking_addr += PAGE_SIZE;
+	if (((text_poke_mm_addr + PAGE_SIZE) & ~PMD_MASK) == 0)
+		text_poke_mm_addr += PAGE_SIZE;
 
 	/*
 	 * We need to trigger the allocation of the page-tables that will be
 	 * needed for poking now. Later, poking may be performed in an atomic
 	 * section, which might cause allocation to fail.
 	 */
-	ptep = get_locked_pte(text_poke_mm, poking_addr, &ptl);
+	ptep = get_locked_pte(text_poke_mm, text_poke_mm_addr, &ptl);
 	BUG_ON(!ptep);
 	pte_unmap_unlock(ptep, ptl);
 }

