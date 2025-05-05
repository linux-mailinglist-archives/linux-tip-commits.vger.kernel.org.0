Return-Path: <linux-tip-commits+bounces-5251-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F284FAA9DD9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 23:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E393AB061
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 21:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2942B262FD3;
	Mon,  5 May 2025 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8wyIb9j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECDB204840;
	Mon,  5 May 2025 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746479366; cv=none; b=T8EjTFqrNCIDd2MOkDYn/wMrZBX4GTXZs3f7TQM9IoQbXlEEn0fbE/zrTgZAWUgOnixWd7cRAHDK46b4z8IBM/bcumanxVnuLP1d24iUpLiz40qZcC7O4C0RoMBShCd4AlSqLdXq1X30DOkXKPURqDwVoHKKirHIgWweNCa9mjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746479366; c=relaxed/simple;
	bh=KV7fCtsVdiotwii6ldKNDZX/3Xgo8iGcftnuvms2J2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZq/RVpmrFDggm0RGe2iCMuHzoTj7majkazJVWIHsYhVb8cmTx5MGd5QVhZWyz+5Iprn93tYEl3I+Jat4lsp+gqj8JFaesWfQHDmSasJL3nDM7rqdxujaeFPgkZuG5sspKzR3+odnq99Pq8iCOA9F8zVkSqQoDaALDTuu0KJw/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8wyIb9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F1AC4CEE4;
	Mon,  5 May 2025 21:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746479365;
	bh=KV7fCtsVdiotwii6ldKNDZX/3Xgo8iGcftnuvms2J2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8wyIb9jdd0hoqMgI1FEsIWrhzJauWDjedt8eLP9JQk3x9ogATs6BH5PYCL0ALjjy
	 Jfe6IFLrH/ysp5JmEx48t91Ah0dd0ktEDNV1Kyz6BRvIAskm44Dxf6OGIF/SpLJDAW
	 EpH4IUzWhN2REicwH0WPD7tUsQ5VCT51LWE/7z+uxQ5mIY2WwMLuMykbFyBzQWBybl
	 m/p3r1wXdBYPMIEcG53ew+vihSqXluvsBK3DTpq8DB9baCXGFpV+ptIzXGszKiICEt
	 4XCb9J/MmWQj5MVrWbK3ciyJ3ZvJVZrqhOuB2KBmk81nZtGbyUrdCK1elvpZOad3av
	 aAAtBZ+QUrk0Q==
Date: Mon, 5 May 2025 14:09:21 -0700
From: Kees Cook <kees@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
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
Message-ID: <202505051408.7CABD131@keescook>
References: <20250503120712.GJaBYG8A-D77MllFZ3@fat_crate.local>
 <202505041418.F47130C4C8@keescook>
 <aBihr1qRFBm1xj3_@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBihr1qRFBm1xj3_@gmail.com>

On Mon, May 05, 2025 at 01:31:59PM +0200, Ingo Molnar wrote:
> 
> * Kees Cook <kees@kernel.org> wrote:
> 
> > But as reported above, there *is* a copy in copy_uabi_to_xstate(). (It
> > seems there are several, actually.)
> > 
> > int copy_sigframe_from_user_to_xstate(struct task_struct *tsk,
> >                                       const void __user *ubuf)
> > {
> >         return copy_uabi_to_xstate(x86_task_fpu(tsk)->fpstate, NULL, ubuf, &tsk->thread.pkru);
> > }
> > 
> > This appears to be writing into x86_task_fpu(tsk)->fpstate. With or
> > without CONFIG_X86_DEBUG_FPU, this resolves to:
> > 
> > 	((struct fpu *)((void *)(task) + sizeof(*(task))))
> > 
> > i.e. the memory "after task_struct" is cast to "struct fpu", and the
> > uses the "fpstate" pointer. How that pointer gets set looks to be
> > variable, but I think the one we care about here is:
> > 
> >         fpu->fpstate = &fpu->__fpstate;
> > 
> > And struct fpu::__fpstate says:
> > 
> >         struct fpstate                  __fpstate;
> >         /*
> >          * WARNING: '__fpstate' is dynamically-sized.  Do not put
> >          * anything after it here.
> >          */
> > 
> > So we're still dealing with a dynamically sized thing, even if it's not
> > within the literal struct task_struct -- it's still in the kmem cache,
> > though.
> 
> Indeed!
> 
> > So, this is still copying out of the kmem cache for task_struct, and the
> > window seems unchanged (still fpu regs). This is what the window was
> > before:
> > 
> > void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
> > {
> >         *offset = offsetof(struct thread_struct, fpu.__fpstate.regs);
> >         *size = fpu_kernel_cfg.default_size;
> > }
> > 
> > And the same commit I mentioned above removed it.
> > 
> > I think the misunderstanding is here:
> > 
> > >    The fpu_thread_struct_whitelist() quirk to hardened usercopy can be removed,
> > >    now that the FPU structure is not embedded in the task struct anymore, which
> > >    reduces text footprint a bit.
> > 
> > Yes, FPU is no longer in task_struct, but it IS in the kmem cache named
> > "task_struct", since the fpstate is still being allocated there.
> 
> Thank you for this fantastic explanation and the bug fix!
> 
> Since IMHO it would be a shame to lose all these explanations, and 
> because it's been exposed to -next for weeks without getting reported, 
> I've applied your fix to tip:x86/fpu after changeloggifying it. I've 
> also added your SOB, if that's fine with you. Let's not destroy genuine 
> Git history, let's not lose credit and let's not lose all these details 
> by squashing this fix into the buggy commit...

Okay, sounds good. :) Yeah, please consider it:

Signed-off-by: Kees Cook <kees@kernel.org>

Thanks!

-- 
Kees Cook

