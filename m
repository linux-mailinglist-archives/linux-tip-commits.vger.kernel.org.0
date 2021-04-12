Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6F035D078
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Apr 2021 20:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245084AbhDLShF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Apr 2021 14:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244437AbhDLShD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Apr 2021 14:37:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9671061206;
        Mon, 12 Apr 2021 18:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618252605;
        bh=Ih9PwPlZCF8qIlNWYj18bW/7UFo/CWzcHVQUgrYeK6w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=P0iRwp4WeQMwkwYb8Dlt+ETO2z3zC9nF3pBoARbykJgKXW0k/hcLA4BZTzp7rAzUt
         wEw2fmxpKI52RhJbuFToY4FR2ngctYGCUg5pfH3aFKdNeQgip57Jf6b4Lzigsil9B/
         UwBPnz0sd7Yobpew5e1qV0tIyhQl9ZI1rZpHQHAp8IQkgogV6WcTSnWYpnRzvAcUgL
         gfS8bYhh6FwNf+AMgHkNn6S2erQpkBzOlnBzlcqbrwwaeiaecYtnPlmvPmu1IAC4Pv
         J16Zr45Fq6MdSRnyhAgWlQRVW9RhEsDMB1jgeGnxopqWPkPh4NvzCB41YDznjemdZ4
         bBVqZKzkd51xA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6353A5C034B; Mon, 12 Apr 2021 11:36:45 -0700 (PDT)
Date:   Mon, 12 Apr 2021 11:36:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: core/rcu] softirq: Don't try waking ksoftirqd before it
 has been spawned
Message-ID: <20210412183645.GF4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <161814860838.29796.15260901429057690999.tip-bot2@tip-bot2>
 <87czuz1tbc.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czuz1tbc.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Apr 12, 2021 at 04:16:55PM +0200, Thomas Gleixner wrote:
> On Sun, Apr 11 2021 at 13:43, tip-bot wrote:
> > The following commit has been merged into the core/rcu branch of tip:
> >
> > Commit-ID:     1c0c4bc1ceb580851b2d76fdef9712b3bdae134b
> > Gitweb:        https://git.kernel.org/tip/1c0c4bc1ceb580851b2d76fdef9712b3bdae134b
> > Author:        Paul E. McKenney <paulmck@kernel.org>
> > AuthorDate:    Fri, 12 Feb 2021 16:20:40 -08:00
> > Committer:     Paul E. McKenney <paulmck@kernel.org>
> > CommitterDate: Mon, 15 Mar 2021 13:51:48 -07:00
> >
> > softirq: Don't try waking ksoftirqd before it has been spawned
> >
> > If there is heavy softirq activity, the softirq system will attempt
> > to awaken ksoftirqd and will stop the traditional back-of-interrupt
> > softirq processing.  This is all well and good, but only if the
> > ksoftirqd kthreads already exist, which is not the case during early
> > boot, in which case the system hangs.
> >
> > One reproducer is as follows:
> >
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE03" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y CONFIG_NO_HZ_IDLE=y CONFIG_HZ_PERIODIC=n" --bootargs "threadirqs=1" --trust-make
> >
> > This commit therefore adds a couple of existence checks for ksoftirqd
> > and forces back-of-interrupt softirq processing when ksoftirqd does not
> > yet exist.  With this change, the above test passes.
> 
> Color me confused. I did not follow the discussion around this
> completely, but wasn't it agreed on that this rcu torture muck can wait
> until the threads are brought up?

Yes, we can cause rcutorture to wait.  But in this case, rcutorture
is just the messenger, and making it wait would simply be ignoring
the message.  The message is that someone could invoke any number of
things that wait on a softirq handler's invocation during the interval
before ksoftirqd has been spawned.

We looked at spawning the ksoftirq kthreads earlier, but that just
narrows the window -- it doesn't eliminate the problem.

We considered adding a check for this condition in order to yell at
people who invoke things that rely heavily on softirq during this time,
but there are perfectly legitimate use cases where it is OK for the
softirq handlers to just sit there until ksoftirqd is spawned.  The
problem isn't doing a raise_softirq(), but instead waiting on the
corresponding handler to complete.

We didn't see any reasonable false-positive-free way to create a reliable
diagnostic for that case, possibly due to a lack of imagination on
our part.

Ideas?

> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index 9908ec4..bad14ca 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -211,7 +211,7 @@ static inline void invoke_softirq(void)
> >  	if (ksoftirqd_running(local_softirq_pending()))
> >  		return;
> >  
> > -	if (!force_irqthreads) {
> > +	if (!force_irqthreads || !__this_cpu_read(ksoftirqd)) {
> >  #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
> >  		/*
> >  		 * We can safely execute softirq on the current stack if
> 
> This still breaks RT which forces force_irqthreads to a compile time
> const which makes the compiler optimize out the direct invocation.
> 
> Surely RT can work around that, but how is that rcu torture muck
> supposed to work then? We're back to square one then.

Ah.  So RT relies on softirq handlers never ever being directly invoked,
even during boot time?  I was not aware of that.

OK, I will bite...  What are the RT workarounds for this case?  Maybe
they apply more generally.

							Thanx, Paul
