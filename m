Return-Path: <linux-tip-commits+bounces-4882-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B27BA85923
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736F99A2753
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96994272F6D;
	Fri, 11 Apr 2025 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J0qKQjcg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AJTL7JHP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937A8234237;
	Fri, 11 Apr 2025 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365743; cv=none; b=WKvHbT4mp5gebzTuu4tuis2ZyXIBvfV42huKK/g2XHmlwJ1KrvTA/lLI7sgMLDO/clAUoD9DjIQw9LZEqeTcyIA6NGuLNjGuMF+05QefOpXn27Ms+qDX8y5rwp2PBM0MWV2S4mqoQ+0XF5En558MXk29mL6Nykac7b+xYaI+MeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365743; c=relaxed/simple;
	bh=EjBnEEsEWEayCo2llLEqaDBJqlFX3DqRjRZNhkdPJYc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CBSO2TGSWXPWk6DHamPANmgvUqUKZM47dRFoB2t+sXc3yvz8kdKvK0Rc0mAio2SPkhhMc0Gr4iPeALJzFKS8nTTI3GORFY4SrHGCTvq2efFLfVw1zetf6Y44YGL2TUvfSr8oUA0dm2HHgU6E9FMo4oSYEDUh4mwvOiBl+21Zuok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J0qKQjcg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AJTL7JHP; arc=none smtp.client-ip=193.142.43.55
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
	bh=Lylv9Qw6JRT9z2qp3Wk4WrWh9rpqUSMqoDtxmUiFwB0=;
	b=J0qKQjcg+6D659GGSHhhfrQG+Nrp2SiHtRQl3886iv42V6paOen2Ynw0r+43a9HZ2oHJeQ
	OaB8et28WFAQajWJEClxQtiFysecEy48EzMMeXRZUk7+RaNU8drFaPyZGnJADjkQBLRi7K
	XRTEyWE732imoH1Lri6l2HKsKvv/oX7tfNz8boKicm64l1VNr2vEDxYYkJkOyN3XqrFUTB
	b8yXhg/ixU7uB9pHLsx8i/K+ZSzaYUnHFiT460nmnieflSfKGPD62Mf1iYcMge6XlhKjPI
	1MDabkHYWn/OoBLoBuGpX4ojE5jGbZJ763cZjTuYGxjOMWlq4M9My5tPuuov4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365737;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lylv9Qw6JRT9z2qp3Wk4WrWh9rpqUSMqoDtxmUiFwB0=;
	b=AJTL7JHPnQE0keyWikrVf1HJu5pdusGS4Fv9gpaIFW7hid4X0e3zaeuF3YUY7milonCcUI
	x6CYYHT4FcMQQ+Cw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename 'poking_mm' to
 'text_poke_mm'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-9-mingo@kernel.org>
References: <20250411054105.2341982-9-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436573698.31282.6538293897528770259.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     a5c832e0476e461af46a0aa9bda43a573adbe63f
Gitweb:        https://git.kernel.org/tip/a5c832e0476e461af46a0aa9bda43a573adbe63f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Rename 'poking_mm' to 'text_poke_mm'

Put it into the text_poke_* namespace of <asm/text-patching.h>.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-9-mingo@kernel.org
---
 arch/x86/include/asm/text-patching.h |  2 +-
 arch/x86/kernel/alternative.c        | 18 +++++++++---------
 arch/x86/mm/init.c                   |  8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 93a6b7b..7a95c08 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -128,7 +128,7 @@ void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
 }
 
 extern int after_bootmem;
-extern __ro_after_init struct mm_struct *poking_mm;
+extern __ro_after_init struct mm_struct *text_poke_mm;
 extern __ro_after_init unsigned long poking_addr;
 
 #ifndef CONFIG_UML_X86
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d2cd0d8..8ce0d46 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2191,7 +2191,7 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 	return temp_state;
 }
 
-__ro_after_init struct mm_struct *poking_mm;
+__ro_after_init struct mm_struct *text_poke_mm;
 __ro_after_init unsigned long poking_addr;
 
 static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
@@ -2201,7 +2201,7 @@ static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
 	switch_mm_irqs_off(NULL, prev_state.mm, current);
 
 	/* Clear the cpumask, to indicate no TLB flushing is needed anywhere */
-	cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(poking_mm));
+	cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(text_poke_mm));
 
 	/*
 	 * Restore the breakpoints if they were disabled before the temporary mm
@@ -2266,7 +2266,7 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 	/*
 	 * The lock is not really needed, but this allows to avoid open-coding.
 	 */
-	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
+	ptep = get_locked_pte(text_poke_mm, poking_addr, &ptl);
 
 	/*
 	 * This must not fail; preallocated in poking_init().
@@ -2276,18 +2276,18 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 	local_irq_save(flags);
 
 	pte = mk_pte(pages[0], pgprot);
-	set_pte_at(poking_mm, poking_addr, ptep, pte);
+	set_pte_at(text_poke_mm, poking_addr, ptep, pte);
 
 	if (cross_page_boundary) {
 		pte = mk_pte(pages[1], pgprot);
-		set_pte_at(poking_mm, poking_addr + PAGE_SIZE, ptep + 1, pte);
+		set_pte_at(text_poke_mm, poking_addr + PAGE_SIZE, ptep + 1, pte);
 	}
 
 	/*
 	 * Loading the temporary mm behaves as a compiler barrier, which
 	 * guarantees that the PTE will be set at the time memcpy() is done.
 	 */
-	prev = use_temporary_mm(poking_mm);
+	prev = use_temporary_mm(text_poke_mm);
 
 	kasan_disable_current();
 	func((u8 *)poking_addr + offset_in_page(addr), src, len);
@@ -2299,9 +2299,9 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 	 */
 	barrier();
 
-	pte_clear(poking_mm, poking_addr, ptep);
+	pte_clear(text_poke_mm, poking_addr, ptep);
 	if (cross_page_boundary)
-		pte_clear(poking_mm, poking_addr + PAGE_SIZE, ptep + 1);
+		pte_clear(text_poke_mm, poking_addr + PAGE_SIZE, ptep + 1);
 
 	/*
 	 * Loading the previous page-table hierarchy requires a serializing
@@ -2314,7 +2314,7 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 	 * Flushing the TLB might involve IPIs, which would require enabled
 	 * IRQs, but not if the mm is not used, as it is in this point.
 	 */
-	flush_tlb_mm_range(poking_mm, poking_addr, poking_addr +
+	flush_tlb_mm_range(text_poke_mm, poking_addr, poking_addr +
 			   (cross_page_boundary ? 2 : 1) * PAGE_SIZE,
 			   PAGE_SHIFT, false);
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index bfa444a..84b52a1 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -824,11 +824,11 @@ void __init poking_init(void)
 	spinlock_t *ptl;
 	pte_t *ptep;
 
-	poking_mm = mm_alloc();
-	BUG_ON(!poking_mm);
+	text_poke_mm = mm_alloc();
+	BUG_ON(!text_poke_mm);
 
 	/* Xen PV guests need the PGD to be pinned. */
-	paravirt_enter_mmap(poking_mm);
+	paravirt_enter_mmap(text_poke_mm);
 
 	/*
 	 * Randomize the poking address, but make sure that the following page
@@ -848,7 +848,7 @@ void __init poking_init(void)
 	 * needed for poking now. Later, poking may be performed in an atomic
 	 * section, which might cause allocation to fail.
 	 */
-	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
+	ptep = get_locked_pte(text_poke_mm, poking_addr, &ptl);
 	BUG_ON(!ptep);
 	pte_unmap_unlock(ptep, ptl);
 }

