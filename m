Return-Path: <linux-tip-commits+bounces-4040-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51152A55DF6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 04:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3AB3B27BC
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 03:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BA054673;
	Fri,  7 Mar 2025 03:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qEMb/0vq"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62D51F94C;
	Fri,  7 Mar 2025 03:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741316470; cv=none; b=nxm2R5BOWN/+LXbZ2MUckTileZFV7t5ij3l4wPoqDbH+4MZfatp4LX+Zfbt2BV9vL+cCF5xmePp7VUPMhnPV0bXyq9k5E0X8HRFpGwM/pGhlOV5cVXuGhEKCDyio3jDlcQ9eBosUoQo374IdnBG6Ne+KQN53pAq3uiDW16a7moI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741316470; c=relaxed/simple;
	bh=Ce+92LM+uM4YqylDZSx7GYV7EDCMsE46HHc8u/9jI8k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=EkYfItq6V0uguCI9H25nS/TzomE55Qt78uJJJ57/Ain+KpjBY6d3aIDfsLDn4eI3hjRXh0PKs3496FeM050wubvZo8OVoULGa4YMFZjDCv6FNsA4CmpFmRXbDQ+0AhLf/f9Q8QZnD2ulKrH2gYlhdZb2gB17RSW9I7u0fhnia40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=qEMb/0vq; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52730beo023818
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 6 Mar 2025 19:00:37 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52730beo023818
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741316438;
	bh=Z55d4SeZwwI/wUtJOp92wkIpa/kadSMCflhcc0ibZ4k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=qEMb/0vqMjeKOkB2AUT2CZCp2TbxNZhEPUcO0EbXj+rqLOuI2KZnicviOYxiNz2MU
	 3h1kzQ2BPcdt8jhOKYx0tFRhr3r35duWQDs21MkZvb1AbC2f6vfIWD7wL/DpyMCgJT
	 3MuNXbCzzJ90S6gBQEFEgsnZqRwvMH5zihrF1CzNM4nZ92kDu033wHWMytiRI67DnK
	 diZEzo50jOCEPVR4EyvoxLwmyHUNhsEITdMAoCGbT2CSOhbrjGgL3tlKx43AGmP7kk
	 PXKDARPObino/LK4nr7uOrwOTnPbig623lP+MVndmHVng8C8IFnL9Rs1FTnzUZ1nvs
	 nC4Zw+PrMt0dA==
Date: Thu, 06 Mar 2025 19:00:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org,
        tip-bot2 for Uros Bizjak <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org
CC: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/asm=5D_x86/kexec=3A_Merge_x86=5F32_a?=
 =?US-ASCII?Q?nd_x86=5F64_code_using_macros_from_=3Casm/asm=2Eh=3E?=
