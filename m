Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E4E40FF55
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 20:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhIQS1q (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 14:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhIQS1p (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 14:27:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CDCC061574;
        Fri, 17 Sep 2021 11:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N7BdNz9Vf/o9bdJ+Yzke7wjYnqiO+rP/ebx3b0B6FZE=; b=Hf4VwZ/c5g4Tn5kwarU0Sy0m7j
        g6/RDYv8EoyK+TAe/KbO33MPhEhTh8tGrkn/ivLABOnABPXEqfjcNsqx4lKzsVbL5N6HWxTOu5lWi
        J7gG+logNAXxrjQBnctPEPNgdU+jFgHeVcLfRfH+IBvibxjCSOnA7ccj6z/QJd7XuMQle4OArpa3W
        JoIOoRAFggBaxzvpogWPuvTRlqpjoIz3XdiR4EEj5wAKl28b/fvLOZqJi1wJkWbGPJdKxmcodgDLA
        RbMDs5fF3/Uj98AkRgetfHnSJ7pCMrzoavWqV+LYcg2jLs4W02K4d/2Qkpr2cf8QRcl2xEr64gqrh
        l3SYPddQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRIYz-003v7o-EJ; Fri, 17 Sep 2021 18:26:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22B4598625E; Fri, 17 Sep 2021 20:26:16 +0200 (CEST)
Date:   Fri, 17 Sep 2021 20:26:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: sched/core] sched: Fix -Wmissing-prototype
Message-ID: <20210917182616.GH4323@worktop.programming.kicks-ass.net>
References: <163179356649.25758.16036449513954806322.tip-bot2@tip-bot2>
 <CAFTs51Weqaig2tk-vMrSCzaQUch2Zr_Us0SPGutJAjMoYBK94A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTs51Weqaig2tk-vMrSCzaQUch2Zr_Us0SPGutJAjMoYBK94A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Sep 17, 2021 at 09:57:37AM -0700, Peter Oskolkov wrote:
> On Thu, Sep 16, 2021 at 4:59 AM tip-bot2 for Peter Zijlstra
> <tip-bot2@linutronix.de> wrote:
> >
> > The following commit has been merged into the sched/core branch of tip:
> >
> > Commit-ID:     98a3270911f7abe2871a60799c20c95c9f991ddb
> 
> $ make defconfig
> $ make -j16
> 
> ld: kernel/sched/core.o: in function `sched_free_group':
> core.c:(.text+0x2cfd): undefined reference to `free_rt_sched_group'
> ld: kernel/sched/core.o: in function `sched_create_group':
> core.c:(.text+0xbdcb): undefined reference to `alloc_rt_sched_group'
> ld: kernel/sched/core.o: in function `sched_init':
> core.c:(.init.text+0x335): undefined reference to `init_cfs_bandwidth'
> ld: kernel/sched/fair.o: in function `alloc_fair_sched_group':
> fair.c:(.text+0x8427): undefined reference to `init_cfs_bandwidth'
> make: *** [Makefile:1196: vmlinux] Error 1
> 
> Reverting this patch fixes the issue.

Moo, ok, I'll go figure that out ... too damn many CONFIG_ knobs is
what.
