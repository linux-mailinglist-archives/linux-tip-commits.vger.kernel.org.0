Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5BE40604D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Sep 2021 02:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbhIJAEC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 20:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhIJAEC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 20:04:02 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53538C061574;
        Thu,  9 Sep 2021 17:02:52 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id i13so200008ilm.4;
        Thu, 09 Sep 2021 17:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qfK7KKl8oFnAFH+nw9DM1NT8Mmm4+KRvCOrQXBPc9YQ=;
        b=JSw6gegC8T2qItiD+mR81bE9kG69ZL9oFEyQX0T9e8eeGTmewX4cK6osqNg085Swip
         wqhJEUtXgpnp7p1NHuhWQKyWQj5tE49RZtBP78yh4ijmqrFWa3eGf6wAG/xfagmexEAE
         TqV/q2XehhTAWGipnNNCuvTFrwXgFbYP1Gm1KhiobVy1JUpQSIMWGBBm6D9xYBv0RncY
         fxv+zExVbKcTIYuctmoZjYPHBLacLHg6+8g5iGNRoL49PMGuGKlJUNXIacJ4f8CBJR2q
         KN+ef499hhIkwM8GOFEct4vlVlrpBtP6CwRCny+bx8s07n5FlUZ742k+PxetG9u/MSGR
         eExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qfK7KKl8oFnAFH+nw9DM1NT8Mmm4+KRvCOrQXBPc9YQ=;
        b=i8rsCsFYWK410Ltf+IEpm8y1UJUKokz7YIenJelOKW9yULqk6LzsBhwEyyFcqRNgkA
         AqLgGWojknfYskkZjo82WpmFjJuy5PqL3GIYkvMfIEbpXGWrTxr0K+NrJYZashW5vJJh
         89uShmu0IQbyMT/zEqmFNEazzEMdxsUQ4Kp0T+ZYZVVQWjN63SiRg7J9oNQ+7J1QAx3F
         c2ODroK2NleAQNmbT8Hjj0M6p1HPI2Y/xAH6HeEMEsfR+6vKOzw2OPTVeNSd6a2LNvCd
         HjHsX3vLmm4cxvuNtfuYPJmP2+hvdwJHCLSLFtfDXK/4Z1w7Z6pEAO/3+BJxd/feT5aa
         FS2Q==
X-Gm-Message-State: AOAM533WubqJ1xsiRAopqcd4QtxgitMPpYA4SEKhr/SBqO1npn1QBitB
        86yOE8wEGx4H4uqfOrks+7Y=
X-Google-Smtp-Source: ABdhPJx3XgSSt7P4jwLJpMfTeIhUnjm7pdclbaRsqiUqCdh3RY8o19sP5CF6ckLWEsFYIQp36R0pfA==
X-Received: by 2002:a92:ad12:: with SMTP id w18mr4235005ilh.181.1631232171550;
        Thu, 09 Sep 2021 17:02:51 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id o5sm1548868iow.48.2021.09.09.17.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 17:02:50 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id D562E27C005B;
        Thu,  9 Sep 2021 20:02:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 09 Sep 2021 20:02:49 -0400
X-ME-Sender: <xms:p6A6YUmNsdhmXNN91aaqq4MX4rCXPQn80F7Sxfq1RZ_nQ-Hu3HRemA>
    <xme:p6A6YT3ayp0tewFu7fHSP36FuOgzS5s93WKCIORZBWwwbgcSiQmCxTykI7mcW2w2y
    av1NJNrWxldXiZBWQ>
X-ME-Received: <xmr:p6A6YSoSDn0EjQnN5aWX-eyBq3949Vyd3XNRWEUiG7rYwpY3tMxiPZ1WXDRCow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegtddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:p6A6YQnk6lJmDWoJRNiTYNks_VK5QQ64K_LI1jYDH4x8iu57vKvggg>
    <xmx:p6A6YS3ycplbyx1D3pvahiPq5sKmJYPSj6U1vYWM9BKRBcAtV3S4KA>
    <xmx:p6A6YXsn6GMEqhGpjx9VUAc1TI6Ybz9IotbmoWPaJb88qtiysD63_w>
    <xmx:qKA6Yb6k4veRvD76QJQBR5t8JeSzp7luwPqHlUXlIf3prBsZVDk3V9kezV8>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Sep 2021 20:02:46 -0400 (EDT)
Date:   Fri, 10 Sep 2021 08:01:14 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Dan Lustig <dlustig@nvidia.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <YTqgSmX57l2hCMk0@boqun-archlinux>
References: <20180926182920.27644-2-paulmck@linux.ibm.com>
 <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
 <20210909133535.GA9722@willie-the-truck>
 <5412ab37-2979-5717-4951-6a61366df0f2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5412ab37-2979-5717-4951-6a61366df0f2@nvidia.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Sep 09, 2021 at 01:03:18PM -0400, Dan Lustig wrote:
