Return-Path: <linux-tip-commits+bounces-4824-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03015A83F59
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 11:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF76D3BF14D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 09:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72261EB5F7;
	Thu, 10 Apr 2025 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfILl1rY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB92214A91;
	Thu, 10 Apr 2025 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278352; cv=none; b=V0v/nlBiyQu4YE7dALngGMwHM7jWHMyEWbzxggQRncL15OZbV+uqejFDIqHtcpNbsFUqGI3dSEGlFL27BMLzhFpjep8CUR0pxPOCg6Fj9F9HuUXEhxunwCsAkg1zL2yvhm0h5RNAAwdx42P9N2Gd7SexBHhFsGlNkI0hm/EHdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278352; c=relaxed/simple;
	bh=0kIzi7TbTQFS8VlZNGMFkRNquA5kSYKBBDNZ76ejBk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIhEYMvvN0ZxYH3Eiie2dYUaUP/7/2HjP87eESlz1FKyVl7dktnS2HytLX4svhRNmMLy1D4i/oD0jErbyAJ8ovOJcTS+O7/nYCU+X4jNWLGszmiB8HUB7xNufJw4HlNzMblZ6ZnhxVvjG/xwlt75zY5iCzc/EyrjhL3A9dB3Vuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfILl1rY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17380C4CEDD;
	Thu, 10 Apr 2025 09:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744278352;
	bh=0kIzi7TbTQFS8VlZNGMFkRNquA5kSYKBBDNZ76ejBk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XfILl1rYnxJVxtNk1Mui9WiG5xWY8QYfVAaY4Bn68POkWSJDSsylxP3hyLiM/SCfA
	 Sy4bZkgDrP73HTpnWwr9TJU+p7uGBeXJ1TJt3bdVqK2nU8KOuI/RNhy5mbszYPuxIm
	 KoGJirY1w0i6fw10QNFwJ87FYSmyL1GTd8bRK4go3X5YL4wIEYS991XKNoSO0ow7WV
	 4xwmF5qHtLypkW2IP/gZMYEhS2xM8fozDc9BFq5/NLRJN7vUm0NvsdAcrDmR5EtC9h
	 XYDQcJOXUYb5LMhIf55kgHFIkGL3vorIBOu9bKEVOE5G658CoFiwJw7I7YC9JmnxE0
	 W5Vg06wS8wX8w==
Date: Thu, 10 Apr 2025 11:45:49 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org
Subject: Re: [tip: perf/core] perf: Simplify perf_event_free_task() wait
Message-ID: <Z_eTTf6RBeHQ8bmT@localhost.localdomain>
References: <20250307193723.044499344@infradead.org>
 <174413910413.31282.5179470093314736126.tip-bot2@tip-bot2>
 <Z_ZvmEhjkAhplCBE@localhost.localdomain>
 <20250410093456.GA17321@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250410093456.GA17321@noisy.programming.kicks-ass.net>

Le Thu, Apr 10, 2025 at 11:34:56AM +0200, Peter Zijlstra a écrit :
> On Wed, Apr 09, 2025 at 03:01:12PM +0200, Frederic Weisbecker wrote:
> 
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 3c92b75..fa6dab0 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -1270,6 +1270,9 @@ static void put_ctx(struct perf_event_context *ctx)
> > >  		if (ctx->task && ctx->task != TASK_TOMBSTONE)
> > >  			put_task_struct(ctx->task);
> > >  		call_rcu(&ctx->rcu_head, free_ctx);
> > > +	} else if (ctx->task == TASK_TOMBSTONE) {
> > > +		smp_mb(); /* pairs with wait_var_event() */
> > > +		wake_up_var(&ctx->refcount);
> > 
> > So there are three situations:
> > 
> > * If perf_event_free_task() has removed all the children from the parent list
> >   before perf_event_release_kernel() got a chance to even iterate them, then
> >   it's all good as there is no get_ctx() pending.
> > 
> > * If perf_event_release_kernel() iterates a child event, but it gets freed
> >   meanwhile by perf_event_free_task() while the mutexes are temporarily
> >   unlocked, it's all good because while locking again the ctx mutex,
> >   perf_event_release_kernel() observes TASK_TOMBSTONE.
> > 
> > * But if perf_event_release_kernel() frees the child event before
> >   perf_event_free_task() got a chance, we may face this scenario:
> > 
> >     perf_event_release_kernel()                                  perf_event_free_task()
> >     --------------------------                                   ------------------------
> >     mutex_lock(&event->child_mutex)
> >     get_ctx(child->ctx)
> >     mutex_unlock(&event->child_mutex)
> > 
> >     mutex_lock(ctx->mutex)
> >     mutex_lock(&event->child_mutex)
> >     perf_remove_from_context(child)
> >     mutex_unlock(&event->child_mutex)
> >     mutex_unlock(ctx->mutex)
> > 
> >                                                                  // This lock acquires ctx->refcount == 2
> >                                                                  // visibility
> >                                                                  mutex_lock(ctx->mutex)
> >                                                                  ctx->task = TASK_TOMBSTONE
> >                                                                  mutex_unlock(ctx->mutex)
> >                                                                  
> >                                                                  wait_var_event()
> >                                                                      // enters prepare_to_wait() since
> >                                                                      // ctx->refcount == 2
> >                                                                      // is guaranteed to be seen
> >                                                                      set_current_state(TASK_INTERRUPTIBLE)
> >                                                                      smp_mb()
> >                                                                      if (ctx->refcount != 1)
> >                                                                          schedule()
> >     put_ctx()
> >        // NOT fully ordered! Only RELEASE semantics
> >        refcount_dec_and_test()
> >            atomic_fetch_sub_release()
> >        // So TASK_TOMBSTONE is not guaranteed to be seen
> >        if (ctx->task == TASK_TOMBSTONE)
> >            wake_up_var()
> > 
> > Basically it's a broken store buffer:
> > 
> >     perf_event_release_kernel()                                  perf_event_free_task()
> >     --------------------------                                   ------------------------
> >     ctx->task = TASK_TOMBSTONE                                   smp_store_release(&ctx->refcount, ctx->refcount - 1)
> >     smp_mb()
> >     READ_ONCE(ctx->refcount)                                     READ_ONCE(ctx->task)
> > 
> > 
> > So you need this:
> > 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index fa6dab08be47..c4fbbe25361a 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -1270,9 +1270,10 @@ static void put_ctx(struct perf_event_context *ctx)
> >  		if (ctx->task && ctx->task != TASK_TOMBSTONE)
> >  			put_task_struct(ctx->task);
> >  		call_rcu(&ctx->rcu_head, free_ctx);
> > -	} else if (ctx->task == TASK_TOMBSTONE) {
> > +	} else {
> >  		smp_mb(); /* pairs with wait_var_event() */
> > -		wake_up_var(&ctx->refcount);
> > +		if (ctx->task == TASK_TOMBSTONE)
> > +			wake_up_var(&ctx->refcount);
> >  	}
> >  }
> 
> Very good, thanks!
> 
> I'll make that smp_mb__after_atomic() instead, but yes, this barrier
> needs to move before the loading of ctx->task.
> 
> I'll transform this into a patch and stuff on top.

Sure! Or feel free to fold it, though that imply a rebase...

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

