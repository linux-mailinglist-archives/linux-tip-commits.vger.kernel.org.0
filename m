Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB9B3BED19
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Jul 2021 19:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhGGRem (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Jul 2021 13:34:42 -0400
Received: from foss.arm.com ([217.140.110.172]:41552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230111AbhGGRem (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Jul 2021 13:34:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 352871042;
        Wed,  7 Jul 2021 10:32:01 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15E4D3F694;
        Wed,  7 Jul 2021 10:31:59 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/core: Initialize the idle task with preemption disabled
In-Reply-To: <c9bd8db3-60ae-1dbe-aa2f-f2fe3d5fe2d9@roeck-us.net>
References: <20210512094636.2958515-1-valentin.schneider@arm.com> <162081815405.29796.14574924529325899839.tip-bot2@tip-bot2> <20210706194456.GA1823793@roeck-us.net> <87fswr6lqv.mognet@arm.com> <20210707120305.GB115752@lothringen> <87czru727k.mognet@arm.com> <c30097f3-63b4-6fa0-a369-8f4e20ee1040@roeck-us.net> <de7b1d0f-8767-1b33-2950-576029c0d9f7@ozlabs.ru> <878s2i6uk2.mognet@arm.com> <c9bd8db3-60ae-1dbe-aa2f-f2fe3d5fe2d9@roeck-us.net>
Date:   Wed, 07 Jul 2021 18:31:55 +0100
Message-ID: <875yxm6nec.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 07/07/21 09:35, Guenter Roeck wrote:
> I think I have it. pseries_defconfig, and pseries emulation,
> started with "-smp 2" and qemu-system-ppc64:
>
> [    0.731644][    T1] smp: Bringing up secondary CPUs ...^M
> [    0.750546][    T0] BUG: scheduling while atomic: swapper/1/0/0x00000000^M
> [    0.752119][    T0] no locks held by swapper/1/0.^M
> [    0.752309][    T0] Modules linked in:^M
> [    0.752684][    T0] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.13.0-11855-g77d34a4683b0 #1^M
> [    0.753197][    T0] Call Trace:^M
> [    0.753334][    T0] [c000000008737b20] [c0000000009f9b18] .dump_stack_lvl+0xa4/0x100 (unreliable)^M
> [    0.754224][    T0] [c000000008737bb0] [c000000000190ed0] .__schedule_bug+0xa0/0xe0^M
> [    0.754459][    T0] [c000000008737c30] [c000000001182518] .__schedule+0xc08/0xd90^M
> [    0.754738][    T0] [c000000008737d20] [c000000001182b8c] .schedule_idle+0x2c/0x60^M
> [    0.754945][    T0] [c000000008737d90] [c0000000001a48ec] .do_idle+0x29c/0x3c0^M
> [    0.755145][    T0] [c000000008737e60] [c0000000001a4df0] .cpu_startup_entry+0x30/0x40^M
> [    0.755403][    T0] [c000000008737ee0] [c00000000005ef10] .start_secondary+0x2c0/0x300^M
> [    0.755621][    T0] [c000000008737f90] [c00000000000d254] start_secondary_prolog+0x10/0x14^M
> [    0.764164][    T1] smp: Brought up 1 node, 2 CPUs^M
>
> Guenter

Hmph, I was about to say I couldn't get that, but after cycling between
different PREEMPT options I finally triggered it, so thanks for that!

Same sha1 as yours, invocation is:

  qemu-system-ppc64 vmlinux -smp 2 -nographic -m 1024 -machine pseries,usb=off

with pseries_defconfig + CONFIG_DEBUG_ATOMIC_SLEEP + CONFIG_PREEMPT_VOLUNTARY

Now to dig!
