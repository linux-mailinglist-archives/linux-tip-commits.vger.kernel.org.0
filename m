Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B744070B5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Sep 2021 19:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhIJR55 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Sep 2021 13:57:57 -0400
Received: from netrider.rowland.org ([192.131.102.5]:34893 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229476AbhIJR54 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Sep 2021 13:57:56 -0400
Received: (qmail 45788 invoked by uid 1000); 10 Sep 2021 13:56:44 -0400
Date:   Fri, 10 Sep 2021 13:56:44 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-tip-commits@vger.kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mpe@ellerman.id.au
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20210910175644.GE39858@rowland.harvard.edu>
References: <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
 <20210909133535.GA9722@willie-the-truck>
 <5412ab37-2979-5717-4951-6a61366df0f2@nvidia.com>
 <20210909180005.GA2230712@paulmck-ThinkPad-P17-Gen-1>
 <YTtpnZuSId9yDUjB@boqun-archlinux>
 <20210910163632.GC39858@rowland.harvard.edu>
 <20210910171221.GN4323@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910171221.GN4323@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Sep 10, 2021 at 07:12:21PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 10, 2021 at 12:36:32PM -0400, Alan Stern wrote:
> > +Here the second spin_lock() is po-after the first spin_unlock(), and
> > +therefore the load of x must execute before the load of y, even tbough
> 
> I think that's commonly spelled: though, right?                    ^^^^^^

Oops, yes, I missed that.  Good eye!

> > --- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
> > +++ usb-devel/tools/memory-model/Documentation/explanation.txt
> > @@ -1813,15 +1813,16 @@ spin_trylock() -- we can call these thin
> >  lock-acquires -- have two properties beyond those of ordinary releases
> >  and acquires.
> >  
> > +First, when a lock-acquire reads from or is po-after a lock-release,
> > +the LKMM requires that every instruction po-before the lock-release
> > +must execute before any instruction po-after the lock-acquire.  This
> > +would naturally hold if the release and acquire operations were on
> > +different CPUs and accessed the same lock variable, but the LKMM says
> > +it also holds when they are on the same CPU, even if they access
> > +different lock variables.  For example:
> 
> Could be I don't understand this right, but the way I'm reading it, it
> seems to imply RCsc. Which I don't think we're actually asking at this
> time.

No, it doesn't imply RCsc.  This document makes a distinction between 
when a store executes and when it becomes visible to (or propagates to) 
other CPUs.  Thus, even though write 1 executes before write 2, write 2 
might become visible to a different CPU before write 1 does.  In fact, 
on non-other-multicopy-atomic systems, two writes might become visible 
to different CPUs in different orders (think of the IRIW litmus 
pattern.)

Or to consider a more relevant example, a write can execute before a 
read even though the write doesn't become visible to other CPUs until 
after the read is complete.

If you want, you can read this as saying "execute as seen from its own 
CPU" (although even that isn't entirely right, since a write can be 
visible to a po-later read which nevertheless executes before the write 
does).  Or think of a write as executing when its value gets put into 
the local store buffer, rather than when it gets put into the cache 
line.

Alan
