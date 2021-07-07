Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140133BE987
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Jul 2021 16:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhGGORh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Jul 2021 10:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhGGORg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Jul 2021 10:17:36 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DF8C061574;
        Wed,  7 Jul 2021 07:14:54 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so2359296oti.2;
        Wed, 07 Jul 2021 07:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VYHMBVTtZYFBd/135j2lN/KDcFhv4G/4LIniAenzAK4=;
        b=Q4AfkH51ZhrG1cQIo/cRVPTlOKmEtQuI+N9g21IyleEslFmnLBU003OxU+PxBhpJER
         eF7NGn5JG2nGEeVSpVYnsek6sIygk9FY6Kg+4PC951Ab8XBTw+R36z4kNlwNDp1MNCt1
         ZHH47w2nEKLVkktCgIBsmGxZktdeFhl41PRjBadTf2ckb/DX7T2TBgKh7WEJ/oonqw44
         1Uk0UPv9wSc2Eg0nf6Xyp/K/c7N1Sfq2vbna2jYcNzoQYL6M52dEPcUF7NIz+1Eo/D2D
         uCrzIMToxjaiJEDObup7F3ZP060shAZ0t3xMEze6H++DAwOkVVET2cTT7Cnp8B2vg4Ib
         qgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VYHMBVTtZYFBd/135j2lN/KDcFhv4G/4LIniAenzAK4=;
        b=M2POPUYA8hp+DPuvrj7gNUixEb0votkIiAXEd/KpXxf63lPnW5rqC/MjAVaPhTHOvp
         u4J7MYfCICKO90vwnjlK7mdNaDiXjS5JWDSjdFHWgjXqSMAkBnTG6pNKcWCjEr8yaNXd
         Ji/lUWXSUhiPS+xOPfw7mGSJi2zVxrEylKzxCMVWWP5/UAOn27ZAALN2B3VnxBr4KDKB
         nPo8qm+hUZtIfkcK4i2CsgP0ntNSoXGmuhjMDcsFMzxSk/yeJ+PGJtKTqtJhm9MHFoqv
         v+nByyi5DXI721x4ntEbS/+h1qZGEY4wqVLHaYXcbLFLL7SDhF5HIaCnBCYVbl7qhPIk
         Scag==
X-Gm-Message-State: AOAM531bEppVskNMKZMHZRkpfTZnDLHEKDVpX/gGS/ykPmPyyPwyOOmA
        CvfqkBVH5/O1ff4r+NerdLY=
X-Google-Smtp-Source: ABdhPJwALQ5t6M/bvhaaGP9ThhVgUYTCYrXCYj+u53vggFNRliXGNh2rQDBI3wogrSTMMryuwSRLBg==
X-Received: by 2002:a9d:7ad7:: with SMTP id m23mr20455538otn.138.1625667293468;
        Wed, 07 Jul 2021 07:14:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j11sm85286otr.6.2021.07.07.07.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 07:14:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [tip: sched/core] sched/core: Initialize the idle task with
 preemption disabled
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
References: <20210512094636.2958515-1-valentin.schneider@arm.com>
 <162081815405.29796.14574924529325899839.tip-bot2@tip-bot2>
 <20210706194456.GA1823793@roeck-us.net> <87fswr6lqv.mognet@arm.com>
 <20210707120305.GB115752@lothringen> <87czru727k.mognet@arm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c30097f3-63b4-6fa0-a369-8f4e20ee1040@roeck-us.net>
Date:   Wed, 7 Jul 2021 07:14:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87czru727k.mognet@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 7/7/21 5:11 AM, Valentin Schneider wrote:
> On 07/07/21 14:03, Frederic Weisbecker wrote:
>> On Wed, Jul 07, 2021 at 12:55:20AM +0100, Valentin Schneider wrote:
>>> Thanks for the report.
>>>
>>> So somehow the init task ends up with a non-zero preempt_count()? Per
>>> FORK_PREEMPT_COUNT we should exit __ret_from_fork() with a zero count, are
>>> you hitting the WARN_ONCE() in finish_task_switch()?
>>>
>>> Does CONFIG_DEBUG_PREEMPT=y yield anything interesting?
>>>
>>> I can't make sense of this right now, but it's a bit late :) I'll grab some
>>> toolchain+qemu tomorrow and go poke at it (and while at it I need to do the
>>> same with powerpc).
>>
>> One possible issue is that s390's init_idle_preempt_count() doesn't apply on the
>> target idle task but on the _current_ CPU. And since smp_init() ->
>> idle_threads_init() is actually called remotely, we are overwriting the current
>> CPU preempt_count() instead of the target one.
> 
> Indeed, this becomes quite obvious when tracing the preemption count
> changes. This also means that s390 relied on the idle_thread_get() from the
> hotplug machinery to properly setup the preempt count, rather than
> init_idle_preempt_count() - which is quite yuck.
> 
> I'll write a patch for that and likely one for powerpc.
> 

Can you reproduce the problem with a powerpc qemu emulation ?
If so, how do you reproduce it there ? Reason for asking is that I don't see
the problem with any of my powerpc emulations, and I would like to add test
case(s) if possible.

Thanks,
Guenter
