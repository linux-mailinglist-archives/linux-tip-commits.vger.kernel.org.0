Return-Path: <linux-tip-commits+bounces-1311-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BCD8D4B6B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 30 May 2024 14:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF00BB216FA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 30 May 2024 12:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E501C6892;
	Thu, 30 May 2024 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="yyH0PO52"
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E38E16F0C1;
	Thu, 30 May 2024 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071721; cv=none; b=p7rgHACE4CKxfcoQbgSu8JFwxV1orAnPrV64sdSe83azApJ+VymIsMctjh1FZ9/4DPVguuobT+abUqwZ54BrxHD/NcINiZ6sxJBM5+kJjY5TcSBRy5Rw6FXBgfHpvNpCZd5n8fkjm85k4FNt8JSdEFrAPRpLt0HyqIf0o+x+/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071721; c=relaxed/simple;
	bh=A+7BM5zcg2ZbU2VcbCIwgx++vz8uoB6k8Jxo5wbpzHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGzo9AMBZ7k49+6iiyHzQ34u0jY6CRKlojsjPJY3SV1i8ye3MkiodY1HS3hd66RiniUd43CEdxkrvpZVOaHUkEcVXh5+tuDQTc4kaQ53p/glNBHNrB3WiOuXRYf4FBSbUvN6+wdab92oml3ORZcjiztP7VyDAFA0JWCf62J1Ovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=yyH0PO52; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1717071693; x=1717676493; i=christian@heusel.eu;
	bh=ofSzlfXPN2RQEwtHY7AxtRNd5rOYPTz7ZUpwWo/py9Q=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=yyH0PO52lQW+pPTwt6J/n6YzKC56WhG+GbBl9ljPYHmZfHEZw7tG8axiFQBWUknk
	 HGUkltHrzVd4QLMqIOIz+WQpsrTjwta3UHw72ChOAHVYrrtSAx+2DkLBCaYLRnk9r
	 XdP+cjpPlnsO2/J4n6KxjujKJPN0T5i1ndW15MxxwBVdYVTd9gyO03L6+nd6aF3Yd
	 +Oucmf0R5jZqOW9FDxLvfjmdQllhD76kSsMRV6i6vy+IVXNUAUtYU3xi5ChBn4dHh
	 5zx01vzxqPQZtLW1JNwqzBVKz/gk6ydrmt/j7w05C/3LpAioT6AgwPAUkrph4ncI7
	 XSx0iuzxbB64mjiElQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M4JeB-1sCvlc0kcL-000JjU; Thu, 30
 May 2024 14:21:33 +0200
Date: Thu, 30 May 2024 14:21:28 +0200
From: Christian Heusel <christian@heusel.eu>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip: x86/urgent] x86/topology/amd: Evaluate SMT in CPUID leaf
 0x8000001e only on family 0x17 and greater
Message-ID: <xoof7q7s6gak5iyvp3x6lgksqlpmw6sfiqvyjqc53m7egrvuya@vb7w6uoq25w7>
References: <7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk>
 <171697474837.10875.6335609575452053884.tip-bot2@tip-bot2>
 <2gj2lkahha4wzyf2ol6xk2ermrmsxaklznrisixdg4m3ogzten@gbrtiyjebeup>
 <20240530085914.GAZlg_4lcZIaa83jVb@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nj5e2rqilf7cvfqc"
