Return-Path: <linux-tip-commits+bounces-4122-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5A6A5CEFE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Mar 2025 20:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C571892CC2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Mar 2025 19:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D162641F5;
	Tue, 11 Mar 2025 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOfCouex"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C23C25EF8E
	for <linux-tip-commits@vger.kernel.org>; Tue, 11 Mar 2025 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720177; cv=none; b=jwrxJVAS+UufFvdtNTsl2kOPnUGaioOiPO1SNmkJvyEPzWiHrsyOqXUjM4BhjJ/ooNHkducvc8NpTkK2jQiFRroVJ5FxfIzSsHpFEXye6sisqFqjYgE90AJHiumjT9FsfbErh8JGQJ/4/xSRVOjJzYH30beDVguI+sWXUd3TOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720177; c=relaxed/simple;
	bh=MT4KIEXDYAda2ZPIqFmDaXeAzKgL5BjwsOEQyMFsJW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eoUFobR1M0k5Z4P5yCtlg12IBHftRhvyrsAVrg2R1DxmarE6usesyMmtz8DyDCCLIy23RAa1+qq/SfGaNI/7U3h8aoPS6wyoHh9MyfrZ+8yKfigA5mHNaPzto5ZSXTEXV4yC40AA4zJ3lknCHLu+cKqrhWRHvE4IC58PcrmC8R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JOfCouex; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476693c2cc2so64241cf.0
        for <linux-tip-commits@vger.kernel.org>; Tue, 11 Mar 2025 12:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741720174; x=1742324974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFAEU/m42kolI7o2UBtagA4X8ZayRpTZW4FmPY5DRL8=;
        b=JOfCouexykl6rJAht6yMLmvKxaZ/9iPwl7WRacSc32pnjZ0fUL+3Z+9OFL+sgheBEB
         DXJARGySpAM7dHvU5lVP7tDZa66rFq+aazWSNC7GQx/eRORir+YbZZ95xUXvRSf3mWUT
         N5VX2CrAJx2d6YK+VbUrai4jsgJx28CVt7IFaSNXQNy7dbAjZPiGbBykPTYDHUtr5qTR
         9c2wkch6rUhr+kLQOgV131zkYDhL0sxCA2IZJ6LHj2pSQQEG/5IpiXZbSNRlJXej8ffs
         4pKwIjLvdOu5PIXLTUBbjJa3LRDeTza+5WRW6K0qP+3vzgtHn338plmNQ0XNj3Ny4XKo
         MrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741720174; x=1742324974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFAEU/m42kolI7o2UBtagA4X8ZayRpTZW4FmPY5DRL8=;
        b=KHWSX6MaSgaUyUywIZ+2vsH750D5cM6WtsJ3fTKuEjo+SeRjT2uVgHWe2Z8eQo/skv
         qjB/4CGb8SN/rUaJFIt1mknctJt7gXCYUZgTNZ9IucSZoBIq9nCc5WggvV/ml3WAyXHw
         p5AuLq/37nfiN8Yh0IJH4CXW+aTtYobPn6PYzlmwff/VzkcLFt0JTUt3G/xKmEP0ZXyU
         8LKKXA6lit52SMDpevtVcsaMOnt6ulUX96HLyjXYtdXneVIEkmXyGPt1wFixPS6D8AVY
         /BPbtLDttLnqsdLzcrThmgOGn2gwjb4vlTRLKrqNNYUXNnnOMzqSkRuR6tPfE6bV4pxV
         Ht5A==
X-Forwarded-Encrypted: i=1; AJvYcCVtESulFh+YUfx+1XRG1CAONa8XTqaWBiGDs/c/PhzWWh/c4ms81M6T9D76l4QoGT2VxcEv6U+pC9L7IQp7gkYc8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxmZQidbkz/uqAA6zbjiVpCLR5SjtCPjtY5uxHwKxowsQ57jS9
	N6WmcWchSOd6joKBEbtqbI/lqi4dDlf06sSguua7h5CuEgm1mPO0rpDCsBHJiTYPp/+TiZiQ7zu
	bG9m2QnKG4rfPJHgEDvlrkZo+ei0hGTPRAhjp
