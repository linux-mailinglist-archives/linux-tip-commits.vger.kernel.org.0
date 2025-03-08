Return-Path: <linux-tip-commits+bounces-4071-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D974A5774F
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 02:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBF41732FD
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 01:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5335674C14;
	Sat,  8 Mar 2025 01:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCbZjXjv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CDB60DCF;
	Sat,  8 Mar 2025 01:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741397897; cv=none; b=by2Ez6yb/z3yZBVR7FxJ8y8ADBMMyg3pAqKV492SUYqoDMUHTUHaSABgpIe7BDYSzWC2M63veWEo+BLNUPtU1UMtm+VQTIECmkbz9mJKJKCGRfokPrtiiB9F/qTvNckfKu0YeejX9D0KzcpCCDJHl6CbV1De/hpX5ADFLZacDE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741397897; c=relaxed/simple;
	bh=O0pfHBH6G6rQLqBAYK579O3diR42DxdkQNQ218db5KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewrEzjICOkuHd8OX4QkdxDTXJAcxFrO9iuf0ibxP2/kP6LAv1YMLdtFWH1rJLOgBsmUFXWoO7eX+51ngnCWEaMnrUBKmZnYdH0RfgE1krCWdbMZ+CXNocFsS3Zi0HetsJqf88JmVBQfchiBzxG7Of+zMo90ROIDnh+9jQw9rljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCbZjXjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5E9C4CED1;
	Sat,  8 Mar 2025 01:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741397896;
	bh=O0pfHBH6G6rQLqBAYK579O3diR42DxdkQNQ218db5KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCbZjXjvqzDIZg4nJx1cbFRvyRuP2/4rId5gTE1S5VCl4/xrAkqhbCWZIlPPKGUHi
	 qRXO/SBPkKk17OY41FZaDuhiEvgdHTHjfX9KZ0qPJfvhHX5I17lC6hIpWgZablY3n3
	 gpdJqT6kTVHjViKKcHN1Lwjf0EPkzEZPI/Q86iTedtnEaoVWmEzBVVnT6TRJGghlAK
	 wOM7CF0KoSlSnDHxdBt0q3OSB2tPCvfOKLvmRfO6+7accrkzoKKuyyWQNlUrGXXlXx
	 P//2TGOET/JQhxqvQ7GkW8o3I+ZeE2/IeZukZTyfcsuv1Bkw9YIjUlfydwRFMhKd8n
	 D8rtInttJSuEg==
Date: Fri, 7 Mar 2025 17:38:14 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
	linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>, x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <20250308013814.sa745d25m3ddlu2b@jpoimboe>
References: <174108458405.14745.4864877018394987266.tip-bot2@tip-bot2>
 <90B1074B-E7D4-4CE0-8A82-ADEB7BAED7AD@zytor.com>
 <Z8t7ubUE5P7woAr5@gmail.com>
 <20250307232157.comm4lycebr7zmre@jpoimboe>
 <A669251B-7414-4EE7-B0AD-735E845C0B5B@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A669251B-7414-4EE7-B0AD-735E845C0B5B@zytor.com>

On Fri, Mar 07, 2025 at 03:29:00PM -0800, H. Peter Anvin wrote:
> On March 7, 2025 3:21:57 PM PST, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >On Sat, Mar 08, 2025 at 12:05:29AM +0100, Ingo Molnar wrote:
> >> 
> >> * H. Peter Anvin <hpa@zytor.com> wrote:
> >> 
> >> > > #endif /* __ASSEMBLY__ */
> >> > 
> >> > So we are going to be using this version despite the gcc maintainers 
> >> > telling us it is not supported?
> >> 
> >> No, neither patches are in the x86 tree at the moment.
> >
> >FWIW, the existing ASM_CALL_CONSTRAINT is also not supported, so this
> >patch wouldn't have changed anything in that respect.
> >
> >Regardless I plan to post a new patch set soon with a bunch of cleanups.
> >
> >It will keep the existing ASM_CALL_CONSTRAINT in place for GCC, and will
> >use the new __builtin_frame_address(0) input constraint for Clang only.
> >
> >There will be a new asm_call() interface to hide the mess.
> >
> 
> Alternatively, you can co-opt the gcc BR I already filed on this and
> argue there that there are new reasons to support the alternate
> construct.

We hopefully won't need those hacks much longer anyway, as I'll have
another series to propose removing frame pointers for x86-64.

x86-32 can keep frame pointers, but doesn't need the constraints.  It's
not supported for livepatch so it doesn't need to be 100% reliable.
Worst case, an unwind skips a frame, but the call address still shows up
on stack trace dumps prepended with '?'.

I plan to do the asm_call() series before the FP removal series because
it's presumably less disruptive, and it has a bunch more orthogonal
cleanups.

-- 
Josh

