Return-Path: <linux-tip-commits+bounces-4952-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562F7A873AC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 21:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDCF87A288C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 19:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001D639FCE;
	Sun, 13 Apr 2025 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shydVDea"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9BA1862A;
	Sun, 13 Apr 2025 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744573395; cv=none; b=kjzHsBqsg+mF2ceeKBtQG6xJND3XuZM4m4CyCVPlFTirAFHj4wVcBovOGhgtQRewOJlDoQxSbWSUWeVY5eAa63VtC75+Fp6AvnyFtIS3MOH+Ht0erwdXD1+vUxyjfFS/eFEKjdaWDdqlICCnz3f51oZ3ucquyFv30erv+mmtmAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744573395; c=relaxed/simple;
	bh=oEqBz1Ey1X/q0WGJonnMdNetp5YCj0ml3zi7CP04Qqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzjAYEjhqWQbz5HypcTwgbEZO1+NVEUrFAYSphCy8vQMAxhnXKtivVnrdo25Gy9ZFNRBJZwBSMRGe1+GbZ4GxO4vATkaD+0rhuX23eCHH366wqu3C2wePwGelB5gufR1VZ/XAInrZ/A5A/VHJBVtpWzfO4JWBmmSzhJ5g+C69/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shydVDea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CBEC4CEDD;
	Sun, 13 Apr 2025 19:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744573394;
	bh=oEqBz1Ey1X/q0WGJonnMdNetp5YCj0ml3zi7CP04Qqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=shydVDeaFK8H13Clx2kwH3TURm4XlXWO23IOtUF47I2rv8GNKRgDCTuCuXpnzmmsf
	 /yvlUdNmL5W90yTzkR5ARQNK6QOmY8CNGMVBhBkdNYL4rNHfJAdq4BfhGXhJ4MxXiJ
	 ZFwmbNtYi/tKif2KXhS+xmW3EqVibEL5tvtypO5Dn9tTqV1I/AMhyl9xr3MxMT+4Sx
	 G55Y85BWIWrIh3th2wScx4HMcsL6XlHVgT4va2XR5P3B4KKBDvcrhYW//ZAceEQ6ox
	 m27jgf55dV+x8Jk5kxZcquV/n7rNww6SjLNq9wbp3pueWDGvaBG5e+5aU/roTOJo+E
	 iRF/DedZDaXFQ==
Date: Sun, 13 Apr 2025 21:43:09 +0200
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
Message-ID: <Z_wTzWA7h5jdy47Y@gmail.com>
References: <174428272631.31282.1484467383146370221.tip-bot2@tip-bot2>
 <20250411210815.GAZ_mEv8riLWzvERYY@renoirsky.local>
 <Z_oqalk92C4G6Rqt@gmail.com>
 <CAFULd4bTd6GMftLBX7Nu0xftini00o4v7=1XfuoDC8ydUr9Ueg@mail.gmail.com>
 <Z_t7_brzSoboOsen@gmail.com>
 <CAFULd4ZBbAG4ndn+rzjjqF+pmtGa3UbyDOWfEXww0XhExJByVA@mail.gmail.com>
 <Z_wI0uNoG2G2TQMC@gmail.com>
 <CAFULd4b2afcu5PnxhqwwepwWMSA7mvYNyPnMtkCjjT84VG8VXA@mail.gmail.com>
 <Z_wOYOrVJJkUUUF9@gmail.com>
 <CAFULd4ZRTfZggPp395Y-ZJ6DkHFdorvjX-MiFHxR40UGU+3rSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4ZRTfZggPp395Y-ZJ6DkHFdorvjX-MiFHxR40UGU+3rSQ@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Sun, Apr 13, 2025 at 9:20 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > > > If this commit is removed, [...]
> > > >
> > > > I did not remove commit ac053946f5c4, it's already upstream. Nor
> > > > did I advocate for it to be reverted - I'd like it to be fixed. So
> > > > you are barking up the wrong tree.
> > >
> > > If the intention is to pass my proposed workaround via Andrew's tree,
> > > then I'm happy to bark up the wrong tree, but from the referred
> > > message trail, I didn't get the clear decision about the patch, and
> > > neither am sure which patch "brown paper bag bug" refers to.
> >
> > It's up to akpm (he merged your original patch that regressed), but I
> > think scripts/genksyms/ should be fixed instead of worked around -
> > which is why I zapped the workaround.
> 
> As said earlier, I have tried to fix genksyms, but the simple fix was 
> not enough. The correct fix would be somehow more involved, and I 
> have zero experience in genksyms source. I'm afraid I don't know this 
> source well enough to offer a fix in the foreseeable future, so I 
> resorted to the workaround (which at the end of the day is as 
> effective as the real fix).

I disagree that hacks/workarounds are as effective as the real fix.

In the Linux kernel the usual principle is that developers who 
introduce unanticipated in-tree regressions are expected to fix them 
for real and not just work them around. Not following that principle 
may have reputational costs going forward (or not), but it's your time 
and your call really.

Thanks,

	Ingo

