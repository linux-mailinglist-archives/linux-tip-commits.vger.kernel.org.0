Return-Path: <linux-tip-commits+bounces-1309-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D3B8D4182
	for <lists+linux-tip-commits@lfdr.de>; Thu, 30 May 2024 00:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A45283FE0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 May 2024 22:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F169C1C9EDF;
	Wed, 29 May 2024 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="ICndzTF3"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39E1225D6;
	Wed, 29 May 2024 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717022805; cv=none; b=NuCa/XWlwydSNfW9CP0fyatrR4U5tqgA9yVWu0aOoXTZUd4goer/ipWAVTqHBPA2RPWeBPUsB4UlNfDbCKCzvt6EqxwOokz2x9muk5lGKsD2n180t8O0eUY2ZLuPRgNHjhi9qSlnOx23VUl9lNWV6SK/A3sE97SdnsEE9646jaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717022805; c=relaxed/simple;
	bh=R8Y/1yWk13Z92Ga0+yRAKYTTyLr7fKDk9Xa0oyL+4KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oD9967xXUZS+Id34equyQ5R/0NqbXwxp2XuWhK5mc12Rk+ZQNJggmyq4UhcmLpNJEh2Yv2PW4+306u0d8D+nZxZZQsoZJr0KJFzaS8psyoN3AEWlHlyr1QI5KNuHunq/QY7dGoVahnjblWHTgrIaSKedQD9bti1gM8tsQioN1DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=ICndzTF3; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1717022787; x=1717627587; i=christian@heusel.eu;
	bh=rvkRn1scf+EMnqlDNbAkVKe1cYluv8bP2a6YdUujSCI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ICndzTF3GrUAldui7KMwiXp3mZlrOHiyGPXdEYms0CKzmkMEd/QPf2auSXXQMe6P
	 3C7g6HRpvClswU/6zlsmHT/MCphlgd1Bp1oSdmyC7zYCbOusjnlIxfMsK4jqnpaQX
	 U56Mzy4+G/+igLzmQeNeZmUIDDaW+pNIT0fsUzMa9T2Xl7PiJNvX6JfbAzipKFOVz
	 xu/dGVVzxx5lGRfBWYk3uWiM241pNbIn+wUcAy1Iqh2rl4HhsicbMx6gBG5QmV57v
	 AMd8q6ec6YaMcpTjF05OLi85n2Ou0XgDmX7nxMCjPD5+Sdr1mbg1c0Lb0p+lLwHo7
	 tQc8ph9Ou+RAJM8oZA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MPp0l-1rpi9g0T3b-00Mx3C; Thu, 30
 May 2024 00:40:51 +0200
Date: Thu, 30 May 2024 00:40:50 +0200
From: Christian Heusel <christian@heusel.eu>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: Re: [tip: x86/urgent] x86/topology/amd: Evaluate SMT in CPUID leaf
 0x8000001e only on family 0x17 and greater
Message-ID: <2gj2lkahha4wzyf2ol6xk2ermrmsxaklznrisixdg4m3ogzten@gbrtiyjebeup>
References: <7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk>
 <171697474837.10875.6335609575452053884.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nhya4smjkjicwrca"
Content-Disposition: inline
In-Reply-To: <171697474837.10875.6335609575452053884.tip-bot2@tip-bot2>
X-Provags-ID: V03:K1:vK0vhD8JptAXyk5NIHfgZzm49lbDcZGdvDC2i+N66TZYrb7Tnwq
 L4YgSbQSD1J37/WvTeCs0XvXwOWkuY2fh+lsfh32HGRLu+9SUr3kxnpZkFjD/p2D1tjpgFb
 J5YtzPl0hjcDLaWpROIcv9Xhl2A3OPgpOj+1Gb9iHoE0yrwr38TQr8Z2stpFiHrzO4hXGtX
 X29aRmpDoFNNOoS+Yp8QA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SS0be6QVhhg=;BdKa79pKeARa249qxJa0nL3pErX
 bniyw4L/lNNdVXXrxuK/kSkvmBn1wh5vC/KH2IKA0zWin8hsFtzxfwkqtz3UYFRV+UHXlw6+v
 tTI/UnKn5ggoTkG9YIHzbdMvyeOs+kuPXpRr2Djsw48eGWVi4qWp/uu0Md4XmRBWQAps/7z0e
 l8nfLOy0NMJOh/osHDdiqGOB95CPoqXriTgoPgvJpEs0wctV8KEt//5VfVke5avEHQ1k5bPQ0
 HKIRcUZYaA2U6mLr5obyGQw1q4zMjbjPuWgRMaBk7wZHMKOdsCqwc9WjHHg90UB6nKPXpMa15
 vtams+R4Z0sTWqsm9B/tGHij3pJV7pDsaCoCBRNPHTSpyS+pm6L+u44hNRvBpj7pk9+wmSTym
 ZCvLz1iisVsm7QiruP6EPPY/Yz+U7eEKXjAO9tqQjbictQmm9551OJcoQvVf5JN2KQik5Jrc2
 zt+ayV1FMmp+hU5A+PDJwTWAqUJ6u9FMS2URGRAz2k4tNjS8XR1aeOZ4QhFgWO/JnqxNw+XaS
 dnuWrICXd913zo2pou0Vm5U9jamnYtPWIaO9YAUKqH1L7cQ++O5ExJDjldN2SR5EYbnYGa4mr
 ++M6raM9840GX/NBjmf8W8Lxq+BU2P48V3b5GMwfxBw2s1eilWnzEEIT3pJF1Bb5ysZdRf5g0
 wTD9U7alhLVmTaUwku2X66oci9/xPQkWkU41AelFJXwOe8DBTERFfKcyo54Y+mt5Omyh9oSzC
 3spgIfd+loz6SEVlGFZJ8szOs0Gh4BRJBtIdHvahrOAeIXmdTO/iD4=