X-Gm-Gg: ASbGnctvjPDeMIKyVwJWaCmZGIscrt7HBR62Kqj1C7QwID4Ud2jmBsO9P2ySs6LA1Pt
	2AqGpTL8vUgVk13ZiWcuCwbV0lL4htK3kPBhOO6rMzZ/nTeEAeb8vQIlkgKlHaP+SRTbjBNipU+
	zhhdwHzlmN04auSNW8A3I3foPuS4vxxo63zhudhn2Th/qI+OKr4tpvzcuN
X-Google-Smtp-Source: AGHT+IHC917nAvWIA/Bj5kyqPPfwGwqj9CH/w5Z0oWa/lQ+m7IY3UUlwjuwuqez0X6+HZVxKqmjsaUkxOVHXJsK3yVs=
X-Received: by 2002:a05:622a:87:b0:475:1416:5cc9 with SMTP id
 d75a77b69052e-476ac43023emr739401cf.10.1741720173802; Tue, 11 Mar 2025
 12:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224124200.820402212@infradead.org> <174057447519.10177.9447726208823079202.tip-bot2@tip-bot2>
 <20250226195308.GA29387@noisy.programming.kicks-ass.net> <CANiq72=3ghFxy8E=AU9p+0imFxKr5iU3sd0hVUXed5BA+KjdNQ@mail.gmail.com>
 <20250310160242.GH19344@noisy.programming.kicks-ass.net>
In-Reply-To: <20250310160242.GH19344@noisy.programming.kicks-ass.net>
From: Ramon de C Valle <rcvalle@google.com>
Date: Tue, 11 Mar 2025 12:09:22 -0700
X-Gm-Features: AQ5f1Jq1r4Lml3jLS-NMmbFgi85kOdzC-wdrdZA59dLGP6T7oPwNiU2pQejz1Kk
Message-ID: <CAOcBZOSPBsTvWFdpwE0-ZU76yMDGBEo3p9y614XYEu+ZSnQ6Sg@mail.gmail.com>
Subject: Re: [tip: x86/core] x86/ibt: Implement FineIBT-BHI mitigation
To: Peter Zijlstra <peterz@infradead.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Matthew Maurer <mmaurer@google.com>, 
	linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	linux-tip-commits@vger.kernel.org, 
	Scott Constable <scott.d.constable@intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Kees Cook <kees@kernel.org>, x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 9:04=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Mar 10, 2025 at 05:00:47PM +0100, Miguel Ojeda wrote:
> > On Wed, Feb 26, 2025 at 8:53=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Wed, Feb 26, 2025 at 12:54:35PM -0000, tip-bot2 for Peter Zijlstra=
 wrote:
> > >
> > > > +config CC_HAS_KCFI_ARITY
> > > > +     def_bool $(cc-option,-fsanitize=3Dkcfi -fsanitize-kcfi-arity)
> > > > +     depends on CC_IS_CLANG && !RUST
> > > > +
> > >
> > > Miguel, can we work on fixing that !RUST dep?
> >
> > Thanks for the ping Peter -- we discussed `rustc` in the couple PRs
> > that added it to LLVM back then, and I think the conclusion was that
> > it shouldn't be a fundamental problem to add it to `rustc`.
> >
> > From a quick look, the Clang flag that eventually landed just emits
> > one more `llvm.module.flags` and LLVM takes care of the rest. So it
> > should be straightforward to add a `-Csanitize-kcfi-arity` in `rustc`
> > and then pass it at the same time to both Clang and `rustc` in the
> > kernel.
> >
> > But I may be missing something -- Cc'ing Ramon and Matthew, since they
> > are the ones behind sanitizers and kCFI in upstream Rust.
> >
> > I added it to our list, and created an issue in upstream Rust for it:
> >
> >     https://github.com/rust-lang/rust/issues/138311
> >     https://github.com/Rust-for-Linux/linux/issues/355
> >
> > I will also mention it in the meeting with upstream Rust in a couple da=
ys.
>
> Thanks!, let me know if there's anything I can do. I'm happy to test
> patches.

I've submitted a PR for it:
https://github.com/rust-lang/rust/pull/138368. Let me know if you're
able to give it a try.

