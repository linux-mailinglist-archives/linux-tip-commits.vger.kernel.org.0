Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABAD40F062
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 05:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243991AbhIQDXV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 16 Sep 2021 23:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243979AbhIQDXT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 16 Sep 2021 23:23:19 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45909C061768;
        Thu, 16 Sep 2021 20:21:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y4so6325979pfe.5;
        Thu, 16 Sep 2021 20:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=19ZsXBgjRoFiuYc7FDx5t17rf/GYxwhi/L1E4zAeihI=;
        b=foCpxQlE3TPZrwgg0RXkeU47xo4A5vx3HTKWPJFfZFn/iG4AsxVbGMl89lufCCH4fQ
         81AmWKO3lr9YyMhsoTtvOzPuyRXXNb+iA0FkQHv487aLhlmaekEHdwZreUiXM/hoafBq
         BSd6+FErpwxZ4BQUI1EEsIwfOFJ3ndBkFMExiIhFtlOmM2HA3W0gidE4mTK1yEiEPLIY
         Y8ynUjieQwuO5Fw++lD75QwydC4blowIxDqTUrfhbKB7V+bAjO4JBhYH5lYEbq9vXQCO
         DJAyvHOvHCJyVbMHmrsdp66OM0O2O8yAuE70uQuj+8DPgRALm/K8RtqGvkmXJcOryvKk
         WA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=19ZsXBgjRoFiuYc7FDx5t17rf/GYxwhi/L1E4zAeihI=;
        b=iRDXubE41NmGNb1+Dy9QjWLj8QNWxYdW74bSn9W+uPc274v5/i6sKskxOc1u85Ufsz
         N5+VAYZkCjgAIZVlt7DO/HscdVqFdQhveSzzwoOl1FeGhpDT4Oq+K5BYzXtO/EqtAYbO
         1fD89dFQhVXefs5Z410Sm7mhZFEoRals/D4dnfEvy2SmdCJr+qvAmuFU8U/Vi/Mzbvom
         F9Yu3cT+ZfG+tyViXaZUs6u1Nu+WUv/4BIg9srmzgpDddH4a3SQNvzqEJCaeEP6f4lo/
         i0N7KT5nEeAa75BjYG0QxLM3Qkcwby99KWOmNzFUj2jOpoQQWl3ORZ1zG8XLpU5rqiu8
         kb8w==
X-Gm-Message-State: AOAM532FaiDJPpeN6hDt/KgJku3BZeMqyimW72SMbYrXTdJoNW0IH5Qo
        bePtWU2Gvutf1ZYAGSvuuYFLVTVAqWU=
X-Google-Smtp-Source: ABdhPJwKIB3J+CBUihSAmjXGeh5bxduji2zsqWZxOn+bb2niAVylnq9Pn76nCwhvXdasnFjAo9mnZA==
X-Received: by 2002:a65:5948:: with SMTP id g8mr7810787pgu.51.1631848917807;
        Thu, 16 Sep 2021 20:21:57 -0700 (PDT)
Received: from localhost (193-116-82-172.tpgi.com.au. [193.116.82.172])
        by smtp.gmail.com with ESMTPSA id t6sm8958535pjr.36.2021.09.16.20.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 20:21:57 -0700 (PDT)
Date:   Fri, 17 Sep 2021 13:21:52 +1000
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
In-Reply-To: <20210910110819.GA1027@willie-the-truck>
MIME-Version: 1.0
Message-Id: <1631847849.o57vj41jx3.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Excerpts from Will Deacon's message of September 10, 2021 9:08 pm:
> Hi Paul,
>=20
> On Thu, Sep 09, 2021 at 10:46:35AM -0700, Paul E. McKenney wrote:
>> On Thu, Sep 09, 2021 at 02:35:36PM +0100, Will Deacon wrote:
>> > On Thu, Sep 09, 2021 at 09:25:30AM +0200, Peter Zijlstra wrote:
>> > > On Wed, Sep 08, 2021 at 09:08:33AM -0700, Linus Torvalds wrote:
>> > > > then I think it's entirely reasonable to
>> > > >=20
>> > > >         spin_unlock(&r);
>> > > >         spin_lock(&s);
>> > > >=20
>> > > > cannot be reordered.
>> > >=20
>> > > I'm obviously completely in favour of that :-)
>> >=20
>> > I don't think we should require the accesses to the actual lockwords t=
o
>> > be ordered here, as it becomes pretty onerous for relaxed LL/SC
>> > architectures where you'd end up with an extra barrier either after th=
e
>> > unlock() or before the lock() operation. However, I remain absolutely =
in
>> > favour of strengthening the ordering of the _critical sections_ guarde=
d by
>> > the locks to be RCsc.
>>=20
>> If by this you mean the critical sections when observed only by other
>> critical sections for a given lock, then everyone is already there.
>=20
> No, I mean the case where somebody without the lock (but using memory
> barriers) can observe the critical sections out of order (i.e. W -> R
> order is not maintained).

This is a sincere question, why is this important? I mean _any_=20
restriction on reordering makes things easier by definition I can't=20
argue with that, but why is this one in particular seen as a problem?
It just seems disproportionate.

We naturally think of accesses within locks as atomic as a whole=20
(provided the other parties are doing the proper locking too). So like=20
atomic operations, aligned stores, etc can be reordered, I don't see why
these should have any particular ordering either, or why a unlock()=20
should pair with a later lock() of an unrelated lock to provide some
ordering.

It gives the idea that individual lock operations in isolation should be=20
or do something special, but I think that's the wrong way to think about=20
it, the lock and the unlock operate on a specific lock word and protect=20
specific data vs other processors that access the same data under the
same locks.

If you don't know what you're doing or don't want to think about=20
ordering, perform accesses under locks. If you don't lock, you get to
think about ordering. At which point sure two sets of operations from
different critical sections could go out of order, but so can any two
stores. Or two stores from inside the one critical section if you are
not holding the correct lock.

Thanks,
Nick
