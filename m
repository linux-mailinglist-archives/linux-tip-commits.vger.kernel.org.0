Return-Path: <linux-tip-commits+bounces-7115-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59654C258BD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 15:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E98F04E2C1B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDE526F46C;
	Fri, 31 Oct 2025 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ia6tB33C"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC0F18626;
	Fri, 31 Oct 2025 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920481; cv=none; b=Ei/C7XSWwbDavhrxilIL8u+xUuPYlnbxOHFjMufpWQ+bhckj4K2btRSaXF3/H/WgQhrwlwK3qGsqqyjAL5BUnUSGXzVuEb0Qxl/qV/RutO0+BX1UuutmGuJvUEywNbQT1x1pxdAEXxsiBzBgVGVVlKQ4XZxeLsROKK77t51/s9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920481; c=relaxed/simple;
	bh=3NulyacXSl49eNpdqvgtMGL3ehLEXJQuC7SavjrQqxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQd3sC5sxYxU+9XAjLqhWkZ9t9dTdvR1KTg3DPV2rujthBzVLDJG5X54fefUAY/JusrbmEZ2NQX+AAe+qPcszT9PppOCTQkSILsS9PK9mr4O50396qQ8C01ehbLf6A+OxalimUlvoh6YVRjaTJHW8yar0OaZyCtyyq5H3/BcMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ia6tB33C; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EE3AE40E0200;
	Fri, 31 Oct 2025 14:21:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XmPKwdgqzz4d; Fri, 31 Oct 2025 14:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761920473; bh=ItQen+T7r+kQGp63kWdaxPIAtX9W6tLedfhMcm6UYv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ia6tB33CE2BUvRo2T+S5Vp/Dot6zEwWUZwQjxaH82KtzAUJLyQvHiNBoVg9L8MZLB
	 aI+fJbpDUogV/OmKo5/F9gBxJm7epDV25iQzRidcSPQx6ghIkYr9pMtC2iL30rvSEG
	 phIwcYULqiLZcTS4d0QF5OygZuomOGpxgdwL8wH9EhJPCfE2ODE+pMtTgWTVSLhiiK
	 JPIED4tcS9vk3WBETz0JM6vjJ1doVq4k9k0Vt58LfRYiuRnKTjkZB1eLCCqrtifTCV
	 O+dco5ikASsVHkq8rrmfYEHs89n0kD0qV3nJ5t/R56UohbMOphxHtz54EfB6Y9a0El
	 FS+VfnxRPObjT8uc0gHY8XuMqTLH57yGSXCTexFa05TsgL2tYV3Tc2hY3o3mVR51Fu
	 dnIa3ppym7BGykX5+X+C0QS+eIS/QBATLZg49enQeFTKWEuPaTMwd3/D3JnSyhjKIg
	 6R/C6ynNeqBBE2kojTZcDxhVm6iTZB0B2o+9ak6LA0Mrrb3jUNgb02kppl126aHaP9
	 Y+YNbKdIPzoRJ6pgFvvZmOAFML0MmkzeuUwhhpLAKtSNHgSY+OPVC571Ljy5Q69Dte
	 0aemHTvCVcxd2v3bfjNBYxT16OvaHQfhteZQeqC2OARvPQbuvT4gZbqgPbO9/KmMaL
	 nL6Yh1Ipn4HjDta8eCplm1Dw=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7A7ED40E0225;
	Fri, 31 Oct 2025 14:21:06 +0000 (UTC)
Date: Fri, 31 Oct 2025 15:21:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool/klp: Add --debug option to show
 cloning decisions
Message-ID: <20251031142100.GEaQTFzKD-nV3kQkhj@fat_crate.local>
References: <176060833509.709179.4619457534479145477.tip-bot2@tip-bot2>
 <20251031114919.GBaQSiPxZrziOs3RCW@fat_crate.local>
 <20251031140944.GA3022331@ax162>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031140944.GA3022331@ax162>

On Fri, Oct 31, 2025 at 10:09:44AM -0400, Nathan Chancellor wrote:
> Yeah, that looks good to me and matches the workaround that Peter did in
> include/linux/compiler-clang.h. If cleanup is going to be used more in
> objtool, it might be worth taking that approach there too like:
> 
>   #ifdef __clang__
>   #define __cleanup(func) __maybe_unused __attribute__((__cleanup__(func)))
>   #else
>   #define __cleanup(func) __attribute__((__cleanup__(func)))
>   #endif

LGTM.

I'll wait for the objool-er folks to lemme know what they want before
I productize it.

Thx Nathan!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

