Return-Path: <linux-tip-commits+bounces-6814-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE49BDA192
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 16:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76B6A4E84CA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 14:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470E43002C1;
	Tue, 14 Oct 2025 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IKds0kCZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF412FE071;
	Tue, 14 Oct 2025 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452765; cv=none; b=K6bhPwgrNj6XRRAxXt5ymGCaT/yU3veb3qgWzDF2WegQvkRoImfDB8D74QBFH9/08HFhhel5t+d+m6DSu963YrngEmTDjOF5gmDx272DI02vHAhH0EZBeBXldLj3tr5Dz049Y9ynYNjnDiK1Cw9uP/UXhHanQyj9rIaiDHWozZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452765; c=relaxed/simple;
	bh=03XBU/ljH1CvtJGXcF3L5sF94xzuolTmpOzL/YZ+we4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHYP0kt1tWRQCW6qJYKzHYHhBBbxQWecnPo5opPy+aEzYgG4Fa/I/M3iMVg7UpLpkxkvpTcyIp7mZS8WWujLtccSOhrjjPbukgjT5vRu1WMHK3cBsi6gfsKUgYkN99f926fMo9pqIYFqj3qVY7OQiy7wBfjL6TrWp2gWSyP3xUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IKds0kCZ reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 19B6E40E01C9;
	Tue, 14 Oct 2025 14:39:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VJANuCVHVFYv; Tue, 14 Oct 2025 14:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760452756; bh=/OPOJqx+RSwPZEPT1NeBc6SFZ8fOuD4CFHOmHdmHhAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKds0kCZeXoyDTnUolCcERBOKeKbIanX81CMe8blGxEu2KaXBH6V8xOgrfnV7RHXk
	 8qlK9hPZnfEajWC5TjvQZgISq1i/dsUmHsj+zACBIsmCReoUZpr36lCML+qoSoOEqd
	 qzLpZEfFYgBo4DDRkE79w6MO4Z3MgrLftSF18eM1UNkeSF5sK3AD6MG+3SaWBuFngV
	 ETUTKpcDvfTlc0VNtY9rvTFkPXmBqMqypNXWpfejqujf/MPeWlQzrcUJrFOv2D/oJA
	 +fMRj8U2GOYeDvIsIjUqSzbxKh/O05vb137vW6TCXUn6PFhqd1sQk2ldKjt7snncQO
	 /I1C0gUmhdj4F4wUerMEctXBs5ALmhuuYVnkDyKWYA2AdX3TGhut+hT0rnusdtYTxb
	 Vv98IZxa/Lh6HyyLQEWAFaFrTjmw6mSHqAKjs22yOKPWGmz8J9QJhOf0rk19vsSyop
	 fOZf11S0MZJYwPpGkoNskw7TM5+fQ4LCh6uyLSodXRU3Qj7koUUTjzBWaPWlJXOWl4
	 XfLru5rURV9LcbJaG09a+1QIdshrbAP7XGnTggBUehC/858qEZZBq3jwD0Co8/C7y8
	 lyIUFmFmdz4qKu2HkvKqQIzRTyIIUyAeyLynjC0rmEu0nVzb8eWR67fxADNABdWxiH
	 F5zJUYwKCvW5GWrn71naGoso=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5C28E40E016D;
	Tue, 14 Oct 2025 14:39:11 +0000 (UTC)
Date: Tue, 14 Oct 2025 16:39:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: x86/core] x86/alternative: Patch a single alternative
 location only once
Message-ID: <20251014143910.GHaO5gjk3IRSLRwqhY@fat_crate.local>
References: <20250929112947.27267-4-jgross@suse.com>
 <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>
 <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>
 <4fd058ac-3af5-4778-842c-9a185d828c9d@suse.com>
 <20251014141245.GCaO5aXSQqglFrT9Iy@fat_crate.local>
 <c0fb45d5-c4a0-498d-8378-dd96ec261c8c@suse.com>
 <20251014142656.GFaO5dsDlJ6d_WY_fk@fat_crate.local>
 <bafc306d-b43e-464f-94e6-f59eeaa7d690@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bafc306d-b43e-464f-94e6-f59eeaa7d690@suse.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 04:31:31PM +0200, J=C3=BCrgen Gro=C3=9F wrote:
> I have this here in the commit message:
>=20
>   - In case of replacing an indirect with a direct call using the
>     ALT_FLAG_DIRECT_CALL flag, there is no longer the need to have that
>     instance before any other instances at the same location (the
>     original instruction is needed for finding the target of the direct
>     call).
>=20
> which is explaining why the problem is occurring. Isn't that enough?

I can guess what this is about but a concrete example here would make it
a lot clearer, I'd say.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

