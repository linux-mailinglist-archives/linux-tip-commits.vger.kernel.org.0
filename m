Return-Path: <linux-tip-commits+bounces-5031-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB4CA91B89
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 14:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE1D8A049E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 12:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B96A24166E;
	Thu, 17 Apr 2025 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omJ8nD5G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A07241667;
	Thu, 17 Apr 2025 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744891439; cv=none; b=onTUJyS8Ct2ie9rCpKJhQDUVW7zI+cAyOkUN6D4oPw2ief6t0Zs/UGbE1bN9l2T4mW/K9UCrp52kUBqo06jM4Wp5hAuMdcu3ss5fh6w0979kDmlmfUV/MhTc8I/NAhj9Ez+5yg7EAzBV42QUl1FQHCBkNZGfFKSeiiGqqrM0pOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744891439; c=relaxed/simple;
	bh=2JZS5eIe1ON0EHD3QKIZWeAakJBfbzWDc3CKofn5RLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDmmjxcYkACSCiVQHNQS0Gts+r1k5NutmmqTh/B9FXYS4HLRap4BYoRY5kFXCT00kdGSvsF2vpkQAuTb3lmMkUdNCKKAIBQ+BvRGNHJ1kP/MSalsM18ob71i0eTGB/xKZsCLDPNfDgEMoUwOxErgCvuUbLbZw3qL0SV9BS4Nuwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omJ8nD5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3C7C4CEE4;
	Thu, 17 Apr 2025 12:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744891438;
	bh=2JZS5eIe1ON0EHD3QKIZWeAakJBfbzWDc3CKofn5RLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=omJ8nD5Gnh7AW0sOLU+A8W0tj5UQSP5n2U3bHAzK/0YX0GpdTJyNTVJSbYAfsjOFr
	 lQk3Sccx8r7gWS8kkZbNZJb4+4dysqKEi76oehvZbjTNM2OFkXcOSu0wTGapQWrV9E
	 B4tZZZNInmV1s2qTXFHlKyM6V4kXSv2jU1wlcQ/0Q+yYba4hPuyP6DlHlI8tRPDw1Z
	 FJqANqpDplWwEjyi//T6gLrmkqpkQrPp/3HWzFk8UbBf0tAwoSVrbVPwIwogvRoeDM
	 vo9L8NKJtI7Jjy1rR+JnKeV4lIG19Ai5o9Qg+Ezsh1Sc/CORL0Th/y+0/qgVaHSedT
	 gEeJJzE8t1hoQ==
Date: Thu, 17 Apr 2025 14:03:55 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org
Subject: Re: [tip: perf/core] perf: Simplify perf_event_free_task() wait
Message-ID: <aADuK4jhKT2AGOYp@gmail.com>
References: <20250307193723.044499344@infradead.org>
 <174413910413.31282.5179470093314736126.tip-bot2@tip-bot2>
 <Z_ZvmEhjkAhplCBE@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_ZvmEhjkAhplCBE@localhost.localdomain>


* Frederic Weisbecker <frederic@kernel.org> wrote:

