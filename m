Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC043BE7A7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Jul 2021 14:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhGGMOp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Jul 2021 08:14:45 -0400
Received: from foss.arm.com ([217.140.110.172]:35708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231358AbhGGMOp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Jul 2021 08:14:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 384F2D6E;
        Wed,  7 Jul 2021 05:12:05 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35B5C3F73B;
        Wed,  7 Jul 2021 05:12:04 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/core: Initialize the idle task with preemption disabled
In-Reply-To: <20210707120305.GB115752@lothringen>
References: <20210512094636.2958515-1-valentin.schneider@arm.com> <162081815405.29796.14574924529325899839.tip-bot2@tip-bot2> <20210706194456.GA1823793@roeck-us.net> <87fswr6lqv.mognet@arm.com> <20210707120305.GB115752@lothringen>
Date:   Wed, 07 Jul 2021 13:11:59 +0100
Message-ID: <87czru727k.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 07/07/21 14:03, Frederic Weisbecker wrote:
> On Wed, Jul 07, 2021 at 12:55:20AM +0100, Valentin Schneider wrote:
>> Thanks for the report.
>>
>> So somehow the init task ends up with a non-zero preempt_count()? Per
>> FORK_PREEMPT_COUNT we should exit __ret_from_fork() with a zero count, are
>> you hitting the WARN_ONCE() in finish_task_switch()?
>>
>> Does CONFIG_DEBUG_PREEMPT=y yield anything interesting?
>>
>> I can't make sense of this right now, but it's a bit late :) I'll grab some
>> toolchain+qemu tomorrow and go poke at it (and while at it I need to do the
>> same with powerpc).
>
> One possible issue is that s390's init_idle_preempt_count() doesn't apply on the
> target idle task but on the _current_ CPU. And since smp_init() ->
> idle_threads_init() is actually called remotely, we are overwriting the current
> CPU preempt_count() instead of the target one.

Indeed, this becomes quite obvious when tracing the preemption count
changes. This also means that s390 relied on the idle_thread_get() from the
hotplug machinery to properly setup the preempt count, rather than
init_idle_preempt_count() - which is quite yuck.

I'll write a patch for that and likely one for powerpc.
