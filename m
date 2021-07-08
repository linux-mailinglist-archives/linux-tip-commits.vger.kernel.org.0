Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A363BF3AA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Jul 2021 03:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhGHBxT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Jul 2021 21:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhGHBxS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Jul 2021 21:53:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC721C06175F
        for <linux-tip-commits@vger.kernel.org>; Wed,  7 Jul 2021 18:50:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y17so4260290pgf.12
        for <linux-tip-commits@vger.kernel.org>; Wed, 07 Jul 2021 18:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=q3zMtawysIJzQo3VuvzN8yTT5X9XIbc6q+Nlmu+/bcQ=;
        b=HO8Sjk9BfZM7V2Rcgnkj5Tyoc7RqOc7B0yGMOUFWDYHKCFsS7Rt7Ism6BDjagpjVVT
         XvcXTDIYq8hurMp+o05S84Y9rY8ICHwmbh7jEON9Glmoly/9w79xHhEn6dfBcU25p6nH
         WFG5Vg9IP9Gr3VwsCgEt/atkQaA0L33vDjmmGvdve89KL04I1YKkb7RB8P6Ot7G0bNTC
         J8VM2qG7sBIh0x1VqRbBfF6rf2t4XTpsmnC8WCuEHtfOPOK6jFtYRpeGE+0QL+3YgMeU
         RmQCR8Q6GS8ZahXyaFxgbTWpwrw5bB2EWMfwEiXLaltOXTZM8WpK/oxKRlLovOjm4jWg
         TDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q3zMtawysIJzQo3VuvzN8yTT5X9XIbc6q+Nlmu+/bcQ=;
        b=iVIwFB6TExXeN9n2T/dev3N/ygj89VGYB6NpgpZRrntag114DghSpRahzrOIO1+Hig
         yr1UBT4fe+an7eCUYLswLAaSPUORcYyKWxVpTtN+rLG0mnx+gvY16h0poFBhpNQufycH
         DK0wyHQoRs5hFmebPLJDILJ/EQCdfOgya2eZb1b00CY01b42FlFniO14JQDTnHdkJVe5
         dY8vjpwT5eRKRyFVz19racGYknLO6kmt1sLq+5C/VkgwOJKpG7vZafRxJRMZ8LVuoAwX
         NkAD+SneMo/HSy8RuVJOdiJZLdBA8SY846oWo3n+gtDJptPdW1jgaaH1jNvVlAevRFVb
         eftA==
X-Gm-Message-State: AOAM532+X2UHHcHj1MIOw7z5MnCEbWa8BM5lie+RtxQFNIdHK/FvfYM2
        4ijaDhtBKDHxlP9JeUnQaum6hQ==
X-Google-Smtp-Source: ABdhPJwKtpgmioukwHPVwFtR/9XWsY+luViLvGsBrwI0JmAZLZVUUXJezKXYEsNQXo6WLRFnB4b7KA==
X-Received: by 2002:a05:6a00:8c4:b029:2b4:8334:ed4d with SMTP id s4-20020a056a0008c4b02902b48334ed4dmr28225085pfu.36.1625709036308;
        Wed, 07 Jul 2021 18:50:36 -0700 (PDT)
Received: from [192.168.10.23] (219-90-184-65.ip.adam.com.au. [219.90.184.65])
        by smtp.gmail.com with UTF8SMTPSA id m21sm520100pfa.99.2021.07.07.18.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 18:50:35 -0700 (PDT)
Message-ID: <645405bb-50ae-f18e-eeba-b42770cc4b8e@ozlabs.ru>
Date:   Thu, 8 Jul 2021 11:50:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:89.0) Gecko/20100101
 Thunderbird/89.0
Subject: Re: [tip: sched/core] sched/core: Initialize the idle task with
 preemption disabled
Content-Language: en-US
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
References: <20210512094636.2958515-1-valentin.schneider@arm.com>
 <162081815405.29796.14574924529325899839.tip-bot2@tip-bot2>
 <20210706194456.GA1823793@roeck-us.net> <87fswr6lqv.mognet@arm.com>
 <20210707120305.GB115752@lothringen> <87czru727k.mognet@arm.com>
 <c30097f3-63b4-6fa0-a369-8f4e20ee1040@roeck-us.net>
 <de7b1d0f-8767-1b33-2950-576029c0d9f7@ozlabs.ru> <878s2i6uk2.mognet@arm.com>
 <c9bd8db3-60ae-1dbe-aa2f-f2fe3d5fe2d9@roeck-us.net>
 <875yxm6nec.mognet@arm.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <875yxm6nec.mognet@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org



On 08/07/2021 03:31, Valentin Schneider wrote:
> On 07/07/21 09:35, Guenter Roeck wrote:
>> I think I have it. pseries_defconfig, and pseries emulation,
>> started with "-smp 2" and qemu-system-ppc64:
>>
>> [    0.731644][    T1] smp: Bringing up secondary CPUs ...^M
>> [    0.750546][    T0] BUG: scheduling while atomic: swapper/1/0/0x00000000^M
>> [    0.752119][    T0] no locks held by swapper/1/0.^M
>> [    0.752309][    T0] Modules linked in:^M
>> [    0.752684][    T0] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.13.0-11855-g77d34a4683b0 #1^M
>> [    0.753197][    T0] Call Trace:^M
>> [    0.753334][    T0] [c000000008737b20] [c0000000009f9b18] .dump_stack_lvl+0xa4/0x100 (unreliable)^M
>> [    0.754224][    T0] [c000000008737bb0] [c000000000190ed0] .__schedule_bug+0xa0/0xe0^M
>> [    0.754459][    T0] [c000000008737c30] [c000000001182518] .__schedule+0xc08/0xd90^M
>> [    0.754738][    T0] [c000000008737d20] [c000000001182b8c] .schedule_idle+0x2c/0x60^M
>> [    0.754945][    T0] [c000000008737d90] [c0000000001a48ec] .do_idle+0x29c/0x3c0^M
>> [    0.755145][    T0] [c000000008737e60] [c0000000001a4df0] .cpu_startup_entry+0x30/0x40^M
>> [    0.755403][    T0] [c000000008737ee0] [c00000000005ef10] .start_secondary+0x2c0/0x300^M
>> [    0.755621][    T0] [c000000008737f90] [c00000000000d254] start_secondary_prolog+0x10/0x14^M
>> [    0.764164][    T1] smp: Brought up 1 node, 2 CPUs^M
>>
>> Guenter
> 
> Hmph, I was about to say I couldn't get that, but after cycling between
> different PREEMPT options I finally triggered it, so thanks for that!
> 
> Same sha1 as yours, invocation is:
> 
>    qemu-system-ppc64 vmlinux -smp 2 -nographic -m 1024 -machine pseries,usb=off
> 
> with pseries_defconfig + CONFIG_DEBUG_ATOMIC_SLEEP + CONFIG_PREEMPT_VOLUNTARY
> 
> Now to dig!

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

CONFIG_DEBUG_ATOMIC_SLEEP=y

is what I have, and qemu cmdline is

qemu-system-ppc64 \
-nodefaults \
-chardev stdio,id=STDIO0,signal=off,mux=on \
-device spapr-vty,id=svty0,reg=0x71000110,chardev=STDIO0 \
-mon id=MON0,chardev=STDIO0,mode=readline \
-nographic \
-vga none \
-enable-kvm \
-m 512M \
-smp 2 \
-kernel ./vmldbg \
-machine pseries


(unrelated) I wonder how/why PREEMPT_NOTIFIERS work when PREEMPT_NONE=y 
:-/ I have a crash in a KVM preempt notifier with such config.



-- 
Alexey
