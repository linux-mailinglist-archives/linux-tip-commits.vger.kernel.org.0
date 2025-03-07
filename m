Return-Path: <linux-tip-commits+bounces-4049-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C57AEA56E5D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 17:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F099C1699E9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 16:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B864121C177;
	Fri,  7 Mar 2025 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0j/PDvY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7DD634EC;
	Fri,  7 Mar 2025 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366302; cv=none; b=sDJ9MXAqOJhVcs4r/M2MyLNgOoeR2Ap+ENpYKouFVpBzHEHLltLQVYMa4w00CxBSe67ANpetik8s4HLYnZnudHqysl+0mrlwWYumtuooyP9QU9z9E3CycncfVWUJDf5ysbRLgY5ji+xXGVXhZefPSUMrfRNqn70THaa8ivuwAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366302; c=relaxed/simple;
	bh=alWLxts8I1LVeHcFD4o9Tk354TpdfgHz+c6UXPKGrvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTxdt2v+DFBbXD/h1IsYUfKxKoTP6LFPHXgni61buxfFTWuFcfiDND1BoD/wkHZcBJudJS5zy4QiqSFwyEEQIRCIoZwchD1ClianvlAOVjpcYF0DwcKVqnzYE9SBZ9uLSbVmjKHAmUBgpmVa3aMFAz4Gnu1bfnHYglxD9W37QBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0j/PDvY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741366301; x=1772902301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=alWLxts8I1LVeHcFD4o9Tk354TpdfgHz+c6UXPKGrvk=;
  b=N0j/PDvYIPZ/7ksu6e04bddaHhT0/INH2+8m5NiIo04BTU1VmvZhUuQq
   3Z7hZGHNV5XZAwcNcwisIdCYalxLsMXqyUuzAWoIdkfEPpCjYUNW1oMFz
   EPxuPNfsblfR5jJ3PHVMTmcrez1lR+3JeY9c+CVi7LXukvcnKAAx+gZNF
   o5sLJPZrKcz6EJIor0ohzB0r5ycxRi+v+y//6Pk6/uh8Fq85555BPMg9a
   nwvCZrVWgHPSnnJZIdkIWBpLiQjkSlyslrHA1G7zrM2T4azNfbrWfZgv5
   H8ZzCgKYb1YI+I5lhYk5b+GezdsOlb/2lEtn6nxZQvN2SMkuby3a/EQ3H
   Q==;
X-CSE-ConnectionGUID: tiH8hyVuR8mcyFBNlW9YKA==
X-CSE-MsgGUID: Z9GVsp3LTum44YsKtk6c6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46345802"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="46345802"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 08:51:40 -0800
X-CSE-ConnectionGUID: WtD25zaFT3mXXARehBlPTA==
X-CSE-MsgGUID: 7Z7n2cvwQLuhP/uYgVY9Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="124601988"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 08:51:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqav9-00000000SjA-1hoP;
	Fri, 07 Mar 2025 18:51:35 +0200
Date: Fri, 7 Mar 2025 18:51:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	kernel test robot <lkp@intel.com>, x86@kernel.org
Subject: Re: [PATCH] x86/mm: Define PTRS_PER_PMD for assembly code too
Message-ID: <Z8skF4rtRzaDL2Ou@smile.fi.intel.com>
References: <20250306092658.378837-1-andriy.shevchenko@linux.intel.com>
 <174125602814.14745.12946945836213678532.tip-bot2@tip-bot2>
 <CAHk-=whTGVy1aaEashu3K49wuG7-hARh02xbAr_hMm3844Ec7Q@mail.gmail.com>
 <Z8oSAQiBvVJ_METQ@gmail.com>
 <Z8oa8AUVyi2HWfo9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8oa8AUVyi2HWfo9@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 06, 2025 at 11:00:16PM +0100, Ingo Molnar wrote:
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > Separating out the assembler-compatible defines from the types 
> > headers appears to be a bigger patch, since it's all mixed in with C 
> > syntax:
> > 
> > <=-----------------------------------===============================
> > typedef struct { pud_t pud; } pmd_t;
> > 
> > #define PMD_SHIFT       PUD_SHIFT
> > #define PTRS_PER_PMD    1
> > #define PMD_SIZE        (1UL << PMD_SHIFT)
> > #define PMD_MASK        (~(PMD_SIZE-1))
> > 
> > /*
> >  * The "pud_xxx()" functions here are trivial for a folded two-level
> >  * setup: the pmd is never bad, and a pmd always exists (as it's folded
> >  * into the pud entry)
> >  */
> > static inline int pud_none(pud_t pud)           { return 0; }
> > static inline int pud_bad(pud_t pud)            { return 0; }
> > static inline int pud_present(pud_t pud)        { return 1; }
> > ================================================================>
> > 
> > In any case I've removed the commit for the time being until this all 
> > is cleared up.
> 
> So there's a simple solution: define it on i386 too, via the patch 
> below. It appears the double-definition doesn't create any warnings, on 
> GCC at least.

Fine by me as long as it gets fixed. Currently it prevents the WERROR=y
to be used along with `make W=1` for x86_32 by both compilers.

> But if it's an issue, we could do something like this in 
> <asm-generic/pgtable-nopmd.h>:
> 
>  #if defined(PTRS_PER_PMD) && (PTRS_PER_PMD != 1)
>  # error "mm: Wait a minute, that's a super confusing pagetable setup ..."
>  #endif
> 
> ?
> 
> Thanks,
> 
> 	Ingo
> 
> =========================>
> From: Ingo Molnar <mingo@kernel.org>
> Date: Thu, 6 Mar 2025 22:53:49 +0100
> Subject: [PATCH] x86/mm: Define PTRS_PER_PMD for assembly code too
> 
> Andy reported the following build warning from head_32.S:
> 
>   In file included from arch/x86/kernel/head_32.S:29:
>   arch/x86/include/asm/pgtable_32.h:59:5: error: "PTRS_PER_PMD" is not defined, evaluates to 0 [-Werror=undef]
>        59 | #if PTRS_PER_PMD > 1
> 
> The reason is that on 2-level i386 paging the folded in PMD's
> PTRS_PER_PMD constant is not defined in assembly headers,
> only in generic MM C headers.
> 
> Instead of trying to fish out the definition from the generic
> headers, just define it - it even has a comment for it already...
> 
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/include/asm/pgtable-2level_types.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable-2level_types.h b/arch/x86/include/asm/pgtable-2level_types.h
> index 7f6ccff0ba72..4a12c276b181 100644
> --- a/arch/x86/include/asm/pgtable-2level_types.h
> +++ b/arch/x86/include/asm/pgtable-2level_types.h
> @@ -23,17 +23,17 @@ typedef union {
>  #define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PMD_MODIFIED
>  
>  /*
> - * traditional i386 two-level paging structure:
> + * Traditional i386 two-level paging structure:
>   */
>  
>  #define PGDIR_SHIFT	22
>  #define PTRS_PER_PGD	1024
>  
> -
>  /*
> - * the i386 is two-level, so we don't really have any
> - * PMD directory physically.
> + * The i386 is two-level, so we don't really have any
> + * PMD directory physically:
>   */
> +#define PTRS_PER_PMD	1

Should I give a try?

Okay, just

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

for x86_32 with Clang 19.1.7 and GCC 14.2.0.

-- 
With Best Regards,
Andy Shevchenko



