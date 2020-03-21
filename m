Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A82418E39A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 21 Mar 2020 19:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgCUSMv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 21 Mar 2020 14:12:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39242 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbgCUSMv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 21 Mar 2020 14:12:51 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jFic5-0007YN-IM; Sat, 21 Mar 2020 19:12:49 +0100
Date:   Sat, 21 Mar 2020 19:12:49 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Subject: Re: [tip: locking/core] lockdep: Annotate irq_work
Message-ID: <20200321181249.vy7xxkgrd65piapw@linutronix.de>
References: <20200321113242.643576700@linutronix.de>
 <158480602510.28353.4851999853077941579.tip-bot2@tip-bot2>
 <20200321164057.GA9634@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200321164057.GA9634@lenoir>
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 2020-03-21 17:40:58 [+0100], Frederic Weisbecker wrote:
> > diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> > index 9c17f9c..f23f540 100644
> > --- a/include/linux/irqflags.h
> > +++ b/include/linux/irqflags.h
> > @@ -69,6 +69,17 @@ do {						\
> >  			current->irq_config = 0;	\
> >  	  } while (0)
> >  
> > +# define lockdep_irq_work_enter(__work)					\
> > +	  do {								\
> > +		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
> > +			current->irq_config = 1;			\
> 
> So, irq_config == 1 means we are in a softirq? Are there other values for
> irq_config? In which case there should be enums or something?
> I can't find the patch that describes this.

0 means as-is, 1 means threaded / sleeping locks are okay.

> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -245,6 +245,7 @@ static void nohz_full_kick_func(struct irq_work *work)
> >  
> >  static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
> >  	.func = nohz_full_kick_func,
> > +	.flags = ATOMIC_INIT(IRQ_WORK_HARD_IRQ),
> >  };
> 
> I get why these need to be in hardirq but some basic explanations for
> ordinary mortals as to why those two specifically and not all the others
> (and there are many) would have been nice.

Is the documentation patch in this series any good?

> Thanks.

Sebastian
