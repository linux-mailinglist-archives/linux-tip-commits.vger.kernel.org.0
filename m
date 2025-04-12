Return-Path: <linux-tip-commits+bounces-4896-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FD2A86BD2
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 10:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE941769C9
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 08:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BA11917C2;
	Sat, 12 Apr 2025 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMenkaeY"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09309149C6F;
	Sat, 12 Apr 2025 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744446012; cv=none; b=mWG4siTxR6Guc9jSlbvTH4Qpll04r9AmowPp0AoshyEPZTOSnGI5zOe07Kf3QKbwGaG6UXxPl6nA4jMVvSt3CJn917tklrssVsXFUs5rkdyH7pI+Cp6NN8A2lWdv/WEuggsailR0/Q+CN47clFmKgonrYCNbhMN2H9dVFoXmmNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744446012; c=relaxed/simple;
	bh=YJl1vmNcOg5yJUxYSZGlUL6mZOR5RN1bTpxwoe/64Gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVkeSWH+qiqLjB505xY8VVkPwkTylVRmhMChJkeOORykoA6tapCiOXLAgAOi7xaanT3djVSxgNRfkqa8XOzVYdSlfb5Iu/V8CpCAJ5qXEcFF5FMZH8sNa75lzesyAPA0wLt6rGJfKycm8OUTzS209BfwyrwspXZ9KzCbNfZXrHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMenkaeY; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30db3f3c907so27058231fa.1;
        Sat, 12 Apr 2025 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744446009; x=1745050809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zyb5LfzkpC3XYd7aBaGCQkZkuFMnU/qCwTe20qzfgnE=;
        b=IMenkaeY1Qk3yl79JVF/+c9w4IZ0d4TGnhT03FbPiOVdWXSfC7zmSbPVSDVhkqzRxR
         ftytmjgV22B5jqWyutoCHSJ2Ea4o7j6IbyTTuXXKjXY2bWnvYZequof+KNe4BtAAXDd9
         BZ+btBYSsu+PYHKah7l5TSe9MdpjdXSD9R4wCyIxyJSOaGJ+HcrOf/F32Z4jTjzxImIN
         llVAAoSGgLRh4iOC9I8RKmnCF6EFIp3U8/m0182T3gYx737Z226rmhJ/71i0UEC/PA1s
         pDUYxCS9Cwr3BQAyKooRg5S5g3o0lg8hPxngTyxJrCJGWIivRa9wFWK4vNxZa3cxCxSb
         Hu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744446009; x=1745050809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zyb5LfzkpC3XYd7aBaGCQkZkuFMnU/qCwTe20qzfgnE=;
        b=IPhJzGPKh/J+kht2lO7FzqGzs1AkGn+Fc6splosxq7fyyaZtaL+8jbUOftJRkmuVzV
         /qaeMw8dYaOD/TMdPNbaJ7J2XwQ6wSpa7SZ8yaEeShwVv89pmLlzEaYvHw/S4IE3hQyK
         nO0hHXRm/53/n7kI0UNWDwQ8t57/EqREIyxULWtWNVAPjlUO2NyfElfPEXi8PR9u5J+V
         AyGiFTKnq3r7EjVd7KVSW1LYyN3sjaWO+1DZtZ65DTUABQKWVlJpJOAiVgp+f6UmMEMl
         WftvlTkKayjO3Q4v0VfMk/iz/dfCpLZVCXDLPFu7DoD8iwwt18h4fgIcNDy86ZrABXKm
         1Xvw==
X-Forwarded-Encrypted: i=1; AJvYcCUuUDvNSC3AtlNijb+HKugcPvT3Q8uXkJ0sq4vjbmTQsXyp2s6VB56HI67G814saQfFriBHp3Xcic+uKn+a69AZFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+bhuwBi8iLf94wHhDi3WG2+mAxJT5T0PL83GRZOGh41Sivt6g
	zEAwGj9JXr8bq+J6tk98idRUvfPI013xHLfcQhEbY7Kz/lDoQj5rBtsCyWIV1GVvSBtfgy4ytN5
	T6OtcMgvqtrp5/9iCmEZWlE2WUd4=
X-Gm-Gg: ASbGncuD76TLu3S8sB1GFOMw8Z19RNl10AyJj+3OLudTxV6AyG/6fpV7BpumDgT3gtw
	xlRECrMTOOQG8xJe+1LCRTV8j0/+HgAFKhaACrIufe7bQdnE2w7ONaYLZ1kgTmgcBZqJ0b+jV6x
	JivHnRsuvGgXyH/APdXCOzQw==
