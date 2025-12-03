Return-Path: <linux-tip-commits+bounces-7585-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB51CA0A03
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 18:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17C8130014CA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 17:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4236032D0E2;
	Wed,  3 Dec 2025 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeStIfcL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CD532ABC7;
	Wed,  3 Dec 2025 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784017; cv=none; b=FTexV6p2M2zF7bGmaXy8/k5xpmsTlwty2AcT3ZtMi5w96YunrjlV86pY9+7W12mG7H0wiZrsqazyF2S/3RzOsxkX899qbWXgJYtuvew0XH+gwLqdTYbcntAjRmKGvMbCDDTViWonGhnOnhlXD8rvsKy0DAiIRbFNvzFYfIg08+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784017; c=relaxed/simple;
	bh=WRY8YLizPAkapsHRRIwMqLYmGjGAe0KDqmYvPfU8gkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGHyMfAtfmwEKJAIdcc2LgVfymFxpPHv4XxniMF8+GE9qzliAfkXSTslsOP9OuAMu74vsZS6naiVdQvPFUQHEmax8Xt2MRUC30WTiUp0JoCoTIosgokrnyku185UiCFDA3CcTLEzwsswZU2g0xCeuZrBUj0LSkSVOCOASvRf2aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeStIfcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1089CC4CEF5;
	Wed,  3 Dec 2025 17:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764784015;
	bh=WRY8YLizPAkapsHRRIwMqLYmGjGAe0KDqmYvPfU8gkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aeStIfcLCNdLHFqMyOgeKtIh7IMKwlrjqZXVFlqjEO+so12me3TTu4yLaZdf2J8ZV
	 bKSigmXpn6g9dYcWuKKLt4b1Ni6aoad7YJcNZ9u5SZUZsLDEV60DLGS7aTpqi+kTmU
	 rN7rRuLiKFQXJs0MZbXY1U1V6TUZBOg0c4Owc13IMjxWsXZA7mkXwp1q0gOIIG+qb4
	 DX0UAdEQvmVKPrz2HWBAo+DElQC/ZnytgSfjQCJrBQ7FZqba7qeSqpoxpAR27bUoq/
	 F4nS6qsqHewbWmR3h8Tk4JjJB5pZroVnUFEWZWZBZqLFIfb5n0aCMQHhcpQtimcKmn
	 NQemMC2+2/saA==
Date: Wed, 3 Dec 2025 09:46:53 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool: Consolidate annotation macros
Message-ID: <72juhabxma7rw5eq2gglct4lmeoqfvrlv5jf36sdcfimz5rxxd@gnfuxdgv6stj>
References: <c05ff40d3383e85c3b59018ef0b3c7aaf993a60d.1764694625.git.jpoimboe@kernel.org>
 <176478003405.498.13298696533128884255.tip-bot2@tip-bot2>
 <CAHk-=wgzL-bCggZOuDU7_f-1jpjus8Oaqtek9T8GdGUexnHYkg@mail.gmail.com>
 <aTBr3ImmrJQe4G49@gmail.com>
 <CAHk-=wjc4BeSu7dHB=5AuQNWQ=sOGAuH4j0=uRwsGyiSo+m+bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjc4BeSu7dHB=5AuQNWQ=sOGAuH4j0=uRwsGyiSo+m+bw@mail.gmail.com>

On Wed, Dec 03, 2025 at 09:21:55AM -0800, Linus Torvalds wrote:
> On Wed, 3 Dec 2025 at 08:57, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Find below a diff of the arch/x86/kernel/process.s output
> > of your tree versus current tip:objtool/urgent.
> 
> Yeah, just a single example would have been sufficient, ie a simple
> 
>    Turn
> 
>         911:
>                .pushsection .discard.annotate_insn,"M", @progbits, 8
>                .long 911b - .
>                .long 1
>                .popsection
>                jmp __x86_return_thunk
> 
>   Into
> 
>         911: .pushsection ".discard.annotate_insn", "M", @progbits, 8;
> .long 911b - .; .long 1; .popsection
>         jmp __x86_return_thunk
> 
> and btw, the quotes around the section name are not necessary afaik.

Indeed, I can remove those quotes.

> Also, I have to say that being mergeable is a bit annoying here:
> without that, we could drop the "@progbits, 8" parts too which is just
> strange noise.  Is the mergeability really a win? Because I'd assume
> that it's never *actually* merged, since the expression "911b-." ends
> up being a unique value?
> 
> What am I missing? It *feels* like this should just all be
> 
>         911: .pushsection .discard.annotate_insn ; .long 911b - .;
> .long 1; .popsection
>         jmp __x86_return_thunk
> 
> instead. But it's entirely possible I'm not seeing the reason here...

So that mergeable thing is the only way to convince the toolchains to
allow setting the section entsize, which is a generic way for objtool to
look at the myriad of special sections and determine their entry sizes,
so it can extract individual entries for the purposes of creating
livepatch modules.

In this case I do realize the irony of objtool needing to know the
section size of a section which is explicitly created for objtool's use
(so of course it already knows the size).

In actuality they are two completely separate subcommands of objtool.
"Regular" objtool reads .discard.annotate_insn for its annotations,
whereas "objtool klp diff" extracts special section entries.  It does so
in a generic way (entsize), regardless of whether the special section is
objtool-specific or not (e.g., the bug table).

-- 
Josh

