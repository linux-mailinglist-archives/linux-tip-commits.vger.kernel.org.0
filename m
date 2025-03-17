Return-Path: <linux-tip-commits+bounces-4293-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E976A65D23
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 19:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E5D188D5EE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 18:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840731CCEC8;
	Mon, 17 Mar 2025 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BPT1UZz2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C083F199EBB;
	Mon, 17 Mar 2025 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237342; cv=none; b=nEscpUYc57Ry/KNVtS+VgWcfS0FkcF3+n+32MCeXomvE9G9B/6z0CoMu+A3N1ejZwmWG3Volu9Ps06lDALEIHxAHkn8VpmhwZqUehGUVdwXzJ6iRhr5LwV5S/8rTGlShyciz8vUJEXH71Uc8LebYTgGMCdv5uapZK5n0d+eET/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237342; c=relaxed/simple;
	bh=OhcBFAmlrh8cZqJqb627p9ybduEh1BNZbdllZiDtV7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRNwtu0zDQ0Zy79Am5sFkNytIB1Evfxl9umQ05nIXuJfwMIKVCLBHSzeVb02XD59Q4eVboGxltnfsr95b0Xekp9P2DChMW11yMZUa1uEVbB9g7BEOmFgteQF4Sj1OliOnw2ZPC6DnStn0i7glZZrZqhoEG7KvNhlV28qtCSN5Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BPT1UZz2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AED5740E01D1;
	Mon, 17 Mar 2025 18:48:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CAinKpUwp15V; Mon, 17 Mar 2025 18:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742237334; bh=nvbeuLgQbATxTGYjh48hke3t+Gvpq5X4zj0DZ3NlNwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPT1UZz2MWmt1oi3pv8yWDYdo8E6cX+bkfWONBeh/lZLoCHAWodB1uJv/ccph0EXH
	 y/VB6XlCyB1kpq2pZiklINP2pGpJOH67iy1rz3b5glqcXdvPmO+0fo3g1QSVzbuuPm
	 Fln22pH1smLqbKLTmkFOlePxhEQWbcrD4kiXdDLimDLqZle7KwAnnceINXLpIJfzFD
	 OmypYizM8HhdPKpYTyHJh6HSidHV83B5U13dUKm7uNEppTfrVks065wCgsFHr8/LRd
	 f/0asYovjHbmcQo9fv4DZWfzUYoS1XgHRjDyevHCSzhZ+YlpBRqL4IBhDytHNg+IbT
	 GuZKkwpWqhpovMvKhg/kFyCUet15YUA68zkmBCL4nAy5E+TEEiSubbyrfhX+PGwpYu
	 6kn2zLC4xbmg1NvMNDdG43SkAqcBvkNcnYldTwedDmxlVTuciFJBBdCD0ZUEwiF0zs
	 Cmy/WtfUCbsM/69dSZisvr+Vv8fDIIL7IAqEgcx7iBPufaFsgu2eNStOTYTJpMLZ6W
	 6ARe/CtY13Ly1Ix8iKEq6b7gc5Ic4lXdpDveClZP98dD4SzyecqxGsst3h9LL8uc0V
	 kwYh2CgeWmR0f4VMzPE58ymtecmwv9ckOwVpgT938ZNBhE5ir556/k+IQ5idZVwmqM
	 XKC8skOG+RPugVX6iADR2uUQ=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7FE4840E0169;
	Mon, 17 Mar 2025 18:48:44 +0000 (UTC)
Date: Mon, 17 Mar 2025 19:48:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: x86/fpu] x86/fpu: Use XSAVE{,OPT,C,S} and XRSTOR{,S}
 mnemonics in xstate.h
Message-ID: <20250317184839.GIZ9huh0WS7cOFXz0X@fat_crate.local>
References: <20250313130251.383204-1-ubizjak@gmail.com>
 <174188823430.14745.17591986001259957573.tip-bot2@tip-bot2>
 <20250317101415.GBZ9f198PAh90nMWDf@fat_crate.local>
 <CAFULd4b-sZucEtvx19==5wcOfOCzj5fuZ2SHS7ZMboZQXdVycg@mail.gmail.com>
 <20250317104616.GCZ9f9eF-0n0qPbWwk@fat_crate.local>
 <CAFULd4b_a=3xs2b_88WaDR9hLuhMqNZiMu+kNAbrgJf2MoVNnQ@mail.gmail.com>
 <1886668D-E44A-4510-B31E-933545FA2C23@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1886668D-E44A-4510-B31E-933545FA2C23@zytor.com>

On Mon, Mar 17, 2025 at 11:38:12AM -0700, H. Peter Anvin wrote:
> Ok, I'm going to argue, but only because the argument is called "st" and the
> assembly parameter "xa". That's needlessly different and means having to
> look extra hard 
> 
> We can obviously not use the same token, but IMO it would make a lot more
> sense to call one of them _st or perhaps st_p (being a pointer).

Already documented:

https://git.kernel.org/tip/4348e9177813656d5d8bd18f34b3e611df004032

Got tired of discussing the obvious.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

