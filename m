Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6371B33F499
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhCQPv4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232154AbhCQPv0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615996285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMetl3K6jfP3qBdZDOkg2+NljNufqpTHhSClueI0Ibg=;
        b=HpKoGjI4GwPsF03yXb1cFlNl/L0qF6MFQww70sDQcTB5d5DD31JuBzoMXa0+Dhy62tPzzu
        wAkeo1Br3B3u5DUijuijst/28rsCTJ0G+w11zY72rEsKGViXLDmyg0xH0/5slYpG5LbsLu
        IkR+fR4anwVaBsFLyLayfy7/HunOBTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-LE-xaNRqMveP7suBQMSXLA-1; Wed, 17 Mar 2021 11:35:15 -0400
X-MC-Unique: LE-xaNRqMveP7suBQMSXLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 093CF100747B;
        Wed, 17 Mar 2021 15:35:14 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-171.rdu2.redhat.com [10.10.117.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6793E60CCE;
        Wed, 17 Mar 2021 15:35:13 +0000 (UTC)
Subject: Re: [tip: locking/urgent] locking/ww_mutex: Treat ww_mutex_lock()
 like a trylock
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
References: <20210316153119.13802-4-longman@redhat.com>
 <161598470197.398.8903908266426306140.tip-bot2@tip-bot2>
 <YFIASRkXowQWgj2s@hirez.programming.kicks-ass.net>
 <YFIEo8IVQ/Mm9jUE@hirez.programming.kicks-ass.net>
 <e1bcd7fb-3a40-f207-ee19-d276c8b8bb75@redhat.com>
Organization: Red Hat
Message-ID: <e39f4e37-e3c0-e62a-7062-fdd2c8b3d3b9@redhat.com>
Date:   Wed, 17 Mar 2021 11:35:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <e1bcd7fb-3a40-f207-ee19-d276c8b8bb75@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 3/17/21 10:03 AM, Waiman Long wrote:
> On 3/17/21 9:31 AM, Peter Zijlstra wrote:
>> On Wed, Mar 17, 2021 at 02:12:41PM +0100, Peter Zijlstra wrote:
>>> On Wed, Mar 17, 2021 at 12:38:21PM -0000, tip-bot2 for Waiman Long 
>>> wrote:
>>>> +    /*
>>>> +     * Treat as trylock for ww_mutex.
>>>> +     */
>>>> +    mutex_acquire_nest(&lock->dep_map, subclass, !!ww_ctx, 
>>>> nest_lock, ip);
>>> I'm confused... why isn't nest_lock working here?
>>>
>>> For ww_mutex, we're supposed to have ctx->dep_map as a nest_lock, and
>>> all lock acquisitions under a nest lock should be fine. Afaict the 
>>> above
>>> is just plain wrong.
>> To clarify:
>>
>>     mutex_lock(&A);            ww_mutex_lock(&B, ctx);
>>     ww_mutex_lock(&B, ctx);        mutex_lock(&A);
>>
>> should still very much be a deadlock, but your 'fix' makes it not report
>> that.
>>
>> Only order within the ww_ctx can be ignored, and that's exactly what
>> nest_lock should be doing.
>>
> I will take a deeper look into why that is the case. 

 From reading the source code, nest_lock check is done in 
check_deadlock() so that it won't complain. However, nest_lock isn't 
considered in check_noncircular() which causes the splat to come out. 
Maybe we should add a check for nest_lock there. I will fiddle with the 
code to see if it can address the issue.

Cheers,
Longman


