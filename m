Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C81633F0E7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 14:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCQNNb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 09:13:31 -0400
Received: from casper.infradead.org ([90.155.50.34]:35336 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhCQNNA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 09:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M8V4Gbrn6zP42eMueGTVV/9PfYZWlOv7jnjiFYn/5Ls=; b=CnVnPPu57NRADopOzW67y4hM4T
        V/HK+2etiPgS0tnWFKP9ItZ65/ud5vF8yZs7YlkbEj6NahWEikzGWQSd8ds2HtbPjaRuTV7Z62AlT
        TmmbRkx1CmICk/yautV8wBSSBDa1d4AOUiMsKG8qJpVbKHD+nt3/7NVV0p/HVcv9oZD/lHSWUthXI
        Lbcu7T3DDvhGirP3iAtoKDWhMDuKlPOA6j709fMCrjkH9lKnfN/K2Nc4d++Qi46/ZGktO+NlsleK1
        bB+me9uErVx9LcoJtvVKAPLYkNla0NHreBgGi8nwCI1IUOy80y6KHrpcuqlmaMv8t8zdKF6OY3/r7
        pEOcMwNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMVyb-001V41-Tc; Wed, 17 Mar 2021 13:12:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D85E301324;
        Wed, 17 Mar 2021 14:12:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43A6520781083; Wed, 17 Mar 2021 14:12:41 +0100 (CET)
Date:   Wed, 17 Mar 2021 14:12:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: locking/urgent] locking/ww_mutex: Treat ww_mutex_lock()
 like a trylock
Message-ID: <YFIASRkXowQWgj2s@hirez.programming.kicks-ass.net>
References: <20210316153119.13802-4-longman@redhat.com>
 <161598470197.398.8903908266426306140.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161598470197.398.8903908266426306140.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Mar 17, 2021 at 12:38:21PM -0000, tip-bot2 for Waiman Long wrote:
> The following commit has been merged into the locking/urgent branch of tip:
> 
> Commit-ID:     b058f2e4d0a70c060e21ed122b264e9649cad57f
> Gitweb:        https://git.kernel.org/tip/b058f2e4d0a70c060e21ed122b264e9649cad57f
> Author:        Waiman Long <longman@redhat.com>
> AuthorDate:    Tue, 16 Mar 2021 11:31:18 -04:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 17 Mar 2021 09:56:46 +01:00
> 
> locking/ww_mutex: Treat ww_mutex_lock() like a trylock
> 
> It was found that running the ww_mutex_lock-torture test produced the
> following lockdep splat almost immediately:
> 
> [  103.892638] ======================================================
> [  103.892639] WARNING: possible circular locking dependency detected
> [  103.892641] 5.12.0-rc3-debug+ #2 Tainted: G S      W
> [  103.892643] ------------------------------------------------------
> [  103.892643] lock_torture_wr/3234 is trying to acquire lock:
> [  103.892646] ffffffffc0b35b10 (torture_ww_mutex_2.base){+.+.}-{3:3}, at: torture_ww_mutex_lock+0x316/0x720 [locktorture]
> [  103.892660]
> [  103.892660] but task is already holding lock:
> [  103.892661] ffffffffc0b35cd0 (torture_ww_mutex_0.base){+.+.}-{3:3}, at: torture_ww_mutex_lock+0x3e2/0x720 [locktorture]
> [  103.892669]
> [  103.892669] which lock already depends on the new lock.
> [  103.892669]
> [  103.892670]
> [  103.892670] the existing dependency chain (in reverse order) is:
> [  103.892671]
> [  103.892671] -> #2 (torture_ww_mutex_0.base){+.+.}-{3:3}:
> [  103.892675]        lock_acquire+0x1c5/0x830
> [  103.892682]        __ww_mutex_lock.constprop.15+0x1d1/0x2e50
> [  103.892687]        ww_mutex_lock+0x4b/0x180
> [  103.892690]        torture_ww_mutex_lock+0x316/0x720 [locktorture]
> [  103.892694]        lock_torture_writer+0x142/0x3a0 [locktorture]
> [  103.892698]        kthread+0x35f/0x430
> [  103.892701]        ret_from_fork+0x1f/0x30
> [  103.892706]
> [  103.892706] -> #1 (torture_ww_mutex_1.base){+.+.}-{3:3}:
> [  103.892709]        lock_acquire+0x1c5/0x830
> [  103.892712]        __ww_mutex_lock.constprop.15+0x1d1/0x2e50
> [  103.892715]        ww_mutex_lock+0x4b/0x180
> [  103.892717]        torture_ww_mutex_lock+0x316/0x720 [locktorture]
> [  103.892721]        lock_torture_writer+0x142/0x3a0 [locktorture]
> [  103.892725]        kthread+0x35f/0x430
> [  103.892727]        ret_from_fork+0x1f/0x30
> [  103.892730]
> [  103.892730] -> #0 (torture_ww_mutex_2.base){+.+.}-{3:3}:
> [  103.892733]        check_prevs_add+0x3fd/0x2470
> [  103.892736]        __lock_acquire+0x2602/0x3100
> [  103.892738]        lock_acquire+0x1c5/0x830
> [  103.892740]        __ww_mutex_lock.constprop.15+0x1d1/0x2e50
> [  103.892743]        ww_mutex_lock+0x4b/0x180
> [  103.892746]        torture_ww_mutex_lock+0x316/0x720 [locktorture]
> [  103.892749]        lock_torture_writer+0x142/0x3a0 [locktorture]
> [  103.892753]        kthread+0x35f/0x430
> [  103.892755]        ret_from_fork+0x1f/0x30
> [  103.892757]
> [  103.892757] other info that might help us debug this:
> [  103.892757]
> [  103.892758] Chain exists of:
> [  103.892758]   torture_ww_mutex_2.base --> torture_ww_mutex_1.base --> torture_ww_mutex_0.base
> [  103.892758]
> [  103.892763]  Possible unsafe locking scenario:
> [  103.892763]
> [  103.892764]        CPU0                    CPU1
> [  103.892765]        ----                    ----
> [  103.892765]   lock(torture_ww_mutex_0.base);
> [  103.892767] 				      lock(torture_ww_mutex_1.base);
> [  103.892770] 				      lock(torture_ww_mutex_0.base);
> [  103.892772]   lock(torture_ww_mutex_2.base);
> [  103.892774]
> [  103.892774]  *** DEADLOCK ***
> 
> Since ww_mutex is supposed to be deadlock-proof if used properly, such
> deadlock scenario should not happen. To avoid this false positive splat,
> treat ww_mutex_lock() like a trylock().
> 
> After applying this patch, the locktorture test can run for a long time
> without triggering the circular locking dependency splat.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Acked-by Davidlohr Bueso <dbueso@suse.de>
> Link: https://lore.kernel.org/r/20210316153119.13802-4-longman@redhat.com
> ---
>  kernel/locking/mutex.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 622ebdf..bb89393 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -946,7 +946,10 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>  	}
>  
>  	preempt_disable();
> -	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
> +	/*
> +	 * Treat as trylock for ww_mutex.
> +	 */
> +	mutex_acquire_nest(&lock->dep_map, subclass, !!ww_ctx, nest_lock, ip);

I'm confused... why isn't nest_lock working here?

For ww_mutex, we're supposed to have ctx->dep_map as a nest_lock, and
all lock acquisitions under a nest lock should be fine. Afaict the above
is just plain wrong.
