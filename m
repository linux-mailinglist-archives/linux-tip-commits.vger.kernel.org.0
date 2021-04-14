Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8920B35FA6B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Apr 2021 20:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351737AbhDNSMV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 14 Apr 2021 14:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349712AbhDNSMU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96A7660234;
        Wed, 14 Apr 2021 18:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618423918;
        bh=+c25Y4lDJcUngMFCC6ehdjOCkVWMv90Bo8T+0YkkilI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Uro1rPB7OX1rRbCXFncmETAarK+DNK+/496vYdPqUJvMFHpBuW+Wf0ovsdpy7mVaM
         PnkjhY0t2/dTwkQjvjrCIrQqI0mX0IRQRBOiw99CWQ5hK2D7vGbXdWRaCLPS1O+t2l
         LIvCGZRddxnylagqhwcLPV/J/kgxGY2WmmEeQPq6oReD5ngAXBhwhCkNBJeFutt7YQ
         SQkBjD1fBkgghIZ2Tl1uJC4EC+Om/35UGJQqRfzm4ZAJuJi8hdkoC8hmDK8hoicAME
         7LihOcC82f+eMCkAQxsFsOhAN3T672EJs8OAdsi3zTiS2b0iKfJThVp8BojT+RJImI
         ylrY8yw9pky5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4DF3C5C23EB; Wed, 14 Apr 2021 11:11:58 -0700 (PDT)
Date:   Wed, 14 Apr 2021 11:11:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: core/rcu] softirq: Don't try waking ksoftirqd before it
 has been spawned
Message-ID: <20210414181158.GU4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <161814860838.29796.15260901429057690999.tip-bot2@tip-bot2>
 <87czuz1tbc.ffs@nanos.tec.linutronix.de>
 <20210412183645.GF4510@paulmck-ThinkPad-P17-Gen-1>
 <20210414071322.nz64kow4sp4nwzmy@linutronix.de>
 <20210414085757.GA1917@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414085757.GA1917@pc638.lan>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Apr 14, 2021 at 10:57:57AM +0200, Uladzislau Rezki wrote:
> On Wed, Apr 14, 2021 at 09:13:22AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2021-04-12 11:36:45 [-0700], Paul E. McKenney wrote:
> > > > Color me confused. I did not follow the discussion around this
> > > > completely, but wasn't it agreed on that this rcu torture muck can wait
> > > > until the threads are brought up?
> > > 
> > > Yes, we can cause rcutorture to wait.  But in this case, rcutorture
> > > is just the messenger, and making it wait would simply be ignoring
> > > the message.  The message is that someone could invoke any number of
> > > things that wait on a softirq handler's invocation during the interval
> > > before ksoftirqd has been spawned.
> > 
> > My memory on this is that the only user, that required this early
> > behaviour, was kprobe which was recently changed to not need it anymore.
> > Which makes the test as the only user that remains. Therefore I thought
> > that this test will be moved to later position (when ksoftirqd is up and
> > running) and that there is no more requirement for RCU to be completely
> > up that early in the boot process.
> > 
> > Did I miss anything?
> > 
> Seems not. Let me wrap it up a bit though i may miss something:
> 
> 1) Initially we had an issue with booting RISV because of:
> 
> 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
> 
> i.e. a developer decided to move initialization of kprobe at
> early_initcall() phase. Since kprobe uses synchronize_rcu_tasks()
> a system did not boot due to the fact that RCU-tasks were setup
> at core_initcall() step. It happens later in this chain.
> 
> To address that issue, we had decided to move RCU-tasks setup
> to before early_initcall() and it worked well:
> 
> https://lore.kernel.org/lkml/20210218083636.GA2030@pc638.lan/T/
> 
> 2) After that fix you reported another issue. If the kernel is run
> with "threadirqs=1" - it did not boot also. Because ksoftirqd does
> not exist by that time, thus our early-rcu-self test did not pass.
> 
> 3) Due to (2), Masami Hiramatsu proposed to fix kprobes by delaying
> kprobe optimization and it also addressed initial issue:
> 
> https://lore.kernel.org/lkml/20210219112357.GA34462@pc638.lan/T/
> 
> At the same time Paul made another patch:
> 
> softirq: Don't try waking ksoftirqd before it has been spawned
> 
> it allows us to keep RCU-tasks initialization before even
> early_initcall() where it is now and let our rcu-self-test
> to be completed without any hanging.

In short, this window of time in which it is not possible to reliably
wait on a softirq handler has caused trouble, just as several other
similar boot-sequence time windows have caused trouble in the past.
It therefore makes sense to just eliminate this problem, and prevent
future developers from facing inexplicable silent boot-time hangs.

We can move the spawning of ksoftirqd kthreads earlier, but that
simply narrows the window.  It does not eliminate the problem.

I can easily believe that this might have -rt consequences that need
attention.  For your amusement, I will make a few guesses as to what
these might be:

o	Back-of-interrupt softirq handlers degrade real-time response.
	This should not be a problem this early in boot, and once the
	ksoftirqd kthreads are spawned, there will never be another
	back-of-interrupt softirq handler in kernels that have
	force_irqthreads set, which includes -rt kernels.

o	That !__this_cpu_read(ksoftirqd) check remains at runtime, even
	though it always evaluates to false.  I would be surprised if
	this overhead is measurable at the system level, but if it is,
	static branches should take care of this.

o	There might be a -rt lockdep check that isn't happy with
	back-of-interrupt softirq handlers.  But such a lockdep check
	could be conditioned on __this_cpu_read(ksoftirqd), thus
	preventing it from firing during that short window at boot time.

o	The -rt kernels might be using locks to implement things like
	local_bh_disable(), in which case back-of-interrupt softirq
	handlers could result in self-deadlock.  This could be addressed
	by disabling bh the old way up to the time that the ksoftirqd
	kthreads are created.  Because these are created while the system
	is running on a single CPU (right?), a simple flag (or static
	branch) could be used to switch this behavior into lock-only
	mode long before the first real-time application can be spawned.

So my turn.  Did I miss anything?

							Thanx, Paul
