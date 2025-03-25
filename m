Return-Path: <linux-tip-commits+bounces-4529-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09138A6F419
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 12:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F386F3AB56B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76172561B8;
	Tue, 25 Mar 2025 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft/YGqeE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2962561A4;
	Tue, 25 Mar 2025 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902356; cv=none; b=ieAjhnAFa8rT8HBPKAhPnVXzk+/FAmJtoWvDgXgX4kUM/Aui0o5afhjANMTMSZvxUSM5w0Hmj/0TWIUFXvXLxXvnlGkggTI+bev3szwWbhtVmDxbsogJO2AJxdjkYPKruo8Urqk7HN7/jjQCLIfuzyTx4tqsciTKXgc9+67RtCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902356; c=relaxed/simple;
	bh=LAr8Bf6j+HhEyNruXvqxpBt11yzs3KpmWOMV+YIiS+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJMj2QM5OPBlWnL46PFrNIBGd7wGjHtw/OyttyEW0E1XKwWIepGcBMolbgtMzplkBopBomj2FQzRnpkKBcPR1hMK2UeITAJoqsUj5LoAYcXnNeK9sRov0RTi+iP1azxG1PjHBIYLymQi1SobXOXfcxq2Wm+Btu9rkbG8NHdBPCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft/YGqeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980B6C4CEED;
	Tue, 25 Mar 2025 11:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902355;
	bh=LAr8Bf6j+HhEyNruXvqxpBt11yzs3KpmWOMV+YIiS+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ft/YGqeE1BLI0gBEuiXyxhjESzNkAXleA4deBPgFxuKFyBy0ukzyKCOCsGeybaVXZ
	 UgZR00E6uMxaZN7UbwdiMpk25bNq9PGNLJZEcVP0rG7mI2w7gANx0fHbtXcpM2JLHy
	 7eFp5+Aov7n/9oyLbC/o7gJCX1HtsC6BEidrBmefgtwqHdD6oKMhlOu4BrVBBuYl9k
	 Knza2xDh3uDauozFuq9vTlzJ4Lkz7Bs3LtuVljY31QDDR1UyGxWTVz/s7bDSf9EEL/
	 uDw5b4uofzMdoj8M3qrQmM9cOQRvJGLZQ4rjzA8e7Vv7g0yu6bD0rUPjYddnGXSi/u
	 /XEo73ibeLQEA==
Date: Tue, 25 Mar 2025 11:32:30 +0000
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, ASoC: codecs: wcd934x: Remove
 potential undefined behavior in wcd934x_slim_irq_handler()
Message-ID: <0b3b6878-a1c1-4cd0-b2a8-d70833759578@sirena.org.uk>
References: <7e863839ec7301bf9c0f429a03873d44e484c31c.1742852847.git.jpoimboe@kernel.org>
 <174289169388.14745.12400458342392826127.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/luSzX7yQ7aRVIJC"
Content-Disposition: inline
In-Reply-To: <174289169388.14745.12400458342392826127.tip-bot2@tip-bot2>
X-Cookie: Visit beautiful Vergas, Minnesota.


--/luSzX7yQ7aRVIJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 08:34:53AM -0000, tip-bot2 for Josh Poimboeuf wrote:
> The following commit has been merged into the objtool/urgent branch of ti=
p:
>=20
> Commit-ID:     46b70c569b774ea2c671bb3aff2a50d29760b7c3
> Gitweb:        https://git.kernel.org/tip/46b70c569b774ea2c671bb3aff2a50d=
29760b7c3
> Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> AuthorDate:    Mon, 24 Mar 2025 14:56:09 -07:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Tue, 25 Mar 2025 09:20:29 +01:00
>=20
> objtool, ASoC: codecs: wcd934x: Remove potential undefined behavior in wc=
d934x_slim_irq_handler()

FWIW the original patch doesn't seem to have made it into my inbox (the
regmap one did), not that it makes a *huge* difference but might be some
infra/script issue which crops up on some other more urgent occasion.

--/luSzX7yQ7aRVIJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfilE0ACgkQJNaLcl1U
h9BS1Qf/QbN3kgpPBI9JdevrTNj9IHyosHVeUBtM1GQdE1P7Fw50gV/HyLB1Hnpc
GuYNQ4S/8lvkGQWCMmmiLSoJ5zjHtksN/zlbRIkm3GYe37BWt/vzLxcP9jouiA5K
uslGY4grHpKJFi37DQBOZuZSo0/cbPbfr7vLGlO1a6QgNMLtZAaYdO4hX99siihF
K6ulcpVG91Jk5GXNj/jbLmVqeHMBx3dSORhjnt4tkcp1GfAd3p0oyRu10jFGl7bF
eDhpBP6bBJ6X1krpiuXS6/P3DVtV2HROVv1893FG7egO3bTr811LQ7uo1Wjg8KH4
2fE4HPHSwoYqkNwys0BTDaJ3ut0QFQ==
=9Ocm
-----END PGP SIGNATURE-----

--/luSzX7yQ7aRVIJC--

