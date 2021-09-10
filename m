Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1A7406A7C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Sep 2021 13:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhIJLJp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Sep 2021 07:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232415AbhIJLJo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Sep 2021 07:09:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA3D260FE3;
        Fri, 10 Sep 2021 11:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631272113;
        bh=08O+Zk6UxWViDpgehhdwotP3atDes4dHB20ZtyWAn5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2WdN4vX9Ymk94t7DzJfgynHiufSaYXlVtNTe+Fo/iZ42rBEFfxegEdDm9AJ6k6Vf
         73nTxtx+wOkfqp23Ts9FyE2mneffWgbwKTIj4ZFYGLIEpPWTgt1BpC+GfquwX2+YmK
         4oJDrw5jrZ0lXs54reg9sZpusKyiiunrR/37XttDSjBdW6CE++pOW5WWeFBj6PA08K
         EzHaWkjSYtGgnd1eH4DWgRtKj/Om/b00mPoRCckpLilVNcHib6BHxNg9/EGuT9ZxrL
         5+JWCB39bZJQfdvuWNJ7ttz7WlhKGrjiPRwnnohtD/FY6q3dOsvzC1xMebNz3w51c+
         s0OI/VohDh1xA==
Date:   Fri, 10 Sep 2021 12:08:27 +0100
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
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
        paul.walmsley@sifive.com, dlustig@nvidia.com, mpe@ellerman.id.au,
        npiggin@gmail.com
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20210910110819.GA1027@willie-the-truck>
References: <20180926182920.27644-2-paulmck@linux.ibm.com>
 <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
 <20210909133535.GA9722@willie-the-truck>
 <20210909174635.GA2229215@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909174635.GA2229215@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hi Paul,

On Thu, Sep 09, 2021 at 10:46:35AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 09, 2021 at 02:35:36PM +0100, Will Deacon wrote:
> > On Thu, Sep 09, 2021 at 09:25:30AM +0200, Peter Zijlstra wrote:
> > > On Wed, Sep 08, 2021 at 09:08:33AM -0700, Linus Torvalds wrote:
> > > > then I think it's entirely reasonable to
> > > > 
> > > >         spin_unlock(&r);
> > > >         spin_lock(&s);
> > > > 
> > > > cannot be reordered.
> > > 
> > > I'm obviously completely in favour of that :-)
> > 
> > I don't think we should require the accesses to the actual lockwords to
> > be ordered here, as it becomes pretty onerous for relaxed LL/SC
> > architectures where you'd end up with an extra barrier either after the
> > unlock() or before the lock() operation. However, I remain absolutely in
> > favour of strengthening the ordering of the _critical sections_ guarded by
> > the locks to be RCsc.
> 
> If by this you mean the critical sections when observed only by other
> critical sections for a given lock, then everyone is already there.

No, I mean the case where somebody without the lock (but using memory
barriers) can observe the critical sections out of order (i.e. W -> R
order is not maintained).

> However...
> 
> > Last time this came up, I think the RISC-V folks were generally happy to
> > implement whatever was necessary for Linux [1]. The thing that was stopping
> > us was Power (see CONFIG_ARCH_WEAK_RELEASE_ACQUIRE), wasn't it? I think
> > Michael saw quite a bit of variety in the impact on benchmarks [2] across
> > different machines. So the question is whether newer Power machines are less
> > affected to the degree that we could consider making this change again.
> 
> Last I knew, on Power a pair of critical sections for a given lock could
> be observed out of order (writes from the earlier critical section vs.
> reads from the later critical section), but only by CPUs not holding
> that lock.  Also last I knew, tightening this would require upgrading
> some of the locking primitives' lwsync instructions to sync instructions.
> But I know very little about Power 10.

Yup, that's the one. This is the primary reason why we have the confusing
"RCtso" model today so this is my periodic "Do we still need this?" poking
for the Power folks :)

If the SYNC is a disaster for Power, then I'll ask again in another ~3 years
time in the hope that newer micro-architectures can swallow the instruction
more easily, but the results last time weren't hugely compelling and so _if_
there's an opportunity to make locking more "obvious" then I'm all for it.

Will
