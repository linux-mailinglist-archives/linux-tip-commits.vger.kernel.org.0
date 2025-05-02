Return-Path: <linux-tip-commits+bounces-5198-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9EBAA78DA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 19:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1A1463D8D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 17:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989A425B69D;
	Fri,  2 May 2025 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cqsRiLfI"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BEF263F3D
	for <linux-tip-commits@vger.kernel.org>; Fri,  2 May 2025 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746208363; cv=none; b=AO4ukVZKgVbWialkFBOR1Qokg6Gtq0FKRw3Cs0ZTA0gJFHWPXIMUwiDc4gopfI5ulPkjYdr/x8CPA16aRPEp9k3CDtRFY7yS3z9dSvABuCO8XFhbp1ewgLPdyZM+7nXc0RxMvtnOu7PkRU8RjPA8ZjFwTGAvGNt9nDFd8iFaIHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746208363; c=relaxed/simple;
	bh=TMIgcgfI53ASO5LRhBCN9KJj/SKpPkYNOMudWH8eld0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7vEdXVPf0gaD8X5Y9vovXBzh4qhNSUS3K2Rm6cSsY+1RDncgpvddnhWQJGWsa0rSbmlkUQO6gAgeZOcliupBUBVxOaq5gsv5HbY1pIMJsxaHTYpgAbmfiWde7bauqNB4PV99gfEfIlaRZt0kzF01uuNG90NchjirGhfi/gvKZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cqsRiLfI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f6222c6c4cso3440185a12.1
        for <linux-tip-commits@vger.kernel.org>; Fri, 02 May 2025 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1746208359; x=1746813159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L+qzGYQVD+m8VMlSDDggqEimDlE2nd4dP5p1ek457P0=;
        b=cqsRiLfIS40MoRmZ3hh7g/kkYtrphWmnBpvGUfmZe7Va7Myx3BtmvqPPD6BwTTSCVq
         4Xz1r8pxHgt6jq61TRuxKwX+kHF03WM3pR4XwFs0V6T9H4cm1WyDW3zm1n6dQCPtoCo9
         oc5Zgb1QPsIHBOopz0dBiPDrKkONazMKBO0a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746208359; x=1746813159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+qzGYQVD+m8VMlSDDggqEimDlE2nd4dP5p1ek457P0=;
        b=DagG9Wj+IKEGycZ3u/T/mjj3E6F3O4vQ10ezifHDZnRHvpvGfgqOg0Ef8cwrSZ+51d
         eJD3eerQly3jfwp1GBmIsw4cX/++znRJjK9hgvNFH04Rg3gxGV9ReB5/4rnWok5/DIKn
         8STBlRfWPujdZz1fmna8drmpdAPXtkONhNu/PrlHq8uZ+psrxaKizyRTXc+fr1JGXLcz
         IjMGSCw/9JYTg2KkjfAgKZQXr63xk08r5zPWXPrMh4uqALbsFaZDBUfhAlfWD0Qa22Rv
         P1gWkGk9L7hgM02nnHJrEwoVsp+a4X1iATzk3Baa486u4MFP1pU6BevnG6sWoGtTxPAg
         yx5g==
X-Forwarded-Encrypted: i=1; AJvYcCVie2Nj6kjJzzWssz8juus5FAsqkPU/btt3LJ1Si6fodNSHuOP1FiPqJjQtt7EEGqWy/KnfTRp2nXolXb0oT8/6Gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHHO4uGhK+7wsa0sVwZormUS3awNWPLKkk7Yvlb+1eEwdJM99B
	d4h+pXWWnDWUqcMzy+0EVTYPxbNdpK75lhyHnuEAeQmQ2L7EkwSifJ4cV2x7xHKTvLfbdp562H8
	9PRQ=
