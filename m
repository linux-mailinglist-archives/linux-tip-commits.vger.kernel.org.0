Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658643BE9D6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Jul 2021 16:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhGGOiL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Jul 2021 10:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbhGGOiK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Jul 2021 10:38:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B532FC06175F
        for <linux-tip-commits@vger.kernel.org>; Wed,  7 Jul 2021 07:35:29 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id f20so2326987pfa.1
        for <linux-tip-commits@vger.kernel.org>; Wed, 07 Jul 2021 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zCuVLIRisCBVFVTqoZmLYlwjqTVj+wOlxhhkcxXyeMY=;
        b=sjWqY2yl7Bm2dnZosYR3SUmdxG00K+ZhhJQ+Hs7j9qWKGOZLRHw3e+/DUWtC2jaLd5
         J72SqKyX9+eGsprY/f58B+NRLCu9kLTiWFAMvwiZYZOAIOCFtmn040kbaN9qAfPXYvj0
         +5XaKKxtnwPJepUBzjz8BH99deTwo7p5PpJtaFlhFfcXPq3mMeU1Dvu9PIXE6n3Xj+e7
         1Ifx3VpJLqAtQCtP/3xOPte0eNxTKe/QizyTrrr7EOKtU1b3cFCvkW0kvTASFr/GFbSS
         tiPTxdGtq0U7ZsUgzDatf/rkek2DucyqiGguh3QG3gagJzVm5G/c2zCAzgwWA7ee9aTp
         Ipeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zCuVLIRisCBVFVTqoZmLYlwjqTVj+wOlxhhkcxXyeMY=;
        b=gW88bAb31R9wpEQae+JFtE3YQ8r1VnjPsnTLoZGWrUZkoHkPkcPf1LN26jI4oe0XEw
         0s1cVcDdBoadpGS1NYGD16NehwiF5P6nG4+qMQNOgqWWBAigiL/YKp6CuoQlynRLul/F
         meFvCfkWYiWieBHqzcu5dfFsGPKAUfHfCZ00Xu4AhGDxe6Q2E9Fs0fUlIC0v+cGOaluJ
         ul7E5KGO0whW2Xb1EGjxErScsi69lUQve69xWUToTkAJRiMWRC0N1VHBHjf7Of7g/RuO
         bPqS80k0sLHDu/ZyxG+ingFNlRIwMerfPVATAqHm8cBl7fLW18C158l48IaM6mKNq2F+
         Uawg==
X-Gm-Message-State: AOAM532mf02H1OSbbE0q89nYbng0QjS/ERirSwJBaShxRs2aYlw/M5kH
        6n2Xv+qqGmrjTBILu3xwfPWiGg==
X-Google-Smtp-Source: ABdhPJygm1PSPP9RpJcwlV1hdlHGiACfHl9N4R/H4MjQMyFM+yz7QdYnxV2bbgQVv0SfjVHJ6ePhlQ==
X-Received: by 2002:a62:8fc8:0:b029:2ec:9b7a:f59e with SMTP id n191-20020a628fc80000b02902ec9b7af59emr25702534pfd.39.1625668529305;
        Wed, 07 Jul 2021 07:35:29 -0700 (PDT)
Received: from localhost (219-90-184-65.ip.adam.com.au. [219.90.184.65])
        by smtp.gmail.com with UTF8SMTPSA id x18sm16075987pfc.76.2021.07.07.07.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 07:35:28 -0700 (PDT)
Message-ID: <de7b1d0f-8767-1b33-2950-576029c0d9f7@ozlabs.ru>
Date:   Thu, 8 Jul 2021 00:35:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Thunderbird/88.0
Subject: Re: [tip: sched/core] sched/core: Initialize the idle task with
 preemption disabled
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
References: <20210512094636.2958515-1-valentin.schneider@arm.com>
 <162081815405.29796.14574924529325899839.tip-bot2@tip-bot2>
 <20210706194456.GA1823793@roeck-us.net> <87fswr6lqv.mognet@arm.com>
 <20210707120305.GB115752@lothringen> <87czru727k.mognet@arm.com>
 <c30097f3-63b4-6fa0-a369-8f4e20ee1040@roeck-us.net>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <c30097f3-63b4-6fa0-a369-8f4e20ee1040@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org



On 08/07/2021 00:14, Guenter Roeck wrote:
> On 7/7/21 5:11 AM, Valentin Schneider wrote:
>> On 07/07/21 14:03, Frederic Weisbecker wrote:
>>> On Wed, Jul 07, 2021 at 12:55:20AM +0100, Valentin Schneider wrote:
>>>> Thanks for the report.
>>>>
>>>> So somehow the init task ends up with a non-zero preempt_count()? Per
>>>> FORK_PREEMPT_COUNT we should exit __ret_from_fork() with a zero 
>>>> count, are
>>>> you hitting the WARN_ONCE() in finish_task_switch()?
>>>>
>>>> Does CONFIG_DEBUG_PREEMPT=y yield anything interesting?
>>>>
>>>> I can't make sense of this right now, but it's a bit late :) I'll 
>>>> grab some
>>>> toolchain+qemu tomorrow and go poke at it (and while at it I need to 
>>>> do the
>>>> same with powerpc).
>>>
>>> One possible issue is that s390's init_idle_preempt_count() doesn't 
>>> apply on the
>>> target idle task but on the _current_ CPU. And since smp_init() ->
>>> idle_threads_init() is actually called remotely, we are overwriting 
>>> the current
>>> CPU preempt_count() instead of the target one.
>>
>> Indeed, this becomes quite obvious when tracing the preemption count
>> changes. This also means that s390 relied on the idle_thread_get() 
>> from the
>> hotplug machinery to properly setup the preempt count, rather than
>> init_idle_preempt_count() - which is quite yuck.
>>
>> I'll write a patch for that and likely one for powerpc.
>>
> 
> Can you reproduce the problem with a powerpc qemu emulation ?
> If so, how do you reproduce it there ? Reason for asking is that I don't 
> see
> the problem with any of my powerpc emulations, and I would like to add test
> case(s) if possible.

I can reproduce the problem on powerpc easily - qemu with "-smp 2" does it.


-- 
Alexey
