Return-Path: <linux-tip-commits+bounces-3999-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC85CA4F0AB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 23:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8BCA17229D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 22:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE141FCFE4;
	Tue,  4 Mar 2025 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1s5nOeG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62341DDC14;
	Tue,  4 Mar 2025 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128313; cv=none; b=HY5cuGFNT0Z+wiOPfmT82bJBXjRPYv76AODaqIL4MavsDtppj4PtNAA/gSDI2N40Vvf/9eFvNNRUt1OmEBsaVX2nbAGDA3Lp/L0VnhPnMp2fKBjw1SzcxikJ4a/mZGbvgEfyhuLXmbVsGVjHNN5lwHNIY3ZUnSEDhwM9paStbF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128313; c=relaxed/simple;
	bh=enFWvQ+kvr5BsMD/Wa2qawYcXGNamAoRIk7ZQBVfbnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUWKr7eG6GqsK0GkvVimISCziiSMFBk80d2vV9eMhh2V3tIMEuZqf3K+wheWooR6gH8KAbidrUvBTwSmkpzvPqQFonFL9T2DO1I7lTE0iFbK8KL6jAG0YKD+DYnoQrmWC1fFNN8P343JXrz2xOJmDmDuaMEbDxQbd0aa4Zo0c0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1s5nOeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1FBC4CEE5;
	Tue,  4 Mar 2025 22:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741128313;
	bh=enFWvQ+kvr5BsMD/Wa2qawYcXGNamAoRIk7ZQBVfbnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1s5nOeGUibvIujG40ALt8Gq+0LoRLx2YnQPo64epQqT0RHLGZcR+0TN9FoamtQVS
	 zRni8FethWGJfAC1XbMaIovPBS5qfOHfAoskILG3JcCc2PcFStWYSyu9iDXTRUih6R
	 tpg1jugxkDiWfqNAhLVjRvPmpqmliyyODetOTsbx/1FzDKkWz37nHZxb/ytobcQU8C
	 zBDcQfIKxtUXUkDmHRKaFupGbVDf6cnYmRktSvr78VAmMbdkhkDGYGij0TJ1vtJ6D4
	 FkLYh6KCF6dcEytXH/OA4y3h+s5YiNzLk1TWg9Y80/TREE5duLz/oWD4cICrDOvC85
	 qlPO+ZU9u5mtA==
Date: Tue, 4 Mar 2025 14:45:11 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <20250304224511.cnnxyof2eeuvolcv@jpoimboe>
References: <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com>
 <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
 <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
 <20250304182132.fcn62i4ry5ndli7l@jpoimboe>
 <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
 <CAHk-=whqPZjtH6VwLT3vL5-b3ONL2F83yEzxMMco+uFXe8CdKg@mail.gmail.com>
 <20250304195625.qcxvtv63fqqk6fx4@jpoimboe>
 <CAHk-=wizdAA_d1yHZQGHoJs2fqywPiT=NJT2wNA0xybV+GVefw@mail.gmail.com>
 <CAHk-=wiwhHKvxZoaCPs2Zs4gaMAfCyZ=arBvXdP_kvNKOH5sKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiwhHKvxZoaCPs2Zs4gaMAfCyZ=arBvXdP_kvNKOH5sKA@mail.gmail.com>

On Tue, Mar 04, 2025 at 10:41:08AM -1000, Linus Torvalds wrote:
> On Tue, 4 Mar 2025 at 10:13, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Does clang even need it?
> 
> Bah. Yes it does. I may not have clang sources to try to look at, but
> I can do a test-build.
> 
> Anyway, I do think it would be better to make this compiler-specific,
> and keep gcc using the old tested case that works well regardless of
> whether frame pointers are enabled or not, since it doesn't _care_.

Problem is, the old ASM_CALL_CONSTRAINT is an output constraint, but the
new one with __builtin_frame_address() is an *input* constraint.  How
would you combine those into a single macro?

> And I think there's a better way to deal with the whole "generate
> better code when not needed" too, if clang really has to have that
> disgusting __builtin_frame_pointer() thing that then has problems when
> frame pointers aren't enabled.

But as I've mentioned, even the old ASM_CALL_CONSTRAINT macro affects
code generation for the non-FP case.  For both compilers.  Not sure why.

We don't want to punish the default ORC config -- (hopefully) used in
the vast majority of configs at this point -- for frame pointer sins.

> IOW, you could do something pointless like
> 
>    extern int unused_variable;
>   #define ASM_CALL_CONSTRAINT "+m" (unused_variable)
> 
> which generates a dependency that doesn't matter, and then doesn't
> then require preprocessor hacks for when it is empty.

... assuming that DTRT and doesn't trigger any side effects, for all
compiler versions, now and forever?


BTW, I'm not opposed to just forgetting all this mess and stripping out
frame pointers altogether.  They have no benefit compared to ORC.  And
objtool is pretty much mandatory at this point.

Then we'd no longer have to worry about which awful hack does the least
amount of harm for each compiler and all its supported versions.

And for the eventual red zone enablement, we can enter the light of
supported behavior with that "redzone" clobber, and use objtool to
make sure that gets used.

-- 
Josh

