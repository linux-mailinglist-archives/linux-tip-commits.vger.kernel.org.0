Return-Path: <linux-tip-commits+bounces-3621-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB287A44E5E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 22:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C3F7A1B38
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 21:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EED18DB2C;
	Tue, 25 Feb 2025 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XLTAadDd"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F44374F1
	for <linux-tip-commits@vger.kernel.org>; Tue, 25 Feb 2025 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517650; cv=none; b=fCfdmGE1olbOUP8i4y1TFwrzzgPvhjRxRCTP/BM1tcaT5swW3pzRGPaQPEQVkx6o1QQ75gSHnTrUsY0x+bYScN9ZzLGvP3pXBwufuu5YwH8lKkEODbkegHgT+7bEd6xspvlD/sgZcFtv+1PJlIIloagNbL+/RGCyCV5qP/Ft1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517650; c=relaxed/simple;
	bh=QStLP7kU/H6Q5DTwstCE48OEpuJLb+0tRWLJd4PpdqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pknlg1gD1X/L9KyqFGG29ZdSWkzcZQVr65/oTqElbJjN0ocvY/XEwMyndkxR6yYKRIF0kQ+fNdmru0qRJuTgyZo90fqE1IFncGiYJrgNn7FGphZRRAQKKJHshY3Ig5XzxUbq1YXSfxS4OwkfOZaMfk8/4iN+vtitG9Ca+9wF/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XLTAadDd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e0939c6456so9741497a12.3
        for <linux-tip-commits@vger.kernel.org>; Tue, 25 Feb 2025 13:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740517646; x=1741122446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KS0+F21mT81i/tWAcFhVBiWxytCvW0/3x4Qj5tX3R9Y=;
        b=XLTAadDd/v3rM1ICdEJvKhJk3I6vgQYDJGgRqIDm5zRfHkhjW7UsiyiSz05apWQq7V
         o0b5e6xBT/O/CyM0r4OeB8jwT0ihlwwPy00XIsITenttKzsoas3O0202g1/+bNCMct1t
         x1r6iIX/zPeAkC9jTGotdXFsV/Hd+zMCG1gk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740517646; x=1741122446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KS0+F21mT81i/tWAcFhVBiWxytCvW0/3x4Qj5tX3R9Y=;
        b=Fn1Pqzv+uGRx27bXtfvFBO05U/2TDjQD7xvnklB4QxOkDFfaP7N1wuDF//qkBMUSGV
         addRFSTLTgDugnsyOJP/UTA+p9MTRvl4v9IKB+RY+wiqznKC8KzBMY+m/g2fjC4Zukx3
         lXboktg1d16GnlhgqmFk5rYGb4kmP5MgPohBVePJYK8YGezrx5tZHCKZEshgSEFpah5Q
         NS9OME5V00SW1qWp2ENDZKH17hnlFiQd38hcf8vEVI48KQnPSurcTLBPuTgZOtCsDP/K
         bl0PsOx53C+0VCGBYcQyi2cfYWZx2P54qeGbU+gnmVD17E4rUH2ljMI4ASgJKPjPXAbl
         ZXkg==
X-Gm-Message-State: AOJu0Yy1e5E4s2qslHn/lOFKreHuuBAoDzbmgX4yIVDFipoK34xsVoFa
	nt9OC1sMjzuNkqzJS21rqcIYFP06/yjYr5dTnLqNavmMZur2Iljx/hxuiuY9p6ApWMz6uBUaO8u
	Pbu8=
X-Gm-Gg: ASbGncuYHFE0VoiPN2TM9JEaj19aTHcXfWRaGZU18GGBzcDnRJjme6piw3leAbknOb4
	50hdHcj5mGh1Q5HbI0yyarrElA1HNGpn2G15vA6Bmp54MUEpMXzWuZgR4XgTGasck/4ERBr/zq/
	pWSP4lzZfum81zmmD5NE7QXGOOUv/+dMIlXjtMLsLzsDSnM2hIRLPOQJQr66hTxLKC4igi2FIrN
	m5yFOnHJLpH9RHG6EH3T9E0w/ac+k+9e0zALwsk5CkKHkc3fYYA4FGAuHzH4xJWVRAKuDhK9HnP
	dQ9kHyUnPhZxSKBH9YY04+cTooux5OIdD/dOr7RIVetlsh5DiVBO8wqUMJiVPXZkN/rh8I+vqHF
	k
X-Google-Smtp-Source: AGHT+IEs4zDx4IFZZvGcFppBiWLySwtgK9vWrcpsqEHsr3vkFFFWkO18HXnDaOK2Gy28p14uaRbHXA==
X-Received: by 2002:a05:6402:e87:b0:5e0:82a0:50d7 with SMTP id 4fb4d7f45d1cf-5e0b70db116mr13463828a12.8.1740517646507;
        Tue, 25 Feb 2025 13:07:26 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e462032c6dsm1773876a12.73.2025.02.25.13.07.25
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 13:07:25 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abbda4349e9so891928366b.0
        for <linux-tip-commits@vger.kernel.org>; Tue, 25 Feb 2025 13:07:25 -0800 (PST)
X-Received: by 2002:a17:907:94c8:b0:abb:e7b0:5453 with SMTP id
 a640c23a62f3a-abc0d98781bmr1537905366b.12.1740517644705; Tue, 25 Feb 2025
 13:07:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174051422675.10177.13226545170101706336.tip-bot2@tip-bot2>
In-Reply-To: <174051422675.10177.13226545170101706336.tip-bot2@tip-bot2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Feb 2025 13:07:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whfkWMkQOVMCxqcJ6+GWdSZTLcyDUmSRCVHV4BtbwDrHA@mail.gmail.com>
X-Gm-Features: AWEUYZmZfC87y1L1tpnGo4waiHehm2rxjxpr8QrJwMJwrZHzArD8aGOgeNgx2jA
Message-ID: <CAHk-=whfkWMkQOVMCxqcJ6+GWdSZTLcyDUmSRCVHV4BtbwDrHA@mail.gmail.com>
Subject: Re: [tip: x86/mm] x86/mm: Clear _PAGE_DIRTY when we clear _PAGE_RW
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 12:10, tip-bot2 for Matthew Wilcox (Oracle)
<tip-bot2@linutronix.de> wrote:
>
> We should, therefore, clear the _PAGE_DIRTY bit whenever we clear
> _PAGE_RW.  I opted to do it in the callers in case we want to use
> __change_page_attr() to create shadow stacks inside the kernel at some
> point in the future.  Arguably, we might also want to clear _PAGE_ACCESSED
> here.

This explanation makes ZERO sense, and screams "this is a major bug" to me.

If a page is dirty, it doesn't magically turn clean just because it
becomes read-only. The dirty data remains and may need to be written
back to memory.

Imagine writing to a shared memory area, and then marking it all
read-only after you're done. It's still dirty, even if it's read-only.

Now, I don't actually expect this patch to be wrong, I'm literally
just complaining about the explanation. Because the explanation is
very lacking. That's particularly true for the __set_pages_np() case
which also clears _PAGE_PRESENT, because then the whole shadow stacks
explanation flies right out the window: the shadow stack rules simply
do NOT APPLY to non-present pte's in the first place.

So honestly, I think this wants an explanation for why it's actually a
safe change, and how the dirty bit has been saved before the
operation.

             Linus

