Return-Path: <linux-tip-commits+bounces-4092-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD75A57C35
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 18:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934C11894086
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7E614D2BB;
	Sat,  8 Mar 2025 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMHomYj9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E33961FF2;
	Sat,  8 Mar 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741453574; cv=none; b=QVs1Tnkb4IN81aWr+L6tF3G+XNT5QVMbK/APxwCG7+H6TspbY7WVBQIBWoZOFCsppmoM4YzmT/Om9/8INXLC7dlT1i8iGU73Rnm1Z4vPqUG5Rf1QjlEbyd7z6gxX1MBbvriDsfEuTVHhaI272cIKESljwzlcSrewzUBReVcbe8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741453574; c=relaxed/simple;
	bh=6S/5uBVZCMtGp4vXQgSPKhfqMz5sJD/S0kF5/+dM5H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+ucmsTQj4mCqF8uwzeqvGdybDTu97t8Ib3arv6eDR40B73/32GsoMcPdBUi1Q4giylTteeF8Py5K/hmjBGg7XZDd13BplqKjOdaVeRLESh+5wGPy6HphAeTEQ0/6uIQvLZ/fZLkGnFyGGwu8CFvkJLBO5IjoEbBQGUglO735lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMHomYj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC970C4CEE0;
	Sat,  8 Mar 2025 17:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741453573;
	bh=6S/5uBVZCMtGp4vXQgSPKhfqMz5sJD/S0kF5/+dM5H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMHomYj9uz80vvROkeWKMENJe6tBo4waZ28+6f9BlqsjzamAVD1nGtKGRV5aLYIUE
	 fJji7yGbiN14FBo6XDeFypJZCUTbYkfpvJPfQZsKfYieBeA2pjC9cxUGFOmstJNaSe
	 JwK/9PerwG03d/mgfeXK1XiP4LJRJJnvP4pUk2/Ydy8U7rYjw+rMP/JJ5xJA9FIZpz
	 fTqdfsQH5V8Eg8riHfIbXTdTbeDP9Ic0e4Jt5d6hEW14ugsVPs6Kfc3jBwZ4Gnr6cl
	 H27BBgXtdk2arz+GFJP0GwBaGFq2sUH22AyvUCmordUKirfFVdHx8wUBCX0idPDIWb
	 NaPJK0CJEvOPw==
Date: Sat, 8 Mar 2025 09:06:11 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org,
	tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
	linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>, x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <20250308170611.4hlwdz5dndd4bnms@jpoimboe>
References: <174108458405.14745.4864877018394987266.tip-bot2@tip-bot2>
 <90B1074B-E7D4-4CE0-8A82-ADEB7BAED7AD@zytor.com>
 <Z8t7ubUE5P7woAr5@gmail.com>
 <20250307232157.comm4lycebr7zmre@jpoimboe>
 <A669251B-7414-4EE7-B0AD-735E845C0B5B@zytor.com>
 <20250308013814.sa745d25m3ddlu2b@jpoimboe>
 <20250308081530.7c7e4f94@pumpkin>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250308081530.7c7e4f94@pumpkin>

On Sat, Mar 08, 2025 at 08:15:30AM +0000, David Laight wrote:
> On Fri, 7 Mar 2025 17:38:14 -0800
> Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> 
> ...
> > We hopefully won't need those hacks much longer anyway, as I'll have
> > another series to propose removing frame pointers for x86-64.
> > 
> > x86-32 can keep frame pointers, but doesn't need the constraints.  It's
> > not supported for livepatch so it doesn't need to be 100% reliable.
> > Worst case, an unwind skips a frame, but the call address still shows up
> > on stack trace dumps prepended with '?'.
> 
> Doesn't 'user copy hardening' also do stack following?
> That needs to find all the stack frames (that have locals) and I think
> is is more reliable with frame pointers.

Yeah, that's arch_within_stack_frames(), which is frame pointer only.

ORC would actually be more reliable than frame pointers, but IIRC,
hardened usercopy didn't get an ORC implementation due to performance
concerns about doing an ORC unwind for every usercopy to/from the stack.

So yeah, hardened usercopy is one minor benefit of frame pointers vs ORC.

-- 
Josh