Content-Disposition: inline
In-Reply-To: <20240530085914.GAZlg_4lcZIaa83jVb@fat_crate.local>
X-Provags-ID: V03:K1:UofRPC2OMG++XNzOW8tOxvoxKnHgI5V+5Vez//AQfuhLuxEFLT3
 X4AHaVr7+Hmb1/iHWOx3HA92EGsPJTIa83Nx6C+m//NI/aLMOmvm9p3CNMqC/a7tRKmgR8p
 A08qjLSP7+gpLXZxnYUFecG4tpBvUpm/1ITUxSUrFS4+GHZLixY/iFrIo9Ifp7fB2VPqwPA
 cp0TNl1s/pYI85LBi65eg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3pKsS524UNg=;vn276BggOWYLHFFQPpUCGhVVp8G
 BgBw66xJROmpHa0Q56pN3n/7QsUQXzt/10uezS7aqXDZ0JEKys1B3I6rUE/WyCGJtEIWa6BBH
 XABTaNwBlVDWL6j3x2BmdEx9rOAL/5SdST6gDz24QMegXFc4D+JvlCjbKU3kXi3Y3A5ctl3BY
 JsronITgfPJel69juz7eLhAE0mxj8eaVxrXMJNHHi2HE8Ek5mDPOnpi/3VARxsxKiv5EUCrlW
 qHC2tsWRah2mVYwmv7TGs2F3mlL/XM9Ca2YGc3tX0XHeIKlWAZZ8rc72hWlEw6WDPaYwdmjTA
 NANlrQQZHMP+8vVviWZL+kIAUFppd5wCEhYV3rveWLU4c1ejhkHSRD3nEtaBJx98AWOQfDtFm
 VgHUkFjtZYa7E0t0kk0sI42208DCYe+3X2xT3wrupMekAziyACxBjyS/i0kx6U6lP1kUBMHeW
 OcuTY9930jIKJEZC5PIIJ8FIoSc+xbaMBTq4ZslgBuO0xUyqr/5y3+Z0F3mDnWwnoYR9zsxHn
 ZI8aQPWLeEMESJbkNIHdc4YphBeqGJKO/wbHbd6FZtRjO5bCMIpDlxnyl5zfcbopO4fBMxCVI
 VIZ5SUwV/8gyMghF4ihm8Ny8J0fxBZWq2VIdJOH0kxruloKUifMgnB/S0t70povTW+BIhfytC
 PJ7CbjE6d4hjNM1JWRQImK1WmhAzg3UYwIfAP4kaalSMNLK4b9eoYMd4eD4h/RswWJNB5BJAh
 exd6rBbMBkDw2NtwELquBzoLH9qvxxkwfwk5Jd4+hozRoR4iuoPcW4=


--nj5e2rqilf7cvfqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/05/30 10:59AM, Borislav Petkov wrote:
> On Thu, May 30, 2024 at 12:40:50AM +0200, Christian Heusel wrote:
> > it seems like somehow the patch has lost the following two trailers
> > compared to the list variant[0] while being applied:
> >=20
> >     Bisected-by: Christian Heusel <christian@heusel.eu>
> >     Cc: regressions@lists.linux.dev
> >=20
> > Did that happen on purpose or did some scripts fail?
>=20
> Well, we don't add unknown tags because it was getting unwieldy and
> Bisected-by is not really one we do. I can offer
>=20
> 	Reported-by: Christian Heusel <christian@heusel.eu>
>=20
> as bisection is important work and it should be documented.
>=20
> How does that sound?

Sounds good! I thought it was a thing because I saw it used in a few
places, i.e. here:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=3De3=
7617c8e53a1f7fcba6d5e1041f4fd8a2425c27

I'll keep it in mind for future bug reports! :)

Have a nice week,
Chris

--nj5e2rqilf7cvfqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmZYb0gACgkQwEfU8yi1
JYW3sRAAlyCJ3vE37fOnturHmODQjIO5EKdSouWkrS5tdvZ5QC26c1iamOL5nn0C
DgLZhGPOaASAmjFdLkF6m7aLexlgcH5Os6uLcrQFIX8elPt4/U9RDF89qtwgrUYu
wL0cW9s02r+GxgvHftgnvdDqt9uJZ5h/7q/bm1VITzsbt/9AvGtkhtfC84+1iY44
eMxSa8jVXYUN8uX3C/ipmugrSfUiIJNJB52QZqVZ7YlDQcEcLhpwiWPrB4UIuWw9
8wJMMQWGmGYxgNRmBeV+BRYdQj7+VDv3mjbvkAcV3XQLmB/GL8F+oNKI+EM15qxn
RZBArRzz1SR1ihGj4iCd9cX9sRE4F7ESTyHJTreoUXsJAr2fygFIfm/jN1U3cGwR
3VfZ5Zf4xOCxEJX+ElRHaUOlVNRgKeYw8/BHFOorg8F0hOo4SCPAn6SDCW4FNPVM
Sua9rhoJ3wslFaNfds418tlHsCGDk+bipVgEhcDhRkk799Ls+REDNTVlnqrP6Zc1
lbqh+PBd+32mhgx4ePWQIZgElxUYt0L2YyaIxUyVF9CkiQsTYCSvd+lQ3ujK6Obp
maCCxWQOuPaH8GaS1Lh7ts+FKXKsKigcr6yW52DJqcM0YAGBiltEGvmYDa8i9lNJ
fU6hQiB2sTafG2jO3HwOY6cdcflmqFDSMs6IwHPB18hrST2iJ6s=
=FIQN
-----END PGP SIGNATURE-----

--nj5e2rqilf7cvfqc--

