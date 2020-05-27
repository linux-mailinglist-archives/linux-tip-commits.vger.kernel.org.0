Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB671E3483
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 May 2020 03:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgE0BOR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 May 2020 21:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgE0BOP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 May 2020 21:14:15 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8E9C061A0F
        for <linux-tip-commits@vger.kernel.org>; Tue, 26 May 2020 18:14:14 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h9so7722518qtj.7
        for <linux-tip-commits@vger.kernel.org>; Tue, 26 May 2020 18:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NHzMNH28y/GXSoFOf1/NF/R2VMPDvKZxUdmkO5KBgxY=;
        b=jJTXjPkgJLHrf2hO4j4PKGAsQ+OKm/7kMeoo0TXPZvOfXHeldzfY1lXSh+NwiaxTOw
         ZKnc3V5UK9RskJaNiNhRroqXlInFVKOAbJ9njNeGK1woyD/fhwy2Lh2BzGuO3QqBKS49
         Y6UzSbGFQwu17utdr39lsGrhkGKF4xP4O6twY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NHzMNH28y/GXSoFOf1/NF/R2VMPDvKZxUdmkO5KBgxY=;
        b=YDVle2n/Ki0aSDRG58k/R7XgHKi3lV6TEvP+SrIbvwQQ7zcZYD6SNAG/2iqdL5I4Pk
         kQ0lS9zDx20c453cU+Jp0ffGgNg6d844g7SePOxnUwBczHFstmAlXNk4VYUr3kkU1fmB
         3270hRPtE1autOseTCW7R2fo0ETanWepIpG+GrxvMZd3p8s9Y5E6FMcoTJQFYl6DwLzi
         2GT4NOa+iWc0Gi4IyIqkZe6lmgzs6rs+BNC4QLE4MG+HvskHZoLjMWys5DQ2Ke/FGYn3
         v6MSXJUO9/n8z1KlHALEHQfXy/xy2X5ya9/MjaSe/yc6EonKdcVmjaxsLLvjzQ5A/ASg
         nmVw==
X-Gm-Message-State: AOAM532AkbX5UHAKDH71KiHIGiNrbT1idq4dsukzJ/pYQPynqiyvUETh
        KblqWTo0Q/+8abrubNJAjQ593Q==
X-Google-Smtp-Source: ABdhPJzpw4hOd5QOy5LX+F5XNYCN3BpbdALQEeniFIPQEU07Dr5VpM/Wwp+pQNuQicgRtYfXDVz0Tw==
X-Received: by 2002:ac8:7b4c:: with SMTP id m12mr1627606qtu.97.1590542054136;
        Tue, 26 May 2020 18:14:14 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o144sm1075774qke.126.2020.05.26.18.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 18:14:13 -0700 (PDT)
Date:   Tue, 26 May 2020 21:14:13 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-tip-commits@vger.kernel.org, x86 <x86@kernel.org>
Subject: Re: [PATCH] rcu/performance: Fix kfree_perf_init() build warning on
 32-bit kernels
Message-ID: <20200527011413.GD149611@google.com>
References: <158923078019.390.12609597570329519463.tip-bot2@tip-bot2>
 <20200526182744.GA3722128@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200526182744.GA3722128@gmail.com>
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, May 26, 2020 at 08:27:44PM +0200, Ingo Molnar wrote:
[...]
> ./include/linux/kern_levels.h:5:18: warning: format ‘%lu’ expects argument
> of type ‘long unsigned int’, but argument 2 has type ‘unsigned int’
> [-Wformat=] 5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */ |
> ^~~~~~
> ./include/linux/kern_levels.h:9:20: note: in expansion of macro ‘KERN_SOH’
>     9 | #define KERN_ALERT KERN_SOH "1" /* action must be taken immediately */
>       |                    ^~~~~~~~
> ./include/linux/printk.h:295:9: note: in expansion of macro ‘KERN_ALERT’
>   295 |  printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
>       |         ^~~~~~~~~~
> kernel/rcu/rcuperf.c:726:2: note: in expansion of macro ‘pr_alert’
>   726 |  pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
>       |  ^~~~~~~~
> kernel/rcu/rcuperf.c:726:32: note: format string is defined here
>   726 |  pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
>       |                              ~~^
>       |                                |
>       |                                long unsigned int
>       |                              %u
> 
> 
> The reason for the warning is that both kfree_mult and sizeof() are 
> 'int' types on 32-bit kernels, while the format string expects a long.
> 
> Instead of casting the type to long or tweaking the format string, the 
> most straightforward solution is to upgrade kfree_mult to a long. 
> Since this depends on CONFIG_RCU_PERF_TEST

Thanks for fixing it.

> BTW., could we please also rename this code from 'PERF_TEST'/'perf test'
> to 'PERFORMANCE_TEST'/'performance test'? At first glance I always
> mistakenly believe that it's somehow related to perf, while it isn't. =B-)

Would it be better to call it 'RCUPERF_TEST' instead of the
'RCU_PERFORMANCE_TEST' you are proposing? I feel the word 'PERFORMANCE' is
too long.  Also, 'rcuperf test' instead of the 'rcu performance test' you are
proposing.  I am Ok with doing it however you and Paul want it though, let me
know.

Paul, should I send you a renaming patch for the new performance tests as
well (which I believe should be in the -dev branch).

thanks,

 - Joel


> 
> Thanks,
> 
> 	Ingo
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
>  kernel/rcu/rcuperf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index 16dd1e6b7c09..221a0a3810e4 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -88,7 +88,7 @@ torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
>  torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
>  torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
>  torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() perf test?");
> -torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
> +torture_param(long, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
>  
>  static char *perf_type = "rcu";
>  module_param(perf_type, charp, 0444);
