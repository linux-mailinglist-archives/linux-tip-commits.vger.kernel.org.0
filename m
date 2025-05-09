Return-Path: <linux-tip-commits+bounces-5513-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 729CCAB073B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 May 2025 02:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76B316747F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 May 2025 00:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506EF63B9;
	Fri,  9 May 2025 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcL8jVIt"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710663FC7
	for <linux-tip-commits@vger.kernel.org>; Fri,  9 May 2025 00:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746751533; cv=none; b=ngwZRDJtoXqeDNZk+6hgzjC2MoEL2I0JoYmZXwysX1vzK7LLofwgxz393ei1GPyUUBZC6uwT2OFv+Tzr+2dzPp35RiglydvOddPjfOo253Q1ot75hGRR5RUbpE4c8bxX3VPtO+JPzV7EDVK++Y+ZvrEKv2KCiX41ZFxrjcu6+KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746751533; c=relaxed/simple;
	bh=F3SweCz7MNyTIf7Sl/mcYdgcU7AYtp1zXA98lgPwocg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jg3557KD/VhVddFltqsOPK9719CdXcWbbVoW1+vnwtnd+f2gKL7XGuJCrUoSna98GccZiBIumDiyNJI4kERrYF7QYw5OSURi2rvgmEL6rNxxvnPUhM7dZBVK4YLTlkRgH83NNnsLcUvqD7ZjRkfxWjyDSalqeORS1O+ji6RsbjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcL8jVIt; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso2341a12.1
        for <linux-tip-commits@vger.kernel.org>; Thu, 08 May 2025 17:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746751530; x=1747356330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjvcmTMj9iu4CCyYeVFkuY5AWCE78eTuqkHvMFVALIQ=;
        b=mcL8jVItCNaFX8//1hen7k/z2gbaNcuLxn1QA6h0kahFdpLWC0o6EhE9hXyYrkLBIF
         y1RuR7e8x/m+k5YFvjOVFPTSmI6EIJPIJ/ZjWsF7JXBCQzAZBbBNFtIzIxp/6z3RIOVr
         TSWuQxUUEtGDlqltkdHLPDkzXZ4h7o9d227BhqyEry/7rNBxiT/MjHvUuDI9BOT/k1Vh
         /NoKqfSjDfKvkp0S/53Ky9KEja3fPCHI2ckdgSZhJtYYjlAPCt3F02ii2LOJZYKRPuCR
         DI0NpILaJSHNdOO/jIxJ1ZVTySP2YwSHIEys74XuJcaqkQ3PIF7QBDCZ+dvB3P5qaPd1
         gPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746751530; x=1747356330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjvcmTMj9iu4CCyYeVFkuY5AWCE78eTuqkHvMFVALIQ=;
        b=CbOh0tNUYQnhFYOZWSQqmVAcaMa8TMR/Q062ggKY6z0I3sa3NMQ6slKt8HAy8yRJey
         E9POBIXoUoaph97CJqiMxzhCqXdhkO7kayfEXZY1uuLzRkHEzOIFmeQ+S52fbPndGZIk
         I8RMJyO93/GGnvXAvv8gjasNEUzM2aes4f+chsKvUJJvoUk+ItXdNZKW0ty0F1fRnzog
         VtuMTp98xXh/kd0is11Zc4hOSwY/6gN62HS8nmGbnvBiZlVOS8i6bPZc8h3Ap1igOlQ3
         RpZrKK4V7bwDIL23k81bF6tKzL7yTPB2zSfbleEtaAc2SEbRpP/HXUG+PWmNJQ1sGL51
         AKWg==
X-Forwarded-Encrypted: i=1; AJvYcCW6aQ15DAnyKniiM4dVPJ1iIJ7bl0M+cTnFDUxH6VoED2QalAUD8GiDvoJZUlCHSaP2XAWC52AbR/5D/PPKt9re2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0fTJ3ce1wM1Omu0X0YCa+yVeXrLQ0a346kD46MQTJzTiSosV2
	CC1xOiDvkBQl2v5CGKXXltp0Aor0PIZXwQUiiat6mis7qHgeWV90791V8BG1cDYgduNkjXE7Obx
	n1dHKW7Ue8UeoYgNpBM7pIuntNLomWtjbavoJ