User-Agent: K-9 Mail for Android
In-Reply-To: <174129682336.14745.3287112422322924162.tip-bot2@tip-bot2>
References: <20250306145227.55819-1-ubizjak@gmail.com> <174129682336.14745.3287112422322924162.tip-bot2@tip-bot2>
Message-ID: <36B61764-A297-459A-AD55-ACC54C409876@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 6, 2025 1:33:43 PM PST, tip-bot2 for Uros Bizjak <tip-bot2@linutro=
nix=2Ede> wrote:
>The following commit has been merged into the x86/asm branch of tip:
>
>Commit-ID:     aa3942d4d12ef57f031faa2772fe410c24191e36
>Gitweb:        https://git=2Ekernel=2Eorg/tip/aa3942d4d12ef57f031faa2772f=
e410c24191e36
>Author:        Uros Bizjak <ubizjak@gmail=2Ecom>
>AuthorDate:    Thu, 06 Mar 2025 15:52:11 +01:00
>Committer:     Ingo Molnar <mingo@kernel=2Eorg>
>CommitterDate: Thu, 06 Mar 2025 22:04:48 +01:00
>
>x86/kexec: Merge x86_32 and x86_64 code using macros from <asm/asm=2Eh>
>
>Merge common x86_32 and x86_64 code in crash_setup_regs()
>using macros from <asm/asm=2Eh>=2E
>
>The compiled object files before and after the patch are unchanged=2E
>
>Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>Signed-off-by: Ingo Molnar <mingo@kernel=2Eorg>
>Cc: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>Cc: Baoquan He <bhe@redhat=2Ecom>
>Cc: Vivek Goyal <vgoyal@redhat=2Ecom>
>Cc: Dave Young <dyoung@redhat=2Ecom>
>Cc: Ard Biesheuvel <ardb@kernel=2Eorg>
>Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>Link: https://lore=2Ekernel=2Eorg/r/20250306145227=2E55819-1-ubizjak@gmai=
l=2Ecom
>---
> arch/x86/include/asm/kexec=2Eh | 58 +++++++++++++++--------------------
> 1 file changed, 25 insertions(+), 33 deletions(-)
>
>diff --git a/arch/x86/include/asm/kexec=2Eh b/arch/x86/include/asm/kexec=
=2Eh
>index 8ad1874=2E=2Ee3589d6 100644
>--- a/arch/x86/include/asm/kexec=2Eh
>+++ b/arch/x86/include/asm/kexec=2Eh
>@@ -18,6 +18,7 @@
> #include <linux/string=2Eh>
> #include <linux/kernel=2Eh>
>=20
>+#include <asm/asm=2Eh>
> #include <asm/page=2Eh>
> #include <asm/ptrace=2Eh>
>=20
>@@ -71,41 +72,32 @@ static inline void crash_setup_regs(struct pt_regs *n=
ewregs,
> 	if (oldregs) {
> 		memcpy(newregs, oldregs, sizeof(*newregs));
> 	} else {
>+		asm volatile("mov %%" _ASM_BX ",%0" : "=3Dm"(newregs->bx));
>+		asm volatile("mov %%" _ASM_CX ",%0" : "=3Dm"(newregs->cx));
>+		asm volatile("mov %%" _ASM_DX ",%0" : "=3Dm"(newregs->dx));
>+		asm volatile("mov %%" _ASM_SI ",%0" : "=3Dm"(newregs->si));
>+		asm volatile("mov %%" _ASM_DI ",%0" : "=3Dm"(newregs->di));
>+		asm volatile("mov %%" _ASM_BP ",%0" : "=3Dm"(newregs->bp));
>+		asm volatile("mov %%" _ASM_AX ",%0" : "=3Dm"(newregs->ax));
>+		asm volatile("mov %%" _ASM_SP ",%0" : "=3Dm"(newregs->sp));
>+#ifdef CONFIG_X86_64
>+		asm volatile("mov %%r8,%0" : "=3Dm"(newregs->r8));
>+		asm volatile("mov %%r9,%0" : "=3Dm"(newregs->r9));
>+		asm volatile("mov %%r10,%0" : "=3Dm"(newregs->r10));
>+		asm volatile("mov %%r11,%0" : "=3Dm"(newregs->r11));
>+		asm volatile("mov %%r12,%0" : "=3Dm"(newregs->r12));
>+		asm volatile("mov %%r13,%0" : "=3Dm"(newregs->r13));
>+		asm volatile("mov %%r14,%0" : "=3Dm"(newregs->r14));
>+		asm volatile("mov %%r15,%0" : "=3Dm"(newregs->r15));
>+#endif
>+		asm volatile("mov %%ss,%k0" : "=3Da"(newregs->ss));
>+		asm volatile("mov %%cs,%k0" : "=3Da"(newregs->cs));
> #ifdef CONFIG_X86_32
>-		asm volatile("movl %%ebx,%0" : "=3Dm"(newregs->bx));
>-		asm volatile("movl %%ecx,%0" : "=3Dm"(newregs->cx));
>-		asm volatile("movl %%edx,%0" : "=3Dm"(newregs->dx));
>-		asm volatile("movl %%esi,%0" : "=3Dm"(newregs->si));
>-		asm volatile("movl %%edi,%0" : "=3Dm"(newregs->di));
>-		asm volatile("movl %%ebp,%0" : "=3Dm"(newregs->bp));
>-		asm volatile("movl %%eax,%0" : "=3Dm"(newregs->ax));
>-		asm volatile("movl %%esp,%0" : "=3Dm"(newregs->sp));
>-		asm volatile("movl %%ss, %%eax;" :"=3Da"(newregs->ss));
>-		asm volatile("movl %%cs, %%eax;" :"=3Da"(newregs->cs));
>-		asm volatile("movl %%ds, %%eax;" :"=3Da"(newregs->ds));
>-		asm volatile("movl %%es, %%eax;" :"=3Da"(newregs->es));
>-		asm volatile("pushfl; popl %0" :"=3Dm"(newregs->flags));
>-#else
>-		asm volatile("movq %%rbx,%0" : "=3Dm"(newregs->bx));
>-		asm volatile("movq %%rcx,%0" : "=3Dm"(newregs->cx));
>-		asm volatile("movq %%rdx,%0" : "=3Dm"(newregs->dx));
>-		asm volatile("movq %%rsi,%0" : "=3Dm"(newregs->si));
>-		asm volatile("movq %%rdi,%0" : "=3Dm"(newregs->di));
>-		asm volatile("movq %%rbp,%0" : "=3Dm"(newregs->bp));
>-		asm volatile("movq %%rax,%0" : "=3Dm"(newregs->ax));
>-		asm volatile("movq %%rsp,%0" : "=3Dm"(newregs->sp));
>-		asm volatile("movq %%r8,%0" : "=3Dm"(newregs->r8));
>-		asm volatile("movq %%r9,%0" : "=3Dm"(newregs->r9));
>-		asm volatile("movq %%r10,%0" : "=3Dm"(newregs->r10));
>-		asm volatile("movq %%r11,%0" : "=3Dm"(newregs->r11));
>-		asm volatile("movq %%r12,%0" : "=3Dm"(newregs->r12));
>-		asm volatile("movq %%r13,%0" : "=3Dm"(newregs->r13));
>-		asm volatile("movq %%r14,%0" : "=3Dm"(newregs->r14));
>-		asm volatile("movq %%r15,%0" : "=3Dm"(newregs->r15));
>-		asm volatile("movl %%ss, %%eax;" :"=3Da"(newregs->ss));
>-		asm volatile("movl %%cs, %%eax;" :"=3Da"(newregs->cs));
>-		asm volatile("pushfq; popq %0" :"=3Dm"(newregs->flags));
>+		asm volatile("mov %%ds,%k0" : "=3Da"(newregs->ds));
>+		asm volatile("mov %%es,%k0" : "=3Da"(newregs->es));
> #endif
>+		asm volatile("pushf\n\t"
>+			     "pop %0" : "=3Dm"(newregs->flags));
> 		newregs->ip =3D _THIS_IP_;
> 	}
> }

Incidentally, doing this in C code is obviously completely broken, especia=
lly doing it in multiple statements=2E You have no idea what the compiler h=
as messed with before you get there=2E

