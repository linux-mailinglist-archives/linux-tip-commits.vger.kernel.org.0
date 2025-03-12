Return-Path: <linux-tip-commits+bounces-4134-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E9EA5DBB4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 12:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CFA3BA19A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 11:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E144B2405E5;
	Wed, 12 Mar 2025 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNKyjftN"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BA123F38E;
	Wed, 12 Mar 2025 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779416; cv=none; b=CC8vn7Hch5flE+YsLw21vUUeQm2qtHyOdbCNOh9y9Vjk1sN4XZsbCZHP8wq0X3DvK3hfnO7uZkrm8QhbiR6gILA+LVWljWwwKnKRinXDaesb9OLiUPPM76DC7+gdNhPuw8YETsCb3FEfoSstK3b2t4BluHeRzaj3W6B4z6oPAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779416; c=relaxed/simple;
	bh=gknEh2t/Je3Rn3xjD+1SZpU4HNy9nSnVGJ/aaMZ0Ecg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wx5Tp3ntLyWoe5aboAzjwNIs+jql4+BWFqhhuVVqzeW+suK+7lVfY6aBJVb3WUHc8joAfN35tANop/Ci0cqICWxrZv9pZut5FJ+gqVKiAWfoxfjU2+T46075ySp8KkrV0agy0zTdde2lhM2ASpQlbPu//vBWCCtsAiXpHtkDIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNKyjftN; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so1751704a91.1;
        Wed, 12 Mar 2025 04:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741779414; x=1742384214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gknEh2t/Je3Rn3xjD+1SZpU4HNy9nSnVGJ/aaMZ0Ecg=;
        b=lNKyjftNloIjlsjeTRPqp3XTG5gE4YWblcdl1DnnXlZATJVt4IVro1MZHd+D2kKyu2
         dI/IuV0AB+VT/UDG0txP+tFHMMbuuh06gvhlsTmLR3Lc92UK3tSqDyI6VO9nynx2hCkt
         cW1JGhLcPXEJZsQJnX8QFpj3XuXLE0y7qUvBbIc+fSX2Pc+LKKAUyPAYDlkPzI9+RGNl
         LQeUofa1smf9DgZiNHlFpAbm3OJfjliA6r6udZKkPTy9p8gf+lAAfcKqYfaZhLTi4RSu
         EmQNCv/RFqR+FpuCAuGjfI6wILK8MA2jYhKzjLT56lJ9TOINiv5xVCkuu7Y9YQGS0z3z
         Sg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741779414; x=1742384214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gknEh2t/Je3Rn3xjD+1SZpU4HNy9nSnVGJ/aaMZ0Ecg=;
        b=OMGORJuCkuJfH2voPpdkProV+1YVZvBLO4Z312LJVpEboVab+gfLl3cDYMlfhAEWyk
         3JZx5zEw5tSeCfoUgQkpEAiC5mVDvoKEqE177c5t7EwG1nQkNMYPV2zk2TXLTT9MvCLa
         qD9hqWptpbQZ0XdHd2QBfkCLnbSx+Jjs00ZetEarBiAM68vNFnGp8EZlg1zB4vIeLM5I
         EnHrr8aKWFxLXKarmwI+Hvog2Kf/0oI0a+o7mk7hE10plV5wbDMDAlLwpH1HHP37r9p3
         bV1M4O+VNKmPsd6h8B8V76hqnNHxFELOkeEqFg0KPvzm7sQV8KBbViI+4uvRzpqYHFwN
         OTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8LPTC6VkK0xkeXIvGPksYS5qB365eq3BehtIB2YrZA3qKNBGGXXXLt45D+netU9YEm2fqJkirMWrjiQAJ26pXaQI=@vger.kernel.org, AJvYcCWmhdh5/jwUIVWWAKwrfQjRG1E1sfK598EUGtrFZzcbGWo1/+tUJsrEmWbCTKN+anVNpk7c7xD4fal3szQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YypiThAtP2dPVIlG32LqWw2p6tUSf35aS+3WaMwJDIjtjVMrHp1
	nrPLO2cnFOJZBNrRnez5TZXDUTMv5FkzAtBt5hgzkjsq5JSE+6Yd2lmhbVAjMOvhEn3jU7JfSyn
	Thdn+R/rAQIUFMRou0R8Z7+5GEyE=
