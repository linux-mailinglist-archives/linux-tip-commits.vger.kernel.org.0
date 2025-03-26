Return-Path: <linux-tip-commits+bounces-4561-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF92FA7134A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 10:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0A73AEB05
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3079418C32C;
	Wed, 26 Mar 2025 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9iZxNOv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4761547C0
	for <linux-tip-commits@vger.kernel.org>; Wed, 26 Mar 2025 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742979731; cv=none; b=PcJM4Ag4810NkeTHSmpkhHSH48Kba5+8LPS+rEKstSX98I05ZgiR4t+2YZPnyIBR3YyDYLsovXYGZozhujzMy020CEISmtq+F/ajGbDAxcevcgACi+Dgt21GmVKZeYSw5uOxph0DSzQNNc8nkAMjwk1ptKhObZkOyKGQsYi2LoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742979731; c=relaxed/simple;
	bh=HnMLbQ7u6lQdLja8yj4eKYRrTSRcnyD4yDBIeCrOwHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpKyNYXy8H+NmM+tTV3yKshIYNGKpylgdU6X5tOSYPXEPQ9bQoArMhFj0GgMTFsV8rsbQMLY1hWcX+2mjpR1pmpZSS9K4vhvb4SVajNs5BW3LKSdaDBzcMZcJWjuvKOoxI6lgvLU9A325qvN6T/8HjJEdCfwD3gHzMKG+44S8gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9iZxNOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08637C4CEE2;
	Wed, 26 Mar 2025 09:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742979730;
	bh=HnMLbQ7u6lQdLja8yj4eKYRrTSRcnyD4yDBIeCrOwHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9iZxNOvUWnwjBxvg7K7zwNJmI4jWYT4gGeSjcFjx46Ju8RLfTugSsS1+5tOhbOUJ
	 EUcUEDBHZetFrFhBa5sOw/+H7al3zxe/Kqsg8pmNI98HxkoKPb69F3K8SQxgU2OPM/
	 0qimNvvAtGkNvx3CwYe+qZ470wG8dyte7bosSQalnYgsk1wwndT2u2IKDW+GH7E0bN
	 uhnkE6qZNgFGCDyEnKNyD+TKYtoh0oCR96A6HHJ4+t3he3rT5AUZ3bScJRHJIyWU77
	 BqeHK8if1BERzIWFY7it5vq/hr8FyrRdIaGJZ80z8loRnPO2Egn2pLcn1jH+Ri+qy+
	 06wKpKqs0/K7g==
Date: Wed, 26 Mar 2025 10:02:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-tip-commits@vger.kernel.org, 
	"linux-kernel@vger.kernel.org Linus Torvalds" <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent
 theoretical divide-by-zero in pwm_mediatek_config()
Message-ID: <m7pgkp3ueo7iqgqf74upjrihr3mpmb3sqhwegnjxxwsrgx2jsw@dnec5iqiyobh>
References: <fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org>
 <174289169184.14745.2432058307739232322.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6kf7ox4iiam55qas"
Content-Disposition: inline
In-Reply-To: <174289169184.14745.2432058307739232322.tip-bot2@tip-bot2>


--6kf7ox4iiam55qas
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent
 theoretical divide-by-zero in pwm_mediatek_config()
MIME-Version: 1.0

On Tue, Mar 25, 2025 at 08:34:51AM +0000, tip-bot2 for Josh Poimboeuf wrote:
> The following commit has been merged into the objtool/urgent branch of ti=
p:
>=20
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
>=20
> With CONFIG_COMPILE_TEST && !CONFIG_CLK, pwm_mediatek_config() has a
> divide-by-zero in the following line:
>=20
> 	do_div(resolution, clk_get_rate(pc->clk_pwms[pwm->hwpwm]));
>=20
> due to the fact that the !CONFIG_CLK version of clk_get_rate() returns
> zero.
>=20
> This is presumably just a theoretical problem: COMPILE_TEST overrides
> the dependency on RALINK which would select COMMON_CLK.  Regardless it's

RALINK and ARCH_MEDIATEK. The latter enables COMMON_CLK as it depends on
ARM or ARM64 which both select COMMON_CLK.

> a good idea to check for the error explicitly to avoid divide-by-zero.
>=20
> Fixes the following warning:
>=20
>   drivers/pwm/pwm-mediatek.o: warning: objtool: .text: unexpected end of =
section
>=20
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

--6kf7ox4iiam55qas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfjwowACgkQj4D7WH0S
/k7+Bwf+KQtUrqfdpXkFMlnvrhxss3iwZA0zfgp6F5JlI2eYQDKOO/UL7ExNo+3h
grceEwlO4uQ7L057pVp6Fg6dovzCTXw4r8vdhO/FPqgzgFo6nYKd0Ybp/Y3JorYq
3ZvyLoNmLdE+NowmJG8Z6vl4A+CnyvG3opu9f36DhQM7kbjWHApKtEPfSpgzM2fn
uyWqOvzzwJjbPnJuqPcMUojkt8kYrduJUK8bsNGSxbbNcX7NPERR/L3w+1HIkKUR
IfcrNvLJCaLxKiZjssOiX48k+ggh858ElaE4m5lS5aNW8opCr3gVkF+aTdrfCWBQ
3UQ+XwJuz4OufS/Am865Cst2Jr4nmg==
=8x4J
-----END PGP SIGNATURE-----

--6kf7ox4iiam55qas--