> On 9/9/2021 9:35 AM, Will Deacon wrote:
> > [+Palmer, PaulW, Daniel and Michael]
> > 
> > On Thu, Sep 09, 2021 at 09:25:30AM +0200, Peter Zijlstra wrote:
> >> On Wed, Sep 08, 2021 at 09:08:33AM -0700, Linus Torvalds wrote:
> >>
> >>> So if this is purely a RISC-V thing,
> >>
> >> Just to clarify, I think the current RISC-V thing is stonger than
> >> PowerPC, but maybe not as strong as say ARM64, but RISC-V memory
> >> ordering is still somewhat hazy to me.
> >>
> >> Specifically, the sequence:
> >>
> >> 	/* critical section s */
> >> 	WRITE_ONCE(x, 1);
> >> 	FENCE RW, W
> >> 	WRITE_ONCE(s.lock, 0);		/* store S */
> >> 	AMOSWAP %0, 1, r.lock		/* store R */
> >> 	FENCE R, RW
> >> 	WRITE_ONCE(y, 1);
> >> 	/* critical section r */
> >>
> >> fully separates section s from section r, as in RW->RW ordering
> >> (possibly not as strong as smp_mb() though), while on PowerPC it would
> >> only impose TSO ordering between sections.
> >>
> >> The AMOSWAP is a RmW and as such matches the W from the RW->W fence,
> >> similarly it marches the R from the R->RW fence, yielding an:
> >>
> >> 	RW->  W
> >> 	    RmW
> >> 	    R  ->RW
> >>
> >> ordering. It's the stores S and R that can be re-ordered, but not the
> >> sections themselves (same on PowerPC and many others).
> >>
> >> Clarification from a RISC-V enabled person would be appreciated.
> 
> To first order, RISC-V's memory model is very similar to ARMv8's.  It
> is "other-multi-copy-atomic", unlike Power, and respects dependencies.
> It also has AMOs and LR/SC with optional RCsc acquire or release
> semantics.  There's no need to worry about RISC-V somehow pushing the
> boundaries of weak memory ordering in new ways.
> 
> The tricky part is that unlike ARMv8, RISC-V doesn't have load-acquire
> or store-release opcodes at all.  Only AMOs and LR/SC have acquire or
> release options.  That means that while certain operations like swap
> can be implemented with native RCsc semantics, others like store-release
> have to fall back on fences and plain writes.
> 
> That's where the complexity came up last time this was discussed, at
> least as it relates to RISC-V: how to make sure the combination of RCsc
> atomics and plain operations+fences gives the semantics everyone is
> asking for here.  And to be clear there, I'm not asking for LKMM to
> weaken anything about critical section ordering just for RISC-V's sake.
> TSO/RCsc ordering between critical sections is a perfectly reasonable
> model in my opinion.  I just want to make sure RISC-V gets it right
> given whatever the decision is.
> 
> >>> then I think it's entirely reasonable to
> >>>
> >>>         spin_unlock(&r);
> >>>         spin_lock(&s);
> >>>
> >>> cannot be reordered.
> >>
> >> I'm obviously completely in favour of that :-)
> > 
> > I don't think we should require the accesses to the actual lockwords to
> > be ordered here, as it becomes pretty onerous for relaxed LL/SC
> > architectures where you'd end up with an extra barrier either after the
> > unlock() or before the lock() operation. However, I remain absolutely in
> > favour of strengthening the ordering of the _critical sections_ guarded by
> > the locks to be RCsc.
> 
> I agree with Will here.  If the AMOSWAP above is actually implemented with
> a RISC-V AMO, then the two critical sections will be separated as if RW,RW,
> as Peter described.  If instead it's implemented using LR/SC, then RISC-V

Just out of curiosity, in the following code, can the store S and load L
be reordered?

	WRITE_ONCE(x, 1); // store S
	FENCE RW, W
 	WRITE_ONCE(s.lock, 0); // unlock(s)
 	AMOSWAP %0, 1, s.lock  // lock(s)
	FENCE R, RW
	r1 = READ_ONCE(y); // load L

I think they can, because neither "FENCE RW, W" nor "FENCE R, RW" order
them. Note that the reordering is allowed in LKMM, because unlock-lock
only need to be as strong as RCtso.

Moreover, how about the outcome of the following case:

	{ 
	r1, r2 are registers (variables) on each CPU, X, Y are memory
	locations, and initialized as 0
	}

	CPU 0
	=====
	AMOSWAP r1, 1, X
	FENCE R, RW
	r2 = READ_ONCE(Y);

	CPU 1
	=====
	WRITE_ONCE(Y, 1);
	FENCE RW, RW
	r2 = READ_ONCE(X);

can we observe the result where r2 on CPU0 is 0 while r2 on CPU1 is 1?

Regards,
Boqun

> gives only TSO (R->R, R->W, W->W), because the two pieces of the AMO are
> split, and that breaks the chain.  Getting full RW->RW between the critical
> sections would therefore require an extra fence.  Also, the accesses to the
> lockwords themselves would not be ordered without an extra fence.
> 
> > Last time this came up, I think the RISC-V folks were generally happy to
> > implement whatever was necessary for Linux [1]. The thing that was stopping
> > us was Power (see CONFIG_ARCH_WEAK_RELEASE_ACQUIRE), wasn't it? I think
> > Michael saw quite a bit of variety in the impact on benchmarks [2] across
> > different machines. So the question is whether newer Power machines are less
> > affected to the degree that we could consider making this change again.
> 
> Yes, as I said above, RISC-V will implement what is needed to make this work.
> 
> Dan
> 
> > Will
> > 
> > [1] https://lore.kernel.org/lkml/11b27d32-4a8a-3f84-0f25-723095ef1076@nvidia.com/
> > [2] https://lore.kernel.org/lkml/87tvp3xonl.fsf@concordia.ellerman.id.au/