X-Gm-Gg: ASbGncvET9yYdf71a353J1JemeUdaS1TO/N1ksV1ar4Jwree8hLLfZJbUX9st+oC8cy
	RV9IyxfLX6ZclXCqqj4t1aVbkSUJmi/Ra6BXAwUPen2E5yHK+PjMBeuiIas7o4H2h2zJvNxubBx
	17ebKUsdeR6t6BQ2fwbtu2u7ngaA==
X-Google-Smtp-Source: AGHT+IEDN2xmhNlHD/KpfAlbk7SO5pRX4Yth6unjvNI0fUm0BIoxX6m646b5DTRt63pZIvK66yoOhveOUoUHNzUZqQU=
X-Received: by 2002:a17:90b:1d0b:b0:2ff:7970:d2bd with SMTP id
 98e67ed59e1d1-300ff9090d1mr3647168a91.5.1741779414383; Wed, 12 Mar 2025
 04:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224124200.820402212@infradead.org> <174057447519.10177.9447726208823079202.tip-bot2@tip-bot2>
 <20250226195308.GA29387@noisy.programming.kicks-ass.net> <CANiq72=3ghFxy8E=AU9p+0imFxKr5iU3sd0hVUXed5BA+KjdNQ@mail.gmail.com>
 <20250310160242.GH19344@noisy.programming.kicks-ass.net> <CAOcBZOSPBsTvWFdpwE0-ZU76yMDGBEo3p9y614XYEu+ZSnQ6Sg@mail.gmail.com>
 <CANiq72mcCEbeWb-RAXLcWRnJms2LA6xV=QqQ5=N3ii=3TC89fw@mail.gmail.com>
 <CAOcBZOQnGCqKut-BTvfJNgB9Rz+f5DAANwMs9DU16Js+QDGOrw@mail.gmail.com> <20250312091633.GI19424@noisy.programming.kicks-ass.net>
In-Reply-To: <20250312091633.GI19424@noisy.programming.kicks-ass.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Mar 2025 12:36:42 +0100
X-Gm-Features: AQ5f1JoWE1IHsvmTAsXyQOhSft5_BwvvABh61PPokhGerXhpR6A5ZQumzZyMbRA
Message-ID: <CANiq72mi62AkrKzre254DDd_VwUsZzEMqNuXpFeY_4AjObrNVw@mail.gmail.com>
Subject: Re: [tip: x86/core] x86/ibt: Implement FineIBT-BHI mitigation
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ramon de C Valle <rcvalle@google.com>, Matthew Maurer <mmaurer@google.com>, linux-kernel@vger.kernel.org, 
	ojeda@kernel.org, linux-tip-commits@vger.kernel.org, 
	Scott Constable <scott.d.constable@intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Kees Cook <kees@kernel.org>, x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 10:16=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> The rust-log-analyzer seems to suggest the nightly build failed?
>
> Suppose it didn't fail, where do I find it?

Ah, sorry for the confusion -- by "nightly" here I meant the toolchain
that gets built and distributed by the Rust project.

To get one, we need the PR to land first, and then we can use the new
flag. It is easy to land such a PR/feature because it lands as an
"unstable feature", i.e. meant for testing and so on only. So we can
get quickly "proper" toolchains (i.e. tested and built like the
full/normal releases are), and if everything checks out, then upstream
Rust can commit to stabilize the feature later on.

That is why I suggested to wait for that, since the PR seemed
straightforward to land to me, and thus it could land soon.

I don't know if there may be a way to pick up the toolchains that
their CI built for testing PRs, though. It is not too hard to build
from scratch anyway if you want to do so -- I can also build it for
you if you want to test right away before it lands. Otherwise, I can
ping you when the nightly toolchain is ready.

> I normally build llvm toolchains using tc-build, but it seems rust is
> not actually part of llvm?

Yeah, Rust uses LLVM but is not part of the LLVM project.

But I think we could have support to build Rust there easily -- I
discussed it with Nathan (Cc'd) in the past. Currently, for the
LLVM+Rust toolchains he provides in kernel.org, he just bundles the
upstream Rust binaries AFAIR -- and IIRC he uses tc-build to drive
that build, so if we do that we could also "easily" get the full chain
in kernel.org too ("easily" if we ignore doing the PGO dance for the
Rust side etc. and assuming the building time/resources makes it
doable, which I don't know about).

If that is correct, I could take a look into adding a simple Rust
build to tc-build (i.e. without PGO etc.).

Cheers,
Miguel

