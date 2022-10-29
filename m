Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36146122FD
	for <lists+linux-tip-commits@lfdr.de>; Sat, 29 Oct 2022 14:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJ2MmT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 29 Oct 2022 08:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiJ2MmS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 29 Oct 2022 08:42:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733D25A2C2
        for <linux-tip-commits@vger.kernel.org>; Sat, 29 Oct 2022 05:42:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so2326782pjk.1
        for <linux-tip-commits@vger.kernel.org>; Sat, 29 Oct 2022 05:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ce250joL3iqDn2xbwYnkLhofwJ7IAaSStzyPW5mbUM=;
        b=FP58HsbJhZJQ3Dvhh3Y3k9SwtypgSUMezdeYmDn9yQ1FH2AUB+b1/lD5oJDZScUtIH
         tIpZQ6Sa6DpGIgpvJvURJVa4v/xfdKvmzwbsNKhUSSI6RvYwwO26d+GD7ZgiSTlVAYlR
         YO/mhHjQzahnauhRDFutBnEIEwsRLiBwyOdBEFAtUhgbI+dFM1IcfMJmyCTf09w3X6WA
         UIVMEn4Va9RGN6AyhT2PIhRSb51AWNb7D9UD0D+JOIs0VP+iW4tjOIBJxwNXqE1E1xIA
         ESY06oJnhqs1zmJMN2/BacaUCrXmuep0pgQF3q9nP0Vjey5n8MrhIsyjqmn5/FLZ1oZc
         xUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ce250joL3iqDn2xbwYnkLhofwJ7IAaSStzyPW5mbUM=;
        b=bhImCnlroKgFbK4l4LQyKx179a114MnRW+MFG6aPbXy1J/MJQbAYOlFWWW+jp7szkW
         OykZE/32AwVh0R+4M9hmI1cHO0JBkDswsOKP1IyCGNRbRK5cdz95ONZPAZ0m1ljapBwa
         tXq1Ln1pyR/88wse6thoJ3KdMXFeW3YS+W/4H++MpvMmPqQ9C+pJOWIugerks79O6WJC
         R1XPqILO5Na+4pLMHsoCixls36QtB8VFU1zt22es8ppk7ej6q1FhS1WAyhbpMO6Jkl6m
         /tze4FAzG5FHAfSJTJ/18H/u67hOL0ErB23cBvr663laM1gvP6dFtuMoEJIQZ796+YgV
         xP0g==
X-Gm-Message-State: ACrzQf0Gs1OrG51/V1ha6Bq3vRtERKKhHSeR5bIamGhsQkpoL/7CQgQ6
        gGLbee33ogH3uCEVbo/hJSoP8t17SCHCUQ==
X-Google-Smtp-Source: AMsMyM553KStNWLnmeOyGVfUgwhZ+WLhrO04SI5G9pzlGFYkdz02fQ1DOjWotg8joGpr2pAAoGsDCw==
X-Received: by 2002:a17:90b:3b8d:b0:20d:5829:8d97 with SMTP id pc13-20020a17090b3b8d00b0020d58298d97mr21229797pjb.105.1667047333974;
        Sat, 29 Oct 2022 05:42:13 -0700 (PDT)
Received: from [10.4.223.2] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id z28-20020a62d11c000000b0056c06d583fasm1125660pfg.219.2022.10.29.05.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 05:42:13 -0700 (PDT)
Message-ID: <6ea3a2ca-85d7-b338-f516-c91ec5e7a128@bytedance.com>
Date:   Sat, 29 Oct 2022 20:40:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [tip: sched/core] sched/psi: Fix avgs_work re-arm in
 psi_avgs_work()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-tip-commits@vger.kernel.org,
        Pavan Kondeti <quic_pkondeti@quicinc.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
References: <20221010104206.12184-1-zhouchengming@bytedance.com>
 <166693932887.29415.17016910542871419770.tip-bot2@tip-bot2>
 <f990a324-e28e-6de1-acb0-ba764808a56a@bytedance.com>
 <CAJuCfpHOt1Vfc=ZtAYt_2QamOujfuFtNHAdJe7iBMmDgTLGtyw@mail.gmail.com>
 <Y1wzVeCYDFSO0KYe@hirez.programming.kicks-ass.net>
 <Y10UpNIGtffsZHXr@hirez.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Y10UpNIGtffsZHXr@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 2022/10/29 19:55, Peter Zijlstra wrote:
> On Fri, Oct 28, 2022 at 09:53:57PM +0200, Peter Zijlstra wrote:
>> On Fri, Oct 28, 2022 at 08:58:03AM -0700, Suren Baghdasaryan wrote:
>>
>>> Not sure what went wrong. Peter, could you please replace this one
>>
>> Probably me being an idiot and searching on subject instead of msgid :/
>>
>> I'll go fix up -- tomorrow though, it's late and I'm likely to mess it
>> up again.
> 
> Can you please check queue.git/sched/core ; did I get it right this
> time?

I just checked that three patches, LGTM.

And would you mind picking up this, by the way?

https://lore.kernel.org/all/20220926081931.45420-1-zhouchengming@bytedance.com/

Thanks!
