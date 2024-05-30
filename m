Return-Path: <linux-tip-commits+bounces-1310-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0E88D47EF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 30 May 2024 11:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0753AB2419E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 30 May 2024 09:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19B918398F;
	Thu, 30 May 2024 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Kjmwhpon"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C54418398D;
	Thu, 30 May 2024 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059574; cv=none; b=pk4nHeQgs8X4dmIuP6UfsrZy9it378fpaJ0JBTWQLr+/7AnYmS14775MWMh20u7V99ATp3+7S1G88fdsGXyP1WpZUocfUo1LPW6Gx+2kQjmmUyZI8NJXNsQFk8j8D56mD3OVRFWiCkG5c+odDCWL1KvGCaFQhk5j9CQ03PU8aQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059574; c=relaxed/simple;
	bh=SkjjPhyXR+J9ZYzmle2MoX7KnTUMcyGj3vyfwGgqs9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1to+mjQyMi15Y3cP4Dv1OWdPl+fRVqDDKXxPBLN0z/2AXcmYLWSW42NNtt5P7KRumncNkYs5JX1MtV75Q1Ql+xA3KiplvQvGxZYw9MXvDtlwJ8KH6dVmIXWynZL3rtsdJcrUqUFO9mQQiTdiByngKX++crk5PrBRjT6IXwaduc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Kjmwhpon; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 754FC40E0241;
	Thu, 30 May 2024 08:59:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YMUaDw39zA_D; Thu, 30 May 2024 08:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717059564; bh=Pu8wGV8ZGkv6P0zbzP8zgR3tDmcR1UHFjCtSjRmEi6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KjmwhponTNFOHCCFSlJMeG0zaEADk5R7bfkr2V3rM9AIbyrbfS2K+wIaml9LPWKfh
	 PXQbfKtlwlMXeWFYUPZCxDX2I4yR/LcwnZED41BpIg3lPmRGhYU7+VhzDsGv+YwLmV
	 yx9yB5T1fJTGwn5kPE7zh1hepNa1nFYuwsykDFEPyfnl5IwfX19Phb8bMyLaM4yY18
	 Cng6+Wtr76GZuDFMRsgnmt6Svpj9jauPYsrCnrFQvaLDxFgiO3xQyN3fPWuGnNyA9a
	 0xItRKPhrO3v9Rg1E64xDGKTBT0Hp1BG9GgB4UvVSiMCjB625qxooel3+zTYtqqCjh
	 sLLVu36QvPL6gbB+bP+UrSaxqLgfw/i9DP1znxdJcYBEyosigs9Kqd8y3x3vJ/mr+3
	 Us2jHSMH8Bif9fhIco5UfKVcJMGCHYSoU70hIIac9RGNbNKA+DqAzrGOIDXQFzx7oq
	 t8giJYIPPFmnZXFmuOBGmgMrJWppg8yl4OlhtBG9HjqnCx78zEF6wpwARguGF2dBqo
	 hdJW0Ebc1OiHe9AcEVwPYkGfcI/gSg1gfiWLx6xSvFVXA91q4Wg6H07BLN/k/ybP/v
	 efgdGnygHE4UJJzLW6dV1cvtAYKNxVjG7R92zFnXRpACmUE0Nh/SSTSdb/W/tRqHbt
	 uuYgewoT1TmWfXXU6cH9+v+s=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 92DC640E0177;
	Thu, 30 May 2024 08:59:20 +0000 (UTC)
Date: Thu, 30 May 2024 10:59:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Christian Heusel <christian@heusel.eu>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip: x86/urgent] x86/topology/amd: Evaluate SMT in CPUID leaf
 0x8000001e only on family 0x17 and greater
Message-ID: <20240530085914.GAZlg_4lcZIaa83jVb@fat_crate.local>
References: <7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk>
 <171697474837.10875.6335609575452053884.tip-bot2@tip-bot2>
 <2gj2lkahha4wzyf2ol6xk2ermrmsxaklznrisixdg4m3ogzten@gbrtiyjebeup>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2gj2lkahha4wzyf2ol6xk2ermrmsxaklznrisixdg4m3ogzten@gbrtiyjebeup>

On Thu, May 30, 2024 at 12:40:50AM +0200, Christian Heusel wrote:
> it seems like somehow the patch has lost the following two trailers
> compared to the list variant[0] while being applied:
> 
>     Bisected-by: Christian Heusel <christian@heusel.eu>
>     Cc: regressions@lists.linux.dev
> 
> Did that happen on purpose or did some scripts fail?

Well, we don't add unknown tags because it was getting unwieldy and
Bisected-by is not really one we do. I can offer

	Reported-by: Christian Heusel <christian@heusel.eu>

as bisection is important work and it should be documented.

How does that sound?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

