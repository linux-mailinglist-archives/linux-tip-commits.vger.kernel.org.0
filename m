Return-Path: <linux-tip-commits+bounces-4052-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C355A574A0
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 23:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 991C37A6B58
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 22:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4890D25A2A7;
	Fri,  7 Mar 2025 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="u7tHnnC5"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF95208973;
	Fri,  7 Mar 2025 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385066; cv=none; b=YJxW0SUbXyBvr2hFmta6g+AlDvjFoNYzNXP3/7RfsmFxSMXRZxCAyOWamhQn6oOM+CwYP2Ui3rjilKlvKYlA2Pm3jl0ONGRNfBMS0gLz7lFvnfout+tX9vQLaOZoeiRGTOT3BwwoUlUmEE2YOj3Pl678IAmBOf4ZZDeaGxgzL9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385066; c=relaxed/simple;
	bh=UnCLBxDmaqUfb6z9OONJeWG56N0sDqbKeQXKsxxGvjw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=R7izOHobFfrgsZL+Q8xSRS2lRg1SO7lhYoxgEpIeFYJ83UgsrNUsE+RnJAEhoVSYgXTZX6i5lZPRPmI1GOCfkxobJDiOHzYaHhPlyzlLcgV32WY745PtuGUnHwW4A8yO21zeA1P0FfTLxe+YNYYo4I4ILYIh+w/TZFGx5xX3nog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=u7tHnnC5; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 527M4DMm454517
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Mar 2025 14:04:13 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 527M4DMm454517
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741385054;
	bh=UJbdZO4NXWE6XGj+XSl8E0fP10MWbuXN/k4XZtGRd9E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=u7tHnnC5oRK5X5oA6CGk0yJMmI9Au4UA9t5hSpEuGibfx0iFtOqA6VHKhbrksnyqW
	 8PifKKzmZ8CFnDQ+4IBmQ7mGHDfNs3KarLdHQIR0xTY+cn7lKV/ZGH71NNZM3URkBF
	 1axXAdWPDd0eV/0W8bT5zaQPMgpi1HlIhXCWtZ2NEGv2ZS6E739gZ+QcqQVTRyLhxq
	 ukvRvDLMgJz1vWvakBd8pH5s7Xs7MWOVo3v0iKI7ayx9otXb76zU86Ad4jrTwfQrlm
	 9hb/Cn6XvKSNx0ZP2Npq+skZZkn6Ku+1/gCn/4Kx4ol+7R0haQ0jq63qOjdk4JPdyT
	 XDxPBx0vrlkSQ==
Date: Fri, 07 Mar 2025 14:04:10 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org,
        tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org
CC: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Gerst <brgerst@gmail.com>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/asm=5D_x86/asm=3A_Make_ASM=5FCALL?=
 =?US-ASCII?Q?=5FCONSTRAINT_conditional_on_frame_pointers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <174108458405.14745.4864877018394987266.tip-bot2@tip-bot2>
References: <174108458405.14745.4864877018394987266.tip-bot2@tip-bot2>
Message-ID: <90B1074B-E7D4-4CE0-8A82-ADEB7BAED7AD@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 4, 2025 2:36:24 AM PST, tip-bot2 for Josh Poimboeuf <tip-bot2@linu=
tronix=2Ede> wrote:
>The following commit has been merged into the x86/asm branch of tip:
>
>Commit-ID:     05844663b4fcf22bb3a1494615ae3f25852c9abc
>Gitweb:        https://git=2Ekernel=2Eorg/tip/05844663b4fcf22bb3a1494615a=
e3f25852c9abc
>Author:        Josh Poimboeuf <jpoimboe@kernel=2Eorg>
>AuthorDate:    Sun, 02 Mar 2025 17:21:03 -08:00
>Committer:     Ingo Molnar <mingo@kernel=2Eorg>
>CommitterDate: Tue, 04 Mar 2025 11:21:40 +01:00
>
>x86/asm: Make ASM_CALL_CONSTRAINT conditional on frame pointers
>
>With frame pointers enabled, ASM_CALL_CONSTRAINT is used in an inline
>asm statement with a call instruction to force the compiler to set up
>the frame pointer before doing the call=2E
>
>Without frame pointers, no such constraint is needed=2E  Make it
>conditional on frame pointers=2E
>
>Signed-off-by: Josh Poimboeuf <jpoimboe@kernel=2Eorg>
>Signed-off-by: Ingo Molnar <mingo@kernel=2Eorg>
>Acked-by: Peter Zijlstra (Intel) <peterz@infradead=2Eorg>
>Cc: Linus Torvalds <torvalds@linux-foundation=2Eorg>
>Cc: Brian Gerst <brgerst@gmail=2Ecom>
>Cc: H=2E Peter Anvin <hpa@zytor=2Ecom>
>Cc: linux-kernel@vger=2Ekernel=2Eorg
>---
> arch/x86/include/asm/asm=2Eh | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/arch/x86/include/asm/asm=2Eh b/arch/x86/include/asm/asm=2Eh
>index 0d268e6=2E=2Ef1db9e8 100644
>--- a/arch/x86/include/asm/asm=2Eh
>+++ b/arch/x86/include/asm/asm=2Eh
>@@ -232,7 +232,11 @@ register unsigned long current_stack_pointer asm(_AS=
M_SP);
>  * gets set up by the containing function=2E  If you forget to do this, =
objtool
>  * may print a "call without frame pointer save/setup" warning=2E
>  */
>+#ifdef CONFIG_UNWINDER_FRAME_POINTER
> #define ASM_CALL_CONSTRAINT "r" (__builtin_frame_address(0))
>+#else
>+#define ASM_CALL_CONSTRAINT
>+#endif
>=20
> #endif /* __ASSEMBLY__ */
>=20

So we are going to be using this version despite the gcc maintainers telli=
ng us it is not supported?

