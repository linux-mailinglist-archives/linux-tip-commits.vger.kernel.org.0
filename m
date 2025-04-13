Return-Path: <linux-tip-commits+bounces-4937-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4722A8734F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 20:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1A53B41B0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3491F76A8;
	Sun, 13 Apr 2025 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+JFfH7p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDBA1F6679;
	Sun, 13 Apr 2025 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570584; cv=none; b=XSe0fFcygjDKgDSgZOMZhNgiEaeMef5nhiDGDJxvUVFNzyAPX0Lmxjt4V4A7cu8lLvcaP2cTo4AD6rYK1sh0weTs0hVwJ/VLY67bUnPj8PHIXvYx5MD0LFGfVwx7jzeXATOcenJ5yyzKVy6LEGNozqLPMExL7WPsl5StCxxxgHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570584; c=relaxed/simple;
	bh=luQyl5FilkI3A48oEXgAnyvdYK+q0Wm0s+KqaLEjp10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CORhxc2QE5ruTUbGeYrBoZqC4sbwiDsWNwg4n624zqemQsMa9wt/v4wL6cwVeWWcz+Dbv/xvCl5C4ctt8fZVmhQDVUjyTG+btMo/yijun2P+jDg8z+e6c7HJSSoq+7ohgdeNdCcMSX2IdPeHqzeqGrDUKrL5/q4WWh20QA9iFpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+JFfH7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1723DC4CEEF;
	Sun, 13 Apr 2025 18:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744570583;
	bh=luQyl5FilkI3A48oEXgAnyvdYK+q0Wm0s+KqaLEjp10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+JFfH7pWvcz3/RZPR8BZ9szCPesHZevLi6fwIknAl2LaH3K/ggnPaGxxoe+OIKhX
	 o/gNODwgo/FUY4oBX0jm2cwBpa/lInRVYl+ZOP2DCMPF3Rx59CBSsiGr/qBVA/RvC3
	 6a8xP8BWR4txRxirFlbXAg/nVHDC6G8PMk7JFE/Re5gPxUXuEr64aDOuO6z9yPloew
	 4DOhTQIPHMVygG6xRH9z3CtLZR2PFi9hPo8N/B6plLTKQFj6NTe3tkrAw4pMHrueeq
	 HX6ux/ybDW2zOEHZiOZpwMRWV+g8Suvs/l4xngAUKmcEGDhD+TfS7OZzch0zpl/ObB
	 JhC2tR0i394sA==
Date: Sun, 13 Apr 2025 20:56:18 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>, x86@kernel.org
Subject: Re: [tip: core/urgent] compiler.h: Avoid the usage of
 __typeof_unqual__() when __GENKSYMS__ is defined
Message-ID: <Z_wI0uNoG2G2TQMC@gmail.com>
References: <20250404102535.705090-1-ubizjak@gmail.com>
 <174428272631.31282.1484467383146370221.tip-bot2@tip-bot2>
 <20250411210815.GAZ_mEv8riLWzvERYY@renoirsky.local>
 <Z_oqalk92C4G6Rqt@gmail.com>
 <CAFULd4bTd6GMftLBX7Nu0xftini00o4v7=1XfuoDC8ydUr9Ueg@mail.gmail.com>
 <Z_t7_brzSoboOsen@gmail.com>
 <CAFULd4ZBbAG4ndn+rzjjqF+pmtGa3UbyDOWfEXww0XhExJByVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4ZBbAG4ndn+rzjjqF+pmtGa3UbyDOWfEXww0XhExJByVA@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Sun, Apr 13, 2025 at 10:55 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > > Yeah, agreed, I've removed this workaround from tip:core/urgent for
> > > > the time being - it's not like genksyms is some magic external
> > > > entity we have to work around, it's an in-kernel tool that can be
> > > > fixed/enhanced in scripts/genksyms/.
> > >
> > > Please note that you will disable a check that is finally able to
> > > fail the build for a whole class of very subtle percpu bugs.
> >
> > I simply zapped a commit that was applied two days ago and asked akpm
> > to resolve a regression that was introduced upstream via his tree
> > through this commit, in this merge window:
> >
> >   ac053946f5c4 ("compiler.h: introduce TYPEOF_UNQUAL() macro")
> >
> > What 'disabled checks' are you talking about?
> 
> Percpu checks require TYPEOF_UNQUAL() macro, so removing
> USE_TYPEOF_UNQUAL definition

I did nothing to remove the USE_TYPEOF_UNQUAL definition, did I?

> [...] will skip the definition of __percpu_qual in 
> arch/x86/include/asm/percpu.h (please see 
> 6a367577153acd9b432a5340fb10891eeb7e10f1), and consequently __percpu 
> macro won't be defined with __seg_gs (please see 
> 6cea5ae714ba47ea4807d15903baca9857a450e6).
> 
> If this commit is removed, [...]

I did not remove commit ac053946f5c4, it's already upstream. Nor did I 
advocate for it to be reverted - I'd like it to be fixed. So you are 
barking up the wrong tree.

Thanks,

	Ingo

