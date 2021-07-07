Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FB23BE1D7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Jul 2021 06:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhGGEJ0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Jul 2021 00:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhGGEJ0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Jul 2021 00:09:26 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9515C061574;
        Tue,  6 Jul 2021 21:06:45 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso969017oty.12;
        Tue, 06 Jul 2021 21:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L9KXBAdgUdwykMSnUuubLWVOFEmtbnfz6/mlcwzGsLY=;
        b=il07f4nS6JlA7KEIX9Jys5epGzx2NbrpnxrJImLWmbIxA+dZk0+cotlvZRBw1eQlxT
         5EaWD0MUT/+u4JDF37OrD4tWPQQKMrDTtPjplpREebDVEe6M0Lk8IEgETFsDj59PlGEq
         M3SveBp+dFN/nJbsJKL2qdJYEgPyAuXvJSHm8EHnIVBKDpEoLC6IjL+kyPVSB10M10ZG
         uXI3HrfYrEttdnrRgSll0HvHtWMjIYbxwLjSew60ud3DelMzT6xrRbxUCwXXPPh+UqLe
         CTeMZFv/QlvRznYhihQbDMjw/wsLMiscsi0I2/u53p0LFucqETQD0jEYupMBZDa9X34R
         0YNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L9KXBAdgUdwykMSnUuubLWVOFEmtbnfz6/mlcwzGsLY=;
        b=OXw8sh7WfMcx2YV8ETW9/lce1Lofb9muWcP6vCVWI0KOahaiSOJ9n+t4PQiTIQ+LZp
         aKbWUEhTeTa6Ve08hfBhlczuTFqdjOLZzYGHHG2kFVIKwTeUuXJpgyZ5F0XCRh7zdkMk
         u90ZawO/5MZXkJumtnCRvs21uDsiW1hjVvUfrhAtv5UEeD+85Vzwmkae9DjUoS5OY52K
         RhhU6rb1ofbeW9n78pZh+1/6pwzTyTLNr4b9ZKeeXxF1yGyRonfaLpdhy+qKiO/XC2a8
         zPjlZTd78Zv+a/RuemqDSKw1pRkoTWOCz6XkwgGY0YPJsHBIIy4FaC1qFbmgUFLYdAma
         cx4Q==
X-Gm-Message-State: AOAM530ltD1NqZKmLL3UKbyn5d5Hlkz9flqyDxQqbPbMwg3YmJrgiCBc
        V8SnZDAF6Jp1QfO/4joqrtm0e3qJiwg=
X-Google-Smtp-Source: ABdhPJxa04pXBzuyZvNsWeQzYBspUwVL/EpCAtFtpEcrc4Y8XGzeed5fIqvuBA2TXEvkKL9Um1WsOg==
X-Received: by 2002:a9d:63ca:: with SMTP id e10mr17776891otl.320.1625630805121;
        Tue, 06 Jul 2021 21:06:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l11sm3251068oou.0.2021.07.06.21.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 21:06:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [tip: sched/core] sched/core: Initialize the idle task with
 preemption disabled
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
References: <20210512094636.2958515-1-valentin.schneider@arm.com>
 <162081815405.29796.14574924529325899839.tip-bot2@tip-bot2>
 <20210706194456.GA1823793@roeck-us.net> <87fswr6lqv.mognet@arm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0d792e69-8ba3-5658-16ea-c1090bffa410@roeck-us.net>
Date:   Tue, 6 Jul 2021 21:06:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87fswr6lqv.mognet@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 7/6/21 4:55 PM, Valentin Schneider wrote:
> 
> Hi Guenter,
> 
> On 06/07/21 12:44, Guenter Roeck wrote:
>> This patch results in several messages similar to the following
>> when booting s390 images in qemu.
>>
>> [    1.690807] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
>> [    1.690925] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
>> [    1.691053] no locks held by swapper/0/1.
>> [    1.691310] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-11788-g79160a603bdb #1
>> [    1.691469] Hardware name: QEMU 2964 QEMU (KVM/Linux)
>> [    1.691612] Call Trace:
>> [    1.691718]  [<0000000000d98bb0>] show_stack+0x90/0xf8
>> [    1.692040]  [<0000000000da894c>] dump_stack_lvl+0x74/0xa8
>> [    1.692134]  [<0000000000187e52>] ___might_sleep+0x15a/0x170
>> [    1.692228]  [<000000000014f588>] cpus_read_lock+0x38/0xc0
>> [    1.692320]  [<0000000000182e8a>] smpboot_register_percpu_thread+0x2a/0x160
>> [    1.692412]  [<00000000014814b8>] cpuhp_threads_init+0x28/0x60
>> [    1.692505]  [<0000000001487a30>] smp_init+0x28/0x90
>> [    1.692597]  [<00000000014779a6>] kernel_init_freeable+0x1f6/0x270
>> [    1.692689]  [<0000000000db7466>] kernel_init+0x2e/0x160
>> [    1.692779]  [<0000000000103618>] __ret_from_fork+0x40/0x58
>> [    1.692870]  [<0000000000dc6e12>] ret_from_fork+0xa/0x30
>>
>> Reverting this patch fixes the problem.
>> Bisect log is attached.
>>
>> Guenter
>>
> 
> Thanks for the report.
> 
> So somehow the init task ends up with a non-zero preempt_count()? Per
> FORK_PREEMPT_COUNT we should exit __ret_from_fork() with a zero count, are
> you hitting the WARN_ONCE() in finish_task_switch()?
> 
> Does CONFIG_DEBUG_PREEMPT=y yield anything interesting?
> 

My configuration doesn't have CONFIG_PREEMPT enabled.

Guenter
