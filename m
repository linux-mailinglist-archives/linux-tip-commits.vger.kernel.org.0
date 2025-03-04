Return-Path: <linux-tip-commits+bounces-3998-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A8CA4EFE7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 23:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD187A6042
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 22:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974F21FFC5F;
	Tue,  4 Mar 2025 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Da45kpbt"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBB11FCF74;
	Tue,  4 Mar 2025 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126106; cv=none; b=ZCNK67IV+RzAPvweR7XvnebiJ8YErBraPbCFQMyJJsPNYpvD20fa0cxEbVynYgKWa9wM7AfqvRm8PJ2u+sL/p7qdOTmdODQO33Pjr1hn+FpSwwVFaDJtnLyZRuYsdpJ64H+zAufqzXJm/26CjIr1omdJoaxMH72LrkY17TsyEoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126106; c=relaxed/simple;
	bh=mmFAD33zFqcs61U7695dcai268+0b2YCvWmBwUiNz+A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=l0oSZKi6pV9v9iBN01luBTirwvYEwO039sVzVdoBtrL/JWks9/ib7P0GmXlX6jCbiTX+UKU+cDrM1p+EMKxvUDCAJLd830sMPHi8HiMBVTDOifDUT9kFA+5OW1FBz7rfPjMPWN5QD9GrkxHZ2PXGi1GbS0Mqi+RWgmxN+Bx7aes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Da45kpbt; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 524M87c12625389
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 4 Mar 2025 14:08:07 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 524M87c12625389
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741126088;
	bh=+CNk/9dqeBwPXbHv5NuGd3RQVrL9dhGnuaXV57QAm8M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Da45kpbtvxNpLv9yPLzmBClxDLcxKRHCqIEmsyq4bRSxPNvOMCdNHmLHj6el5v371
	 XrQPGZPi5VzmFAfaEkJPMa31OBsfr+x7z6r3U//KDkrCbhTe7tdEiF6Rdu6DpePQrQ
	 LWFcFTj7/X893YIKizrgq+bCdJPQgexfDUt54f3PT6wCeQkhmoJrrbu6c9Bi7ztGJg
	 FWU25OwF8j7NDaZUkgoegB0BbhZIwcA8c+pMJx43vJMh++bGUUkmw/YzDJAnXio2YT
	 S2nCK5vxE4lm7GesXS1MnVuwk+yObUlocrxs91Az1j8pRK04L99aSHkhmVgsWo9T2x
	 WKD/YSFEklG1w==
Date: Tue, 04 Mar 2025 14:08:05 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>
CC: linux-kernel@vger.kernel.org,
        tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Gerst <brgerst@gmail.com>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/asm=5D_x86/asm=3A_Make_ASM=5FCALL?=
 =?US-ASCII?Q?=5FCONSTRAINT_conditional_on_frame_pointers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aebc3572-43a9-984b-1c47-1f06b17b2972@gmail.com>
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2> <C77024F6-3087-40A3-8AFB-A642EECAFF4E@zytor.com> <20250303224548.pghzo2j4hdww7nxt@jpoimboe> <20250303224758.2ugmmy7f7zsqti4m@jpoimboe> <28D821BB-96B5-4389-839E-5B7CB4D49F5F@zytor.com> <aebc3572-43a9-984b-1c47-1f06b17b2972@gmail.com>
Message-ID: <05C62769-A1DD-468C-9EF4-A7F78EC850AC@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 4, 2025 7:35:30 AM PST, Uros Bizjak <ubizjak@gmail=2Ecom> wrote:
>
>
>On 4=2E 03=2E 25 01:35, H=2E Peter Anvin wrote:
>> On March 3, 2025 2:47:58 PM PST, Josh Poimboeuf <jpoimboe@kernel=2Eorg>=
 wrote:
>>> On Mon, Mar 03, 2025 at 02:45:50PM -0800, Josh Poimboeuf wrote:
>>>> On Mon, Mar 03, 2025 at 02:31:50PM -0800, H=2E Peter Anvin wrote:
>>>>>> +#ifdef CONFIG_UNWINDER_FRAME_POINTER
>>>>>> #define ASM_CALL_CONSTRAINT "r" (__builtin_frame_address(0))
>>>>>> +#else
>>>>>> +#define ASM_CALL_CONSTRAINT
>>>>>> +#endif
>>>>>>=20
>>>>>> #endif /* __ASSEMBLY__ */
>>>>>>=20
>>>>>=20
>>>>> Wait, why was this changed? I actually tested this form at least onc=
e
>>>>> and found that it didn't work under all circumstances=2E=2E=2E
>>>>=20
>>>> Do you have any more details about where this didn't work?  I tested
>>>> with several configs and it seems to work fine=2E  Objtool will compl=
ain
>>>> if it doesn't work=2E
>>>>=20
>>>> See here for the justification (the previous version was producing cr=
ap
>>>> code in Clang):
>>>=20
>>> Gah, that link doesn't work because I forgot to cc lkml=2E
>>>=20
>>> Here's the tip bot link:
>>>=20
>>>   https://lore=2Ekernel=2Eorg/all/174099976253=2E10177=2E1254265789225=
6193630=2Etip-bot2@tip-bot2/
>>>=20
>>=20
>> One more thing: if we remove ASM_CALL_CONSTRAINTS, we will not be able =
to use the redzone in future FRED only kernel builds=2E
>
>Actually, GCC 15+ will introduce "redzone" clobber, so you will be able t=
o write e=2Eg=2E:
>
>void foo (void) { asm ("" : : : "cc", "memory", "redzone"); }
>
>Please see [1] and:
>
>+@item "redzone"
>+The @code{"redzone"} clobber tells the compiler that the assembly code
>+may write to the stack red zone, area below the stack pointer which on
>+some architectures in some calling conventions is guaranteed not to be
>+changed by signal handlers, interrupts or exceptions and so the compiler
>+can store there temporaries in leaf functions=2E  On targets which have
>+no concept of the stack red zone, the clobber is ignored=2E
>+It should be used e=2Eg=2E@: in case the assembly code uses call instruc=
tions
>+or pushes something to the stack without taking the red zone into accoun=
t
>+by subtracting red zone size from the stack pointer first and restoring
>+it afterwards=2E
>+
>
>[1] https://gcc=2Egnu=2Eorg/bugzilla/show_bug=2Ecgi?id=3D117312
>
>Uros=2E

Very nice :)

