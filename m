Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981132A018D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Oct 2020 10:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgJ3JiQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 30 Oct 2020 05:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3JiQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 30 Oct 2020 05:38:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25362C0613CF;
        Fri, 30 Oct 2020 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8P3Vd0fpshJOqllZKRjIxmlOR9P1zlE3yNvn6d8Tb0c=; b=ow+j+doFQFKOTYO6mUOHH+uVQe
        sJ/TZpUx9VvDrKLEdFD0GYonbAaNfzKampSB5XLxiS3HzVvw4THJrNwIRcbeqnk1j8bFDOdTF5cL2
        eANk2KVQY00hPDG2tJXjrPB4AbBOcI+8boP4EDYzIMP1OFlRzmwUd+wUyy/0UKV12SV2GuoAq3zo8
        BNlr1ORh5ZhOYQB748C2AZw90vdlL2i1VxI1ITH9sYum4KcPNnrXcNj0alzegS/PwftneKi20epVC
        OMP/K2S50euuJI1d8GaOlliM4MXL9EqDIhMYKecbzuJeZz2613bKuBaCia9ifqFugsBMOVWQbhDvu
        Nhr6RvwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYQrH-000364-Vy; Fri, 30 Oct 2020 09:38:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4E3D30015A;
        Fri, 30 Oct 2020 10:38:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 792AB2B974BDE; Fri, 30 Oct 2020 10:38:06 +0100 (CET)
Date:   Fri, 30 Oct 2020 10:38:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>,
        Qian Cai <cai@redhat.com>, x86 <x86@kernel.org>
Subject: Re: [tip: locking/core] lockdep: Fix usage_traceoverflow
Message-ID: <20201030093806.GA2628@hirez.programming.kicks-ass.net>
References: <160379817513.29534.880306651053124370@build.alporthouse.com>
 <20201027115955.GA2611@hirez.programming.kicks-ass.net>
 <20201027123056.GE2651@hirez.programming.kicks-ass.net>
 <160380535006.10461.1259632375207276085@build.alporthouse.com>
 <20201027154533.GB2611@hirez.programming.kicks-ass.net>
 <160381649396.10461.15013696719989662769@build.alporthouse.com>
 <160390684819.31966.12048967113267928793@build.alporthouse.com>
 <20201028194208.GF2628@hirez.programming.kicks-ass.net>
 <20201028195910.GI2651@hirez.programming.kicks-ass.net>
 <20201030035118.GB855403@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030035118.GB855403@boqun-archlinux>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Oct 30, 2020 at 11:51:18AM +0800, Boqun Feng wrote:
> On Wed, Oct 28, 2020 at 08:59:10PM +0100, Peter Zijlstra wrote:

> Sorry for the late response.

No worries, glad you could have a look.

> > So that's commit f611e8cf98ec ("lockdep: Take read/write status in
> > consideration when generate chainkey") that did that.
> > 
> 
> Yeah, I think that's related, howver ...

It's the commit that made the chainkey depend on the read state, and
thus introduced this connondrum.

> > So validate_chain() requires the new chain_key, but can change ->read
> > which then invalidates the chain_key we just calculated.
> > 
> > This happens when check_deadlock() returns 2, which only happens when:
> > 
> >   - next->read == 2 && ... ; however @hext is our @hlock, so that's
> >     pointless
> > 
> 
> I don't think we should return 2 (earlier) in this case anymore. Because
> now we have recursive read deadlock detection, it's safe to add dep:
> "prev -> next" in the dependency graph. I think we can just continue in
> this case. Actually I think this is something I'm missing in my
> recursive read detection patchset :-/

Yes, I agree, this case should go. We now fully support recursive read
depndencies per your recent work.

> >   - when there's a nest_lock involved ; ww_mutex uses that !!!
> > 
> 
> That leaves check_deadlock() return 2 only if hlock is a nest_lock, and
> ...

> > @@ -3597,8 +3598,12 @@ static int validate_chain(struct task_struct *curr,
> >  		 * building dependencies (just like we jump over
> >  		 * trylock entries):
> >  		 */
> > -		if (ret == 2)
> > +		if (ret == 2) {
> >  			hlock->read = 2;
> > +			*chain_key = iterate_chain_key(hlock->prev_chain_key, hlock_id(hlock));
> 
> If "ret == 2" means hlock is a a nest_lock, than we don't need the
> "->read = 2" trick here and we don't need to update chain_key either.
> We used to have this "->read = 2" only because we want to skip the
> dependency adding step afterwards. So how about the following:
> 
> It survived a lockdep selftest at boot time.

Right, but our self-tests didn't trigger this problem to begin with, let
me go try and create one that does.

> ----------------------------->8
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 3e99dfef8408..b23ca6196561 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2765,7 +2765,7 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
>   * (Note that this has to be done separately, because the graph cannot
>   * detect such classes of deadlocks.)
>   *
> - * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
> + * Returns: 0 on deadlock detected, 1 on OK, 2 on nest_lock
>   */
>  static int
>  check_deadlock(struct task_struct *curr, struct held_lock *next)
> @@ -2788,7 +2788,7 @@ check_deadlock(struct task_struct *curr, struct held_lock *next)
>  		 * lock class (i.e. read_lock(lock)+read_lock(lock)):
>  		 */
>  		if ((next->read == 2) && prev->read)
> -			return 2;
> +			continue;
>  
>  		/*
>  		 * We're holding the nest_lock, which serializes this lock's
> @@ -3592,16 +3592,9 @@ static int validate_chain(struct task_struct *curr,
>  
>  		if (!ret)
>  			return 0;
> -		/*
> -		 * Mark recursive read, as we jump over it when
> -		 * building dependencies (just like we jump over
> -		 * trylock entries):
> -		 */
> -		if (ret == 2)
> -			hlock->read = 2;
>  		/*
>  		 * Add dependency only if this lock is not the head
> -		 * of the chain, and if it's not a secondary read-lock:
> +		 * of the chain, and if it's not a nest_lock:
>  		 */
>  		if (!chain_head && ret != 2) {
>  			if (!check_prevs_add(curr, hlock))

I'm not entirely sure that doesn't still trigger the problem. Consider
@chain_head := true.

Anyway, let me go try and write this self-tests, maybe that'll get my
snot-addled brains sufficiently aligned to make sense of all this :/
