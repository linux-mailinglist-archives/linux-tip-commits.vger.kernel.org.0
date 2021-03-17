Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E741533F75E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 18:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhCQRqG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 13:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbhCQRpl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 13:45:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0774AC06174A;
        Wed, 17 Mar 2021 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A2FtYHm1/WgaQlEuzToT6dfW4PtI9zS/+POuKxKvN7w=; b=bTeil9/Cl6vMIs4vkOmuiKUIzi
        iXyRwv2x3/mGFMgYjfMwBnFaHy+fpx6fESiRDmvTeN/g7Pf+HgVbeB1TUmjviwdYHwDbuqFs4VWMn
        UkbczNfJsvPr8BaUnoWKt19y1qQULzdWmQd5AZlcsTtjTwSIZEE+qRr4s54dJ0y06GAu0qPlOpO30
        AWG/SCs+DNXErLJlX1FksIhC8RihyxQnPDmGLC7SV5qr0r2QPoxFLJlCvNERm+qLH97nIq77bT7Vi
        wTQcyUYOJqfGNyCUkmK5hhvyT/iezoQqIdxrtSmUV0P+8TiuKcEkbyMF6zX/uZD9odoD4gpnAYl+P
        VZCvo7hA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMaEi-003gwd-4H; Wed, 17 Mar 2021 17:45:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B9B79305C22;
        Wed, 17 Mar 2021 18:45:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC581203D90CA; Wed, 17 Mar 2021 18:45:35 +0100 (CET)
Date:   Wed, 17 Mar 2021 18:45:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: locking/urgent] locking/ww_mutex: Treat ww_mutex_lock()
 like a trylock
Message-ID: <YFJAP8x917Ef0Khj@hirez.programming.kicks-ass.net>
References: <20210316153119.13802-4-longman@redhat.com>
 <161598470197.398.8903908266426306140.tip-bot2@tip-bot2>
 <YFIASRkXowQWgj2s@hirez.programming.kicks-ass.net>
 <YFIEo8IVQ/Mm9jUE@hirez.programming.kicks-ass.net>
 <e1bcd7fb-3a40-f207-ee19-d276c8b8bb75@redhat.com>
 <e39f4e37-e3c0-e62a-7062-fdd2c8b3d3b9@redhat.com>
 <YFIy8Bzj7WAHFmlG@hirez.programming.kicks-ass.net>
 <YFI/C4VZuWjyHLNK@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFI/C4VZuWjyHLNK@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Mar 17, 2021 at 06:40:27PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 17, 2021 at 05:48:48PM +0100, Peter Zijlstra wrote:
> 
> > I think you'll find that if you use ww_mutex_init() it'll all work. Let
> > me go and zap this patch, and then I'll try and figure out why
> > DEFINE_WW_MUTEX() is buggered.
> 
> Moo, I can't get the compiler to do as I want :/
> 
> The below is so close but doesn't actually compile.. Maybe we should
> just give up on DEFINE_WW_MUTEX and simply remove it.
> 
> ---
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index 0cd631a19727..85f50538f26a 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -129,12 +129,15 @@ do {									\
>  # define __DEP_MAP_MUTEX_INITIALIZER(lockname)
>  #endif
>  
> -#define __MUTEX_INITIALIZER(lockname) \
> +#define ___MUTEX_INITIALIZER(lockname, depmap) \
>  		{ .owner = ATOMIC_LONG_INIT(0) \
>  		, .wait_lock = __SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
>  		, .wait_list = LIST_HEAD_INIT(lockname.wait_list) \
>  		__DEBUG_MUTEX_INITIALIZER(lockname) \
> -		__DEP_MAP_MUTEX_INITIALIZER(lockname) }
> +		depmap }
> +
> +#define __MUTEX_INITIALIZER(lockname) \
> +		___MUTEX_INITIALIZER(lockname, __DEP_MAP_MUTEX_INITIALIZER(lockname))
>  
>  #define DEFINE_MUTEX(mutexname) \
>  	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
> diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
> index 6ecf2a0220db..c62a030652b4 100644
> --- a/include/linux/ww_mutex.h
> +++ b/include/linux/ww_mutex.h
> @@ -50,9 +50,17 @@ struct ww_acquire_ctx {
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  # define __WW_CLASS_MUTEX_INITIALIZER(lockname, class) \
> -		, .ww_class = class
> +		, .ww_class = &(class)
> +
> +# define __DEP_MAP_WW_MUTEX_INITIALIZER(lockname, class) \
> +		, .dep_map = { \
> +			.key = &(class).mutex_key, \
> +			.name = (class).mutex_name, \

			,name = #class "_mutex", \

and it 'works', but shees!

> +			.wait_type_inner = LD_WAIT_SLEEP, \
> +		}
>  #else
>  # define __WW_CLASS_MUTEX_INITIALIZER(lockname, class)
> +# define __DEP_MAP_WW_MUTEX_INITIALIZER(lockname, class)
>  #endif
>  
>  #define __WW_CLASS_INITIALIZER(ww_class, _is_wait_die)	    \
> @@ -62,7 +70,8 @@ struct ww_acquire_ctx {
>  		, .is_wait_die = _is_wait_die }
>  
>  #define __WW_MUTEX_INITIALIZER(lockname, class) \
> -		{ .base =  __MUTEX_INITIALIZER(lockname.base) \
> +		{ .base =  ___MUTEX_INITIALIZER(lockname.base, \
> +			__DEP_MAP_WW_MUTEX_INITIALIZER(lockname.base, class)) \
>  		__WW_CLASS_MUTEX_INITIALIZER(lockname, class) }
>  
>  #define DEFINE_WD_CLASS(classname) \
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index 0ab94e1f1276..e8305233eb0b 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -358,9 +358,9 @@ static struct lock_torture_ops mutex_lock_ops = {
>  
>  #include <linux/ww_mutex.h>
>  static DEFINE_WD_CLASS(torture_ww_class);
> -static DEFINE_WW_MUTEX(torture_ww_mutex_0, &torture_ww_class);
> -static DEFINE_WW_MUTEX(torture_ww_mutex_1, &torture_ww_class);
> -static DEFINE_WW_MUTEX(torture_ww_mutex_2, &torture_ww_class);
> +static DEFINE_WW_MUTEX(torture_ww_mutex_0, torture_ww_class);
> +static DEFINE_WW_MUTEX(torture_ww_mutex_1, torture_ww_class);
> +static DEFINE_WW_MUTEX(torture_ww_mutex_2, torture_ww_class);
>  
>  static int torture_ww_mutex_lock(void)
>  __acquires(torture_ww_mutex_0)
