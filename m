Return-Path: <linux-tip-commits+bounces-5921-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1178AE9E3C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 15:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2808188678D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 13:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D042E4274;
	Thu, 26 Jun 2025 13:08:49 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ECB2AD11;
	Thu, 26 Jun 2025 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943329; cv=none; b=Mw4LxIlZN3FOAp7DlI5lyaOna0LEywA7zmyYszCz8uTd6cJ4sJSOISmcs/sG1QFWuPQ3Xm9txvGlc98f/uU78mwFOmDLxkPfgOKhsuFpO59YLHBk4VjzdLcI7kfVlMNtAU6zSi8PRRer6bVbJsbRBeIkddcE6pVT78mOrzukjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943329; c=relaxed/simple;
	bh=M3+W48GBr7ps/RTDpEQhEjapukwGJfycaI+PsS00OH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KT+atmrg/ChS6527FbFWCVLv+pQ/eEkUMUdPMashx+oIQKiAp5RQXy/dYLBzWBuiDTGX8ZyMnpOQBAc5+MV0Ij1ipowZMT3eFg+P9JxhjRj2YslO3MGVAN302tNVTJOxzTxIXS/DSUzQD2Gxh6WffPp27egSxWO8IAaZmbMOFoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bSfC116tMzYQvCR;
	Thu, 26 Jun 2025 21:08:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0F7551A11DE;
	Thu, 26 Jun 2025 21:08:44 +0800 (CST)
Received: from [10.67.108.244] (unknown [10.67.108.244])
	by APP4 (Coremail) with SMTP id gCh0CgBHq19WRl1oAoPgQg--.29022S3;
	Thu, 26 Jun 2025 21:08:40 +0800 (CST)
Message-ID: <3dfe387c-d1db-4cbe-b41d-8f9f27fe3a1f@huaweicloud.com>
Date: Thu, 26 Jun 2025 21:08:38 +0800
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: perf/urgent] perf/core: Fix WARN in perf_cgroup_switch()
Content-Language: en-US
To: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
References: <20250604033924.3914647-3-luogengkun@huaweicloud.com>
 <174963417198.406.3332177110975635135.tip-bot2@tip-bot2>
From: Luo Gengkun <luogengkun@huaweicloud.com>
In-Reply-To: <174963417198.406.3332177110975635135.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHq19WRl1oAoPgQg--.29022S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw48WFy7Ar1DCrW5Zr1UWrg_yoW7GF43pa
	97CrWag398XFy2qay3tw1vva4Svw4FqaykWr13Kw4ayFW5Xrn8JF47Gw45XFn8Zwn7tFyf
	JrZ09r1ak34Uta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/


On 2025/6/11 17:29, tip-bot2 for Luo Gengkun wrote:
> The following commit has been merged into the perf/urgent branch of tip:
>
> Commit-ID:     3172fb986666dfb71bf483b6d3539e1e587fa197
> Gitweb:        https://git.kernel.org/tip/3172fb986666dfb71bf483b6d3539e1e587fa197
> Author:        Luo Gengkun <luogengkun@huaweicloud.com>
> AuthorDate:    Wed, 04 Jun 2025 03:39:24
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 05 Jun 2025 14:37:52 +02:00
>
> perf/core: Fix WARN in perf_cgroup_switch()
>
> There may be concurrency between perf_cgroup_switch and
> perf_cgroup_event_disable. Consider the following scenario: after a new
> perf cgroup event is created on CPU0, the new event may not trigger
> a reprogramming, causing ctx->is_active to be 0. In this case, when CPU1
> disables this perf event, it executes __perf_remove_from_context->
> list _del_event->perf_cgroup_event_disable on CPU1, which causes a race
> with perf_cgroup_switch running on CPU0.
>
> The following describes the details of this concurrency scenario:
>
> CPU0						CPU1
>
> perf_cgroup_switch:
>     ...
>     # cpuctx->cgrp is not NULL here
>     if (READ_ONCE(cpuctx->cgrp) == NULL)
>     	return;
>
> 						perf_remove_from_context:
> 						   ...
> 						   raw_spin_lock_irq(&ctx->lock);
> 						   ...
> 						   # ctx->is_active == 0 because reprogramm is not
> 						   # tigger, so CPU1 can do __perf_remove_from_context
> 						   # for CPU0
> 						   __perf_remove_from_context:
> 						         perf_cgroup_event_disable:
> 							    ...
> 							    if (--ctx->nr_cgroups)
> 							    ...
>
>     # this warning will happened because CPU1 changed
>     # ctx.nr_cgroups to 0.
>     WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
>
> [peterz: use guard instead of goto unlock]
> Fixes: db4a835601b7 ("perf/core: Set cgroup in CPU contexts for new cgroup events")
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20250604033924.3914647-3-luogengkun@huaweicloud.com

