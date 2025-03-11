Return-Path: <linux-tip-commits+bounces-4124-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4699FA5D0C3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Mar 2025 21:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05732189893A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Mar 2025 20:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B367E260A32;
	Tue, 11 Mar 2025 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQxVz/tt"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD0B25BAB1
	for <linux-tip-commits@vger.kernel.org>; Tue, 11 Mar 2025 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741724632; cv=none; b=uxNf6qc6q3Ei7IfGLIlThXx+oUBRt7dUWkYNjM8Ox5vrQcuX3pDSa8pIGsPhn8MA3sQrU5+sIYwBrEryNMFJLMKRVPk1vvNivv+UPAopM7n5mZQni+bxV/LBQpCqrKdzTnK/Iun/0GCoVFgPxSN6W/d2SX2y66tXAv6kIBUK7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741724632; c=relaxed/simple;
	bh=sbK9cABnnz6Q1VIMb+kR5gOfZAIpJZMrTjBVB3KKKXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMuId4cO3WEfw1hJnWY3NhMi2HGDObtknenyGZPSlkDKpd6U+WfxLd4KEo6VX4O3BO33IDJEBE7hYML84O2UobjAztNGQ0JWE8r3WtSupKlP8k3sAp+xqstsBJPg7BQdW3BbmuR0/3u1qjcQEC+reWmybxlClatmozB8xeJ65uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQxVz/tt; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4769e30af66so13931cf.1
        for <linux-tip-commits@vger.kernel.org>; Tue, 11 Mar 2025 13:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741724630; x=1742329430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbK9cABnnz6Q1VIMb+kR5gOfZAIpJZMrTjBVB3KKKXA=;
        b=pQxVz/tt0ci54NN7sP7iO2mIT46iJqFHK8FufU2rQQKu1cO26P8oVGmL+phQ6QLs7Q
         d9LidHQ7uRyi1WqVn8gGoDijhmiGjvpadH056Qj8PJbgL9KYubfKjawaL8wRHmy+3p6p
         lkFS0L/mMvNfZmIJRLUedE7IcyZKJE5FbxDRrcsxAj+NK3Ejt6KnvdAsrvTDYjOx591Z
         IhpOdUJ0cljRZa9CHB6vvbtGpnk7nZ7TKYid2/2z5gsZ+Hi+TzlyFCKZxSDhh0/YY1jo
         sB+C40B5Seequ9YWTq3TduDsFILCoAt2s7tT+xIeNXnj3Pi2tyB4lf1kfM8hbjIZmVd5
         VdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741724630; x=1742329430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbK9cABnnz6Q1VIMb+kR5gOfZAIpJZMrTjBVB3KKKXA=;
        b=UuKKoACagG9Sw3fFU0JFskHxT8CmSQMY+In/pvEp25ZmcmKuU7w7Pm3FPbA0bYw90h
         nvgJZI7YCWX93yN74DA9kigKREDn9T06oD1QF8lN2cl7fLpojgwQsuBfSEfMF0YHQAlg
         MPuBX6B1fSTQetec1MJAkZLg+7TVLJgyQ0wBK0T+rLSGRMDo++2f+qZH74MUhft4Nwzw
         2kOJfHN7NDW/Vl7FlUD1shJljaRPKnbJQr/37IRstOp+1b02a2TrLV9CKO62juUJtEtW
         bEIMtny4S+RXDGhFT48K0MCCfdRTAaQRYQh9nLjDgQ8auKgjuEnL0kWIQqy3Mi7D8L1K
         SZLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJjO0EEivTCop5uB3c49tRycRv+l+AtoqiKANG82+Fkn+xtBv4zqt+Ciq7peQ5NlGU743Zu2Deyv+3wyuIZIIn4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTsuV/YnjoBKpcPRcwsowp/5VWuP3v6IK2T+++brcP2qE2Nn6
	4IclGw3NrN2N/oprNeK046wqD/mJ9KfiX7dTW5rVAmWstvrbOjssxGJMNgKQh8g2uz0vZ1HrrFx
	X7gmzg5I/QCuULS1m/YixmgxkB6T+mLD1SQEc
X-Gm-Gg: ASbGncssiTUPAgWxJbeDDAKXFtBVN34NrzbjJC0TTopsmU7KItFJWGW7fya/ptHfV1+
	FSFGJboYcXX3ogBPoq8Pyb6kSIHe+NvWcQcFf0nya/UXb2IeEm1QHohFNLO75iGVrP6/0fIfkwa
	5nhTTP0lC1sYptADeJyUQHXEu5N0+PwS2Q2gCrM41gQd0mkoHakVyz4c0m
X-Google-Smtp-Source: AGHT+IHyVXBYlUvywadtQAERTXME+3zR0NqHXE+KArmz4mpSAh0P1v+MQYs3pjWRQzwPCecq0GLl6pwyK16HiKuZ5/0=
X-Received: by 2002:a05:622a:64b:b0:474:cd63:940d with SMTP id
 d75a77b69052e-476ac172a8bmr1042471cf.0.1741724629891; Tue, 11 Mar 2025
 13:23:49 -0700 (PDT)
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
In-Reply-To: <CANiq72mcCEbeWb-RAXLcWRnJms2LA6xV=QqQ5=N3ii=3TC89fw@mail.gmail.com>
From: Ramon de C Valle <rcvalle@google.com>
Date: Tue, 11 Mar 2025 13:23:39 -0700
X-Gm-Features: AQ5f1JrCpGZrgzt8Rl9g-TEKoue7e8xLo-GmbseT14-jYs9UYP7jXIneC8q4GOU
Message-ID: <CAOcBZOQnGCqKut-BTvfJNgB9Rz+f5DAANwMs9DU16Js+QDGOrw@mail.gmail.com>
Subject: Re: [tip: x86/core] x86/ibt: Implement FineIBT-BHI mitigation
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Matthew Maurer <mmaurer@google.com>, 
	linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	linux-tip-commits@vger.kernel.org, 
	Scott Constable <scott.d.constable@intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Kees Cook <kees@kernel.org>, x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 12:41=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Mar 11, 2025 at 8:09=E2=80=AFPM Ramon de C Valle <rcvalle@google.=
com> wrote:
> >
> > I've submitted a PR for it:
> > https://github.com/rust-lang/rust/pull/138368. Let me know if you're
> > able to give it a try.
>
> Thanks Ramon, that was quick!
>
> Left a comment there and linked it -- if you meant to ask Peter, then
> I guess it would be easiest for him to use the first nightly that has
> it as a `-Z` flag.
>
> i.e. I think it is simple enough to land it as-is, especially if we
> add the quick check I suggested.

Left a note there. Let me know what you think. Yes, I guess we could
just check the next nightly that has those changes.

