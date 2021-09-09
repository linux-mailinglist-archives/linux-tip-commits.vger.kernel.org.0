Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C88405D18
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 20:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbhIITAt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 15:00:49 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40303 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S236112AbhIITAs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 15:00:48 -0400
Received: (qmail 13113 invoked by uid 1000); 9 Sep 2021 14:59:37 -0400
Date:   Thu, 9 Sep 2021 14:59:37 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-tip-commits@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20210909185937.GA12379@rowland.harvard.edu>
References: <20180926182920.27644-2-paulmck@linux.ibm.com>
 <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
 <20210909133535.GA9722@willie-the-truck>
 <CAHk-=whULF=p-igDd-pvB+oqX-josNmbeBx2sTBA13t9UqcpQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whULF=p-igDd-pvB+oqX-josNmbeBx2sTBA13t9UqcpQA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Sep 09, 2021 at 10:02:13AM -0700, Linus Torvalds wrote:
> On Thu, Sep 9, 2021 at 6:35 AM Will Deacon <will@kernel.org> wrote:
> >
> > I don't think we should require the accesses to the actual lockwords to
> > be ordered here, as it becomes pretty onerous for relaxed LL/SC
> > architectures where you'd end up with an extra barrier either after the
> > unlock() or before the lock() operation. However, I remain absolutely in
> > favour of strengthening the ordering of the _critical sections_ guarded by
> > the locks to be RCsc.
> 
> Ack. The actual locking operations themselves can obviously overlap,
> it's what they protect that should be ordered if at all possible.
> 
> Because anything else will be too confusing for words, and if we have
> to add memory barriers *and* locking we're just screwed.
> 
> Because I think it is entirely understandable for people to expect
> that sequence of two locked regions to be ordered wrt each other.
> 
> While memory ordering is subtle and confusing, we should strive to
> make our "..but I used locks" to be as straightforward and as
> understandable to people who really really don't want to even think
> about memory order as at all reasonable.
> 
> I think we should have a very strong reason for accepting unordered
> locked regions (with "strong reason" being defined as "on this
> architecture that is hugely important, anything else would slow down
> locks enormously").
> 
> It sounds like no such architecture exists, much less is important.

All right.

Currently the memory model has RCtso ordering of accesses in separate 
critical sections for the same lock, as observed by other CPUs not 
holding the lock.  Peter is proposing (and Linus agrees) to expand this 
to cover critical sections for different locks, so long as both critical 
sections are on the same CPU.  But he didn't propose strengthening the 
ordering to RCsc, and I presume we don't want to do this because of the 
slowdown it would incur on Power.

Does everyone agree that this correctly summarizes the change to be made 
to the memory model?

Alan
