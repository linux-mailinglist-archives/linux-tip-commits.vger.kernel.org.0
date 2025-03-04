Return-Path: <linux-tip-commits+bounces-3993-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2810AA4EDFE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 21:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E227A38FA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8D92063D9;
	Tue,  4 Mar 2025 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqfE7wwQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046A82376E6;
	Tue,  4 Mar 2025 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118418; cv=none; b=VWPt6+W/eUPEucRgMbH3oO/wrkq3LFoOCaFigtksySHw1dLZ2KVKtOAsRRStv9ZooMN9QqBBnzCRuh1xWUzPg79/HeFXNkcRZDtOvFh24xes1winI5lBOYGpU6z9XJnzXq6xDft8XT+M4vmYoqcaFP8iio2E3Sw+aJ96rvHj4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118418; c=relaxed/simple;
	bh=u7V1rTxxn6eYq6XJwjhAT6QHLM3MwNQOrFeNzgvTqK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKCwA/kBNkJEvgFO4m1OElMlaa+jD+ILsoTxm4PwjnGnU03nxG/J/f7WaRH0hryDHuhJeg0hzfPmNBDULt11vVyfHhCrNFLyJHJXKD74hj5BfYyIO//N1IGHBodlKj0zJLnaHZn+YRyjFUxmIKZFgX5MTR935luQ66Y09wAPlBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqfE7wwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CA9C4CEE5;
	Tue,  4 Mar 2025 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741118417;
	bh=u7V1rTxxn6eYq6XJwjhAT6QHLM3MwNQOrFeNzgvTqK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqfE7wwQgRMhbWlflsNnqB2b8YdCZYEIJhYLWerktYl+7CQYStF2WddrKX1lg+WKm
	 bqTb7KwEtU8qOGutt2EFVOmMuhMTQZOxpUpLTcN22swUv+j2wnrc+FHgTsaj29FJxh
	 sUiCwNsAHpouIoR6vkRFwhagb9L9XpbGMZabsv7HNtodEfdTswrDqsCyW3mHn5SZhT
	 if0i3Io/dS77PIBkcV0kgRbmpZJzMW1RpEx2CwdVIvWolyxz3v4MliiK53ml8JMAGD
	 oRt9jxYmtmUTlUQHrr74afMp6QgWX8IlZoAHRNwBXr5qk02THdqYXTB4YxhSdGuyww
	 Tjz2R3wipAMYg==
Date: Tue, 4 Mar 2025 12:00:16 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <20250304200016.rj7wjwhdehbtlr4g@jpoimboe>
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com>
 <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
 <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
 <20250304182132.fcn62i4ry5ndli7l@jpoimboe>
 <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
 <20250304194749.zw6jdfmrctfgxfxk@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304194749.zw6jdfmrctfgxfxk@jpoimboe>

On Tue, Mar 04, 2025 at 11:47:52AM -0800, Josh Poimboeuf wrote:
> On Tue, Mar 04, 2025 at 08:48:29AM -1000, Linus Torvalds wrote:
> > In your own words from 8 years go in commit f5caf621ee35 ("x86/asm:
> > Fix inline asm call constraints for Clang"), just having the register
> > variable makes the problem go away:
> > 
> >     With GCC 7.2, however, GCC's behavior has changed.  It now changes its
> >     behavior based on the conversion of the register variable to a global.
> >     That somehow convinces it to *always* set up the frame pointer before
> >     inserting *any* inline asm.  (Therefore, listing the variable as an
> >     output constraint is a no-op and is no longer necessary.)
> > 
> > and the whole ASM_CALL_CONSTRAINT thing is just unnecessary.
> 
> I don't know if that GCC 7.2 thing from eight years ago was a fluke or
> what, but without ASM_CALL_CONSTRAINT, those "call without frame pointer
> save/setup" warnings are still very much active with recent compilers.
> 
> Below is what I get with empty ASM_CALL_CONSTRAINT + GCC 14 + defconfig
> + CONFIG_UNWINDER_FRAME_POINTER.

And to clarify, yes, those still have the global register variable
defined.

-- 
Josh

