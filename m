Return-Path: <linux-tip-commits+bounces-3629-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C692A45403
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 04:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706B1170111
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 03:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2242C25A2C8;
	Wed, 26 Feb 2025 03:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UWje9NKn"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059D256C8C
	for <linux-tip-commits@vger.kernel.org>; Wed, 26 Feb 2025 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740540684; cv=none; b=hvjqjE15c/WhVjYb0WWN8btIBBzW3Pyfulswq5Wqpokkc2YeOD1TBIEPd0R1mJFYV+1g6U+4xXWMeSHYxCYil1cLJPA9X98qCSkiQGlEaRmJ5wzyBUfgA1wFVGlBU+dvLl72oQxd64MLBR23tuTNiLyMtW7gmiXanzlmIRtOTmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740540684; c=relaxed/simple;
	bh=nP8hKiHVK/7riq8c54PWOVWLM1kaMXn8xcuMQlrcJkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nja3tmNRB8BQ/1cvvTTjPC4Pz3y60pbxOQ3P3NfmyWvBo4j3O3wSU+jQ6S8RnxeS+ooGoPAogWfYPe9VGMws4hrXeJSaX7XluQpDC2UOTssAwTj6xX8creI/iyyVbiKei+OBQM62qB3yIQq3jlrKDeEQoc2LbdcFINm+awAkkXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UWje9NKn; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e04f87584dso9584576a12.3
        for <linux-tip-commits@vger.kernel.org>; Tue, 25 Feb 2025 19:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740540680; x=1741145480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w4woczAwWEwp1Ji8GSgiXmrdqEqLfYh+FgmTaBo87qg=;
        b=UWje9NKn63AfBGAm+jfv2v+TVuYBXdrP6CCEvwmtPIp7EzK73MzN2Y51VTyVWdV4eE
         KK81FkVFZLntOA4JEPGwkm/nI4GjgBgaiyMqkO6WkELMGUB0x8/OcSEVmMk33cVKHzGs
         PTbVRxUV4kdwrx8gbfY9tb5PMhM/DwOylc4jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740540680; x=1741145480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4woczAwWEwp1Ji8GSgiXmrdqEqLfYh+FgmTaBo87qg=;
        b=AbeyWHhAQjEjwo+XLPNuEjl091Gh57ePIIKjuJbWea0VKbKvA/o/5pY8XA8MEiiEDx
         2eHdp772yV1VdLIMHr8c5tywDPjJ4WhPyy06GgA029GlOdroa59DvGn0ANQT0E6g9+Yi
         Ja8gonNlr5OIs2HW4L1ZQt96YEpfvqYmztofMLj+ktlTGNxGlIqCYCGEKD1fFZ0nh/eG
         Aos0BCxpd4eE2ufwO9fve+YISE+RhY5BMpkwL9ZvunoJVA9AHRbk4vaNFkLm9faqso5K
         JQMCN0ewXAFAKuTln8usPydTEmaX4pteP8N0eliVlrtB1klVFxnB8Qm511ZoC8BROxWy
         LGbw==
X-Forwarded-Encrypted: i=1; AJvYcCU60PUog74WrWqA1mNlsMzqtF7xTxRhE2GpwsCs6XhDwae65gpir73MkJhQCZV1M3twjaF1rnMjAUnqPAf9PdvR2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6UI9/yumhxitIptJHdwhgIm4gjezp4n2Ipip6Cj30dIwsA8lU
	9mgB4xPWM+ug4icMIWde4Ad5f8bDrJ9cD7i7FMOQclADiYi3HPM3wxQbvgZN84CPfcOo01VpyHA
	XYaM=
