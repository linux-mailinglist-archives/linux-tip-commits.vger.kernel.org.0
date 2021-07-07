Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75F23BEC5B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Jul 2021 18:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhGGQik (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Jul 2021 12:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhGGQik (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Jul 2021 12:38:40 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F180EC061762;
        Wed,  7 Jul 2021 09:35:58 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id w127so4017367oig.12;
        Wed, 07 Jul 2021 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SdjtKulK52JZbDskOxsiTOMKU9j9/kBAI8zRtWAf2MY=;
        b=CA8hoCCs18wpIptwPbG1ZM86QyNMU0CxtiAtNqwc3ByzH2geqToOZFz4TdwAd1lddQ
         OZctWgjCLRD+fV7WF7tg7zILckUHKn0Iy+kzh2sYyc8lEufKRTDQxdvjIyM13/BQ8bO9
         dCCWS8q4SPWH6tZalY+wLqE+qEUaSiNuw0Pw7b9PeSgXXs+qROKoJ3vpGryNjf5j/yft
         CIjqiXApDJNq7UAJcWFqPQOokzWUFODcUYXjUN5zcYa40StcBT2+pxJ6m4M0+qqPuyQD
         gmb6WZ4RtRlMd++TqfA4AO+4YyAaEVRMd2GLT6W6vR0hGickXta1pIK8xS0Wnv+WgbfH
         SUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SdjtKulK52JZbDskOxsiTOMKU9j9/kBAI8zRtWAf2MY=;
        b=CrmlluYnDFpMfUkSMuaiXuMYt8vY1BRBgfFxwCW0HGaX8MK8bx95FaQWrlNpCAiSN0
         PJ+/XsmlK/wfoRo6ATP1OO/upO3lgQBmnDEbQvz+tRPhg8IBOJQbykwPFsPPzitao+w1
         9pnvYCtb71c6FavYnqJ6o+vYPNCkc4nr4iW5QqpgYYl+43pvKZI9lQLJhswX8EcqW3JV
         cg72t4TsfeUB85xuWiNeiSJPx3vRDmEgoa+Qbe37AHRgPTEx2j25oSvJFYwU5WARvNII
         LvyDSUMTqkwpwnauzkwtfKcIx1bCqY07y07xGX9MjYH9Av/1ZILyXt125HMdhqnFKMu/
         odiA==
X-Gm-Message-State: AOAM533lcOpxJAv7qVwB99CXSwO90lm+Y/0ay/UPsWUMKENpu6oFZsyk
        s5PoRxNk2AXiwbkAVhB69Ic=
X-Google-Smtp-Source: ABdhPJypEzkEn+0VEkE7tglsHJvM/4SXWPXbZNsgiYzseXIpBJ6uElV7CRqGo/1VwBMa40vpUXMkTA==
X-Received: by 2002:a54:4797:: with SMTP id o23mr8901907oic.158.1625675758396;
        Wed, 07 Jul 2021 09:35:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d7sm4019679otb.66.2021.07.07.09.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 09:35:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
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
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [tip: sched/core] sched/core: Initialize the idle task with
 preemption disabled
Message-ID: <c9bd8db3-60ae-1dbe-aa2f-f2fe3d5fe2d9@roeck-us.net>
Date:   Wed, 7 Jul 2021 09:35:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <878s2i6uk2.mognet@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 7/7/21 7:57 AM, Valentin Schneider wrote:
> On 08/07/21 00:35, Alexey Kardashevskiy wrote:
>> On 08/07/2021 00:14, Guenter Roeck wrote:
>>>
>>> Can you reproduce the problem with a powerpc qemu emulation ?
>>> If so, how do you reproduce it there ? Reason for asking is that I don't
>>> see
>>> the problem with any of my powerpc emulations, and I would like to add test
>>> case(s) if possible.
>>
>> I can reproduce the problem on powerpc easily - qemu with "-smp 2" does it.
>>
> 
> So on powerpc I'm chasing a slightly different problem, reported at
> [1]. I couldn't get it to trigger on qemu for powerpc64, and I'm still
> struggling with powerpc. Could you please share you qemu invocation &
> kernel .config? Thanks.
> 

I think I have it. pseries_defconfig, and pseries emulation,
started with "-smp 2" and qemu-system-ppc64:

[    0.731644][    T1] smp: Bringing up secondary CPUs ...^M
[    0.750546][    T0] BUG: scheduling while atomic: swapper/1/0/0x00000000^M
[    0.752119][    T0] no locks held by swapper/1/0.^M
[    0.752309][    T0] Modules linked in:^M
[    0.752684][    T0] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.13.0-11855-g77d34a4683b0 #1^M
[    0.753197][    T0] Call Trace:^M
[    0.753334][    T0] [c000000008737b20] [c0000000009f9b18] .dump_stack_lvl+0xa4/0x100 (unreliable)^M
[    0.754224][    T0] [c000000008737bb0] [c000000000190ed0] .__schedule_bug+0xa0/0xe0^M
[    0.754459][    T0] [c000000008737c30] [c000000001182518] .__schedule+0xc08/0xd90^M
[    0.754738][    T0] [c000000008737d20] [c000000001182b8c] .schedule_idle+0x2c/0x60^M
[    0.754945][    T0] [c000000008737d90] [c0000000001a48ec] .do_idle+0x29c/0x3c0^M
[    0.755145][    T0] [c000000008737e60] [c0000000001a4df0] .cpu_startup_entry+0x30/0x40^M
[    0.755403][    T0] [c000000008737ee0] [c00000000005ef10] .start_secondary+0x2c0/0x300^M
[    0.755621][    T0] [c000000008737f90] [c00000000000d254] start_secondary_prolog+0x10/0x14^M
[    0.764164][    T1] smp: Brought up 1 node, 2 CPUs^M

Guenter
