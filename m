Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F54406E36
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Sep 2021 17:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbhIJPfC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Sep 2021 11:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbhIJPfC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Sep 2021 11:35:02 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C944CC061756
        for <linux-tip-commits@vger.kernel.org>; Fri, 10 Sep 2021 08:33:50 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id s15so1742445qta.10
        for <linux-tip-commits@vger.kernel.org>; Fri, 10 Sep 2021 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=EWICIH/bq9+JnJ6UbUy8392Y6bG2Wmd0DTEhVvgAdSk=;
        b=RrZz3pmDMkUm2WvqXyeQVkaDx75dgcj9ymJQXb5PlhEEPG2EAPKR2dFWGAGU7Au6Dx
         TI/CsBAdHPunzz8wdXp3ewRkKr0yiO/CjhbvcxyxKpVwztbF3HhybZQCTArPHAo4nv98
         UqZJpTBKmPIB6Rtyeyxnry0F4tn9hAI38OtDjaDCukQXAA+dTvb1z/dFCgk/zHNrzf8S
         H+pyj4rKT3mTIdbxvyOrIal4A6meO/ThftqIOlUE1myNQ+lZNFd2QGX0R/c8YAFiZaqU
         nnpKY2E82Q2pab2qHnE3cCern2KSeJ7UKGj1mIEnSvfeY1T8bYq2uUtPH7/mEPKqwLf/
         JFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=EWICIH/bq9+JnJ6UbUy8392Y6bG2Wmd0DTEhVvgAdSk=;
        b=4hRrO/jonOvGkxfcmAP/z2Q29Vlqqh95UBqTzg0jZAR9jFODp+0QZhZEko7hL9NzC7
         TSOgJ/oQmPaS7mbIra2399pw+3GCmk99EErlu5wcREU78Bm5QI0wbGaoz6YehXbdkwj/
         kCTTrRmK+6zfFgHOCdgO24/84C5vj5v28uI5ycCwRhbyXRUzh3eWY1MO5MPk6jK9SRoi
         Kc9UWxDO7qxZVBx04neovOVcTwZyTGppziKwFy01N/rm9k2EMXN8RE/5hZL1P9UxiZXA
         7QvxRrN/j66ge7vHSQWVbRp09SfTI/y5sSvtgkGKAzI3tzCOZ9qcU01JAdLwf0QSukCo
         478g==
X-Gm-Message-State: AOAM531+xBWgKbB6LByW6QQJGwGzlWe6jQWX7v6Let0kenUjztyBMV7U
        cE0fZeLm+JwWmP2sOMpzQ0aG5g==
X-Google-Smtp-Source: ABdhPJzyQYhHdQGKVKbI/i75l3yvzFJEcnugJidFZIkDTkUZgqF5Z8sJDxShrGNeA4vhOAU8AGHrog==
X-Received: by 2002:ac8:5a08:: with SMTP id n8mr8889673qta.58.1631288029683;
        Fri, 10 Sep 2021 08:33:49 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q18sm3361829qtx.73.2021.09.10.08.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 08:33:49 -0700 (PDT)
