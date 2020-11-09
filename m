Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB8D2AC952
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Nov 2020 00:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgKIX0Q (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 9 Nov 2020 18:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731523AbgKIX0P (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 9 Nov 2020 18:26:15 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3858DC0613D4
        for <linux-tip-commits@vger.kernel.org>; Mon,  9 Nov 2020 15:26:15 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id u127so12188123oib.6
        for <linux-tip-commits@vger.kernel.org>; Mon, 09 Nov 2020 15:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38DeofOFUIYkLHO9imZX1OTrjAgZGAGUoTcq8TI1vbI=;
        b=mPXtDnpUWNsQDQKU4BEqEb6c+IKqIlLrne9ZlTQSv44suRs0UqF/YUjFdlHDtAjMs1
         RmYGq+keKmTrlrYEuEclEQfb2G/lvHqtTA9FuxUhMqU3BDrJHzmm5M3YdxYCauA1xBr4
         gtILKmrT1UgfmYGzsf4NaQUa5F4PAkylF2fQSexEdt9ZZ1k87Iw5onaGdbtAhGlzGgej
         aZQu8shSDccyRce7ufVFqQcd6j0bieruHqbOPvWPTLLdyCBkxW9B70n6psBiLinZz+5k
         W1EDXWHJsd7h/UOKG32Kv5ZYSUB8dyaWBhkHfBd/VMkfy1lbASGoD0qDdseQS/ghNn1k
         ZmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38DeofOFUIYkLHO9imZX1OTrjAgZGAGUoTcq8TI1vbI=;
        b=udc5/srs2Rgey/8r28tNp5ROrraoSSnc69YUxoW6jh6gbYWOspCJejuLdUOHcY9g2s
         jmpUXpCC0ohH3i+c+CICdxOiER6wCjZdbrYltCivNz3S7xHjnpVpwNUVambhD9fn7cOl
         upOpIBoT4GL3KIGgmN9e0c0lVvCkhhP1Q8s+cdHWhAXACqQRl2Hrd9BBpReutDnltVNe
         uCW8osIp+5yqtU1sQsCO/1Y0aLl3zY8NGn/B1GnKKkvSu220khymjTqgiJYRVWlE3eoN
         pUN5/rai7J4QyMbHG8/fnIvjCtpP3f0dY7Fmmi6Pih4QqWypEh1qqSLE5Omau1DEuUCB
         3AEA==
X-Gm-Message-State: AOAM533dIixLqrqA6GFD8k4A6Hv9kzjCHb8+9bU1w11vGi/9SY8nU4zS
        Znvucp075kYfk/pR3O/ye5Bhiro7LlCh6mtJyQQ05aHYeto=
X-Google-Smtp-Source: ABdhPJzPGvNiGQt38mG6elvI4UW6ZTgvh7re8iq8Ub9xo68tgHOVP7tdGXalhNBroZjoV4oXYZYvIP66JnOFv8geHnk=
X-Received: by 2002:aca:5505:: with SMTP id j5mr1012865oib.6.1604964374323;
 Mon, 09 Nov 2020 15:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20201030190807.GA13884@agluck-desk2.amr.corp.intel.com>
 <160431588828.397.16468104725047768957.tip-bot2@tip-bot2> <3f863634cd75824907e8ccf8164548c2ef036f20.camel@redhat.com>
 <bfc274fc27724ea39ecac1e7ac834ed8@intel.com> <CALMp9eTFaiYkTnVe8xKzg40E4nZ3rAOii0O06bTy0+oLNjyKhA@mail.gmail.com>
 <a22b5468e1c94906b72c4d8bc83c0f64@intel.com>
In-Reply-To: <a22b5468e1c94906b72c4d8bc83c0f64@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 9 Nov 2020 15:26:02 -0800
Message-ID: <CALMp9eS+SYmPP3OzdK0-Bs1wSBJ4MU_POZe3i5fi3Fd+FTshYw@mail.gmail.com>
Subject: Re: [tip: ras/core] x86/mce: Enable additional error logging on
 certain Intel CPUs
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Qian Cai <cai@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>, Boris Petkov <bp@alien8.de>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Nov 9, 2020 at 2:57 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> > I thought Linux had long ago gone the route of turning rdmsr/wrmsr
> > into rdmsr_safe/wrmsr_safe, so that the guest would ignore the #GPs on
> > writes and return zero to the caller for #GPs on reads.
>
> Linux just switched that around for the machine check banks ... if they #GP
> fault, then something is seriously wrong.
>
> Maybe that isn't a general change of direction though. Perhaps I
> should either use rdmsrl_safe() in this code. Or (better?) add
>
>         if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>                 return;
>
> to the start of intel_imc_init().

I wouldn't expect all hypervisors to necessarily set CPUID.01H:ECX[bit
31]. Architecturally, on Intel CPUs, that bit is simply defined as
"not used." There is no documented contract between Intel and
hypervisor vendors regarding the use of that bit. (AMD, on the other
hand, *does* document that bit as "reserved for use by hypervisor to
indicate guest status.")
