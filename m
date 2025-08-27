Return-Path: <linux-tip-commits+bounces-6388-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A07EB37D7D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 10:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B477C7888
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 08:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B873376B4;
	Wed, 27 Aug 2025 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="H2YlbI1d"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D823375C7;
	Wed, 27 Aug 2025 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282763; cv=none; b=ABsfWksAV69W2rDJeHvw9/KW9AIci+wA+jY4bVCgHV9TZ5vJrmOFS3wwEv7tLiS19oYKxw0a1avxx215K3skoEGQj2Rur/I1CUoUsoGbHn9S/qtLBdIHh+afduIIg5rufWR4RpJzmLKgEtqjkHjLnD+vw5h00dQSYFwT8HKKMLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282763; c=relaxed/simple;
	bh=HvCjCKRG0ZmNX5W3P2DI96xuJKEXTc3hliKOG/fOo2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdUHXxjNkr6MIVpThaeeN620ZQ0SfxozfNQ57c7sSviEl8/lDU8FMRPh9OYZLrDbIQKMOGVQrFUpzulz9i408WNBiSrovCdiJL8gRqgrOHAJsbUIydNrvsYjCZpTpakDJ9dwz/URlrbmg1fORa/3kd0KH7CCY29UTtdi+Ipn4kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=H2YlbI1d; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8C80240E027E;
	Wed, 27 Aug 2025 08:19:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Fzy4M1DT4Fjo; Wed, 27 Aug 2025 08:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756282750; bh=M9r5tLI7xeglildtxk5nY/poxUbDebRhVuz4fISHj2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H2YlbI1dFkq140n7hmliUhsiWa2Ct9x8LLsOvLUbUHZx0KMV8Ivq9l9UqIdeASJwv
	 QegSlH9de/972bzQP1KnaRUUJKWzkanNqhMn0qM9+Y18bIup1TFyek9FN4GhyZZXWG
	 ePQT2v1p5yUwM7BIWlL/5mFuZcPryx7s7RTnOzsd42E6O1Pa5J1bMmQWH13jeojllb
	 jGMefadERrUVgi2mUlA8iZWK8rmqN1K6MP5GasOmUIP2M8jzs5qWfeWOjh1pV45WN/
	 HiYL6lk4CGfnTELAGmxKCxNVVU2M5D9poQv50UKW+Q+hvRjDqQ3xzV0/gehBTP9ijm
	 VqqcyWBK82tHsDo4Ae9y5Vd6euC/DtMjLxY3ik2An7AwX88D0tn/DC5PnQXQulI3DX
	 bt4w4DQ15G01aCCnQPdnG1EZ/Qi9tJfusPF+bbScHUsoqQERm1K5I69dBiE3EjSuMy
	 Fnmsmo4EeCernNTr8M0AudB0AMjVl3BGks7c4RDXOPIBdgOufexokfM0Q1GjBINSBF
	 QzoIVabS2RxToFmREQ1U2bstYcnhQvc6RKTYVAGBTI8A8MycFYPO6lYA5+KtvYOJ/V
	 y/2XxGX5G9HISxCQ66m0PHGJ8uT5ojEN5xEtyD1A30WnMSrVDuKgDklXbTVXDuvO38
	 n9wfMoISLFGqpBfVje+SmPXE=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A668240E019C;
	Wed, 27 Aug 2025 08:19:06 +0000 (UTC)
Date: Wed, 27 Aug 2025 10:19:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/asm] x86/vdso: Fix output operand size of RDPID
Message-ID: <20250827081900.GAaK6_dB-acJ_rkKk4@fat_crate.local>
References: <20250616095315.230620-1-ubizjak@gmail.com>
 <175627714358.1920.14102647257754782558.tip-bot2@tip-bot2>
 <CAFULd4aZYEi02cKeS1RAL66Qs149nLys8SJfTvfHuPH3FMXJeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4aZYEi02cKeS1RAL66Qs149nLys8SJfTvfHuPH3FMXJeA@mail.gmail.com>

On Wed, Aug 27, 2025 at 09:53:17AM +0200, Uros Bizjak wrote:
> The 1/2 patch is intended to be backportable

Is it fixing an actual, real life bug?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

