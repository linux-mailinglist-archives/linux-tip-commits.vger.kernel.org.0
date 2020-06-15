Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE20B1FA286
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jun 2020 23:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbgFOVIa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Jun 2020 17:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731420AbgFOVIa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Jun 2020 17:08:30 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B5242078E
        for <linux-tip-commits@vger.kernel.org>; Mon, 15 Jun 2020 21:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592255309;
        bh=2uwrT3LndWuOmVFs7KNYrM0gYbf8YHkseGi77l6m1nA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SwFe1XrVngm7lGTXR+6vv1E0vGwbBXS2LrKN04vBZe4ChL/Yx1XYcx2YDv3NuRWks
         oaPgW46sENCNptuQZZ8gwtNI8mhdOtgfZ1nQV1IRIcBr7CP64JYvLCqDD9JZmDlnZz
         i7E35/oiM6/+l5NE0Wqpha2y0YkEvubz/8CmSjhQ=
Received: by mail-wm1-f46.google.com with SMTP id r9so921471wmh.2
        for <linux-tip-commits@vger.kernel.org>; Mon, 15 Jun 2020 14:08:28 -0700 (PDT)
X-Gm-Message-State: AOAM532Lq3x7zQcLUo54aDiR/hyGclOh9SC/FAfU9ke00CZ7f80xPeNz
        nV/39lKjigcY3w6SAhyDU40CL1f9R/P7aPOExeVocA==
X-Google-Smtp-Source: ABdhPJyxEn4ZEFRrBcIP2yFeRdfXbYA/EdvnZ/NhZpeD3cwBJrDDqngPIQlMSjRWfaptXiQXlOJ2wY53olUTtd7wH3U=
X-Received: by 2002:a05:600c:22da:: with SMTP id 26mr1175441wmg.176.1592255307605;
 Mon, 15 Jun 2020 14:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <f8fe40e0088749734b4435b554f73eee53dcf7a8.1591932307.git.luto@kernel.org>
 <159199140855.16989.18012912492179715507.tip-bot2@tip-bot2>
 <20200615145018.GU2531@hirez.programming.kicks-ass.net> <CALCETrWhbg_61CTo9_T6s1NDFvOgUx7ebSzhXj7O_m8htePwKA@mail.gmail.com>
 <20200615194458.GL2531@hirez.programming.kicks-ass.net>
In-Reply-To: <20200615194458.GL2531@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 15 Jun 2020 14:08:16 -0700
X-Gmail-Original-Message-ID: <CALCETrUbwwoYTzyntr=bUjJU44iyt+S8bRS04OxmByP3aD4A9g@mail.gmail.com>
Message-ID: <CALCETrUbwwoYTzyntr=bUjJU44iyt+S8bRS04OxmByP3aD4A9g@mail.gmail.com>
Subject: Re: [tip: x86/entry] x86/entry: Treat BUG/WARN as NMI-like entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

> On Jun 15, 2020, at 12:45 PM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> =EF=BB=BFOn Mon, Jun 15, 2020 at 10:06:20AM -0700, Andy Lutomirski wrote:
>>> On Mon, Jun 15, 2020 at 7:50 AM Peter Zijlstra <peterz@infradead.org> w=
rote:
>>
>> Hmm.  IMO you're making two changes here, and this is fiddly enough
>> that it might be worth separating them for bisection purposes.
>
> Sure, can do.
>
>>> ---
>>>
>>> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
>>> index af75109485c26..a47e74923c4c8 100644
>>> --- a/arch/x86/kernel/traps.c
>>> +++ b/arch/x86/kernel/traps.c
>>> @@ -218,21 +218,22 @@ static inline void handle_invalid_op(struct pt_re=
gs *regs)
>>>
>>> DEFINE_IDTENTRY_RAW(exc_invalid_op)
>>> {
>>> -       bool rcu_exit;
>>> -
>>>        /*
>>>         * Handle BUG/WARN like NMIs instead of like normal idtentries:
>>>         * if we bugged/warned in a bad RCU context, for example, the la=
st
>>>         * thing we want is to BUG/WARN again in the idtentry code, ad
>>>         * infinitum.
>>>         */
>>> -       if (!user_mode(regs) && is_valid_bugaddr(regs->ip)) {
>>> -               enum bug_trap_type type;
>>> +       if (!user_mode(regs)) {
>>> +               enum bug_trap_type type =3D BUG_TRAP_TYPE_NONE;
>>>
>>>                nmi_enter();
>>>                instrumentation_begin();
>>>                trace_hardirqs_off_finish();
>>> -               type =3D report_bug(regs->ip, regs);
>>> +
>>> +               if (is_valid_bugaddr(regs->ip))
>>> +                       type =3D report_bug(regs->ip, regs);
>>> +
>>
>> Sigh, this is indeed necessary.
>
> :-)
>
>>>                if (regs->flags & X86_EFLAGS_IF)
>>>                        trace_hardirqs_on_prepare();
>>>                instrumentation_end();
>>> @@ -249,13 +250,16 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
>>>                 * was just a normal #UD, we want to continue onward and
>>>                 * crash.
>>>                 */
>>> -       }
>>> +               handle_invalid_op(regs);
>>
>> But this is really a separate change.  This makes handle_invalid_op()
>> be NMI-like even for non-BUG/WARN kernel #UD entries.  One might argue
>> that this doesn't matter, and that's probably right, but I think it
>> should be its own change with its own justification.  With just my
>> patch, I intentionally call handle_invalid_op() via the normal
>> idtentry_enter_cond_rcu() path.
>
> All !user exceptions really should be NMI-like. If you want to go
> overboard, I suppose you can look at IF and have them behave interrupt
> like when set, but why make things complicated.

This entire rabbit hole opened because of #PF. So we at least need the
set of exceptions that are permitted to schedule if they came from
kernel mode to remain schedulable.

Prior to the giant changes, all the non-IST *exceptions*, but not the
interrupts, were schedulable from kernel mode, assuming the original
context could schedule. Right now, interrupts can schedule, too, which
is nice if we ever want to fully clean up the Xen abomination. I
suppose we could make it so #PF opts in to special treatment again,
but we should decide that the result is simpler or otherwise better
before we do this.

One possible justification would be that the schedulable entry variant
is more complicated, and most kernel exceptions except the ones with
fixups are bad news, and we want the oopses to succeed. But page
faults are probably the most common source of oopses, so this is a bit
weak, and we really want page faults to work even from nasty contexts.

>
> Anyway, let me to smaller and proper patches for this.
