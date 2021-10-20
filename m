Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CA243542E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 21:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhJTT5F (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 15:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhJTT5B (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 15:57:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED67C061749;
        Wed, 20 Oct 2021 12:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PJroMUkrNsdbbHOZ83LbsX148S8G/Sk1T+SJjJQKedA=; b=VJkHyviEqMqc79SP7cdtGPlwkE
        u1PDE4CLPy3fUkqXXFV0psShYswAUgjr6y0azKyCa+PSRNZvXasbVlF9LaKBGeK9jwFUwrG+rCY4j
        zv895JfcaJSSFU2KS75K2/q8BysNy4daWTAeXIZbKhkvKwiLyMMoxEPLbotF1dHnXkYkHHql698KY
        bdR6G8ZTLeGBqKJ8d2qHqFoMUHhCL7JWRl3vEkOJq962C4HYcKqgrGUN/KtS0QqjuAxF39N2llF1F
        7+Y6/JRcISaOC0lTKqmU+CqCy8HpJiH0asdNFxNGnHMWorzJYmaKcHD67aaC3uDdHsf3BbKw5hW3W
        +cnlHxiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdHca-00CoYg-7l; Wed, 20 Oct 2021 19:51:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D189F986DD9; Wed, 20 Oct 2021 21:51:31 +0200 (CEST)
Date:   Wed, 20 Oct 2021 21:51:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>, x86@kernel.org
Subject: Re: [tip: sched/core] sched: Add cluster scheduler level for x86
Message-ID: <20211020195131.GT174703@worktop.programming.kicks-ass.net>
References: <20210924085104.44806-4-21cnbao@gmail.com>
 <163429109791.25758.3107620034958821511.tip-bot2@tip-bot2>
 <9e7b0c92-5a3b-8099-8c69-83a9d62aced4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e7b0c92-5a3b-8099-8c69-83a9d62aced4@amd.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Oct 20, 2021 at 08:12:51AM -0500, Tom Lendacky wrote:
> On 10/15/21 4:44 AM, tip-bot2 for Tim Chen wrote:
> > The following commit has been merged into the sched/core branch of tip:
> > 
> > Commit-ID:     66558b730f2533cc2bf2b74d51f5f80b81e2bad0
> > Gitweb:        https://git.kernel.org/tip/66558b730f2533cc2bf2b74d51f5f80b81e2bad0
> > Author:        Tim Chen <tim.c.chen@linux.intel.com>
> > AuthorDate:    Fri, 24 Sep 2021 20:51:04 +12:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Fri, 15 Oct 2021 11:25:16 +02:00
> > 
> > sched: Add cluster scheduler level for x86
> > 
> > There are x86 CPU architectures (e.g. Jacobsville) where L2 cahce is
> > shared among a cluster of cores instead of being exclusive to one
> > single core.
> > 
> > To prevent oversubscription of L2 cache, load should be balanced
> > between such L2 clusters, especially for tasks with no shared data.
> > On benchmark such as SPECrate mcf test, this change provides a boost
> > to performance especially on medium load system on Jacobsville.  on a
> > Jacobsville that has 24 Atom cores, arranged into 6 clusters of 4
> > cores each, the benchmark number is as follow:
> > 
> >   Improvement over baseline kernel for mcf_r
> >   copies		run time	base rate
> >   1		-0.1%		-0.2%
> >   6		25.1%		25.1%
> >   12		18.8%		19.0%
> >   24		0.3%		0.3%
> > 
> > So this looks pretty good. In terms of the system's task distribution,
> > some pretty bad clumping can be seen for the vanilla kernel without
> > the L2 cluster domain for the 6 and 12 copies case. With the extra
> > domain for cluster, the load does get evened out between the clusters.
> > 
> > Note this patch isn't an universal win as spreading isn't necessarily
> > a win, particually for those workload who can benefit from packing.
> > 
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://lore.kernel.org/r/20210924085104.44806-4-21cnbao@gmail.com
> 
> I've bisected to this patch which now results in my EPYC systems issuing a
> lot of:
> 
> [    4.788480] BUG: arch topology borken
> [    4.789578]      the SMT domain not a subset of the CLS domain
> 
> messages (one for each CPU in the system).
> 
> I haven't had a chance to dig deeper and understand everything, does anyone
> have some quick insights/ideas?

Urgh, sorry about that. So this stuff uses cpu_l2c_id to build 'clusters',
basically CPUs that share L2, as a subset of the 'multi-core' topology,
which is all CPUs that share LLC (L3 typically).

Your EPYC seems to think the SMT group is not a strict subset of the L2.
The implication is that you have threads with different L2, which would
franky be quite 'exotic' if true :-)


If it does boot, what does something like:

  for i in /sys/devices/system/cpu/cpu*/topology/*{_id,_list}; do echo -n "${i}: " ; cat $i; done

produce?

I'll try and figure out how AMD sets l2c_id, that stuff is always a bit
of a maze.
