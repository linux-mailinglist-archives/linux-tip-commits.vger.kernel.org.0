Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78ACC24EA0A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Aug 2020 23:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgHVV7w (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 22 Aug 2020 17:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgHVV7v (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 22 Aug 2020 17:59:51 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B72920FC3
        for <linux-tip-commits@vger.kernel.org>; Sat, 22 Aug 2020 21:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598133590;
        bh=26/N8+mvdu6vlbNFTien1WtTQ3gb3dU7NGk55H9qbcg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XqoYxwF1bwXh/iSy5GpGXceIJHdU3M6lfgzq0M1F6S1AzgrK+fMdw8yLVzBtisc5x
         e6lsVvnJMZOER4PR+5pNh1ARBTvU4q7mQsEANhNkEm/vkpA9s2mgGHGbWxNwke6z0L
         +dlKJyuQBeyj/BC6RLr2VbPRTlnxcJr/poHOeBYs=
Received: by mail-wm1-f52.google.com with SMTP id u18so4990077wmc.3
        for <linux-tip-commits@vger.kernel.org>; Sat, 22 Aug 2020 14:59:50 -0700 (PDT)
X-Gm-Message-State: AOAM5318pJibRkZ+hF7gkavvziLeg7VVDjCKkWk8p4iyx19WB2sDFb2f
        SDAiRjOqN+s1hwrEkAwCywGljt/QAStckoV2np3o3g==
X-Google-Smtp-Source: ABdhPJx8zYLtQI9PtVOSnI3R8T+8esNH3luXDKza2exG6DLlTSdqFPsxQ/yBNmt1hQvaBDz7uJ7L04rqy528U7jIwUk=
X-Received: by 2002:a7b:ca48:: with SMTP id m8mr127503wml.36.1598133588918;
 Sat, 22 Aug 2020 14:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <881de09e786ab93ce56ee4a2437ba2c308afe7a9.1593795633.git.luto@kernel.org>
 <159388495037.4006.7851835406474127743.tip-bot2@tip-bot2> <20200820102344.GP2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200820102344.GP2674@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 22 Aug 2020 14:59:37 -0700
X-Gmail-Original-Message-ID: <CALCETrVFQuMcUgfDkREGFHSSF9UW5yy4UuNZSpjw1962eSvLyw@mail.gmail.com>
Message-ID: <CALCETrVFQuMcUgfDkREGFHSSF9UW5yy4UuNZSpjw1962eSvLyw@mail.gmail.com>
Subject: Re: [tip: x86/urgent] x86/entry, selftests: Further improve user
 entry sanity checks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Aug 20, 2020 at 3:24 AM <peterz@infradead.org> wrote:
>
> On Sat, Jul 04, 2020 at 05:49:10PM -0000, tip-bot2 for Andy Lutomirski wrote:
>
> > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > index f392a8b..e83b3f1 100644
> > --- a/arch/x86/entry/common.c
> > +++ b/arch/x86/entry/common.c
> > @@ -49,6 +49,23 @@
> >  static void check_user_regs(struct pt_regs *regs)
> >  {
> >       if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
> > +             /*
> > +              * Make sure that the entry code gave us a sensible EFLAGS
> > +              * register.  Native because we want to check the actual CPU
> > +              * state, not the interrupt state as imagined by Xen.
> > +              */
> > +             unsigned long flags = native_save_fl();
> > +             WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
> > +                                   X86_EFLAGS_NT));
>
> This triggers with AC|TF on my !SMAP enabled machine.
>
> something like so then?
>
> diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
> index a8f9315b9eae..76410964585f 100644
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -18,8 +18,15 @@ static __always_inline void arch_check_user_regs(struct pt_regs *regs)
>                  * state, not the interrupt state as imagined by Xen.
>                  */
>                 unsigned long flags = native_save_fl();
> -               WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
> -                                     X86_EFLAGS_NT));
> +               unsigned long mask = X86_EFLAGS_DF | X86_EFLAGS_NT;
> +
> +               /*
> +                * For !SMAP hardware we patch out CLAC on entry.
> +                */
> +               if (boot_cpu_has(X86_FEATURE_SMAP))
> +                       mask |= X86_EFLAGS_AC;
> +
> +               WARN_ON_ONCE(flags & mask);
>
>                 /* We think we came from user mode. Make sure pt_regs agrees. */
>                 WARN_ON_ONCE(!user_mode(regs));

LGTM.

Acked-by: Andy Lutomirski <luto@kernel.org>
