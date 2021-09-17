Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EA840F1A1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 07:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhIQFc6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 01:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhIQFc5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 01:32:57 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D909C061574;
        Thu, 16 Sep 2021 22:31:36 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h3so8522706pgb.7;
        Thu, 16 Sep 2021 22:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=g95fLp68s8x8Ys7f0g+XIqQ9cJm5k9DeyZeKhVz150o=;
        b=HZUjX6LgkfZ06wGInmB4LRqZWf9wd0ZNrAtabr4olEAXqFjF/UC1D1C0yi2AIgsiNm
         TzLDW182t5LH1hz61a0EyQ9VlT4vez/sJVwJhTOXyvM1Fa77J03Kw5FGYcjDHSESE6vc
         MTbJokeE8MPOEmqgQgvHrqIBeqrBC+95vBqCCZFhXp92jDQzX18wI7LKi3FHacu4gx+E
         H6ZBZwY8EqlPGGDtkZjyGfKVBXgIlis6r5AazS7PQDvwR6HdIzbW1er+eOIrnY4fu5BL
         OisfGbS8bmGSSM4S5ktZzXomf/YYGK9toTI8BO/OFe9BNoBhYto4n4kXpB2zpIcPv1am
         9ngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=g95fLp68s8x8Ys7f0g+XIqQ9cJm5k9DeyZeKhVz150o=;
        b=xQ+f7ccR64hrIJ02y95uxe1/K8cU1mKfJmGZLpK/h2T6bc8u+UWg7Qdo54jni9Dxqj
         6O1z2o4uQjLpm/dXu9mgLq4cHNUcuN9zWe/E1whHHT/ZkuX92efW5Ftk3ZChq2N/+EaV
         T53xoDh4C2eWmLzjDMswURqnODucJYJ2Ov81icWp1EQNWCU5LobQbBCbHD2nH05uzBZj
         O6z7sOfNBDFxNNhNhm9gxBVPn9IBKmSRJ2id2yucfNBAsQg1XaD2xOub2BIObM6RkLYu
         wguKxiIO+dSSIZk6s9m0uULVAlRUbDcYyAgqjfnhmrezYKeJ0RwFlkFzlHF6LQiuAnDk
         H8Yg==
X-Gm-Message-State: AOAM5334OKuiKlnVAISs3m9VM61gzgyr7VcEfrYb6sSEXcetsIROO7DA
        0tThxBeBTrwfO9qR0ea2kJE=
X-Google-Smtp-Source: ABdhPJyMOrWQpw6n8dyJuoPcJiv20B6YZcLwJ5JCq5YnQ+nlfkLdxP9ox07W7LP13vhd/1XjpD3dEg==
X-Received: by 2002:a63:1e16:: with SMTP id e22mr8184125pge.153.1631856695448;
        Thu, 16 Sep 2021 22:31:35 -0700 (PDT)
Received: from localhost (193-116-82-172.tpgi.com.au. [193.116.82.172])
        by smtp.gmail.com with ESMTPSA id e16sm4655325pfc.214.2021.09.16.22.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 22:31:34 -0700 (PDT)
Date:   Fri, 17 Sep 2021 15:31:29 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        dlustig@nvidia.com, Stephane Eranian <eranian@google.com>,
        Peter Anvin <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        mpe@ellerman.id.au, palmer@dabbelt.com,
        Andrea Parri <parri.andrea@gmail.com>,
        paul.walmsley@sifive.com, Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vince Weaver <vincent.weaver@maine.edu>
References: <20180926182920.27644-2-paulmck@linux.ibm.com>
        <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
        <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
        <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
        <20210908144217.GA603644@rowland.harvard.edu>
        <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
        <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
        <20210909133535.GA9722@willie-the-truck>
        <20210909174635.GA2229215@paulmck-ThinkPad-P17-Gen-1>
        <20210910110819.GA1027@willie-the-truck>
        <1631847849.o57vj41jx3.astroid@bobo.none>