X-Google-Smtp-Source: AGHT+IGv329rmoSFOEcnZHBQ0ZkLOLRDex1cOLnJw9/15kT85PKbL/rTSCsGEwkXzcOmqT9iBH062y4YHAYPTG2sNBU=
X-Received: by 2002:a05:651c:312b:b0:30b:be23:3ad with SMTP id
 38308e7fff4ca-310499f5e0dmr18331121fa.10.1744446008670; Sat, 12 Apr 2025
 01:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404102535.705090-1-ubizjak@gmail.com> <174428272631.31282.1484467383146370221.tip-bot2@tip-bot2>
 <20250411210815.GAZ_mEv8riLWzvERYY@renoirsky.local>
In-Reply-To: <20250411210815.GAZ_mEv8riLWzvERYY@renoirsky.local>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 12 Apr 2025 10:20:01 +0200
X-Gm-Features: ATxdqUEmUI3lM4jZ_-9-cnYNle7oLX-ZDutoV8y_D-AHQEEs92FH4Qe33hP-8ss
Message-ID: <CAFULd4bWM3X9_8iHmbiRst=nxBmLD7FU=xyJ1D2xKq0hi57+0Q@mail.gmail.com>
Subject: Re: [tip: core/urgent] compiler.h: Avoid the usage of
 __typeof_unqual__() when __GENKSYMS__ is defined
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	linux-tip-commits@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 11:07=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Thu, Apr 10, 2025 at 10:58:46AM -0000, tip-bot2 for Uros Bizjak wrote:
> > The following commit has been merged into the core/urgent branch of tip=
:
> >
> > Commit-ID:     e696e5a114b59035f5a889d5484fedec4f40c1f3
> > Gitweb:        https://git.kernel.org/tip/e696e5a114b59035f5a889d5484fe=
dec4f40c1f3
> > Author:        Uros Bizjak <ubizjak@gmail.com>
> > AuthorDate:    Fri, 04 Apr 2025 12:24:37 +02:00
> > Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> > CommitterDate: Thu, 10 Apr 2025 12:44:27 +02:00
> >
> > compiler.h: Avoid the usage of __typeof_unqual__() when __GENKSYMS__ is=
 defined
> >
> > Current version of genksyms doesn't know anything about __typeof_unqual=
__()
> > operator.  Avoid the usage of __typeof_unqual__() with genksyms to prev=
ent
> > errors when symbols are versioned.
> >
> > There were no problems with gendwarfksyms.
> >
> > Fixes: ac053946f5c40 ("compiler.h: introduce TYPEOF_UNQUAL() macro")
> > Closes: https://lore.kernel.org/lkml/81a25a60-de78-43fb-b56a-131151e1c0=
35@molgen.mpg.de/
> > Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Link: https://lore.kernel.org/r/20250404102535.705090-1-ubizjak@gmail.c=
om
> > ---
> >  include/linux/compiler.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 27725f1..98057f9 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -229,10 +229,10 @@ void ftrace_likely_update(struct ftrace_likely_da=
ta *f, int val,
> >  /*
> >   * Use __typeof_unqual__() when available.
> >   *
> > - * XXX: Remove test for __CHECKER__ once
> > - * sparse learns about __typeof_unqual__().
> > + * XXX: Remove test for __GENKSYMS__ once "genksyms" handles
> > + * __typeof_unqual__(), and test for __CHECKER__ once "sparse" handles=
 it.
> >   */
> > -#if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
> > +#if CC_HAS_TYPEOF_UNQUAL && !defined(__GENKSYMS__) && !defined(__CHECK=
ER__)
> >  # define USE_TYPEOF_UNQUAL 1
> >  #endif
>
> So mingo is right - this is not really a fix but a brown-paper bag of
> sorts.
>
> The right thing to do here is to unpatch the __typeof_unqual__ stuff
> until all the fallout from it - genksyms and whatever else - has been
> fixed properly.
>
> So to avoid too much churn I's suggest something like this (totally untes=
ted
> ofc) until all has been fixed.

FYI, the sparse patch is at [1], but the talk about the abandoned
project suggests that __typeof_unqual__ and dependent percpu checks
will remain disabled for some time.

[1] https://lore.kernel.org/linux-sparse/5b8d0dee-8fb6-45af-ba6c-7f74aff9a4=
b8@stanley.mountain/

Uros.

