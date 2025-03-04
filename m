Return-Path: <linux-tip-commits+bounces-3959-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EC5A4ED3B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A813AF3AB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A9A259C88;
	Tue,  4 Mar 2025 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd9JANeJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07837255251;
	Tue,  4 Mar 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115706; cv=none; b=EdfhHjsgD9qox0lmV7yFxww6/YOfsBbHfZikf0oEfO11rULxWDAXyJlQWLA7rG6hPabr0Tg3kgdgXQE6mdPazDfZpJQ9a62UKYsGTqMEMqtVnni8PbXLkS7IN1b9l+1VZ76VJaFSEE910jSm31rIH4YJ8uav/DFbB71pSIFVYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115706; c=relaxed/simple;
	bh=JJAJkxUJ1Ssn3V4i6mnrB10sKcPRACeB/DFOKNhD4xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyJsb9mVOFPSeYH92xmuAozREWP4dirgBrq+Wl0Klk/jYq/RS72zeXn4Pt29N2Emr2U+sk171pdO5XNehNpBHnTNuszfV8x09gAYCziW4nYi18vLiU543VQnYkSE/hsTx4XZAFX3dOVx22Mfifm5vWX2JdGKnXD7fpESuMsPTo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wd9JANeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B85C4CEE5;
	Tue,  4 Mar 2025 19:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741115705;
	bh=JJAJkxUJ1Ssn3V4i6mnrB10sKcPRACeB/DFOKNhD4xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wd9JANeJfOHYEK6EVPAw2D9d0oO9xu0TCn07i8JUGEwPwIzMrEo5kUUUM0JRxSgCe
	 Ya3UwIMByvZ6Uh+tYsP68ftGLlEZ5Sb2oUUlEb2wleHZY8s8Pi7V+xko8gXaIKzaHz
	 clG23v9FmTavanU2W+8MXoBWlc5e9ueafFP+tdJGVKSy+9lrjvfuaOAaalcU5GXcVD
	 7Hu53N+0GntPjjXh8ZtcVDqw6t5o60eAhQii5IMPK0chk/6rFPiJH05vFD5SPwMIbf
	 7al0iIOlOcya//ouNSpRt/9UXCO9EbsX118KNqgGFOyrqNAMIwu/5JCnXAgRtIZaxs
	 DxmBf9AudKkRA==
Date: Tue, 4 Mar 2025 20:15:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <Z8dRNO1-_1YmIpAv@gmail.com>
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com>
 <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
 <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
 <20250304182132.fcn62i4ry5ndli7l@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304182132.fcn62i4ry5ndli7l@jpoimboe>


* Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Tue, Mar 04, 2025 at 08:01:58AM -1000, Linus Torvalds wrote:
> > On Tue, 4 Mar 2025 at 07:51, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > Put another way: the old code has years of testing and is
> > > significantly simpler. The new code is new and untested and more
> > > complicated and has already caused known new problems, never mind any
> > > unknown ones.
> > >
> > > It really doesn't sound like a good trade-off to me.
> 
> I'm utterly confused, what are these new problems you're referring to?
> 
> And how specifically is this more fragile?
> 
> AFAICT, there was one known bug before the patches.  Now there are zero
> known bugs.
> 
> Of course, it's entirely possible the build bots will shake out new
> objtool warnings over the next weeks.  But as of now, I haven't seen
> anything.

In any case I've zapped these two commits from tip:x86/asm for the time 
being:

  x86/asm: Fix ASM_CALL_CONSTRAINT for Clang 19 + KCOV + KMSAN
  x86/asm: Make ASM_CALL_CONSTRAINT conditional on frame pointers

Until there's consensus.

I left the 3 preparatory patches, which make sense as standalone 
cleanups:

  KVM: VMX: Use named operands in inline asm
  x86/hyperv: Use named operands in inline asm
  x86/alternatives: Simplify alternative_call() interface

Thanks,

	Ingo

