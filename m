Return-Path: <linux-tip-commits+bounces-1471-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F8790F3F4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Jun 2024 18:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2741DB20991
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Jun 2024 16:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AC1152191;
	Wed, 19 Jun 2024 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fpD+10nz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77261CAA2;
	Wed, 19 Jun 2024 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718814101; cv=none; b=CWFG5PmznnCXkTjLD/IB+2OoYPOewyBmTZ1G4Kctg8omiA3vYL1xtM+PG471Jwf1Woihb0QMdN8YOAaAExpQL7qtWIrYku6WIG47o31AAgjCQoaO/IXEw1nPeYtYX3OmoPRA0PXg/rc6opNvwxjOJ+9tbQMj3OWnvGn+gpD7ZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718814101; c=relaxed/simple;
	bh=Wb0WD4M3XqUI1pCsWuGrRHCJWON7GNEsaIvp0+S9nzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lq7We+zQCSqrrg7XRsbWCs9R3Xfcadv6bakIaJAwpACZULha/ldQxUX6yfUkcHOAI4y7r615dtO7HrZBbNvF063Lz+xb+P0S7hpaWuO0H024A1rwOtZ6soSIno12oXfrbxpaldixW1VCM857jAAbyq7gXTJhA1PHROaG2yrhBjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fpD+10nz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A489040E01F9;
	Wed, 19 Jun 2024 16:21:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mHJGS0hdo0kH; Wed, 19 Jun 2024 16:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718814094; bh=5TwwB1IhKj1dFD3SKZQGcZT1x75ai8seaUTmduDWBgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpD+10nzmCt8DRNk1h+i/P0lMVaLn/BxftAwuq6bfxkaniOR/hR3TeiSKZVKBY5nc
	 Y83Gv5dgd1xVLSJwKOzHBsKIyvZ+Y2cnQ2GhowjY3MDfFyNJYw8HDjARSu+1ducGml
	 Ku6Di/SWXveARAnwV2fgX69CCd0ehG31CaNuczb3dALPSuAKbwi5N+iFSHW7n4J87V
	 4WOTameOtg1Z8uyWKSI3dDDbadoXAYLx5wcUZf9qJaByHSx7MyzJ2eS7cUeurNjTEV
	 DPbOtCfNb2f4AO3dXmIkHP/GdVVHStJCMC+lL/rWrSw+oVr+LAlhpJ1AYssQnP+ou+
	 s6cFTi4TZwORPzY4nWCocuE7A1A9e3ouPIQWRAIKYaLT1cC81mQE/xAYqcfnTkovc+
	 zU8a9c/mwDN7YKJ1zog2fbxez7Krx/04a0O7W+WHqMN+b5IwNz0tSe4p+WSREMvpo3
	 lRn+dT49PGLJKXx9W1tmiw+5vONECcz/hg8vpRiYENRjHJ9gGHgNzHzywDmC3DYtfF
	 vOXdH/IPlPOwb1SRe4y9YbtBWZHYAx8p7YcFoDyTRXJARCJYhQQSumbvaSdlVMaK3F
	 2kEn7bFcNSTTMQeZBDbtkyl8A4ZEeBjYjgy7VaD31vkuYr2cxEONBGtk7L04hXKfML
	 /RgMI/77oiS6YAZpgBdCLvpE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7610240E01A5;
	Wed, 19 Jun 2024 16:21:29 +0000 (UTC)
Date: Wed, 19 Jun 2024 18:21:24 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-tip-commits@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/urgent] x86/resctrl: Don't try to free nonexistent
 RMIDs
Message-ID: <20240619162124.GFZnMFhPW3wo2Avezo@fat_crate.local>
References: <20240618140152.83154-1-Dave.Martin@arm.com>
 <171879092443.10875.1695191697085701044.tip-bot2@tip-bot2>
 <ZnLUVtZ3oaFjcUj9@e133380.arm.com>
 <20240619134522.GCZnLg8pgJq9MPHS8M@fat_crate.local>
 <ZnMBN487xiPOfpRp@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnMBN487xiPOfpRp@e133380.arm.com>

On Wed, Jun 19, 2024 at 05:03:03PM +0100, Dave Martin wrote:
> It's still a guideline, no?  (Though I admit that common sense has to
> apply and there are quite often good reasons to bust the limit in
> code.)  But commit messages are not code, and don't suffer from
> creeping indentation that eats up half of each line, so the rationale
> is not really the same.

Just do a "git log" on mainline and marvel at all the possible "formatting".

The ship on being able to read commit messages with formatting that fits what
you're expecting has long sailed.

> Anyway, I was just mildly surprised, it's not a huge deal.

Yeah, we don't have a strict rule. And I don't think you can make everyone
agree and then adhere to some rule for commit messages width. But hey... :-)

> (Quoted: "Text-based e-mail should not exceed 80 columns per line of
> text.  Consult the documentation of your e-mail client to enable proper
> line breaks around column 78.".  No statement about commit messages,
> and "should not exceed" is not the same as "should be wrapped to".
> This document doesn't seem to consider how git formats text derived
> from emails.)

See above.

I'm willing to consider a rule for commit messages if the majority agrees on
some rule.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

