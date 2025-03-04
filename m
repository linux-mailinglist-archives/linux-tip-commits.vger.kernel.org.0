Return-Path: <linux-tip-commits+bounces-3953-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2CBA4ED18
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580468C3181
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 18:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BB9209692;
	Tue,  4 Mar 2025 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyDJn9iT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50EC207A1D;
	Tue,  4 Mar 2025 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112494; cv=none; b=id8mSzQhEJ525oEr6t3pUDN+WfeuOMCEYON25gnX8dzICr0Ywd+WKIFTqrrygRkYwCAVjnhNsFd/hm0OppfnS1LHHE94CxM39CJd6ZD37S8euJ6nQ/wPqX9sq7kksfgRmII8JxVnOuKYd/tIhx+G+SlQs0uL3upO9IdFN8rmJVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112494; c=relaxed/simple;
	bh=za0SuWLRhElff/bceu6BDxVrKjWckpBw7aqLeA2sbyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzSGhK9y6yJ68tYTqcTvG74b8k5Ql9rbhbBsNb9h7ZQ2uKw23e200FvjjqG3uycdYGOhN06pNMc6CpQxm7AoE9InugGI4u+OkyeeOKtHr4LpvWdgjPDo387kjYYMZDLTB8Zf5lvUiai1IwedLSgttAZ6JHFYTTqdYbrww8fKQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyDJn9iT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10F2C4CEE5;
	Tue,  4 Mar 2025 18:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741112494;
	bh=za0SuWLRhElff/bceu6BDxVrKjWckpBw7aqLeA2sbyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LyDJn9iT5NK0ljlzd/CxYT+DQB6iW+kCeUfbS1tZN32EQUS8F6Icaw+hC1AqB29xV
	 eN3mnDCjUwCz0KaGojeFIFtV81L1tXiTf5fGwtnEdIUQ56xC4X7qGOgvlKpVloKtm0
	 cvBna7i/C5rDTgAXaskW6U03kJbuZUmx51eECwQzdwMFUdgof6f8YvKeKh8vY46OIq
	 o5AmhhqGOAAIc+5rEUpYsW0zqrq0eWPMPCfuKnpqN+Dghyi5ebjJbjjJUd5QK6VnoW
	 Kmakiko0MUzcBfmOPR1EzVR41A+rhgb3/dARydErKZi7kBxWl9NUWhJk3I8ZZwTmm/
	 zQ0pD1xqJGHuQ==
Date: Tue, 4 Mar 2025 10:21:32 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <20250304182132.fcn62i4ry5ndli7l@jpoimboe>
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com>
 <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
 <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>

On Tue, Mar 04, 2025 at 08:01:58AM -1000, Linus Torvalds wrote:
> On Tue, 4 Mar 2025 at 07:51, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Put another way: the old code has years of testing and is
> > significantly simpler. The new code is new and untested and more
> > complicated and has already caused known new problems, never mind any
> > unknown ones.
> >
> > It really doesn't sound like a good trade-off to me.

I'm utterly confused, what are these new problems you're referring to?

And how specifically is this more fragile?

AFAICT, there was one known bug before the patches.  Now there are zero
known bugs.

Of course, it's entirely possible the build bots will shake out new
objtool warnings over the next weeks.  But as of now, I haven't seen
anything.

> Side note: it's not clear that we should need to do that
> ASM_CALL_CONSTRAINT thing _at_all_ any more.
> 
> Iirc, the only reason we did it was for old versions of gcc, and we're
> already in the process of switching minimum gcc versions up to past
> where the whole thing is relevant at all. There's another tip bot
> commit that makes the minimum gcc version be 8.1 due to the (much
> MUCH) cleaner percpu section series.
> 
> And afaik, that makes all of this completely pointless.

I'm excited to hear we can get rid of a lot of old GCC cruft, but this
has nothing to do with the compiler version.

It's needed for CONFIG_UNWINDER_FRAME_POINTER, for all compiler
versions.  Otherwise the callee may skip the frame pointer setup before
doing the call.

> So tell me again - why are we making the kernel code worse?

Again I don't see how this is worse, please spell it out for me...

-- 
Josh

