Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E4140390D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  8 Sep 2021 13:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349218AbhIHLpe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 8 Sep 2021 07:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349176AbhIHLpc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 8 Sep 2021 07:45:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1583EC061575;
        Wed,  8 Sep 2021 04:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KkbVfC2NQ37cQ9a9pfkaXbYDmV13hjbW4DGEU3FEM8g=; b=cgldSu7jeycIUIEkvccbPhxMpL
        isZsXa+GOmeyES61HptJTl2+pBZ6PXUcZfiMqXCesR4WlhrFtw8AEFX82Ov3Wx35XGhAIVbxp7Ccb
        yRz4x0FR81Kou2PY5yryoFvE/vaR+SX+xj3dBQbjcdvkztvqOsFT0QmKCbBJ+hi7yoZVJLAeSWPqp
        k2a34E2vNIZfi0TKY0Hze1VwJdoxDZC5TFk8kSWiBz6DLezTvrWRE87RQ8MXUrzatj2cfyzUccj+/
        m4VydFJQuamYB/tglrmSaXfyWu7fd9PMn67+l+mzfK3iP3cvFwXw9Tr4Sn8VhnVgXADicnd4sTs3M
        zzMUKBEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNvzx-001dJI-53; Wed, 08 Sep 2021 11:44:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91163300362;
        Wed,  8 Sep 2021 13:44:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6FEA92067E687; Wed,  8 Sep 2021 13:44:11 +0200 (CEST)
Date:   Wed, 8 Sep 2021 13:44:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     stern@rowland.harvard.edu, alexander.shishkin@linux.intel.com,
        hpa@zytor.com, parri.andrea@gmail.com, mingo@kernel.org,
        paulmck@kernel.org, vincent.weaver@maine.edu, tglx@linutronix.de,
        jolsa@redhat.com, acme@redhat.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, eranian@google.com, will@kernel.org
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
References: <20180926182920.27644-2-paulmck@linux.ibm.com>
 <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Sep 08, 2021 at 01:00:26PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 02, 2018 at 03:11:10AM -0700, tip-bot for Alan Stern wrote:
> > Commit-ID:  6e89e831a90172bc3d34ecbba52af5b9c4a447d1
> > Gitweb:     https://git.kernel.org/tip/6e89e831a90172bc3d34ecbba52af5b9c4a447d1
> > Author:     Alan Stern <stern@rowland.harvard.edu>
> > AuthorDate: Wed, 26 Sep 2018 11:29:17 -0700
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Tue, 2 Oct 2018 10:28:01 +0200
> > 
> > tools/memory-model: Add extra ordering for locks and remove it for ordinary release/acquire
> > 
> > More than one kernel developer has expressed the opinion that the LKMM
> > should enforce ordering of writes by locking.  In other words, given
> > the following code:
> > 
> > 	WRITE_ONCE(x, 1);
> > 	spin_unlock(&s):
> > 	spin_lock(&s);
> > 	WRITE_ONCE(y, 1);
> > 
> > the stores to x and y should be propagated in order to all other CPUs,
> > even though those other CPUs might not access the lock s.  In terms of
> > the memory model, this means expanding the cumul-fence relation.
> 
> Let me revive this old thread... recently we ran into the case:
> 
> 	WRITE_ONCE(x, 1);
> 	spin_unlock(&s):
> 	spin_lock(&r);
> 	WRITE_ONCE(y, 1);
> 
> which is distinct from the original in that UNLOCK and LOCK are not on
> the same variable.
> 
> I'm arguing this should still be RCtso by reason of:
> 
>   spin_lock() requires an atomic-acquire which:
> 
>     TSO-arch)		implies smp_mb()
>     ARM64)		is RCsc for any stlr/ldar
>     Power)		LWSYNC
>     Risc-V)		fence r , rw
>     *)			explicitly has smp_mb()
> 
> 
> However, Boqun points out that the memory model disagrees, per:
> 
>   https://lkml.kernel.org/r/YTI2UjKy+C7LeIf+@boqun-archlinux
> 
> Is this an error/oversight of the memory model, or did I miss a subtlety
> somewhere?

Hmm.. that argument isn't strong enough for Risc-V if I read that FENCE
thing right. That's just R->RW ordering, which doesn't constrain the
first WRITE_ONCE().

However, that spin_unlock has "fence rw, w" with a subsequent write. So
the whole thing then becomes something like:


	WRITE_ONCE(x, 1);
	FENCE RW, W
	WRITE_ONCE(s.lock, 0);
	AMOSWAP %0, 1, r.lock
	FENCE R, WR
	WRITE_ONCE(y, 1);


Which I think is still sufficient, irrespective of the whole s!=r thing.
