Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36703BE78E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Jul 2021 14:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhGGMFs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Jul 2021 08:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231437AbhGGMFr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Jul 2021 08:05:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E80F61C98;
        Wed,  7 Jul 2021 12:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625659387;
        bh=NjF5w9ZP+cQZ5Y4p+VeGTnHtVqiDONjLEpnlo0arWdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gOwpVQDNeLQbksLIDdOIRGGpaI0sHWc6RcyCDmf2cckd6L1sBi2uwj6qCfuarvjOF
         0HIH1qoj9zR/SiANu0/O3GaNDG6jueXTL5OMA69Awzu5Q92y8rGzShMBoWbwHmxhu5
         lNaNEBSkDbSAdTgydQO3bKp5wFqIsU678AcxDXTUlxsK1h9wDS2FFpmIBJvSLezzLm
         dlPKY/mxuLP4pe30EDosRrp/S3tgvduItn7cgaewYm54fPD0fANCuhCqs0x9IKVnf1
         GdRNjGTuErRRpDDIR4KHGb+3BOb0tIREWtyPmI8F8KOu6PmUk16xrER+Ys6ZAooCGr
         EewFfme1yIiKQ==
Date:   Wed, 7 Jul 2021 14:03:05 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/core: Initialize the idle task with
 preemption disabled
Message-ID: <20210707120305.GB115752@lothringen>
References: <20210512094636.2958515-1-valentin.schneider@arm.com>
 <162081815405.29796.14574924529325899839.tip-bot2@tip-bot2>
 <20210706194456.GA1823793@roeck-us.net>
 <87fswr6lqv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fswr6lqv.mognet@arm.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Jul 07, 2021 at 12:55:20AM +0100, Valentin Schneider wrote:
> 
> Hi Guenter,
> 
> On 06/07/21 12:44, Guenter Roeck wrote:
> > This patch results in several messages similar to the following
> > when booting s390 images in qemu.
> >
> > [    1.690807] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
> > [    1.690925] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
> > [    1.691053] no locks held by swapper/0/1.
> > [    1.691310] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-11788-g79160a603bdb #1
> > [    1.691469] Hardware name: QEMU 2964 QEMU (KVM/Linux)
> > [    1.691612] Call Trace:
> > [    1.691718]  [<0000000000d98bb0>] show_stack+0x90/0xf8
> > [    1.692040]  [<0000000000da894c>] dump_stack_lvl+0x74/0xa8
> > [    1.692134]  [<0000000000187e52>] ___might_sleep+0x15a/0x170
> > [    1.692228]  [<000000000014f588>] cpus_read_lock+0x38/0xc0
> > [    1.692320]  [<0000000000182e8a>] smpboot_register_percpu_thread+0x2a/0x160
> > [    1.692412]  [<00000000014814b8>] cpuhp_threads_init+0x28/0x60
> > [    1.692505]  [<0000000001487a30>] smp_init+0x28/0x90
> > [    1.692597]  [<00000000014779a6>] kernel_init_freeable+0x1f6/0x270
> > [    1.692689]  [<0000000000db7466>] kernel_init+0x2e/0x160
> > [    1.692779]  [<0000000000103618>] __ret_from_fork+0x40/0x58
> > [    1.692870]  [<0000000000dc6e12>] ret_from_fork+0xa/0x30
> >
> > Reverting this patch fixes the problem.
> > Bisect log is attached.
> >
> > Guenter
> >
> 
> Thanks for the report.
> 
> So somehow the init task ends up with a non-zero preempt_count()? Per
> FORK_PREEMPT_COUNT we should exit __ret_from_fork() with a zero count, are
> you hitting the WARN_ONCE() in finish_task_switch()?
> 
> Does CONFIG_DEBUG_PREEMPT=y yield anything interesting?
> 
> I can't make sense of this right now, but it's a bit late :) I'll grab some
> toolchain+qemu tomorrow and go poke at it (and while at it I need to do the
> same with powerpc).

One possible issue is that s390's init_idle_preempt_count() doesn't apply on the
target idle task but on the _current_ CPU. And since smp_init() ->
idle_threads_init() is actually called remotely, we are overwriting the current
CPU preempt_count() instead of the target one.