Sorry for the late reply, I found that the link is v2 instead of v3.
This v3 link is:

https://lore.kernel.org/all/20250609035316.250557-1-luogengkun@huaweicloud.com/

v2 attempts to fix a concurrency problem between perf_cgroup_switch
and perf_cgroup_event_disable. But it does not to move WARN_ON_ONCE
into lock-protected region, so the warning is still triggered.

The following patches have been tested and fix this issue.

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f746469fda5..a35784d42c66 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -951,8 +951,6 @@ static void perf_cgroup_switch(struct task_struct *task)
         if (READ_ONCE(cpuctx->cgrp) == NULL)
                 return;

-       WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
-
         cgrp = perf_cgroup_from_task(task, NULL);
         if (READ_ONCE(cpuctx->cgrp) == cgrp)
                 return;
@@ -964,6 +962,8 @@ static void perf_cgroup_switch(struct task_struct *task)
         if (READ_ONCE(cpuctx->cgrp) == NULL)
                 return;

+       WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
+
         perf_ctx_disable(&cpuctx->ctx, true);

         ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);

> ---
>   kernel/events/core.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index d786083..d7cf008 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -207,6 +207,19 @@ static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
>   	__perf_ctx_unlock(&cpuctx->ctx);
>   }
>   
> +typedef struct {
> +	struct perf_cpu_context *cpuctx;
> +	struct perf_event_context *ctx;
> +} class_perf_ctx_lock_t;
> +
> +static inline void class_perf_ctx_lock_destructor(class_perf_ctx_lock_t *_T)
> +{ perf_ctx_unlock(_T->cpuctx, _T->ctx); }
> +
> +static inline class_perf_ctx_lock_t
> +class_perf_ctx_lock_constructor(struct perf_cpu_context *cpuctx,
> +				struct perf_event_context *ctx)
> +{ perf_ctx_lock(cpuctx, ctx); return (class_perf_ctx_lock_t){ cpuctx, ctx }; }
> +
>   #define TASK_TOMBSTONE ((void *)-1L)
>   
>   static bool is_kernel_event(struct perf_event *event)
> @@ -944,7 +957,13 @@ static void perf_cgroup_switch(struct task_struct *task)
>   	if (READ_ONCE(cpuctx->cgrp) == cgrp)
>   		return;
>   
> -	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> +	guard(perf_ctx_lock)(cpuctx, cpuctx->task_ctx);
> +	/*
> +	 * Re-check, could've raced vs perf_remove_from_context().
> +	 */
> +	if (READ_ONCE(cpuctx->cgrp) == NULL)
> +		return;
> +
>   	perf_ctx_disable(&cpuctx->ctx, true);
>   
>   	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
> @@ -962,7 +981,6 @@ static void perf_cgroup_switch(struct task_struct *task)
>   	ctx_sched_in(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
>   
>   	perf_ctx_enable(&cpuctx->ctx, true);
> -	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
>   }
>   
>   static int perf_cgroup_ensure_storage(struct perf_event *event,


