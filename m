Return-Path: <linux-tip-commits+bounces-4401-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547C7A69AA3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 22:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D30423A49
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 21:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDD24A1D;
	Wed, 19 Mar 2025 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ueX4DND5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lz0Lqe/T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703C3801;
	Wed, 19 Mar 2025 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418718; cv=none; b=EULYLlAy8rVWM3kO//P8DvvEiBI1qozbvHN2QNSayFcCbZdxd1OUUHS7kD2FvTKGFc+WxdFqihz95kUuWPI3PNMzdv8DkU52XdeK00Dv3sWfgojHB/fTgdDyjRtk7yGRA1MLaJqmt3ZR/t2GuXs0qkn2B+CPVAZ5tIPj6BffsGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418718; c=relaxed/simple;
	bh=A6RTyasNAkV2fMXFUYUBGDOoJnv5eMzBGz/wFjqEaIM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aIbnbX6RHnhoo4aJROHTgHJ82d+xDVJF/i699nnrHCupD6JlCmeygpPkwMviyjYfOc2enpxzxkB+ZXUNwlO3DBLXG+mhsRCYDDZrAdGx5csIXc/zMG3u6cFYgiQM/Kw/HessZBTTLKC5eDlqEAJRGNZ4VIZgLAPum8u6sTPpwp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ueX4DND5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lz0Lqe/T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 21:11:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742418714;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/L9kH7aEtoTEzooZPUsLL8PoE5Ip40F4+tUcrST9Pk=;
	b=ueX4DND5SZfQrB6DjyXLhq8uv9N1uv9yLZwPeC3cmQ9NtOSjGsIBWnrZPK7p3NBzLob5Bf
	PdGbu6A91wYDeAlfgCu2KODInPjj+ewxK/MhMkeoENkyV1rozoxPZemGsMg2vdPYmap2J2
	fmJ0OJbyANG4on3vHMwm9ugLZZh0DyxPT84GreVtVJvDJVSa8VFHVLqBcSERg1z6VYH3Ic
	1DJcz3oLHP5qbeCpWx7nGD2Wa3bCaR5JWpEk2wKwFhS3eSoZmE8Rg7MWpqxu5oE3bQaJMb
	SFxqegx8a19hn3Y6D4MGo3DDPTqUhPb8f3TsxqAKzLvg7vWavGY9okzIX4Sm+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742418714;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/L9kH7aEtoTEzooZPUsLL8PoE5Ip40F4+tUcrST9Pk=;
	b=lz0Lqe/T0lf5xcS0lkp2kWeCwhSDCRfZ39Wv9I+Sb4+pgLedM0OiirGBb1gYsSEVzv3wGu
	YkFPPABSd5cVGlCg==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/mm: Only do broadcast flush from reclaim if pages
 were unmapped
Cc: Rik van Riel <riel@surriel.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319132520.6b10ad90@fangorn>
References: <20250319132520.6b10ad90@fangorn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174241871098.14745.5835208191022684505.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     0b7eb55cb706e92d6073e4ab63ccd4d219cf2cda
Gitweb:        https://git.kernel.org/tip/0b7eb55cb706e92d6073e4ab63ccd4d219cf2cda
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Wed, 19 Mar 2025 13:25:20 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 21:56:42 +01:00

x86/mm: Only do broadcast flush from reclaim if pages were unmapped

Track whether pages were unmapped from any MM (even ones with a currently
empty mm_cpumask) by the reclaim code, to figure out whether or not
broadcast TLB flush should be done when reclaim finishes.

The reason any MM must be tracked, and not only ones contributing to the
tlbbatch cpumask, is that broadcast ASIDs are expected to be kept up to
date even on CPUs where the MM is not currently active.

This change allows reclaim to avoid doing TLB flushes when only clean page
cache pages and/or slab memory were reclaimed, which is fairly common.

( This is a simpler alternative to the code that was in my INVLPGB series
  before, and it seems to capture most of the benefit due to how common
  it is to reclaim only page cache. )

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250319132520.6b10ad90@fangorn
---
 arch/x86/include/asm/tlbbatch.h | 5 +++++
 arch/x86/include/asm/tlbflush.h | 1 +
 arch/x86/mm/tlb.c               | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbbatch.h b/arch/x86/include/asm/tlbbatch.h
index 1ad56eb..80aaf64 100644
--- a/arch/x86/include/asm/tlbbatch.h
+++ b/arch/x86/include/asm/tlbbatch.h
@@ -10,6 +10,11 @@ struct arch_tlbflush_unmap_batch {
 	 * the PFNs being flushed..
 	 */
 	struct cpumask cpumask;
+	/*
+	 * Set if pages were unmapped from any MM, even one that does not
+	 * have active CPUs in its cpumask.
+	 */
+	bool unmapped_pages;
 };
 
 #endif /* _ARCH_X86_TLBBATCH_H */
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 7cad283..a9af875 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -353,6 +353,7 @@ static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
 {
 	inc_mm_tlb_gen(mm);
 	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
+	batch->unmapped_pages = true;
 	mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
 }
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 0efd990..0925768 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1633,8 +1633,9 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	 * a local TLB flush is needed. Optimize this use-case by calling
 	 * flush_tlb_func_local() directly in this case.
 	 */
-	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB) && batch->unmapped_pages) {
 		invlpgb_flush_all_nonglobals();
+		batch->unmapped_pages = false;
 	} else if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
 		flush_tlb_multi(&batch->cpumask, info);
 	} else if (cpumask_test_cpu(cpu, &batch->cpumask)) {

