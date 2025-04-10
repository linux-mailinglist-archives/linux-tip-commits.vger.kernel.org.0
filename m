Return-Path: <linux-tip-commits+bounces-4823-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3706A83EDE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 11:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C72047ADDF8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 09:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229F020E334;
	Thu, 10 Apr 2025 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="osf3t8aK"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F1525D8E2;
	Thu, 10 Apr 2025 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744277702; cv=none; b=TZwOluUPbfCDjqbPV9IcBTl9dHoOyvlc+Ok8wSgv0CRMxpBkq+QM4HEV6ALpNhrpSYZ8VNYKIV4eJivoiofWtc/J1XqYqrvqa4sHR3eYLjN1hYK/0Vb4od+BGIaOibr7urxEtJzgA9PFdF7cyMvakgRglrArBh2teRBwJBIGa98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744277702; c=relaxed/simple;
	bh=OF9yxO/u4XCow7Qu6hPl66FhWEUvw9jIiJeqXS3IfG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmNELPNb+oioY6TfOQoOnpXSqifmr7AX0EkN48mzmIULRnVv7JAIIoN+BC2jHVxQgDHppvrfwfdeNwsyLksrqBlyMUkLYCg0ZWq4pSQTYx+pPzacbJxESZUU2rMIwt9PE9mXC15GAJJ1y4F1veRdHyDMJfCVfCs3N3jvXppF5lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=osf3t8aK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h/SiiwofwfmzPeG9zN86yMU2F7qnYsGrjKhis+7Q1QY=; b=osf3t8aKX3ptzlKd2Vh9VqbstC
	7C1FbY/pkY1uYGZpDLqvzyceyrNkuE7JbT3kEchOtgH4lyfU4YPE117A76gtVLeuHkJ33LxCjQo16
	AOVUxsY57xZlybeVK6nK51Yxfn/hhrPnfRbmJ6kWFY+LHiLyh06hnetuKq+2uvVmLofZ66qDh5xx2
	OWZihhdwXYWFC2McNplshbmDyyeWOuNW3JaEW9yocsHRl3/DhRI6MRbVi0jtdWgDUF+eFChMbN8Un
	Xm5wuxtLrpJ+UNyVBmZoWfn6kb8tte+lpA5Q3mzMNPQ9MfiaOMJAZ+5yl+4b38+M+zm7dMgwL5jaK
	G+/iSwwA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u2oJF-00000008mul-0JuV;
	Thu, 10 Apr 2025 09:34:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7760B3003C4; Thu, 10 Apr 2025 11:34:56 +0200 (CEST)
Date: Thu, 10 Apr 2025 11:34:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org
Subject: Re: [tip: perf/core] perf: Simplify perf_event_free_task() wait
Message-ID: <20250410093456.GA17321@noisy.programming.kicks-ass.net>
References: <20250307193723.044499344@infradead.org>
 <174413910413.31282.5179470093314736126.tip-bot2@tip-bot2>
 <Z_ZvmEhjkAhplCBE@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_ZvmEhjkAhplCBE@localhost.localdomain>

On Wed, Apr 09, 2025 at 03:01:12PM +0200, Frederic Weisbecker wrote:

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

Very good, thanks!

I'll make that smp_mb__after_atomic() instead, but yes, this barrier
needs to move before the loading of ctx->task.

I'll transform this into a patch and stuff on top.

