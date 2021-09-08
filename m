Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56400403C5B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  8 Sep 2021 17:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351931AbhIHPP7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 8 Sep 2021 11:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348450AbhIHPP6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 8 Sep 2021 11:15:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6449C061575;
        Wed,  8 Sep 2021 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LdTCvAteTIAmo7w6m1ecGTY5uPdtHi24nvN2i0a75rI=; b=YUSTFx7+UfC3oU1Xp6HK7G8bc+
        sGOMbvASiPDft4YZzY+32pPX7CYwyDvANpscYyk9qiZvUR13UPOeQXLN4Wc/eDj0ccQLqrPsUvuml
        I0dxQXWspMhp5t3w5YQTWwJiuIiHe47Z04iB2DvOqyXFxjoL/WWeo5Ms3jh5Lm8SEqSJPe/bHUWNI
        KpqcmjR95XyrF7WpZ+FZByaPGyCOARYA/mMxzHW7LTzr0bWuV9rULCqOtPvsLPDeRjGYbbxzEE5OC
        fvHnWxhktAdbFZrWWkNmfus2FApBkQ+aemYCMdgLx3GsmQphOmSYeLFpH97s6mc1t/Vm1ivEVX5EC
        bF5LZDaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNzFJ-008usm-Ed; Wed, 08 Sep 2021 15:12:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F74F300314;
        Wed,  8 Sep 2021 17:12:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF7CA20800161; Wed,  8 Sep 2021 17:12:15 +0200 (CEST)
Date:   Wed, 8 Sep 2021 17:12:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     alexander.shishkin@linux.intel.com, hpa@zytor.com,
        parri.andrea@gmail.com, mingo@kernel.org, paulmck@kernel.org,
        vincent.weaver@maine.edu, tglx@linutronix.de, jolsa@redhat.com,
        acme@redhat.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, eranian@google.com, will@kernel.org,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <YTjSz/dE2g96t8ja@hirez.programming.kicks-ass.net>
References: <20180926182920.27644-2-paulmck@linux.ibm.com>
 <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908144217.GA603644@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Sep 08, 2021 at 10:42:17AM -0400, Alan Stern wrote:
> On Wed, Sep 08, 2021 at 01:44:11PM +0200, Peter Zijlstra wrote:

> > > Is this an error/oversight of the memory model, or did I miss a subtlety
> > > somewhere?
> 
> There's the question of what we think the LKMM should do in principle, and 
> the question of how far it should go in mirroring the limitations of the 
> various kernel hardware implementations.  These are obviously separate 
> questions, but they both should influence the design of the memory model.  
> But to what extent?
> 
> Given:
> 
> 	spin_lock(&r);
> 	WRITE_ONCE(x, 1);
> 	spin_unlock(&r);
> 	spin_lock(&s);
> 	WRITE_ONCE(y, 1);
> 	spin_unlock(&s);
> 
> there is no reason _in theory_ why a CPU shouldn't reorder and interleave 
> the operations to get:
> 
> 	spin_lock(&r);
> 	spin_lock(&s);
> 	WRITE_ONCE(x, 1);
> 	WRITE_ONCE(y, 1);
> 	spin_unlock(&r);
> 	spin_unlock(&s);
> 
> (Of course, this wouldn't happen if some other CPU was holding the s lock 
> while waiting for r to be released.  In that case the spin loop for s above 
> wouldn't be able to end until after the unlock operation on r was complete, 
> so this reordering couldn't occur.  But if there was no such contention then 
> the reordering is possible in theory -- ignoring restrictions imposed by the 
> actual implementations of the operations.)
> 
> Given such a reordering, nothing will prevent other CPUs from observing the 
> write to y before the write to x.

To a very small degree the Risc-V implementation actually does some of
that. It allows the stores from unlock and lock to be observed out of
order. But in general we have very weak rules about where the store of
the lock is visible in any case.

(revisit the spin_is_locked() saga for more details there)

> > Hmm.. that argument isn't strong enough for Risc-V if I read that FENCE
> > thing right. That's just R->RW ordering, which doesn't constrain the
> > first WRITE_ONCE().
> > 
> > However, that spin_unlock has "fence rw, w" with a subsequent write. So
> > the whole thing then becomes something like:
> > 
> > 
> > 	WRITE_ONCE(x, 1);
> > 	FENCE RW, W
> > 	WRITE_ONCE(s.lock, 0);
> > 	AMOSWAP %0, 1, r.lock
> > 	FENCE R, WR
> > 	WRITE_ONCE(y, 1);
> > 
> > 
> > Which I think is still sufficient, irrespective of the whole s!=r thing.
> 
> To me, this argument feels like an artificial, unintended consequence of the 
> individual implementations, not something that should be considered a 
> systematic architectural requirement.  Perhaps one could say the same thing 
> about the case where the two spinlock_t variables are the same, but at least 
> in that case there is a good argument for inherent ordering of atomic 
> accesses to a single variable.

Possibly :-) The way I got here is that my brain seems to have produced
the rule that UNLOCK+LOCK -> TSO order (an improvement, because for a
time it said SC), and it completely forgot about this subtlely. And in
general I feel that less subtlety is more better, but I understand your
counter argument :/

In any case, it looks like we had to put an smp_mb() in there anyway due
to other reasons and the whole argument is moot again.

I'll try and remember for next time :-)
