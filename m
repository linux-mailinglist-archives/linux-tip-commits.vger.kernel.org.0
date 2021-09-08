Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3298403BB0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  8 Sep 2021 16:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349490AbhIHOn1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 8 Sep 2021 10:43:27 -0400
Received: from netrider.rowland.org ([192.131.102.5]:44001 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1349453AbhIHOn1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 8 Sep 2021 10:43:27 -0400
Received: (qmail 605270 invoked by uid 1000); 8 Sep 2021 10:42:17 -0400
Date:   Wed, 8 Sep 2021 10:42:17 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     alexander.shishkin@linux.intel.com, hpa@zytor.com,
        parri.andrea@gmail.com, mingo@kernel.org, paulmck@kernel.org,
        vincent.weaver@maine.edu, tglx@linutronix.de, jolsa@redhat.com,
        acme@redhat.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, eranian@google.com, will@kernel.org,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20210908144217.GA603644@rowland.harvard.edu>
References: <20180926182920.27644-2-paulmck@linux.ibm.com>
 <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Sep 08, 2021 at 01:44:11PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 08, 2021 at 01:00:26PM +0200, Peter Zijlstra wrote:
> > On Tue, Oct 02, 2018 at 03:11:10AM -0700, tip-bot for Alan Stern wrote:
> > > Commit-ID:  6e89e831a90172bc3d34ecbba52af5b9c4a447d1
> > > Gitweb:     https://git.kernel.org/tip/6e89e831a90172bc3d34ecbba52af5b9c4a447d1
> > > Author:     Alan Stern <stern@rowland.harvard.edu>
> > > AuthorDate: Wed, 26 Sep 2018 11:29:17 -0700
> > > Committer:  Ingo Molnar <mingo@kernel.org>
> > > CommitDate: Tue, 2 Oct 2018 10:28:01 +0200
> > > 
> > > tools/memory-model: Add extra ordering for locks and remove it for ordinary release/acquire
> > > 
> > > More than one kernel developer has expressed the opinion that the LKMM
> > > should enforce ordering of writes by locking.  In other words, given
> > > the following code:
> > > 
> > > 	WRITE_ONCE(x, 1);
> > > 	spin_unlock(&s):
> > > 	spin_lock(&s);
> > > 	WRITE_ONCE(y, 1);
> > > 
> > > the stores to x and y should be propagated in order to all other CPUs,
> > > even though those other CPUs might not access the lock s.  In terms of
> > > the memory model, this means expanding the cumul-fence relation.
> > 
> > Let me revive this old thread... recently we ran into the case:
> > 
> > 	WRITE_ONCE(x, 1);
> > 	spin_unlock(&s):
> > 	spin_lock(&r);
> > 	WRITE_ONCE(y, 1);
> > 
> > which is distinct from the original in that UNLOCK and LOCK are not on
> > the same variable.
> > 
> > I'm arguing this should still be RCtso by reason of:
> > 
> >   spin_lock() requires an atomic-acquire which:
> > 
> >     TSO-arch)		implies smp_mb()
> >     ARM64)		is RCsc for any stlr/ldar
> >     Power)		LWSYNC
> >     Risc-V)		fence r , rw
> >     *)			explicitly has smp_mb()
> > 
> > 
> > However, Boqun points out that the memory model disagrees, per:
> > 
> >   https://lkml.kernel.org/r/YTI2UjKy+C7LeIf+@boqun-archlinux
> > 
> > Is this an error/oversight of the memory model, or did I miss a subtlety
> > somewhere?

There's the question of what we think the LKMM should do in principle, and 
the question of how far it should go in mirroring the limitations of the 
various kernel hardware implementations.  These are obviously separate 
questions, but they both should influence the design of the memory model.  
But to what extent?

Given:

	spin_lock(&r);
	WRITE_ONCE(x, 1);
	spin_unlock(&r);
	spin_lock(&s);
	WRITE_ONCE(y, 1);
	spin_unlock(&s);

there is no reason _in theory_ why a CPU shouldn't reorder and interleave 
the operations to get:

	spin_lock(&r);
	spin_lock(&s);
	WRITE_ONCE(x, 1);
	WRITE_ONCE(y, 1);
	spin_unlock(&r);
	spin_unlock(&s);

(Of course, this wouldn't happen if some other CPU was holding the s lock 
while waiting for r to be released.  In that case the spin loop for s above 
wouldn't be able to end until after the unlock operation on r was complete, 
so this reordering couldn't occur.  But if there was no such contention then 
the reordering is possible in theory -- ignoring restrictions imposed by the 
actual implementations of the operations.)

Given such a reordering, nothing will prevent other CPUs from observing the 
write to y before the write to x.

> Hmm.. that argument isn't strong enough for Risc-V if I read that FENCE
> thing right. That's just R->RW ordering, which doesn't constrain the
> first WRITE_ONCE().
> 
> However, that spin_unlock has "fence rw, w" with a subsequent write. So
> the whole thing then becomes something like:
> 
> 
> 	WRITE_ONCE(x, 1);
> 	FENCE RW, W
> 	WRITE_ONCE(s.lock, 0);
> 	AMOSWAP %0, 1, r.lock
> 	FENCE R, WR
> 	WRITE_ONCE(y, 1);
> 
> 
> Which I think is still sufficient, irrespective of the whole s!=r thing.

To me, this argument feels like an artificial, unintended consequence of the 
individual implementations, not something that should be considered a 
systematic architectural requirement.  Perhaps one could say the same thing 
about the case where the two spinlock_t variables are the same, but at least 
in that case there is a good argument for inherent ordering of atomic 
accesses to a single variable.

Alan