X-Gm-Gg: ASbGncsx/64R+oSKvmNhOtjKbImOPN2g+X0McJH2Yb+WT/PQp8y4ASbtZEgZj1yrYCs
	bjF/rZDf24EiiNI4FIWQlqyhMVUCxErocsPln2r4eLlrQ1T1OqS1CcuKoVAb4quHlyCWMNOgfjZ
	D1HJ/VJG8KIfAsNFyhs1QGg3A2UoFyC8AegxGuxLSnoc68pBMj0qe74Sv6oENjWKwbImOozXiBQ
	XhpVozqMEb/6TIigTt7jwyFMQ3PzdlTMAbCYHxecXRjMOu36w2/3rXZZQdz2rD5KS9LHv+sKVd3
	fEXyvLTLc2wAoMsUjxCgtXG14jLn8Vv3wljTTGebCgz6APgmDtYetfxSIhUUQ/csAsS/5vKZoZc
	U
X-Google-Smtp-Source: AGHT+IGl9EYihDnwdRYTmjZqVDcvf+66AxI2ge0YacodS0P5Esp7nlF0gWBhzdVvBRaOLulT5BFF2w==
X-Received: by 2002:a05:6402:3893:b0:5e0:5feb:57d5 with SMTP id 4fb4d7f45d1cf-5e4a0e2b159mr1971365a12.32.1740540679968;
        Tue, 25 Feb 2025 19:31:19 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e45b71696bsm2113057a12.40.2025.02.25.19.31.17
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 19:31:18 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e0452f859cso10007791a12.2
        for <linux-tip-commits@vger.kernel.org>; Tue, 25 Feb 2025 19:31:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCBYdLWCZPYu/A75KqkCGHxKhUv5m+RFvhEvLXjAu0VMa9yZd6hPbCFyLw0uTVhcNzR1DQEnBdRWtbH1EHZajJ2A==@vger.kernel.org
X-Received: by 2002:a17:907:3e0d:b0:abb:b209:aba7 with SMTP id
 a640c23a62f3a-abeeedcf3bbmr123763066b.26.1740540677605; Tue, 25 Feb 2025
 19:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174051422675.10177.13226545170101706336.tip-bot2@tip-bot2>
 <CAHk-=whfkWMkQOVMCxqcJ6+GWdSZTLcyDUmSRCVHV4BtbwDrHA@mail.gmail.com> <Z76APkysrjgHjgR2@casper.infradead.org>
In-Reply-To: <Z76APkysrjgHjgR2@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Feb 2025 19:31:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+VBV5kBMfXYNOb+aLt3WJqMKFT0wU=KaV3R12NvN5TA@mail.gmail.com>
X-Gm-Features: AQ5f1Jp7I0ja65q-0RHKbtvWFR7GAuhvgls2dzRZEZ_p4USgiAWwx3oIsJSdPXE
Message-ID: <CAHk-=wj+VBV5kBMfXYNOb+aLt3WJqMKFT0wU=KaV3R12NvN5TA@mail.gmail.com>
Subject: Re: [tip: x86/mm] x86/mm: Clear _PAGE_DIRTY when we clear _PAGE_RW
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 18:45, Matthew Wilcox <willy@infradead.org> wrote:
>
> Are you saying that the PTE dirty bit controls whether the CPU flushes
> cache back to memory?  That isn't how I understand CPUs to work.

No, I'm saying that dropping the dirty bit drops information.

Yes, yes, we have the SW-dirty bit, and hopefully that is indeed
always set, but the way we test for "is this page dirty and needs
writeback" is literally to test *both*.

        return pte_flags(pte) & _PAGE_DIRTY_BITS;

> I don't understand why the dirty bit needs to be saved.  At least in
> the vfree() case, we're freeing the memory so any unflushed writes to
> it may as well disappear.  But I don't know all the circumstances in
> which these functions are called.

I'm not saying that it needs to be saved.

But I *am* saying that it needs to be explained why dropping it is fine.

And I am also saying that your explanation for why it should be
cleared makes no sense, since two out of three cases also cleared
_PAGE_PRESENT, at which point the whole shadow stack issue is
completely irrelevant.

So please explain *why* clearing PAGE_DIRTY is ok. Don't bring up
issues like the shadow stack setting that is irrelevant for at least
two of the cases that you changed.

If all of these are purely used for vmalloc() or direct mappings, then
*that* is a valid explanation ("we don't care about dirty bits on
kernel mappings"), for example.

               Linus

