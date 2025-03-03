Return-Path: <linux-tip-commits+bounces-3835-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA121A4CE4F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 23:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E198917404E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 22:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C328232379;
	Mon,  3 Mar 2025 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="e7eFvsEO"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267D8215058;
	Mon,  3 Mar 2025 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041139; cv=none; b=YShDc98AapWHNfsP/sqeJMw6T2lbQ/3Lo2GREAICMEqqTgRm0HfHSl4VfKqXmC100znHuvI6dHviRJJOOQ/34ptlhvsp+CP0oCw+HblsDmemHqzbgtj7kzdSrSvVBEjaFWbtGpbcuzfR53ghPpy8uoH88rWcDJ1LDHQjmkjFy14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041139; c=relaxed/simple;
	bh=pb1s+9OYVPB6sc2/2o17aL4a3XOc0VX9RjEiNSpL+xg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Hl3Nh286DyajnlS4iv4TCGMmRsjjjmwxgdMDMPGKxucKybprTQvkousKVveDPNyW38W3WbGOIaR09SvtrySluJdzHCDuiiF0uLXVck8OhTUwr27gP4k6OOk2hm3kngHwUeJfat+L8yT8WeUChEPba9NJVG7ebHjG2y6udTlLJng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=e7eFvsEO; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPv6:::1] ([172.59.160.22])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 523MVuQt1780740
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 3 Mar 2025 14:31:58 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 523MVuQt1780740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741041119;
	bh=bWeBICZ90Qg1XSFb/a1DDKl3aM977PtC32QKPZgjedA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=e7eFvsEOBDxbNpNPdl71VcvG7YHrjyCPYUsLSCv9CU56IZ0YyP01I3DUx7sF2gpSY
	 39dsNkW0urqnXh4mUHkLvbXToWUS5MFfVVlyQjGy7rrVIvPZW/8P0Q8lI2+2O0Q7I/
	 pA20KVMh9BfJMbcX5lAsVMMJlbzUWnakahN1h4eh/J4IzZinC4zIybW1w/N7jF2dBl
	 84Nz5+uTpOmzW3mnLh3HRxzF1FLg7Mos4V6O/g6VHJe8g254H5NTa6fGrEY7qMIrli
	 L/vAdXrsq5IDzBjC4WrQN12wP1RbQO7UdetnAoTASar2qjNh/2geOW2xGmUB1xqAia
	 Mvf56SYjZOFeg==
Date: Mon, 03 Mar 2025 14:31:50 -0800
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
In-Reply-To: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
Message-ID: <C77024F6-3087-40A3-8AFB-A642EECAFF4E@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 3, 2025 3:02:41 AM PST, tip-bot2 for Josh Poimboeuf <tip-bot2@linu=
tronix=2Ede> wrote:
>The following commit has been merged into the x86/asm branch of tip:
>
>Commit-ID:     e5ff90b179d45df71373cf79f99d20c9abe229cb
>Gitweb:        https://git=2Ekernel=2Eorg/tip/e5ff90b179d45df71373cf79f99=
d20c9abe229cb
>Author:        Josh Poimboeuf <jpoimboe@kernel=2Eorg>
>AuthorDate:    Sun, 02 Mar 2025 17:21:03 -08:00
>Committer:     Ingo Molnar <mingo@kernel=2Eorg>
>CommitterDate: Mon, 03 Mar 2025 11:39:54 +01:00
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

Wait, why was this changed? I actually tested this form at least once and =
found that it didn't work under all circumstances=2E=2E=2E

