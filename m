Return-Path: <linux-tip-commits+bounces-4044-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A12A5639A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 10:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66C03B5658
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 09:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE5520CCC2;
	Fri,  7 Mar 2025 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ajb6w2AS"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CEA20968E;
	Fri,  7 Mar 2025 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339223; cv=none; b=WZhwPgSKh7TieH9efwK0amd5m28fXnwTB2Lem/fnHMRa1NUK0ya8w0k1/gGFWZoX5Ps40kS+/O7c3cJmQjoEFjWoPtSLMqblUGaAlpUts4x4gaIl3vGo1thB7+I/1utFv2iFz6SiDHbvH/Mk/DQ4otFXFEQIFf8h0yvkZG+/eus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339223; c=relaxed/simple;
	bh=9/DjYnN9zqXerfNuhVK8b5x7ZDMPC9BjRHtPhecmp7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EH4X/R6oy/casBnI4a/JF5b5aK4ceU1OkBzmGC58u8ycsfNKXoKDDH1+088SMvwkZQDY8NHngfbf1U/LLvE1Z5IzrlsFjPmbDXlEwD7yxAhGDDt6I6PZRLH6V3uk4+8/wJ0Ol4zL6X+pHlvSZPNJQwfZXqUiLKl3cKYkBaoxW24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ajb6w2AS; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30b9f7c4165so14285241fa.3;
        Fri, 07 Mar 2025 01:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741339219; x=1741944019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wF098SdY1+et+6WUIEyzSNWkuQHvhxC9RenO2Oeg7L4=;
        b=Ajb6w2ASTSi+klEWJAI0fp9zV+O4itR/k0jIFpOhFayP7nfpIDFPWkGEGzire/LZoq
         k6NPHjm0Pk4kcnj3tR8EiQMlGl8R8vithjv4btua/I0crkIOSfPovBzR/vbvgzEoQ8Ry
         mP3rTB5QzpLLO31YSYAhqUK6ov7HNdmsiXw2XtuSSIbVHrd/thwOGwhYgB/1cMJZxgj7
         vPNp1yKAKqa1GbLOpNSFio+qI9T+y2sBsXGAqMmBowYIa7Xnioc5FHDvJBFynmPd7/46
         wctgD3zgzFDh21y0zsazuH+YqGO+vEqIEd0gdjaXwvcM8gu5mZ0ZhqVo3fwXp+rI3u+E
         XLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339219; x=1741944019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wF098SdY1+et+6WUIEyzSNWkuQHvhxC9RenO2Oeg7L4=;
        b=sBgFK9PxZeNrhDZNXj4r4VmChfLL87++xXNmy/GS6sjA8wEVUIFqPXp+C43TYiMCRw
         +8+a4B9U2nqh+q85KTa/LixsUa7tETuNSamG1kZlactHNtfJaYhN0mbt9rg3Tk8zWKHQ
         FE7OUeFGfEoOlAPy78TI8gYZb68Oj5XwDdFsK++rAxOTBwV1X2d8oBmwDTCFihRKKadP
         V9D26Lo4kfG0XlpPk0s3EA4Gv+Wu5uw5zrhQbK5OdnqmFVrinK6EHnOoWh/C3Rd+JtGx
         Vw6N2w2I1KKf1WHkgFdKr9VQp3JGgTSqaH+U3L/KKbe07WClQJWbkVjkY/Q8+nJjWEyA
         LOpg==
X-Forwarded-Encrypted: i=1; AJvYcCVKAyTOK6BdaMOX2VRenB+Pryp469h887RBeyyixdQ7OqtlzzUYT0Et0vfr41k9dA7FLuSM4Wm0BWjr+FuTdAlRJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHgYcFsUuojDo7p3XMnqU7Cex714IxYCnMd4JBRIQnDcJ+vvFb
	9IcEoyzADjMT+YvzZbW1zNGEX9G3uvO2nVNuxkYdWl3OhiibnwJpDj9UXcnazlFSwRGSddSlRnn
	r+oOJVjK3wUxGmqhqOg29ObtTelY=
X-Gm-Gg: ASbGncsQ9QN7KjUSCKwykphSmuNz1rggZcFkW7n1BCEQVJF0+2oH57U5ig5u6kz4vLp
	6B+qX7rSDCSlwbfWB68/Kjt6Ueoid/c3ecDLy2zdNI1sd20B59oSC0DT2pRcb6+JAmYPEQBWvRz
	ZO7gpFzKp7kbd2/nEPC5SZm3B4vw==
