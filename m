Return-Path: <linux-tip-commits+bounces-4245-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C05C7A64A19
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59C13B63BF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EE4235BE2;
	Mon, 17 Mar 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cueQOBAa"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BB42253AE;
	Mon, 17 Mar 2025 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207330; cv=none; b=tshjFnhIwxFQXCf/gAcmHOb3Jr0s1hIksnjGJdhmpNcEHQeCshfrPogp64nUjfvUnT7TS0cAZBX0EGyLoicuIP+hHeSYPvnIgLyeP//gJzG/IXcvPC4dKf+v/HgtLcM0I8q2+L2fKqLXKuw+MOPD+WIMEGzS68u/PrFiqdfedn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207330; c=relaxed/simple;
	bh=L34jB4X9J4PZF6KWyGeB6Jx7x+Zl35dwlBDiykQHLjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCB+f3whp8y94maCL1wlBzksocomdmZSlLhfxExiNmFHbrYaitxoBEO4rrF+S+E8wyekuSfIRAirizQrceXCMrMc2PxfWnByG/ITsfoYJV2jZF9P9UeILZs52lf5JuNxR7yt+JOuynR8wLD7rfO0d+xT/5oxa6D2zHwUV8ROhHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cueQOBAa; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bf1d48843so40602361fa.2;
        Mon, 17 Mar 2025 03:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742207327; x=1742812127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yX6QzfcRz1cLG12S1tGWCTgUvcgx+pPDbW34AvRgEOc=;
        b=cueQOBAaRPwNs46et8k80dwvTwRNQ6UTEwqd/pqjfs/6z1KGK4AGL3qEJeCYwmwhNW
         8r03DymCUcqy3HLfad5BxDyx/rFzxjcPVECkh7jKLLL2Yjbpffg6KTjHZzWVdburXq8d
         9RtswQU4SpaY/Mffs+/3ySW1QOdFUL15p7seYIkzM9zJLhr+NOXUESWL3rp7dAlV/urp
         /Ua5cFbwoc9h8QqvRl3MR87JK7oyfrnBbB583vPftXtRKBHfu4Xjat6KAJEtHHd8stXi
         cJufQLv8Cqvm8eIMHRwWtNpo1XXnO3nT18aJFcJdzIDrQYiGxTg5z4nNWCXAWLsLQ75u
         OtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742207327; x=1742812127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yX6QzfcRz1cLG12S1tGWCTgUvcgx+pPDbW34AvRgEOc=;
        b=H8+qFgFRwrOrckrMg36xHZxX1L4SOZBviJbvpXIUUysE99pEUkTcM/2n6pcH4BcNEE
         MoR3+5IGUtU0BU48TAufffUbAQt6EVYJGO3XLvtYQAnSPCzoViAcwNbFR8QTmn0knaBJ
         fd6bQ7VX4NhiSDrvlzWqRdnR3J3rSjzCJxxJ2EMx8KBpeQYarGB0tSKpArbNzzFyZyEI
         gu5iSDBqX+rSLhBlBiL8Ls2u+W1xo/lSudiyvLZXQ3S9uqUhz77Ez7aFuTQJsP33a7xb
         6VuQ+u6zeL2s1Ppff15o0S3ob8Da5Zvg5NhblOZ62dqdrK2SBZpLxWX9fv7Dhup5pB/z
         PHhA==
X-Forwarded-Encrypted: i=1; AJvYcCWij3oanz+1mBDdHhODw+sqE0wZIFW9PlGSQlbNkelQLFwoT1SzDvZausCyXJJ/HSli/HrR/KpoVwAHyBF7JFMgCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7v/xNBSJ9N+hX7m7Jq6L+cAA16jC8yKD+bOCl7zVX0h+A2NB9
	9gLort6n11NjBJ+EZwnCSMoTfznqbYDWCGBPI2oRvbGwWXReGdoIq9O2KohgeBxsZbdFG14Esbp
	l6atbCVOZZq9cfV33FfSbf5DYdN685jcs
X-Gm-Gg: ASbGnctjYrOdNoLgFC7PzzzORbPSO7UjX7nmV0JPjz0VeRNkxYMBVYESN8JM9+bdNIf
	E3xZv5qLwAMG7UQCCOyPW974naNTAvozJsdupU6lnT2nbGH+5/L3pusA3IgcainOcZ1PtsqdiuT
	5uBrfB3KfRpSVORbAOpkBH8hICoA==
X-Google-Smtp-Source: AGHT+IGtJsdfASo1y5f5AiQd1PN5VoHhf+fGkskM+nRARafy/0ttN4WxuSfGQwNtc4VqigOk0W1XJfkhJR0TWa59A1w=
X-Received: by 2002:a05:651c:210a:b0:30a:2a8a:e4b5 with SMTP id
 38308e7fff4ca-30c4a8d1e1amr60541301fa.27.1742207326612; Mon, 17 Mar 2025
 03:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313130251.383204-1-ubizjak@gmail.com> <174188823430.14745.17591986001259957573.tip-bot2@tip-bot2>
 <20250317101415.GBZ9f198PAh90nMWDf@fat_crate.local>
