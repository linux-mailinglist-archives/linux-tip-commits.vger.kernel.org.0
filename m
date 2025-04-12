Return-Path: <linux-tip-commits+bounces-4897-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F23A86BDE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 10:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E763BCAC1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF8C18DF89;
	Sat, 12 Apr 2025 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i14Kc2mJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326DFDDAB;
	Sat, 12 Apr 2025 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744447715; cv=none; b=exft89HUeL25hKpIrJS3odPkoMCCKUoxt5n4ctjmNIRgE50i94pZYYel3UKDHvEN4RndyZEy2SjNe5a8dhPhYM4SE7dNty4RfjfftriNP23SoG2mo85d68oyb0pgtEXabvvYFGhPlnGEGYeYihGhKUq5KngQGn0JL9mg7ks3I6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744447715; c=relaxed/simple;
	bh=P8agLbyOVO9R4ksorEp2VdapP/p5K5Aa1B1D+nHspq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2ZyGpgMUB1ure2cRLzYJrrBC+mC+YWtZ7zai6bJCLgQXOIH5PV8qKaGh2xOUFSERAQlGjW+wDY6jeD9UAFa/Vv1KIP1BzpmLiZlQM9PlRiopnyCWG9UbfmmqRaT88gNiChlYHyu9hVNzW4Z2keKtXgO7YOBK3fh5362URthBXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i14Kc2mJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80081C4CEE3;
	Sat, 12 Apr 2025 08:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744447714;
	bh=P8agLbyOVO9R4ksorEp2VdapP/p5K5Aa1B1D+nHspq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i14Kc2mJg0baH2J7LARXNVJZNAJuBVYHVCst3UVhE/LHyHgst65AAsRppVMlrqdRk
	 0tmdrPFP/2ed+pi9rawaoesrAcslG4FjJXPNoyjYEojiZ/tiDKsZ3/UreEcwfjTsQJ
	 zW/s8IZzcjVihgWcnODU10EeLnopUR61uXSfaPMMj3iP1zoMhuUurawS06m/lqwGIf
	 Um+oB9q2Sz7SvDRKL8oag6leDg4HT6mSJoQcCyf8a+AF5ZE86wsQ0ydcZe+tkROGz6
	 f3T/yf0eo++zzcrANhJEtKz5Ol9qvQ/dq4PQ1+OBO7j7JgEHYQm5NoHNR7+OcI0Z2Q
	 G9r3k5PXAJ3Yg==
Date: Sat, 12 Apr 2025 10:48:29 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Ian Campbell <ijc@hellion.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: x86/build] x86/boot: Drop CRC-32 checksum and the build
 tool that generates it
Message-ID: <Z_oo3eBywzj6s8Eg@gmail.com>
References: <20250307164801.885261-2-ardb+git@google.com>
 <174138907883.14745.965399833848496586.tip-bot2@tip-bot2>
 <364ad671-5e5c-47c1-af22-34a7c481f8e3@intel.com>
 <2fddc2e9-8c97-48de-bcc3-29645d58f0f1@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fddc2e9-8c97-48de-bcc3-29645d58f0f1@intel.com>


* Dave Hansen <dave.hansen@intel.com> wrote:

> On 4/11/25 12:33, Dave Hansen wrote:
> ...
> > The only weird thing I'm doing is booting the kernel with qemu's -kernel
> > argument.
> 
> I lied. I'm doing other weird things. I have a local script named
> "truncate" that's not the same thing as /usr/bin/truncate. Guess what
> this patch started doing:
> 
> >  quiet_cmd_image = BUILD   $@
> > -silent_redirect_image = >/dev/null
> > -cmd_image = $(obj)/tools/build $(obj)/setup.bin $(obj)/vmlinux.bin \
> > -			       $(obj)/zoffset.h $@ $($(quiet)redirect_image)
> > +      cmd_image = cp $< $@; truncate -s %4K $@; cat $(obj)/vmlinux.bin >>$@
> 
> 				 ^ right there

Oh that sucks ...

> I'm an idiot. That was a poorly named script and it cost me a kernel
> bisect and poking at the patch for an hour. <sigh>
> 
> Sorry for the noise.

I feel your pain, I too once overlaid a well-known utility with my own 
script in ~/bin/. After that incident I started adding the .sh postfix 
to my own scripts, that way there's a much lower chance of namespace 
collisions.

Thanks,

	Ingo

