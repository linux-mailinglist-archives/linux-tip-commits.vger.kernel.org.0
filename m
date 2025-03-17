Return-Path: <linux-tip-commits+bounces-4284-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2BAA64B0D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEC33B6D04
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008A4237706;
	Mon, 17 Mar 2025 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SFg43GFk"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821A223C375;
	Mon, 17 Mar 2025 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208400; cv=none; b=HPPaMIF/Hw59PD6cEZuh/jW2VkcAi84ZWw8ZDLMUdJFcImYIF3oOTP6FspEIkAlHOdCWlytK2kJz2Gc9MmCDFXv6Khifg1wRc7XZTuzjXvrXRapBxO+FK/mvIFHDEjjzmbCy/bz1wnsPLz7WTzyYTYApmnKNWBwFkSYJFEXX5EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208400; c=relaxed/simple;
	bh=g5iwVEWzCZsV0Wyd42Lx2PWjQTkIRH6PRJ+J5li/LQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SENSvXwlKqqc7Xumm9N9LkdaK49Xx8faSnibbkLb0koxlEqrTGf0+94MijxqDQouGA9iydVJwJhPa2LYmsVORfoWEQFbm4EJ3FY6LvG39oYB8IIH5v3RQk9I7nwl5lfSrwp+XTTZovkpQz7Ms9tLpOz/HhEpIyjnHfTAJz1QULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SFg43GFk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2E09640E020E;
	Mon, 17 Mar 2025 10:46:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EBqrj1jMLVYU; Mon, 17 Mar 2025 10:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742208392; bh=fglALhqrEpwfCpWltLAGAzAVtU0ESkSJ2dtUnmcMarI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFg43GFk9OlLkQTLm3N6GHMEjUcL/rb3uGtoMQ8ncj5uW7FjBpISNfFpVC9X3g/WU
	 BzLe+oqqX2Ea8oHEtgcfSiYN+ie8GpC59NG6mLWnTloCTqQiZIbhUGH1QWyjmX+ypl
	 Mw/Bth15tALlI13dM8qy9Ea3d8Ny8mB4M6wuA+4Ue/eqGzldOxHTicmmXM/ZJ/RgZ4
	 9QKWkmj+A87M80m/yM0AjdQPgSQsZte+iY+rw6p2RKnAMnJy9Cx25/L19vyVk4P4Wu
	 +j+wrsu7rVZ0eOzeBAeriiVgZG14F+9QVEtNnUR2WzXEhxrw5mqe5VZPThyb9EnYlB
	 r3VrKmTfnRyTtBzluSTwENJUwm9pDKvx7gWZyTKgVJUixijngrTtFAWZEogykR8kLU
	 ms65LcYD8AkSk3KvwNgiYyOL5kDb6Qr27nLqrAt/wB3iVbLJRsFOXeM3yQfdAqjQ4F
	 hYA8Kug8YFLXklkiYxkvTJA0kPKfTind350+4yg63ykOGX3TWAy9IgPdH4/9k2SpR2
	 530oZR+LDMcVmYXhlfFVJtF1n+yY8x2rI+/2uOsJM+Q4WTVsRtGBOrcEvuGtaxPuJj
	 Memk9/C5Ju8IpO5KViV+dNleB9u/4qaKI8URgi40iPp8nsp7PhkZzTsWBa09/yyynP
	 f60cUrSqht+bvR2+dofLxhBE=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9D7240E0214;
	Mon, 17 Mar 2025 10:46:21 +0000 (UTC)
Date: Mon, 17 Mar 2025 11:46:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: x86/fpu] x86/fpu: Use XSAVE{,OPT,C,S} and XRSTOR{,S}
 mnemonics in xstate.h
Message-ID: <20250317104616.GCZ9f9eF-0n0qPbWwk@fat_crate.local>
References: <20250313130251.383204-1-ubizjak@gmail.com>
 <174188823430.14745.17591986001259957573.tip-bot2@tip-bot2>
 <20250317101415.GBZ9f198PAh90nMWDf@fat_crate.local>
 <CAFULd4b-sZucEtvx19==5wcOfOCzj5fuZ2SHS7ZMboZQXdVycg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4b-sZucEtvx19==5wcOfOCzj5fuZ2SHS7ZMboZQXdVycg@mail.gmail.com>

On Mon, Mar 17, 2025 at 11:28:58AM +0100, Uros Bizjak wrote:
> > > @@ -114,10 +113,10 @@ static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 ma
> > >  #define XSTATE_OP(op, st, lmask, hmask, err)                         \
> > >       asm volatile("1:" op "\n\t"                                     \
> > >                    "xor %[err], %[err]\n"                             \
> > > -                  "2:\n\t"                                           \
> > > +                  "2:\n"                                             \
> > >                    _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE)  \
> > >                    : [err] "=a" (err)                                 \
> > > -                  : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)    \
> > > +                  : [xa] "m" (*(st)), "a" (lmask), "d" (hmask)       \
> >
> > This [xa] needs documenting in the comment above this.
> >
> > What does "xa" even mean?
> 
> xsave area.

That's struct xregs_state in kernel nomenclature.

And the macro's argument is called "st".

And when it says [xa] there, one wonders where that "xa" comes from. So please
add a comment above the macro explaining that.

And you can redo the whole patch - it is the topmost one in tip:x86/fpu and
can simply be replaced.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

