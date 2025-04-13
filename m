Return-Path: <linux-tip-commits+bounces-4919-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55243A8710B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 10:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5363B69F5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC2C537E9;
	Sun, 13 Apr 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwY6yS2e"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2054A18;
	Sun, 13 Apr 2025 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744532838; cv=none; b=CvTAW5EQL2XqKk7yCqGECbbeF85FPrUxTJstRPGBKWAeETCiOyNGSttP0LrhGTWYRihLtelz9u+JRPlGaZKlqnnWemh/gUqJdjf3v2qg4jB7QtmtI3TqE6HdUifTHL4qUN5L4j9feFcwU4ophton3VX+AZpbrctmv+bnrFBCweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744532838; c=relaxed/simple;
	bh=0v3Jq+/wGcI13DKH1vnMiRY+delUiPLDIImtK4f9tLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uElvrDMzX33o/zZNG9RGdMb2XloEHj2Y6dpZyI/I/5iQaqnBNlWr5fd67mrCgmqQLNTYJFADmoNtNTyDJyGf8gOB9P2nWSfe85yvyWH+Tr1LdbYsWVwyAPDkSgaaXhRrPwcXMQwDy0b9DgBSFIbq7YqXEzjTklQM5gj+4bxD8XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwY6yS2e; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30c44a87b9cso27341181fa.3;
        Sun, 13 Apr 2025 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744532835; x=1745137635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buOxrvabxsXlCms6m8Mzv8UYzhuS/9ep95QMGH+5VUE=;
        b=ZwY6yS2e+XDIedJeXcWIYpyk5LMaJpMsbuA0f689beWWDM3O/9DDe0BbXbZ0A0epkt
         Rr5YJPCGCk9t40QR7W4kLZko0j4lK+TFW3NBUpb8CodXNIVYZU8B/ro7V3ZOMfAdCfts
         TNaoBHuGo5+ZFmeGewm9Mq47iKpWloF8NvPA4ZKTpRdRoj8yDnWnSgc+m6OELkQAEzLQ
         ABPhLWu3IY2TI+KADvGb/mna2GrxHiaGOZmdSC8GvWo/RSH58cBkqIfhYP/u91AfLaMG
         57eW9ehYW3y4UZhlaBxKRnHiVdP1y9HssZbA/zegiUKTg/mQRo1jMHC5gfHh2anHGt8r
         Dyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744532835; x=1745137635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buOxrvabxsXlCms6m8Mzv8UYzhuS/9ep95QMGH+5VUE=;
        b=D1M87SzhPmLvhbjmmJkCKg6ox73Z+ukYdjX47WqH94WOmz589ZsDofq0nzpg6eu2J4
         1ws/qE6gxABPR1whasNFCLwT2lDxRrV/kO9jN84m9DyJ9l4eAvYuwnHJ9d6rHNH/uP3X
         0ngDlwGg4Yg57zoNA5Z8zsRm/XUhD+V9wVKhePHwTK9yhZlk8dp3ez/5ba7x70FK8jLN
         Aq5ME3mKBazTiVhFLXujUzR1JvhGkctcBv+kTaHYXYD0XNIc9KzrA/izu+OoqMDrGJOW
         JcscNQgrRsc+/bMsyiVVVQFh0C85nLdUrCKniH+JcUd4DvbW5eLKHx8jbppru3x3Xj0M
         Zfdw==
X-Forwarded-Encrypted: i=1; AJvYcCU986JZ9AmVTQiBKetgRQ2yEisOF2ElXP57a7MwGPR0zErcKeGDQJ2lzgMc/QHOjPUuRMzAotsdX6pmEo87efDKLG8=@vger.kernel.org, AJvYcCVbaEHpfwXWNeu5dzhaf5V6NHO9NwFPcceJNvFhh8ahVictWjdm66gG2UTqTLL+HBjfYQ5KIB2WaeoZvR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTm8cYBTQ+TXYEX0zCz4Oo0X42sgEVkU/kFzbyPxpz9vkuUWaV
	i6uJ2mliA7Fgl0jryjmE3QV8p3w8s0L4C1/AZ1UwtMJpC+w1wKJV1jF2Sm6X/0MKuWLNV8EK7Cd
	D8YJFd60ZRDY17tIopio1epC5Ox4=
