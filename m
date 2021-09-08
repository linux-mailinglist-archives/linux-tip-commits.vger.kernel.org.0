Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C082C40387B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  8 Sep 2021 13:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhIHLCP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 8 Sep 2021 07:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbhIHLCM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 8 Sep 2021 07:02:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461B6C061575;
        Wed,  8 Sep 2021 04:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NBB/pE6kVFPym7y5im4H4R75sKk+SHXomtuzG57X2fg=; b=OTNXMORpOInjk+Ph5RpPeN2/aY
        rZiZp9Ef9TC++jLN8rIHqpe8ByMJtm2QR0MUo0qs0wEA3W5/IbDa1sMRe+FSqg3zpuV+8weXgUMYg
        edAz0BkHy1kg8onASopvMCrRmO0ea1xtENHFmY/okEJPU9Qh0lr5mgxwTe3qrZq34BXiMtn5vBEJV
        k3pF0HsPyvdBk104yry6D+Uf2PDFKJfMsAg9MM4sPoBG9a433U8gl6ct4g6Si/mUTPgkmWvoSeuyh
        NrpIjA0r2pYPuh1H2Ap/OT4/3EAqge+2cgoWZvkchvmJhfCEXXm3aFNDdeNt3xsjDB+K5rxKUwi1v
        nYVYybFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNvJb-001cqL-Jy; Wed, 08 Sep 2021 11:00:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 431D0300362;
        Wed,  8 Sep 2021 13:00:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11D81212EAB69; Wed,  8 Sep 2021 13:00:26 +0200 (CEST)
Date:   Wed, 8 Sep 2021 13:00:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     stern@rowland.harvard.edu, alexander.shishkin@linux.intel.com,
        hpa@zytor.com, andrea.parri@amarulasolutions.com, mingo@kernel.org,
        paulmck@kernel.org, vincent.weaver@maine.edu, tglx@linutronix.de,
        jolsa@redhat.com, acme@redhat.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, eranian@google.com, will@kernel.org
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
References: <20180926182920.27644-2-paulmck@linux.ibm.com>
 <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Oct 02, 2018 at 03:11:10AM -0700, tip-bot for Alan Stern wrote:
> Commit-ID:  6e89e831a90172bc3d34ecbba52af5b9c4a447d1
> Gitweb:     https://git.kernel.org/tip/6e89e831a90172bc3d34ecbba52af5b9c4a447d1
> Author:     Alan Stern <stern@rowland.harvard.edu>
> AuthorDate: Wed, 26 Sep 2018 11:29:17 -0700
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue, 2 Oct 2018 10:28:01 +0200
> 
> tools/memory-model: Add extra ordering for locks and remove it for ordinary release/acquire
> 
> More than one kernel developer has expressed the opinion that the LKMM
> should enforce ordering of writes by locking.  In other words, given
> the following code:
> 
> 	WRITE_ONCE(x, 1);
> 	spin_unlock(&s):
> 	spin_lock(&s);
> 	WRITE_ONCE(y, 1);
> 
> the stores to x and y should be propagated in order to all other CPUs,
> even though those other CPUs might not access the lock s.  In terms of
> the memory model, this means expanding the cumul-fence relation.

Let me revive this old thread... recently we ran into the case:

	WRITE_ONCE(x, 1);
	spin_unlock(&s):
	spin_lock(&r);
	WRITE_ONCE(y, 1);

which is distinct from the original in that UNLOCK and LOCK are not on
the same variable.

I'm arguing this should still be RCtso by reason of:

  spin_lock() requires an atomic-acquire which:

    TSO-arch)		implies smp_mb()
    ARM64)		is RCsc for any stlr/ldar
    Power)		LWSYNC
    Risc-V)		fence r , rw
    *)			explicitly has smp_mb()


However, Boqun points out that the memory model disagrees, per:

  https://lkml.kernel.org/r/YTI2UjKy+C7LeIf+@boqun-archlinux

Is this an error/oversight of the memory model, or did I miss a subtlety
somewhere?
