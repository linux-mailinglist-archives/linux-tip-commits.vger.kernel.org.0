Return-Path: <linux-tip-commits+bounces-4572-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0803A73DCF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Mar 2025 19:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9393AA27F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Mar 2025 18:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0290B2192F9;
	Thu, 27 Mar 2025 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGVy+AEU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCA7381C4;
	Thu, 27 Mar 2025 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743099263; cv=none; b=Fbe5yPujPJB5febbRSmN6cPFZ0iPwPQLDnmuGjmBBrkXQ9Qf8OuF1RdtsANc+/arTx0usFK0qFqgrBqBKxJjGrlRb/V5JVN7j2KXCTVhD2o5V+7ZdVSMuPPtgbxanzuxoC3PiRy4jj/FufeBmczv6v8TorJ9ARrcovw0CsZAVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743099263; c=relaxed/simple;
	bh=4Ft9xIPZQUU9uYzVlf33IIEpUMKVpUOzBBAyceCSDZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+y9aVZMUM8qdJ7ALc2uZvYS9Ze2c7ndrYaI7qM8zsO3zU+WFs62FjNWtpXWVgPnQt4ZckLkoPeV7OJLt7JATPqD9xPhOUvtXgWMYgx4MjGzPLqJP8Mq2x93kXsyYM/kClG1Qrt8g6vSJ4PJpv7eLKuv+RpDgN1jFKa8ceBTd1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGVy+AEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823A6C4CEDD;
	Thu, 27 Mar 2025 18:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743099262;
	bh=4Ft9xIPZQUU9uYzVlf33IIEpUMKVpUOzBBAyceCSDZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGVy+AEUA02Dz2ivMK5nygcB3xIec6vKm9osG5+Na5XOIBKYLKg+vq7QxogGf8aLF
	 mzFzL35fVkbO8xq1L+KkR+9vav+RVoWzb1jJqvDSWb92LXPnSTSeV27U01rdWZ+Ti6
	 2/1l8CS8cgBwYOUnaPQ8bgjiaiOeToiMD7+9dsfigyo0DVbxpxLYaGwRsonRt+HDr8
	 /KS/HnRfKTXiKDoQP+G7ZCdKLAgVQSxD//yCes7eCmpVoriYgGwR4uevzfDJpN03or
	 xgeO66GPnu5QETjb1uEThp/zwgjYcUk8oEpN6UbbfgL7Bu7F0Z4+M5NX8TQe0hku0I
	 ylOMpqf5UJO8g==
Date: Thu, 27 Mar 2025 19:14:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, 
	linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent
 theoretical divide-by-zero in pwm_mediatek_config()
Message-ID: <nzk5uzpwqqkflmdgfe7kwsnsecqnsn6vsyo4ycoaueasnud6ot@pg6cazrf6zuf>
References: <fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org>
 <174289169184.14745.2432058307739232322.tip-bot2@tip-bot2>
 <m7pgkp3ueo7iqgqf74upjrihr3mpmb3sqhwegnjxxwsrgx2jsw@dnec5iqiyobh>
 <Z-Uv60sD_S2xYVB1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gqyx7bjsgd2nmhyo"
Content-Disposition: inline
In-Reply-To: <Z-Uv60sD_S2xYVB1@gmail.com>


--gqyx7bjsgd2nmhyo
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent
 theoretical divide-by-zero in pwm_mediatek_config()
MIME-Version: 1.0

Hello Ingo,

On Thu, Mar 27, 2025 at 12:00:59PM +0100, Ingo Molnar wrote:
> * Uwe Kleine-K=F6nig <ukleinek@kernel.org> wrote:
>=20
> > I wonder a bit about procedures here. While I like that warnings that=
=20
> > pop up in drivers/pwm (and elsewhere) are cared for, I think that the=
=20
> > sensible way to change warning related settings is to make it hard to=
=20
> > enable them first (harder than "depends on !COMPILE_TEST" "To avoid=20
> > breaking bots too badly") and then work on the identified problems=20
> > before warning broadly. The way chosen here instead seems to be=20
> > enabling the warning immediately and then post fixes to the warnings=20
> > and merge them without respective maintainer feedback in less than 12=
=20
> > hours.
>=20
> As I indicated elsewhere in this thread, it's a WIP branch, so we'll=20

That sounds as if I should know that. But it's neither in the part of
the thread that I was Cc:d, nor in the cover letter.

> rebase it if/as we get feedback from maintainers: fix or skip the patch=
=20
> on negative feedback, adding in tags on positive feedback.
>=20
> Does this particular patch look good to you?

I fail to see an urgency and so think this patch should better go via
the pwm tree. Do you consider it urgent (as the branch name suggests)?
Or is this v6.16 material?

> > > Cc: "Uwe Kleine-K=F6nig" <ukleinek@kernel.org> (maintainer:PWM SUBSYS=
TEM)
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Link: https://lore.kernel.org/r/fb56444939325cc173e752ba199abd7aeae3b=
f12.1742852847.git.jpoimboe@kernel.org
>=20
> I've also tentatively added your Acked-by, if that's OK with you.

The patch is OK. Iff you can convince me that it should go via tip, it's
fine for me.

Best regards
Uwe

--gqyx7bjsgd2nmhyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfllXgACgkQj4D7WH0S
/k4EiAf/evcJ6ao4tZDmEX3hn4JjXwAyqpF+dLGrNTXZm5pT6bGxE8Dqg7ES3y4c
MpyNiStcHajzSdV3nq/Rd9C+9X29KrP3mmwLuG8pl1GzAp723fsib2U9i21fZiwN
t8MPS3l6YhWIaYixqkRsaNjnKLGRz2m2+ZYe4Pjnr5eDIrOHp7sfjpkE+b481K5B
DZ4ljzMKH46IHzJvOFsBUX8I39lijYDoiNavCTIeqxZ1lxrCRewMYtL4n38UI3ws
bKWUcYySqf5aNuq4mqKXuOaK7kVDuson8HDMaH4jM09j02ybn7VSjDj2FoqxPOGo
nAssvhkLaABByY6PVAbyObkCCVK9fw==
=N7Za
-----END PGP SIGNATURE-----

--gqyx7bjsgd2nmhyo--

