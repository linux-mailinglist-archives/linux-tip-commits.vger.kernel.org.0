Return-Path: <linux-tip-commits+bounces-4924-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14820A871B5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 13:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8056174A55
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 11:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD29178372;
	Sun, 13 Apr 2025 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsyT8YFx"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B23D984;
	Sun, 13 Apr 2025 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744542347; cv=none; b=JQonkhpAN5cmW90RQMxpLSVfqhG80X3vB7rrEqT4i+1yLvl/A6BSDHPbnlJH31qe8CHM9d9h1chn05vlnldakFaMlzkfL5IZ0AKsK51DSV+0WcCVb2Bl3lYAYG0U59AfjnvlsXCq9LhBa3YlDwKNQe6CTtTVPtTdRa1gQ4UrcbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744542347; c=relaxed/simple;
	bh=EV9bLyLiQgj0zexCh0MFMFqodFrGWYJwodYnlnMhZLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKlGsKkwQnUuKWMWXP/PStLd0RrabJ4fyAhFD0wgoFLZgzE8norfH7czdNSogkORsLd7c/lx1w4ZaXwAdSewhX5wPHd3kRZFFU4n/5+sq0tY+tzm6jx9Y/rk4Eu99QbkJXHgFGluSNyCBKGMcvYp3D4WV8lsPhJtLQ6uGPIFChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsyT8YFx; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so30371241fa.2;
        Sun, 13 Apr 2025 04:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744542341; x=1745147141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkvNYBoz6k2ClpzWrXDmwkMOqKn26OBPjmJazQv/740=;
        b=YsyT8YFx2arzi69xg3UhB9TFuUHQkwjHtSNYGjNhsGimSN/aNjmd8ZgLOA6i3sZz0q
         Gwc9o09ctjByVWS76rYKPcuunQJL+pi7+EqLAyKdrWBzh/CibvGlgJdVbIeNnEYMBN5Z
         0fYCrKMpJt0AqFcDh6HhxP5K/34VNoQUAStMFR+Y72+SlniJ2y3NLm3/qrXMJ8wtt4vP
         GN+e6ebzWnHXyF5JoIuD43M59VSW/N4lWWJPe9BixvDrCUZcxhjkl3T/NjEynqwmS5wD
         GImn67N2Ue8AATpFQUDpq1plBkAU0UkYICr9bGp/kVbLlGQDND/Qlpoq1ct/RWZviQNe
         Lv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744542341; x=1745147141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkvNYBoz6k2ClpzWrXDmwkMOqKn26OBPjmJazQv/740=;
        b=EaDskyMaONe0Ez3iaYt/qVgt268J3eVMCMHIhurPxtFc+dsiycOD//C1TtqkGxSkKr
         XeF/EZCCyAqCVcdcfQc4cya/e9hMQHlSVsiBddEns7q8inzAcoehxSXJ8HNFUgJMoQDE
         vN8gXmF9b/kVvnMCJz1zgXQ6+wOBesFTtHOjBNEd90jmcCNb14p3n5PE711sK0FFL2L3
         kmstZ6vmM+bsMn3UOl5DigKaExWJFLI3zZbDgiXIMqRfzo8PV2jvAZo0ujGKruAjUFEG
         dpHV9yBQ++dWsGGxdPsXUeCvW//kib8Fy62sN4xbifFRiZSxOJ7aFUuhb2AtZWTIGKmw
         Kz2w==
X-Forwarded-Encrypted: i=1; AJvYcCUIki6Uxz0ZFUzfD1rFI3d30xu7n5074iJ1SJE9eXWIfNNl1SNP/n8KUluPH2wZ3HFYTj2l7dgELNEKxkPDqGHKvwQ=@vger.kernel.org, AJvYcCVJ9vZwZAJqod387fdoMYCvVP/MhliCZPb/J9ILylvDgIdoJB0LATYM7f6FWhEZSR3zmOzJvsq8xHFIAUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoRQDmFHM5j+YpmjfP7uYqhfMnGIlfGvJoiRBRxKDSv++PntRF
	LbsFcwjCjqoWpyp+gdOsO9p9355WacdCmvtl2k2kIQrqOyL501tH7CKObu75Vmvc//dMbIY0Eyf
	OnaU9eWapzpkC8U/1VNAmnM17a34=
