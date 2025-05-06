Return-Path: <linux-tip-commits+bounces-5264-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CC1AAC1CE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 12:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D8A189F694
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 10:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D62A20C028;
	Tue,  6 May 2025 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3lZI5+J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DEE224250;
	Tue,  6 May 2025 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529032; cv=none; b=b3UvZAAoK5W9bUrpLF0CYSP9+6p+WjOM0+9RLzcfWfqpYO3MQnP3XfG/LhopcDqgNbhBxrodobADIXpeoUrJs7vL6JuBm56az9BYS4VTKX95rO+h1OqaJ6A1woIDjfuCBhVMMUkjChmDi86qNMMWowNGANigL4L0g+cMAa7bYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529032; c=relaxed/simple;
	bh=UZP09VVhMdP7fJBircJxuTpzV5r6sQifpaEYZBjp6YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmKYciY4jQl2tiLXgJJZdrcPN6XSRZnJ4HkIU45OCoyYUTc4AZImm20gWtkSdakxMONNiZCDvFfolfKZjOPgQh6uPHDYTjPtTLuWHKuX85coORfmMCnHTRIbDf0HdPlKMuHwCW6yVm/gekGNQzijkQeM89gDP7MK6RRJlgZHY5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3lZI5+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614C3C4CEED;
	Tue,  6 May 2025 10:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746529031;
	bh=UZP09VVhMdP7fJBircJxuTpzV5r6sQifpaEYZBjp6YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3lZI5+J+1RF4GBzDEXOcuX6Dmw3rVOYJos8/ZZ2/n9n2V93u+m6WnW6WHb5o0M7W
	 SgFWKExxbKP7Slp1epR4vPLX1eqb1eS0ivWeGhQWOzbl/L5wae0dYgv+QXV0NjVtFa
	 G32Ge52xo7dzr4G6JnCZWVuaue328RI+zL0BXWFfRD0F1k1WR4HWUJYU4txnCixWnQ
	 7B/w29LooRlwwZw8KhLmeRbJ37JQSvWi60UM8OfgXmEDr6bHzMq2VHsB9Xmw0C/OOv
	 PPJlU00izOxp9OgB3iqKQvU4ECa0vXktshVgdiP7tx951sT2WGsHoiaWDOniGCKvR1
	 wHnpgz1XpMCyA==
Date: Tue, 6 May 2025 12:57:08 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	stable@kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/microcode: Add microcode_loader_disabled() storage
 class for the !CONFIG_MICROCODE case
Message-ID: <aBnrBHfj_TM8gyit@gmail.com>
References: <CANpbe9Wm3z8fy9HbgS8cuhoj0TREYEEkBipDuhgkWFvqX0UoVQ@mail.gmail.com>
 <174628529460.22196.11450380316905137027.tip-bot2@tip-bot2>
 <aBcFv6BzmRNWqLY8@gmail.com>
 <aBhJVJDTlw2Y8owu@gmail.com>
 <20250505074703.GAaBhs99-ndCbFO6xl@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505074703.GAaBhs99-ndCbFO6xl@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Mon, May 05, 2025 at 07:15:00AM +0200, Ingo Molnar wrote:
> > 
> > Fix this build bug:
> > 
> >   ./arch/x86/include/asm/microcode.h:27:13: warning: no previous prototype for ‘microcode_loader_disabled’ [-Wmissing-prototypes]
> > 
> > by adding the 'static' storage class to the !CONFIG_MICROCODE 
> > prototype.
> 
> Thanks, I'll merge it with my patch.

Please don't forcibly rebase trees like that, because you've just 
reintroduced a bug this way in tip:x86/urgent:

  # 5214a9f6c0f5 x86/microcode: Consolidate the loader enablement checking

  +static inline bool __init microcode_loader_disabled(void) { return false; }

static inlines don't need an __init tag ...

This was done correctly in the commit you removed:

  59e820c6de60 ("x86/microcode: Add microcode_loader_disabled() storage class for the !CONFIG_MICROCODE case")

  +static inline bool microcode_loader_disabled(void) { return false; }

> > Also, while at it, add all the other storage classes as well for this 
> > block of prototypes, 'extern' and 'static', respectively.
> 
> This I won't add as it is unnecessary.

Technically the 'int' in 'unsigned int' is 'unnecessary' and could be 
skipped as well with 'unsigned', right? Yet clean kernel code uses it 
because it's easier to read and more consistent. Likewise, the 'extern' 
storage class is a well-known and widespread way in the kernel to 
document public APIs, a counterpart to 'static'. Most of our major 
headers use that style.

Your change is a doubly poor choice in this particular case of 
<asm/microcode.h> as well, because the header continues with an 
'extern':

  extern unsigned long initrd_start_early;

So by dropping that cleanup you reintroduced an inconsistency as 
well...

Thanks,

	Ingo

