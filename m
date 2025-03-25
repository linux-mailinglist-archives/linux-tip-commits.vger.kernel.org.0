Return-Path: <linux-tip-commits+bounces-4537-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AA7A70228
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 14:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BB0844E53
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 13:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F5418E34A;
	Tue, 25 Mar 2025 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="My/gFKsl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3B1990AF;
	Tue, 25 Mar 2025 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908652; cv=none; b=Oa4pLTnPl334jaWbLKcLZ4egJWz/s5NMdq46SthbDGxBYZeXRWG0Hwr1wS9W9jhThiSqiA6okyzvHeJCgEerHtkX4KgS/0V1pFpPKUmZoP9mfxTz77RDiuN01xczSumY0eI0yXqyLuCM0gaxKEGRjHS8uKIlRCrPpqVtvtNTRxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908652; c=relaxed/simple;
	bh=G/dRMvLZuCERHfVVqrvJrYXngwoIH+3iOu2PD76yNto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WK/xQY9xEFsbnBAtdEHTa5sxqHcr3R+fLuVO1gqmmubovIukIZsjWpBetFeiuvx94L1GxtlgPRQ2XIViA+/FCjr2YiYSfl/Ov7rBCMJrZwT37JaVt6TPuwbVBzIKK83Kfai+EVkAYkwwIikReI5RVbdxmK5hOgYMVGTgBDfAah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=My/gFKsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7180C4CEE4;
	Tue, 25 Mar 2025 13:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742908651;
	bh=G/dRMvLZuCERHfVVqrvJrYXngwoIH+3iOu2PD76yNto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=My/gFKslcfp9xyNwSVVr/3lWY60jtasBQYfA+YJictLW0LFc5zlpCGoLtRKMK1a10
	 TIHw8SgStjKmR98SfRQ+8lNFBLByU8RsFzHK+cWxTM4rDKLmvAs5qs2OBZpC3YEstT
	 Y/CxmhEK3C8vzHtnk6n7wMWGAQbFT413T+TDQzmyBA0YZwbxSyMZOt2vQfwy5u7BwD
	 1wHj2TAMkZgLciX0N0798uaWHkaQilVinqbOJBJHT/q/tpbusZ16r0QmQ27XCen4U2
	 /Oo2UGOXtxrvFfEKm5pXVLeH+z4xHOkbftib/KD2udEmon8smWDXPP5BedCsbDkxOS
	 2sZtVduh6BYXA==
Date: Tue, 25 Mar 2025 13:17:27 +0000
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, regulator: rk808: Remove
 potential undefined behavior in rk806_set_mode_dcdc()
Message-ID: <b6f22fe3-4d79-44de-9b83-758ab3f98dba@sirena.org.uk>
References: <2023abcddf3f524ba478d64339996f25dc4097d2.1742852847.git.jpoimboe@kernel.org>
 <174289169296.14745.3095638819267951807.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DaOFBVzOAtTlnZpM"
Content-Disposition: inline
In-Reply-To: <174289169296.14745.3095638819267951807.tip-bot2@tip-bot2>
X-Cookie: Don't get mad, get interest.


--DaOFBVzOAtTlnZpM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 08:34:52AM -0000, tip-bot2 for Josh Poimboeuf wrote:
> The following commit has been merged into the objtool/urgent branch of ti=
p:
>=20
> Commit-ID:     4d014a6b8e4dba75eb0b99e6ed990bb7e38da294
> Gitweb:        https://git.kernel.org/tip/4d014a6b8e4dba75eb0b99e6ed990bb=
7e38da294
> Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> AuthorDate:    Mon, 24 Mar 2025 14:56:10 -07:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Tue, 25 Mar 2025 09:20:29 +01:00

Acked-by: Mark Brown <broonie@kernel.org>

--DaOFBVzOAtTlnZpM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfirOYACgkQJNaLcl1U
h9Bi0gf+PRx3EnptDnLlHmCTxpKdhVSh0phTtZ3nPC1PwV3irzwTh05/zPfaeEbR
R1K3UwJdgoBSyRgC+uRKqIQUkyh69cN3CRp1f9ZCWzbg0U/KTs/HFjqHUbStl9hI
cJP64iUeSExXiZhwWua4iOAuV1Eb+RpHXfQ2qJohs6FaX8DRFzPv/ooXqjoQH34D
rLYPb2nwN2qOWFU3uo58fiUbW149d2blmJFi4C9oHLkbaph89NBM+dHQOh9Rv2t+
fldKQFDNWOs70bfLXm/Y1HSErhwqy2NONtEU3qIRumBCEGWbK3KwBFEiL1TGUXyD
tPddDxGP+eB7IOTZ1OVb7jCI0UuIYw==
=B3l0
-----END PGP SIGNATURE-----

--DaOFBVzOAtTlnZpM--

