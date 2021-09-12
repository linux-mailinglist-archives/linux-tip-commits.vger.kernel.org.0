Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD889407B13
	for <lists+linux-tip-commits@lfdr.de>; Sun, 12 Sep 2021 02:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhILA3n (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 11 Sep 2021 20:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhILA3n (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 11 Sep 2021 20:29:43 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E86C061574;
        Sat, 11 Sep 2021 17:28:30 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id q14so6162871ils.5;
        Sat, 11 Sep 2021 17:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5xiwNSUhiYdwk6rYExUUDpp7mhs1HZsvlkk3EZ+BI+k=;
        b=F4qRT91+CJOgCgl84KC+eL5rh32tKQydz8hekJwViOmMUB2S+yzLXjMYdMx1j20z2/
         4oThlafDUSPeIeQQsnh79iSjzBgEw+pFUwVvCIYaenoDPd07ihXZNl9SJw8R+aIV5O/f
         CCQgIhtdd3lvM3fsh7JNIvpISD9cAJu5jBElbP9omNFYIWpwmioFSaJkP7lbyYGv3oFH
         fht6m4b8Pt9jVMFcU8kTg4Kv0lb6LMv3LyyzzPnXhd57XTcbzpxCVAQyC4bz1CQrWM7p
         HzHVrgZ8xdiH/GRp1wbE26EVpgP0Rnkg0wqoBFwq/3j4UpbSmPsIag1YeWm5MH8pL0/v
         4+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5xiwNSUhiYdwk6rYExUUDpp7mhs1HZsvlkk3EZ+BI+k=;
        b=lS3kxEOzNd0ib5jk3Etim9pN+LQBFQh0LrwhJc3UMfvaauBqv5rZVOrfMV/MoQxxgW
         fssVQ3NKzuzFPWnSosScItR8BeIL4Rbk1kQ4Ga/gKuKa4KJJr7qlV2hvkK466T8VnLsf
         0c0DTrrszcfJuqWw42ojzdgdmy8nw/Zbfz/mUdsITMakH4Dd4wDaGU5AbOUoPyg7KSJT
         D7R1J2OP5rovjpU8eMTJ63arGZblvt8TIIrxE8F9Nl2ReHCYfRrwTuzOyP9jwL2nQbtH
         GMeuxz/CtZTkZ57zunTZhUQ94Gq7mfKpTo3GDzhTzsVTD1+mvFUa+ROBDSIVRQ1MBEpS
         x8wg==
X-Gm-Message-State: AOAM531H+6XM0qLbKkdhTHsw/ebrqD2kgto5xaII/4DwEnoPWpmHssob
        2tM7Yg3hLnC7fld4fpmZ7JAoHnyQZp6ilA==
X-Google-Smtp-Source: ABdhPJx+XM3Ui/PlnesOzIZjNW+SbNRQBMrhFE/9V7aHuPwlGKByfm4BASwKmpipAAqAhBGyJen0rQ==
X-Received: by 2002:a92:6f06:: with SMTP id k6mr2986767ilc.116.1631406509611;
        Sat, 11 Sep 2021 17:28:29 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x12sm1727994ill.6.2021.09.11.17.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 17:28:28 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id C447527C0054;
        Sat, 11 Sep 2021 20:28:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 11 Sep 2021 20:28:27 -0400
X-ME-Sender: <xms:qEk9YVFXbqi270kOvNyHplnOcKo4elIjxkKXDNWVPD4PpwK-e2JkqA>
    <xme:qEk9YaUPEN5GCuSNevFVRhRYzMNXfnpq2_jsKLbUvvzQ3R4W3DFa15_hMFoksPMW9
    hwMO9adozeCYb3_LQ>
X-ME-Received: <xmr:qEk9YXI_YXQPLZxl-8Y7mLlJX3eEiEZzy4ZdMbJeTFqX0QqAzNSTns1aul0eBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeggedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:qEk9YbHbY4qWCXcceUbTUszgjBEieU30BKK8oTSMNaZMHIqdnQBWJw>
    <xmx:qEk9YbVUVeWjlF-PC7EaSzC4mgwUzTpGfYIL0B-AoPSo_b30NNNViQ>
    <xmx:qEk9YWNLMt3bAxhMNP_oMhLIOaYPEF6OX1hb7BzNhQxKPpmX93NICw>
    <xmx:q0k9YaZnxlimMPccSnr1cFiKsKqWNE0pxH1J5kaT2rNqRVEJa5B4mVt3os0>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Sep 2021 20:28:24 -0400 (EDT)
Date:   Sun, 12 Sep 2021 08:26:46 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-tip-commits@vger.kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mpe@ellerman.id.au
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <YT1JRhnL6RBqoza5@boqun-archlinux>
References: <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
 <20210909133535.GA9722@willie-the-truck>
 <5412ab37-2979-5717-4951-6a61366df0f2@nvidia.com>
 <20210909180005.GA2230712@paulmck-ThinkPad-P17-Gen-1>
 <YTtpnZuSId9yDUjB@boqun-archlinux>
 <20210910163632.GC39858@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910163632.GC39858@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Sep 10, 2021 at 12:36:32PM -0400, Alan Stern wrote:
> On Fri, Sep 10, 2021 at 10:20:13PM +0800, Boqun Feng wrote:
> > On Thu, Sep 09, 2021 at 11:00:05AM -0700, Paul E. McKenney wrote:
> > [...]
> > > 
> > > Boqun, I vaguely remember a suggested change from you along these lines,
> > > but now I cannot find it.  Could you please send it as a formal patch
> > > if you have not already done so or point me at it if you have?
> > > 
> > 
> > Here is a draft patch based on the change I did when I discussed with
> > Peter, and I really want to hear Alan's thought first. Ideally, we
> > should also have related litmus tests and send to linux-arch list so
> > that we know the ordering is provided by every architecture.
> > 
> > Regards,
> > Boqun
> > 
> > --------------------------------->8
> > Subject: [PATCH] tools/memory-model: Provide extra ordering for
> >  lock-{release,acquire} on the same CPU
> > 
> > A recent discussion[1] shows that we are in favor of strengthening the
> > ordering of lock-release + lock-acquire on the same CPU: a lock-release
> > and a po-after lock-acquire should provide the so-called RCtso ordering,
> > that is a memory access S po-before the lock-release should be ordered
> > against a memory access R po-after the lock-acquire, unless S is a store
> > and R is a load.
> > 
> > The strengthening meets programmers' expection that "sequence of two
> > locked regions to be ordered wrt each other" (from Linus), and can
> > reduce the mental burden when using locks. Therefore add it in LKMM.
> > 
> > [1]: https://lore.kernel.org/lkml/20210909185937.GA12379@rowland.harvard.edu/
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> 
> The change to linux-kernel.cat looks fine.  However, I didn't like your 
> update to explanation.txt.  Instead I wrote my own, given below.
> 

Thanks. Indeed your changes of explanation is better.

> I also wrote a couple of litmus tests which Paul can add to the 
> appropriate archive.  They are attached to this email.  As expected, 
> they fail (result Sometimes) with the current LKMM and succeed (Never) 
> with Boqun's updated model.
> 

Appreciate it, I will put together your change to explanation.txt (with
the typo fixed), my change to cat file and the litmus tests, and send
a proper patch next Monday.

Regards,
Boqun

> Alan
> 
> 
> --- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
> +++ usb-devel/tools/memory-model/Documentation/explanation.txt
> @@ -1813,15 +1813,16 @@ spin_trylock() -- we can call these thin
>  lock-acquires -- have two properties beyond those of ordinary releases
>  and acquires.
>  
> -First, when a lock-acquire reads from a lock-release, the LKMM
> -requires that every instruction po-before the lock-release must
> -execute before any instruction po-after the lock-acquire.  This would
> -naturally hold if the release and acquire operations were on different
> -CPUs, but the LKMM says it holds even when they are on the same CPU.
> -For example:
> +First, when a lock-acquire reads from or is po-after a lock-release,
> +the LKMM requires that every instruction po-before the lock-release
> +must execute before any instruction po-after the lock-acquire.  This
> +would naturally hold if the release and acquire operations were on
> +different CPUs and accessed the same lock variable, but the LKMM says
> +it also holds when they are on the same CPU, even if they access
> +different lock variables.  For example:
>  
>  	int x, y;
> -	spinlock_t s;
> +	spinlock_t s, t;
>  
>  	P0()
>  	{
> @@ -1830,9 +1831,9 @@ For example:
>  		spin_lock(&s);
>  		r1 = READ_ONCE(x);
>  		spin_unlock(&s);
> -		spin_lock(&s);
> +		spin_lock(&t);
>  		r2 = READ_ONCE(y);
> -		spin_unlock(&s);
> +		spin_unlock(&t);
>  	}
>  
>  	P1()
> @@ -1842,10 +1843,10 @@ For example:
>  		WRITE_ONCE(x, 1);
>  	}
>  
> -Here the second spin_lock() reads from the first spin_unlock(), and
> -therefore the load of x must execute before the load of y.  Thus we
> -cannot have r1 = 1 and r2 = 0 at the end (this is an instance of the
> -MP pattern).
> +Here the second spin_lock() is po-after the first spin_unlock(), and
> +therefore the load of x must execute before the load of y, even tbough
> +the two locking operations use different locks.  Thus we cannot have
> +r1 = 1 and r2 = 0 at the end (this is an instance of the MP pattern).
>  
>  This requirement does not apply to ordinary release and acquire
>  fences, only to lock-related operations.  For instance, suppose P0()
> @@ -1872,13 +1873,13 @@ instructions in the following order:
>  
>  and thus it could load y before x, obtaining r2 = 0 and r1 = 1.
>  
> -Second, when a lock-acquire reads from a lock-release, and some other
> -stores W and W' occur po-before the lock-release and po-after the
> -lock-acquire respectively, the LKMM requires that W must propagate to
> -each CPU before W' does.  For example, consider:
> +Second, when a lock-acquire reads from or is po-after a lock-release,
> +and some other stores W and W' occur po-before the lock-release and
> +po-after the lock-acquire respectively, the LKMM requires that W must
> +propagate to each CPU before W' does.  For example, consider:
>  
>  	int x, y;
> -	spinlock_t x;
> +	spinlock_t s;
>  
>  	P0()
>  	{
> @@ -1908,7 +1909,12 @@ each CPU before W' does.  For example, c
>  
>  If r1 = 1 at the end then the spin_lock() in P1 must have read from
>  the spin_unlock() in P0.  Hence the store to x must propagate to P2
> -before the store to y does, so we cannot have r2 = 1 and r3 = 0.
> +before the store to y does, so we cannot have r2 = 1 and r3 = 0.  But
> +if P1 had used a lock variable different from s, the writes could have
> +propagated in either order.  (On the other hand, if the code in P0 and
> +P1 had all executed on a single CPU, as in the example before this
> +one, then the writes would have propagated in order even if the two
> +critical sections used different lock variables.)
>  
>  These two special requirements for lock-release and lock-acquire do
>  not arise from the operational model.  Nevertheless, kernel developers
> 

> C ullk-rw
> 
> (*
>  * Result: Never
>  *
>  * If two locked critical sections execute on the same CPU, all accesses
>  * in the first must execute before any accesses in the second, even if
>  * the critical sections are protected by different locks.
>  *)
> 
> {}
> 
> P0(spinlock_t *s, spinlock_t *t, int *x, int *y)
> {
> 	int r1;
> 
> 	spin_lock(s);
> 	r1 = READ_ONCE(*x);
> 	spin_unlock(s);
> 	spin_lock(t);
> 	WRITE_ONCE(*y, 1);
> 	spin_unlock(t);
> }
> 
> P1(int *x, int *y)
> {
> 	int r2;
> 
> 	r2 = smp_load_acquire(y);
> 	WRITE_ONCE(*x, 1);
> }
> 
> exists (0:r1=1 /\ 1:r2=1)

> C ullk-ww
> 
> (*
>  * Result: Never
>  *
>  * If two locked critical sections execute on the same CPU, stores in the
>  * first must propagate to each CPU before stores in the second do, even if
>  * the critical sections are protected by different locks.
>  *)
> 
> {}
> 
> P0(spinlock_t *s, spinlock_t *t, int *x, int *y)
> {
> 	spin_lock(s);
> 	WRITE_ONCE(*x, 1);
> 	spin_unlock(s);
> 	spin_lock(t);
> 	WRITE_ONCE(*y, 1);
> 	spin_unlock(t);
> }
> 
> P1(int *x, int *y)
> {
> 	int r1;
> 	int r2;
> 
> 	r1 = READ_ONCE(*y);
> 	smp_rmb();
> 	r2 = READ_ONCE(*x);
> }
> 
> exists (1:r1=1 /\ 1:r2=0)