X-Google-Smtp-Source: AGHT+IHMIXZAmq0xjTS/MjdX+YO4P+6+KRfg7gGC9idOm09cQdiYuLjszuYADBZJhbus3dLJha+Axtk2WNQeiZ6XaC4=
X-Received: by 2002:a2e:a78a:0:b0:302:4a61:8b85 with SMTP id
 38308e7fff4ca-30bf4631610mr8821851fa.37.1741339218732; Fri, 07 Mar 2025
 01:20:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306145227.55819-1-ubizjak@gmail.com> <174129682336.14745.3287112422322924162.tip-bot2@tip-bot2>
 <36B61764-A297-459A-AD55-ACC54C409876@zytor.com>
In-Reply-To: <36B61764-A297-459A-AD55-ACC54C409876@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 7 Mar 2025 10:20:17 +0100
X-Gm-Features: AQ5f1JoVpHqNHwbVu--vKXyqWzq-qOcE0rHDZ88XBE3Cn6aNJZwSdr1dWlQyEdM
Message-ID: <CAFULd4b29XMoBoN9_0BCtuV2dgasO=WUu0re91Refjx68Q9O9A@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/kexec: Merge x86_32 and x86_64 code using
 macros from <asm/asm.h>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, 
	tip-bot2 for Uros Bizjak <tip-bot2@linutronix.de>, linux-tip-commits@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>, Baoquan He <bhe@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 4:00=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wrote=
