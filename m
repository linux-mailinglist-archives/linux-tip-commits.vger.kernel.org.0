Return-Path: <linux-tip-commits+bounces-4574-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFFEA74827
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 11:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E613BD3F3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 10:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC9D21A955;
	Fri, 28 Mar 2025 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVubFPpl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE223219A8A;
	Fri, 28 Mar 2025 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743157488; cv=none; b=mn/BfOjyUxUFtqm58eC1+we3pMsgqJRYYJkeF1Eyk+qk9ctmSQPdRr1kjEn8M+oQBfvJmHJWE6SKCqts4s/dPIceqQD2TCBs1rdBc2wMFoCNnS3/CDf9VQMamjUbC4xCrTy923UBjBcwWw4OFRa9EXs9gxyrrKUpdFwb5gaZlqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743157488; c=relaxed/simple;
	bh=RcdegxXne6OXMg+PBigwFYskT/0HUyTxAwCwwxw0DpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QN4tAQ0+uAeQwkhsDsIWYdKRafATbiWX/mi9PjOsYWQI4hmr/3wyacgVZrwKUK3E/oo+AwCOb05QM/MO9tL3HA2imVd3DIaQGfwPg1QdviBdNGOsGgmVjIdhGdQP9os0UGp4Nfd+V6IeOxVtbbgIht21W9UXkARfMtqs/l7dT3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVubFPpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3FBC4CEE5;
	Fri, 28 Mar 2025 10:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743157488;
	bh=RcdegxXne6OXMg+PBigwFYskT/0HUyTxAwCwwxw0DpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVubFPpl1R2OrjGGKmI/hEsx/UELBmxhVjUfCqPwpOeAyoqSyB/PH0OU+w4eUt6Gs
	 VXEa5albIKJnfyOMHgqat56VEHvuNY/wa1fvNGAKK1yFA/u+ezWnbao/ZfB/U4KOKQ
	 fDN4iVSwyo+EDjasoK0PCjanzE/dPZvWsSo+3cvcWF6I8zxQ9aK8eGQOq0osjW3kvA
	 ZSiTnlwE57F2Cv+OKauD2Og9MC8vkxLCVU/9/CITNPYEJZC7gmBDctgZR9L9Cvrm8W
	 Oo68T39ZSXj7g5nf7fjMY5Q+M+BECmc7sVihvvfzRS4N9vsxhe+8wEJ84kWxxMIk60
	 oYOGBry70K3Mg==
Date: Fri, 28 Mar 2025 11:24:45 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, 
	linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent
 theoretical divide-by-zero in pwm_mediatek_config()
Message-ID: <ivss2v7kmk6ylcojffyxwucsmfcgbbe3kxiasbe3dqijvooy6m@vpkopftglx3a>
References: <fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org>
 <174289169184.14745.2432058307739232322.tip-bot2@tip-bot2>
 <m7pgkp3ueo7iqgqf74upjrihr3mpmb3sqhwegnjxxwsrgx2jsw@dnec5iqiyobh>
 <Z-Uv60sD_S2xYVB1@gmail.com>
 <nzk5uzpwqqkflmdgfe7kwsnsecqnsn6vsyo4ycoaueasnud6ot@pg6cazrf6zuf>
 <Z-XBb_8f6cItnlZN@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ii3sn23we4kckjh5"
Content-Disposition: inline
In-Reply-To: <Z-XBb_8f6cItnlZN@gmail.com>


--ii3sn23we4kckjh5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent
 theoretical divide-by-zero in pwm_mediatek_config()
MIME-Version: 1.0

Hello Ingo,

On Thu, Mar 27, 2025 at 10:21:51PM +0100, Ingo Molnar wrote:
>=20
> * Uwe Kleine-K=F6nig <ukleinek@kernel.org> wrote:
>=20
> > > > > Cc: "Uwe Kleine-K=F6nig" <ukleinek@kernel.org> (maintainer:PWM SU=
BSYSTEM)
> > > > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > > > Link: https://lore.kernel.org/r/fb56444939325cc173e752ba199abd7ae=
ae3bf12.1742852847.git.jpoimboe@kernel.org
> > >=20
> > > I've also tentatively added your Acked-by, if that's OK with you.
> >=20
> > The patch is OK.
>=20
> Thanks!
>=20
> > [...] Iff you can convince me that it should go via tip, it's fine=20
> > for me.
>=20
> I wanted to collect all the objtool fixes for CONFIG_OBJTOOL_WERROR=3Dy=
=20

Regarding "all": Taking a quick look, I wonder if
drivers/pwm/pwm-fsl-ftm.c is also affected. Given I cannot reproduce the
warning for the pwm-mediatek driver, I can only guess. This driver
does:

	static unsigned int fsl_pwm_ticks_to_ns(struct fsl_pwm_chip *fpc,
						  unsigned int ticks)
	{
		unsigned long rate;
		unsigned long long exval;

		rate =3D clk_get_rate(fpc->clk[fpc->period.clk_select]);
		exval =3D ticks;
		exval *=3D 1000000000UL;
		do_div(exval, rate >> fpc->period.clk_ps);
		return exval;
	}

and doesn't depend on HAVE_CLK. So similar to the pwm-mediatek driver
there are configurations where clk_get_rate() returns 0.

Assuming this is indeed a problem, I wonder how many more offenders
there are and if CONFIG_OBJTOOL_WERROR is ready for prime time already.

> failures in a single place to not inconvenience randconfig CI testing=20
> efforts, so in that sense it would be nice to send this via the=20
> objtool/urgent tree, but I'll remove it if you insist.

I'm still in the process to determine my opinion on that.

Best regards
Uwe

--ii3sn23we4kckjh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfmeOkACgkQj4D7WH0S
/k4Z3wf8DE39K9ZJB93UpTAIsgPXT+yAXng8sMxoPZPMh62M2G7Kx/l/3RvRkXnW
pzK2Miu/VXCEBEgOqr1KV0FhNr+OojF3DzDn9q9r5YlrRVBKWuLKiB/g/LoL1giZ
e6Y+w5BwLKb4rOjKH2oQsg2fAMgGgm8yJtiYnQYtgHSiZvV/uI5je/+lV9PhtP0F
G89phYV232Cxi1IrJyL1ukxuUgap755fC0Jh6o7/BAuFsjes3TmsxewHZOqpsw1N
RxtGxXnKgLk9GPiPWPQyTXNVQa23smttNl0wMQvmptop5xhN8KVLaXi9T56XN6yb
qHwQbZc1IMaLH4SzcYfeD6n+XyjeHQ==
=TL36
-----END PGP SIGNATURE-----

--ii3sn23we4kckjh5--

