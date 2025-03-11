Return-Path: <linux-tip-commits+bounces-4123-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF0EA5CF9C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Mar 2025 20:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591523B1226
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Mar 2025 19:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA8C2641F9;
	Tue, 11 Mar 2025 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY7RaAJx"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4745217719;
	Tue, 11 Mar 2025 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722104; cv=none; b=gagawmYiE4NDcgpIyxmCuAY0qDLQGGwAaABQJHTqHusXSAv8/TS0jGBZ2zDWki2vM4el5wNUDkDI6/qDtySCychIKwQjzgqLRDRP9ERPynIWC9DUXGCP88texg/42iJv+soo4dK9emrXGLxZiIymQ/e1Yy3dTDEzTpDySieBp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722104; c=relaxed/simple;
	bh=4NN58KwaogQ+HtjntVqmJ5D0KQWkeU7fca3r8Gitstc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCRG2FDghOCi1tmIrdIx0K6CPt0+9mhUJjmAPGn98ceflD5ZnqpwJxrzDVU83ie72oInKyY0vWtjCR2uVKq/4fSdwB69HZrpb17r9piXJf6xMO1SwEEVLZBnVOxCeKaVRW50c0S+45H8swqWk2gRB8EOv+F88M7nBMYxyc6tGiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LY7RaAJx; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-301001bc6a8so331057a91.1;
        Tue, 11 Mar 2025 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741722102; x=1742326902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NN58KwaogQ+HtjntVqmJ5D0KQWkeU7fca3r8Gitstc=;
        b=LY7RaAJx+ecMvswOd8CQbuDXE0F7+dKmfTPW7t7acKHVVQ78yjH5a+/YRCKdinhQ2w
         sPibaROHtT0Ev+sh9pR6txTcEo46FS6+EeqOzfdOqgUwapzP0FcirBLcLlMvILBWNrV9
         G1SrH7RQYwvowEH4Tt9x2FwDjU5b74qNNCA+M2o1DNUFQXlAS+L/UmIoRic1GSBgDirH
         TXMq5/YRvg9wp2lQzIVg2WDSNdYKxB7BaL0edqJsZHGvp/R8EAnFWlBVAb0YBUbUYtbb
         EyMbeSPPLQrHm1lDnTKqDpyCliIiIC8XIXJlu8TWOoI9JkPShMKCD0FFyBJxBwGh2E3x
         no7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741722102; x=1742326902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NN58KwaogQ+HtjntVqmJ5D0KQWkeU7fca3r8Gitstc=;
        b=dvOTGuaJKWwzcCwufv5UM2hIic4L5iurbYW6OtJmwtQLZDdSH7m2jDjtlJ9GDSFRaC
         OCRmH2tn1z77ZAw2QSqo+vpl2eXHhQBYtqVS63g/7W+TRYqnx1TTJwkEs4ooLfDvWzPI
         /mmZ25xLEuwf1eNDPnTSymgOYpRJc0f0qeuMaQMfLa6tGijYreGISoFPYCS5OS7RCWaw
         7Zi0us++wPixbfHPUXm+UGfq0UgSd21Y2/cj5OqBIy664TT0iUAQRQ0iV8lpqM5xrw8r
         jMqn0YZvzFLZ+u/USDQtBPlmRsuovI/ujqjoW3it6ckimUncesbNfzAbKQkXDNiFlyy8
         Rt7A==
X-Forwarded-Encrypted: i=1; AJvYcCVdNY94wGojW2ZJNAYgNlhjEsqAT6kN4kmkaFyhl9nX8HVmF1ut1omDWubegEWXdBzTE5oehXclohmjshJErqClxR0=@vger.kernel.org, AJvYcCXUUpbpow0DQOkkBbAwDATjAHuuvWiqe/A0FO6QuIHCONTGD+gz2SDhTBZAiZm/LUOA7p7dt7HpflyuNfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQNufId0I2q/XHerHmyJa4zleKZCsa60FyjxWzsUuwNwEF56cp
	A2UNkI1gnlAHMYFhq04WQNDbKxiNF+VxsAfzYLs9yowzRqRekkkhQayweysK/z5D5E/wKIzetxo
	Nqv8MyV/XKWn+PZOS3lFAuq8Lu1Y=
X-Gm-Gg: ASbGncuU5OeZ+hPjpdfsbVYKQ+7IBObclT8XxXaUPT5RWpe/4tvdN9QHvolH4E522ZP
	zXFOju2l0u/f6xTBuQFYD9huvJDFqAznln42SBXXj6lyGqz3/9PX20fWFDYyHIjh+48vGwzy1pX
	2JqcGHWr1hXLvMiEk/dZK/mLKjvA==
X-Google-Smtp-Source: AGHT+IEHgzKY98fCSC28NvfroYaPYjmHHOdVBQFbWVwcHaECJ/CxuNDuKd2c0Xf3ceo2tQ8qq2JVBUbByicBALf6QT8=
X-Received: by 2002:a17:90b:4c51:b0:2ff:5540:bb48 with SMTP id
 98e67ed59e1d1-300ff94c15dmr2357427a91.8.1741722102000; Tue, 11 Mar 2025
 12:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224124200.820402212@infradead.org> <174057447519.10177.9447726208823079202.tip-bot2@tip-bot2>
 <20250226195308.GA29387@noisy.programming.kicks-ass.net> <CANiq72=3ghFxy8E=AU9p+0imFxKr5iU3sd0hVUXed5BA+KjdNQ@mail.gmail.com>
 <20250310160242.GH19344@noisy.programming.kicks-ass.net> <CAOcBZOSPBsTvWFdpwE0-ZU76yMDGBEo3p9y614XYEu+ZSnQ6Sg@mail.gmail.com>
In-Reply-To: <CAOcBZOSPBsTvWFdpwE0-ZU76yMDGBEo3p9y614XYEu+ZSnQ6Sg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Mar 2025 20:41:29 +0100
X-Gm-Features: AQ5f1JqOWl3zSHYNx42VbjOidpWEFsyL2bIR1r6TXOGw_mI28pY_6cxT_FVtxHg
Message-ID: <CANiq72mcCEbeWb-RAXLcWRnJms2LA6xV=QqQ5=N3ii=3TC89fw@mail.gmail.com>
Subject: Re: [tip: x86/core] x86/ibt: Implement FineIBT-BHI mitigation
To: Ramon de C Valle <rcvalle@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Matthew Maurer <mmaurer@google.com>, 
	linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	linux-tip-commits@vger.kernel.org, 
	Scott Constable <scott.d.constable@intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Kees Cook <kees@kernel.org>, x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 8:09=E2=80=AFPM Ramon de C Valle <rcvalle@google.co=
m> wrote:
>
> I've submitted a PR for it:
> https://github.com/rust-lang/rust/pull/138368. Let me know if you're
> able to give it a try.

Thanks Ramon, that was quick!

Left a comment there and linked it -- if you meant to ask Peter, then
I guess it would be easiest for him to use the first nightly that has
it as a `-Z` flag.

i.e. I think it is simple enough to land it as-is, especially if we
add the quick check I suggested.

Cheers,
Miguel

