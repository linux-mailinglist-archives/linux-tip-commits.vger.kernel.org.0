Return-Path: <linux-tip-commits+bounces-3691-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A89A478AB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8285188FA43
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 09:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B2F227BAA;
	Thu, 27 Feb 2025 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vfr/6Gqj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LGYXm/5O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888B229B3C;
	Thu, 27 Feb 2025 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647103; cv=none; b=o5QPgJ2tl/cyYqFRSXk1osI+TWczRw78moT9ILp3upPklFQXUTw+/G25+nKcG97OKQ7w771ekZNomLCC27Dtxq1oG9b833/Z+kzGevgyR80SQkBrtGum+1SbqgI+KiffPKzJFcDEPzqpmXijJDheqmIywpUD48IEeD4UUsca4G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647103; c=relaxed/simple;
	bh=hJEgEsYMdc8r1P2YQfuOfXeRuCKjtmjxnSgr7JxGdCQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bdKKYYRTEjHgxyQrXPow9N7vDMG7dO7WnhrocwEuWlqHx6nO3+c/deMw8W6sSGHZETHpcpe2MGfw6Z5sUxvuhfKv1jQrTLRiNr1BT7WJysBsoxDBdGnFediRBCCnVd1pqWUvD4wVhq8cJW2OJPgOFGfioxv9VUn1C3aB7H0zy9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vfr/6Gqj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LGYXm/5O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 09:04:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740647099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ylzoQEmuhd4REW3S3P4w446IwA4hDH1SSyM5nagkaY=;
	b=Vfr/6GqjWYQ9g80VrknnJIP9xjaXymi5T8E2kGer72cAY5tF5zgvqRXk4ZUlf8H2UhBZly
	6E++ecrbATQ11OclMkIZiC1900aBExMzcPpJaiNahQvtyIg7+zt6kJdTHFx+tpqbYAMKWI
	f2FkhFKDuXBV5hK3cp9SUazFqvVCKv58k4h2IhjWCPj6wWnqunDXCIDNS1CMRTxL6fXJ+z
	zNLT8sNAHUgmErXGnn3BcXatYh4IJ3JdrgjR+G+ACBC7aoFej1ysV/Z6QYsDobK1AhUvrM
	KEOGOA6ExB/hsN4Xa+WMtl5Swpph8IVuzPAiG39gARm4GG+FdsgeTSlrZnHDXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740647099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ylzoQEmuhd4REW3S3P4w446IwA4hDH1SSyM5nagkaY=;
	b=LGYXm/5OqmqekmJQ9g30aenqoxfJ+PZIKYgE0wU7w1YU0z0ap4kgprP/w3lZdD4ezE4VLU
	GFpMKEp50RyMmiCQ==
From: "tip-bot2 for Matthew Wilcox (Oracle)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Clear _PAGE_DIRTY for kernel mappings when we
 clear _PAGE_RW
Cc: kernel test robot <oliver.sang@intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <174051422675.10177.13226545170101706336.tip-bot2@tip-bot2>
References: <174051422675.10177.13226545170101706336.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174064709593.10177.8365314982667248304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     c1fcf41cf37f7a3fd3bbf6f0c04aba3ea4258888
Gitweb:        https://git.kernel.org/tip/c1fcf41cf37f7a3fd3bbf6f0c04aba3ea4258888
Author:        Matthew Wilcox (Oracle) <willy@infradead.org>
AuthorDate:    Tue, 25 Feb 2025 19:37:32 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 09:58:17 +01:00

x86/mm: Clear _PAGE_DIRTY for kernel mappings when we clear _PAGE_RW

The bit pattern of _PAGE_DIRTY set and _PAGE_RW clear is used to mark
shadow stacks.  This is currently checked for in mk_pte() but not
pfn_pte().  If we add the check to pfn_pte(), it catches vfree()
calling set_direct_map_invalid_noflush() which calls
__change_page_attr() which loads the old protection bits from the
PTE, clears the specified bits and uses pfn_pte() to construct the
new PTE.

We should, therefore, for kernel mappings, clear the _PAGE_DIRTY bit
consistently whenever we clear _PAGE_RW.  I opted to do it in the
callers in case we want to use __change_page_attr() to create shadow
stacks inside the kernel at some point in the future.  Arguably, we
might also want to clear _PAGE_ACCESSED here.

Note that the 3 functions involved:

  __set_pages_np()
  kernel_map_pages_in_pgd()
  kernel_unmap_pages_in_pgd()

Only ever manipulate non-swappable kernel mappings, so maintaining
the DIRTY:1|RW:0 special pattern for shadow stacks and DIRTY:0
pattern for non-shadow-stack entries can be maintained consistently
and doesn't result in the unintended clearing of a live dirty bit
that could corrupt (destroy) dirty bit information for user mappings.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/174051422675.10177.13226545170101706336.tip-bot2@tip-bot2
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
 