X-Gm-Gg: ASbGncvNVhXpwVi3BWxtLRFEKMtfGczrNNY3wPqa9ac4khKwE1Ub+5MlTwWqKShAiVB
	g6GK/G+KZEZWuyF3WL1q0U5OxGNg5SXNIsR1p2SXj7F5OANI97+xi0qTtNnBDlbNuprvSo5vWVA
	w6p/81ZhRbCG2aZ7WFJJmIEA==
X-Google-Smtp-Source: AGHT+IE+3xZedj/wAdEhMdffMJOiAt1C8sFv/sZjpWcXyGPZaEtX1HJiJGzPumy5i74aYPSbEbYeiSEBJlak0KH3eL0=
X-Received: by 2002:a2e:bccc:0:b0:2ff:56a6:2992 with SMTP id
 38308e7fff4ca-31049aae557mr28609261fa.37.1744542341186; Sun, 13 Apr 2025
 04:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404102535.705090-1-ubizjak@gmail.com> <174428272631.31282.1484467383146370221.tip-bot2@tip-bot2>
 <20250411210815.GAZ_mEv8riLWzvERYY@renoirsky.local> <Z_oqalk92C4G6Rqt@gmail.com>
 <CAFULd4bTd6GMftLBX7Nu0xftini00o4v7=1XfuoDC8ydUr9Ueg@mail.gmail.com> <Z_t7_brzSoboOsen@gmail.com>
In-Reply-To: <Z_t7_brzSoboOsen@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 13 Apr 2025 13:05:35 +0200
X-Gm-Features: ATxdqUGWXrSVpNoq4j9UTjdP7mOIN50cyDABESN7VeGqLifRCKOOVVt6I2mcImQ
Message-ID: <CAFULd4ZBbAG4ndn+rzjjqF+pmtGa3UbyDOWfEXww0XhExJByVA@mail.gmail.com>
Subject: Re: [tip: core/urgent] compiler.h: Avoid the usage of
 __typeof_unqual__() when __GENKSYMS__ is defined
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 13, 2025 at 10:55=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > > Yeah, agreed, I've removed this workaround from tip:core/urgent for
> > > the time being - it's not like genksyms is some magic external
> > > entity we have to work around, it's an in-kernel tool that can be
> > > fixed/enhanced in scripts/genksyms/.
> >
> > Please note that you will disable a check that is finally able to
> > fail the build for a whole class of very subtle percpu bugs.
>
> I simply zapped a commit that was applied two days ago and asked akpm
> to resolve a regression that was introduced upstream via his tree
> through this commit, in this merge window:
>
>   ac053946f5c4 ("compiler.h: introduce TYPEOF_UNQUAL() macro")
>
> What 'disabled checks' are you talking about?

Percpu checks require TYPEOF_UNQUAL() macro, so removing
USE_TYPEOF_UNQUAL definition will skip the definition of __percpu_qual
in arch/x86/include/asm/percpu.h (please  see
6a367577153acd9b432a5340fb10891eeb7e10f1), and consequently __percpu
macro won't be defined with __seg_gs (please see
6cea5ae714ba47ea4807d15903baca9857a450e6).

If this commit is removed, then the compiler will fallback to old
declarations of percpu variables and won't perform percpu checks
anymore. This new functionality is implemented in such a way that can
be fully disabled in a couple of places, and not declaring
USE_TYPEOF_UNQUAL is one of them.

OTOH, my patch avoids __typeof_unqual__() only when generating
preprocessed source for genksyms. genksyms uses this preprocessed
source to generate CRC32 from keywords that declare variables and it
is perfectly OK to use "old" definitions, without __typeof_unqual__
and __seg_gs keywords; there is no loss of functionality. __GENKSYMS__
condition can be removed once genksyms recognizes __typeof_unqual__
(and __seg_gs).

Everything else besides "sparse", which already uses the same
fallback, handles __typeof_unqual__() perfectly well. This includes
GNUC >=3D 14 and clang >=3D 19.

Thanks,
Uros.

