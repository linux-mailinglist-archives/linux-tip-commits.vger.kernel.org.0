Return-Path: <linux-tip-commits+bounces-5237-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DCCAA8D4A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 09:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F620172101
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 07:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9F5176AC8;
	Mon,  5 May 2025 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="haJRq4fk"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A81B26AC3;
	Mon,  5 May 2025 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431247; cv=none; b=m+erCCOw6oHrkxosn1BvgOgBGxACN2nIYOBl/36zrPJ5QCZPfHC55lyP1mmjRHndyHoJ4Sd4ypp8tJ3eMkYAv9cA/f6HLEgn9XIPRcRFcUV3mJPDcZ6cBlqSke01jgQjCHOxIH8UMkI5bb1WkjijQmM4hc2NKs+SsnZLnPvh8PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431247; c=relaxed/simple;
	bh=L+Jobn3Dm82dPXqjNJZeIIpoPjn+JqC4znf9xdvZaAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH/I6s0P/XhmlJ+1awAOjuKXFuXxIOhFsHypnivf56wNvYtFRrYPFrLt6jF3uCyU94E8BBW8pz94s/QL230Y6Z9MkW0qDn0sJLp4Kx/pHptu82LCVU+12EAVvRoEPStBiD62fRreMiDI7+7mZNWDUqDIJaEDEtKBdxu+doFi77A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=haJRq4fk reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 08C9940E01FA;
	Mon,  5 May 2025 07:47:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Eqw4v5yL0XKK; Mon,  5 May 2025 07:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746431236; bh=g87WSiT7cgkCq6TIPbMjnkVlg8RgZZXhg2E7udepX0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=haJRq4fkEgyoGwdPlQLyd1bnbQ0ycJQL98wi6kKVBvDgxb1DNGnlzlvvtBAKai6+1
	 W2FKHYi0dbgYcZPpPDzKs4qJnJ1W6Zi2fW+PB2R7w3OWqZ2ba37EW+kE+tx/9BUzs6
	 WO5iAtxybduSFPbfImqKCewUUuLX8SX+YvugYj+NM6Cq+k2VdGkOOr8ES+wOANMMa5
	 FxnrTgON4StLn/EvojGh4NSpDukOA28ygywpEXDCOwq/bak+W3CpqjtoO21odWSPUV
	 +M5pzmqsrYEGNyhHK30t3vVeeZ64v8pnh3nXRc4nwLfO8KQ9By/0pQo8nzuWXo4uXi
	 BAiZ3e0QQW5rgt1ry1yoBiGTlTVQiVOim9JdVcY9GkbkOt3iH2u7xWcg9+ngTHIuBa
	 /90CdiDd7pdbDdpKvATVpJHXGyLygFszppE/bHJUTWuWe1MiaLLIfBU/do4wZObrQa
	 8pxw2oPvGK5nh6P7I6fqPId47jPTyazZreTp+aWD/ty2LSqTO4ZbAexRT5ZbUNIjqE
	 QRMkS7ha/Ku/qhCf4AkzmYiKohSOtlyOeCk8SooBXw+RERHKhGOxL/sooirPMw9cn7
	 7beX/a7pX4yvREFsxqJYXyIwp5UA4gOnrpViG6ejcUO7U9R+bAsP39/+MBwafYeL4d
	 W0T4WTFYdokt6IxbC3PH93kg=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3F4DE40E0222;
	Mon,  5 May 2025 07:47:11 +0000 (UTC)
Date: Mon, 5 May 2025 09:47:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	stable@kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/microcode: Add microcode_loader_disabled() storage
 class for the !CONFIG_MICROCODE case
Message-ID: <20250505074703.GAaBhs99-ndCbFO6xl@fat_crate.local>
References: <CANpbe9Wm3z8fy9HbgS8cuhoj0TREYEEkBipDuhgkWFvqX0UoVQ@mail.gmail.com>
 <174628529460.22196.11450380316905137027.tip-bot2@tip-bot2>
 <aBcFv6BzmRNWqLY8@gmail.com>
 <aBhJVJDTlw2Y8owu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBhJVJDTlw2Y8owu@gmail.com>
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 07:15:00AM +0200, Ingo Molnar wrote:
>=20
> Fix this build bug:
>=20
>   ./arch/x86/include/asm/microcode.h:27:13: warning: no previous protot=
ype for =E2=80=98microcode_loader_disabled=E2=80=99 [-Wmissing-prototypes=
]
>=20
> by adding the 'static' storage class to the !CONFIG_MICROCODE=20
> prototype.

Thanks, I'll merge it with my patch.

> Also, while at it, add all the other storage classes as well for this=20
> block of prototypes, 'extern' and 'static', respectively.

This I won't add as it is unnecessary.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