> Le Tue, Apr 08, 2025 at 07:05:04PM -0000, tip-bot2 for Peter Zijlstra a écrit :
> > The following commit has been merged into the perf/core branch of tip:
> > 
> > Commit-ID:     59f3aa4a3ee27e96132e16d2d2bdc3acadb4bf79
> > Gitweb:        https://git.kernel.org/tip/59f3aa4a3ee27e96132e16d2d2bdc3acadb4bf79
> > Author:        Peter Zijlstra <peterz@infradead.org>
> > AuthorDate:    Fri, 17 Jan 2025 15:27:07 +01:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Tue, 08 Apr 2025 20:55:46 +02:00
> > 
> > perf: Simplify perf_event_free_task() wait
> > 
> > Simplify the code by moving the duplicated wakeup condition into
> > put_ctx().
> > 
> > Notably, wait_var_event() is in perf_event_free_task() and will have
> > set ctx->task = TASK_TOMBSTONE.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > Link: https://lkml.kernel.org/r/20250307193723.044499344@infradead.org
> > ---
> >  kernel/events/core.c | 25 +++----------------------
> >  1 file changed, 3 insertions(+), 22 deletions(-)
> > 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 3c92b75..fa6dab0 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -1270,6 +1270,9 @@ static void put_ctx(struct perf_event_context *ctx)
> >  		if (ctx->task && ctx->task != TASK_TOMBSTONE)
> >  			put_task_struct(ctx->task);
> >  		call_rcu(&ctx->rcu_head, free_ctx);
> > +	} else if (ctx->task == TASK_TOMBSTONE) {
> > +		smp_mb(); /* pairs with wait_var_event() */
> > +		wake_up_var(&ctx->refcount);
> 
> So there are three situations:
> 
> * If perf_event_free_task() has removed all the children from the parent list
>   before perf_event_release_kernel() got a chance to even iterate them, then
>   it's all good as there is no get_ctx() pending.
> 
> * If perf_event_release_kernel() iterates a child event, but it gets freed
>   meanwhile by perf_event_free_task() while the mutexes are temporarily
>   unlocked, it's all good because while locking again the ctx mutex,
>   perf_event_release_kernel() observes TASK_TOMBSTONE.
> 
> * But if perf_event_release_kernel() frees the child event before
>   perf_event_free_task() got a chance, we may face this scenario:
> 
>     perf_event_release_kernel()                                  perf_event_free_task()
>     --------------------------                                   ------------------------
>     mutex_lock(&event->child_mutex)
>     get_ctx(child->ctx)
>     mutex_unlock(&event->child_mutex)
> 
>     mutex_lock(ctx->mutex)
>     mutex_lock(&event->child_mutex)
>     perf_remove_from_context(child)
>     mutex_unlock(&event->child_mutex)
>     mutex_unlock(ctx->mutex)
> 
>                                                                  // This lock acquires ctx->refcount == 2
>                                                                  // visibility
>                                                                  mutex_lock(ctx->mutex)
>                                                                  ctx->task = TASK_TOMBSTONE
>                                                                  mutex_unlock(ctx->mutex)
>                                                                  
>                                                                  wait_var_event()
>                                                                      // enters prepare_to_wait() since
>                                                                      // ctx->refcount == 2
>                                                                      // is guaranteed to be seen
>                                                                      set_current_state(TASK_INTERRUPTIBLE)
>                                                                      smp_mb()
>                                                                      if (ctx->refcount != 1)
>                                                                          schedule()
>     put_ctx()
>        // NOT fully ordered! Only RELEASE semantics
>        refcount_dec_and_test()
>            atomic_fetch_sub_release()
>        // So TASK_TOMBSTONE is not guaranteed to be seen
>        if (ctx->task == TASK_TOMBSTONE)
>            wake_up_var()
> 
> Basically it's a broken store buffer:
> 
>     perf_event_release_kernel()                                  perf_event_free_task()
>     --------------------------                                   ------------------------
>     ctx->task = TASK_TOMBSTONE                                   smp_store_release(&ctx->refcount, ctx->refcount - 1)
>     smp_mb()
>     READ_ONCE(ctx->refcount)                                     READ_ONCE(ctx->task)
> 
> 
> So you need this:
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index fa6dab08be47..c4fbbe25361a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1270,9 +1270,10 @@ static void put_ctx(struct perf_event_context *ctx)
>  		if (ctx->task && ctx->task != TASK_TOMBSTONE)
>  			put_task_struct(ctx->task);
>  		call_rcu(&ctx->rcu_head, free_ctx);
> -	} else if (ctx->task == TASK_TOMBSTONE) {
> +	} else {
>  		smp_mb(); /* pairs with wait_var_event() */
> -		wake_up_var(&ctx->refcount);
> +		if (ctx->task == TASK_TOMBSTONE)
> +			wake_up_var(&ctx->refcount);
>  	}
>  }

JFYI, I've added your SOB:

    Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Thanks,

	Ingo

