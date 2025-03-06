Return-Path: <linux-tip-commits+bounces-4039-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F23DA55932
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 23:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722441763EC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 22:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E575C27C14D;
	Thu,  6 Mar 2025 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bi9LCvTA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F95277024;
	Thu,  6 Mar 2025 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298421; cv=none; b=cwXHtHKibSdz+wdej6pRMmLpGDdRhqjdEsd3uguQDNZ0tNtoPEDex7CA3If9ZWImhmocaAIhXjewoOvsHXtxu4yYLmj1fmu2pLeUdxYR61Ml7bKCnMPFZTq8E3wG+gbp042NOgiAWe6v6HB1S3MbIo1TurWAuPhv/7zl0xc/ls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298421; c=relaxed/simple;
	bh=Zs+tTAIxX3ePN/KYhRZTW8Wmq0k2cGIFNrzoMNDUR3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5G0VzO/rfVAF2Iiq8CV0LpiXYByde9zD/FhH+MDeNS6v3QuH2jrf9FsC/37p/c34Hz5iW2MORk95bvky1GKntniCcXnewyyh0ZkZrIpl1oY5W8c6rDYU1PWGcNuKlq5FW55cWoZqT4y9HRYGmjKugE5nYWZeV6XG5yAu5lbVTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bi9LCvTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5265C4CEE0;
	Thu,  6 Mar 2025 22:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741298420;
	bh=Zs+tTAIxX3ePN/KYhRZTW8Wmq0k2cGIFNrzoMNDUR3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bi9LCvTA7VrS+yobZyd4FP6V2NU7Jd84HaSskT/Bjxn2Riy6icyAiJIBk+F2GEAYm
	 hmR7FLVHWQU1VQTYnZxeDOibogfv08JIRoN8ZxmVKnXZfISxfHAiVxMs2a8QIb1a7V
	 i11P+wNAkaDnzISQBzUho3Z0/d3fZbm+SI6GHjGF1p05tKdLeXQq4u6lJrGNWki8Xk
	 N0oFVRf1XhHmJnp09vO05dWY4sSzn8/H65GxABDUdLE6awBX2TKOX/j1bx4Nol0VJf
	 KsT8NtJYKb5Oo/q12j2VHf77aa8FTZagXqzBg1Dw0N+5q97X7ybdPV7LSVOqedindd
	 eggVxomNEsBJA==
Date: Thu, 6 Mar 2025 23:00:16 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, x86@kernel.org
Subject: [PATCH] x86/mm: Define PTRS_PER_PMD for assembly code too
Message-ID: <Z8oa8AUVyi2HWfo9@gmail.com>
References: <20250306092658.378837-1-andriy.shevchenko@linux.intel.com>
 <174125602814.14745.12946945836213678532.tip-bot2@tip-bot2>
 <CAHk-=whTGVy1aaEashu3K49wuG7-hARh02xbAr_hMm3844Ec7Q@mail.gmail.com>
 <Z8oSAQiBvVJ_METQ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8oSAQiBvVJ_METQ@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> Separating out the assembler-compatible defines from the types 
> headers appears to be a bigger patch, since it's all mixed in with C 
> syntax:
> 
> <=-----------------------------------===============================
> typedef struct { pud_t pud; } pmd_t;
> 
> #define PMD_SHIFT       PUD_SHIFT
> #define PTRS_PER_PMD    1
> #define PMD_SIZE        (1UL << PMD_SHIFT)
> #define PMD_MASK        (~(PMD_SIZE-1))
> 
> /*
>  * The "pud_xxx()" functions here are trivial for a folded two-level
>  * setup: the pmd is never bad, and a pmd always exists (as it's folded
>  * into the pud entry)
>  */
> static inline int pud_none(pud_t pud)           { return 0; }
> static inline int pud_bad(pud_t pud)            { return 0; }
> static inline int pud_present(pud_t pud)        { return 1; }
> ================================================================>
> 
> In any case I've removed the commit for the time being until this all 
> is cleared up.

So there's a simple solution: define it on i386 too, via the patch 
below. It appears the double-definition doesn't create any warnings, on 
GCC at least.

But if it's an issue, we could do something like this in 
<asm-generic/pgtable-nopmd.h>:

 #if defined(PTRS_PER_PMD) && (PTRS_PER_PMD != 1)
 # error "mm: Wait a minute, that's a super confusing pagetable setup ..."
 #endif

?

Thanks,

	Ingo

=========================>
From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 6 Mar 2025 22:53:49 +0100
Subject: [PATCH] x86/mm: Define PTRS_PER_PMD for assembly code too

Andy reported the following build warning from head_32.S:

  In file included from arch/x86/kernel/head_32.S:29:
  arch/x86/include/asm/pgtable_32.h:59:5: error: "PTRS_PER_PMD" is not defined, evaluates to 0 [-Werror=undef]
       59 | #if PTRS_PER_PMD > 1

The reason is that on 2-level i386 paging the folded in PMD's
PTRS_PER_PMD constant is not defined in assembly headers,
only in generic MM C headers.

Instead of trying to fish out the definition from the generic
headers, just define it - it even has a comment for it already...

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable-2level_types.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-2level_types.h b/arch/x86/include/asm/pgtable-2level_types.h
index 7f6ccff0ba72..4a12c276b181 100644
--- a/arch/x86/include/asm/pgtable-2level_types.h
+++ b/arch/x86/include/asm/pgtable-2level_types.h
@@ -23,17 +23,17 @@ typedef union {
 #define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PMD_MODIFIED
 
 /*
- * traditional i386 two-level paging structure:
+ * Traditional i386 two-level paging structure:
  */
 
 #define PGDIR_SHIFT	22
 #define PTRS_PER_PGD	1024
 
-
 /*
- * the i386 is two-level, so we don't really have any
- * PMD directory physically.
+ * The i386 is two-level, so we don't really have any
+ * PMD directory physically:
  */
+#define PTRS_PER_PMD	1
 
 #define PTRS_PER_PTE	1024
 


