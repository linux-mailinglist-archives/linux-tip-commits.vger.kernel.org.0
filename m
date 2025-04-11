Return-Path: <linux-tip-commits+bounces-4874-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4E6A85915
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD91F9A384C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF2E238C13;
	Fri, 11 Apr 2025 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cdfEII9N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i7SJhtn2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270BC234248;
	Fri, 11 Apr 2025 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365738; cv=none; b=Rz9V2IWSyxiYSgT2lm6BVl1txYnsUoDdMvwrGZVDX5/DquIko6Jbb9p61bMHd3/S+DebRUgKt1CchXOohjODaEo4t86CF+ZPUQfXsDfl3Tg/tDijdUK5yp+HLt35XxkbKzT9IVaAiNu5e5fOYhCnUkTP1hAPC3mU5Aa5cfe7ExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365738; c=relaxed/simple;
	bh=CBmoUy1Je9usvL6H5C0daDRXORuQ1R23c/llG618tLY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RHDjoHPZrpeeO9aH9BzAuM9Wut9s8rBfF8I4bwwKtpyyIdv5OqBF6PwMzmop8sPj7YfJXpzG2SIJRh7tIgUPIfiegcy6ewV3TaAEC56E/rQiOkBqxitYe4GMdP0eWvszsHKEC/aUB5y1cFSWPn/hb0jt08sh4nFsOElXOPv+RKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cdfEII9N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i7SJhtn2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365734;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNQNHt7Y8PtuRnu/+q7UlW6YVTPTDvNtxgkknykv2NU=;
	b=cdfEII9NQggLOj+Wu0ZI4M9139MXVEmCLyoJhUK8G0SYdDkze2DQjIoSWECD/rKiTNumg3
	sfzR+7VT6K1pCxsh/zcg8yGXPWf1EA7hOFlTN3txeA4/YkWK29hQG/1oA6Ir4R/NF6pnC7
	pf5X1iJrPZq/011KcRq4UKJPqBKNZWE8MAN9EpLIsCHwoouiFjwcQKxC9/9vzPKH56+3nt
	rjMgIVLIc2tfCL3o50TW45VZOlBj4GcFEa0KqCdDzW/HXsuwVRHPAlLr2gLlsTzQ2Jc9N/
	2+CAEQ4GHxDMfGAmTtT786gsYYplIBdxQYOUsVP7AWNzvVZGjAHc67nv2M+muw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365734;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNQNHt7Y8PtuRnu/+q7UlW6YVTPTDvNtxgkknykv2NU=;
	b=i7SJhtn2Pstsq9LEJkAZLYWIx8Jw0Tc9X2ZBqcdYjmsh9/EEzC4/wIcPrfKcO3NA+UPl29
	SoRhzeuHIXehnFBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Remove the confusing,
 inaccurate & unnecessary 'temp_mm_state_t' abstraction
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-14-mingo@kernel.org>
References: <20250411054105.2341982-14-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436573360.31282.2298804383739211482.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     f5afa2e8efda592ecc69cea7528ff660ac1d8096
Gitweb:        https://git.kernel.org/tip/f5afa2e8efda592ecc69cea7528ff660ac1d8096
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:25 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Remove the confusing, inaccurate & unnecessary 'temp_mm_state_t' abstraction

So the temp_mm_state_t abstraction used by use_temporary_mm() and
unuse_temporary_mm() is super confusing:

 - The whole machinery is about temporarily switching to the
   text_poke_mm utility MM that got allocated during bootup
   for text-patching purposes alone:

	temp_mm_state_t prev;

        /*
         * Loading the temporary mm behaves as a compiler barrier, which
         * guarantees that the PTE will be set at the time memcpy() is done.
         */
        prev = use_temporary_mm(text_poke_mm);

 - Yet the value that gets saved in the temp_mm_state_t variable
   is not the temporary MM ... but the previous MM...

 - Ie. we temporarily put the non-temporary MM into a variable
   that has the temp_mm_state_t type. This makes no sense whatsoever.

 - The confusion continues in unuse_temporary_mm():

	static inline void unuse_temporary_mm(temp_mm_state_t prev_state)

   Here we unuse an MM that is ... not the temporary MM, but the
   previous MM. :-/

Fix up all this confusion by removing the unnecessary layer of
abstraction and using a bog-standard 'struct mm_struct *prev_mm'
variable to save the MM to.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-14-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b8794f7..0ee43aa 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2139,10 +2139,6 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 	}
 }
 
-typedef struct {
-	struct mm_struct *mm;
-} temp_mm_state_t;
-
 /*
  * Using a temporary mm allows to set temporary mappings that are not accessible
  * by other CPUs. Such mappings are needed to perform sensitive memory writes
@@ -2156,9 +2152,9 @@ typedef struct {
  *          loaded, thereby preventing interrupt handler bugs from overriding
  *          the kernel memory protection.
  */
-static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
+static inline struct mm_struct *use_temporary_mm(struct mm_struct *temp_mm)
 {
-	temp_mm_state_t temp_state;
+	struct mm_struct *prev_mm;
 
 	lockdep_assert_irqs_disabled();
 
@@ -2170,8 +2166,8 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 	if (this_cpu_read(cpu_tlbstate_shared.is_lazy))
 		leave_mm();
 
-	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
-	switch_mm_irqs_off(NULL, mm, current);
+	prev_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
+	switch_mm_irqs_off(NULL, temp_mm, current);
 
 	/*
 	 * If breakpoints are enabled, disable them while the temporary mm is
@@ -2187,17 +2183,17 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 	if (hw_breakpoint_active())
 		hw_breakpoint_disable();
 
-	return temp_state;
+	return prev_mm;
 }
 
 __ro_after_init struct mm_struct *text_poke_mm;
 __ro_after_init unsigned long text_poke_mm_addr;
 
-static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
+static inline void unuse_temporary_mm(struct mm_struct *prev_mm)
 {
 	lockdep_assert_irqs_disabled();
 
-	switch_mm_irqs_off(NULL, prev_state.mm, current);
+	switch_mm_irqs_off(NULL, prev_mm, current);
 
 	/* Clear the cpumask, to indicate no TLB flushing is needed anywhere */
 	cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(text_poke_mm));
@@ -2228,7 +2224,7 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 {
 	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
 	struct page *pages[2] = {NULL};
-	temp_mm_state_t prev;
+	struct mm_struct *prev_mm;
 	unsigned long flags;
 	pte_t pte, *ptep;
 	spinlock_t *ptl;
@@ -2286,7 +2282,7 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 	 * Loading the temporary mm behaves as a compiler barrier, which
 	 * guarantees that the PTE will be set at the time memcpy() is done.
 	 */
-	prev = use_temporary_mm(text_poke_mm);
+	prev_mm = use_temporary_mm(text_poke_mm);
 
 	kasan_disable_current();
 	func((u8 *)text_poke_mm_addr + offset_in_page(addr), src, len);
@@ -2307,7 +2303,7 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 	 * instruction that already allows the core to see the updated version.
 	 * Xen-PV is assumed to serialize execution in a similar manner.
 	 */
-	unuse_temporary_mm(prev);
+	unuse_temporary_mm(prev_mm);
 
 	/*
 	 * Flushing the TLB might involve IPIs, which would require enabled

