Return-Path: <linux-tip-commits+bounces-4567-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D98DA72B71
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Mar 2025 09:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7E318824C8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Mar 2025 08:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992622054FB;
	Thu, 27 Mar 2025 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvyEGtYs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722DE2054F5;
	Thu, 27 Mar 2025 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743064035; cv=none; b=syQrqPMJGolOrWBqCyyBeOv0JH/v8CDt8UmzEQVtS0rOIebmwXI0vbFwCi3bKrNFu5HiSyUQIDEIjjqFEUsLJWWPcNRB4XwCHQXEUybVPoLZdrMqLuYr6m6nwZ2c8sqVMoGu1z5LoIfKlDb1OitDVvkJwJ0EPHvn4mJFRG2rTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743064035; c=relaxed/simple;
	bh=O2dsz57EQNAAlhHCV6qrZBFPCi/fpl9rjvv/zSxm5bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0DDWjpABgq5zflXqWdY5BJXulV7r1O4AeFM8Up+Jcx7biQbmQrKlul6lGSRMsYGtzAtLweOag/7AujFgurqu2/VbA2rX1A3MjJS260UeTg4RNPMF2ajmLVfQ8HflbEXcEq/aGflRmU0WdxwHMyR5n1KYDIUnnn3MgRph+7fxZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvyEGtYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDBEC4CEEB;
	Thu, 27 Mar 2025 08:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743064034;
	bh=O2dsz57EQNAAlhHCV6qrZBFPCi/fpl9rjvv/zSxm5bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvyEGtYspj3FjLl+rx4VvuJIIntOO1ATjFIYJTtBSVG9/SDVQi9ayxx+U8wFQCAId
	 geejMNqt4F23xXE66FSksslElI0yZeXG2ICanr7li2KojBdEXWCSu1D475shoHV2bm
	 8Rk4k6NYq5sDqHS4l9BIy/sQPGke1z80pYcTlKNKaM5dsUjNVSPCnNTBUGTXSg2Uw6
	 X8xzkgXeYfsbvjtkGq/Rsy65NbFYeAwdj88PLMVv8wJwGza7hNaRDyiqzLuMgNpPwu
	 sdXqVCYPnzKuSWrdCykKLwCkgf1Cmoai2n76FBspHxWq1b8Jts+SlhODtxKCfE7XT3
	 fiaQuYCjEVVSA==
Date: Thu, 27 Mar 2025 09:27:12 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-tip-commits@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent
 theoretical divide-by-zero in pwm_mediatek_config()
Message-ID: <scvpqpsqlprw5aezendymnhyqmtbwi7belfbnrpjg66joqckrt@2ythe544ujpk>
References: <fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org>
 <174289169184.14745.2432058307739232322.tip-bot2@tip-bot2>
 <4avdt2nru6cpypssyw5chxiuadh74qcobfboopwsske2ycr565@qnb6utlyxuj4>
 <5i7cbgl7vza4bktquqbr7mvkrypbzmoeoys76wpzo4efmwze32@uwasrdhgsejo>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4wbxf4mrb4xhozgj"
Content-Disposition: inline
In-Reply-To: <5i7cbgl7vza4bktquqbr7mvkrypbzmoeoys76wpzo4efmwze32@uwasrdhgsejo>


--4wbxf4mrb4xhozgj
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent
 theoretical divide-by-zero in pwm_mediatek_config()
MIME-Version: 1.0

Hello Josh,

On Wed, Mar 26, 2025 at 10:44:04PM -0700, Josh Poimboeuf wrote:
> On Wed, Mar 26, 2025 at 11:35:28AM +0100, Uwe Kleine-K=F6nig wrote:
> > I wonder a bit about procedures here. While I like that warnings that
> > pop up in drivers/pwm (and elsewhere) are cared for, I think that the
> > sensible way to change warning related settings is to make it hard to
> > enable them first (harder than "depends on !COMPILE_TEST" "To avoid
> > breaking bots too badly") and then work on the identified problems
> > before warning broadly. The way chosen here instead seems to be enabling
> > the warning immediately and then post fixes to the warnings and merge
> > them without respective maintainer feedback in less than 12 hours.
>=20
> Actually, this type of warning has existed for years.  Nothing in the
> recent objtool patches enabled it.

Yes, I understood that the recent patch only made the warning fatal.

> I only discovered this particular one a few days ago.  I suspect it only
> exists with newer compilers.
>=20
> > I fail to reproduce the warning here for an x86_64 build on
> > 1e26c5e28ca5. I have:
> >=20
> >         $ grep -E 'CONFIG_(CLK|PWM_MEDIATEK|OBJTOOL_WERROR)\>' .config
> >         CONFIG_PWM_MEDIATEK=3Dm
> >         CONFIG_OBJTOOL_WERROR=3Dy
> >=20
> > and the build works fine for me and there is no warning about
> > drivers/pwm/pwm-mediatek.o. What am I missing?
>=20
> Sorry, I should have given more details about that.  It was likely
> something with KCOV and/or UBSAN, though I can't seem to recreate it at
> the moment either :-/

The combination "existed for years" + "discovered a few days ago" +
needs particular combination of .config and toolchain makes me believe
the right way to fix is a medium priority patch via the maintainer of
the affected driver. I don't see the urgency to justify the current
procedure.

I don't know what the current merge plan is, but if you want to merge it
through the pwm tree, I'm willing to take it. I wouldn't create a pull
request just for that before 6.15, but send it along if something more
urgent pops up.

Best regards
Uwe

--4wbxf4mrb4xhozgj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmflC90ACgkQj4D7WH0S
/k6H6AgAhhNyd0NgRCpP+bQ0Vwsgx5bBnxOGyeTz2Q+MGlo8XbOMY6V7r14k92WA
Y8ISsVZ20VTwaC7b2DctospsFpRgE3Kv/DEVnb+KungCHzgEPvRy2JcmE23u0YrI
nCllrXxtj3LsZ1EVyKijlDgpUEbjYY4HjeZUtEf1C+1QtPl0DwPMKFgm0gGnQmKi
NhlwLYosPPquMThnLT4RWnt29pqbvTiMmm2mgdi0jqdVwYHfF1J2eG2Z68DI2p94
7JumIGFKdhsbwCOMRlU0QMvI1cBnmtoce3oeUw2GgO5wkxJPoLvvJ5kJT92ATsos
GhRQ/PlU1l3xgrjJa/WvY+ELD5XRyQ==
=lErp
-----END PGP SIGNATURE-----

--4wbxf4mrb4xhozgj--

