Return-Path: <linux-tip-commits+bounces-5080-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1374DA9373F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 14:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CAB466066
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 12:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9B3274FC4;
	Fri, 18 Apr 2025 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IaOHOOqw"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E1F1DF246;
	Fri, 18 Apr 2025 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979855; cv=none; b=bAvaipcbJnd35phxbCdjr3fL6vhe4ged76sV9q+SqFV3FnUmQF1vDWkJF6YuwV+iSMbG4b3aTFbY9ez9G3DFOkZNWVMY3J0MpErkwbZfk37Zfg2fC9DMfDOmF5YFQ2qA3w08fsfK6F7kjwsyyHGVetzgfacOavwcxB0k7Z7yVQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979855; c=relaxed/simple;
	bh=uUnzL+q7wIgF2mGjWnGorLdgmjHPCsrTUJjyrxQ1HWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+mgV9tR9VKFuYOT/ulrGdL9lwsd+ALHcLs8/vGnhUgbCFwZ82MKJu9zlpUW6KGCa0xw0YArqlgHwpeDDNHiqS7Fn/p9MzqZVcfJMh88dyFX/MhTSrgf4w1sFkAV4OiYRMrFT2IVQy4A7lSHrpz5ggUD0QBnLYTBJ/lrXj2eRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IaOHOOqw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 78E3F40E024A;
	Fri, 18 Apr 2025 12:37:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wwvSEX_I3nzk; Fri, 18 Apr 2025 12:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744979846; bh=s2mYFoHL8m7enCNSKO0eZ1lDiYgdygcE7DJwYrFMfkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IaOHOOqw0pQU5ukLw5Y8g5ELkxgpuopfQp1UexiF0eKfEeDwbbPbqyGqlMOoBmK9V
	 rj4VwFD4xffQnnWOhaqGPK9ZQgol3TwMbocIWekptDwcZ8U7Cc25McHpDJuLsfNVwG
	 ADMlnBgYxuE5nFlG+0vEY1cEE1wYzcDeQFhFy15a+TTE3u4+jUSwJZTDBD5IUfxIAO
	 E10GaX4y2KswhQpI5ommRgkMGkouSPgAGPAlf5PTxMc2phPDhdXAwOvz2clfKmNT/l
	 L6LwbM7rSVhu03qYJaXfxpJe/4D3q6pjpYLSD/p/lg4/9V6dYFEzLn1BI+RoL2lIxk
	 EnVoSmkAbCqH362K/nMF4yRp0N8nJpwotBoZ2YBg1LhzanSCBYfQeBsShmDA1hvIKG
	 ywNOWT7ZoDcbieevEZnRMBfvEwQ2qsS1IJSasDbEjr0QQgO+ZORxY4HnmEmD6M9ESV
	 fpFqIPUJh4zD8T2EIVpWTUEt19sRAveg8W6pfVOhB4BVYCPhol/4NGV0klsCVzwX7q
	 wRPc2nHiCGcgtTQOyunEoF78C4jD4O3QDTfp46v51vE3XiVUYQJulDol9qHbXNFm+K
	 9mtSVfv+XzpH64DFYc11Eh8bap+HgX+iPKRljSN1Ez9Fd4xnDvqClYKnqHhBfftSzu
	 c/KxRyY72ggTpY1NM1GFs+rw=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F44240E0247;
	Fri, 18 Apr 2025 12:37:19 +0000 (UTC)
Date: Fri, 18 Apr 2025 14:37:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	stable <stable@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Sandipan Das <sandipan.das@amd.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/cpu/amd: Fix workaround for erratum 1054
Message-ID: <20250418123713.GCaAJHedTC_JWN__Td@fat_crate.local>
References: <174495817953.31282.5641497960291856424.tip-bot2@tip-bot2>
 <20250418104013.GAaAIsDW2skB12L-nm@renoirsky.local>
 <aAJBgCjGpvyI43E3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAJBgCjGpvyI43E3@gmail.com>

On Fri, Apr 18, 2025 at 02:11:44PM +0200, Ingo Molnar wrote:
> No, it doesn't really 'need' a stable tag, it has a Fixes tag already, 
> which gets processed by the -stable team.

Last time I asked Greg, he said they scan for those tags but it doesn't hurt
to Cc stable as it helps.

Greg?

> Also, the bug is old, 1.5 years old:
> 
>   Date: Sat, 2 Dec 2023 12:50:23 +0100
> 
> plus the erratum is a perf-counters information quality bug affecting 
> what appears to be a limited number of models, with the workaround 

No, the fix is needed because Zen2 and newer won't set
MSR_K7_HWCR_IRPERF_EN_BIT. It needs to go everywhere.

> likely incorporated in BIOS updates as well.

You can very much forget that argument. I have hard BIOS adoption data which
paints an abysmal picture. So NEVER EVER rely on BIOS to do anything.
Especially for Zen1 which is oooold in BIOS time.

> Leave it up to the -stable team whether they think it's severe enough to
> backport it?

No, they leave it to us section maintainers to decide AFAIK.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

