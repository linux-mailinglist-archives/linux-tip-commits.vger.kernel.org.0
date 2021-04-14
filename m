Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7C135FEA6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Apr 2021 01:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhDNXym (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 14 Apr 2021 19:54:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55830 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhDNXym (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 14 Apr 2021 19:54:42 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618444458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qsvcj0n9frkh6dJnqzTyQUWd/b4Iv/TVMWQmBRti16w=;
        b=hqmyZ9Oy3zes5zgAYiyuHeGq0Q/yzfkB+PK37i6hVkvcNc++JAeCi8m7XtEvPONLSe90My
        DzLXQxcqKmOjqOTw5gKfzppUKObY4rlyUSSRk++uI5PINbUhKFFPGhyqKB1fdQqe0pmUWJ
        z50DyljBcEgJjmkRYoBLX1Zltav1jBwa9KQ70Dgh5Aj+8yGh1kqPznEL3++MZoUN9MBvdb
        2yf+lvZnIDcLeKBXvdukaZVrFweqnkZDsBi9b5+208aZQ5sE5TzmVcC5GOfDGeh81zOSjj
        hacskuIOgpLQMsAKYgeVZX6Lv+H9M1T/r/yqKwxVb/jDf/0kOqQbzyiw0xC+Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618444458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qsvcj0n9frkh6dJnqzTyQUWd/b4Iv/TVMWQmBRti16w=;
        b=0C3EtLASdZbkGgu6MQOc1VqsFz078AhwzJDYw1gCl6lheLH3mlT3dgdKamxhgQAFOpuPka
        Hi4Zv9YSzxCV5VDA==
To:     paulmck@kernel.org, Uladzislau Rezki <urezki@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: core/rcu] softirq: Don't try waking ksoftirqd before it has been spawned
In-Reply-To: <20210414181158.GU4510@paulmck-ThinkPad-P17-Gen-1>
References: <161814860838.29796.15260901429057690999.tip-bot2@tip-bot2> <87czuz1tbc.ffs@nanos.tec.linutronix.de> <20210412183645.GF4510@paulmck-ThinkPad-P17-Gen-1> <20210414071322.nz64kow4sp4nwzmy@linutronix.de> <20210414085757.GA1917@pc638.lan> <20210414181158.GU4510@paulmck-ThinkPad-P17-Gen-1>
Date:   Thu, 15 Apr 2021 01:54:18 +0200
Message-ID: <87tuo8v2vp.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Paul,

On Wed, Apr 14 2021 at 11:11, Paul E. McKenney wrote:
> On Wed, Apr 14, 2021 at 10:57:57AM +0200, Uladzislau Rezki wrote:
>> On Wed, Apr 14, 2021 at 09:13:22AM +0200, Sebastian Andrzej Siewior wrote:
>> At the same time Paul made another patch:
>> 
>> softirq: Don't try waking ksoftirqd before it has been spawned
>> 
>> it allows us to keep RCU-tasks initialization before even
>> early_initcall() where it is now and let our rcu-self-test
>> to be completed without any hanging.
>
> In short, this window of time in which it is not possible to reliably
> wait on a softirq handler has caused trouble, just as several other
> similar boot-sequence time windows have caused trouble in the past.
> It therefore makes sense to just eliminate this problem, and prevent
> future developers from facing inexplicable silent boot-time hangs.
>
> We can move the spawning of ksoftirqd kthreads earlier, but that
> simply narrows the window.  It does not eliminate the problem.
>
> I can easily believe that this might have -rt consequences that need
> attention.  For your amusement, I will make a few guesses as to what
> these might be:
>
> o	Back-of-interrupt softirq handlers degrade real-time response.
> 	This should not be a problem this early in boot, and once the
> 	ksoftirqd kthreads are spawned, there will never be another
> 	back-of-interrupt softirq handler in kernels that have
> 	force_irqthreads set, which includes -rt kernels.

Not a problem obviously.

> o	That !__this_cpu_read(ksoftirqd) check remains at runtime, even
> 	though it always evaluates to false.  I would be surprised if
> 	this overhead is measurable at the system level, but if it is,
> 	static branches should take care of this.

Agreed.

> o	There might be a -rt lockdep check that isn't happy with
> 	back-of-interrupt softirq handlers.  But such a lockdep check
> 	could be conditioned on __this_cpu_read(ksoftirqd), thus
> 	preventing it from firing during that short window at boot time.

It's not like there are only a handful of lockdep invocations which need
to be taken care of. The lockdep checks are mostly inside of lock
operations and if lockdep has recorded back-of-interrupt context once
during boot it will complain about irqs enabled context usage later on
no matter what.

If you can come up with a reasonable implementation of that without
losing valuable lockdep coverage and without creating a major mess in
the code then I'm all ears.

But lockdep is just one of the problems

> o	The -rt kernels might be using locks to implement things like
> 	local_bh_disable(), in which case back-of-interrupt softirq
> 	handlers could result in self-deadlock.  This could be addressed
> 	by disabling bh the old way up to the time that the ksoftirqd
> 	kthreads are created.  Because these are created while the system
> 	is running on a single CPU (right?), a simple flag (or static
> 	branch) could be used to switch this behavior into lock-only
> 	mode long before the first real-time application can be spawned.

That has absolutely nothing to do with the first real-time application
at all and just looking at the local_bh_disable() part does not cut it
either.

The point is that the fundamental assumption of RT to break the non-rt
semantics of interrupts and soft interrupts in order to rely on always
thread context based serialization is going down the drain with that.

Surely we can come up with yet another pile of horrible hacks to work
around that, which in turn will cause more problems than they solve.

But what for? Just to make it possible to issue rcu_whatever() during
early boot just because?

Give me _one_ serious technical reason why this is absolutely required
and why the accidental misplacement which might happen due to
unawareness, sloppyness or incompetence is reason enough to create a
horrible clusterfail just for purely academic reasons.

None of the usecases at hand did have any reason to depend on the early
boot behaviour of softirqs and unless you can come up with something
really compelling the proper solution is to revert this commit and add
the following instead:

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -74,7 +74,10 @@ static void wakeup_softirqd(void)
 	/* Interrupts are disabled: no need to stop preemption */
 	struct task_struct *tsk = __this_cpu_read(ksoftirqd);
 
-	if (tsk && tsk->state != TASK_RUNNING)
+	if (WARN_ON_ONCE(!tsk))
+		return;
+
+	if (tsk->state != TASK_RUNNING)
 		wake_up_process(tsk);
 }
 
which will trigger on any halfways usefull CI infrastructure which cares
about the !default use cases of the kernel.

Putting a restriction like that onto the early boot process is not the
end of the world and might teach people who think that their oh so
important stuff is not that important at all especially not during the
early boot phase which is fragile enough already.

There is absolutely no need to proliferate cargo cult programming.

Keep It Simple ...

> So my turn.  Did I miss anything?

Maybe :)

Thanks,

        tglx
