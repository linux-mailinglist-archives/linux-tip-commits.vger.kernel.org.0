Return-Path: <linux-tip-commits+bounces-3631-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A84DA45445
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 05:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A56C3A8C7E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 04:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91CA4438B;
	Wed, 26 Feb 2025 04:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EWu3VBoP"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB4D20B21B
	for <linux-tip-commits@vger.kernel.org>; Wed, 26 Feb 2025 04:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542784; cv=none; b=VQZUcs41RmcNAjaYLFTRnLRebzBwh+ivcxK/1j4cKwgy2nVKD3l3mPWOwEES6TuHUmU+cVWLVfGHCDqALwp9CI4bVRbMo5YrdvTg118C4Fp64R9J0cFr7EU85tcDYY6tCoaaVzUCzBAZ23lRLZXkg9JR+16wBuV/LMzeNP5V0vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542784; c=relaxed/simple;
	bh=AuW50vH3VSY/Xf8J37DQxfTy+N6QXSGr4cXcli5U37I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p31MnFEN/DlfaPnN0DUOEfPDvSOMfClYedQcXSw4nQK1tYfjbiFBB3fOWxxokhfTJmC/uFwngeN2p8SCtTWNAtlo6pBA9bhmsfAwFrcMJuoP5pYJ79Tk4BMmdc7QVHK6gWZMXpC075GiN50wrjY2H6R/MkHjZl/UUYDgM9qazIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EWu3VBoP; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab771575040so82248166b.1
        for <linux-tip-commits@vger.kernel.org>; Tue, 25 Feb 2025 20:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740542781; x=1741147581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=40VvcXlH8rEZKpE1INxpbYUwpWWo+F2leARtkRuHi+c=;
        b=EWu3VBoPeC+lM/0iimQzipsR91hbnRhtAMO83B19JK/zHZFpEKJhB5kxVWxTrTqTdM
         bI6V/bJHVf6EfFqZ0F3JgRqsSg+iL4K6lD5FdB5gUZWvlkD2FEeK6LgGNTr8XCBtKKXO
         ksS2BPy87yj3IJJB8LryH36UJVj3OTDuGo/vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740542781; x=1741147581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40VvcXlH8rEZKpE1INxpbYUwpWWo+F2leARtkRuHi+c=;
        b=cuY7Oz6c/dxw27KsRVdVKWZoj9TDmvnTGb69HzdxMqvVeuiPRmy/ED7z6YYibEI+TC
         WbAgswscKAfGq0TFvuA1XKuyGHmjV8qE2rt/ZNk0bDcYgCWP/DkpAUmwms4c0v3EgJkW
         7XGNK+9CxpzUFEZF7TydayMYx8uUkX6y48clwTA7x8R6yqmn6P3QggsoWGiPVri8eq9L
         KAYBntmPGzXkIUuwNRR42hIBUvWDP5nqK6P+zYoAXLeefi6lnH76QSD9tWkmmJhD0Bma
         ceWZpToMLVpVFGhc1nMmeelJLhmBLfq5yubn1Ix7KcfPIlIZQkwg50GtuwVOMpkUgAKP
         v65g==
X-Forwarded-Encrypted: i=1; AJvYcCWiRDU5uQDZF/a1+36xO5yqlj4uz8AZwX/GBCooqrgJ47FT+GJ1JjMzVPgJYe/0oSPBlqHhz4rAZoFFjhNvazhGmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6LXvg8rzje1UBTl9J3wpSvod+zgzNU+L48LmNueoBYO7NfsCY
	yRvEuLyWfrOrLcyIqixgumNsphfu4NjTy1RAHSb8bsmKSHiY7aH6S9USfi2ptng1Gx2qNIeu6np
	VcOw=
X-Gm-Gg: ASbGncspqibKgaegv74rnhUwKkWkDSEHjO5xJX7H+//T1VnkG5EBf8B8xmPcY0T2Xwg
	pobPSgwQgWrhHjv0KdEkVnGjORHvlgls/lypWQs7XOb5cW0dQr/qiAnfjffR3Ho8FYn/RP30WaT
	gEcykIcF2BMKwUgM04gmvzhwUm8cPPjs7Je40vbnms9iFW+WoDSA46Gy+4iv3Flo0Yzvb8B3Q/o
	uWPbRH75zUFzZzb3byzhR+130l7tHolagUpqmfm2MlnQztJBVcrD9UUkk5g0aW4SeGDaEuhvkOf
	iVP9gmeiYXGS4OLmcrquD3sWvEssESO2iemPhc28bcTOveQteGgyEjExpILsHDyS16kv4gXeesa
	G
X-Google-Smtp-Source: AGHT+IGUNtkjFtrMWLuXFBkYucjKCu6+bS2rhHkr5ng7A0NGByYNFVID78FXjYFyZp/ABjMLdwC2/w==
X-Received: by 2002:a17:907:a317:b0:ab7:46c4:a7be with SMTP id a640c23a62f3a-abbeda28000mr2164064166b.2.1740542780837;
        Tue, 25 Feb 2025 20:06:20 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20b7513sm253921966b.177.2025.02.25.20.06.18
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 20:06:19 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab771575040so82243366b.1
        for <linux-tip-commits@vger.kernel.org>; Tue, 25 Feb 2025 20:06:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHjVW8GfgaP8KdIj9tghchk0tT+ePv3XCyAMfzg2EZhEJeeeeOThJI9ZsJlRCOGkrGHhPQGW93fECmzA1W1eXRcA==@vger.kernel.org
X-Received: by 2002:a17:907:cf91:b0:abb:bb82:385b with SMTP id
 a640c23a62f3a-abbeddc5eb9mr2218246466b.13.1740542778393; Tue, 25 Feb 2025
 20:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174051422675.10177.13226545170101706336.tip-bot2@tip-bot2>
 <CAHk-=whfkWMkQOVMCxqcJ6+GWdSZTLcyDUmSRCVHV4BtbwDrHA@mail.gmail.com>
 <Z76APkysrjgHjgR2@casper.infradead.org> <CAHk-=wj+VBV5kBMfXYNOb+aLt3WJqMKFT0wU=KaV3R12NvN5TA@mail.gmail.com>
 <Z76R6ESSwiYipQVn@casper.infradead.org>
In-Reply-To: <Z76R6ESSwiYipQVn@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Feb 2025 20:06:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=whS1uq_4hEgkZJogv_HMhe_PJ-RyMs6E303_Pa+W0zx0A@mail.gmail.com>
X-Gm-Features: AQ5f1JoCnqtK6fTnLK3CaWRyz3BVTY7M9pK4Iq32FOaHAgO4MK-3ssz-_tr_HuM
Message-ID: <CAHk-=whS1uq_4hEgkZJogv_HMhe_PJ-RyMs6E303_Pa+W0zx0A@mail.gmail.com>
Subject: Re: [tip: x86/mm] x86/mm: Clear _PAGE_DIRTY when we clear _PAGE_RW
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 20:00, Matthew Wilcox <willy@infradead.org> wrote:
>
> I think the entire point of this file is to manipulate kernel mappings.

Very likely. But just looking at the patch, it was very non-obvious.

           Linus

