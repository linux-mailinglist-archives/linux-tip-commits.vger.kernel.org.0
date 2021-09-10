Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2EC406D70
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Sep 2021 16:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhIJOSU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Sep 2021 10:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbhIJOSU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Sep 2021 10:18:20 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F07C061574;
        Fri, 10 Sep 2021 07:17:09 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id q3so2510549iot.3;
        Fri, 10 Sep 2021 07:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+sFLMZElAVHc/wW7dKbFnODg1P6YHS1rZdYgRGnxqS0=;
        b=Qft7R5rG2nvgGRq3853xAqNE830wk0LN97/l7kmrjYH3QSgMA1lM5yhlDCDt9KQFt2
         L4X2RNZre6WcHt7vDtM8cNHcJ5ArCyNxj8/pA+dTPaxlrW+lw6lo4PGMqY9zg04zp3gm
         0GDlTScCyTMf4cx426ZHkzXTd3Nrl1n3jfywUULts7S97I6TZNvNVOFTFQr9Pj3Ty8bo
         h8SGwswT8GP/B3Nl09DUbc5Xv38I/r+Sn7+IAO9I1OC6sF3bp+ni3oKPb8n/R0tMUoro
         pwDrMtc6l0UsV517ErDebCx8SYZFA8/PeQWPN6VM0/JcryamzzGkgDkoG9aA+Egbnldq
         PA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+sFLMZElAVHc/wW7dKbFnODg1P6YHS1rZdYgRGnxqS0=;
        b=A4Z+D761d/pStIXMI3D0qDfkuAaBKW9lTjX2v2pfJfPSNxqJ6V1z1CD+Sq4yGRHBZK
         VzytDZ3CXybrbzvRPZAorTPw0V/AWWYW4/xei4Qf+s/P1L0vHkIa8oAHGfmGb0XNSYmj
         ghmbBI9LGNRKEC5G97OQvgEG5DC1MpVj/MVj9LZDZevHXGOTFx9OEfZDqaaXq1o+BQzh
         7s/HmCCpFvrXC5N7sX7o4G0SLT02XMyAao8qwmW7bcUuTAgKVo60ITrSBqoy1QOWsPtM
         afJUWbnWI2EJjEpegkajUeBLwaM/wIPfMRPeHRMIO0hN5HPdhXg/kJWUCmF0b0eDK1Ni
         r63g==
X-Gm-Message-State: AOAM533+VJqHwjZM4lEj6IjKu9G4nQ7chTay1Jo3mE8VD+RJjjKXwzx3
        SUyfCl5fXxOe/0m9Q8P3HJA=
X-Google-Smtp-Source: ABdhPJzeCxfGxPrZUPLfvozxZ0shyhheF4J55KmxyhyGARd6ssgztvdemEa7XhocaMXlO9AHzEmghg==
X-Received: by 2002:a6b:2b43:: with SMTP id r64mr7070754ior.187.1631283428903;
        Fri, 10 Sep 2021 07:17:08 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id s18sm2679699iov.53.2021.09.10.07.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:17:08 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5C5AF27C0054;
        Fri, 10 Sep 2021 10:17:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 10 Sep 2021 10:17:07 -0400
X-ME-Sender: <xms:4Gg7YUu3qodJvuVwXahBFi-cyeIKLd2NCvLbjMSz8PXGybx2AsYFmg>
    <xme:4Gg7YReJd29j4_DE5rO0f-0VxYzi81e8xQBbsXCGLgsr7hgbGr5rVnhKc5vUu47oU
    vXeNftoeGKt7p5nUg>
X-ME-Received: <xmr:4Gg7YfxgpCUqQde-GLG4hT-v57Ei4i5wCmdSY9P0ttsJBcx2wThIuPPmtCT3OQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeguddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:4Gg7YXMfU-tuLy52oXdYRJmGpYumR5JGQEa-lJpk5Yf9DKEQ_RB51A>
    <xmx:4Gg7YU967dQJQOx8sdTnvawrEfeS543qLRN4lQaCUq1HIYbJ841j7g>
    <xmx:4Gg7YfWpusiEdG4g735ay0cGgGhV79vupRkG1chEyO6jXxCPbNcNjw>
    <xmx:4mg7YfiezmjYkfU1QNLCoRh4maX8DW3rqmeADZG4rdkgkE2NRFjYfg5kW3A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Sep 2021 10:17:04 -0400 (EDT)
Date:   Fri, 10 Sep 2021 22:15:30 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Dan Lustig <dlustig@nvidia.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
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
Message-ID: <YTtognqVF6UCHQ/7@boqun-archlinux>
References: <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
 <20210909133535.GA9722@willie-the-truck>
 <5412ab37-2979-5717-4951-6a61366df0f2@nvidia.com>
 <YTqgSmX57l2hCMk0@boqun-archlinux>
 <YTsmZWGXOKlfgbh9@hirez.programming.kicks-ass.net>
 <YTstpCYfnL9P1sAA@boqun-archlinux>
 <20a453f3-9b1f-20ab-880b-1018b2e11664@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20a453f3-9b1f-20ab-880b-1018b2e11664@nvidia.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Sep 10, 2021 at 09:48:55AM -0400, Dan Lustig wrote:
> On 9/10/2021 6:04 AM, Boqun Feng wrote:
> > On Fri, Sep 10, 2021 at 11:33:25AM +0200, Peter Zijlstra wrote:
> >> On Fri, Sep 10, 2021 at 08:01:14AM +0800, Boqun Feng wrote:
> >>> On Thu, Sep 09, 2021 at 01:03:18PM -0400, Dan Lustig wrote:
> >>>> On 9/9/2021 9:35 AM, Will Deacon wrote:
> >>>>> On Thu, Sep 09, 2021 at 09:25:30AM +0200, Peter Zijlstra wrote:
> >>
> >>>>>> The AMOSWAP is a RmW and as such matches the W from the RW->W fence,
> >>>>>> similarly it marches the R from the R->RW fence, yielding an:
> >>>>>>
> >>>>>> 	RW->  W
> >>>>>> 	    RmW
> >>>>>> 	    R  ->RW
> >>>>>>
> >>>>>> ordering. It's the stores S and R that can be re-ordered, but not the
> >>>>>> sections themselves (same on PowerPC and many others).
> >>
> >>>> I agree with Will here.  If the AMOSWAP above is actually implemented with
> >>>> a RISC-V AMO, then the two critical sections will be separated as if RW,RW,
> >>>> as Peter described.  If instead it's implemented using LR/SC, then RISC-V
> >>>
> >>> Just out of curiosity, in the following code, can the store S and load L
> >>> be reordered?
> >>>
> >>> 	WRITE_ONCE(x, 1); // store S
> >>> 	FENCE RW, W
> >>>  	WRITE_ONCE(s.lock, 0); // unlock(s)
> >>>  	AMOSWAP %0, 1, s.lock  // lock(s)
> >>> 	FENCE R, RW
> >>> 	r1 = READ_ONCE(y); // load L
> >>>
> >>> I think they can, because neither "FENCE RW, W" nor "FENCE R, RW" order
> >>> them.
> >>
> >> I'm confused by your argument, per the above quoted section, those
> >> fences and the AMO combine into a RW,RW ordering which is (as per the
> >> later clarification) multi-copy-atomic, aka smp_mb().
> >>
> > 
> > Right, my question is more about the reasoning about why fence rw,w +
> > AMO + fence r,rw act as a fence rw,rw.
> 
> Is this a RISC-V question?  If so, it's as simple as:

Yep, and thanks for the answer.

> 1) S and anything earlier are ordered before the AMO by the first fence
> 2) L and anything later are ordered after the AMO by the second fence
> 3) 1 + 2 = S and anything earlier are ordered before L or anything later
> 
> Since RISC-V is multi-copy atomic, so 1+2 just naturally compose
> transitively.
> 
> > Another related question, can
> > fence rw,w + store + fence w,rw act as a fence rw,rw by the similar
> > reasoning? IOW, will the two loads in the following be reordered?
> > 
> > 	r1 = READ_ONCE(x);
> > 	FENCE RW, W
> > 	WRITE_ONCE(z, 1);
> > 	FENCE W, RW
> > 	r2 = READ_ONCE(y);
> > 
> > again, this is more like a question out of curiosity, not that I find
> > this pattern is useful.
> 
> Does FENCE W,RW appear in some actual use case?  But yes, if it does

I'm not aware of any, but probably because no other arch can order
write->read without a full barrier (or release+acquire if RCsc), we have
a few patterns in kernel where we only want to order write->read, and
smp_mb()s are used, if on RISCV FENCE W,R is cheaper than FENCE RW,RW,
then *in theory* we can have smp_wrmb() implemented as FENCE W,R on
RISCV and smp_mb() on other archs.

/me run

And I'm sure there are cases that we use smp_mb() where only
write->{read,write} is supposed to be ordered, so there may be use case
by the same reason.

I'm not proposing doing anything, just saying we don't use FENCE W,RW
because there is no equilavent concept in other archs, so it's not
modeled by an API. Besides, it may not be cheaper than FENCE RW,RW on
RISCV.

Regards,
Boqun

> appear, this sequence would also act as a FENCE RW,RW on RISC-V.
> 
> Dan
> 
> > Regards,
> > Boqun
> > 
> >> As such, S and L are not allowed to be re-ordered in the given scenario.
> >>
> >>> Note that the reordering is allowed in LKMM, because unlock-lock
> >>> only need to be as strong as RCtso.
> >>
> >> Risc-V is strictly stronger than required in this instance. Given the
> >> current lock implementation. Daniel pointed out that if the atomic op
> >> were LL/SC based instead of AMO it would end up being RCtso.
> >>
