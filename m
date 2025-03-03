Return-Path: <linux-tip-commits+bounces-3839-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93314A4CF89
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 00:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067923A1AA1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 23:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183201F3FEB;
	Mon,  3 Mar 2025 23:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VpnwrGJF"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69157F9E6;
	Mon,  3 Mar 2025 23:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046364; cv=none; b=TEd5Bk4K7SnvMPbetYn1PnrbUkF/6RJh9fFSe5DRoSQ7PaYEal3eQq3GNZNLLgbt1xxXxRtV0rhJw+p4r8frTf33bZE4q+VbP/I9Z9C1xmeAbAW2feYoYwClLPuPpvrBOF4mHP7CAqJGha4aWZbtsrAy1srI7FGjJ8It4kXfN5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046364; c=relaxed/simple;
	bh=vTqUhtHDls/JpslyJ0Wdnl9rOP1vPNz7j8ygSzOAhbQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fPCv+XXTsdPomzNSHzPGDrYXiePDK4JiQv3rGXgnu95IeqJPEFN/y/X1jLoavoZDMc9YKiikhKdsKVxI+PIM5oxVBa8sE58SqzsW8sZvfk+ex0uYacFcn9QPJ44dom7auuhxAKqEU5vIMPtHDRECncZQEpG6S4UTM6quIpwvSho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=VpnwrGJF; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 523NxCXD1810935
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 3 Mar 2025 15:59:12 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 523NxCXD1810935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741046352;
	bh=OkrtIdfx+ueEpceVI+REPBHK1JAGxo3tqPKoiN47StA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=VpnwrGJFerpDiyEBLWHVk1G5LQZ6XTzblnz/NzFrKlnBbPQM8eRWr7HojDxEdZ3dB
	 k3pboM7kqh68S3oVIDJqOyYMCK3EpB8HRC98sW5dw2PGj3dOhe8rrFHCopJWK7O7vL
	 RZ+k5qR5ejsa89M+z0IHuFzMAOiAKw1uA85ey6AD71XLqGjLt0RdrvbLj//vwldocK
	 nhB3mu5lDj7bzDFr5jk4yWVFNKCC52T+T2S7/N7VkAeyb6VUFqKaImBmbzFtoIIW2k
	 SYqhXkO+7UEghwb7sH4CQHqLeF2s9Nog7zVhELYcUhjuLviti4INsvQ7qt5Zq1YPCf
	 coMiIgBLjyfgA==
Date: Mon, 03 Mar 2025 15:59:12 -0800
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
In-Reply-To: <20250303224548.pghzo2j4hdww7nxt@jpoimboe>
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2> <C77024F6-3087-40A3-8AFB-A642EECAFF4E@zytor.com> <20250303224548.pghzo2j4hdww7nxt@jpoimboe>
Message-ID: <959B2AE8-109C-4EAD-A977-8EBAFD8A1075@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 3, 2025 2:45:48 PM PST, Josh Poimboeuf <jpoimboe@kernel=2Eorg> wro=
te:
>On Mon, Mar 03, 2025 at 02:31:50PM -0800, H=2E Peter Anvin wrote:
>> >+#ifdef CONFIG_UNWINDER_FRAME_POINTER
>> > #define ASM_CALL_CONSTRAINT "r" (__builtin_frame_address(0))
>> >+#else
>> >+#define ASM_CALL_CONSTRAINT
>> >+#endif
>> >=20
>> > #endif /* __ASSEMBLY__ */
>> >=20
>>=20
>> Wait, why was this changed? I actually tested this form at least once
>> and found that it didn't work under all circumstances=2E=2E=2E
>
>Do you have any more details about where this didn't work?  I tested
>with several configs and it seems to work fine=2E  Objtool will complain
>if it doesn't work=2E
>
>See here for the justification (the previous version was producing crap
>code in Clang):
>
>  https://lore=2Ekernel=2Eorg/dbea2ae2fb39bece21013f939ddeb15507baa7d3=2E=
1740964309=2Egit=2Ejpoimboe@kernel=2Eorg
>

I need to dig it up, but I had a discussion about this with some gcc peopl=
e about a year ago=2E

