Return-Path: <linux-tip-commits+bounces-1469-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B9590EF4D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Jun 2024 15:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FEB1C23D9D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Jun 2024 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C1B14AD35;
	Wed, 19 Jun 2024 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UApPb/IK"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DBE146D54;
	Wed, 19 Jun 2024 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804742; cv=none; b=SUFcaSsYvKS/QPi3fdU2ZqshVg/djmM1gwywVInJCNnU4CdMTdoAAnUNgpPz7B3j3dtYyFhy8jnZ1DP+WlYyLJLpnue4BRR8u+brCbNhbjmUBDD8+48pQHZtmoxuLTiPFO2I88vkugW5ZuJOX6d91W7PLP0UKH9QuWbMx3GIg+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804742; c=relaxed/simple;
	bh=i4eZfD8NuHEdph1gtEhtLoyB7ApzBADRFfcQrRUJ/MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1r0nnxIPRRBuG1n8p6cFA0eKOMs5BaEpC/SyTp5nqeCoNs8EpxZ71f3i9g9FlBORt2rxM1B9OZXMILZ79BEUYtAdWtxLrTwJf15EpjbpR8yWAKhkd4NWNBMhccodZtM9dtAtvR8iFe/Gc/5/6ppg/+WkG0Q0MvkNBCso9oOSGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UApPb/IK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 91FF740E021A;
	Wed, 19 Jun 2024 13:45:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gRVxKwiBY3oi; Wed, 19 Jun 2024 13:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718804734; bh=t+6WnbGeziECA0FJEO+TQh1RnHU/NKYqXNJlXIcz/uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UApPb/IK7apy6BLfMWqyy//SEV2ABOUSvR+IJHE7f05KZSBxPwRkEbfxNS4qxxt96
	 8VIFuCQQ5m8+HAM2uQDCIXX0ObkJMb+u43mz0Hp0mx5pPPJIkkNRrg74u5dpeA1R3j
	 otdi25KsUVLW5fjDFg2mTlsGg6NJdb3w9Y9eyOBLnXJE0yvB2inUpEnZ32W7pxGTkb
	 0lRBBiuwgZhDpVFZIdSBVzQMlgaKUAmU7F/bdUiTkpAHoXfcT03xIXo/ECRR55sjcE
	 wXUZ4GA3qWGEPFgZ5kQZDDlWKL6AbqxRgun+Dy2ufrdep37leg8PPX8SBd01jzjDfU
	 7W9zukL1hmvlq9o1yniO8bXW25g3DF4dPwjvA9xrJVhRlR9zyEuBjZRzq05eWkPZq1
	 +7DX9f7DzR8YzXGMx0B1BOhT6tOsIlli22LiymRlfxuJE3gVGMabZbuwpDFzbW4nzC
	 cw+eyVoCg0xWGPvUKZsSQp2Z/mdkomV6q76rq1Eut84Da13oUWUitljEC2LjHYWypS
	 tq0VwGQkYsbf/Do5myacKevr2cQL/LWOTauBRROvx/TwfBnm6oOvHhGNKAII5yxlX4
	 V+Ar8aK1XC7m918SjYSJy8AICC3t42bUjo1ALxLDJWvH/MRJGKaeqmMYkad7RAI8RL
	 XK7eHHvhpL8+5b9ROaIwN5WQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F9DF40E01F9;
	Wed, 19 Jun 2024 13:45:29 +0000 (UTC)
Date: Wed, 19 Jun 2024 15:45:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-tip-commits@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/urgent] x86/resctrl: Don't try to free nonexistent
 RMIDs
Message-ID: <20240619134522.GCZnLg8pgJq9MPHS8M@fat_crate.local>
References: <20240618140152.83154-1-Dave.Martin@arm.com>
 <171879092443.10875.1695191697085701044.tip-bot2@tip-bot2>
 <ZnLUVtZ3oaFjcUj9@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnLUVtZ3oaFjcUj9@e133380.arm.com>

On Wed, Jun 19, 2024 at 01:51:34PM +0100, Dave Martin wrote:
> This commit message now looks a mess on a regular terminal, since git
> log indents the start of each line by four columns.

Well, we got rid of the 80 cols rule a long time ago so if you're looking at
kernel code in that same terminal, you're looking at a similar mess?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

