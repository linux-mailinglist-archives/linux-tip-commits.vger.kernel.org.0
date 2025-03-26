Return-Path: <linux-tip-commits+bounces-4562-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A712A714F9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 11:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FE6188E2BC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 10:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A7E1B6D08;
	Wed, 26 Mar 2025 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXQwYnr1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB6F1AD41F;
	Wed, 26 Mar 2025 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742985331; cv=none; b=ijlI10QgZBTn6EvATJzTzD1VxgkFAe01oDBe63k6tkAYm/Q+ace93hxp9UoRmpttdQbu9OScJLxy3oynQNyvPliMa8599eh9FEpyILzQiv+DkqcJ0OMo9S0Pu4YngdIA7rWB1rSQiIlp5XPW2ofYidr0KJ6HelfXLFmD49cpnw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742985331; c=relaxed/simple;
	bh=Sppx97QIO2UiCanc36x9EickmLREHYObHBI6U0GInro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SudPvvE1HFXNk1dzhQhdD6Zv2QpaZELSF5n2aG/3yS8sgBcEkBqYTOZaT0dGNVZ6ZV7UbYKWgqUcapiRZ6s/Qg7aWi0LIMUGyIYDYAOhdLs+4XXkHbWLTmox79vUGYY6ZoDOTZ7GvwQJAkQO+YnCtalE/O0XEeUo5v5FI4zfA74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXQwYnr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729F1C4CEE2;
	Wed, 26 Mar 2025 10:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742985331;
	bh=Sppx97QIO2UiCanc36x9EickmLREHYObHBI6U0GInro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uXQwYnr1W5s+0kXY0bTs0RXTvpiMCIAiO4o7Gz1N3YjPrzx2BsSyNn3YgObaLAsxs
	 wCNnutkXBprVaUSfRX2EmdUqHMpMa7H9T7nhJmcOMk5xFj+Drf3u5Pxqzo+MDGsqOJ
	 76g/wYa+au6w+EVsCCoWxkWLZ4EY8iZFzKhqW4L/5tK+8HbesSljgbi5ZN0izyfz+l
	 P+7ebqVCXlMBLhH7e3v1GoHnlnzfp1PhIuOJbrKDl1ouzxJ9P5R3hl4dcVTVYjJ72Q
	 KwqnfGjw2dSOxA3/Mp4hM8S76idcSzMxWdKKVhwlAgfu5bqevXLUtjwUwnjY/q2wv8
	 zavuS98ir5p3Q==
Date: Wed, 26 Mar 2025 11:35:28 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent
 theoretical divide-by-zero in pwm_mediatek_config()
Message-ID: <4avdt2nru6cpypssyw5chxiuadh74qcobfboopwsske2ycr565@qnb6utlyxuj4>
References: <fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org>
 <174289169184.14745.2432058307739232322.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hvfawdrhoecikzcm"
Content-Disposition: inline
In-Reply-To: <174289169184.14745.2432058307739232322.tip-bot2@tip-bot2>


--hvfawdrhoecikzcm
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent
 theoretical divide-by-zero in pwm_mediatek_config()
MIME-Version: 1.0

[I forgot a comma in the original post and so the list of Cc: was
broken. Here comes a resend, sorry to everyone who get the mail twice
now. If you reply, please do so on this copy to not continue using the
broken address.]

Hello,

On Tue, Mar 25, 2025 at 08:34:51AM +0000, tip-bot2 for Josh Poimboeuf wrote:
> The following commit has been merged into the objtool/urgent branch of ti=
p:
>
> Commit-ID:     2becbc66a151500636046503f541255af6acf4fa
> Gitweb:        https://git.kernel.org/tip/2becbc66a151500636046503f541255=
af6acf4fa
> Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> AuthorDate:    Mon, 24 Mar 2025 14:56:11 -07:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Tue, 25 Mar 2025 09:20:32 +01:00

I wonder a bit about procedures here. While I like that warnings that
pop up in drivers/pwm (and elsewhere) are cared for, I think that the
sensible way to change warning related settings is to make it hard to
enable them first (harder than "depends on !COMPILE_TEST" "To avoid
breaking bots too badly") and then work on the identified problems
before warning broadly. The way chosen here instead seems to be enabling
the warning immediately and then post fixes to the warnings and merge
them without respective maintainer feedback in less than 12 hours.

> objtool, pwm: mediatek: Prevent theoretical divide-by-zero in pwm_mediate=
k_config()
>
> With CONFIG_COMPILE_TEST && !CONFIG_CLK, pwm_mediatek_config() has a
> divide-by-zero in the following line:
>
>       do_div(resolution, clk_get_rate(pc->clk_pwms[pwm->hwpwm]));
>
> due to the fact that the !CONFIG_CLK version of clk_get_rate() returns
> zero.
>
> This is presumably just a theoretical problem: COMPILE_TEST overrides
> the dependency on RALINK which would select COMMON_CLK.  Regardless it's

RALINK and ARCH_MEDIATEK. The latter enables COMMON_CLK as it depends on
ARM or ARM64 which both select COMMON_CLK.

> a good idea to check for the error explicitly to avoid divide-by-zero.
>
> Fixes the following warning:
>
>   drivers/pwm/pwm-mediatek.o: warning: objtool: .text: unexpected end of =
section
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>

Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")

would be nice.

> Cc: "Uwe Kleine-K=F6nig" <ukleinek@kernel.org> (maintainer:PWM SUBSYSTEM)
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/r/fb56444939325cc173e752ba199abd7aeae3bf12.=
1742852847.git.jpoimboe@kernel.org

I fail to reproduce the warning here for an x86_64 build on
1e26c5e28ca5. I have:

        $ grep -E 'CONFIG_(CLK|PWM_MEDIATEK|OBJTOOL_WERROR)\>' .config
        CONFIG_PWM_MEDIATEK=3Dm
        CONFIG_OBJTOOL_WERROR=3Dy

and the build works fine for me and there is no warning about
drivers/pwm/pwm-mediatek.o. What am I missing?

Best regards
Uwe

--hvfawdrhoecikzcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfj2GsACgkQj4D7WH0S
/k7Ragf+MBsmN1FwP/Dpj/5cu97qxUT/mIQy92v3DPR6KSFtN9+x1Uejlwi0n3ru
sq6cK4BEgbI84Nx2E7WjSSnBbK3IJ5stDosbP0kUkd+13gx0reLeiSbgkKkpC0o2
pkh1tEtO8/gdAoH7wDlfYEkIsSKMFFRQScL4a2cdwr3E3gFP7j7wXxjMsKAU7JT6
IPn8Rx38iCsgmDaZyJEHwQrlWQzvi8TdylKMNGTnOQL9N3lnDKCtY1tSZhMs2Gp7
xM016kX6E4VOSXGgiqP1JGnQkWB50S/r6IRm+jfqjaHaZY9j6/BujupHUJ60ZN7V
A+wX22IzsN+ebJJ2tmJflRUa+RdYYA==
=QuOy
-----END PGP SIGNATURE-----

--hvfawdrhoecikzcm--

