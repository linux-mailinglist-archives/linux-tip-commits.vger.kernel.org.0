Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B5427BDF2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 09:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgI2HZg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 03:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgI2HZg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 03:25:36 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E097C061755;
        Tue, 29 Sep 2020 00:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z1LEDC9dbIm7MGnY3PO/Fs+DYoGU7JMpABHegTdqjpc=; b=nti/DiKTMG0Y8EpNjr3yjweRtW
        fa1KycD/kV7rLcodN4hbh7od44OKC3SvrxXGug7leDRtxVNArwKzDWAZFE9smz2SmdjG9HCmhDMON
        Ytsq51xbxJR+qhqeuxy9vS+byVrrhRhSDinSWPunbMaYOgv4EGKOZel+sj72eOwyjdZlkQYwfN5mK
        qIT/eVpYBywe+3D5t8qNmJEBd58fKgnhWoNbHxNE4QoxuPwnUosj+/WFkG2X0vX/DUnRLy0alNrSs
        sE0qXmT+XraG/2za1aK41VngaiqqOUHzdz2V539GjFyrYy8+/1Sn+Zn/CHEJIRycBVlhU65KXIfKo
        XhEhyPJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNA0x-0001BA-RA; Tue, 29 Sep 2020 07:25:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CBA6303F45;
        Tue, 29 Sep 2020 09:25:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D121A200D4C46; Tue, 29 Sep 2020 09:25:29 +0200 (CEST)
Date:   Tue, 29 Sep 2020 09:25:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>
Subject: Re: [tip: core/rcu] rcu/tree: Mark the idle relevant functions
 noinstr
Message-ID: <20200929072529.GL2628@hirez.programming.kicks-ass.net>
References: <20200505134100.575356107@linutronix.de>
 <158991795300.17951.11897222265664137612.tip-bot2@tip-bot2>
 <b94de56b-1b37-07a0-f0de-12471ee5fc3d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b94de56b-1b37-07a0-f0de-12471ee5fc3d@amd.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Sep 28, 2020 at 05:22:33PM -0500, Kim Phillips wrote:
> On 5/19/20 2:52 PM, tip-bot2 for Thomas Gleixner wrote:
> > The following commit has been merged into the core/rcu branch of tip:
> > 
> > Commit-ID:     ff5c4f5cad33061b07c3fb9187506783c0f3cb66
> > Gitweb:        https://git.kernel.org/tip/ff5c4f5cad33061b07c3fb9187506783c0f3cb66
> > Author:        Thomas Gleixner <tglx@linutronix.de>
> > AuthorDate:    Fri, 13 Mar 2020 17:32:17 +01:00
> > Committer:     Thomas Gleixner <tglx@linutronix.de>
> > CommitterDate: Tue, 19 May 2020 15:51:20 +02:00
> > 
> > rcu/tree: Mark the idle relevant functions noinstr
> > 
> > These functions are invoked from context tracking and other places in the
> > low level entry code. Move them into the .noinstr.text section to exclude
> > them from instrumentation.
> > 
> > Mark the places which are safe to invoke traceable functions with
> > instrumentation_begin/end() so objtool won't complain.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> > Acked-by: Peter Zijlstra <peterz@infradead.org>
> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > Link: https://lkml.kernel.org/r/20200505134100.575356107@linutronix.de
> > 
> > 
> > ---
> 
> I bisected a system hang condition down to this commit.

That's odd, mostly its the lack of noinstr that causes hangs, I've never
yet seen the presence of it cause problems.

> To reproduce the hang, compile the below code and execute it as root
> on an x86_64 server (AMD or Intel).  The code is opening a 
> PERF_TYPE_TRACEPOINT event with a non-zero pe.config.

In my experience, it is very relevant which exact tracepoint you end up
using.

PERF_COUNT_HW_INSTRUCTIONS is a very long and tedious way of writing 1
in this case, on my randonly selected test box this morning, trace event
1 is:

$ for file in /debug/tracing/events/*/*/id ;  do echo $file -- $(cat $file); done | grep " 1$"
/debug/tracing/events/ftrace/function/id -- 1

> If I revert the commit from Linus' ToT, the system stays up.

>    memset(&pe, 0, sizeof(struct perf_event_attr));
>    pe.type = PERF_TYPE_TRACEPOINT;
>    pe.size = sizeof(struct perf_event_attr);
>    pe.config = PERF_COUNT_HW_INSTRUCTIONS;
>    pe.disabled = 1;

Doubly funny for not actually enabling the event...

>    pe.exclude_kernel = 1;
>    pe.exclude_hv = 1;

Still, it seems to make my machine unhappy.. Let's see if I can get
anything useful out of it.
