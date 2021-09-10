Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F00406D8E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Sep 2021 16:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhIJOXF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Sep 2021 10:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhIJOXE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Sep 2021 10:23:04 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F483C061574;
        Fri, 10 Sep 2021 07:21:52 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id j18so2511863ioj.8;
        Fri, 10 Sep 2021 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zmNqBLewQaaKkP2q8Ul9Jyt5h75v47zNGniVQpRx2AQ=;
        b=BxBv/+bSDLI1rN7kY8XSh3xYVqzyskdsnmX8S58laTteFNswfqpEKT5vDvYd+p6ZFp
         K+YgWnIfDJjXKJWSZzSku7CrsWy2g9i73fBa37Qk9mZi2ur9oU8JJSdKqyUyqVaf/DNn
         cq6xKKK6zf1YUKPJfLGux7i1iOeBrLqshxoMuTVYY+8YrWtR1k8TKSfcQ8qRRdBVRqCl
         j5O3xOBe3hUIKHbgycyWH70+kET7/vrB9oM1a9qOde0cUzYY617O5Kq981HtkAPu3rcA
         xbwnGYkMUsQIEsH4c7Hmz9vR3Eq2QXQYhEzpESGRNnFmL6DLg8sr2PSiXVARGq0zJo20
         tOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zmNqBLewQaaKkP2q8Ul9Jyt5h75v47zNGniVQpRx2AQ=;
        b=mMxLq/IU7/1RCeF3JzGgqkggTAMO6Uo1mZ6JyRWohUQ+mfCNBd9Jq4apvJo6wRBPiP
         ntH44JHXpb2DUCNYlkfV9CWbeDJrEt4VEKPQzS/etxbxCzjDeHOYpaWA6p+1A0bZnIx7
         kP9JWc6O5IF08j3TFX8ooFAWIvYAAwvR7NSfIMV1KROkGm26RlmUOy3w/b+NGOHmk5HR
         bJBYho9VygMDSq7uRSKBAPoHPrkB18KTB0gQY0njsbBsiLG1nHZDm6JIwkTYB1QrjOeM
         ujyTd5xjT4I9Zbn77Z455UAkP/9HuSLdhqVq0ApKANCZzjFkWqffOmpK7lEAppcHsLss
         dnEw==
X-Gm-Message-State: AOAM531o4v0mULEQjaKqtTAT96ifF+86Rv0kJ6eJ7BhQOnwR07M90w9a
        gW1eSogwf26Roc/3B8ZUu7c=
X-Google-Smtp-Source: ABdhPJw+E68xCs6Oxl5jTnpHdh/LKCk9dItlsG58oCXjwyXFlCvMNuQLWdjghPO3ZsFIg2XOo6lY9Q==
X-Received: by 2002:a6b:ba42:: with SMTP id k63mr7244772iof.37.1631283711819;
        Fri, 10 Sep 2021 07:21:51 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p19sm2504816ilj.58.2021.09.10.07.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:21:51 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5F92727C0054;
        Fri, 10 Sep 2021 10:21:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 10 Sep 2021 10:21:50 -0400
X-ME-Sender: <xms:-2k7YUCwiswyMHj6GVOeQ00rsSCmDUqDQrzC2KnDfZyCx7EkHDNK7Q>
    <xme:-2k7YWinXPT9u4fMHllG6n0pGO077Uq-NmvE2_rELaRTReQXxCNpkQowtaelNk_vo
    w5GJzXuK5KRPeevog>
X-ME-Received: <xmr:-2k7YXkPG8Wge9vYRxS3NvWwOS1TTnwyhtEUnXWQpGvsndYzYPrUdgKfBAZFyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeguddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:-2k7Yay427K9GVzuJn1nqf83X6dFt7jcNnvm0mjAdsvBlF2GOFGqdA>
    <xmx:-2k7YZTtSzKpMOV2l85Pq-mykm0euZecMci-9L0hupB8kgqc8x-qow>
    <xmx:-2k7YVa8HX-a31_WDjRpgf1WvXpBfOYh3qoB-auWr-_Y1P4vkfCiHQ>
    <xmx:_mk7Ybme2Q-w1jWUSGEB1Lp8jbZOBaBE0CI0kNotzbKb5w8bJJcPvoMcT0c>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Sep 2021 10:21:47 -0400 (EDT)
