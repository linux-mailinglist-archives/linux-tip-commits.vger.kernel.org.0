Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8020740FA44
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 16:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhIQOhw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 10:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhIQOhw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 10:37:52 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E79BC061574;
        Fri, 17 Sep 2021 07:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1631889387;
        bh=Um62tW04nD5lADJsNR/G1g4/H1dSt3UUggeF9CPCnIc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ONjH0bSxFa+Xu9EgXOZsy1OkN5fLq+gbP42A235UR5gJDet5ZRbp541b8Tg3EE0WG
         i71yft1F5llyr4GGKh0MTVV6rDaUt8TgziyaltF6DTJMjSBnbnPl91XoWjx5GRnrvb
         Ghz28rwQ31rLqkpzGV529yHZSFIjs4cYGyU2pHSasNLG6uXJFnCoHBRkG4DOmsCPl4
         VrIc6fG+4IXwTQgJz1nUFKA343x1aYMKrHQQSUYNQuU9vzYkfTKlftGt4fv1JYARaz
         WB3RlI7uiy0vyDJiBDD2h8ZPmFx2/+AybRB3/Sj+Gh5E6buLLTIU5yWqgKWGPLVLIS
         9lcZdJzh2n3iw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4H9xN74tx5z9sSn;
        Sat, 18 Sep 2021 00:36:23 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
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
        paul.walmsley@sifive.com, dlustig@nvidia.com, npiggin@gmail.com
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
In-Reply-To: <20210910110819.GA1027@willie-the-truck>
References: <20180926182920.27644-2-paulmck@linux.ibm.com>
 <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
 <20210909133535.GA9722@willie-the-truck>
 <20210909174635.GA2229215@paulmck-ThinkPad-P17-Gen-1>
 <20210910110819.GA1027@willie-the-truck>
Date:   Sat, 18 Sep 2021 00:36:20 +1000
Message-ID: <87wnnfi80r.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Will Deacon <will@kernel.org> writes:
> On Thu, Sep 09, 2021 at 10:46:35AM -0700, Paul E. McKenney wrote:
>> On Thu, Sep 09, 2021 at 02:35:36PM +0100, Will Deacon wrote:
>> > On Thu, Sep 09, 2021 at 09:25:30AM +0200, Peter Zijlstra wrote:
>> > > On Wed, Sep 08, 2021 at 09:08:33AM -0700, Linus Torvalds wrote:
>> > > > then I think it's entirely reasonable to
>> > > > 
>> > > >         spin_unlock(&r);
>> > > >         spin_lock(&s);
>> > > > 
>> > > > cannot be reordered.
>> > > 
>> > > I'm obviously completely in favour of that :-)
>> > 
>> > I don't think we should require the accesses to the actual lockwords to
>> > be ordered here, as it becomes pretty onerous for relaxed LL/SC
>> > architectures where you'd end up with an extra barrier either after the
>> > unlock() or before the lock() operation. However, I remain absolutely in
>> > favour of strengthening the ordering of the _critical sections_ guarded by
>> > the locks to be RCsc.
>> 
>> If by this you mean the critical sections when observed only by other
>> critical sections for a given lock, then everyone is already there.
>
> No, I mean the case where somebody without the lock (but using memory
> barriers) can observe the critical sections out of order (i.e. W -> R
> order is not maintained).
>
>> However...
>> 
>> > Last time this came up, I think the RISC-V folks were generally happy to
>> > implement whatever was necessary for Linux [1]. The thing that was stopping
>> > us was Power (see CONFIG_ARCH_WEAK_RELEASE_ACQUIRE), wasn't it? I think
>> > Michael saw quite a bit of variety in the impact on benchmarks [2] across
>> > different machines. So the question is whether newer Power machines are less
>> > affected to the degree that we could consider making this change again.
>> 
>> Last I knew, on Power a pair of critical sections for a given lock could
>> be observed out of order (writes from the earlier critical section vs.
>> reads from the later critical section), but only by CPUs not holding
>> that lock.  Also last I knew, tightening this would require upgrading
>> some of the locking primitives' lwsync instructions to sync instructions.
>> But I know very little about Power 10.
>
> Yup, that's the one. This is the primary reason why we have the confusing
> "RCtso" model today so this is my periodic "Do we still need this?" poking
> for the Power folks :)
>
> If the SYNC is a disaster for Power, then I'll ask again in another ~3 years
> time in the hope that newer micro-architectures can swallow the instruction
> more easily, but the results last time weren't hugely compelling and so _if_
> there's an opportunity to make locking more "obvious" then I'm all for it.

I haven't had time to do the full set of numbers like I did last time,
but a quick test shows it's still about a 20-25% drop switching to sync.

So on that basis we'd definitely rather not :)

I'll try and get some more numbers next week.

cheers
