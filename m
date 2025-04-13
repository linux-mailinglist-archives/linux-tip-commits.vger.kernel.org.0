Return-Path: <linux-tip-commits+bounces-4920-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F182A8711D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 10:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA6EB7A0840
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 08:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EF3185B48;
	Sun, 13 Apr 2025 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYT6jFR+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD091F95C;
	Sun, 13 Apr 2025 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744534530; cv=none; b=jfFsEnzKuuM1yehVK9GAimNbaahWwkvoNi9L2jLwIX9Ua+/6zzS3YvwT7QtB5a/cCE991nNmtZxEtJ2s95VoHEHZ8kwS40vJ6liMWl/K5w2IPu0PwUXII6F3GQb7WphngXcEKiWi3I24fJ9XXQyu/Q0AtOlslAmfDalnj46oziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744534530; c=relaxed/simple;
	bh=1TqjYUc3KglV6+3Br7EdMouyO18ud70iYMOgRZYKvTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fl4ThapMcThv5HmtBSaSpLYiPeF0fEl2ua+aB2OlJYkU6LNBj4Iw4PXOYBuoq3oQDPj4LqWiFkh6vf20KELWhX2laH3slqonX+Q/VB3NbViqo+jfnu1Ct4XWUb51Ln0Q/gCcGhVGJSr/4ag3XtgMZDgLGGkGx/CASb8dMzExcYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYT6jFR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6B2C4CEDD;
	Sun, 13 Apr 2025 08:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744534530;
	bh=1TqjYUc3KglV6+3Br7EdMouyO18ud70iYMOgRZYKvTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYT6jFR+RLTv8FZgWeJx+hG0pNm+NxVio9dYDl7Ws6zso7+9NBq7Pgz8aMc52x++D
	 AK74u756QRmyIdSqarBeQqspRbLe4Ss8OUzodPEKE9xBuXZcDstMJqpdHKWjm53qKP
	 3q4FceDWKb1zsZO7XKDDW7ETjJlz6iNII0qcBrVMV/2W0gZCUMR7MO1Q37w+c24F2n
	 liRf6qfwuJycWOMgjj8Re4/sg8A7eMPYMGNqGgDRXYwpxDYHpg2awEBSatDtsWT1H1
	 DeM3IjZuHBPV60o7qLPcGEeWtmUehdDaJkf5uIqAvnMAHCNqaJyJjSa61fpqH58Oh4
	 hESCt2h7M0H/Q==
Date: Sun, 13 Apr 2025 10:55:25 +0200
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
Message-ID: <Z_t7_brzSoboOsen@gmail.com>
References: <20250404102535.705090-1-ubizjak@gmail.com>
 <174428272631.31282.1484467383146370221.tip-bot2@tip-bot2>
 <20250411210815.GAZ_mEv8riLWzvERYY@renoirsky.local>
 <Z_oqalk92C4G6Rqt@gmail.com>
 <CAFULd4bTd6GMftLBX7Nu0xftini00o4v7=1XfuoDC8ydUr9Ueg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4bTd6GMftLBX7Nu0xftini00o4v7=1XfuoDC8ydUr9Ueg@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> > Yeah, agreed, I've removed this workaround from tip:core/urgent for 
> > the time being - it's not like genksyms is some magic external 
> > entity we have to work around, it's an in-kernel tool that can be 
> > fixed/enhanced in scripts/genksyms/.
> 
> Please note that you will disable a check that is finally able to 
> fail the build for a whole class of very subtle percpu bugs.

I simply zapped a commit that was applied two days ago and asked akpm 
to resolve a regression that was introduced upstream via his tree 
through this commit, in this merge window:

  ac053946f5c4 ("compiler.h: introduce TYPEOF_UNQUAL() macro")

What 'disabled checks' are you talking about?

Thanks,

	Ingo