Date:   Fri, 10 Sep 2021 22:20:13 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <YTtpnZuSId9yDUjB@boqun-archlinux>
References: <20180926182920.27644-2-paulmck@linux.ibm.com>
 <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
 <20210909133535.GA9722@willie-the-truck>
 <5412ab37-2979-5717-4951-6a61366df0f2@nvidia.com>
 <20210909180005.GA2230712@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909180005.GA2230712@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Sep 09, 2021 at 11:00:05AM -0700, Paul E. McKenney wrote:
[...]
> 
> Boqun, I vaguely remember a suggested change from you along these lines,
> but now I cannot find it.  Could you please send it as a formal patch
> if you have not already done so or point me at it if you have?
> 

Here is a draft patch based on the change I did when I discussed with
Peter, and I really want to hear Alan's thought first. Ideally, we
should also have related litmus tests and send to linux-arch list so
that we know the ordering is provided by every architecture.

Regards,
Boqun

--------------------------------->8
Subject: [PATCH] tools/memory-model: Provide extra ordering for
 lock-{release,acquire} on the same CPU

A recent discussion[1] shows that we are in favor of strengthening the
ordering of lock-release + lock-acquire on the same CPU: a lock-release
and a po-after lock-acquire should provide the so-called RCtso ordering,
that is a memory access S po-before the lock-release should be ordered
against a memory access R po-after the lock-acquire, unless S is a store
and R is a load.

The strengthening meets programmers' expection that "sequence of two
locked regions to be ordered wrt each other" (from Linus), and can
reduce the mental burden when using locks. Therefore add it in LKMM.

[1]: https://lore.kernel.org/lkml/20210909185937.GA12379@rowland.harvard.edu/

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 .../Documentation/explanation.txt             | 28 +++++++++++++++++++
 tools/memory-model/linux-kernel.cat           |  6 ++--
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 5d72f3112e56..d62de21f32c4 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1847,6 +1847,34 @@ therefore the load of x must execute before the load of y.  Thus we
 cannot have r1 = 1 and r2 = 0 at the end (this is an instance of the
 MP pattern).
 
+This requirement also applies to a lock-release and a lock-acquire
+on different locks, as long as the lock-acquire is po-after the
+lock-release. Note that "po-after" means the lock-acquire and the
+lock-release are on the same cpu. An example simliar to the above:
+
+	int x, y;
+	spinlock_t s;
+	spinlock_t t;
+
+	P0()
+	{
+		int r1, r2;
+
+		spin_lock(&s);
+		r1 = READ_ONCE(x);
+		spin_unlock(&s);
+		spin_lock(&t);
+		r2 = READ_ONCE(y);
+		spin_unlock(&t);
+	}
+
+	P1()
+	{
+		WRITE_ONCE(y, 1);
+		smp_wmb();
+		WRITE_ONCE(x, 1);
+	}
+
 This requirement does not apply to ordinary release and acquire
 fences, only to lock-related operations.  For instance, suppose P0()
 in the example had been written as:
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 2a9b4fe4a84e..d70315fddef6 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -27,7 +27,7 @@ include "lock.cat"
 (* Release Acquire *)
 let acq-po = [Acquire] ; po ; [M]
 let po-rel = [M] ; po ; [Release]
-let po-unlock-rf-lock-po = po ; [UL] ; rf ; [LKR] ; po
+let po-unlock-lock-po = po ; [UL] ; (po|rf) ; [LKR] ; po
 
 (* Fences *)
 let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
@@ -70,12 +70,12 @@ let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
 let to-r = addr | (dep ; [Marked] ; rfi)
-let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
+let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
 
 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) = (rfe ; [Marked])? ; r
 let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
-	po-unlock-rf-lock-po) ; [Marked]
+	po-unlock-lock-po) ; [Marked]
 let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ;
 	[Marked] ; rfe? ; [Marked]
 
-- 
2.32.0

