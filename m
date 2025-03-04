Return-Path: <linux-tip-commits+bounces-3840-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9350A4D040
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 01:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A578A1897F73
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 00:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4199813AA38;
	Tue,  4 Mar 2025 00:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GfBdWpO2"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A213792B;
	Tue,  4 Mar 2025 00:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048522; cv=none; b=XU7z44dJrIFlTNnNgxufH6bLQ0GPogMWiYB8DTSV7nWs2QFPifQV0kG6ExsPxjEDD33uz5uv8iK6DjK7W0kMcwvKWDSB++Ts+XtH+rdzzlcRSnE+SH+uyyG9kvGQ7K1EjXklZEGiV7QziscBD5YYU3J3twdqpa9TpevFGLEg8a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048522; c=relaxed/simple;
	bh=7Ey8CyPnKm4QgzLgxk012/CXCaXqH4lHRbJYBpv6nR8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=DCcm9GDD0hCDg8IPVTwVtnX1i6YWjvmYxw3ZB+yX1dEM/BmmsdGMfV2HySH2N3jEYmEl3hJZjQTGucsHnFfkTLr2v+Yfu+qSghO2RAmiHMLjdu0H0gG4MEt4j+aSyC8JpOFIvfShXV0sEg5n0HB7tmiE27YlS2TqzuxCaDTjOh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=GfBdWpO2; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5240ZAfH1827316
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 3 Mar 2025 16:35:10 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5240ZAfH1827316
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741048511;
	bh=n9bzfqoBS2kS82+h22bmGORfUSlZ6dYuvMhCII7QADs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=GfBdWpO2HKh5X6+Cq3ORZa/VasK8E3PCSt8ATBTGBWX7tjLi51VU4x9sLuIzTXScK
	 HGRKLMBJbwizb3utvtqmygZ8FYl7Xqd/oUl1956ll9sU1ZUSqV/aFclJYMfphrRyYO
	 CQMACWyMrePh43jwgZojK8jaOgClo7X7gzBcAvNjcKoA4f2b9uwb/Lrpr3KcNZeD33
	 nfrl6LdCZp6boSLjucNOl1PKdF2XyW3L9ZdV9v+64jBdu4BaBdzkicbmcUdEvBvyiM
	 xLM0qjWOgt4OnEQAo3m8CID05mT1kEvgbGNvzIDSG/EQOIn9NyqweU+8Btb5nvx4jt
	 AKUH0vqHhNjig==
Date: Mon, 03 Mar 2025 16:35:10 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: linux-kernel@vger.kernel.org,
        tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Gerst <brgerst@gmail.com>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/asm=5D_x86/asm=3A_Make_ASM=5FCALL?=
 =?US-ASCII?Q?=5FCONSTRAINT_conditional_on_frame_pointers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250303224758.2ugmmy7f7zsqti4m@jpoimboe>
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2> <C77024F6-3087-40A3-8AFB-A642EECAFF4E@zytor.com> <20250303224548.pghzo2j4hdww7nxt@jpoimboe> <20250303224758.2ugmmy7f7zsqti4m@jpoimboe>
Message-ID: <28D821BB-96B5-4389-839E-5B7CB4D49F5F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 3, 2025 2:47:58 PM PST, Josh Poimboeuf <jpoimboe@kernel=2Eorg> wro=
te:
>On Mon, Mar 03, 2025 at 02:45:50PM -0800, Josh Poimboeuf wrote:
>> On Mon, Mar 03, 2025 at 02:31:50PM -0800, H=2E Peter Anvin wrote:
>> > >+#ifdef CONFIG_UNWINDER_FRAME_POINTER
>> > > #define ASM_CALL_CONSTRAINT "r" (__builtin_frame_address(0))
>> > >+#else
>> > >+#define ASM_CALL_CONSTRAINT
>> > >+#endif
>> > >=20
>> > > #endif /* __ASSEMBLY__ */
>> > >=20
>> >=20
>> > Wait, why was this changed? I actually tested this form at least once
>> > and found that it didn't work under all circumstances=2E=2E=2E
>>=20
>> Do you have any more details about where this didn't work?  I tested
>> with several configs and it seems to work fine=2E  Objtool will complai=
n
>> if it doesn't work=2E
>>=20
>> See here for the justification (the previous version was producing crap
>> code in Clang):
>
>Gah, that link doesn't work because I forgot to cc lkml=2E
>
>Here's the tip bot link:
>
>  https://lore=2Ekernel=2Eorg/all/174099976253=2E10177=2E1254265789225619=
3630=2Etip-bot2@tip-bot2/
>

One more thing: if we remove ASM_CALL_CONSTRAINTS, we will not be able to =
use the redzone in future FRED only kernel builds=2E

