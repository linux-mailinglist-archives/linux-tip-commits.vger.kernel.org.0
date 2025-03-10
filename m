Return-Path: <linux-tip-commits+bounces-4110-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E068FA59A91
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 17:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049CE1888E92
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8C722A7EB;
	Mon, 10 Mar 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnXAnM/8"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5861F227BB5;
	Mon, 10 Mar 2025 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622461; cv=none; b=l2y/WKhre89XA+rFgc5k/AbU03UxU44tJNvBGbtSvzSwvbe49N4cMLh1p8ZinlVGMfT0ggoBTpbb3cPNufvNqSOe7cWfFVIU3zjwrf04PM3nPrOtXpSxt1yBFZ7aAy8Zu4edoKBeQ3JeW+grABi5roIvJJqMZss43voLTCW7hoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622461; c=relaxed/simple;
	bh=mz7e+DwnGEi0ZbMOIPk0d2pyGa8YuaSQhtow3eIM53g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3NFPzWfXktVoerK6706Bbku4O/JQh8jFZ713pIDZJJURVgziaFBdSOe0bnLNmKrGwYiWWLWjB4OFNGZvzkwVbwfApKjMOrUmT9UQu8tOhPm/eJDIbsadi9oVCiLUxbzTakpdRRdp8ljdYkWlQzRD+GI1Kw1bsM10UGJnlWlE6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnXAnM/8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-301001bc6a8so9562a91.1;
        Mon, 10 Mar 2025 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741622459; x=1742227259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zZBaSde5BDm2iUrwQj9zdT29C5q6BzjamuIxH45kT4=;
        b=KnXAnM/8nzktazxxJpNhuqJLd8KbavK+85pnVgKLPjdBlmNMrC186usEH5kbQzmVyF
         nHmTyh19OKrUBLCbSYPFtuO6zQiLmdlaFqu6VfSgzGr1VycDAQFJ0Bv8i55BW6fhBCx4
         VH562b+i7f/kTwaHEYjW2p3fucrCojIwsmdP9gL0rsRcMz7A914Oj7p8ASfBp86J79iK
         /UiNtrmIFRDOF7Qs4rJwhKAXOPwEAWo7si4iwoKDG4hrPkMjs0ZUMAwe2lB9fI8PkzrV
         gywW5cSwIHzdV/arouMMjf/n2HJI6YYyM0SHud3cdpf5hV/8MrO8sdfLm18xfGLTL2UI
         l+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741622459; x=1742227259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zZBaSde5BDm2iUrwQj9zdT29C5q6BzjamuIxH45kT4=;
        b=T3gx3M17SsiORGFky7iwRRZiKLxvJwY9UExA3gZvicyfoNuPvwlIZCpFpzJ9i+cXyu
         d1oyPxViJDzVU4C1w+OYpAdC8yd0bPC6e4RWgkPuPT5DOu5/pnaT3TK5iqoImoKaRL21
         IYHy3GdCvrMe16wKSvRW7R5jvu+zC3we+6S+PYdIYzF5rPx5YFBRcMS+P0AwmbyF4z0x
         ImkEQwZpryJSNGNfHv1EVWhDwduHvd80n+zDWJ29eb48OI5XJDLD0UKvFHo+IOQhco4J
         7Bnz8nU8i7Yun/LmlDJexcmnZICthu+W6MxzMW/AbbjYE6gh5SNgWfoGgPzV3TX2EjOP
         zMVg==
X-Forwarded-Encrypted: i=1; AJvYcCV8r/eHG5BIhdgq13Bf/nFHxkq4c9S5Qq0MOh7QvY/8/xJFnP7myLFezo64WrlKYWJFuo9Qlwp3l18vsIEplO6YFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3jh4S9fNiqn0PhiXF98Cqs+NTagN8YnRynv2A290C3K1ApXTe
	UbWJUscrafAOPD6j4dzv8DrmQHlNiDV2I0yHZBWqbhQZ4YbAF2+0UrVL7qq9sNwW5Ba6Nsjd1CW
	rsSGV5RwRwVPRwWx+msHBi4DbvAk=
X-Gm-Gg: ASbGnctcc/43OPzJbaNvtFGQ5gmNfTQtB4rBV3lQPtqVd1IzrWpfZ4sMvayGuuPubtb
	1PJ1bL6wl/fsPMhWs1MqraAriohHbkJjh6XOrfwUn4n6MzEuuiJhNY5hShi/+5lSay4crbOhFcV
	2OMBvMYjPyIB2MgDr/Op2o5dFzUw==
X-Google-Smtp-Source: AGHT+IGUT+lwFvvHh9DxFp/evRyCtc43rNwXVv3kIVt8aG9wUooVO7R3xngVyEL0TltRIXFVEVRjTkyOK4us/gpOr3I=
X-Received: by 2002:a17:90b:1a8f:b0:2ff:4b7a:f0a4 with SMTP id
 98e67ed59e1d1-300ff8b9c82mr141206a91.3.1741622459338; Mon, 10 Mar 2025
 09:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224124200.820402212@infradead.org> <174057447519.10177.9447726208823079202.tip-bot2@tip-bot2>
 <20250226195308.GA29387@noisy.programming.kicks-ass.net>
In-Reply-To: <20250226195308.GA29387@noisy.programming.kicks-ass.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Mar 2025 17:00:47 +0100
X-Gm-Features: AQ5f1JrMVR5D2io-jpxIYwEZZnkZnNoP44hiVSLAuqjgKpDzteU9AB2q6JKAJLM
Message-ID: <CANiq72=3ghFxy8E=AU9p+0imFxKr5iU3sd0hVUXed5BA+KjdNQ@mail.gmail.com>
Subject: Re: [tip: x86/core] x86/ibt: Implement FineIBT-BHI mitigation
To: Peter Zijlstra <peterz@infradead.org>, Ramon de C Valle <rcvalle@google.com>, 
	Matthew Maurer <mmaurer@google.com>
Cc: linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	linux-tip-commits@vger.kernel.org, 
	Scott Constable <scott.d.constable@intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Kees Cook <kees@kernel.org>, x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 8:53=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Feb 26, 2025 at 12:54:35PM -0000, tip-bot2 for Peter Zijlstra wro=
te:
>
> > +config CC_HAS_KCFI_ARITY
> > +     def_bool $(cc-option,-fsanitize=3Dkcfi -fsanitize-kcfi-arity)
> > +     depends on CC_IS_CLANG && !RUST
> > +
>
> Miguel, can we work on fixing that !RUST dep?

Thanks for the ping Peter -- we discussed `rustc` in the couple PRs
that added it to LLVM back then, and I think the conclusion was that
it shouldn't be a fundamental problem to add it to `rustc`.

From a quick look, the Clang flag that eventually landed just emits
one more `llvm.module.flags` and LLVM takes care of the rest. So it
should be straightforward to add a `-Csanitize-kcfi-arity` in `rustc`
and then pass it at the same time to both Clang and `rustc` in the
kernel.

But I may be missing something -- Cc'ing Ramon and Matthew, since they
are the ones behind sanitizers and kCFI in upstream Rust.

I added it to our list, and created an issue in upstream Rust for it:

    https://github.com/rust-lang/rust/issues/138311
    https://github.com/Rust-for-Linux/linux/issues/355

I will also mention it in the meeting with upstream Rust in a couple days.

Cheers,
Miguel

