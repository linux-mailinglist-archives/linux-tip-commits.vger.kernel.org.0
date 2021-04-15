Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48870360149
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Apr 2021 07:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhDOFCs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 15 Apr 2021 01:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhDOFCr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 15 Apr 2021 01:02:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AD826115C;
        Thu, 15 Apr 2021 05:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618462945;
        bh=Y3LVWFe15Vks9Gdlcz+Rq+67gcDclCmHU2vPUGj2gfU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=c0IZadq4snCAW+txyztM0vmEPqpElfgHhb3LoxVbl92gR+YMdO4MSQOeOZIGptxPw
         5pX2JYdFu7UMwr/Pc952lRGqCqFYpkcI8IWZ1nopQGB+39S09xWiECulINT6xAbujP
         JQDI023C5T/KbtJ4HaHY7FjLaOYquiOIDQ6Akb+mc02jUgUrtezh1JHUdADpt2xCzz
         x/PgIW6VWcTrTsNtQJICQYvIAYxafyamuFe7ZYvxUsJaYl27QanSDvq1LU7M72RJHD
         jkRHdiMuytoHRwKAp7u1gjnkJEVH9iZl+vyT56h40oyI+P/hFc5bTilzQ0RelYYm/g
         giZEyObSpedOw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 266B05C2732; Wed, 14 Apr 2021 22:02:25 -0700 (PDT)
Date:   Wed, 14 Apr 2021 22:02:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: core/rcu] softirq: Don't try waking ksoftirqd before it
 has been spawned
Message-ID: <20210415050225.GC4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <161814860838.29796.15260901429057690999.tip-bot2@tip-bot2>
 <87czuz1tbc.ffs@nanos.tec.linutronix.de>
 <20210412183645.GF4510@paulmck-ThinkPad-P17-Gen-1>
 <20210414071322.nz64kow4sp4nwzmy@linutronix.de>
 <20210414085757.GA1917@pc638.lan>
 <20210414181158.GU4510@paulmck-ThinkPad-P17-Gen-1>
 <87tuo8v2vp.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuo8v2vp.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Apr 15, 2021 at 01:54:18AM +0200, Thomas Gleixner wrote:
> Paul,
> 
> On Wed, Apr 14 2021 at 11:11, Paul E. McKenney wrote:
> > On Wed, Apr 14, 2021 at 10:57:57AM +0200, Uladzislau Rezki wrote:
> >> On Wed, Apr 14, 2021 at 09:13:22AM +0200, Sebastian Andrzej Siewior wrote:
> >> At the same time Paul made another patch:
> >> 
> >> softirq: Don't try waking ksoftirqd before it has been spawned
> >> 
> >> it allows us to keep RCU-tasks initialization before even
> >> early_initcall() where it is now and let our rcu-self-test
> >> to be completed without any hanging.
> >
> > In short, this window of time in which it is not possible to reliably
> > wait on a softirq handler has caused trouble, just as several other
> > similar boot-sequence time windows have caused trouble in the past.
> > It therefore makes sense to just eliminate this problem, and prevent
> > future developers from facing inexplicable silent boot-time hangs.
> >
> > We can move the spawning of ksoftirqd kthreads earlier, but that
> > simply narrows the window.  It does not eliminate the problem.
> >
> > I can easily believe that this might have -rt consequences that need
> > attention.  For your amusement, I will make a few guesses as to what
> > these might be:
> >
> > o	Back-of-interrupt softirq handlers degrade real-time response.
> > 	This should not be a problem this early in boot, and once the
> > 	ksoftirqd kthreads are spawned, there will never be another
> > 	back-of-interrupt softirq handler in kernels that have
> > 	force_irqthreads set, which includes -rt kernels.
> 
> Not a problem obviously.
> 
> > o	That !__this_cpu_read(ksoftirqd) check remains at runtime, even
> > 	though it always evaluates to false.  I would be surprised if
> > 	this overhead is measurable at the system level, but if it is,
> > 	static branches should take care of this.
> 
> Agreed.
> 
> > o	There might be a -rt lockdep check that isn't happy with
> > 	back-of-interrupt softirq handlers.  But such a lockdep check
> > 	could be conditioned on __this_cpu_read(ksoftirqd), thus
> > 	preventing it from firing during that short window at boot time.
> 
> It's not like there are only a handful of lockdep invocations which need
> to be taken care of. The lockdep checks are mostly inside of lock
> operations and if lockdep has recorded back-of-interrupt context once
> during boot it will complain about irqs enabled context usage later on
> no matter what.
> 
> If you can come up with a reasonable implementation of that without
> losing valuable lockdep coverage and without creating a major mess in
> the code then I'm all ears.

