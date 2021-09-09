Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873A2405BC7
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 19:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbhIIRLE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 13:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240539AbhIIRLD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 13:11:03 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50ABC061574
        for <linux-tip-commits@vger.kernel.org>; Thu,  9 Sep 2021 10:09:53 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so5084140lfu.5
        for <linux-tip-commits@vger.kernel.org>; Thu, 09 Sep 2021 10:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=diTVsMYqliPsntfgupSiQvQMuF7KcKYQBTVusJZ/h/Y=;
        b=VmEctbgHul4P8W8T9HtRUrO/mtlYhuO6qpGs6XmtXJRlio+QOUgKC049cxIiHSNiOg
         djteLekmvDdQqPQ6855lV3YAT50gfrDu4zxrdCIqMc9YjrnuUc0+8CoJjrt7pKnfNz95
         +qdw0ajYtXMBK2qlwtYipW05sjvaLD1bEgwoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diTVsMYqliPsntfgupSiQvQMuF7KcKYQBTVusJZ/h/Y=;
        b=CLwJFfusxoq78y+nVn7hyYRK3iHox30VuRU2ges/D7vqv486UvTK41SobVRiR5/KSB
         quidA+GzE+v/sw7EH+Z9TsiTPs6JRJxDbfsFvg3GR+7GDuPbrtgcw6eWD7SkkmCrROmp
         IKsFGEGJYrf+0RYRLJx8zAhqSRWoiEsrTM1UcwnDlZQQ/hDtKpZEqHV4UnsI0YP16Yug
         fpCT8rDa8+4XwvLVh+RA/4JM72+mSojuCcDjWqC23ufYY6ab3Diwr3H8XpA7vKCYNp7X
         EUHHQOiV/tABH0nanHnSed5gpQysOQS0OGVtUMKiP6/ROR2md+zjxIngzxGb0hda1Pme
         fShQ==
X-Gm-Message-State: AOAM5304vta1RGCK0pkPFZ0l4fssdxYGKi3xQA+7UtAUPmBkz6MtJWVC
        ywAusIDacok34zf9nw++k4Mml+HA4gnfZ4WdhK4=
X-Google-Smtp-Source: ABdhPJx3y0Up1wI/MsVoLdrH70uGUXsUYbv+5uoqslotC27Mf5ZCcgorHSvvIyTHymstNAqKpM0pLg==
X-Received: by 2002:ac2:4318:: with SMTP id l24mr692294lfh.145.1631207391842;
        Thu, 09 Sep 2021 10:09:51 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id o6sm9408lfc.0.2021.09.09.10.09.51
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 10:09:51 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id l10so5096569lfg.4
        for <linux-tip-commits@vger.kernel.org>; Thu, 09 Sep 2021 10:09:51 -0700 (PDT)
X-Received: by 2002:a05:6512:34c3:: with SMTP id w3mr626249lfr.173.1631206949455;
 Thu, 09 Sep 2021 10:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180926182920.27644-2-paulmck@linux.ibm.com> <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net> <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu> <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net> <20210909133535.GA9722@willie-the-truck>
In-Reply-To: <20210909133535.GA9722@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Sep 2021 10:02:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whULF=p-igDd-pvB+oqX-josNmbeBx2sTBA13t9UqcpQA@mail.gmail.com>
Message-ID: <CAHk-=whULF=p-igDd-pvB+oqX-josNmbeBx2sTBA13t9UqcpQA@mail.gmail.com>
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        linux-tip-commits@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Sep 9, 2021 at 6:35 AM Will Deacon <will@kernel.org> wrote:
>
> I don't think we should require the accesses to the actual lockwords to
> be ordered here, as it becomes pretty onerous for relaxed LL/SC
> architectures where you'd end up with an extra barrier either after the
> unlock() or before the lock() operation. However, I remain absolutely in
> favour of strengthening the ordering of the _critical sections_ guarded by
> the locks to be RCsc.

Ack. The actual locking operations themselves can obviously overlap,
it's what they protect that should be ordered if at all possible.

Because anything else will be too confusing for words, and if we have
to add memory barriers *and* locking we're just screwed.

Because I think it is entirely understandable for people to expect
that sequence of two locked regions to be ordered wrt each other.

While memory ordering is subtle and confusing, we should strive to
make our "..but I used locks" to be as straightforward and as
understandable to people who really really don't want to even think
about memory order as at all reasonable.

I think we should have a very strong reason for accepting unordered
locked regions (with "strong reason" being defined as "on this
architecture that is hugely important, anything else would slow down
locks enormously").

It sounds like no such architecture exists, much less is important.

              Linus
