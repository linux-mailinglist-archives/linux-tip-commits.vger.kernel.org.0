Return-Path: <linux-tip-commits+bounces-4108-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC34A59914
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 16:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC94D1633AE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4975C226556;
	Mon, 10 Mar 2025 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fa/Oj2Hr"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3444819D8A9;
	Mon, 10 Mar 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619202; cv=none; b=FPzRs03+VFLA40OE/E0tPbrCeYDKn9XNXAkxxWjQK5Uim1IvICdvCsQUo/N4lpvLLCUoUzUP64YhAkrRGVpfZjdmaXRtbPUi7lr4UG2SjEqPIm8RJm4S4wvm1qsxv1WXuBBSNM1MwpKHlvN+jWpLsK7544gsrW7/BzMtzXnWapU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619202; c=relaxed/simple;
	bh=rZ8uUQkiWZrYIzNjKkld6JK7paqRRusVgUK9k1nfBDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk0xr6La0MM4VygzP0doL9EbgCF+eolClxxe6ThIwGGo5cAP1iodibA1eNEc0DFFkFnp/psDyOhAM8hrY/BDWWtdtvECu8oAI8XPZFKOmEnG62qhMCLQtuuZ8M7n5IyDlmzrfRwQW72ZnnfVYKLRxnle83vnaA6UnM+XWE2t9xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fa/Oj2Hr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 05D1240E0219;
	Mon, 10 Mar 2025 15:06:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Y6eH-qkseM9Y; Mon, 10 Mar 2025 15:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741619194; bh=1QMtNoYRBeomE6w99RXluzph7oHOBKtvkXdRfdtXfII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fa/Oj2HrcNJy7ALPM8YayOMpM8IW8gxi0Ud2tS7+8fCFfu4z0j798pfjgIyPUmtWK
	 eazQzIdGZhIOmm71TmPh6eG1ytmtOQUrS1lwLv76tvZSXq+JR0TISPEvQtzRiiz9/H
	 lkt0y+Ou8Pmj4HzRuBd+peBGk/viav70jNYI8x95mWyXB5r2fl3EhvaENg2qADiU5M
	 YO7YtsWwZQk/5U3jYV1W0LkNHxGVE8Q7FiOMaIyIg4INppvaBvJ2Uq9YC9Je+1eQCd
	 78qT28fUnOL6DWtaFwA5M+pShDBvkd8z1g/G/qtKDuokYp4318a2qjNoZdXXPFXF7b
	 wkI93a529ZAPr/42kCr1FHxjfBBoV36JN5ZqosGLHoWsTYDH2mGqItsX7vFsMjKRel
	 dD6YcwIOgFYKpszDTUJlKNNZbcnjgOcwwTIQqMgtpnRegVzYMwuNQ3V6LcuglidNRE
	 9QYL692r1VtDSVvuhVmdXhEb7vwHGGhrP3QI55urYYde0AFB14iQ4hgwCcRJ//I4zq
	 aax1bTHLED8zfGmmL6Q50QRzb8MbMMpipYUGTcdmo1j6tG8Bdh+OxiyD/x5h/wFnWV
	 DZP8nZfVU/EfIl9WkcUNGdsT7Pdw6JqTedKICSvF9gzxeQAiz8LGunYiwsxkaRZO8M
	 CwjDLX8bjl5ub5Ta9HpFOMvw=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0CF5A40E015D;
	Mon, 10 Mar 2025 15:06:25 +0000 (UTC)
Date: Mon, 10 Mar 2025 16:06:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	"tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>,
	linux-tip-commits@vger.kernel.org, "Xin Li (Intel)" <xin@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: x86/cpu] x86/cpufeatures: Add {REQUIRED,DISABLED} feature
 configs
Message-ID: <20250310150619.GNZ87_66FZYtQ3_4OT@fat_crate.local>
References: <20250228082338.73859-3-xin@zytor.com>
 <174159470920.14745.5729743445717865267.tip-bot2@tip-bot2>
 <A0C784F1-EF4F-4CCC-98AE-954197CD7554@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A0C784F1-EF4F-4CCC-98AE-954197CD7554@zytor.com>

On Mon, Mar 10, 2025 at 07:43:44AM -0700, H. Peter Anvin wrote:
> I think it is worth noting that the list here was intentionally unchanged
> from the previous definitions, but that several of these could and probably
> should be overhauled. 

Sure, send patches.

:-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

