Return-Path: <linux-tip-commits+bounces-4986-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FE9A893BD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Apr 2025 08:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144EF1751E4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Apr 2025 06:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48C2211299;
	Tue, 15 Apr 2025 06:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JybAhIuL"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DFF18A6A9;
	Tue, 15 Apr 2025 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744697826; cv=none; b=fgaa2/Klw/lCmsGz7OpFww28p0qv+swBN7aFKunnHpihqXuy0MB2FmM2aF1AJRVMj1fvdIfCTZ549mr94mNhTtMNIkXH/n2gGDLxyL2uVk6XBkrG+J2kMV7eFPZsRL5fe+qhDMqJlVoAwSnhzG+K4JpLTseWGzc+N7bclq3EyZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744697826; c=relaxed/simple;
	bh=14o5+/rPRNUSc5/tPisvurCwfLOCXGtfSja4B9Ey210=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1mF/jjRZl4oE5f84XyzKRJmEeMDn/msJckZEt2O2M6LcjQBXOHmheoPfnYHA82vWeH9t47HbQ2J25HDR3gJ6s6ew+gcUpRY13wa6jUA/hLfnKe+hvyhtYdlLqINiFvAtw3koIv02i/8EYZYPsmesR3ZO0vDcCJ6PjaFBglUPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JybAhIuL; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bf1d48843so43868861fa.2;
        Mon, 14 Apr 2025 23:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744697823; x=1745302623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14o5+/rPRNUSc5/tPisvurCwfLOCXGtfSja4B9Ey210=;
        b=JybAhIuLcEGUS4Ty9Rg3zZ+S+MgUpuMfuFzJFEDvtxlRrFlxhWUVs6rIc/DG4yjv0C
         nHOuKEEhfV80dsp9AZWmGRqFiOnqqU8ZXONN7MpMciKeo3J8AJAGONN6+LzflFMxncce
         Ybh6yRdTl6H+lLz++2mzE/QIP5QCBgCQC+8nLlP//8MM0czl4Nq2PpFQ+lasewZZCI8Z
         BJNiLYkOkYrTzeHFqrKoUKxxADa0xz0HYaI7UtYQ1pAQEu32UNTXDcyNH+9ngWOF+xmf
         LoAqMkVBs/Nmqu84yNSpjzVzHMM9r+kRst7CwCC7LL/JmwwJVRV2CVXNQcuJLbfp2rOB
         lQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744697823; x=1745302623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14o5+/rPRNUSc5/tPisvurCwfLOCXGtfSja4B9Ey210=;
        b=bRVRakNTGaNYPHnc0v767gR8j6uoS5fiYuOOjsyi0IxN8BLwIobjUH742lBr6eBIuG
         F+PMhRspbkTsIfGGzAMju8dweHOMh+wtvQ7ffYMJKdhJe3t6jhkvxCehN7i5Q4N9K2uU
         A5MuZN7FGZi456mrwN4eylJQiS2dWuhMsMftHWhMzdogoELFqs2YgJGtHQjJwewH6Aru
         uYaj8e9f7i04V1/FwbrqqYMNon6xoWKwScn0reyewsypor0PjuoAa0Cp4AiWNWx+f5ZT
         u6ghvxwj0LjA/HbKbJSBqcLkxAy9ftOSpFhodyre4BJyI/fWvzVDcL8oL5VR0JtKob7n
         pZgg==
X-Forwarded-Encrypted: i=1; AJvYcCUE3SnAA7x02sLxd5AVqZGx5VLrahoE4rRM9A1FwrgmG4G5fGK8FXQrN0IKoIXLJ5x7RGcgFxP+uzKBh8o=@vger.kernel.org, AJvYcCUJbzOI1AjZ9ZTXc1WXNd2X6WbLZDmEbTUti6/P2MHVQaPYqy9/FT/5kN5/hFMtvbyfK/O+Z5NmSBcuXkDM75sC9rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPmsCywwiPeAPpaKQdhFvnu6qWVif6HMN78OKlRtOCyKdGlZUm
	6E72kulpvz6/FFSPai/9jj3l5OleU6OkAqcC1Hkl8qOaTprcIb18QcrJI5HQbmrZnvlXS8VQFQC
	nj1z7KrH8EXzd1jUGGxH6RhIGha4=