:
>
> On March 6, 2025 1:33:43 PM PST, tip-bot2 for Uros Bizjak <tip-bot2@linut=
ronix.de> wrote:
> >The following commit has been merged into the x86/asm branch of tip:
> >
> >Commit-ID:     aa3942d4d12ef57f031faa2772fe410c24191e36
> >Gitweb:        https://git.kernel.org/tip/aa3942d4d12ef57f031faa2772fe41=
0c24191e36
> >Author:        Uros Bizjak <ubizjak@gmail.com>
> >AuthorDate:    Thu, 06 Mar 2025 15:52:11 +01:00
> >Committer:     Ingo Molnar <mingo@kernel.org>
> >CommitterDate: Thu, 06 Mar 2025 22:04:48 +01:00
> >
> >x86/kexec: Merge x86_32 and x86_64 code using macros from <asm/asm.h>
> >
> >Merge common x86_32 and x86_64 code in crash_setup_regs()
> >using macros from <asm/asm.h>.
> >
> >The compiled object files before and after the patch are unchanged.
> >
> >Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >Signed-off-by: Ingo Molnar <mingo@kernel.org>
> >Cc: David Woodhouse <dwmw@amazon.co.uk>
> >Cc: Baoquan He <bhe@redhat.com>
> >Cc: Vivek Goyal <vgoyal@redhat.com>
> >Cc: Dave Young <dyoung@redhat.com>
> >Cc: Ard Biesheuvel <ardb@kernel.org>
> >Cc: "H. Peter Anvin" <hpa@zytor.com>
> >Link: https://lore.kernel.org/r/20250306145227.55819-1-ubizjak@gmail.com
> >---
> > arch/x86/include/asm/kexec.h | 58 +++++++++++++++--------------------
> > 1 file changed, 25 insertions(+), 33 deletions(-)
> >
> >diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> >index 8ad1874..e3589d6 100644
> >--- a/arch/x86/include/asm/kexec.h
> >+++ b/arch/x86/include/asm/kexec.h
> >@@ -18,6 +18,7 @@
> > #include <linux/string.h>
> > #include <linux/kernel.h>
> >
> >+#include <asm/asm.h>
> > #include <asm/page.h>
> > #include <asm/ptrace.h>
> >
> >@@ -71,41 +72,32 @@ static inline void crash_setup_regs(struct pt_regs *=
newregs,
> >       if (oldregs) {
> >               memcpy(newregs, oldregs, sizeof(*newregs));
> >       } else {
> >+              asm volatile("mov %%" _ASM_BX ",%0" : "=3Dm"(newregs->bx)=
);
> >+              asm volatile("mov %%" _ASM_CX ",%0" : "=3Dm"(newregs->cx)=
);
> >+              asm volatile("mov %%" _ASM_DX ",%0" : "=3Dm"(newregs->dx)=
);
> >+              asm volatile("mov %%" _ASM_SI ",%0" : "=3Dm"(newregs->si)=
);
> >+              asm volatile("mov %%" _ASM_DI ",%0" : "=3Dm"(newregs->di)=
);
> >+              asm volatile("mov %%" _ASM_BP ",%0" : "=3Dm"(newregs->bp)=
);
> >+              asm volatile("mov %%" _ASM_AX ",%0" : "=3Dm"(newregs->ax)=
);
> >+              asm volatile("mov %%" _ASM_SP ",%0" : "=3Dm"(newregs->sp)=
);
> >+#ifdef CONFIG_X86_64
> >+              asm volatile("mov %%r8,%0" : "=3Dm"(newregs->r8));
> >+              asm volatile("mov %%r9,%0" : "=3Dm"(newregs->r9));
> >+              asm volatile("mov %%r10,%0" : "=3Dm"(newregs->r10));
> >+              asm volatile("mov %%r11,%0" : "=3Dm"(newregs->r11));
> >+              asm volatile("mov %%r12,%0" : "=3Dm"(newregs->r12));
> >+              asm volatile("mov %%r13,%0" : "=3Dm"(newregs->r13));
> >+              asm volatile("mov %%r14,%0" : "=3Dm"(newregs->r14));
> >+              asm volatile("mov %%r15,%0" : "=3Dm"(newregs->r15));
> >+#endif
> >+              asm volatile("mov %%ss,%k0" : "=3Da"(newregs->ss));
> >+              asm volatile("mov %%cs,%k0" : "=3Da"(newregs->cs));
> > #ifdef CONFIG_X86_32
> >-              asm volatile("movl %%ebx,%0" : "=3Dm"(newregs->bx));
> >-              asm volatile("movl %%ecx,%0" : "=3Dm"(newregs->cx));
> >-              asm volatile("movl %%edx,%0" : "=3Dm"(newregs->dx));
> >-              asm volatile("movl %%esi,%0" : "=3Dm"(newregs->si));
> >-              asm volatile("movl %%edi,%0" : "=3Dm"(newregs->di));
> >-              asm volatile("movl %%ebp,%0" : "=3Dm"(newregs->bp));
> >-              asm volatile("movl %%eax,%0" : "=3Dm"(newregs->ax));
> >-              asm volatile("movl %%esp,%0" : "=3Dm"(newregs->sp));
> >-              asm volatile("movl %%ss, %%eax;" :"=3Da"(newregs->ss));
> >-              asm volatile("movl %%cs, %%eax;" :"=3Da"(newregs->cs));
> >-              asm volatile("movl %%ds, %%eax;" :"=3Da"(newregs->ds));
> >-              asm volatile("movl %%es, %%eax;" :"=3Da"(newregs->es));
> >-              asm volatile("pushfl; popl %0" :"=3Dm"(newregs->flags));
> >-#else
> >-              asm volatile("movq %%rbx,%0" : "=3Dm"(newregs->bx));
> >-              asm volatile("movq %%rcx,%0" : "=3Dm"(newregs->cx));
> >-              asm volatile("movq %%rdx,%0" : "=3Dm"(newregs->dx));
> >-              asm volatile("movq %%rsi,%0" : "=3Dm"(newregs->si));
> >-              asm volatile("movq %%rdi,%0" : "=3Dm"(newregs->di));
> >-              asm volatile("movq %%rbp,%0" : "=3Dm"(newregs->bp));
> >-              asm volatile("movq %%rax,%0" : "=3Dm"(newregs->ax));
> >-              asm volatile("movq %%rsp,%0" : "=3Dm"(newregs->sp));
> >-              asm volatile("movq %%r8,%0" : "=3Dm"(newregs->r8));
> >-              asm volatile("movq %%r9,%0" : "=3Dm"(newregs->r9));
> >-              asm volatile("movq %%r10,%0" : "=3Dm"(newregs->r10));
> >-              asm volatile("movq %%r11,%0" : "=3Dm"(newregs->r11));
> >-              asm volatile("movq %%r12,%0" : "=3Dm"(newregs->r12));
> >-              asm volatile("movq %%r13,%0" : "=3Dm"(newregs->r13));
> >-              asm volatile("movq %%r14,%0" : "=3Dm"(newregs->r14));
> >-              asm volatile("movq %%r15,%0" : "=3Dm"(newregs->r15));
> >-              asm volatile("movl %%ss, %%eax;" :"=3Da"(newregs->ss));
> >-              asm volatile("movl %%cs, %%eax;" :"=3Da"(newregs->cs));
> >-              asm volatile("pushfq; popq %0" :"=3Dm"(newregs->flags));
> >+              asm volatile("mov %%ds,%k0" : "=3Da"(newregs->ds));
> >+              asm volatile("mov %%es,%k0" : "=3Da"(newregs->es));
> > #endif
> >+              asm volatile("pushf\n\t"
> >+                           "pop %0" : "=3Dm"(newregs->flags));
> >               newregs->ip =3D _THIS_IP_;
> >       }
> > }
>
> Incidentally, doing this in C code is obviously completely broken, especi=
ally doing it in multiple statements. You have no idea what the compiler ha=
s messed with before you get there.

These are "asm volatile" statemets, so at least they won't be
scheduled in a different way. OTOH, please note that the patch is very
carefully written to not change code flow, usage of hardregs in the
inline asm is usually the sign of fragile code.

Uros.

