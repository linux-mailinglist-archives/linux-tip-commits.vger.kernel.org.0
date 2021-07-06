Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629A63BDFEB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Jul 2021 01:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhGFX6I (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 6 Jul 2021 19:58:08 -0400
Received: from foss.arm.com ([217.140.110.172]:52440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbhGFX6H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 6 Jul 2021 19:58:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36E7BD6E;
        Tue,  6 Jul 2021 16:55:28 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ECF63F694;
        Tue,  6 Jul 2021 16:55:27 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/core: Initialize the idle task with preemption disabled
In-Reply-To: <20210706194456.GA1823793@roeck-us.net>
References: <20210512094636.2958515-1-valentin.schneider@arm.com> <162081815405.29796.14574924529325899839.tip-bot2@tip-bot2> <20210706194456.GA1823793@roeck-us.net>
Date:   Wed, 07 Jul 2021 00:55:20 +0100
Message-ID: <87fswr6lqv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org


Hi Guenter,

On 06/07/21 12:44, Guenter Roeck wrote:
> This patch results in several messages similar to the following
> when booting s390 images in qemu.
>
> [    1.690807] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
> [    1.690925] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
> [    1.691053] no locks held by swapper/0/1.
> [    1.691310] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-11788-g79160a603bdb #1
> [    1.691469] Hardware name: QEMU 2964 QEMU (KVM/Linux)
> [    1.691612] Call Trace:
> [    1.691718]  [<0000000000d98bb0>] show_stack+0x90/0xf8
> [    1.692040]  [<0000000000da894c>] dump_stack_lvl+0x74/0xa8
> [    1.692134]  [<0000000000187e52>] ___might_sleep+0x15a/0x170
> [    1.692228]  [<000000000014f588>] cpus_read_lock+0x38/0xc0
> [    1.692320]  [<0000000000182e8a>] smpboot_register_percpu_thread+0x2a/0x160
> [    1.692412]  [<00000000014814b8>] cpuhp_threads_init+0x28/0x60
> [    1.692505]  [<0000000001487a30>] smp_init+0x28/0x90
> [    1.692597]  [<00000000014779a6>] kernel_init_freeable+0x1f6/0x270
> [    1.692689]  [<0000000000db7466>] kernel_init+0x2e/0x160
> [    1.692779]  [<0000000000103618>] __ret_from_fork+0x40/0x58
> [    1.692870]  [<0000000000dc6e12>] ret_from_fork+0xa/0x30
>
> Reverting this patch fixes the problem.
> Bisect log is attached.
>
> Guenter
>

Thanks for the report.

So somehow the init task ends up with a non-zero preempt_count()? Per
FORK_PREEMPT_COUNT we should exit __ret_from_fork() with a zero count, are
you hitting the WARN_ONCE() in finish_task_switch()?

Does CONFIG_DEBUG_PREEMPT=y yield anything interesting?

I can't make sense of this right now, but it's a bit late :) I'll grab some
toolchain+qemu tomorrow and go poke at it (and while at it I need to do the
same with powerpc).
