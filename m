Return-Path: <linux-tip-commits+bounces-4034-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6175FA558AE
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 22:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8497D3A6382
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 21:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37E0207DF3;
	Thu,  6 Mar 2025 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwn0bef7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B928E1A3176;
	Thu,  6 Mar 2025 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296134; cv=none; b=ER85SDVPtcKNq6dHaO5zHRxyLXX8OTyhX84qOBW/bVZ+ziZBuHwqzaCqBGaAaJ9SVWRaedqeX+3QFGrypvQ5+3eJstFNeVNr1yfU6UP87KGw+188jgVctUb6jVjuToJ3cJNz1PdX7nMpthPSI5UaBga6UFwYY95HB9wrdYeeRj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296134; c=relaxed/simple;
	bh=RJ7L2/PCOnNpUBmkwWMftwXfB0mjGlfWd+PF6zlAMkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeemr+JhJJ31Mp6gBx+ILcL5k33WG2jWccCZRgJidZDYCmmpjmZiMLjN3glddko5b301eGNV+d7H5Br3+pAGtTC9ftKoVfR1yIRTbDjb4JgHNVndi/ypiIDjM3dkktIBX3SMLM7nTGK6VhMsnXL29Qv0X+j4IQlV4FH+sq8VLD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwn0bef7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935FDC4CEE0;
	Thu,  6 Mar 2025 21:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741296134;
	bh=RJ7L2/PCOnNpUBmkwWMftwXfB0mjGlfWd+PF6zlAMkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwn0bef73GNPx8L+gZZiaT2/B3QVQ9uwWwTinqdvReKlNxgAvoNOUcLt4sZDnmvnY
	 TUoqzUoCvAzNPrUydPuDJ/5v4FvnJ9EMOXKd1JumVsuNFR6kqZ6yfv3j0JmIjiMqmr
	 n6OGX/ATcIBE5IOV3OyHPwslxDAR20y5NSjfbu7TIbY4a9lxdnQ4e0YNEFMNTRId/N
	 NqK8DACwLywDYuBKuh9zEdubIAVo20kZDk/uP10B2kvM2M6vLJ2qMR6GPkaTFbo+WP
	 wW+0GZNoQPOYx2WlVz86poGqMuRrzFbWEwBS1KfOj5w30V8X6XTtVO4LswlIa0HeWu
	 RG+Z8wS42ZglQ==
Date: Thu, 6 Mar 2025 22:22:09 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: x86/mm] x86/mm: Check if PTRS_PER_PMD is defined before use
Message-ID: <Z8oSAQiBvVJ_METQ@gmail.com>
References: <20250306092658.378837-1-andriy.shevchenko@linux.intel.com>
 <174125602814.14745.12946945836213678532.tip-bot2@tip-bot2>
 <CAHk-=whTGVy1aaEashu3K49wuG7-hARh02xbAr_hMm3844Ec7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whTGVy1aaEashu3K49wuG7-hARh02xbAr_hMm3844Ec7Q@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 6 Mar 2025 at 00:13, tip-bot2 for Andy Shevchenko
> <tip-bot2@linutronix.de> wrote:
> >
> > x86/mm: Check if PTRS_PER_PMD is defined before use
> 
> I'm not at all happy with this one.
> 
> > -#if PTRS_PER_PMD > 1
> > +#if defined(PTRS_PER_PMD) && (PTRS_PER_PMD > 1)
> 
> Honestly, I feel that if PTRS_PER_PMD isn't defined, we've missed some
> include, and now the code is making random decisions based on lack of
> information.

Yeah, so <asm/pgtable-2level_types.h> hasn't defined it historically, 
because 2-level paging only has PGDs and PTE tables - and it relies on 
<asm-generic/pgtable-nopmd.h> doing it:

 #define PTRS_PER_PMD    1

<asm/pgtable_types.h> includes <asm-generic/pgtable-nopmd.h>, and with 
it most of the MM headers.

But:

> It should be defined either by the architecture pgtable_types.h
> header, or if the PMD is folded away, the architecture should have
> included <asm-generic/pgtable-nopmd.h>.
> 
> So I'm *really* thinking this patch is completely bogus and is hiding
> a serious problem, and making PAGE_TABLE_SIZE() have random values.

Yeah, so the MM headers cover the C case - but the bugreport was about 
the assembly side (head_32.S):

  In file included from arch/x86/kernel/head_32.S:29:
  arch/x86/include/asm/pgtable_32.h:59:5: error: "PTRS_PER_PMD" is not defined, evaluates to 0 [-Werror=undef]
     59 | #if PTRS_PER_PMD > 1

and AFAICS the assembly version of these headers doesn't define 
PTRS_PER_PMD.

Separating out the assembler-compatible defines from the types headers 
appears to be a bigger patch, since it's all mixed in with C syntax:

<=-----------------------------------===============================
typedef struct { pud_t pud; } pmd_t;

#define PMD_SHIFT       PUD_SHIFT
#define PTRS_PER_PMD    1
#define PMD_SIZE        (1UL << PMD_SHIFT)
#define PMD_MASK        (~(PMD_SIZE-1))

/*
 * The "pud_xxx()" functions here are trivial for a folded two-level
 * setup: the pmd is never bad, and a pmd always exists (as it's folded
 * into the pud entry)
 */
static inline int pud_none(pud_t pud)           { return 0; }
static inline int pud_bad(pud_t pud)            { return 0; }
static inline int pud_present(pud_t pud)        { return 1; }
================================================================>

In any case I've removed the commit for the time being until this all 
is cleared up.

Thanks,

	Ingo

