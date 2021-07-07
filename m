Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468A93BEA29
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Jul 2021 16:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhGGPAE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Jul 2021 11:00:04 -0400
Received: from foss.arm.com ([217.140.110.172]:38892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232109AbhGGPAD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Jul 2021 11:00:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 752481042;
        Wed,  7 Jul 2021 07:57:23 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 374C73F73B;
        Wed,  7 Jul 2021 07:57:22 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Guenter Roeck <linux@roeck-us.net>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/core: Initialize the idle task with preemption disabled
In-Reply-To: <de7b1d0f-8767-1b33-2950-576029c0d9f7@ozlabs.ru>
References: <20210512094636.2958515-1-valentin.schneider@arm.com> <162081815405.29796.14574924529325899839.tip-bot2@tip-bot2> <20210706194456.GA1823793@roeck-us.net> <87fswr6lqv.mognet@arm.com> <20210707120305.GB115752@lothringen> <87czru727k.mognet@arm.com> <c30097f3-63b4-6fa0-a369-8f4e20ee1040@roeck-us.net> <de7b1d0f-8767-1b33-2950-576029c0d9f7@ozlabs.ru>
Date:   Wed, 07 Jul 2021 15:57:17 +0100
Message-ID: <878s2i6uk2.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 08/07/21 00:35, Alexey Kardashevskiy wrote:
> On 08/07/2021 00:14, Guenter Roeck wrote:
>>
>> Can you reproduce the problem with a powerpc qemu emulation ?
>> If so, how do you reproduce it there ? Reason for asking is that I don't
>> see
>> the problem with any of my powerpc emulations, and I would like to add test
>> case(s) if possible.
>
> I can reproduce the problem on powerpc easily - qemu with "-smp 2" does it.
>

So on powerpc I'm chasing a slightly different problem, reported at
[1]. I couldn't get it to trigger on qemu for powerpc64, and I'm still
struggling with powerpc. Could you please share you qemu invocation &
kernel .config? Thanks.

[1]: https://lore.kernel.org/linux-next/YNSq3UQTjm6HWELA@in.ibm.com/

>
> --
> Alexey