X-Gm-Gg: ASbGncuyo+3REqaoBBcWgnJy8Gsufz4a2DjPAez2TFFxejtO9fQvwlVYu1jh3vhQBJm
	+Zq+6TbSi0yOd4BrXCIQ3qFS75V1RIoQA+DI2fXJjOt3rxR2DzpxCoq5GZvEE4+KHbAbm71hRL/
	d6HENhUBcssbP9Z+eQZQt8LXOJEitTgU+WZXYGJdjxhCoQXIXonmCIzBSkRZdZRAPsfA71WaLTp
	uvsFVBsDH2B8oY8QYQcMBF2SM4lsdqTONpXq16RZ2jh6oSUDG2c5nkr9Ae2lEkI95nLRCuRq3Pe
	Is9RizR3YCm/aXydbph/htmvJO9cig762YOvL3o62tOAlTeoxg3aZFdy8X/gcQjJ5rrESYnmJYd
	rV4cO8gagpByqT7Y=
X-Google-Smtp-Source: AGHT+IFwMOXemfRtz3LGflLJXOwkbrb5EcrkKqd90S/EC+cV1gX3cIjAhqW2t5o/ruBfvmfB+hX3qQ==
X-Received: by 2002:a17:906:6a11:b0:aca:9a61:931d with SMTP id a640c23a62f3a-ad17adbe0c4mr358182666b.30.1746208359146;
        Fri, 02 May 2025 10:52:39 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189146f61sm79346666b.9.2025.05.02.10.52.37
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 10:52:37 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac29fd22163so391689366b.3
        for <linux-tip-commits@vger.kernel.org>; Fri, 02 May 2025 10:52:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBv4DSkGJRhiUw8zBsisHlNfIHwufqzIOGhn1D+B7/TIzyaIXTXh/hZRWxgw58M1jJvW9c1ziuOVCSg784Vnm+8A==@vger.kernel.org
X-Received: by 2002:a17:907:728a:b0:ac7:d7f3:86c6 with SMTP id
 a640c23a62f3a-ad17ad3a86cmr353817166b.9.1746208356936; Fri, 02 May 2025
 10:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429213817.65651-1-cpru@amazon.com> <20250430100259.GK4439@noisy.programming.kicks-ass.net>
 <B27ECDA1-632D-44CD-AB99-B7A9C27393E4@amazon.com>
In-Reply-To: <B27ECDA1-632D-44CD-AB99-B7A9C27393E4@amazon.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 May 2025 10:52:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgb5WcfMEgsOQg4wzVWuYNgCL-e17YX33ZET_G3-ZCo7g@mail.gmail.com>
X-Gm-Features: ATxdqUHYMChzuFnxzpibzLtkTrwHUQOJbZWvS4aZuUPZ8wK3AkEbViB7psNkIbY
Message-ID: <CAHk-=wgb5WcfMEgsOQg4wzVWuYNgCL-e17YX33ZET_G3-ZCo7g@mail.gmail.com>
Subject: Re: EEVDF regression still exists
To: "Prundeanu, Cristian" <cpru@amazon.com>
Cc: Peter Zijlstra <peterz@infradead.org>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Blake, Geoff" <blakgeof@amazon.com>, 
	"Csoma, Csaba" <csabac@amazon.com>, "Doebel, Bjoern" <doebel@amazon.de>, 
	Gautham Shenoy <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Joseph Salisbury <joseph.salisbury@oracle.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 May 2025 at 10:25, Prundeanu, Cristian <cpru@amazon.com> wrote:
>
> Another, more recent observation is that 6.15-rc4 has worse performance than
> rc3 and earlier kernels. Maybe that can help narrow down the cause?
> I've added the perf reports for rc3 and rc2 in the same location as before.

The only _scheduler_ change that looks relevant is commit bbce3de72be5
("sched/eevdf: Fix se->slice being set to U64_MAX and resulting
crash"). Which does affect the slice calculation, although supposedly
only under special circumstances.

Of course, it could be something else.

For example, we have a AMD performance regression in general due to
_another_ CPU leak mitigation issue, but that predates rc3 (happened
during the merge window), so that one isn't relevant, but maybe
something else is..

Although honestly, that slice calculation still looks just plain odd.
It defaults the slice to zero, so if none of the 'break' conditions in
the first loop happens, it will reset the slice to that zero value and
then the

        slice = cfs_rq_min_slice(cfs_rq);

ion that second loop looks like it might just pick up that zero value again.

I clearly don't understand the code.

             Linus

