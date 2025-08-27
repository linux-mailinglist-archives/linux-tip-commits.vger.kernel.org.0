Return-Path: <linux-tip-commits+bounces-6387-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6280B37C47
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 09:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF363A96CD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 07:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2232D0C76;
	Wed, 27 Aug 2025 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPPy6ZEm"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD8531DD97;
	Wed, 27 Aug 2025 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281214; cv=none; b=LCUNbgSamGJljlTVB+C1YbMj8NKuH11BvS90pT6dEpnsb0k4P6PZfx5zHSK5PwN1rrJ7kH6U3W6753vllhUFYA97W2awdUKwhUlnysrKcmHKsQK2b0g5+p0wPLmK92/uMFT43k216PwPbRgJPwbHPZcZFASYiBbNNHqOj6TyFyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281214; c=relaxed/simple;
	bh=xIZxtBbpfTYR467EL+8lMV8yXpD6+0TE4aClQx8zsqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPYxc26KL+zvYbH71wIlJGQv7caYdM5nO50tCcskPzS4sW3GDv/A65xEEOTxyS8ZtnRNXKB9zb3EP5uC5L5hZ+kbMJW+XRA3EuncK7b7Q3ONa2MKlYICskyPRAXrNr4wj4qiUWKXZTrW5x0NC57hcwLbYtT5k6GQ6sk78p7XvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPPy6ZEm; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-333f92d60ddso48785701fa.3;
        Wed, 27 Aug 2025 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756281211; x=1756886011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5SwVVdd09QNk7orxe/jVotYzoI6S19JyIqQJ6Wtv4U=;
        b=UPPy6ZEmhUv+5kdmUPed2BlhN3lYixMOw7LQ4f7756qDMcg7bac9nVRnMpXZKVhbWG
         +1s15el89U9CRvapWHeUImEpkoTP/4zX1fRswSntpYzhOlenMxVezaGsyluHa5ALBa+S
         ZhrJhWOaL4kY/FNsRm0xK2P1mJR5xNjZ+6ufX9lwFie9LedKyn35JMB/x9zWlTwPl/sG
         AfRbdl6y40Rg1vNvxb/sQoDFo/dtRkDxlOKuTkaGwh13bx38vRI21edIqzL8mu8s44Qb
         HFV56kjavqdRkaE9wUi601/KZDpOMje7xCx29xWzpB0JninHXzgu51DioCh4nVV1bj8i
         A5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756281211; x=1756886011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5SwVVdd09QNk7orxe/jVotYzoI6S19JyIqQJ6Wtv4U=;
        b=Gxu6kcdoUIXnmK1sh98Yre4j9slIsFd+2VtvTmVQDmtRL1Yevbs4zUzzn2zGTOsRz0
         IzSMNaLFmvfRcN1xTqXRFEhjEL2sgIGfX9u9znaSTDYZbWGJrbEEilgoNwb2EPYewsXL
         l+5PLqWULHs4k0ugHWpVHV5fT+Ko4ZHPdFUSQAaFdPiQqHvlZiMlQOr/xfQcd8sP8+AL
         KXWR7zm3o/hn9fWXnWdZ21S9C+/QmnTy1TeVQqXHAAR2zzfQ4s8zbbvDWAt2APA1hwtj
         lMLNog2cZac0cr7w5c4K6JggDRJZOeCf07OFU9XIsEq7OJ90FUsv+jtU5XkgH7CoiQiM
         EFDg==
X-Gm-Message-State: AOJu0YzifEjgi5nEvwhNdqdRtFQcjkHkGNzWDWTRcKU9sw04deKONY3X
	pp/nKjloD5GHe0MTa9RxB+GVn4XsOnfiS04mVjxw1sSKC1CkDI5bWNuvYqs0B1vXQvADVe2QxVC
	M1rXw7EldwVXW0i93iyB+tEKd3fQhzBt+Bg==
X-Gm-Gg: ASbGncuilz7Ropduge+h1ctK8fpQzEhFmSPf4lOzJaUlsatyNtoA2JYeSLj3oIVNpUB
	nBoe94fcGNzDOUkNWu5bTq8Y2npJSMraicODzT9sJpDweIXev6lxzL58Ij9KpsYd5qrw2fISEnf
	TME+0mIXzxbhPMWQ0X03zK0NhdOzVeWyRZdkE/Jt/282GWsSF5bQlF8ZR8nDHgjpmgzPH7+el0q
	LVyeSKmmqWyyflG7g==
