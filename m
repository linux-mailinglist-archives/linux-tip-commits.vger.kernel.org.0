Return-Path: <linux-tip-commits+bounces-3645-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6590A45C4E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D976A7A67BF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 10:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5D525EFA2;
	Wed, 26 Feb 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQEAK98a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FD425C6E9;
	Wed, 26 Feb 2025 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567359; cv=none; b=Mr+Rtdnt+5ulrJkxXBtiYYWhLxo3IvunFb4OzGxtOHUxrSxRW6YKDd+jZ8ctlWQJWYzoY3Ctggn2R8mjsNgi2QR6TmWvzPzibIvFR+pgnH3qFczgEe5EWEB5IdBe6FpOYi3zbXUpTGr4xAXoK2HX9Uhh/Zn4hp4xQEM+xhQ3YwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567359; c=relaxed/simple;
	bh=ZU+ZyR4aLY3x0j3q2rbfwoqtx+ltymMrrVIRBW7+YG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbR4br/v5gVH4+HGlgsDHVm7nXIQejL9gs9p/ghzRl2bIn2Awy7CGI/0uP9ZyLhnNarCQ4VCECWv8aczl95TQeGsEPYHwpyG4q5MjbND08Zwwzn/vYAomVcxaI+kxjJkL+EAdFa3vBeA32xL0iyktvnXX9euScsxeidDbDmxly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQEAK98a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A38C4CED6;
	Wed, 26 Feb 2025 10:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740567358;
	bh=ZU+ZyR4aLY3x0j3q2rbfwoqtx+ltymMrrVIRBW7+YG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQEAK98a9QsxVuUm4D+p3xKTQ8MVebjyVtb1s6tWkACMs3hlnKv6+T31miCwY1kIh
	 PiTr1b7Lp89NngG+P0fdlzGCOqhrhC42qtV9ht2jvSv+5HrlLNIxw3w8Hp8gSnZEZg
	 6DGna/DFkja7qjtlQMZ/HX/Lmo1fw2QrjCIU3IySKHQu8OA/XOu/X3M6QHeT5tjq7z
	 UDZLDkLgf01Gk6ww34mSoQfEE8Nz3MA5Cpfq9oWS/sI620jNtMi9BjuVoTr8PRN9NE
	 mp7g4AADraboKmZA5ICnooX09Dtv/aYuRc7WPHpp34SbtsH94KcmRzZbl5fmbeWJvE
	 4TEzhlXjD9qug==
Date: Wed, 26 Feb 2025 11:55:48 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>, x86@kernel.org
Subject: Re: [tip: x86/mm] x86/mm: Clear _PAGE_DIRTY when we clear _PAGE_RW
Message-ID: <Z77zNK7mRdjwILL7@gmail.com>
References: <174051422675.10177.13226545170101706336.tip-bot2@tip-bot2>
 <CAHk-=whfkWMkQOVMCxqcJ6+GWdSZTLcyDUmSRCVHV4BtbwDrHA@mail.gmail.com>
 <Z76APkysrjgHjgR2@casper.infradead.org>
 <CAHk-=wj+VBV5kBMfXYNOb+aLt3WJqMKFT0wU=KaV3R12NvN5TA@mail.gmail.com>
 <Z76R6ESSwiYipQVn@casper.infradead.org>
 <CAHk-=whS1uq_4hEgkZJogv_HMhe_PJ-RyMs6E303_Pa+W0zx0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whS1uq_4hEgkZJogv_HMhe_PJ-RyMs6E303_Pa+W0zx0A@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 25 Feb 2025 at 20:00, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > I think the entire point of this file is to manipulate kernel mappings.
> 
> Very likely. But just looking at the patch, it was very non-obvious.

Yeah, agreed - and I've extended the changelog the following way:

  Subject: [PATCH] x86/mm: Clear _PAGE_DIRTY for kernel mappings when we clear _PAGE_RW
  
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

Is this explanation better?

Thanks,

	Ingo

