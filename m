Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C5027B7F9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 01:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgI1XUh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 28 Sep 2020 19:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgI1XUc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 28 Sep 2020 19:20:32 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05DD823A52;
        Mon, 28 Sep 2020 22:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601333727;
        bh=nVv5eFMhZxzuUjz/hzt1MJOVFmdQT3QVpGthmSQf4Tg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=na+DVtNqqzotWjIjIDUhDtGn4eiWCgc7gW9oZFsQJx1nI/IB9WSmHnqpJPLYWSuWy
         u7FScVx5yydPbLyz4zv8VDlRks/l75WDA0dUQB9SFckbpcdY8keaFkCyePUdrgloql
         TpRbxMDidOiQIP1/FWVt3+roJeQci+NOzn2Wx3kQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B051035227DB; Mon, 28 Sep 2020 15:55:26 -0700 (PDT)
Date:   Mon, 28 Sep 2020 15:55:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        rostedt@goodmis.org
Subject: Re: [tip: core/rcu] rcu/tree: Mark the idle relevant functions
 noinstr
Message-ID: <20200928225526.GR29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200505134100.575356107@linutronix.de>
 <158991795300.17951.11897222265664137612.tip-bot2@tip-bot2>
 <b94de56b-1b37-07a0-f0de-12471ee5fc3d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b94de56b-1b37-07a0-f0de-12471ee5fc3d@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Sep 28, 2020 at 05:22:33PM -0500, Kim Phillips wrote:
> Hi,
> 
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
> 
> To reproduce the hang, compile the below code and execute it as root
> on an x86_64 server (AMD or Intel).  The code is opening a 
> PERF_TYPE_TRACEPOINT event with a non-zero pe.config.
> 
> If I revert the commit from Linus' ToT, the system stays up.

"Linus' ToT" is current mainline?  If so, what does your revert look like?
Over here that revert wants to be hand applied for current mainline.

							Thanx, Paul

> .config attached.
> 
> Thanks,
> 
> Kim
> 
> #include <stdlib.h>
> #include <stdio.h>
> #include <unistd.h>
> #include <string.h>
> #include <sys/ioctl.h>
> #include <linux/perf_event.h>
> #include <asm/unistd.h>
> 
> static long
> perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
> 	       int cpu, int group_fd, unsigned long flags)
> {
>    int ret;
> 
>    ret = syscall(__NR_perf_event_open, hw_event, pid, cpu,
> 		  group_fd, flags);
>    return ret;
> }
> 
> int
> main(int argc, char **argv)
> {
>    struct perf_event_attr pe;
>    long long count;
>    int fd;
> 
>    memset(&pe, 0, sizeof(struct perf_event_attr));
>    pe.type = PERF_TYPE_TRACEPOINT;
>    pe.size = sizeof(struct perf_event_attr);
>    pe.config = PERF_COUNT_HW_INSTRUCTIONS;
>    pe.disabled = 1;
>    pe.exclude_kernel = 1;
>    pe.exclude_hv = 1;
> 
>    fd = perf_event_open(&pe, 0, -1, -1, 0);
>    if (fd == -1) {
>       fprintf(stderr, "Error opening leader %llx\n", pe.config);
>       exit(EXIT_FAILURE);
>    }
> }


