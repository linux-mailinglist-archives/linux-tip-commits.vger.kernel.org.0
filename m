Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3FF29C624
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Oct 2020 19:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1822159AbgJ0SNp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Oct 2020 14:13:45 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:53542 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756518AbgJ0ON4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Oct 2020 10:13:56 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 22818078-1500050 
        for multiple; Tue, 27 Oct 2020 14:13:35 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201027124834.GL2628@hirez.programming.kicks-ass.net>
References: <20200930094937.GE2651@hirez.programming.kicks-ass.net> <160208761332.7002.17400661713288945222.tip-bot2@tip-bot2> <160379817513.29534.880306651053124370@build.alporthouse.com> <20201027115955.GA2611@hirez.programming.kicks-ass.net> <20201027123056.GE2651@hirez.programming.kicks-ass.net> <20201027124834.GL2628@hirez.programming.kicks-ass.net>
Subject: Re: [tip: locking/core] lockdep: Fix usage_traceoverflow
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>,
        Qian Cai <cai@redhat.com>, x86 <x86@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Date:   Tue, 27 Oct 2020 14:13:31 +0000
Message-ID: <160380801190.10461.12497441495326131849@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Quoting Peter Zijlstra (2020-10-27 12:48:34)
> On Tue, Oct 27, 2020 at 01:30:56PM +0100, Peter Zijlstra wrote:
> > This seems to make it happy. Not quite sure that's the best solution.
> > 
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 3e99dfef8408..81295bc760fe 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -4411,7 +4405,9 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
> >               break;
> >  
> >       case LOCK_USED:
> > -             debug_atomic_dec(nr_unused_locks);
> > +     case LOCK_USED_READ:
> > +             if ((hlock_class(this)->usage_mask & (LOCKF_USED|LOCKF_USED_READ)) == new_mask)
> > +                     debug_atomic_dec(nr_unused_locks);
> >               break;
> >  
> >       default:
> 
> This also works, and I think I likes it better.. anyone?
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 3e99dfef8408..e603e86c0227 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -4396,6 +4390,9 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
>         if (unlikely(hlock_class(this)->usage_mask & new_mask))
>                 goto unlock;
>  
> +       if (!hlock_class(this)->usage_mask)
> +               debug_atomic_dec(nr_unused_locks);
> +

From an outside perspective, this is much easier for me to match with
the assertion in lockdep_proc.

Our CI confirms this works, and we are just left with the new issue of

<4> [260.903453] hm#2, depth: 6 [6], eb18a85a2df37d3d != a6ee4649c0022599
<4> [260.903458] WARNING: CPU: 7 PID: 5515 at kernel/locking/lockdep.c:3679 check_chain_key+0x1a4/0x1f0

Thanks,
-Chris
