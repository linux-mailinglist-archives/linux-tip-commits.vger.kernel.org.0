Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940FB405C76
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 20:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242655AbhIISBQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 14:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237205AbhIISBP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 14:01:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F19D6610C9;
        Thu,  9 Sep 2021 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631210406;
        bh=GHZCW8HUw7/KGu0uSODqmPQAEJcMv82slvw8vvRuROY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NS/cWWKTrVi3QTkJnuhBSR0/wCFTcxu0VpStcAAB7t3bGFvq8A3vMK1XyeSjm1zS7
         D5PJtib1nYiZ3hv1jf0u9zrHms9Jvv/QXYeYYVVmDCNBcoc2A6n3hsYG/tfqfIu3as
         BJzEV0FB8LocUY2jUujyQdjb0V2WInBj9SjdzqiJMhsZU31OyiIEFGgjmwTreW/VAK
         G0asbgTo55x95u0KjGZvnpZ2dvlxKDCJ+8ddAAc0Z4CuPTPZBnjkFyxPUmoDi+XzIf
         QDo1wu/kN23eikPBu+xolUuoksJs7TEu8pfoMULGwE7gsyg0HsNlq8iPUFlNK7UfH9
         ALZidXSKPR7fg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BDCCE5C0DC8; Thu,  9 Sep 2021 11:00:05 -0700 (PDT)
Date:   Thu, 9 Sep 2021 11:00:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dan Lustig <dlustig@nvidia.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        paul.walmsley@sifive.com, mpe@ellerman.id.au
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20210909180005.GA2230712@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20180926182920.27644-2-paulmck@linux.ibm.com>
 <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
 <20210909133535.GA9722@willie-the-truck>
 <5412ab37-2979-5717-4951-6a61366df0f2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5412ab37-2979-5717-4951-6a61366df0f2@nvidia.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Sep 09, 2021 at 01:03:18PM -0400, Dan Lustig wrote:
> On 9/9/2021 9:35 AM, Will Deacon wrote:
> > [+Palmer, PaulW, Daniel and Michael]
> > 
> > On Thu, Sep 09, 2021 at 09:25:30AM +0200, Peter Zijlstra wrote:
> >> On Wed, Sep 08, 2021 at 09:08:33AM -0700, Linus Torvalds wrote:
> >>
> >>> So if this is purely a RISC-V thing,
> >>
> >> Just to clarify, I think the current RISC-V thing is stonger than
> >> PowerPC, but maybe not as strong as say ARM64, but RISC-V memory
> >> ordering is still somewhat hazy to me.
> >>
> >> Specifically, the sequence:
> >>
> >> 	/* critical section s */
> >> 	WRITE_ONCE(x, 1);
> >> 	FENCE RW, W
> >> 	WRITE_ONCE(s.lock, 0);		/* store S */
> >> 	AMOSWAP %0, 1, r.lock		/* store R */
> >> 	FENCE R, RW
> >> 	WRITE_ONCE(y, 1);
> >> 	/* critical section r */
> >>
> >> fully separates section s from section r, as in RW->RW ordering
> >> (possibly not as strong as smp_mb() though), while on PowerPC it would
> >> only impose TSO ordering between sections.
> >>
> >> The AMOSWAP is a RmW and as such matches the W from the RW->W fence,
> >> similarly it marches the R from the R->RW fence, yielding an:
> >>
> >> 	RW->  W
> >> 	    RmW
> >> 	    R  ->RW
> >>
> >> ordering. It's the stores S and R that can be re-ordered, but not the
> >> sections themselves (same on PowerPC and many others).
> >>
> >> Clarification from a RISC-V enabled person would be appreciated.
> 
> To first order, RISC-V's memory model is very similar to ARMv8's.  It
> is "other-multi-copy-atomic", unlike Power, and respects dependencies.
> It also has AMOs and LR/SC with optional RCsc acquire or release
> semantics.  There's no need to worry about RISC-V somehow pushing the
> boundaries of weak memory ordering in new ways.
> 
> The tricky part is that unlike ARMv8, RISC-V doesn't have load-acquire
> or store-release opcodes at all.  Only AMOs and LR/SC have acquire or
> release options.  That means that while certain operations like swap
> can be implemented with native RCsc semantics, others like store-release
> have to fall back on fences and plain writes.
> 
> That's where the complexity came up last time this was discussed, at
> least as it relates to RISC-V: how to make sure the combination of RCsc
> atomics and plain operations+fences gives the semantics everyone is
> asking for here.  And to be clear there, I'm not asking for LKMM to
> weaken anything about critical section ordering just for RISC-V's sake.
> TSO/RCsc ordering between critical sections is a perfectly reasonable
> model in my opinion.  I just want to make sure RISC-V gets it right
> given whatever the decision is.
> 
> >>> then I think it's entirely reasonable to
> >>>
> >>>         spin_unlock(&r);
> >>>         spin_lock(&s);
> >>>
> >>> cannot be reordered.
> >>
> >> I'm obviously completely in favour of that :-)
> > 
> > I don't think we should require the accesses to the actual lockwords to
> > be ordered here, as it becomes pretty onerous for relaxed LL/SC
> > architectures where you'd end up with an extra barrier either after the
> > unlock() or before the lock() operation. However, I remain absolutely in
> > favour of strengthening the ordering of the _critical sections_ guarded by
> > the locks to be RCsc.
> 
> I agree with Will here.  If the AMOSWAP above is actually implemented with
> a RISC-V AMO, then the two critical sections will be separated as if RW,RW,
> as Peter described.  If instead it's implemented using LR/SC, then RISC-V
> gives only TSO (R->R, R->W, W->W), because the two pieces of the AMO are
> split, and that breaks the chain.  Getting full RW->RW between the critical
> sections would therefore require an extra fence.  Also, the accesses to the
> lockwords themselves would not be ordered without an extra fence.
> 
> > Last time this came up, I think the RISC-V folks were generally happy to
> > implement whatever was necessary for Linux [1]. The thing that was stopping
> > us was Power (see CONFIG_ARCH_WEAK_RELEASE_ACQUIRE), wasn't it? I think
> > Michael saw quite a bit of variety in the impact on benchmarks [2] across
> > different machines. So the question is whether newer Power machines are less
> > affected to the degree that we could consider making this change again.
> 
> Yes, as I said above, RISC-V will implement what is needed to make this work.

Boqun, I vaguely remember a suggested change from you along these lines,
but now I cannot find it.  Could you please send it as a formal patch
if you have not already done so or point me at it if you have?

							Thanx, Paul
