Return-Path: <linux-tip-commits+bounces-5922-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C78D6AE9E5B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 15:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB56216558D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 13:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25622E427A;
	Thu, 26 Jun 2025 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YeXEgArP"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112B2E5401;
	Thu, 26 Jun 2025 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943611; cv=none; b=lOYvuDqk66io5LLLZY5nc75WTyvKMLBQ8l0THheplbdnE0tYnAozz8dt6DvflQ0e7aHTTrf3gt66RmulDxYFL9ugxUfOenZXD11VwNdXyvS/4SoNdtHWUyQPYn9riyGwXUPVFK+vlTJp4bKLLg9KyE2GAcPnY4ufgirJ12CSHys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943611; c=relaxed/simple;
	bh=+TaLcRAODzVe1YlprcD13pOkDvDks0vO6YcEcbJ1dps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkbBOqfHMsc1SIgfH7NM2PB1Z03lvgjpXegz60QM/OjqIWqFkLwE4qNZnRLoyWkuIzYORKgjXgCHdlhhYXiZM0VIfOV9NVrGSTfXmta+xB97B/PdqZtXw5h9lpCY9OAGaLXVGopMMVJpeqndVGAoxTpou/5bv6uIZUgZQTCnbSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YeXEgArP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FJiv3Smj87Kb7GmOuhvZBdlqpaeOIoAZg/wJR0QpmlA=; b=YeXEgArPlHozISEO9MsmjOrik1
	m5UBPOskji1ge7P+1V7ma+nsuvRLiU7E1xc8FUhLubsCn9bCKwikpR+Sb/BtQ2eC33qbvIVSMlR6P
	trAx9hdYJXBElF1eQ3GheG/AH15M6rkVWKP/IMHRrGn+7iOpZv90pDyt6/akPXBDnpBiDkyznL6oi
	IBErJGCkyhchDnxsabogpFssadfSy6ArShZRCdywu7NoNmbTXDquJYent3zh9tQb9wDDlirAi74O9
	Sjqxb8iK6yrbZBuSbmyAAtsZ7UUl7aF1HmajWElnhZXLN/zMucZeKq/HGsFzxdPutvSsxU+EpRneV
	3dGdxgcQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUmPv-0000000BhGi-1M1C;
	Thu, 26 Jun 2025 13:13:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D81B530BDDA; Thu, 26 Jun 2025 15:13:26 +0200 (CEST)
Date: Thu, 26 Jun 2025 15:13:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: perf/urgent] perf/core: Fix WARN in perf_cgroup_switch()
Message-ID: <20250626131326.GH1613200@noisy.programming.kicks-ass.net>
References: <20250604033924.3914647-3-luogengkun@huaweicloud.com>
 <174963417198.406.3332177110975635135.tip-bot2@tip-bot2>
 <3dfe387c-d1db-4cbe-b41d-8f9f27fe3a1f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dfe387c-d1db-4cbe-b41d-8f9f27fe3a1f@huaweicloud.com>

On Thu, Jun 26, 2025 at 09:08:38PM +0800, Luo Gengkun wrote:

> Sorry for the late reply, I found that the link is v2 instead of v3.
> This v3 link is:
> 
> https://lore.kernel.org/all/20250609035316.250557-1-luogengkun@huaweicloud.com/
> 
> v2 attempts to fix a concurrency problem between perf_cgroup_switch
> and perf_cgroup_event_disable. But it does not to move WARN_ON_ONCE
> into lock-protected region, so the warning is still triggered.
> 
> The following patches have been tested and fix this issue.
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1f746469fda5..a35784d42c66 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -951,8 +951,6 @@ static void perf_cgroup_switch(struct task_struct *task)
>         if (READ_ONCE(cpuctx->cgrp) == NULL)
>                 return;
> 
> -       WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
> -
>         cgrp = perf_cgroup_from_task(task, NULL);
>         if (READ_ONCE(cpuctx->cgrp) == cgrp)
>                 return;
> @@ -964,6 +962,8 @@ static void perf_cgroup_switch(struct task_struct *task)
>         if (READ_ONCE(cpuctx->cgrp) == NULL)
>                 return;
> 
> +       WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
> +
>         perf_ctx_disable(&cpuctx->ctx, true);
> 
>         ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);

Can you send as a full new patch, the thing is already in Linus' tree.