X-Google-Smtp-Source: AGHT+IHiLfLIVgocvn7cuJjINbdlsCg9NSU4a1KxbI2ynRgkDxDcdX42P++asBByqyVEK2uWZWl7GBs7wBaee5/GIlU=
X-Received: by 2002:a2e:b8c1:0:b0:336:7ec6:882c with SMTP id
 38308e7fff4ca-3367ec68c99mr26406511fa.43.1756281210322; Wed, 27 Aug 2025
 00:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616095315.230620-1-ubizjak@gmail.com> <175627714358.1920.14102647257754782558.tip-bot2@tip-bot2>
In-Reply-To: <175627714358.1920.14102647257754782558.tip-bot2@tip-bot2>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 27 Aug 2025 09:53:17 +0200
X-Gm-Features: Ac12FXwBAlBFeOB0iSexIn31Gu3xldK7EMm8iUs1FsU-qaSWpbaSgULF0ntq7xY
Message-ID: <CAFULd4aZYEi02cKeS1RAL66Qs149nLys8SJfTvfHuPH3FMXJeA@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/vdso: Fix output operand size of RDPID
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 8:45=E2=80=AFAM tip-bot2 for Uros Bizjak
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the x86/asm branch of tip:
>
> Commit-ID:     ac9c408ed19d535289ca59200dd6a44a6a2d6036
> Gitweb:        https://git.kernel.org/tip/ac9c408ed19d535289ca59200dd6a44=
a6a2d6036
> Author:        Uros Bizjak <ubizjak@gmail.com>
> AuthorDate:    Mon, 16 Jun 2025 11:52:57 +02:00
> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> CommitterDate: Tue, 26 Aug 2025 19:33:19 +02:00
>
> x86/vdso: Fix output operand size of RDPID
>
> RDPID instruction outputs to a word-sized register (64-bit on x86_64 and
> 32-bit on x86_32). Use an unsigned long variable to store the correct siz=
e.
>
> LSL outputs to 32-bit register, use %k operand prefix to always print the
> 32-bit name of the register.
>
> Use RDPID insn mnemonic while at it as the minimum binutils version of
> 2.30 supports it.
>
>   [ bp: Merge two patches touching the same function into a single one. ]

The 1/2 patch is intended to be backportable (only this part carries
"Fixes" designation). The 2/2 patch introduces RDPID mnemonic that
requires binutils-2.30, so the second part is not backportable to
branches that still require binutils-2.25.

Uros.

>
> Fixes: ffebbaedc861 ("x86/vdso: Introduce helper functions for CPU and no=
de number")
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/20250616095315.230620-1-ubizjak@gmail.com
> ---
>  arch/x86/include/asm/segment.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segmen=
t.h
> index 77d8f49..f59ae71 100644
> --- a/arch/x86/include/asm/segment.h
> +++ b/arch/x86/include/asm/segment.h
> @@ -244,7 +244,7 @@ static inline unsigned long vdso_encode_cpunode(int c=
pu, unsigned long node)
>
>  static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
>  {
> -       unsigned int p;
> +       unsigned long p;
>
>         /*
>          * Load CPU and node number from the GDT.  LSL is faster than RDT=
SCP
> @@ -254,10 +254,10 @@ static inline void vdso_read_cpunode(unsigned *cpu,=
 unsigned *node)
>          *
>          * If RDPID is available, use it.
>          */
> -       alternative_io ("lsl %[seg],%[p]",
> -                       ".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
> +       alternative_io ("lsl %[seg],%k[p]",
> +                       "rdpid %[p]",
>                         X86_FEATURE_RDPID,
> -                       [p] "=3Da" (p), [seg] "r" (__CPUNODE_SEG));
> +                       [p] "=3Dr" (p), [seg] "r" (__CPUNODE_SEG));
>
>         if (cpu)
>                 *cpu =3D (p & VDSO_CPUNODE_MASK);