In-Reply-To: <20250317101415.GBZ9f198PAh90nMWDf@fat_crate.local>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 17 Mar 2025 11:28:58 +0100
X-Gm-Features: AQ5f1Jr75R0dKtWfeXD10vh_mXTYQbuMEKe0rum7dfiueZyr8dno-rCoH-AIJbc
Message-ID: <CAFULd4b-sZucEtvx19==5wcOfOCzj5fuZ2SHS7ZMboZQXdVycg@mail.gmail.com>
Subject: Re: [tip: x86/fpu] x86/fpu: Use XSAVE{,OPT,C,S} and XRSTOR{,S}
 mnemonics in xstate.h
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 11:14=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Thu, Mar 13, 2025 at 05:50:34PM -0000, tip-bot2 for Uros Bizjak wrote:
> > The following commit has been merged into the x86/fpu branch of tip:
> >
> > Commit-ID:     2883b4c2169a435488f7845e1b6fdc6f3438c7c6
> > Gitweb:        https://git.kernel.org/tip/2883b4c2169a435488f7845e1b6fd=
c6f3438c7c6
> > Author:        Uros Bizjak <ubizjak@gmail.com>
> > AuthorDate:    Thu, 13 Mar 2025 14:02:27 +01:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Thu, 13 Mar 2025 18:36:52 +01:00
> >
> > x86/fpu: Use XSAVE{,OPT,C,S} and XRSTOR{,S} mnemonics in xstate.h
> >
> > Current minimum required version of binutils is 2.25, which
> > supports XSAVE{,OPT,C,S} and XRSTOR{,S} instruction mnemonics.
> >
> > Replace the byte-wise specification of XSAVE{,OPT,C,S}
> > and XRSTOR{,S} with these proper mnemonics.
> >
> > No functional change intended.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Brian Gerst <brgerst@gmail.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Link: https://lore.kernel.org/r/20250313130251.383204-1-ubizjak@gmail.c=
om
> > ---
> >  arch/x86/kernel/fpu/xstate.h | 27 +++++++++++++--------------
> >  1 file changed, 13 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.=
h
> > index aa16f1a..1418423 100644
> > --- a/arch/x86/kernel/fpu/xstate.h
> > +++ b/arch/x86/kernel/fpu/xstate.h
> > @@ -94,18 +94,17 @@ static inline int update_pkru_in_sigframe(struct xr=
egs_state __user *buf, u64 ma
> >  /* XSAVE/XRSTOR wrapper functions */
> >
> >  #ifdef CONFIG_X86_64
> > -#define REX_PREFIX   "0x48, "
> > +#define REX_SUFFIX   "64"
> >  #else
> > -#define REX_PREFIX
> > +#define REX_SUFFIX
> >  #endif
> >
> > -/* These macros all use (%edi)/(%rdi) as the single memory argument. *=
/
> > -#define XSAVE                ".byte " REX_PREFIX "0x0f,0xae,0x27"
> > -#define XSAVEOPT     ".byte " REX_PREFIX "0x0f,0xae,0x37"
> > -#define XSAVEC               ".byte " REX_PREFIX "0x0f,0xc7,0x27"
> > -#define XSAVES               ".byte " REX_PREFIX "0x0f,0xc7,0x2f"
> > -#define XRSTOR               ".byte " REX_PREFIX "0x0f,0xae,0x2f"
> > -#define XRSTORS              ".byte " REX_PREFIX "0x0f,0xc7,0x1f"
> > +#define XSAVE                "xsave" REX_SUFFIX " %[xa]"
> > +#define XSAVEOPT     "xsaveopt" REX_SUFFIX " %[xa]"
> > +#define XSAVEC               "xsavec" REX_SUFFIX " %[xa]"
> > +#define XSAVES               "xsaves" REX_SUFFIX " %[xa]"
> > +#define XRSTOR               "xrstor" REX_SUFFIX " %[xa]"
> > +#define XRSTORS              "xrstors" REX_SUFFIX " %[xa]"
> >
> >  /*
> >   * After this @err contains 0 on success or the trap number when the
> > @@ -114,10 +113,10 @@ static inline int update_pkru_in_sigframe(struct =
xregs_state __user *buf, u64 ma
> >  #define XSTATE_OP(op, st, lmask, hmask, err)                         \
> >       asm volatile("1:" op "\n\t"                                     \
> >                    "xor %[err], %[err]\n"                             \
> > -                  "2:\n\t"                                           \
> > +                  "2:\n"                                             \
> >                    _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE)  \
> >                    : [err] "=3Da" (err)                                =
 \
> > -                  : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)    \
> > +                  : [xa] "m" (*(st)), "a" (lmask), "d" (hmask)       \
>
> This [xa] needs documenting in the comment above this.
>
> What does "xa" even mean?

xsave area.

Uros.

