Return-Path: <linux-tip-commits+bounces-4582-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F088A75045
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 19:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC017A6686
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 18:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6336B1D7994;
	Fri, 28 Mar 2025 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIJW3V49"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38527286A9;
	Fri, 28 Mar 2025 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743185981; cv=none; b=rX5+ZPrmi/ce0NE7g/PWL0oeOp+WLBAQOtAT9vyx8Cg4mCHnqes6qwyicY4m3Is3ljjkyMwArhq6eh1yJVEXc8gmXY12hL4E5Bg1zvK7N9NlRcdsjoL8rmY9S3LwOUxaqn4CjJ3C/l1h7L7f2qNHbcaBvrj2wxKtFaoZQuwzXrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743185981; c=relaxed/simple;
	bh=kuN9bj2/FuIAEYupxbfKi1EvsySiDFDN5oiqwFLqYAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrC+mstbAApYm+A8DrRf4nRAyQS9u0iwncWCrf3rdF/BPFGY4Hjez0xgyDT7qsQv8Xo6QVJsqAfEBLdIRYbxWqS0fqmGcsEHeI+SY5oLTMKgoj9B7ZVYh82eueASd16lAk7uPCOt/SovWdGiNFWo2h8ZM4MVJVBtxFykLfQFXsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIJW3V49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFAEC4CEE4;
	Fri, 28 Mar 2025 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743185980;
	bh=kuN9bj2/FuIAEYupxbfKi1EvsySiDFDN5oiqwFLqYAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rIJW3V49I9jLbHWMa0w4kTdMtOE1NuGq0BxD57kac4FsGfuJgdz5R18XiwpJ5IY8L
	 WGGNpdsBG8G1TbHbFqidPFPOLG5BnL80GM/yUkmaHea1eSBsVWfyL+aWANghueq9pX
	 bfdVldrFdJjDaSAmRUtmAs9jHgg60Mvg/N3vAADlDttzzIHPq3Nmfq9mFnz+GXDD2O
	 H21R1IAQy+X/EnheoIS0kiB/Blquw4bgU06Jgkp94k+FT7TWvf8qF6ZKNLBCCwRUn3
	 eInjZCGIETrO9DeVuwSxZ6uL0U5bJ401lCJMlFo72XGHDOUVgQ6HQeOOqzmZMK6lzU
	 UQ+EyL9MdLoRg==
Date: Fri, 28 Mar 2025 19:19:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, 
	linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent
 theoretical divide-by-zero in pwm_mediatek_config()
Message-ID: <4swgr64qmedmlpsgaf7n4mfssfoxqkjvlveg3xhm7eogh7ae76@t4zd7fw4trxg>
References: <fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org>
 <174289169184.14745.2432058307739232322.tip-bot2@tip-bot2>
 <m7pgkp3ueo7iqgqf74upjrihr3mpmb3sqhwegnjxxwsrgx2jsw@dnec5iqiyobh>
 <Z-Uv60sD_S2xYVB1@gmail.com>
 <nzk5uzpwqqkflmdgfe7kwsnsecqnsn6vsyo4ycoaueasnud6ot@pg6cazrf6zuf>
 <Z-XBb_8f6cItnlZN@gmail.com>
 <ivss2v7kmk6ylcojffyxwucsmfcgbbe3kxiasbe3dqijvooy6m@vpkopftglx3a>
 <Z-an4KuB-OQE5ovv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f3tl5ltsvr4fcv7q"
Content-Disposition: inline
In-Reply-To: <Z-an4KuB-OQE5ovv@gmail.com>


--f3tl5ltsvr4fcv7q
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent
 theoretical divide-by-zero in pwm_mediatek_config()
MIME-Version: 1.0

Hello Ingo,

On Fri, Mar 28, 2025 at 02:45:04PM +0100, Ingo Molnar wrote:
> * Uwe Kleine-K=F6nig <ukleinek@kernel.org> wrote:
>=20
> > > failures in a single place to not inconvenience randconfig CI=20
> > > testing efforts, so in that sense it would be nice to send this via=
=20
> > > the objtool/urgent tree, but I'll remove it if you insist.
> >=20
> > I'm still in the process to determine my opinion on that.
>=20
> Although Josh's fix looks obviously correct to me, I've removed the=20
> commit from objtool/urgent, because your indecision about it is=20
> blocking other fixes.

This isn't exactly the reaction that I expected, but of course you're
entitled to do that.

> Feel free to pick up the fix in your tree.

I'd like to understand if there are still more fixes needed similar to
the pwm-mediatek one. I managed to reproduce that issue and will play
around with that a bit to check if some more fixes are needed.

Best regards
Uwe


--f3tl5ltsvr4fcv7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfm6DcACgkQj4D7WH0S
/k6Idwf+NHG99w3ld8/jj5dIJe41t+wqWNDukkOdVCI9fnEaA2ORiaTXqYDmK0SU
x1Mzba4AQQxduqqYgYqAaghyNrPWG8IFICvbWETTLMn08YgQQ+L5Y3Jpy34Sgmu2
CNTHzZf9kIar8Ku4uC/JESe9DvK7QxxYMNGaTwiN25k1J9mKDEF2HMI6/kg9gcgX
OzSJBOARIGexC3pj5c6f16Y9nMdn1HggXSyXLJfiGLvsf4YmTB9z0GA5KE3EEdqb
CUozcqKtFBLpQxq3NR3nvu/sbAtJTR6L9hI89s29kEvRGCC1ilgmOW9zglYcCOmy
dJjCHXk0wk1QYDOjs/7e6McqxGgZzw==
=zpEw
-----END PGP SIGNATURE-----

--f3tl5ltsvr4fcv7q--

