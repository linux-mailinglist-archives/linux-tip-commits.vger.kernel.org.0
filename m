Return-Path: <linux-tip-commits+bounces-1231-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701268B8DBD
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 May 2024 18:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F451C21481
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 May 2024 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133A8130492;
	Wed,  1 May 2024 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+CYxHqt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7909A12FB36
	for <linux-tip-commits@vger.kernel.org>; Wed,  1 May 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579617; cv=none; b=MXviUIw07fUCLFHVNZ+E/KYxwNvW+wEeEqSf9oUCsJmfKc3QThSQbNN+FtW+YHjNJZHA6QMMNDuOjcVz6ykQP1mR36Uc2ZSfCSxHNKhU2mU9VL+OC6dOmnK1esYFj2gEO2+IljyuPGWYASmxXgb9tywrEQR6yh+Ww066Y9DmJSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579617; c=relaxed/simple;
	bh=Pa9w/V8mbigAhonO5FDBjI6AaOlVVJdP2CoC36lyTN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrQhv9TYtpyApQ0fQfgRnqzpxbTShNj6AwHaipYT8KyXCADlM+5F9epIRxE2vN6npDKZitk7Lel55WCZj6ObWme4KeZn0EqHyzqVHurFT83AZkVENFuYQMMbVinIcVBheriLeLzTxl1IW3g5XtcEpRLFWzRiGcgtbKkL06gUKLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+CYxHqt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714579614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zCmyjOviXwLUhJllYlBi6gdtFcdjU43GquheYltQR2E=;
	b=e+CYxHqtg4hphOqLjvcsrbHKFTbFetHouwAmEpQvAIgPU29MV9DIEfAuXVBo86rG7mqsDo
	BBEaS8Ge6MsPeTyDFgRCiHnzV/7vap2jP6d3OAh4QwAcSFz3i+PMHrZNstdlfSLl1hL683
	9gVGYWxMWbLrBM56/+oUw9CuIeGfpBQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-eMZyQytUPO6diFe3OufLHQ-1; Wed, 01 May 2024 12:06:52 -0400
X-MC-Unique: eMZyQytUPO6diFe3OufLHQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a5564a2e3a5so502239666b.1
        for <linux-tip-commits@vger.kernel.org>; Wed, 01 May 2024 09:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714579611; x=1715184411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCmyjOviXwLUhJllYlBi6gdtFcdjU43GquheYltQR2E=;
        b=EIzL7e/hsOjBmAci1i7LjRGsQYuhkDCbCbcDxadX3urTrsuGp7Qqn/fElxE4nixiCz
         Svmc3t12fs1yRv+Yjg1Nx3kHZoaVtgSD+t8T3APHDGmhJ0Sh3zbSEKAaVzxHD0pR4a+v
         h+PeWxU/6aKgX8TYoHuSm6l6F19FHNf3ZIeZY5O2VIft2dJZEwxdV2Otz9mAN2pwNvFC
         NRhooI0aTgfo5teV6t6GkoSWkdT/WWLapMJmIDVAQhlYKApQTSKFEQyn8pzvlvNLR4Yh
         7l4sg5q1zRWpT3dsrRmABOlK9kGPv/hSHRJIoyd9/MHR2jf+NGvaSCVKyfsGnLUihbpc
         317A==
X-Gm-Message-State: AOJu0Yx4D6pv2qNFgyrVF2QhQ31OMsdU8oy429ITIE8lrFEocacfYcBC
	zLwvKmr5ONnKIb2uk1W07ZtE1zbpVSGCz/nhJgziAUxYjTWz32kTfwWcTuhEMKpdsmdtHp/S9IB
	DdrH9ICTcuqIyJP9SLpbWDMmLyqouSozcEmKmwmS0RB43TV+/2qaT40x4mpRQKRzjapCn
X-Received: by 2002:a17:906:e219:b0:a55:6407:c0c7 with SMTP id gf25-20020a170906e21900b00a556407c0c7mr2220720ejb.17.1714579610584;
        Wed, 01 May 2024 09:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSWXyxMPkCSSih0yWGqTLHuq6EYNoGLqSVy832mfrhjjSXClwj3CHGBGPNyfYgHDW4KAhULA==
X-Received: by 2002:a17:906:e219:b0:a55:6407:c0c7 with SMTP id gf25-20020a170906e21900b00a556407c0c7mr2220710ejb.17.1714579610008;
        Wed, 01 May 2024 09:06:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:6a42:bb79:449b:3f0b:a228])
        by smtp.gmail.com with ESMTPSA id jt17-20020a170906ca1100b00a5910978658sm2738310ejb.208.2024.05.01.09.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:06:49 -0700 (PDT)