X-Gm-Gg: ASbGncs8tnruU0e8fsTmUkq0RScyKmWPNytXf4O7Tqlrid5+pXYdCk0dF0w5TJmg7vi
	pUk3B3ad9aj/bX4S2IuBRvX+n1oPkozNLVRY/XgLbQ+MyfFhDVp3P9Qpyu2pPpJo7XXl0qnfOrX
	WtGu0CNmdyC2m4dHnqERBWmw==
X-Google-Smtp-Source: AGHT+IFDRgfCx4zdnCFN4jix8GVMsmPDba+WEwhclFcXgG1NE9K+WIxonDPVN3Cv91Mfe1j688Kq9/qIp5YU91jbxqE=
X-Received: by 2002:a05:651c:220a:b0:30b:edd8:886 with SMTP id
 38308e7fff4ca-310499f5dacmr46680681fa.9.1744697822644; Mon, 14 Apr 2025
 23:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404102535.705090-1-ubizjak@gmail.com> <174428272631.31282.1484467383146370221.tip-bot2@tip-bot2>
 <20250411210815.GAZ_mEv8riLWzvERYY@renoirsky.local> <Z_oqalk92C4G6Rqt@gmail.com>
 <CAFULd4bTd6GMftLBX7Nu0xftini00o4v7=1XfuoDC8ydUr9Ueg@mail.gmail.com>
 <Z_t7_brzSoboOsen@gmail.com> <CAFULd4ZBbAG4ndn+rzjjqF+pmtGa3UbyDOWfEXww0XhExJByVA@mail.gmail.com>
 <Z_wI0uNoG2G2TQMC@gmail.com> <CAFULd4b2afcu5PnxhqwwepwWMSA7mvYNyPnMtkCjjT84VG8VXA@mail.gmail.com>
 <Z_wOYOrVJJkUUUF9@gmail.com> <20250414182057.fe2fc32273ca1520c9b5dd4d@linux-foundation.org>
In-Reply-To: <20250414182057.fe2fc32273ca1520c9b5dd4d@linux-foundation.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 15 Apr 2025 08:16:51 +0200
X-Gm-Features: ATxdqUH6F8RrUNX5r2VRC6HS0yoSNbzfnBSgkjnh9sqT5xjH4_eBMJ2syY3oV-k
Message-ID: <CAFULd4YOGgH39+Fge=N3M0jKzchg36005ZYss_qPD_0qzQ2scg@mail.gmail.com>
Subject: Re: [tip: core/urgent] compiler.h: Avoid the usage of
 __typeof_unqual__() when __GENKSYMS__ is defined
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, 
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Paul Menzel <pmenzel@molgen.mpg.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 3:20=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sun, 13 Apr 2025 21:20:00 +0200 Ingo Molnar <mingo@kernel.org> wrote:
>
> > > > > If this commit is removed, [...]
> > > >
> > > > I did not remove commit ac053946f5c4, it's already upstream. Nor
> > > > did I advocate for it to be reverted - I'd like it to be fixed. So
> > > > you are barking up the wrong tree.
> > >
> > > If the intention is to pass my proposed workaround via Andrew's tree,
> > > then I'm happy to bark up the wrong tree, but from the referred
> > > message trail, I didn't get the clear decision about the patch, and
> > > neither am sure which patch "brown paper bag bug" refers to.
> >
> > It's up to akpm (he merged your original patch that regressed), but I
> > think scripts/genksyms/ should be fixed instead of worked around -
> > which is why I zapped the workaround.
>
> I'm OK with the original workaround - super simple and fixes the issue.
> I don't know if Borislav intends to upstream this, so I'll grab a copy
> also.
>
> Nobody has commented on Uros's more recent alteration to genksyms
> (https://lkml.kernel.org/r/CAFULd4aLMF_2AbUAvpYw+o1qo6U-Ya_+Ewy-wW17g-r-M=
BF9_g@mail.gmail.com)?
>
> Uros, please persist with that approach and hopefully we'll have a
> patch which removes the temporary workaround.

The genksyms patch was posted as formal patch submission at [1] and
was accepted to -tip tree. The genksyms patch obsoletes compiler.h
patch [2], so there is no need for compiler.h change anymore.

[1] https://lore.kernel.org/lkml/20250413220749.270704-1-ubizjak@gmail.com/
[2] https://lore.kernel.org/all/CAFULd4aLMF_2AbUAvpYw+o1qo6U-Ya_+Ewy-wW17g-=
r-MBF9_g@mail.gmail.com/

Thanks,
Uros.

