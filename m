Return-Path: <linux-tip-commits+bounces-4107-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9517A59817
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 15:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A640F3A57FA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 14:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63AC22A1E4;
	Mon, 10 Mar 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="p+osrAFi"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E6622A7E1;
	Mon, 10 Mar 2025 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618212; cv=none; b=EIfvqAVrgAjQEtqJJldpI58SVP5wdEVq5aEQwukfo//2mbY98imeZB9+aMtd1ipiDah3uF3c/hOns1A3+YL0n0knaZftOCZrTp2xmlHHfa3TIycBmGmiytML8QHYEX2N6WSmsd2VNIbIZAO4UXCr3UrP3a50+prEjXzdUb/Q1Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618212; c=relaxed/simple;
	bh=ewGaDkOFqPyjeN9+k3ufHGI4cxFZ8zLEpKatYvaSQnA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ogqKuYXWsXET8RZvKf4t/a8H5BvZPEEHUlcvSuAacO62+6qqOPtQ0IBqDL8MWjoemd6l5eTNHBLrKMU0wlDug4Xt7i2ZxsY4LzRQ6CJFcnyRAJJWd0hysmAvnYKJad10r6wP+Q/ZRBoMkgYo6tamP3zl63LXMSY/H32YXrDDrxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=p+osrAFi; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52AEnxqX1654648
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 10 Mar 2025 07:49:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52AEnxqX1654648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741618200;
	bh=QzcilB+KSVBYSQc9ikBLH3zjKH5ws08Aa5y2Evv5Vmk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=p+osrAFiTakr3GTVYWgkJtMn6AfFuG90Iv69diq4MOr7NoSqi+tXTrfGY/v/LSy64
	 ZuhwKBOnrbK/4IESjwpcHUZaXdAYG0ydHl0wRUH4LUkhG5DFGPe1tuh73CLiisdhGk
	 DzPl0UXL+Sykz9L7q2IiBAKB3d7HgbhC5NOLRp45wN5Ux4mFgb73GHwJwORJtqYS1f
	 U7YCCiaWxKN0qONXF6+uCqCHG6L6dAZqseRJC523Z/hs1b49dwMlMGVX1xs5wQWN5+
	 ysR1eG37ktY0zQJkvVPCvMRVnh1QHZq9xYyfXnBqeSWmKJ7einIw4THnuD2U5yFE9B
	 wNK02O/tp2BoQ==
Date: Mon, 10 Mar 2025 07:49:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Gerst <brgerst@gmail.com>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/asm=5D_x86/asm=3A_Make_ASM=5FCALL?=
 =?US-ASCII?Q?=5FCONSTRAINT_conditional_on_frame_pointers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250308013814.sa745d25m3ddlu2b@jpoimboe>
References: <174108458405.14745.4864877018394987266.tip-bot2@tip-bot2> <90B1074B-E7D4-4CE0-8A82-ADEB7BAED7AD@zytor.com> <Z8t7ubUE5P7woAr5@gmail.com> <20250307232157.comm4lycebr7zmre@jpoimboe> <A669251B-7414-4EE7-B0AD-735E845C0B5B@zytor.com> <20250308013814.sa745d25m3ddlu2b@jpoimboe>
Message-ID: <1602F93C-94B6-40DA-A2F6-B8D4C0E24C1F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 7, 2025 5:38:14 PM PST, Josh Poimboeuf <jpoimboe@kernel=2Eorg> wro=
te:
>On Fri, Mar 07, 2025 at 03:29:00PM -0800, H=2E Peter Anvin wrote:
>> On March 7, 2025 3:21:57 PM PST, Josh Poimboeuf <jpoimboe@kernel=2Eorg>=
 wrote:
>> >On Sat, Mar 08, 2025 at 12:05:29AM +0100, Ingo Molnar wrote:
>> >>=20
>> >> * H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>> >>=20
>> >> > > #endif /* __ASSEMBLY__ */
>> >> >=20
>> >> > So we are going to be using this version despite the gcc maintaine=
rs=20
>> >> > telling us it is not supported?
>> >>=20
>> >> No, neither patches are in the x86 tree at the moment=2E
>> >
>> >FWIW, the existing ASM_CALL_CONSTRAINT is also not supported, so this
>> >patch wouldn't have changed anything in that respect=2E
>> >
>> >Regardless I plan to post a new patch set soon with a bunch of cleanup=
s=2E
>> >
>> >It will keep the existing ASM_CALL_CONSTRAINT in place for GCC, and wi=
ll
>> >use the new __builtin_frame_address(0) input constraint for Clang only=
=2E
>> >
>> >There will be a new asm_call() interface to hide the mess=2E
>> >
>>=20
>> Alternatively, you can co-opt the gcc BR I already filed on this and
>> argue there that there are new reasons to support the alternate
>> construct=2E
>
>We hopefully won't need those hacks much longer anyway, as I'll have
>another series to propose removing frame pointers for x86-64=2E
>
>x86-32 can keep frame pointers, but doesn't need the constraints=2E  It's
>not supported for livepatch so it doesn't need to be 100% reliable=2E
>Worst case, an unwind skips a frame, but the call address still shows up
>on stack trace dumps prepended with '?'=2E
>
>I plan to do the asm_call() series before the FP removal series because
>it's presumably less disruptive, and it has a bunch more orthogonal
>cleanups=2E
>

I should probably clarify that this wasn't flippant, but a serious request=
=2E

If this works by accident on existing gcc, and works on clang, that is a v=
ery good reason for making it the supported way of doing this going forward=
 for both compilers=2E Per-compiler hacks are nasty, and although we are pr=
etty good about coping with them in the kernel, some user space app develop=
er is guaranteed to get it wrong=2E=20

Frame pointers are actually more relevant in user space because user space=
 tends to be compiled with a wider range of debug and architecture options,=
 and of course there is simply way more user space code out there=2E

