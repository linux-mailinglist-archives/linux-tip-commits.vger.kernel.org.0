Return-Path: <linux-tip-commits+bounces-5221-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB27CAA85B0
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 11:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3BB16736B
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 09:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728811D5CC6;
	Sun,  4 May 2025 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8oYcVlI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4581D516F;
	Sun,  4 May 2025 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352410; cv=none; b=Pzii+TAMjhojhJ9I1ijW2llx76M/iXMZt3qgiBoMNcDe0scw28+qliROD33gIBMngNIdbpJQjUK/Osm43g9UQeQQoL8HRn3P7dsXBN1vC/n24sk+noyqaN8ecwTbwIfyI8vmqE/LCQz7hoMe5rjfhuhRNOvdNkSXzMp+XpqZ3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352410; c=relaxed/simple;
	bh=eiuoW4WfYbB/NLMVhSl0ytucyk+1Q9O7CyBNqlpFpZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAJptmaePrsDvxgyZUl4HyuImyQhyZoPmG2ZMYnvzy+WPO+5ueAz5G1fleTrpjlL8FLYnsLVdj8RGOjZrbUySrN470y2C+Xh3ls6MRtZ9hM0y/SRA9/Qwy40qHeA8gYTkIOTjlAhtA6WiL47iMkihO1kWjWHL8sYnM7mZ1gMESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8oYcVlI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EACC4CEF2;
	Sun,  4 May 2025 09:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746352409;
	bh=eiuoW4WfYbB/NLMVhSl0ytucyk+1Q9O7CyBNqlpFpZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c8oYcVlI+leIUNnMqswnXdkX2I0SXzGzWTqVI6ro7suaX1MMgQQMEx0r5KRdsx4TC
	 3SrWEweUKdCkD8dAhOGGkWAKLUhoH9f0XYv4+HsOluPeYzDZHsGas/xOiOKxO4dyCM
	 kwN7VXhAHSILcvZWFrI94qzGPdl8czdZqItc2RC5Vpp9EJgpvftMT2X8IebSVDJSRs
	 efNYrNgDJYj2bSX8FWlw9700fo5yDOMx3e/QE/9/EVHjn3Es5oQPvrKck/75PNNVjs
	 BF8/l1BGuQMxJQSbmB01PeRWeyh//D/YRjs5l5GEShhaZBh88KX0/snn8WruQ55TZr
	 HdmwoLnmR83Hg==
Date: Sun, 4 May 2025 11:53:24 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: hardened_usercopy 32-bit (was: Re: [tip: x86/merge] x86/fpu:
 Make task_struct::thread constant size)
Message-ID: <aBc5FNmf-pl6iypR@gmail.com>
References: <20250503120712.GJaBYG8A-D77MllFZ3@fat_crate.local>
 <aBcM7UXj8HQWZeHJ@gmail.com>
 <aBco5IostuyCepaT@gmail.com>
 <20250504095041.GAaBc4cRpKHJvo5fRE@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504095041.GAaBc4cRpKHJvo5fRE@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Sun, May 04, 2025 at 10:44:20AM +0200, Ingo Molnar wrote:
> > > Thx for the report, mind sending the exact .config that fails for you?
> > 
> > BTW., mind sending the full bootlog as well? I cannot reproduce it here 
> > with CONFIG_HARDENED_USERCOPY=y, so I suspect it's something about the 
> > build, HW or boot environment.
> 
> Attaching boot.log and .config.
> 
> Toolchain is:
> 
> gcc (Debian 13.2.0-25) 13.2.0

Thanks!

	Ingo

