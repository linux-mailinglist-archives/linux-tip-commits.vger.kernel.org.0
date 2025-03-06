Return-Path: <linux-tip-commits+bounces-4033-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7CFA5571B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 20:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4856616E7C8
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84AE270EBC;
	Thu,  6 Mar 2025 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aohrVaFW"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B100A26FDB4
	for <linux-tip-commits@vger.kernel.org>; Thu,  6 Mar 2025 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290613; cv=none; b=oHukXmdOXrJdnBCFxefQ/ZLfrhZoZwpxzMDCb9iK4DGgVUe85F2f3G96kjVfuTjIW2DuygWswRIj5Rv65kW2ZwLPLhxitu4Q2UIvK1c4itOKuwIHJgBPz53ELWI68w6WJbkE410FOSWt+HeYnjUuK96NoCNLiFdKnToQ8X8SlXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290613; c=relaxed/simple;
	bh=SeYj+5vmQMk9Qek2o0j+zoxvhCMdTopO/yz69EP+B5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qhcgzdcfysm6h2rOxIl4fLlQxsA6jns8FMX31KM4JCorYOh6q8k1tnJCGZebSZ3rS136+Yea0uoHzLNG7CHUambsROFXaL3FhuV9Fn/Zhv2e2t+c3cDTz+FJNGzc1LgFBiIJ8eT/Wkb4FgD5x4MHf+Qx28+2pDF0pU4AS05qSVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aohrVaFW; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abf57138cfaso195988666b.1
        for <linux-tip-commits@vger.kernel.org>; Thu, 06 Mar 2025 11:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741290608; x=1741895408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5UzXSAjCTYVMhmStXClPBVrbuKzccqNEtXPxciKvgg=;
        b=aohrVaFWLKiWyod7vcSXfzpp3cx9tXY5DkQpD5GsPGvM4nTxQCAXGTNT6ggz88O7K7
         pb15NVIAWDFP3dR41BRjbVO5oXNmvSZ+t75K75a6ycZFe6ehinz038IBqyoruPwD6qUE
         ak+NCKf3M0VZty/C94+tIafXoJck51Q1sQP10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741290608; x=1741895408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5UzXSAjCTYVMhmStXClPBVrbuKzccqNEtXPxciKvgg=;
        b=nG5O143E7L26T+Ve8YpagTJ3LyVrjZ720jn86YJUnTOsa6WZKnF+zyWxRuvApkHmz6
         3Yxz1wKl+D7CdWQY2wh6pMQEVyrIbfAVehvCewpdeqn5FqHDQhfYJ+H6AC0yhiUlajKc
         bOQV1/Pw+iaOtIFFzHMzFU3q734CzjWfw4RFImqb1elDam/i9Ds79UK3n4PoxRM3SVme
         vMctpnDSKTN92ZXcO/iXWhfc5LgiW5B3J3B9XIil6rDfWoZ7mGp7r0m/Qwd9H+qP8kub
         KxEPOIQAgt47DILhrdefBgg8Yf+QX5aroPtQDzgqBLAYDlSWSPqQgznFJdpClIs1RAyq
         geHw==
X-Gm-Message-State: AOJu0YyU2jViHdccWLZpi6mxydrm3wYvHdxFM2qZunvP2VA9G3zAsfgf
	fnSYLV2lQFO5WztiAq4bFhj5BRxLldJYsxS/FQNxk6ui3SAIS6lXzpjC7xVd4NHOxnITwiFk0lL
	YNbQ=
X-Gm-Gg: ASbGnct+Ihpvje697eXbzeV3E2FoNM6/0xakInsTz8PYQWtdr2+9GlSKIQcb1tq4NeA
	l/naX4L1ot+jbzxf8UKsQfOCpIjP4uNFJOYOZACMnuj1L2/3BMa7+fSuvlEcSu5gLQbL7Vmysat
	fM2LJ4c7NBRwdZQECfGvoLlzGghKopwBOXNzPUe2M29Vssx0n/rxfuizzHQEKa+hlOgBb2ijsgh
	zJ1bqLyMRAPBbLURQca8CuhTyaygt5OTToz97zu5FySN1FgFhvMXN7CqXS62IjosRn/ifz4lBp0
	HzSCxttWfspPxjKtfJrk3WB/gylC2lYtNZyeMnrC0ryvHd9liIAAxtEDk7hl0CbxiAoRuwX7Xyq
	eGY9lJcrc8rIl5V1i7SY=
X-Google-Smtp-Source: AGHT+IHn+SjxO1o21nSXdVg24jdC91PnfiJoBc6UM3emb1qig/WK8w+/TIDV179wC07wy+Cq0sIL/g==
X-Received: by 2002:a17:907:2d92:b0:ac2:2ba5:5471 with SMTP id a640c23a62f3a-ac252b3664bmr43585066b.24.1741290607532;
        Thu, 06 Mar 2025 11:50:07 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2399d45d4sm141603966b.167.2025.03.06.11.50.06
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 11:50:06 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so1979719a12.0
        for <linux-tip-commits@vger.kernel.org>; Thu, 06 Mar 2025 11:50:06 -0800 (PST)
X-Received: by 2002:a17:907:9455:b0:abf:425d:5d3 with SMTP id
 a640c23a62f3a-ac252f4b12dmr39156866b.40.1741290605907; Thu, 06 Mar 2025
 11:50:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306092658.378837-1-andriy.shevchenko@linux.intel.com> <174125602814.14745.12946945836213678532.tip-bot2@tip-bot2>
In-Reply-To: <174125602814.14745.12946945836213678532.tip-bot2@tip-bot2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Mar 2025 09:49:49 -1000
X-Gmail-Original-Message-ID: <CAHk-=whTGVy1aaEashu3K49wuG7-hARh02xbAr_hMm3844Ec7Q@mail.gmail.com>
X-Gm-Features: AQ5f1Jrmr_jLOp0tlshhDmwAms2O84ODqe4i1s4V7Wh5J5oNtXIjYzua0O7oZ3M
Message-ID: <CAHk-=whTGVy1aaEashu3K49wuG7-hARh02xbAr_hMm3844Ec7Q@mail.gmail.com>
Subject: Re: [tip: x86/mm] x86/mm: Check if PTRS_PER_PMD is defined before use
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 00:13, tip-bot2 for Andy Shevchenko
<tip-bot2@linutronix.de> wrote:
>
> x86/mm: Check if PTRS_PER_PMD is defined before use

I'm not at all happy with this one.

> -#if PTRS_PER_PMD > 1
> +#if defined(PTRS_PER_PMD) && (PTRS_PER_PMD > 1)

Honestly, I feel that if PTRS_PER_PMD isn't defined, we've missed some
include, and now the code is making random decisions based on lack of
information.

That's not correct. You can't say "I don't know the size, so I'm just
assuming it's 1".

It should always be defined, because it's normally used
unconditionally (just grep for it in mm code, eg mm/pagewalk.c:
real_depth()).

So the undefined case really is broken.

It should be defined either by the architecture pgtable_types.h
header, or if the PMD is folded away, the architecture should have
included <asm-generic/pgtable-nopmd.h>.

So I'm *really* thinking this patch is completely bogus and is hiding
a serious problem, and making PAGE_TABLE_SIZE() have random values.

                Linus