X-Gm-Gg: ASbGnct0yJoUohOtnTnr2cxE+ozZW2z53txIG/en2SWIn1plINtEo5Bb32gS/LqyjLX
	5k4Xt7Uwak6S/KZJMfAT/4uKAU7rpgYZqjWl6pmIjiV6uTkoVEZDFMPVnUcsyyyxNzPyvjQ4lMb
	+kEQFkziRnEnqwlLbq+CfDbg==
X-Google-Smtp-Source: AGHT+IFIhUpqlQ4ZwlqnhYNhTmxWUbsBLJXkWnvqOdSvKRQQFCLncgsOYq7XCitPfC7NrirYmVY6rvOpDXzamOY47X8=
X-Received: by 2002:a05:651c:3225:b0:309:17:750d with SMTP id
 38308e7fff4ca-31049a932admr28784291fa.27.1744532834427; Sun, 13 Apr 2025
 01:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404102535.705090-1-ubizjak@gmail.com> <174428272631.31282.1484467383146370221.tip-bot2@tip-bot2>
 <20250411210815.GAZ_mEv8riLWzvERYY@renoirsky.local> <Z_oqalk92C4G6Rqt@gmail.com>
In-Reply-To: <Z_oqalk92C4G6Rqt@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 13 Apr 2025 10:27:07 +0200
X-Gm-Features: ATxdqUEgbd74PN99mAMNm4GPSlQwD9WhGUmTSngiIYkBKayMsAXTVSfI3YxZ0XU
Message-ID: <CAFULd4bTd6GMftLBX7Nu0xftini00o4v7=1XfuoDC8ydUr9Ueg@mail.gmail.com>
Subject: Re: [tip: core/urgent] compiler.h: Avoid the usage of
 __typeof_unqual__() when __GENKSYMS__ is defined
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Paul Menzel <pmenzel@molgen.mpg.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 10:55=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Borislav Petkov <bp@alien8.de> wrote:
>
> > On Thu, Apr 10, 2025 at 10:58:46AM -0000, tip-bot2 for Uros Bizjak wrot=
e:
> > > The following commit has been merged into the core/urgent branch of t=
ip:
> > >
> > > Commit-ID:     e696e5a114b59035f5a889d5484fedec4f40c1f3
> > > Gitweb:        https://git.kernel.org/tip/e696e5a114b59035f5a889d5484=
fedec4f40c1f3
> > > Author:        Uros Bizjak <ubizjak@gmail.com>
> > > AuthorDate:    Fri, 04 Apr 2025 12:24:37 +02:00
> > > Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> > > CommitterDate: Thu, 10 Apr 2025 12:44:27 +02:00
> > >
> > > compiler.h: Avoid the usage of __typeof_unqual__() when __GENKSYMS__ =
is defined
> > >
> > > Current version of genksyms doesn't know anything about __typeof_unqu=
al__()
> > > operator.  Avoid the usage of __typeof_unqual__() with genksyms to pr=
event
> > > errors when symbols are versioned.
> > >
> > > There were no problems with gendwarfksyms.
> > >
> > > Fixes: ac053946f5c40 ("compiler.h: introduce TYPEOF_UNQUAL() macro")
> > > Closes: https://lore.kernel.org/lkml/81a25a60-de78-43fb-b56a-131151e1=
c035@molgen.mpg.de/
> > > Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > > Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > > Link: https://lore.kernel.org/r/20250404102535.705090-1-ubizjak@gmail=
.com
> > > ---
> > >  include/linux/compiler.h | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > > index 27725f1..98057f9 100644
> > > --- a/include/linux/compiler.h
> > > +++ b/include/linux/compiler.h
> > > @@ -229,10 +229,10 @@ void ftrace_likely_update(struct ftrace_likely_=
data *f, int val,
> > >  /*
> > >   * Use __typeof_unqual__() when available.
> > >   *
> > > - * XXX: Remove test for __CHECKER__ once
> > > - * sparse learns about __typeof_unqual__().
> > > + * XXX: Remove test for __GENKSYMS__ once "genksyms" handles
> > > + * __typeof_unqual__(), and test for __CHECKER__ once "sparse" handl=
es it.
> > >   */
> > > -#if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
> > > +#if CC_HAS_TYPEOF_UNQUAL && !defined(__GENKSYMS__) && !defined(__CHE=
CKER__)
> > >  # define USE_TYPEOF_UNQUAL 1
> > >  #endif
> >
> > So mingo is right - this is not really a fix but a brown-paper bag of
> > sorts.
>
> Yeah, agreed, I've removed this workaround from tip:core/urgent for the
> time being - it's not like genksyms is some magic external entity we
> have to work around, it's an in-kernel tool that can be fixed/enhanced
> in scripts/genksyms/.

