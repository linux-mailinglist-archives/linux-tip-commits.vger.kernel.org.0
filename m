Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE364057AA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 15:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352758AbhIINlB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 09:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357477AbhIINgw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 09:36:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4407C60F4A;
        Thu,  9 Sep 2021 13:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631194542;
        bh=iGb3aFTZvFrFF1Dl9Z7zCVV2Bug7d35snwFG0aHedNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aP8tZaoZM3Wip4ZzCWZQVmJOOKX7L75vvouB4d7ONzfcI91TX7xdbisH6/BA6ezhz
         hxo6F1Gt9KbDsxkXRnSAudKZkWkZpMJ7Oq9VjWzEvwUC2rBxa3ABKEcC/rwRGSTyzS
         36lbVYKa2XmribZNnCxwoLx/AiW9e8rN6nsrib0veAK2FMwKMiwAif6N+CiaHcyznG
         BZsnv3Tjtxz/FnI+l7qrmVUB+DX22P7lnBtN3tLZDzmhp3KIaOHp85VKEIVt4XuyXK
         kIecqRveGrFBDSSYiVXDHgmTQ1x/QP5vjTd3FXSVnhTSuP6lcmwPiaL/mDwe3Od4lJ
         t/UCz/3HiZOzA==
Date:   Thu, 9 Sep 2021 14:35:36 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
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
        linux-tip-commits@vger.kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, dlustig@nvidia.com, mpe@ellerman.id.au
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20210909133535.GA9722@willie-the-truck>
References: <20180926182920.27644-2-paulmck@linux.ibm.com>
 <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

[+Palmer, PaulW, Daniel and Michael]

On Thu, Sep 09, 2021 at 09:25:30AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 08, 2021 at 09:08:33AM -0700, Linus Torvalds wrote:
> 
> > So if this is purely a RISC-V thing,
> 
> Just to clarify, I think the current RISC-V thing is stonger than
> PowerPC, but maybe not as strong as say ARM64, but RISC-V memory
> ordering is still somewhat hazy to me.
> 
> Specifically, the sequence:
> 
> 	/* critical section s */
> 	WRITE_ONCE(x, 1);
> 	FENCE RW, W
> 	WRITE_ONCE(s.lock, 0);		/* store S */
> 	AMOSWAP %0, 1, r.lock		/* store R */
> 	FENCE R, RW
> 	WRITE_ONCE(y, 1);
> 	/* critical section r */
> 
> fully separates section s from section r, as in RW->RW ordering
> (possibly not as strong as smp_mb() though), while on PowerPC it would
> only impose TSO ordering between sections.
> 
> The AMOSWAP is a RmW and as such matches the W from the RW->W fence,
> similarly it marches the R from the R->RW fence, yielding an:
> 
> 	RW->  W
> 	    RmW
> 	    R  ->RW
> 
> ordering. It's the stores S and R that can be re-ordered, but not the
> sections themselves (same on PowerPC and many others).
> 
> Clarification from a RISC-V enabled person would be appreciated.
> 
> > then I think it's entirely reasonable to
> > 
> >         spin_unlock(&r);
> >         spin_lock(&s);
> > 
> > cannot be reordered.
> 
> I'm obviously completely in favour of that :-)

I don't think we should require the accesses to the actual lockwords to
be ordered here, as it becomes pretty onerous for relaxed LL/SC
architectures where you'd end up with an extra barrier either after the
unlock() or before the lock() operation. However, I remain absolutely in
favour of strengthening the ordering of the _critical sections_ guarded by
the locks to be RCsc.

Last time this came up, I think the RISC-V folks were generally happy to
implement whatever was necessary for Linux [1]. The thing that was stopping
us was Power (see CONFIG_ARCH_WEAK_RELEASE_ACQUIRE), wasn't it? I think
Michael saw quite a bit of variety in the impact on benchmarks [2] across
different machines. So the question is whether newer Power machines are less
affected to the degree that we could consider making this change again.

Will

[1] https://lore.kernel.org/lkml/11b27d32-4a8a-3f84-0f25-723095ef1076@nvidia.com/
[2] https://lore.kernel.org/lkml/87tvp3xonl.fsf@concordia.ellerman.id.au/
