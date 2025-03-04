Return-Path: <linux-tip-commits+bounces-3992-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50651A4EDF3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F488188E02D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C711225F78A;
	Tue,  4 Mar 2025 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTVypOhV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F896252915;
	Tue,  4 Mar 2025 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118187; cv=none; b=nqtL2SEdR0MI9/hn6NaQuyfuvDgh+tbWJ6iNeG/xUJH/kASQqsaMk/GP25p83zeGyj8L3h4C/6Eg/b/nWs7NIPqBTHwNVQJJwEKAyg3EsUaPAeMWdibIimxny/eqq92+fpn5fQLH/bYUeQvvAm3A6Y6gBeQYcRk5RjvMdgf0XzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118187; c=relaxed/simple;
	bh=I/Z/NqwW9Tm8BBSL1NLMaIkQepTGpxleKiOj1RmEuk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLY4asZc6u9KJr1Ib+L/5uNC4x5IBbicVQHYV0WLE2j7zL6iPXxpY5sSxUoJJdttfwRwr31qkGyOWeiw7uH2xD4YbSSklGUk0m67zifvxS6k2rouyqqwZL2epoH+N1HwRZ63gYRk9vF4egR69UWpqtmlpJNYDZZ9wYKslbqEr8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTVypOhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA95C4CEE5;
	Tue,  4 Mar 2025 19:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741118187;
	bh=I/Z/NqwW9Tm8BBSL1NLMaIkQepTGpxleKiOj1RmEuk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sTVypOhVGjvM43D/ALfau9C5zjbZ3/S7fsJXMVKj2GsLssh0iIfFEy0XDyDRe+uX7
	 zbfBdTlEed6R8C6ApwLSdOXNJwpH7JebjrT0YCSyeaBGSVBz79rKT98s976kCLF8mh
	 U4kLRLUobZ31HdqvZNCRt1md5UsujsJg4cwwWJcHyedYKHWSW3oUk03sd6yjaZ/xmN
	 tKaHE2m0WAQlnjT2WNIxa55Wk3N/A2ep9bwtJ1JUGnEU5Z3A5R4X5Sona467mfOveu
	 +mAmX0ckk1sgfl1OUnLnViP9YJECJU+CjiONdxnc5BSlUlhNf/OutqJsblQ3Cu+7/k
	 MEvOO7BrsT2Og==
Date: Tue, 4 Mar 2025 11:56:25 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <20250304195625.qcxvtv63fqqk6fx4@jpoimboe>
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com>
 <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
 <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
 <20250304182132.fcn62i4ry5ndli7l@jpoimboe>
 <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
 <CAHk-=whqPZjtH6VwLT3vL5-b3ONL2F83yEzxMMco+uFXe8CdKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whqPZjtH6VwLT3vL5-b3ONL2F83yEzxMMco+uFXe8CdKg@mail.gmail.com>

On Tue, Mar 04, 2025 at 08:57:13AM -1000, Linus Torvalds wrote:
> On Tue, 4 Mar 2025 at 08:48, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Random ugly code, untested, special versions for different config options.
> >
> > __builtin_frame_address() is much more complex than just the old "use
> > a register variable".
> 
> On the gcc bugzilla that hpa opened, I also note that Pinski said that
> the __builtin_frame_address() is likely to just work by accident.
> 
> Exactly like the %rsp case.

Right, so they're equally horrible in that sense.

> I'd be much more inclined to look for whether marking the asm
> 'volatile' would be a more reliable model. Or adding a memory clobber
> or similar.

Believe me, I've tried those and they don't work.

> Those kinds of solutions would also hopefully not need different
> sequences for different config options. Because
> __builtin_frame_address() really *is* fundamentally fragile, and the
> fact that frame pointers change behavior is a pretty big symptom of
> that fragility.

While that may be theoretically true, the reality is that it produces
better code for Clang.

If the main argument is that it needs more testing, then sure, let's go
test more compiler versions.

-- 
Josh

