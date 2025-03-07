Return-Path: <linux-tip-commits+bounces-4059-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76002A5760C
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 00:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0748179524
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 23:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F22525D20B;
	Fri,  7 Mar 2025 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CvZFoMLY"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E57258CF7;
	Fri,  7 Mar 2025 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390159; cv=none; b=SaqHCc2GvBH1JBdXMD72AEKYc/gTZ2BIxDL+wx2qsQZlN4N7yOQcvIILqSQ/eCyRoLswEbHVOkkM7FRWyeZ5TtLS6qTF/H5UPHugacjxysb2hrwu/o84Vu4u5N8oaBlMyAL6EglLNsZBJ7r+Yjdy/t7uPTAKm0Wb9rXEDDfBsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390159; c=relaxed/simple;
	bh=Slall6SVSyYYujJBGzpuLGkq8QwY+nJRaF0FV5Ktvqo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YoeD8Q6SNeqd4VJpp+b19OuwgcZkOnzX5PCs59qH/IUsExYlzjjyybS9QdaxPz8cepO3B6MD7Cy97emjabVs5Yi3z0ZRSdrUuFwz1ydys72ldwgKxmY6pqubjFYLURwhNM9Aj6DtP77ciSR7g38WXJ/wTrzOb1dJzUkS32x6wtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=CvZFoMLY; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 527NT3V0486096
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Mar 2025 15:29:04 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 527NT3V0486096
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741390144;
	bh=Slall6SVSyYYujJBGzpuLGkq8QwY+nJRaF0FV5Ktvqo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CvZFoMLY7RovTGG8TdpJlanme1cMcpP7psm6w0uPMIzwkkXGvBCStFeIL7AANlmE1
	 6L95Z+DdiP/LioKU6SYr08AJN53F1oFcx6Ts6tY9GApWkcyD+OuRb7CGWl6tvfzLKs
	 Tcrl/DkXhmrYbTtbuz7vICDwAwVGMDF1CAayh4C7+Eax4cJKKPCwCd/ce2q5f1/Prt
	 7E3zgw5Jvw0yuA+McSqxeJvyoqM+WbCDXH//y8DCGt8sSuhuqFeRltq8RwgGcnSgeE
	 AKC843gNmFgcJssTrt1WTljFYkMbLV/htdpAj1OxNQ1IUhfqF/2ahr3ctyK42n79F9
	 hbBCUlGqpvLiw==
Date: Fri, 07 Mar 2025 15:29:00 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>
CC: linux-kernel@vger.kernel.org,
        tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Gerst <brgerst@gmail.com>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/asm=5D_x86/asm=3A_Make_ASM=5FCALL?=
 =?US-ASCII?Q?=5FCONSTRAINT_conditional_on_frame_pointers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250307232157.comm4lycebr7zmre@jpoimboe>
References: <174108458405.14745.4864877018394987266.tip-bot2@tip-bot2> <90B1074B-E7D4-4CE0-8A82-ADEB7BAED7AD@zytor.com> <Z8t7ubUE5P7woAr5@gmail.com> <20250307232157.comm4lycebr7zmre@jpoimboe>
Message-ID: <A669251B-7414-4EE7-B0AD-735E845C0B5B@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 7, 2025 3:21:57 PM PST, Josh Poimboeuf <jpoimboe@kernel=2Eorg> wro=
te:
>On Sat, Mar 08, 2025 at 12:05:29AM +0100, Ingo Molnar wrote:
>>=20
>> * H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>>=20
>> > > #endif /* __ASSEMBLY__ */
>> >=20
>> > So we are going to be using this version despite the gcc maintainers=
=20
>> > telling us it is not supported?
>>=20
>> No, neither patches are in the x86 tree at the moment=2E
>
>FWIW, the existing ASM_CALL_CONSTRAINT is also not supported, so this
>patch wouldn't have changed anything in that respect=2E
>
>Regardless I plan to post a new patch set soon with a bunch of cleanups=
=2E
>
>It will keep the existing ASM_CALL_CONSTRAINT in place for GCC, and will
>use the new __builtin_frame_address(0) input constraint for Clang only=2E
>
>There will be a new asm_call() interface to hide the mess=2E
>

Alternatively, you can co-opt the gcc BR I already filed on this and argue=
 there that there are new reasons to support the alternate construct=2E

