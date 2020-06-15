Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91581FA3AC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Jun 2020 00:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgFOWqO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Jun 2020 18:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgFOWqO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Jun 2020 18:46:14 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85257207D4
        for <linux-tip-commits@vger.kernel.org>; Mon, 15 Jun 2020 22:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592261173;
        bh=g+es2wRdd6OfsBGwlF+KXjC8dXEfPRX3KCkljPYj1kI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V5YcBOxoaOUp9WqtMqv9B6Q3WmllVWjXoPhzjEkHzCj7eBQA3GKLXrml6lyE8QPJo
         CaKmnMb/Dp1n5F06uLYYlXZRRZy2Dou97wH/3z0wrZ6I6tFI3amOce1Z1KDfScFRL5
         NF5AE0Vfc+oxIAV5V8w/Xsyig14nbexk+h5ANNLg=
Received: by mail-wr1-f51.google.com with SMTP id e1so18809401wrt.5
        for <linux-tip-commits@vger.kernel.org>; Mon, 15 Jun 2020 15:46:13 -0700 (PDT)
X-Gm-Message-State: AOAM532EDgigMceZDP/nsp94AWPxUorqnjwKIErdRADmZoCKlpbdZWCr
        tx95Fo6qIjJ/u6skaBosQkoh65SHi3qlSxDoizc8rA==
X-Google-Smtp-Source: ABdhPJzzK38Hhpi4cxwVUdqJm3iUGTYewgVcPhGh6vuIjTVr6IOtiVA7Zldem175jw8oZdcV0XlerTfMpGjp0AG4kpE=
X-Received: by 2002:adf:ea11:: with SMTP id q17mr30345939wrm.75.1592261172100;
 Mon, 15 Jun 2020 15:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <f8fe40e0088749734b4435b554f73eee53dcf7a8.1591932307.git.luto@kernel.org>
 <159199140855.16989.18012912492179715507.tip-bot2@tip-bot2>
 <20200615145018.GU2531@hirez.programming.kicks-ass.net> <CALCETrWhbg_61CTo9_T6s1NDFvOgUx7ebSzhXj7O_m8htePwKA@mail.gmail.com>
 <20200615194458.GL2531@hirez.programming.kicks-ass.net> <CALCETrUbwwoYTzyntr=bUjJU44iyt+S8bRS04OxmByP3aD4A9g@mail.gmail.com>
 <20200615222330.GI2514@hirez.programming.kicks-ass.net>
In-Reply-To: <20200615222330.GI2514@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 15 Jun 2020 15:46:00 -0700
X-Gmail-Original-Message-ID: <CALCETrXisDDMb_eaPDq1DWrMuSqo1hDrOd14u7fSR4J_RxJu_A@mail.gmail.com>
Message-ID: <CALCETrXisDDMb_eaPDq1DWrMuSqo1hDrOd14u7fSR4J_RxJu_A@mail.gmail.com>
Subject: Re: [tip: x86/entry] x86/entry: Treat BUG/WARN as NMI-like entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Jun 15, 2020 at 3:23 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jun 15, 2020 at 02:08:16PM -0700, Andy Lutomirski wrote:
>
> > > All !user exceptions really should be NMI-like. If you want to go
> > > overboard, I suppose you can look at IF and have them behave interrupt
> > > like when set, but why make things complicated.
> >
> > This entire rabbit hole opened because of #PF. So we at least need the
> > set of exceptions that are permitted to schedule if they came from
> > kernel mode to remain schedulable.
>
> What exception, other than #PF, actually needs to schedule from kernel?
>
> > Prior to the giant changes, all the non-IST *exceptions*, but not the
> > interrupts, were schedulable from kernel mode, assuming the original
> > context could schedule. Right now, interrupts can schedule, too, which
> > is nice if we ever want to fully clean up the Xen abomination. I
> > suppose we could make it so #PF opts in to special treatment again,
> > but we should decide that the result is simpler or otherwise better
> > before we do this.
> >
> > One possible justification would be that the schedulable entry variant
> > is more complicated, and most kernel exceptions except the ones with
> > fixups are bad news, and we want the oopses to succeed. But page
> > faults are probably the most common source of oopses, so this is a bit
> > weak, and we really want page faults to work even from nasty contexts.
>
> I think I'd prefer the argument of consistent failure.
>
> Do we ever want #UD to schedule? If not, then why allow it to sometimes
> schedule and sometimes fail, better to always fail.
>
> #DB is still a giant trainwreck in this regard as well.
>
> Something like this...
>
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -216,10 +216,25 @@ static inline void handle_invalid_op(str
>                       ILL_ILLOPN, error_get_trap_addr(regs));
>  }
>
> -DEFINE_IDTENTRY_RAW(exc_invalid_op)
> +static void handle_invalid_op_kernel(struct pt_regs *regs)
> +{
> +       if (is_valid_bugaddr(regs->ip) &&
> +           report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
> +               /* Skip the ud2. */
> +               regs->ip += LEN_UD2;
> +               return;
> +       }
> +
> +       handle_invalid_op(regs);
> +}
> +
> +static void handle_invalid_op_user(struct pt_regs *regs)
>  {
> -       bool rcu_exit;
> +       handle_invalid_op(regs);
> +}
>
> +DEFINE_IDTENTRY_RAW(exc_invalid_op)
> +{

Meh, I guess I'm okay with this.

In some sense, #UD and #PF are fundamentally different.  #PF wants to
be able to schedule in the kernel.  #UD wants to be as minimal as
possible in the kernel but probably still wants to do the nmi_enter()
dance in case it's an RCU warning and the warning handler code wants
to use RCU.

One solution would be to get rid of ud2 for warnings and replace it
with CALL warning_thunk :)  But I guess I'm okay with your patch.

--Andy
