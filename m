Return-Path: <linux-tip-commits+bounces-4991-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC26A8A4D7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Apr 2025 19:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA904400E3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Apr 2025 17:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C0D18B0F;
	Tue, 15 Apr 2025 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="amK3F2zp"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98F17BBF;
	Tue, 15 Apr 2025 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736499; cv=none; b=fBh1zYVW+mQ56zIktV7kUXDS8W8ZtB5IM6VwCLQyFqkEmwAp2+rXMYXZxy7SuMWkVXDN8nVO6pYbVdqKGGknA+7MsWzhBFNfAcTZ41uuMw9E0UcbZ676u43u0cM64CRQRhGdiYiqTBiI9C2I+Srqtej4HVdsfRU312c4BEzxtpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736499; c=relaxed/simple;
	bh=pnuDVtTHYv5Kzi5ocf3oiv0Vqm8eA3qJ9oq3Ou9Lm8M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UW+Q++AdOpZvmIPg3LLqT+z87Nhjx7sXjqMJyFO4eKhSXVqr1OGm9S+ILdILalRTmBJoPU88uNodHGoe0u1Hjp5EZr97XkBhYU0lKx7ZWg42LRHs++t7bJzdblp7tDH4g5RAEeOh81+YQ6Pb5uW/6YL0YKCvxBSQCmnvK9iMYug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=amK3F2zp; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 53FH0EfF2921211
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 15 Apr 2025 10:00:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 53FH0EfF2921211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1744736456;
	bh=2PGO/bjarbzWZFKbGFC0nWFI3jUy9vtqZch+4ZGunNc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=amK3F2zp25ISKDxffxJnlTAQhUERMhDlrWLENN+wwHPHgyTB0Nvlj1JEEGjc2WO1J
	 pW9LOokB4bRhxTf9KR0+JTlnYcwpq2ObamGqL5dhPzDiH8R5rjVKTlNfzk0v6Kh5L+
	 75Bfn7yJx/1MA4/w0QgB5wuv87NQmyBNIe/lJ57QD6zhcM5biq1OPjWk9rZPU4QEWP
	 ikynoRY9YeFgFbZLWTiovNBSOYdrL6wdbX1tchuCQ0iDKaqUWf67CQajftjxSHeuC3
	 rDrLFJimbvBPkv5MCMWE6W8U/MdWKk0t/5b3A0I2jrTCQxvaNjyCUtGctwSjIZmsM4
	 DeYJFwMgoHVRw==
Date: Tue, 15 Apr 2025 10:00:11 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>
CC: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Ian Campbell <ijc@hellion.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/build=5D_x86/boot=3A_Add_bac?=
 =?US-ASCII?Q?k_some_padding_for_the_CRC-32_checksum?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMj1kXEWerW9A7t0njN7hM7Ms48+mE94p3CTv_LP9P-CotOtPg@mail.gmail.com>
References: <20250312081204.521411-2-ardb+git@google.com> <174178137443.14745.10057090473999621829.tip-bot2@tip-bot2> <20250414135625.GDZ_0UCcIQ-fg8DKZL@fat_crate.local> <CAMj1kXEWerW9A7t0njN7hM7Ms48+mE94p3CTv_LP9P-CotOtPg@mail.gmail.com>
Message-ID: <89CE5702-6C52-4E02-9A18-31E4161CA677@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 14, 2025 7:07:53 AM PDT, Ard Biesheuvel <ardb@kernel=2Eorg> wrote:
>On Mon, 14 Apr 2025 at 15:56, Borislav Petkov <bp@alien8=2Ede> wrote:
>>
>> On Wed, Mar 12, 2025 at 12:09:34PM -0000, tip-bot2 for Ard Biesheuvel w=
rote:
>> > The following commit has been merged into the x86/build branch of tip=
:
>> >
>> > Commit-ID:     e471a86a8c523eccdfd1c4745ed7ac7cbdcc1f3f
>> > Gitweb:        https://git=2Ekernel=2Eorg/tip/e471a86a8c523eccdfd1c47=
45ed7ac7cbdcc1f3f
>> > Author:        Ard Biesheuvel <ardb@kernel=2Eorg>
>> > AuthorDate:    Wed, 12 Mar 2025 09:12:05 +01:00
>> > Committer:     Ingo Molnar <mingo@kernel=2Eorg>
>> > CommitterDate: Wed, 12 Mar 2025 13:04:52 +01:00
>> >
>> > x86/boot: Add back some padding for the CRC-32 checksum
>> >
>> > Even though no uses of the bzImage CRC-32 checksum are known, ensure
>> > that the last 4 bytes of the image are unused zero bytes, so that the
>> > checksum can be generated post-build if needed=2E
>>
>> Sounds like it is not needed and sounds like we should whack this thing=
 no?
>>
>> Or are we doing a grace period and then whack it when that grace period
>> expires?
>>
>
>This was done on hpa's request - maybe he has a duration in mind for
>this grace period?

I would prefer to leave it indefinitely, because an all zero pattern is fa=
r easier to detect than what would look like a false checksum=2E

So I remembered eventually who wanted it: it was a direct from flash boot =
loader who wanted to detect a partial flash failure before invoking the ker=
nel, so that it can redirect to a secondary kernel=2E

That would obviously not be an UEFI environment, so the signing issue is n=
ot applicable=2E

An all zero end field actually works for that purpose (although requires a=
 boot loader patch), because an unprogrammed flash sector contains FFFFFFFF=
 not 00000000=2E

We have kept the bzImage format backwards compatible =E2=80=93 sometimes a=
t considerable effort =E2=80=93 and the cost of reasonably continuing to do=
 so is absolutely minimal=2E This is an incompatible change, so at least it=
 is appropriate to give unambiguous indication thereof=2E

In other words: it ain't broken, don't try to fix it=2E It is all downside=
, no upside=2E


