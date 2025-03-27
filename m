Return-Path: <linux-tip-commits+bounces-4565-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10506A729FC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Mar 2025 06:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C69217377D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Mar 2025 05:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AE41B81C1;
	Thu, 27 Mar 2025 05:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWETa2j3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B213DDAA;
	Thu, 27 Mar 2025 05:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743054247; cv=none; b=pUyj2kLMtF/spOCK80pIecHhrkfYnlTnEl0mcEnkRcL3THP2N0PIrNlboZvNnxmJla5izX1xXMCAV9h5W0H+reVWXWUvKetaxgmswVinFM69vFi3BGDCz77xSESUgKOcaZZzbWDOP4YSFhORORRYgK+/33ymUJ1GD3LTlebfCKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743054247; c=relaxed/simple;
	bh=7doPNIBcvGM2CVSphaz6RI3B+Qyn0i0/VaXR4AUmgxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sETmgb171naYG1cClQfuSHAVqy45+6boNvP8dIAzvHjEv9sfMB3BdT21Z3pxGFVXgQXAxydXyR51H6OD/ZrLeGz+CE3CLltBHcl+14H0rmNjb7wPxhHOM4b5LxLqWDm9Ggf5JtfMo1xpayTxlGt+YA7rMbDKiNUGnUaEeMOBiMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWETa2j3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52C3C4CEDD;
	Thu, 27 Mar 2025 05:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743054246;
	bh=7doPNIBcvGM2CVSphaz6RI3B+Qyn0i0/VaXR4AUmgxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWETa2j3567PZ4ia0bZOYjmGOwwbxcBFY/NH7FKE4grjP1x1drO6d36mRbM8xKKfT
	 /LiIC0cqcWA0ZR0iQPuD/qItheQHWum9CWuSySdPsunUAfwMKRZGtrr0DCFT9g/18U
	 wFVyAtcseW1uQzrmyCGWBB6KmErqINz6ioGSMfxABVa8m6BEaxdohDq3Be40yEapFC
	 rY0NjTjXfR1JWLi3Az6w51q03c9OlaVviKKgcGCgBMZpATte+WrC48kRf/xQ6jL9Qr
	 skhav8ZQidpmsHGLDxuAp07Bawv2mfioFjooQB2Yk5QQGGO1WcY/uyJ0FmUealsSZ3
	 PQ7tNNsJbUeBg==
Date: Wed, 26 Mar 2025 22:44:04 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-tip-commits@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent
 theoretical divide-by-zero in pwm_mediatek_config()
Message-ID: <5i7cbgl7vza4bktquqbr7mvkrypbzmoeoys76wpzo4efmwze32@uwasrdhgsejo>
References: <fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org>
 <174289169184.14745.2432058307739232322.tip-bot2@tip-bot2>
 <4avdt2nru6cpypssyw5chxiuadh74qcobfboopwsske2ycr565@qnb6utlyxuj4>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4avdt2nru6cpypssyw5chxiuadh74qcobfboopwsske2ycr565@qnb6utlyxuj4>

On Wed, Mar 26, 2025 at 11:35:28AM +0100, Uwe Kleine-König wrote:
> I wonder a bit about procedures here. While I like that warnings that
> pop up in drivers/pwm (and elsewhere) are cared for, I think that the
> sensible way to change warning related settings is to make it hard to
> enable them first (harder than "depends on !COMPILE_TEST" "To avoid
> breaking bots too badly") and then work on the identified problems
> before warning broadly. The way chosen here instead seems to be enabling
> the warning immediately and then post fixes to the warnings and merge
> them without respective maintainer feedback in less than 12 hours.

Actually, this type of warning has existed for years.  Nothing in the
recent objtool patches enabled it.

I only discovered this particular one a few days ago.  I suspect it only
exists with newer compilers.

> I fail to reproduce the warning here for an x86_64 build on
> 1e26c5e28ca5. I have:
> 
>         $ grep -E 'CONFIG_(CLK|PWM_MEDIATEK|OBJTOOL_WERROR)\>' .config
>         CONFIG_PWM_MEDIATEK=m
>         CONFIG_OBJTOOL_WERROR=y
> 
> and the build works fine for me and there is no warning about
> drivers/pwm/pwm-mediatek.o. What am I missing?

Sorry, I should have given more details about that.  It was likely
something with KCOV and/or UBSAN, though I can't seem to recreate it at
the moment either :-/

-- 
Josh

