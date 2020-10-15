Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B884828ED0C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Oct 2020 08:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgJOGYl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 15 Oct 2020 02:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbgJOGYk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 15 Oct 2020 02:24:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C683C0613D2
        for <linux-tip-commits@vger.kernel.org>; Wed, 14 Oct 2020 23:24:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b8so1925579wrn.0
        for <linux-tip-commits@vger.kernel.org>; Wed, 14 Oct 2020 23:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PXzy1d3ckMk0Ny0gHfuwHvgJ6RXIhGLeAUjxyUMOj74=;
        b=YZbkD9vMiz5BzYxugQodbY8GjIsUu9NZMMfVV6I+A0SuakkKwK87m8Mt6+3RgPHchE
         8p0/mxoEh81CbftpKckrDFXk4zF+O3+fTs8kjsCiL+Prl6lFiAlEBVd3hnL1ELLihZu0
         49zucOkSqjTj9l/Zb7mMAyvFgykwp+Dv25lOu4Qo5zkoCcNIL4GJlAu9mBS9LACtkNPe
         x6KzG7b1i5DJvl1hvDKGNZUBB9AtOuxVtfQpwnW1maOLeTKwTB/avP7sy6d6Y2Wh2a8m
         RP3+cr9MKuy/NLMQH+8nh+FtMT6g0DHF4ViKmATpr/SHP/V6CJZdTk7Gzq3BDX4/QMg0
         D3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PXzy1d3ckMk0Ny0gHfuwHvgJ6RXIhGLeAUjxyUMOj74=;
        b=Kt3k8tq6zsdDyJbUjdUaYpGQpa5KCTxHVw7QvzaDmJT8i60+ha5uGcTuZpA569FpOR
         MJiDp8neKvqFgLvYxdYZgWfKOIWtMoT2+awM396Zglt/TzbJSTv/EcyKbhWp6h7I9coT
         +msTmgEDSv/A0iyXjpq7Ab38JJchEehOUevg4FiEDixL2PG7LixMcdRP90y5KDNtYkwB
         WPZ7l1Id5TNk8iCeVXFF4FMxTAci+ltmrRhJwdR2rR1eVPbthpvfdFp47LbkJB8NBt6D
         iWxKJd8Uf0eMpl+W9yE9ipH14BdADJvYzLJzjekf+PzMKk72pPADhgpsCTX/CV8Fn3Gy
         txug==
X-Gm-Message-State: AOAM53304Gcnubw3SrJrCfBYYVTLB+dfaK7i04U/NG3TZ4R3EQpA8NIp
        kT/tW8t6s356vUQSi8d/cIiERFnNsmPBNya/mQBFwA==
X-Google-Smtp-Source: ABdhPJxBQX/QxK6pw7DKHu3C/wNzs8v0GZG0QDSdLbwtuGccZJwqO/VtMhCyAGnJcHarzcj3QQkcXqPhY9n4PXmtnIM=
X-Received: by 2002:a5d:6407:: with SMTP id z7mr2524568wru.271.1602743078716;
 Wed, 14 Oct 2020 23:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <160208761921.7002.1321765913567405137.tip-bot2@tip-bot2>
 <20201009203822.GA2974@worktop.programming.kicks-ass.net> <20201009204921.GB21731@zn.tnic>
 <20201010174415.zwopoy6vpficoqlr@treble> <20201012091236.0f9a64bfedb8825732b65ea5@kernel.org>
 <20201012153949.jfwa7rgpzu5b7ld4@treble> <20201014162859.987d5f71f5e5456ffb812abc@kernel.org>
In-Reply-To: <20201014162859.987d5f71f5e5456ffb812abc@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Oct 2020 23:24:26 -0700
Message-ID: <CAP-5=fUoSGy3NAzTSbF3YLEPABSs7oPsxLkCx36XkEzzm341yw@mail.gmail.com>
Subject: Re: [tip: objtool/core] x86/insn: Support big endian cross-compiles
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Oct 14, 2020 at 12:29 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Mon, 12 Oct 2020 10:39:49 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> > On Mon, Oct 12, 2020 at 09:12:36AM +0900, Masami Hiramatsu wrote:
> > > On Sat, 10 Oct 2020 12:44:15 -0500
> > > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > > On Fri, Oct 09, 2020 at 10:49:21PM +0200, Borislav Petkov wrote:
> > > > > On Fri, Oct 09, 2020 at 10:38:22PM +0200, Peter Zijlstra wrote:
> > > > > > On Wed, Oct 07, 2020 at 04:20:19PM -0000, tip-bot2 for Martin Schwidefsky wrote:
> > > > > > > The following commit has been merged into the objtool/core branch of tip:
> > > > > > >
> > > > > > > Commit-ID:     2a522b53c47051d3bf98748418f4f8e5f20d2c04
> > > > > > > Gitweb:        https://git.kernel.org/tip/2a522b53c47051d3bf98748418f4f8e5f20d2c04
> > > > > > > Author:        Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > > > > > AuthorDate:    Mon, 05 Oct 2020 17:50:31 +02:00
> > > > > > > Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
> > > > > > > CommitterDate: Tue, 06 Oct 2020 09:32:29 -05:00
> > > > > > >
> > > > > > > x86/insn: Support big endian cross-compiles
> > > > > > >
> > > > > > > x86 instruction decoder code is shared across the kernel source and the
> > > > > > > tools. Currently objtool seems to be the only tool from build tools needed
> > > > > > > which breaks x86 cross compilation on big endian systems. Make the x86
> > > > > > > instruction decoder build host endianness agnostic to support x86 cross
> > > > > > > compilation and enable objtool to implement endianness awareness for
> > > > > > > big endian architectures support.
> > > > > > >
> > > > > > > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > > > > > Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
> > > > > > > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> > > > > > > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > > > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > > >
> > > > > > This commit breaks the x86 build with CONFIG_X86_DECODER_SELFTEST=y.
> > > > > >
> > > > > > I've asked Boris to truncate tip/objtool/core.
> > > > >
> > > > > Yeah, top 4 are gone until this is resolved.
> > > >
> > > > Masami, I wonder if we even need these selftests anymore?  Objtool
> > > > already decodes the entire kernel.
> > >
> > > No, they have different roles. The selftest checks if the decoder
> > > works correctly by comparing with the output of objdump.
> > >
> > > As far as I can see, the objtool relies on the sanity of the decoder
> > > (it trusts the output of the decoder).
> >
> > Ok.  I wonder if we should move the decoder selftest to the 'tools'
> > subdirectory.
>
> It is in the arch/x86/tools, so it is already in a kind of tools :)
> But yeah, it was considered to be used only on x86. But if someone
> start trying to run it on non-x86, cross compiling, we need to
> reconsider that.
>
> Thank you,
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>

There is undefined behavior that is present in the x86 insn.c code as
described in:
https://lore.kernel.org/lkml/20190724184512.162887-4-nums@google.com/

I resent this patch fixing other potential undefined behavior:
https://lore.kernel.org/lkml/20201015062148.1437894-1-irogers@google.com/T/#t

The misaligned loads will likely break on anything non-x86.

Thanks,
Ian
