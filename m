Return-Path: <linux-tip-commits+bounces-4996-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDE8A8AA97
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Apr 2025 23:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53C644166C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Apr 2025 21:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749BA255227;
	Tue, 15 Apr 2025 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="c4ogMmTu"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767221C18C;
	Tue, 15 Apr 2025 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744754354; cv=none; b=O5jeV8tQa3hu41QtnaLgvk2h6TixpmFltOEW7zIaAGXZ3P/3+BuMESAqzLL03J96D73fmhRoU/ElhDSWOTDzjWNHt0W5OO9E7I3GJGEl/yvCgjv7uQ0GI8PrsI68JKSb26+aipJhTeBAxrD5suCJvh0jcI5z0YAO2jOYknHO/NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744754354; c=relaxed/simple;
	bh=ZoztBRaWaF8oulMijZIuqNNbxgi9KxoMHPdVBCX22W0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=oo/bVRXCgpYqVtszTDR9mkr4HLtcVFYVxSp5lM1uTy7Y8LGWqom4c0mlfozyNEMqc/U81YAipklvO8/HmaIFaXuUoGykcRI4Ta4bK2TP//EEdXwE1hhjWCmfr8mU8QpWMVUHYsFG9LPoarLl1mlyWdcK3McgQz5LrWAzzRripFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=c4ogMmTu; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 53FLwkaV3049355
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 15 Apr 2025 14:58:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 53FLwkaV3049355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1744754327;
	bh=p/Kobxw00TgT3IZhctQi5ur37RnOL56Ro5ijUB3nIMI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=c4ogMmTun8emHTkMAs/Tvnnz00LCHJbQ6c7AlnlxZUlFWbjNfsXZBnEMgqz7R0M2l
	 n8pMQuFO+SeEYVj7Hu492wKkMFadKYCuT0nO9NvIvof7C1adKGV2TNMSRBfmYqj2p9
	 +vkI10bi++bVIoJoWZ57068naknxsd6Ff4Tzso5fvblPBmWd9wVwxowH1C1i7l5d5Z
	 jeZw1niHMwC2a88wdhtM20VmQAiHovlRFYD+oDSQq0FTIPtRP6cbmrWVN0j52KawNZ
	 AwNqbLnNkweNMCPJ535sLGyQwxCXwc/kY3Mh0B8EwYsHwmhIipHojoKw2xdMtToXyD
	 TEgwjb5BLareA==
Date: Tue, 15 Apr 2025 14:58:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>
CC: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Ian Campbell <ijc@hellion.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/build=5D_x86/boot=3A_Add_bac?=
 =?US-ASCII?Q?k_some_padding_for_the_CRC-32_checksum?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250415215427.GLZ_7Vk6t9Vg-kgAhH@fat_crate.local>
References: <20250312081204.521411-2-ardb+git@google.com> <174178137443.14745.10057090473999621829.tip-bot2@tip-bot2> <20250414135625.GDZ_0UCcIQ-fg8DKZL@fat_crate.local> <CAMj1kXEWerW9A7t0njN7hM7Ms48+mE94p3CTv_LP9P-CotOtPg@mail.gmail.com> <89CE5702-6C52-4E02-9A18-31E4161CA677@zytor.com> <20250415215427.GLZ_7Vk6t9Vg-kgAhH@fat_crate.local>
Message-ID: <CA6671C6-C1E3-4EFB-A63B-77542BE2BB3A@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 15, 2025 2:54:27 PM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Tue, Apr 15, 2025 at 10:00:11AM -0700, H=2E Peter Anvin wrote:
>> >This was done on hpa's request - maybe he has a duration in mind for
>> >this grace period?
>>=20
>> I would prefer to leave it indefinitely, because an all zero pattern is=
 far easier to detect than what would look like a false checksum=2E
>>=20
>> So I remembered eventually who wanted it: it was a direct from flash bo=
ot loader who wanted to detect a partial flash failure before invoking the =
kernel, so that it can redirect to a secondary kernel=2E
>
>What is a "direct from flash boot loader"?
>
>> That would obviously not be an UEFI environment, so the signing issue i=
s not applicable=2E
>>=20
>> An all zero end field actually works for that purpose (although require=
s a boot loader patch), because an unprogrammed flash sector contains FFFFF=
FFF not 00000000=2E
>>=20
>> We have kept the bzImage format backwards compatible =E2=80=93 sometime=
s at considerable effort =E2=80=93 and the cost of reasonably continuing to=
 do so is absolutely minimal=2E This is an incompatible change, so at least=
 it is appropriate to give unambiguous indication thereof=2E
>>=20
>> In other words: it ain't broken, don't try to fix it=2E It is all downs=
ide, no upside=2E
>
>Sure but look at what is there now:
>
>                /* Add 4 bytes of extra space for the obsolete CRC-32 che=
cksum */
>                =2E =3D ALIGN(=2E + 4, 0x200);
>                _edata =3D =2E ;
>
>This basically screams at me: "delete me, delete me!" :-P
>
>So I would probably put the gist of what you say above as a comment there=
 so
>that we have the rationale stated there, for future, trigger-happy
>generations=2E
>
>Thx=2E
>

It is an embedded boot loader that loads the kernel image from flash (eith=
er NAND or NOR), without a file system=2E

