Return-Path: <linux-tip-commits+bounces-4045-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43054A5665C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 12:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D345171D97
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 11:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE458212D61;
	Fri,  7 Mar 2025 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="k7GhPtBi"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B4F20ADF8;
	Fri,  7 Mar 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346055; cv=none; b=esrcgz/AzDdIb1FZSA83VO6loCsHx3lpT5leYV3RIHimIt3T13X1LRztH+GENq7V2ofROsmnDsG572OZvUJzj07cPO/UFuRALfKuF9VQs3dpM0/UEIQQs4mKjZr/CpIWkkNaVplGwA1f7na2Sb6I5LKMSB90OBUXPGE7uCKjadA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346055; c=relaxed/simple;
	bh=Klkb0vtj1sM3oTPIpH/xSYTsoRjUsFuMFwvsxNanhZU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QTARfxX1h9NGqxxd1cyEHc2rFVN/9Zm+dDEBCm58W/dPqfpbRJ7WoHgh1CZgaMr6RQ4YC9fH9Bt00dUJvCkIEg2T8S1gwqHrh4P1sB5D9/Pi/O6Tj+2qDXCC9CQFx+O5oH+DoXfrDzFNEea/Y7muNPIcJSV5++DuceFAJnm9BoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=k7GhPtBi; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 527BDxLt191898
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Mar 2025 03:13:59 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 527BDxLt191898
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741346040;
	bh=3s+/bqEB2e2NCp19RKTF/Cq+N1C1HPXRqZ5qT8xuGJE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=k7GhPtBib9vwuZchKCk71nNsYd3krTOiYtvrA0yLljkCrgl6gBXYJsHVQzeGqVuBv
	 if/Zcs0aKYpNlSEMjSyZvXs0qF1Wtlwz1IAQbmOOpASX9I9H+ruOuUaXBdSws9ovpy
	 LwLhK7xq4O4rvr0XcMhZNs3cRk16P+X7Yk9Kqxa80NnkSId+b6JagFJE9R1i/RrhQz
	 e9TcSY15uX1T2mFJiQUX+kX58Gyopf0FTHHmXEmbyEgN3vxxes7iO+lKzHjyMTRxhB
	 zvZ0MW5SIh6Jynykx5J/snlr9o/BAo01vWAvkBMEhk6TD7Fp5gwv7rW+8Ocx6shjP+
	 vE+dy70IW2qlQ==
Date: Fri, 07 Mar 2025 03:13:55 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>
CC: linux-kernel@vger.kernel.org,
        tip-bot2 for Uros Bizjak <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/asm=5D_x86/kexec=3A_Merge_x86=5F32_a?=
 =?US-ASCII?Q?nd_x86=5F64_code_using_macros_from_=3Casm/asm=2Eh=3E?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFULd4b29XMoBoN9_0BCtuV2dgasO=WUu0re91Refjx68Q9O9A@mail.gmail.com>
References: <20250306145227.55819-1-ubizjak@gmail.com> <174129682336.14745.3287112422322924162.tip-bot2@tip-bot2> <36B61764-A297-459A-AD55-ACC54C409876@zytor.com> <CAFULd4b29XMoBoN9_0BCtuV2dgasO=WUu0re91Refjx68Q9O9A@mail.gmail.com>
Message-ID: <426BE71F-FAF6-4C68-944D-9F559FF42737@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 7, 2025 1:20:17 AM PST, Uros Bizjak <ubizjak@gmail=2Ecom> wrote:
>On Fri, Mar 7, 2025 at 4:00=E2=80=AFAM H=2E Peter Anvin <hpa@zytor=2Ecom>=
 wrote:
