Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CB7404625
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 09:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352572AbhIIH3c (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 03:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350906AbhIIH3b (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 03:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762FBC061575;
        Thu,  9 Sep 2021 00:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6l+bVRkZAR24KpvUarH2ZXKDkGOGMuRedBuOO37bodQ=; b=cyvi8oh3sb3R7ofchE9i+XMLVo
        efFEzwsvzCAxstqvZGzEkbH9IIF1L7SgHkRqw4vDdImw2c/0q+0upl0jb/oR7FhIVgZiRkwOHcpHc
        PGmocsa8SzH9WTdgs7sHLzjK13Hn8/VqVNGhHZzIgEWmoLJmojyuE9Xp8S1aTstN+Mtqomf9T1tJg
        o8ThcJdGWoLvXpb3xtLtI9cjN9AWLLWfc2Z7yo8fYBrRF1zbWttQdb48On5GFQI6SaHv8C04+Kv95
        d+533NK6TyzHCLVlIbT1nsJhhsIXjixvSVxK2SdyzmmPHt8iKJi+r/Pp1SpSpqUr/yYPJzD8eG/Z5
        oJq2ikLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOERB-009a4c-CB; Thu, 09 Sep 2021 07:25:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 049853001C0;
        Thu,  9 Sep 2021 09:25:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA90B2015E4B3; Thu,  9 Sep 2021 09:25:30 +0200 (CEST)
Date:   Thu, 9 Sep 2021 09:25:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
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
        Will Deacon <will@kernel.org>,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
References: <20180926182920.27644-2-paulmck@linux.ibm.com>
 <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Sep 08, 2021 at 09:08:33AM -0700, Linus Torvalds wrote:

> So if this is purely a RISC-V thing,

Just to clarify, I think the current RISC-V thing is stonger than
PowerPC, but maybe not as strong as say ARM64, but RISC-V memory
ordering is still somewhat hazy to me.

Specifically, the sequence:

	/* critical section s */
	WRITE_ONCE(x, 1);
	FENCE RW, W
	WRITE_ONCE(s.lock, 0);		/* store S */
	AMOSWAP %0, 1, r.lock		/* store R */
	FENCE R, RW
	WRITE_ONCE(y, 1);
	/* critical section r */

fully separates section s from section r, as in RW->RW ordering
(possibly not as strong as smp_mb() though), while on PowerPC it would
only impose TSO ordering between sections.

The AMOSWAP is a RmW and as such matches the W from the RW->W fence,
similarly it marches the R from the R->RW fence, yielding an:

	RW->  W
	    RmW
	    R  ->RW

ordering. It's the stores S and R that can be re-ordered, but not the
sections themselves (same on PowerPC and many others).

Clarification from a RISC-V enabled person would be appreciated.

> then I think it's entirely reasonable to
> 
>         spin_unlock(&r);
>         spin_lock(&s);
> 
> cannot be reordered.

I'm obviously completely in favour of that :-)
