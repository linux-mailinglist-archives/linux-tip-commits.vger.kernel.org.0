Return-Path: <linux-tip-commits+bounces-4294-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D01AA65D46
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 19:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5625188ECBE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF59119A288;
	Mon, 17 Mar 2025 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="oHxVLjkg"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C65D176ADB;
	Mon, 17 Mar 2025 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237421; cv=none; b=ArSIozUfMt8+nG4sflJ3i096pK9LtCemvZaCEF6px2dLKGcJaQ3mP+9/lSNX+hjXBPGHEsOoYo4xusmKb+jJTYx74zNbPBLWiF1R933VeiWHIrkCqEWeDKV/CtmkVYBcgXXGpsftJkbk8bxp8b+p/6lHpq45sMxupNYdKaL6Ky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237421; c=relaxed/simple;
	bh=BrCDkwh9DOlwvAN3HPEcrERSZ3qB1wiIBz+Eet8Feh8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JpjM1ys5J77qiF6VEv/zu2XTPwCLRFsGgkM8R/n5ref4EnP9/Ai3jWokdhy1kyLHMeLHseP4F44yA0JRlrZaxRsVlDLGgXQaMkCdlXUG8hYr5XLK1OpGXzbxe7fdWQEUEfkdWqI96O+yMwov7R/M7xZBwO0Boh5xfwGf1Oo1/a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=oHxVLjkg; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52HInuvH668508
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 17 Mar 2025 11:49:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52HInuvH668508
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742237397;
	bh=BrCDkwh9DOlwvAN3HPEcrERSZ3qB1wiIBz+Eet8Feh8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=oHxVLjkg1g2dFKgrcXgExFcRU7pcsArtDkre8wCtXGGVq6PUabP+u72GEKQVtNQBR
	 1FBo7XhaXvaI5AHJoZlh83mDXZPGt8kMmDkS3g5rlfcx4zAkziZcxDgXyJHpWP27nt
	 OeCeSSVjHPF1ZUjfefrzRXAjoLLsXaUJPiJsVat7WyzpLol6/iBp98H3RyKce9GHMX
	 vT4UkypTN6EGhxo36V4yFgDhcPcrUwog4dx+JbilH7G7h2vHTxdh1JuZDlbSrHHACJ
	 Wz8EGGHG29MDsNe4yMSEv79HM9EkA42dkVIov3tKCBIgBt1N+3UK7Klg6X0Vq1DbAz
	 L43NG6OLEHjUw==
Date: Mon, 17 Mar 2025 11:49:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>
CC: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/fpu=5D_x86/fpu=3A_Use_XSAVE=7B=2COPT?=
 =?US-ASCII?Q?=2CC=2CS=7D_and_XRSTOR=7B=2CS=7D_mnemonics_in_xstate=2Eh?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250317184839.GIZ9huh0WS7cOFXz0X@fat_crate.local>
References: <20250313130251.383204-1-ubizjak@gmail.com> <174188823430.14745.17591986001259957573.tip-bot2@tip-bot2> <20250317101415.GBZ9f198PAh90nMWDf@fat_crate.local> <CAFULd4b-sZucEtvx19==5wcOfOCzj5fuZ2SHS7ZMboZQXdVycg@mail.gmail.com> <20250317104616.GCZ9f9eF-0n0qPbWwk@fat_crate.local> <CAFULd4b_a=3xs2b_88WaDR9hLuhMqNZiMu+kNAbrgJf2MoVNnQ@mail.gmail.com> <1886668D-E44A-4510-B31E-933545FA2C23@zytor.com> <20250317184839.GIZ9huh0WS7cOFXz0X@fat_crate.local>
Message-ID: <05953E05-28D0-4640-9ECF-BDDB9521ECD3@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 17, 2025 11:48:39 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Mon, Mar 17, 2025 at 11:38:12AM -0700, H=2E Peter Anvin wrote:
>> Ok, I'm going to argue, but only because the argument is called "st" an=
d the
>> assembly parameter "xa"=2E That's needlessly different and means having=
 to
>> look extra hard=20
>>=20
>> We can obviously not use the same token, but IMO it would make a lot mo=
re
>> sense to call one of them _st or perhaps st_p (being a pointer)=2E
>
>Already documented:
>
>https://git=2Ekernel=2Eorg/tip/4348e9177813656d5d8bd18f34b3e611df004032
>
>Got tired of discussing the obvious=2E
>

Ok=2E