X-Gm-Gg: ASbGnct9ArfRUYhIBuBUKlst/jI7/WCamrXQC4M+vuM9bWB+gmWLK1zMhG4QJZ7xjx3
	nuEJHMLyBXqnwjNV1onJv1ZAYaFnkEt9UJjHOvewn04jEcPmWnxdtqE5ZD05Hbdb6bMmMeClqI5
	hkE5R2SjrGSaPtm+EAsQtF
X-Google-Smtp-Source: AGHT+IEaOWqb9f2E4Q1/ZcgfLQB0/8/FfCO65qxRTtRUPAIu0zbMTqE+wq4Xy+JenLhKPcxcvnZ1ZdSTxsN7UWTTJ8g=
X-Received: by 2002:a05:6402:128a:b0:5fb:89b1:717f with SMTP id
 4fb4d7f45d1cf-5fca18fcc39mr45282a12.0.1746751529581; Thu, 08 May 2025
 17:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425200541.113015-1-xur@google.com> <174601619410.22196.10353886760773998736.tip-bot2@tip-bot2>
 <jj4fu243l7ap4bza5imrgjk5f5dhsoloxezgphdjwo7sb5iqsq@wkt46abbt45r>
In-Reply-To: <jj4fu243l7ap4bza5imrgjk5f5dhsoloxezgphdjwo7sb5iqsq@wkt46abbt45r>
From: Rong Xu <xur@google.com>
Date: Thu, 8 May 2025 17:45:18 -0700
X-Gm-Features: AX0GCFusp0ihkGqmvl5QTilS2LUpRE6AKPN19BfCLSreyPjsYKxu8ro4ZEyIggM
Message-ID: <CAF1bQ=SBgs6RiOEXakcZ=TaYjwXngMKNrp8gHL9FhfjOodOxiA@mail.gmail.com>
Subject: Re: [tip: objtool/core] objtool: Fix up st_info in COMDAT group section
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: tip-bot2 for Rong Xu <tip-bot2@linutronix.de>, linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 4:22=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> On Wed, Apr 30, 2025 at 12:29:54PM +0000, tip-bot2 for Rong Xu wrote:
> > The following commit has been merged into the objtool/core branch of ti=
p:
> >
> > Commit-ID:     2cb291596e2c1837238bc322ae3545dacb99d584
> > Gitweb:        https://git.kernel.org/tip/2cb291596e2c1837238bc322ae354=
5dacb99d584
> > Author:        Rong Xu <xur@google.com>
> > AuthorDate:    Fri, 25 Apr 2025 13:05:41 -07:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Wed, 30 Apr 2025 13:58:34 +02:00
> >
> > objtool: Fix up st_info in COMDAT group section
> >
> > When __elf_create_symbol creates a local symbol, it relocates the first
> > global symbol upwards to make space. Subsequently, elf_update_symbol()
> > is called to refresh the symbol table section. However, this isn't
> > sufficient, as other sections might have the reference to the old
> > symbol index, for instance, the sh_info field of an SHT_GROUP section.
> >
> > This patch updates the `sh_info` field when necessary. This field
> > serves as the key for the COMDAT group. An incorrect key would prevent
> > the linker's from deduplicating COMDAT symbols, leading to duplicate
> > definitions in the final link.
> >
> > Signed-off-by: Rong Xu <xur@google.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://lkml.kernel.org/r/20250425200541.113015-1-xur@google.com
>
> Unfortunately this patch completely destroys performance when adding a
> bunch of symbols.  Which I'm doing in v2 of my klp-build patch set.
The patch won't add symbols. Do you mean the updates take too much time
when adding symbols? It's probably true as we lookup the sections for every
added symbols. I did not notice the compile time issues in my builds.
If this is a problem, it needs to be fixed.
Thanks for working with v2!
>
> What was the use case for this?  I don't remember seeing any COMDAT
> groups in the kernel.

In the PGO or AutoFDO builds, we used many COMDAT variables for counters
and control variables. I think the compiler also puts the functions
defined in header
as COMDAT.
The issue I encountered was objtool moved the variables for
profile_filename and
profile_version, but the comdat keys were not updated.

-Rong

> --
> Josh

