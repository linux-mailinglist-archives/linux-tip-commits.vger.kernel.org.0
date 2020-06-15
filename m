Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32871F9E1A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jun 2020 19:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgFORGe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Jun 2020 13:06:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729124AbgFORGd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Jun 2020 13:06:33 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA832078A
        for <linux-tip-commits@vger.kernel.org>; Mon, 15 Jun 2020 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592240793;
        bh=r5R/ikfStX/TN262QFGVTMqGbq7JL4UwYz+2Sek4Smg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1UZJ8DRv73SEfs3IFT6VATioL6Rq7K2O3RMd68r3HG1lpmKcZjZ9w8Cfl2bsR4gbx
         MmyCiTH82vhwq5g8oy5zQ0NW50PjUqUFVugUojy/uO3u/Uva/5nWnVxXpdUsSf1KVH
         OrjHp+4GUw8AnQnGaxudHp+W2M5yD/qKn5tljI7w=
Received: by mail-wr1-f43.google.com with SMTP id r7so17925547wro.1
        for <linux-tip-commits@vger.kernel.org>; Mon, 15 Jun 2020 10:06:32 -0700 (PDT)
X-Gm-Message-State: AOAM530PdMB6gLxGdLtPyQUnZAFg/obvj2+LaghFK2gv/IfmChWKAnxq
        Wj6sCcQG0ReYmwJPHsptoLxPnV4PqNgz1n0euiNQAw==
X-Google-Smtp-Source: ABdhPJxgwUDnzgrk7e8LJjUyWgTzQSzXN9RlagDqH82jXjka9LeEJNZPzaEoFQyFFX3xmmRC08Cr/kXCWHozlXoxzQU=
X-Received: by 2002:adf:ea11:: with SMTP id q17mr29246918wrm.75.1592240791404;
 Mon, 15 Jun 2020 10:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <f8fe40e0088749734b4435b554f73eee53dcf7a8.1591932307.git.luto@kernel.org>
 <159199140855.16989.18012912492179715507.tip-bot2@tip-bot2> <20200615145018.GU2531@hirez.programming.kicks-ass.net>
In-Reply-To: <20200615145018.GU2531@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 15 Jun 2020 10:06:20 -0700
X-Gmail-Original-Message-ID: <CALCETrWhbg_61CTo9_T6s1NDFvOgUx7ebSzhXj7O_m8htePwKA@mail.gmail.com>
Message-ID: <CALCETrWhbg_61CTo9_T6s1NDFvOgUx7ebSzhXj7O_m8htePwKA@mail.gmail.com>
Subject: Re: [tip: x86/entry] x86/entry: Treat BUG/WARN as NMI-like entries
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

On Mon, Jun 15, 2020 at 7:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 12, 2020 at 07:50:08PM -0000, tip-bot2 for Andy Lutomirski wrote:
> > +DEFINE_IDTENTRY_RAW(exc_invalid_op)
> >  {
> > +     bool rcu_exit;
> > +
> > +     /*
> > +      * Handle BUG/WARN like NMIs instead of like normal idtentries:
> > +      * if we bugged/warned in a bad RCU context, for example, the last
> > +      * thing we want is to BUG/WARN again in the idtentry code, ad
> > +      * infinitum.
> > +      */
> > +     if (!user_mode(regs) && is_valid_bugaddr(regs->ip)) {
>
> vmlinux.o: warning: objtool: exc_invalid_op()+0x47: call to probe_kernel_read() leaves .noinstr.text section
>
> > +             enum bug_trap_type type;
> > +
> > +             nmi_enter();
> > +             instrumentation_begin();
> > +             trace_hardirqs_off_finish();
> > +             type = report_bug(regs->ip, regs);
> > +             if (regs->flags & X86_EFLAGS_IF)
> > +                     trace_hardirqs_on_prepare();
> > +             instrumentation_end();
> > +             nmi_exit();
> > +
> > +             if (type == BUG_TRAP_TYPE_WARN) {
> > +                     /* Skip the ud2. */
> > +                     regs->ip += LEN_UD2;
> > +                     return;
> > +             }
> > +
> > +             /*
> > +              * Else, if this was a BUG and report_bug returns or if this
> > +              * was just a normal #UD, we want to continue onward and
> > +              * crash.
> > +              */
> > +     }
> > +
> > +     rcu_exit = idtentry_enter_cond_rcu(regs);
> > +     instrumentation_begin();
> >       handle_invalid_op(regs);
> > +     instrumentation_end();
> > +     idtentry_exit_cond_rcu(regs, rcu_exit);
> >  }
>
>
> For now something like so will do, but we need a DEFINE_IDTENTRY_foo()
> for the whole:
>
>         if (user_mode()) {
>                 rcu = idtentry_enter_cond_rcu()
>                 foo_user()
>                 idtentry_exit_cond_rcu(rcu);
>         } else {
>                 nmi_enter();
>                 foo_kernel()
>                 nmi_exit()
>         }
>
> thing, we're repeating that far too often.
>
>

Hmm.  IMO you're making two changes here, and this is fiddly enough
that it might be worth separating them for bisection purposes.

> ---
>
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index af75109485c26..a47e74923c4c8 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -218,21 +218,22 @@ static inline void handle_invalid_op(struct pt_regs *regs)
>
>  DEFINE_IDTENTRY_RAW(exc_invalid_op)
>  {
> -       bool rcu_exit;
> -
>         /*
>          * Handle BUG/WARN like NMIs instead of like normal idtentries:
>          * if we bugged/warned in a bad RCU context, for example, the last
>          * thing we want is to BUG/WARN again in the idtentry code, ad
>          * infinitum.
>          */
> -       if (!user_mode(regs) && is_valid_bugaddr(regs->ip)) {
> -               enum bug_trap_type type;
> +       if (!user_mode(regs)) {
> +               enum bug_trap_type type = BUG_TRAP_TYPE_NONE;
>
>                 nmi_enter();
>                 instrumentation_begin();
>                 trace_hardirqs_off_finish();
> -               type = report_bug(regs->ip, regs);
> +
> +               if (is_valid_bugaddr(regs->ip))
> +                       type = report_bug(regs->ip, regs);
> +

Sigh, this is indeed necessary.

>                 if (regs->flags & X86_EFLAGS_IF)
>                         trace_hardirqs_on_prepare();
>                 instrumentation_end();
> @@ -249,13 +250,16 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
>                  * was just a normal #UD, we want to continue onward and
>                  * crash.
>                  */
> -       }
> +               handle_invalid_op(regs);

But this is really a separate change.  This makes handle_invalid_op()
be NMI-like even for non-BUG/WARN kernel #UD entries.  One might argue
that this doesn't matter, and that's probably right, but I think it
should be its own change with its own justification.  With just my
patch, I intentionally call handle_invalid_op() via the normal
idtentry_enter_cond_rcu() path.

--Andy
