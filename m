Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A4540692B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Sep 2021 11:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhIJJhK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Sep 2021 05:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhIJJhK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Sep 2021 05:37:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5600DC061574;
        Fri, 10 Sep 2021 02:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1zHanfdh3/bn0UbYzdL99BhoAIVMMbNw6i4+osoTWXY=; b=bcT6h50rGNw0WqF6pE/cumxuoO
        uxG77d48Cx6yMxkoK4fC++tqH2dlXxb2A8IKHGmitqxZ8lCbnIQN4++vea4Lz7KHAPDYj7jQbcgUM
        GFnkmFY0wMGaJoMxNbmBTCS94OeCD9l6bwikcKfpFZbNuAbJJUnJRPfsye8V6Djo54lMwTjsdC4Mp
        bSTmlzU9055zaUpx/byO9DU92YJ4vRtNt5SbY1CRQ2DesbA5AX6XRqI49nG0/1GdKNBs5AhYQPdFh
        oxJ6wdOP3leOOCFn0M8Y6w3QCLQk6ql3faud8lIzxDYBGgtoo6i134d/jGU1BBKr+YBFL4dgPOBBU
        WbJQxprw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOcuV-00AsCl-Pq; Fri, 10 Sep 2021 09:33:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66C2530022C;
        Fri, 10 Sep 2021 11:33:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 485A723CBCBEE; Fri, 10 Sep 2021 11:33:25 +0200 (CEST)
Date:   Fri, 10 Sep 2021 11:33:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        paul.walmsley@sifive.com, mpe@ellerman.id.au
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <YTsmZWGXOKlfgbh9@hirez.programming.kicks-ass.net>
References: <20180926182920.27644-2-paulmck@linux.ibm.com>
 <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
 <20210909133535.GA9722@willie-the-truck>
 <5412ab37-2979-5717-4951-6a61366df0f2@nvidia.com>
 <YTqgSmX57l2hCMk0@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTqgSmX57l2hCMk0@boqun-archlinux>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Sep 10, 2021 at 08:01:14AM +0800, Boqun Feng wrote:
> On Thu, Sep 09, 2021 at 01:03:18PM -0400, Dan Lustig wrote:
> > On 9/9/2021 9:35 AM, Will Deacon wrote:
> > > On Thu, Sep 09, 2021 at 09:25:30AM +0200, Peter Zijlstra wrote:

> > >> The AMOSWAP is a RmW and as such matches the W from the RW->W fence,
> > >> similarly it marches the R from the R->RW fence, yielding an:
> > >>
> > >> 	RW->  W
> > >> 	    RmW
> > >> 	    R  ->RW
> > >>
> > >> ordering. It's the stores S and R that can be re-ordered, but not the
> > >> sections themselves (same on PowerPC and many others).

> > I agree with Will here.  If the AMOSWAP above is actually implemented with
> > a RISC-V AMO, then the two critical sections will be separated as if RW,RW,
> > as Peter described.  If instead it's implemented using LR/SC, then RISC-V
> 
> Just out of curiosity, in the following code, can the store S and load L
> be reordered?
> 
> 	WRITE_ONCE(x, 1); // store S
> 	FENCE RW, W
>  	WRITE_ONCE(s.lock, 0); // unlock(s)
>  	AMOSWAP %0, 1, s.lock  // lock(s)
> 	FENCE R, RW
> 	r1 = READ_ONCE(y); // load L
> 
> I think they can, because neither "FENCE RW, W" nor "FENCE R, RW" order
> them.

I'm confused by your argument, per the above quoted section, those
fences and the AMO combine into a RW,RW ordering which is (as per the
later clarification) multi-copy-atomic, aka smp_mb().

As such, S and L are not allowed to be re-ordered in the given scenario.

> Note that the reordering is allowed in LKMM, because unlock-lock
> only need to be as strong as RCtso.

Risc-V is strictly stronger than required in this instance. Given the
current lock implementation. Daniel pointed out that if the atomic op
were LL/SC based instead of AMO it would end up being RCtso.

