Return-Path: <linux-tip-commits+bounces-6722-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A8CB9EFCD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 13:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2CA3AE702
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 11:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF162D1916;
	Thu, 25 Sep 2025 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pydypxqi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A864B28B415;
	Thu, 25 Sep 2025 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800871; cv=none; b=uUy9bMRNbTWnNxpoWJlkdZa4jzFgcH+jbeUk7SHCTCg+bAOUuJgB1GunbKnOvE8Sn1UgUI55j71wfTB9EODfwyiyHRNLoawMMQs8lo9Y3X3YpT3Fe4zOkNIra4oEyDixEXHjgrLNysTHI2CNsqpVntXt3+ze0+HVt9jB+JTRkVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800871; c=relaxed/simple;
	bh=j8MpnwcfPX2dZDPE30kXEzCmdJkyFGmKh1J1fy9wcwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjMRtAu6iWWgxkDaGtyEh5N4fJ7yLt4uc8liGNkafGGRHF1o/toKMcn9I9F7lyAPJjorr7jJfcnrEEOQJHstNn8v9BMenty+SOnZKKDbxgIOHXOsxO8ZQA8oSsfzpv9d5GwwTG1oLk1+xY5iwqxb8kLyNzO1N1IgXPZ8M+2PutI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pydypxqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D389C4CEF0;
	Thu, 25 Sep 2025 11:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758800871;
	bh=j8MpnwcfPX2dZDPE30kXEzCmdJkyFGmKh1J1fy9wcwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pydypxqi9/3Yo/DRcgQRn4JW0wjju74NQJDgbTrF3HrJax7jzMp52QuWypBusKJ7R
	 +Bb3m3wc4rZ3Jbt8nU/dcbTzkJJBPeGk0jlOyo4jmGiPEFinN40GCXlmRXymRz1PJw
	 WDB6MW48CfTT4cxGmrYMZVFps8pcx9M8rKJeAc3dBaKF/UdTt19wtVsj+Z6NBThYmj
	 hS1mUD9VgfYhHVyehs7nD5273NwbasYYhCRbdYyOIWWMbe1K2IifMdU/qBMytK3X2f
	 NdFDQMjTdgxXDBXVZt2XXVT+Hlyl9L9kGZsYoK/xabdfsiOq7Kd+H+YWoLxZcvzMGE
	 tT9dVvyT4HbSA==
Date: Thu, 25 Sep 2025 12:47:47 +0100
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, andrealmeid@igalia.com,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [tip: locking/futex] selftests: kselftest: Create
 ksft_print_dbg_msg()
Message-ID: <833f5ae5-190e-47ec-9ad9-127ad166c80c@sirena.org.uk>
References: <20250917-tonyk-robust_test_cleanup-v3-1-306b373c244d@igalia.com>
 <175838567551.709179.5619760179104074372.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="786AysrNRwx1ZrHy"
Content-Disposition: inline
In-Reply-To: <175838567551.709179.5619760179104074372.tip-bot2@tip-bot2>
X-Cookie: Interchangeable parts won't.


--786AysrNRwx1ZrHy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 04:27:55PM -0000, tip-bot2 for Andr=C3=A9 Almeida w=
rote:
> The following commit has been merged into the locking/futex branch of tip:
>=20
> Commit-ID:     f2662ec26b26adb71783fa5e5ee75aff6f18a940
> Gitweb:        https://git.kernel.org/tip/f2662ec26b26adb71783fa5e5ee75af=
f6f18a940
> Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> AuthorDate:    Wed, 17 Sep 2025 18:21:40 -03:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Sat, 20 Sep 2025 18:11:53 +02:00
>=20
> selftests: kselftest: Create ksft_print_dbg_msg()
>=20
> Create ksft_print_dbg_msg() so testers can enable extra debug messages
> when running a test with the flag -d.

I'm seeing build failures on a wide range of the selftests in -next due
to this patch.  The build fails with:

aarch64-linux-gnu-gcc -fno-asynchronous-unwind-tables -fno-ident -s -Os -no=
stdli
b \
        -include ../../../../include/nolibc/nolibc.h -I../..\
        -static -ffreestanding -Wall za-fork.c /build/stage/build-work/ksel=
ftest
/arm64/fp/za-fork-asm.o -o /build/stage/build-work/kselftest/arm64/fp/za-fo=
rk
In file included from za-fork.c:12:
=2E./../kselftest.h:108:8: error: unknown type name =E2=80=98bool=E2=80=99
  108 | static bool ksft_debug_enabled;
      |        ^~~~
=2E./../kselftest.h:1:1: note: =E2=80=98bool=E2=80=99 is defined in header =
=E2=80=98<stdbool.h>=E2=80=99; this is=20
probably fixable by adding =E2=80=98#include <stdbool.h>=E2=80=99
  +++ |+#include <stdbool.h>
    1 | /* SPDX-License-Identifier: GPL-2.0 */

I'm using gcc-14, full build log at:

   https://builds.sirena.org.uk/f2662ec26b26adb71783fa5e5ee75aff6f18a940/ar=
m64/defconfig/build.log =20

--786AysrNRwx1ZrHy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjVK+IACgkQJNaLcl1U
h9CJmAf/eTpyg7o0X+KrcvqxLv9W5szOk9ZqpjvIflFTDrfMjr+TbUmpu0IaN+Xa
m0DdA3ImxotuYYvmp6jIqU2arJRpDxqT242Srd7h/ADPVIneoqTRUlZZLZzxwThd
cgKA+rsoIuPPdr9Dlgt1a+NotjP1+hqD5eEy+22vSo1YgCQuWW6HzoJbbmzK/Zmo
Gh7nZZzM/xYMzyzfZqWCo7EJgsew4PhtUvuxBy4AlO7FEX684K/DhL6Nw7lMmGdy
7yJbjTenIRmI/5R+3AQnXCojPYi++3p0FNTRLTWAI1hASrERAtxoyS0ja1kXUPxr
ZzHaDI70q0APBkmZv0bRnrPuoGfRzg==
=m9Xn
-----END PGP SIGNATURE-----

--786AysrNRwx1ZrHy--

