Return-Path: <linux-tip-commits+bounces-5266-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5529AAC3B7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 14:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27751C262A8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 12:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C322027FB18;
	Tue,  6 May 2025 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PiqEuBiu"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A983278146;
	Tue,  6 May 2025 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746533980; cv=none; b=nmaGN3fWoNDfsZ0X5vZdgR9U4VFAvvGtyh+2CJ2oefpQmkVtp0tc8Sfl9krJD4dbIbjfa4FcKsK78tga06IMC3EIsNYUuftUKC+fMgMe9+YnMT/X/u/RP2+yDm3RkgzPeCX5qugDWfcYTQgjMhn0cl++cMgm7CJiDLtjMKxtzoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746533980; c=relaxed/simple;
	bh=9sbMJr+mIKp9wKuEJQIcBbY0qRWVRBrg4ctIgw5BX14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1VC2sMviIEl8GbJlhGENLMOvSx8mCQDYMOa7duI+Dkq+oFSAz70hja1+1Asb2vpTdUKR50dtGWAHld5+yYVsrdBfPbC2vMtSaA7kqlebPVnHkL1PqKGM5Drc3AzR7sHR31QuAzchHgXcdo7xAfC9H+kYAxZtGf8DWhuzkZdiCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PiqEuBiu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 71B0040E0196;
	Tue,  6 May 2025 12:19:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OODRIyzZv_61; Tue,  6 May 2025 12:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746533971; bh=jm44TcWJXAdZhZfXPEaze6ec1t9UZL/W1VhmS9cUBnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PiqEuBiu4orAAzkp+pHGLlBLRA3FIVAjUL2YhzHwU/3CBx+995eqzP54xLw84zKhQ
	 E+EglrH1K6V0oo2rStZiqF1MFdudDkaxZsh9GTIDv6IB+EpudzajwqkhqbF5SKEc5S
	 hwGKEE9EvuYoyplam6+tNSnpUtqVIiJbDUC9AnvlfFsAU1/M26lBEtGuPIa4OrSiTG
	 ihjlCs4q0vr1R6gmO9amdG5oH3EnFnpIYsMhHudMwEUNzgq65GZYrrl7V4YonbdObU
	 Rr5N1sFOkmP30af/OwoDUkqpsWE1gBUJkee0ahjNOIniM/siXnH5T9dnqynVW6sO9M
	 QGSBCfwIsPs58ZLYhYPDD1sL/AmksZdsS8PgrDcMZV7UtqzHo6eO6G9xr+ePwJrVXZ
	 8LreZYHfBYfriI0cM7KnD8whvHadFyNiqeb/Ac7K+NHtYR7HtJstCAewJykWU3zytb
	 Bd9oJF9F4gw0sbIJ9yASOpLjcJ6yU056YkWTgZAJkfM6RyWsGV7lC8mEPHN18asmn9
	 xamFkuBA+QiDDvdGT+Qe8KKghf6sLCjZFnwLHIjyDri9jXHq9z7cwnCBCYyFziQiRO
	 Iwfwqfj0i7j2nVAO9NJJDUmHfZ+q5234RASc+oebitbbsi+ZGwJdQTqSvJ6NwnKAB0
	 0HGNKauuso9Vnxezwx5OuKfo=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80EFE40E0173;
	Tue,  6 May 2025 12:19:26 +0000 (UTC)
Date: Tue, 6 May 2025 14:19:20 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	stable@kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/microcode: Add microcode_loader_disabled() storage
 class for the !CONFIG_MICROCODE case
Message-ID: <20250506121920.GCaBn-SNzAJx3aodZF@fat_crate.local>
References: <CANpbe9Wm3z8fy9HbgS8cuhoj0TREYEEkBipDuhgkWFvqX0UoVQ@mail.gmail.com>
 <174628529460.22196.11450380316905137027.tip-bot2@tip-bot2>
 <aBcFv6BzmRNWqLY8@gmail.com>
 <aBhJVJDTlw2Y8owu@gmail.com>
 <20250505074703.GAaBhs99-ndCbFO6xl@fat_crate.local>
 <aBnrBHfj_TM8gyit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBnrBHfj_TM8gyit@gmail.com>

On Tue, May 06, 2025 at 12:57:08PM +0200, Ingo Molnar wrote:
> Please don't forcibly rebase trees like that, because you've just 
> reintroduced a bug this way in tip:x86/urgent:
> 
>   # 5214a9f6c0f5 x86/microcode: Consolidate the loader enablement checking
> 
>   +static inline bool __init microcode_loader_disabled(void) { return false; }
> 
> static inlines don't need an __init tag ...

Oh please do tell what kind of bug that is. Especially if in
a CONFIG_MICROCODE=n build *all* the callsites of that function are gone!

Geez.

> Technically the 'int' in 'unsigned int' is 'unnecessary' and could be 
> skipped as well with 'unsigned', right?

And this is the same how exactly?

> Yet clean kernel code uses it because it's easier to read and more
> consistent. Likewise, the 'extern' storage class is a well-known and
> widespread way in the kernel to document public APIs, a counterpart to
> 'static'. Most of our major headers use that style.

Does this header need it?

No. Not really.

If it fixes something, yes, sure, by all means.

Gratuitous cleanups without any point: no. 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

