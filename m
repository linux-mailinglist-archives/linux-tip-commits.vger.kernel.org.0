Return-Path: <linux-tip-commits+bounces-5209-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EE0AA845C
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 08:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125983BC890
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 06:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46EF17FAC2;
	Sun,  4 May 2025 06:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkGswWua"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ED21422AB;
	Sun,  4 May 2025 06:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746341106; cv=none; b=tHZsdAgW8sFkKt0Yj4KBDAMgHhnEP6WtY2w5Zznr3mYgfohidWA4ihNIJJ+19E9GngKE6QHmKVVcKD4QlfbjooTJ/Lg1JHtRAs7l9t4bAF+prBSSyyR0tu6Le42tJyud3VSo2N8V4CF9tjjraqmnD5KslfDf8ea9q6emlT1vKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746341106; c=relaxed/simple;
	bh=1oBKbQwBJWj3OeVDQwCXVDnc2NtLeTDeugomRQzFhLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0cp20pkKziKaWNVYqH+wGK7ewOwC8gPvL+iaKxFTb1t4AUMOP8i2DH0yESomsMCCEHFBYRD06n/pvHu9h6a55Ijp+op+fRf3xz/n4kanckr0t+OWS3bozJw5WFamgkzr5QnAykOScvI04ABem427bJyUPnwLiEVuo1mlZO/NqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkGswWua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73254C4CEE7;
	Sun,  4 May 2025 06:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746341105;
	bh=1oBKbQwBJWj3OeVDQwCXVDnc2NtLeTDeugomRQzFhLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rkGswWuasDnF0aLN26zHWKoVIh4hvaia8M660xt84WFMgU9ZuZ5wPCCEENzGzDOjX
	 EaICxmx9mHyOQPlTnaX4COJNZ8vnmLqewhdC/rgcFBX5BvXeAM5EdinhwSN8iobjIu
	 lIzqORhYDT0aNiNjGF1cR7umPfDA2toUdM1hBZKIE7hkjIsSQJuNxoBL8/3dy++mIn
	 +gDaEfz7fsi4vgnjI4Wh6Pxe7Mbr1JIUFCxEYLsNV2Ydpy6ktQC9YFM5hK7ZGU36rq
	 31Nz87uoEBh9A8SRJRmQ0pEAdHip4DDbRIZ99KoS32XOtxX6+NGYsRQ3ffk9WYIM/W
	 Kfz0oO7qNvsRQ==
Date: Sun, 4 May 2025 08:45:01 +0200
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
Message-ID: <aBcM7UXj8HQWZeHJ@gmail.com>
References: <20250503120712.GJaBYG8A-D77MllFZ3@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503120712.GJaBYG8A-D77MllFZ3@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Apr 14, 2025 at 07:34:48AM -0000, tip-bot2 for Ingo Molnar wrote:
>
> > The fpu_thread_struct_whitelist() quirk to hardened usercopy can be 
> > removed, now that the FPU structure is not embedded in the task 
> > struct anymore, which reduces text footprint a bit.
> 
> Well, hardened usercopy still doesn't like it on 32-bit, see splat below:
> 
> I did some debugging printks and here's what I see:
> 
> That's the loop in copy_uabi_to_xstate(), copying the first FPU state
> - XFEATURE_FP - to the kernel buffer:
> 
> [    1.752756] copy_uabi_to_xstate: i: 0 dst: 0xcab11f40, offset: 0, size: 160, kbuf: 0x00000000, ubuf: 0xbfcbca80
> [    1.754600] copy_from_buffer: dst: 0xcab11f40, src: 0xbfcbca80, size: 160
> 
> hardened wants to check it:
> 
> [    1.755823] __check_heap_object: ptr: 0xcab11f40, slap_address: 0xcab10000, size: 2944
> [    1.757102] __check_heap_object: offset: 2112
> 
> and figures out it is in some weird offset 2112 from *task_struct* even
> though:
> 
> [    1.750149] copy_uabi_to_xstate: sizeof(task_struct): 1984
> 
> btw, the buffer is big enough too:
> 
> [    1.749077] copy_uabi_to_xstate: sizeof(&fpstate->regs.xsave): 576
> 
> but then it decides to BUG because an overwrite attempt is being done on
> task_struct which is bollocks now as struct fpu is not part of it anymore.
> 
> And this is where I'm all out of ideas so lemme CC folks.

Thx for the report, mind sending the exact .config that fails for you?

Thanks,

	Ingo