Date: Wed, 1 May 2024 12:06:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Zqiang <qiang.zhang1211@gmail.com>, x86@kernel.org, maz@kernel.org
Subject: Re: [tip: irq/urgent] softirq: Fix suspicious RCU usage in
 __do_softirq()
Message-ID: <20240501120501-mutt-send-email-mst@kernel.org>
References: <20240427102808.29356-1-qiang.zhang1211@gmail.com>
 <171436008266.10875.5509449909240073046.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171436008266.10875.5509449909240073046.tip-bot2@tip-bot2>

On Mon, Apr 29, 2024 at 03:08:02AM -0000, tip-bot2 for Zqiang wrote:
> The following commit has been merged into the irq/urgent branch of tip:
> 
> Commit-ID:     1dd1eff161bd55968d3d46bc36def62d71fb4785
> Gitweb:        https://git.kernel.org/tip/1dd1eff161bd55968d3d46bc36def62d71fb4785
> Author:        Zqiang <qiang.zhang1211@gmail.com>
> AuthorDate:    Sat, 27 Apr 2024 18:28:08 +08:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Mon, 29 Apr 2024 05:03:51 +02:00
> 
> softirq: Fix suspicious RCU usage in __do_softirq()
> 
> Currently, the condition "__this_cpu_read(ksoftirqd) == current" is used to
> invoke rcu_softirq_qs() in ksoftirqd tasks context for non-RT kernels.
> 
> This works correctly as long as the context is actually task context but
> this condition is wrong when:
> 
>      - the current task is ksoftirqd
>      - the task is interrupted in a RCU read side critical section
>      - __do_softirq() is invoked on return from interrupt
> 
> Syzkaller triggered the following scenario:
> 
>   -> finish_task_switch()
>     -> put_task_struct_rcu_user()
>       -> call_rcu(&task->rcu, delayed_put_task_struct)
>         -> __kasan_record_aux_stack()
>           -> pfn_valid()
>             -> rcu_read_lock_sched()
>               <interrupt>
>                 __irq_exit_rcu()
>                 -> __do_softirq)()
>                    -> if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
>                      __this_cpu_read(ksoftirqd) == current)
>                      -> rcu_softirq_qs()
>                        -> RCU_LOCKDEP_WARN(lock_is_held(&rcu_sched_lock_map))
> 
> The rcu quiescent state is reported in the rcu-read critical section, so
> the lockdep warning is triggered.
> 
> Fix this by splitting out the inner working of __do_softirq() into a helper
> function which takes an argument to distinguish between ksoftirqd task
> context and interrupted context and invoke it from the relevant call sites
> with the proper context information and use that for the conditional
> invocation of rcu_softirq_qs().
> 
> Reported-by: syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20240427102808.29356-1-qiang.zhang1211@gmail.com
> Link: https://lore.kernel.org/lkml/8f281a10-b85a-4586-9586-5bbc12dc784f@paulmck-laptop/T/#mea8aba4abfcb97bbf499d169ce7f30c4cff1b0e3

I can add that this also fixes a UAF reported by syzbot
(partially, another part of UAF is an unrelated bug):

Reported-by: syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com



> ---
>  kernel/softirq.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index b315b21..0258201 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -508,7 +508,7 @@ static inline bool lockdep_softirq_start(void) { return false; }
>  static inline void lockdep_softirq_end(bool in_hardirq) { }
>  #endif
>  
> -asmlinkage __visible void __softirq_entry __do_softirq(void)
> +static void handle_softirqs(bool ksirqd)
>  {
>  	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
>  	unsigned long old_flags = current->flags;
> @@ -563,8 +563,7 @@ restart:
>  		pending >>= softirq_bit;
>  	}
>  
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> -	    __this_cpu_read(ksoftirqd) == current)
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && ksirqd)
>  		rcu_softirq_qs();
>  
>  	local_irq_disable();
> @@ -584,6 +583,11 @@ restart:
>  	current_restore_flags(old_flags, PF_MEMALLOC);
>  }
>  
> +asmlinkage __visible void __softirq_entry __do_softirq(void)
> +{
> +	handle_softirqs(false);
> +}
> +
>  /**
>   * irq_enter_rcu - Enter an interrupt context with RCU watching
>   */
> @@ -921,7 +925,7 @@ static void run_ksoftirqd(unsigned int cpu)
>  		 * We can safely run softirq on inline stack, as we are not deep
>  		 * in the task stack here.
>  		 */
> -		__do_softirq();
> +		handle_softirqs(true);
>  		ksoftirqd_run_end();
>  		cond_resched();
>  		return;


