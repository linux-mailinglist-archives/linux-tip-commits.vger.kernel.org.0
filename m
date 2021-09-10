Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16837406976
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Sep 2021 12:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhIJKHL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Sep 2021 06:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhIJKHK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Sep 2021 06:07:10 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF60C061574;
        Fri, 10 Sep 2021 03:06:00 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b200so1560107iof.13;
        Fri, 10 Sep 2021 03:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rm/35qmYxuJ4TnAhR4aEb0K3A6Padg2jSpsikHayYHw=;
        b=CtSuq1MzRwWqWE1h/A7dcyow/3kGnkHQaFMaxMwbrbgowVzHbZSqGW29D7LvVT8Gtj
         t4YfHC/FHc5RmtZ239SaehyeASTeDeSEVjd+3l799twpiYEzIitYnBd6zFFevK8+70cF
         /Ajr+Q90MTY3wmrG+yiRMX9uEYX4Ws5VNy6zqRGRjUBtQTaIxOihaxFrJ1UDbQOzS4bC
         Rrn7HTXcYJDBauN+6mjvqef4Fma4WISBeqa2+nHcCKSEcp5t5klHjsrZo2URyrUNgQNm
         CeJ3CsCkC9w0Qmzl2+4r3fRzZN0ywCXl9u0XNwh9UsstiNDgjsKNDQhK8D2GHacT5ye/
         huvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rm/35qmYxuJ4TnAhR4aEb0K3A6Padg2jSpsikHayYHw=;
        b=130yfq3VNyKk9ropF/O1yUc3yqcR6aySoEgRJW+V7XW4uH7E7uHSzVj1GCjcjqMvpE
         Hz0rNO8W94sWK7Lj+jC0MOgq2VC4MqlLt8v18qal2M0e+dyNosVUWlAkfeeGzehHrV8X
         0S7myIVMDYOV6OCsD7iSs42B+/IALDOH/eui3xTY8H4lCDhxn8GnYhi7iEzM+c497D8g
         iNlNkZtzTmGVM6mPRH2l8mp0FY2hC+fUxRtzO3Z/l6hBWGgWxy0gsDuC8Zt4jkbMeKUd
         xWfNizRt+uO61KyHNQ6cVeW5mTQo2VFGf60I8kD2z4t1y3J+KM816XLducCjkdm4tnEd
         C/zg==
X-Gm-Message-State: AOAM531G/eF2Q8oA1ZbKn3OR02Q1qTR8ljs8kEvgKzaRIic3IIuorXMV
        CC1Ffkb0LHzeuEvxrzIi55U=
X-Google-Smtp-Source: ABdhPJw7up9zgSIu89YD32l6UwzV0PMnmSK/QpwZ38+nAe+4JM66Ik1Dx3mlsN5Wnzyx6R465ZnSNA==
X-Received: by 2002:a05:6602:1346:: with SMTP id i6mr6294305iov.128.1631268359430;
        Fri, 10 Sep 2021 03:05:59 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id f3sm2315494iow.3.2021.09.10.03.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 03:05:58 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id D2DCB27C0054;
        Fri, 10 Sep 2021 06:05:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 10 Sep 2021 06:05:57 -0400
X-ME-Sender: <xms:Ai47YV6f_P4OdYJeyjpy6einXDk1_WG7-fjoNHwuBnuyYcvUfol1qA>
    <xme:Ai47YS5rXD95lbOl_AmQDFeA95yBAPFMrklopPFTt1BoviTrKTxUvWAYnQrOZJfz_
    KbPrLYd_fqjauu6QQ>
X-ME-Received: <xmr:Ai47YcdObazidjJICbxFc16qTEYHWt7QTiulWbewmmaHcn6g7t185Nbuhzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeguddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Ai47YeLAqBWkwcJjXIWCMk2S5GbU9Pv1XAEcUOaxmDpasjwEplvHlg>
    <xmx:Ai47YZLwwN4tMVL4wpwZYYE1oeWAkGntb7RxBEj1VRCEB9Pa0ePSXw>
    <xmx:Ai47YXw2yBMNppjLCa_0ngFUJ0uBtx3JNGKD8leRsQLoluO4oiYKFg>
    <xmx:BS47YR_9buWgufDApJjqR7ZPMTDJZxyENSc1--sR8DSF3pPMhXGII76V6Z4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Sep 2021 06:05:54 -0400 (EDT)
Date:   Fri, 10 Sep 2021 18:04:20 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <YTstpCYfnL9P1sAA@boqun-archlinux>
References: <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
 <20210909133535.GA9722@willie-the-truck>
 <5412ab37-2979-5717-4951-6a61366df0f2@nvidia.com>
 <YTqgSmX57l2hCMk0@boqun-archlinux>
 <YTsmZWGXOKlfgbh9@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTsmZWGXOKlfgbh9@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Sep 10, 2021 at 11:33:25AM +0200, Peter Zijlstra wrote:
> On Fri, Sep 10, 2021 at 08:01:14AM +0800, Boqun Feng wrote:
> > On Thu, Sep 09, 2021 at 01:03:18PM -0400, Dan Lustig wrote:
> > > On 9/9/2021 9:35 AM, Will Deacon wrote:
> > > > On Thu, Sep 09, 2021 at 09:25:30AM +0200, Peter Zijlstra wrote:
> 
> > > >> The AMOSWAP is a RmW and as such matches the W from the RW->W fence,
> > > >> similarly it marches the R from the R->RW fence, yielding an:
> > > >>
> > > >> 	RW->  W
> > > >> 	    RmW
> > > >> 	    R  ->RW
> > > >>
> > > >> ordering. It's the stores S and R that can be re-ordered, but not the
> > > >> sections themselves (same on PowerPC and many others).
> 
> > > I agree with Will here.  If the AMOSWAP above is actually implemented with
> > > a RISC-V AMO, then the two critical sections will be separated as if RW,RW,
> > > as Peter described.  If instead it's implemented using LR/SC, then RISC-V
> > 
> > Just out of curiosity, in the following code, can the store S and load L
> > be reordered?
> > 
> > 	WRITE_ONCE(x, 1); // store S
> > 	FENCE RW, W
> >  	WRITE_ONCE(s.lock, 0); // unlock(s)
> >  	AMOSWAP %0, 1, s.lock  // lock(s)
> > 	FENCE R, RW
> > 	r1 = READ_ONCE(y); // load L
> > 
> > I think they can, because neither "FENCE RW, W" nor "FENCE R, RW" order
> > them.
> 
> I'm confused by your argument, per the above quoted section, those
> fences and the AMO combine into a RW,RW ordering which is (as per the
> later clarification) multi-copy-atomic, aka smp_mb().
>

Right, my question is more about the reasoning about why fence rw,w +
AMO + fence r,rw act as a fence rw,rw. Another related question, can
fence rw,w + store + fence w,rw act as a fence rw,rw by the similar
reasoning? IOW, will the two loads in the following be reordered?

	r1 = READ_ONCE(x);
	FENCE RW, W
	WRITE_ONCE(z, 1);
	FENCE W, RW
	r2 = READ_ONCE(y);

again, this is more like a question out of curiosity, not that I find
this pattern is useful.

Regards,
Boqun

> As such, S and L are not allowed to be re-ordered in the given scenario.
> 
> > Note that the reordering is allowed in LKMM, because unlock-lock
> > only need to be as strong as RCtso.
> 
> Risc-V is strictly stronger than required in this instance. Given the
> current lock implementation. Daniel pointed out that if the atomic op
> were LL/SC based instead of AMO it would end up being RCtso.
> 
