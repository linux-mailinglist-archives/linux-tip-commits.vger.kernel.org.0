Return-Path: <linux-tip-commits+bounces-5239-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E82DEAA9211
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 13:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0A51891EC7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 11:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1579813B2B8;
	Mon,  5 May 2025 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fsxm77yl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0D211C;
	Mon,  5 May 2025 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746444725; cv=none; b=uGys8pe2q4+XBpkNW05Q9J7yD9molBwOLycsZnTKjSq46cpnWfLlCI/Wn7Sk+DA9zYdHQyLCOkpGxxZ3wZh/NWsB0ILaZR++h/sdGoCYvpEnz8YcWvMXx8F6Pb+xCu1M687fkm0cCOy/GmMfDPS2Wq8SdXXrHaxE3RE2952AWtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746444725; c=relaxed/simple;
	bh=sSbIcbJAsWOp8UQ8YetgntsO4PWlZoiT+/z23PFgjSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHffrpxV9cYHCAxU+pCPi1b1XaC7Vp/Y6Ll8V75q09YmWHsW0lbGc/U4OcZgTikkQSoweoL6FuaQy7Jl8v8C9IskbM+qGH9szW5G8aLTJQtZ9+ID7jVBuM25pwEvvJhLo8okznuwL6pd09UzuPIzTcrHuv6LDLj7NhgsqmcZmp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fsxm77yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A687EC4CEE4;
	Mon,  5 May 2025 11:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746444724;
	bh=sSbIcbJAsWOp8UQ8YetgntsO4PWlZoiT+/z23PFgjSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fsxm77yl/0UYSuPasfDxI0DDQ+yQgUblo+5EapHuBNXJHYnucDYSJ/3hUfz81Bk/s
	 iMyH/ZJiwgV7ue7soUxQtthKJpmfahf2b7o6rYv3tmBmpij0fqaADOb4YGUYd5f0jM
	 hGvOJS28faIDNxA80AladUNM3gwLOdwkviZArL19O8EA3xXan0q2sWPKQp64cpCUzA
	 qB5QZw14PoAeLNN9gtXpKlZU10s8HWaF7eO1IB96/LXUuDwXaCzEaYn3fWSVX1SthS
	 MWNOFW9w/ihSvubKHq+knSw9OnT+7+2c4vSdcS3fvXTO4EhsQO2j4WNppI9VQNpqpN
	 TOz0WXvOm5E7A==
Date: Mon, 5 May 2025 13:31:59 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: hardened_usercopy 32-bit (was: Re: [tip: x86/merge] x86/fpu:
 Make task_struct::thread constant size)
Message-ID: <aBihr1qRFBm1xj3_@gmail.com>
References: <20250503120712.GJaBYG8A-D77MllFZ3@fat_crate.local>
 <202505041418.F47130C4C8@keescook>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505041418.F47130C4C8@keescook>


* Kees Cook <kees@kernel.org> wrote:

> But as reported above, there *is* a copy in copy_uabi_to_xstate(). (It
> seems there are several, actually.)
> 
> int copy_sigframe_from_user_to_xstate(struct task_struct *tsk,
>                                       const void __user *ubuf)
> {
>         return copy_uabi_to_xstate(x86_task_fpu(tsk)->fpstate, NULL, ubuf, &tsk->thread.pkru);
> }
> 
> This appears to be writing into x86_task_fpu(tsk)->fpstate. With or
> without CONFIG_X86_DEBUG_FPU, this resolves to:
> 
> 	((struct fpu *)((void *)(task) + sizeof(*(task))))
> 
> i.e. the memory "after task_struct" is cast to "struct fpu", and the
> uses the "fpstate" pointer. How that pointer gets set looks to be
> variable, but I think the one we care about here is:
> 
>         fpu->fpstate = &fpu->__fpstate;
> 
> And struct fpu::__fpstate says:
> 
>         struct fpstate                  __fpstate;
>         /*
>          * WARNING: '__fpstate' is dynamically-sized.  Do not put
>          * anything after it here.
>          */
> 
> So we're still dealing with a dynamically sized thing, even if it's not
> within the literal struct task_struct -- it's still in the kmem cache,
> though.

Indeed!

> So, this is still copying out of the kmem cache for task_struct, and the
> window seems unchanged (still fpu regs). This is what the window was
> before:
> 
> void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
> {
>         *offset = offsetof(struct thread_struct, fpu.__fpstate.regs);
>         *size = fpu_kernel_cfg.default_size;
> }
> 
> And the same commit I mentioned above removed it.
> 
> I think the misunderstanding is here:
> 
> >    The fpu_thread_struct_whitelist() quirk to hardened usercopy can be removed,
> >    now that the FPU structure is not embedded in the task struct anymore, which
> >    reduces text footprint a bit.
> 
> Yes, FPU is no longer in task_struct, but it IS in the kmem cache named
> "task_struct", since the fpstate is still being allocated there.

Thank you for this fantastic explanation and the bug fix!

Since IMHO it would be a shame to lose all these explanations, and 
because it's been exposed to -next for weeks without getting reported, 
I've applied your fix to tip:x86/fpu after changeloggifying it. I've 
also added your SOB, if that's fine with you. Let's not destroy genuine 
Git history, let's not lose credit and let's not lose all these details 
by squashing this fix into the buggy commit...

Thanks,

	Ingo

