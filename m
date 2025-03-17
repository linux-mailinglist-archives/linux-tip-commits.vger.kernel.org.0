Return-Path: <linux-tip-commits+bounces-4292-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E41A65CE2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 19:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 822CE7A3AFD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 18:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230C0A47;
	Mon, 17 Mar 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Fkzvqlm+"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941AA199947;
	Mon, 17 Mar 2025 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742236719; cv=none; b=VFZnPE/OFWq6AL1vfvbBsRcKpkM/v2UfK6yT0YaIAl55cU0KS9IssUD9alRreVauvqa62JWTcCUVoPDSDOCMvVy3uXhbC5Ai9oQroCTzjyzJC022qmJBTzVFnAYynngYwjluJw4+FDyabstMT/8MDnck6YW6rYaorvknYM/T/WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742236719; c=relaxed/simple;
	bh=1LBVxJitL5UO4S0Z4LYepoRKUaPznTN7cx/SDb/PfoA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=iPx1Y554nPJFHcymN319/F3b10LJB5zoko0UXRoWoEhrwuHKAsZL4SRhSl2YlZCRV1cbQAXaqqLCyIvjl4IyoEM7KjRuzcSYUrwMUjwjZSdN1LLXB30HK7Z/AqfQCdvt8p+6w6dV545EZLZObt4tADkc82V+eX+VktZNNhY/boQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Fkzvqlm+; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52HIcEOi663885
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 17 Mar 2025 11:38:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52HIcEOi663885
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742236695;
	bh=bhzVoSI27Qv+u96iSpgHIvxVbeO2zaDqwasONZPZQN4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Fkzvqlm+gdF+8Y1OMR3suzlaT9l2+5P1lHejz82nu8wspDq64DGG3yA2giuCpyqdl
	 EZLqiXCcyxqrpwrUM8ApZRObBtF13yb8DVeD5x2mJ3Aajs+lEQRn+HNS5DyxUHmBxm
	 9IWhQGGvaXraBYjz9GyO8OtgzDgkH809nQzvhVWG5CLNxxm3ziltEYrCwXs2YZ8fDI
	 7ZW23wl1HZolvkfPEU6Y6v4ZoSCn9ecwGfh4x1OiPNMTnQCPz4lcLx2K0aLiiQ7kCa
	 9Tgnm+6UnE7wL/3py9hwDV74WO547cAubh5jia6AtAgklgF2mBwO045yCRrFfWfuuk
	 q6PO2p58X+xkw==
Date: Mon, 17 Mar 2025 11:38:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>, Borislav Petkov <bp@alien8.de>
CC: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/fpu=5D_x86/fpu=3A_Use_XSAVE=7B=2COPT?=
 =?US-ASCII?Q?=2CC=2CS=7D_and_XRSTOR=7B=2CS=7D_mnemonics_in_xstate=2Eh?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFULd4b_a=3xs2b_88WaDR9hLuhMqNZiMu+kNAbrgJf2MoVNnQ@mail.gmail.com>
References: <20250313130251.383204-1-ubizjak@gmail.com> <174188823430.14745.17591986001259957573.tip-bot2@tip-bot2> <20250317101415.GBZ9f198PAh90nMWDf@fat_crate.local> <CAFULd4b-sZucEtvx19==5wcOfOCzj5fuZ2SHS7ZMboZQXdVycg@mail.gmail.com> <20250317104616.GCZ9f9eF-0n0qPbWwk@fat_crate.local> <CAFULd4b_a=3xs2b_88WaDR9hLuhMqNZiMu+kNAbrgJf2MoVNnQ@mail.gmail.com>
Message-ID: <1886668D-E44A-4510-B31E-933545FA2C23@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 17, 2025 4:06:11 AM PDT, Uros Bizjak <ubizjak@gmail=2Ecom> wrote:
>On Mon, Mar 17, 2025 at 11:46=E2=80=AFAM Borislav Petkov <bp@alien8=2Ede>=
 wrote:
>>
>> On Mon, Mar 17, 2025 at 11:28:58AM +0100, Uros Bizjak wrote:
>> > > > @@ -114,10 +113,10 @@ static inline int update_pkru_in_sigframe(s=
truct xregs_state __user *buf, u64 ma
>> > > >  #define XSTATE_OP(op, st, lmask, hmask, err)                    =
     \
>> > > >       asm volatile("1:" op "\n\t"                                =
     \
>> > > >                    "xor %[err], %[err]\n"                        =
     \
>> > > > -                  "2:\n\t"                                      =
     \
>> > > > +                  "2:\n"                                        =
     \
>> > > >                    _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SA=
FE)  \
>> > > >                    : [err] "=3Da" (err)                          =
       \
>> > > > -                  : "D" (st), "m" (*st), "a" (lmask), "d" (hmask=
)    \
>> > > > +                  : [xa] "m" (*(st)), "a" (lmask), "d" (hmask)  =
     \
>> > >
>> > > This [xa] needs documenting in the comment above this=2E
>> > >
>> > > What does "xa" even mean?
>> >
>> > xsave area=2E
>>
>> That's struct xregs_state in kernel nomenclature=2E
>>
>> And the macro's argument is called "st"=2E
>>
>> And when it says [xa] there, one wonders where that "xa" comes from=2E =
So please
>> add a comment above the macro explaining that=2E
>
>This is an internal label for a named argument=2E The name shouldn't
>bother anybody, it could be anything, [xa], [ptr], [arg] or whatnot,
>so I see no reason why a comment should explain the choice=2E It's like
>arguing about the name of a variable=2E
>
>Uros=2E
>

Ok, I'm going to argue, but only because the argument is called "st" and t=
he assembly parameter "xa"=2E That's needlessly different and means having =
to look extra hard=20

We can obviously not use the same token, but IMO it would make a lot more =
sense to call one of them _st or perhaps st_p (being a pointer)=2E

