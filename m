Return-Path: <linux-tip-commits+bounces-4286-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 440E6A64BC0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 12:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A3C188C53E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C52642069;
	Mon, 17 Mar 2025 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvdm7R6I"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852232E3370;
	Mon, 17 Mar 2025 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209563; cv=none; b=T2w9j/lbiVeFioN5gtXhO4dLZlqveJa1xNEw+KBy5bu3+s+EDKJsqCCJfuSIp69N9n38OIlo8CyIfbUQQYA3mzAJfttBB/hjXq1nhAz9uRGv+uSHpzAg6FVcseFxP/OKK7g0HKf0l8aPtoBNvn6qqE4Yjuhv8SZXrSEGU/IcGZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209563; c=relaxed/simple;
	bh=O5U1kQYPtoo1453wWTerwkVykU62NLa6ubh3OOtQiT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLzgEvRiq9AMWmkpo6XWYwDKOxPjjfhQxZPlw2dKUawRYFfhWYlEyiiag842KLvzW3I73gfyGKrVmzFnNdLdsgj+Gc8BLH/UB5ole8wD7+z0j7eo2o0GpmQYoU8G/UwnHArIN0i+SG12cyzGwrbUMqfFOLFq1jP/ZmejLiIhgcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cvdm7R6I; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so43816781fa.1;
        Mon, 17 Mar 2025 04:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742209559; x=1742814359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgkosUeo/nhS7GWQwCRcAN3753nsD7ErN/0YpE+CRAg=;
        b=Cvdm7R6I5vPziTcGC7n9NQuA7eUTJ1ASFMHwoCf8VUw9AHu1QOJQbNnfVdydKxC1oa
         UZSv/V91qaxcF2FC8CEpSKt6ZyA8468XvGtwPkXk6BvjBQUgVICe0z1VWiGCNQgCOI8a
         CpeJyjPHFHIq1Suj0mzGvGs+f+XO1dp6uQu6qm4XY+m73ylaVojSE5y+DfvxFjFsqjgK
         VyKKz06JNVyVlSXh26Y7lA3oDbRk42NZNVgAXcMVo7GOJMTk31A92lfr3rS2uW6kjubN
         Iizg78qdWai9rKWsXiogXLSEyTS1nM//VZ7H4wN1G8RhG8PrbM5MBkwN81H2t8WY5SQL
         dajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742209559; x=1742814359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgkosUeo/nhS7GWQwCRcAN3753nsD7ErN/0YpE+CRAg=;
        b=Zdu4DYpY4jHxACToxM/5RsCsOynnwxWkIKxjuRjkzLSRViOx3Otqaw1Gl1SzLsWIAJ
         74dkfZfJWjMoeQRIRTrXJk2IOIaFYP05gpVU+BWQVsYnC5gDSfAjf8iSBEb4HSp4Mz3S
         sUfdBcdlcX0hHDuqr9oUDqEXjaBBQ2JyNBGt604xPgMwcx2jmRrQPaoeYMgWf3F2TGml
         M33uUT2f7qKwZqixNc7H20/suXB8cCI9HVAdUUsrAwxBc0jGU75CC8+D9d5bPihUxKtQ
         q2hxDZfS0eGo6H739YN7nmJo7PvbQSJZYXojYPb+6r8XyNSarEDIRNvZyLRtFqluvsEZ
         RnQA==
X-Forwarded-Encrypted: i=1; AJvYcCWmuIWDjpAiZWqhV5W/6A0YxppPx5RYjMkVGNU6UtqK9zZ9/b5mbmEmBwdXTSKS1wB6NHhjYsNm9cr90Z1TdyGR/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YypiO/UBDdoI99Uwn0TwZ7JlQLk4PACJcz1fMg/9VLB8s4iPSyU
	rn4Rge2gArD2Ea0zZPgeT7u4oALhTSrrfWnmomegW+oBtT1KW7s33vZMyBsp4Nxju1ffpfM7KAm
	IrtNGSZkUl7c0eOAtTYi1K06i+ZazHcbQ
X-Gm-Gg: ASbGnct+jskNPX/agqpBMmsntENmI2JShb5rxAI20QNQAX1KfgKwbau5KiWv+GgJSCk
	ScSbHJw8vBdJwz2RGWEiGtQKrR7O6mqg/5KH6IxetEYZzbSP7FRKHRjcDmsCzCnBdDlapDpkFU7
	uYKQa+Dufv0GqJNUmXpXG+ZP4Uzg==
X-Google-Smtp-Source: AGHT+IFpWWCedHMKqSi5+gojuQ85aERJhkVX4+QmX0hFRdA12H+C+YoECrHkL0rH0qZWow7vGfw7WpKsGZ1eaploexM=
X-Received: by 2002:a05:6512:1282:b0:549:8f01:6a71 with SMTP id
 2adb3069b0e04-549c39aed5cmr6443133e87.51.1742209559265; Mon, 17 Mar 2025
 04:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313130251.383204-1-ubizjak@gmail.com> <174188823430.14745.17591986001259957573.tip-bot2@tip-bot2>
 <20250317101415.GBZ9f198PAh90nMWDf@fat_crate.local> <CAFULd4b-sZucEtvx19==5wcOfOCzj5fuZ2SHS7ZMboZQXdVycg@mail.gmail.com>
 <20250317104616.GCZ9f9eF-0n0qPbWwk@fat_crate.local>
In-Reply-To: <20250317104616.GCZ9f9eF-0n0qPbWwk@fat_crate.local>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 17 Mar 2025 12:06:11 +0100
X-Gm-Features: AQ5f1Jq9hRnWG1ApqvvbzeztgDbboVw75z7WTtvhChtJiyl18U4tnnqBRQs62Uk
Message-ID: <CAFULd4b_a=3xs2b_88WaDR9hLuhMqNZiMu+kNAbrgJf2MoVNnQ@mail.gmail.com>
Subject: Re: [tip: x86/fpu] x86/fpu: Use XSAVE{,OPT,C,S} and XRSTOR{,S}
 mnemonics in xstate.h
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 11:46=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Mon, Mar 17, 2025 at 11:28:58AM +0100, Uros Bizjak wrote:
> > > > @@ -114,10 +113,10 @@ static inline int update_pkru_in_sigframe(str=
uct xregs_state __user *buf, u64 ma
> > > >  #define XSTATE_OP(op, st, lmask, hmask, err)                      =
   \
> > > >       asm volatile("1:" op "\n\t"                                  =
   \
> > > >                    "xor %[err], %[err]\n"                          =
   \
> > > > -                  "2:\n\t"                                        =
   \
> > > > +                  "2:\n"                                          =
   \
> > > >                    _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE=
)  \
> > > >                    : [err] "=3Da" (err)                            =
     \
> > > > -                  : "D" (st), "m" (*st), "a" (lmask), "d" (hmask) =
   \
> > > > +                  : [xa] "m" (*(st)), "a" (lmask), "d" (hmask)    =
   \
> > >
> > > This [xa] needs documenting in the comment above this.
> > >
> > > What does "xa" even mean?
> >
> > xsave area.
>
> That's struct xregs_state in kernel nomenclature.
>
> And the macro's argument is called "st".
>
> And when it says [xa] there, one wonders where that "xa" comes from. So p=
lease
> add a comment above the macro explaining that.

This is an internal label for a named argument. The name shouldn't
bother anybody, it could be anything, [xa], [ptr], [arg] or whatnot,
so I see no reason why a comment should explain the choice. It's like
arguing about the name of a variable.

Uros.

