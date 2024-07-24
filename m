Return-Path: <linux-tip-commits+bounces-1747-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB46693AFC2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Jul 2024 12:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD882816F0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Jul 2024 10:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3404215099E;
	Wed, 24 Jul 2024 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="da9s6DyW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0601C6A3;
	Wed, 24 Jul 2024 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721816560; cv=none; b=gkZ+L6C2YEFvhVtbXj/Nyf4RxGJk17bDZSnPTTOEWrGCWomdnmlNgFnGGtPEp0YSBkJeJbF1qYSsY2AyenQuQDsvwtG9tkR7na7TSHWDAl1Y7OIneai8/xUlmNLgD9mSPVohr9fRIQMazuMgjooijkPhRbvUoOtygdgFnxrrKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721816560; c=relaxed/simple;
	bh=CpzLAX+cGc84GixEkngIF402SuS6KyhzX67cnLUe2cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljVhCqmmzDG7xlO6iTMOJ3wjuMOnjo6qWKOFztzBkA0YLQKJYXT+FaVmh69bOor3cr5K0+qsHsskadFKySrLrDfplh80C9rYR8Pyd0ItH6A/U9YKbmawVWf1QlLyDGq6D/sYr/mFeAs3K4XZGzcHSCJ3k8Q+v2k3UaonZqCtad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=da9s6DyW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CF85A40E0206;
	Wed, 24 Jul 2024 10:22:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rV94-xZHxwII; Wed, 24 Jul 2024 10:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721816545; bh=aRdb5RxgRGAawN+GEjx75D5QAxiX5RIlW2M0X8Y3hpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=da9s6DyWniKJPun4Hqa0PJw2PMQCgvTOqr1DL3Y+TWSCqeplAvBRMJoYd/Bse4Y11
	 1zqb96+VHQOjPTYut2eNinffqCuRRfJ67J4KA52OBZTtUNVGd+wMkjIOuUz1LmW1Hs
	 wF0Bs/ptDGVDcD1dr8T/IX3aW788ERNNkyNBDVV3OTfaDZXn8vRflpCNxU6zJlpONJ
	 GyU8SsunIpU3mO+ZHl8KtKvaE1ffjLbWuddnaSDYBKGOl5ucrpUo6GuRYdO/6f977A
	 5OHlXNK4xh1ZRXedazz2yFg8Qel2j/WpfXZY6s2IOJ4iUnlLN4qPjRuZDTI6bV5fNT
	 XLqoWKy1UTO5fe0d39hYPVlV2wvMCOUgB9Svzh/+ZsRnSgPicTqg3JFRZUujRZ7SaF
	 LmzBBun7wgLl5XBtl2o4awSM4ukMHdHtbrBKyh3fG90sCNZAP/7q0ul6e4pRhAoXXE
	 2GNoiWjEyIvUYQLXrxKsb+eYIXM7Msu83rg7rdVvV/ND5MZXPCSqLbQHoX++8DSxIR
	 fDT2UHy8UEFjQ83YtT3xycxjG0cm1qAfrApo9uSUG3GnyQ/twvTG/vwiusjFwLc4T5
	 sHBoNX3psSsQZpCEuUKaGqRbGVNstQELeW6QXGUBWhZbDRw7uFKfG49KxvRIv2n9i+
	 zT9qpC8ix/7XkbgVHGTlFNx8=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F38E40E0185;
	Wed, 24 Jul 2024 10:22:18 +0000 (UTC)
Date: Wed, 24 Jul 2024 12:22:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Frederic Weisbecker <frederic@kernel.org>,
	Narasimhan V <Narasimhan.V@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [tip: timers/urgent] timers/migration: Move hierarchy setup into
 cpuhotplug prepare callback
Message-ID: <20240724102217.GBZqDV2cd_wADGLJoR@fat_crate.local>
References: <20240717094940.18687-1-anna-maria@linutronix.de>
 <172141237277.2215.9152426860884348584.tip-bot2@tip-bot2>
 <Zp5bpLJHlYsZinGj@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zp5bpLJHlYsZinGj@localhost.localdomain>

On Mon, Jul 22, 2024 at 03:16:20PM +0200, Frederic Weisbecker wrote:
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index fae04950487f..8d57f7686bb0 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -1673,6 +1673,15 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
>  
>  		lvllist = &tmigr_level_list[top];
>  		if (group->num_children == 1 && list_is_singular(lvllist)) {
> +			/*
> +			 * The target CPU must never do the prepare work, except
> +			 * on early boot when the boot CPU is the target. Otherwise
> +			 * it may spuriously activate the old top level group inside
> +			 * the new one (nevertheless whether old top level group is
> +			 * active or not) and/or release an uninitialized childmask.
> +			 */
> +			WARN_ON_ONCE(cpu == raw_smp_processor_id());
> +
>  			lvllist = &tmigr_level_list[top - 1];
>  			list_for_each_entry(child, lvllist, list) {
>  				if (child->parent)
> @@ -1705,14 +1714,6 @@ static int tmigr_cpu_prepare(unsigned int cpu)
>  	struct tmigr_cpu *tmc = per_cpu_ptr(&tmigr_cpu, cpu);
>  	int ret = 0;
>  
> -	/*
> -	 * The target CPU must never do the prepare work. Otherwise it may
> -	 * spuriously activate the old top level group inside the new one
> -	 * (nevertheless whether old top level group is active or not) and/or
> -	 * release an uninitialized childmask.
> -	 */
> -	WARN_ON_ONCE(cpu == raw_smp_processor_id());
> -
>  	/* Not first online attempt? */
>  	if (tmc->tmgroup)
>  		return ret;

That fixes the issue as confirmed by Narasimhan.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

