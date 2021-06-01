Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56453972DB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jun 2021 13:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhFAL4U (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Jun 2021 07:56:20 -0400
Received: from foss.arm.com ([217.140.110.172]:48252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233409AbhFAL4T (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Jun 2021 07:56:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C1C26D;
        Tue,  1 Jun 2021 04:54:38 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F06A3F73D;
        Tue,  1 Jun 2021 04:54:37 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Yejune Deng <yejune.deng@gmail.com>, x86@kernel.org
Subject: Re: [PATCH] sched,init: Fix DEBUG_PREEMPT vs early boot
In-Reply-To: <YLS4mbKUrA3Gnb4t@hirez.programming.kicks-ass.net>
References: <20210510151024.2448573-3-valentin.schneider@arm.com> <162141495460.29796.4438792168641232595.tip-bot2@tip-bot2> <YLS4mbKUrA3Gnb4t@hirez.programming.kicks-ass.net>
Date:   Tue, 01 Jun 2021 12:54:35 +0100
Message-ID: <87mts9g5qc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 31/05/21 12:21, Peter Zijlstra wrote:
> On Wed, May 19, 2021 at 09:02:34AM -0000, tip-bot2 for Yejune Deng wrote:
>> @@ -19,11 +19,7 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
>>      if (irqs_disabled())
>>              goto out;
>>
>> -	/*
>> -	 * Kernel threads bound to a single CPU can safely use
>> -	 * smp_processor_id():
>> -	 */
>> -	if (current->nr_cpus_allowed == 1)
>> +	if (is_percpu_thread())
>>              goto out;
>
> So my test box was unhappy with all this and started spewing lots of
> DEBUG_PREEMPT warns on boot.
>

I get these too, though can't recall getting them when testing the
above. I think it's tied with what Frederic found out with copy_process()
copying PF_NO_SETAFFINITY, which it now no longer does.

> This extends 8fb12156b8db6 to cover the new requirement.
>
> ---
> Subject: sched,init: Fix DEBUG_PREEMPT vs early boot
>
> Extend 8fb12156b8db ("init: Pin init task to the boot CPU, initially")
> to cover the new PF_NO_SETAFFINITY requirement.
>
> While there, move wait_for_completion(&kthreadd_done) into kernel_init()
> to make it absolutely clear it is the very first thing done by the init
> thread.
>
> Fixes: 570a752b7a9b ("lib/smp_processor_id: Use is_percpu_thread() instead of nr_cpus_allowed")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