In-Reply-To: <1631847849.o57vj41jx3.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1631855601.07l1who4w0.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Excerpts from Nicholas Piggin's message of September 17, 2021 1:21 pm:
> Excerpts from Will Deacon's message of September 10, 2021 9:08 pm:
>> Hi Paul,
>>=20
>> On Thu, Sep 09, 2021 at 10:46:35AM -0700, Paul E. McKenney wrote:
>>> On Thu, Sep 09, 2021 at 02:35:36PM +0100, Will Deacon wrote:
>>> > On Thu, Sep 09, 2021 at 09:25:30AM +0200, Peter Zijlstra wrote:
>>> > > On Wed, Sep 08, 2021 at 09:08:33AM -0700, Linus Torvalds wrote:
>>> > > > then I think it's entirely reasonable to
>>> > > >=20
>>> > > >         spin_unlock(&r);
>>> > > >         spin_lock(&s);
>>> > > >=20
>>> > > > cannot be reordered.
>>> > >=20
>>> > > I'm obviously completely in favour of that :-)
>>> >=20
>>> > I don't think we should require the accesses to the actual lockwords =
to
>>> > be ordered here, as it becomes pretty onerous for relaxed LL/SC
>>> > architectures where you'd end up with an extra barrier either after t=
he
>>> > unlock() or before the lock() operation. However, I remain absolutely=
 in
>>> > favour of strengthening the ordering of the _critical sections_ guard=
ed by
>>> > the locks to be RCsc.
>>>=20
>>> If by this you mean the critical sections when observed only by other
>>> critical sections for a given lock, then everyone is already there.
>>=20
>> No, I mean the case where somebody without the lock (but using memory
>> barriers) can observe the critical sections out of order (i.e. W -> R
>> order is not maintained).
>=20
> This is a sincere question, why is this important? I mean _any_=20
> restriction on reordering makes things easier by definition I can't=20
> argue with that, but why is this one in particular seen as a problem?
> It just seems disproportionate.
>=20
> We naturally think of accesses within locks as atomic as a whole=20
> (provided the other parties are doing the proper locking too). So like=20
> atomic operations, aligned stores, etc can be reordered, I don't see why
> these should have any particular ordering either, or why a unlock()=20
> should pair with a later lock() of an unrelated lock to provide some
> ordering.
>=20
> It gives the idea that individual lock operations in isolation should be=20
> or do something special, but I think that's the wrong way to think about=20
> it, the lock and the unlock operate on a specific lock word and protect=20
> specific data vs other processors that access the same data under the
> same locks.
>=20
> If you don't know what you're doing or don't want to think about=20
> ordering, perform accesses under locks. If you don't lock, you get to
> think about ordering. At which point sure two sets of operations from
> different critical sections could go out of order, but so can any two
> stores. Or two stores from inside the one critical section if you are
> not holding the correct lock.

It doesn't actually really relieve the burden of thinking about barriers=20
mcuh at all, come to think of it.

spin_lock(&foo);
x =3D 1;
spin_unlock(&foo);
spin_lock(&bar);
y =3D 1;
spin_unlock(&bar);

vs

if (READ_ONCE(y) =3D=3D 1)
    // spin_unlock(&foo)+spin_lock(&bar) provides store ordering
    smp_rmb();
    BUG_ON(READ_ONCE(x) =3D=3D 0);

Then if you didn't comment the store ordering requirement in the first
code, then you patch things to simplify or add functionality:

spin_lock(&foo);
x =3D 1;
spin_lock(&bar);
y =3D 1;
spin_unlock(&bar);
z =3D 1;
spin_unlock(&foo);

or

spin_lock(&baz);
x =3D 1;
y =3D 1;
spin_unlock(&baz);

Then you broke it. Because you thought being clever and avoiding
thinking about or talking about ordering in your code which performs=20
memory accesses outside of locks was improving the situation.

It's not good practice. If there is *any* unlocked memory access, you=20
should always think about and comment *all* memory orderings. Locking
should not ever be relied on to give you some kind of implicit semantics
that you think should be obvious. All the accesses always need thought
and they always need comments.

spin_lock(&foo);
// The spin_unlock+spin_lock orders this store before the store to y,=20
// the corresponding smp_rmb is at function().
x =3D 1;
spin_unlock(&foo);
spin_lock(&bar);
// See x
y =3D 1;
spin_unlock(&bar);

Once you do that, does it *really* break the bank to add a line of code?

spin_lock(&foo);
// See smp_unlock_lock_mb() below
x =3D 1;
spin_unlock(&foo);
// This orders this store of x above before the
// store to y below.=20
smp_unlock_lock_mb();
spin_lock(&bar);
// See smp_unlock_lock_mb() above
y =3D 1;
spin_unlock(&bar);

I can't see how that line of code created a fundamentally a bigger=20
problem.

If you don't need the performance and don't want to deal with ordering,=20
*always use locks*. If you absolutely can't always use locks, *always=20
document important memory accesses ordering that is or can affect=20
unlocked memory accesses*. We are all agreed on this rule, right? So
what am I missing?

Thanks,
Nick