Please note that you will disable a check that is finally able to fail
the build for a whole class of very subtle percpu bugs. This
functionality was discussed and specifically requested at [1] and [2]
by Thomas [CC'd]:

--q--
Coming back to __percpu. As I mentioned in the original thread it's a sad
state of affairs that the only way to detect the __percpu fails is sparse
or some other static checker:

      https://lore.kernel.org/all/87bk7vuldh.ffs@tglx

But that's a different problem to solve and does not invalidate the fixes
which come with this series in any way.

If the compiler people would have provided a way to utilize the anyway
non-standard name space support in a useful way, I could have spared the
time to bang my head agaist the wall simply because this would have failed
to build in the first place long ago. That just makes me sad.

After wading through this, I really ask the 0-day people to push hard on
any sparse fallout which involves __percpu. The resulting failures can be
truly subtle and not necessarily fatal right away.
--/q--

and

--q--
I did not follow the __set_gs work closely, so I don't know whether Uros
ever tried to actually mark the per CPU variable __set_gs right away,
which would obviously catch the above 'foo' nonsense.

I think this should just work, but that would obviously require to do
the type cast magic at the EXPORT_SYMBOL side and in some other places.
--/q--

[1] https://lore.kernel.org/lkml/20240303235029.555787150@linutronix.de/
[2] https://lore.kernel.org/lkml/87edcruvja.ffs@tglx/

My proposed "workaround" patch (quoted above) will fallback to
generate a preprocessed source that both, sparse and genksyms
understand *without any loss of functionality*. This exact source is
what these tools currently process, and as shown in the message trail,
the proposed patch fully restores the existing functionality.
Effectively, genksyms would generate the same CRC if it would match
typeof_unqual keyword with typeof and ignore __seg_gs keyword.

The effectiveness of the check can be seen in the pull request for MM
updates [3]:

--q--
- The 6 patch series "Enable strict percpu address space checks" from
  Uros Bizjak uses x86 named address space qualifiers to provide
  compile-time checking of percpu area accesses.

  This has caused a small amount of fallout - two or three issues were
  reported.  In all cases the calling[sic] code was founf[sic] to be incorr=
ect.
--/q--

[3] https://lore.kernel.org/lkml/20250330165732.f4c1493615375623f67e38eb@li=
nux-foundation.org/

The patch that disables the above checks trades enablement of this new
functionality for the request that genksyms (and sparse?) fully
support the new keyword first. A workaround was promptly developed
that allows the external tools to work without any loss of
functionality, and allows these tools to be independently improved at
any later time. Please also note that genksyms is already partially
obsoleted by and substituted in allyesconfig by gendwarfksyms, this
was the reason the issue was found only at rc1 time.

Also, I don't think that the issue falls into the "brown-paper bag"
bug category at all. The unfixed source results in a minor loss of
functionality (percpu symbols are not versioned), was detected at rc1
and promptly fixed (worked around). The issue can't be detected by any
standardized approach (allyesconfig compile), and for the core change
of this magnitude, some fall-out is to be expected during integration
(rc1) time. FYI - more than 30 patches were needed to fix percpu
issues in the kernel source (many of these issues were not found by
sparse) before checks were enabled and the enablement was already
postponed for one release to fix an issue, triggered by some extremely
dubious usage by external tools (rust).

Based on the above facts, I'd like to ask maintainers to reconsider
their decision.

Uros.

