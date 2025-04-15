Return-Path: <linux-tip-commits+bounces-4995-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C23A8AA89
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Apr 2025 23:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0486F7AC920
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Apr 2025 21:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70B82248AB;
	Tue, 15 Apr 2025 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="buzp1Inj"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCDC21C18C;
	Tue, 15 Apr 2025 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744754093; cv=none; b=j9YHHoPketb76jBVJPxitQbOXKayXuv3nqlsLKxvVz7I4u3dh8PbxEdKuIf4Ey23Cz3HrYnfmrXRVYQyhnbSq1dnBJwCBEcobUQ5B1pWcZeUVlkMi8oWcScGiBV9YqMPYjNKNeO6qq3ai3y0nJ7sDzMtOaTnNDzSJlWG4aZn5O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744754093; c=relaxed/simple;
	bh=ZZbFtBetr1YtrRn001MQ+bU4WVmaLaWXdReIWobzDo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQqyR81+IQ4kXXWoQq2ELWFg1WAv5nJOCpf1S8ixSZLd41QYqcWDaS8lQRyz25FNMVd0uw+tapmvix+XeqD3R8+l+VV3LZFIBLVGYM/3s8gS9+2VltWkSnjEUv/GZC3C4YPCNUmAhgJW+TmkHUH+4AcCgnQt6iAn6ZZgNy5i6r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=buzp1Inj reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A84B840E015E;
	Tue, 15 Apr 2025 21:54:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1NibRQDG_KtU; Tue, 15 Apr 2025 21:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744754082; bh=SxhtpHPnd4nLcF0fPWUahX1phFdNE82RskD4BKP0aqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=buzp1InjGiXcOpDtp9/TylV7AqU1n40pgojsyZn8VFHg5fHCHt9CTQDoBzYjCU6IY
	 lkjn+HmfusevzUt4ZM0gkuLNBZdijiHCtWcHktxvDpkFMisIoL9zpd1jgwVdsmfuaD
	 3W4ay4/SK3JU5uizE4Ggr/gb+UmwOBD9DLJsM2R2mey924UswxB/k+H8SidqhG8R24
	 jYSBnMcTrQHlKg6pxSZnNRE1aNKhlOvS9+nnsJNX91VYBv588s0zIscGHgf0omKNkH
	 mDBbCd1ndbU3E9A0ATLDR8rpD3K3cx8Z3JztHbFfhnFbF7YTetQRzxrYkz2SCsDZNS
	 UeIU3vYm+4G+RINmWyTlLAmjUGfcpgP45a8zhJcer7Q9+eWrKnp/focB9/R/gPz3yU
	 uPjiguU1JLymYtriMlT38a4KcoDfMnAlma+trRPiDiIq42mokYQKkNrxgwSaHVq/DP
	 krDFWOD5g7cAIVa7ERGYEl60Hsy6uzHYUXfLxdXoPOOLjIUa+lsMsDgzC3PKgBU/zh
	 bTOEErfAhXqk/tY+wH7K5WNWZLcX8U5+LVsoxwjUjfRc+TbvhGJ2zt4P84iQYzSDzi
	 TAoBjQO4OD8LoYJP2MQYmolw8PtOHpv+50sHZTKWpU5ymv1S4JhdkVBkMkT4/Es1G9
	 k/Z5OHc5hwzZeWFnbRsNvcXs=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91B2A40E0196;
	Tue, 15 Apr 2025 21:54:34 +0000 (UTC)
Date: Tue, 15 Apr 2025 23:54:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Ian Campbell <ijc@hellion.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: x86/build] x86/boot: Add back some padding for the CRC-32
 checksum
Message-ID: <20250415215427.GLZ_7Vk6t9Vg-kgAhH@fat_crate.local>
References: <20250312081204.521411-2-ardb+git@google.com>
 <174178137443.14745.10057090473999621829.tip-bot2@tip-bot2>
 <20250414135625.GDZ_0UCcIQ-fg8DKZL@fat_crate.local>
 <CAMj1kXEWerW9A7t0njN7hM7Ms48+mE94p3CTv_LP9P-CotOtPg@mail.gmail.com>
 <89CE5702-6C52-4E02-9A18-31E4161CA677@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89CE5702-6C52-4E02-9A18-31E4161CA677@zytor.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 10:00:11AM -0700, H. Peter Anvin wrote:
> >This was done on hpa's request - maybe he has a duration in mind for
> >this grace period?
>=20
> I would prefer to leave it indefinitely, because an all zero pattern is=
 far easier to detect than what would look like a false checksum.
>=20
> So I remembered eventually who wanted it: it was a direct from flash bo=
ot loader who wanted to detect a partial flash failure before invoking th=
e kernel, so that it can redirect to a secondary kernel.

What is a "direct from flash boot loader"?

> That would obviously not be an UEFI environment, so the signing issue i=
s not applicable.
>=20
> An all zero end field actually works for that purpose (although require=
s a boot loader patch), because an unprogrammed flash sector contains FFF=
FFFFF not 00000000.
>=20
> We have kept the bzImage format backwards compatible =E2=80=93 sometime=
s at considerable effort =E2=80=93 and the cost of reasonably continuing =
to do so is absolutely minimal. This is an incompatible change, so at lea=
st it is appropriate to give unambiguous indication thereof.
>=20
> In other words: it ain't broken, don't try to fix it. It is all downsid=
e, no upside.

Sure but look at what is there now:

                /* Add 4 bytes of extra space for the obsolete CRC-32 che=
cksum */
                . =3D ALIGN(. + 4, 0x200);
                _edata =3D . ;

This basically screams at me: "delete me, delete me!" :-P

So I would probably put the gist of what you say above as a comment there=
 so
that we have the rationale stated there, for future, trigger-happy
generations.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

