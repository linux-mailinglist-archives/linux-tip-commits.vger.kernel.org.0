Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA353FD3FD
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Sep 2021 08:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbhIAGwE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 1 Sep 2021 02:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242018AbhIAGvz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 1 Sep 2021 02:51:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1972761026;
        Wed,  1 Sep 2021 06:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630479059;
        bh=nuifr3ris37q+Y5JGJfMUBRYEWniYo1DWffXeGtMmxU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i9IqqT94pUcFlO/OH1o/g+x3IP8QKvFP9vtmlNJi04OuOuwUtMcllybisPsv0bF4o
         T9R2fydFMFBOoQ4IQgBz7fMeHlX9/ubAdGzcDRFAnaMPlavofriJ1ZT+cIGEqEkXOy
         JutgAwBM1B2EsIfywt6295cr+1GvGqClzkZe9bSifF4OqkrVsGrvyHy04dKt//f5l3
         86ChPbHsHmSltPolXxnezMyL8jKzZ4d4jIwObwQ+mPivabAtgSVhjVh0P0FuxE3mJ/
         0hUnSdxyfGck+zSg963UtENyWzQwQjaO0ydVW4LxxbryM7XLfaV7IbvHhZdIE7KZ9g
         Ekz23d3r1dy8g==
Received: by mail-oi1-f173.google.com with SMTP id n27so2646589oij.0;
        Tue, 31 Aug 2021 23:50:59 -0700 (PDT)
X-Gm-Message-State: AOAM533+Xifd2xNoXxwcb7Vmap4GH/mhiIU/0vv8ptU53R4Fou6kOM/Y
        tmVQc6D5fan8GQSiLOBh5iF/efGtCUl1jNp7EM0=
X-Google-Smtp-Source: ABdhPJyNLgCZp34W88Uie1F+sI5ioPLOVxDGAn9K5700mn+kYeeNw0qY9yRJOgR99xJKKif2ULpG7mguhuhucd6g+EY=
X-Received: by 2002:aca:eb97:: with SMTP id j145mr6118513oih.33.1630479058436;
 Tue, 31 Aug 2021 23:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <163014706409.25758.9928933953235257712.tip-bot2@tip-bot2>
 <d18d2c6fd87f552def3210930da34fd276b4fd6d.camel@perches.com>
 <CAMj1kXGhnzwP2OP=ECwNK4sG383wvmybCbvUz5YrqNUHSPgOBQ@mail.gmail.com> <44c6c9b3-bade-41ab-2166-b4cd1ed97408@arm.com>
In-Reply-To: <44c6c9b3-bade-41ab-2166-b4cd1ed97408@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 1 Sep 2021 08:50:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGs36bL111qfv8HsOxuZ_GAHTkCSij7qzp7E_mprk=EgQ@mail.gmail.com>
Message-ID: <CAMj1kXGs36bL111qfv8HsOxuZ_GAHTkCSij7qzp7E_mprk=EgQ@mail.gmail.com>
Subject: Re: [tip: efi/core] efi: cper: fix scnprintf() use in cper_mem_err_location()
To:     James Morse <james.morse@arm.com>
Cc:     Joe Perches <joe@perches.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, 31 Aug 2021 at 18:02, James Morse <james.morse@arm.com> wrote:
>
> Hi guys,
>
> On 28/08/2021 13:18, Ard Biesheuvel wrote:
> > (add RAS/APEI folks)
> >
> > On Sat, 28 Aug 2021 at 13:31, Joe Perches <joe@perches.com> wrote:
> >>
> >> On Sat, 2021-08-28 at 10:37 +0000, tip-bot2 for Rasmus Villemoes wrote:
> >>> The following commit has been merged into the efi/core branch of tip:
> >> []
> >>> efi: cper: fix scnprintf() use in cper_mem_err_location()
> >>>
> >>> The last two if-clauses fail to update n, so whatever they might have
> >>> written at &msg[n] would be cut off by the final nul-termination.
> >>>
> >>> That nul-termination is redundant; scnprintf(), just like snprintf(),
> >>> guarantees a nul-terminated output buffer, provided the buffer size is
> >>> positive.
> >>>
> >>> And there's no need to discount one byte from the initial buffer;
> >>> vsnprintf() expects to be given the full buffer size - it's not going
> >>> to write the nul-terminator one beyond the given (buffer, size) pair.
> >> []
> >>> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> >> []
> >>> @@ -221,7 +221,7 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
> >>>               return 0;
> >>>
> >>>
> >>>       n = 0;
> >>> -     len = CPER_REC_LEN - 1;
> >>> +     len = CPER_REC_LEN;
> >>>       if (mem->validation_bits & CPER_MEM_VALID_NODE)
> >>>               n += scnprintf(msg + n, len - n, "node: %d ", mem->node);
> >>>       if (mem->validation_bits & CPER_MEM_VALID_CARD)
> >>
> >> [etc...]
> >>
> >> Is this always single threaded?
> >>
> >> It doesn't seem this is safe for reentry as the output buffer
> >> being written into is a single static
> >>
> >> static char rcd_decode_str[CPER_REC_LEN];
>
> > Good question. CPER error record decoding typically occurs in response
> > to an error event raised by firmware, so I think this happens to work
> > fine in practice. Whether this is guaranteed, I'm not so sure ...
>
> There is locking to prevent concurrent access to the firmware buffer, but that only
> serialises the CPER records being copied. The printing may happen in parallel on different
> CPUs if there are multiple errors.
>
> cper_estatus_print() is called in NMI context if an NMI indicates a fatal error. See
> __ghes_panic().
>

OK, better to fix it then - there does not seem to be a good reason
for using a buffer in BSS here anyway.

I'll send out a patch.

Thanks,
Ard.