--nhya4smjkjicwrca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/05/29 09:25AM, tip-bot2 for Thomas Gleixner wrote:
> The following commit has been merged into the x86/urgent branch of tip:
>=20
> Commit-ID:     76357cc192acd78b85d4c3380d07f139d906dfe8
> Gitweb:        https://git.kernel.org/tip/76357cc192acd78b85d4c3380d07f13=
9d906dfe8
> Author:        Thomas Gleixner <tglx@linutronix.de>
> AuthorDate:    Tue, 28 May 2024 22:21:31 +02:00
> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> CommitterDate: Wed, 29 May 2024 11:01:20 +02:00
>=20
> [...]
>=20
> Fixes: f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology par=
ser")
> Closes: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-=
/issues/56
> Reported-by: Tim Teichmann <teichmanntim@outlook.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Tested-by: Tim Teichmann <teichmanntim@outlook.de>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw=
6g2jduf6c@7b5pvomauugk

Hey Thomas, hey Borislav,

it seems like somehow the patch has lost the following two trailers
compared to the list variant[0] while being applied:

    Bisected-by: Christian Heusel <christian@heusel.eu>
    Cc: regressions@lists.linux.dev

Did that happen on purpose or did some scripts fail?

Cheers,
Chris

[0]: https://lore.kernel.org/lkml/8734q1bsc4.ffs@tglx/

--nhya4smjkjicwrca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmZXrvIACgkQwEfU8yi1
JYV8KRAAuYOpDzuKP0RvY1IKUBIeX3h/DmjjLa6cnD3Zm2ZId3lPG3hQE7AlwYVp
PiYXN7kyhATzDv2xPW7XlhI6QVTXFIgVXP0scxAlxyMf48X9sWN2xr5UcUhHw2t4
oy264tzA8MikYKICsiTJNHenZoWKgN1/TOGkYDaxX0LNIq8l2xZIQIrGj03gs8h2
goElBb8Uy1xlk1Ym6sN52HX7Ov7bLpcIBfUgMNVSalYmff78zI80SZx/tRoefufx
pBBEhdK67u/dK1JpfIciC8pmYgUsnDAUIbrNCT9VKcxeU6Z49wQ3GbsRse/uoX+u
fgazDTxpY0Nj/eAG0+gkRAHXsM/C1lXBwGnyuCnNN6RpiWrmnxS+70rJ1sz1tbfT
CPOGKfc4K8nEnNSVojorNHq1bTO7vWYCq1oKJEfDJtK5gOyeyDinoQQAFdUy19uZ
1jMKeq8kmd+tWav1VpTrPMJyBcYykulr8BVuMX+4kdQqUCqmGg28NoZic6D4iVfo
nhrsOK8Usvcj86ddgV3OhhSj8NQKLR3WFO8pqw80Ii5a3pWeGfa9rEcHh2dyeVCV
2Pmzb+Yy8Gwzfa1usngXbnmN/glr42L0E9Q+nrS3BL7whZIPC55sZOR5Lmm2xNFt
VJ1zM8/DkQAzR8v1h27DHa8PPa3dTBfS3ql+tGWDKgbm5OUbPLQ=
=vFzW
-----END PGP SIGNATURE-----

--nhya4smjkjicwrca--