>>
>> On March 6, 2025 1:33:43 PM PST, tip-bot2 for Uros Bizjak <tip-bot2@lin=
utronix=2Ede> wrote:
>> >The following commit has been merged into the x86/asm branch of tip:
>> >
>> >Commit-ID:     aa3942d4d12ef57f031faa2772fe410c24191e36
>> >Gitweb:        https://git=2Ekernel=2Eorg/tip/aa3942d4d12ef57f031faa27=
72fe410c24191e36
>> >Author:        Uros Bizjak <ubizjak@gmail=2Ecom>
>> >AuthorDate:    Thu, 06 Mar 2025 15:52:11 +01:00
>> >Committer:     Ingo Molnar <mingo@kernel=2Eorg>
>> >CommitterDate: Thu, 06 Mar 2025 22:04:48 +01:00
>> >
>> >x86/kexec: Merge x86_32 and x86_64 code using macros from <asm/asm=2Eh=
>
>> >
>> >Merge common x86_32 and x86_64 code in crash_setup_regs()
>> >using macros from <asm/asm=2Eh>=2E
>> >
>> >The compiled object files before and after the patch are unchanged=2E
>> >
>> >Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>> >Signed-off-by: Ingo Molnar <mingo@kernel=2Eorg>
>> >Cc: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>> >Cc: Baoquan He <bhe@redhat=2Ecom>
>> >Cc: Vivek Goyal <vgoyal@redhat=2Ecom>
>> >Cc: Dave Young <dyoung@redhat=2Ecom>
>> >Cc: Ard Biesheuvel <ardb@kernel=2Eorg>
>> >Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>> >Link: https://lore=2Ekernel=2Eorg/r/20250306145227=2E55819-1-ubizjak@g=
mail=2Ecom
>> >---
>> > arch/x86/include/asm/kexec=2Eh | 58 +++++++++++++++------------------=
--
>> > 1 file changed, 25 insertions(+), 33 deletions(-)
>> >
>> >diff --git a/arch/x86/include/asm/kexec=2Eh b/arch/x86/include/asm/kex=
ec=2Eh
>> >index 8ad1874=2E=2Ee3589d6 100644
>> >--- a/arch/x86/include/asm/kexec=2Eh
>> >+++ b/arch/x86/include/asm/kexec=2Eh
>> >@@ -18,6 +18,7 @@
>> > #include <linux/string=2Eh>
>> > #include <linux/kernel=2Eh>
>> >
>> >+#include <asm/asm=2Eh>
>> > #include <asm/page=2Eh>
>> > #include <asm/ptrace=2Eh>
>> >
>> >@@ -71,41 +72,32 @@ static inline void crash_setup_regs(struct pt_regs=
 *newregs,
>> >       if (oldregs) {
>> >               memcpy(newregs, oldregs, sizeof(*newregs));
>> >       } else {
>> >+              asm volatile("mov %%" _ASM_BX ",%0" : "=3Dm"(newregs->b=
x));
>> >+              asm volatile("mov %%" _ASM_CX ",%0" : "=3Dm"(newregs->c=
x));
>> >+              asm volatile("mov %%" _ASM_DX ",%0" : "=3Dm"(newregs->d=
x));
>> >+              asm volatile("mov %%" _ASM_SI ",%0" : "=3Dm"(newregs->s=
i));
>> >+              asm volatile("mov %%" _ASM_DI ",%0" : "=3Dm"(newregs->d=
i));
>> >+              asm volatile("mov %%" _ASM_BP ",%0" : "=3Dm"(newregs->b=
p));
>> >+              asm volatile("mov %%" _ASM_AX ",%0" : "=3Dm"(newregs->a=
x));
>> >+              asm volatile("mov %%" _ASM_SP ",%0" : "=3Dm"(newregs->s=
p));
>> >+#ifdef CONFIG_X86_64
>> >+              asm volatile("mov %%r8,%0" : "=3Dm"(newregs->r8));
>> >+              asm volatile("mov %%r9,%0" : "=3Dm"(newregs->r9));
>> >+              asm volatile("mov %%r10,%0" : "=3Dm"(newregs->r10));
>> >+              asm volatile("mov %%r11,%0" : "=3Dm"(newregs->r11));
>> >+              asm volatile("mov %%r12,%0" : "=3Dm"(newregs->r12));
>> >+              asm volatile("mov %%r13,%0" : "=3Dm"(newregs->r13));
>> >+              asm volatile("mov %%r14,%0" : "=3Dm"(newregs->r14));
>> >+              asm volatile("mov %%r15,%0" : "=3Dm"(newregs->r15));
>> >+#endif
>> >+              asm volatile("mov %%ss,%k0" : "=3Da"(newregs->ss));
>> >+              asm volatile("mov %%cs,%k0" : "=3Da"(newregs->cs));
>> > #ifdef CONFIG_X86_32
>> >-              asm volatile("movl %%ebx,%0" : "=3Dm"(newregs->bx));
>> >-              asm volatile("movl %%ecx,%0" : "=3Dm"(newregs->cx));
>> >-              asm volatile("movl %%edx,%0" : "=3Dm"(newregs->dx));
>> >-              asm volatile("movl %%esi,%0" : "=3Dm"(newregs->si));
>> >-              asm volatile("movl %%edi,%0" : "=3Dm"(newregs->di));
>> >-              asm volatile("movl %%ebp,%0" : "=3Dm"(newregs->bp));
>> >-              asm volatile("movl %%eax,%0" : "=3Dm"(newregs->ax));
>> >-              asm volatile("movl %%esp,%0" : "=3Dm"(newregs->sp));
>> >-              asm volatile("movl %%ss, %%eax;" :"=3Da"(newregs->ss));
>> >-              asm volatile("movl %%cs, %%eax;" :"=3Da"(newregs->cs));
>> >-              asm volatile("movl %%ds, %%eax;" :"=3Da"(newregs->ds));
>> >-              asm volatile("movl %%es, %%eax;" :"=3Da"(newregs->es));
>> >-              asm volatile("pushfl; popl %0" :"=3Dm"(newregs->flags))=
;
>> >-#else
>> >-              asm volatile("movq %%rbx,%0" : "=3Dm"(newregs->bx));
>> >-              asm volatile("movq %%rcx,%0" : "=3Dm"(newregs->cx));
>> >-              asm volatile("movq %%rdx,%0" : "=3Dm"(newregs->dx));
>> >-              asm volatile("movq %%rsi,%0" : "=3Dm"(newregs->si));
>> >-              asm volatile("movq %%rdi,%0" : "=3Dm"(newregs->di));
>> >-              asm volatile("movq %%rbp,%0" : "=3Dm"(newregs->bp));
>> >-              asm volatile("movq %%rax,%0" : "=3Dm"(newregs->ax));
>> >-              asm volatile("movq %%rsp,%0" : "=3Dm"(newregs->sp));
>> >-              asm volatile("movq %%r8,%0" : "=3Dm"(newregs->r8));
>> >-              asm volatile("movq %%r9,%0" : "=3Dm"(newregs->r9));
>> >-              asm volatile("movq %%r10,%0" : "=3Dm"(newregs->r10));
>> >-              asm volatile("movq %%r11,%0" : "=3Dm"(newregs->r11));
>> >-              asm volatile("movq %%r12,%0" : "=3Dm"(newregs->r12));
>> >-              asm volatile("movq %%r13,%0" : "=3Dm"(newregs->r13));
>> >-              asm volatile("movq %%r14,%0" : "=3Dm"(newregs->r14));
>> >-              asm volatile("movq %%r15,%0" : "=3Dm"(newregs->r15));
>> >-              asm volatile("movl %%ss, %%eax;" :"=3Da"(newregs->ss));
>> >-              asm volatile("movl %%cs, %%eax;" :"=3Da"(newregs->cs));
>> >-              asm volatile("pushfq; popq %0" :"=3Dm"(newregs->flags))=
;
>> >+              asm volatile("mov %%ds,%k0" : "=3Da"(newregs->ds));
>> >+              asm volatile("mov %%es,%k0" : "=3Da"(newregs->es));
>> > #endif
>> >+              asm volatile("pushf\n\t"
>> >+                           "pop %0" : "=3Dm"(newregs->flags));
>> >               newregs->ip =3D _THIS_IP_;
>> >       }
>> > }
>>
>> Incidentally, doing this in C code is obviously completely broken, espe=
cially doing it in multiple statements=2E You have no idea what the compile=
r has messed with before you get there=2E
>
>These are "asm volatile" statemets, so at least they won't be
>scheduled in a different way=2E OTOH, please note that the patch is very
>carefully written to not change code flow, usage of hardregs in the
>inline asm is usually the sign of fragile code=2E
>
>Uros=2E
>

That doesn't matter, though; that only means they can't be moved relativel=
y to each other, but the compiler is perfectly capable of inserting code be=
fore, or in between=2E=20

Your patch might be a functional null, but the code is broken on a deep an=
d fundamental basis=2E

