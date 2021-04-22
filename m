Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A532367C18
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Apr 2021 10:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbhDVIQK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Apr 2021 04:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbhDVIQJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Apr 2021 04:16:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC284C06174A;
        Thu, 22 Apr 2021 01:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PWr7R1dU9cuwPOC+nwH35454h9m94YSv8+YAHyiC65Q=; b=V+YlHuy8JS8dlfw5WsGflbrZD8
        35lo6lNadOU7tQptPY7vYjaUfDwI6X8KwBN5MAXd+CwN93sicyEHiRX6cqnKyGzXEbIXYl1DzUSsO
        B32pGFzQi7JSVOHkIP5a5igROlJHAANLnVkhJKD4hM0h6/0XLS0buxcnBbFt+nWrqOKVarQg7FMkj
        Y3wQcTOJm0UdBBqNTzIqEqy/kdeErLZbefMhHjJYsbciAHiwJr+SQnOYlNTydebWhXCAt7uGlCYW1
        JOYfV72Y/5g8m2kn4iNVNYuWAVz+XCKZPnoy0n/xf/YX9Dqi7ott3NOSBm1XkHye9MQSJMQf/SE0x
        91j2NHJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZUUi-00GDuz-4o; Thu, 22 Apr 2021 08:15:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 029B93001E2;
        Thu, 22 Apr 2021 10:15:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D34932BE658B2; Thu, 22 Apr 2021 10:15:26 +0200 (CEST)
Date:   Thu, 22 Apr 2021 10:15:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        x86@kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [tip: sched/core] sched,fair: skip newidle_balance if a wakeup
 is pending
Message-ID: <YIEwnnhG9bFkPqQs@hirez.programming.kicks-ass.net>
References: <20210420120705.5c705d4b@imladris.surriel.com>
 <161907696062.29796.108437696048031441.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161907696062.29796.108437696048031441.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Apr 22, 2021 at 07:36:00AM -0000, tip-bot2 for Rik van Riel wrote:
> @@ -10684,7 +10693,12 @@ out:
>  	if (time_after(this_rq->next_balance, next_balance))
>  		this_rq->next_balance = next_balance;
>  
> -	if (pulled_task)
> +	/*
> +	 * If we are no longer idle, do not let the time spent here pull
> +	 * down this_rq->avg_idle. That could lead to newidle_balance not
> +	 * doing enough work, and the CPU actually going idle.
> +	 */
> +	if (pulled_task || this_rq->ttwu_pending)
>  		this_rq->idle_stamp = 0;

I've un-committed this patch, because vingu was reporting increased idle
time because of this hunk.  I had mistakenly assumed that was sorted
with v3, sorry for not keeping better track of things.

(also, now that I look again, please also fix the Subject to have a
capital after the :)


