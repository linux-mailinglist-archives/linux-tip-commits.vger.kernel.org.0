Return-Path: <linux-tip-commits+bounces-3836-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0DFA4CE7B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 23:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFDD3A5671
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 22:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633AB239561;
	Mon,  3 Mar 2025 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohr9tIpW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC59239068;
	Mon,  3 Mar 2025 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041435; cv=none; b=HxojshOTc9V1ik1bHZ4AeH70LGB4w8k6//eVWn8AY9soU8y+t8gm8cN2TYWFC8pou237PYglFvGBp8IbGw4npSL+psXsNnBE+hrbwNo1cDTFNpiLtV+fnu8e5z9c0zMuGDRaEPn01ya7U9+7WVILPurD6Q4k0/jVy7VBCn8OUq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041435; c=relaxed/simple;
	bh=jBGCgCTIh94cQxq7MrDORBhD2ez9Ci8x7u/4/UL66og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGb7qO2y0BVPCQ3Ib7LbrH4JmNojIkyNK7pNXsulYv2+L1qM0JG2hFZeoCNFmr22sRymmRRrJumcrZ5M8GLE+BaysLIESKLijljbYCHzNbNuVOTkpYdGXKw/5UnB7CurYDtqutTV0PE3Z8LPZLuIBG5JKou533/zLAZQL/bqHsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohr9tIpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBE5C4CED6;
	Mon,  3 Mar 2025 22:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741041435;
	bh=jBGCgCTIh94cQxq7MrDORBhD2ez9Ci8x7u/4/UL66og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ohr9tIpWhmji5apc2/UIlYMwRXdsV1zzNdeI6TpxogTieVML8yyOkGLZdpzZc6ilD
	 iyOxFCDbRgSbi3pmHSzDPJXbRAC6hf1x88314iYRoREx6CKiAYvj6V5a1uGP2zM2Ju
	 swuUuU2IueRiaeoViSwtI9zNS3BFBaWelN0g0/9k1FjoeU6laK7EhlX++xvOkzuIbj
	 Qo9wO8Xtb57kaCTVaxdtw4n1DvocNVl9u8Kyvb6ToIq8m44DrKdMb8ppxfGLaYQWIb
	 ziJEO04/gc8Xkff6+R85CVHv4YT8CN5n6sWswvJY936uqqCtWQlCVqaz2P7qPrOjIY
	 6kwRn/8KQYtog==
Date: Mon, 3 Mar 2025 14:37:13 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <20250303223713.jkatipgfmlik3b2t@jpoimboe>
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>

On Mon, Mar 03, 2025 at 08:28:10AM -1000, Linus Torvalds wrote:
> On Mon, 3 Mar 2025 at 01:02, tip-bot2 for Josh Poimboeuf
> <tip-bot2@linutronix.de> wrote:
> >
> > x86/asm: Make ASM_CALL_CONSTRAINT conditional on frame pointers
> >
> > With frame pointers enabled, ASM_CALL_CONSTRAINT is used in an inline
> > asm statement with a call instruction to force the compiler to set up
> > the frame pointer before doing the call.
> >
> > Without frame pointers, no such constraint is needed.  Make it
> > conditional on frame pointers.
> 
> Can we please explain *why* this is done?
> 
> It may not be required, but it makes the source code uglier and adds a
> conditional. What's the advantage of adding this extra logic?
> 
> I'm sure there is some reason for this change, but that reason should
> be explained.
> 
> Because "we don't need it" cuts both ways. Maybe we don't need the
> ASM_CALL_CONSTRAINT, but it also didn't use to hurt us.
> 
> The problems seems entirely caused by the change to use a strictly
> inferior version of ASM_CALL_CONSTRAINT.
> 
> Is there really no better option? Because the new ASM_CALL_CONSTRAINT
> seems actively horrendous.

The original ASM_CALL_CONSTRAINT was already pretty horrendous, can you
clarify why you think the new one is even worse?

On thing that's nicer, now that it's an input constraint, it can be
appended to other constraints without affecting the constraint ordering.

As far as making it conditional, the code generation seems better.
Before, it was forcing some functions to set up the frame pointer even
with ORC.

Also it nicely confines the hack to a little CONFIG_FRAME_POINTER
corner.  Frame pointers are very much deprecated on x86-64 anyway, maybe
we can just eventually get rid of that option.

-- 
Josh

