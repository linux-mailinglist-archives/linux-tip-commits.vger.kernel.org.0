Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEDD31C8F2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Feb 2021 11:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhBPKkZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 16 Feb 2021 05:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhBPKkW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 16 Feb 2021 05:40:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A43DC061574;
        Tue, 16 Feb 2021 02:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gHDXAw/B+mW6hMmWjHJ5AP1o5rqDQiiLPaGpdzXb7Ok=; b=IrZz0SUU89p9EAXf/KDm2T9Y8B
        02nlaxYtoPnJiHmTETta4Bf3i+3soPeGV8+LZhaWOsoU437IWVJrBaglh6jns+blO4c5SNLHbpnpq
        +7K0zJ0xln6dl30Gx+iKLOLVS3ushnYJ8+O2AuiPgA1AeGN3SAPKLalYqBhI7nZvbbRpjJFCYSOg8
        /GAmeX06NVvF47NAblLMIqQkuiIKE/niIioyYGnGuvFeudJePh9zWYfqpsvjZt1W4JM+Uq0d4tv2E
        I2lzcnfQaaOCQzXpGKqqzM0K6z6yTCYcOQ5yfVtVu4/nZ9GhGnfJLBYLXsFrd0FjOwgZWIzsrkzSY
        KFr7W4FQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lBxkE-00Gkyh-AG; Tue, 16 Feb 2021 10:38:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 482173059DD;
        Tue, 16 Feb 2021 11:38:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2CBB62058AF24; Tue, 16 Feb 2021 11:38:12 +0100 (CET)
Date:   Tue, 16 Feb 2021 11:38:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>, x86@kernel.org
Subject: Re: [tip: sched/core] sched,x86: Allow !PREEMPT_DYNAMIC
Message-ID: <YCuglAA95cDfSoFD@hirez.programming.kicks-ass.net>
References: <YCK1+JyFNxQnWeXK@hirez.programming.kicks-ass.net>
 <161296521143.23325.3662179234825253723.tip-bot2@tip-bot2>
 <20210210141838.GA53130@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210141838.GA53130@lothringen>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Feb 10, 2021 at 03:18:38PM +0100, Frederic Weisbecker wrote:
> Also should we add something like this?

I suppose we can do that, but I'd rather have actual numbers to go with
it, I don't think the trampolines are really that terrible.

> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Wed, 10 Feb 2021 15:11:39 +0100
> Subject: [PATCH] preempt/dynamic: Make PREEMPT_DYNAMIC optional
> 
> In order not to make the small trampoline overhead mandatory for archs
> that support HAVE_STATIC_CALL but not HAVE_STATIC_CALL_INLINE, make
> PREEMPT_DYNAMIC optional.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/Kconfig.preempt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index 416017301660..1fe759677907 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -40,7 +40,6 @@ config PREEMPT
>  	depends on !ARCH_NO_PREEMPT
>  	select PREEMPTION
>  	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
> -	select PREEMPT_DYNAMIC if HAVE_PREEMPT_DYNAMIC
>  	help
>  	  This option reduces the latency of the kernel by making
>  	  all kernel code (that is not executing in a critical section)
> @@ -83,11 +82,13 @@ config PREEMPTION
>         select PREEMPT_COUNT
>  
>  config PREEMPT_DYNAMIC
> -	bool
> +	bool "Override preemption flavour at boot time"
> +	depends on HAVE_PREEMPT_DYNAMIC && PREEMPT
> +	default HAVE_STATIC_CALL_INLINE
>  	help
>  	  This option allows to define the preemption model on the kernel
> -	  command line parameter and thus override the default preemption
> -	  model defined during compile time.
> +	  command line parameter "preempt=" and thus override the default
> +	  preemption model defined during compile time.
>  
>  	  The feature is primarily interesting for Linux distributions which
>  	  provide a pre-built kernel binary to reduce the number of kernel
> @@ -99,3 +100,5 @@ config PREEMPT_DYNAMIC
>  
>  	  Interesting if you want the same pre-built kernel should be used for
>  	  both Server and Desktop workloads.
> +
> +	  Say Y if you have CONFIG_HAVE_STATIC_CALL_INLINE.
> -- 
> 2.25.1
> 
