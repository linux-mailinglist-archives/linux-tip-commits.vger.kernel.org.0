Return-Path: <linux-tip-commits+bounces-7602-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C72BFCA157C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 20:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F6FE302533E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344E2330B28;
	Wed,  3 Dec 2025 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFYKq2wL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082DA398FAF;
	Wed,  3 Dec 2025 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764787691; cv=none; b=f2YKh4ItS1vX9i1Y2w90j/91VG95P5iieLhdmq1jY0XniNWl5BKboesu+jKlYtXwnLhHKfmxSuGNoBnnRBRHwVv8GgOcN+i1108KNmHnGto8rbt8R0m6sOlIct7RNafuaY2souO1tglZZSy8Wil4v8E+q/TCsro0C5hbeIPPwy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764787691; c=relaxed/simple;
	bh=mw8PtT80YXECqxQTDm1Nvm8X1WOAIP0CqkCgrllE8b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJGPvbZbKm0VqFwFc+vELRtlCgCXzv88O3C12HPj73Zg1lpwYTo4YR2+dBGHGl3vuqos4xXcKBtLoR/9rQ0m3t838gF6EMG35vnsrEKnTojyq1D8PtsIuLzxGMBXoNknWRyTTgT2mUmVkTs6v72TR9o8wEo7b93qjz6YeSfqIO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFYKq2wL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A9CC4CEF5;
	Wed,  3 Dec 2025 18:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764787690;
	bh=mw8PtT80YXECqxQTDm1Nvm8X1WOAIP0CqkCgrllE8b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vFYKq2wLRkIdpGSDsUOWzEQB37tpNnxV27U+vqQX1acD9ewsqvExmoVzU9xc+PU8d
	 VdNIWTsCDq+dqRSuOe0rruYu6dJUTzSHogPwmssdL+gc/KXUxj8wagn318z5pd5qg0
	 IAKwixePPMg7ArsyLXtls1e883H2FT53jeJCP8pj6X6TY8SLhpbDF/+8kjF8ccM96u
	 E/WiKrj9Xy+rvmN2se8SM4fTbjL3X3DfOuVE7Pn2tzoTrkqxVlVCSBxpUAdW+Wh4mG
	 wmdgnKPTFrl2cqo89PMMZ/AUMmn3wnRerW+Y0g9wjHS2r4Am6Kc7g81hh2Ux7AECAB
	 RPoMErcFtcHNw==
Date: Wed, 3 Dec 2025 19:48:06 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool: Consolidate annotation macros
Message-ID: <aTCF5rABohJTVCVl@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjc4BeSu7dHB=5AuQNWQ=sOGAuH4j0=uRwsGyiSo+m+bw@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

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

I ended up rebasing the commit after all and added your example,
because seeing it written out triggered further enhancements:

> and btw, the quotes around the section name are not necessary afaik.
>
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

Thanks,

	Ingo

