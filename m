Return-Path: <linux-tip-commits+bounces-5071-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA323A9358F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 11:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648C0189639D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6179E20CCFF;
	Fri, 18 Apr 2025 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PFI5dNLL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C42204F6F;
	Fri, 18 Apr 2025 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744969841; cv=none; b=QLQlYTYsr/GYk3VkCT/EnkRLhaZyYWKRYVhEUJZiZjS7H/qNZxySQJ4gqMjAiFTNGPfmlRKziFgDzOwliwJVJNGJueCvJaNw7b2LKWY+TO2ZxYIoXTNd7cg2d/jhTo0dbFICtdm5q9LjCYajW57rtD5mg6KKmsX7QdkXyKD1Pmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744969841; c=relaxed/simple;
	bh=4oWpSTc9qKph3hl8y8YBVLf3NCdy8RejW7w5leGIgLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U35QUXbGlTNbGy4FblpDCVkOUKC3apy5e3q1kWeGqSCzE/+R/c3YfEfje/xjNM+CPXlUjKw06NoWLKj+XK1RXl7NoheqDDQAQGkESSC5L2H64JKPRJF9D1Ypx0Br31iGmGZZChpSevCDgZwZgHcww+mpB+wzmU8/dC/dxxS6e1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PFI5dNLL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1wU3onK3VDy96ry8Q0RFciG/KE4gBkJHePhzzlypOjc=; b=PFI5dNLLmxjLVp2VSS44dkihKR
	W7mbuieMs8WCh9IibqtmC5n33P5BBX94SUe4Pn+FVMAbh88qyVPx4eEw2oq5rsc1CirB1UMNRTQOw
	KLwpOW6U8udoafNkoV4Y1cM5lBmORiLkVPLM6ODfgPY0H15jsafydG7FRNS/Y39WYZuwP3wEmvKnD
	TNKZYpJqi6pYmpUw42GDTsbx8bwi8q1VJwNJOeaXOUVG/z5T98yAuVb9SabghWoeD3z8Br/HLIECn
	IU4EcIDPDmZKWJS74DDe9xg7ri9HVqiayt76GYSuOnjVijKljXK4IAdB3SfPB+lqlFjTwHBGbiyWk
	iQg2Y6Jw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5iMk-0000000CeGU-2C7d;
	Fri, 18 Apr 2025 09:50:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BC37A300619; Fri, 18 Apr 2025 11:50:34 +0200 (CEST)
Date: Fri, 18 Apr 2025 11:50:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: x86/alternatives] x86/efi: Make efi_enter/leave_mm() use
 the use_/unuse_temporary_mm() machinery
Message-ID: <20250418095034.GR38216@noisy.programming.kicks-ass.net>
References: <20250402094540.3586683-7-mingo@kernel.org>
 <174448360887.31282.4227052210506129936.tip-bot2@tip-bot2>
 <20250417141751.GAaAENj1RsBOtp2Tvb@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417141751.GAaAENj1RsBOtp2Tvb@fat_crate.local>

On Thu, Apr 17, 2025 at 04:17:51PM +0200, Borislav Petkov wrote:
> On Sat, Apr 12, 2025 at 06:46:48PM -0000, tip-bot2 for Andy Lutomirski wrote:
> > The following commit has been merged into the x86/alternatives branch of tip:
> > 
> > Commit-ID:     e7021e2fe0b4335523d3f6e2221000bdfc633b62
> > Gitweb:        https://git.kernel.org/tip/e7021e2fe0b4335523d3f6e2221000bdfc633b62
> > Author:        Andy Lutomirski <luto@kernel.org>
> > AuthorDate:    Wed, 02 Apr 2025 11:45:39 +02:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Sat, 12 Apr 2025 10:06:04 +02:00
> > 
> > x86/efi: Make efi_enter/leave_mm() use the use_/unuse_temporary_mm() machinery
> > 
> > This should be considerably more robust.  It's also necessary for optimized
> > for_each_possible_lazymm_cpu() on x86 -- without this patch, EFI calls in
> > lazy context would remove the lazy mm from mm_cpumask().
> > 
> > [ mingo: Merged it on top of x86/alternatives ]
> > 
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Link: https://lore.kernel.org/r/20250402094540.3586683-7-mingo@kernel.org
> > ---
> >  arch/x86/platform/efi/efi_64.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> > index ac57259..a5d3496 100644
> > --- a/arch/x86/platform/efi/efi_64.c
> > +++ b/arch/x86/platform/efi/efi_64.c
> > @@ -434,15 +434,12 @@ void __init efi_dump_pagetable(void)
> >   */
> >  static void efi_enter_mm(void)
> >  {
> > -	efi_prev_mm = current->active_mm;
> > -	current->active_mm = &efi_mm;
> > -	switch_mm(efi_prev_mm, &efi_mm, NULL);
> > +	efi_prev_mm = use_temporary_mm(&efi_mm);
> >  }
> >  
> >  static void efi_leave_mm(void)
> >  {
> > -	current->active_mm = efi_prev_mm;
> > -	switch_mm(&efi_mm, efi_prev_mm, NULL);
> > +	unuse_temporary_mm(efi_prev_mm);
> >  }
> >  
> >  void arch_efi_call_virt_setup(void)
> 
> mingo thinks this one causes this:
> 
> [    0.119491] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.119498] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
> [    0.137368] Freeing SMP alternatives memory: 40K
> [    0.137381] pid_max: default: 32768 minimum: 301
> [    0.137496] ------------[ cut here ]------------
> [    0.137502] WARNING: CPU: 0 PID: 0 at arch/x86/mm/tlb.c:795 switch_mm_irqs_off+0x3d3/0x460
> [    0.137516] Modules linked in:

Ah yes :-( Something like so perhaps..

---
Subject: x86/mm: Fix {,un}use_temporary_mm() IRQ state

As the function switch_mm_irqs_off() implies, it ought to be called with
IRQs *off*. Commit 58f8ffa91766 ("x86/mm: Allow temporary MMs when IRQs
are on") caused this to not be the case for EFI.

Ensure IRQs are off where it matters.

Fixes: 58f8ffa91766 ("x86/mm: Allow temporary MMs when IRQs are on")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 92bde0d6205a..1451e022129a 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -991,6 +991,7 @@ struct mm_struct *use_temporary_mm(struct mm_struct *temp_mm)
 	struct mm_struct *prev_mm;
 
 	lockdep_assert_preemption_disabled();
+	guard(irqsave)();
 
 	/*
 	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
@@ -1023,6 +1024,7 @@ struct mm_struct *use_temporary_mm(struct mm_struct *temp_mm)
 void unuse_temporary_mm(struct mm_struct *prev_mm)
 {
 	lockdep_assert_preemption_disabled();
+	guard(irqsave)();
 
 	/* Clear the cpumask, to indicate no TLB flushing is needed anywhere */
 	cpumask_clear_cpu(smp_processor_id(), mm_cpumask(this_cpu_read(cpu_tlbstate.loaded_mm)));