My naive thought was something vaguely like this in invoke_softirq():

static inline void invoke_softirq(void)
{
	if (ksoftirqd_running(local_softirq_pending()))
		return;

	if (!force_irqthreads || !__this_cpu_read(ksoftirqd)) {
		if (force_irqthreads && !__this_cpu_read(ksoftirqd))
			lockdep_off();
#ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
		/*
		 * We can safely execute softirq on the current stack if
		 * it is the irq stack, because it should be near empty
		 * at this stage.
		 */
		__do_softirq();
#else
		/*
		 * Otherwise, irq_exit() is called on the task stack that can
		 * be potentially deep already. So call softirq in its own stack
		 * to prevent from any overrun.
		 */
		do_softirq_own_stack();
#endif
		if (force_irqthreads && !__this_cpu_read(ksoftirqd))
			lockdep_on();
	} else {
		wakeup_softirqd();
	}
}

If I am reading the code correctly (ha!), this prevents locks from being
recorded during that short piece of the boot process, but vanilla kernels
would collect lockdep information during that time as well.

Similar changes would be needed elsewhere, which could easily get into
"mess" territory, and maybe even "major mess" territory.

> But lockdep is just one of the problems
> 
> > o	The -rt kernels might be using locks to implement things like
> > 	local_bh_disable(), in which case back-of-interrupt softirq
> > 	handlers could result in self-deadlock.  This could be addressed
> > 	by disabling bh the old way up to the time that the ksoftirqd
> > 	kthreads are created.  Because these are created while the system
> > 	is running on a single CPU (right?), a simple flag (or static
> > 	branch) could be used to switch this behavior into lock-only
> > 	mode long before the first real-time application can be spawned.
> 
> That has absolutely nothing to do with the first real-time application
> at all and just looking at the local_bh_disable() part does not cut it
> either.
> 
> The point is that the fundamental assumption of RT to break the non-rt
> semantics of interrupts and soft interrupts in order to rely on always
> thread context based serialization is going down the drain with that.
> 
> Surely we can come up with yet another pile of horrible hacks to work
> around that, which in turn will cause more problems than they solve.
> 
> But what for? Just to make it possible to issue rcu_whatever() during
> early boot just because?
> 
> Give me _one_ serious technical reason why this is absolutely required
> and why the accidental misplacement which might happen due to
> unawareness, sloppyness or incompetence is reason enough to create a
> horrible clusterfail just for purely academic reasons.

I have just been burned by mid-boot madness more than once.

But yes, this is not an emergency, not that I know of, not yet, anyway.
Thus, reverting this makes sense.  The merge window is not very far away,
and attempting to get anything resembling this right in that timeframe
would be quite brave.

> None of the usecases at hand did have any reason to depend on the early
> boot behaviour of softirqs and unless you can come up with something
> really compelling the proper solution is to revert this commit and add
> the following instead:
> 
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -74,7 +74,10 @@ static void wakeup_softirqd(void)
>  	/* Interrupts are disabled: no need to stop preemption */
>  	struct task_struct *tsk = __this_cpu_read(ksoftirqd);
>  
> -	if (tsk && tsk->state != TASK_RUNNING)
> +	if (WARN_ON_ONCE(!tsk))
> +		return;
> +
> +	if (tsk->state != TASK_RUNNING)
>  		wake_up_process(tsk);
>  }
>  
> which will trigger on any halfways usefull CI infrastructure which cares
> about the !default use cases of the kernel.

This gives false positives because it is OK to pile up requests for
softirq handlers.  When ksoftirqd starts, it will then invoke any
handlers that were requested.  The thing that is not OK is to block the
boot process waiting on those handlers to finish.

> Putting a restriction like that onto the early boot process is not the
> end of the world and might teach people who think that their oh so
> important stuff is not that important at all especially not during the
> early boot phase which is fragile enough already.

"But it is so simple without -rt!"  ;-)

I suppose that we could put a check in the scheduling-clock interrupt
under appropriate debug.  If ksoftirqd has not started one minute into
boot, complain.  Maybe "complain" includes a call to show_state(),
just to help convince people to use faster console hardware.

> There is absolutely no need to proliferate cargo cult programming.

You lost me on this one.

> Keep It Simple ...

NR_CPUS=0!  It is the only way!!!

> > So my turn.  Did I miss anything?
> 
> Maybe :)

Another approach is to move the spawning of ksoftirqd earlier.  This
still leaves a window of vulnerability, but the window is smaller, and
thus the probablity of something needing to happen there is smaller.
Uladzislau sent out a patch that did this some weeks back.

							Thanx, Paul
