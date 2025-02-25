Return-Path: <linux-tip-commits+bounces-3618-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC76A44C15
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 21:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3591C173305
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 20:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3199B20E028;
	Tue, 25 Feb 2025 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fsaP+cGd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HWSPfibB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8217E39ACC;
	Tue, 25 Feb 2025 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514231; cv=none; b=tBCCQTL1y/2T+z881XRrTx7J7Rao0cy2m+sgadCz26auk1yhHaxwDoISmDIsIxdLMVvDoBfWV31+I2vkav3pdXeY624F0wEmRsExZoMKvL9Zo9aUz05QSfYcHhDGmd8qZCRWR383hz0ljvbni8POdUoioFWhVdOaFZ15lK9rabI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514231; c=relaxed/simple;
	bh=qDYT1e1m9ecN1KtKMGCvUM2nIMkPihySw+lOvlXbeh0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=HIrgRutlMIA/y4pZ8BNfCG5CVoOCUTRiLQKno/roqzlJLZ+053BM21iSbCEJrevjMt7vpXcSm8u1OI7o7krx3zJrcQ4MJVdBav7G6gI1V25/M0gz1eZ0STlvuEwJiLnkmKK0q1RugrZpbY2i32M0p1LNJDNKJWzwl/jGF7b/2A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fsaP+cGd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HWSPfibB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Feb 2025 20:10:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740514227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cmL1p/OsbYR4UnnPSo5AorXkCfVgmDpvTbyNsH22Tdw=;
	b=fsaP+cGdcpmPvg0MlTvU00ziUN/gwd6tqMJ6YD8k43U9FjG92dGPvdHA6ARQqDKUiZIvNR
	J0M5vxvgcC/DDKBIXfpmUenIrWf7kdQs7WpGSE9Jl6HkXL5hWa17e/pkxPwlG6L2L1PFwG
	mOvgV0X1tOtjeYysP+Bz6Vjh5RqbborN7zRubdq8thIYKm5SDKzYt3WZGl7us2JMZWlz46
	SyNUaAe1wzuC6wrplF4mVnNJ2wsriKh1kvU0h/m4RJH0pEbpTFHSyCVxaMqMsoI/hxk/F2
	dY2rDN6Z/RXVDLusckj/8Y1UPBwHnjHntLxDzKgZl3PbPoPTT67MtD8DCyPc1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740514227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cmL1p/OsbYR4UnnPSo5AorXkCfVgmDpvTbyNsH22Tdw=;
	b=HWSPfibBXailAF2MmCzc5K8tWTBZK4EWpzxgg8M98KlSxkjdP3LEiSHsGWnHbVmq8tVkDC
	eSziKYKR67cKZ6Dw==
From: "tip-bot2 for Matthew Wilcox (Oracle)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Clear _PAGE_DIRTY when we clear _PAGE_RW
Cc: kernel test robot <oliver.sang@intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174051422675.10177.13226545170101706336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     d75a256b6a64132fc7aab57ad4c96218e3ae383b
Gitweb:        https://git.kernel.org/tip/d75a256b6a64132fc7aab57ad4c96218e3ae383b
Author:        Matthew Wilcox (Oracle) <willy@infradead.org>
AuthorDate:    Tue, 25 Feb 2025 19:37:32 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Feb 2025 20:59:32 +01:00

x86/mm: Clear _PAGE_DIRTY when we clear _PAGE_RW

The bit pattern of _PAGE_DIRTY set and _PAGE_RW clear is used to
mark shadow stacks.  This is currently checked for in mk_pte() but
not pfn_pte().  If we add the check to pfn_pte(), it catches vfree()
calling set_direct_map_invalid_noflush() which calls __change_page_attr()
which loads the old protection bits from the PTE, clears the specified
bits and uses pfn_pte() to construct the new PTE.

We should, therefore, clear the _PAGE_DIRTY bit whenever we clear
_PAGE_RW.  I opted to do it in the callers in case we want to use
__change_page_attr() to create shadow stacks inside the kernel at some
point in the future.  Arguably, we might also want to clear _PAGE_ACCESSED
here.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/oe-lkp/202502241646.719f4651-lkp@intel.com
---
 arch/x86/mm/pat/set_memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 84d0bca..d174015 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2628,7 +2628,7 @@ static int __set_pages_np(struct page *page, int numpages)
 				.pgd = NULL,
 				.numpages = numpages,
 				.mask_set = __pgprot(0),
-				.mask_clr = __pgprot(_PAGE_PRESENT | _PAGE_RW),
+				.mask_clr = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY),
 				.flags = CPA_NO_CHECK_ALIAS };
 
 	/*
@@ -2715,7 +2715,7 @@ int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 		.pgd = pgd,
 		.numpages = numpages,
 		.mask_set = __pgprot(0),
-		.mask_clr = __pgprot(~page_flags & (_PAGE_NX|_PAGE_RW)),
+		.mask_clr = __pgprot(~page_flags & (_PAGE_NX|_PAGE_RW|_PAGE_DIRTY)),
 		.flags = CPA_NO_CHECK_ALIAS,
 	};
 
@@ -2758,7 +2758,7 @@ int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
 		.pgd		= pgd,
 		.numpages	= numpages,
 		.mask_set	= __pgprot(0),
-		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW),
+		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY),
 		.flags		= CPA_NO_CHECK_ALIAS,
 	};
 

