Return-Path: <linux-tip-commits+bounces-2080-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1910595668B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Aug 2024 11:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3FD286678
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Aug 2024 09:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBB11586DB;
	Mon, 19 Aug 2024 09:14:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF2F148FE0;
	Mon, 19 Aug 2024 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058884; cv=none; b=qKCEHITrUI8/cJ5W9ri4DRaFvWL/au7gJnhzRlth6DBlxczBaArv3c26p9EnpBNkj4y61pQ+HGZ1Ui9db4aVXQP11weqCElC+Pd7yM4HXO+sFKpH4ycCcCwHsBMQKSCyXTJYT0XK14V3wT2e6eTqKEwWdx2ujKUozoIBhmG+mtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058884; c=relaxed/simple;
	bh=G+wsMecrDCT8FTyXe8LseW45irGqIFo3jAoyDBcJ47w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fx+TO5FzAxDCVaQRvqomutHWyKdDEjkvymjkbVTsA1RlhwtfaguveoOlUiL2tc89b2t3IeAWe0NEarUhXex4qOat/Rvlcsvnlc9mzyvfWs9FZDuShN6eoqKHD+PhgqikcshqARquPrvl/14WuQAYyI2FgJ/x2qKsaomzRaxD1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EF491063;
	Mon, 19 Aug 2024 02:15:07 -0700 (PDT)
Received: from [10.57.49.21] (unknown [10.57.49.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 268883F73B;
	Mon, 19 Aug 2024 02:14:40 -0700 (PDT)
Message-ID: <d52d617f-d5c7-45c8-a543-d3ecade2adf8@arm.com>
Date: Mon, 19 Aug 2024 10:14:38 +0100
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: sched/core] sched/uclamg: Handle delayed dequeue
To: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc: Luis Machado <luis.machado@arm.com>, Hongyan Xia <hongyan.xia2@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org
References: <20240727105029.315205425@infradead.org>
 <172396218984.2215.18280492377096522742.tip-bot2@tip-bot2>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <172396218984.2215.18280492377096522742.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/24 07:23, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     dfa0a574cbc47bfd5f8985f74c8ea003a37fa078
> Gitweb:        https://git.kernel.org/tip/dfa0a574cbc47bfd5f8985f74c8ea003a37fa078
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Wed, 05 Jun 2024 12:09:11 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Sat, 17 Aug 2024 11:06:42 +02:00
> 
> sched/uclamg: Handle delayed dequeue

Nit, but I haven't seen the typo until now.

> 
> Delayed dequeue has tasks sit around on the runqueue that are not
> actually runnable -- specifically, they will be dequeued the moment
> they get picked.
> 
> One side-effect is that such a task can get migrated, which leads to a
> 'nested' dequeue_task() scenario that messes up uclamp if we don't
> take care.
> 
> Notably, dequeue_task(DEQUEUE_SLEEP) can 'fail' and keep the task on
> the runqueue. This however will have removed the task from uclamp --
> per uclamp_rq_dec() in dequeue_task(). So far so good.
> 
> However, if at that point the task gets migrated -- or nice adjusted
> or any of a myriad of operations that does a dequeue-enqueue cycle --
> we'll pass through dequeue_task()/enqueue_task() again. Without
> modification this will lead to a double decrement for uclamp, which is
> wrong.
> 
> Reported-by: Luis Machado <luis.machado@arm.com>
> Reported-by: Hongyan Xia <hongyan.xia2@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> Tested-by: Valentin Schneider <vschneid@redhat.com>
> Link: https://lkml.kernel.org/r/20240727105029.315205425@infradead.org
> ---
>  kernel/sched/core.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7356464..80e639e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1691,6 +1691,9 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>  	if (unlikely(!p->sched_class->uclamp_enabled))
>  		return;
>  
> +	if (p->se.sched_delayed)
> +		return;
> +
>  	for_each_clamp_id(clamp_id)
>  		uclamp_rq_inc_id(rq, p, clamp_id);
>  
> @@ -1715,6 +1718,9 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
>  	if (unlikely(!p->sched_class->uclamp_enabled))
>  		return;
>  
> +	if (p->se.sched_delayed)
> +		return;
> +
>  	for_each_clamp_id(clamp_id)
>  		uclamp_rq_dec_id(rq, p, clamp_id);
>  }
> @@ -1994,8 +2000,12 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>  		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
>  	}
>  
> -	uclamp_rq_inc(rq, p);
>  	p->sched_class->enqueue_task(rq, p, flags);
> +	/*
> +	 * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
> +	 * ->sched_delayed.
> +	 */
> +	uclamp_rq_inc(rq, p);
>  
>  	if (sched_core_enabled(rq))
>  		sched_core_enqueue(rq, p);
> @@ -2017,6 +2027,10 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  		psi_dequeue(p, flags & DEQUEUE_SLEEP);
>  	}
>  
> +	/*
> +	 * Must be before ->dequeue_task() because ->dequeue_task() can 'fail'
> +	 * and mark the task ->sched_delayed.
> +	 */
>  	uclamp_rq_dec(rq, p);
>  	return p->sched_class->dequeue_task(rq, p, flags);
>  }
> 