Date:   Fri, 10 Sep 2021 08:33:49 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Sep 2021 08:33:43 PDT (-0700)
Subject:     Re: [tip:locking/core] tools/memory-model: Add extra ordering for locks and remove it for ordinary release/acquire
In-Reply-To: <YTtpnZuSId9yDUjB@boqun-archlinux>
CC:     paulmck@kernel.org, Daniel Lustig <dlustig@nvidia.com>,
        will@kernel.org, peterz@infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stern@rowland.harvard.edu, alexander.shishkin@linux.intel.com,
        hpa@zytor.com, parri.andrea@gmail.com, mingo@kernel.org,
        vincent.weaver@maine.edu, tglx@linutronix.de, jolsa@redhat.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, eranian@google.com,
        linux-tip-commits@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, mpe@ellerman.id.au
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     boqun.feng@gmail.com
Message-ID: <mhng-8110fb1f-a92b-454e-8f12-3868a60efcc7@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, 10 Sep 2021 07:20:13 PDT (-0700), boqun.feng@gmail.com wrote:
> On Thu, Sep 09, 2021 at 11:00:05AM -0700, Paul E. McKenney wrote:
> [...]
>>
>> Boqun, I vaguely remember a suggested change from you along these lines,
>> but now I cannot find it.  Could you please send it as a formal patch
>> if you have not already done so or point me at it if you have?
>>
>
> Here is a draft patch based on the change I did when I discussed with
> Peter, and I really want to hear Alan's thought first. Ideally, we
> should also have related litmus tests and send to linux-arch list so
> that we know the ordering is provided by every architecture.
>
> Regards,
> Boqun
>
> --------------------------------->8
> Subject: [PATCH] tools/memory-model: Provide extra ordering for
>  lock-{release,acquire} on the same CPU
>
> A recent discussion[1] shows that we are in favor of strengthening the
> ordering of lock-release + lock-acquire on the same CPU: a lock-release
> and a po-after lock-acquire should provide the so-called RCtso ordering,
> that is a memory access S po-before the lock-release should be ordered
> against a memory access R po-after the lock-acquire, unless S is a store
> and R is a load.
>
> The strengthening meets programmers' expection that "sequence of two
> locked regions to be ordered wrt each other" (from Linus), and can
> reduce the mental burden when using locks. Therefore add it in LKMM.
>
> [1]: https://lore.kernel.org/lkml/20210909185937.GA12379@rowland.harvard.edu/
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  .../Documentation/explanation.txt             | 28 +++++++++++++++++++
>  tools/memory-model/linux-kernel.cat           |  6 ++--
>  2 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index 5d72f3112e56..d62de21f32c4 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -1847,6 +1847,34 @@ therefore the load of x must execute before the load of y.  Thus we
>  cannot have r1 = 1 and r2 = 0 at the end (this is an instance of the
>  MP pattern).
>
> +This requirement also applies to a lock-release and a lock-acquire
> +on different locks, as long as the lock-acquire is po-after the
> +lock-release. Note that "po-after" means the lock-acquire and the
> +lock-release are on the same cpu. An example simliar to the above:
> +
> +	int x, y;
> +	spinlock_t s;
> +	spinlock_t t;
> +
> +	P0()
> +	{
> +		int r1, r2;
> +
> +		spin_lock(&s);
> +		r1 = READ_ONCE(x);
> +		spin_unlock(&s);
> +		spin_lock(&t);
> +		r2 = READ_ONCE(y);
> +		spin_unlock(&t);
> +	}
> +
> +	P1()
> +	{
> +		WRITE_ONCE(y, 1);
> +		smp_wmb();
> +		WRITE_ONCE(x, 1);
> +	}
> +
>  This requirement does not apply to ordinary release and acquire
>  fences, only to lock-related operations.  For instance, suppose P0()
>  in the example had been written as:
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 2a9b4fe4a84e..d70315fddef6 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -27,7 +27,7 @@ include "lock.cat"
>  (* Release Acquire *)
>  let acq-po = [Acquire] ; po ; [M]
>  let po-rel = [M] ; po ; [Release]
> -let po-unlock-rf-lock-po = po ; [UL] ; rf ; [LKR] ; po
> +let po-unlock-lock-po = po ; [UL] ; (po|rf) ; [LKR] ; po
>
>  (* Fences *)
>  let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
> @@ -70,12 +70,12 @@ let rwdep = (dep | ctrl) ; [W]
>  let overwrite = co | fr
>  let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
>  let to-r = addr | (dep ; [Marked] ; rfi)
> -let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
> +let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
>
>  (* Propagation: Ordering from release operations and strong fences. *)
>  let A-cumul(r) = (rfe ; [Marked])? ; r
>  let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
> -	po-unlock-rf-lock-po) ; [Marked]
> +	po-unlock-lock-po) ; [Marked]
>  let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ;
>  	[Marked] ; rfe? ; [Marked]

I'm not a memory model person so I don't really feel comfortable 
reviewing this, but I can follow the non-formal discussion so

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com> # For the RISC-V fallout

So far we've been sticking with the "fastest implementation allowed by 
the spec" mentality, but TBH I think we'd have ended up moving to RCsc 
locks regardless of where LKMM ended up just to be in line with the more 
popular architectures.  With mmiowb gone I think this was the last bit 
of memory model weirdness we'd been carrying around in the RISC-V port, 
so it would have always just been a worry.

We don't really have any hardware to evaluate the performance 
implications of this change, as there are no interestingly aggressive 
implementations of the memory model availiable today.  Like Dan said 
we've got all the ISA mechanisms in place to adequently describe these 
orderings to hardware, so in theory implementations should be able to 
handle this without falling off any performance cliffs.

Happy to take a look and an implementation of this on RISC-V, but if 
nothing arises I'll go sort it out.  It does remind me that we were 
supposed to move over to those generic ticket spinlocks, though...

Thanks!
