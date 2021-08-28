Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CC73FA5A0
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Aug 2021 14:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhH1MUA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 28 Aug 2021 08:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234070AbhH1MTs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 28 Aug 2021 08:19:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9833B60551;
        Sat, 28 Aug 2021 12:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630153137;
        bh=Nh0BfZMqC8hAr/UrLTtyFIi2G5iHnQ4TpsLNIw5Dw58=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VeCTpCfmBf0HZVk2gVWyUfSj51k2LW5BFI5VhBzwQE3AS0QHvk39i7r6J4+n050XB
         hWFN/cwJd4gy3PDtGuGVkqCjDV6XBdrOoCbZ4AHf2/YyGl5pYybAl0tfZVsuc+oyn2
         Adf6NrnufsgXt5HfQMeAv8aOq1L1Uf57cEQIXGzJC8vG0Q2D3Ttd7i/8f72Lx++noB
         VyGSFdmx8MwulRXFpLjmhLHbQhRA85mmCnf+Tp9YoOYrtvB387FwIPVkRVil1glUfT
         3Gjqytog9ZhaGFmOkXzEJIx25vl7x/62x3fREfWHX/9YU5XTCIQreEl9ZcRXezxh/a
         rWfs6b5cOLGhg==
Received: by mail-ot1-f51.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso11511820otv.12;
        Sat, 28 Aug 2021 05:18:57 -0700 (PDT)
X-Gm-Message-State: AOAM532cBwWH0n/4NidnJG36pX+UzFbv9TPp8KxDI4alsZL1gJAJceAx
        204ZWAcV9HbbSMFsiAdPKMlsSdtEvF5G2DgmUzw=
X-Google-Smtp-Source: ABdhPJzVxgcTW7zMqTEHKjBmXbQ8dnZT0zRpIsKp9aNnaAZpJFK+9W1EgfRduid+rA6jgocm+nr+L03982DRtU2fB8E=
X-Received: by 2002:a05:6830:124b:: with SMTP id s11mr12480317otp.90.1630153137015;
 Sat, 28 Aug 2021 05:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <163014706409.25758.9928933953235257712.tip-bot2@tip-bot2> <d18d2c6fd87f552def3210930da34fd276b4fd6d.camel@perches.com>
In-Reply-To: <d18d2c6fd87f552def3210930da34fd276b4fd6d.camel@perches.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 28 Aug 2021 14:18:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGhnzwP2OP=ECwNK4sG383wvmybCbvUz5YrqNUHSPgOBQ@mail.gmail.com>
Message-ID: <CAMj1kXGhnzwP2OP=ECwNK4sG383wvmybCbvUz5YrqNUHSPgOBQ@mail.gmail.com>
Subject: Re: [tip: efi/core] efi: cper: fix scnprintf() use in cper_mem_err_location()
To:     Joe Perches <joe@perches.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

(add RAS/APEI folks)

On Sat, 28 Aug 2021 at 13:31, Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2021-08-28 at 10:37 +0000, tip-bot2 for Rasmus Villemoes wrote:
> > The following commit has been merged into the efi/core branch of tip:
> []
> > efi: cper: fix scnprintf() use in cper_mem_err_location()
> >
> > The last two if-clauses fail to update n, so whatever they might have
> > written at &msg[n] would be cut off by the final nul-termination.
> >
> > That nul-termination is redundant; scnprintf(), just like snprintf(),
> > guarantees a nul-terminated output buffer, provided the buffer size is
> > positive.
> >
> > And there's no need to discount one byte from the initial buffer;
> > vsnprintf() expects to be given the full buffer size - it's not going
> > to write the nul-terminator one beyond the given (buffer, size) pair.
> []
> > diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> []
> > @@ -221,7 +221,7 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
> >               return 0;
> >
> >
> >       n = 0;
> > -     len = CPER_REC_LEN - 1;
> > +     len = CPER_REC_LEN;
> >       if (mem->validation_bits & CPER_MEM_VALID_NODE)
> >               n += scnprintf(msg + n, len - n, "node: %d ", mem->node);
> >       if (mem->validation_bits & CPER_MEM_VALID_CARD)
>
> [etc...]
>
> Is this always single threaded?
>
> It doesn't seem this is safe for reentry as the output buffer
> being written into is a single static
>
> static char rcd_decode_str[CPER_REC_LEN];
>

Good question. CPER error record decoding typically occurs in response
to an error event raised by firmware, so I think this happens to work
fine in practice. Whether this is guaranteed, I'm not so sure ...
