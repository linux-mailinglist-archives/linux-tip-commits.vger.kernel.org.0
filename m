Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7330407075
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Sep 2021 19:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhIJRV6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Sep 2021 13:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhIJRV5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Sep 2021 13:21:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07778C061574;
        Fri, 10 Sep 2021 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ywULsRgfl8spdk+6KG6of6ltCKMxYqZsF0ZGMeKFOPI=; b=IayTb0LaLtscPPiQJNM/Zb2SlP
        50FTGWXO4tTPVMv/fY5tFF80bNvrzVh9qfafBtaJxO8BuSE+TJawu+BQhFo81i9Ig+m7/qqYPJecu
        ivkovF9HPaHMMtqCeJgqWc51g0up1ZVjXf5BvZ8qoYgipQXKp2zlvRRmxv30H5u+dyrtS2K2DvrlM
        +iJ7K5KpF7Kcyv2w79oI3PFZ68/d99Ujnf7gHgZkN6RjhWbHW2pi1M3iHjZD/mPwU3Wx11jtNoDAB
        3ZQow7/npcatWcKwCyOHIuVtk5oEZ3xM6zVxPlxq1ql6FHWVBYIE1aRcb5vpHpMv32zWx2BXdHt1q
        1r3J5fNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOk9o-00BCfe-M4; Fri, 10 Sep 2021 17:18:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC83D98627A; Fri, 10 Sep 2021 19:17:43 +0200 (CEST)
Date:   Fri, 10 Sep 2021 19:17:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
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
Message-ID: <20210910171743.GO4323@worktop.programming.kicks-ass.net>
References: <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
 <20210909133535.GA9722@willie-the-truck>
 <5412ab37-2979-5717-4951-6a61366df0f2@nvidia.com>
 <20210909180005.GA2230712@paulmck-ThinkPad-P17-Gen-1>
 <YTtpnZuSId9yDUjB@boqun-archlinux>
 <20210910163632.GC39858@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910163632.GC39858@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Sep 10, 2021 at 12:36:32PM -0400, Alan Stern wrote:
> --- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
> +++ usb-devel/tools/memory-model/Documentation/explanation.txt
> @@ -1813,15 +1813,16 @@ spin_trylock() -- we can call these thin
>  lock-acquires -- have two properties beyond those of ordinary releases
>  and acquires.
>  
> +First, when a lock-acquire reads from or is po-after a lock-release,
> +the LKMM requires that every instruction po-before the lock-release
> +must execute before any instruction po-after the lock-acquire.  This
> +would naturally hold if the release and acquire operations were on
> +different CPUs and accessed the same lock variable, but the LKMM says
> +it also holds when they are on the same CPU, even if they access
> +different lock variables.  For example:

Could be I don't understand this right, but the way I'm reading it, it
seems to imply RCsc. Which I don't think we're actually asking at this
time.
