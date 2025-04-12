Return-Path: <linux-tip-commits+bounces-4898-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1906DA86BE1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 10:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D5E1B81281
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 08:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B63149C6F;
	Sat, 12 Apr 2025 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LywybWXZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC20DDAB;
	Sat, 12 Apr 2025 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744448111; cv=none; b=L9LdSz/zfaUnhk/M/peOnXzDEJdHpaau+kEpma49rVlDmDfY9+SlHc658zoIjeIvnzraAvhNleoLlUolNYct2GtQ18GN9kDcshsC+t2Fy3BvN8Avrspr88oEDYEU0VY/vOX0X35RVOesu4x/wwXKKx3rNoXqUF76GCCZEOeI8uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744448111; c=relaxed/simple;
	bh=x+okFSocuEcsftPwwGN0qvjDwDxvA6N9/ElnIA7nEP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNg2aF6IqOOS+cwofOXKvY6r3E/gUXxqoqGUg3pgVUqmcnig2XBVMaDek8vc8NRUsaMt5Fy6lm3KG84JPjHQBGhLE3e7DKbC40yQh20KbrjmJhyq3ASRaSXGUMpFQ2IFOk9WB3fSkEPAc7RA55rtIFkLBkpZDDvHu12Snktez4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LywybWXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1555EC4CEE3;
	Sat, 12 Apr 2025 08:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744448110;
	bh=x+okFSocuEcsftPwwGN0qvjDwDxvA6N9/ElnIA7nEP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LywybWXZLylHKzUqYF01W3h8N5jmcf6IdGDfzOf1tQ28wxGOVI9DLyjf59ZAuLwaN
	 j7EEqzSUeULWfKhC667GxHSZuETgo2NPOl0I//dXnapixqDJzvLpmLGnoARXUI0dQZ
	 2Yeok9lu8NzbXZJDkRSQRwaB8aM+2ikdsLAoopYulWMT4tLaOSQW7kZIU6K+1M1LG2
	 PtMrCbzzaZJGpnbAAKDxOHCIf1Od2kHRwEeoMuNRxEz5VIh5iGBW3l2a8KWoG+1JQd
	 AvDOLTEVsOCasb9iLYsVfRszeVtd+YowiFHy1x+kMGpk5Kvt9SjfR6h6tN4kBeIT/Q
	 olGoktz/ZlBfA==
Date: Sat, 12 Apr 2025 10:55:06 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org
Subject: Re: [tip: core/urgent] compiler.h: Avoid the usage of
 __typeof_unqual__() when __GENKSYMS__ is defined
Message-ID: <Z_oqalk92C4G6Rqt@gmail.com>
References: <20250404102535.705090-1-ubizjak@gmail.com>
 <174428272631.31282.1484467383146370221.tip-bot2@tip-bot2>
 <20250411210815.GAZ_mEv8riLWzvERYY@renoirsky.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411210815.GAZ_mEv8riLWzvERYY@renoirsky.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Thu, Apr 10, 2025 at 10:58:46AM -0000, tip-bot2 for Uros Bizjak wrote:
> > The following commit has been merged into the core/urgent branch of tip:
> > 
> > Commit-ID:     e696e5a114b59035f5a889d5484fedec4f40c1f3
> > Gitweb:        https://git.kernel.org/tip/e696e5a114b59035f5a889d5484fedec4f40c1f3
> > Author:        Uros Bizjak <ubizjak@gmail.com>
> > AuthorDate:    Fri, 04 Apr 2025 12:24:37 +02:00
> > Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> > CommitterDate: Thu, 10 Apr 2025 12:44:27 +02:00
> > 
> > compiler.h: Avoid the usage of __typeof_unqual__() when __GENKSYMS__ is defined
> > 
> > Current version of genksyms doesn't know anything about __typeof_unqual__()
> > operator.  Avoid the usage of __typeof_unqual__() with genksyms to prevent
> > errors when symbols are versioned.
> > 
> > There were no problems with gendwarfksyms.
> > 
> > Fixes: ac053946f5c40 ("compiler.h: introduce TYPEOF_UNQUAL() macro")
> > Closes: https://lore.kernel.org/lkml/81a25a60-de78-43fb-b56a-131151e1c035@molgen.mpg.de/
> > Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Link: https://lore.kernel.org/r/20250404102535.705090-1-ubizjak@gmail.com
> > ---
> >  include/linux/compiler.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 27725f1..98057f9 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -229,10 +229,10 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >  /*
> >   * Use __typeof_unqual__() when available.
> >   *
> > - * XXX: Remove test for __CHECKER__ once
> > - * sparse learns about __typeof_unqual__().
> > + * XXX: Remove test for __GENKSYMS__ once "genksyms" handles
> > + * __typeof_unqual__(), and test for __CHECKER__ once "sparse" handles it.
> >   */
> > -#if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
> > +#if CC_HAS_TYPEOF_UNQUAL && !defined(__GENKSYMS__) && !defined(__CHECKER__)
> >  # define USE_TYPEOF_UNQUAL 1
> >  #endif
> 
> So mingo is right - this is not really a fix but a brown-paper bag of
> sorts.

Yeah, agreed, I've removed this workaround from tip:core/urgent for the 
time being - it's not like genksyms is some magic external entity we 
have to work around, it's an in-kernel tool that can be fixed/enhanced 
in scripts/genksyms/.

Maybe akpm can merge this or some other fix and sort it out? AFAICS the 
bug came in via the -mm tree in January, via:

  ac053946f5c4 ("compiler.h: introduce TYPEOF_UNQUAL() macro")

Thanks,

	Ingo

